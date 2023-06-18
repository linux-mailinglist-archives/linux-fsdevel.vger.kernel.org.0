Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B857346C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFRPRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 11:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjFRPRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:17:34 -0400
X-Greylist: delayed 744 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 08:17:29 PDT
Received: from esg.nwe.de (esg.nwe.de [195.226.126.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9200BB
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 08:17:29 -0700 (PDT)
X-ASG-Debug-ID: 1687100696-1ed71d5dc76ac8d0001-kl68QG
Received: from mail.scram.de ([213.206.175.31]) by esg.nwe.de with ESMTP id 5LINuM2jHp5BNg3Q; Sun, 18 Jun 2023 17:04:56 +0200 (CEST)
X-Barracuda-Envelope-From: jochen@scram.de
X-Barracuda-Effective-Source-IP: UNKNOWN[213.206.175.31]
X-Barracuda-Apparent-Source-IP: 213.206.175.31
Received: (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender)
        by mail.scram.de (Postfix) with ESMTPSA id E6CBA8A7031;
        Sun, 18 Jun 2023 17:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.scram.de E6CBA8A7031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scram.de;
        s=mail2021; t=1687100696;
        bh=UgbVYs9bJq5rL+mcmnpFz/R6KU2ExQ5ruBLD7G1IyVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eA34T42g7aM7SOihdOKH4LG1CSBozCMcIKnQd+b1Ui9BaET/dK7YHApw/utWrnqIu
         10slmyjm5l3uvkvG9K1Jx6mGOPPfLQHdAwMAw6w8TZqQ7IMiacG+mprr56zvZYKu6g
         +odaNIW+eGZNgVylrRSrmFCdlodXTnvdQPnDSpT0=
Message-ID: <46e78dab-72fd-99f4-97c5-99733bf34c6c@scram.de>
Date:   Sun, 18 Jun 2023 17:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] fuse: support unlock remote OFD locks on file release
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH 1/2] fuse: support unlock remote OFD locks on file release
Cc:     Andrew Morton <akpm@osdl.org>, me@jcix.top, jan.peschke@quobyte.com
References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
 <20230608084609.14245-2-zhangjiachen.jaycee@bytedance.com>
From:   Jochen Friedrich <jochen@scram.de>
In-Reply-To: <20230608084609.14245-2-zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[213.206.175.31]
X-Barracuda-Start-Time: 1687100696
X-Barracuda-URL: https://195.226.126.84:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at nwe.de
X-Barracuda-Scan-Msg-Size: 8820
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110212
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tested-By: Jochen Friedrich <jochen@scram.de>

On an unpatched Kernel, running Volume migrations in QEMU on a fuse 
backed file (linke Quobyte) fails with 'Failed to get "consistent read" 
lock' error messages.
With this patch applied, all works well :-)

Best regards, Jochen

