Return-Path: <linux-fsdevel+bounces-67927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22BC4E0F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BEB188085E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669633AD85;
	Tue, 11 Nov 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Wcx9jMJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238133120C;
	Tue, 11 Nov 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866706; cv=none; b=S9dj3Vt/dPbTsfN+Hlm7HgkXZg1S1YRqUimkvQpRFuLIfkYlMkLZ+xti5glZL8yNGGZ04bRSbh1a+cq7RxS81tCu9RUd6irrLo2zWD7c2yhQY11grAXDNaQuSA2ukqqpNi2ySa1P2BgQpmwdDy66IvhGIXEOWJQ3APwXsWKI0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866706; c=relaxed/simple;
	bh=J7WqU+qFuPqY6lrI493z2xpaTkFBF79kSoAgrPIeltE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jevzPFxKXhDpzOfzeXYmK63KELUopn29k7V1X3H2tulQPGyiIDmK7oD9cx+QBQCwU69AyHehaJNAm5Gqvs26e42VEwd1dCtS20neZDI2bKl8oGb6/5MH5QeVj2Fk7yb4waT1QKiDmyR1Y6ahfj4H1oigvIj2reowq4XFln9ggv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Wcx9jMJT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762866696; x=1763471496; i=w_armin@gmx.de;
	bh=7iRlyxi57atvoFWPoLQFNeWyWZNMG97YnVYPNzVDjkE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wcx9jMJTlJDDpDYiK3wGT866ydgBZ4iYc6T3a9RKoUwbXc0zKqkznT/U3ZU1xbsI
	 TNDsew+zJ8bKil30uhAFbjWdcjCHxwxgLw/9uA/pPzQ3eLp6FV/nqpbBp+h2WE3tm
	 PR9mFYEs3HCKjO03PFfdJfmmHbLkkK5xkg4Iz+64EeI1CZ71mR5297/34iu6BZB8G
	 O97XZfpujiWZiHLS3OVJcDiRc9RSJkA9FrThXIEFzxsIdMTETM0Li2/+ebbXZ+esB
	 lrfDeVsGfySZjLJxFl1PrlO8SntdzbMGHq9dreUPNeLHHrhTaaF0eW++jViRtg3NC
	 ApmBfGeVGelXQNwR6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O2Q-1vLYmM1o5O-00BPwd; Tue, 11 Nov 2025 14:11:36 +0100
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
Subject: [PATCH v2 3/4] platform/x86: wmi: Remove extern keyword from prototypes
Date: Tue, 11 Nov 2025 14:11:24 +0100
Message-Id: <20251111131125.3379-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:J+hbef+rldfd330a5NRS1/Eklb40AdaA9tHndaptE8Yeujm818G
 eyYONA/2FsPto7oxM5Cg+xoPhXn+hHbBTTCyWDKLtNNgAx6tahs/KK6TEC1bO+euGhyEHBL
 /+b6EJNeVimBKS3fHAMNMRXtCUkLHOLKPeHj/cDTh7k3WRQEBz+DFxNzIbeFo0whxYV+Gkc
 JlA2BUB0G9aJju63StyOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QQ2+NbBHa60=;Hp9MN9tpNn6jkpdCeARQ1tINutQ
 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
 Fxxb1jjRTUyQXDR+UhWs0J+dePWl42oH9ne+6C

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


