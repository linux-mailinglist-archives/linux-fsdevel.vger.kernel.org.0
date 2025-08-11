Return-Path: <linux-fsdevel+bounces-57444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579FFB218F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A354611BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D12242D89;
	Mon, 11 Aug 2025 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSHJWR2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F5239096
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953875; cv=none; b=f0fAJwL9EtIeRFsKcmY8BB4+DS2P9XH16kA3D3QmPLoFWIVDhfkv/a37cyeAlqabMeGq0VnGtXC88J/Jn8eUx0dStOS6is7v864TyZTTdjTgI3f6gUfMJMWRz8ZAe/gABX9fv707La+piFqoqlD6Ztb2U14OQRF4vI3lGxlw3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953875; c=relaxed/simple;
	bh=XlKWe7hGY5MiFreFuz3bf4pAkpABAV4Hc9Q8DzXwtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCRB46L/2AoRZLXnq/fx5CKNqcbe8ML9HM129ceQedIbw6Q+WPdqFaHVej4TBwwQdHbOflYZJWwzALDdiJ0Kx0rCXMIj+6dlhIfSfIUjwwvl9240PdfAGm3KMyoL0DLFMiSyP6tMJz6rVTsiu3D4wDjk48c3GDZ/SZ0Wupj9D3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSHJWR2A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-242d1e9c6b4so89725ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754953873; x=1755558673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=YSHJWR2Ak4gKSANGEL3Fqc1ZINt5iFRbA0zVKdnvL0nnrT5J7nx5tQuwEy6fGH1kka
         UcFrLsH6sQOhTkcUt2VHNlaRXkU9eJ1/6gEJexK7A+fBYC5SgmkTbhrR4MBcBoVvyoOu
         xAe7SjKWG6czv3spPAy4dOGwTs0FNxeCXIHWTScr7tItz/DAOpZJXqBfzWYHSHstTI8c
         sF/Y7AffUIuqhEjogcjUewGZ1DURn34f9y3fS9Ai3O6go+qe4mZCoqKRayKPNgF97GcI
         FZw/9GQTxy6T4Hn/S2l4EXMEaSdGc9j7admfGv6LthS+q7Ah1vmimLLWSXXFhPK5yOpN
         RlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953873; x=1755558673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=FXyQ6qyZit8IPH+opkl8bKwa67hDvpWlGMLZOWQTqRq6gt9rXjOiI1JHh0Pa80X8OK
         0k7LlSF3l53IXFZzPFbZi3ZNNLk6OT+dxT9Kbih/3DO0v9gf4OdqkvIO0OIL5QOub4Hg
         nyt6wPyD0MGOy9vHp6T6kFBOKdkKwfMntfvAzOosBJK0t+XAesBwKN3Y1THfbBv97h/2
         mq0GK1iq8u0jrSL1ZNlWjK/U16bwKvwzQUXJb1Q6WvihpzjIrpXCa8L3WrQKLt/fRMG1
         Dp0P4Ndcf1d9Nzujc2qxfPOCTR6qp5YJBSo3PxsCHm09X4zZNyVkuU/2M5vQ60INEXWt
         jf+g==
X-Forwarded-Encrypted: i=1; AJvYcCWz+t0fBE216rwIDx8Y0elV7GWJE+9yjKIVXonQkPvxM8pMWU9vXHiO8n+U9gZq6FKNSSY3uVhiiAkCDA9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2upaXGWqjGvqmVW6SpGXmX6/xadG4jV/utWpnjrbLOxqHzJHe
	fGKlgxL08DHVNyemzDoTiBfwyX/uvPlLykj2NN2/HhFquvBqy18mppMLk1ceUknS8A==
X-Gm-Gg: ASbGncuwvFpP5DnpvXdPsHlM2xJo4gs1ELDQbmC5qWwBe+0cEdADzrwL4oxl9R0eV3k
	h2uL2lK3FJSbQfXzOnVhbEFxgeTmjPsRQOpBzZeyrxsRIbttIxdN8QEhH84/0hQRsBNtkIuRPXo
	Yx591vsJbM591wuRNerjylTsL7Nf+sWGyuOdsltJUZGHdw6KTGLlzKiFKHZ5lv0gf5D2PWLjA8P
	u8arN0LcCpMRTqOmt3tt0pOEt+0dDa05zZkQTe4k1ARlTS8GhNFzkwhf1zVYXzZOJj15/YXKjih
	VdkGAEwsA2TOPctGSPIWHK543Qjt2cHHZcz+u/CBp0TnYcVrf1kXRMsmkxn8ImKXnmCLg1o1RYB
	utEYucNFVfJR7udmpFaFEXQRo/vZ9JbiY/a0lJnORJOtNEMmgDhe9UKzP5PXjX7hcS+5w5Q==
X-Google-Smtp-Source: AGHT+IFzyKR/w1E27eWm6IovhDIP1SONsBPcExVJWFEliFhx+rfqf71Fi48caAfu36gGEzgxJL2HPA==
X-Received: by 2002:a17:903:41c5:b0:240:520b:3cbc with SMTP id d9443c01a7336-242fd3660c2mr1826635ad.14.1754953872909;
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm27859139b3a.54.2025.08.11.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:11:07 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 26/30] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
Message-ID: <20250811231107.GA2328988.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-27-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-27-pasha.tatashin@soleen.com>

On 2025-08-07 01:44:32, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> @@ -3123,7 +3123,9 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = flags & VM_NORESERVE;
> +	info->flags = 0;

This is not needed as the 'info' is being set to 0 just above
spin_lock_init.

> +	if (flags & VM_NORESERVE)
> +		info->flags |= SHMEM_F_NORESERVE;

As info->flags will be 0, this can be just direct assignment '='.

>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -5862,8 +5864,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -			loff_t size, unsigned long flags, unsigned int i_flags)
> +				       loff_t size, unsigned long vm_flags,
> +				       unsigned int i_flags)

Nit: Might be just my editor, but this alignment seems off.

>  {
> +	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5880,7 +5884,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, flags);
> +				S_IFREG | S_IRWXUGO, 0, vm_flags);
>  	if (IS_ERR(inode)) {
>  		shmem_unacct_size(flags, size);
>  		return ERR_CAST(inode);
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

