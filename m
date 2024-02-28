Return-Path: <linux-fsdevel+bounces-13136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB186BAB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08A6B25EEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB521361D7;
	Wed, 28 Feb 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NklWdN2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB841361B8;
	Wed, 28 Feb 2024 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159009; cv=none; b=ES8IiwA77R4VstxqfJsIop/7RlamG18W+aUtcp027E1Pr1Pz3cLKkVERMF+5ojD9YOWpIt9mw/3sx2/6PbEVcPinuAJAH55Hor8UO++EtducyR4aIfiLkOOmO5GZzuCODQkaoaXGOlGXOfRYwexIfl2r2/eI9zRUmtlwfJ5S7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159009; c=relaxed/simple;
	bh=efAARcR7gFpwaoDBRFOeE7SvyonXSekFYYuK9/IJfAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSat+/jej1nMq9loSpphDKeKggXE0ZcE6dgFDxJ9hzbfuPjPnDAB8k1T95GvO04tV7YzXOX+1kpRdAwMJZLrlZ3hKqKdA5QZBMA+OP+gCuanky8k5X8pqE0Sc8BgFBTNssURewX+s9lbMXIpruSCIpH1FL/ivHuwdwUk6RIm/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NklWdN2u; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0da678302so161852eaf.0;
        Wed, 28 Feb 2024 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709159007; x=1709763807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqwfgf5Oxmdk/q9s8w3xjmRByoPtFa5KtuN8A69uJIE=;
        b=NklWdN2u/TCK+yPJovHA1ig39Ry2iRfqGaI8IFojVP0Q+k3e1t1d42EywuYB2c2cxg
         PLUsQGVZCVRVyud9yFqUN2DHCNdruAP9pBgpapqRCkRwTFi5a5C2Ka136TwErJoR+hCU
         OzkNJV6z3PguAwB/H5DwspUvEF75eNBgH1D03pgfSGeXtET9Tu32Tzgy0cGoHr55rs2z
         OZiQBbzaJhlXYVLsF4Ooo2CQCJtiftgaPUQtfG+BrFs070f4XyeUZlCvpbBiCrcVA0B1
         mQpl0W4ayABXT/nArEK8xQftqGhagiNQJCMiax/kI1wXlrwn5uZxfwpwPrNrav6GLV5E
         TYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159007; x=1709763807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hqwfgf5Oxmdk/q9s8w3xjmRByoPtFa5KtuN8A69uJIE=;
        b=WPWFS3se2cnqQpQlSshoFMZA8K6VZFWWxsRSt6M3OzGyfzltZ0oXSJPVYzEo9c6j3A
         nsAfSJhYDU9DWoRNCs/oC5tpx0IcW/OcyrzARhK79l81nsM85DfKVa+vZXPUFdLY1hIi
         j3akTXH6+BcYVRPQYc3Ux2i2cF1fmSgjTxnC9btYU5xhB4xVd7s5ceHEATNN6DJ55zPn
         MKo02eGMfdLIdJ97KUrhizJqBbovmKfvBndoc2DrHj2GxRBgSlMMjiyUUCGPa6XCjYh2
         JvreVih+v2sVpPi5Z1Fvv/0w5gM/uyTzQaE+XVEj6bwpGn4bZvvA9/ju1TiQzxzPRpZ2
         JuQw==
X-Forwarded-Encrypted: i=1; AJvYcCVuKUz7clIfS6UFaVePmNfzyAu09GYbhf0qA4h19tZEg7iJqjZ8PVsWmFtsvNGxYrqfyCRAHIRPBhxIQIKSNAy0StN95M+XfjwZNKzI5hJWx+lmA3/kKZhQH3+WQlbyzhfGM8X5SsfSa6gwPg==
X-Gm-Message-State: AOJu0YypFGFlWUCCiyNv58aIKjQucU2melxEVpLCnflpSlyGHqEEdwhG
	jzyrUOk9D/CPGMBnX0srU+2lGhxkeb1D9eVoI7P4CwT2LBhTLzda6knpRc6re016PNtJ4zqxTOB
	pWde59awkBVNVmBKVz0dzedQYXN8=
X-Google-Smtp-Source: AGHT+IEgO7bdA+0K92kgCyeW17cOUPxkEoTj0hyMJup6CuZLnUAJDI0zyamr20pz3eFYcj2nq3v1fbrN42DMo7oQ3Ss=
X-Received: by 2002:a4a:3c02:0:b0:5a0:993a:3839 with SMTP id
 d2-20020a4a3c02000000b005a0993a3839mr388209ooa.8.1709159006619; Wed, 28 Feb
 2024 14:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228214708.611460-1-arnd@kernel.org>
In-Reply-To: <20240228214708.611460-1-arnd@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 17:23:13 -0500
Message-ID: <CAJSP0QX6wowdwuSCz+a-2mBsp5KDUjSZeFJL82JuqsC0z6vhfg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: don't mark virtio_fs_sysfs_exit as __exit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Williams <dan.j.williams@intel.com>, Jane Chu <jane.chu@oracle.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Calling an __exit function from an __init function is not allowed
> and will result in undefined behavior when the code is built-in:
>
> WARNING: modpost: vmlinux: section mismatch in reference: virtio_fs_init+0x50 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit.text)
>
> Remove the incorrect annotation.
>
> Fixes: a8f62f50b4e4 ("virtiofs: export filesystem tags through sysfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Arnd. Please see the duplicate patch that Miklos applied:
https://lore.kernel.org/linux-fsdevel/CAJfpegsjcZ-dnZYft3B5GBGCntmDR6R1n8PM5YCLmW9FJy1DEw@mail.gmail.com/T/#t

Stefan

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 3a7dd48b534f..36d87dd3cb48 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1595,7 +1595,7 @@ static int __init virtio_fs_sysfs_init(void)
>         return 0;
>  }
>
> -static void __exit virtio_fs_sysfs_exit(void)
> +static void virtio_fs_sysfs_exit(void)
>  {
>         kset_unregister(virtio_fs_kset);
>         virtio_fs_kset = NULL;
> --
> 2.39.2
>
>

