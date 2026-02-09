Return-Path: <linux-fsdevel+bounces-76720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NdJMY0TimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:04:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10233112D72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41E22300BE93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A363859D1;
	Mon,  9 Feb 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnuFnntJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7C239E75
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656574; cv=none; b=m5GB3JT6ypVvg3Gi4F040/9CSJgqbwC9UxhftZXeZMwxyZyn9+h/Vqjh9eqFnkiCPxCrCsX8VNMY5cqoRVMPxXAl2PdiBCMSED0g55ugHEFIskeUHvVLHxsNHeEwmYCc+PGd0XeXKlCCTB8DCXJIlGTK075TuOIzn3LtDMN7JJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656574; c=relaxed/simple;
	bh=kilC+CY0PbwU9Geq85da85AmbW/kV1eBYvXJ+6IbO54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M0UsvgFTximSsh3uVu2+YeV7lIfitEjsb9ummHvLZvFQGSHUGzl+lpjdpMDs4eLs98sAXvCoLgogjfEiBQ1vGx9S+2haG9ZNco5Wkh+GlC/yN/OyjZPDOuhmDCsP0yQQj1XLwLxf7fyIXRzuoekdPEREQDoxwYiZWr3psOfRizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnuFnntJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1949592b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770656573; x=1771261373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=gnuFnntJ2GMVtFXmMslkmGSuyPJDoDcNhaLQBiTyb/XlV5AzUK0ITnH/cfVlppRtok
         5jKBJzqEGXGKjrjeLxt2VBsMDcpKm37EcvYdxN8kSt0f5GsRWbqpIPUUaIcmcBZCBAqV
         nem7d3j8MshMW/e/UbGLFD1t2eZATw4js7REYGk8HoPSrWYBN+Lo238+LaBghWtCDaMM
         7wm2eTUeCnbEMevKTPE0YXGxqiZJzr3k1EnPT71M3r2Wrx991dMnnwhnrbSV11DqS8G2
         hbzh2oQSl2OR2HjqsrR7cczj97VHoOqoQBqi+jasWGxyUJoln5LX3Zl+jxS+QvjIYtkk
         SKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656573; x=1771261373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=RdMFnuQzBeAyyPBOZTX+hM9aqK+RMA8NbeD1yknEH6JQOOsCDqa04X8QvZYuNrV1qB
         DtS68ayxvb2BA4iPiO5lcSAc/iPAzbRzpIFCc+SEniF6t+nZ96jz1wmqF40d+FcGtgR7
         fVlo/25Ufl1vTC/gXkFxWwpH2EyAA+KwSuSQRf34/BJQm4TSHlAjN08NTZsAe6MzT3WL
         HqX3FbgQ0iWF5xHrzgFMhMdhgeJ6qX0JlV8eUczZIHSBki2Nvdsj2jfYTTbGIfL5cUXT
         z42kz4OmJt/3+dKVsDPDp8pyKPcE4BpavBqSzWWAZqQjEXxxKWX6Sx5QHZdwYVaHrOH0
         WCsw==
X-Gm-Message-State: AOJu0Yxcdxr0cZL8DwdMMY4A77ydXwFYsuQIKoroM2I0XH2UlijiM8hF
	ZR+BcLPgqHpob9tQLChvqC7lqpOAmzDjaDhH586wyngAcgNxLdmfQ059HHIteMxKxFVABz+Q
X-Gm-Gg: AZuq6aKTazP9igfpqqu51VsD5r9IR6PPdR/hBWzRvSSPJ6MLoxhAfDC7c6oYLxEcEXm
	Q3dOiPr16Zt1NuykY5QsRtnbV70OKH0WTvSCdmoCsZnLKPClHl4/Lw1NhYxgwVyUlZ20YDGTOv/
	iEgPdIykZg43++XCJJg6HDp0/3gNucym0UZ1zwyCV5zhSnzzkKawO6O73Glk/lxJ+iFehbhwYzB
	bdfrtb8l3NLLAu6amiELdweyplWn1WOX90z7G34FdHWYfljm7sBf8/Zpp6Zx+h6bQ9wE+Tmf9NF
	T8VPbT1Gm99x675FuwsH/sXeEMhMhU6VWHm11ziacHIDhAoz+S6uOuAWDLhe9MVZ1cI+mm+kvAM
	3b/HNCsUbsAaZm2n6p2oV18XdjmHz2iQdmVp4zZpoCSpdRrw9HZV+2D2U5VInMgor9RK2yJtQVN
	BkY3+ukBOaNHeLQFt4EoQBt6CQB/6U9vkHWYFlG3g=
X-Received: by 2002:a05:6a00:2d92:b0:81f:44f9:7c1a with SMTP id d2e1a72fcca58-824415ff98fmr9974589b3a.3.1770656572972;
        Mon, 09 Feb 2026 09:02:52 -0800 (PST)
Received: from localhost.localdomain ([115.199.244.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82446e81823sm13388491b3a.12.2026.02.09.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:02:52 -0800 (PST)
From: oaygnahzz <oaygnahzz@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oaygnahzz <oaygnahzz@gmail.com>
Subject: [PATCH] [QUESTION] ext4: Why does fsconfig allow repeated mounting?
Date: Tue, 10 Feb 2026 01:02:45 +0800
Message-Id: <20260209170245.12703-1-oaygnahzz@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76720-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oaygnahzz@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10233112D72
X-Rspamd-Action: no action

Hi all,
The mount interface will report an error for repeated mounting,
but fsconfig seems to allow this. Why is that?

Thanks.
---
 fs/fsopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1aaf4cb2afb2..06a8711dd627 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -300,6 +300,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 
 /**
  * sys_fsconfig - Set parameters and trigger actions on a context
+ *
  * @fd: The filesystem context to act upon
  * @cmd: The action to take
  * @_key: Where appropriate, the parameter key to set
-- 
2.33.0


