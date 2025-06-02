Return-Path: <linux-fsdevel+bounces-50326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20EACAECA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548887A351D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931920E338;
	Mon,  2 Jun 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jt+WSqEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429EE4A0F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870368; cv=none; b=S9LRXhhZmI8vXsIThXwQ0dCRCtZax9fPT8n0p0e3rLweKvRsjz+GlDKgHY8Ky0ORfdjtZmGK+VICKAj2mD5IyC/LILksofTdAW0E5llXZJjKXDNvucVTPOAZYM332OrI1mV+fHpWGETDybur3frW9P6h+++xkkziRIAb5QvOT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870368; c=relaxed/simple;
	bh=urOJkX2VjWSvjtiwfgDrnKakD4pvfzNkU4bAqbjE+Lg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sUKXIZq6v7do+XPepfCASmRhu1xVQux+NIlV13PFiDwsFTrPh5YPx89aatpERESLcWZisOB999QwuUTGkCg2eu1JeF1Wdhrd0NJa6FJzzRsUstRXHZp15EHIXXWfj0iAH6ai3bjyJJe27Hro1FTqNvmr89PvQQJGqLcNKeSb9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jt+WSqEB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43e277198so29772251cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1748870364; x=1749475164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hNeIv0nkqI8i4I6qvdfHDcZqAUy2I6oKFEk2iwT02ZU=;
        b=jt+WSqEB7Xcev5d272aI4P/K5v/unhe4k/+bHCNfLxcZyI78UanGn1BGh3bk8ysm/g
         pM9Uiq0WLcQfvyUoIXyaB0SEkTRFriT5jwAYWbQq4bK3PoQIMRrIH0G1axTU3Cbovfdb
         zkPgBcpYnXdrxKz/h2K322Y8BHaPuRZIRpSA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870364; x=1749475164;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNeIv0nkqI8i4I6qvdfHDcZqAUy2I6oKFEk2iwT02ZU=;
        b=OOH4hwsTleY1x8a5XtkHJS8BxVEcXCPC2923oB07h8spT0nO9X+kQIX2Yo6gUWdU7Q
         ILnC6+jR7BFVE0kYx1Qo0jIXioaNoL/DxILoK3ewnFyPVZzvtWPXPDZqBPWowaTnUNKi
         Yg2tx4KiuMr+JMNHd5SSgqF1wi2PvXHsuhLfdlMVmTvZxG9DdHGZVa9TEb2YBStwfzFN
         FEgkJC46zuDjJOLtrRPYgYfXy8gr9DlDGjEbZT+MQZgvo+a/TvE8BPk6+nx07S0KPVTw
         1+S6dI6wAlx5BeqRCILclBhaqO/GnkfPHdcmwSM2IX0rj6xg1PzfSmaj1h4vzURCoGoq
         gl/Q==
X-Gm-Message-State: AOJu0Yw9EHok6AiGiNgJHsyCJ55x3+9OX/pvl5YmemDW/ufvY55KR3j5
	PibAB7EupuSG0D56QsnyKxQz+juV8Zq/FHUFexcVo7SzSYbsZB0ZLdEA9QRCjzI2KcpCY/H3vMq
	t4kqxDL5ZsbYRugSjA53MnbER6SKVorVd7SLOT7DqIIglYCjATusMYuw=
X-Gm-Gg: ASbGncveTfGOcgZv1LvyTXrXDBLow/QWi09YyuEExJ448aCjwYPZmd9SeRZEUSn4K8G
	TRzPb7DBxql4FFUtmxBblxjVHRKeEk0aOiKrOswol9W0NkiSAx4t8za+kjoRg/Wh/uVRdJjvS12
	hrbgOoxBJIamjdl7XJewA9NfZBSEizVG0=
X-Google-Smtp-Source: AGHT+IEqIX8uBNZUeXHVbIz/ByVsdfNk1YkCWbKwHXwV4z/QG9MV95SEQtbIlnvdSjm7wzaXzKGQ6VmxZihpWuWuYys=
X-Received: by 2002:a05:622a:4d96:b0:4a4:3a45:a870 with SMTP id
 d75a77b69052e-4a4aed86be6mr152401871cf.41.1748870363569; Mon, 02 Jun 2025
 06:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Jun 2025 15:19:12 +0200
X-Gm-Features: AX0GCFvw7gX-uNdjKLeV2woDtV5Y5MaBSm2beYIlJgsMM4lk09sgtGqTtt8oGcg
Message-ID: <CAJfpegspRzFpTreohM56=ztnjaU2gVFYnvF2WETaD+LiymB8WQ@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c799f60636969cd7"

--000000000000c799f60636969cd7
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.16

- Remove tmp page copying in writeback path (Joanne).  This removes
~300 lines and with that a lot of complexity related to avoiding
reclaim related deadlock.  The old mechanism is replaced with a
mapping flag that tells the MM not to block reclaim waiting for
writeback to complete.  The MM parts have been reviewed/acked by
respective maintainers.

- Convert more code to handle large folios (Joanne).  This still just
adds the code to deal with large folios and does not enable them yet.

- Allow invalidating all cached lookups atomically (Luis Henriques).
This feature is useful for CernVMFS, which currently does this
iteratively.

- Align write prefaulting in fuse with generic one (Dave Hansen)

- Fix race causing invalid data to be cached when setting attributes
on different nodes of a distributed fs (Guang Yuan Wu)

