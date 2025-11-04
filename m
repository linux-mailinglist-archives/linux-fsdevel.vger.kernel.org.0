Return-Path: <linux-fsdevel+bounces-66986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B49C32F3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3B3448FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAD224AE0;
	Tue,  4 Nov 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cOhpich8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0AF9EC;
	Tue,  4 Nov 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289155; cv=none; b=mY/9h2f2g3mD2ht5QeEChN9oo92UMxuh7kMLuQ/w8Qzw8K50EavLNzTVYuY7YVlIxM4Ko/2yw+4QM0HGbPnwRQSdbcLyc7Tx1gdVEvRE5SxjbMojJd1ugAcLz87YFztnSJPnSgsfxMITSIXLQi4aVHIXZAd37vKmMMjAfbFCZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289155; c=relaxed/simple;
	bh=pYRixYNMuRW0O2YOWth/EjjzkNSsUX3bM89uzM/pWaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8yopOkSSL6hGk5VJKryJeC5aK7gcuc0xxqqAYeL6XGX1n2IFZoPJV5zxPSx9p89mKGpEpa4MTMUipnwA0Tj1hQ5xfJBagWeN/zK6R2LbDsaCSbDNLgjx+0Ce2H1Pyl0/8Sx/Hr/Xk7mE3khTONnYANCPL6zI7vYBQWBUWxjMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cOhpich8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762289150; x=1762893950; i=w_armin@gmx.de;
	bh=+Yy5FzeH3zqJeuG3lOxt450dmDHT1IVzQekEBlABkz4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cOhpich8XYFbSZqxPnFgUxmDpTNLN9nNu//tIitA1eL+nk/AJBBNmi2NZqCSbp6T
	 MhWAv/3CnhWs1oJLjYauR2UWwXPku8daK2nqrEir0+T/S+JgVZrGeqTuAPN8nrQSp
	 GLYM1VsU6gY0sH+oACZeut6HGeTcbU6w8G8VS6hWUW7uUCEQZuVbTluzYSANkvBCE
	 dCz1rfRUUkeR0kkEmOyFrf0QSNJt+rWgprGRnw3RsSKchqPhZ0y6IittowSMNXTll
	 vsC3m2aT5EUSTb5qBmnZOksb5FAAw6muBUcKk8dotSqXUXz1zphJUusZWVcJRD2sr
	 6V3P+w45+PESxkIwzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O6Y-1vEk0u0pHa-0036EF; Tue, 04 Nov 2025 21:45:50 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] platform/x86: wmi: Prepare for future changes
