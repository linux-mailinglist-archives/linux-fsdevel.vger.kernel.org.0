Return-Path: <linux-fsdevel+bounces-75884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L0eFFObe2nOGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:39:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA59B3082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F839305E9FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E8353ED7;
	Thu, 29 Jan 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="qFsb+WB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315F2BE043
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708119; cv=none; b=smjwqA0/O0D84Y0VVkOnA6TxSSAus+zICaw2YrsJwfNT6a22X8iL7i7A339J0J6Fqn6EH0z/saUa7GpeyZYd661yZfaYQyeTTIP+hJKxiJbAQMgVBddHayDU7aE70mG98MM1j0Pni7XLdaw1Rjxkt//yqZatOHepWpDYhdhLz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708119; c=relaxed/simple;
	bh=PakxINc96R+AFjBhGVOOEJJEttHcKEAiHetixSTEjxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+AI39/Z7NXvsHf8IfBxwqKRZlTW8mL4hOsDdC0/LijY4Nd0DHMowomnhF/Opxx796NpDjS8nBj0o/RpT99wxF0QnYGCMFQBPPZes8MeuhzJhT9iIHSOt/8QLeH6+68Nl5jCw4Fu/wbxIdfcFfjNfcN2zr854qSsDGBMAmr913A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=qFsb+WB4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so957473f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769708116; x=1770312916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Td/1webZFtgsexoz6A4dWJ1XKLPDFkv6w3Bvpiy14F4=;
        b=qFsb+WB4q5wHqJhrDG4qTYgF69lMWTv1DOUXP+JMkVEkk5MVa0TpFTzLxof9tjjCb1
         nWFttresLcEDVtId4EJUGb2tMHxVIwyASfp1NV9wW2vMvmy3rboxD7ZZ8KHejetEEw4+
         Aq5niWej3cYgvEuyysVkiW+CU2943iZkkT63UPI0cbT9gOBtjojFifF6pYFcUVZUpxj+
         hWcEnLprrnujgeAIWA6CpFTKhPX9jJ0LtfU75pPMVNQqaNtC2Rn+C9u+FSTbVGKhqNAc
         fMHMs96JobLjIJAnlIDNHMW21uCzrV4GghPTWGmiu2COoy8XZbEJpoXrt8pksME2eSEp
         z6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708116; x=1770312916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td/1webZFtgsexoz6A4dWJ1XKLPDFkv6w3Bvpiy14F4=;
        b=oLyJjsCJPW/ux6jnxupvuoJ3ygtj2J75UnvBFd1yIYmcb6YPtNgL/MnrjNlKQHv3MR
         d7RgJgWGd/MYmVf6ZVAesqHlK6cTfoVNIZ8AaOIK4ghaFsySuXcPtP0I5tlKPZUwrn7J
         +hnrrKZXVnSE1uxx19ie8GoIBxDLod8paHD4FnW+WXg8pKFnnqUkVhK8GRxNuhCGnn/4
         eUH0VYWJ69ip8TdfU9of28DV/L8YHGjZ8+rFvJJkbXPbZSU2UsLKMyzTjT7qlkqIhemu
         NnLAFuiy1v8SV8gPV6D155GuZ9XRkMvxFvRP01nMRVtYJnk0JaXK/gl0u/C6jWEZdfIL
         dlIA==
X-Gm-Message-State: AOJu0YxQNmIMnw8GNqDj2KsF+iGDI2HoEI19e37c543gLnmWfULMuq9M
	QynFSNTKjlRKR7LkYo5EdEZFtE4lQSw8ySe/Y4cJCshXb0fVtrAMAbGQCHSD1oUfC/9Y2Qagqmk
	P9dk+ytU=
X-Gm-Gg: AZuq6aIV3O5KRZBFW1rQlCXwlLEuvRbuslsXINwVoS9FiYoixNMUKcnyC1n7ec0nOqW
	GOLvouOojg2/bYX9kgRb2v5naGtts29HnxtmNB3EWi7WcC488xSSrbM0QqwxrksEPwY/cuqHYNz
	oBCfIjRM6pjffm+qS4s7cAJmMCgZqhL5O9sDh3XvkTDItG1NTREo5g8elAX3eKVEvNOk0kt7pR8
	HYhivVFMB3u0otuPeZhRArjGYeeYKbJ3K5aIWAdvRd+Obrxy6sdK4FweH7JdBaYKeFqTshmc0/N
	4VhdpkUg210rIy+SnEsREABDNXgZYeHUM/H+yPM8+KaKA7vxnatpoC289bjShZqI3G9lAIwOxM7
	EXupVTKK5iZNjF8RcGjhhgVYGzigXVmFR15O1pidX8id2Ix1pv4UcUrqfdMWefxXKFSEC1wiEmr
	ghwRPDi1dqxt7X2jE0sSxQf/LLThtmkT5JhEb2VcoIQufwoQ8jhDmGemfOwDkzYGzeKtoGyc9DU
	Df1xMVrsZ+X5g==
X-Received: by 2002:a5d:588f:0:b0:435:a9ad:d21a with SMTP id ffacd0b85a97d-435f3aae39emr604940f8f.40.1769708116233;
        Thu, 29 Jan 2026 09:35:16 -0800 (PST)
Received: from snaipe-arista.aristanetworks.com ([81.255.216.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf16sm16904163f8f.22.2026.01.29.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:35:15 -0800 (PST)
From: Snaipe <me@snai.pe>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [RFC PATCH 0/1] Bind-mounting memfds
Date: Thu, 29 Jan 2026 18:35:14 +0100
Message-ID: <20260129173515.1649305-1-me@snai.pe>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snai.pe:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-75884-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@snai.pe,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snai.pe:email,snai.pe:dkim,snai.pe:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAA59B3082
X-Rspamd-Action: no action

From: "Franklin \"Snaipe\" Mathieu" <me@snai.pe>

Hi folks,

I'm sending this patch that allows the use of open_tree on a memfd with
the intent of bind-mounting it.

I am unsure about the execution of this patch. shm_mnt fails the is_mounted
check, but unlike pidfs and nsfs I can't compare the dentry's d_op
against a known dentry ops global.

I opted for a simple check of path->mnt against shm_mnt but I'm not sure
it's the best approach. Please advise if there's anything better,
otherwise, the patch itself should be straigtforward enough.

Franklin "Snaipe" Mathieu (1):
  fs,ns: allow copying of shm_mnt mount trees

 fs/namespace.c | 8 ++++++++
 mm/internal.h  | 2 ++
 mm/shmem.c     | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.52.0


