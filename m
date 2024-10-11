Return-Path: <linux-fsdevel+bounces-31648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F739997F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9AFB20E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD5C2C6;
	Fri, 11 Oct 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pwr3vYqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63621392
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606743; cv=none; b=ZXntkpHr/LHPh0WZPjHjgutaHYjHaaxqDlweaVS64K+MaCItc7RzFzgW6/UR60Zaoh/fJpK2tCKOnOtQPHVndKupPdsdwgt3cWsjj0/ePGZqoZOpc/VLXQUBB9PvGcggbEZCESi/bzOwadAfHnjlTXJAvP/K5T6PVtITefPaE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606743; c=relaxed/simple;
	bh=U6PUAykp73iKKHV5fdD8PAkfE5kmnNbKtNiNViCmipg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mWHrcGjpwGqLR9Yuv4HuG+R3Iv21CVjnqr2zDbawhtLzL9qq020UOG089oJhQiL0h9Q6rk7S8ATPKO9dd2gBuaFaNbTp/DKTWT+rxI+k40OkJGg3hrBHk1dVm4b55DotKgk8G5qPijleQUmgqIMSDF5H+48E5R9X5PkYN2EzDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Pwr3vYqB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71de9e1f374so1150747b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728606740; x=1729211540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L88k/6LQJ6n1DZsE/un1+ux0jKynkO+0CSLGH0Z2NJk=;
        b=Pwr3vYqBDOAy8cnkB7RyrcMYV+dJyFEgkKpAbFmEoUJ+E3YEYhTvlc+MeiLCU4xsE4
         nPCvNXXvdICIPLrvvZEf+Ws7eYulqt/x8rJs0iTYpdjil17iLt8FMI4Fex+s4+hS6eSw
         GP65XkrvTHwAXR2t8TRCuvYk9HVImv6HpCODdU9hda8LaXSLuaa3JFhSSXtfMj2OXcZQ
         pynd+O3vJnkfxl00bU6ZgacquJKWJqp9GFD2TyWHfXSo+RLSh7F9dpZ492lchdGV1p7I
         mwOW10ncjDa/X9j2yVbzl+q90VWgJkVhC0ihFdx/6IZBCT1HNC+ycjZKYxY9b+vFFRN8
         037A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606740; x=1729211540;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L88k/6LQJ6n1DZsE/un1+ux0jKynkO+0CSLGH0Z2NJk=;
        b=wtcCiuolJ/wkVidBttaU5f7HhZbV6x4n4HuQT3CdIYjLqCzRAtHXhbBH44rUG1ANsE
         AeI9Zs72c/FYQefYqmNhI6clZ2WInsMzrbf6nyrmViWmyEXubh10FG4OIfwAC/djGrH+
         hSI2AFS+5fyC1/47hrxSPTd2/R3tsH7J7aivQ8GtFZbUx6cp/HkQ8dKbqpZ7bykf+5Ez
         8DBwZxxPoZM+p6ATz5H9sKlQskfgUWmiX0MFo6m2uRkiBei9itbHv8WDbyGjDrd9PO2E
         P0jncnkPYzHPxnhQkMBGFwewQV3ufZs5W2FI7VJ+f9WK0fK+q/6TuL0XXjmyKXJdVpZf
         eN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXHWx4VnIvk3W4Hj4dvE2TKKZy6U92qf6OI8SS2oje+ZHi07VG5xynSq1rFyPZbQmD6ziJc4sw61dZzdb+s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qE4hbg6q47Jw6aBM7XU9G8PbU6jKP74Gf2sSG7+EaOEyXZRI
	zIe0ccSY7bjKx6gJcF7E3aPuiqIdc23V0hSJqPoaFxWq9goTWhu//X+xdAjoNJyatTt0+GwqgG6
	7
X-Google-Smtp-Source: AGHT+IGyS+aA9UxCtkzeUWYlobH1ifyQtJfGEXOmfg62rhTEkQa/syWVFaq3tPCmx1Ml8NjwqupEEw==
X-Received: by 2002:a05:6a00:4f95:b0:71e:21:d2da with SMTP id d2e1a72fcca58-71e38083ec2mr1436401b3a.27.1728606740101;
        Thu, 10 Oct 2024 17:32:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1545600a12.94.2024.10.10.17.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:32:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH RFC/RFT 0/3] Converge common flows for cpu assisted shadow
 stack
Date: Thu, 10 Oct 2024 17:32:02 -0700
Message-Id: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJyCGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3eKM4pLs+OT8vLLUIqBsYmpaUnJSapppirmhElBTQVFqWmYF2MB
 opSA3Z/0gtxCl2NpaAE6oGlppAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
 David Hildenbrand <david@redhat.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
X-Mailer: b4 0.14.0

x86, arm64 and risc-v support cpu assisted shadow stack. x86 was first
one and most of the shadow stack related code is in x86 arch directory.
arm64 guarded control stack (GCS) patches from Mark Brown are in -next.

There are significant flows which are quite common between all 3 arches:

- Enabling is via prctl.
- Managing virtual memory for shadow stack handled similarly.
- Virtual memory management of shadow stack on clone/fork is similar.

This led to obvious discussion many how to merge certain common flows in
generic code. Recent one being [1]. Goes without saying having generic
code helps with bug management as well (not having to fix same bug for 3
different arches).

In that attempt, Mark brown introduced `ARCH_HAS_SHADOW_STACK` as part
of arm64 gcs series [2]. This patchset uses same config to move as much
as possible common code in generic kernel. Additionaly this patchset
introduces wrapper abstractions where arch specific handling is required.
I looked at only x86 and risc-v while carving out common code and defining
these abstractions. Mark, please take a look at this and point out if arm64
would require something additional (or removal).

I've not tested this. Only compiled for x86 with shadow stack enable. Thus
this is a RFC and possible looking for some help to test as well on x86.

[1] - https://lore.kernel.org/all/20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com/T/#m98d14237663150778a3f8df59a76a3fe6318624a

[2] - https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#m1ff65a49873b0e770e71de7af178f581c72be7ad

To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Mark Brown <broonie@kernel.org>

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
Deepak Gupta (2):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      kernel: converge common shadow stack flow agnostic to arch

Mark Brown (1):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK

 arch/x86/Kconfig                       |   1 +
 arch/x86/include/asm/shstk.h           |   9 +
 arch/x86/include/uapi/asm/mman.h       |   3 -
 arch/x86/kernel/shstk.c                | 270 ++++++------------------------
 fs/proc/task_mmu.c                     |   2 +-
 include/linux/mm.h                     |   2 +-
 include/linux/usershstk.h              |  25 +++
 include/uapi/asm-generic/mman-common.h |   3 +
 kernel/Makefile                        |   2 +
 kernel/usershstk.c                     | 289 +++++++++++++++++++++++++++++++++
 mm/Kconfig                             |   6 +
 mm/gup.c                               |   2 +-
 mm/vma.h                               |  10 +-
 13 files changed, 392 insertions(+), 232 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-shstk_converge-aefbcbef5d71
--
- debug


