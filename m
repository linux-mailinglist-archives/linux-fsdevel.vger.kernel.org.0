Return-Path: <linux-fsdevel+bounces-70462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18196C9BFD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E13A2E17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDB26CE22;
	Tue,  2 Dec 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maven.pl header.i=@maven.pl header.b="J3HPtnLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799C266568
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689872; cv=none; b=FlNvUm/b+qmJYD0bfLKm9qeoqQm/omCKKfjb1dHpULoro3DOJphN+caJLcTjbSN8EeswXMX5BJqz0+tK8HoHLULDaqg647OtbDjuU8BCgZGqqfK/wI0I6z+Q0RWBdCE9t6ZUxIESMqGY5C+7m88U9P8/u8JPiP83Uv6ygGqUqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689872; c=relaxed/simple;
	bh=vpE5EoPl81OXEBoVcuuXCPpqAzZxp4nL17xE1XR1pcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oeNZfbJzOtQZkShs1/frxRv3ItlOuUhNGCnbB8pz585SULLzOTkzWGEx/E9T7sb9l6PHg0j/wIAQonjKJQN7I/KFLgQty+cL/1MgLXkZfniWLG7FO1ZID2VxO4hwoCutnb3Nf1nGzy3Rbv7VFz8cG4jvh4GCpgm+b0BVXRekSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maven.pl; spf=pass smtp.mailfrom=maven.pl; dkim=pass (1024-bit key) header.d=maven.pl header.i=@maven.pl header.b=J3HPtnLh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maven.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maven.pl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so8637049a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maven.pl; s=maven; t=1764689867; x=1765294667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ConuvD8daUO5TViY4uGMmoV/CoG7J3iCApA22ZT8ug4=;
        b=J3HPtnLhD8dZ1NxPGy1zcba2ZrsPjGuIJJKgafRKoQG+qxKemdC8lFY0th8L59ntdb
         V5KZiqL2h1qLej8hT9Y+em7byAnTKDt6c09WMJjdnQP61mCVX+YTn6zkZkuYJKloRZCp
         fr2+JKS06wKPYXiu5dPlzUX9tWAnmO98pYkn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689867; x=1765294667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ConuvD8daUO5TViY4uGMmoV/CoG7J3iCApA22ZT8ug4=;
        b=paISrVbrHjb58rXPAow7OU/PmN88BR2pisinJQe6gEjaEAUHnbDWJdAQv3eTStAPA8
         R0RQoO0vv2xp/IShEFKtyGpnD+M7Z04aKOyJ/JmHDbvxDHmiMEmc2WiuZM+1oTj6Qyhd
         AILoZsaxo9uP8nA0XaJjCAPYuNmtGHwrv+QjhwoIdV/viIACHDagRIKq1H+guvgU7p04
         8mPV5gVkAUBKExfEkV3XGBRZ6PtxzjgnR0qwzYh3QiBqgeRHnqgiPG+daKPH/k65z2g+
         LW4qErTkOthz7++dJc/hGSmuDXJ4/Y7Mq9fHzU8QVkUus4O0Hckke1bx/VgxW7Fvxd6R
         +ZDg==
X-Forwarded-Encrypted: i=1; AJvYcCWSL9v8faCy2fVBP5KMKT/jzv8gk0SiYrNZwThUHMhjK8fPq5SFJ6dniRax/SyklvGBDMH7pPK2+3WuNxmO@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdIo8bvBmKNT5uKmUyWpHnRhxZFzS14goBT/KNiTYmL42wNme
	VNVdTaMlaLbe1An4zmzZho4h/2D0vRjO2Iz2rY0UsxraEwTU4v8izGinwzEpvEfQkyo=
X-Gm-Gg: ASbGncvIbmxXgDnS9vl0aoP7pYMn1G62giBodKn15hY/BpajA/009qyvd79VCc79EGi
	PRuT8fjy3BkfBSoXR0A85qGdtn+aW6YBLbgfODx5mHBKUtk1I/O1Uh9D+QuTKxJAkc5u2E+zUNG
	ip98jNEdjVyuEzCPnBuM5QQclCu7r1scZRvnRTQ861uCPkRqe9IpMwz2qyvctKMI2+A+9PKeqy0
	vHL37vmgutGiAahzz0+8yn/PxoV02swXCigDN2W4YyYQOkMSUiELhk94E36rQDOoeWDRi0h19Fb
	MxHqrQBBVb0uQVfzY0vjK/ULwvf2LxUpqwX8t2ggG+2LtrIsAyE2O1ggC+VuCXFtvyITDBFfVle
	zn2/IU2qBqnNa6PnkBwGjaZOdfTEBvWI5NCvChim21YYbGidTwz4POS58RD5yICm1X8OTDjzJI6
	xj++nT0t2yp59+W85ueB/FLJ1MXMRkFxcNwC9hu58VeiO0nZgdXzdwxjKVtkmglPB/QKuIkpyx
