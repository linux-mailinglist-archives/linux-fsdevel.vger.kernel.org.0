Return-Path: <linux-fsdevel+bounces-77300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLcKOzk0k2lx2gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:14:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2E14542C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A82319DDB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA53161B5;
	Mon, 16 Feb 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4/OYM8u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rn7DRheX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F02315D43
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254395; cv=none; b=lv9c+gbhE7tyKFuUwc9wKAKJZ9UNMhljtKwKbnfEv+hpNlQFvTm7Uj86CBOfG3SEH4fj5FWhVRihq9z5RwM6wbY9+D+qVwXSJUYJ9LpdQ1NGOjI1+M+7N9Eu0la+5yXwCixJrLGkvBllL/x4FGkO3/otNpLcrGC85if28vcrkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254395; c=relaxed/simple;
	bh=ku1dmf4toeaGtX7VBobBNgDz1QSiC/bGi9Lw8fcbevM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njl1htRQ8q3ViCYJ6ZuoopvOABBb1EyPaDo4ptrv5Cg7TAvMHHO7q+2dHeNRjV6clvl8GPgNQVS97wqTNFkaP6FjmW38DXeyYL43hsg0aMRfaIp/Q+QdXm5/nb0lBHuRiQnap1nmYkeqD2a2adhogQowgau7YOAW2Bn0j9yoObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4/OYM8u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rn7DRheX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
	b=L4/OYM8urn2QSXNxTIaZKJFxYJBmkMoB7Hf9wg455waOb6XrnbhkjnJdET7y+8LsRy3icA
	xuWJjSoN3svj25mwIxSdzUv27JtfYkjFR/ORbxCfZLZwtgg5fqOYjfOZ1dEuWp2w9bEhQP
	6WZv6QKNcUZQk3vx8ARXOGpvQb0bNw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-dQhcvuHHPiGup2JLkU-rHw-1; Mon, 16 Feb 2026 10:06:31 -0500
X-MC-Unique: dQhcvuHHPiGup2JLkU-rHw-1
X-Mimecast-MFC-AGG-ID: dQhcvuHHPiGup2JLkU-rHw_1771254390
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4376c206493so3111271f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254390; x=1771859190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
        b=rn7DRheXDTjheiqdd6YBnXlDjTn2snEwg44RmwxopDmHPZG0CmzKz8bHlbEIqb44HY
         cM17ZVgg8b0fKfaCqCEqU1YazVBAJIFL8b8g1r+1F6n2v9oJy/TIkCtF08Dk0RNpi3gP
         6UaT4u5m1ViX+WqyY4OwHCqesim+QpNBTiYXySJLQIXbL/2X7i7CN5fRQoeXJDZ5m6Dz
         7ZEDzzELLo7B5QW23UbPhN2u+EEZlZ1xVWrFqrAtEGNDbYJoqhVxZTMZGjikp/x/aMdb
         1Au42kraHRcck9jgnHy1qKZg63+xzCIvGI0pHVvYzfRyb7T45s8atcmNVBxbFokWJeXp
         U+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254390; x=1771859190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
        b=dcoIWVnqW3gOoK9W1gjMKYQ+c6gR/54UBsLihHx8Y5PXRcHbvIbmT4wqZUV/gcCPDn
         nSf9m5tgMqGKLbTHhaun45CdvGkKRsPx+IckShDk3l4Dsjib5oISlGuuqveQ+KCTnx2m
         W/MHNSb21P4nDGygZbAcv3iPBHSiNooQV+mUlinRVuuKR9BSqKlRedOeWpjMKtIRn7IU
         8z+/VyaRQ0SXtlXaZzeJAJpu0SskV3PmIhOTXGEitjS/Gs5YGNtZalLVqfoUJpmAM8YQ
         Em5IOkGG2nxbYtt5t/t4MdXfav9L1uLI0kftH8d/eMpCmICNnt7nMd9TMj1chjej0Lw0
         37wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU2UssCJuuSC3wcqUsE8HYdmLonjnc5rW2hIatoZbvC69D8ySVXpzqT9QsQwmeMGBsebcTkp0IYmvBGw/w@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIgA231fY4NOsFiY4qbhpYtb4KVSjD4EmYwT4EWJPDjPVR+X2
	ciTtb52tp4sSa1yG1sFzBfMDlEc6qKUq+PwiRCFyOzJXvtGzJenZ5uL/4Vae/LIsPMM+EZNqKRk
	RXHcniR7Z2Ftrv4cdpF9ip7BogW28MBTbQnGpGh+IYhCSMINGSy6d7wC9S4Kb3dOEwKA=
X-Gm-Gg: AZuq6aKMRlFSaTWOfn+arX1R7RcET/D+0MdyYGmYhZsVejR+leeNJxDCa9dRgFxW28d
	DwTXxR56/WIQLkwEQzr9Y2plDIG4TVJYLyzqErt7JaGb1lrUidG93ABLiwe/WnmNXB13nzuwNs8
	sBQy2EoT1VKCd87gkqEPHqSSfIWauXKh9hlqVXjSesddCnOvolbRCvJhHN4K6ZWsI/hCh3R2saq
	AafJTMbQIlTxp4tFjoqlTntXa4x7da4kb2cWKXD6SFpLEYTMrmJ2nDEzf8h1pk7fPcBxdkM3BKk
	eB/ZYtdvgcxRju3E17gdmumGfqw1Xf8qqlU5T5dlrujQyXP4fYuDtlMtYm5LFVHiyfzFhIUYZyh
	XL2rIgE/uafh/PU7ghVsCDudq2217GsUsupV1LgipCq86D9ro
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358256f8f.18.1771254390362;
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358189f8f.18.1771254389851;
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
Date: Mon, 16 Feb 2026 16:06:24 +0100
Message-ID: <20260216150625.793013-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77300-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AE2E14542C
X-Rspamd-Action: no action

Make sure calling capable()/ns_capable() actually leads to access denied
when false is returned, because these functions emit an audit record
when a Linux Security Module denies the capability, which makes it
difficult to avoid allowing/silencing unnecessary permissions in
security policies (namely with SELinux).

Where the return value just used to set a flag, use the non-auditing
ns_capable_noaudit() instead.

Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d0b9b984002fe..9c9fca2976d2b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		/*
-		 * An unprivileged user can setup an fanotify group with
-		 * limited functionality - an unprivileged group is limited to
-		 * notification events with file handles or mount ids and it
-		 * cannot use unlimited queue/marks.
-		 */
-		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
-			return -EPERM;
+	/*
+	 * An unprivileged user can setup an fanotify group with
+	 * limited functionality - an unprivileged group is limited to
+	 * notification events with file handles or mount ids and it
+	 * cannot use unlimited queue/marks.
+	 */
+	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
+	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
+	if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 		/*
 		 * Setting the internal flag FANOTIFY_UNPRIV on the group
 		 * prevents setting mount/filesystem marks on this group and
@@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * A user is allowed to setup sb/mount/mntns marks only if it is
 	 * capable in the user ns where the group was created.
 	 */
-	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
-	    mark_type != FAN_MARK_INODE)
+	if (mark_type != FAN_MARK_INODE &&
+	    !ns_capable(group->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
-- 
2.53.0


