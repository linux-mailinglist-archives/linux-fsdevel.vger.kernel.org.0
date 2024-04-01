Return-Path: <linux-fsdevel+bounces-15836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695C8944A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916611C21722
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687334F217;
	Mon,  1 Apr 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHMkJeSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F544E1CE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995051; cv=none; b=HVTpQl9MPi0XHE2t9huYWKpufka1MeetOms/vKNUxGynpXyIPlI01DRMu9YvIZFW1xGffK0czKpcggO2spwj2yIr7ORyMJVTmXuP2M5CwcCLYEoeQVdS78oyfFt0JzB3KwqPyIzNc/cNbEq6g29fwBdpV55CrmPCFUT78a8jXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995051; c=relaxed/simple;
	bh=z2HNaLW7w9QpZHWGF0jaA9MyMN6bCQ1kVStq5aF7W4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X4mskrPHb5tMm5B2MbtsYXKT61gO68dzSipxY/4YMJZVwDLrgk937YnWRP/Az5U690TYt//PS1MmHEKo0kSd9gUulG6KyZobNuUvdMCwfBtqmTQ+cPe0IXT+3rfPkImSHhuSqyzgXp0NZ3mhkI2H00/OBlXbL08NGXVx76SFfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHMkJeSL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6673051276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711995049; x=1712599849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sw2vY2M4CeKEyqj973cP6PJDE6m3drwFn3wvpEExDXs=;
        b=rHMkJeSLIwbDSDjhAaUaHbGeo9ua3hm9of4MyQaLy0zZMvNGtvYEnEdula2es1QbPW
         pY4QSMRWt+1t/WE9SNVbgzlEVlFj8GGjMIaO0tar77U8CEsd/4yT+PIfWJYbsXsvAvbV
         uCCvztO/lH1qProrX3SxFuT+O/4ldTN1OWLZdVfhqgcxMvNAnVBKnxhFPFv6H2jgvOJ0
         8FJLuRFXQwdPA7pnbfjNsj+s//nuXBraiIeZpaypwBXn5cbliWpVG+myT90fLVRhK9Ag
         SMgGj7StrbdgJVpr6fkS2+lUtNxDv0JNJq5Qmi0r1Mjk/99ISZ+LSOWL44a+iDi/OlYR
         6Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995049; x=1712599849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sw2vY2M4CeKEyqj973cP6PJDE6m3drwFn3wvpEExDXs=;
        b=XqdvZ+pLkO8sQrxKazcHiccwPEjtEBFugLZ1jFy+bs6/XdBUgTN+fyJ+k8DCluYxkT
         Xt3jfgEwIIIpQKcguuV1C6FAP3vlQnMAr+gaG4jS58ji6Q+nWwF3d+BVm6dbqZ61peJV
         4BTvvgxMLGCeEb+8PtiBYlUsjRjWZSna16NdRg2ZEhQJlYBYt/GVYV62Bdf4M1zGkV0k
         ttvfYAHjQ/o0acv7GPTSHS7wB9DBTHKSwYzM+eTyV1MJn9zdRtvB0G7wjQ34Jc+GVqZL
         u+Uhdy5Z6VnrwNG5si+ACNmPAUk6HKj7XVH+0NRNI0FtszJPg3J7xHcmcIiIL9IX7PcI
         mSfQ==
X-Gm-Message-State: AOJu0YwRajlDEK3JC9Uhijr4X1s8rtiCxhanUch1/eqxEyvTXH6ru5su
	d9ARCN2kskr3QPW0/qq0ZL4R/GKQFKVieTcGIKAt+Occ8fePSY3O7L804vbj/5qvD3GeMN0FjNI
	UN3Cm8AdELpHF0BHx+G38PQ==
