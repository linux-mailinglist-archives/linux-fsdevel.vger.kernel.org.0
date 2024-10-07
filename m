Return-Path: <linux-fsdevel+bounces-31151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6999274C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717A128404B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3A190073;
	Mon,  7 Oct 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsPJPInj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745E18DF89;
	Mon,  7 Oct 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290403; cv=none; b=MUTyQWtWUmyiEGR+D0pnfCocNZ7XZdGuHGw8NzFd2RWR8fOe/cbV2L21nm/LwrjUan+T7TqaXTHTQi7bNPAST6odSexW2J//MRH/4tpLsb32C41kEJsCkPdvOJTEibEDitZHwLH5cSJfKaoJ0/rq4ipccmHOeyceZP7BSmU14HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290403; c=relaxed/simple;
	bh=y5FEYFFIHvE+OCqQMvhFVSYMsNN+3wvjZzozee6pIVM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEB/0PBlcp43oB2IInIHd1id5IDG9zAxV584K389aB6g1rvJiY8OEF66mjdGSO2qGSzqCw5GEhQ+eVzlI8utV4pn4ntuWsoGPFswx22EYVc1L88PwabymNA1B0wsdME+aRlC3IdjEDT+C3nScfpGK84UewoAcYUKeBuoG2u7F2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsPJPInj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so55262525e9.3;
        Mon, 07 Oct 2024 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290400; x=1728895200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFCpSUURl8cQGnuaR/LZg2Sq4sT3YOyDevEk6aZ+0CI=;
        b=WsPJPInj94jRm8zaXDyit0n+YpcHvikft/MnuQ+N0gxOsJfrN52Li/Bu8DUQrg3s+x
         O7JIKmbl+TJAOI0b15pUc+hfHHI8hJdNfG7uFnwpIuNxDRyfV104ZgqPuAA8AofDi+32
         NPu9VkX9/6uiTdP6X+hSqDK1J9LNYNBUVCxSNNB6bUXwPMcY65cm+GsxL1NvLGVgdpFV
         M/N/Wh/kGi3JGNfTh2pXkBdwWGY2M7FajIlNp6H3XFKyyMcPXKGd7CemsePxRJnglKrr
         9cA+2rcBZBPEdS5hBYDQ222fnt1cLIsVERhWxUsCbUyYQNg4gvhss2V13lsegW+z8S3z
         jOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290400; x=1728895200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFCpSUURl8cQGnuaR/LZg2Sq4sT3YOyDevEk6aZ+0CI=;
        b=ausv7O7J65h2b/c72noGsWgORpH597adbR1/mskKDuvq9/tJxSxiqdjfjt143Mm4xa
         XEOgQgXz7hLtfGRWY9F/zkEMZMNj1aiKpqoP3G4wh/13L+fI8fvhwOHFsgpf1ixfPGZu
         LYTozT7wVnMFSXWl8rJIbLfUSdn03xCWSzD61vG4HNfmRTtpQmLoCzFheSxDww9YAFZ7
         wv7MiZX4idWPNpKE54L4WmlU3l+w0bN9tFcf5FG7lTjqWPxZ4uLmNBnRe1CNDRVy5AYZ
         8K0ENZ8+WEumP9gZFKb7ZLhnizaHdh824KXWF/X1vNzc6UZftN/LPfbS2ddC4Uh7G088
         6nng==
X-Forwarded-Encrypted: i=1; AJvYcCUQhp9X6V1AKZJRvR51bcZnA97XkWwvzRt+WQMCxRJuAZNPyLGZCbR6wx2MQjwPDNw+d7IBk5EPiAMxLmny@vger.kernel.org, AJvYcCVGUkhsUDrTZLVuDwTf/bTr9UN5rh7+1cCHJZfKU1nh0Plc2bInFRNaxK/S5kU0yfZaMWVtPRsi/xEDv+K+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3TE01yXDWlKyMtkgolKVTHDfdS/U30NI1JR6neD2D0G4W7MR
	Ky6IgEPIOCd1H9cyig1ho14aNI2duz3Bjj87uvYZIhbbg6pL6Ob6
X-Google-Smtp-Source: AGHT+IGInGtJqWnW05u2AHMjH5TDu4j93+BNuAKPDAEQaiDwPqjyMx/0P5X8FBMsNuQEOSIz8eNzLA==
X-Received: by 2002:a05:600c:4686:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42f85ae942cmr106177525e9.23.1728290399888;
        Mon, 07 Oct 2024 01:39:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e39aebsm68386985e9.0.2024.10.07.01.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:39:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Oct 2024 10:39:58 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr
 name prefix
Message-ID: <ZwOeXj9GGt7RdqsQ@krava>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002214637.3625277-2-song@kernel.org>

On Wed, Oct 02, 2024 at 02:46:36PM -0700, Song Liu wrote:
> Introduct new xattr name prefix security.bpf, and enable reading these
> xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr(). Note that
> "security.bpf" could be the name of the xattr or the prefix of the
> name. For example, both "security.bpf" and "security.bpf.xxx" are
> valid xattr name; while "security.bpfxxx" is not valid.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++++++-
>  include/uapi/linux/xattr.h |  4 ++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 3fe9f59ef867..339c4fef8f6e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -93,6 +93,23 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
>  	return len;
>  }
>  
> +static bool bpf_xattr_name_allowed(const char *name__str)
> +{
> +	/* Allow xattr names with user. prefix */
> +	if (!strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +		return true;
> +
> +	/* Allow security.bpf. prefix or just security.bpf */
> +	if (!strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN) &&
> +	    (name__str[XATTR_NAME_BPF_LSM_LEN] == '\0' ||
> +	     name__str[XATTR_NAME_BPF_LSM_LEN] == '.')) {
> +		return true;
> +	}
> +
> +	/* Disallow anything else */
> +	return false;
> +}
> +
>  /**
>   * bpf_get_dentry_xattr - get xattr of a dentry
>   * @dentry: dentry to get xattr from
> @@ -117,7 +134,7 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st

nit, I guess the comment for bpf_get_dentry_xattr function needs to be updated

 * For security reasons, only *name__str* with prefix "user." is allowed.

jirka

>  	if (WARN_ON(!inode))
>  		return -EINVAL;
>  
> -	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +	if (!bpf_xattr_name_allowed(name__str))
>  		return -EPERM;
>  
>  	value_len = __bpf_dynptr_size(value_ptr);
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 9463db2dfa9d..166ef2f1f1b3 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -76,6 +76,10 @@
>  #define XATTR_CAPS_SUFFIX "capability"
>  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
>  
> +#define XATTR_BPF_LSM_SUFFIX "bpf"
> +#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
> +#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
> +
>  #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
>  #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
>  #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
> -- 
> 2.43.5
> 
> 

