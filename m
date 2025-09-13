Return-Path: <linux-fsdevel+bounces-61205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318BB55FA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 10:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738D11C27E7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBADB2EA726;
	Sat, 13 Sep 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="v8IwRRRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022128.outbound.protection.outlook.com [40.107.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215402E612F;
	Sat, 13 Sep 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753925; cv=fail; b=q/rqQnQ3UQ2GgMWJWmSti5QVTfR/QL10xvwLpNSgM+cU0897e5Jd/kr4K4S7YYeYHF9CR11Qw8hQZ0vRFNoPiXIde2xBuIb4crU4tC7epUl4zcAx6LOSbyC9GNbY31xRkeuY7A0mwhATUf/REs0GB4I4VSLn1ESBw173RAQiJRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753925; c=relaxed/simple;
	bh=2dfdAhExD64i0DbF+CwkX379VUlZaZ5kAHQMSZbWJEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n4/+DckfcPg2hkpaqLvArnwrXjDcBuk6Hcy13ktERkjnISnzmB4LU3G/vb6BPFoMhbqqVCWc1OVaE7b0dP6Zd4ghqhIrl7ecZbA9GYsEjqb7H6LzjQIjQog4pxgS1r1sPueC0F8sfOwFInEGPWhz4+mBs3uQSM812c4AK4ngG0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=v8IwRRRa; arc=fail smtp.client-ip=40.107.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unz+GwaXOMrNJfVpWglQMAY7rUGvAoKFKdr/1pQdisZ/jopx7kW5c0jmC/f0mfsnqffKbvgYyoZx2xzBYx5PlSzcrFP7wCB+bcX5hpjKyH7fS5DCcq51N1viklREFSjKgc41CGDVVp+i9oXvpAVMc5XkcHqTdSSveM4zdUSl4DkefG2KOU00fEfQlUPF+mJ/ZlGTSkz0kbReSAcwGmOoZqzaDkJm8CHlpM4jprDljUZ/unOB/JMkv5me3XTIaaSiAkcDOAkKAI/wlQRnnmYViZ7kZYBcoxjQZktkmC/nmbEmYERuZg3SpLrQ814PunDbFJgKzvX7rZ+sTQqT7GdnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dfdAhExD64i0DbF+CwkX379VUlZaZ5kAHQMSZbWJEs=;
 b=KbaqekWDPaCJG9KV809dHKZBfnLPY9OSDJuYyaK974T2ne4va4LvM7Uz4ymIgUmFhnloRRd+3iyw0tVuVqez2ii7hhRBNMMiJWUYB7cyINfY0XNQKNK+pj/Fg46Fm7qY9ShdRbQh+rof6r7aZiwumBiXNJ6a5eFLTQMI3c7AFwZnp58Ys2u40D+mUXuqfpfUq+x7yhIRa+/gKNXWrCttlT7AukQauylFIqEvCMmP8FkdOwlPETFkxgnETDgXXOXxBTS5zN6qOZJQ7i3+l/HaKV2rx/KqeuxAP12b4myzGCvr9FCNKfdQby3gmXf0g6bbk5mj9ULN8eUAizGVZmRmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dfdAhExD64i0DbF+CwkX379VUlZaZ5kAHQMSZbWJEs=;
 b=v8IwRRRaz0Swv/eDkePsNK1OqI2n1FnfYfnm4YrzUdW72wwYRuxeTzHIafEIgwLqMB7NfO/tYlolVtZonhoO5SHJNOGqwvLqDtd5Xjk895zqUT6Gc6dSulH0tgWEvLgvRN+EREbgvz66S/Y244n0/D7FsC5lAsbFoNTFcTH67xTY4QFt4l2onrYU9sPGbnfNhlFq5ztU+7cN0GJ4aE3TjEY1i5aH+fkfUxqUlXWz+EEZ5dmNL9wum/z1xlpgavQy31R0V/cNuEnNuYKuNa1XSki+29qHrmSK5cu1AglZeqiSHNT7iwepL+Twr2YPKgfKqcl0Af7XkvBiWqbPpMcj+g==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 BE1PPF5475DB85A.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::644) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Sat, 13 Sep 2025 08:58:34 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%7]) with mapi id 15.20.9115.018; Sat, 13 Sep 2025
 08:58:34 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "tytso@mit.edu" <tytso@mit.edu>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "rob@landley.net" <rob@landley.net>,
	"linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
	"mzxreary@0pointer.de" <mzxreary@0pointer.de>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "cyphar@cyphar.com" <cyphar@cyphar.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, "monstr@monstr.eu" <monstr@monstr.eu>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "graf@amazon.com"
	<graf@amazon.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"email2tema@gmail.com" <email2tema@gmail.com>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "ecurtin@redhat.com" <ecurtin@redhat.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>, "linux-alpha@vger.kernel.org"
	<linux-alpha@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Thread-Topic: [PATCH RESEND 00/62] initrd: remove classic initrd support
