Return-Path: <linux-fsdevel+bounces-25721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B146894F910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666A81F22753
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E4195B18;
	Mon, 12 Aug 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPr1R2pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4B4D112;
	Mon, 12 Aug 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499143; cv=none; b=fP/dZqaUiC4Totp+v6+NK8jyJ7UAtwfg1lHdnaPInLo8we55qxv/BiP0rL8iStIpPBMfUTX88LOu4bBCTvlnADiY/dPmAbDmW0FVYQm0wx7KqEfn5hMrwJ1ZlIURYH4USUd5eSoFpKnOt6wJtJ+agz5kXKdnKGBskIy7A1+STig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499143; c=relaxed/simple;
	bh=+/dmCtTKtDCmF8v9S+Xz2eif5t/bIIfoP2HPW6FRZSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5YrWDacbIP68lObTjLQ/wMjrEto2tZTSAhmK6Mact8rtST0vHAlK010EdCqFc1+uFSWTixiZa7a5VG6vd9SyTZLcywZqYy5EgTpwlU/7bEVgV45CxWvmckh83yWHnoV4xNS4H0odbZnM33vvRTLl9NM1Po7Pp8t+8WLHCdYqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPr1R2pq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso52355571fa.2;
        Mon, 12 Aug 2024 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723499140; x=1724103940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77UTgNM+g1Q/AdgNsjql77qvhxjCiN6U5tIJiUV1daA=;
        b=aPr1R2pqncfN7CoHRI9Wqfjle5mPbJwu7JF1WpsLvXfhHcDHsLosu34/YoFaZxahTm
         JX0RDRizQoGMrkXlx2+8uoEdwhdn1rOTEK22/xb1+85SIhX6qtFjGnKWziNQiobae1bG
         TlSWwDz9fyFghtV6qq/kdQtDtzPCpd+6f54SBwB/SyEHyJe+BiF0YKo8+tuB2xpjPGbE
         i33xYS5btOmpH5iyydIbgmLthovvAaa4o9tG0ibozfV97UljG72RHMelPnqK4mcAFNZM
         j1aUrUWgs3OH9HAGY2fXugvl7WVb/LIAQvYy6q8gUrZpR73NHoAoQ76uT12/6xJYLtUM
         IqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723499140; x=1724103940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77UTgNM+g1Q/AdgNsjql77qvhxjCiN6U5tIJiUV1daA=;
        b=jkBtI4RnKlF2CAk/pedv8577PBBHwoOb+4Us+zGvgR25DOE3ly5zJoUNst9ofE40wQ
         ZOdOvE91EvVG2wt/fg1UTbc+HRJ9Dw1xATEb2H8q3bcfUsjWBOYvLaWZYRqtVnghZGBH
         Zl3sucJmycXfRlktrS0RygPks4o7/Oy5ezdi8chKodKX6JFW3Dkm6t5tPT9f8Vb374Dh
         t5WP3HvqDy6tj3MmyQY51HyaKCwfY6YxBK67JLVdFYo2+sbtTGZc7iEzyH1OLmuMDQwg
         lqLuxUDVYGKzme9vJz7bKTAu4RlQ2s4Hft3mXdCP81kYYLtjsOLF3QlUvnCvCWEwOPbz
         I02A==
X-Forwarded-Encrypted: i=1; AJvYcCUMpA7l6bPhnujeBGPtRLPn2KEr3Kcp5pwVEQDXLWhg1sZIF2/Y+CFCTVt3eMq0PgeIsubnp6SLfuVrAhbSmOizuI3bu586YNkClmmWbiKmlo4yYZn9cnpLaP+O1HVKKuh7Mo7XvHguDsZ7xq6KyDUVkRVgOx8JlZhhwD8nfdpi6MOu53eKn0X98NeLnYSBLGqkBoaw7j2g+ZKzRpHa0lhTE9EkgQDbUyoOwiI=
X-Gm-Message-State: AOJu0YzQYa4OrWZnbsI5oGCDLn8kHAM3A1fIx/6dTcMIVX4Jlw/DY8O+
	T3r2ZKviza2KLjgvm5GCsZZYx3aCsH3XYm6YzkZRBUSwSLyEOtQE
X-Google-Smtp-Source: AGHT+IHCSQ3xvWb16BnUlSYfXiHKUOHGnsKamZs/Kpv5QaNE4OmNJeTQrTUdakPuoFumAh+64CDR9A==
X-Received: by 2002:a2e:bc09:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f2b70d3805mr11647201fa.0.1723499139891;
        Mon, 12 Aug 2024 14:45:39 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5dfc9fsm2420031a12.66.2024.08.12.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:45:39 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:45:29 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook
 inconsistencies
Message-ID: <o6ptrfa7gjdukphqtp6dakq3ykndrjusuhi4fyvpc5ne6amcig@lqbdb2dg7yzv>
References: <20240812174421.1636724-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812174421.1636724-1-mic@digikod.net>

On Mon, Aug 12, 2024 at 07:44:17PM +0200, Mickaël Salaün wrote:

No opinion about the core idea, I'll note though that this conflicts
with a patch to move f_owner out of the struct:
https://lore.kernel.org/linux-fsdevel/20240809-koriander-biobauer-6237cbc106f3@brauner/

Presumably nothing which can't get sorted out with some shoveling.

I do have actionable remark concerning creds though: both get_cred and
put_cred are slow. Sorting that out is on my todo list.

In the meantime adding more calls can be avoided:

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 4f03beed4737..d28b76aef4f3 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -66,6 +66,7 @@ static inline void file_free(struct file *f)
>  	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
>  		percpu_counter_dec(&nr_files);
>  	put_cred(f->f_cred);
> +	put_cred(f->f_owner.cred);

	if (likely(f->f_cred == f->f_owner.cred)) {
		put_cred_many(f->f_cred, 2);
	} else {
		put_cred(f->f_cred);
		put_cred(f->f_owner.cred);
	}

>  	if (unlikely(f->f_mode & FMODE_BACKING)) {
>  		path_put(backing_file_user_path(f));
>  		kfree(backing_file(f));
> @@ -149,9 +150,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	int error;
>  
>  	f->f_cred = get_cred(cred);
> +	f->f_owner.cred = get_cred(cred);

	f->f_cred = f->f_owner.cred = get_cred_many(cred, 2);

>  	error = security_file_alloc(f);
>  	if (unlikely(error)) {
>  		put_cred(f->f_cred);
> +		put_cred(f->f_owner.cred);

		put_cred_many(cred, 2);

>  		return error;
>  	}

