Return-Path: <linux-fsdevel+bounces-23510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BEE92D867
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06671C21251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEB197552;
	Wed, 10 Jul 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6WcssT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0C195803;
	Wed, 10 Jul 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636892; cv=none; b=eJftqZ+xQeTCSkDhG7OayTSLQu8h7a5GT3wD2+WD6zNUs14KugmeP6gd+RtpfW5d3Nfqmz3D5CmlXXrj+pJd84199vTZI+RWC51gsOhm/ziiO+3c1TFAH2Je2MXq5je1YAwBIJUmXmTa/6twOgN6trFnENobdUWKDrUXEne9NSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636892; c=relaxed/simple;
	bh=/6ZdP5ZM/JfMQZmkv1icoRxVdcTKnlZGbxoMGuBNnSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtVc7Qllfx5FmvyQhB0sFuglCLz/kypLDY+lJU9RmZomoo3GRWCVXlUGLUXjjF031nh0vXxK4SzRPxFNWo3elOqwS9y0foh3JYCAoq0Jj8wYA9DdnJJBw3GtO48vkMbXSLsNoq8c4Vl2dya9FSB0d81Jltsg7WslVdAQtIDouhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6WcssT6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso86249a91.3;
        Wed, 10 Jul 2024 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636890; x=1721241690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBxSFl8LoHS9twH9xDyNT3cXkhW2LHblXm1qvqlBk90=;
        b=C6WcssT60q6b2csS4ApKhVcrtGQNbA3eWPP+VkZqdDSkwJUkDBg4rJmKrWob+TfUIx
         6/0LNYGb3DQeGRG8Zp35O0aaq6Vv9od/Idjz8UiA+jD3/1GhPUrAzPsfy071o282QOET
         jvdRwskCgJlMJuBJho7Dx7mEPchJ6cr2q4mge/tB1f9SoibtvcyT2k8w2Lbh8M9ICp1Z
         LKsRp0yKJuH8tJMFN1XN/0FVBBSUYm4RiTK1pqaX6RF32GcOscYQJnt9q84/PCA1Xuxe
         VZ+ruTjmyJdqIUWyAM+mp1A0vmQY7R301gWO/XvV/2+LAuYl7WHj5i0L9bRhz/GgXDVS
         v1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636890; x=1721241690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBxSFl8LoHS9twH9xDyNT3cXkhW2LHblXm1qvqlBk90=;
        b=a8LZQ2gh5A5v+T1n4hmRkmfAr5nwf5uUo1Xxwyeesn6shWVuEngY0TdTlDjfft4wbq
         hlMvCmoC4Z7zvq1/Migp7NNqJJ2HzMDTbgtuEjsLBshPVr5ynR0ChvkMrW2N1AyEhf5N
         5y4Ol5XI9YLtp3R6txd20MWe9/+4fB+sZV2pJsERijG11tK992EzXSEG+AIY0IUpadOk
         9udDTCqnbK7UmhBymqyCHmUzi+3yqyfzhnLM4WwVBik31LXBA2OYhbiOFk31Pe4hTE2C
         o1GvgzLqik0Qt5n0xVU55/8wfmTdoN0m8uTmTzPQoOW9IzX6mOFBJlWkmIRKwK76TO4W
         Plxg==
X-Forwarded-Encrypted: i=1; AJvYcCW0N93m5lK8/O8IQwQOV+ghHxosvcIpMoMdnSKDnPn9A/dGt+FEpD63CNYUcFaZOT04WqX9lYD1pUzGg/XU1sfKfDrmNsVfh8z3AiqPWX8Qy7i3npKaajvE4X0H6dZiDNS3c7ILrt2dmllc1w1dcMMdIIWvYaHsZEFR0uwVkVM8Aw==
X-Gm-Message-State: AOJu0YxoUb9MMwWAbZ8CKP3AvC1AcM30lw+whKCLYAKktOszsDMYGaSf
	iG1PaAbOpPzUUfQF+jtZuvFCdtX80O1U+G8F3ujwGV+KtHaoj2huDPfbwVtO9rQRx7IOxwx7RQs
	7bkXvCupVyZNyF15Y431h37Mf4ZI=
X-Google-Smtp-Source: AGHT+IEJXwm7pdf8JwdvXdSZZi6IyXCVzfds1s3XT3svtFCDKiakMYSU1tjVm15bDHgIst8I80Z5hQXcfgQoXD7xIKQ=
X-Received: by 2002:a17:90a:f58c:b0:2c9:6a15:640 with SMTP id
 98e67ed59e1d1-2ca35bde1a6mr5164660a91.4.1720636890155; Wed, 10 Jul 2024
 11:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240710113234.7d8fe0c61b5bebb275e1e2a6@linux-foundation.org>
In-Reply-To: <20240710113234.7d8fe0c61b5bebb275e1e2a6@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:41:18 -0700
Message-ID: <CAEf4BzZLPMc95B1PPaF4YVNO92F02wNuwnswoMptN=5zkjkUeA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:32=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 27 Jun 2024 10:08:52 -0700 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to al=
low
> > applications to query VMA information more efficiently than reading *al=
l* VMAs
> > nonselectively through text-based interface of /proc/<pid>/maps file.
>
> I haven't seen any acks or reviewed-by's for this series.  lgtm, so I
> plan to move it into mm-stable later this week.

great, thanks!

