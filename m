Return-Path: <linux-fsdevel+bounces-31592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6699894A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA22B1F28B4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E01CB505;
	Thu, 10 Oct 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhOwmEZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C21CDA31;
	Thu, 10 Oct 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569716; cv=none; b=dbeylfmZQRTcTMh7XNJDyT488Ux1Yz5QFN14r2tJGuqExb/pA4EUcRkZcnakhNNKr86Yl60CXNhExeoZdfrPAmG4R776cLMxhjYKrQVVAN6Gn29LH08Rcw1WWgKifFf+Whl5SfZQYz+D8qY3HRVZt59snoWz5gOC5BTCiP/atYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569716; c=relaxed/simple;
	bh=pxBvWcrhGMIPuPgtXeIxNxIKDs1AJSR+OZH4rWNkoBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5+HcKHua3EdkZzNNsof2oEoAofowmYekXoMCZczzX7R+z/7p017fS83vxZs/iVs+6hSbW5ZySlOiEsSDNbpeTa6Q+B4nZQRbEctykn1od8M2Uo963J3s+GdYsx07ZsPeXEIKQbA0AJtbeoFQnDs4Crl+KIWpJn2JqFcm+u7IGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhOwmEZF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7afc67e9447so86012285a.1;
        Thu, 10 Oct 2024 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728569712; x=1729174512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqvqzpyos9Z2cHl1Hq4441Cm311q4Rw0QpRuIoqWsVw=;
        b=IhOwmEZF7l74V/U0nNfx8eyYQrpPJ5MNkJQpmsxy9Td5PCc7tzTK7TbRt25zmj+f65
         gfDzCY+Z0ls3jn5f5RxJfOXZlzbTaojKICWf3tVAPgKWvOe8RFerkvpwg00vF6jrTvck
         /e/ugpJqz00wGZ1N4qaooYkC87svJ4x9zQjaqUxH77/ILiSfS5HV6e1t50altKU2AmVL
         jQGW0o4LlcmLemKDw8FSB3M+lHH2FNIa6uicwKBlXD725C6zzK/m11VX/EcxyHASRYFv
         owJFFBpPhlV/vgjQwoIgw4MumZ05q+Ztho5hb3Np9yXWt8PvVjZC376cl2fzhNBE6LGZ
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569712; x=1729174512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqvqzpyos9Z2cHl1Hq4441Cm311q4Rw0QpRuIoqWsVw=;
        b=btxqLBkG9PlVIk47gWxLjiWLjbDuCDLAziNCA/nwAWqghd90AkXgm7YfhGRDMdUmip
         6XPuBWUl4jrKpscGIQgtnt32ie6QzSLWdjM/HNWwg3nlgW3u/tdPosz+ghpoOUV4O7pI
         vjWGULGDLqDRq9mRYhYYcVS5kwjscgVqzqQVT6+FFAr3xpQLPqi1O54yCjQzp3Q0tRz3
         2eG6dx2AGhZAcnJPKn34jqYWN29kgszcv4lfASro6wtcvVgZNzY2VzMKWbVTlL/BMq6j
         Xn6/WLqqszQWMeYu4MeAHHXHWdEkYM5hEbNeaJiW/IAgsGIjthkmgi3cAJX0/ihKxXB5
         rX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1U0MD07d6bHpq0PNIfjhk7cUDBoJ6SSBmNgVallqZPaFr/Jj7Wqy2mE8STJ4G7Mk9wyFeAKzIA85tVgfeCw==@vger.kernel.org, AJvYcCWEN2rXpWM2lQkWUgIOOeChpxz4Vs/RXq00l7Ir0VNFN2fVC574KTQ9Sq92UBnmAvP+S6ZZOF9lBS9TMUp0@vger.kernel.org, AJvYcCX/UrEQ7JoUU6TFtwV2ggSlmxyu93wbQBF7N7imA4Y6N+xrSX4YINJFtpuuf+yYWmx8zhZLEJhBoYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdoBfBrsi5OiBri5YetFlaVKc4LFAhSALJ4tiRo+YgdqdT9sV9
	XUnz9UnHiS0TCiYDInmnxX5x0DL//SqYG33AUKHRNfOgEAxnzFT4
X-Google-Smtp-Source: AGHT+IHQiOHFkcicch0l/ECWAvjz3Na6Zp7HBy505VDWPlG2NN7O8G09nABk4XVG+XlnB+ahQcIxfQ==
X-Received: by 2002:a05:620a:2903:b0:7a4:dff8:35d5 with SMTP id af79cd13be357-7b1125481b7mr545113785a.33.1728569711965;
        Thu, 10 Oct 2024 07:15:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:e47b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149580bfsm48822085a.76.2024.10.10.07.15.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Oct 2024 07:15:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: tamird@gmail.com
Cc: Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] XArray: minor documentation improvements
Date: Thu, 10 Oct 2024 10:12:58 -0400
Message-ID: <20241010141309.52527-2-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAJ-ks9khQo8o_7qUj_wMS+_LRpmhy7OQ62nhWZBwam59wid5hQ@mail.gmail.com>
References: <CAJ-ks9khQo8o_7qUj_wMS+_LRpmhy7OQ62nhWZBwam59wid5hQ@mail.gmail.com>
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
V2 -> V3:
  - metion `xa_erase`/`xa_store(NULL)` in multi-index entry discussion.
  - mention non-equivalent of `xa_erase`/`xa_store(NULL)` in the
    presence of `XA_FLAGS_ALLOC`.
V1 -> V2: s/use/you/ (Darrick J. Wong)

 Documentation/core-api/xarray.rst | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6..78bbb031de91 100644
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
+You can then set entries using xa_store() and get entries using
+xa_load().  xa_store() will overwrite any entry with the new entry and
+return the previous entry stored at that index.  You can unset entries
+using xa_erase() or by setting the entry to ``NULL`` using xa_store().
 ``NULL`` entry.  There is no difference between an entry that has never
-been stored to, one that has been erased and one that has most recently
-had ``NULL`` stored to it.
+been stored to and one that has been erased with xa_erase(); an entry
+that has most recently had ``NULL`` stored to it is also equivalent
+except if the XArray was initialized with ``XA_FLAGS_ALLOC``.
 
 You can conditionally replace an entry at an index by using
 xa_cmpxchg().  Like cmpxchg(), it will only succeed if
-- 
2.47.0


