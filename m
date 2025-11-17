Return-Path: <linux-fsdevel+bounces-68777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4371C65FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92C894E8BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B832ABD0;
	Mon, 17 Nov 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDvuwokg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374C2FD1BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408353; cv=none; b=Zb09C4gBMwnlHwReXmpkl9PhnZYq3chujfzZpMA2+CnsZZO8w9eYo4+Qq0bt2J/uDiJT1A1hRPCSpge93J3ukRxVKfYX9yB122KA9YWKJGt/y8Q0Uq7ci7tt6McToQaM6fFago901GjeCE0iL+2iEmEOGrdzxz76ZSPh1STG0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408353; c=relaxed/simple;
	bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjuM/6CTTO1Gu6lJg3TVm8uR37dba3lTnRMJHwioUaJ8BcU2lBP5LzlYfsf1u6mRZZM0slFtMA1UdIhJxAujiL+twubkPUDuMouU7ozAGRsP2QVvSQWUihfXfBUXaDZ+wjXsyOUD8/p2PnF7WpwxqDcoYKD11OhE2NVRMjE85Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDvuwokg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5957753e0efso5007794e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763408348; x=1764013148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
        b=qDvuwokgJ7ynZsglDSewTnrj0tY7az0tYREPbz/DYRBG3kgll4ay88TKYpt702LNbv
         2uu9HxCqV8Gtaa7IeX+TQ/7IJESYmIpflDbL3EdzIQstkzb7uLuedxhd6H0MIOZtpCNf
         dqCAh5kzyBQVFdKgszhSQLcNB/fBGs0dF9ZkLt+IN7ivHw7Pyb1nDcrfQCc9aOPxxtzV
         XgxEatw7hijzxySZsCeRTfqro9vgiRYPuGh57NSKzxa8kYs0rH8QCkLdlM2onOxtxFQi
         YaWiyQoCDCgle5arO0Y1VMZHQHLLW4qL3BV6ZhdKNNdTMBhUhuRCfIAi4Wofq9LoYO9f
         hkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408348; x=1764013148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
        b=eHUvlqFCnTsuFcuk95mgYD0+MW95QRw0k6KZFr7qPvw5nhVYSq7nKWKz62GifDGvQ3
         2MDKnlCLmNl6tZ50qD0llleoBOFX2AqwD5wMKVkHZBDktBT7A/MmxFPR0iaULMaF+CA5
         /zOL8w8gGhVkXNl2Nt8AXrU/y4ZqFKFlFbRIR6FelY0soPbaoR+/ZG/2wplLJl5vhsoJ
         DILdVDoBc6qRWiG9R0Cb2Dmq/f+k+6lR1j46nv3ZvUHWjxmEzvPoJ3P16iACdAiUcQGo
         fWA5Vg95BkoQtQm0zJfxPRAKpJo/tdvXWIIQeqjX9+55PHPeZ7lq/AibyNFiIOMtirwb
         T5yA==
X-Forwarded-Encrypted: i=1; AJvYcCWZABb9YgkrjcPR8CK0R5HWlh4bgAulV/NJ1Uhek9eE54CxboZFXYw6OtiMiZbiO1e9oWV+m73hkQW/82Hm@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3On9gMjwLiULSzmfoV7jqPoIHeXQo25ul+7LKam4QXeFuCTb
	f6Qor5rWnffh0axmHDmkkq7pFvq/8acdbPt4DGQKYeb5j6h06qBN2+qv9d2o2MDxGfBAAETqfhI
	XRhFeXCQ+SBbpbG6vPM9wTvpXfxBdjwoVdV7Dgwvp
X-Gm-Gg: ASbGncsy8MTG9qFPLcI/28J37v8ARC/CwakWrIhlt50DZ8Yq4+tAgDSRRZ0MF0F3hee
	NpBwB6VX6p/QmNb6Uqk4b7B6bTybwDtBYk+XPh26eOHDumPfso6j3YXf+Hsrzd1SRX+TFHTok/O
	k/Z9pCjrtDEQK11Yed/x0usXU7IL6uSH0nacE8tjcap3NrOBLacMZ44D8/RZ34i7tAIN6XUC+4I
	xiVsyEDboxYo+yrW0zypWeCYJdn7OG8XY199rurGL2PWGo/lhwihHdS8ROwzpQ+gPHRNo8=
X-Google-Smtp-Source: AGHT+IFN4xOyb2ZHLHkpG4LWQorQPgUWti/L9wSnM39BaS2Jya2ibJD/Dhx+BTWb3SDVgOFhixbcdjfh2auRRViLmWg=
X-Received: by 2002:a05:6512:12c9:b0:594:3270:3b14 with SMTP id
 2adb3069b0e04-595841f96b2mr4673200e87.32.1763408347863; Mon, 17 Nov 2025
 11:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com> <20251115233409.768044-18-pasha.tatashin@soleen.com>
In-Reply-To: <20251115233409.768044-18-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 11:38:40 -0800
X-Gm-Features: AWmQ_blJn1ck9PTGxHP2-KznbYK2P4A6YYPNkQIgUM3c99KDsjZHm2bxwWZBfno
Message-ID: <CALzav=eskApQk6kstsQWThwV=h4Qmd85kAw3CxZt=6hj=JS-Xw@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] selftests/liveupdate: Add userspace API selftests
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
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

On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testin=
g/selftests/liveupdate/.gitignore
> new file mode 100644
> index 000000000000..af6e773cf98f
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/.gitignore
> @@ -0,0 +1 @@
> +/liveupdate

I would recommend the following .gitignore so you don't have to keep
updating it every time there's a new executable or other build
artifact. This is what we use in the KVM and VFIO selftests.

# SPDX-License-Identifier: GPL-2.0-only
*
!/**/
!*.c
!*.h
!*.S
!*.sh
!*.mk
!.gitignore
!config
!Makefile

