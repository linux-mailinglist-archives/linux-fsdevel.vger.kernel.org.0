Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00E71EEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjFAQVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFAQVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F312C;
        Thu,  1 Jun 2023 09:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EC16475A;
        Thu,  1 Jun 2023 16:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45044C433EF;
        Thu,  1 Jun 2023 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636466;
        bh=J9x2GSgcCuBZSk1uZOf/tNoS5CtNSbRyWQ2pfrQq7M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZCqqQC0a9i9hGh1DZzervY8TO67e/jssn6MiOym0PkWTyCcyWpfLV+nzn/KctYrE
         JmIfAZQkiWDITUxLX3S0cHZd21Ufpix0t56Pt2OHQRvZHXQkCcBLhl9D/y85/SxXNk
         yI8GCS0Sym3IJxaE5pBG64Azm8xrd5iMdGu8WvDS40fu8DPjGmWji6boJV4tmXMv8U
         phMlnOqSSvBA0I4rm6Su2mcfaT4sLPUKsyLrNmGplbNqgEQ/xOVeEGTUSTxcj99tja
         YNqJQEBVbEb5Wm7RmYNxO9Bpk3zIXOfDGWvc1N7nneMMdNOWCT1ER/auVu2jvRbMkH
         3pdzyWUkOfaVg==
Date:   Thu, 1 Jun 2023 18:21:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230601-flora-hemmung-31a1e66b5179@brauner>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
 <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
 <20230601161353.4o6but7hb7i7qfki@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601161353.4o6but7hb7i7qfki@quack3>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:13:53PM +0200, Jan Kara wrote:
> On Thu 01-06-23 15:37:32, David Laight wrote:
> > ...
> > > > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > > > + * in two directories, one is not ancestor of the other
> > 
> > Not directly relevant to this change but is the 'not an ancestor'
> > check actually robust?
> > 
> > I found a condition in which the kernel 'pwd' code (which follows
> > the inode chain) failed to stop at the base of a chroot.
> > 
> > I suspect that the ancestor check would fail the same way.
> 
> Honestly, I'm not sure how this could be the case but I'm not a dcache
> expert. d_ancestor() works on dentries and the whole dcache code pretty
> much relies on the fact that there always is at most one dentry for any
> directory. Also in case we call d_ancestor() from this code, we have the
> whole filesystem locked from any other directory moves so the ancestor
> relationship of two dirs cannot change (which is different from pwd code
> AFAIK). So IMHO no failure is possible in our case.

Yes, this is a red herring. What matters is that the tree topology can't
change which is up to the caller to guarantee. And where it's called
we're under s_vfs_rename_mutex. It's also literally mentioned in the
directory locking documentation.
