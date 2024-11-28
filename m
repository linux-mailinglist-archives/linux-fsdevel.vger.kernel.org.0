Return-Path: <linux-fsdevel+bounces-36064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBC9DB60F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691951633FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2F19342B;
	Thu, 28 Nov 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDgSA3Fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148414D70F;
	Thu, 28 Nov 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791267; cv=none; b=FXIlS0WaGnp8WiyirxtnN96/SzFuR99c0YJ2RkFT1OpsesCcDEqTVcFQCfo7gtTb5MZkCDUIabehCpKQWdHdtIlT/i++L88dB6mbvwIStC/qf6ex3A7svPkePIw9h6gVNY1rFG2VwmyHGQBMViKAK76pZGNvi0zLbdWC18Vg+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791267; c=relaxed/simple;
	bh=gqnDIFsz4zY3u9/e60QHB50wur4i08DJi4gy8+n3/90=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=B2necuC52DbMTOXmSpXua5jmEG1yKIGoL9CyZAwQZlE4w2ZMRES7cK56VFiHJbvdZPTjR+z43TOg9hubk+RpJR4hJyllRpzXdmb/2hbq4uEn9SdD6dRiKc/1zu39R6rB3q2dN+ExlXDX7zde360uN0ElxRKRBx4RLu1wgGHExX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDgSA3Fm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so1392282a91.0;
        Thu, 28 Nov 2024 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732791265; x=1733396065; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYqpSFv5fS8gO0KqPMWYrGRRoaEZE+IL3NpfNrLZ+nw=;
        b=fDgSA3FmbrdVs4jf70lq941szKd0TeHk70WvMtHMgA1BZLTkIuf0A63YV7VaVe8/Au
         NwNRdBHw9FBUx8nDNOwXw4QdHicQzcURA3tlzK+dg0XX1311Tzbtl/+HlzorrBUkchCn
         a5pAsbFLjHftyWtO7JN/BIY/hYumBnL70w8PCKiJT1448+VbIOB2F6VE+iwuoGUI3P4e
         uf7QBPcQ5uQxIBs8iYs6JkGOQXOwoYqfZuxVBJS4Inp29x7ykdQFO8If5qnu6DIQ/1gp
         4i8GXSdkvDkIuZ3Kv+Sq5vqDwJ4352SFyU8Kzn4vTqECUs0161LwSPHY7SUq7XE5hWH8
         zGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791265; x=1733396065;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYqpSFv5fS8gO0KqPMWYrGRRoaEZE+IL3NpfNrLZ+nw=;
        b=k7VnMwVsUfufZxNkn6di09n79GFlBvAEdY/dngjagBgBzMNdvM3clp3m1niZSrR0Qf
         HIhkIrgoNuO3FBjqMafrZTU+ezCrFBP60h3hhIHESyGxl5YOqVxFHzC9SdBJi396GI/x
         LrNFypj0BnqXfrmeh7/ADlboQqkvZyWW9QceQQarI0D1skBY+UOtonLeC2J2A6VwX9CK
         BPAjnnABYXNpp9BAbIKex8trOn03ZJCE1NFVnbPiwbrdPsuNQsGzwrGXcZNAj+/+MDkq
         DpKf5juWA0uqK2DLvYR9S+V0eR47OwF8qrk0CvIv2cCzhX+OFCVYii5xU9RNr42QCiwG
         mUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6KHUl1050oYRMjzxAGhJ0i/UiDJGxGv4jGxhBRvjK+uW2hEiOXIGuA0m5PkJXgaJhQZp2V8fnYvCGVO6Wsg==@vger.kernel.org, AJvYcCXdYgOhbKr5lzI19bRNdbPVtWC5OSsCFUxIs0lB1gPbDvako6Z6HvaJYoW/9JTW3GphFlRkEbwVYyWX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1ztty8FL9qm26uB8jbTkL2i4kuHVD0FkBRK1yxEkBErxXjCG
	COD14aqEAfuPOnO/HDGal7Othak+xqKUm2jiUIB8hNApcsCjuNfE
