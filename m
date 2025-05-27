Return-Path: <linux-fsdevel+bounces-49932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C417AC5C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F8A9E048E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A221146C;
	Tue, 27 May 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Sa1/xR6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0020C47F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380347; cv=none; b=WvbKGas2gJnhwA3fY0gBA3rhVl6iGi1Bi6/KHnKLcQTYzt64w3W073LlkSwnFpmzBEbP+V03e3Oe1pFYh+7q7IR1pdXhumNNlCpDydblGJTEt/1ODY/shPNQB3XKnntYvmec8ahofZTeZ8GQq1/9x0vq8MyxUw2OTwuDMdJcaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380347; c=relaxed/simple;
	bh=DQ7gvIg477mXkbwD+tqhbnf21WuB0ClZJXQEpiX+dCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebne5+tXCKiTnZRg5ZOh2Km/38jCwO0mimHUmMvljddGcrjyn+Lohapfk9cyOxCKsgAqIK61iETtOt/ZR8iVY8pJwjun8LcUoZVHcA7Sv/RuyCZIrYYif7ZHYUTVt8HCd683N786AuRSkuzls0OD4fjSg0DVnzmsVY7rcePhLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Sa1/xR6g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231e98e46c0so31933275ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1748380345; x=1748985145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqliXQh59DYt1kumcR2EztTwEVCDnwBbbaZcfU/tuM4=;
        b=Sa1/xR6gHko5zgyhIu5i6eiULqSTRMOyDU8xc8OUXRdHCcTM03heekBqJZFmkFWvYT
         UX59zj+ftWpE66bntAYtl+Ax6+GLkYBWlQb/lkBR1t09niGebSsotQ1adDNtOKqmFmLJ
         RWpCIQGNcY6CxahzlF3I5tTBWUw/pu3OgNZlIMtIsZzR8y3Fas3JeM0ek7e2beK2RLyU
         SidLpEOSK6DKfolP8iZrPCMnqA9eW05Hd8gBCjPYtwAQfqgBCgQMPBzil81HX8jxbGWB
         xSwLsk87TbIyBhqBZr/QffQa9s6tZ4xVyO4BsIsINE++Vv79gUqueu7WGNgnfRq9yCcZ
         v8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380345; x=1748985145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqliXQh59DYt1kumcR2EztTwEVCDnwBbbaZcfU/tuM4=;
        b=osKLF7KSgghCqMExeQj7Sc8XPybVrdlXcTKbWBcyDrqoXPSUMS1etyTOo2isSIKSJW
         KpDKXQXFQTVVvhIuC78om4BYOwyUE01XbG9YdcgRKZ1t79/6LeVV7/2bsasJyhOBVQ5v
         2TIcj3kLLDrsDNNbxznZ8BbUQYaHvlEdJK+uTMAjGKa0YnZbDEP4W4zlziY9xFHto5li
         7iCnLr58GftDjIts0SFdrm9nAVUEYxGriVQIDabVIwqdkfp5RS9h4qB0nrNcDFBaWqEq
         yfOHhNyPBMCrZhfY2t4sueBh5hU0Xs8AHSKHkzbXE4oegwrhKTNFvPMeB388kl9Hsurf
         iCtw==
X-Forwarded-Encrypted: i=1; AJvYcCUlOFx7zwJslAsHJIIaP6Tf0pwnqm9GrztSzct48YzNPk43Wg+2pLu8oQ75jy4/do3ToUHfRc72Mr0ZybHj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hH4eSb1qDc5xvb7qrgIdF0MTvAO4FwHcqTDBEDa+ZvDA/oKu
	spmf5kaqQK2XDNJqjWdC7zXV0mJ7vSUbjcVEuFHaL7R5T8Lbc4n6mkOEx9FGiOrMsQ4=
X-Gm-Gg: ASbGnct4lW4lrAhDqBH8LvTpYzf2CtGEtYOTvy3UTkFEt6gmbqArO+3pd80r8zS0IKt
	pV35xMJ0pjzPbpxZIwtZMpBb46FWwrX/RX/rl1HUtTA0Mcc5Ju0yK+CmUGl/QiTLVNxx3YdtSdC
	Gq6APIGJPEK3QAEUmGR0ZvsiszYUzVg4N0juekqNZCQuD6fHx17BoZHmTNodiS+b193PPzwNOTA
	XVATmQtDcvox1DW+JsQSayG3WJtS3r4jBubdXbmx+yPHmCGjPjI+zVzgbhDm+iXiT1MLQGtT6yA
	tXhvsS/QPCQJNc1tB/fHfildfZEbTNPxS3A2OnsqRf63e6bm/7BRdJpwwinJ+o+7Vw1VcOAdLBc
	z8QD18Ya0tgZRpO+XnkFNWnSm7Bw=
