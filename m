Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119A5B6740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 07:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIMFUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 01:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIMFUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:20:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F471F2EB
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YqUw7kHRxtqzD+DOqVol8QoF8ucrYovTiSImpbe3qm8=; b=ucLgSeYtinwCyou0CJYlQC/srY
        omVo80xDbX3jXHZTyWZ+8ngvVY1umYUFHJHPdWSWHaY9slOtXGcvmVQKxDV0hrkhqTfyYTe4EMxl1
        WyrBN/YcRlC6ihQItpiwJr7QHlG1w8i2mkFQBaWbF4aswyabmw5nFjgiMPokcyRmsmTP31wLBNfso
        Zgz4jg43D9gIPwPHiEI8kh5h20kiacebFQPL7LidffDAACKTxpv++rrAsDf1Nw0JvUchoajTgvRcR
        RP90NacCq5hdKl0EVGBBpEfYAydvwzYBW81NY86CqfuiC6dow/inJgtIar8FJAwZQYlNytnDM21XM
        t1c7+ycw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXyLC-00FkIg-0n;
        Tue, 13 Sep 2022 05:20:10 +0000
Date:   Tue, 13 Sep 2022 06:20:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <YyATCgxi9Ovi8mYv@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166304411168.30452.12018495245762529070@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:41:51PM +1000, NeilBrown wrote:
> On Mon, 21 Feb 2022, Miklos Szeredi wrote:
> > There has been a longstanding race condition between rename(2) and link(2),
> > when those operations are done in parallel:
> > 
> > 1. Moving a file to an existing target file (eg. mv file target)
> > 2. Creating a link from the target file to a third file (eg. ln target
> >    link)
> > 
> > By the time vfs_link() locks the target inode, it might already be unlinked
> > by rename.  This results in vfs_link() returning -ENOENT in order to
> > prevent linking to already unlinked files.  This check was introduced in
> > v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
> > deleted file").
> > 
> > This breaks apparent atomicity of rename(2), which is described in
> > standards and the man page:
> > 
> >     "If newpath already exists, it will be atomically replaced, so that
> >      there is no point at which another process attempting to access
> >      newpath will find it missing."
> > 
> > The simplest fix is to exclude renames for the complete link operation.
> 
> Alternately, lock the "from" directory as well as the "to" directory.
> That would mean using lock_rename() and generally copying the structure
> of do_renameat2() into do_linkat()

Ever done cp -al?  Cross-directory renames are relatively rare; cross-directory
links can be fairly heavy on some payloads, and you'll get ->s_vfs_rename_mutex
held a _lot_.

> I wonder if you could get a similar race trying to create a file in
> (empty directory) /tmp/foo while /tmp/bar was being renamed over it.

	Neil, no offense, but... if you have plans regarding changes in
directory locking, you might consider reading through the file called
Documentation/filesystems/directory-locking.rst

	Occasionally documentation is where one could expect to find it...
