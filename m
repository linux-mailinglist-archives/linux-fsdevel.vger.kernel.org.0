Return-Path: <linux-fsdevel+bounces-45169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4903A73FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DF8827EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705D1DE3AB;
	Thu, 27 Mar 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkm2litp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C41CCB21;
	Thu, 27 Mar 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109595; cv=none; b=fARKbSeTJ8/45Ai7mR25GFooVQztkSWusmdY4kCBtWskO60FJ+Ag227n2gd3KtLW32JBOiOBCvDFym/liGH/Gk2Q7vqc/hklLiU1I4DCcjSKb+KiyZIVSSJKaxwNx5JxfcL3xf7IiuPPdutzBgFRoYKBkfX5JCoRuefiDRV8aYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109595; c=relaxed/simple;
	bh=GLqglL9v23gJuG69hfxF1A3fwXDbnmKCTJK5LlaQ9fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEiXXZssRmxGpTgF3jRiQtt6VK6g4Cl8DgLRZ3Dnwn8lq7aNQ5gVlcH9GwTGOK1dam5RSgrNlKtZrUy4xAyParb77+8+sfTgBoXbDclRffJsWr92BYXAeAKli0/IFHqmCXmWL8T6B2uenJ5vcE7MJx3DtbnFQfSKDNJKYey4Tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkm2litp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso11174885e9.0;
        Thu, 27 Mar 2025 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109592; x=1743714392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFrrEKOtsin+8uVvD5v18PtpdZsRPpaDruCArBuJl1k=;
        b=Kkm2litpaQ0gLSLmjnPKXuOxEHmTgt7X+ucU14TgE+Aw/CmeiSK1s9jAKuDfv3kKBy
         +gHUaOA5l1MtjuzLB3Lat+OaTOj1p2jWLe0WbWOCPF3up6tb2a6N0bn9hmk93nBy0as5
         zC+3pWlFwXiS9VxewszNANbqzfCF/Nlnz/Wq50xo0xJQdaNJ16pYsX6Vk8+81l2S+Hrg
         Y5ejOGGq91ElguZc3MNBuQJEj3qIRmOPnY6o/GBwaAykpi67SeuQrmqlFrqGdyWNtpOz
         VkUQ9eFajvm5b2GKlbSH+WlZAEQRcAAQiiOFjuH3Z2oqlRr9O86ntGL24G1YCouwM4g4
         wM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109592; x=1743714392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFrrEKOtsin+8uVvD5v18PtpdZsRPpaDruCArBuJl1k=;
        b=dlfpE8CFrAyNmY0xWUZYPgfrlccYh04z7JNTh9Uz4UuNL8JyeXH/qH0AiowhC1xONI
         6EHbKuA/Q25unW3stsV7Zwaj5pDGxkRBdk9oMwZyRGerHCWzwrbDU2oOxo7O0lHOS32Q
         VMHkEAYzqi1Jgj9Flp64CxmFv8LzM4Y0p+a3yOqCKYB4yU/oZudQ+52FYe1PxfPa8Zr/
         MQczIm9DUOSpCYVw+e9tcu/qp1RZSx8UYbzEKqxDRpVDlBNQXqQQ3KrO6ueBg0SnuDqE
         pCrigiP+6CIFNhxKJUSV5K8H/UocWDRskRpgk1ANg20Z7gAopBt7VTfSMu6aPqkQi5SR
         fMOA==
