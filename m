Return-Path: <linux-fsdevel+bounces-56927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFDB1D03B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E456F567400
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20911DFD8B;
	Thu,  7 Aug 2025 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jGhRq5J8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE651C3BFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531094; cv=none; b=ONd8+ZRD3rGogMOwBeaI6wyxoxbm+KA6ZfZt7vKW7b24rmd4GM0CVixSs5nTIFVYM6JrB5NCZtdjozHe9IeUqv9YsCU1f0+tkxv962T8o4eb+Ra5ScHqdg4wDC/+4sIkSQcnsItkefklaZAV1jb/wxP8RfH3FtWI/mTZoRlFYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531094; c=relaxed/simple;
	bh=7U4lml8t8oTaVKuCLMpzN1Wuy07LH0AEtgZI7ZnzuAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMaD4vCrxv0PYI1STEo3qx31dA4+5DhypRkyf/gcKznjeYdTULYVHqI5jZMTI9jY93UpAVN7FZ5I0yhEDDR6+GkAbTj6afGEPv4FKah7C+S7GXQBZk5NB6/r4qaJKplKSmbVdQ0Wzzo9XvFVQvMX/Id2U9yLka1/hFut5iwvupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jGhRq5J8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-707453b0306so5567796d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531092; x=1755135892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaESzk2f6ioxFaB+zOVCWa3oEolQrGNRo6YQh6Uj768=;
        b=jGhRq5J8VB7lIKnNpy5IKMw8o759Wi8rvUO67fzgAAGCCCNNALGWGFCvUy8qIR2/LT
         DXGxW0APa9sdDaPeZEwdzz0T2lICen0AXKPPnAznTYEJWRHZQTfte+Svh0/PKYE1wN/E
         Hw9FP6Y83KNEBd3R+497m3ThktAMJAxFcsnbHwhRHmebFfa7+opf19X8RXLo+BdSY3gw
         vj1YvsosNm64zjFspN5YAkjdnqvhI7zj2WOgFRuA2hBLMN2h7r3WUF31CD2F4GR4hOmR
         qf6OOUYSKXEEXnkxZcjMDk/tFAuea95bcYCzFRjAcDrsVywYcGTLqOzHgv1pcuTLGqrI
         F8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531092; x=1755135892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaESzk2f6ioxFaB+zOVCWa3oEolQrGNRo6YQh6Uj768=;
        b=HmxiiUjYzkQ2uChTaahqsq4acLbrzXEfWf/QKYi6EPCCRVOqOPJmwikukLxMdZvjiY
         Wrso1laaUU9zaIa8Fx9SUuX+gNFL+1f3cIkPucIdSBib7ZHmNXf1hxeZZie6rd7iDM/d
         eQL98P9OiJlSVoase/y+6YLHjAMpTT5Sh7KzTxhnIROvDfNxMkK3MyTAm3JEzal4VN6V
         ZQAPwzhYiXH6iTUYQxBgV9U63ga6B/NtLFVUouIcHuzSpYY4TEV7K+NjoqedPAzv930k
         nugfDdenRK7Oa9RO8JEIWUQckCRN0oGm95Tx+12fkJdD02SEcGEGDBcEKCMVv9tiFpIi
         laMw==
X-Forwarded-Encrypted: i=1; AJvYcCVdB/SyaCbE7/IfENA3WIdxcUXTC5jtaJs1N6MtcSxhMg8DICDrEK6Ri/2aRMZ50a80WjmN99gp1X70Db3b@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2LJWGiSYMWUMBtK0nPA4MzlgfjVwvKZbeL+uhxrbb3zrhbRf
	8opWeenUtyBaEYep3lLCkLNumhhaIFDuS+XpAjfPbBkvmij2cXcDWVWQO6iB7QLTvu0=
X-Gm-Gg: ASbGncs5MmBouTs/hViEhuRwS8glpYyOZtjLPLvlJwjoF6aQykBJMpEbKWX3EPunNh9
	5AJTKDiE77mj52FA8nOPFd9RitelB32qgUNMvVoPf2XK78/OsYifCDq05TzZ+dawAOjit3FiLbs
	7iHUzbU3VuqACMXPoAVnC9gOKUaJHK9j0Y2pdCYoHzd6bb5YursIYAfuyLFChB4HEB8rjoOAlKN
	Ehg0M5n7pOXHJ1f/SPrYmQrgvPATEWYpACylZzMlGbmPeiu39JRsBisEKichEji80XaDYvb1Phe
	wJSevQJQV0Yo+wAnpNlwnVrlzLZcRosw6kb4BFiFbQ8wl2BqSUB1N1Qfr/j66I21y/8vbuClY4r
	wS+BjZE7P4vSoQbWMENc01zZAiBcnHcDARwjdWz0r4fQHXl8E8oXOtiQ4ZxrtkpZfwC4ZC1z/e4
	b4n7yL+ulGVAE1
X-Google-Smtp-Source: AGHT+IEyWMvTBlOM62kNmVMKSSB8JNc55ip6AvkaRw6dwIN2X5ATQTWFGGBA3z7kK5RTd9pgC648bw==
X-Received: by 2002:ad4:5f8f:0:b0:707:4daf:637 with SMTP id 6a1803df08f44-7097af1440bmr64537216d6.29.1754531091759;
        Wed, 06 Aug 2025 18:44:51 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 03/30] kho: warn if KHO is disabled due to an error
Date: Thu,  7 Aug 2025 01:44:09 +0000
Message-ID: <20250807014442.3829950-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 6240bc38305b..c2b7e8b86db0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.1.565.gc32cd1483b-goog


