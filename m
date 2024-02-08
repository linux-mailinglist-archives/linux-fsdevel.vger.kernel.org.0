Return-Path: <linux-fsdevel+bounces-10718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D263284D89C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751171F21BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E2364DB;
	Thu,  8 Feb 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xr1Hy5o/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E52D620
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362328; cv=none; b=XkBD2QMDH1rOnlkQ+W9vWTY3NXwiyRhmX9Wh1COtKFxdxHK1ED4vI2W1LREUtznL2ZAab4NM/5wLWMPpA74fms+r5cI96iWH5SSqFU16D05JsScgHdgCEOKUppKBMnu6ztCfsy833EQ2l4V/Jj3Qw513jESvwWk/ZJGdbT/J8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362328; c=relaxed/simple;
	bh=QBP1d2INSJJ5CT9OSZezCK5o0sFnfjm4zPqF0UwXyPQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=XJqEklaVg888VX4jMvjmhJ2CWMHlWAKs9HM8T1EfA2X00TB5YclLgY4BgbP0b9bZweNrkqvqubQJomVK6NFGFCGIXi0x/x+tyFWXCXRMzbVLZFd6HIn7a2DYo7qJ8hSwt20j3Et5XMTCZgwDKSazJpzfE9qJLcXEYFb8HPr39+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xr1Hy5o/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6818f3cf006so6301276d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362323; x=1707967123; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9NeCOLMO8D+Li8NPC6OAfEyheiTPtPHuLj+MlZ5sS28=;
        b=Xr1Hy5o/HWC5bodVXx128sJc7lJpmuUvLstqpCCc+A9jOJCeYy/r6/a4f9Fkp31rzH
         n4S9rSMiXj+ZlXLK2SN3H+EBhOfaW+229RbOIztedCYqFn4bj8J8QJDneJWFepgupMJs
         Xa1qJLUMvLP9tt03iRMZwsY3ZVyO7bI22FeluRcl2A1wPPiM+EdKzWsTjFv0BCF+udgC
         45tzIA2EuAWm5kR0ZwreDnNCPZnKMd0oElMv+1dmGPqrvZ14mLSIQH7dTBU9gnXZw9UC
         Cy/IndDxARtBfnZGG2eviAQl0mClYl/7kFCquHl24BKqmWXC4gfoGOR6fEoIF11ufTyF
         Uw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362323; x=1707967123;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NeCOLMO8D+Li8NPC6OAfEyheiTPtPHuLj+MlZ5sS28=;
        b=pYdzFR9Wua2Sdr7zTF3cvwBHbmf9KMP30+uhABF8a1C421CYzHMfRbCpDyDAZ305Sd
         3mn/WhIzuI0IA+QkqrTjpVKLPl489koVHKPVVzw/TsbW/QljSk8MBRG4Zsa0vFQR6lzV
         0CobMbjtV/0vM69Hb4HhiebWgk90lZtoZFaibq1MNAr6/QJhphiReNWD1fBBCz2UNOOC
         oBwSmJsZfpmVJpQ80Us4pQwvw8y98uzbPG8YeLO8KQYi5u2hLDIJKZCoDr6tc0W8bx6j
         LRql0b5f1ehuXr8KC69+Qon6ivpLGCn79YgWwty1xoJ3BpjpKx4x86T5MMBCfMbS30E3
         Fd3g==
X-Gm-Message-State: AOJu0Ywq2Cx5tUqMEwHZGd79AEWVyu5cIL3iZ4xfQ0mMc83qJM4nSjFy
	qcWbRT6D4hUm5+1dtohgoUtAY4EMAkwdXzfhVIkSVxeVtOEHfG9gFu0hvOy3tw==
X-Google-Smtp-Source: AGHT+IFW55PcPigyWcFJg+e8rzV3gyC2TliXUMzhBbz5g4ss6B2Yc5DWLZgXrjPgR99INOvaHAZX9Q==
X-Received: by 2002:a0c:8f1a:0:b0:68c:71d7:293b with SMTP id z26-20020a0c8f1a000000b0068c71d7293bmr5353842qvd.44.1707362323236;
        Wed, 07 Feb 2024 19:18:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYEqcz9JrBKdJctK6bEEzohG6WCY21Aj9JvhoHplqCM0z8a347REEjaeIk+wf8KfGiYxa6ouB7q8hYdpGF0E5jQtdD2aGGcnfBMu5uh0vhGOEZyYYuo5pbhbK6GcWClz2Qj9WFfcMC12XIoBFsGZL1xi3RNwiuQYkoCm7wI3mv6wV6yxmh0VK65WQEZXYFc6louGJ+I8KBeW7NQ+YWEoL8f5I5rg9UPEmkIHYtGqIRD1SqnZQW52jqmaAkm6VCjLpLSwdKEfvnhLTc1cUlUaL33HEeTK5CKd+0KfB55w7vOWLKL0mLINlCZqO+eC6MMwWmYVY65qJob0mCqALqwjjsSUJIIOKhvUTuIhspJ6LdbTkQhij+e6SiQKKYKv9CZ3sstnyHaMnVJqPFmU/UKda5HiYZ4VWm7A7V+hwwyFE03T58PFBVGkxrSIqIfUVVgVUGFMuVhorkUWL3NPEj0RWLDh7pR48MyZEeGwSEBuxt+e8m2iYHug3olk7ntinGmUoBDkSeOplCIgNNxNgGfqp3xXe0dV3BGX0XsH2A+p5DeqMLCxKo62JgZPLOOaH8ie26mnsu0E3CUZToHDMiH6khoau1QaM9BPcH9GOz8BMFFoBwB1g5xbtMhPWd9mf8F8E6QBYx9uTQzls7gic4tsp5bB9ScFw1AwLgohfQtER9gHqon/xCc5juRj8vbB4IHH5w58XgU0qGXocVblrNzc+gfnT5SMZJ8zg8actKuyQzIrcd8nK3yenkgcM0tNxONvXT4+fmQByf83Ecab9vHG9OJMh0ilXRsPOkbBryt6bJnLnShJpqbY8umfrrR5BbcGWyjGon0ukcaW6i+CSV+NTctQSJX30vGiPFq8Q3xyD3dHH4szAKAJOQp5GRlh/O5EFiCeKPZ/U88SheqaLSIrQAh1An9+5HMjE9CbtYbIMrjWZZyZwoDLIwDSkldf9T00uHx9
 0yUyhnwvtY39M=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pz3-20020ad45503000000b0068cb4ed4840sm1179193qvb.62.2024.02.07.19.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:42 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:42 -0500
Message-ID: <a2ad49e279b2904385064e4d0f65f0ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 11/25] security: Introduce inode_post_removexattr hook
References: <20240115181809.885385-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-12-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_removexattr hook.
> 
> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> xattr removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful xattr removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

