Return-Path: <linux-fsdevel+bounces-16749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97478A203E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806CF2836C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90D24A04;
	Thu, 11 Apr 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="eaeAzjUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D71CF96;
	Thu, 11 Apr 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867497; cv=none; b=EikUbFsr8aNICVxDq6yKFytN1S6CmspJZj88xD4Onxrw87fF7KUaV8GT8I4Axfc2CPMfkwFjbBvxBzB0sdNe8VnVTAK6Ubx1lhXFlRyDISXzjf6+qOxHotw6Zzq2jmS4C+d40TosVwp7WghnJJkce8nW+LzqxCGnehJR049r5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867497; c=relaxed/simple;
	bh=ILT+HgeRwqkDmSdCPI/rfnhIwt+GtfTZs2Zig2y3DLI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rN2hNkk0BYDs6VxXmPaM51BqJDE1tZPGhDxvl9cJsXebAmFJjbPE3pty9YHC3vpleEAmPxFnMfwe7uRaT+CpCt9bzFUbPKX9V5T+PzEmRq1b803aLE4OQTJBcCv3POPGKYFshjuppJvGY6Ur69be3ELTAul2RIwLygt2s7flh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=eaeAzjUc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712867486; x=1713472286; i=spasswolf@web.de;
	bh=ILT+HgeRwqkDmSdCPI/rfnhIwt+GtfTZs2Zig2y3DLI=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
	b=eaeAzjUcm5lMRaUjiUY42Lacytr2pnMuohbFlO50aOunop3MCTRXJp+fy+EnDkPB
	 1j2YRXwIU5YAyMyWR3MSht8GDNCxJrvSiOYiuCaesLYRCGsAi2Ukn4OINd4JbPqK1
	 8S/SXfIuKj2DT01XPZEuNGHGl6GvujKTUlXSsezCkoU+li9SY/XZ44InNhlLHqVv0
	 jQ/wAiylbpClrVMYjaeCkj0MLCP+sVM3I9jQMPsvRwHT13QZvWPsl5r2f+8HWmXfm
	 Y2hR8Be1cpN1tzMxV6zoS7OdX/PbRdCNvdkXMQ4mtUXBRyzGMtVJZwMi3l0YeN4ys
	 sRz7Y1drdooQpKTSTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1sAc9X1HGj-00TE4W; Thu, 11
 Apr 2024 22:31:26 +0200
Message-ID: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
Subject: commit e57bf9cda9cd ("timerfd: convert to ->read_iter()") breaks
 booting on debian stable (bookworm, 12.5)
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	spasswolf@web.de
Date: Thu, 11 Apr 2024 22:31:25 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ihIn3l3CEueHHdqDk6cXIXZa6KdgzydflKCmXZgA+RynikgGaC/
 SJgEg9PaOp7nAOpOi9cX3FqufKfU5bGHrIx0AkyPsOHlaQuac6U9bnGTjgKHLd+CD5TBZwf
 /x1p2drYkOQ++WF/DuzdTAB9W1/e/CIHKfp+CzpW6ZbT5zZrrW6vJTg8NvmRhIDkpfyImc4
 1YBi/a+fnXM75ZVf43EbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xVA5SrpXPQo=;T9JPRjnM/KeOpavqXPctiHbiiMr
 Wh3nvRWaBOXVWrptTQQiopGLzNXvWeSGImiVLySXQyB1cwJcLvLfHoFdkGStEAdZBXYBwN7iT
 wgq+PHAK3iCA8uK7eoiOyJqAtfmljaLWDVVa+J0Pv/NMZpKqC59hY7X++paXJdYZj3VyY/7Ex
 4hrEAgaC/fUu902ncFhhLrrfm3Ldbm4CktVhReXP/hg4OaWNnVyXyMzQUrvfPzvJosn/aWhxz
 UVphYctO8WQKLeHuDfRFBQwerDe13Bzu6G4QneYj1hKyV46orHrD2Sepf/Nqugv0YTwTjijcY
 oNSt75x7SQtYPP/h1PZIhrTv7fY9biOxyYPily8rGTHf342gj1F51fXwTO0/n0U5CAc8r7Wv/
 EdpjkoQgHFekErpmfYJTMcvLD8UiLd93m5jcOfHY4e3jIlryj7JUyLKt6KC+0DDtonao09Z5W
 0UWxr37lE9RKc8v5uu5sbnxUIu9ypveaXzQO3tHd7cV6Il+nUjqgEKdzT2ccRNNjZiDTM4Qci
 bQsZTKoKdZP8zWvJDepgqFulZ0XtpYI84NJV5a7MVZv/kIr6nDn/RRBPyX9CmOuo2bhi72nL9
 BtVPCSEo+06TsrNGk/Z9Z5e4zw6fSWJU6az3O/EusGYEq00RDpT+blKa4gJQYEVdY3pU1VAbl
 auEXaGFGqgyglYqLkX5xtzJ/1iGaGSKILNJfDQDHckM/KP3ig9JwAI8zDJBdmPe47NtZYIMXk
 WBVHe/AWkHzHn6Hpm4fB4iooo7abm0KCSSCZc5VXg0pdNJSCDv0+SkpGqxRmwWpSodzcKIrre
 T3a3h1gchmAwi+A7BcaLTCEEHJOtVDktUywOdBYYjTYpk=

Since linux-next-20240411 the booting process on debian stable hangs during the
init messages. I bisected this to commit e57bf9cda9cd, and reverting this commit
in linux-next-20240411 fixes the issue. I'm running debian stable (amd64) on an
MSI Alpha 15 laptop with 64G ram and the following hardware:

$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root
Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host
Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host
Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP
Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP
Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP
Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP
Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host
Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP
Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstream
Port of PCI Express Switch (rev c3)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream
Port of PCI Express Switch
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP
Audio Controller
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411
PCI Express Gigabit Ethernet Controller (rev 15)
06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc.
KC3000/FURY Renegade NVMe SSD E18 (rev 01)
07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe PCIe
SSD (rev 03)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High
Definition Audio Controller
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB
3.1
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB
3.1
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio
Controller
08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] Sensor
Fusion Hub

Bert Karwatzki



