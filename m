Return-Path: <linux-fsdevel+bounces-21702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61649908936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659521C25025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3895193093;
	Fri, 14 Jun 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P/KrYiA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7B1922C1
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359314; cv=none; b=Fbi7pxUMLTYZ2DgvnsrcGQ6lUvlOQUtZN9pKyIhpgEkdu1yldAvItzZVgEWEL6i9B6PDL/dSuPrWq2UIlrsjORuYsDQkJ4Cpac3+FkUPY17QhejhNJrLUS5pZ5VVtWXNAXqGN/JWIBjKD9EbrQa/1TmDsGbWrejvSXP3CKAHUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359314; c=relaxed/simple;
	bh=qJTa0t7bObTfCjOsSPk5ToDKQr8/FSrapP7WtkGtJ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmZ/nalFiE9IWCGBH1a7xqjTjScUUQ1eSxLl3abTgRvhts2PycEZQO/ltaYkv37ScYA7Ae0KIoD5qrvFF5BpFGWQhtgvsEa6oGB5aIP8j769S9ew6OBjDaT9BZRUZFY7EEkE0Pc7aaKEwHP83M94qkroZnB/D5SndRXHtwvAdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P/KrYiA0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso270787666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718359311; x=1718964111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IcWtGd9eZRzKtVaUol/ojSmPdnH4QZAUkGyNOHOIh5g=;
        b=P/KrYiA0mWJeW422PKKeUdYBDk/E6Murj6RaWCOATV7TvFJpFqyiDYDw4lnbBqv9Xv
         apo48/dunHFdLRYbizpAoQdTeVnsbr9fZ7Cx2uKmTAo5WLStzzDKH6zgeADCUceDxaQC
         dY7Qm5BngbGHIvtHHJq2K70xeBuFEcBCzQ4kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359311; x=1718964111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcWtGd9eZRzKtVaUol/ojSmPdnH4QZAUkGyNOHOIh5g=;
        b=mWzur7bL9KLb+QB2xvQ2aebjn/n5UzPPKyNVHrfQ5e318ZPeGmIPn4MVbfih8QFz7B
         3/KTMR/4AATnGJMNMvgOR9c4KTeqSdN9DkmLS8v7xC9vvtbKUNT6KP07ZPPezpy95lee
         v3HfvesoSoAxR0a75wxNIRm4UEeNs5+to54T64pHQl71h04/yK1H9klfdylQi1whLgAE
         QFmMTypnTonRp4vW+0lBBwywCLHfE2Ve4VxDNDzsomWA3CXFu089tiLTIuoSn939EK+P
         wwmdT3Dr020wl8qgBGmkOcKURWcMegZzqSS/bIOm3yK4nrjq9dAWGkY9AvSlhPYdi8C7
         DvZg==
X-Gm-Message-State: AOJu0YxYQMDcDGTX7dGz0gf7NSqCKbjYlG2p3vEtRRGEcq5QnZFomK2W
	eXl38+grg2zRwJYPP4X53G105xbiKuZDe+YVsY7/mRZUY0mbi/aLyAtjVNwzQnQlfocscJitIWk
	TuLXl3hzj/+kdyJA/wW1ciSEoj9lcHVAgDARiaw==
X-Google-Smtp-Source: AGHT+IEgKX7E3k+SiFkKq6gGcI+BVqO1cEyU5VEV9bAavZZ1VOJTWdSg/ASw7UP+4+eXdSAKiLhWTvPrPWhPxqILYI0=
X-Received: by 2002:a17:906:1446:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a6f60de2519mr127172566b.66.1718359310843; Fri, 14 Jun 2024
 03:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com> <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
In-Reply-To: <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jun 2024 12:01:39 +0200
Message-ID: <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:

> So why the client doesn't get woken up?

Need to find out what the server (lxcfs) is doing.  Can you do a
strace of lxcfs to see the communication on the fuse device?

Thanks,
Miklos

