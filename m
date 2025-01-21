Return-Path: <linux-fsdevel+bounces-39763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB31A17CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D5D3AAFF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8091F0E44;
	Tue, 21 Jan 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbDMEj8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AB1B4137;
	Tue, 21 Jan 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457704; cv=none; b=UfezLiYFmwaz0gE2VqWm0ueG0eany2UKesCs77eN+Y/3ORGzWCm7CvZPXv9bW0BUQm5ZbxLcd7Z7bs87HOAc47IV3GehIXaEyCzV/IDScY9RXESqlxnNfUDd00S5YcRPGOfgcwf9tLvxYlL0/0QJH0YbQKMEgpIQQX/NfoJDuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457704; c=relaxed/simple;
	bh=tjc/uPo3nNub+LJy3NyJOpyez0cgIB0HTgYXsItmdIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qy95J0ZJr9g3bmr+0kB+xLjjgNaoP7T/LP9CLJ1nLGLDcTOyKrFL3Pp6B2Wv2NpSnDKnrkKlz5M5M2rTOAMSLRLKebbci1f7405FHqNQg6VuCSFsirKYfkM4pcBrA1zU+kBQxsp5kMrM0pUhc3dr0PM7TgvJ0IZ/NGwne13vVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbDMEj8S; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso8255746a12.0;
        Tue, 21 Jan 2025 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457701; x=1738062501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3cnZir4QJpKXLEKnJWS7QFyO1/v96Jr+h1cl7sS99I=;
        b=jbDMEj8Sek9vIMDRhfW5UD/vQie6iz3zC8ri0folWCAaM8DPgepVQeD3fPalkTlm04
         isd4+h1XE8bQgKUAh7MybUNGua0p6k9fmUUDgmVT55Q3XQF6r3FEhEle/ont5Zj8pXIT
         F+X5qHiNjU5i7R/QbYPX0Ncc/zIrLfVlAZNBUMlbK9hSO0naf6PNkxf3e0YIXeebyXbY
         d7DLl7xm3V4R7tlYb0YvSXvzFxwaz0Xkmia3q0QRDhldwnyWKSifU5aIBjuXHliasf/2
         M5P7feLADKI+QnrjNueEF3V4uJvhvk7SYXM5hYq7AojHIkO39CUaTpP3sq7Zu6IsC/TR
         6jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457701; x=1738062501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3cnZir4QJpKXLEKnJWS7QFyO1/v96Jr+h1cl7sS99I=;
        b=lGZMENVh8R+ZRXzAVumuY+Z4sMUahY/VZgVJjaWKd1AJbDl2PH3+nrV9HycPpHbthw
         Uxz4o0zdaxGmwjFZ27rXFPBu+8CTJ5Out/OFJeAS5Q3hPaUSIgNUM0mZ4BeHwzZRk1Qn
         mtxByBw9wfCWtkZtzMFzr3bR0Nh715cSjBEpUXiQ2TLrImrsVHpupkJBovIDYTeLAmH2
         k0/h6noemGxORno0no9E2oXkloYCBu+/88IexxoWg261X2SHGavva+0nmoUfi3cQYVM4
         dOxvtmNqx9MWBbiyPezCdL++8edfGIRwRk+Vt3NWeSlWLOcNZCVhvU86EKF4cyLJpbMf
         MEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVVyF2WD0WPXnMcdim6kghh9jPCEQq7MoAbETwh+n/YLf2vgoai+lQMt3aHB7LW8OtNVdOrQ+9dvuZrVawqsg==@vger.kernel.org, AJvYcCVW8QHlEoQ5X9jYT9iXAKbVf+VDazpXHr3ETFml08Xxck7s/8aFKzma+UExQ4FDJpnn6JARNFBF@vger.kernel.org, AJvYcCX3g2LyyRMpMzkPOUcBxEf1C+nLoaGOeU3mWtrLxbISx0XLMmmjVOFGv/5oz7oS6ea6k3hwhqDEzBjdPhud@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3dEYWIu8a066POXWzaaBpuYvedpHZBkfH2NI/B40R07A9/k0
	TwD9YANR2YOGQGd2FSLfUfH6fIXp2x/k2wtnB340mJI72pn1vYm7
X-Gm-Gg: ASbGncu1/gNsTu/WWgRG+hSExEdlVsJteb6WgQ0icP3NUoF5eqAZFnfEm9aEWJlkcQ5
	dIUw/Tl+Zq7DixAnZyBghw35GUCC92tWidQ+nwvJ2g/LExtHcUPdC5JiwGw2l7UfhRXWy9gBnxg
	Iy36D6QqPaIjIs2RNA95ZDdrxR2I71NYM9ta50gwfnmR/jITaseycwoZnxhDXyAxvrewQjTUPiK
	mLUfl+nB+3EeW3HEgLWNoCI9HPwbVsCzmOO7lbhAC9EqnbPflxwICcvfmh+rvEHo5C6QxV2EzQM
	WNWyqILZbb9vcogFY1+qQN4gng5hC5S+BiqcrNb5dDK6wJSNzSggAib/ikmpPh6r82k=
X-Google-Smtp-Source: AGHT+IE3VHSr3TqES+WOuCj3CUZR5hXZwthFxa/1nxuHszK/a2Y/T/8ShY3DS7Cl9tcOSeLfd4pa8Q==
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr38552384a12.24.1737457700553;
        Tue, 21 Jan 2025 03:08:20 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d28sm7209841a12.40.2025.01.21.03.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:08:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	Dmitry Safonov <dima@arista.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6 0/3] Manual backport of overlayfs fixes from v6.6.72
Date: Tue, 21 Jan 2025 12:08:12 +0100
Message-Id: <20250121110815.416785-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greg,

Per your request, here is a manual backport of the overlayfs fixes that
were applied in v6.6.72 and reverted in v6.6.73.

For the record, this overlayfs series from v6.7 [2] changes subtle
internal semantics across overlayfs code, which are not detectable by
build error and therefore are a backporting landmine.

This is exactly what happened with the automatic apply of dependecy
patch in v6.6.72.

I will try to be extra diligent about review of auto backports below
v6.7 from now on.

Luckily, the leaked mount reference was caught by a vfs assertion and
promptly reported by Ignat from Cloudflare team.

Thanks!
Amir.

[1] https://lore.kernel.org/stable/2025012123-cable-reburial-568e@gregkh/
[2] https://lore.kernel.org/linux-unionfs/20230816152334.924960-1-amir73il@gmail.com/

Amir Goldstein (3):
  ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
  ovl: support encoding fid from inode with no alias
  fs: relax assertions on failure to encode file handles

 fs/notify/fdinfo.c       |  4 +---
 fs/overlayfs/copy_up.c   | 16 ++++++-------
 fs/overlayfs/export.c    | 49 ++++++++++++++++++++++------------------
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  2 +-
 5 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.34.1


