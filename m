Return-Path: <linux-fsdevel+bounces-72253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB4CEAA5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CDC53031343
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871F29DB99;
	Tue, 30 Dec 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSmURGtP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n6ANiaz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046D2F3636
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767128843; cv=none; b=KFSRSvxck+7iHa1FLEueFtsRj3rS0kzFEuM+hzfZMaCFz0Tm1jY0RaDlAd8aMCMIMFoyUYmre9t/Mj6Bf2B86FX3qVVRTnehywrCMNgcBaA78DSKs5qETSpK2238z4J1I1irJM193HaspQqaWNYRdbOHqCVBgUiSMPfnnYmJ9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767128843; c=relaxed/simple;
	bh=buFLvgqPk07T/IK64g26n1eo7lJtPO3A+e/41msTbVI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=V066rguGZ0eUUb7hIU8XBlEpPz3s3VwgFASN9WsvFYWXdLJEr9w08TQ6221Dxe3N5QLo7BkYTyJQVLxMEk18XKNayQN5OOjcqbYCOZXF3UcWo/q+4X7O2vPxDdRdfVEtZ2NRVuiJrIsZhG45fbMI0KFWN6W/+T4Zk7Tmd2Corhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSmURGtP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n6ANiaz6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767128838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fs3dF5XgyMuZpukt7W4gv9P8n3NBqDsrPfX7SygV9BU=;
	b=QSmURGtPXm4ssHhagVTzSKwXDeemhipt6HGlCrE3CITiOr57sVdcobghu0WKNov3Qy9QA4
	UuWXbt7t3kdzYPgX4pewlfHndBMTyX3MYZt/K6cxE9B4POpZM1ykZH+EVRUYAcwmwUiIU3
	JNdgthMkBPrXXUxDDiVWA9NoHYXVfZU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Xk986rGcOsqM7DoNFtRWfw-1; Tue, 30 Dec 2025 16:07:14 -0500
X-MC-Unique: Xk986rGcOsqM7DoNFtRWfw-1
X-Mimecast-MFC-AGG-ID: Xk986rGcOsqM7DoNFtRWfw_1767128833
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6855557aso233994651cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767128833; x=1767733633; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs3dF5XgyMuZpukt7W4gv9P8n3NBqDsrPfX7SygV9BU=;
        b=n6ANiaz6PMbTZFOGmF/K2N/vQILkJsoM7rNUXCI2LMd2gNR7x3g+casr90eb60ooYj
         +dGRs6mCoW+Zk1X9e2YXdod+a0v22MjdwbGxmhW9fUy1wTY085BcLnuAOLUiHXrhbDIe
         P04oDGmTd3oROMTRcU3pLGOUrLwvovC2nOag+pnq5yD0PFGCmuBXbo4Vt9+xrnThWjUn
         ChQ9kCZCQqtTntKd4fizgbZRkvXSK9xMI6WTDbOcEK7J3IkfmaCFJppwKqKRAjKjf9H5
         pSj3Di/6wansYRrW6nfKquI37JoDIRx1LhY2g5RKw0XkgO9kDLrHijDDqKT3vUMcxHQn
         gAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767128833; x=1767733633;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fs3dF5XgyMuZpukt7W4gv9P8n3NBqDsrPfX7SygV9BU=;
        b=WQ2ui61ZPaxck5oKpqs7Wqy0KsdepWBs4By3bL4CuDI4MVTyK+mSg8iU7hUUkoG3r0
         cB2o6xWZWtqCVvc4BAQrgW+uv81DQIoSND11/Zg0aBi8KQKlAph2cvHWyJcnkqnHrISt
         zxbUa7v2twUgb5ZNHpKzmr3ZCd7KXc6enUHR2/uOiHBjlA3rUSnSe3uiKSMf93F7oOAv
         +usQBCIXXQRtmHaQUXIXeJY8+nj9WGTkt8dLNQBhjqkRItsmPlx89lqmpW/JLbKmGZ5u
         Hka527kJtqwJ36LdG8OE49t8vmg6R3jj8M3NrW4ASIHbOPTtnJKoVlCBZOxsrlaEn6hl
         0V5A==