X-Google-Smtp-Source: AGHT+IGy9c1SIpR62DuX3RY6owTyXe677BgnxKCJ9+xqz0YJshlg1pIkj1ulbuns/NCIo5SMedW9fA==
X-Received: by 2002:a17:903:198c:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-23414f6185cmr201233445ad.23.1748380345232;
        Tue, 27 May 2025 14:12:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc2363b1sm236395ad.174.2025.05.27.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:12:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uK1aw-00000008wla-0J4N;
	Wed, 28 May 2025 07:12:22 +1000
Date: Wed, 28 May 2025 07:12:22 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: don't lose folio dropbehind state for overwrites
Message-ID: <aDYqtuXdLvcSl78t@dread.disaster.area>
References: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>

On Tue, May 27, 2025 at 09:43:42AM -0600, Jens Axboe wrote:
> DONTCACHE I/O must have the completion punted to a workqueue, just like
> what is done for unwritten extents, as the completion needs task context
> to perform the invalidation of the folio(s). However, if writeback is
> started off filemap_fdatawrite_range() off generic_sync() and it's an
> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
> don't look at the folio being added and no further state is passed down
> to help it know that this is a dropbehind/DONTCACHE write.
> 
> Check if the folio being added is marked as dropbehind, and set
> IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
> the decision making of completion context in xfs_submit_ioend().
> Additionally include this ioend flag in the NOMERGE flags, to avoid
> mixing it with unrelated IO.
> 
> This fixes extra page cache being instantiated when the write performed
> is an overwrite, rather than newly instantiated blocks.
> 
> Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Found this one while testing the unrelated issue of invalidation being a
> bit broken before 6.15 release. We need this to ensure that overwrites
> also prune correctly, just like unwritten extents currently do.

I wondered about the stack traces showing DONTCACHE writeback
completion being handled from irq context[*] when I read the -fsdevel
thread about broken DONTCACHE functionality yesterday.

[*] second trace in the failure reported in this comment:

https://lore.kernel.org/linux-fsdevel/432302ad-aa95-44f4-8728-77e61cc1f20c@kernel.dk/

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 233abf598f65..3729391a18f3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1691,6 +1691,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
>  	if (wpc->iomap.flags & IOMAP_F_SHARED)
>  		ioend_flags |= IOMAP_IOEND_SHARED;
> +	if (folio_test_dropbehind(folio))
> +		ioend_flags |= IOMAP_IOEND_DONTCACHE;
>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>  
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 26a04a783489..1b7a006402ea 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -436,6 +436,9 @@ xfs_map_blocks(
>  	return 0;
>  }
>  
> +#define IOEND_WQ_FLAGS	(IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED | \
> +			 IOMAP_IOEND_DONTCACHE)
> +
>  static int
>  xfs_submit_ioend(
>  	struct iomap_writepage_ctx *wpc,
> @@ -460,8 +463,7 @@ xfs_submit_ioend(
>  	memalloc_nofs_restore(nofs_flag);
>  
>  	/* send ioends that might require a transaction to the completion wq */
> -	if (xfs_ioend_is_append(ioend) ||
> -	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
> +	if (xfs_ioend_is_append(ioend) || ioend->io_flags & IOEND_WQ_FLAGS)
>  		ioend->io_bio.bi_end_io = xfs_end_bio;
>  
>  	if (status)

IMO, this would be cleaner as a helper so that individual cases can
be commented correctly, as page cache invalidation does not actually
require a transaction...

Something like:

static bool
xfs_ioend_needs_wq_completion(
	struct xfs_ioend	*ioend)
{
	/* Changing inode size requires a transaction. */
	if (xfs_ioend_is_append(ioend))
		return true;

	/* Extent manipulation requires a transaction. */
	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
		return true;

	/* Page cache invalidation cannot be done in irq context. */
	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
		return true;

	return false;
}

Otherwise seems fine.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