Am 08.06.2023 um 10:46 schrieb Jiachen Zhang:
> Like flock(2), the fcntl(2) OFD locks also use struct file addresses as
> the lock owner ID, and also should be unlocked on file release.
>
> The commit 37fb3a30b462 ("fuse: fix flock") fixed the flock unlocking
> issue on file release. This commit aims to fix the OFD lock by reusing
> the release_flag 'FUSE_RELEASE_FLOCK_UNLOCK'. The FUSE daemons should
> unlock both OFD locks and flocks in the FUSE_RELEASE handler.
>
> To make it more clear, rename 'ff->flock' to 'ff->unlock_on_release', as
> it would be used for both flock and OFD lock. It will be set true if the
> value of fl->fl_owner equals to the struct file address.
>
> Fixes: 37fb3a30b462 ("fuse: fix flock")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>   fs/fuse/file.c   | 17 ++++++++++++++---
>   fs/fuse/fuse_i.h |  2 +-
>   2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index de37a3a06a71..7fe9d405969e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -312,7 +312,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>   
>   	fuse_prepare_release(fi, ff, open_flags, opcode);
>   
> -	if (ff->flock) {
> +	if (ff->unlock_on_release) {
>   		ra->inarg.release_flags |= FUSE_RELEASE_FLOCK_UNLOCK;
>   		ra->inarg.lock_owner = fuse_lock_owner_id(ff->fm->fc, id);
>   	}
> @@ -2650,8 +2650,19 @@ static int fuse_file_lock(struct file *file, int cmd, struct file_lock *fl)
>   	} else {
>   		if (fc->no_lock)
>   			err = posix_lock_file(file, fl, NULL);
> -		else
> +		else {
> +			/*
> +			 * Like flock, the OFD lock also uses the struct
> +			 * file address as the fl_owner, and should be
> +			 * unlocked on file release.
> +			 */
> +			if (file == fl->fl_owner) {
> +				struct fuse_file *ff = file->private_data;
> +
> +				ff->unlock_on_release = true;
> +			}
>   			err = fuse_setlk(file, fl, 0);
> +		}
>   	}
>   	return err;
>   }
> @@ -2668,7 +2679,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
>   		struct fuse_file *ff = file->private_data;
>   
>   		/* emulate flock with POSIX locks */
> -		ff->flock = true;
> +		ff->unlock_on_release = true;
>   		err = fuse_setlk(file, fl, 1);
>   	}
>   
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9b7fc7d3c7f1..574f67bd5684 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -225,7 +225,7 @@ struct fuse_file {
>   	wait_queue_head_t poll_wait;
>   
>   	/** Has flock been performed on this file? */
> -	bool flock:1;
> +	bool unlock_on_release:1;
>   };
>   
>   /** One input argument of a request */
>
>  From patchwork Thu Jun  8 08:46:09 2023
> Content-Type: text/plain; charset="utf-8"
> MIME-Version: 1.0
> Content-Transfer-Encoding: 7bit
> X-Patchwork-Submitter: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> X-Patchwork-Id: 13271765
> Return-Path: <linux-fsdevel-owner@vger.kernel.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
> 	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194CC7EE25
> 	for <linux-fsdevel@archiver.kernel.org>;
>   Thu,  8 Jun 2023 08:47:37 +0000 (UTC)
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>          id S235560AbjFHIrf (ORCPT
>          <rfc822;linux-fsdevel@archiver.kernel.org>);
>          Thu, 8 Jun 2023 04:47:35 -0400
> Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
>          lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
>          with ESMTP id S235284AbjFHIrc (ORCPT
>          <rfc822;linux-fsdevel@vger.kernel.org>);
>          Thu, 8 Jun 2023 04:47:32 -0400
> Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
>   [IPv6:2607:f8b0:4864:20::432])
>          by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2062733
>          for <linux-fsdevel@vger.kernel.org>;
>   Thu,  8 Jun 2023 01:47:31 -0700 (PDT)
> Received: by mail-pf1-x432.google.com with SMTP id
>   d2e1a72fcca58-651f2f38634so284228b3a.0
>          for <linux-fsdevel@vger.kernel.org>;
>   Thu, 08 Jun 2023 01:47:31 -0700 (PDT)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>          d=bytedance.com; s=google; t=1686214051; x=1688806051;
>          h=content-transfer-encoding:mime-version:references:in-reply-to
>           :message-id:date:subject:cc:to:from:from:to:cc:subject:date
>           :message-id:reply-to;
>          bh=M478tZ0BJPqFdShribkt4DG9LiqmYQZeG2OJxmtwTQI=;
>          b=Yq2Nya/66Vu5w6nNpTUv8LEnsCGR+JlJ895K/cvR0mlClcb2DLPGqhvMmAhPRnVC6P
>           5lyLBb0BanEOEB5t67nNrVRDwmL/nXyneeJKirBxtqfYoX82wSUEyObyvO5lBx5WlZjd
>           7IFu2/h9klmSHROrvtKaxHRzYYf97RrRZ7R6kUT/MptavElCUHxFZYVt8v39v0QUxqH8
>           MBekCo2B/5+W5SBtVF33Auv200I2Z82VjkUUpo4jXKJb6wedh1dfBUxH68MnoVoVRJcq
>           CehSyCf+cG+5K5kWw96LsHynVXZEpos6blrNXcKzRev92YSyY59ZKV4R2rqBlgxN/CeI
>           vyVw==
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>          d=1e100.net; s=20221208; t=1686214051; x=1688806051;
>          h=content-transfer-encoding:mime-version:references:in-reply-to
>           :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
>           :subject:date:message-id:reply-to;
>          bh=M478tZ0BJPqFdShribkt4DG9LiqmYQZeG2OJxmtwTQI=;
>          b=IIdJ5BqHdko+u8iHJ25sRJlbsFEuTdUrBtxh2l6ZHZ1APaHEHOUIYEdUQk0/jb+fq8
>           FBlIf7K/TzO9LyYIshf+7CTZ2HhxfopgnafeaiMeUyID2x+G1Fc3wvAvPSvF7dZKXYJz
>           ebR+R0Prljz6lJHDAydvFYURpRfMT5E6Rnwp+CCofymPXlYmcWBgQwA+blAp50FZE4yw
>           DMCkSYNzyPbSpA77j4sK3F3ptNJOAdlUzf3w0zlKDX4a146eq+uocseNLb5SftdHWL2z
>           FVqlKkGRjuBws2ss1/Iqhhw1q8tPoIHB1yUicoLntg1ukKxFBLsbHIn5juBAcnz7fmQY
>           xw6w==
> X-Gm-Message-State: AC+VfDxt+ymlCMH+c9NbnO3d+FD0m+JQp5D2xU5rkCmmjrwYyh9vgl+6
>          JeUTJJz5Eg0m9YrHXMK4n1CSOQ==
> X-Google-Smtp-Source:
>   ACHHUZ7154zUvrdNtTgZVFuJ8WpQ3S+Vr8G9uLG4z30KZw1UZuEHkqXzo6u/4y2aW+LeH1v8GBnjxw==
> X-Received: by 2002:a05:6a20:7d85:b0:10d:d0cd:c1c7 with SMTP id
>   v5-20020a056a207d8500b0010dd0cdc1c7mr7184475pzj.15.1686214050909;
>          Thu, 08 Jun 2023 01:47:30 -0700 (PDT)
> Received: from localhost.localdomain ([61.213.176.13])
>          by smtp.gmail.com with ESMTPSA id
>   23-20020aa79157000000b0063b806b111csm614160pfi.169.2023.06.08.01.47.25
>          (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>          Thu, 08 Jun 2023 01:47:30 -0700 (PDT)
> From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
>          linux-kernel@vger.kernel.org
> Cc: Andrew Morton <akpm@osdl.org>, me@jcix.top,
>          Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Subject: [PATCH 2/2] fuse: remove an unnecessary if statement
> Date: Thu,  8 Jun 2023 16:46:09 +0800
> Message-Id: <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
> X-Mailer: git-send-email 2.35.1
> In-Reply-To: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
> References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
> MIME-Version: 1.0
> Precedence: bulk
> List-ID: <linux-fsdevel.vger.kernel.org>
> X-Mailing-List: linux-fsdevel@vger.kernel.org
>
> FUSE remote locking code paths never add any locking state to
> inode->i_flctx, so the locks_remove_posix() function called on
> file close will return without calling fuse_setlk().
>
> Therefore, as the if statement to be removed in this commit will
> always be false, remove it for clearness.
>
> Fixes: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>   fs/fuse/file.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7fe9d405969e..57789215c666 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2619,10 +2619,6 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
>   		return -ENOLCK;
>   	}
>   
> -	/* Unlock on close is handled by the flush method */
> -	if ((fl->fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
> -		return 0;
> -
>   	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);
>   	err = fuse_simple_request(fm, &args);
>   
