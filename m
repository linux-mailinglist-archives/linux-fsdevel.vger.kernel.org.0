Return-Path: <linux-fsdevel+bounces-68425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B98C5BC31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00FF3B37BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2C2E613C;
	Fri, 14 Nov 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JywJOkRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C719F137
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104731; cv=none; b=XQk6ZzC03be6NbA9DXdkD24dhfn+Sxtt+d8JEyzajKs+3nJBiUx4pDai/LM7z0Y3+m+PZaztGBLPZony0HcRhuUReVdL6F8UvwyQaVvj+bj3ZL6e/f6Fns/JeEg/YSzVXJdlfv5IopahpaTGi65mNQHheT95MqvS0DvMnCmN5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104731; c=relaxed/simple;
	bh=pBruvPUEk9sdm7ojTRfuAmE5tz4M39hzPy9nFvCgxXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKsYEGLkucnP2biCAbdgnrPblubIk8xRPskS4/mpL5JQyQdQI6UTcQwdV21H3CZtPAh6ICC4TuB/bB7wmsVHcGIDEGxZO2KJRx8hjce8AxB8mn/1W8LY5eI173NK5JSaoUuwwrHd05BG/Bn0i3QZsob/mcRV5faCzkRSD3YKNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JywJOkRZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2627269d5so205236485a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763104726; x=1763709526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RSUC6I/0xtkTFjc0S9sYd9t9bOQZ6fRfLXdwbkZEqCo=;
        b=JywJOkRZMMuhTpFpEvs34qunX7J3CRQqIzA25kMCrRs3AtHzNRpbAezcS2m9b3vqMo
         CmLtxXyLfNfcItKN20LU1GAwHi5Sha2MqsY482dcNQgVZeQKGGIuiVTLiqAC9Oh4YpK7
         kGeqS354X0K9TR/nUQILU6uXomY1FYAoWu2dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763104726; x=1763709526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSUC6I/0xtkTFjc0S9sYd9t9bOQZ6fRfLXdwbkZEqCo=;
        b=Zg25T8pQN0jEh9l++RY26l6uGaMLl2N34kmby9Bv5xRAw1Gmx7oJPAv6LOV4Yaudt4
         dWBTTZw7yBOahwb1p2u8AhfNwIx7bApvfww+Yubd06rWwcgEYf161M5WUMjYJmZOafL/
         rC4so0RRoeRLwwpcg3hgBQeB6vPV9PG6ECWbK61mgoItHknV2bC6Qu/cp5E5Wu6bODRE
         0jk1NEOKc1QarWPvpYE0e3ijBQ7JaXbADy5fg88HiV5dHnxTQ0l8qm6c0zIsqWkXNlKn
         S6UbMJDWBqvBvIQP75QsM68QoZyWKkjVbBFmG/aZwBw2L9l6MBkJ0319txjdALXR6nR1
         FsrA==
X-Forwarded-Encrypted: i=1; AJvYcCV4iDT2ZNFP2bWsRy6dA0IbNXu+SobL1NFsifKQjhex6jYPxc0UNQQgOVcbAf124J8oPLDUvStk5oPSyUY6@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMHT5gZnR8syz+vI8JRSqWkPEBd/FYp84g+2zjXjEdWfrWW0u
	Utn1+nmSfY4GKKRYZD4EqnyJCI1/weHsMIUWTdbVb1iA0Ql372gHu/ius1rjeZUPPIGFdPmK6g5
	iBtrzPNDC6nFW3LCtpeFgE9LAKYmMoHMOCkFkXhp8Mg==
X-Gm-Gg: ASbGncvMcxX2FD9YbjVQtqoPjWuCn6emRMi+iIfqJkf3PLQSjNJJWQ9CJj4ohICXKom
	zSA+HNr74K5YBDUo7OsPtYNVs5XoFe4mZaP2ZzipQKME9VlmY0UqY41rAY17yrWBgwzmbaKLRHm
	gpZ7OH4/4Vc+OkSE2LUrADnV0cvI6C6fKuLQ4dn1nzg6JZqdRLmEsNL0/tIi+ymQXwoEPgU+swL
	VlDTu4sT+UZuwAAYvteIsjxSmPuOX/RGAatMpn57KQP1RebG/JZip/LPm2IRLXR2lbv
X-Google-Smtp-Source: AGHT+IH9defKmC5r+LJeQ1e6mdHLF4LbeJoqfB5vpMC/YabfqRZyvpmEh8pDIVCEspEp39Qry07R+fhopAd9kUSsFWM=
X-Received: by 2002:ac8:5e0d:0:b0:4ed:d2b:d43f with SMTP id
 d75a77b69052e-4edf2048479mr32594541cf.7.1763104726664; Thu, 13 Nov 2025
 23:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-6-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-6-b35ec983efc1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 08:18:35 +0100
X-Gm-Features: AWmQ_bmo0OzcPAWZX1QwevX3GLs4HxBqX6zuFXDJXLl0cJT40hnDYO9AGPqQCOA
Message-ID: <CAJfpegv=yshvPv432F6ytAcuBLWQnx5MvRQjKenmzg-WafZ_VA@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] ovl: port ovl_create_tmpfile() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:

> @@ -1332,27 +1332,25 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
>         int flags = file->f_flags | OVL_OPEN_FLAGS;
>         int err;
>
> -       old_cred = ovl_override_creds(dentry->d_sb);
> +       scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
>                 new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
> -       err = PTR_ERR(new_cred);
> -       if (IS_ERR(new_cred)) {
> -               new_cred = NULL;
> -               goto out_revert_creds;
> -       }
> +               if (IS_ERR(new_cred))
> +                       return PTR_ERR(new_cred);

Same thing here.

>
>                 ovl_path_upper(dentry->d_parent, &realparentpath);
> -       realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
> -                                       mode, current_cred());
> +               realfile = backing_tmpfile_open(&file->f_path, flags,
> +                                               &realparentpath, mode,
> +                                               current_cred());

Where do we stand wrt "chars per line" thing?   checkpatch now allows
100(?) so shouldn't we take advantage of that?