Thread-Index: AQHcJEeT2Mpw/pxzFEi5dQsRFemUDLSQ0JwA
Date: Sat, 13 Sep 2025 08:58:34 +0000
Message-ID:
 <1f9aee6090716db537e9911685904786b030111f.camel@cyberus-technology.de>
References: <20250913003842.41944-1-safinaskar@gmail.com>
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|BE1PPF5475DB85A:EE_
x-ms-office365-filtering-correlation-id: 90a42005-8cbb-461a-a583-08ddf2a3b8a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEtqeWxscitYa1RhT3VCWlcwU2ZkaFpyT1prcXR2cmlhd1QwVnFDZUJoZDN3?=
 =?utf-8?B?OWh3QmZSY0xTekozdXpuVjhrdmZTcWl0bVFYOUt2NWxPY2hpakJrM1U1bE9i?=
 =?utf-8?B?YkMxUENDWDJpaitMMFRoU2Jpc2U4bGFNTHM3STVBc3BDNTQ1VnJRYmIwb1RP?=
 =?utf-8?B?UmZqWUt1SmVrbFBFZDhHWm40SEE0VEdoUCtRQ3BhdVNSV3VCNWFGRGNpR1c0?=
 =?utf-8?B?d204Sk4yREN1UWNEaUJlMVRlVXgwQ0YvSzVTbnM1TEtmNzBsNEthZjRzZFd3?=
 =?utf-8?B?R1lIaWpjdXFUOU9sWFpKb01OaEJ0eWpMcDJLZXlBdVNVSjJuVUF5cUxmOGtv?=
 =?utf-8?B?U0EzTkpFZDhkOExGRk1KdWFUamFBYUt4WDZvTEc5VXNqUVlXOTdiV3kraHFx?=
 =?utf-8?B?bGd4Rjg2dVBCbU5QeUNIU0JqcjJOYks1djMxV2JJYVY1MGxHZFliMFlEVk5Q?=
 =?utf-8?B?eHNFMWw5ekZUSkZTMzF3aGZFOU04SGw4NXBkS0FoMk5yZWIyVys1SnpnOVIw?=
 =?utf-8?B?SmV2cGZEeTVEYnRBZnBWbFlVVS9DZE1hWi84dVdQR0g4ZzZzaWtQME1NL2sy?=
 =?utf-8?B?YjRHc3NVTWN6NEs1KzhZaGZWcDQrR3dhOW8xZVVndTkyWmtZY202S3RIODJt?=
 =?utf-8?B?M0tQcjZoSXdrNkxUNFhrR0w0cDY0Zm10NkVoeG9QMHdYakUxQWZuek91czJG?=
 =?utf-8?B?N20vOVBDWDV5ZDYvYjl4VzFTOUNmMExaTjhHczJBekZua284bEl1QnlkVDFi?=
 =?utf-8?B?a0dMUnhNb0x4S1kxbUFKQmlBaHBwQmNuM3B3T2Z3THRIZXh5NjlwdkZmeFhT?=
 =?utf-8?B?dlpGQWhmS1ZXVkhYQUJMd0hjNmlQaHJYSWJ5U0l2b2hYaUk4RGlQUDNYRHNs?=
 =?utf-8?B?WC9uMlB0bk90dVB1UlBNMGhFNzh1WXMxbjVXU1FLWm5qTHBkYW94aVlrV2dQ?=
 =?utf-8?B?TEQvLzJRNTdlOGRsUEhOZlNhczB6R3JzRWM2NW1lOWduc0o2UFJURGNJeVg1?=
 =?utf-8?B?OTgrMWpXUjZvQ0ZGYVU4VEVYeDJ2dGZ4TncvVDNtbFhQaTNGLzhlZjRzbHlm?=
 =?utf-8?B?VkRsZnQvOUZiVEJ0clgzeExxMnpSZUMwUC9PTERTQXBxOXMzKzlNUUhZRGxL?=
 =?utf-8?B?am5NeUFNeFB3R3YybGtTcjhVeDNpQ2QzV3cwMkQvNk5vTFR2V0FoMDJwQjRG?=
 =?utf-8?B?VlJ4ZVBvaFA3ZkJPM3FLSzRoZE5MbEZKcW16R1kzTGtMaDhXQ2RjcElXRW5S?=
 =?utf-8?B?cGpBSllRSEFhTURpRE5GUm5yZ3V3bThsWXF5YnB5WVdRaFlmYXYvdWM2UDBx?=
 =?utf-8?B?VXNZVEpjRWczSEE2UUR4Z282aTh0aldwOE5rZDc1ano1MFBUZXRiOUxacUNJ?=
 =?utf-8?B?Q0xpQmRlWnRPV2NlRFBheWRJVWNIWXhlQmZSN1lRYUVlWUloNWxmQlBjaSt1?=
 =?utf-8?B?eHFVdGFleTE1bUo1dzA1MXhHcFhIa1E1cWo5aHNXV1RBc2laTll4UXAwYUMw?=
 =?utf-8?B?VGlUT3cyTVdJWUZPcXAyMnQzcnFFWUlHYXlTNWdUZW1uM1NJOTNiUUNzeTRJ?=
 =?utf-8?B?V3BLWkhiTnJVV1pxQXdFQ3A2VC94b2t4dW5Hazh2blE5QWphSHZ0TlFJUVcw?=
 =?utf-8?B?dGt3YTRCK3d2V3o4eHhlYWtFWTZZZUx1NlFQRnNVUEFaOWZZY25pTmdKUXEw?=
 =?utf-8?B?TUlpRkZIb0Rza1ZJTVZMck5BeStNT1dNSGZpbkVpK1FSUkRkL2t0RzlaMzhK?=
 =?utf-8?B?Z3VzVDZJT1UwamJQUzdUc3l0SnFRVVVqd3ZYeTRsQVBkbnJhVGIxbmRLMmJG?=
 =?utf-8?B?M1pBTHNvR2pyUVZZYlFVUnBYRXg2Q2tOU0IyUFJEbjZ5OEc1dS9JQnpvSm0z?=
 =?utf-8?B?RUxBanpRUFBBZ2xnWU4xUlRkVlNIR1BUR0g3S1JSUUh3NWtpbjV1T1JHU0dv?=
 =?utf-8?B?b0hCVTNpVlR3STNGMkhhZ0ZVaXo5QVE2Z0UySnpLNTNxOWZnK0I3UExPODdH?=
 =?utf-8?B?MGpzdWppYUpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzUzRlFmTWxKQXpCMDZHbVR2NGJoT0g2NzNlUEx4OGRkWTJ2OFFaUHFKTS9X?=
 =?utf-8?B?SElIZ2o0TzkxSFlFUnlkY0VzeEk5cnVEYWZvZzQyblpFaXZlejArUDZ4N1F0?=
 =?utf-8?B?NlNsUnJiMy9Xd2Z3aTVLbGJjVFU5VG0xVTlRVXh6UFFGZFVVb29pZ2Y1bFRx?=
 =?utf-8?B?OVd4L1BsWktDRXliazkwVHpLRzhSZ0gvcURYbjE3UUE1R0hQSVFYdkcvTnl0?=
 =?utf-8?B?UjUzOUdibTdsNGlVcnJHdjU5eklTRU5jTG9HSFN1Q294R09DbXVUTjFLRmh3?=
 =?utf-8?B?T2NhQXZPbm5PQTlJQWRISlA3NmhhK1NGOU1HbVRLOFRma2tJWHVuQzczVVNI?=
 =?utf-8?B?MXJVcC9NbDdnVXV6cTFvSi9sMzhOQmFxV0pMZGsybFdqRnFYZXdPQVU1YzBo?=
 =?utf-8?B?UlpMa24ra1NsQ3d1SGxvZHIzc3NYekhQNDdQZG1BQ1ZPRHJ4SHozWEE0TGFp?=
 =?utf-8?B?em9Kb01PdlNwWmV4OW5qQVlwb2o4cVZyVEdGVXBLRmJzWWtUb1I4ekd6bWlY?=
 =?utf-8?B?UlozenNjdGZ0bU5vMVJYNDlSK1dKcFB1M1JnYjM3SU5tUDJMZ1lSTkVFZTlu?=
 =?utf-8?B?YlRya3pjUEFFTXJKT2htR25GMlZmVlM2eElzdDlYU2pWTWtTcEFieEFPTm1s?=
 =?utf-8?B?Z0txRnJtMUt1UkxObGZHTWphWnVGN2FmcitHczdpSjRURGdlakdpVU43dTZH?=
 =?utf-8?B?RGlHTG1pY1hqV0dXeWhIblhrMkNsSlFIQmx0aU9yeThjQWRuLzRFUVhjMzVR?=
 =?utf-8?B?dE9WMGNaZk9qaE84SlBKWXUwVkFKd2lPaU15UG1Gcktad1p1b3BrVHRmbU1S?=
 =?utf-8?B?d21nZy9vSHlTS2ZWNk80QVg3VmFDVmRXWm0rNW5Ja0FpL0hLTngxbmV3TUFZ?=
 =?utf-8?B?dXZqWEt1ODFoNW1WKzZoSHdsOGtMWVJzYURCWEFET2RKVHNEOVVNK2c1cm9I?=
 =?utf-8?B?QXZaQVNDSGx0VnJCclJGSDU5S1Y3M25DNENuaDVOeTJ1WTQ4bG9NQnpoeHc4?=
 =?utf-8?B?T2tBQmZzcjU5K0M3UUFmRk04WkN4TUxZcGFPQThBaFdmSHlBRFo0Wi9abXhJ?=
 =?utf-8?B?QUQydlRQYTNGRlRDdnovTGZvQUUyTXc2anlpRG91akpuUlJnSy9MbTZIUzNq?=
 =?utf-8?B?K0hQWEtUUkQ3TW9ycW5iOWM4a2xQY0QzekFRd3lLNG01OXFCTmRoZmxBL0lP?=
 =?utf-8?B?VXFwWXJ4TlBXRkoyUHlLc2pRQ2Z3VUVKZTc1TWt0VTZmaXh2Z3JlSHVzOXNr?=
 =?utf-8?B?U3JPVFZKMkpNZkt6RGlsdVJVRWFDbHhVczVjRzlyQTZmWTFGbG5VNlRCV0du?=
 =?utf-8?B?REZWNnFrYkI0a2hFZGNLSkFLY1lSNVhLSFl4aXQ3dUhiOUkyeHpYa0FIU281?=
 =?utf-8?B?VUdKS3Zha1U1dENFMVNhbEJ1cjFOMFIvTDQ1RVJsYTRQK1Q0SGg3eHJLcUpS?=
 =?utf-8?B?ektYSTJLQ3RnVy9wMFlWK291QWt3V2U5WG1jMFlWR3ZicmtjVzB3eGU3QTBh?=
 =?utf-8?B?SnduQzhIRnRsVE02cHZjZ3JXc3JCSDF6NWdVSWZ6bkluRXFMN3VxTytnZXBv?=
 =?utf-8?B?am5Qc3JTeFRhN0tKQm83T3BsckljR1hYc2hiLzJ1c3NMT3hONjRFdkFXSmN0?=
 =?utf-8?B?TFZ4LzEybUt6bm1wWWI0RFdiMlMyUXZtRktTUjFsQzNFbzdqbXNQNENJcTBK?=
 =?utf-8?B?VHduZ0JUSmJNZ2R6QXprN3lOVnFxOWVObVZtSEU2MmhxVGl0NlRGL2ZtU29k?=
 =?utf-8?B?S3BqTm1UQnVjYUI4OExTMWI5N1o1V1AxZXNtaU9hRWo3aWdXNDdpS28zVGdr?=
 =?utf-8?B?bzFydjFrTUFvU3grejVBY3VVZkhuWVN0QkVYQlpaelRKaGlwNEJ5ZG1ocURi?=
 =?utf-8?B?U3NwMjhoeEgybkxLYWtGWTU4eXJqV25mUVE4eHUyQStnRWxwVlNYdEh5Y3l1?=
 =?utf-8?B?TmExc2lnM2xXYjBtRlVxSHFXT2dwYXNVMklCbGtZQnc1eWQ4c2NBaGY2TE5H?=
 =?utf-8?B?SmZrL3Y4cVB3aG5Kd01ybEZJNk5ENHAzNUl6UGVzZ1VEMXFnaEgwQUJMcmdO?=
 =?utf-8?B?K1VyNnNKaUN6YmMzYkFpOWVkVUdzWXVmdWdUUWRpaFBHYWtvOTBJSUdaMi9Z?=
 =?utf-8?B?QnFRL0xQQXUvZUEzYkdVTEhXa2JpUE1lS1JoUWNRVVlUU2haYndiMjVDbjZ6?=
 =?utf-8?Q?nTUtMQqogJuNvRWJU3SGGumdm6VWCjbZO0z4EjSXdgSR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE82B6496E16714F9F4AF9BA1CEEFB91@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a42005-8cbb-461a-a583-08ddf2a3b8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 08:58:34.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TApQElCG/9VYp7xZZBuNrg6KUgdNp8YPpXIs6shYbTWilwooEJ2zXSgpXo2d5f4wqv0KdbBJx8BSvGGknZaQeD0gAkKNGSj0Mk9sP2QQQUGYu3WbaY8lw8J1sUs89vpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF5475DB85A