X-Google-Smtp-Source: AGHT+IFAZ8Se8nHA0Of3hEysmza4VRg6qbci7e1TG3olLS+L6R1D++n7SLB99RNTps6QkAlE7iFc8jPZQ89cC3NRtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2313:b0:ddd:7581:1237 with
 SMTP id do19-20020a056902231300b00ddd75811237mr3279498ybb.3.1711995049368;
 Mon, 01 Apr 2024 11:10:49 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:10:48 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKf4CmYC/43NQQ6CMBCF4auQWTumLQWNK+5hWGCZQhOkpFMJh
 PTuVk7g8nuL/x3AFBwxPIoDAq2OnZ8z1KUAM3bzQOj6bFBCaVEqiRzDbJYdLeNoeZk+jFsXY0C
 Dml6W6pvVpu4hB5ZA1m1n/Nlmj46jD/v5tcrf+ld2lShRmLq8V50UqpLN4P0w0dX4N7QppS9rB YvIxQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711995048; l=3756;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=z2HNaLW7w9QpZHWGF0jaA9MyMN6bCQ1kVStq5aF7W4M=; b=kU6IxVx3/F03byPgQEL8DLNLMSnWNCYWY3e9y+7keVoKq+5hvMV5hXsypcquKgXyj0ecnWlJ8
 lvja9jJqSVCAxSvYraO/3hVEpDYa2ynuZ0XmjXrTG7v0QdUj3JsrDWG
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
Subject: [PATCH v2] hfsplus: refactor copy_name to not use strncpy
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated with NUL-terminated destination strings [1].

The copy_name() method does a lot of manual buffer manipulation to
eventually arrive with its desired string. If we don't know the
namespace this attr has or belongs to we want to prepend "osx." to our
final string. Following this, we're copying xattr_name and doing a
bizarre manual NUL-byte assignment with a memset where n=1.

Really, we can use some more obvious string APIs to acomplish this,
improving readability and security. Following the same control flow as
before: if we don't know the namespace let's use scnprintf() to form our
prefix + xattr_name pairing (while NUL-terminating too!). Otherwise, use
strscpy() to return the number of bytes copied into our buffer.
Additionally, for non-empty strings, include the NUL-byte in the length
-- matching the behavior of the previous implementation.

Note that strscpy() _can_ return -E2BIG but this is already handled by
all callsites:

In both hfsplus_listxattr_finder_info() and hfsplus_listxattr(), ret is
already type ssize_t so we can change the return type of copy_name() to
match (understanding that scnprintf()'s return type is different yet
fully representable by ssize_t). Furthermore, listxattr() in fs/xattr.c
is well-equipped to handle a potential -E2BIG return result from
vfs_listxattr():
|	ssize_t error;
...
|	error = vfs_listxattr(d, klist, size);
|	if (error > 0) {
|		if (size && copy_to_user(list, klist, error))
|			error = -EFAULT;
|	} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
|		/* The file system tried to returned a list bigger
|			than XATTR_LIST_MAX bytes. Not possible. */
|		error = -E2BIG;
|	}
... the error can potentially already be -E2BIG, skipping this else-if
and ending up at the same state as other errors.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- include NUL-byte in length (thanks Kees)
- reword commit message slightly
- Link to v1: https://lore.kernel.org/r/20240321-strncpy-fs-hfsplus-xattr-c-v1-1-0c6385a10251@google.com
---
---
 fs/hfsplus/xattr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..5a400259ae74 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -400,21 +400,19 @@ static int name_len(const char *xattr_name, int xattr_name_len)
 	return len;
 }
 
-static int copy_name(char *buffer, const char *xattr_name, int name_len)
+static ssize_t copy_name(char *buffer, const char *xattr_name, int name_len)
 {
-	int len = name_len;
-	int offset = 0;
+	ssize_t len;
 
-	if (!is_known_namespace(xattr_name)) {
-		memcpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
-		offset += XATTR_MAC_OSX_PREFIX_LEN;
-		len += XATTR_MAC_OSX_PREFIX_LEN;
-	}
-
-	strncpy(buffer + offset, xattr_name, name_len);
-	memset(buffer + offset + name_len, 0, 1);
-	len += 1;
+	if (!is_known_namespace(xattr_name))
+		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
+				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
+	else
+		len = strscpy(buffer, xattr_name, name_len + 1);
 
+	/* include NUL-byte in length for non-empty name */
+	if (len >= 0)
+		len++;
 	return len;
 }
 

---
base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
change-id: 20240321-strncpy-fs-hfsplus-xattr-c-4ebfe67f4c6d

Best regards,
--
Justin Stitt <justinstitt@google.com>


