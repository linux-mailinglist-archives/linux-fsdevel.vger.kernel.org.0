Return-Path: <linux-fsdevel+bounces-20049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA48CD299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 14:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65851F21DB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938B14A0A7;
	Thu, 23 May 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn0SHxIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CF1474BC;
	Thu, 23 May 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468560; cv=none; b=BVhj+2wHwWxWGE1GmYZEEaXGxAiS86lAlsrY9hiUwFo/Tpgyk6a8++AJMut2vBYhWfoBDIVjauXfYrgOhnfv4JiF5g9lsjxiEqCpF0AV0pQ8msmFewxHeAhHsP1Z+FdsMNcNOLjAJ5CrgMnbEKDMZfmtfn/Kg7nuCNwX1uU7pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468560; c=relaxed/simple;
	bh=HdmW1gOgpWUDWXSdqbqOwIQZrjfbTqeyJE7qb78fOkE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Cv4O9OxWxdPrLKUI4scVgkudCLGFcSA4MaG9fWx7w/qOPUQG9Ur6lZFgIAe5+KtQ0Fa9EC0/SfF3D9YSCx7UGm17HV3CbQueSKFDMS829FhGAi3BEW5y0ERU/4Auaaf30NCwMnetnpXimErCKu+KMYl9sfXqrTc2LjViHcoJsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn0SHxIG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bdd8968dabso666487a91.3;
        Thu, 23 May 2024 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468558; x=1717073358; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3aeBmKgrOnO4yEhVnrO4wtVoPhNU9lhbqrAJNJKcN4g=;
        b=Gn0SHxIG9B41DRs4CovVh48WlIsbsMqO7NS/rvI9INhLZfaHRKKFuOcpkgCdiHZDwX
         UtWuQ08Aif27+9YQ13KO5uq+3JiZqxKKFzl/3/nXOjL4xv6PUB+Mn7iNiRy3WSKqRGbt
         LWovoJOPI+mlUr71F5+QgM2s7vg9Hy+4luEe8fE1bEG0VOjt6bgR/+mA4OAEFwVMNeys
         kHn99tUxR6PXVUQP22PPfHxy2J/+aGyVgVALdDzJO/lrgSkmHl5lsA81re5SqdfQChKp
         IQLPkunzIz3rfQDhaRNgdfPoD0dZJ+kRIiHb4GXznxo6vCfEcFqj/QHB0nD4n3fxnZaf
         l1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468558; x=1717073358;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aeBmKgrOnO4yEhVnrO4wtVoPhNU9lhbqrAJNJKcN4g=;
        b=VpsSG463LZCTgzggkuR3a217deA3UiZHTSa5tJINH0Gd4/VOhq9lXRIZICkF2oK4tA
         VnVTn0asXaCAqNPcfAsKzHmQsU9H6gmRY8wvzAnn+B5aPcUypbNBQ41D51zKoAYMscrk
         jDnD3y6CSm1xnMachN8YaDm9GeU3JdMim3n1JKLpoPxN9kA0v0AX6PpR97H30kjJulpO
         6RQ9VPIpMwpn3lx9Nk2NvMlUm08AkwpFJuMzWL+K/zhtvj1oSGO/rnGmakoK51rxZe8U
         nnYcl3A4O+QGpAQIBvVI7lUWvGXpOesGzppLA8/qJcrzQzGG5uJNsGY6+7vlI8CunYfU
         t7lw==
X-Forwarded-Encrypted: i=1; AJvYcCXVSFQAkdYCOuAOt10B+PKyTrdSWYmGRWZToblFzjdNb90EDiWTQ/jwcp+dfVK1YEo0IP1pV2JzqS9pBAVb+n9OFLlydCmTymiCVXGZYcXQ3TwbgMlOlMgVAih1pN7P3iWZ98faLU2lqQ==
X-Gm-Message-State: AOJu0YxwZn6YJybJDcs83RFbidcZhmy5RB2R0VatEioe+Vk5TiLcUbyO
	1gW1IbVxX7lnKw85oz7SnGMPntu60B9/ZSEyJ0Wh/slaA+s7B4H+
X-Google-Smtp-Source: AGHT+IFyZ9tLOMxbFXyWyRzA8fBN8CQ9Ox4w0qSotXEjlrcRyj3tjW1eGMS/TfOEWCgDutX2ppOMcQ==
X-Received: by 2002:a17:90a:d389:b0:2bd:90fc:6631 with SMTP id 98e67ed59e1d1-2bd9f5b8a77mr4926122a91.33.1716468557954;
        Thu, 23 May 2024 05:49:17 -0700 (PDT)
