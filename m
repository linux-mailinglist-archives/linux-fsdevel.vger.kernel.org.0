Return-Path: <linux-fsdevel+bounces-77299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOE7KBI1k2mg2gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:17:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D414557A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2587C30A8A1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0236315D23;
	Mon, 16 Feb 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGbwzfUd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFHNSdXo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A430CD91
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254393; cv=none; b=SbgG00UprIq2gCqaG0h1tlfJ6ZZ0D6CFVOJqpZZRMMcaTqu0aupJt2lx4Dgn/ojd7ctRrBbK1SajE2KNaoL0UOQKCxqAPmfjRN7qBDHUjT2GUo0+gnDJsTy1rwdlhw9OhZYPcKrdiqIpkGwOCEz64mkaUt1YeALEY6R+NVIRAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254393; c=relaxed/simple;
	bh=lNDowtUHSkw+k/WpEDgGge0SfGDSJL247zcNQSwuyB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kwn99D+XnSbaqt9rTNouNaC28sj8iZh9pzDLWuS6DzkwNeQIKcwomr36qanqzv5Cir7u09Mlq/d7IWzIi5M4LCcMj3fdkcqnaXIPEbLByF/cdQXSvEK+oaid2nuZyQ/gg5p+fyZsW0u5YZDpOzebdyFZ+MNX7LL7EYM0NkeziRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGbwzfUd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFHNSdXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
	b=YGbwzfUdoXX9hbcnZEmgpMtCOnFDehEiq7YmGUP2OjZS8T2k0GyRjSO9IkgwzVI2+pDHtt
	lDVeGVZDGmSIfsa3f5uta/2Uk2tCEzSzbtB0jsYBYstvubu/pgbc0H+wxp1mlN+GKTxSsH
	dSME3zjQqAD4Oaiq+Ua6yxsZeqQP1vs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-JY-CqmHqNNuoxhzJF5l8_Q-1; Mon, 16 Feb 2026 10:06:30 -0500
X-MC-Unique: JY-CqmHqNNuoxhzJF5l8_Q-1
X-Mimecast-MFC-AGG-ID: JY-CqmHqNNuoxhzJF5l8_Q_1771254389
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435db9425ebso2953277f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254389; x=1771859189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
        b=NFHNSdXoOfWF3rPDPk7ZrUrna2Bg8IYU1164qW8o8JylggKfSXWmTH8wr0zwe9r2fq
         TJnwL3Sj0JI8+cuJv684XWYuodFAcbQyheSaoMW4OGbhV2iASGf/Rn+kjfawNUwF4q0Z
         V6bCHdiFvATH6b4FY6HMrK7nRUIJaVs2ONqR8DT32MBtkkYno8rygXU9B551Gj9VkD63
         s5h/8GIvv+l3MTJobzGVzFMhnFqZ3CUonn9ULz+XeVyWA0XE+BMwMfd0Y0zBYIEDteZT
         Q4/v+Onx2GogJ5hllVdOak/o8R48+3rQBF10IG/ql9nDb4DG6Jt8gCYFLykavQg/n75k
         31hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254389; x=1771859189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
        b=iknIgYzYZDg/lcqiOWsGrf9qVeYiQrpYWGNDtb9UXsGx5TQ/LhrwEEJiOMDpyG70MZ
         VQHFBpDBxRg80b25yR75mVgWnPKbhBozk73mbxjA6x82mv3XWNsc9f1CokeoFgsBJAmX
         74KHUb/tQ6S7XlG/BssUoz5T/RB9L6hjTZgDPuq3E4gkcnzEed2EcoDsiV4WmuSmHIMR
         EpdDzJ8Fv7wwM36JKrpG7uEL26k1Be55A4F+vZow64C/jcJq8H8zoFTEAoXAhnBM5GXm
         t2QR7zRquhDDom/B9AZAAP7yPkmjfu0g8BOmx04hdIN0WiqDxNKE6HlEmzABuF60Yzi0
         933w==
X-Forwarded-Encrypted: i=1; AJvYcCVorAS2RShlbBPe6iKxiPef5da2cs2mHFrpAoWu9IqQJAT1DpZy1G/6fhF9dpLX1i9QcjSd4H+lzsqAJYsK@vger.kernel.org
X-Gm-Message-State: AOJu0YyFE9QLOMSVXJPrPRZDgLvWr+3Fhozi9yS85lRE9ToPJa16ZR4a
	mYBrsn/1OqExykou/5O+aPzrruJCBLi/MkM2TYYaYGvAFkZ7D69DyK1EcdllYhph005xQr7udgS
	pb1psb/YmucCOtsMzO5m3pY0LSwHwQ2tA0U6L2o7dwj35/gThPTEUJ4f2+c7EafUActc=
X-Gm-Gg: AZuq6aL9df8pid2xqzV12AGIsTdesK6nSNVUy8/OIfbfkydPRapT1WAnF8/DIbN3Wzz
	V+v8tJkkWLed40gw+u2JYPiysrSzlq6fPzN+D8fJIRlwBg6FQeX9NG8+oc+8nexEosfKj33z57i
	tCNCgnJqBkEmA+O97W7uDRda1jiZPbFr90ctqiPBQ2bxwrJRiOesY0DlsdcU5yGi5suPAXrtdoe
	cSEeE5/YUO8W/1mEGM68Ru7si6yuOnvFLqJ6mE5Y0ZMeacIPi5cHjKtveAQOmfW1jLVVjVhKVVC
	mpb2XyrUDbd0E6PliilcwpQL3sro6sYxRQKgwD4Jf5yyiyX8pdbo0nx/N3nnOj9Pz64lPd0rnUG
	euPyEJkWsROvV/WsjaDBmRPAACRqRJ81NRvVBYTdYoGx7SKtt
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660425f8f.52.1771254388687;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660369f8f.52.1771254388191;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:27 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fanotify: avid some premature LSM checks
Date: Mon, 16 Feb 2026 16:06:23 +0100
Message-ID: <20260216150625.793013-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77299-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE8D414557A
X-Rspamd-Action: no action

Restructure some of the validity and security checks in
fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
denials in the audit log where hey shouldn't be.

Ondrej Mosnacek (2):
  fanotify: avoid/silence premature LSM capability checks
  fanotify: call fanotify_events_supported() before path_permission()
    and security_path_notify()

 fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

-- 
2.53.0


