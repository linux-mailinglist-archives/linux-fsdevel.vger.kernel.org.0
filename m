Return-Path: <linux-fsdevel+bounces-65946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C64C16689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4604E06C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BF34EEF2;
	Tue, 28 Oct 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdctLMHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3D30B501
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675100; cv=none; b=aaj3EisaK+MHLC8upNJYoCyHzknPF6SWibduVoWkEOP6uiOjsxyxHRRxOI7TzNGSoOwfV+N0RxvoWCSuRnN0JL1cxvaTcvxS4hUIFOhyGgAY9GsrsOlb3A/dgSQoRZADzdit0CZugXtYGScWRgD86baRMvJv692NzV1w6Ao5a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675100; c=relaxed/simple;
	bh=RaoOxtf4tynpAQhWGZ+VoiaGvDp+WDU2t51rMJIc05I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+jtCyL2ZZbPVeJumYAbTcKajp12dOfWWAZuvOib9demyitnN/8YYjflslXbCXLGUzmFAm8NneSdXAImlEZet4h1xOg/XsFOzLLl2V02DedQBameBstFFvN4nQ4/0q6Zoyn2vbL4/pwVwz6qGdGBeFyslens8u2vm/jft15w2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdctLMHB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6a73db16efso5973180a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675099; x=1762279899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZGcSb3KMjunEwsGl73wpUetGy5CQKMWrqjXg4vjIUY=;
        b=WdctLMHBzOnhdTW2THvt0JuFx9slGvNoxmWfKh1oLHp2LrFJ1ApW/pzUgqCyOnhkvu
         pdqityLrtydBjNx05kZCXdpuluAJfYxXjDUy7AE6N3KbB8qPxJ9NYD5u6JBliZkr5f5a
         e1+1sdYPwKsSouFTwwosgmTchx2VD1VRj4Mv/2BoSazR31LEijAHu2N0PiGytm29YrK6
         /i4nrvZguMh70WfYjhzWtmiGS1suNS9C/Lm0Q/6KgXbnbO6XJl3sUgXHFAl0zFgJ8214
         K2uiMhORGiVN9hMOL5klNAVk6xZAUInVjCZldBv44VWiyLYp3u+wpFMrnvcnDCfA0+Jz
         8/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675099; x=1762279899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZGcSb3KMjunEwsGl73wpUetGy5CQKMWrqjXg4vjIUY=;
        b=vnhYoqNykKgCDxaaeZMXZMdk+fd4s0eN+H2+FQUmFfYwED6HABtpFak0yEk44DOFRb
         beYdnlObEj1n9oRA29frfsz0SMrjbTSYLfZnCTms5kNFT/sTSMZw3oxyn4D98lDGQoVi
         /Y0NWi6WgcwY1/vLx8QzJgbq3aJ1LdzvdPMMbyhbx/KLJPpksGvGyS7bUIWMxOnQiy2P
         BPRQnS0p2ze+/drN+DtiNqw/eV4jefn3hsQL8YCVSclo6MBGjsjCbyabtsYC+i7wTYF9
         ITfWCx0x5p9UEfD3J0DDtBTkOd4S1psd6Nzw8V8qPSb9YdDl/IW0LExXvr1C/20PVCcp
         yRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8X027pNIvRQActFJYHwC/pt+A71uIlLeUNWP03JCsee8oksEGOfSBRTqd5+MyRpfIJ3FwgZZVYzrYAZv@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3NakqV5khMLnd8lDNnr9ahXMe/9OTB5ki2cDIw77XQFGjfbD
	qAzhp+X/AG8FF8EUdkfKA6uGcg9KWW/pEZK86jjlrWfZSUwXNG+mbkgQ
X-Gm-Gg: ASbGnctvUtGu1NbCBqOB30tWHdPWsIiYyY67uzAdUlpuZJi5il3HsE0cz8Gv/I7xIlu
	8q0+hLq9uXJ+L9HgwMmd/KIMuC3XF6p/EYRVFzDJQu6PjqBQXtes7Bo9uezyYYscDk4wI+tPnBb
	FVPeuA6d5l0l+wexpkvUaI/QWXnUqvVEvehzE8M08IJdc9OT8GWKUvl+nuZ3LHxBfuO81+qaum1
	LlgRUvP1a7TTwT+RJCbevDhtJeGN53qLrcgOvtPHPkQF1WBcJvNR6cqqgu0t8jBEBU+76IdjhqN
	75Hkm06N+pxINK5KJMQKM+tzll2l8E8j7CrBDpZlOqVCfwzcoXRLTiv0xKHcGrgc3qIh6/Lq2kS
	XdK+tAO5g5UQbUfOyH+cU61ZHecAoiMPlYxMlPMytzHRpSOVpMmBhTwtzodZpD5vNghGoW1/zdq
	usri92xHwR8qeQ8N8lL64cXGQu/1s=
X-Google-Smtp-Source: AGHT+IHLwp71b/86DO67O5tY8yiWwcJqECkddhQ1WX2CNzJj89RlLwXijSCXK655bsOO+K3Jpu3vhQ==
X-Received: by 2002:a17:902:d2cd:b0:281:613:844b with SMTP id d9443c01a7336-294def312a6mr860865ad.52.1761675098666;
        Tue, 28 Oct 2025 11:11:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm122720055ad.55.2025.10.28.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:11:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] vfs-6.19.iomap commit 51311f045375 fixups
Date: Tue, 28 Oct 2025 11:11:31 -0700
Message-ID: <20251028181133.1285219-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are two fixups for commit 51311f045375 ("iomap: track pending read
bytes more optimally") in the vfs-6.19.iomap branch. It would be great
if these could get folded into that original commit, if possible.

The fix for the race was locally tested by running generic/051 in a loop on an
xfs filesystem with 1k block size, as reported by Brian in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t 

Changelog:
v2 -> v3:
Fix the race by adding a bias instead of returning from iomap_read_end() early.

v2: https://lore.kernel.org/linux-fsdevel/20251027181245.2657535-1-joannelkoong@gmail.com/
v1: https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joannelkoong@gmail.com/#t

Joanne Koong (2):
  iomap: rename bytes_pending/bytes_accounted to
    bytes_submitted/bytes_not_submitted
  iomap: fix race when reading in all bytes of a folio

 fs/iomap/buffered-io.c | 75 +++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 19 deletions(-)

-- 
2.47.3


