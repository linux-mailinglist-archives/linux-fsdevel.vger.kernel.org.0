Return-Path: <linux-fsdevel+bounces-67553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC0C4330A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4097188DBA7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410EB2741B6;
	Sat,  8 Nov 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DiUZmm/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8724C676
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625652; cv=none; b=W6op+cX0nYlsz2XFDejPtYMdhYkPJyWgMqL+70XE/WAIUpt5LGvgkuzqiT/tDPio91crCm8+aWKVcQvpfPMCcLqBy02wAc/7UPPFZCRfHVKBTWBGaD6jRJxmdgacHyagXjNcyDMWfUOu/SjOlrwcMBmS7fyvd+jEkLUOT236v+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625652; c=relaxed/simple;
	bh=HXLYSWisfIRg/IZEGEaCxFtj3HbKG4twWmdqzwXU56M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8qN9Kf56KTmA9sv87WdcS0mzMhR6KZAd+gdVKMgGNB8GM686MkFFRzrskjIl0ozvnDYPI8HASNo8CYhrYpVSGPYGkX4M68H8t1QH1Z/jOxJpB3ywmiipInLKU4Wmo+NcGPFvGbzHgc1lGtbgeZkYHCMlmyOCrLH8glrJGHlLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DiUZmm/U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2714266a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762625649; x=1763230449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q3WFXvp3nzw/xfIhFbqypMckNDbnX8ReX564Qc9Enc=;
        b=DiUZmm/URky2uJk4p6TqUg8JYsDKX68Wlio8SnlETKTdQV5P6kVnCYCc5A1HmG67YR
         dPiUYtngGF/IDwNQ6NwhgqBwOhXOYiaqO0uCQRfn5M9IdfoUIQgMTGvaEoveSIqz7QY2
         7JROIPuVD9XX7mItmn63f88nMjTaf1tXoJuePaR7CmGpQ6mwLCqjzLU/W9/Klsi/YsGj
         0sBDeVGvKiGmqv9QLtp4wZzCmvM7MyBbxeWg5rNa5xbvaQa9G1U9iS6rRQzHT/b7rIlz
         uI8UILJXP1NAibLw5jSnbQaDKk9FyHv4szQaMnO9f7DSzJ3E70mlx2/ZpeaPs90EEHi+
         o19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625649; x=1763230449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Q3WFXvp3nzw/xfIhFbqypMckNDbnX8ReX564Qc9Enc=;
        b=KkAaqy9GY/UNNknpI/U+WhX7+bj/c8Y+u9d/n/u2XdCE+Im67zZVVpUOSeXXuBfK+u
         4Zpy2ePbLwjHTXea/sinOSOKn90nDHP2qlUZsbII0GcZqhFh8Fc6d9P+Rs5N9vGAvSbb
         Q74zau+BSilENj2eZaS+kd5neEnecTp5qCzdLBh3gDHiobdukVdWgc1sS68EeSE+EMnf
         90S/OESCXeERiPbIPUUwzCkh5YHvyVLNy9OQ4pNsUHT4jpmyOUD9h5dUGUYAHKOw+6qb
         l7Hd3bYPtJ2D3DvrkFv41p/Vgr2d5pZhVPETRFwJsmtNgLzYWU+MNefVizVHoYRPp9jZ
         uSXg==
X-Forwarded-Encrypted: i=1; AJvYcCXCuiWGH3iES8OpTjBNY2Q7WnoZ4x0kbcHx+yDO3tqP0jV/6JiB0/Hxpj+gV2R8wIT7cyIGBqBQf0lf8rmu@vger.kernel.org
X-Gm-Message-State: AOJu0YzxymuJ/L3ZphSbBEhW8r+OTORpRP4A7qxj3lgd/YRZVfmUQLGC
	tqreFXotL/D0td3XHIBrV+8qkL9ISnUPYfzs0wAxA2NuAItk+y0CJu6yiJLs21irbDT4DK4lHA7
	1B7ExLYfNPf5sOTGKFWV/d2Zf4pdMQZs2lDOcL/wArw==
X-Gm-Gg: ASbGncuq6AWvEbTciMEpL0zxtEZHv9UNH7qjMLtqjsZjifpwEzaBQ56n/ZSuk1VNm4b
	RYcXNyMoCsuOK8oM9IqUhFNGBD3dI4fOXloq4eV8BoOFkSm8JY6cawqTOLHNlp+t35lGJ61yPQ9
	hjFEIl8PiCMhm+OzvjcJp9SibTPWxmhaA6n8X0cKrqieT4h07LxbY5o6tXCq47cawqKvkJxVNe9
	rUp4pykM1AVwG360tWrHRaYF/SdfbdFOrot4hMGMtoaPFaXgLCJ1HcrmPgUbc9onoQas5AbtyEW
	BYQJ/JGtEQqc6sNzaWpHJSucGyDb
X-Google-Smtp-Source: AGHT+IGnxIvGVB3DoG73/LoR1IZOJvd+jikoooj0blQZKowrXDzv2ZHuSFpnulnp2McWHadhftCSnlvUuIh9AczGGLk=
X-Received: by 2002:a05:6402:280e:b0:63e:405d:579c with SMTP id
 4fb4d7f45d1cf-6415e83f02fmr2267675a12.29.1762625649247; Sat, 08 Nov 2025
 10:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com> <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
In-Reply-To: <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 13:13:32 -0500
X-Gm-Features: AWmQ_bn1c7HhzSfiUpQMj3X6qTh8tFK5YjykAbxye45PZog-6bB9QqhpzjoyA_I
Message-ID: <CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Live Update Orchestrator
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:33=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri,  7 Nov 2025 16:02:58 -0500 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > This series introduces the Live Update Orchestrator, a kernel subsystem
> > designed to facilitate live kernel updates using a kexec-based reboot.
>
> I added this to mm.git's mm-nonmm-stable branch for some linux-next
> exposure.  The usual Cc's were suppressed because there would have been
> so many of them.

Thank you!

Pasha

