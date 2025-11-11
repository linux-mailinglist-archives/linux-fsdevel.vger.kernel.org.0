Return-Path: <linux-fsdevel+bounces-67926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0503C4E0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D6E3A1B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBBE331210;
	Tue, 11 Nov 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="G8bdj33O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE301328259;
	Tue, 11 Nov 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866703; cv=none; b=ZVfX+ocOcjYpvmbl2FAXCkmqt4PiPrphdulyRwaShJjUWAXeAFt3SqcT5gDMs4faqvPpwvCCrNpe0ekACnWduOupqCEo3z1bOiB1OBwLbPbcGZgdg6QMQQlcSRqaXK56aZhanx81jEj33iQDr93fM/zGowNZ8TFIirfiST06eIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866703; c=relaxed/simple;
	bh=by/Li4iSHhM1rDG8xsYwZIwe5AwgL0fSad9FXoF5WKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyjBRCtKygE0Q88HrB70mQUeVW0gjKdKD5jkejQzRRHXh1tK4+8Y12u0eJw0LFS1ujF2VtVbVhEgxHrfR9gTx7+ooSAmN+XRjx0ofEXGo7BqLpbEd55etYE7qaoGCTQaoaeNUDoJ/iKJexKoNgtHuLTtcb+6es1noznQ8rWcDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=G8bdj33O; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762866692; x=1763471492; i=w_armin@gmx.de;
	bh=SKEe6QBDEckw6UbPK40FILVB/LXShWLeNILNZ7Iwdpg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G8bdj33O8IAkZKQaFJkZr2D6+ai80NwXDXfFTCFLamIj3Qo/snMZ58JpovCg1MDN
	 ka/GF2IenwG0U9wf+o3woUaCzu5cybMGOFcfv22KcogUNcmLUcNDCsqwzbhEc5LU2
	 7wDPWcy/RW1JeKpHCtllmqyZcoh46oygfjcYoeRK5T4+52me7mCnT6yK5BtVXff/q
	 pwSEmq2A+Vez5mRsdsfL3ypHYN7r75FZ5S4gGXllmXx2XPQSCQOfvxCiP059q4xa7
	 xhpWHck2iLvGFJSFUde6vQsN2O6BQ0Cm/ZZ2HEHsptWF68Oj7xitmpG1YyCHluFVL
	 E0rO8VPl/GQhfr6yhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfpSb-1vpf4c31yb-00qGOQ; Tue, 11 Nov 2025 14:11:32 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: superm1@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/4] fs/nls: Fix utf16 to utf8 conversion
Date: Tue, 11 Nov 2025 14:11:22 +0100
Message-Id: <20251111131125.3379-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111131125.3379-1-W_Armin@gmx.de>
References: <20251111131125.3379-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aHvUie/LVaPFFB9fYLOP52I86uXBhSIuLhHCGlgxtPbeel9p6w+
 MH0qjj7dySvW79LrNOWDKZ1gCRX67ChDmyFoorJulR2ya8GKzCp3u4ACf1YaDzt1J1TSxOv
 wVNw78SgXcj74sXfYGqX3roN8tusd92BCLjlYwns0YvHAkZckWen0wY7JulAYu0H3Rpngg0
 giGGLOFJwE3fqokTVBk1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MeRJ5TjFvQc=;eXWDkIDzjHMKu5O4ujf6nSBT83h
 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

Currently the function responsible for converting between utf16 and
utf8 strings will ignore any characters that cannot be converted. This
however also includes multi-byte characters that do not fit into the
provided string buffer.

This can cause problems if such a multi-byte character is followed by
a single-byte character. In such a case the multi-byte character might
be ignored when the provided string buffer is too small, but the
single-byte character might fit and is thus still copied into the
resulting string.

Fix this by stop filling the provided string buffer once a character
does not fit. In order to be able to do this extend utf32_to_utf8()
to return useful errno codes instead of -1.

Fixes: 74675a58507e ("NLS: update handling of Unicode")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 fs/nls/nls_base.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..d434c4463a8f 100644
=2D-- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -94,7 +94,7 @@ int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
=20
 	l =3D u;
 	if (l > UNICODE_MAX || (l & SURROGATE_MASK) =3D=3D SURROGATE_PAIR)
-		return -1;
+		return -EILSEQ;
=20
 	nc =3D 0;
 	for (t =3D utf8_table; t->cmask && maxout; t++, maxout--) {
@@ -110,7 +110,7 @@ int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
 			return nc;
 		}
 	}
-	return -1;
+	return -EOVERFLOW;
 }
 EXPORT_SYMBOL(utf32_to_utf8);
=20
@@ -217,8 +217,16 @@ int utf16s_to_utf8s(const wchar_t *pwcs, int inlen, e=
num utf16_endian endian,
 				inlen--;
 			}
 			size =3D utf32_to_utf8(u, op, maxout);
-			if (size =3D=3D -1) {
-				/* Ignore character and move on */
+			if (size < 0) {
+				if (size =3D=3D -EILSEQ) {
+					/* Ignore character and move on */
+					continue;
+				}
+				/*
+				 * Stop filling the buffer with data once a character
+				 * does not fit anymore.
+				 */
+				break;
 			} else {
 				op +=3D size;
 				maxout -=3D size;
=2D-=20
2.39.5