T24gU2F0LCAyMDI1LTA5LTEzIGF0IDAwOjM3ICswMDAwLCBBc2thciBTYWZpbiB3cm90ZToNCj4g
SW50cm8NCj4gPT09PQ0KPiBUaGlzIHBhdGNoc2V0IHJlbW92ZXMgY2xhc3NpYyBpbml0cmQgKGlu
aXRpYWwgUkFNIGRpc2spIHN1cHBvcnQsDQo+IHdoaWNoIHdhcyBkZXByZWNhdGVkIGluIDIwMjAu
DQo+IEluaXRyYW1mcyBzdGlsbCBzdGF5cywgYW5kIFJBTSBkaXNrIGl0c2VsZiAoYnJkKSBzdGls
bCBzdGF5cywgdG9vLg0KPiBpbml0L2RvX21vdW50cyogYW5kIGluaXQvKmluaXRyYW1mcyogYXJl
IGxpc3RlZCBpbiBWRlMgZW50cnkgaW4NCj4gTUFJTlRBSU5FUlMsIHNvIEkgdGhpbmsgdGhpcyBw
YXRjaHNldCBzaG91bGQgZ28gdGhyb3VnaCBWRlMgdHJlZS4NCj4gVGhpcyBwYXRjaHNldCB0b3Vj
aHMgZXZlcnkgc3ViZGlyZWN0b3J5IGluIGFyY2gvLCBzbyBJIHRlc3RlZCBpdA0KPiBvbiA4ICgh
ISEpIGFyY2hzIGluIFFlbXUgKHNlZSBkZXRhaWxzIGJlbG93KS4NCj4gV2FybmluZzogdGhpcyBw
YXRjaHNldCByZW5hbWVzIENPTkZJR19CTEtfREVWX0lOSVRSRCAoISEhKSB0byBDT05GSUdfSU5J
VFJBTUZTDQo+IGFuZCBDT05GSUdfUkRfKiB0byBDT05GSUdfSU5JVFJBTUZTX0RFQ09NUFJFU1Nf
KiAoZm9yIGV4YW1wbGUsDQo+IENPTkZJR19SRF9HWklQIHRvIENPTkZJR19JTklUUkFNRlNfREVD
T01QUkVTU19HWklQKS4NCj4gSWYgeW91IHN0aWxsIHVzZSBpbml0cmQsIHNlZSBiZWxvdyBmb3Ig
d29ya2Fyb3VuZC4NCj4gDQoNCkFzIHRoZSBwZXJzb24gd2hvIGtpY2tlZCB0aGlzIG9mZiBieSB0
cnlpbmcgdG8gZ2V0IGVyb2ZzIHN1cHBvcnQgZm9yIGluaXRyZHM6DQpZb3UgaGF2ZSBhbGwgbXkg
c3VwcG9ydCBmb3IgbnVraW5nIHNvIG11Y2ggbGVnYWN5IGNvZGUhIEknbSBhbGwgZm9yIHJlbW92
aW5nDQpoaXN0b3JpY2FsIGJhZ2dhZ2UgZXZlbiBpZiBpdCBjb21lcyB3aXRoIHNsaWdodCBpbmNv
bnZlbmllbmNlcyBmb3IgZnJpbmdlDQp1c2VjYXNlIHVzZXJzIChtZSEpLg0KDQpJZiB0aGlzIHNl
cmllcyBnb2VzIHRocm91Z2gsIEknbGwgZHJpbmsgYSBiZWVyIHRvIHlvdSENCg0KQWNrZWQtYnk6
IEp1bGlhbiBTdGVja2xpbmEgPGp1bGlhbi5zdGVja2xpbmFAY3liZXJ1cy10ZWNobm9sb2d5LmRl
Pg0KDQo+IA0KPiBBbHNvIEkgcmVuYW1lZCBDT05GSUdfQkxLX0RFVl9JTklUUkQgKHdoaWNoIGJl
Y2FtZSB0b3RhbCBtaXNub21lcikNCj4gdG8gQ09ORklHX0lOSVRSQU1GUy4gQW5kIENPTkZJR19S
RF8qIHRvIENPTkZJR19JTklUUkFNRlNfREVDT01QUkVTU18qLg0KPiBUaGlzIHdpbGwgYnJlYWsg
YWxsIGNvbmZpZ3Mgb3V0IHRoZXJlICh1cGRhdGUgeW91ciBjb25maWdzISkuDQoNClRoaXMgaXMg
YmVhdXRpZnVsLiBUaGUgb3JpZ2luYWwgbmFtZXMgd2VyZSBwcmV0dHkgbWlzbGVhZGluZyENCg0K
PiBXb3JrYXJvdW5kDQo+ID09PT0NCj4gSWYgInJldGFpbl9pbml0cmQiIGlzIHBhc3NlZCB0byBr
ZXJuZWwsIHRoZW4gaW5pdHJhbWZzL2luaXRyZCwNCj4gcGFzc2VkIGJ5IGJvb3Rsb2FkZXIsIGlz
IHJldGFpbmVkIGFuZCBiZWNvbWVzIGF2YWlsYWJsZSBhZnRlciBib290DQo+IGFzIHJlYWQtb25s
eSBtYWdpYyBmaWxlIC9zeXMvZmlybXdhcmUvaW5pdHJkIFszXS4NCg0KVGhpcyBpcyBwcmV0dHkg
bmVhdCwgYmVjYXVzZSBub3cgeW91IGNhbiB1c2UgX2FsbCBmaWxlc3lzdGVtc18gYXMgaW5pdHJk
cy4gOi1EDQpUaGlzIHNvbHZlcyBteSBvcmlnaW5hbCBwcm9ibGVtLCBhbGJlaXQgd2l0aCBhIHRp
bnkgc2hpbSBpbml0cmFtZnMuIE5pY2UhDQoNCg0KSnVsaWFuDQo=

