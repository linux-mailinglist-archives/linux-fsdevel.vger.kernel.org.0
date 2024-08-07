Return-Path: <linux-fsdevel+bounces-25247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8994A461
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF5F1F24C53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A871D1736;
	Wed,  7 Aug 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6WPKU0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BE1C9DF1;
	Wed,  7 Aug 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023226; cv=none; b=UzFYJ5xBx9a9sDr3X3jT68LkQTwVy8NdD6Y2GmPbat8miLg5JfSbxISLBw/hazgi4v2eiG9M9jptXDdndg95TWkDUoavXKCYL+qWAa6vbV4cG63UpS26Q6kkamxqcwMxwrOopWQUugl6dZYVLh1JCdiX130RE271Hs1YGK6m758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023226; c=relaxed/simple;
	bh=Lcy3Vr1bFcZkfnbijh9rirzo29S7Cm4XIgbOqJ7yKi8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opYF2fBnbww4jXw4v2OAE/qwSAsWwi1q9EQvWuRBNKMc+1u+klfmbvpBOGRS4V5M4xNI9gx95YvOFiFEf9D8AjMSIttrAmxpXMpesRhP9KIOdyj65PrldD/bUVaHXkP3lZvw3k0UtXjZiB2hmbnqxOShFmG8WFS2j6qjARGWqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6WPKU0P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so193660766b.1;
        Wed, 07 Aug 2024 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723023223; x=1723628023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xN5pL0uP1l7Ckql8FJK/sLQyb9fYS/IBXDPG22XPl8=;
        b=B6WPKU0P01XXJZ8TMf1+5pTA21t0hrpCt3Esg/Fc0ykTwMRvCpEdcjRoxuWhfl0lwa
         bwUlJlI4lDw/FnatxYbOjoddSjupBg8HqhuLPt6jADCgHp484vGw6FCwQ9Bbzf+WB5ai
         2zzT1Rftbgf2P/RxeQ0rpsJrE2IYcKvttKhBnWATE81Is/MUDTsdUFF7nwluNkLHyHZD
         GOgZ1egZh+Opz3QK4o1Kr8ky+QI4L8/tP7qVh+7r3cRmU/mj7k4s8vZwmq7zPxKSPEC2
         HqpWK8q4vWXBci6pmEqz6TC4bO5bIj4Td3OZxYaTEQ3A6aGggaBJkpWCtsIDNjehWhAE
         Yj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723023223; x=1723628023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xN5pL0uP1l7Ckql8FJK/sLQyb9fYS/IBXDPG22XPl8=;
        b=v2YUcj8WVLlI1qR6SMd9Dr3ab3RHyhPGhpZK5MK9H+/glMGdosN7amMXRDqHyshN5F
         FD/vWkQKhG5vzDk3WmI8lS+O2TTEUFLunNkdBXsaIUoiqesRbuXgkMIBj6j8EN7L6KoP
         k5C9P59Etqw7l97oXpBwJTPaPPZJuyUyjdMzoU7dniYvKQdku8ZVesdoEMSjlQQikJgn
         9E6v/aSuJT9EGcjUv8FKjKVbx0wv0SKfdxKIY6BYJm6xbss10WBjC+OIye6yxWFgMz3J
         OKF9lXZmRQTl37wJOFza1JthzBeYoBD/dJcgbR3TUoH0wiA8WMe/7YOnwbFJMufDdCMW
         RPMw==
X-Forwarded-Encrypted: i=1; AJvYcCWcDLLbYoxnIh/vDQCJbT3qceKGrBRtRcNF3epZCMGIXqID+ZUh2zuozerDJW485zE9ZJUs8FqfsFDnNnLa3HaWLZz2yAZxeJSODDcEAP+6cR5pX0Jtrn5oV5hitJvwBTjYqxA0gCZ3Jh951w==
X-Gm-Message-State: AOJu0Yzh6za7YApjbB5ZrUu+1k8hkTpoxsshqkQrn0L4NI5DE2kMB9Pe
	BB5AhB0QTmNcP3Ks8sxTMq+IEak1fu46DYf88PAewfCDtlog6gjx
