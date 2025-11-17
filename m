Return-Path: <linux-fsdevel+bounces-68782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE5C6610C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B7B92291A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C132E728;
	Mon, 17 Nov 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxpktJBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9582877DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410127; cv=none; b=U1DPoidkaKKMUL3sFVLO6/6IGn9J0oBUoqsAME1xcC6tR3gdVQjoV0j1PCGI0z92MVyRYgRURPOG+8IGvegllcyWef2cfSwPBSx8S4F7ehrGRXN1J0pfjBXRfArPtNCRVeKFxUt4YzzzRLpHLsk5zFP5cdGe2BvfnIgcHLpCdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410127; c=relaxed/simple;
	bh=Yw1aZQl8vl8/93QETkjfeEjlH/aNdRcNmurvSzAuBsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bActRrfgkq2nQeb+EX71SwB03Ss51iQGOngytRN1e88MnCNH6+k4PXpDn0+LMCDlpuapnYxyke6TYJJHbEbpsOShLTse3LxmSRiinrofMRTkD2Pd2DJN6TEjBglEgZRY8ho6oqg0XDq/wQY3Rm2piQmdU4AjnPRCmbTC5T4twBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxpktJBj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-591c98ebe90so5112690e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763410123; x=1764014923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8IeajO+LKfiTWjgb9/LynkoZi0BDB3SfDWMQAsNP9Q=;
        b=KxpktJBjKPbBpynuF8Pz/0fn3yQOHh4y658WI53aV6eNhHAqfzu812ml/fWQua+uJv
         hPzpni+Q8xqYGSZRDTalnBYoILuBGC0DdrOkm6LJba5j/o95Ak3vkGvQwOGd3QPY4QAq
         mVriFdLSpNAy1Jh9Xq7CUiFGgE7jcnSRSFxfth+G2NsPvG6ojV8uwgmiwUjCvK332Ihj
         yBeXwbfCxdhhR3Gh4Fwn3G7ucUrNx7oSP9t2yANx3kKDLVyBcweqAKkFOzxZH1GfzxQh
         Ps32Gt0eRCQWtmt/1ZZM0r8o0tlLbr26FpsxfHKBpzMlSfC1QnekXoPMnWruaxJQS/4C
         Q+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763410123; x=1764014923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8IeajO+LKfiTWjgb9/LynkoZi0BDB3SfDWMQAsNP9Q=;
        b=rj/Gw30DNPVO5WR4+f7SrfRaTwXhEND08zCPji/9W+BUygPZ2J9E0IcSimtb7a5cLy
         Hg1VIi4/6cH7KSJWTQaLgEDF93i2r4TnoPP1h0XiHaJaW5nhXOxMypLAPqVSGZGMN9EK
         UNg6EntwtxzfjO/X3RMxqEeFCpG8vcZAjqw04s7NKWs6My4Q9niFyVEr8R0e+Zox2avf
         20r+FsPy/IQlaFQwhfBuoWEraeURKEux49zyYbPyxuJiwf4eLfbRWdoS1a/wgyQ0lTWn
         WCoNzkIRJEY+DOUAyeNqprHE9/gO/6oXkxkwEl0l5J6omi73uu8QTaV4f3649Jp4e6J5
         eWvA==
X-Forwarded-Encrypted: i=1; AJvYcCX4KSmfF7XTzj6e7BG9Bg0IQwhbpq79dXl5FJQFyVEZUeyuobQaW3ZfB5T/KNtSBbfQiL2bX4Q217168uD5@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhDWWmyv1KuP7XZSU2l3M80iSrPXFedk6v3YxfdrCQd9RoFFV
	7z6OW18+qaWz+P9E2hBuX57O9nG96HLRhRIij9DG2/DrbuG5S/V7XYH3cdkL3BYla5IOus9s1Ok
	5LvBkLJ+yenY5LhkPWaZZs9XcS2ZWsmxBwCGQIt+g
X-Gm-Gg: ASbGncuL/9BKNaFJyPjz7+lDa+qsQMkb/VtNxDKlXxnVng9LXOfvvUn+36T5GDk7jS1
	NLjOwj3zWuq6XIz67PIPzKitXTSyZZqrA0i0tjCmG3K4Q9Ar80egVZCNpVcyeqnsuxpI9cGXBcY
	3i8JecOpNwmaYb/q0z+wHPK63yD6lBJmZck9jfHqTrjO55wzbt9hftPnWDOrvGzyxe5Bd/zARv8
	YgdjxHf6ImTQszRPp4pL6RZfRfNO5STPAfnk/xjeSWkE9o3PGTzIJxee3/ZkTRkp5tUpBGeftjO
	EoYJeya171+LV/OV
X-Google-Smtp-Source: AGHT+IHojPwd3v72NJVpkRmb3ZkvRiR6CtkdMhnImHWMeD919h0DtLK7G2dHr+aPFZd7TlllVFDo3XPzHq7+z0cC59I=
X-Received: by 2002:a05:6512:b17:b0:594:27c6:a03 with SMTP id
 2adb3069b0e04-595841af94fmr4509003e87.13.1763410122875; Mon, 17 Nov 2025
 12:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <CALzav=edxTsa7uO7XxiUSx+DZiX169T4WL39vYsn3_WcUuVKrg@mail.gmail.com>
In-Reply-To: <CALzav=edxTsa7uO7XxiUSx+DZiX169T4WL39vYsn3_WcUuVKrg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 12:08:14 -0800
X-Gm-Features: AWmQ_bn0yHZxh94v8VlTzlMn4GZr7M3WPHVUsDMCpZs3Y3uXKCxbVDFrAaiWm-s
Message-ID: <CALzav=f+6hQ-UYBpwmAyKHPmtvEq-Q=mOL20_rZmAcTyd87+Vg@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
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

On Mon, Nov 17, 2025 at 11:27=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:

> Putting it all together, here is what I'd recommend for this Makefile
> (drop-in replacement for the current Makefile). This will also make it
> easier for me to share the library code with VFIO selftests, which
> I'll need to do in the VFIO series.
>
> (Sorry in advance for the line wrap. I had to send this through gmail.)

Oops I dropped the build rule for liveupdate.c. Here it is with that includ=
ed:

# SPDX-License-Identifier: GPL-2.0-only

LIBLIVEUPDATE_C +=3D luo_test_utils.c

TEST_GEN_PROGS +=3D liveupdate
TEST_GEN_PROGS_EXTENDED +=3D luo_kexec_simple
TEST_GEN_PROGS_EXTENDED +=3D luo_multi_session

TEST_FILES +=3D do_kexec.sh

include ../lib.mk

CFLAGS +=3D $(KHDR_INCLUDES)
CFLAGS +=3D -Wall -O2 -Wno-unused-function
CFLAGS +=3D -MD
CFLAGS +=3D $(EXTRA_CFLAGS)

LIBLIVEUPDATE_O :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBLIVEUPDATE_C))
TEST_PROGS :=3D $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED)
TEST_PROGS_O :=3D $(patsubst %, %.o, $(TEST_PROGS))

TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O))
TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(TEST_PROGS_O))
-include $(TEST_DEP_FILES)

$(LIBLIVEUPDATE_O): $(OUTPUT)/%.o: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

$(TEST_PROGS): %: %.o $(LIBLIVEUPDATE_O)
        $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $<
$(LIBLIVEUPDATE_O) $(LDLIBS) -o $@

EXTRA_CLEAN +=3D $(LIBLIVEUPDATE_O)
EXTRA_CLEAN +=3D $(TEST_PROGS_O)
EXTRA_CLEAN +=3D $(TEST_DEP_FILES)

