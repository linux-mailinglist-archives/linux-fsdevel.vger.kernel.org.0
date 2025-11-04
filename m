Return-Path: <linux-fsdevel+bounces-66989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A11EC32F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75AF460BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA112FC87E;
	Tue,  4 Nov 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="egsTa0mX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C32FB0AE;
	Tue,  4 Nov 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289171; cv=none; b=gkMbTR5N4KnrpT8pOUMYYdUbwSCA1fdfquKo8zG8Rr0dpg1Yo+PXQlZeRlnInmD+qB5P/VWQsF444OfZTrklYpAVIhNOAn1XeWoD7kY2B2QbX5IR45EFZV6Zp05SBKT6mai7+Zr7MK17rTIvgIvIZrBHaQ+BUa8GJRcqbZ9eRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289171; c=relaxed/simple;
	bh=by/Li4iSHhM1rDG8xsYwZIwe5AwgL0fSad9FXoF5WKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWcgibaa8zvBWyNJsVJNgepuHifsyW8Rt/lJeSz2Uwt14M6Olhky+is8RbqkTB1widZilrWGPM3ck6BV3Q6K7/7fHlA9VBtmUkyBZm1X46jUna4o2NNz/U/RNyNRvU1lzsSX+q956RGFkcJvx95egxAmsHWeMJLekVGJyXQjSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=egsTa0mX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762289152; x=1762893952; i=w_armin@gmx.de;
	bh=SKEe6QBDEckw6UbPK40FILVB/LXShWLeNILNZ7Iwdpg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=egsTa0mXQyviLp7yGr9XaH7E0m7kVcbMOOGhbc1p2/ZlVJNYd6U5zFld1sV0L+sq
	 kIBtfTezaY7t+bd0yAGJ236xn9vEyp51oHV32cPLh9nlHEVWillIoB/OkDjrfrPtR
	 nbnzhYg3U/4U9haLz0GQo8nmmFclWL73vXaiJF/372qinWvwUnNGtJFEfgE0vxUFZ
	 cTuxnb41o20yizK4vxa2hdzj1bFkDIcLdtRe9jN91QAarehgV8siWi9D7PW0RJ6JS
	 1VUAmgoO9XgnD37tQWgIWgK1XPkHgwex4yO6JrngXV1Q0yOkdse7v9VjHJK8KohOK
	 KX6OOJONICMxRzO73g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1My32F-1wAIQR1t8R-00y6eV; Tue, 04 Nov 2025 21:45:52 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/4] fs/nls: Fix utf16 to utf8 conversion
Date: Tue,  4 Nov 2025 21:45:37 +0100
Message-Id: <20251104204540.13931-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104204540.13931-1-W_Armin@gmx.de>
References: <20251104204540.13931-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7FUHFbYyPOpM2TLAx7Z8bBcG5qHSsgvzz8rGBE9XcKOAkDvk3Xi
 sW9RcMJgaQmlDqhTH1Qlri7b9XaNQWiQ+1/veXkQrUn4f3BUoyN/TCXsRhbytcRWcC127p4
 qcbfiXIjEL59eZkGaASFgniaEwUjg9zeEw1gCAi1bEGcAdjwupXpu4jWGp0pdVIQcWMgx8p
 OjhiYgO+K/c/bkMolVVRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6s9v6bKRXS8=;4znOSUUmIH6sFTG/Uy5RXVvFXMP
 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
 wQVvmAxJdzNuALs0XhW/JXPGvY=

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


