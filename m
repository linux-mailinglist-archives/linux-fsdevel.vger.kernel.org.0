Return-Path: <linux-fsdevel+bounces-27135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8F95EE60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C341C20F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02D1474CF;
	Mon, 26 Aug 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="RrMgK0S7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C61474A4;
	Mon, 26 Aug 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667621; cv=fail; b=FaT4ZWmEyq+3dtouMptErOKPSyrmDpTDM0/KXAjARh8aHpfYp69n4PspauG+5j6OOIsSlSKm37EWjlzLJ7vGEsV4enNQfx0T3ufX/U7fwDdQVzguKshdsJboVbTM8qCkyYVdY7DO+sVLUXPBogeG2edk02Bk1dhlZIS6OSqYUTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667621; c=relaxed/simple;
	bh=3Tna26ZccLfUvCYxp+sfDlwKOyq+u8MtiZVmD5zYLIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uotiz5JkkIEsbGfPOPtNLTi5uhKud2UfTFOEsgnp31G7mNh5AfK3Jp7Nv+JpEmOXKqjCAmrbJR792DHY/FhXmU1/2vj2mqKfCcDTUP04Od3rrh3YXGSv+XMrC1NExDtt18OvIXse1GJmf+rNh6oY6E4yDugbhEHbz2+M1YYjsBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=RrMgK0S7; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIplc9B17HCVVLtTQchk6FZ62WdtKXLliHPv0UsENyGmdPfgjNcluu94JVelmJuQrconhE+RzQR2dj46tl75YoTefd4EkapIwQDfQm4ofK6PQ2Y+dMQIrHYJHxQXoKZd7VGec4qMHB9S/hOvDDKt6Us2TVsYgcr8+plHae1HBl1YnAV1OAXhlmQEjp5nJB1RY5YUGrVHPE4MYt90BiBe0aZOEsGkuSy6z5Pw2A1sEtcQhoVLxOgVeX34RfNOEPlUmimQf9L+V1P5Gn+QHPew0WgwjmjlZ+BD2JlYULkYXO3Z2afDNAM2u7IaIT8jO8/PAFbDZru39dvsW1g1FMYK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tna26ZccLfUvCYxp+sfDlwKOyq+u8MtiZVmD5zYLIQ=;
 b=VPeRs1b2BeqCY33HGpfpeWLkcQKQS57LPw2bkUPcaVzVX21NvPATAGV5LaudAo7nkcQlJLoLLSD6psi2u94KReB1/QOUAlckT6rH0jsqO8BCBMcCGHH1amUoIZeS2NLqTDE94M/mZE6k7L8HinDUbhtZpx5+4xE9izZKYVO3yIroOe7SiiaDzQouZIwwxZj1BThTAnIgdnEgyM4fiiJbn+Jj+2FK+cfkGbcM1lbtP44595OiXrNysfGQ+o2bEUPH36yanB7jkabBeXk/6zMBeGncGFK3pNSnSgKnU5stqr3+pcvYRw0iKLI7qPG8kHemU1KOhSBeEngRjwfHBmGPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tna26ZccLfUvCYxp+sfDlwKOyq+u8MtiZVmD5zYLIQ=;
 b=RrMgK0S7ITS3Go50G9rQ+MBO0BO4ozd+G0LAPsiQRcdEUwp7S9WCjeZC+x+bsZ06MGz9LFgUsOoIPUeo/JeIMfDMwy6LI1Ed3o9osPFLufhS5BtmIO7P4NyLV56rOjEOmc4VFjShrqosCqN6FrTsBg9GbO7QWxdS7uHTbnK2FJmFO+AeoGmlGh0GpU7lRc3spbt+6isZ/knLJCdmGg2LltY69DFMsF5LYvYWDqezNwHerG2sKEdeD7KWzN+Jjjhp5jmyRSxL02umLEfWrc/FMmydnnUaZANx9EI0VA7WnGY3BcJd6Win3FR7Z7oAttWD/Aj2MZcF3WhyAVpWXvVQPQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 10:20:15 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 10:20:09 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o
	<tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
	<akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned
 long
Thread-Topic: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned
 long
Thread-Index: AQHa9GLNdttrxQ5DCUuAFZJBLy2M47I5MGuAgAAfrziAAAotAA==
Date: Mon, 26 Aug 2024 10:20:09 +0000
Message-ID: <ce5eba04-77a6-4a64-aec9-64196cdf64fc@cs-soprasteria.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswzu1l3xO99KN3I@zx2c4.com>
 <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu> <87v7znd3g4.ffs@tglx>
