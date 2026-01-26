Return-Path: <linux-fsdevel+bounces-75548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIBWKuDud2kVmgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:46:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DF8E071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F81301BC32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA430BBA5;
	Mon, 26 Jan 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eex1ueMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBD30748B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467588; cv=none; b=Zmhm/6KJo9MmLz+DZuHrb7OnmAk0FoU224Y6R3Nybtu97CYjBqZnZbGJHR+KA5BviV6/1JbTqpSRHLm19yg8i1DMZ+ujbCvmtE6qgkhTn7qg3a3lxFBW2OKibc2apEHCR3XtY37Uys1Etc1jbx0n+zpgfPapjcnrIMwYJbKb0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467588; c=relaxed/simple;
	bh=kJswEap/988uxdVAAsdjaebeA7FGtp6PG3lV8iHgVXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJEkIpCQ4qcHRyo3zcgk2PfOImq1ihuQo+Sr8Ke9W5JrBxj9MxVQCzPZqTZUEYoFmcbkVWdVgvhWZTYCjoQjyyi4OSIjAdLnWFvEo8zGwirfxGdpM0abk/Vnonl+2sWyrvFnp+xAGa9y+1R6RmlAl449DXzt7xBmkxDltStKUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eex1ueMy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so2217768a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769467586; x=1770072386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oewXodTZAZNOklkm5s1LaCIom/Zf9cTYM2/n0lx66rw=;
        b=Eex1ueMyXFiRvU4khkZ3Jfhwrh8uCqlbecFhh0kymgIYKhm8bBbn740Qc6KboVWIni
         dScq8gkhOUz95Yo0ekab1Pw/eyIDV1a/YD9wXuxXTd/KnleqdXbxMB/+GcyvSRchigDc
         ay8fyoPNAufnouam34cHJFCim2ixSbrWUTQYaQLN9E1Twas4b13XzcpgcTMajtQOUtnA
         y5pWGcQqJ7HfhK3MgwKznRjjkOLzp/7SrOqW8c1cYvHUjMQUAFIaCMhn/aAc9h5h3Pry
         HVOxWVDhDVzWE+qZCMA+xcdkpLoF146EnQAStsmQKml7+CMUA5IjE707u5pcyPJhvPD5
         Oyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467586; x=1770072386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oewXodTZAZNOklkm5s1LaCIom/Zf9cTYM2/n0lx66rw=;
        b=wQcfjkQp0h2lq7yqVAVbDPX/6RCzZZ7HMrZGE2gnagtcuA7zhWpx6Z1NEukOIvWmqK
         sB8+EWsgdx7LOVUFhxE11E2ahfK0mxBNLDSaY4wSoFl0Nrc5i2uAjw/95w1Zgtqp1UuR
         4zAdWfej9FG26O5lXsoCjMhjdScWoNoWxuEBI6ujkMoJnByfq/0kQPQZNaRtC52mdVsI
         371vOCOvg2OVfL7xFOXSHhWO7ozz8mpjCAEKliIv8NW6+7pLDFxPRr94QAJMUFl40n1Y
         4Fsyh+fe0ZjdHTHRQr/S4mOFkclt5obsUFaDAddBo6zVaBEDI45iM4uwoi2ffTqRAg2x
         dHUw==
X-Forwarded-Encrypted: i=1; AJvYcCU1gxI4cxa1mSAj8TF2r25El14+5zuOH/l22k44ocE1XEKY5Vl8DWbFdcr5ySH+fOqmIqkcJqh36wo71GLL@vger.kernel.org
X-Gm-Message-State: AOJu0YweGomz8B+LAYtXmMPm2qI1/BHjcx5IoL31XS3PeR8+VXLoNMsC
	Ef14aosX2rlUAfaAr/kOq09uueXTZdglI+z07JomvmAC654uctUbNqWu
X-Gm-Gg: AZuq6aLMWA0ixjOzlHiag+g8UUaAGBGshl6BQmncZwV2xmkmIBA3FPOpArdD2JpGkSv
	D24tVIPJRNcQla+n2qEhpCPYbisOie49Ji2oHNTpUGQp54G/QRKD3Zbokry5fB3NtXet0TuXz3t
	iay5uxammHz4BnG4FCE+kskHBwS6KzVncrte0fDaqKNTu/cnrwZrfssF30jF6RR4i5lcIokxBG4
	vujjDJNtTN7Osty4BAsqrr5cfu3YW9AyYv8T/bBRyIySNFHY7k4hENh9BZxr8jH79SXFmmx8/Eg
	mwElBBI2LC7l/wBGwGjo+5nZwADFO3/Rep99WzbcDsmxDrKBx9xRh7eCHFuXlXlGQhCDPBOAFQn
	ElNIF4LqZisSmcH8CnrgUGCiiBSGQ93Y/Qt0OxSDRllE/8PV5AYfYmvCxTLh87I7lIwqVKknxY2
	mGgA4QZg==
X-Received: by 2002:a17:90b:1c01:b0:340:be44:dd11 with SMTP id 98e67ed59e1d1-353c41885abmr5090813a91.27.1769467586074;
        Mon, 26 Jan 2026 14:46:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f615a44csm460591a91.13.2026.01.26.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:46:25 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 0/1] iomap: fix invalid folio access after folio_end_read()
Date: Mon, 26 Jan 2026 14:41:06 -0800
Message-ID: <20260126224107.2182262-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75548-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F2DF8E071
X-Rspamd-Action: no action

This patch is on top of Christian's vfs.fixes tree.

Changelog
---------
v4: https://lore.kernel.org/linux-fsdevel/20260123235617.1026939-1-joannelkoong@gmail.com/
* Drop new iomap_read_submit_and_end() helper (Christoph and Matthew)

v3: https://lore.kernel.org/linux-fsdevel/20260116200427.1016177-1-joannelkoong@gmail.com/
* Make commit message more descriptive (Christoph)
* Also remove "+1" bias (Matthew)
* Account for non-readahead reads as well (me)

v2: https://lore.kernel.org/linux-fsdevel/20260116015452.757719-1-joannelkoong@gmail.com/
* Fix incorrect spacing (Matthew)
* Reword commit title and message (Matthew)

v1: https://lore.kernel.org/linux-fsdevel/20260114180255.3043081-1-joannelkoong@gmail.com/
* Invalidate ctx->cur_folio instead of retaining readahead caller refcount (Matthew)

Joanne Koong (1):
  iomap: fix invalid folio access after folio_end_read()

 fs/iomap/buffered-io.c | 51 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

-- 
2.47.3


