Return-Path: <linux-fsdevel+bounces-67925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFEC4E137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5E0C4EFDC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39733120B;
	Tue, 11 Nov 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IDwYaVQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F6328248;
	Tue, 11 Nov 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866703; cv=none; b=tuLlWf8R2IDNiul/DqvvvJHuhb8aqe5SzAfe1CdJOdRE5MGsndo4z7AURclEjjBvKkERpmI64XEDQRGfg1uP4GI+65V1CnFe/If3e+jl8800BU7IsWyy8BejwcnOujk40cEraSQEQZuVJFFafgQ8NKtStDgdWa/8zfUR/gNFRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866703; c=relaxed/simple;
	bh=l0Xp2gdUHOY3ARXkXTrD+8glhjg9MqV9gwERXhTeKBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcP6bQUFGYTFRURAaZVCCmioSoeTdZ5beVmUwWY818QVj59WLxz7clnl88kePvnbnr6PdaYi8mZL1UkwrkW1y81RcU4XtCw+nO3Rxra44UV6hGEOdb8TGc9ptBO9mu0hSBVckqBmsO57C6c3b2uCgjUjfRbFN5XH/91pVp8xMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IDwYaVQJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762866689; x=1763471489; i=w_armin@gmx.de;
	bh=7d5cSiuqrvKYBz/rIkG/i6IpNv3Dy66WwkCI8QqJXuI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IDwYaVQJomz2JlY+kjOJRDqN3zEiMsxwVBKOeK0TlWrYRH1BvBAz9Z0VNA3Z6dk4
	 IXQ6FVJgvau0RfQWg4LvLGCbWILumH+VMEaO9O8RknBpau42rbVOFAvGSezJ4qRXx
	 VSft1JEWAq3J2SEunwnfWkRGCKUQ0MvtlMJSVEZCWGYO8zL8Ldd5PJ79QDorPrM2k
	 DsQGAIqkGChJdWXH6WY/GgP93TgkaYhPAiEsg3fz/CgUm0/mtugwtOAsJS5jk0sas
	 UPaDXQOceK1jpCPTSX45cRLJXvZa87mI8yDttaDzxLc568P02N/6/gw/LCqWmCG2F
	 +DEcRbFdK7uw0uzyOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7R1J-1wHBr22OmD-00y4sE; Tue, 11 Nov 2025 14:11:29 +0100
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
Subject: [PATCH v2 0/4] platform/x86: wmi: Prepare for future changes
Date: Tue, 11 Nov 2025 14:11:21 +0100
Message-Id: <20251111131125.3379-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qlepj94tEOYfnlSLiimPoC3+SFYTX5UAcDQG6J2MG6sAsoahSzM
 NwlARGWDEfBREuV0RRFWQNXCiC57axetd/fB8gsVi8B1aPwiepVnQpE6JNlUGD7NDoH2kd6
 c4+8w1/olClSQsaySA0NSyJFT9GleO/h5Mb8qlayWP5hxjyz37aqYSi2k6S4gAbUn3+enpP
 BCjqWgR2VzycKXF1foxgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yI6zRK1hh4Y=;2KmdeyGSE/zIaQQzJ8XYl5v/GIw
 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
 7P9uwXmbWGdiCd2XxCuEGe/yHM=

After over a year of reverse engineering, i am finally ready to
introduce support for WMI-ACPI marshaling inside the WMI driver core.
Since the resulting patch series is quite large, i am planning to
submit the necessary patches as three separate patch series.

This is supposed to be the first of the three patch series. Its main
purpose is to prepare the WMI driver core for the upcoming changes.
The first patch fixes an issue inside the nls utf16 to utf8 conversion
code, while the next two patches fix some minor issues inside the WMI
driver core itself. The last patch finally moves the code of the WMI
driver core into a separate repository to allow for future additions
without cluttering the main directory.

Changes since v1:
- move WMI driver core to drivers/platoform/wmi to prepare for future
AArch64 support

Armin Wolf (4):
  fs/nls: Fix utf16 to utf8 conversion
  platform/x86: wmi: Use correct type when populating ACPI objects
  platform/x86: wmi: Remove extern keyword from prototypes
  platform/x86: wmi: Move WMI core code into a separate directory

 Documentation/driver-api/wmi.rst           |  2 +-
 MAINTAINERS                                |  2 +-
 drivers/platform/Kconfig                   |  2 ++
 drivers/platform/Makefile                  |  1 +
 drivers/platform/wmi/Kconfig               | 34 ++++++++++++++++++++++
 drivers/platform/wmi/Makefile              |  8 +++++
 drivers/platform/{x86/wmi.c =3D> wmi/core.c} | 34 +++++++++++++---------
 drivers/platform/x86/Kconfig               | 30 -------------------
 drivers/platform/x86/Makefile              |  1 -
 fs/nls/nls_base.c                          | 16 +++++++---
 include/linux/wmi.h                        | 15 ++++------
 11 files changed, 85 insertions(+), 60 deletions(-)
 create mode 100644 drivers/platform/wmi/Kconfig
 create mode 100644 drivers/platform/wmi/Makefile
 rename drivers/platform/{x86/wmi.c =3D> wmi/core.c} (98%)

=2D-=20
2.39.5


