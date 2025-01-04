Return-Path: <linux-fsdevel+bounces-38397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F7A016F1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FAA162A17
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5A1D63C1;
	Sat,  4 Jan 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="aFVxSd+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797531D5CE5
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736025369; cv=none; b=ScrE3Tt8mW7by5se9q5typstABPswsP8IwrOoZAHPbU3LfZkO2kcjYAYu3QMmCPfcz3q3tqmzT3q/y0GhTr3ktsOvxDJuKFtaXeeMradnLOrlQ2K6FTPplu0mR9arlbt8qkvBVik/6VN5/QO6n54JUCtonsK76MUhWZd2MnzZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736025369; c=relaxed/simple;
	bh=DYU5AoJFN88QPgDHNfxcw0BVy8MieTaaGFGqDOAKSrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4L0mdnXLffSln8mnxKmg8DhamqxxY5iJEbxWcUyM9Z3oQ9B4lbvAQs7O/KXZ/+H/KE1v2kHrdJucALnfpAUK8/7uHncfCoKviDBYu5m73HJOkNw5tgyZCHyBVgEIexp/a53jYrNyhfwIDioAx+ccWU3s7xXVhJaYxby2tA3cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=aFVxSd+9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-386329da1d9so6061454f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jan 2025 13:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1736025363; x=1736630163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyr/eOHsgmSVZnniBJlKIc3iYrLLHuoPpsr0i9Z8NYs=;
        b=aFVxSd+9V+AcWQNM9IkJiCbzjTcVn/fkwZ69dGf3fZvq+qoCj/owq+Uu+3SHEJ/RAo
         rUHq8b10WCyXM3QS/pZ3v3Ds/xVqBOJyOtyZst4Tl3QBCEZNLjFdRhXrC4zmrukW2Gsg
         SHzm3Jl19Mpvm9fySd6oXqJJ0LeLp17duDqmqy7ey2q9i8U1A8Vs30r/AyVgqtcZz+cK
         DqlamlV2/rFJ66Re/5YwklnRPXfe9iwVdL0MbDVaBv6xUpqiL0Ag0Zwio8Pw9LbQX5dk
         tNxTJYTN/tyKZixoF0pCRCnSduhvh3WsrHxDB+QlVj7AAmJ4uakE/6d+Mz02VeYrsBLr
         CsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736025363; x=1736630163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyr/eOHsgmSVZnniBJlKIc3iYrLLHuoPpsr0i9Z8NYs=;
        b=IdgrpB6arHNG39eg+5nkLOQoGiDYPbmWa0W2NW/pLoBovCnLY8eHtC4Hd4qImME+7K
         l3PNmhNeQ2rrUW35k7+RRrtnZ7Zr3m81V6fadS/5/mVJJcAqaRmg3zKYtHSoeu0b2Gv+
         C5qLZgN6nhDY5CL71IHy7qfx+l3ZnDJWdNolCCzTsDwt1RPySCh+4eFLjTgcaAoyhBsn
         Sm3Gdb1CKSU69fcinlGLK97kTNgZs8r6kNBLIftb/HcwyKntyXR823nfQ5cX33cX4UBB
         806qFEtr1+edHoL9Ge+JNRtzYPF7wojr/Xrv5eWQ6T6PcWsGpIDyU3uv3CG0iNx/GafN
         sRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVkNZLq4yzc+hnsgLTVOENK7cE0MQYgkVJEhLh1hr83w4DjS77mNjkQqmwzh3Ae/fQ15TlLAFA6xBSzM+WS@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFUymaMT2eVhUzqNg2o38iZ4lOmLhJ/crnLQSvbo81900aQe7
	uFKDXALMqX+O1P53LvMafhWuam8z2EYxbtkaZEGoA4RJj7h62bJsaMvheYOMzFW0372A2Hldwft
	fmw==