Date: Tue,  4 Nov 2025 21:45:36 +0100
Message-Id: <20251104204540.13931-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a2o/5UGqA2g+vWARMlh2wPOjPuXiSjHtKeGIEoiRxG58/6neJm3
 PK1385GPdSgw7Hy9KZ3R+KEqyql4sw9rrJou4vgwBELHtoPX5Df3IBB4w6N4yDTp1sNoRcC
 /vMdl28bkkbx6yFFa85Wxw/6iQMsfCj1BCLKIkTpF2Y972udT+ycBqYL+4pXNLNzoINwVzf
 cAILLueKHdFYOzqUqOcbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nSKeVATT1gE=;d+aUvduCMk9HTls33X0Z/Wm7DLl
 OrTGY39Q213xKhk9uuZhwzj/d3SDlF9WzompmBENV01H0xYG0HfBO/cygvGEzqNNXc+rYQPg0
 8j744zicc+8rlUa+3b6haTXNnGPkFurCErrzwLMyNE9w7vmSPBxMnkyE6yISqJTWAya9/gSn8
 wjDrnJ+11cf+g+H6fmvf8WLsAi6HI3W5e8SneJrC9cGxTd2q6VrXImbTndUYdF+zYBsjSWksz
 h6fcWjNO0cOpXnF3dgrLUk6Diu/NKfF5/Wq0+A1ry6oWTRduMfeYJ6doBHAC7thCcTX4uPOyu
 I45nBDFxldO5nBEwtymZ7o9kzZ9dSSRs1Q2qjeD03/tAmogAPpaKmyp0y8aqDKqfgV1dGU3D1
 vksNI/+JV+bFd6UNNnCjOsmrzNQminIkrTtq1Q7wqcSyVJ24o2WYs1ql3ac0kITWB14/Xk2VP
 RHgxT2AI10M/Isb2/RjZRnraKxgyJ1xVQF0cnUFqklAs1XvBXi4lht+8HJ9l5J3Xzb7NQNVvh
 5YH+7auFWtffk/UeJTQkVO1Z7Dves7k3dV9wsRBck3pXWF6CbkuFXEmKsZga2ubDUd2y8rFl3
 dJi8aRbIjZDKDLnqXt8AS34zYboItHP5zUIshHax9oXvaQkhZb5C5KBSvnqIZjvKGkzXPNfID
 T0lzDQxPkmqnSs9fM73rJ6NxA3TH9vk9c9TZI7tqLej8nzqkregA3aSDT3V9H2UDQhGfx5D+l
 aelOvK5xbhT6CSUTxZz1WIAtJmDWAPMawpTAN69wKaZzU8H0Qxr2WeXcF70HgXNssUT6lUDiI
 /pTwcgJEgYEaRnRjn9Qn8zqkGUkMayHm9z+rgpN6U/2O1j0+CXJcNZBJIkXxAdHY7IShNJCxk
 AR7zflcDpFvqWVPGglWnQ+tGNhYVO2sRooaomJ5mPjmcMzAmCigBjUqvLcJFwneQZr97f3cUJ
 SSBKrGw/CMZgw/sG2ftL8jQFKA7hS4/ZkpFJRD77Bwf11z/FB8sEQoArZwkYtuei5opM2tuC7
 8J+MDenFNV+PMEO5aWG3T6ktwtvHG66atEZy+t6oUqhVw3sNnwHpe5gx+PJPA3abhkjLhQ76P
 oOXQO9hdsfEXUONAWOGh+BomO6kU4uErsOleRo/NSZfU08mNTTqCOBdlKTLeC4O9d93lgR4yl
 KFsKyEa9hB/tHT6FahRB+NAIz6IjayGRQihaH9wBIBeM+9Iyp7kh2TNpP9P8ZopKcHy2t/7II
 n0SeFU00sbiFfpey/7B2FER61D8XjI8onWAfbNtHN53tAGhn0culH73m4h+it3ZiNWb66a9sq
 srUgUFSQ384jyAQ/EZugoMGQSdvnmUF60BCry3WD0+Zi3jNDfm/6GgmZrHJ2kWkrdhRlnYQNi
 FSlHap4D74WyipNQLAm/z78vADYDxos5yoJRmUfsSOe/7fWDiFruNAlZtnxl/KzUkIbYexVNE
 0vYJDUoJWCJsUc4zpRYiwBn+SJVOY0JrGhLRIW/L5sDVJB3PfjBktPMzPWaoEkJf0vZEVkUMJ
 0xCzx3ett4VGyPAEZFObllg79wwsdbw1xmOn9GsegecP2w2aKgIKu1v7skGGkr3UylZH2EMOB
 RKTyOp9lJ9NmP3aLokm2XWsJU2R2XGWM87XWo9iS/qJGyQo8PwyGExBTxYDZug47/SllKbp0k
 ce/D6UZUiW6QMAezBI66FACg+5wAce5pnPtlw4MbuLt3KOVdNAgSS7/iqf4resivD0NlUWt70
 nZt5DO4p8C2sQONcKgAZyZ0rKQVich7Zq9M09TOS2mEV59cM5XXZCmnw1S8Uaq/iYennWRoqR
 dI8US/NqwmYVmzfb5idisbPveQWFZhHlZaGhgj5x6RaX1rNjUfAFqXGj7l81B60O019tLyHcD
 rps/y2Vrpd68fQahAKN8c1meNXgSbPiymTIjHk7nyy4+QpiGe1hjf2igxQx4g0GKaFxuoU8mN
 o8JohIiPhL3FTEkje8w9h/4kGbfY3WNDVCAL3uh7ftwXaoMlEhZ9ECvq27K/ZzB2lTmo7s7ZD
 JKztkWRz/4ukIC68g5g2hiDiS3X1bTRup3HO2jNogZYOqE1w+O4OZ0Kdc55SqJkxb4iaj3Ipc
 UmEpsb/lp2aIj8WopHKlq2yqzFzyG6Qic9prwgMXzT1zST7fpZVQv0ZsMDu4MdMRNUTtNoF/K
 ugvH3qyOe7p0ICwKE1FivffGT4uL1y/BZ7aE4OX5iB/HSmtaT85C5vs6FVc9sPgdRsfizgf6j
 WRBMi5MjiEJfR3Fn4vO4zbQc/5ePCtbiITKYoYggTyXHN01kKnEpdt0DUL0uhQRULEsU4JRW4
 aSxzO0YdFtvFfkYII/Zxd+zLbcfVxi5sF9yo21F3M8yMnLIj/9iSlE5fn5ct9OfT71mEcDdrX
 p4CDw44RyOHuypGl0ZZkpBfnMCm1yrY82hkxXBp3lcG6LkoSli8NErXXiw1q8bVp6PXio6UjG
 C5UYLr5w93+NCqvRmp4o5YLBJqzrV4nclBpLkWFGorEqCTMx1nKWuKni5x7Lxc5sgNVIg6+Dv
 +3QhuoeYD5eoR7PjX0DTzVdQL+po1oHqFwoCyz0IldQK3A2tMnLw8bmlxKQRRp7DPkPBqGIl8
 r8RtKMPg/y5Mo9tnLbFrGYxJerejNleVC+aN8jid+F+s3DRBBSRxeRbhMfswLXiKD6Qb2CpjK
 FMgNmjp8ZqT6txzEYSgXFUAhUM0SVbaYjxwScdAuNBX3lXTp/T8ln2U6XU/Z6OkCM1rQvDWs2
 hGVmcL/kyCy0BSJOmUn+N4KvcjVuQOo7Je0+HhPAUKi43tJdFdY992VBkpO8UDsaJeKPaEzX+
 jJa1VGlwF35EUd8qQjQjA8guAU5onOrLoHGqNZU6CFy5+MiccJdPouKcDI7pmUBtj8W8LQAJ9
 eD7Ie3ruzcmwsS8se5dBguUTVTP3nEDSwi1BQ8l9ckHPYJyYqeYdhUcmRZtF07BfGGiHz7dcm
 HkhZQBEp/uiOYrKwf3HeQLXWqnuNdjtN0zuMXZROBuBT37udbfywGZ7UnmEogSdQ0DAQC5KFd
 XEUV1GCFXO3rmnw7f5ESGBBXiFpNk1VdnGCJT28dxMskNMOO/UuOLoACq4uJNjKi5Eo2b9e8U
 EXVubVLdIZCV0AaA4tbHZVsXHOJd4+pAbKT48lJ/2LJYGQPMRAv4VTAlrAj9bF0eOQi2sN06m
 3lqSO7aOI1kRfwHLPmTyeN7W/mpX7Ljc+7U6VT8fBb617gtApC7g7yWAKEu4KBXFmtnI10TO5
 XlVNZTmKEVgQeuYiji2AlMUvysv0f9vs91GdoTAJozhl7odDIHNEXQECiMJxJrCV7XnMF0oVl
 t3T6NTO+0yjWwkZ2LGhGJ2x8H4PG/1mfV3gq7LiDN9w+XJYjyatFcSdmzGdfXVUgspwoDin3o
 PK+o9f2SblEriI9iIYL7OW19BloE2ZapmXmqvt0xMnEfitdVavsYCukqnMESWLc/a1XtUkXxE
 ThK9Cr97yRas1j07dlMbvaveYsy7cobLc0MywL1Hf3TYN/M7DpzRE0+P7F05RxNJHZPWtM9iR
 aJAx/7zSSQyEaG2OYFLtbAbF6xf5vilM3jHUT9+Ed3qye78BKge6FBwd1stFYOSbgeeDAuECx
 X+nm9GfL1GOg82C3ao6qESq2obX8TsSXA5WYBoq03mr6L0xLJ/Pm2P9PLiSB8vQZy7dOmK06k
 KOkc6BilwYOjOLhGZCpEWtuS1pcf2SOmBRzvY3RKmOkpHYat7YfKJb+9S18wAtFdDV5uEsfCO
 1ETskjmnvyljAYAGgjmq6sIoo4QRTUAcfSau0vIDGfYqN0s8kJ/CkwF4gIui/bvN/H7e+gMnm
 jqPml8OlLKYgjIbuxkSuyOU3xc2MQAlzCI8abjWzks/owRmVW39TBMtq5xyvN0uN4tS6iiH5j
 GjucVcDGOZWTkAeHmwlKFIzbYGGCSkURhc7Vn+7QzzPd79NhHojRLO6qUklGxLu67bpvcmYfk
 Ds4MfWBQwd8bQlMRaA6zrtD/wuis2ErcGtQQWkW6cTujqJcU6Vh3FAJTckEVX5BX08zOEDpH7
 hNbQIb/jKTOBgWuVUe3raefTm7KZiiO7NTeSakXSlEvgfMyyFEX+Mqv39PCDxdW0vbjnReaaT
 QC2yMyUy8AOM/MhXRcRwaPrzXBt735YYcQwR20RXqZ9v+RhsiakZsxxA3X7RTrFAe7SMUNTH8
 LnprP9BpU1L2R3ymc9MVjpnJHcUaEcTALXkBIqDAFXVzIlOLesIluxK9RROQZT0Maw+2eQTzQ
 dkyf+1eew78QpBxjyyGtLOnWxudg49/f4Jw7XIVjmFJH48VSliQutZEz3VcvSV/mOaDYDXKBR
 uSb72pFnxurk5x7VR/YaFBtu+YG99//Hc9H4i+uq3bCdRNnGlD4O/53b9bhAN35m5X75/mtym
 0dg51HuQbpb6Y5sI3jGYPojBU0yi97OvY1ES+7s3wHMXhiVTADU7URzl4lplAfusSne3YhOqn
 /y2nafbpgkiyO6ITGyXyQGvg7p1IRIvkE5AkSlGnDLcoidhGzTFlMhRfQ4KnYACXwxcbQQvyL
 2wZCcGcX3K/lEpoxCZeROqIgdT0q2KbyewA7+3sUhY5PGdSitiUX+EFjzkE0W/KWdWRMwuiiI
 gTBg10yaNJcyZ+PijnEVpND7yb/LhNiX1xxZ0wWV0gMUUfegCHnS3pnhgdHmvZ14NaPGpYw97
 wcqwJxsyexLzEjxfj5AyA3DPJ74QfGusHYjJVFtj5tpEZ1cSvFsppy1SF1GWPlj+erOwkULpB
 hxjTDVjIhhxmhb8YgK46Ski4Ug1dHd2uvDqC1YBYVIPipB3AX6x5Uo3nBuMc+4dqfiLlrd7SE
 JIxDHjKJ2h5SKU/5Q7VEBJMp9SM6q1TrGVOdmO4Oz0TZGMnm0lFH0VXAiaeXIv8Py/+n6KETN
 3uEgfQuU8tNqSeuboNy4JFI1NnfCnh72b7Xi9UAOATgvjbrmqeq3yiAkjs5e/M7g6TycqI17i
 nd+wSrUbwLpS/iJtDlPrp/sFY5l9KqEQUCddToUDbGzYAOPAJ8hE8OuCifkOSFeZgVK9SueCq
 Y/rHrAIsHA9ONch1ppLZDZ3WAQC1PrisiE5IWZIg/oQpfzmBw0zUIbaAaxhD+lNveWDjw==

