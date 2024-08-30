Return-Path: <linux-fsdevel+bounces-27998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F8965C8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A122872BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59EE170836;
	Fri, 30 Aug 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cifechxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2F4DA14
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009587; cv=none; b=l7VFTqUpHwkA4tdUgqFk4qOh93U8YjeOx3J1qr0kNTErl0WSehsZ3o4iPD3tyeJdGGsinezJupZAWM55lcfDLqOxDZmPpqXR5Z1vVys2D7PaTvVQJ1QjKGFjVG7vL4Zh64qIOEHbzb6OuGKWH6AQN5Lzy2WX8XFBYNPO2yiPG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009587; c=relaxed/simple;
	bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfotOrd2Ikbg9XbOJt7MSzTG0mZ0+f3ZmKyRT16/XekD3XkG2nyaJ4sdwTMDgpNOsnA1Y233kGGBz2HBCJNOKXrawxzkvQGWRX7gioWvTa8cV8LRZaAK2IR9yequ3a341x+p1JjJ0CK4U3ODwzn55seqJqkkPjq5Rp8H88oVnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cifechxc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8677ae5a35so171312966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725009583; x=1725614383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
        b=cifechxc8m11Udi9kFH+m4UaxNxQk0ZlYKWX1LBrbQLjeKjZno9c9EYzN1o2IyXI9h
         d/A43sgACjVaL89P+MMA6/WOCHKvk20ZsfU1Nl13VkZHCp9jJLJKl0oO5WMGd5KcsuV1
         1w7Gu40mwhe2Z07Ni+Kb9LXbxZWQzNV9Tm9n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009583; x=1725614383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
        b=cztPJ5z7X4aRsaK8X6May5t6INfepHvH+HWcyktRdhWYHfOdVLGGoRbkSTKLcWHrZR
         xuBdYZcjDXWMzQZZwILQ/7ev0u/8XwoZ6Lfmch/EExqq5ztKdppSwFwQydYQ7SWxEn92
         ZR8m7rnJs4m68Nyd0O8XRhd1ZBXi8g4152BzNIrKa0mx0cpACezG9rs70i/Mb3uCn1zc
         EequG9WZK44S0l++DV7/oLEhszEotQMSVhhEkTCndLeOqAyI0pV+Lr1pNssHduGbp0v8
         suH0IcADTfMs3ANDz1yjTj/i4WAC2Xyvm3lAHzbzili07Fh9tpnu74ZsEXSN4Y6r4Mld
         vx0g==
X-Forwarded-Encrypted: i=1; AJvYcCXcc1GO0w2DaokSZpf4jWvxTiFdZXeNcwFvAHekL/C9C5iU7z4m4ATSMr0EBqZvePUkKMAof9/vP3ewzuPA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JqWmp0CVbCHaVdQQ+ThGcwYd095APlh2tFYiKTd9rU5+Lstg
	y2Tjoyrig5VKilPCZDg1uYJaACjhlKBAIbQ4pLsEBrjEDgf/gsvLyVixAIM1TsJFHKskvxunCRQ
	1Zennf5zrYmWtFnVwxGpTc8MIf25CzqdyFihmaA==
X-Google-Smtp-Source: AGHT+IESVdlaSA97LQ9pHjyEMyjV5aoj65F1KCwOqpL5cnFNtljUt9oHYPUt5dDJC3S3UBR82X6iQiQufvuRt+IDsE8=
X-Received: by 2002:a17:907:1c9e:b0:a7a:9ece:ea5f with SMTP id
 a640c23a62f3a-a897f956730mr407074166b.41.1725009582857; Fri, 30 Aug 2024
 02:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824092553.730338-1-yangyun50@huawei.com>
In-Reply-To: <20240824092553.730338-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 11:19:31 +0200
Message-ID: <CAJfpegvsO6EQkAQOt9XRN_HqG-M3rYAd3-4+BeCFLu85350vxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add no forget support
To: yangyun <yangyun50@huawei.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 11:26, yangyun <yangyun50@huawei.com> wrote:
>
> FUSE_FORGET requests are not used in some cases (e.g., juicefs) but have
> an impact on the system. So add no forget support.

Applied, thanks.

Miklos

