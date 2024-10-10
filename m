Return-Path: <linux-fsdevel+bounces-31639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF099948E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE43284F67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373081E3769;
	Thu, 10 Oct 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf3oKMyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A38F6A;
	Thu, 10 Oct 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596551; cv=none; b=HhjGxx030sNiBXU9flji8Sqvyg+P4dh587LDaNvr99JH/HG3jaQqFsOYBS+RR4AMAP3kT8Y6aZ5OFQnLW8fIlOE3bepyCJ4MZjSCIkIHZQ1c6hB6xygP774vFHrRNNCQ4JbIlJi6StRTU+ujhCy7nZwsujBUoh5lENUzL67fboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596551; c=relaxed/simple;
	bh=VrvY4DpJfj3ufaWEX4OjbZZMqwK4NoBHggfZQO7Q4t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK3GLS++r4nuAvEObIB9HtIG9iV8/s4bzSy5CvlosPwjOMvGLSD/vVC8jLbD/wY1lkxsypZCX5fojaNzvNDyqnmKEqIicc7GbX83XY11CN5v9GuBVn/ZFD9qr/xaQ5r1SPfkCc/IfGeGZ/5xnYSAs3JjLhp19T2OqarD1TUNiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf3oKMyO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4603f64ef17so11928341cf.0;
        Thu, 10 Oct 2024 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728596549; x=1729201349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kMpj933RTR+1BcHaRrkNBWiwga7SD4/k6eT8jq3qyo=;
        b=Nf3oKMyOtBlWuZ0v4r2WTjC8/eyG2Y0GU9tz6cYgFuDpM4zynBuVXW3vjDZB+S+voi
         xHoGP/CtnvkeKEBYLgE4/sZhUMs4flIUk2Z+Y649oLfAWc/7lP2tel0uAAp1syDj/IWK
         ngDqOmhn9pme+ATqvjUECb3e2ZNOTER/OjLTNf6Kl7rGXbNQrUaMTOJVBJ2wIv9QbJYA
         vhY1ZVVko4WDDr5OyQZYvFafi2vFvZ1i/I+5CPXnYpEmFCUcCw8W3Cw5MF1mjlqxFG0y
         nh5Phs/aA37cuGOhud0YMDKhAZ7pgPVxWODFV/GwFwvYCTkGIqUgf8P7+4leneA8EYJM
         KCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728596549; x=1729201349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kMpj933RTR+1BcHaRrkNBWiwga7SD4/k6eT8jq3qyo=;
        b=J6F941WmBIjCSAzC1oRid0GJwzGeXHE+BLEmS8qXIv5tUYeZ27qw4SFOy5IgERRVg8
         CLTZU6mNBcYU8aHCYxBSkRDA8iUHNI8FB4UVB63xfpjBHpdu33aXoQcdKDOHVrp1Xhvx
         OGTgrgSGLXkgwCADs5otHAr5W3Ri4+XgeAZROVghspPnK+k5qkJkWVSDnTTNG7xNolHd
         HowISoom0qcSF9NhiAdW+uFJ+LNNkWCCIhEWhAJUG5H2ASJuXZXzQxaNpHDSgtBH/Qqo
         HZkj1V5FgtXu/2V5y44Bs0Ka2h2K0ib/JBCdGFbFiyT9P/E4sczhDa6jGBkoiU28Z21K
         lruQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqM9JdJiVCrv/5jB9abxzRWrNiDO/0Y3q01QKpqYMCellvYiVMVIpyQTYBGxcQFGMNQ6fL/cOiOyvCocQVSA==@vger.kernel.org, AJvYcCXJdo/SadMTep5WVohjAHSa3fZUfhvg5i9EN8/HFhTVzc6Gt87xjki602ih6KCHFXhMcESrO82SCDjah+Iu@vger.kernel.org, AJvYcCXVM+2vWCnJn47lGDisvkMt/EWgmj3ztgYvSWS1YeO25zePTClJj91O1R1eFDLC1YMtVslLBfSmofo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGx3u+mEYFTUDfd5kDod2UhbtYCxIdJHarGDXld3x3U4XUF6XR
	XirFl5i/1QMby36FjlCm+lXrIlXCSzaUnq7zmRBa8vsuwLVTdqsn
X-Google-Smtp-Source: AGHT+IFYODTyTQrOToY+eXJQRjrZItXa2TMyRAa2uXcRClBI4VgSXCnMmafz4gO05izb6vWmFZ+JlA==
X-Received: by 2002:a05:622a:1444:b0:458:1cf9:6fe1 with SMTP id d75a77b69052e-4604b25d247mr9717901cf.9.1728596548835;
        Thu, 10 Oct 2024 14:42:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:e464])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428069bbsm9258021cf.54.2024.10.10.14.42.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Oct 2024 14:42:27 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] XArray: minor documentation improvements
Date: Thu, 10 Oct 2024 17:41:51 -0400
Message-ID: <20241010214150.52895-2-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Replace "they" with "you" where "you" is used in the preceding
  sentence fragment.
- Mention `xa_erase` in discussion of multi-index entries.  Split this
  into a separate sentence.
- Add "call" parentheses on "xa_store" for consistency and
  linkification.
- Add caveat that `xa_store` and `xa_erase` are not equivalent in the
  presence of `XA_FLAGS_ALLOC`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
V3 -> V4: Remove latent sentence fragment.
V2 -> V3:
  - metion `xa_erase`/`xa_store(NULL)` in multi-index entry discussion.
  - mention non-equivalent of `xa_erase`/`xa_store(NULL)` in the
    presence of `XA_FLAGS_ALLOC`.
V1 -> V2: s/use/you/ (Darrick J. Wong)

 Documentation/core-api/xarray.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6..f6a3eef4fe7f 100644
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
-- 
2.47.0


