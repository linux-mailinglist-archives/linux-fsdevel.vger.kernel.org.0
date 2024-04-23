Return-Path: <linux-fsdevel+bounces-17545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6C8AF6BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC53F1F228F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FDA13CA9A;
	Tue, 23 Apr 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoD9dZtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035512B77
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897714; cv=none; b=Ui+Y6HqxpSqMNj/nLbuoUyxW0WHvNnVW+cuBHme9wue2IpYCUvvQlV+ycjWSA9zzKwJJnWYKRh1UX7lucRfksSQZ/vhHDWXS+SuoUVG5qBXuiiYd8BI0iMx97Z0ktrAZ787Yek0any35jgpG/gWmJA4lYlKPQk4EAGvcWymXGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897714; c=relaxed/simple;
	bh=rkZmDBZZcJhVN6mPuWy4uMyeYcqDYd3E+rQp4e4pMmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOXmBm+RrOMfP7BcU18yHPJPlW5JrBk6rP7HfWgbIOBrwGhHjXVCmAqy77DH3Fp9bjIxiDrurCsVqfL6BdIMSsvEElPK9J0RtpDEBsP/iNOt7Q5JHyjkfLfTnDISVjkHyK2GK8tHSuqEBQ/xg9OREnd+jS8TA6gT2azcB6s/PZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoD9dZtM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6a04bb4f6d5so31124436d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713897712; x=1714502512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkZmDBZZcJhVN6mPuWy4uMyeYcqDYd3E+rQp4e4pMmA=;
        b=XoD9dZtMwMMVixUiVnpHJZlH3LD8HiDdgR+0rot1KyBoR0r3SQx1Rsaew/1AopEzgP
         iU5xD60PXMvyF6T6CxHv+wMs/sNXHXO7VpR7AhOYO2B1FlZNVHjsGGjda0iE5zySAwJr
         jJIHI9rArYIxGFDZzo6z9abIIqbGPZknPxZEsTVk0hmzKS4vyL2J8LOdTsQ38ESWu9gH
         u/2Bw7dUUAuy20Fxv7gxl7qG8ehGZaWbzHgmxAJVmU9EJ8+P9CV88+PmF2C6Z/rD4sUj
         jLTuqIDjej2yL4qC2WZLUZkJJh6YLVC3p8LWAGV/VTHFENRtKtgeTE1wkZUOgzHsmDYh
         t2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713897712; x=1714502512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkZmDBZZcJhVN6mPuWy4uMyeYcqDYd3E+rQp4e4pMmA=;
        b=au5M2YU7sVMrdnOofUA6DkPDCFn6h5xoJmxyKkgdv73zgoMrnpWW2s4ed0FWqFSPnj
         4tl8YZrqRtKvLy1hLsGOaBbYTpM5ripletfTUiQK31hthx1vNDDtidpcARf06vIswsoi
         0BOvQMgSi1h6CPWHXAIObJdIT3O7Sjde5zBYiOG8vk2VGsNUg5pIefhJC4M2Ok1tvOel
         /QwsdCppudTpfBqKNBFfMfDI0xRcl1hYh5Z3IJZhJyIVnvq4nuiQO/TnpUwCtUL2YwaW
         GPgt+/ZnFXV1eGIi66fGYPzigvzXNdHGAp4RCIF/Z6cbhqsAchJNRP7f92LgoUPS4YIc
         zfwg==
X-Forwarded-Encrypted: i=1; AJvYcCXF8tiJGhnyaBk9+eFpw03MemWi0geZzaRT0Y5l8zxXpWIHzXwVbwI49IfR9fhtTzluJfTipTDVp1H058uQXaN9iOoEUv/YcpuxIIISkg==
X-Gm-Message-State: AOJu0YwLW4pUTKt+yRem9PZQdnYlRzwPndkjc6XL7dEEHaDvtTl0QQLI
	Isghq0jc0pEqpmL/abSuYDZTu7HikK4z1Nf31eWtMR92EaDOBDl/iC4vfNPniKMi+I0RBqT/zA5
	xnDRl8U2T/2t6KDZL0qRa41capM1BMUJ87W0yNsgOZ7yJ3FN6fg==
X-Google-Smtp-Source: AGHT+IHkHCY0nAsTRn0X1AxyqTY/RSGMHd2W96s8+CnN0R0bF8TOmL0E6rUwoyEuLSPM0fhjc1ltCOp/0oJQdiys1B8=
X-Received: by 2002:a0c:c591:0:b0:6a0:5f8f:d753 with SMTP id
 a17-20020a0cc591000000b006a05f8fd753mr190211qvj.49.1713897712026; Tue, 23 Apr
 2024 11:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240416001639.359059-1-richardfung@google.com> <20240419170511.GB1131@sol.localdomain>
 <CAGndiTNW=AAy8p6520Q2dDoGJbstN5LAvvbO9ELHHtqGbQZAzQ@mail.gmail.com> <CAJfpegs=J5x_0DfiiXcEtsRxkoVq+ZGv_FhxFo9Vk8B++e_P3A@mail.gmail.com>
In-Reply-To: <CAJfpegs=J5x_0DfiiXcEtsRxkoVq+ZGv_FhxFo9Vk8B++e_P3A@mail.gmail.com>
From: Richard Fung <richardfung@google.com>
Date: Tue, 23 Apr 2024 11:41:13 -0700
Message-ID: <CAGndiTNRvHGtYZ3-Q7TJDCAYcFNLTypzgnGf3bCcithjwKV0tw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add initial support for fs-verity
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ynaffit@google.com
Content-Type: text/plain; charset="UTF-8"

> Please verify that I didn't mess anything up.

Tested it and it works! Thanks for updating the patch

