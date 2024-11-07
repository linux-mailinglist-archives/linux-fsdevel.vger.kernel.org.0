Return-Path: <linux-fsdevel+bounces-33954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA89C0EBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425E41F28055
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6A194A65;
	Thu,  7 Nov 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhrAyO6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93334192598
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007066; cv=none; b=qOrggx/Oz9XDPwLF679tmhFxdsZyOH/6mJZsoqbnVv5ToT5zES1xrJ7q4HZJUVuFBjFZB56x6iIkbeMUMq6yJ4aV1b18W/YboB40doxcx8sVIgZKIQYCMg1SZWjJBECsFPkvOPV99DzOP1F+PhG4+F/OCNFxjzQuxCpyrd3COzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007066; c=relaxed/simple;
	bh=TkAFk54d4ZFvcKTSnxnBXeZtlkayKYj0HI4okcukWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYOSkOcwFABO/NuCsnKQQeJmAXaAFpWz0+DSvc3LnuLcXdLYXCaOv9pBNfbF9obwy3AETQT6kwBGudXxstGTIQ+A1uF4r/ItFK8xKqcrOBWz5VkBStBBi/VRP0zJy0VXu1OnqJUk1fhT6fMFEVMf1BWLu+WrZT3Q+y8RudzaFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhrAyO6y; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1354852276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007063; x=1731611863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr8JpF5lWbeUzT238/bHr55gxwNV9GQSeDBdKh6actU=;
        b=AhrAyO6ybR0Azc74tY7jP+23wBVIxmV3m8WHOCjwNwMUnDOpY4cUQ27Nt7Y4gE5o4z
         rcDB8U54degrHVnYZHuR4+iktFV20GV4I5TzjaeVHjNJpwUorUp21yr5dt7g9mMN/YlV
         EGU5QFkNAWgEz4teUjmqifM2fDGU6D5A4pcHU9QI/33a28f8BwhpntPGtGRTELkwjWIE
         sdGf5D92tLfZ3493wxYDrHcsELR0c0FdMe2l7nY4I0JLqIvXI2Am3YzEe/MAjAkFg4gt
         DvjXFRN2NZVWGOlAHrt4mQn/bAgNLwWiI7lTOnB/P9rL7RuSV32lgbF2/uaZqGTq0d0k
         UhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007063; x=1731611863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr8JpF5lWbeUzT238/bHr55gxwNV9GQSeDBdKh6actU=;
        b=lZOHiVgQyckROYxkE9wYJZf1C/bZgg07iLVkXeqOOGZxVi+crlPKxzAle8vSxpDbnN
         vesytQtvB2jrfoP+g7osbRMiQmSopAfBp84YHzJK4boHl9oST/S+YFrWdgk3qEqWEY9O
         qK0WK9DK8FuUHLybN8iq/zeITW4VSW2PUHKsZc58WKyc1YR9wTCnDAt2r4dRmxB9GKnm
         zCWK2TYmNWtvNI96F0GP1JuUvdaVzZdNDpgMHagGm0i6LdBZAtGL8FrAxeK2/4oQiVAv
         U6/LcUcEZBncoZYKENQRd5a8A6y/BXoNPVD5jfKHBwlcDJAQlFwfPNbnpUDxMBWkJ+2q
         TifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs4iCslYudMWh5i8CyTowbFFxpo9eXZfg3r/cVkSR4yaEw1i/6RS15aBudedMOC4EXXMuxzRx64W0suSxo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlf2amAABu7wnlsjX1sxFb4jZ75UBO/xOl5wGU0zwl17qapTBp
	KseoOZQNTuiDT6odwsLTREF5/0N0FdiA4oGuKRZXAekUXG6VSmT9
X-Google-Smtp-Source: AGHT+IEbBlsb5ERr3hnSoA0jW6wUSHWc5HPhwIQVHOXGe/lfWgx6vnkhmxEOPnzB9Db6GkYOJAxRJQ==
X-Received: by 2002:a05:6902:320c:b0:e29:1a7f:2f9f with SMTP id 3f1490d57ef6-e337f8d0579mr164205276.41.1731007063606;
        Thu, 07 Nov 2024 11:17:43 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1f204esm391863276.60.2024.11.07.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:43 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 5/6] mm/migrate: skip migrating folios under writeback with AS_WRITEBACK_MAY_BLOCK mappings
Date: Thu,  7 Nov 2024 11:16:17 -0800
Message-ID: <20241107191618.2011146-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
it is under writeback and has the AS_WRITEBACK_MAY_BLOCK flag set on its
mapping. If the AS_WRITEBACK_MAY_BLOCK flag is set on the mapping, the
writeback may take an indeterminate amount of time to complete, so we
should not wait.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..1d038a4202ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-			break;
+			if (!src->mapping ||
+			    !mapping_writeback_may_block(src->mapping))
+				break;
+			fallthrough;
 		default:
 			rc = -EBUSY;
 			goto out;
-- 
2.43.5


