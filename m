Return-Path: <linux-fsdevel+bounces-67929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDEC4E14F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60A454F8009
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F034250D;
	Tue, 11 Nov 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ip28wqAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B933ADA7;
	Tue, 11 Nov 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866709; cv=none; b=TdIy0foZ3N6ATAVbX0KV7JgEGXhxUzveTU7ZY67gbZ3QSbL6I0QP9JEvswcXYyAU5QeJPULB4sgvGc4bgAVLMXeEBEXd2CshIn1bL3b3fKk1o06JWqdD/yPGeM6NIsPkVC9pZPK/MlqfjVD54qRWl2J8JD282DBEqqC8wEj7trk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866709; c=relaxed/simple;
	bh=l6dgkwVTX+nYYUEUarUe9Z8EG8LznFvBnfy7Dit+dJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e346X9cFVdgzzYGiD0oK0ftVmUuZrlt7M3xbJGowf1Qm74PHNU25Gu6ECgPbAmewRvC9rT70/PxczwFmzK+tQqk9m/ip82T0ZXDq95dKnz5nMz8A7w3vzzO3TJ1ndPZOsN+mwRG/utsPyI/RnC0rwS5AprELUlKehkNwE2OxqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ip28wqAn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762866694; x=1763471494; i=w_armin@gmx.de;
	bh=0P/Z+v6CnKjg6IgFnYEQ2dxLZv6jFsLO3430lUKgxhA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ip28wqAnXowYQDAYdSHujmBD41/wYLA4FUYeVp+xRy/Xy9KDEfpqQKkPmbWusYu/
	 DwTG5Bhh4JPrU/V8Hgs8noIW0Rz9Ax/BdexR0wVmdHH3jgBB54aWvViZc3VGObkpX
	 ptGxRi0Tr3cZoJqwLIaQU9fH7NNon+5/wD1jP2Sq5P96JB2iGvQZ0Kn1HzQdvtFXF
	 6xRS/dGXeWFg3mV/2TgScjzpMMg20hw04z7CXQPGSq55Is5zTa5ldiC8xD6+bnTsg
	 7/Cy7YnSiaWE0dY4gETx/R9fLoeWhIeNhkS8E7XAa2lkcqbl20pE45rCiAG/GtvOz
	 fEeTwK5j6Wo3ie1F1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MeU0q-1vtEu1452K-00ipnu; Tue, 11 Nov 2025 14:11:34 +0100
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
Subject: [PATCH v2 2/4] platform/x86: wmi: Use correct type when populating ACPI objects
Date: Tue, 11 Nov 2025 14:11:23 +0100
Message-Id: <20251111131125.3379-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:WKzGiazRbRJEWXZ7gA3cIuv0IkVn5I2vz1LzNVsEAcenG2S3zDB
 g1uq2aiZrBk1UJ5IGkepXXNL2icgrlHc4hBEQNfkqdMZSNO+oZg7QNSqkeykb5+b1ZsBAkm
 9q+T2o2c+2/7iBeBj2G57RC08zBK10iL6RKjMDAnkT6GUup5fRtONOgwu8EpabV4sVf3L11
 xRdpU+PbA0dlUyqUVOazQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iyzTv7W2Kgc=;PDvimj3XJ1v8KGnZhdAUcQ112tk
 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

When evaluating a WMxx/WSxx ACPI control method, the data buffer
either needs to be passed as an ACPI buffer or as an ACPI string.
Use the correct type (buffer/string) when populating the associated
ACPI object.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4e86a422f05f..6878c4fcb0b5 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -142,14 +142,6 @@ static inline void get_acpi_method_name(const struct =
wmi_block *wblock,
 	buffer[4] =3D '\0';
 }
=20
-static inline acpi_object_type get_param_acpi_type(const struct wmi_block=
 *wblock)
-{
-	if (wblock->gblock.flags & ACPI_WMI_STRING)
-		return ACPI_TYPE_STRING;
-	else
-		return ACPI_TYPE_BUFFER;
-}
-
 static int wmidev_match_guid(struct device *dev, const void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
@@ -351,9 +343,16 @@ acpi_status wmidev_evaluate_method(struct wmi_device =
*wdev, u8 instance, u32 met
 	params[0].integer.value =3D instance;
 	params[1].type =3D ACPI_TYPE_INTEGER;
 	params[1].integer.value =3D method_id;
-	params[2].type =3D get_param_acpi_type(wblock);
-	params[2].buffer.length =3D in->length;
-	params[2].buffer.pointer =3D in->pointer;
+
+	if (wblock->gblock.flags & ACPI_WMI_STRING) {
+		params[2].type =3D ACPI_TYPE_STRING;
+		params[2].string.length =3D in->length;
+		params[2].string.pointer =3D in->pointer;
+	} else {
+		params[2].type =3D ACPI_TYPE_BUFFER;
+		params[2].buffer.length =3D in->length;
+		params[2].buffer.pointer =3D in->pointer;
+	}
=20
 	get_acpi_method_name(wblock, 'M', method);
=20
@@ -519,9 +518,16 @@ acpi_status wmidev_block_set(struct wmi_device *wdev,=
 u8 instance, const struct
 	input.pointer =3D params;
 	params[0].type =3D ACPI_TYPE_INTEGER;
 	params[0].integer.value =3D instance;
-	params[1].type =3D get_param_acpi_type(wblock);
-	params[1].buffer.length =3D in->length;
-	params[1].buffer.pointer =3D in->pointer;
+
+	if (wblock->gblock.flags & ACPI_WMI_STRING) {
+		params[1].type =3D ACPI_TYPE_STRING;
+		params[1].string.length =3D in->length;
+		params[1].string.pointer =3D in->pointer;
+	} else {
+		params[1].type =3D ACPI_TYPE_BUFFER;
+		params[1].buffer.length =3D in->length;
+		params[1].buffer.pointer =3D in->pointer;
+	}
=20
 	get_acpi_method_name(wblock, 'S', method);
=20
=2D-=20
2.39.5


