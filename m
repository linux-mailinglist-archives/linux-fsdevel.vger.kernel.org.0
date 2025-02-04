Return-Path: <linux-fsdevel+bounces-40823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7114AA27D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E6D3A4201
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745121ADA3;
	Tue,  4 Feb 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzNWK31Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3552054E1;
	Tue,  4 Feb 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704740; cv=none; b=meXv8PKkIA3bQ2AayV29qMFDwtYtgyba3K0JFTN628kPvrA5Juf6ZsWVPCR0d7IWVZ+w0F9ZvK4u7CcdpvP7ZBcOgLMXNfWUI2hXLmbvfPkVQFC2R+Attd4/BJNuFn/x46E7MylHe6gz8eXM8YmAQvI/tEbCkhoJfUFSpU3zEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704740; c=relaxed/simple;
	bh=M+FCUPVRm1PjZlRYsxqwUfQlh7CWGgXKYnjqc2zJcL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzxT3guZVoTRRZxkA6oakN3BLBpIMp+M/5I3x5iAquiEhbeqJJIdJYtSqa1IUL5JZCERF7Tcp2wHS3Pbj8wMD51jYQGl4jgykKlkt2hJBmUs084SLHZrE4MbjfQwl7HooYhkjakjeA1aJpVuF2IcKxn9QirHluCzR112L9ZFWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzNWK31Z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7157cf352so45210366b.0;
        Tue, 04 Feb 2025 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738704737; x=1739309537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4SHbg4OH1aXCOac4AvtsM+SHVN27HONJoUI3Ty0gykc=;
        b=YzNWK31ZRRDJ7tLSe3bkBoacdkmU6+rWxzBiz6NW1gvxxCIxpkj4Os14Iyj/7euRxv
         cLltalfjHX8SDanaNKVQlhG3cARCAaKlTEPcD2lV7GvjWVjnm3ZdHRA/V58XlPHEyAbT
         x+OXmoajiF46gfPuA6ByULvVMevHMcdTzXxfkLDiQ2uLY/M5BcSy/JCA+vgu48wA+AfV
         Xcmz0PN1ZRXdjVVyzL1/rsgr2WBlFesSxtIQzx+0vqFo/47/ckKuasRa7TolAroSPIPZ
         ZZImWHYuf/zPm8tAgW6sdM7gnDF314zeorXHEVjcWsQ7klC43eHzfx4WldJpvqAQgCP0
         SXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704737; x=1739309537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SHbg4OH1aXCOac4AvtsM+SHVN27HONJoUI3Ty0gykc=;
        b=lrjPKxMYPvWmBlwCbfq5vLUiGUsjnldwzs8D0AJi/is+uUk9kqEIZAOuXrYiY+Bynj
         ImR8lpVlLn9e5vuOGxXNDpz9tUeH36sdZwU3xmS3cy8PhjCzD5Vb/dmd+F+YaKaVRMYB
         eKM+OryvqHlqHDVakhPw8lN3fb4VDw2QjmW0Zv5lbhwDO25EMw8VVnYvdTINTgVLy2qa
         mYl4MudLAd5ykyC3fQaYEwtIwL4xJxRRH7kzP+/K8seGOaDr9YFKuJUY0SRzk6czaWRR
         1mgTlZS4J5jJDS5Ba0x/GRAFP5Vi6RjDnwrfL/zSz45Jj+Uu9U5PT8aXJSz2twFEDGho
         7fRA==
X-Forwarded-Encrypted: i=1; AJvYcCUFuxKQvZZjeSdYJmV+pSlQ//LSacV+niEl6I8G2GutD6kCbOkINHeGVbQb5rUYPgs1q6u7Nmx0dR2n73p/@vger.kernel.org, AJvYcCWyx0Ct94x1SZZT63niwnx3F96MnCZwC9Kyo01OAksb3XnNZB4xVCwGCXVX6PLXWxRs0uiJ66U4hFXhQuPM@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrF4lMjOTfJJJNQFX6ISUECqXIq54RHX5wGnmPHjIXKCujYF5
	uh2rU+hGQS1w8oj8VrKOzh8/sx0my6V76r8hceye5q+3XuFzMX9I
X-Gm-Gg: ASbGnctOScurpnppsxPA7hILc6YiymKhuhPxE38us6+7LieyRId1Ui+v69e/kvZUIQt
	ERrctKGa5j7BL+sjp0UpthCA7N8TTFRuVe4KS+FRRBzULBfqc3LrhFOhYo2UA3kuBebv3AgWtQp
	vkXvxwECCUNYTPRqQXNqyxCJu67gtOREMozJNhGPgDZ98xEHBJIkslyffJeUIM5Oa7JXM2s5nRz
	j6rD0G2bd5IlFt486Lc2faROlHVp2SIOzXDRl37WdQJQrgI042K62DcmaWS2Q5hUxAj+Thh+f7v
	Pbqi6S8z9nAnYCeuXe8uUCPe71AGxf4=
X-Google-Smtp-Source: AGHT+IEWALjCfV4VcdwamcF4IebS+1bhvPzZMHWyj+kECUovIba+BPhbtEU3uPDuqqIxh/Axf1BXTg==
X-Received: by 2002:a17:907:7255:b0:aab:a02c:764e with SMTP id a640c23a62f3a-ab748435278mr525692566b.14.1738704737260;
        Tue, 04 Feb 2025 13:32:17 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723d0006sm10103682a12.2.2025.02.04.13.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:32:16 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: sanity check the length passed to inode_set_cached_link()
Date: Tue,  4 Feb 2025 22:32:07 +0100
Message-ID: <20250204213207.337980-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This costs a strlen() call when instatianating a symlink.

Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
there is no such facility at the moment. With the facility in place the
call can be patched out in production kernels.

In the meantime, since the cost is being paid unconditionally, use the
result to a fixup the bad caller.

This is not expected to persist in the long run (tm).

Sample splat:
bad length passed for symlink [/tmp/syz-imagegen43743633/file0/file0] (got 131109, expected 37)
[rest of WARN blurp goes here]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This has a side effect of working around the panic reported in:
https://lore.kernel.org/all/67a1e1f4.050a0220.163cdc.0063.GAE@google.com/

I'm confident this merely exposed a bug in ext4, see:
https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t

Nonethelss, should help catch future problems.

 include/linux/fs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..1437a3323731 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -791,6 +791,19 @@ struct inode {
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
+	int testlen;
+
+	/*
+	 * TODO: patch it into a debug-only check if relevant macros show up.
+	 * In the meantime, since we are suffering strlen even on production kernels
+	 * to find the right length, do a fixup if the wrong value got passed.
+	 */
+	testlen = strlen(link);
+	if (testlen != linklen) {
+		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
+			  link, linklen, testlen);
+		linklen = testlen;
+	}
 	inode->i_link = link;
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
-- 
2.43.0


