Return-Path: <linux-fsdevel+bounces-75324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDXwEQcBdGmz1AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:15:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D642F7B69A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C25753011A7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7832E7161;
	Fri, 23 Jan 2026 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6s5SHPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D919CD06;
	Fri, 23 Jan 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210116; cv=fail; b=YgR1D/7r15eZt50WTQqVCC+mdtGP979O3172nEHY9TWpULLZwWF+PJ0KIIVHeOs31xZQiRSIs6h9m4MUDCq7azpPgVjIAOh2j+ZkCJ4o+NXqtDivThQALLyhRIpnM9gNndr0eyzu9pgJEciYgmHrG1VMwZtd8WSOW2mKaNtDvE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210116; c=relaxed/simple;
	bh=vgQ/ZaoChBA3hAiuK+GToUX3xtILbIW6SlKbv0xxSOw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e93G87ezdM+ePdXOalbrvsQfMQj7T5s1c5DoLFQkeLo1xqFASYYgjVlqaWaWrKuBFTepcf4Fq6JI3yhQu/UqStHQlNPBnrSlPzsoErvMCAnSV8n4MC4YlrM/MUxCaT62RHk+JUsAOltQXhegsTJMVfXWU/7rMCwRN4+3Uzd+urE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b6s5SHPp; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NCvPCD021316;
	Fri, 23 Jan 2026 23:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=vgQ/ZaoChBA3hAiuK
	+GToUX3xtILbIW6SlKbv0xxSOw=; b=b6s5SHPpRh/AcI4yFCyHrFJpdxKlJSYCr
	4V/LMhL88SC4AOyTeFlSm0QwroSAzCfq/VAyyTcaN1Xnk21C//7a4BDJRCMcKn7x
	bjHtMKew5S1Qfh6rq0ac9U2OABU+DbriCQr+zN0egTD5DuQOcyS3rHj0YTO62GgR
	utzCZgEir7dpomrL8OZFe4IelD30UD6JE3cNcnuPk3X60FoxbppMYskCzEP2cPhi
	XElqyF8dRmWTyIehohqw2kU22gp7CgWZ4xYDlnLifhsNNgVGdZ1b64MJjy9ew/hv
	M1DWn0TfNM7I2h+Pt2AUoPhML6FN5zm9wub1BovJAY1hKzi2EZADQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612n1g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 23:15:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NNBdbM006478;
	Fri, 23 Jan 2026 23:15:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612n1fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 23:15:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNYm8WthkB9b7dKrfXkUBRamp3/unK3T1PRRj9jrJgIoxNg/w3ExAgsdhNKGuTv7xHUMPYT7PukWNPh2UsOA8EINKQf78qWuBg7AEX+VjEQO5Q0V5zYewvNp6jmbafbP0Oy8Wi9XNYQRhnydxSz5aob7o2FbDr2E5XDuQ6RM5LBcO8fAYnpgITZo7P/O1ISfjzDSN8ce/9Yr4uxERt5t8YkFgpxUXmgtAl4rv4fssuCar1ZQATCenXI8wrewf2pxSIbfDqJRs6KmkOFay++ej1P4zZ0UUIglXfeeltEdJdguqmgwsduTD5Zzv2D9LldNAhnnlp+uHXHgdykK4ZzB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgQ/ZaoChBA3hAiuK+GToUX3xtILbIW6SlKbv0xxSOw=;
 b=cXg7pjsVA1w4MRu1F3Rt7sFwRChD2pQBQ1jg/qpz7NFFU70jTfC+vbcf8XNCrS0IEL2/8nRi7ONFvfJJNQAyVIWZAl4U4qxqN2UcKthDMaEnlWSP1VWA8caIMHOI0TlB4MiYUWe9B/fAVJkgdNqgCLifFpqglblNsQpi/WIiZyguXWp/aNDeTPeADDw7/Au47Ahqzjx+eYIVxavcO8N16apEHk1jdzfL3LnqZ7xlWXqk0n3oHjKzqLEMTnUw4oL/eVR76wn9lwYp/o/ikJx9eEEjv7uxKzr3FUHOmN6C/j9tR+miyfy6l6JxIKJtx3q6Op/O8mZ/TMikCnkpVkEz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPF96A1F4B4A.namprd15.prod.outlook.com (2603:10b6:f:fc00::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 23 Jan
 2026 23:15:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 23:15:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] Is it time of refreshing interest to NILFS2 file
 system?
