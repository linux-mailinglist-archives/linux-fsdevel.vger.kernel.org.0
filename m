Return-Path: <linux-fsdevel+bounces-50996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC2AD19ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FE7A3706
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C820110B;
	Mon,  9 Jun 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihj191Ke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47F1DC9B1;
	Mon,  9 Jun 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749458369; cv=none; b=iRXjHOGAcLkM9PoDwRQaFOQDTTpIia1mCZTJsyMmQqjwIJwpW0KygMOKjuOLaV7k0LpEgOoeM2V0hU5Mgw0aQHjCWBujUJrhlA2UmfVSASg2uF646P13YvixXP+U9RZoyo/A8OuJiCtwy77uGl2tIs3+btbV1z/jmODjg2Hc4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749458369; c=relaxed/simple;
	bh=/UsCaKNq9xr/ZV75tgrXJEv56dnt1bMUFHh4Hlcfoik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MJcoLizfGjGtmPTQo69sAV45hxMU+BhuC1h7aBRtmQviJYSk0atl//suWDdXISFGm5HPtX2yiyaZmEhkUFJ1Rl19PNlCVhPO2FZr9BAapnKMqQ16jBAUc2UQjErd1PaO0yOKc0WvPPxzYt+o2uQ2t9GeGckONEpg0GiUcdjkLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihj191Ke; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87ec4ec218fso436552241.3;
        Mon, 09 Jun 2025 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749458367; x=1750063167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/UsCaKNq9xr/ZV75tgrXJEv56dnt1bMUFHh4Hlcfoik=;
        b=ihj191KeFm6w6aj+FE0LSBPosSmetHHB3MKrgzRZZN2hwWZUvlHtWfxUgW/afOXkHl
         pifeMvbMlaN/7dET7zCa2DZncAQ82cYLUwdeRR0YfzcUlZLpP1HNgWOvfAaeVl3S+5pj
         JQrE3imU3LjFGCKVEVzzvsARruGWb8jrdX8uSdXtX8wsAAS9kaqAJP1Ehu9ESF9FIl5L
         wGlVq1G2bsVidH5uplZpHX88V9xitKeB9VkXdf/cSXj0jBjqwNKzkuroCjAS7y6u6qpi
         dsuLe4CuY1YvDeTaqcW3wirHu/Q32V/xznv/ECEFrRQSKdoUmKdLJBvCXwBOrf97ER1k
         b1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749458367; x=1750063167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UsCaKNq9xr/ZV75tgrXJEv56dnt1bMUFHh4Hlcfoik=;
        b=YCeP1oJquv1gYfC0yNM6JpdqaSh/Z5n8O0cGpwNrIdKfHB59RKfInJjjxYSUNek14y
         6XbFlWLPt7M5VUbJVPmM1cuGurhEPUz9XjQ0LwuqeNS9yHKxWNgrDNEsufYQeTRlaPKk
         J+/IiofuCpxc7sr6NGDkaKxYo6AYjsG0aMhH2AFVmiLRelGMoH4WtIgsuy7VacBnUmce
         0etBRIDD60y1QlFf1kTos9+jmptR2ijfHfanx2AKeE6S4+klo8RUaLEtdDVrmKbikQvA
         kJJMU2b8I+U3YEO9siiE6w4Y2Pkg8/ySqtVAYxAezD+Q232RTKtU1BYM85LvOb/f6c4t
         CwKg==
X-Forwarded-Encrypted: i=1; AJvYcCVhlNIhQ7ttsXuI0Lm//fPc7QDCohs6hD8td498rwNirB0BBuMRn2xi7Vh5uiyqNLnam0VEmqKjYqxw2+bO@vger.kernel.org, AJvYcCXV8uhS96NWxglWV7Y/NNB2c16x/J4FBPvdS18r8hFSxj78PG59WZmcC0ABinZKWJ2lFrrHVJooopdtlh67@vger.kernel.org
X-Gm-Message-State: AOJu0YywEZL/cTjlwkyqPQXLrWI9J9EZ+hztPyIsTHDiOBN1i/j94c+Q
	XxzTvHrnY1Z44S2JKC5FjIdPXIuW/MNkmH/tYQ5pjY6gNfTZFPoxWXDxec4BKOisqZepSvHDdXr
	8Sc3rMMvYi98psTbIrFeY0ykPOTk/pgI=
X-Gm-Gg: ASbGncu7Pw1khCi+IU+XDr0qlh9ogk++cyJihnM4BvO41hA7PbUVXet67CP/6njrBRa
	4nYKNbSbRx7IIIBEix5foWbxTJ66IevwJZjZ5l0CPI5MCi5nocIODeovpUE1FzkeAQfz+waXEcw
	A0JKBu/EuQa0tXmt+h0BlTLY0SzZCGe394wnXpIx1nd/oC
X-Google-Smtp-Source: AGHT+IHZ+RmLpJDZTbVTVwoTCs1bK4jc+HO9jPbYukLPZZYG9zdYTxniq9Niz2zidvAHAcEe3SUAHquojh2Mu26SuA4=
X-Received: by 2002:a05:6102:1624:b0:4e5:97e3:a97 with SMTP id
 ada2fe7eead31-4e77290bbcemr8896811137.15.1749458366852; Mon, 09 Jun 2025
 01:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Mon, 9 Jun 2025 16:39:15 +0800
X-Gm-Features: AX0GCFtNYI-b3kfkcuPR5qDCZr7Uh9Bc8u-dvALgXtAxekpV1d89-_tR1kKiX9A
Message-ID: <CAOU40uAjmLO9f0LOGqPdVd5wpiFK6QaT+UwiNvRoBXhVnKcDbw@mail.gmail.com>
Subject: [BUG] WARNING in bdev_getblk
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I encountered a kernel WARNING in the function bdev_getblk() when
fuzzing the Linux 6.12 kernel using Syzkaller. The crash occurs during
a block buffer allocation path, where __alloc_pages_noprof() fails
under memory pressure, and triggers a WARNING due to an internal
allocation failure.

Root Cause:

Code Path: The failure originates from the function bdev_getblk() in
fs/buffer.c, which attempts to allocate a new buffer via
grow_buffers() =E2=86=92 grow_dev_folio() =E2=86=92 __filemap_get_folio().
Memory Allocation Failure: Under specific memory pressure and
vm.zone_reclaim_mode settings, the internal call to alloc_pages() in
__alloc_pages_noprof() fails, resulting in the observed warning.

I recommend reviewing the block buffer allocation path in
bdev_getblk(), particularly how it handles allocation failures under
memory pressure.

This can be reproduced on:

HEAD commit:

commit adc218676eef25575469234709c2d87185ca223a

report: https://pastebin.com/raw/wqAeZJxF

console output : https://pastebin.com/raw/aLaVQpzR

kernel config : https://pastebin.com/x48ijkN8

C reproducer : https://pastebin.com/raw/whJgYnHk

Best regards,

Xianying

