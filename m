Return-Path: <linux-fsdevel+bounces-10728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4F84D8E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EBAB2451F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67B43CF46;
	Thu,  8 Feb 2024 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MEZRjnfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D325770
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362338; cv=none; b=stJm6Lu9I3LL0o56jW2ht8PQS+3Ip+a1kLBR5l2yeJb96PZpaGpzVMgqJDHQreeei30cM1lINRdVbgsN76hM1vjzKY3vfknpz9k3BKnAK3RS2gWEQdUmKh1meNKUSeo2v6KeI6RLOoNFMHvFmOYeFxelCirXHmSMel/RS3D9UpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362338; c=relaxed/simple;
	bh=QxXYto16RKwpKe0WAuqyyFSv8bZEk+rYAhFfJZDWHpc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ekewaV3TTkcOC+VeRZ0Ll6tGutowMpgu/mskZKmqIL2/wavkBX6/Vqc9kpkoPqU7h7I7DvMQKcA/lfulg5RULsi+zugatT1MiKb9bGuIxeWeiU8GmfM8rYur5XvKa+rFlr/svzPX37a3jHycTrgjzvLyDocFwwqcWsNrptvwkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MEZRjnfC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818f3cf006so6301756d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362331; x=1707967131; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7jlGv8JHUSR10sS3dfCJsrgR+VqC9NQSIZQ6VcWAY+8=;
        b=MEZRjnfCzlNL1kxcTjyVoRyMIz7o3KzC5/e53Ha+GSsH2L7wfAjXQNocGT6106lLik
         DxWhr+cpIUfMub7P6whw+/YZrAGS9XmHG8OclvqoFLP7J6YAVmM74HayHuhIuWURtRTl
         cXXKowO0eMnF3SMIJGfHm5lmGKEWgGmWQ7uIoo8Efl2xWd/Ii+D+hXMjjGFrggZ/iZO2
         g4yaGFsyRY0k4cbtEf8/0o+rCvCOs+GVcp41sE8mm6AMqZQlKQgHh2nEG5yWS9yHuIhw
         LE3CScm9hAx5qLy1uIaUbWGqohN09i2UWt/tLXCs8jfgh+Tjfw+cloL1acBdkAGQPE2F
         lXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362331; x=1707967131;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jlGv8JHUSR10sS3dfCJsrgR+VqC9NQSIZQ6VcWAY+8=;
        b=k7CmevQQVs8Up8DFmLk916hxrp0tKwYpoENxuMYiW0qKkOBWkGgAerbXupQwK/gnBu
         nPHfD4lk+WYD8nduDZWDMSih5VvnsNiGbzs+5hEiqZGLNdi8CjEVrLr2+XFyioVHhPDh
         jXT/UxrwJ10JK8MJpnoS5yqxVsN37jHySb13SdxBAHJeDIw9D/5YPacvKCN1FGDarREd
         UYJggHBSU0/v9oKAIMTffNCQTg5/tFueK6ZtRdEnlRCz2Omv0CseFrbPYgyl+fcUkMji
         TvZOG+VA9GpMQmYJAAN/uOu/HyhyrdltQPW+/umNoCoSvwahXxeMbPazfa8ycyAa4hbv
         P0gw==
X-Gm-Message-State: AOJu0Yyo2ycMe4mfr5bUjN0TNOdYgCycHWs30cvrcgDbLrN6fy5e2jYd
	VUw60LE/wDtGYk+5Qi7kPWaJgdJ5icwQAi4waZwKwjR9yfWdFWE+oC6o5Xzo3g==
