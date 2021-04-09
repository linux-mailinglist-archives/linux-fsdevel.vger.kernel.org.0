Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A88359CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDILNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233879AbhDILNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=OQ8G7opl3Ja78HGKN+7JOg1ItMgDLC5y3nu90Tiqv0pNJAIoaaopdHwdcUyyzczCycnyjR
        zfPGbtAyRSNzAefAIE1cmZWbOt0BkbmeHvVN3NFFjINNyVQNagXD2sEqgbVPdSxrWNZNen
        akLYfYEi+nEotAwqSDhoWF9myk3FrRA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-ayQe8W_xMbC3WwIuZsYq6A-1; Fri, 09 Apr 2021 07:13:02 -0400
X-MC-Unique: ayQe8W_xMbC3WwIuZsYq6A-1
Received: by mail-ed1-f71.google.com with SMTP id h5so2496025edf.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 04:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=nA9VEW5tWb6JRK7z/9Y3Sw8QSsQcljv6QWNzimq1pGCIEDqBuNAcV9cQfchoboVEc9
         jqvymVYCJAREdaEbWUEdddMncaV2VhFJWcv9LB3VAbvvZIpoVG/Ya4WS6LMKuEm4wxxd
         lRIfGyYepRe3LB30wl8Zfi59jRLk5aqBeuJcsRlcF63203oqmvtpc7U9QVBdjvPDwdAD
         Ep+bwr1T/1wkbAamPZ6xw55CkDu91vQiDNHHqEm/TnVe90QJ4Rf3WdS9nz9JWP4ZW88i
         oMN2a9evNixLOCnuJNWl7zjuzNtwqo3W0/1+7VWWkgf+pfuJQMuRZs/MQNCiYZzkwftE
         9fTg==
X-Gm-Message-State: AOAM531Kd541sfIiSB0XBh5K0he5t/RfYb5oUK5q4HlU1o9e7/AL+SSU
        as6eViao44YFWbTM52+UeGefTP+HSGk9AyRkEqAcBt4YK4L8Vnt6SIJxNgUxgN/Mo0u5RrQsTPk
        giqVVR2t0Y0/FCRa+NLvH2fvkDA==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751957ejb.42.1617966781264;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN01aC0ArployKcFNzWC+455t509jtFprEos2SXUsaUxRWFCvmE9PBB5j0Mfpph1bCkHvNIw==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751940ejb.42.1617966781061;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:13:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Fri,  9 Apr 2021 13:12:54 +0200
Message-Id: <20210409111254.271800-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409111254.271800-1-omosnace@redhat.com>
References: <20210409111254.271800-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When mounting an NFS export that is a mountpoint on the host, doing the
same mount a second time leads to a security_sb_set_mnt_opts() call on
an already intialized superblock, which leaves the
SECURITY_LSM_NATIVE_LABELS flag unset even if it's provided by the FS.
NFS then obediently clears NFS_CAP_SECURITY_LABEL from its server
capability set, leading to any newly created inodes for this superblock
to end up without labels.

To fix this, make sure to return the SECURITY_LSM_NATIVE_LABELS flag
when security_sb_set_mnt_opts() is called on an already initialized
superblock with matching security options.

While there, also do a sanity check to ensure that
SECURITY_LSM_NATIVE_LABELS is set in kflags if and only if
sbsec->behavior == SECURITY_FS_USE_NATIVE.

Minimal reproducer:
    # systemctl start nfs-server
    # exportfs -o rw,no_root_squash,security_label localhost:/
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # ls -lZ /mnt
    [all labels are system_u:object_r:unlabeled_t:s0]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1daf7bec4bb0..b8efb14a1d1a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+
+		/*
+		 * If we are checking an already initialized mount and the
+		 * options match, make sure to return back the
+		 * SECURITY_LSM_NATIVE_LABELS flag if applicable. If the
+		 * superblock has the NATIVE behavior set and the FS is not
+		 * signaling its support (or vice versa), then it is a
+		 * programmer error, so emit a WARNING and return -EINVAL.
+		 */
 		rc = 0;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE) {
+			if (WARN_ON(!(kern_flags & SECURITY_LSM_NATIVE_LABELS)))
+				rc = -EINVAL;
+			else
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		} else if (WARN_ON(kern_flags & SECURITY_LSM_NATIVE_LABELS)) {
+			rc = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.30.2

