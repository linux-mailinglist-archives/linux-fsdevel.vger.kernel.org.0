Return-Path: <linux-fsdevel+bounces-43013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D5A4CF0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 00:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FC53AB6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2223E23C;
	Mon,  3 Mar 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABBAO9bT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39123C8D4;
	Mon,  3 Mar 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043076; cv=none; b=C+Qo1REO5xI9GIwCzraNKeGJwnQGzbcsEoPixgtMlqJuSWsVPUnPaPGfnXsdx58ruOBU3x7zBbC0lv5BU9YdTQ3MYqJmezdulfMbM404QZrzDQvYTfFtdy9X4hOrAHKVdp89CljdSMxokakvk9LCU3KPnSTKmJ1u0E/uDtY/qOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043076; c=relaxed/simple;
	bh=+k7c1OL2y3P9gA3cCz8Ikn8HZr5bgnLQ7OHuC/VOVEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNBCGterLZXkNDC/+APqhhdu1v8EiV5lWBMJLeSDTgMJtjukE7GeGszUiBXByV2PKmR3B769VMoxLh9tIN6PttWtg3h2C+yzj1Uxzwro3qGR1ucPCuCrUGQJ1LLJPXQY715pfArhbQQghjzVxX74aHs8vE4FbgwB+mU9R8dyHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABBAO9bT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394036c0efso32127365e9.2;
        Mon, 03 Mar 2025 15:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741043073; x=1741647873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWqmfQVrYo21Wc2s9mCGBxeqvQkF9gz0ryHa7/Ih4L0=;
        b=ABBAO9bTLXiimUwqGhzWarVTqwi/WgfaYlKjI3Vsi7Tf2olDaG6c3lDavhcvqqoUoy
         uMDjS1lBNvNtDFRWSP+e2nuet9OZlBUw1flgR0twmrM/i580CLrLWEVhh3pHrU4E3Zin
         vP5s2sJZpRLdizwfDtZJy/S91DfwvST1FlPyaWRMbPphiGmgQLKKsJNMZqJl0IGlMb3Z
         AImJt2EcaVX2L5RnJ6Ne+GTdM3HHxtPS8yMTWwfHRfRGIc4JKEJCgUp3Ce60ZQv0v2cZ
         6qvlNDgCEuDpgd2ShmGlMSsx/h5/mGpMdjHZKOuibYtGf4TSmfow9HOfzvRz8NCEojlM
         vKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043073; x=1741647873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWqmfQVrYo21Wc2s9mCGBxeqvQkF9gz0ryHa7/Ih4L0=;
        b=EYc9blF7+IlRtMz94z4FeApd/wlrYUicy+fFWVtJ6s/kfbCOEoBheH2PZaWy6foozx
         k0aCeVDdtVT7ouQcf4FsSzn1bIMX9geyrbMpHkyDOYMDvBzJZx/dTj2KmORLZm0vltFD
         l648G+1icIAjI9xUE48Q+JHuCR3ZrDk6PHA4olLh+FH9tOvW5bUEtLomMNNpK1VkdStd
         yD/38vXZAyo4V/+iovXFowfSK9xmiX2rD/zPEKEmVhfcxY58eBD7kLkebpXbZI+XU3DW
         fe53jlJxqJbqcRnMaYA3SfsKnPHz8EtSUYELuxCFaj2ImUxWAObCNdtulFBV2AefXVzI
         6HGw==
X-Forwarded-Encrypted: i=1; AJvYcCUAjFWcgBzsbQzHFjC2lmSChbjP/W4egj4UDOChR2auDkJgFT9Bek17Gxk88a/x5uIX6SumsNxOixbqVemB@vger.kernel.org, AJvYcCUsGzdgbSgjbzpEjpS8bxTWMVQbAV5VsBOVISot2bWtYv16S6cDUA0pVT9ivxfZBcZgeso/op23mN2HhL3L@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIP3jf9UGCtFyCBGxV1LbIlL9/sv/RRlFlVWyWR2KBptQFrXn
	J0+5paEK3Yaeop28TdjRrTMOWbjUAWYvhPgCMfwn1JI+a98j/mx8
X-Gm-Gg: ASbGncsMnArdLDNMQKo4DRqxm0hLg3iY6y0+lJQliWkYx1c6z85tN+CzPSx92LAd4Mu
	6fKz8OVvYuYekikra/y7NxxMhssz29bFOor3lMSmOSPPViyc1KXQPcyJLOI6zyt5olEek/GgBQb
	LOPvN4RfOOjudlfKO6A4g61OoCI2dZLx+Vr+cfLltFapEe1wzuaKWJurgcjFeBp50vErm4/xbpC
	w/ksoIfeYR42jKHpwo05gTrPTjFWQ2D1oka2F3Xor4CU1oaqhleK4wHtTpJimbmPSFyJNrV0dcD
	LWXOcbvSKrb9Xc671AzIHqIftubqrUxKCQyDEkXl4OP0RBu+mayIlHKixwmU
X-Google-Smtp-Source: AGHT+IFPUSSQabR3lRr5osHSSuASrvSwn9HcZny0KkX3Vwfz3cvKINUYU1ME4WSxnwhA6KiSnzOubg==
X-Received: by 2002:a05:600c:1e27:b0:439:9828:c422 with SMTP id 5b1f17b1804b1-43ba7493dd7mr122039365e9.18.1741043072844;
        Mon, 03 Mar 2025 15:04:32 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm37679255e9.31.2025.03.03.15.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:04:31 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	brauner@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3] wait: avoid spurious calls to prepare_to_wait_event() in ___wait_event()
Date: Tue,  4 Mar 2025 00:04:09 +0100
Message-ID: <20250303230409.452687-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303230409.452687-1-mjguzik@gmail.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vast majority of cases the condition determining whether the thread
can proceed is true after the first wake up.

However, even in that case the thread ends up calling into
prepare_to_wait_event() again, suffering a spurious irq + lock trip.

Then it calls into finish_wait() to unlink itself.

Note that in case of a pending signal the work done by
prepare_to_wait_event() gets ignored even without the change.

pre-check the condition after waking up instead.

Stats gathared during a kernel build:
bpftrace -e 'kprobe:prepare_to_wait_event,kprobe:finish_wait \
		 { @[probe] = count(); }'

@[kprobe:finish_wait]: 392483
@[kprobe:prepare_to_wait_event]: 778690

As in calls to prepare_to_wait_event() almost double calls to
finish_wait(). This evens out with the patch.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

One may worry about using "condition" twice. However, macros leading up
to this one already do it, so it should be fine.

Also one may wonder about fences -- to my understanding going off and on
CPU guarantees a full fence, so the now avoided lock trip changes
nothing.

 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2bdc8f47963b..965a19809c7e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -316,6 +316,9 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 		}								\
 										\
 		cmd;								\
+										\
+		if (condition)							\
+			break;							\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
 __out:	__ret;									\
-- 
2.43.0


