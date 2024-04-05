Return-Path: <linux-fsdevel+bounces-16230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D889A626
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F1A1C20CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F9175552;
	Fri,  5 Apr 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHcxcQi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52967172BCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353272; cv=none; b=O/viuJAcBefbzHvK27vn5qK71y/bt36iBHyZs9LUVaHt45/krvuz/e0vIQYR504NdDomEzEoetGz/3XrBjH3JpafM+RSb43urhA0gj12et7QfwjWbOcEiamnQQu+iLT7k5e2lRN1yvKGA0ZOBnwMDrb4rD1Wqwwlarx+F7YngmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353272; c=relaxed/simple;
	bh=rfuLSAoxAdlMwMqf+SnAQnLHYITftcO5C8a85oncnfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RWeHKIMEMUnkVbiUYDooBLo5I6EJK5I5EnuJ+mmNzbowpS1DK2fvfFNMkt7zQP2Xd7/c9vD22o659BbifFX1X+Bf7hA3Lr8g40B96DdlIEKTkFeJm4qsOAXILR1mcs76b37/8AuE0TOcRdycWqGj4Bca2OHI1YKVMvuG/va5iHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHcxcQi+; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5685d83ec51so1113602a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353268; x=1712958068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgpVwwJA3MRA3y75oko3ScmdG271fOGajLCK9HYUHOE=;
        b=WHcxcQi+s6OOrqn9CQz+8MfFmTkfhiyqie5BfZ2Z7bHO3l5FnEZbcbiNvT7bh9oGFE
         Pnf2KqBIEd+HDakTS6tyycB3W29UN63rXDiOfzT3uYVzicbuGEeZKRJnAZq5KDrJaO98
         DQmStB9UpD405ODuaYca5thj1yU50yNN9JtPdZtL39HqCdmXWDBLrIJUxoHzmlQm024d
         HcOkpcC6HzmNJPJF+VsH3EnX9UX/KYO3fCOILh22nqjGBE8y2ebKemEYUO+NSwWy0aC5
         C9V2fDYvmQ4KNjVGyhu7pgmGfimHyOxA8BUEKMhoRHP6NLog6zHULraRz9xDzQLrYI8/
         cZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353268; x=1712958068;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgpVwwJA3MRA3y75oko3ScmdG271fOGajLCK9HYUHOE=;
        b=NLJjsqPdbB80scgqa3wPftl7Q5+njP1F9YMBmmXVvR+mIt9cLI6254d42Hj4K1gCd1
         lBxTRObD4wxSQDvH0FrJchHK/C+LotDJx+R2G6byoKDFPMF1GTNBG8yZ3BZd6WlHqnG8
         nB9Jk7gmOaKpkGR9lSAy3wj1R7LUq0iAJaC0M2/2eB8eiGZrfoy2MK4kKrztMz//Cqsz
         8vvDfzjadUKmBNcimxnPKvN16497bToJPzE7hLc3IzvUflXJ5ZUPKtu1sLHxASk6O/OJ
         HIM7HsNxmVnZyaDe9eeB+qzWwuATh23InuIlaxZ/m7NCAFuyFjJm6Jjn+Xvyy3vD2tde
         eXog==
X-Forwarded-Encrypted: i=1; AJvYcCWTbN3iLt+XWBSzvp/WHZHNPtPOU2VJM3MHJc2Sh665o+1YaD+UQnz/youHAGMsT2J5Sj5gquKI/6PbOnDURLovUw0ylbyvcdxRQOXzxw==
X-Gm-Message-State: AOJu0Yx/KKdB37PUbMt9d7fF5K+uAcmjPEwQLYCimm+QDAl/1+BAXTfM
	VOSRJy6P+W84LmjT+Oua7prd3x7rIZq/VF51YgozuqUNURR6rJMT9HFaADB5JlUnFNLBwESmK3J
	Ikw==
X-Google-Smtp-Source: AGHT+IHkbB1/lpQMCZ+T3EoTISTLjUbfzEEhtyXSAqwnbQlBAsQnDVelSn77Kb6Gj2ka8UBRWJNxL5i6tes=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:370e:b0:56b:e571:8d40 with SMTP id
 ek14-20020a056402370e00b0056be5718d40mr3568edb.7.1712353268414; Fri, 05 Apr
 2024 14:41:08 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:29 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-2-gnoack@google.com>
Subject: [PATCH v14 01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID or
 FS_IOC_GETFSSYSFSPATH fail
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These IOCTL commands should be implemented by setting attributes on the
superblock, rather than in the IOCTL hooks in struct file_operations.

By returning -ENOTTY instead of -ENOIOCTLCMD, we instruct the fs/ioctl.c
logic to return -ENOTTY immediately, rather than attempting to call
f_op->unlocked_ioctl() or f_op->compat_ioctl() as a fallback.

Why this is safe:

Before this change, fs/ioctl.c would unsuccessfully attempt calling the
IOCTL hooks, and then return -ENOTTY.  By returning -ENOTTY directly, we
return the same error code immediately, but save ourselves the fallback
attempt.

Motivation:

This simplifies the logic for these IOCTL commands and lets us reason about
the side effects of these IOCTLs more easily.  It will be possible to
permit these IOCTLs under LSM IOCTL policies, without having to worry about
them getting dispatched to problematic device drivers (which sometimes do
work before looking at the IOCTL command number).

Link: https://lore.kernel.org/all/cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c=
3gg2szgqd@vfzjaw5v5imr/
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..fb0628e680c4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -769,7 +769,7 @@ static int ioctl_getfsuuid(struct file *file, void __us=
er *argp)
 	struct fsuuid2 u =3D { .len =3D sb->s_uuid_len, };
=20
 	if (!sb->s_uuid_len)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
=20
 	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
=20
@@ -781,7 +781,7 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
 	struct super_block *sb =3D file_inode(file)->i_sb;
=20
 	if (!strlen(sb->s_sysfs_name))
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
=20
 	struct fs_sysfs_path u =3D {};
=20
--=20
2.44.0.478.gd926399ef9-goog


