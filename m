Return-Path: <linux-fsdevel+bounces-17253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF58A9D95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C90E2837F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060C16ABFA;
	Thu, 18 Apr 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZvU5DZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E09165FC7;
	Thu, 18 Apr 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451823; cv=none; b=CpIdNtnckKcu6KIAvfXvYxvCUZ4NnhOlolraHHW/dyzRONqfosS6CBwgfiFiyvAQ8KYx95EeJur5x6zyaMe2GotO4Y9N0xxIvIQ4KP10R8LwWUN9/PUjkGfsUFWeI9Q8qvFeRripnAmJ5UFvqaMmX9tUb4FjN5JdLc8dnqUADeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451823; c=relaxed/simple;
	bh=/exCH+IFX8Lap5lGMTpE20vQSND7MoJrr62INE+iVGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZN38ozBV9HqOeRBE3rol8HC7ZuCkhmrimhm1TZlM20kqlN2AQNapxksfCj/xRXL4c5nBbGmuepZ1oL21HEjHsJh74yH+PMIY3jMCPB0qrfFkKzs2Q2XKjsxxVMH9+qHevaKARn3UQxq7hXLY9enrUA3p2TcqAND815fhOJy5RBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZvU5DZF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so910609b3a.0;
        Thu, 18 Apr 2024 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713451821; x=1714056621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p+8w8Hh04Jmf8oGwjxpLa/UzKTop1h7DhMYms+7Tq8=;
        b=AZvU5DZF+y8K23dSwWeOqRhYbsX4wmBtBeGic3Ed0QP0n58NYwaFbNUD96aDwkkcJT
         gJQ3PmWKzJS6I0Gk51QhuG3uPq1I/5s8skUk9H38/b1YN7uR4Gzx20YRWMcyevdWiCXc
         zw6gusvU+lXalm9oSla5mDBOYtU5p5qtdGMRuy20ePP8dLDWpUxoa4tqILEywf2yCy+d
         LxYlnblsWWaZV2sD7tv1CM8kEbWH0EKIHQB6nBUlQyvQQBPQhEBKJ9IzhnkTIUXjrXte
         6+icHvE/ib+AaXzsUrFHtx0stXbYzGLbcptq0i6wJSgQUjn9Lp4T/uMXf7RdZkR7w848
         jMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451821; x=1714056621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p+8w8Hh04Jmf8oGwjxpLa/UzKTop1h7DhMYms+7Tq8=;
        b=Gb22sE3flAPlWgNbg1p0cCQieQZpW0a0Sgta9YF99Cplr4wLijBUNiWYSaY8IBWyYf
         Ef6anJrUxIZ3m7YkAvU0eP+ZmUM3mYKvCmoqHMo5uOveqwLtP6M2/vsFsvxa99o1F/YT
         LtSK5moZgQJXwGKFptrnCyhvdEP/vdcdUdxE3NgRO2e/l4dRIcOelBdbP0Xr2+xuZUrx
         4BNvJZ5KfDlL7iUM79Ot6fSnPx3wNDmLtSGf3K+nTFX14vH0xNEH2kMU+VWD3tEmuaCF
         UyF2sUnPacF/cYohVL7mGoVM0WcbiGMkT+pYueELH2xJwXBIOhgRgcSShcOnccPyT/s8
         o5lg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Qtc7kdSs7+DRrOUQYrkACQueiV7Gn6tksI7gS8BZ0xkdW7M5CVQPZNGVD6QdBGSB1mBSCojt1sND1muYYhK9IGQuDsOA0NBkdTZfGio5F8CzLM1lOX+bZw9bVDs3Gb+4vsi7M6ofyjaYW+AkIxqknZN7u41TgQwfFHeMBdME00oaDiY/yBiNUKTIazQJCtu22DL32vg8mS5emcc2ecpAzAvAnxLa4LKGVMCjHATPHjnk+3JvbaFzBX+DTILZ2q6g7uRpMpvTPSOYeM3tdh0RRdMtiAayxNO7s/C0UQ==
X-Gm-Message-State: AOJu0YwifrUpVrSUZ/TiqciBU07wxdXG1Mx7QRvYhDAkXOCIr49VMgp5
	K6+/M934UC4tqY9Hdx6+86ReySfahxxYzGmeNYTXj/L5AjWAcsZ1
X-Google-Smtp-Source: AGHT+IEy3w5ti8d/aRlYULSHP6kn4xClYK6aejX5I6/4QNKJ+uBQwqqDM8a4ftyXRx5jRuNQIVC1bQ==
X-Received: by 2002:a05:6a00:3d0c:b0:6ed:332:ffbc with SMTP id lo12-20020a056a003d0c00b006ed0332ffbcmr3858066pfb.20.1713451821509;
        Thu, 18 Apr 2024 07:50:21 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id fv3-20020a056a00618300b006eb3c3db4afsm1552999pfb.186.2024.04.18.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:50:21 -0700 (PDT)
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
	ziy@nvidia.com
Subject: Re: [PATCH v1 04/18] mm: track mapcount of large folios in single value
Date: Thu, 18 Apr 2024 22:50:03 +0800
Message-Id: <20240418145003.8780-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240409192301.907377-5-david@redhat.com>
References: <20240409192301.907377-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey David,

FWIW, just a nit below.

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..08bb6834cf72 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1143,7 +1143,6 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	const int orig_nr_pages = nr_pages;
 	int first, nr = 0;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1155,6 +1154,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			break;
 		}
 
+		atomic_add(nr_pages, &folio->_large_mapcount);
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first) {
@@ -1163,7 +1163,6 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);

Thanks,
Lance