In-Reply-To: <87v7znd3g4.ffs@tglx>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: fb34f613-ec0b-49e6-fd19-08dcc5b8a9c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlRnZHNiaEN6VDdnUnNpNWhBVE0zaGxJUzZGSSt6eDRMNjV6b0I2K3hGUWhi?=
 =?utf-8?B?Z1ZkdVVuMXpFZW0wS251T25YdTVpcWNGNDlZL044Zk1IUFl6dWk3QS81Q3hF?=
 =?utf-8?B?QlE1ZzBqSGloSlFnZFV1ZGlXUmxnV21kV2JQbWh3R2RYYnlJNGdBajJxa1lO?=
 =?utf-8?B?MnBpYisyZG5HS0ZMbGZXek5rSi9UcWgvdU1VN1dTL2h1TmpXdFkxQXJ1ZklU?=
 =?utf-8?B?ZW1OYU9OWDMyKzlHWmx4dlhUZ3hZM2pjbjNxb3BNMnBUaVY5emVySUw5Kzlm?=
 =?utf-8?B?U2g4NUZFQUF4elBVMHE3MjJaa2JhaTNvakcwc1BOMHYzVHZRT1YxVm0rb3lk?=
 =?utf-8?B?ME5MQ04zcTFXUzZmVngvQzYyVWEyL28rTkJFci9JeGhyZkY1eVU0YjFzSHlV?=
 =?utf-8?B?U1ZyQXNNQ1BuYmVxdW4rY0NjMXhrTTdwcXhVYmoxeVUwVDliSWVDTGkwTXpW?=
 =?utf-8?B?cWF6REdZQ3JoR3k2Z1lGRUF4SitMMGgyRXBBRGJaMHZrMUNtRzRPQ2VyUjZK?=
 =?utf-8?B?eFQrRm9SY1BpajM0N2R6MFZmUmZQRW5DUWwwS3JVM2ZiRmFMM0EvaE5sMHox?=
 =?utf-8?B?a0V6NHNMT0x3WTlSckp4dXoveVRON1RNNnhOVGxBcjFMNDJNdkgwcFpGd3Vy?=
 =?utf-8?B?L1ZURDRCSUF5ZXBRYmZmMDIvejhLd2xsU0ROS3BZVDJiOHRkazhwamRLVnM0?=
 =?utf-8?B?R0t6bEtjWS9QRjlzQ2gwV2VtcHBnSEorTUlOeTZjUDRXZFRLcnoxUWx3SG95?=
 =?utf-8?B?SEtvcERiMGE2c3o2L1lRLzlFdXFaaDl6dUdXTWtLdG8xRnNMZXZFczY4aUZn?=
 =?utf-8?B?NEhEY2g1cEZ2MnRCSjNQV1ArelU2TU1DMzNKU0hOcnREeGtZVkZnMGN6TW03?=
 =?utf-8?B?TjB0SEdtQXY4MWt4YTNsaVVDOTRVcEd4SVVGdzNpdlZTOFhCR2tVQnF1cUhC?=
 =?utf-8?B?SkFDeVllcmEzSnZ4Uk5ONmhHUUVoZTdZZEhnUGh5R05YSEMwUzl2VWRaV09j?=
 =?utf-8?B?T2g5Wjcvb25xbStISXV6QnNaY1dwUFE1Q01MSUZXdHN0TmgrNjVYWCt1ZldO?=
 =?utf-8?B?cHp3ZjByYzUrdllETmdXdlhNbk1uOUJnd0JtOWE4Y0NsbWJFU2FwRGhuUERL?=
 =?utf-8?B?NEswL0NBWktYakJwRjJhSXlTcEJlSXlWbzVSMFMvSXBjclZHR2RqYytNdjBL?=
 =?utf-8?B?UjJ1NTlxbkdkV3A5eDlZamdIWktXNXJUSlFhRHNkenRMZjQyMy8rN1ArUEhO?=
 =?utf-8?B?NGRHb2hROU9JeW50UFJNTHpDYmJQT2gxOFFrVk9QWjBHV29FUU42NVdtNG1u?=
 =?utf-8?B?U2VERkNLWDFVZUNxdEI0Tld6bTVTcmpWZFRkQ0FIc24zT01ScktBK3V0cXM0?=
 =?utf-8?B?WTR3UkJLaFlrZUh2N08rQVJScFdxSXdTOHBqK215VUUwaXNtenlZVGtaYW5i?=
 =?utf-8?B?ZHVEN3p0NENVNUxMN1UvL3grNkxOUk9yaFNlSjcxMkl4eFh2Q0NabXE5U2Iz?=
 =?utf-8?B?cWdmYzdFbDJDenFwUnRnczhFL2ZVQkNtYjhjdWpCTjBIdFd2Zkxmb0RSNzRZ?=
 =?utf-8?B?M2tKdGZpNjRRV0VsVTFMZTFqZVpRbEt2MlBwN1A1ckQ5cUpSZHoxZlBDanpN?=
 =?utf-8?B?UG10SFFaSWpSL2JyYkJKMWFmNGxQN2J6ekVXc2NzcG9FZm1lWENaVk1FWk41?=
 =?utf-8?B?emNiR2ZHbExzT1pReUVOK2d5c2k1ZFg5ZXV5Z2Y4V0JXSlFVYWVBNldsbFlI?=
 =?utf-8?B?cEw4Sm1VYWxyUGo4WmoxaWpHSGllenluc05qS3VIM3BicVA4aFRMUGpmREw2?=
 =?utf-8?B?SVQxRVpjbDVNNTN5TVB2RllkclErYWM5Z0NNV3M4UHJwU1dxSTlYMCtySWd0?=
 =?utf-8?B?cXNDK3ZRei9BOTduR3p1QkJ1WHVmdWppb0ZlQWE2bWpoUGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2EyTlhiWFdkZ3o4Vm5jVWZYQWMxTXZPY2o3bzN1OWZmWERQRzhjNEhPcDNh?=
 =?utf-8?B?SnljWmNZM2ZFeVpXOXorb21vWlMrU1owSWhIRzZsVEFERFB4MkFiMExpeW9T?=
 =?utf-8?B?a2k3MVplcWxFVTUyMHNZRVBBUjZkNlZ2Vm5JWFFTbDNzKzNxRzhnSE00bVBI?=
 =?utf-8?B?SEdtZlFyYW4xTzlEdTVYeTYxR1hqSmVlSVp1dS9lc1hpRlg0L1RXcGNUd0Vv?=
 =?utf-8?B?VzVzQ3BJaDREMmRsWmh3TGY3UDl1TlVVa1JGemJMdHd6SUVwcmwwN1hyUkM3?=
 =?utf-8?B?U2d1UHBEQmN3MVpmQ3RpeDk2UFM3S1hKZ0RWQnhHK01BQXZLRnVKK2RyaXph?=
 =?utf-8?B?RzRSZWRxQU9OSmxUa1JvY3hTS3FncnNMOU1tSUxvYXN2c1hmYUdGK1JuLzBG?=
 =?utf-8?B?Nzhrb2ZJNXk4L2xISnpPTTE4ZkhVUEkwdFVCUVhOY1ZnWXh3Y0MxcVFaUFdD?=
 =?utf-8?B?QzVGcUN1Y0hiUFZEcEhsNFluU0Q2alhtNTc0M0pHc3JXdjNjK0paNUFTaHZ1?=
 =?utf-8?B?bDQxc3RKVkRlc0dUcmFiOGFadzEvak1NY1pmN3REYWx4NGtYdk5Hakt6Wk5O?=
 =?utf-8?B?TyszenFQZU4xMmFLYThWeWxxUkd4NHZBTkJCL0NaOGZENUFCRFVqdDNreGJy?=
 =?utf-8?B?R0YzcUpWMVhzMHJ4eWJpbUJhcFVab3BEWVdzT3cxMi9ZUGQ2bUt4c1pYWlFz?=
 =?utf-8?B?L2hJYjBVN01EYnpCS0s3S1FNT2ptTENYcnFKckQwRTF4Mk9XNjdLN1pxcGtk?=
 =?utf-8?B?UFFrUVowTmFRWDRDblZMbHJPUjgrNzI1WWFGOHZTTHZLZDJtZlN5UlVRNDky?=
 =?utf-8?B?aWdpdWRWUjRXc3B0V3RyOXVJSGd4ekV2QlhaV2NwT3huQ29Nbnp2MG0xUjNO?=
 =?utf-8?B?Z3lmWTJmVE83eFhkWHJ3L01pZW9BSUZYclUyazEzNmJUOXJlRFdFVktuazhF?=
 =?utf-8?B?d2xQMjRpQ0lUQVcvMVpDZzFIemhqSVZCRWE0RXZQRWppazBIVk13YStTMmor?=
 =?utf-8?B?UDZzeThHUlRCYzZVeFJIOEtudTZmRmMwK2x2UXBlYmxFbDJlTnJ2UlFWMElo?=
 =?utf-8?B?b2JYaC8yR2FnWFNwcXA4QXI1TWVzN21VeXgrVXFLVGVZVjFZZUFwa1JjNU5Y?=
 =?utf-8?B?VnhJbUdJRjRyQSsxVlV2bDVrMk1Za3MyS3lTekp4akxZdXQwZ0hyb0RyS1FE?=
 =?utf-8?B?b0pvRTBYNDA3RURnaWYzVTNJRm5QWjlYY0k1cGJSV2FiRUFIZi84UmxkeDZx?=
 =?utf-8?B?R3ZQRTd2MzUrWDJIbWxRbnVuWEhST0M0V2Z6VzVlekNHSGc1eXJFeXdhQ3kx?=
 =?utf-8?B?TVlmcDdUWmhtcGNYTE8wUHM5Q3U3MVpydHBFVVhWYk1TMEkvSkptbmtLY1Ev?=
 =?utf-8?B?bXhFRXdRUkd3MW1McG9qZXVFZXIwdHpsR3RLR1gxUHYxeGFLdzVFa2orMGtk?=
 =?utf-8?B?dFFGeG45NEp1eHBTMDh2d3dtY2ducFBlZVN6QzBTYmNTRStqamYwYnZudThX?=
 =?utf-8?B?WmhmMTYwdVhOcXBWUUhNVlZBVng1YlBtSDg1K1grdldvVzg1c0Nydk1rNjBq?=
 =?utf-8?B?L3J0UVMzRW9iN2M3OVVGNTJPNUtjandMMURmd0doZ1ZpVU1aTjVGYzFac2Jq?=
 =?utf-8?B?Nm1HdlRpck01dWZHUTh5VytLOVN3TjdhR1Q4dVd6WUlLc2pzVjQ2VVUvbU9T?=
 =?utf-8?B?cnhVUmFGNVJQMGhmK2JkUEdTZlBsUTFTWFNhWFgwNm5wekFQSUxSSXpsYTJF?=
 =?utf-8?B?TnAvbFlBMUNRcGY0RVhWS3kzT0kwUGlBVVhTdklDT1NBaTNSRGp0VTM2cGIy?=
 =?utf-8?B?MUx1UGxUeXpNOFQzc0dvcjg5alpGYnhHUWkvU1pFWFhIa1pnS2RmTXdwdHNF?=
 =?utf-8?B?NDQrYy9oNVR2NlhPVHFjWnN2NEFOdVRzV2NHVkxGTXl1aEFHNG9TWlMvdXV1?=
 =?utf-8?B?K2xXb2h1V0xKWWZEU0VZdHRCWnRXZndmTFJuMTlJTXB6ZzJveHJUSU1oZ3lU?=
 =?utf-8?B?M2hOOEwyK1JBYmhUOTJybTkwbDhvaktDYjV4QUZCK2xvOUVmZzBTa3VMRWFF?=
 =?utf-8?B?KzJaYlhPelByRSt2bUVaQVV2c2xsOUhGeVZHZ2ZzcForeFlicVFxZm4xMXhZ?=
 =?utf-8?B?Nm1LdGQwM2l0ZytMVldOdGw0WUpuN281dzc3SUU0ZjRNT20rWHlTQjF3cGRh?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E39E615E4FA34DB875F0519E4343CB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb34f613-ec0b-49e6-fd19-08dcc5b8a9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 10:20:09.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvEqkjHDkSjNvRWgSMRAQYv+G77/2PnKz/1GfLYwggAnOfZV3s1/O3nml/HS4Kebssw42ZHJmo7j82FZPklf55JlaMe0kNxkTeitzEFxc3Di8DJBuoZ0EXy8KYBlFtQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS4PR07MB8459.eurprd07.prod.outlook.com

