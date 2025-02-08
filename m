Return-Path: <linux-fsdevel+bounces-41285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905CA2D6D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2947D7A1DD4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726B248196;
	Sat,  8 Feb 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfXe32tN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006C1B4F02;
	Sat,  8 Feb 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739027658; cv=none; b=poYXf53YRfACbRl84rzgTnsxbUlrQqEml81SzYPpykevngBDR1dmtSo5ATkEIAE23/Pc1G+tMl+81RCTeZdtwq5WVfDNE71I7RzGeFuzeeXKaG0V8nKxEnZN006+gphy/dUJ7+5urGmFMx0O00K09pn8r+adowiqKW9lT3hsOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739027658; c=relaxed/simple;
	bh=eDBm8azM1CcfMsmW2iTfoVs6lEoM08VWcppHbv+VZ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utz3Aldr20HTbyakAVFMmv3SXTpasbV4SdaV7fI3nq9agGG0yLpmak9Ry3DN6LzcOvYYWRSdxZg67+gFTzjrOg1utZIrzeYwwk3fJepK6kA4pOhOvKB7RgEWYzXkQrSIq0Jv3pWM486mc6+/cgzHld/KoQpJL+NrmaLZXEY8zIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfXe32tN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dcb7122c1so1321742f8f.2;
        Sat, 08 Feb 2025 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739027655; x=1739632455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6PnvQvvk55IcGUbjkQl3cz2EdhneILHo+vPskqKe6Y=;
        b=GfXe32tNlSPFaw3Zz+Ih3HQOLGe7nz90YZjt7dMmHSNN2DmPC0klQo2/OYjuX22AOZ
         o2QDhctJuXCfuFXBSb3mdfg4WFabTn1bSoMa4h1vUaptUru+/lAfB8edIbcnoeC4C9fH
         h8D136niGP9g7TwxTNkBbUX11tHUKiwkHOyr7WD9ZPTLirN3TmcMiPQYQhU+nqiMgcsE
         Q+0HtgXN70fQ+CtpoJC2XwOIZdyIj/zOlvsWS53vRLgKjnk+aQ6NYz6344QcqqnYQRCA
         6mq8V6y8K3tJBdlqsFDiprJjF0TS2oWvI67Hj9/YXwdq4YVduRow4wUGb//q+l6Rxzgi
         +FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739027655; x=1739632455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6PnvQvvk55IcGUbjkQl3cz2EdhneILHo+vPskqKe6Y=;
        b=fRazRvnPLqrrRoytsL1D/K3G+2pCZR3Wt38Z9jJWmYFjHpbzAukhXEMQ8p8bkMH6qj
         SMzsLG5bff1Pr0EHUbeGIqswc3jGKbulFBe7Li5lTRAJnFgvHtDEbuhIHp/SB9LO8yuD
         aYZxF8qExNq56Z4aywyXKKF4r/lR4/ZR5/26yJj2PVGMqFRQtl7N63PJXO6PSXvxRFvK
         G8xYGKlhnHTP8ojSJuSOvyVcO54i7YDKeL5FZsKfhQrqv+6fxiukjcHUng3xPeQjyvKa
         kEJVc+ZS1JGQfvAESKE4WCL8bxlCZvXBhMvf7E9bd82bJy0Nj2xcT1crofhNoT4Dyu3b
         yFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Ls2KSS+DGwKKNUl8J78P3WQoevrUG9gksmsFF/2jkrXcWhu1aPzpUC9QBYdJrDVSuPuI7711NAUj2Z0T@vger.kernel.org, AJvYcCXJ5wT5b0fVHjmVLLry6h+76ANc+gopDXx3swCrzXlA94wRO3FRX8ve9EN1hzQREsWl3P5KQtK4lbA9AYbh@vger.kernel.org
X-Gm-Message-State: AOJu0Yydox0zQw5PjC+re62HonjKYLvD8AqHy/OhbjMxDcn1xqg6Iq4/
	ECouTV3sg6j5hKVH3RStiNGijHukIqkSENY5kDccXfUdNzuT/Dkl
X-Gm-Gg: ASbGncvZa9WW9gZeFqL0hs+DknOkrCJ4w3mT+e3XjYNdNH+moV3wmLRKIE4rELQ2m3z
	cIS8xhdxoO3a5+Nt2yqca18g41wCtEsi7Vy4gdkUIZQDhXD0BIpDimQaEXS/st4BwOETWjBZtf7
	//WqZaZLUu84siGIBw7GLGc4l/Cih/shSbWGYtIsIkgkLrwcGIgRxRCcoEOeYb4kiU0+E6uywVq
	1Rd0/jgcfyCwZNBPPYS1sLpN6oBQU6u+KTNCN7HBhFVEIV0jZ2aOJSPuW3a+B2VERQBAt4vxcsy
	grhN0o7ChCKF5GgIYm97DOMR9qOhjYqXcZAcNXjzD9xg5rUkJ8HKnAcK4B9wNrTUfGSKTHXZ
X-Google-Smtp-Source: AGHT+IGmifduNSCbvIOjfDBY4BTvQNzu2WLTqjFg7XERN6OZi8gpwC3xViO2h9wYSGmwSnK8o51AtQ==
X-Received: by 2002:a05:6000:1448:b0:38d:b28f:5657 with SMTP id ffacd0b85a97d-38dc935f563mr5441102f8f.43.1739027653812;
        Sat, 08 Feb 2025 07:14:13 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd35742sm7227530f8f.21.2025.02.08.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:14:13 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
Date: Sat,  8 Feb 2025 15:13:47 +0000
Message-Id: <20250208151347.89708-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the function is 'hot enough' to worry about avoiding the
overhead of copy_from_user() it must be worth forcing it to be
inlined.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
I'd guess that gcc is counting up the number of lines in the asm again.

I'm not sure how to handle the indentation of the continuation lines.
Lining up with the ( gives overlong lines.
Elsewhere in this file one, two or four tabs are used.
I picked two tabs - one of my favourite schemes.

 fs/select.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 7da531b1cf6b..9d508114add1 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -771,8 +771,8 @@ struct sigset_argpack {
 	size_t size;
 };
 
-static inline int get_sigset_argpack(struct sigset_argpack *to,
-				     struct sigset_argpack __user *from)
+static __always_inline int get_sigset_argpack(struct sigset_argpack *to,
+		struct sigset_argpack __user *from)
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
@@ -1343,8 +1343,8 @@ struct compat_sigset_argpack {
 	compat_uptr_t p;
 	compat_size_t size;
 };
-static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
-					    struct compat_sigset_argpack __user *from)
+static __always_inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
+		struct compat_sigset_argpack __user *from)
 {
 	if (from) {
 		if (!user_read_access_begin(from, sizeof(*from)))
-- 
2.39.5


