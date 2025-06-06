Return-Path: <linux-fsdevel+bounces-50812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70910ACFC4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33395175DD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4792356C3;
	Fri,  6 Jun 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcFMmYle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6751DD9AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189428; cv=none; b=nry0RnF76+Pg+VbusxvlDaVDxyd8InRVukHULJNSGt+Y/CasU4lBa6ipJYybbk1IxGXraRBZ/oZTu1nhJjpSgmr2C3UdbdL8tox3coIB0J688AnYAfIhmL5pOZri5KsASey42oYn7InJSUOEWT0fsLRKimdz67y9x8TA/9PrZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189428; c=relaxed/simple;
	bh=HVE1G+Z5i7ndExI2k4+eSvEduCb0IPEkjOzuhcF+PlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A69wX/1D4+PkTr00kIU9pWwDL7RFaHZZPCLsfMBLVNdlMMRd8BUIX67pBMTP93hVhyDqAzIIPVGRpP5wsZs/YlR747VOHsn8rUF0kMpZZlF0dI9AskjUV1xneib1/fJP+ucVj9EeE3zBQ68VxCVG2APrBUHAQyJVmJOOnNUIOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DcFMmYle; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2351227b098so13775015ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749189426; x=1749794226; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flbL4ZAGKopRBR3RHJC7fuG7mIkT0wjs478w1oV7gYw=;
        b=DcFMmYleRSDleGws8OdoUqIh/IR8R6eTUP3ZmjU61/I5xnEijXUzjxT8JJpy7uZ1+R
         JXFOOkbgZazFnro6EhB4tuROK1bJ6jP8uQ3WG9QQR6zqyZUlh1xZfEwE/dpQKPB+0rdc
         YTzzJ55b7xYu/p2NypStLAo5vIYrpSPAAjNhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749189426; x=1749794226;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flbL4ZAGKopRBR3RHJC7fuG7mIkT0wjs478w1oV7gYw=;
        b=Rt8nl+Rz7hygnO3gP8t1vgl6komjitBC3mGyE/MyAp2t8XoVJSKxVQ5LlY1MvBMz3Q
         8sl+bSXHjc3M7Uds5C95DyIIfx0ZMN5zkHun2hfOyOJBJJI7ufkOLQqR/H1izP+K3sQo
         72nKAi0BlqK4yAGVHSttnt6aWWPZhjARwo8Zkm5DpJ6worwYERBAmU4X8Py112QgYjZf
         OnFkTL5esRo3JJ2Tb5KeNW/xLViIeNN/N/9gfBle8Ur0TFgbnUeDHwocC0ibsNJGvT8P
         h2I4vh8XOmnU5HMCAjOIkA5I7yk580yHA0J8IZgIQoYfjbHbRf+F76AVescBNwvT9SWl
         v4Og==
X-Gm-Message-State: AOJu0YyubrFn91r3uEkgff8jTWERFR2PDWMH08HrPkeJJ5bBHocVxGi0
	wSZP9IkehO/xlN3RX1W9qNGb97yHbMNpzviQ2KHU33TfzCi6w58cfc9+4btGxnsqmA==
X-Gm-Gg: ASbGnct91spWmXi1wpQmS+LYpJPmPAm8sWINnjMuf5XtoJfv54lLX93cfm+4zCdaPFy
	37eGGH7etgCJG3q46C3KBu8HxSXTCpqbSORZLCwfY7tz9UhzNnNr7te8U34VJRg9XKzRFLdWzaL
	2RCgCq5OrcYZimM/suisJ3+FMsDgfZav29BqVZkNsZwFLooFU/KB4sIFg6lYqXD+rG8Rq6HSWqB
	XL6bIciet5oXonQJks/0+r5Q9dxQ5mSH3mKG8m9fohfjUXKSmlR5e3OoZIVzEkTABFDjWJ8ztym
	mvvZoVmSxKXOSVdcxEhvbWcp1NGou6ic46Kgcjs5/OgJJxRPCMvDX4uPjzr77Hva/g==
X-Google-Smtp-Source: AGHT+IEgAbjDW+mS+YznEbzmeIXBrYaqMOw6H2788sgyRAnufkSPuz90MitCidMrgGnO9vwICzwPgw==
X-Received: by 2002:a17:903:41cf:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23601cf0ceemr31019615ad.2.1749189425909;
        Thu, 05 Jun 2025 22:57:05 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9926:e211:3810:bb30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcf39sm5189745ad.93.2025.06.05.22.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 22:57:05 -0700 (PDT)
Date: Fri, 6 Jun 2025 14:57:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: fuse: suspend blockers
Message-ID: <jofz5aw5pd2ver3mkwjeljyqsy4htsg6peaezmax4vw4lhvyjp@jphornopqgmr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are seeing a number of cases when blocked fuse requests prevent
the system from suspending, which is a little important on laptops.
Usually something like this:

[ 36.281038] Freezing user space processes
[ 56.284961] Freezing user space processes failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
[ 56.285069] task:secagentd state:D stack:0 pid:1792 ppid:1711 flags:0x00004006
[ 56.285084] Call Trace:
[ 56.285091] <TASK>
[ 56.285111] schedule+0x612/0x2230
[ 56.285136] fuse_get_req+0x108/0x2d0
[ 56.285179] fuse_simple_request+0x40/0x630
[ 56.285203] fuse_getxattr+0x15d/0x1c0
[...]

Which looks like wait_event_killable_exclusive() in fuse_get_req().
And we were wondering if we could do something about it.  For example,
perhaps, something like:

---

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f182a4ca1bb32..587cea3a0407d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -241,7 +241,7 @@ static struct fuse_req *fuse_get_req(struct fuse_conn *fc, bool for_background)
 
        if (fuse_block_alloc(fc, for_background)) {
                err = -EINTR;
-               if (wait_event_killable_exclusive(fc->blocked_waitq,
+               if (wait_event_freezable_killable_exclusive(fc->blocked_waitq,
                                !fuse_block_alloc(fc, for_background)))
                        goto out;
        }
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5b65f720261a9..1c8fdf1e02785 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -628,6 +628,19 @@ do {                                                                               \
        __ret;                                                                  \
 })
 
+#define __wait_event_freezable_killable_exclusive(wq, condition)               \
+       ___wait_event(wq, condition, TASK_KILLABLE, 1, 0,                       \
+                     freezable_schedule())
+
+#define wait_event_freezable_killable_exclusive(wq, condition)                 \
+({                                                                             \
+       int __ret = 0;                                                          \
+       might_sleep();                                                          \
+       if (!(condition))                                                       \
+               __ret = __wait_event_freezable_killable_exclusive(wq,           \
+                                                                 condition);   \
+       __ret;                                                                  \
+})
 
 #define __wait_event_freezable_exclusive(wq, condition)                                \
        ___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,                  \

---

Would this be a terrible idea?