DQoNCkxlIDI2LzA4LzIwMjQgw6AgMTE6NDMsIFRob21hcyBHbGVpeG5lciBhIMOpY3JpdMKgOg0K
PiBPbiBNb24sIEF1ZyAyNiAyMDI0IGF0IDEwOjAxLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0K
Pj4gTGUgMjYvMDgvMjAyNCDDoCAwOTo1MCwgSmFzb24gQS4gRG9uZW5mZWxkIGEgw6ljcml0wqA6
DQo+Pj4gQnV0IHRnbHggcG9pbnRlZCBvdXQgaW4gdGhhdCB0aHJlYWQgdGhhdCB0aGlzIGFjdHVh
bGx5IGlzbid0IG5lY2Vzc2FyeToNCj4+Pg0KPj4+IHwgQWxsIG9mIHRoaXMgaXMgcG9pbnRsZXNz
IGJlY2F1c2UgaWYgYSAzMi1iaXQgYXBwbGljYXRpb24gcnVucyBvbiBhDQo+Pj4gfCA2NC1iaXQg
a2VybmVsIGl0IGhhcyB0byB1c2UgdGhlIDY0LWJpdCAnZ2VuZXJhdGlvbicuIFNvIHdoeSBvbiBl
YXJ0aCBkbw0KPj4+IHwgd2UgbmVlZCBtYWdpYyBoZXJlIGZvciBhIDMyLWJpdCBrZXJuZWw/DQo+
Pj4gfA0KPj4+IHwgSnVzdCB1c2UgdTY0IGZvciBib3RoIGFuZCBzcGFyZSBhbGwgdGhpcyB2b29k
b28uIFdlJ3JlIHNlcmlvdXNseSBub3QNCj4+PiB8ICJvcHRpbWl6aW5nIiBmb3IgMzItYml0IGtl
cm5lbHMuDQo+Pj4gfA0KPj4+IHwgQWxsIHdoYXQgaGFwcGVucyBvbiBhIDMyLWJpdCBrZXJuZWwg
aXMgdGhhdCB0aGUgUk5HIHdpbGwgc3RvcmUgdGhlDQo+Pj4gfCB1bnNpZ25lZCBsb25nICgzMmJp
dCkgZ2VuZXJhdGlvbiBpbnRvIGEgNjRiaXQgdmFyaWFibGU6DQo+Pj4gfA0KPj4+IHwgCXNtcF9z
dG9yZV9yZWxlYXNlKCZfdmRzb19ybmdfZGF0YS5nZW5lcmF0aW9uLCBuZXh0X2dlbiArIDEpOw0K
Pj4+IHwNCj4+PiB8IEFzIHRoZSB1cHBlciAzMmJpdCBhcmUgYWx3YXlzIHplcm8sIHRoZXJlIGlz
IG5vIGlzc3VlIHZzLiBsb2FkIHN0b3JlDQo+Pj4gfCB0ZWFyaW5nIGF0IGFsbC4gU28gdGhlcmUg
aXMgemVybyBiZW5lZml0IGZvciB0aGlzIGFzaWRlIG9mIHNsaWdodGx5DQo+Pj4gfCAiYmV0dGVy
IiB1c2VyIHNwYWNlIGNvZGUgd2hlbiBydW5uaW5nIG9uIGEgMzItYml0IGtlcm5lbC4gV2hvIGNh
cmVzPw0KPj4+DQo+Pj4gU28gSSBqdXN0IGdvdCByaWQgb2YgaXQgYW5kIHVzZWQgYSB1NjQgYXMg
aGUgc3VnZ2VzdGVkLg0KPj4+DQo+Pj4gSG93ZXZlciwgdGhlcmUncyBhbHNvIGFuIGFkZGl0aW9u
YWwgcmVhc29uIHdoeSBpdCdzIG5vdCB3b3J0aCBjaHVybmluZw0KPj4+IGZ1cnRoZXIgb3ZlciB0
aGlzIC0gYmVjYXVzZSBWTV9EUk9QUEFCTEUgaXMgNjQtYml0IG9ubHkgKGR1ZSB0byBmbGFncyBp
bg0KPj4+IHZtYSBiaXRzKSwgbGlrZWx5IHNvIGlzIHZEU08gZ2V0cmFuZG9tKCkgZm9yIHRoZSB0
aW1lIGJlaW5nLiBTbyBJIHRoaW5rDQo+Pj4gaXQgbWFrZXMgbW9yZSBzZW5zZSB0byByZXRvb2wg
dGhpcyBzZXJpZXMgdG8gYmUgcHBjNjQsIGFuZCB0aGVuIGlmIHlvdQ0KPj4+IHJlYWxseSByZWFs
bHkgd2FudCAzMi1iaXQgYW5kIGNhbiBjb252aW5jZSBmb2xrcyBpdCBtYXR0ZXJzLCB0aGVuIGFs
bCBvZg0KPj4+IHRoZXNlIHBhcnRzIChmb3IgZXhhbXBsZSwgaGVyZSwgdGhlIGZhY3QgdGhhdCB0
aGUgc21wIGhlbHBlciBkb2Vzbid0DQo+Pj4gd2FudCB0byB0ZWFyKSBjYW4gYmUgZml4ZWQgdXAg
aW4gYSBzZXBhcmF0ZSBzZXJpZXMuDQo+Pg0KPj4gU28geWVzIEkgcmVhbGx5IHJlYWxseSB3YW50
IGl0IG9uIHBwYzMyIGJlY2F1c2UgdGhpcyBpcyB0aGUgb25seSB0eXBlIG9mDQo+PiBib2FyZHMg
SSBoYXZlIGFuZCB0aGlzIGlzIHJlYWxseSB3ZXJlIHdlIG5lZWQgZ2V0cmFuZG9tKCkgdG8gYmUN
Cj4+IG9wdGltaXNlZCwNCj4gDQo+IEZvciBub3N0YWxnaWMgcmVhc29ucz8NCg0KTm8gbm9zdGFs
Z3kgaGVyZS4gV2UgZGVsaXZlciB2b2ljZSBjb21tdW5pY2F0aW9uIHN5c3RlbXMgZm9yIGFpciB0
cmFmaWMgDQpjb250cm9sIHRoYXQgd2UgYXJlIGNvbW1pdGVkIHRvIG1haW50YWluIGZvciBhdCBs
ZWFzdCB0aGUgbmV4dCAxNSB5ZWFycy4NCg0KVGhlIE1QQyA4ODUgd2FzIG1hbnVmYWN0dXJlZCBi
eSBOWFAgdW50aWwgcmVjZW50bHkgYW5kIHdlIGhhdmUgc2V2ZXJhbCANCmh1bmRyZWRzIGluIHN0
b2NrIGluIGNhc2Ugb25lIG9mIG91ciBjdXN0b21lciBuZWVkcyB0byBleHRlbmQgYW4gDQpleGlz
dGluZyBzeXN0ZW0uDQoNClRoZSBNUEMgODMyMSBpcyBzdGlsbCBtYW51ZmFjdHVyZWQgYnkgTlhQ
IGFuZCB0aGUgYm9hcmRzIG9uIG5ldyBzeXN0ZW1zIA0Kd2UgZGVsaXZlciB1c2UgdGhhdCBDUFUu
DQoNCkJvdGggYXJlIDMyIGJpdHMgcG93ZXJwYy4NCg0KDQo+IA0KPj4gaW5kZWVkIHBwYzY0IHdh
cyBzaGVycnktb24tdGhlLWNha2UgaW4gbXkgc2VyaWVzLCBJIGp1c3QgYWRkZWQgaXQNCj4+IGJl
Y2F1c2UgaXQgd2FzIGVhc3kgdG8gZG8gYWZ0ZXIgZG9pbmcgcHBjMzIuDQo+IA0KPiBUaGUgcm5n
IHByb2JsZW0gZm9yIHBwYzMyIHNlZW1zIHRvIGJlOg0KPiANCj4gICAgIHNtcF9zdG9yZV9yZWxl
YXNlKCZfdmRzb19ybmdfZGF0YS5nZW5lcmF0aW9uLCBuZXh0X2dlbiArIDEpOw0KPiANCj4gcmln
aHQ/DQoNCnJpZ2h0Lg0KDQo+IA0KPiBZb3VyIHByb3Bvc2VkIHR5cGUgY2hhbmdlIGNyZWF0ZXMg
aW5jb25zaXN0ZW5jeSBmb3IgMzItYml0IHVzZXJzcGFjZQ0KPiBydW5uaW5nIG9uIDY0LWJpdCBr
ZXJuZWxzIGJlY2F1c2UgdGhlIGRhdGEgc3RydWN0IGxheW91dCBjaGFuZ2VzLg0KPiANCj4gQXMg
ZXhwbGFpbmVkIGJlZm9yZSwgdGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIHN0b3JlIG9yIGxvYWQg
dGVhcmluZyBvbg0KPiAzMmJpdCBzeXN0ZW1zIGJlY2F1c2UgdGhlIGdlbmVyYXRpb24gY291bnRl
ciBpcyBvbmx5IDMyYml0IHdpZGUuIFNvIHRoZQ0KPiBvYnZpb3VzIHNvbHV0aW9uIGlzIHRvIG9u
bHkgdXBkYXRlIDMyIGJpdHMgb24gYSAzMmJpdCBrZXJuZWw6DQo+IA0KPiAtLS0gYS9kcml2ZXJz
L2NoYXIvcmFuZG9tLmMNCj4gKysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jDQo+IEBAIC0yODIs
NyArMjgyLDcgQEAgc3RhdGljIHZvaWQgY3JuZ19yZXNlZWQoc3RydWN0IHdvcmtfc3RydQ0KPiAg
IAkgKiBpcyBvcmRlcmVkIHdpdGggdGhlIHdyaXRlIGFib3ZlIHRvIGJhc2VfY3JuZy5nZW5lcmF0
aW9uLiBQYWlycyB3aXRoDQo+ICAgCSAqIHRoZSBzbXBfcm1iKCkgYmVmb3JlIHRoZSBzeXNjYWxs
IGluIHRoZSB2RFNPIGNvZGUuDQo+ICAgCSAqLw0KPiAtCXNtcF9zdG9yZV9yZWxlYXNlKCZfdmRz
b19ybmdfZGF0YS5nZW5lcmF0aW9uLCBuZXh0X2dlbiArIDEpOw0KPiArCXNtcF9zdG9yZV9yZWxl
YXNlKCh1bnNpZ25lZCBsb25nICopJl92ZHNvX3JuZ19kYXRhLmdlbmVyYXRpb24sIG5leHRfZ2Vu
ICsgMSk7DQo+ICAgI2VuZGlmDQo+ICAgCWlmICghc3RhdGljX2JyYW5jaF9saWtlbHkoJmNybmdf
aXNfcmVhZHkpKQ0KPiAgIAkJY3JuZ19pbml0ID0gQ1JOR19SRUFEWTsNCj4gDQo+IFdoaWNoIGlz
IHBlcmZlY3RseSBmaW5lIG9uIDMyLWJpdCBpbmRlcGVuZGVudCBvZiBlbmRpYW5lc3MgYmVjYXVz
ZSB0aGUNCj4gdXNlciBzcGFjZSBzaWRlIGRvZXMgUkVBRF9PTkNFKGRhdGEtPmdlbmVyYXRpb24p
IGFuZCB0aGUgcmVhZCB2YWx1ZSBpcw0KPiBzb2xlbHkgdXNlZCBmb3IgY29tcGFyaXNvbiBzbyBp
dCBkb2VzIG5vdCBtYXR0ZXIgYXQgYWxsIHdoZXRoZXIgdGhlDQo+IGdlbmVyYXRpb24gaW5mb3Jt
YXRpb24gaXMgaW4gdGhlIHVwcGVyIG9yIHRoZSBsb3dlciAzMmJpdCBvZiB0aGUgdTY0LiA+DQo+
IE5vPw0KDQpZZXMgdGhhdCBsb29rcyBvaywgaXQgd2lsbCBvbmx5IHJlcXVpcmUgYSBiaWcgZmF0
IGNvbW1lbnQgdG8gZXhwbGFpbiANCnRoYXQuIEknbGwgZ2l2ZSBpdCBhIHRyeS4NCg0KPiANCj4g
QnV0IHRoYXQncyBhIHRyaXZpYWwgZml4IGNvbXBhcmVkIHRvIG1ha2luZyBWTV9EUk9QUEFCTEUg
d29yayBvbiAzMi1iaXQNCj4gY29ycmVjbHR5LiA6KQ0KDQpFdWggLi4uIE9rLiBXaGF0J3MgdGhl
IHByb2JsZW0gaGVyZSA/IEkgaGF2ZSB1c2VkIFZNX0FSQ0hfMSB3aGljaCBpcyANCmF2YWlsYWJs
ZS4gSXMgdGhlcmUgbW9yZSB0byBkbyA/DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0K