X-Forwarded-Encrypted: i=1; AJvYcCU03O20HeGKVC1/LSTPYV8yjwTjim//txTmSJWlruYwi9K33/fb5F5/F9tV6E+ZnJugywfrQCBoUiqS4TzjwDUF@vger.kernel.org, AJvYcCU8nmgKiFW0WywIIZdXePrafSwJ8rtX6CwOOYkGHAAjAqIPR19LnrEzWf9WZ64E0GiiBurSqto5pVXLVQo=@vger.kernel.org, AJvYcCUAnWhglOdTHw6g0tNmrthtL6Hcqi/u/o/iPiQyRXo2B0Z8oovXGzTi2u++YjnYujcZZWHJZQEOA8TLiBs8@vger.kernel.org, AJvYcCUUxxURu1mJm6KA0o2acp9uVMOg8f1c5qU9mQT83d982Rjf0rC4Rc2a7LnsTS7Wwyl8NUGLXsl7gt0tGw==@vger.kernel.org, AJvYcCUhGUEt0rvairnw0z5niNDLn5Z5SbM4xnr5Z+x4t1UBVNaF2TjmJAE7Rgi9oEM39CwKELRoZFYWRFIoY42Y7QQEmqW2@vger.kernel.org, AJvYcCUp88RW1e3Xfwjp4kRfV7di1O/MnE0yESPwf9M0ZorBHd33ng+qvcdZMCjmYJOvNIn/1ses2dZK1opznE95@vger.kernel.org, AJvYcCV5IgPu43ZaC8mjK5NLpsSuJqfJDnFTBo/Sl/9x+HzTeB5S/aA86u0r6rA6nFByZnGVXSSl/VnTJXMxRw==@vger.kernel.org, AJvYcCVCxjhH5xAGiYUUXrMnUHlZRqQHEZyJ/RDZrSr+Uh+yawD8i5Aua4I0BqqTRtX7r0W2Cqwz/26Xtt+wL3vRog==@vger.kernel.org, AJvYcCVqd5XuAEcnnZgaDhXhCW9P6hpB1mfJoWosJfQHbPuryMzY5z5BDnnSmGrV7QWnqBkhfr1ZQf0c+RBC@vger.kernel.org, AJvY
 cCWSfOWumUpZu2absMG0N6+iQriIERlSoa3vRvUBZOiF3BlWIsyxuZhmAKc7KoqN0JDn5b4=@vger.kernel.org, AJvYcCWnXMjYcYFiXz/Fqshp0EnTFzS/EW33ey+YRXP2xhlSp2HVGrg/XEjyxFU4/5drvgqHviBE@vger.kernel.org, AJvYcCX1wOPJ68qoOL5Ka/LuBbbx5PfJU+1dpMR6uFXsMXbV2xZ1MeIWcfo0Zfz+akrAY6y98X+fmLCY@vger.kernel.org, AJvYcCX35mqW0E735dB7FMYMXjK7nCwXHSJcJm/gf5q2kjDtzkT+3FN+A9Rqq96U0DUH8YE6BdGdQwySXXAz@vger.kernel.org, AJvYcCXFXnwlHh0EcaT8A/cCSIgKg+zpCwTnCb4XpRaWUMbi4XqE/tfkDq6aIS+Roz+oWMHUK09Tny2cQZUna0c=@vger.kernel.org, AJvYcCXMkD5aWcsyREYDPWOxMweObii9/uOsDsi/laVUJzeU0v/iGTAcBf4F/C3q7Fh9dAYtJATe+fzpRl80VTQ=@vger.kernel.org, AJvYcCXgO4iUj6g68aVSmHi+0JU2B4zVRo7os36L4eRs//ciGd1Om5toAsxqIaYO85qpyf/NcLsisgUuRQ9vRdpO@vger.kernel.org, AJvYcCXwesdZbEqz2OBK0NvLd31E2XWE6Xrb7mqlk0+0YUURxxgXfxlJLajXfM8V5oe530nCgKU2NKYOozmtOAlSBdCbZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSJvo39Wz7u6Ea1UTi+5uZ3ewG2dKwgA1ggl19j4WgW5ECz4J
	Ea5VEEM0rxLtvW1bAgxcgEGvU7cAUPH/wDrI7meAoYGnm2QEKT+j
X-Gm-Gg: ASbGncujgRpcj4OijFlrTCTg7ebhGT1gcQz5C4MlqpvYZa3jaabiRrDOpDJfKm3R+61
	bEbMepDF+m4cwX3NkysWmqCDFpDiEbtzmlpS0deJlhTrPB+a+xunk1XrCBU9ieAVl3WrUYrl8SW
	pHrz3iPeuLpYicZgKFjV1l3aVvLr9bOgBPd/i/vXxdTout04d2GGJsEKyG4v9e6EYd5WdXUrZrB
	DV9TZc84aqlWSr5+T6CDdOTOpZ131yM1M4WB+bKNw3gMnRWPDqSz5jlD+2gPG51UJn4Ny0jstLU
	roHGEk2GWz2nUCq+TwITjTEogSmXbCtWmbL5f2Hq0WyVdSNAhMlSrQsKO1G3zs5akgsZXRINA9s
	ApFIpuJ4=
X-Google-Smtp-Source: AGHT+IF3JVFu2jCYFxmmspP8DgX1SusdSEIsW7Os+9zvssuS6MfQig2v8nl6xgtDIG4B7nUqszDWww==
X-Received: by 2002:a05:600c:4e05:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-43d84f5e5bcmr60988395e9.5.1743109592161;
        Thu, 27 Mar 2025 14:06:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedc2dsm49307315e9.2.2025.03.27.14.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:06:31 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:06:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org,
 oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org,
 mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org,
 rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com,
 inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn,
 jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com,
 wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com,
 dsterba@suse.com, mingo@redhat.com, peterz@infradead.org,
 boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn,
 leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com,
 samuel.holland@sifive.com, yongxuan.wang@sifive.com,
 luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com,
 cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn,
 ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, maple-tree@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
Message-ID: <20250327210625.7a3021d0@pumpkin>
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 08:15:41 -0400
guoren@kernel.org wrote:

> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
> but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
> for construction to reduce cache & memory footprint (Compared to
> kernel-lp64-abi, kernel-rv64ilp32-abi decreased the used memory by
> about 20%, as shown in "free -h" in the following demo.)
...

Why on earth would you want to run a 64bit application on a 32bit kernel.
IIRC the main justification for 64bit was to get a larger address space.

Now you might want to compile a 32bit (ILP32) system that actually
runs in 64bit mode (c/f x32) so that 64bit maths (long long) is
more efficient - but that is a different issue.
(I suspect you'd need to change the process switch code to save
all 64bits of the registers - but maybe not much else??)

	David

