Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD85E467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGCMrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 08:47:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34451 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfGCMrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id u18so2690192wru.1;
        Wed, 03 Jul 2019 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGBdNmMdhFstnWCq77MQvrEKCKvNGnCcZG5DRBITfrc=;
        b=GegmEgttiGYsovo5Z7c0uiUKck3nbem4kn2meh0JkG9uLTR2JLzm0njLr+zKsnh2t9
         woBKi8NlY+BgaMsK6wXH/dm8fSzindZ1+JJ1sMPeDOxjfFWiREoFhCVb/JCvUuxx+1Ez
         XNvHnoRRsIch9tnNxpjmF8OWk6wzQNHIYMm5/BTCWvN1hWgcc0AYyULwW9C2iyxj6TzF
         iImYL8VhRyEpBG9g34q5/qnkOaL4tIHU7ZtjTq8+8jipQkqPkaRpnTCvAkud9hvPAiTm
         EFELxKEN2/8q7zoHerudPOhdPE9g9FYNlnoV1htSOQ9D7Lkp2UIwKes13spXFJDbfqcC
         DMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGBdNmMdhFstnWCq77MQvrEKCKvNGnCcZG5DRBITfrc=;
        b=O+pPG6Qrtm2Wcgx6CiNFcI5TagnRRu2soscJ3O4UqaeGtfK7C5xmIudqWLoKAGrPz3
         CqZJgBiOWI0AlbisQZ5oAGmcZKObInyXwZ/IUSmjlTE5Qw8md6mb+vmTsHPBcmZSTJFF
         +i7l135i6lBJE0cXNCSdA/O1ypPK4syU8/dMUSazoLwUQbzH1/54aHM/qBYbLPZ5E4aL
         5YoqvYQwtZKyBnDrPMmEe8deIov2+OiqUnCxN4AP+rTjEphZa0v/yXs6bSdcvPNjGBeb
         aV5NRfmUQkg9+BegjvmlajPKJzzRJz2ZxwDPwbQNDmRH3DlEaC3ZwGGRfkRhpWHRutIq
         fY/g==
X-Gm-Message-State: APjAAAVyE2IaGCtMj7PPaMyfN1xOKTfmzWivw1W3Gsxs1mfcYwirMRCq
        k3oUsoI10ZWwCsKXjjQvkrLx/kaTE7E=
X-Google-Smtp-Source: APXvYqyWhDxSUDunATg4EkwKFAC5mk4qZLKupInoD5ZmrQlVwniMZW9E7GGqoCGC79KQuTaiUimPVQ==
X-Received: by 2002:a5d:52cd:: with SMTP id r13mr876862wrv.349.1562158048405;
        Wed, 03 Jul 2019 05:47:28 -0700 (PDT)
Received: from heron.blarg.de (p200300DC6F443A000000000000000FD2.dip0.t-ipconnect.de. [2003:dc:6f44:3a00::fd2])
        by smtp.gmail.com with ESMTPSA id o24sm5480588wmh.2.2019.07.03.05.47.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:47:27 -0700 (PDT)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, bfields@redhat.com,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, hughd@google.com,
        anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 2/4] fs/ext4/acl: apply umask if ACL support is disabled
Date:   Wed,  3 Jul 2019 14:47:13 +0200
Message-Id: <20190703124715.4319-2-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703124715.4319-1-max.kellermann@gmail.com>
References: <20190703124715.4319-1-max.kellermann@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function ext4_init_acl() calls posix_acl_create() which is
responsible for applying the umask.  But without
CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
and nobody applies the umask.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on ext4:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/ext4/acl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..7f3b25b3fa6d 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -67,6 +67,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.20.1

