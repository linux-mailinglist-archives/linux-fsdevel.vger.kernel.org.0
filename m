Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD38B75BCAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGUDMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 23:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGUDMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304972691;
        Thu, 20 Jul 2023 20:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB7261CB8;
        Fri, 21 Jul 2023 03:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB997C433C9;
        Fri, 21 Jul 2023 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689909152;
        bh=P5PD4WZdZoh4pNtL4TIN7fX5fHYnGq0RuYxMKGgCGno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcQnlg/RpT+yJL8B+6Vo2Kzu3FNEcBcT+fvC2InxQjcmOp3MmcAQER/qSX4LrFwsh
         b+b//akbq3N+YiK4oeizbbruyqPk4zQfphMsarDQk7BK+jgE6Yhn0uuTEETn6yRLQv
         mAq5r6NP0DGVy0q5EXiqTCBT9Xml1uKDiBW56GgKNZjBOld2tzFRDJY3khxpoN5uef
         JazRSzDOTLAqko4CIxmw+N04KXPyvwukfjAHmL2zYTBR4sDvsPVwWKuhhko1UnU1nb
         QeuTN9sw8DkD2JU0osKGLDPKeM1adSD52pKcuvv3MBkltj+O1kKMZfx6qHG7MOPAV3
         IPOKZ5dA+uSlQ==
Date:   Thu, 20 Jul 2023 20:12:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230721031230.GA847@sol.localdomain>
References: <20230719221918.8937-1-krisman@suse.de>
 <20230720074318.GA56170@sol.localdomain>
 <87y1ja4hau.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1ja4hau.fsf@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:35:37PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> >> Another problem exists when turning a negative dentry to positive.  If
> >> the negative dentry has a different case than what is currently being
> >> used for lookup, the dentry cannot be reused without changing its name,
> >> in order to guarantee filename-preserving semantics to userspace.  We
> >> need to either change the name or invalidate the dentry. This issue is
> >> currently avoided in mainline, since the negative dentry mechanism is
> >> disabled.
> >
> > Are you sure this problem even needs to be solved?
> 
> Yes, because we promise name-preserving semantics.  If we don't do it,
> the name on the disk might be different than what was asked for, and tools
> that rely on it (they exist) will break.  During initial testing, I've
> had tools breaking with case-insensitive ext4 because they created a
> file, did getdents and wanted to see exactly the name they used.
> 
> > It actually isn't specific to negative dentries.  If you have a file "foo"
> > that's not in the dcache, and you open it (or look it up in any other way) as
> > "FOO", then the positive dentry that gets created is named "FOO".
> >
> > As a result, the name that shows up in /proc/$pid/fd/ for anyone who has the
> > file open is "FOO", not the true name "foo".  This is true even for processes
> > that open it as "foo", as long as the dentry remains in the dcache.
> >
> > No negative dentries involved at all!
> 
> I totally agree it is goes beyond negative dentries, but this case is
> particularly important because it is the only one (that I know of) where
> the incorrect case might actually be written to the disk.  other cases,
> like /proc/<pid>/fd/ can just display a different case to userspace,
> which is confusing.  Still, the disk has the right version, exactly as
> originally created.
> 
> I see the current /proc/$pid/fd/ semantics as a bug. In fact, I have/had
> a bug report for bwrap/flatkpak breaking because it was mounting
> something and immediately checking /proc/mounts to confirm it worked.  A
> former team member tried fixing it a while ago, but we didn't follow up,
> and I don't really love the way they did it.  I need to look into that.
> 
> > Or, it looks like the positive dentry case is solvable using d_add_ci().
> > So maybe you are planning to do that?  It's not clear to me.
> 
> I want to use d_add_ci for the future, yes. It is not hard, but not
> trivial, because there is an infinite recursion if d_add_ci uses
> ->d_compare() when doing the lookup for a duplicate.  We sent a patch to
> fix d_add_ci a while ago, but it was rejected.  I need to revisit.
> 

Thanks, I missed that choosing a different-case dentry actually changes the name
given to the new file.  This is because the filesystem is told about the name of
the file to create via the negative dentry that gets found/created -- not via
the original user-specified string.  It would help if you made this clear in a
code comment.  Taking the comment I suggested, I'd maybe revise it to:

			/*
			 * If the lookup is for creation, then a negative dentry
			 * can only be reused if it's a case-sensitive match,
                         * not just a case-insensitive one.  This is needed to
                         * make the new file be created with the name the user
                         * specified, preserving case.
			 *

- Eric