X-Google-Smtp-Source: AGHT+IHwMCxPPn0mYd17V//cYXvGR5qWTv+tKG9E0RlsV/Os/+SrVNgNV6QqosoSYcocuvkqfVyD8w==
X-Received: by 2002:a17:907:94cc:b0:a7a:cc10:667c with SMTP id a640c23a62f3a-a7dc4e563e4mr1342435666b.16.1723023222635;
        Wed, 07 Aug 2024 02:33:42 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8067efcf0fsm135494566b.145.2024.08.07.02.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:33:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Aug 2024 11:33:40 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	liamwisehart@meta.com, lltang@meta.com, shankaran@meta.com
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <ZrM_dOOcdbC7sMTV@krava>
References: <20240806230904.71194-1-song@kernel.org>
 <20240806230904.71194-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806230904.71194-4-song@kernel.org>

On Tue, Aug 06, 2024 at 04:09:04PM -0700, Song Liu wrote:
> Add test for bpf_get_dentry_xattr on hook security_inode_getxattr.
> Verify that the kfunc can read the xattr. Also test failing getxattr
> from user space by returning non-zero from the LSM bpf program.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |  9 +++++
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++++-
>  .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++++++++++---
>  3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index 3b6675ab4086..efed458a3c0a 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -78,4 +78,13 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>  
>  extern bool bpf_session_is_return(void) __ksym __weak;
>  extern __u64 *bpf_session_cookie(void) __ksym __weak;
> +
> +struct dentry;
> +/* Description
> + *  Returns xattr of a dentry
> + * Returns__bpf_kfunc

nit, extra '__bpf_kfunc' suffix?

jirka

> + *  Error code
> + */
> +extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
> +			      struct bpf_dynptr *value_ptr) __ksym __weak;
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> index 37056ba73847..5a0b51157451 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> @@ -16,6 +16,7 @@ static void test_xattr(void)
>  {
>  	struct test_get_xattr *skel = NULL;
>  	int fd = -1, err;
> +	int v[32];
>  
>  	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
>  	if (!ASSERT_GE(fd, 0, "create_file"))
> @@ -50,7 +51,13 @@ static void test_xattr(void)
>  	if (!ASSERT_GE(fd, 0, "open_file"))
>  		goto out;
>  
> -	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
> +	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
> +
> +	/* Trigger security_inode_getxattr */
> +	err = getxattr(testfile, "user.kfuncs", v, sizeof(v));
> +	ASSERT_EQ(err, -1, "getxattr_return");
> +	ASSERT_EQ(errno, EINVAL, "getxattr_errno");
> +	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
>  
>  out:
>  	close(fd);
> diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> index 7eb2a4e5a3e5..66e737720f7c 100644
> --- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>  
>  #include "vmlinux.h"
> +#include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_kfuncs.h"
> @@ -9,10 +10,12 @@
>  char _license[] SEC("license") = "GPL";
>  
>  __u32 monitored_pid;
> -__u32 found_xattr;
> +__u32 found_xattr_from_file;
> +__u32 found_xattr_from_dentry;
>  
>  static const char expected_value[] = "hello";
> -char value[32];
> +char value1[32];
> +char value2[32];
>  
>  SEC("lsm.s/file_open")
>  int BPF_PROG(test_file_open, struct file *f)
> @@ -25,13 +28,37 @@ int BPF_PROG(test_file_open, struct file *f)
>  	if (pid != monitored_pid)
>  		return 0;
>  
> -	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> +	bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
>  
>  	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
>  	if (ret != sizeof(expected_value))
>  		return 0;
> -	if (bpf_strncmp(value, ret, expected_value))
> +	if (bpf_strncmp(value1, ret, expected_value))
>  		return 0;
> -	found_xattr = 1;
> +	found_xattr_from_file = 1;
>  	return 0;
>  }
> +
> +SEC("lsm.s/inode_getxattr")
> +int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
> +{
> +	struct bpf_dynptr value_ptr;
> +	__u32 pid;
> +	int ret;
> +
> +	pid = bpf_get_current_pid_tgid() >> 32;
> +	if (pid != monitored_pid)
> +		return 0;
> +
> +	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
> +
> +	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
> +	if (ret != sizeof(expected_value))
> +		return 0;
> +	if (bpf_strncmp(value2, ret, expected_value))
> +		return 0;
> +	found_xattr_from_dentry = 1;
> +
> +	/* return non-zero to fail getxattr from user space */
> +	return -EINVAL;
> +}
> -- 
> 2.43.5
> 
> 