Received: from dw-tp ([171.76.81.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ef83c1sm1485328a91.22.2024.05.23.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] jbd2: speed up jbd2_transaction_committed()
In-Reply-To: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
Date: Thu, 23 May 2024 18:00:53 +0530
Message-ID: <87ttiosoaq.fsf@gmail.com>
References: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> jbd2_transaction_committed() is used to check whether a transaction with
> the given tid has already committed, it holds j_state_lock in read mode
> and check the tid of current running transaction and committing
> transaction, but holding the j_state_lock is expensive.
>
> We have already stored the sequence number of the most recently
> committed transaction in journal t->j_commit_sequence, we could do this
> check by comparing it with the given tid instead. If the given tid isn't
> smaller than j_commit_sequence, we can ensure that the given transaction
> has been committed. That way we could drop the expensive lock and
> achieve about 10% ~ 20% performance gains in concurrent DIOs on may
> virtual machine with 100G ramdisk.
>
> fio -filename=/mnt/foo -direct=1 -iodepth=10 -rw=$rw -ioengine=libaio \
>     -bs=4k -size=10G -numjobs=10 -runtime=60 -overwrite=1 -name=test \
>     -group_reporting
>
> Before:
>   overwrite       IOPS=88.2k, BW=344MiB/s
>   read            IOPS=95.7k, BW=374MiB/s
>   rand overwrite  IOPS=98.7k, BW=386MiB/s
>   randread        IOPS=102k, BW=397MiB/s
>
> After:
>   overwrite       IOPS=105k, BW=410MiB/s
>   read            IOPS=112k, BW=436MiB/s
>   rand overwrite  IOPS=104k, BW=404MiB/s
>   randread        IOPS=111k, BW=432MiB/s

I was surprised to see that even the read and randread performance
is improved with this patch which should theoritically only impact write
workloads given based on such checks we are just setting IOMAP_F_DIRTY
flag to report to iomap. 

But then I came across these two patches [1] [2]. It seems the change
[1] to set IOMAP_F_DIRTY was initially only done for IOMAP_WRITE path.
But patch [2] moved some logic to fs-dax core and filesystems were left
to always just reports if there is any dirty metadata, irrespective of
reads or writes.

[1]: https://lore.kernel.org/all/20171101153648.30166-17-jack@suse.cz/
[2]: https://lore.kernel.org/all/151062258598.8554.8157038002895095232.stgit@dwillia2-desk3.amr.corp.intel.com/


Ohh - could this patch be that reason of peformance regression when ext4
DIO moved to iomap? Should we CC: stable to when ext4 DIO was moved to
iomap atleast - which I believe was v5.5?

Looks good to me.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> CC: Dave Chinner <david@fromorbit.com>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-ext4/ZjILCPNZRHeazSqV@dread.disaster.area/

aah. This link is helpful too to understand the context. Thanks!

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v1->v2:
>  - Add READ_ONCE and WRITE_ONCE to access ->j_commit_sequence
>    concurrently.
>  - Keep the jbd2_transaction_committed() helper.
>
>  fs/jbd2/commit.c  |  2 +-
>  fs/jbd2/journal.c | 12 +-----------
>  2 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..8244cab17688 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -1108,7 +1108,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  
>  	commit_transaction->t_state = T_COMMIT_CALLBACK;
>  	J_ASSERT(commit_transaction == journal->j_committing_transaction);
> -	journal->j_commit_sequence = commit_transaction->t_tid;
> +	WRITE_ONCE(journal->j_commit_sequence, commit_transaction->t_tid);
>  	journal->j_committing_transaction = NULL;
>  	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
>  
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b6c114c11b97..cc586e3c4ee1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -789,17 +789,7 @@ EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
>  /* Return 1 when transaction with given tid has already committed. */
>  int jbd2_transaction_committed(journal_t *journal, tid_t tid)
>  {
> -	int ret = 1;
> -
> -	read_lock(&journal->j_state_lock);
> -	if (journal->j_running_transaction &&
> -	    journal->j_running_transaction->t_tid == tid)
> -		ret = 0;
> -	if (journal->j_committing_transaction &&
> -	    journal->j_committing_transaction->t_tid == tid)
> -		ret = 0;
> -	read_unlock(&journal->j_state_lock);
> -	return ret;
> +	return tid_geq(READ_ONCE(journal->j_commit_sequence), tid);
>  }
>  EXPORT_SYMBOL(jbd2_transaction_committed);
>  
> -- 
> 2.39.2