X-Gm-Gg: ASbGncu3zUMYOWFKi/YanybA9i4gjVevsPiK7TNjVsTCYJdK7VMimwek65so0TPRR33
	JuzoIjO0vZO2/OOZjngEZ6NZxjFrvPBbQsxB+OZwOfYkQ742fU46sVfCgNRH0QWYHif8C9dC+8C
	BdOx+LAyntKXD2LfkrcBicdE9a6eVoC6oc53xf1hHZvAQLzbBZnoUJn1eb3UszSJILK9GyZQ17l
	xt8gRBzs303bnGSL77DbF+mYgjfbm+dnE9dlYOq
X-Google-Smtp-Source: AGHT+IFop3o0sFRpFBuPl+Eeo1jC06Mdltf5aZPm8jvA0MJyZb/q6Ws69WzTc+MGrOwkWVFWwWsMjA==
X-Received: by 2002:a17:90a:c387:b0:2ea:507f:49bd with SMTP id 98e67ed59e1d1-2ee25abe48dmr4517747a91.2.1732791264636;
        Thu, 28 Nov 2024 02:54:24 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2aff32a4sm1162360a91.2.2024.11.28.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:54:23 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
In-Reply-To: <20241121123855.645335-3-ojaswin@linux.ibm.com>
Date: Thu, 28 Nov 2024 10:28:58 +0530
Message-ID: <87serc2bu5.fsf@gmail.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com> <20241121123855.645335-3-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Protect ext4_release_dquot against freezing so that we
> don't try to start a transaction when FS is frozen, leading
> to warnings.
>
> Further, avoid taking the freeze protection if a transaction
> is already running so that we don't need end up in a deadlock
> as described in
>
>   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Sorry for being late on this. Ideally, shouldn't it be the
responsibility of higher level FS (ext4) to make sure that
FS never freezes while there is pending work for releasing dquot
structures and that it should also prevent any context where such dquot 
structures gets added for release/delayed release. 

e.g. this is what FS takes care during freeze path i.e.
  freeze_super() -> sync_fs -> ext4_sync_fs()-> dquot_writeback_dquots() -> flush_delayed_work() (now fixed)

Now coming to iput() case which Jan mentioned [1] which could still
be called after FS have frozen. As I see we have a protection from FS
freeze in the ext4_evict_path() right? So ideally we should never see
dquot_drop() w/o fs freeze protection. And say, if the FS freezing immediately
happened after we scheduled this delayed work (but before the work gets
scheduled), then that will be taken care in the freeze_super() chain,
where we will flush all the delayed work no? - which is what Patch-1 is
fixing.

(There still might be an error handling path in ext4_evict_inode() ->
ext4_clear_inode() which we don't freeze protect. I still need to take a
closer look at that though).

So.. isn't this patch trying to hide the problem where FS failed to
freeze protect some code path?

-ritesh



> ---
>  fs/ext4/super.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..f7437a592359 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
>  {
>  	int ret, err;
>  	handle_t *handle;
> +	bool freeze_protected = false;
> +
> +	/*
> +	 * Trying to sb_start_intwrite() in a running transaction
> +	 * can result in a deadlock. Further, running transactions
> +	 * are already protected from freezing.
> +	 */
> +	if (!ext4_journal_current_handle()) {
> +		sb_start_intwrite(dquot->dq_sb);
> +		freeze_protected = true;
> +	}
>  
>  	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
>  				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
>  	if (IS_ERR(handle)) {
>  		/* Release dquot anyway to avoid endless cycle in dqput() */
>  		dquot_release(dquot);
> +		if (freeze_protected)
> +			sb_end_intwrite(dquot->dq_sb);
>  		return PTR_ERR(handle);
>  	}
>  	ret = dquot_release(dquot);
> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> +
> +	if (freeze_protected)
> +		sb_end_intwrite(dquot->dq_sb);
> +
>  	return ret;
>  }
>  
> -- 
> 2.43.5

