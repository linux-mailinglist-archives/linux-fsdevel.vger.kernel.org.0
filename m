Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69587705A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEPWJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEPWJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 18:09:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B85426A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 15:09:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4c5e1388so2000105ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684274978; x=1686866978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsjtlt+tmKh7JPFwk0D4DTI1gHb3Nr3Nm7erGiy/3VY=;
        b=QQkN9qlvw5XUU3Z7lXPY6TfcJa12k3O8pI3vuQ1PvDMMq6EYgY2q5pUWvoSLIsDrKS
         2VqMSwhwRmr7XITa7vVNbt0EiIbWwcvCYMFkCeAoEM0GhiAEeRvgk85wzsaXwDx3NFfl
         2sWAIm2MTz9nhbcADs/qhichpxH4Sto4dQeW5KKCmwzZK/943wYWCwJwGuMfzQrcnkh7
         L3D7vKzmHTNPnWc3lAUs2aPb1m5GOvj8K/5airLBacSItHqmPTzzHc/Ogwl9m1usP/Da
         0drZxVnMZ6n/Q8jqVeSocXqXO3ogc/PpZElfBgQ+63BcJXxqrIRhzoKrN/Q685uovSUP
         mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274978; x=1686866978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsjtlt+tmKh7JPFwk0D4DTI1gHb3Nr3Nm7erGiy/3VY=;
        b=D4hKx2OePAlrZsrRjj4FCYeBVQ22IMxEuz+xl9yseZ5J8umRYf0BZCQGl8arUBUVwV
         5KbggnyI8xuNnRdxog55aaUyRnjq8a7CT6hLNz7cLw7ijPuM7aZ5M/u2onhRVRbCoLAL
         D+wxJlHikMwLOyoL+etejm17Bf2XA/ML8YAOup1z0m/gO5U937hUNYyG0J9Woxxh8b48
         NjqCJbkDngM8QH9NszoQQvoGCuhLHYevqRgZbbJapB4qnXEh2DdiWRye6bGQm7x41ZZV
         PzFEn6kq4ENFDN16/wMHpcMguUmwcEWMpP8BIU4G63dBgGfhUovc5GCenQeMaP0prvwi
         ezKg==
X-Gm-Message-State: AC+VfDwW4p4sJcWB3cS3FtzUY40QoJhpZAons6TcWSXKpvM69BeefTRT
        lwb6REYerBnYwQA9CkovJC/Cn0rSvlGdsgFAtYY=
X-Google-Smtp-Source: ACHHUZ6QobyS1uRdWqesr4Y+L/Q3mYDZdA+v1ZMRPT7Lb9Cw8XktRdpxC4hRSazCpVDB2gV439S8Sw==
X-Received: by 2002:a17:902:f54c:b0:19c:dbce:dce8 with SMTP id h12-20020a170902f54c00b0019cdbcedce8mr52725819plf.15.1684274978068;
        Tue, 16 May 2023 15:09:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001adfe981c77sm7305856plg.285.2023.05.16.15.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:09:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pz2rP-000Ja0-04;
        Wed, 17 May 2023 08:09:35 +1000
Date:   Wed, 17 May 2023 08:09:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: DIO hangs in 6.4.0-rc2
Message-ID: <ZGP/H1UQgMYemYP1@dread.disaster.area>
References: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 01:28:00PM +0100, Matthew Wilcox wrote:
> Plain 6.4.0-rc2 with a relatively minor change to the futex code that
> I cannot believe was in any way responsible for this.
> 
> kworkers blocked all over the place.  Some on XFS_ILOCK_EXCL.  Some on
> xfs_buf_lock.  One in xfs_btree_split() calling wait_for_completion.
> 
> This was an overnight test run that is now dead, so I can't get any
> more info from the locked up kernel.  I have the vmlinux if some
> decoding of offsets is useful.

This is likely the same AGF try-lock bug that was discovered in this
thread:

https://lore.kernel.org/linux-xfs/202305090905.aff4e0e6-oliver.sang@intel.com/

The fact that the try-lock was ignored means that out of order AGF
locking can be attempted, and the try-lock prevents deadlocks from
occurring.

Can you try the patch below - I was going to send it for review
anyway this morning so it can't hurt to see if it also fixes this
issue.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

xfs: restore allocation trylock iteration

From: Dave Chinner <dchinner@redhat.com>

It was accidentally dropped when refactoring the allocation code,
resulting in the AG iteration always doing blocking AG iteration.
This results in a small performance regression for a specific fsmark
test that runs more user data writer threads than there are AGs.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 2edf06a50f5b ("xfs: factor xfs_alloc_vextent_this_ag() for _iterate_ags()")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index fdfa08cbf4db..61eb65be17f3 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3187,7 +3187,8 @@ xfs_alloc_vextent_check_args(
  */
 static int
 xfs_alloc_vextent_prepare_ag(
-	struct xfs_alloc_arg	*args)
+	struct xfs_alloc_arg	*args,
+	uint32_t		flags)
 {
 	bool			need_pag = !args->pag;
 	int			error;
@@ -3196,7 +3197,7 @@ xfs_alloc_vextent_prepare_ag(
 		args->pag = xfs_perag_get(args->mp, args->agno);
 
 	args->agbp = NULL;
-	error = xfs_alloc_fix_freelist(args, 0);
+	error = xfs_alloc_fix_freelist(args, flags);
 	if (error) {
 		trace_xfs_alloc_vextent_nofix(args);
 		if (need_pag)
@@ -3336,7 +3337,7 @@ xfs_alloc_vextent_this_ag(
 		return error;
 	}
 
-	error = xfs_alloc_vextent_prepare_ag(args);
+	error = xfs_alloc_vextent_prepare_ag(args, 0);
 	if (!error && args->agbp)
 		error = xfs_alloc_ag_vextent_size(args);
 
@@ -3380,7 +3381,7 @@ xfs_alloc_vextent_iterate_ags(
 	for_each_perag_wrap_range(mp, start_agno, restart_agno,
 			mp->m_sb.sb_agcount, agno, args->pag) {
 		args->agno = agno;
-		error = xfs_alloc_vextent_prepare_ag(args);
+		error = xfs_alloc_vextent_prepare_ag(args, flags);
 		if (error)
 			break;
 		if (!args->agbp) {
@@ -3546,7 +3547,7 @@ xfs_alloc_vextent_exact_bno(
 		return error;
 	}
 
-	error = xfs_alloc_vextent_prepare_ag(args);
+	error = xfs_alloc_vextent_prepare_ag(args, 0);
 	if (!error && args->agbp)
 		error = xfs_alloc_ag_vextent_exact(args);
 
@@ -3587,7 +3588,7 @@ xfs_alloc_vextent_near_bno(
 	if (needs_perag)
 		args->pag = xfs_perag_grab(mp, args->agno);
 
-	error = xfs_alloc_vextent_prepare_ag(args);
+	error = xfs_alloc_vextent_prepare_ag(args, 0);
 	if (!error && args->agbp)
 		error = xfs_alloc_ag_vextent_near(args);
 
