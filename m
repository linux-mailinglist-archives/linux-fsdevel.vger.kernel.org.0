Return-Path: <linux-fsdevel+bounces-50745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97EFACF256
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF4171191
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5E17FAC2;
	Thu,  5 Jun 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NBZTrUCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270815746F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135100; cv=none; b=pnVaeTo8MT0lXN2TTfAFiiG8umZlJp7oQZ185vJxafqElhKncGngfSGnOS+RosXGsktAwZ5uDEdS7/xW46AnnUlZxIPMP6QSRPOQoQ+nbvE1q0pHtfXxpCb7KY49ojLKLklv3CzRMu+J43dFhFyQx2tMaHvv9W9Eu6F0fbjlB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135100; c=relaxed/simple;
	bh=8opYR/RLHE+c4NG9PfiIatcqdYIIGlAtUPp/Y7mK/SA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WfCQwpyyCK8qt27sIFKjsDCycu0sv03iKbwPYZbyOPBWwU6XnI3GVTsqL/HoYLp/3jEqnlqgi6Er7ga/iKMKbsmPEk81f8MtVV9+nzHb/cAhOpnn4Mq8efiMQgShdXqi4Sn//G8yBJpEXOaN+Y4VjKq7KkkOGP8w5nJQ8R2lcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NBZTrUCA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3109f106867so1269242a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749135096; x=1749739896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qZIyhLNfUK8aRt0IjyGDdUz2kW/fFohhjPr9dq+tBQ=;
        b=NBZTrUCAOFNHNKaNR1pMpY0OmZymhLr4tCFdRB2u0yaH7w1La81nyRMFckOIXB6vAY
         fpmL/1pLqEeL2llYJbkMPfgIax/dy/GhGChv7uuhkCU7zV0Aeg+eHpQgU6qBRDUD+3kk
         q60PwuBj6Hjtkhb6T5J3yTPqRrGMdUfUTNlG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135096; x=1749739896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qZIyhLNfUK8aRt0IjyGDdUz2kW/fFohhjPr9dq+tBQ=;
        b=hSyqbXnDKU8YkyzRYQx5KmzQsH9pvSvr0glUA9osw2QKdZ9gnF4LAHOF+TymzaXOlG
         6iCyS0pQjazfpUyKW4Z37c6vPlNm+I0HFg0VQ6tf3T4xZYVZhra4IK4H7Vb3lnO8WaN7
         3yYap3MCy/qnBBpS0fl8F5DafosY0jIMpcPEi1Tc1Jw735BirY+ovjWJFi639uS8wnnZ
         FaseQ/bpDAjqWfhiq0fbwE+N1GPISRvwDSvvZABWwEZ7/A2s36AfC5zvKrzl4YWg4gJz
         yCeDLpxdUXtFHUtSfJwU7LVNrUI/m1bz6DYPiCVUpBNUrnwhkZ6MrkugrJ5QMmD60kGd
         m9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVquPpVWHxJ7zG4dZAHpvee+hyZ/VQpJQKy6lW/1s4SklHt1jL0gHqYFjlriTr7cs5M2EmJ9diWyWlJJJGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wBdXFkELgTxktGXVwzO3dj+nQq53Hy/r23AX6970feaJJmnP
	ZXrvoPcLyyMn8BjK5ASrjrs+oNA1/4lCIsdfEa1xkfbcFBZKR/bEArWDMZLVrtsFB8ozXO7zb8l
	GB12AtmOxUGkdu42h7A0BapvQ0366yp+yCTBM8izJ5GjKX2tgGgGzhcFBtA==
X-Gm-Gg: ASbGncvCU5MJa9zbi2uyUW0PzlIT+5/dDykfoUDcK4F0SmD2CIQOm1rFg4RXiYN/bwM
	hc7qTjMnIbNPikXjA2kZhc1R+fRlnlykmkPDno6Lgf0W/XivR/SNxUvSh7CHV6kwbCsN194Z0y+
	zaB1uTUGn2SKTvX1AIGcmkkV6LE2ufT+M=
X-Google-Smtp-Source: AGHT+IHAbJn7akHP0pYrJh9k1QTBH4AMnJ3AUW68Wk+P5THmWTp3kCTbbGZ2EV9/S5oBNPTKOCVGI0vam2239o4+gmA=
X-Received: by 2002:a05:622a:5a0f:b0:476:7e6b:d297 with SMTP id
 d75a77b69052e-4a5a581c203mr125679031cf.41.1749135086307; Thu, 05 Jun 2025
 07:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 5 Jun 2025 16:51:15 +0200
X-Gm-Features: AX0GCFsTY9gN9NDJLz1wYsjKjFbqBwGH61myZEfMvmbdvIDQuo4OYyMlmpHjQd8
Message-ID: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
Subject: [GIT PULL] overlayfs update for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-update-6.16

- Fix a regression in getting the path of an open file (e.g.  in
/proc/PID/maps) for a nested overlayfs setup  (Andr=C3=A9 Almeida)

- The above fix contains a cast to non-const, which is not actually
needed.  So add the necessary helpers postfixed with _c that allow the
cast to be removed (touches vfs files but only in trivial ways)

- Support data-only layers and verity in a user namespace
(unprivileged composefs use case)

- Fix a gcc warning (Kees)

- Cleanups

Thanks,
Miklos

---
Andr=C3=A9 Almeida (1):
      ovl: Fix nested backing file paths

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Miklos Szeredi (4):
      ovl: make redirect/metacopy rejection consistent
      ovl: relax redirect/metacopy requirements for lower -> data redirect
      ovl: don't require "metacopy=3Don" for "verity"
      vfs: change 'struct file *' argument to 'const struct file *'
where possible

Thorsten Blum (4):
      ovl: Use str_on_off() helper in ovl_show_options()
      ovl: Replace offsetof() with struct_size() in ovl_cache_entry_new()
      ovl: Replace offsetof() with struct_size() in ovl_stack_free()
      ovl: Annotate struct ovl_entry with __counted_by()

---
 Documentation/filesystems/overlayfs.rst |  7 +++
 fs/file_table.c                         | 10 ++--
 fs/internal.h                           |  1 +
 fs/overlayfs/file.c                     |  4 +-
 fs/overlayfs/namei.c                    | 98 ++++++++++++++++++++---------=
----
 fs/overlayfs/ovl_entry.h                |  2 +-
 fs/overlayfs/params.c                   | 40 ++------------
 fs/overlayfs/readdir.c                  |  4 +-
 fs/overlayfs/util.c                     |  9 ++-
 include/linux/fs.h                      | 12 ++--
 10 files changed, 97 insertions(+), 90 deletions(-)

