Return-Path: <linux-fsdevel+bounces-31492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA69976FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7331F24A43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97A1E376B;
	Wed,  9 Oct 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpTrzYVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4A40849;
	Wed,  9 Oct 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507221; cv=none; b=TIyllOTJVcovOWWfeVIf4VZJPh2zUFIihgOUhwkvImQ0g2FBLwQ71FNsYmq7NrvqLP6fXTrSb0xSGWZyJWy3ERM2LTqFrAoKlLdHR08hBMFMbO54m225QBidQQx5sSWcALXUyMk6OifJnAI1kJc9XDJYIYEBWUTdbefQy04JndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507221; c=relaxed/simple;
	bh=bPfFF1qLu1s9pS/YSmea4fYvhF7P16Zq+xOKyHPTRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgx9/UXCaLCn89u3bE1OduoFBwdibR6dIk/7OLCJrxSiG3WmH0hzkDX0QyKInaY4Q0KzKXcRaqk5VfNPE+ZWr8xBFCSE91IykZcohasyel8z2yA1gHa1ftf8/lvwXENct+adudH76wbBVbXVZYMO5y8AjfmXpbC6uX9/owXJ1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpTrzYVU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-716a3e50a81so156728a34.3;
        Wed, 09 Oct 2024 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728507219; x=1729112019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voVO6J0PAZ3Jff9T7o53DzGHe5ozvPynK3o94a09aB8=;
        b=hpTrzYVU6LkYhYcrdJzY5HmO0IqsBehwjwSc7zI1ilJXQERIWkoY6hykMurPNcSLWl
         ZTcpoDY04zCHDOKF2kgMcg9j2uGSYtBViDKVGKZVCr5V9VEc4aIy7mLeAEWMeyhHpITZ
         ZcxE+Fmkl0whfHPwDYlKj/+DJ2VQEqzwr1F0DglJFHRU+EHRI9xozy+qMW6TFRg0e4BS
         HVIZTnhpUSx9NeIzoVdD5wVx9OTG6uz0fi+DmzzG8MaGRTIB7U0GgCvfpD24bznuvl25
         CGfLFzZAP7N6O5ola/1VsQec/UrdEYE5DsyVmMLsc/j6QOYVa/fbmbXkd21+RkdWnXdO
         4BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507219; x=1729112019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voVO6J0PAZ3Jff9T7o53DzGHe5ozvPynK3o94a09aB8=;
        b=UqAWbPKZXLjv2aDgyOmTcPuAeAlLU/TCU3M7eohyLvGL5QUwbk9ogJFczt8ryUcmty
         4g+Ug8OiB+bOyrc02JBo9kdNNmGzBG10/tejf9WNbfSsqQA3SYOtD9bRB6Gh4QXl9Oi9
         Jn1I3N6czKkTdkZUOwkokt6HubpDKYS2SpqpQmsQHGM8QYS9mIMeXNVyaA/amoTdYaSc
         kvfY8COWJx+oV9Kb11hrFXxQY5XN7g9ellxci9PxLKJ+2lXd31nzCCdwGJIOR7zOby4f
         KZSTZrpgvY7VsDCnO3vC8FeU1pJu4gQ55IB9lCooR+t5zWNpIWTZqqG1br5hnGdXGEVX
         WQxw==
X-Forwarded-Encrypted: i=1; AJvYcCVhqQFYShZ1dR7Vz/VOW9ROIKFOObbFlIvOEcOe2UpbtXnRI8I3qX/94J4gogpQNAxfFc9Z4TtUS2o=@vger.kernel.org, AJvYcCVsBSVbA1XJMT/0oDHaqfuxOqX8VFb3mbv43mr1JNnCJJGudyfazES2Z7yabQmerqDVyQv0m9b+XkQqUdW5uw==@vger.kernel.org, AJvYcCWFRUrHsNeSIt45ERuyoWckMb7TZVo5L70Ef6synOsae4yVyOpW836u3x9LORBbSn0WSOIwsZk/4RRroxi7@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdSx0mRjMeps6s5YIc8yHHM/C11+q0XwloweaFkZ3qBdN0OjV
	QNu+wec/4tm6EHbgXDgZz8EsYBBq0QMsslqwxykEaJGRxxDo+ZYM
X-Google-Smtp-Source: AGHT+IE4y28jr+5n5WqaYB/MDvYbGnisP6mV6m87c+QafPqW5BH+Qy878IHtCLdFQ8gXC4fYwBc08w==
X-Received: by 2002:a05:6358:784:b0:1c2:f41e:dbca with SMTP id e5c5f4694b2df-1c3080c3426mr249239255d.7.1728507219300;
        Wed, 09 Oct 2024 13:53:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:6bd1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae756628dbsm486670485a.81.2024.10.09.13.53.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 13:53:38 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] XArray: minor documentation improvements
Date: Wed,  9 Oct 2024 16:52:38 -0400
Message-ID: <20241009205237.48881-2-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Replace "they" with "you" where "you" is used in the preceding
  sentence fragment.
- Use "erasing" rather than "storing `NULL`" when describing multi-index
  entries. Split this into a separate sentence.
- Add "call" parentheses on "xa_store" for consistency and
  linkification.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
V1 -> V2: s/use/you/ (Darrick J. Wong)

 Documentation/core-api/xarray.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6..75c83b37e88f 100644
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
@@ -52,8 +52,8 @@ An unusual feature of the XArray is the ability to create entries which
 occupy a range of indices.  Once stored to, looking up any index in
 the range will return the same entry as looking up any other index in
 the range.  Storing to any index will store to all of them.  Multi-index
-entries can be explicitly split into smaller entries, or storing ``NULL``
-into any entry will cause the XArray to forget about the range.
+entries can be explicitly split into smaller entries. Erasing any entry
+will cause the XArray to forget about the range.
 
 Normal API
 ==========
@@ -64,7 +64,7 @@ allocated ones.  A freshly-initialised XArray contains a ``NULL``
 pointer at every index.
 
 You can then set entries using xa_store() and get entries
-using xa_load().  xa_store will overwrite any entry with the
+using xa_load().  xa_store() will overwrite any entry with the
 new entry and return the previous entry stored at that index.  You can
 use xa_erase() instead of calling xa_store() with a
 ``NULL`` entry.  There is no difference between an entry that has never
-- 
2.47.0