X-Gm-Message-State: AOJu0YyYlUdjygp1PHRrROXx2Tk33rzFZYRl8EmfIUd8htjFDFWUh1Zw
	GRXpGlf6ZVROxTGfXI5v9XoZRMe8xteLr2qv2muzhdemBA3iNdJMvPBrB6a821j/cEKqVT/FzDI
	bSjwA72EKUzC3q4pCfjG97krnazRohvAYZkM/de4F03uu8VgBj7q+oQ9bnErVk7lMUVlTCrrBGc
	nMomwHEdP8KqbTRKstLahCOdlp/oidNX2H33TM1340AG8pjBGwgQ==
X-Gm-Gg: AY/fxX5HffkXGkw1q+cucu8juCbzcGoxeBynbrGoAoE01IvRm2vkMSRgVfjpY1Ep3hV
	PZ5NnBk4ZzLPjftPB5JrPD2NdBXz2xDpdnlGwuyXs5x0i5Yx3GUWWDKEfLRuPfYKHSXoZ/tMoT4
	wDMmrCm9tiZ47GMwIiNVHXD6yrPgRYn//ZVttB18DHJqMbLlrgTbbYbT7RIC2lfs+BxhZxs+FYS
	CG3QjvotwYaEqJqe70v8ZitZYr75aDwZOAcTMWTh9IZZS7qsmX0ZnAPjhw45f4VdLMsmiwQ8AVb
	xfclqUqza/lTMMqiPcqfzbcKM02UiUD7RrIQA8oXzGqEhyJHXQFbaqztmwPiadrSD7Y6SQaYA/I
	HfWmbJHBEuEZyeWHb8TTdo/LKjReP30b1n5UezE6NjxIpZRzeQnkv
X-Received: by 2002:ac8:5812:0:b0:4e7:4a3:ae88 with SMTP id d75a77b69052e-4f4aac5d21bmr505336101cf.7.1767128833056;
        Tue, 30 Dec 2025 13:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGniPugfrtKUmrAdsMvFifGxehdYRRZoaKgkEFfGSz35yFouArtimGZRwcWQsxAfpgWRHElYg==
X-Received: by 2002:ac8:5812:0:b0:4e7:4a3:ae88 with SMTP id d75a77b69052e-4f4aac5d21bmr505335751cf.7.1767128832539;
        Tue, 30 Dec 2025 13:07:12 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac66841bsm242201241cf.30.2025.12.30.13.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 13:07:12 -0800 (PST)
Message-ID: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
Date: Tue, 30 Dec 2025 15:07:10 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, lkp@intel.com, oe-lkp@lists.linux.dev,
 Alexander Viro <aviro@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH RFC] fs: cache-align lock_class_keys in struct
 file_system_type
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LKP reported that one of their tests was failing to even boot with my
"old mount API code" removal patch. The test was booting an i386 kernel
under QEMU, with lockdep enabled. Rather than a functional failure, it
seemed to have been slowed to a crawl and eventually timed out.

I narrowed the problem down to the removal of the ->mount op from
file_system_type, which changed structure alignment and seems to have
caused cacheline issues with this structure. Annotating the alignment
fixes the problem for me.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
Fixes: 51a146e05 ("fs: Remove internal old mount API code")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

RFC because I honestly don't understand why this should be so critical,
especially the structure was not explicitly (or even very well) aligned
before. I would welcome insights from folks who are smarter than me!

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9949d253e5aa..b3d8cad15de1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,7 +2279,7 @@ struct file_system_type {
 	struct file_system_type * next;
 	struct hlist_head fs_supers;
 
-	struct lock_class_key s_lock_key;
+	struct lock_class_key s_lock_key ____cacheline_aligned;
 	struct lock_class_key s_umount_key;
 	struct lock_class_key s_vfs_rename_key;
 	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];