X-Google-Smtp-Source: AGHT+IGGSLRZ//P7EVYtFYlcPCQ7WQ0ILmzzn7EukifdD7QAeQxZodCh/FoXul85fPk/+Aiu0La3VQ==
X-Received: by 2002:a0c:dd08:0:b0:68c:a6e2:d2e1 with SMTP id u8-20020a0cdd08000000b0068ca6e2d2e1mr6625187qvk.46.1707362331602;
        Wed, 07 Feb 2024 19:18:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXMo0UYophNRTNvt8tfg3/HdVHpjmGmQ9deqmf1QT63LWvT9XuJx4IN6kMOJQHpDxnE+SCJZihnmMuwpbfMdrFe1qIry7MoLQFoikl8h7+eoUpf0tXm0LzAFKRA1mlQyhEUfHznsAeKFZCWmKwrrRBtIb2pkjyYI6eL2vNxFc1VweebpAwHJcxTSvSmZ5PmBmx6zPfUtPKgKF4+H/VAX8cHRgRAWjvLDBYoREEajIQ694zSjS2B/PvhKlNVdWjy6zpBftKImqq4ZmTNrTPQHF9FADXzRkvV9LLJGoiJebz6aUfB6EaDxpG4xpZfQ3uKDO3QLssEmIwaavR61GyE+l+u/KUyB2mSjql2h+ArY966oAO4hQDSe3htEkkxUYxv1WbOsuSl7ueC6IfFF4aRitSWncPeJIZBif+95SS/0HjyE62Uc2vBfVdJ53vy0cJkvGjcsVPdFeMfodBemTrAbt6Pg7UbpOoz8/SYDI6yTV9QENb4t9Z+taGPZ0AtMGFwxcaeT3yR5cTpVZhn0COFFDnedFyn0cm4ALJTMTo+nj94EXf/1w9w81cM5Ntd3cGHlOgcK/iHzP7D7+C2L1sw8At+KciSyy6xpM24PONb3jMniSWcd6j/EUhsXb/LYWWOeIzxmADrVE6KZl+kf2S2URIvfRzz/hPmxgPv51zV2zoGLMcnwjQV3cRmcGeGeY7KoXuU+Q+vi5IX91HDFNFUQ4izsCzLrqeFzWz4tC7qa0u0HUVzXZoDlCgJcaNg6T60+5LUKFmjNQeIvzEvAxfAw1EUtQWwO/10mGohm4atXzXp7JQq/+V7J36s7weZF/OBdtucnJ0YqnjgqaBpBzKYzsRUyA+LyTVcDuQruFJrMkdvrMKuC744DjCud0pmJjahAnZgWHARp5WH099cN6lKiePaVe7kji+xCkGEFeOetSYC461b89f
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id oi8-20020a05621443c800b0068cc16f33c4sm835291qvb.80.2024.02.07.19.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:51 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:50 -0500
Message-ID: <1b538d1a73fd542c8463c398232091d5@paul-moore.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 19/25] integrity: Move integrity_kernel_module_request()  to IMA
References: <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-20-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for removing the 'integrity' LSM, move
> integrity_kernel_module_request() to IMA, and rename it to
> ima_kernel_module_request().
> 
> Compile it conditionally if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled,
> and call it from security.c (removed afterwards with the move of IMA to the
> LSM infrastructure).
> 
> Adding this hook cannot be avoided, since IMA has no control on the flags
> passed to crypto_alloc_sig() in public_key_verify_signature(), and thus
> cannot pass CRYPTO_NOLOAD, which solved the problem for EVM hashing with
> commit e2861fa71641 ("evm: Don't deadlock if a crypto algorithm is
> unavailable").
> 
> EVM alone does not need to implement this hook, first because there is no
> mutex to deadlock, and second because even if it had it, there should be a
> recursive call. However, since verification from EVM can be initiated only
> by setting inode metadata, deadlock would occur if modprobe would do the
> same while loading a kernel module (which is unlikely).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/ima.h                    | 10 +++++++++
>  include/linux/integrity.h              | 13 ------------
>  security/integrity/digsig_asymmetric.c | 23 --------------------
>  security/integrity/ima/ima_main.c      | 29 ++++++++++++++++++++++++++
>  security/security.c                    |  2 +-
>  5 files changed, 40 insertions(+), 37 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

