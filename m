Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363F5ABB86
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 02:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiICAGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICAGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:06:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A134DF660;
        Fri,  2 Sep 2022 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KdeTuqcqB+4Nrt8OAhVoYy5O7SMidBuWR9jEOoug8WU=; b=cgNDBcJTeZ5wmsY7k04DFpxV0U
        ZeH6ksnjmTDz0Y9BZ6jj5+75ez+lHZbiJ3axVd5oIqBkI5ud3s4a3f7VdK2/iEm50vENAcEzNWSy0
        hUSvj2huKpM4j9k/3pGyAlNgYiCTzMMN+gh1H9GfW2qVSZxL8i3HWUnOCP818BbV5IcBata7qCMo0
        TV18JArbO7QgUWEwe7+U9x0VJ8q6Gp2NUdTMs4kITnbiyH4MEKaDKu0ovhl7JivBg1lTTSVNjkFj3
        NxD8NUPou2Z4g89i3Ie/2BjOb9sf3l2inYzCU3BTpuoBT+tciy91pd8FxB5+kenWiBW2Z3XmdH81f
        esTdl4XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oUGfg-00BUUx-SB;
        Sat, 03 Sep 2022 00:06:01 +0000
Date:   Sat, 3 Sep 2022 01:06:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YxKaaN9cHD5yzlTr@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <YwmS63X3Sm4bhlcT@ZenIV>
 <166173834258.27490.151597372187103012@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166173834258.27490.151597372187103012@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:59:02AM +1000, NeilBrown wrote:

> > When would we get out of __lookup_hash() with in-lookup dentry?
> > Confused...
> 
> Whenever wq is passed in and ->lookup() decides, based on the flags, to do
> nothing.
> NFS does this for LOOKUP_CREATE|LOOKUP_EXCL and for LOOKUP_RENAME_TARGET

Frankly, I would rather do what all other callers of ->lookup() do and
just follow it with d_lookup_done(dentry), no matter what it returns.
It's cheap enough...
