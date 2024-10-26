Return-Path: <linux-fsdevel+bounces-33018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACA9B19F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2C1F21C35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126191D2F67;
	Sat, 26 Oct 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoLks4qh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117C13B2A8;
	Sat, 26 Oct 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961897; cv=none; b=UVJVFNfhEWYfqw9aJeTErAcJNpcBShcqQY8BkaULKtdio6kbDrgT0VtWXEXsZMEyUczNEag8rrrJKlLq8RULnLrLOQkwLJqURbW32t18aEfd3I0fN7IlYfClGd2yEgAg8a/wMMSE8Blj03mlZG+8DHcZSD7nCEVG/XSMHaRDKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961897; c=relaxed/simple;
	bh=Uoa1yBXZoSBbrjrl4LS4sVenPiHdm/MZ5en50telem8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n0qASipxfIQTUsFyBoWfvnUXeaZJwPSFp3La7Ys1XqwsZ1HCXI74y1ocX1lHnGEqBz63ugtKeFMfV2HJe4B110gPHjBYgliPJCu4N55IxE9UVi6sP0GFzhH/J42Lr5Vfrb4DhA24r0RllP8V+yh7j4xqLDrfJAWSv9SBZL8yeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoLks4qh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbd092f7f0so21421706d6.0;
        Sat, 26 Oct 2024 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729961893; x=1730566693; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMZfwdkUBwCJp9Vo4PM2HvHKSsl3blcRgdTaXW2AdMY=;
        b=MoLks4qhGf+NBD/fkWvK8DjE3hTZfdv8lar4hy5fhkD6pJSx5xoHhAicd/dCVHwk1E
         VvYeiBAQffXjFzdFRQ9shYoXLdg8waXk7gnPScXSJN0C4cQPsvwxd2l6CfgDWLa4rgK1
         ERiyb9ginLcJOQ5khV/iwrANxdKP/WmS8xZevr+essU42ikS3LHMA4TYx+LPTCBtrp46
         L/LXPq/7qJxpbFAL78jC5IJidPdcTI0f/rkh1iuBYUqfFxh24qROuQ0i8TbHNQK5rgpv
         RX58HFi/4psMbIM2lLLu+5f7GfbE7E/vUGhGvpFSB9ATOgdngSxzM6OIJ5aKXgHBwYUy
         KYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729961893; x=1730566693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMZfwdkUBwCJp9Vo4PM2HvHKSsl3blcRgdTaXW2AdMY=;
        b=YsqsFKFFuRTI5e5bktUeAQ57n8B1gB1nDqFSdb2HfC1HIBFEqqFUTe8EBmOt4fughm
         wiefNG/33LYyGkntTHkSgd085Mw/neqXDFfykuhicJIMfMFIxw3j08FdcMn2AsL4Kx1F
         NXNqgyGBgqQr10+LEStQ8IYmQe40amfUuIvux75AxnIYEMlv9hrKik04MuarYhfsxgd9
         t7gVWpGKGQL2B+h+0LvtNUYVmyMTR4dWLHpKePAmGNq3J5LQsYYQJQopU35O3RQQ5PB9
         Yg0j3+jMWG/a7vi2ukIDsItbUYn0HSE4p5+GIOqynIPZVDFaElwQusrW5x09/G0qUzi7
         AtVw==
X-Forwarded-Encrypted: i=1; AJvYcCUlh1dKezfB4urdALsXmetakyAyElDZFAmIdPmOnG3L5L+eB4KzsETfJIcP9U8sDsW7XAMIRUsBRZQ=@vger.kernel.org, AJvYcCXnd5HIRUIX2VU0/AQ3KvGJsaAo8rRO+VjgZFOTKboUMf1MjGhBjdxsMEZxtrtJL2xp0+o6qVWELBXZ34AD@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSnmoRXKv2KGX8FVHuG8+bzunkFkk9DyiBQ1QctnPNoIs9rKQ
	ertkLsqhwofpFTuYRwsXGEd0vDs1dJaFKmJFWNbbcdjG5v729gdtPtIiXZCy
X-Google-Smtp-Source: AGHT+IHOH/bFeW7nkVd2FEp2N/8fGFbMjeSSle63Y9gXrm4MeG5/hsNrHgBg/he+YH3KD/TYpXrRmQ==
X-Received: by 2002:a05:6214:3186:b0:6cc:8705:b5cf with SMTP id 6a1803df08f44-6d1858194f9mr52933426d6.22.1729961892607;
        Sat, 26 Oct 2024 09:58:12 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a02608sm17002436d6.78.2024.10.26.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 09:58:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 26 Oct 2024 12:58:08 -0400
