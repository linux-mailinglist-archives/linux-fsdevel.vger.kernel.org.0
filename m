Return-Path: <linux-fsdevel+bounces-65019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3BBF9C27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3571119C50DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BA203710;
	Wed, 22 Oct 2025 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPaFsug9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99D18DF80
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101127; cv=none; b=mcXKxiA/GqArR269djwyT6x8cxNjoQz3wAOStHvSNNYWU6kmXDM0PlHSBii+vtQSk9IVt8AIyhtUX0pnHn/TdO/pU2SztcFkkNZvQvHOnRYTo7C0imkijIg60Xj+JG3xSK6Cdnka+Y0wSFnGSh8vKXHG3/ulE8tEXTvQLVS8m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101127; c=relaxed/simple;
	bh=eAcIJAMH8RyaOLUFKIfGMYGdTUyHv9MGn07YWGY72Yc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W1dYeExuzUOmsNqJNotjmLifz/JLrc9ZSeuuxWxHYoBfu+PdKK4JyzWmUkNeV5qlLSK61j6W1ouBidx3fEANf9KIWN0eKPZkiaVIf9FTKqBub9d7FKVmxrjSNXnqBDOci39YDfpBFzigZLezbIuciekJI2jnBlmnMJ06H88HcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPaFsug9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b54f55a290cso959290766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101124; x=1761705924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lq2jjLsl5/bNBz+EC4uaN0bKVsmnxh0AOoBuKPfAEzY=;
        b=HPaFsug9UpJ4B3490WAtRKV6sy+mIZscgDf9EzvH8ZDuStHM4gdXZuPHbbGvjSho4z
         E+lKZdLPqIuqhWIYnp4W0q00OXl8B1x8KZyXkQatNHI6x2lNKQDMAaVND8gUPa7RinYF
         Zj9Abr8DKir+wPiCaqTTaPgN2Nm5MTnuGTH1wr5fcGsaI9somN4rWQqvt9O2U7Ikpd8N
         Amqdnqnr7s1X+SsmkgabOLSz4IHLVhFvcOUv06mYVBjuneQh5mYWG3/r/iAOojFURdEY
         uMdZsQA++e34N548hbb+EPlktUzXvAVgtzjpWeJDT6lMygMDDBwcDXCxe5XGOLxYtYdt
         noqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101124; x=1761705924;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lq2jjLsl5/bNBz+EC4uaN0bKVsmnxh0AOoBuKPfAEzY=;
        b=djPj6SNZRxpMx0UD13bZEZc5jMHVHVbaidBYWuIOA0WZ3qcwFnL+R9gvFKnA5xoNfp
         xDSEdy/DPjVdGN08s5epO38s786604hyXLtZG6yGOQJIUs3rkG8K64sj6ZOmgWekgBH6
         kUDSyiHbFFG++MtoK6ttInDovrGfgfY1EmOOyIdnm3vUs+sM4N3IrWeYaQDIttOw/17U
         PB/fDV3jzMc7elrUaA9MdVTnCIVjDkvvTUjxpJG+UzHALBKJvWeualaSEx5EwiEFjbjR
         jbCJS/1BCbD393dZulu7JHCdTSdHRf9hECPUHYNoABTURS6Jh/12sIl3O4LCql6yjYO9
         ijrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZZde02kisZFusCzbA81aw0iuzvR/HeQJp53cGVDM8fsqtHHAhEIiPzHUVaLJY2YmVm+OAz3yUZVj5rC7q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21k9Wxcgp5OwPBafiQYuklm94bN9e09rm08aeX7vVUlaQoMdP
	zPJfLW0LIytCA000DDsheBEBCGKsY/lwEw1IGoILySU0B/Kn1kTcKun69dWZw9H2KvcV1z4CPWi
	kiqVTajOVP7m4fpcJLv0KonSVLRv0B20=
X-Gm-Gg: ASbGncvSwu2aro7Gpb42zthWdgUZNynp7E1RnTYTX384Gz9dZkYoKp2KGsb61Nk507b
	nvrj8XATGABlIsQ2WrbeIxtdbhe74BnLT+0A/9gwtk/VuKCjPgZZ1HASneHEBylD4AzkBqlm3FN
	iXEsE2mLXcxQWcGgRJOtRwzyL3Ocf1PvEAGg1gdXZaM16+HHEZqmeL2EcHJF13drUSJ90SLu12P
	3ASaW93zbde0+lHJvB1YkFdTM5AqN9VlFObjdyZPKG+D2R1E2qSxBAC3xOtkA0=
X-Google-Smtp-Source: AGHT+IFzqNo4QzZ1WnPmf2YSkO/3brp2YxIg4GKpGj44en2ic6JhjtUg3luPUNaA3+TTCkgHSJO+n/jbZzZ4eOcucxc=
X-Received: by 2002:a17:907:3f17:b0:b3e:f89e:9840 with SMTP id
 a640c23a62f3a-b6473242102mr2269139866b.20.1761101122985; Tue, 21 Oct 2025
 19:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 22 Oct 2025 10:44:45 +0800
X-Gm-Features: AS18NWCeORSgmXNohzwlr2_oj1p-NbS5QMAaG1LhUMS3O__rfHvgA71-0O9bb5c
Message-ID: <CANypQFbLkw50aXkdjTbYT2S6me5yowReL2asG__MWveMU=vW0g@mail.gmail.com>
Subject: [DISCUSS] Security implications of slab-out-of-bounds Read issue in hfsplus_strcasecmp
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, Jiaming Zhang <r772577952@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi HFS+ maintainers,

I am starting this thread to discuss the security implications of an
issue in the HFS+ filesystem and to seek your suggestions on whether
it should be assigned a CVE.  I discussed this with the CVE team
earlier, and they suggested I seek opinions from the filesystem
maintainers.

The issue is a slab-out-of-bounds read in hfsplus_strcasecmp(), fixed
by commit 42520df65bf6 ("hfsplus: fix slab-out-of-bounds read in
hfsplus_strcasecmp()"). The issue can be triggered by a corrupted
filesystem image. I also tried to use `fsck.hfsplus` to fix the image,
but the fix failed (exiting with code 8), meaning it would not be
auto-mounted.

This phenomenon means that the barrier to issue exploitation is
relatively high, but I believe the issue's impact still warrants a CVE
for the following reason: it involves kernel-level memory corruption.
If a privileged user attempts to mount a specially crafted HFS+ image
manually, this issue can be triggered, leading to a kernel panic and a
system crash.

A reliable, user-triggered kernel Denial of Service (DoS) is generally
considered a security issue worth tracking.

Given this, I would greatly appreciate your suggestions on whether a
CVE should be assigned to this issue. If you agree, I will follow up
with the CVE team to proceed with the assignment process.

Original issue report:
https://lore.kernel.org/all/CANypQFak7_YYBa_zpa8YmoYzekV_f39jvWJ-STudDUTR2-B_3Q@mail.gmail.com/

Thank you for your time and expertise.

Best regards,
Jiaming Zhang