X-Google-Smtp-Source: AGHT+IG9aOwXWKF1qA+hOvaDs1nJOECV5tbhMVAg0A7LAbBljmK4RosPZQYagf6VaHBxq+UnR/4QJw==
X-Received: by 2002:a05:6402:42ca:b0:640:b373:205e with SMTP id 4fb4d7f45d1cf-64554469ef2mr44474663a12.15.1764689867185;
        Tue, 02 Dec 2025 07:37:47 -0800 (PST)
Received: from [192.168.68.100] (user-188-33-10-15.play-internet.pl. [188.33.10.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510508e1sm15924208a12.27.2025.12.02.07.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 07:37:46 -0800 (PST)
Message-ID: <905377ba-b2cb-4ca7-bf41-3d3382b48e1d@maven.pl>
Date: Tue, 2 Dec 2025 16:37:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] libfrog: add wrappers for
 file_getattr/file_setattr syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>, aalbersh@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
 <20250827-xattrat-syscall-v2-1-82a2d2d5865b@kernel.org>
Content-Language: en-US, pl
From: =?UTF-8?Q?Arkadiusz_Mi=C5=9Bkiewicz?= <arekm@maven.pl>
In-Reply-To: <20250827-xattrat-syscall-v2-1-82a2d2d5865b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/08/2025 17:15, Andrey Albershteyn wrote:

Hello.

> +int
> +xfrog_file_setattr(
> +	const int		dfd,
> +	const char		*path,
> +	const struct stat	*stat,
> +	struct file_attr	*fa,
> +	const unsigned int	at_flags)
> +{
> +	int			error;
> +	int			fd;
> +	struct fsxattr		fsxa;
> +
> +#ifdef HAVE_FILE_ATTR
> +	error = syscall(__NR_file_setattr, dfd, path, fa,
> +			sizeof(struct file_attr), at_flags);
> +	if (error && errno != ENOSYS)
> +		return error;
> +
> +	if (!error)
> +		return error;
> +#endif
> +
> +	if (SPECIAL_FILE(stat->st_mode)) {
> +		errno = EOPNOTSUPP;
> +		return -1;
> +	}
> +
> +	fd = open(path, O_RDONLY|O_NOCTTY);
> +	if (fd == -1)
> +		return fd;
> +
> +	file_attr_to_fsxattr(fa, &fsxa);
> +
> +	error = ioctl(fd, FS_IOC_FSSETXATTR, fa);

&fsxa should be passed here.

xfsprogs 6.17.0 has broken project quota due to that

# LC_ALL=C /usr/sbin/xfs_quota -x -c "project -s -p /home/xxx 389701" /home
Setting up project 389701 (path /home/xxx)...
xfs_quota: cannot set project on /home/xxx: Invalid argument
Processed 1 (/etc/projects and cmdline) paths for project 389701 with 
recursion depth infinite (-1).


ioctl(5, FS_IOC_FSSETXATTR, 
{fsx_xflags=FS_XFLAG_PROJINHERIT|FS_XFLAG_HASATTR, fsx_extsize=0, 
fsx_projid=0, fsx_cowextsize=389701}) = -1 EINVAL (Invalid argument)


diff --git a/libfrog/file_attr.c b/libfrog/file_attr.c
index c2cbcb4e..6801c545 100644
--- a/libfrog/file_attr.c
+++ b/libfrog/file_attr.c
@@ -114,7 +114,7 @@ xfrog_file_setattr(

         file_attr_to_fsxattr(fa, &fsxa);

-       error = ioctl(fd, FS_IOC_FSSETXATTR, fa);
+       error = ioctl(fd, FS_IOC_FSSETXATTR, &fsxa);
         close(fd);

         return error;

fixes it (confirmed here)

> +	close(fd);
> +
> +	return error;
> +}
-- 
Arkadiusz Miśkiewicz, arekm / ( maven.pl | pld-linux.org )