Thread-Topic: [LSF/MM/BPF TOPIC] Is it time of refreshing interest to NILFS2
 file system?
Thread-Index: AQHcjL4dwd18ibQvbkShxUxQIrpTcg==
Date: Fri, 23 Jan 2026 23:15:08 +0000
Message-ID: <8e6c3a70db8b216ab3e9aba1a485de8e6e9db23d.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPF96A1F4B4A:EE_
x-ms-office365-filtering-correlation-id: 8f438d80-faea-4de2-a320-08de5ad54087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEx1RGdGS0VMWU9IbXhlckZXVTl2VExmbkhSaVRxZ1gwNU9NYnJ4V0lRdWo0?=
 =?utf-8?B?bGNySHgvQ3BScSt1clJiRU5oRmhDekI5VkxHTWc0V0RkMVBWSWxNbnMzeFVu?=
 =?utf-8?B?OG5PWU44c1NaMDVWU0VKMnpJMEZyZXlRaTJMTk5iaktmTitFSDhCMElJMTcv?=
 =?utf-8?B?eDV6K3dYWmxKS0pZZ2wxRjIwVGNqaWFlOGRIa2xoNjNkZEdGTVJPWHY5Qjgz?=
 =?utf-8?B?MWdtQ1FMQngwMDRTT0JIUXRmY2ZSR29XK2JiY1Z3K1NrcWZJZ0pwcGk4eWY2?=
 =?utf-8?B?STQwcmQ2bEN4TFIzSmNUYzh1K0JJV3prblBUVHE2R2ZBOHZDMXVVb0E2QVJX?=
 =?utf-8?B?NGxKcXIzM1RSd2VTQURxZ0NmZU8ycTdTSlZXS3Z1ZDRRZXdrcExRaTdDckdV?=
 =?utf-8?B?d0NJTWc3THQxMUo3TVUzNTV1dEtJQWsvQ1Vtd2owdzBsOERNbzljS1UySkp4?=
 =?utf-8?B?eGw4Wm1ISWxmWjZhaHpVTkNhRDFGSEtYcUp4MmJkMWs0K0JhdUh2UzBnVWcv?=
 =?utf-8?B?Uk5EbmZydjhRcHVWK2pjV0pvNncvVVQ1eW50NHdYa0c0QWQ1MmNxb0RndklS?=
 =?utf-8?B?M1JnckEwMGVKR0dYV2gxUUhvOWdXR1Z2UndpSlkzZG01MWFydHNvNTFTelM5?=
 =?utf-8?B?WTFKVDNleGlGcjN3VnNEUWp6WDVKUzM0YlljQmZGcmhFaVU0OUE2UWQxYlp1?=
 =?utf-8?B?OUMzcWZUdlc1S3hrdGVUMDh2ZmhpckpPWlYzL1V3MmNwZUdGVVNxOEFjMk9a?=
 =?utf-8?B?UEZIQXJSV2djbFcveWY3R2hGeitEcU5uOFRySENvVnc3eEx4VzZ5UDNCNUx3?=
 =?utf-8?B?VjQvSmJXK2haNE40V3d1NTRMdHpzRkl4SHFsT0UzYytNRTZJbHIvZVFTOFJG?=
 =?utf-8?B?Rms4ZnpvZTFFUE5XdHNPSEVUc1Z1OTBLN0lOYWZ6MVRFRENmWk1UM2dreXpz?=
 =?utf-8?B?dWNyb2gwMzlFSFVUdnVNNkpyU1h6SDV3bXNwd3ZySHhDb3hHSkFjZWV4RHAw?=
 =?utf-8?B?OHQrdGUwaXVZemVtVjVRY3FOTkhpL01FOTVHL3V3LzFVbXUwVHdyK3hEYW01?=
 =?utf-8?B?VmRPaWtNcnI1V3BYS3FaZGpQTjZBc29iekdBcGZ4Mk13TWViNHBLcWxnWjk2?=
 =?utf-8?B?U0pxdU9KamtMNHdDV0RER0J6dzBUQXpvSUpCMER2ZS9Da24xbEY5UU13czJC?=
 =?utf-8?B?N3FSTlJibXVnZzlZM0hKT0FmYlg3cG1kSW5FUHU0UnM2NHF0MENiMGZxalJh?=
 =?utf-8?B?UHBaRE5GNVZFRUtkTnlxOXhLOGhVNGEycVNxSVoxR3pzL3ZiTTI2Z2VmQmpG?=
 =?utf-8?B?N0pCSTdZTEtOQXFDVFEvTEpqNDRHeTIxT1prejVFWXM2U3liRDcxZ3hnUkND?=
 =?utf-8?B?NWhuNDh1NE5tTG9PN0lsNURRajNqUUtmQjRzSDNGTEs3U21lc2thSlBLeXY3?=
 =?utf-8?B?TERCZS9BYi9rMC8zM2NmUXEwd2hBQ2lMdGVEWEpTTSs4cUw3UmFRWHQyMjdY?=
 =?utf-8?B?bmFGTHZDY3hIVy82OXkxNGFkK2RPeWNHZjhUTEFKb2kvQUFvYy90aE1xMThE?=
 =?utf-8?B?Ym1JdkJ1amFMaHA2ZWJSMk5MeVFhM1dZZHJxZjhnLy9XcUdaaUo2TWJnOVht?=
 =?utf-8?B?eGhraVNMSEN0Q05oay9nczFsVWNVN0d0YTFQWC8zaXhWZnRUb3ZXL2gzMVlD?=
 =?utf-8?B?enlyU0FPR2J0dVJoaHZROUFveWs2d0d1Y0M2WTBSUWNoak1tenVHdVNQRFFr?=
 =?utf-8?B?SEU2M2xsSWRVM2R2U29OdzQ2dGk2UjBHNXZkUFVaQzlTRHczVzRneFZiQzNH?=
 =?utf-8?B?SHc2emQwclFRV05XUlMxaGFOMkxzU0s5czF0cGhNQTVFM2llcXY5ei9pN21o?=
 =?utf-8?B?ZHB5ZEFtclQxalBvL2V3dlp0MWRzWU9lSEJ3cjFjZHZHTXMyTkFtTnRPdXFS?=
 =?utf-8?B?TkQzNkRJTlF2RzZVL0pPOXZYSWJNc3NGVHpEQ2NFcEcxQzZYMVNpbzNhd1ZY?=
 =?utf-8?B?WVg4QXQ4a3dwWUVGdjFRdFROM0lWdWdvRkF5T0lqVXNoVm5pakZWaFc2MHFo?=
 =?utf-8?B?bzB5NXNLSitKYUhwd3Azemp3SEJnQjE1azNWT0pJMXdPSEhyMEVtMUs5aUpN?=
 =?utf-8?B?MDlFdFRHemEyQW5kYWdIUy9GaWZMWkFyQXl1L2xJQ1JLL0p4aGd4YnNhclVq?=
 =?utf-8?Q?zwU331l+NrtBV9aN63Vf3Ng=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1d2UVFucUdsVWVFVDViUnVEb2JHMjlGYTUzWElMSmI1QXQxcCtQMDZGY2FC?=
 =?utf-8?B?cHJJSzBvRW5uUUFUakJKUkdxVnlMMDdUd1p4UTV5dCtHV3MxT09RclEvZ0tm?=
 =?utf-8?B?YllCSzQ1V2pFcG5oVnFjdG5rQ0x0T2d6bzJ6d3RzQTQ4N2Zad0RzM3JWUkox?=
 =?utf-8?B?VndRRkpYWnhZbkhrY3ZyTG5QRUhtRysxU3JVWExkZjVjTW5iaXljcnpiRDRp?=
 =?utf-8?B?VjloNGZ5U3ZrVUppV0xSWmhCU0p2QmpwTFhyMDdMeXRXN2U0Q2lMN0RVVkRR?=
 =?utf-8?B?aituK1pmVFN1N21iUnVGL3F6TmU5bXJVZ1QwNVEzUDM0amRxazFFejIrMS85?=
 =?utf-8?B?cVdMUUE4NTNHQm5Ic3FNSU9LMzhxenpxL09aL2phVVVSZG9NWGxvcU9udkll?=
 =?utf-8?B?UnNyTUZwYjE5RjlUdC90dTdhZEhQZHhVYUxEU2ltaTVXc1M3enVYTnlWMUZU?=
 =?utf-8?B?NHlrNWJ4N2Jvb3R0ZnNZTHFlTUVtN2tXc2JpUHhjaGpLL0J1K3A3L3ppb0da?=
 =?utf-8?B?SG0rRFlxTkQ1VU5ZQTNsT1dTRjh5a2k1NCtXTXlYZ2I4YlFBMm91QlpDZXRj?=
 =?utf-8?B?aDJlNVczNWU2a2RLalZqb2VzQzdhdTVwcEppZXpGRHFXTlRlWklIMmFtcGNW?=
 =?utf-8?B?SEkrdStNS0JKY0l4OXlnRk1TL2RNZ2Y3c3p3aDZwa3ZGUFhxb2QwY0lCZy8z?=
 =?utf-8?B?Ny92ekxIR0lka2NseFVyb2NIQXlLTkNXbktnNEQ0Nk95aExucEozeVE1QU1T?=
 =?utf-8?B?RnlJV2lWN20wWmJ3R0U2bkFEb2cxajdYNXBGV3lpNDhETXVBRy8vclVjSEZQ?=
 =?utf-8?B?Q1F5ZjhBOGR2Y1Q2bFBjaUM0N0tiRkVzdTFLcEZRcDJBNjlSTHo3Wi9jSjhs?=
 =?utf-8?B?RXFadzI5WUtYbVRqcHpjdXhKYUhva3pNRlI1UkpZcFZDUkxad1k4VVM3N2Jl?=
 =?utf-8?B?VUVLM0Q5cEYvVzVUbEd4REdZazFzazM0dUFMNExJWC9xcndYVkhNY2FWS3hr?=
 =?utf-8?B?eE00SXNkaVdBa2hSU1N0UXhvUCtVUm0vRjNxcWo4SEVNUG9lNS9CUVRaZkFW?=
 =?utf-8?B?djU4UUU5aktjYWgvUGh0d2RMMUwyRWJ1OVVrZG94N24vYk10Lzh0cWd1TmpK?=
 =?utf-8?B?MGZjZGExUWhvdGkwaVhVenB2RjNhMDBXa1pSYTJPNjdoeFJBdnJqbFhCTFd3?=
 =?utf-8?B?ZldjMnZ5THYrTHI1RHhDU0RkTVFlUzBDd2FMeDNXZ3ZFRU1YK1pxSm0zUEFN?=
 =?utf-8?B?ZkFuZHpFRXRzZTNqaks3eXpDSVlCMEx1Uk50Yk5nZHJ0VmtZR2pGaXdVMU5j?=
 =?utf-8?B?aEpNMDlDSVlwMmg3Tjd2bmd1b2ZPd2dFK2JvdTU5VmxtVEw2SytYbkNLSHdS?=
 =?utf-8?B?WENhRjZUeUFGV3MvNmFXWVYydmx6UjRNSW9CbHhQQ09tb0MrTXV0eXU4aEZT?=
 =?utf-8?B?ZVVvU0pweTMvWE5KcUg3c1dOL0NEVTkra0pSdnNPaTVyWitqSmh3dnk3S2Rr?=
 =?utf-8?B?eDFQeU5wRGIyWXlVVmRHc2RhNkl1MklpcjVUdmpFTjVzR0xHazl2cE9MTnlq?=
 =?utf-8?B?TC9LcVV5T2RZWXFZc2lIMElhRjRFTUVNUTZvTDRhSmh3TDdkNFdKK2p6SkZn?=
 =?utf-8?B?UExGVEV5SmxHS05yRGU0VVhVekdTN0VtSjlZQjQvNTZoWXRmMXVZa3U0WWtC?=
 =?utf-8?B?bGVRdXVYVm9HVEFnMTJ6QXVTOEhzWVhaK2lpdkNXbjRrK3hadmVQR1A1cnk4?=
 =?utf-8?B?MnU4TjFuVVpyUW1pMS9OeC9pY0FjVmdYSHRxWDZrYkJJeG1HQWVJWGJyWjgy?=
 =?utf-8?B?ejNIaXlDSnZDRkx2dGQ2Q1Q1aXlDbDRVYlJwRFJIdHFlQWlyQ0ZsdTlsNmk3?=
 =?utf-8?B?Z1Yxd29xWWxYYWhSQzJxZkR4MDQzMDF1WnFlTzJoWm1PNldmck01QUxoSEZ0?=
 =?utf-8?B?ZG9wcExtUHE1VThCemptSHVKQWMvWFcybVRQTUpwZDhiR1Fha1dzS2NxZ2E3?=
 =?utf-8?B?YUVHMDZyYVJnM2cxRWZVbWtCZlZJYWFneEZaYkxJREI2aEtYNEdHSlpWclhw?=
 =?utf-8?B?Mlo3ZXJtaUNSdlpOeUtlbWgrZkJ0MXhwMGl3KzFmdmRQTGNtOUpKdC9ZaFha?=
 =?utf-8?B?ZjlEdGxRM2J6YS9oRVBmQmU0QlQveDdQdzZ2ZFhJVC9nOW5ER3lVV2MxdDhP?=
 =?utf-8?B?VXFjYzM3NUg1S3JnTEk5SlhUV204K20wRnR4NFFkSkg1RS9Zdjc5SU5LSHZq?=
 =?utf-8?B?aTRGeFJMbUpwdWFIaXBpQ0hKMXBJTXduellMOFJ1QmNtaVNyUC8yUllGcXRl?=
 =?utf-8?B?K3BYYTRxTmdndHlhL0xmNEZvUXpLUUIrR3Y1bjJTQXByektOOGs2NU15Uy83?=
 =?utf-8?Q?ISz26UyXQ9IkNjewr67ClH9T9GNCdeFW5WrAc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3EDD078275B394C8E2262532D001506@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f438d80-faea-4de2-a320-08de5ad54087
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 23:15:09.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTlbcD1H/TzLDy6xwwOKtspUJVB7Zxfi/CT798SvFat0LW617U4yZVjytgWrVvqFAHeQ35IfVYI6jf0jYa8gJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF96A1F4B4A
X-Proofpoint-GUID: wShKe6DhGlEFyj-58tgJQrM9gWRcYt5O
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=697400ff cx=c_pps
 a=S19i2aQNi83ZBCZ28RB3Sw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=_DE3OsdGHqgFCwFQ:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=y3ZD-6NVmyWVY8AVQIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w0S5LUE5SiKS1h8bLtvUzX6zwIxfsPDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE3NyBTYWx0ZWRfXxbdQ6XEEChZq
 rTCOyy4F16YhrXOGKpE3ZTd9vVlLFYS7bsR94GkyWZlh5pP/ZJPG73uqcn+5Hxh9z9iolshSG6b
 rNc9T+J4EIaZmmm7ChO3eoBtGOGcj+6x+k5mO+4NODmekBSX4wyhOleEGKG9+YEiBfsJCk9h6ZY
 r8eC12Wu+anKMcdYJSrg/kcMoHcVwq2GGKrvHbnwebiekiDmk1zsiV2A9T1s5TYWiJ116asV6Xv
 Hw9Axgmh0Jdqi7MySp7nsEi9x8Du8aU9TRSPbLcg7p3uzSjnseZMwfxfj8hWPIS9IoRzXiKRu/2
 QVz3YqSEdsPvBdtulp7z0H9VqnHaKnhrnyMexQTSAwO0DvxnS9fEDDnLhwPPNshJKmtUmz76Jcv
 bFY6VFK9Vj+Nf8qLQ8LR0BH4YEobUeGCKk1X0PGKi2738kGCJ3IDNg2dXvRAznyOLH41cYPgPnG
 zcyzm86QuVv0Ds1ymHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75324-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D642F7B69A