After over a year of reverse engineering, i am finally ready to
introduce support for WMI-ACPI marshalling inside the WMI driver core.
Since the resulting patch series is quite large, i am planning to
submit the necessary patches as three separate patch series.

This is supposed to be the first of the three patch series. Its main
purpose is to prepare the WMI driver core for the upcoming changes.
The first patch fixes an issue inside the nls utf16 to utf8 conversion
code, while the next two patches fix some minor issues inside the WMI
driver core itself. The last patch finally moves the code of the WMI
driver core into a separate repository to allow for future additions
without cluttering the main directory.

Armin Wolf (4):
  fs/nls: Fix utf16 to utf8 conversion
  platform/x86: wmi: Use correct type when populating ACPI objects
  platform/x86: wmi: Remove extern keyword from prototypes
  platform/x86: wmi: Move WMI core code into a separate directory

 Documentation/driver-api/wmi.rst           |  2 +-
 MAINTAINERS                                |  2 +-
 drivers/platform/x86/Kconfig               | 30 +------------------
 drivers/platform/x86/Makefile              |  2 +-
 drivers/platform/x86/wmi/Kconfig           | 34 ++++++++++++++++++++++
 drivers/platform/x86/wmi/Makefile          |  8 +++++
 drivers/platform/x86/{wmi.c =3D> wmi/core.c} | 34 +++++++++++++---------
 fs/nls/nls_base.c                          | 16 +++++++---
 include/linux/wmi.h                        | 15 ++++------
 9 files changed, 84 insertions(+), 59 deletions(-)
 create mode 100644 drivers/platform/x86/wmi/Kconfig
 create mode 100644 drivers/platform/x86/wmi/Makefile
 rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (98%)

=2D-=20
2.39.5


