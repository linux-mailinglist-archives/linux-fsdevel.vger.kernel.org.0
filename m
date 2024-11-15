Return-Path: <linux-fsdevel+bounces-34990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1E9CF952
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA701F238E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B801F9EA8;
	Fri, 15 Nov 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+sZHJXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF391E630C;
	Fri, 15 Nov 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707540; cv=none; b=IO6xVPJK/jXQNIFvZ1U+15qJjss4qcIEg2PPHM6OT0Dk4hKiAjF+LrPAeq/f5m4KLqBa+iOjam6/cVjZ5Q+Om7EXxBWx8jYGg3AVXXdgWVsRg1mGjxu1xJFoxYNbPPudFyIqd64nlqav05ICMJekXcTLALfaAE03Wr2LN0Y1+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707540; c=relaxed/simple;
	bh=sZFV0uP3WWeSSyCd835E6WVK+3+s+sPdBHOyjlWNkuQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OSqRu4Ed6/avBAi7WvqNPyRwQV4w+wz1W4WLAtRu5Zg/7dAjc9hHC1ivCnQuQV6CZ7QEEHHZySDVilyLlaXPgaj2T+dTorLkIAKmjVZThXoH5cYL5R9BtzD42WaAW83CsEJs/9qbt+NXn8JXkU+OMaSqqCoCYtYqxuo+Xx0pwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+sZHJXZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e91403950dso1758395a91.3;
        Fri, 15 Nov 2024 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707538; x=1732312338; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9q1mbAPAv0n/S09209YIRJnoM8UsP7wPs+sS6v3ZWZE=;
        b=Q+sZHJXZ+8ap6DuDzRP+TwKvg44v8m04Pq0PTdwcWpGyA6CFsMFissZ76w3am+leK6
         HklMgZQZCz6oOkVp2PPNyIooNHPi9+8cljo0r5x4arpTAsJWYJjtDMXXW5nNV9GySMaZ
         IiqBnqTqLKRh5MKgEY+O6tbhnDIDIrr2nzf+s1BuyRmnvlB34Yu67Y7Hyy5M3P1yC4TQ
         mIq/bSzi2dwIhiTvrJa6gyFRvDTBziAAM1zMAnfN1DQT1Y7pnJNZLeoHiZQWT9IWoooD
         WyKlxTN5PyxsjwXi5CCJrdBUDTfxmWnTUmZKyt/jYurE9IQiwhfGmpCjgvOddELeknvF
         4dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707538; x=1732312338;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q1mbAPAv0n/S09209YIRJnoM8UsP7wPs+sS6v3ZWZE=;
        b=S7m2puc0uSXdPrhjMS3L0W7AL4tG2YmeSxfSHBMP0CxXw9Am4m6gaoxeC8dqK6avrW
         pGmQidceLoGzh2rvS3/WTmS+a3vAoh3G+X+hcAZGyxBCuhV5+UG5oHH6TWSRfuEPguSO
         2/fe2yf7cTARwqy+QE8sqG38bl7A7BVB+8cYVHvgOm9Ixhn0d8lwOHE7812JKuveHx6Y
         iElJy8uChHGbnYoDBu1GOqBtos0nYa/8zH4dWfC3Z1I2SyDm3xQHZvyPV1si+Tvuu/31
         vy+K7ozeVzAJ9UDGbN2M3QXJc9hPOQ0he/EXAQycmmHUYcF5Xb/8F8EHcg3mFI58igBH
         Je6w==
X-Forwarded-Encrypted: i=1; AJvYcCX7+9jvgdxagRsV78/oPzbSJR0n5diZ5dZz3iU9K24j2Mdv7pNu1UIfO31xMl22GAoapjZNkvm8QjCX@vger.kernel.org, AJvYcCXGxFKPNdXj0HzTXxBep8hHDU+j03fWZoCStzm8bi22AkB9jmIR34zG0kpZrh7WwBuUH+ulDMoATpKTMyY74A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/3UlgaVetO6GWrWnYuf4ngOOvvXJ9n3gsct+1T/vuMJ6i5uI
	/aqEEa8biV1sCZaCHnl0HVEEBC9bDDfD+QlYWwFdyfPUgDLajtcx
X-Google-Smtp-Source: AGHT+IGrN3dicLqeJXERe269SXL68ng6H2DR3PjmuT0t8IoX0XTxWnm/+wyXNQnXkMuNHwSIW76biw==
X-Received: by 2002:a17:90b:4c52:b0:2e1:e19f:609b with SMTP id 98e67ed59e1d1-2ea1558acfcmr4962539a91.24.1731707537800;
        Fri, 15 Nov 2024 13:52:17 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b6bsm3443935a91.8.2024.11.15.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:52:17 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
In-Reply-To: <20241115183449.2058590-2-ojaswin@linux.ibm.com>
Date: Sat, 16 Nov 2024 02:20:26 +0530
Message-ID: <87plmwcjcd.fsf@gmail.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com> <20241115183449.2058590-2-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> One of the paths quota writeback is called from is:
>
> freeze_super()
>   sync_filesystem()
>     ext4_sync_fs()
>       dquot_writeback_dquots()
>
> Since we currently don't always flush the quota_release_work queue in
> this path, we can end up with the following race:
>
>  1. dquot are added to releasing_dquots list during regular operations.
>  2. FS freeze starts, however, this does not flush the quota_release_work queue.
>  3. Freeze completes.
>  4. Kernel eventually tries to flush the workqueue while FS is frozen which
>     hits a WARN_ON since transaction gets started during frozen state:
>
>   ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>   __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>   ext4_release_dquot+0x90/0x1d0 [ext4]
>   quota_release_workfn+0x43c/0x4d0
>
> Which is the following line:
>
>   WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>
> Which ultimately results in generic/390 failing due to dmesg
> noise. This was detected on powerpc machine 15 cores.
>
> To avoid this, make sure to flush the workqueue during
> dquot_writeback_dquots() so we dont have any pending workitems after
> freeze.

Not just that, sync_filesystem can also be called from other places and
quota_release_workfn() could write out and and release the dquot
structures if such are found during processing of releasing_dquots list. 
IIUC, this was earlier done in the same dqput() context but had races
with dquot_mark_dquot_dirty(). Hence the final dqput() will now add the
dquot structures to releasing_dquots list and will schedule a delayed
workfn which will process the releasing_dquots list. 

And so after the final dqput and before the release_workfn gets
scheduled, if dquot gets marked as dirty or dquot_transfer gets called -
then I am suspecting that it could lead to a dirty or an active dquot.

Hence, flushing the delayed quota_release_work at the end of
dquot_writeback_dquots() looks like the right thing to do IMO.

But I can give another look as this part of the code is not that well
known to me. 

>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

Maybe a fixes tag as well?

>  fs/quota/dquot.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 3dd8d6f27725..2782cfc8c302 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -729,6 +729,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  			sb->dq_op->write_info(sb, cnt);
>  	dqstats_inc(DQST_SYNCS);
>  
> +	flush_delayed_work(&quota_release_work);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(dquot_writeback_dquots);
> -- 
> 2.43.5