Subject: [PATCH v5] XArray: minor documentation improvements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-xarray-documentation-v5-1-0fd4c4e3ce35@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ8fHWcC/03MQQ6CMBBA0auQWTukbSiiK+9hXIx0gEksNUM1G
 MLdbVy5fIv/N1hYhRc4Vxsov2WRNBf4QwX9RPPIKKEYnHGNNa7FlVTpgyH1r8hzplwC7Fq2gwu
 mOYY7lPSpPMj6215vxYOmiHlSpr9Z2dnGelN71508OswURcNljCSPuk8R9v0LWDCeNaAAAAA=
X-Change-ID: 20241026-xarray-documentation-86e1f2d047db
To: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

- Replace "they" with "you" where "you" is used in the preceding
  sentence fragment.
- Mention `xa_erase` in discussion of multi-index entries.  Split this
  into a separate sentence.
- Add "call" parentheses on "xa_store" for consistency and
  linkification.
- Add caveat that `xa_store` and `xa_erase` are not equivalent in the
  presence of `XA_FLAGS_ALLOC`.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Add trailers; otherwise resend of v4. Sent as v5 due to tooling issue.
- Link to v4: https://lore.kernel.org/r/20241010214150.52895-2-tamird@gmail.com/

Changes in v4:
- Remove latent sentence fragment.

Changes in v3:
- metion `xa_erase`/`xa_store(NULL)` in multi-index entry discussion.
- mention non-equivalent of `xa_erase`/`xa_store(NULL)` in the presence
  of `XA_FLAGS_ALLOC`.

Changes in v2:
- s/use/you/ (Darrick J. Wong)
---
 Documentation/core-api/xarray.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6f8e632e7d28d17fd1c60fcf0b5c4..f6a3eef4fe7f0a84068048175cb857d566f63516 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -42,8 +42,8 @@ call xa_tag_pointer() to create an entry with a tag, xa_untag_pointer()
 to turn a tagged entry back into an untagged pointer and xa_pointer_tag()
 to retrieve the tag of an entry.  Tagged pointers use the same bits that
 are used to distinguish value entries from normal pointers, so you must
-decide whether they want to store value entries or tagged pointers in
-any particular XArray.
+decide whether you want to store value entries or tagged pointers in any
+particular XArray.
 
 The XArray does not support storing IS_ERR() pointers as some
 conflict with value entries or internal entries.
@@ -52,8 +52,9 @@ An unusual feature of the XArray is the ability to create entries which
 occupy a range of indices.  Once stored to, looking up any index in
 the range will return the same entry as looking up any other index in
 the range.  Storing to any index will store to all of them.  Multi-index
-entries can be explicitly split into smaller entries, or storing ``NULL``
-into any entry will cause the XArray to forget about the range.
+entries can be explicitly split into smaller entries. Unsetting (using
+xa_erase() or xa_store() with ``NULL``) any entry will cause the XArray
+to forget about the range.
 
 Normal API
 ==========
@@ -63,13 +64,14 @@ for statically allocated XArrays or xa_init() for dynamically
 allocated ones.  A freshly-initialised XArray contains a ``NULL``
 pointer at every index.
 
-You can then set entries using xa_store() and get entries
-using xa_load().  xa_store will overwrite any entry with the
-new entry and return the previous entry stored at that index.  You can
-use xa_erase() instead of calling xa_store() with a
-``NULL`` entry.  There is no difference between an entry that has never
-been stored to, one that has been erased and one that has most recently
-had ``NULL`` stored to it.
+You can then set entries using xa_store() and get entries using
+xa_load().  xa_store() will overwrite any entry with the new entry and
+return the previous entry stored at that index.  You can unset entries
+using xa_erase() or by setting the entry to ``NULL`` using xa_store().
+There is no difference between an entry that has never been stored to
+and one that has been erased with xa_erase(); an entry that has most
+recently had ``NULL`` stored to it is also equivalent except if the
+XArray was initialized with ``XA_FLAGS_ALLOC``.
 
 You can conditionally replace an entry at an index by using
 xa_cmpxchg().  Like cmpxchg(), it will only succeed if

---
base-commit: 850925a8133c73c4a2453c360b2c3beb3bab67c9
change-id: 20241026-xarray-documentation-86e1f2d047db

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


