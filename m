Return-Path: <linux-fsdevel+bounces-15433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F93988E691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C9F1C2DFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65ED15746A;
	Wed, 27 Mar 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnTBa5uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0A156F52
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545072; cv=none; b=RYYrDrql/BWdCZmh+AdyyFJoVf6Tfd7TELw80Z0Cx8eO1H5GuAfpE6iwmRO5/Pi7wNODzmToLZS+6YAOn40d5HGfgw+6hOOJzymMw2H5hF/kyvk5qugwXJGb4mpYXoA2hkp5sIkBwk/cCu0nhkLCywDchsY7N78h693263CvVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545072; c=relaxed/simple;
	bh=DaxfOx5juRgkGT1onoeBml+KzX99DS3H5Kfd98iKnRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NYQGyqqgfY3W+R0Z5Dvwr4ToA0pB64zdEnDWVfoMyEvK8rX42QDKp4+SnhjIomiYNbKWWgEoic3kBjh6zPTj4reLDj3q3klxsDFyZuMSW18m9v5sh0wHzg6Kb2rywv1qczclgO5mwcugGKKZSqnzRxIKUVgJVhQ9JY6Pdq+91FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnTBa5uq; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a46bc50c895so177694766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545069; x=1712149869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyYxrfp8pIz08BwXl1sIdsAZMNI11A0A6tQ7MGaWE3A=;
        b=lnTBa5uqfVtfS29tUfP5h5yCrCyZWNqmNSPAdyChw/rok2c8rtAMBOK2Cn4IPjEeQp
         oMha+GFLF/sJG6ZFG3zUtJeQWtDJ1/RJ1i7H2pqt098wVkHvTpn0/xKmLssZzyhpegVX
         NShBh+V2YwQ36iTIWcjjJGZyqD/9p2VTYQkxQ6dhhi2UZlNR1o3pecJdGjol2dDAxd+X
         gIRy/vC1JTB/ZSKJPVkaNd/uI6xowdznOhNEYBjgUha4cCmhF00+qoin47v3fRjCfKFv
         XjkYXT7uE2+QlHL4FZANl2wiW6Zgm4E58tWR9z/UbyeXvi+MNt2Z/rd1J57C40Vkjax7
         FbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545069; x=1712149869;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JyYxrfp8pIz08BwXl1sIdsAZMNI11A0A6tQ7MGaWE3A=;
        b=KQeZSmxhfAzBY15onm0nfF9SvujL2fDlLA+vx1eM9H5v0l6UaJitIMA4lixEIbxk7h
         4yO4D+pqUJEzTWFNR6Ac5hBDd9aSHAEhNBIi2iS80lslSxUMxQMicl0LPCcUM+6SKoH3
         XfPlwH7r15tfdDRR2WhQ4JWfrkdMLNBg08xhcWipoJhMvGtgRBh6tueWgEzSVJpHrogw
         A+hIaz6FHTonUo1W+UahAncVRqDR3Oc45uI4wkRu3CR8MOhGaAjQZupj+nyXe3SM4sTn
         EVdZB4ejQj1ZZzL0YqoXCR9e6NjpQX1s4HdiTpUgLRl4kEA+epvQJgJ+MkyBu6ic3Kfb
         4uZw==
X-Forwarded-Encrypted: i=1; AJvYcCVv7T2dleMCexciazkFcBmDn7NY2ePHtpk51d7pYa6gLgpCrTOtfKQgAmgV9eOWfHvVOQV1ggVl4vEiQ3FT368Xa28wMZ8dSUOPZRheLQ==
X-Gm-Message-State: AOJu0Yw0vAPVJV3eURGQv3/oiLCqww7MvgPiZGWqpksxIHPv5p/rAIHj
	9MRODlg/vKEJaWtnA8oAqgsTDpyYdKRmq6FnOAQn11AZLC1PwhkIHobu3jwhJcu1r/gVkZWrc2x
	GkA==
X-Google-Smtp-Source: AGHT+IE0fDcnEvDqGJg1fVMOQ6R5gkGljbJZHgo/+asP4z0tgVwIay2ta6riix8G+ncHSOmPx2WqFOJsbtU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:a1d0:b0:a47:1499:6de0 with SMTP id
 bx16-20020a170906a1d000b00a4714996de0mr61846ejb.7.1711545068926; Wed, 27 Mar
 2024 06:11:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:40 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-11-gnoack@google.com>
Subject: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in sync
 with the Landlock LSM
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock's IOCTL support needs to partially replicate the list of
IOCTLs from do_vfs_ioctl().  The list of commands implemented in
do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..661b46125669 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
+ *
+ * The commands which are implemented here should be kept in sync with the=
 IOCTL
+ * security policies in the Landlock LSM.
  */
 static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 			unsigned int cmd, unsigned long arg)
--=20
2.44.0.396.g6e790dbe36-goog


