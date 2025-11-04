Return-Path: <linux-fsdevel+bounces-66988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59EC32F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB404608BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DB2F83D8;
	Tue,  4 Nov 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GdYHzDxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F04224AE0;
	Tue,  4 Nov 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289165; cv=none; b=dZf0FoIt7C5oJcwYxuRYiVaMBb8jstDOEAx5Ey81D9ANPSyVeOhH+nNUP/4sLSDK55uVdgBZcH23JFyFrGVoNTSSkVrhdsdjrvxXmMC0hHYBW9X2yWxSQ05EjvM8UMNGa7Meart+ZBaw5VIX0sFoOFCcL9nLwgyY/C4kYHpnn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289165; c=relaxed/simple;
	bh=J7WqU+qFuPqY6lrI493z2xpaTkFBF79kSoAgrPIeltE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMcFG8qN6nVUiHe1XrOt8CxYjRPaf8esfQTjxO+LgyL37vQhDvlNfYewIV8rw771G/XzJR0uDIvmxHXlZ0ISgZ/N+Y5LwNQ7wwLN50n44M8tn/2sPzeB4aTK/bZGau7a4KGQ4cRs2Z4yq+5NN4JCgHQ6JJhWV1vgONiKFaI6ATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GdYHzDxn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762289157; x=1762893957; i=w_armin@gmx.de;
	bh=7iRlyxi57atvoFWPoLQFNeWyWZNMG97YnVYPNzVDjkE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GdYHzDxnz8X2vBe2eJXlW3ZqxNgwWX+IQ8xfF+8vis5FnrpLqf2Isbgul/sQO/ny
	 G16tiYAY4i0SJ8T/IxNO5j3kQB9GbRl3FO+Lsv5DNz15R9YFce9LwED1moCuzHBjU
	 iEDi0hh7Fsn9sKFHsqZJQaVPjTE/m6Uk1V7qe61thXeOZokIgSihpVjOElDsI3Zwx
	 y3JxHwyhjTKFmo1LWFkrEiIV5epR66vjal1xz9j5BweundFD9RbwhO9w4qAFXyFEr
	 hxQdkk1UBL1V5WvzAZ33MxdxgzNVOoIO4DhhobEdvCRjJjkIo/m5nGJz86rNpzgT1
	 7Wftk8D40u0OXNgV3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvbG2-1w7nJS40n8-00rlkA; Tue, 04 Nov 2025 21:45:57 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: wmi: Remove extern keyword from prototypes
Date: Tue,  4 Nov 2025 21:45:39 +0100
Message-Id: <20251104204540.13931-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:6//mA4fyioNXI9gg7XgdXZACMuHlKkzt00fPi2tM39xGGlRNZ+/
 6EU52+fv9+ir5Z3c09D+0PggmCnMYybtRhxgJiWKteO99FPdw8lRhKIjybn+EjeB82GZn0U
 Oc+P2qPJ99hGG+e5EIq/x1dTVWPchQjwqMEY3Wxqur17jjEZYPL/Zz1XZO5jT7MHNDrHHmj
 gLmNJvidhNkUVIRJq21gQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iE17ucOgyCE=;dQqLgnQLC+mtTz7nb5aHLpY8PtW
 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

The external function definitions do not need the "extern" keyword.
Remove it to silence the associated checkpatch warnings.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/wmi.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 10751c8e5e6a..665ea7dc8a92 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -36,13 +36,10 @@ struct wmi_device {
  */
 #define to_wmi_device(device)	container_of_const(device, struct wmi_devic=
e, dev)
=20
-extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
-					  u8 instance, u32 method_id,
-					  const struct acpi_buffer *in,
-					  struct acpi_buffer *out);
+acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, =
u32 method_id,
+				   const struct acpi_buffer *in, struct acpi_buffer *out);
=20
-extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
-					     u8 instance);
+union acpi_object *wmidev_block_query(struct wmi_device *wdev, u8 instanc=
e);
=20
 acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const =
struct acpi_buffer *in);
=20
@@ -81,9 +78,9 @@ struct wmi_driver {
  */
 #define to_wmi_driver(drv)	container_of_const(drv, struct wmi_driver, dri=
ver)
=20
-extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
-					      struct module *owner);
-extern void wmi_driver_unregister(struct wmi_driver *driver);
+int __must_check __wmi_driver_register(struct wmi_driver *driver, struct =
module *owner);
+
+void wmi_driver_unregister(struct wmi_driver *driver);
=20
 /**
  * wmi_driver_register() - Helper macro to register a WMI driver
=2D-=20
2.39.5


