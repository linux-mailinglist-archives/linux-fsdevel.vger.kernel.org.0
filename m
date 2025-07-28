Return-Path: <linux-fsdevel+bounces-56184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D3FB14345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B431B3A18F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CE28505C;
	Mon, 28 Jul 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVd4r+JY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48047279DA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734713; cv=none; b=M6jwynJW0S5H4NUJaGSMbzH1IH+w1/d0kPF7WAuLtCSFENA3dfPSAm9bcHQvZBV+6w8bgnXcCIR2XPJLV0zzL20WN9AXmibxkmRXn/9JutzzdWZNNbqB+XcO4TKiYsW3XM2bd3N0g6aOey4YuHTPnwCDbpLL0bItFXjMOxSNads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734713; c=relaxed/simple;
	bh=4CpWmxTo2hLmGYDDA8Lp7aLfPM6yv41pw1diCtdXE1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sysNpBvkRMWJouFn7uuEyJpnisrJOAnb7wv/BUOtaWMsL9KFRbsnWd46A6ZWsSRF4wZuU7qB7EqkCCXbcneZYOLACSAJntVDqAYd4tJEQ+0D7QDy/ugVOnJv8EbdAILjtSvTF5h2w5T06CtB82+oYdNQqcWg99GP2/F3By1H5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVd4r+JY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UboS3qfLDBc+qi6WxzczFNpJ8WP4O5vMDtMD40JSNis=;
	b=JVd4r+JYAL8iN5vNJ0MuSsKOqbTRb+w+kQpf1DS75ivVCFeNfMZAFGv1Bt4sTw5l9nE+eV
	HAoAIiqRsxJZi9t1t2LJPPg8yqxUrlqoFadP21k2b75TusLBdQsWOllxNyDtoGEM2ogaPO
	J/SPiHMjYOq5n8rPXVLE2C7T9uoJstc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-TMdHVxZ-Pe2WtlwBvSWXaQ-1; Mon, 28 Jul 2025 16:31:50 -0400
X-MC-Unique: TMdHVxZ-Pe2WtlwBvSWXaQ-1
X-Mimecast-MFC-AGG-ID: TMdHVxZ-Pe2WtlwBvSWXaQ_1753734708
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60728151592so4528258a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734708; x=1754339508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UboS3qfLDBc+qi6WxzczFNpJ8WP4O5vMDtMD40JSNis=;
        b=bXuD670mh/fwncb9DAsGWqKMT8fJxphFCjnEH04qtQP2abmEIPlt65qS2M8Mmh/Gg1
         YNs2my/sxiyZOyg/fyjJhfiTLbfm4fbZjI/mBSDivKkul7x0yUJwl7k8u+QBXjAzMyYC
         RO1gEP5edB1LPUDZaCtPORqZixk/jx4uPDe/I0Guatf6koKXyLq5h89iYf3uqKNrlpZe
         A3hLRApahu97aO8PgBXOhdgCihh8wSMPHxvmCGLxs+X7WOdTLMXiRbc0pB8OewJBJ5Ty
         A02WRWvwEWon1qefrPz7O/CeH2HoemaH8WDxy1HgahbZkBUEkTsog05qYHMmpBiSdizd
         R9OA==
X-Forwarded-Encrypted: i=1; AJvYcCU/jKK5j2RKYy9E4ne9z3DrMH2qCSYvJKDWiQpg3of/IifAFGlwm4nkac9VT2BqoKSGiK9oO1EyfzdPUqJV@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQb88+ZKUWT5zPk7WTFGLxodOcbUBwhC0RTm5Tlzg0iDPcbnw
	wTlnob/uzMMDDOUDRYa+zydO5QlqLdMsPUgc608ZK+ftUN0+4YGOWgCzk54yQG6nBD5klY5ympc
	SLH+RYyClmrGn3fYN3ja6uYo14vlpIQBvAFD4M+khQ7URw5sRm11SfyoCcsuv9qvdPg==
X-Gm-Gg: ASbGnctsQpdQihoQHXQ6Mhg+L+nUX46OQFkQxu5tMUPeA8wWFsqCwp29SdbA21DpgQh
	gDIBSDSl3yoj+dyBdy/KOR/hF5USNT3aEaGMhf3nOEa9nTrNRO8fLL18ZCoUau3n+y7GTvasYws
	Ur9E2EoChnTE2wZ+Ghk9sv5bIf8Bi+6c/cXyxCXoQb1WUnn2Hz/5htF/l2T+JxX2JDjVzIfJrXG
	6JFrqwd/8uvhqm0eL80j/FU5DFS2AXnfd9I8QSJ40KcnjXZPCQSUf940M5jQrLVoA1wFBcuEDC7
	Xpljrqaqbo8xZsD+aYFIGJNu0Fa0+VIadSXP1lZOmEPeSw==
X-Received: by 2002:a05:6402:348b:b0:615:41e5:cfda with SMTP id 4fb4d7f45d1cf-61541e5d4admr4626009a12.22.1753734707696;
        Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7NbV31Mm8G/xBUFv0BekV/8LN0fAoNrs1I+/WZVoZ8FMzVU2xsjyF09u66gqCrOLV/426wA==
X-Received: by 2002:a05:6402:348b:b0:615:41e5:cfda with SMTP id 4fb4d7f45d1cf-61541e5d4admr4625990a12.22.1753734707333;
        Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:30 +0200
Subject: [PATCH RFC 26/29] xfs: fix scrub trace with null pointer in
 quotacheck
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-26-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=4CpWmxTo2hLmGYDDA8Lp7aLfPM6yv41pw1diCtdXE1Q=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSezXTDTT+zVlsmy5qlDdVOUb/ed2xV/6HHW5Q
 FG0P317j3dHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiQhtYmSYI/6O+d+5oz0V
 /X9FVJIaW/pkrXe1Bp72jDwwPZPHJHkdwz+rn1bOZgXH6pQ0/Q6w/8g0vunFt+7gDf6g2SmWhhE
 nPzIDAMKNRVQ=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

The quotacheck doesn't initialize sc->ip.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/scrub/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index d7c4ced47c15..4368f08e91c6 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -479,7 +479,7 @@ DECLARE_EVENT_CLASS(xchk_dqiter_class,
 		__field(xfs_exntst_t, state)
 	),
 	TP_fast_assign(
-		__entry->dev = cursor->sc->ip->i_mount->m_super->s_dev;
+		__entry->dev = cursor->sc->mp->m_super->s_dev;
 		__entry->dqtype = cursor->dqtype;
 		__entry->ino = cursor->quota_ip->i_ino;
 		__entry->cur_id = cursor->id;

-- 
2.50.0


