Return-Path: <linux-fsdevel+bounces-17030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB938A68B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2182C1F21DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632C12837A;
	Tue, 16 Apr 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAAJR2Tv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C58127E28;
	Tue, 16 Apr 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264034; cv=none; b=QjFagpmOMMFqyI6V5P1ectfGq6gyXbVOkg9srC2zhOsk1EdUKw5g4Ym2+dDvX6qfEU6S8vynjsjU4sVDhYjHMhi03n24SyFMF/sacTjhp/y09FIGgfUVMgK5WM5pyWb46HXNoIGXTkZbWWyUgFHYl28wpObLVB98SbfWhk4Rhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264034; c=relaxed/simple;
	bh=yf9ORU5VqJIrPlSmwr54fZQAo/+CCskqhWV5tfkQ+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5flRRQ/zkvG6inWLZq4U27HWPZHF+y+CtTbmpHPxaQo+/+iZtBdtiXCVOTgQDCT4uIheCiTS1DwxNZHI7va5qgJ6WFZDcmSnHdWtGhpIq1EBI/nKK2BB43cmcKARHbey++YsdlqkBT7BhjGgGNALNONBcUMCd/BwziwijC+k+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAAJR2Tv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4f341330fso34767955ad.0;
        Tue, 16 Apr 2024 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713264033; x=1713868833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1z8VdCeJne2MyXf+8c+fA7mb2A/BjtvAD0nnKEdogs=;
        b=JAAJR2TvWa/3opGUBZlZKjryTMfddqRLI3k8m72zfeVdWOetSLRPDpO3iWu85CTkp9
         FXjlxWx0ahblezk4FHStiTXyHS+2+Sc4B3arIZguOaZLq8wV317DQ2KEdTVtgMsMoGaN
         4DA/pEd28VqqRjHkBvQ/jeWJihEXq+08Cy6ZzQvzX3jD1EDPy2ifSZp6LcZ0O5as14MG
         WuGoa/MUYLBKgiECCg5jYHLXH1B9+xMsxja9Jm+B3bA2olQ5t24XHV02uTl5hx/9yTNG
         DBC/uZTKHZIusOI64HxYivCuo2U1QWRni9Zxty0qwOLsxaSdcHmI4VAtLOBf52ug3bdc
         ogYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264033; x=1713868833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1z8VdCeJne2MyXf+8c+fA7mb2A/BjtvAD0nnKEdogs=;
        b=bAsrbranPg7YoEMy5Wh4NwHdOLicgCy0tg/JDolaI1547Mjs32rYJh0EpAUNFd/PsG
         tjtB2GFOLaoDF5HEDckDhIGH+aqBoSAckZJNH7DhBZy2PX8VDz8pBdYJjGjNCqpzSsdO
         Vk8ucn6wSiuzXjLPtDhpxG7Ds+/xbIEGSpDxiEpX9NktBXDNqGN3M9/HUoMDes09Myq+
         VJcVHW13HoPGJSEmXK9NiQD6Wuwf1vClSL+xZiriispSkfHfRHzpD6jaYOSta8oXw+IM
         Fe/6WQRm5UB/wwMRfQUbD8SeFXa8NMgwqgs9PWN+Gav2l+L281r9mrpxlESkkSEJZlRt
         E7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVKiE9kecZBcKfjP2Gx0d9bhAzhUTVG+Y8yTT4B3ahM/6Qk0vyitSwKvfVgQxQghWEsNL4ffX7iIYKH1fF5ByD3XgwXu0zJLtfdWW0R/WnJBkoRAtFTlaJQJkrFXQdVC72tCkiYmsrH+QKE+JCiKp4tHYdhyXvXudf9k3ykALxDX2VzJGv/wBuXzYp71Bf7l6g4ENSw+KEYTjOij4JPbm4Q4Or5BTCiVBojdz/SH6T8/fPXrTZGq67ZdaL2GTsl/RY8dXHmLvDDbE72eIrLKY+S2GSdnUcE1bJ9OfpjfQ==
X-Gm-Message-State: AOJu0YxKZSvSrpGlscb8hByQmuGlsoym7WfVmVj/o3NoY3SuCZrEpmEr
	X4sbULmCDiokFB3WS6Jut/GN5N9EkW6Wzg99C8yUVU5ob3Kn5/8P
X-Google-Smtp-Source: AGHT+IEVE6JlEBgyeNQ8vkUPkRaSgWDWUYr0hp6JGZgymhUxvXFOsOst8mFB35mbNtNEl3G7ds+cRQ==
X-Received: by 2002:a17:902:ed15:b0:1e4:9616:d967 with SMTP id b21-20020a170902ed1500b001e49616d967mr9788274pld.15.1713264032862;
        Tue, 16 Apr 2024 03:40:32 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001e53bb92093sm9410890plh.228.2024.04.16.03.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:40:32 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	chris@zankel.net,
	corbet@lwn.net,
	dalias@libc.org,
	fengwei.yin@intel.com,
	glaubitz@physik.fu-berlin.de,
	hughd@google.com,
	jcmvbkbc@gmail.com,
	linmiaohe@huawei.com,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	naoya.horiguchi@nec.com,
	peterx@redhat.com,
	richardycc@google.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	willy@infradead.org,
	ysato@users.sourceforge.jp,
	ziy@nvidia.com,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using the mapcount of large folios
Date: Tue, 16 Apr 2024 18:40:08 +0800
Message-Id: <20240416104008.41979-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240409192301.907377-6-david@redhat.com>
References: <20240409192301.907377-6-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey David,

Maybe I spotted a bug below.

[...]
 static inline bool folio_likely_mapped_shared(struct folio *folio)
 {
-	return page_mapcount(folio_page(folio, 0)) > 1;
+	int mapcount = folio_mapcount(folio);
+
+	/* Only partially-mappable folios require more care. */
+	if (!folio_test_large(folio) || unlikely(folio_test_hugetlb(folio)))
+		return mapcount > 1;
+
+	/* A single mapping implies "mapped exclusively". */
+	if (mapcount <= 1)
+		return false;
+
+	/* If any page is mapped more than once we treat it "mapped shared". */
+	if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(folio))
+		return true;

bug: if a PMD-mapped THP is exclusively mapped, the folio_entire_mapcount()
function will return 1 (atomic_read(&folio->_entire_mapcount) + 1).

IIUC, when mapping a PMD entry for the entire THP, folio->_entire_mapcount
increments from -1 to 0.

Thanks,
Lance

+
+	/* Let's guess based on the first subpage. */
+	return atomic_read(&folio->_mapcount) > 0;
 }
[...]