X-Gm-Gg: ASbGncskAfHktXWzc2uLG61/uasY2FC8hfU9svxMCcvAAMQpnq/oSngfdWwDSettbQ2
	sVzPbmqlNboC1LyntD0XI9P/jOnKuEplb+/V/ubZ9jkRXbKPsQK1AzCcC9J2r4pvDy1DE6aY1aY
	XVmXBMbRXoMfE0ThpZ33CouaBmdLVls+B4d345/4aHMekD+Ut/6fgScViKPIEcEFrxS4eypWQE+
	peKawjKqc3UnRrL4bIrrpd3T5gdB9j4oZYtX0NjuCKc0r7CXQskLyjROND0gpBVyrib8jo5fRGt
	Yg0lws7Rz/9yr0dtMzS5qLBssU6Dd8aRptkhgwQp7twLPT14H8+U5H0qGS5mDSmV
X-Google-Smtp-Source: AGHT+IHiI9NKb62RzTDNVCW3aL8W1D6GUC+nkKfpURYeEe95xovPEND/d+FNloiqr8u+h5iZCIi17w==
X-Received: by 2002:a5d:6da1:0:b0:386:4a0c:fe17 with SMTP id ffacd0b85a97d-38a2220039fmr43957061f8f.27.1736025362594;
        Sat, 04 Jan 2025 13:16:02 -0800 (PST)
Received: from localhost.localdomain (p200300d9973d88005833f4708c0fe0a2.dip0.t-ipconnect.de. [2003:d9:973d:8800:5833:f470:8c0f:e0a2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a67c77a90sm5935667f8f.54.2025.01.04.13.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 13:16:01 -0800 (PST)
From: Manfred Spraul <manfred@colorfullife.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	1vier1@web.de,
	Manfred Spraul <manfred@colorfullife.com>
Subject: RFC: Checkpatch: Introduce list of functions that need memory barriers.
Date: Sat,  4 Jan 2025 22:15:54 +0100
Message-ID: <20250104211554.20205-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230153844.GA15134@redhat.com>
References: <20241230153844.GA15134@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(depending on output of the discussion in
https://lore.kernel.org/lkml/20250102163320.GA17691@redhat.com/T/#u

It does not make sense to change it now, but I do not see a reason
to single out waitqueue_active().
The code is copy&paste, it seems to work.
There is already a recommendation for spin_is_locked()
)


2nd spinoff from the fs/pipe discussion, and ortogonal to both
the initial topic (use waitqueue_active()) and the 2nd topic
(do not wake up writers if the pipe is not writable)

Memory barriers must be paired to be effective, thus it is
mandatory to add comments that explain the pairing.
Several functions depend on the caller to take care of this.

There is already a request to add a comment for waitqueue_active(),
but there are further comparable functions:

 wq_has_sleepers(): No barrier is needed if the function
  is paired with prepare_to_wait(). With add_wait_queue(),
  a barrier is needed after the add_wait_queue() call.

- spin_is_locked(): the ACQUIRE barrier from spin_lock()
  is on the load, not on the store. Thus spin_is_locked()
  may return false even though the lock is already taken.
  Avoid to use it outside of debug code.

(and, for completeness)
- waitqueue_active(): Usually, a memory barrier before
  the call is needed, and if add_wait_queue() is used, also
  a barrier after add_wait_queue. See wait.h for details.

-
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 scripts/checkpatch.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..8bf5849ee108 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6685,11 +6685,17 @@ sub process {
 			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
 		}
 
-# check for waitqueue_active without a comment.
-		if ($line =~ /\bwaitqueue_active\s*\(/) {
+# check for functions that are only safe with memory barriers without a comment.
+		my $need_barriers = qr{
+			waitqueue_active|
+			wq_has_sleeper|
+			spin_is_locked
+		}x;
+
+		if ($line =~ /\b(?:$need_barriers)\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
-				WARN("WAITQUEUE_ACTIVE",
-				     "waitqueue_active without comment\n" . $herecurr);
+				WARN("NEED_MEMORY_BARRIERS",
+				     "function that usually depend on manual memory barriers without comment\n" . $herecurr);
 			}
 		}
 
-- 
2.47.1


