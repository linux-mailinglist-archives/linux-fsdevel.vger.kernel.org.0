Return-Path: <linux-fsdevel+bounces-32671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B89ACEC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF99288752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3D1C75FA;
	Wed, 23 Oct 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RorhM/lW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C91C1746;
	Wed, 23 Oct 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697312; cv=none; b=Z86HI82KiT1F6AbveMZ/QsHSMfyu2+NqvUX5/05OTvcxxGKOie40Uy7ZcKfz+n3MYJfDyFLGlVxfioiRMEdKf2EfmfxQb4N2/Q+NYF+O/p3rTQ6vCt9lRNOnqDPdjumpslH8BfEsD2Q+rNZE4usjinNeK05Pq2ZI/WKESJMGS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697312; c=relaxed/simple;
	bh=egzzzpluxju+Brk1kUFIgghBxAeHeEx6E4RAuoSQXek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQJ3JgwqvxZWNuM+nJaDv/cUug1OeAJ8dMuqpMsd5iCYOcOzW2Hpiw6sM8dUF1cQ/BWsf7ekwat75oEG7RGgdZ9K0+yZ9SQTKT0+fHsoSp6dI/izRtSsOGXzk0SY6eBdp9GAPExc4+zp7hPRviuNTUn1tiTajluz+WWxvFyL3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RorhM/lW; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729697291; x=1730302091; i=markus.elfring@web.de;
	bh=EAENFtjl9sz4HwwtPOdI6rZgMghwnGzijGkxKkOHbLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RorhM/lWMk7pMNYl/E56jF5zJnCPDxNZYm8GttKhQcpvr7Nysg+b59VaMiin7hs4
	 ToRMfpcavb5zcIAtM4fxCVftGaqwHAz9Y5Qsh7KPll3M6qWZWBQEh+jtzSpKtUrRw
	 F1apT6Hr3F8IX6E4hX3CvL+rSlLStrxt29yLoUME6eRzUk8Ioo0JUjCpzf4DOOgSD
	 s3iVx+Dw11fBoE7299sDPxkNPCZcl/x6H7+qNYYAHUC2rD9Lsn9x3/N8fdj7T0y3K
	 pBqPTY6Z+2FIZ64D8QcUAQn7Ul6F7F4Ky2jN35NUxQerio0FEpLbpn8NEsSgHJjwl
	 WFn0V0When8XR0+whA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1u26IY2ORJ-00vV2M; Wed, 23
 Oct 2024 17:28:11 +0200
Message-ID: <582379a6-dea3-482f-86e4-259d4b23204e@web.de>
Date: Wed, 23 Oct 2024 17:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
To: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Joel Granados <j.granados@samsung.com>
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
 <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
 <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>
 <t4phgjtexlsw3njituayfa6x5ahzhpvv6vc2m6xk6ffcbzizkl@ybhnpzkhih7z>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <t4phgjtexlsw3njituayfa6x5ahzhpvv6vc2m6xk6ffcbzizkl@ybhnpzkhih7z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UL0i4NV2r5DTLgpQYTFUVA8BVfy7ERUfYRECBvNrEYUZxV1vf82
 ljLxLuIfeQwb8Wn63oq21SJ0Qz07P6Lya7SlCHLSp5sUALM+6dzWKn9ROtcUsvITkOZDndh
 JXbGdgqMXjfnCXIVjXqdG434ElGeAbvrjtugLlx5TrANvIa5Lui1T1SWbLBiyKB4sNu9BFF
 qk2Z2+6lUmcx+RocxI76w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nMrifFBllBk=;+x1mrZqyfMrCBW3w2jah6QYdGai
 Ah816exJrIbb/2kU5S/UvpIQ0ttC0pgMZ0SZwACqM0/Wd5BG4D7H4H+aL3b3QR7cmwtWAgQR1
 a3r3SV9O4/a+RsPinWna6+TgFpCVXMRRsMOr8XIowuFcFU6zhe5c0E/lIWFWMdNO0HGhpsU9E
 mFxyYJG9OOYUU4YRbcQcWEVcLE9ha8OYQZ/eHigSon4oZuEUCJCb4FmG+0JqtrEpoAcmh5+wN
 NKZ/qqaKIuBB+vqfF/31mrynxkpxoB6lldaA2wFJW27tRLqSlO+mTfreurXqvmuv0Ilivfxz2
 AcdCHjEXKQtbQpTPsYiR8+PvUCkPCMBk5Wd0NA9OOqO2B3YlVwjCUAMXtT9bOdJ625C3UDLkr
 p/dZ2ORqJs6f5SfWc4UTTLe2ENbBo8mtssycg/D2QrWQxo7GUi6s4XCfD+4eJ/WLe/qXOlvbl
 /VUOWg3kXiZ8XzHAa8skBF2ORT2K+4dd4lQq+X6wNqsQ7+PElhjGvWhIk5XEVvbbqXkD4ddoB
 z+D8xZGahvKE991VoZR+iYK44atAX1VJSoQebAMH9HRxCXl8sG2/zvEO7WLR6bDduscZCGmCK
 gb+JIH/J3uaIUFbGJQCVbiaSOOxXlIVAvqkmk4wcGocbEvDwy04EQK/FNIhnMD7he5DHERr/R
 QzFxDZ1HyuN3dFb3E6sJlwTzsp5gsl8NZBJDRTjSAbPnsYKHTa4FnhH2nq2krClRCUt0UITLR
 ueqQmBOf2MXdeTczDlsa+VbFIB5sjB0nBW295qrpHPZ7axQ2EhpniQohqdEcHB09wq1mfmx4S
 qpGFbKxAoRd21RBbEGvGxOIw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Oct 2024 16:54:59 +0200

Replace two dput(child) calls with one that occurs immediately before
the IS_ERR evaluation. This transformation can be performed because
dput() gets called regardless of the value returned by IS_ERR(res).

This issue was transformed by using a script for the
semantic patch language like the following.
<SmPL>
@extended_adjustment@
expression e, f !=3D { mutex_unlock }, x, y;
@@
+f(e);
 if (...)
 {
 <+... when !=3D \( e =3D x \| y(..., &e, ...) \)
-   f(e);
 ...+>
 }
-f(e);
</SmPL>

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* This update suggestion was rebased on source files of the software
  =E2=80=9CLinux next-20241023=E2=80=9D.

* The change description was adjusted according to the wording preferences
  by Joel Granados.

* An SmPL script example was appended.


 fs/proc/proc_sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9b9dfc450cb3..b277a1ca392e 100644
=2D-- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -698,11 +698,11 @@ static bool proc_sys_fill_cache(struct file *file,
 			res =3D d_splice_alias(inode, child);
 			d_lookup_done(child);
 			if (unlikely(res)) {
-				if (IS_ERR(res)) {
-					dput(child);
-					return false;
-				}
 				dput(child);
+
+				if (IS_ERR(res))
+					return false;
+
 				child =3D res;
 			}
 		}
=2D-
2.47.0


