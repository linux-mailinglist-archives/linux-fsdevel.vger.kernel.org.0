Return-Path: <linux-fsdevel+bounces-76624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INOFNn8thmnkKAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:05:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183D1019AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD63303C614
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36364218AC;
	Fri,  6 Feb 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AolOWp+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAA425CE2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401065; cv=none; b=astyU+nNPuRqWv9LO5/tZrw2dHB8Gd4KY2Gk0DxLwQXdBHn7G9C8kiFajDCHHN9qhOZmq2CxZaqL54lGdOskc61A+kW1TVojUpT2a8Fr0lKBRlLoA0C7ADtZt5DGcwnOyg3Kw2307Kf1U+9Wptg30GjNy+a6OucsMbX6/3AJX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401065; c=relaxed/simple;
	bh=7j57Kb9zrP0CR0LLOCCTX071fm5XUGcku1K0dLPTMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxGjs2h91j0qI7bdbvv/XcxXfHIU0gQxFLQHRaBC44DGssm0vr7B5+RN4wmwJplTwK5igaMf7UEbGMfkFGfwRruhMu3CCEGTC5qqp0utOnbzOOJzJclAxmPCC7tLhtxypX3LV2TvkG+fNI8mXX8HiCnK/QjpaH/4LgRFBtS7qO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AolOWp+J; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014b7de222so22559311cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770401064; x=1771005864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T13Zuh8ax2XAoP2rJy96BUiZCKe9bDTomtxx5ZB6o1U=;
        b=AolOWp+JClR2cNZ6FAgL8x73pi73MvtpXYZeivWEA5kTo3C+SDLebUJLHTXvTaaWdI
         g8C2G0vSSdqwFfNmGL3dgrcW48zZxGmYuvkTg8Bm5vpdRoub6eZ6xOyyFhhbPNm0EcW/
         rW8TOTYkbbArJlAYqVNRjxXVoMNnQ829SlFaZ5NfJY+Jm0pPm9luESCkcMNPzYhFp/Lb
         h+pQqrX+rCUqtpJSUfcc0IKGRSxFTEBEiKuD7V5Tk7BDnd6S+LiGXsHDusnvUpXrNgpQ
         bdXcpV+bF5nHJYOI5AjnDht42SM6Vb60QIGlR7HvyB3Bkht8Xjq4QGnnhRJTY4l3d4DL
         MnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401064; x=1771005864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T13Zuh8ax2XAoP2rJy96BUiZCKe9bDTomtxx5ZB6o1U=;
        b=RyLPKBxtY8g4QCt4S7oNDY3NS42VzMQg2F7Vv8wRxfzxxbw4x+TM8Qb44oxUaMp+Ed
         djR9wzhcnw8RIPkq5RtnX39iwYEB8NDyygbuQDFJAyA+k7NYUYbvAQx860n7g+sB5j7Y
         pucr337Gz0JlnJa/QqnQ2H+xtJKWpZ4kfN7ktdK1zEs5w+w4+8GaergtT+leLedtNONv
         5pKt1nA7jxmqImZDmttIzBOls4l2IdnHmkbwhEemv2YdURxp3PGAZ4Wz3wyl+t1hFccN
         kZ/3V4ZWuj5iKB7SgVSBqOCh/1J3K9NTotaQd/kJCSiMVy/qw3HQnJ4oMHn0uvZvEjEL
         UQDg==
X-Gm-Message-State: AOJu0YwEQ/8oT9R1PKmCDBWG8rpz/Jd727BVOyLj/AgbwjT549uHV+fP
	+0iLNTnCgf0dyB21sf79WGPz2cjfwoQuEpgfSqaHaJANsViXewUIP/fog44RcB4j
X-Gm-Gg: AZuq6aK6j5idiVO74ZBWdzRWnmePVg2sISP5OwxtjF/0r0XjR6UAO0ujl1AehE4IJKd
	tNhatOwRaAaSjG93IWjzFBflkqLSi6YPsV7iTgvuYwfFV6GGiFjtHiFyzCQZIphlNKSJtuWPHi0
	6plmDesWFMK3l6tGn3Cj1Bk3RQCilowJdXSb599TKKwGq7n8Tc6Z2ZSkt4SzPK8dmRX4GzSbzYm
	EocAHr4Zmb1umkvceGrcXxplRVyPMEjQp7Hjx53tWUxIwnH4jfOCpsVIQi73dH9MepRQziLw4/f
	Z5lo7M4Fg9jpc/S1HTeqPSt7RRTAELk0uVFhDUIH8Oa23GSZxJsSFsQP5QCSVdpHk/VnWf5Ziz4
	fMrjRJXpUGCtnYFR7CnqYQF+zU1JaMmAQSY6ZKj+amD563lNVkWnlsKYgixtR2A19jBhm/2YKED
	rgWyozfaoy5wx2lnSiFFl2Qewqz0EVUMKfyAh3iEuxcpkvUgS+1psPJOWpi41XG12jn8HZif9in
	0FA+pXCPfmercwE
X-Received: by 2002:ac8:5993:0:b0:4ee:197a:e809 with SMTP id d75a77b69052e-50639a1f418mr41640841cf.75.1770401064059;
        Fri, 06 Feb 2026 10:04:24 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf3814csm21631946d6.2.2026.02.06.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:04:23 -0800 (PST)
From: danieldurning.work@gmail.com
To: linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Date: Fri,  6 Feb 2026 18:02:48 +0000
Message-ID: <20260206180248.12418-1-danieldurning.work@gmail.com>
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
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76624-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[danieldurningwork@gmail.com,linux-fsdevel@vger.kernel.org]
X-Rspamd-Queue-Id: 0183D1019AD
X-Rspamd-Action: no action

From: Daniel Durning <danieldurning.work@gmail.com>

Added a permission check to pidfd_info(). Originally, process info
could be retrieved with a pidfd even if proc was mounted with hidepid
enabled, allowing pidfds to be used to bypass those protections. We
now call ptrace_may_access() to perform some DAC checking as well
as call the appropriate LSM hook.

The downside to this approach is that there are now more restrictions
on accessing this info from a pidfd than when just using proc (without
hidepid). I am open to suggestions if anyone can think of a better way
to handle this.

I have also noticed that it is possible to use pidfds to poll on any
process regardless of whether the process is a child of the caller,
has a different UID, or has a different security context. Is this
also worth addressing? If so, what exactly should the DAC checks be?

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 fs/pidfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dba703d4ce4a..058a7d798bca 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		goto copy_out;
 	}
 
+	/*
+	 * Do a filesystem cred ptrace check to verify access
+	 * to the task's info.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		return -EACCES;
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
-- 
2.52.0


