Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDE2FBC55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbhASQYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 11:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731305AbhASQXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tefehAb/S+Y499xem07UWHiVem08zQonUc+tFyoGtQ=;
        b=bmGzgzZMfU37JIO7dDmEKiUcTv68f2LTII4mSfr5PX6ZcWcUtaZdG8Ti0WYwBL6w8tWR/8
        hPio0N0zfAvqQW1933Q81eJrHclwt/c6kt0BxEg3sbL57UbzVSo4Ywx6qAnd4wEdx87xwQ
        T3+TwF6YkrIgizCpPujHJyJl0leYJ+A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-CvACyM05M2aPZyDRMFd4Ag-1; Tue, 19 Jan 2021 11:22:13 -0500
X-MC-Unique: CvACyM05M2aPZyDRMFd4Ag-1
Received: by mail-ed1-f70.google.com with SMTP id g14so9699491edt.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 08:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tefehAb/S+Y499xem07UWHiVem08zQonUc+tFyoGtQ=;
        b=EyxS6j76s6GpV9KsUYYWKCWTwa4LXxwu1m9OvGHehD0stb43yNLz89+tyGlw2Uo2/3
         ZreVTpeAj2C5T4jpfIfTz4VK38R/4SDrgabC0JVfp+jNUQy1IwHu2TcYhyYMsiPV1cJr
         nHDHzmVPj50ydiJSI0Ch4VVTEYQOrDGIvifI1TNa1NDWJAwDt1rHD1ThpscXquOzUXpa
         VbOdQiHl59kwTiZTE+gq3rfdGoKXfethKnBKNW7Hb+nGHPyMZZD2FvHEOzuO7wKd2ytJ
         AEf1uNEjpoGc9Fcv9FezwHiHwi6pIrBc9zBpqmmRGgTLpAYCX+Pj3QbxxNUA8zD5HFNG
         8/Ng==
X-Gm-Message-State: AOAM532T9x2ToiI93Y9NMsoj8Bx9JqeMhhyfbXgZoG4IEJC1lvVJlhle
        r100m3XbnxUj8YTMIHb4gyuBOzRzeW9wZfUxLyysgMioCZ7Kh3ErtunTrYxXm7CZT1SRtQHT9mn
        /a9nEfk6pIsocZro2M4C9op+HCA==
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr3478718ejd.365.1611073332309;
        Tue, 19 Jan 2021 08:22:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfDgUkWdym2Ii227SbfpEBuWbMrSciJxkHOMTpPgqAwLgbdBZ6Oj9XcMQl1tHD2OB0qf91lg==
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr3478704ejd.365.1611073332109;
        Tue, 19 Jan 2021 08:22:12 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:10 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 2/2] security.capability: fix conversions on getxattr
Date:   Tue, 19 Jan 2021 17:22:04 +0100
Message-Id: <20210119162204.2081137-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119162204.2081137-1-mszeredi@redhat.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a capability is stored on disk in v2 format cap_inode_getsecurity() will
currently return in v2 format unconditionally.

This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
and so the same conversions performed on it.

If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
user namespace in case of v2) cannot be mapped in the current user
namespace.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index bacc1111d871..c9d99f8f4c82 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -371,10 +371,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 {
 	int size, ret;
 	kuid_t kroot;
+	__le32 nsmagic, magic;
 	uid_t root, mappedroot;
 	char *tmpbuf = NULL;
 	struct vfs_cap_data *cap;
-	struct vfs_ns_cap_data *nscap;
+	struct vfs_ns_cap_data *nscap = NULL;
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
 
@@ -396,46 +397,61 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	fs_ns = inode->i_sb->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
 	if (is_v2header((size_t) ret, cap)) {
-		/* If this is sizeof(vfs_cap_data) then we're ok with the
-		 * on-disk value, so return that.  */
-		if (alloc)
-			*buffer = tmpbuf;
-		else
-			kfree(tmpbuf);
-		return ret;
-	} else if (!is_v3header((size_t) ret, cap)) {
-		kfree(tmpbuf);
-		return -EINVAL;
+		root = 0;
+	} else if (is_v3header((size_t) ret, cap)) {
+		nscap = (struct vfs_ns_cap_data *) tmpbuf;
+		root = le32_to_cpu(nscap->rootid);
+	} else {
+		size = -EINVAL;
+		goto out_free;
 	}
 
-	nscap = (struct vfs_ns_cap_data *) tmpbuf;
-	root = le32_to_cpu(nscap->rootid);
 	kroot = make_kuid(fs_ns, root);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
+		size = sizeof(struct vfs_ns_cap_data);
 		if (alloc) {
-			*buffer = tmpbuf;
+			if (!nscap) {
+				/* v2 -> v3 conversion */
+				nscap = kzalloc(size, GFP_ATOMIC);
+				if (!nscap) {
+					size = -ENOMEM;
+					goto out_free;
+				}
+				nsmagic = VFS_CAP_REVISION_3;
+				magic = le32_to_cpu(cap->magic_etc);
+				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
+					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
+				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
+				nscap->magic_etc = cpu_to_le32(nsmagic);
+			} else {
+				/* use allocated v3 buffer */
+				tmpbuf = NULL;
+			}
 			nscap->rootid = cpu_to_le32(mappedroot);
-		} else
-			kfree(tmpbuf);
-		return size;
+			*buffer = nscap;
+		}
+		goto out_free;
 	}
 
 	if (!rootid_owns_currentns(kroot)) {
-		kfree(tmpbuf);
-		return -EOPNOTSUPP;
+		size = -EOVERFLOW;
+		goto out_free;
 	}
 
 	/* This comes from a parent namespace.  Return as a v2 capability */
 	size = sizeof(struct vfs_cap_data);
 	if (alloc) {
-		*buffer = kmalloc(size, GFP_ATOMIC);
-		if (*buffer) {
-			struct vfs_cap_data *cap = *buffer;
-			__le32 nsmagic, magic;
+		if (nscap) {
+			/* v3 -> v2 conversion */
+			cap = kzalloc(size, GFP_ATOMIC);
+			if (!cap) {
+				size = -ENOMEM;
+				goto out_free;
+			}
 			magic = VFS_CAP_REVISION_2;
 			nsmagic = le32_to_cpu(nscap->magic_etc);
 			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
@@ -443,9 +459,12 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
 		} else {
-			size = -ENOMEM;
+			/* use unconverted v2 */
+			tmpbuf = NULL;
 		}
+		*buffer = cap;
 	}
+out_free:
 	kfree(tmpbuf);
 	return size;
 }
-- 
2.26.2