- Update documentation for passthrough (Chen Linxuan)

- Add fdinfo about the device number associated with an opened
/dev/fuse instance (Chen Linxuan)

- Increase readdir buffer size (Miklos).  This depends on a patch to
VFS readdir code that was already merged through Christians tree.

- Optimize io-uring request expiration (Joanne)

- Misc cleanups

There's conflict with commit 74e6ee62a894 ("fuse: drop usage of
folio_index") the first hunk of which just gets evicted with the tmp
page cleanup and the second one needs to apply the trivial
folio_index(folio) -> folio->index conversion to my version.
Resolution attached.

Thanks,
Miklos
---

Chen Linxuan (3):
      MAINTAINERS: update filter of FUSE documentation
      docs: filesystems: add fuse-passthrough.rst
      fs: fuse: add dev id to /dev/fuse fdinfo

Dave Hansen (1):
      fuse: Move prefaulting out of hot write path

Guang Yuan Wu (1):
      fuse: fix race between concurrent setattrs from multiple nodes

Jiale Yang (1):
      fuse: change 'unsigned' to 'unsigned int'

Joanne Koong (15):
      fuse: Convert 'write' to a bit-field in struct fuse_copy_state
      fuse: use boolean bit-fields in struct fuse_copy_state
      fuse: optimize over-io-uring request expiration check
      mm: skip folio reclaim in legacy memcg contexts for deadlockable mappings
      fuse: remove tmp folio for writebacks and internal rb tree
      fuse: support copying large folios
      fuse: support large folios for retrieves
      fuse: refactor fuse_fill_write_pages()
      fuse: support large folios for writethrough writes
      fuse: support large folios for folio reads
      fuse: support large folios for symlinks
      fuse: support large folios for stores
      fuse: support large folios for queued writes
      fuse: support large folios for readahead
      fuse: support large folios for writeback

Luis Henriques (1):
      fuse: add more control over cache invalidation behaviour

Miklos Szeredi (3):
      fuse: don't allow signals to interrupt getdents copying
      readdir: supply dir_context.count as readdir buffer size hint
      fuse: increase readdir buffer size

---
 Documentation/filesystems/fuse-passthrough.rst | 133 +++++++
 Documentation/filesystems/index.rst            |   1 +
 MAINTAINERS                                    |   2 +-
 fs/exportfs/expfs.c                            |   1 +
 fs/fuse/dev.c                                  | 182 ++++++----
 fs/fuse/dev_uring.c                            |  34 +-
 fs/fuse/dir.c                                  |  46 ++-
 fs/fuse/file.c                                 | 474 ++++++-------------------
 fs/fuse/fuse_dev_i.h                           |   9 +-
 fs/fuse/fuse_i.h                               |  10 +-
 fs/fuse/inode.c                                |  11 +-
 fs/fuse/readdir.c                              |  40 +--
 fs/overlayfs/readdir.c                         |  12 +-
 fs/readdir.c                                   |  47 ++-
 include/linux/fs.h                             |  10 +
 include/linux/pagemap.h                        |  11 +
 include/uapi/linux/fuse.h                      |   6 +-
 mm/vmscan.c                                    |  12 +-
 18 files changed, 519 insertions(+), 522 deletions(-)
 create mode 100644 Documentation/filesystems/fuse-passthrough.rst

--000000000000c799f60636969cd7
Content-Type: text/x-patch; charset="US-ASCII"; name="conflict-res.patch"
Content-Disposition: attachment; filename="conflict-res.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbf44ewu0>
X-Attachment-Id: f_mbf44ewu0

ZGlmZiAtLWNjIGZzL2Z1c2UvZmlsZS5jCmluZGV4IDZmMTlhNGRhYTU1OSwzZDBiMzNiZTM4MjQu
LjAwMDAwMDAwMDAwMAotLS0gYS9mcy9mdXNlL2ZpbGUuYworKysgYi9mcy9mdXNlL2ZpbGUuYwpA
QEAgLTIzNDksNyAtMjExOCw3ICsyMTE4LDcgQEBAIHN0YXRpYyBib29sIGZ1c2Vfd3JpdGVwYWdl
X25lZWRfc2VuZChzdAogIAkJcmV0dXJuIHRydWU7CiAgCiAgCS8qIERpc2NvbnRpbnVpdHkgKi8K
LSAJaWYgKGRhdGEtPm9yaWdfZm9saW9zW2FwLT5udW1fZm9saW9zIC0gMV0tPmluZGV4ICsgMSAh
PSBmb2xpby0+aW5kZXgpCiAtCWlmIChmb2xpb19uZXh0X2luZGV4KGFwLT5mb2xpb3NbYXAtPm51
bV9mb2xpb3MgLSAxXSkgIT0gZm9saW9faW5kZXgoZm9saW8pKQorKwlpZiAoZm9saW9fbmV4dF9p
bmRleChhcC0+Zm9saW9zW2FwLT5udW1fZm9saW9zIC0gMV0pICE9IGZvbGlvLT5pbmRleAogIAkJ
cmV0dXJuIHRydWU7CiAgCiAgCS8qIE5lZWQgdG8gZ3JvdyB0aGUgcGFnZXMgYXJyYXk/ICBJZiBz
bywgZGlkIHRoZSBleHBhbnNpb24gZmFpbD8gKi8K
--000000000000c799f60636969cd7--

