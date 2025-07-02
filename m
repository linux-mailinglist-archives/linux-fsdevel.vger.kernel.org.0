Return-Path: <linux-fsdevel+bounces-53625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F27AF124A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836141C400E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DF25A2A2;
	Wed,  2 Jul 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpDcCa9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F91246BB9
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453284; cv=none; b=lzt2ZA7RzDkCpIifRYbd8IpJf3O/HzVMybNfTOzBRD5qW3UCjiHaXLrkASaHezsGeKps+O81dC9jtZ4EHeqfiYpAAQXXKzGXhhJUvryvpoc3tNTZQuO/0T+U8Sh00UOG0ft8IiXC4fCwbdvDVxuxF02ase/lXeMENivMKfNNktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453284; c=relaxed/simple;
	bh=x0AFjkDlvAQocIajLTiEtOk7pDjdbIyb5Vl8YoFPFC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0rRDINP99NjQOjqEMEJ8/F+wbviKnCZWrEBEDaY57ZsbEuZs8woG0WAVYzkaL4oeOx4Es4ffa9SnwkWCf0LkXAxvWZvP13GKEs790hN8y+GVNkfhJEmX/AETu1x30+Haqdkcnb7+GSPKw6iMZComUbylMdadvHakeniRoQgiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpDcCa9s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a528243636so4190385f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751453280; x=1752058080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZaqLaJib84m+unN67Qm6MiaO9gj1dwxDqxkPHoKHM38=;
        b=VpDcCa9smd/NR8ALKfvOcaR+JRJyPiTN1XWd7ed1bal/ZCgDN5rOUi1ONMr7O792h3
         MYq5MoHmfGGRDa22ksaY6CxDQ9cyWL7ECvzjUt6kVa0Rkjje3sCFlTgVdh3tQ67tCnAu
         wxnjGwBgLkSXEx8ZboMiH0kHW6tFYlERP90oyb4+h7EKFgxE06WkG7ReMFt+P0YSWsnl
         r0qDxw9hKNGfpApVS9pQYKfx98MZ0EdzJuURrGvEfNJf0BvomHi9zYDay1AwReZU7JjB
         5O+fyB0Ty8rLaEzz3KBMmxN3gKEOI/ZMke8WnkdNTjSRXIWJL+NG3V0mE+jJrfA/avVV
         UrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751453280; x=1752058080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaqLaJib84m+unN67Qm6MiaO9gj1dwxDqxkPHoKHM38=;
        b=MlBFB9VWduFPzcFc+Nbj+uZhw7OE3H8us3Jn75iokq54LfzZNrdzgV1H5SNvSfpVhR
         iT7j3rPoyweCgFMemJaDK8TLnsoezGVhDsAzh+hv9rFmumASenO30EWxgiGi9BW9kUct
         YCND+VVq+Enq/W1/55Bxy5245Hx4Y03K9ZtijRtnoBiB+leHMAcx72Qt7Vkq00aIS12m
         y1HRvFRnfXy0iKqLuWQ3+fxMbuDRwpeQFg3/jGcZH9XheywqRum7pebsXWzNooD8GX8k
         5gVMZ0GFYGeFSElTyuRNXlX26Q9NCyVDZVCHjYHesNAVxFfsUC5OcDtgdr1tmcAjjc19
         xm3A==
X-Forwarded-Encrypted: i=1; AJvYcCXFKbbPKhL8KrcV4ta9QK4Zn5CSd1x/JcYhZ7ePyW9hoo9I2uF2fpR42AewXYB9s1AXzfxmuSqhv+NzDfxR@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzoC3CBcKX2oHSrgALPTI0tKZN8A2A+smjw8c8CuYSgpl+Ytn
	DR4Y6z4cyPrdgcdjBN302yyjfMpLMpaNcHHdBTID8c7+6Ga2WNLPc5bFXk4kvnm17Ug=
X-Gm-Gg: ASbGnctTZ8vNd1D2vVLlr2bIs9qTEO1QuC8zB/SoGLQpNaWnWIaEtSH3ymiktW1RjWQ
	6dg7c3jKOsHS7MeRxjHcTMgfwUgGESLnBVQbrtxgKQAlv46NmxrZij1uOUSZHUO6NtKBi0fXqIV
	KYrn4sgHQls2M/xQZMTn0ymy5pdw+RIheEbpeFsd+PQn5s6ZCDNCkfoZug98uOVlskdF+9teFok
	3Xx76epDrdsMiLwZzjo/LcUldHuu90Q80NJI9inOWiZz/C5FPCXj3I6W0FPqc/52PzlbKRiYcQR
	N42lG5E0m+WL1L89VFMsFIZglKr7iL4Z5fJNCQR57ndQW7MQT2ptnseYHqWO8qm4gHl7htDV4Bw
	s
X-Google-Smtp-Source: AGHT+IFDoHf+aaq4UzigGUWl+x39S/WR6MN+OvN18dQGCVdn/JrZS6PzX26KE9GWmWHItZgUMtOHpw==
X-Received: by 2002:a05:6000:4718:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3b200e2a0e3mr1859101f8f.52.1751453280453;
        Wed, 02 Jul 2025 03:48:00 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8a0sm15970228f8f.96.2025.07.02.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:47:59 -0700 (PDT)
Message-ID: <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk, 	brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com, 	amir73il@gmail.com,
 gregkh@linuxfoundation.org, tj@kernel.org, 	daan.j.demeyer@gmail.com, Will
 McVicker <willmcvicker@google.com>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	kernel-team@android.com
Date: Wed, 02 Jul 2025 11:47:58 +0100
In-Reply-To: <20250623063854.1896364-2-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
	 <20250623063854.1896364-2-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sun, 2025-06-22 at 23:38 -0700, Song Liu wrote:
> From: Christian Brauner <brauner@kernel.org>
>=20
> All allocations of struct kernfs_iattrs are serialized through a global
> mutex. Simply do a racy allocation and let the first one win. I bet most
> callers are under inode->i_rwsem anyway and it wouldn't be needed but
> let's not require that.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

On next-20250701, ls -lA gives errors on /sys:

$ ls -lA /sys/
ls: /sys/: No data available
ls: /sys/kernel: No data available
ls: /sys/power: No data available
ls: /sys/class: No data available
ls: /sys/devices: No data available
ls: /sys/dev: No data available
ls: /sys/hypervisor: No data available
ls: /sys/fs: No data available
ls: /sys/bus: No data available
ls: /sys/firmware: No data available
ls: /sys/block: No data available
ls: /sys/module: No data available
total 0
drwxr-xr-x   2 root root 0 Jan  1  1970 block
drwxr-xr-x  52 root root 0 Jan  1  1970 bus
drwxr-xr-x  88 root root 0 Jan  1  1970 class
drwxr-xr-x   4 root root 0 Jan  1  1970 dev
drwxr-xr-x  11 root root 0 Jan  1  1970 devices
drwxr-xr-x   3 root root 0 Jan  1  1970 firmware
drwxr-xr-x  10 root root 0 Jan  1  1970 fs
drwxr-xr-x   2 root root 0 Jul  2 09:43 hypervisor
drwxr-xr-x  14 root root 0 Jan  1  1970 kernel
drwxr-xr-x 251 root root 0 Jan  1  1970 module
drwxr-xr-x   3 root root 0 Jul  2 09:43 power


and my bisect is pointing to this commit. Simply reverting it also fixes
the errors.


Do you have any suggestions?


Cheers,
Andre'

