Return-Path: <linux-fsdevel+bounces-33661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A29BCC4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 13:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D591C20D46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF61D5151;
	Tue,  5 Nov 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZlJiItq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509851D31A2;
	Tue,  5 Nov 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808234; cv=none; b=e6TL5GJSregsXpHkpaQ4z4b6rhRP6cG9vWfavjn8axStd0fwyVWrz/akR0VlXo5XGrLULl+SALwDmnoHrMKxaA2uK5ooxVem21BD/02ssZFzEMtXZresWRBAeda/s2DnmDv5XSUsr4Qm4yc3FIMePUdFci59kecC9yIv73mFCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808234; c=relaxed/simple;
	bh=2scUw8T/1u0DGMQY0Ee1Um3A775p657KQNRNFv94Y3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mySSuyyUpTcyWiJRd2rziGtXbVLkhKFrpT4EnNO5BTBoP28T6LYsz/aghHl+clH2V5B0bJ32gduCuD44wFUhG6v54+NjhpeVVkHqMKmXZM+cWIxuAWHw6CIn/1Ah24DLgSZ1X25Vdw4vYd3HCoN5k1qf+N4bKCPwlRoy6XkM5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZlJiItq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso4782617276.0;
        Tue, 05 Nov 2024 04:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730808232; x=1731413032; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mQe9CPTZg0iYP3rFcpBCYNv2Ed7deu8K6ZCVDXo57I=;
        b=PZlJiItqbNtj3h5tU9i9F02aZ0AERZT4ovmvX4xKq1Osv02b5kU5A7LPzxf5JkNsWY
         fBaTUYY9yT1h8kMMXAWEJ8bFMl8/ryeYslkJvdYTJopuSJBwng9+CdxVbWXJmbeZxofB
         tn0J+sfGGubamu6mfA6wAN2keN6fxf3Mu2WP8vzccf12tsk2Le5Yagb/1EOZT24a+xgR
         9QySfBv06GTVND8U6MwANNeYO3SOXcWvYlo7FKizR5trqjrhT9XRQ3MqYQuha1w6kqRB
         c7SafQV5LSxxEa5OsLJwQ4JWOxWKDTj+4+AJcHBtcBAHVCU108+By7Sp3Bex9EBxOVJO
         uSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730808232; x=1731413032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mQe9CPTZg0iYP3rFcpBCYNv2Ed7deu8K6ZCVDXo57I=;
        b=ZuDlaSkgBA+mVWUSn194dsKimX06av/yNCVx2OEl7Tuine0jfgiazz1sq1rk58PPN1
         jAqfcVMelMAVPgDvetqCSqM11+ptfil7g3OQkHz5KA8D7ruADE5DWFMHXJuB5ZctvbDz
         p3iY9AL2zTK0yCrrbiLboaA/GsRXgKpkR22mYFzqFlRy8iSVtIlO4OK0bH0yuFy6LTnO
         5bPaTS4xQv+jOxuLMQmoRvcZAvGG8W0H0tCfAhGR7Y4cOB4gEc4QKN5AvYIJeUp+vTLm
         +80U3WOL1hCDYjekR9UJrmlaHZU2sw3tUbHc4Cgs+1jXSf99Jo/jZ7p+Ed/++Zr54qbW
         X+2g==
X-Forwarded-Encrypted: i=1; AJvYcCURXAUPw42sW4LGcx2AqWLvrYzH5BjW94fEgItgqPSz+hPkGeBrC/r0C3fVyx7j5R21MxznGsVQQOU=@vger.kernel.org, AJvYcCWzgcyM6PUPeRKBb8J1jfvVxccx6mVYK8MQvWwGPfD6X4sVPf02q+YJNqELc+0GqI9FDJq0X0y+J0ng/F1B@vger.kernel.org
X-Gm-Message-State: AOJu0YwItYmFMtxjhkWj97d/FMB47phYgtt3qSQLCtgu8opHOJqb6DKj
	6Oz2DYL0h9PlhaHHF7oByIuJl/6SsVqyxIV5Dad6uzrwi3izzdbbSCmqukC1et4=
X-Google-Smtp-Source: AGHT+IGFzGNU7gdlibESHBuvspL2ArIC4VbdyAKDhERoA2yh98mJEI+YtpvI0J6+dmCG02TAJZyeeA==
X-Received: by 2002:a05:6902:18c6:b0:e29:6571:e25e with SMTP id 3f1490d57ef6-e30cf4323e8mr24573611276.27.1730808231767;
        Tue, 05 Nov 2024 04:03:51 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (186-189-50-43.setardsl.aw. [186.189.50.43])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a6113csm2466779276.2.2024.11.05.04.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:03:50 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 05 Nov 2024 08:03:42 -0400
Subject: [PATCH RESEND v5] XArray: minor documentation improvements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-xarray-documentation-v5-1-8e1702321b41@gmail.com>
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
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7h
JgsMRt+XVZTrIzMVIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQC+xZK2BwwOe02PlxGG7H8RrxZYY51gb8CdxLI3ED8WXT/GVeL/Ya7k+bir1TUuu/A
pWBj+lROjke/NRDPTiJAQ=
-----END SSH SIGNATURE-----
-- 
Tamir Duberstein <tamird@gmail.com>


