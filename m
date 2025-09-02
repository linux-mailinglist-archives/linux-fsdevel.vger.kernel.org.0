Return-Path: <linux-fsdevel+bounces-59993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327CB40769
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893155665AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B53148CD;
	Tue,  2 Sep 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyc4xh0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8D314A60
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824119; cv=none; b=J8pzpQA/9Uf7joBccMMv2T0z411BjnL4VGZiF5ZqFVRTfJUw0OKsv1s4co9YwUfPFQaWGKI8Yt0ckLjKMNbqvcutKK1kXeFSHUiXLow7ii7OrdTTlUxf1EBeGybrm5H1OpY5nimRc5JE9nOuBMv6OtmB84kGMg9+Fvki2IINFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824119; c=relaxed/simple;
	bh=qfrVAGjHWJB3gsB3fYztZc8uu3b4btKHcgatz0q3kYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAT60oYA1T+vWFHTPmUlDmANhC/U/qMWwfwRJ1vBEiYwaYfg0SOARscAqil2mESW+MFR+RMepe7Uf0gGM9Ig7K+5aDnWapC7CdL09eRf5Z5HzhijoP/uhD8/H1gVENF/wVqpaQdpTlUFTBTlDjIAleNqAlCU/1vbj3eXqgbR4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dyc4xh0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ6jbAuiS+tbmDjSvZTGdhF/BtTp5JKUp4bByQ/q1ck=;
	b=Dyc4xh0lObZbBNZYcdnz7J6TswK1vmDhSbESkb5MzOEa0SAVGetca2U3ZWLEPJ+VT3QYJh
	zI953g3vHKWwmcT44kXEQbq64na3VL4mfklL4Diw+UHr+/xSqONgj/ndw1wQH1+7HyPSrq
	48BWuo+pQXLs2oSZvJmAjq0KfUwUrhA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-E85xmuiINzmsTKF4PcQvKQ-1; Tue, 02 Sep 2025 10:41:52 -0400
X-MC-Unique: E85xmuiINzmsTKF4PcQvKQ-1
X-Mimecast-MFC-AGG-ID: E85xmuiINzmsTKF4PcQvKQ_1756824111
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61d2ab4bcbeso3097849a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 07:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824111; x=1757428911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ6jbAuiS+tbmDjSvZTGdhF/BtTp5JKUp4bByQ/q1ck=;
        b=w1+jkI3ZZ0hDT46Z2CPul0hB8wJ5zI1ftMM2+8wRxeow+q3ZTdSW+S0+luswOMZfrt
         gBW4f8B5fqiTMlnyLUFwh1K0A6InJlHt3haManBMLF2495h644CO4B7/DHVS6zuSI2cM
         WnczLoMIXS1abfaCSETNRA/qLJqrD8yi6y0geH5esmpVQ/CZrJ8cz5ItpehNoQJ9+yA9
         gRk5xgnw0eYgJKDx5BtMSeiWPZ37oqWewiBMJcwuYE9sHah+DdEvte6rIXTqtBrxw1JD
         zXcn5W3eTd4olFO7d5mNZ5unKqEF5XKZHi+9GrZXbnJJNuKoZd7bCkQrBWyePFH38NPB
         6MVw==
X-Gm-Message-State: AOJu0YxmbnaXQA9c2sPmNOYBEAxuclol4bhFqcx2yN0YCR2t9zHmNP3G
	7WRA28nd4cA15et+NaglWrW/vEYy27D6s0ytL7BSvqj8LYcpyHcR+SMQ6c2BD7PalrRU04gnOw+
	t6gTzrVLI1QR4LvT+Fp5GvTuw6BdT0GEd9aBig9bpoBWYFIEI7b+MRHGuWzGZ01mLCdl4ZKB/zk
	jpEHF1ZQnQCMxe+c3BRBa03G9MWKnc2w4seNKRNQ2dZoX3+RAPA65SOg==
X-Gm-Gg: ASbGnctzGRqxEIckbQrxzrKHmedhCTcQMyVS681hlG1F8rSoVuLdhmjk5q/6G8DAKr/
	wS6Wks5ljS6iYiO3QXKYuyfKUCADSWdqviPjvthIUB4wGGiePp/mVKerzyN53BpjRmuu8/i5/U0
	eHAy4t/knmzplgcLeWzeVI6W7gUp6KugD52lgIt1qMye6e/HBv1z9D9ZHcqf7z/j/Uf+tSMjFnu
	tryPfSOWCh2GX2N0Yg11bGHO6J2sEkPuUnEWzNLeIQQLRiiNTrAz6ZMHWv0A9UX1K0twqudtT0w
	vV5T5t8oSuRglR4vlCPWPbq0bdIT5QdPaAJPFodUCeF46tBMZCC0Xk4K3ppnQzL3yYPH7ey8LtO
	bTMRRoLSi8UtEGhNenOLCgqM=
X-Received: by 2002:a05:6402:43c8:b0:61c:9970:a841 with SMTP id 4fb4d7f45d1cf-61d26d7874dmr9875751a12.25.1756824110874;
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/zlcG/d/cHFeJp3GE3kprzB3EdU2LFLiWq0oBCRTmlqo4xIQXiq8R425IKyUlqVRb5OXIHg==
X-Received: by 2002:a05:6402:43c8:b0:61c:9970:a841 with SMTP id 4fb4d7f45d1cf-61d26d7874dmr9875724a12.25.1756824110409;
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-155-210.pool.digikabel.hu. [188.142.155.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm9704514a12.8.2025.09.02.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
Date: Tue,  2 Sep 2025 16:41:44 +0200
Message-ID: <20250902144148.716383-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902144148.716383-1-mszeredi@redhat.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of FUSE_NOTIFY_RESEND and FUSE_NOTIFY_INC_EPOCH fuse_copy_finish()
isn't called.

Fix by always calling fuse_copy_finish() after fuse_notify().  It's a no-op
if called a second time.

Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
Cc: <stable@vger.kernel.org> # v6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index df793003eb0c..85d05a5e40e9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2178,7 +2178,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	 */
 	if (!oh.unique) {
 		err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
-		goto out;
+		goto copy_finish;
 	}
 
 	err = -EINVAL;
-- 
2.49.0


