Return-Path: <linux-fsdevel+bounces-22612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755D91A420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D43284152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CD14F136;
	Thu, 27 Jun 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT55KlSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492A14F115;
	Thu, 27 Jun 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484794; cv=none; b=Hb85oR2C4mtPJ83oI//qIAbQuiyMANXiaA+KluyLfvcvCU80LXwVXNbrUbOrbLGm/6IrA19xeTptNkfTFBZrntl0RprLOrVOc05rwm2HOpO3iwpk3AYO3+R6dgH3e95NyuyPACDXJ/ZkUJ0iP87Xio3dhOQvyF/6+rI33UkLsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484794; c=relaxed/simple;
	bh=Gagml2vWKb4HTLerZRwBKq3Is+4TMHNPAjmAwDGGOrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq770LEbI9iCiQD4RNVTyci4QoFlGrFqLtcDjxZTiEMxINEwXK8SN7jUhkoEdmBRbBqc+cTRhs6GOL60WK06LA7NN4UpkSuMoo2ND2a7p7jkqtOg74eL3At2stARnrqw5fb6PjthhtkHs6P0n/Cqo7IhbD07PTu6P9yJt0TxRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT55KlSK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdd893e5cso5918576e87.1;
        Thu, 27 Jun 2024 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484791; x=1720089591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VCM3WkcoPjwO3U6PrjTKLd51325lQXJKBmY5RFuANs=;
        b=OT55KlSKY629TGYaRxrgU1ygv+/4KLSRApzewn5GNug8s0tzOGOrhBCsyTj26m90uk
         QFYn+Dl6pmQB7EDmuEQ6flPCOf0YX2d3b1tYn4xwNpd5orAno/Wj06GfohwmU2mEASuF
         IukVA5SlqsqsvyLIKJYcVpBmtPWL3BK30Ixk29f3i+Bv76lBOS+5Ka+hY8EhQMWdFhaJ
         Eh3a9G+fnBqrhZHW4AKSButMRMKsS2wR7Ktgdqoxhft8cXldPFeTztagt1SndkeKORDL
         uBBa/RribHUFvFAwVvJBiXOkcuEbG1bPEm+TndTjsnh1RG2Sy/TJieBJYZu08ONsGogi
         4woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484791; x=1720089591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VCM3WkcoPjwO3U6PrjTKLd51325lQXJKBmY5RFuANs=;
        b=rb3BMSt9TxZCECntEFUvE1aCD4/uQnPUfxxi5cXXv7BybGCsrGtEbnLDpMARHNztO6
         1aOUzROsQAt/hPNUR6y0DUI62v4IojYDC08iq07nlHpsWjzPSPUT3GfdfwVlB+Mvl6tN
         rzV3apW2X+JApRwG0nVU1vwWBlxaEGOVa+tsgAaNaKHIexA6MN8ZlfjMiMCeAbvA4N12
         fEYBK0FKSthLQBdKvOuFz99sOdJ/l5AjCfdxr8k420simzhhexIQaLXqyQDaJ2MaR32q
         1ZR+Y5pkg+4mpP+GIo68M2VVILRL5TPcfHny+UDRpzS0mZI+r57gl/+1Tl/D+cEzjl4Y
         rhHA==
X-Forwarded-Encrypted: i=1; AJvYcCUahOub9Y3KXPMwcbjJ9/vPV+Lm74KOz0bqmGx726GAExpT9a8h+Ki8JBznhAoPAQlKNGStCNWNqbKQC8mzcqrhNgoTfV9YmHJhzcue
X-Gm-Message-State: AOJu0YzCfcdmhIvtTWPstjuu+qfrxaFgqrVUP5aGeBtvxrW0su6At2/f
	QUbTXe1pUu3d2mXSH68pWe5v/fLuXZTaibSZEiRtVKtH1PfkJpgH
X-Google-Smtp-Source: AGHT+IHG22q5gGPmyn4JxHMfF43Pxa48+aJZpq9H1yljtLt1rsVh3WR/Ktwueqi2rt34Jzl/0priJQ==
X-Received: by 2002:a05:6512:b0d:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-52cf3fa14famr7561011e87.18.1719484790765;
        Thu, 27 Jun 2024 03:39:50 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42564bb6caasm19957195e9.33.2024.06.27.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:39:49 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 5/7] MAINTAINERS: Add entry for new VMA files
Date: Thu, 27 Jun 2024 11:39:30 +0100
Message-ID: <22f916d5e6d24e095a5537ab590fe26cedabd749.1719481836.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719481836.git.lstoakes@gmail.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 098d214f78d9..0847cb5903ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lstoakes@gmail.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.45.1