X-Rspamd-Action: no action

SGVsbG8sDQoNClFMQyBOQU5EIGZsYXNoIG1ha2VzIHJlYWxseSB0b3VnaCByZXF1aXJlbWVudHMg
Zm9yIGZpbGUgc3lzdGVtcyB0byBiZSByZWFsbHkNCmZsYXNoIGZyaWVuZGx5LiBOSUxGUzIgaXMg
bG9nLXN0cnVjdHVyZWQgZmlsZSBzeXN0ZW0gc3VwcG9ydGluZyBjb250aW51b3VzDQpzbmFwc2hv
dHRpbmcuIEl0IGNvdWxkIGJlIGNvbnNpZGVyZWQgbGlrZSBhIHJlYWxseSBnb29kIGJhc2lzIG9m
IG1lZXRpbmc6ICgxKQ0KUUxDIE5BTkQgZmxhc2ggcmVxdWlyZW1lbnRzLCAoMikgcmVsaWFiaWxp
dHkgcmVxdWlyZW1lbnRzLCAoMykgY29sZCBzdG9yYWdlDQpyZXF1aXJlbWVudHMuIEFJL01MIHdv
cmtsb2FkcyByZXF1aXJlIHRvIHN0b3JlIGFuZCBhY2Nlc3MgaHVnZSB2b2x1bWUgb2YgZGF0YQ0K
ZHVyaW5nIHRyYWluaW5nIHBoYXNlLiBBbmQgTklMRlMyIGlzIGNvbXBsZXRlbHkgZWZmaWNpZW50
IGFzIGNvbGQgc3RvcmFnZQ0Kc29sdXRpb24gZm9yIEFJL01MIHdvcmtsb2FkcyAoZXNwZWNpYWxs
eSwgYmVjYXVzZSBHQyBjb3VsZCBiZSBleGNsdWRlZCBmcm9tIHRoZQ0KZXF1YXRpb24gZm9yIHRo
ZSBjYXNlIG9mIGNvbGQgc3RvcmFnZSkuIE5JTEZTMiBzdWdnZXN0cyByZWFsbHkgZ29vZCBtb2Rl
bCBvZg0Kb3BlcmF0aW9ucyBmb3IgdGhlIGNhc2Ugb2YgbG9uZyBzdHJlYW0gb2Ygc2Vuc29yc+KA
mSBkYXRhIHRoYXQgbmVlZHMgdG8gYmUNCmNvbnRpbnVvdXNseSBzdG9yZWQsIGFuYWx5emVkIG9y
IHVzZWQgZm9yIHRyYWluaW5nL2luZmVyZW5jZSwgYW5kLCBmaW5hbGx5LA0KYXJjaGl2ZWQgb3Ig
ZGlzY2FyZGVkL2Rpc3Bvc2VkLiBQb3RlbnRpYWxseSwgTklMRlMyIGlzIGNhcGFibGUgZGVjcmVh
c2UgVENPIGNvc3QNCihhbmQgZXZlbiBwb3dlciBjb25zdW1wdGlvbikuDQoNCk5JTEZTMiByZXBy
ZXNlbnRzIG9uZSBvZiB0aGUgdW5pcXVlIHBpZWNlIG9mIHRlY2hub2xvZ3kgaW4gdGhlIGZhbWls
eSBvZiBMaW51eA0KZmlsZSBzeXN0ZW1zLiBIb3dldmVyLCBpdCB1bmZhaXJseSBsb3N0IGF0dGVu
dGlvbiBvZiB0aGUgb3Blbi1zb3VyY2UgY29tbXVuaXR5Lg0KQ3VycmVudGx5LCB3ZSBoYXZlIG11
bHRpcGxlIHhmc3Rlc3RzIGZhaWx1cmVzIChhcm91bmQgNTAgY2FuIGJlIHJlcHJvZHVjZWQgaW4N
CnN0YWJsZSBtYW5uZXIpLCBtdWx0aXBsZSBmZWF0dXJlcyBhcmUgc3RpbGwgbm90IGltcGxlbWVu
dGVkIHlldCAoYXRpbWUsIHhhdHRycywNCmZzY2ssIGV0YykuIE5JTEZTMiBpcyBsb3ctaGFuZ2lu
ZyBmcnVpdCBmb3IgWk5TIGFuZCBGRFAgU1NEIHN1cHBvcnQuIEl0IG1ha2VzDQpzZW5zZSB0byBp
bXBsZW1lbnQgdW5pdC10ZXN0cyB0byBjb3ZlciB0aGUgZmlsZSBzeXN0ZW3igJlzIGNvZGUgYmFz
ZS4gUG90ZW50aWFsbHksDQppdCBpcyBwb3NzaWJsZSB0byBjb25zaWRlciBvZiBhZGRpbmcgY29t
cHJlc3Npb24sIGVuY3J5cHRpb24sIGVyYXN1cmUgY29kaW5nDQpmZWF0dXJlcywgbXVsdGlwbGUg
ZHJpdmVzIHN1cHBvcnQgYW5kIHNvIG9uICh5b3UgYXJlIHdlbGNvbWUgdG8gc3VnZ2VzdCBhbmQN
CmltcGxlbWVudCB5b3VyIGZhdm9yaXRlIGZlYXR1cmUpLiBUaGVyZSBhcmUgcGxlbnR5IG9mIHJv
b20gZm9yIHBlcmZvcm1hbmNlDQpvcHRpbWl6YXRpb25zLiBOSUxGUzIgaXMgcmVhbGx5IGdvb2Qg
YmFzaXMgZm9yIGV4cGxvcmluZyBhbmQgZXhwZXJpbWVudGluZyB3aXRoDQpNTCBhcHByb2FjaGVz
IGZvciBiZXR0ZXIgR0MgbG9naWMgYW5kIEZTQ0sgZnVuY3Rpb25hbGl0eS4NCg0KRnJlc2ggTGlu
dXgga2VybmVsIGd1eXMgYWx3YXlzIGFzayBob3cgdGhleSBjYW4gY29udHJpYnV0ZSB0byBMaW51
eCBrZXJuZWwgYW5kDQptYW55IGd1eXMgYXJlIGNvbnNpZGVyaW5nIHRoZSBmaWxlIHN5c3RlbSBk
aXJlY3Rpb24uIE5JTEZTMiBpcyB2aWFibGUgZGlyZWN0aW9uDQp3aXRoIHBsZW50eSBvcHBvcnR1
bml0aWVzIGZvciBvcHRpbWl6YXRpb25zIGFuZCBuZXcgZmVhdHVyZXMgaW1wbGVtZW50YXRpb24u
IEkNCndvdWxkIGxpa2UgdG8gZGVsaXZlciB0aGlzIHRhbGsgd2l0aCB0aGUgZ29hbHMgb2Y6ICgx
KSBlbmNvdXJhZ2luZyBmcmVzaCBMaW51eA0Ka2VybmVsIGRldmVsb3BlcnMgb2Ygam9pbmluZyB0
byBjb250cmlidXRpb24gaW50byBOSUxGUzIsIGFuZCAoMikgY29udmluY2luZw0Kb3Blbi1zb3Vy
Y2UgY29tbXVuaXR5IHRvIHJldml2ZSB0aGUgaW50ZXJlc3QgdG8gTklMRlMyLiBJIGJlbGlldmUg
dGhhdCBOSUxGUzINCmRlc2VydmVzIHRoZSBzZWNvbmQgbGlmZSBpbiB0aGUgd29ybGQgb2YgUUxD
IE5BTkQgZmxhc2ggYW5kIEFJL01MIHdvcmtsb2Fkcy4NCk5JTEZTMiBpcyBwYXJ0IG9mIExpbnV4
IGVjb3N5c3RlbSB3aXRoIHVuaXF1ZSBzZXQgb2YgZmVhdHVyZXMgYW5kIGl0IG1ha2VzIHNlbnNl
DQp0byBtYWtlIGl0IG1vcmUgZWZmaWNpZW50LCBzZWN1cmUsIGFuZCByZWxpYWJsZS4NCg0KVGhh
bmtzLA0KU2xhdmEuDQo=

