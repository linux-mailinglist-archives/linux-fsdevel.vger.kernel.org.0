Return-Path: <linux-fsdevel+bounces-55020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392EB06647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF81AA0924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE62BE7AB;
	Tue, 15 Jul 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q8lPPbNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5A22F767
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605382; cv=fail; b=DkGL8xn0MID7s7+6GS+OUBVOu4VDK5dmo070hwmt28HKdJ8hD9cDBKudeWO8azvHBeBsIrWuDYBtg5k6p6nhMU+p/LARQ1OXyZZwUBg3g7ieNpS4fRG1N78YB0vFalxqI9z9xHjJfx5aR+UKRkW6MrctnZSKLI1D+dNJJqxjg7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605382; c=relaxed/simple;
	bh=PeoTIit1atrApQR+MrZxwya9L5e0VTGoyYz6UBFVxcY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DAO8YFTI2b/sUreuiD+Z39PCXqRgreApjR8OoaAX2obLVA5stNlg6QY5BaZ61aog0AtAyB9D3GNS10OdXZF9QMJvTKupLuaHHRplM9ilahbNIJM7H1X9N80qAt73GpFyTA+unTYTZbuv5J3Xp50g5ESEqC5wQhKpNvAPlKPFlHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q8lPPbNJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FHN24B027941
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ofYiIem0JIDBM4a08PuA7whttGzGGJsjBy8mHTCwZQ8=; b=Q8lPPbNJ
	ifK18z0XIynCOlreItKQgG3LnKRLnTtLoSyWvzRAdVCpu1jqBklAlk0S14ktPv8j
	r1IQ7UNabaOshWtT13kVcs74ly7CZN2Ja/vtqZtCEX+/r9uJFTfVHphJoSHhdj9A
	nu6zrZFm1KuM347+5VcCbBHXCjUgG+grj3OYgEbrzDByowa4et7SAcC7vW9VL+lM
	0MrDgxFvw5Bsg9+SBBNbXf0rrxsN8AMCb47SzKR5S6LHVNcGmYMWm4zmaCZBVhZU
	ORze0cd/PVNAYcnpmKgytfDqV829Sum1w/dtBpiOuLxKMdhdJCvzkx7rEeqXolS9
	COkYHVp9+SVrsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u0xbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:49:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56FIlWa9011527
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:49:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u0xb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 18:49:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYws058W5L1tCXeEr+fO0X9trNBb9wTUA8gBuOUOIQgNB/C2STEy6yyVrZqvmag9cSvg749H+LZlLZ0FnctwIGS7tZFk7rBXIJd6NgRDaSrASNnqRP/FQoT8oG2j4V0CdNoEl7FnfqXiUjSZc9URfqwdrkK/GKeBQGSRE0JWUAIEOLl3FvECJOLRF5rmV3DFPVRiigTFPyAM+SR0L4VoYYgJ7jWegj94nxhL0f7FSCiJq53eaGUigSSfRVt6oRu2RSehbYrP3gm3+HGsVJlaGpnBR0rgkFRpMopT0rnVPawtcvu78M5kjp62zKN/8rW/0lRoJJljS4o3Ds1KAwQHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfUxkQRV9Dt+5KzyKgKiZna1QN64GTJbDFM2yVpF+aw=;
 b=sKbKD/5pYJ3nOrzyhnmotyESLx4iC6eHLzo/RYdyVfp46BgUys0SoLEot3/jnReaxhOLaVyg/a9AeblFLHv3nPiGQv1zdsGJ8czXLwcxx1J8DPyS7u1R0OW/AcbXoc8oLwpDoIt9ifYnSKOGwrYPb5pFSCFr0VmaBRvHYMtsABC2XL06LhaE4sLEv/6olSC3EnMjEkIMFxghdkoPcJRsf3t3gWQ8LvlM12Bufb/w7DuCwT8CIWL62TJp/KjsLNZ+BRvKSHApcfPVs8v/UmpxQi1oPENYvAmHdKRbdyLG2Cqc1ITIwvXmSJ5djsL1eXk3ko2+UYylWemR+QlmbtleEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5666.namprd15.prod.outlook.com (2603:10b6:510:272::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:49:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Tue, 15 Jul 2025
 18:49:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index: AQHb9UfaiGeRHeez2UacqYl1ayC1ELQzh9kA
Date: Tue, 15 Jul 2025 18:49:35 +0000
Message-ID: <d27ab621d904eda6f10fb3fdd280feb0f04e3afb.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
	 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
	 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
	 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
	 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
	 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
	 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
	 <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
	 <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
	 <ead8611697a8a95a80fb533db86c108ff5f66f6f.camel@ibm.com>
	 <b6da38b0-dc7e-4fdc-b99c-f4fbd2a20168@I-love.SAKURA.ne.jp>
	 <22cddf1f1db9a6c9efdf21f8b3197f858d37ec70.camel@ibm.com>
	 <7b587d24-c8a1-4413-9b9a-00a33fbd849f@I-love.SAKURA.ne.jp>
In-Reply-To: <7b587d24-c8a1-4413-9b9a-00a33fbd849f@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5666:EE_
x-ms-office365-filtering-correlation-id: 899cc76d-875f-478c-2eff-08ddc3d057d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3NBQ1ZwS2lVQnQxM2ZFQW5lNlZaaFNkeEhrcFlUaHRuWCtlMDFFRmlkUnM5?=
 =?utf-8?B?Nm5jbFdSeUlmSnJFZDFLZk05bFFBM3NONnVSeEhjUWFoNHRkRnhOQ3J4M20r?=
 =?utf-8?B?MFVqd1NFbGx1MjJ5WldGVkFEOWpSQXVsaEx0d0xkTko1OEt5WUxuc0Y3WTlt?=
 =?utf-8?B?N1hERGNNdEZUTUdDYVpvQzZtSW40cWpxeUY2aGVxSHQzSXB5M2lQalRGaWNn?=
 =?utf-8?B?VFcvNEc3c1kxWWJoS2VwSkFJcGxiNE5RMHhmb1UzRVNwdjVtaStncmEwcUlR?=
 =?utf-8?B?cVRpYkdZQm5Kcm5way9UKzZzcTdhVXhLNWVGYlZWUnNjWW13WWFUY1NOV003?=
 =?utf-8?B?Sm9PUlpLZVYvdllmaG4yU2lWbGtTNUJxajlHU29RTUtEV0xaNkpQamJ4UWpV?=
 =?utf-8?B?QmtPejgrT0lPa0xuTGZlK1FySld1NTNCMHU4QXZ3S0cxQzMvSzFMb2wvVndP?=
 =?utf-8?B?cS9OSkVHOWhOZEVyRWNveGY2anRiY2J1Snl2c29UdlhiVCtrTXErSGxSS09v?=
 =?utf-8?B?WmRzOFc2bTVkT3VTdGdWajVVcnhEdTRHVjhRRDIxWE9aZ1RtVEVySWwwaVhr?=
 =?utf-8?B?aHgwUmRwOVNIRkFJRzI5M3pla01hVkRPeWhnOG0rM0p3OUxWRHVzYXlFN0VY?=
 =?utf-8?B?LzZLekF5Yk5UZE9tZU94UVZjTXlOWmQxcDRkU1E2VkZ5WXRTL1AzbzhndVgy?=
 =?utf-8?B?UlBrbG96NzFERXpUZmwyQk03dXpDZVNpSHljR2JJVjlqZW5ZMTkvS1Y0VjJF?=
 =?utf-8?B?OGpzaXZyZzVON2dLbzR0bTN1VFNaSS9wTEpXQ2cxa2REekx3M0ZJZWY4cm80?=
 =?utf-8?B?RG9tUHlTa3BmMnVhTFl0cWp4ME9jbzFHZHhKWEVSOC91R2wvNXd5YllRaVNn?=
 =?utf-8?B?TUNkWEVrTXZBeUMyTFR0VktmS2hTbGI3NCtIdmF6VzZKeWdtSy9HakcvWWkx?=
 =?utf-8?B?SGtVY1owNk8vdkpyMTdITS9KRW5VdmFQYUVEQkJ3OFcwSW5ZNkJQc2J2T1pw?=
 =?utf-8?B?Uy9DYmJKblJER1FhY3dvYmJVcFN2U0Zjcks1ck9GUks3Um1ncGNtY20wUlBQ?=
 =?utf-8?B?bjF4SjFTa2NKVWRLdGQyV0NDOFpQbmcwdytodmE1dFJnckRvdzU3VGNuOE4r?=
 =?utf-8?B?aGx6cU12cDIxdjVaUytOMmUzdFozK1czeHJhTkNGbHhoVVNhWjZ0SFh0M2FU?=
 =?utf-8?B?b3VpSmJRS2FqS0V5aDRTL0F4Q0JPQW9NazM5Q2lJVWYvQkNlRVgvTDdxQmgv?=
 =?utf-8?B?VW1lYXVrdldxcHZUNTRLbjRqbHM3SFdnMWFQK21aVjdzaDJwcnJCNjA1NlNV?=
 =?utf-8?B?YXhHU2FVZnlHZ1p3VUl4U3ZMSFI4ak8zKzJYVkN3UVdGNHV0M1dDTmsrQXJD?=
 =?utf-8?B?RGtWbGRuY3J4OGE3cjVMTkVkL1h6bzBOQXhzYlZHRWtjUnBVaGZ0RUF4cXN4?=
 =?utf-8?B?VHkrMGg1aXE4YmRiKzRERHloRnNwd0s1M2M0dEl4YnF6emhLTjZzdUN2MnVo?=
 =?utf-8?B?MkY4clJYbVJBZWdMRlpWb203bnAvZ0pEWC81Q3NnVWlUaU1ocHFEMmR4MUo4?=
 =?utf-8?B?Mytrc2FyM0F5alVLNjdSWjA4cm9SMkVxUEdKMXhkalg0MnlHazN3NHlqSE1Z?=
 =?utf-8?B?bTlsUjlNRmROY3BObG5PVFBNK3huLzNLSHBMb1dCOGpGMWJaUU5ZTm1TZmI5?=
 =?utf-8?B?andKWC9NazNlRTEzaHZlUE5SeFBEK2JDSGFEWG9acnIyLy9WVm42bXdHWDNT?=
 =?utf-8?B?N1U4bUpnZDRzV09BczNSazVsd2laRU01QnNUZ1g2cTBiU0xocFNuMnRoRWtR?=
 =?utf-8?B?aVgzTVUrOVZvMnhzT2tWVnJobU9NMmlyTTJMNjVINktVanZ0bTI4WmoxUE85?=
 =?utf-8?B?YWhxbXFYZFpWM1dBN05CWGVEemRKbVhmdmpUMXFHQTRwWTJyMFNzRTl1dmxF?=
 =?utf-8?Q?ExZ4u763Qc4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0ExbmlDQ2tKb3daVEhwemRQbXlZV3U2WXlaTnY5QUpNNG00NHNFOG5jakZN?=
 =?utf-8?B?MGdVYlVUakpaeFRBTi9UL1JqV3I0ZXJBNHhNSS9LaWVhbDRIMGMzQWlycFRT?=
 =?utf-8?B?RGt2bWFBaS9yMWhUYVlhSVFiTGNucEhyUUhKTGUxcW9LT3dwR2NtM1owTTUv?=
 =?utf-8?B?SlppNlVIM2lkSDJvNGVLdUJxeGU4YW1mdUhXaCs3VzhvRFJQTU4zc25rQnJs?=
 =?utf-8?B?bCtLZDMxSXpuT3V0TjFwb0NlUjU4a3lLcDlaRzVwZ3VZakJMd2o4SmVUc1pk?=
 =?utf-8?B?R3JlSEEvQ2YyNStUTjBrOENYV3FwSXRSZkxINngrTDVpVDNUNEhnd0xQKzB2?=
 =?utf-8?B?NkFWN3lQajF0Rkl0Q1FGQ1R0cS85MVVOcXpRV243bjYxR1JkWXBNUmpKMVE1?=
 =?utf-8?B?VUtCTGQzUEIycDhTSjlmTFc2dHNFaDZHV3o1enV4eXc5RXhxbXc5TDZGdVpT?=
 =?utf-8?B?UHRVQzBtZHRVQmlLTEVEcjdDdlg0eUYzZ2YwbWNXaE5vTVJJR0Z4SFhQREl6?=
 =?utf-8?B?bVJIZ2t1ZnM1eE9YUnFTc2Z1MlZXRHlXSmhVY3Y1TXJySkZWeFNmUGM1OC9D?=
 =?utf-8?B?cWpiOXRiYlR3eklYeDlYNlNiV2UxRzFqZ0ZLWUNOekNoVFVnLzlYWUgyR2Yw?=
 =?utf-8?B?cktQVXQwOFAvUGdhM3MrZ1VKd1g5YjNDNkdvQjVDV1NDaDRNdWthUFVuOW4x?=
 =?utf-8?B?R0tVTnpiTGE0ZGMwSmFPQUlvd1YxUjZjL216MnBrZ1NZVHpZNGdmWWxmcFRm?=
 =?utf-8?B?NjFLelZ2YmlBdkJ2ZUFUMkpFQkxiQS9JK0FDNzRyOVhlV09ZOUpmT2tlQ2Y2?=
 =?utf-8?B?ZDZBRUUyY0JlMGt2QWRtamxkeDZ1dytHVDJwc2pwQWlNaFNOMXRsaWNpQ3Z6?=
 =?utf-8?B?R3ZsdldKRERCTmFVQ2RUQURFU21mb2cxTVAwSnBGaHBRUWhvQktkM3dXSGU0?=
 =?utf-8?B?dlFnNmd4Ymd1REM0TjR1dmZQcGUwMU9WK3B3M0I1aHY2dmRlUi9zVmFlbEhr?=
 =?utf-8?B?cGpKQzBNSU9yR08xZkwrNWNpQnNlcm5rSkVWc2FNNFlDS0FLeExMUjZrSXlP?=
 =?utf-8?B?RStZaWMxRXpiOW1pK0c4bGdvclFsTWNnbEpkSWlaMHQ3eXphL1pGMWUzOHBM?=
 =?utf-8?B?MWJoWUwzbzJ3Z1grTlBkdVRPaGJCcGNtY3h6Z0tFOVZJZHN1QzNMMU4reVM2?=
 =?utf-8?B?NmloQ3JTclgxaWV4cjVyRzFzOUZFMncxR2ZRWGljVVdXSFk5a2RGOGRlT3RS?=
 =?utf-8?B?OGR0ajFnZXBpT1g0RmZqOElMWVV2R0Z3aWZuOVhyUktOQ1IyMzI3Rkluc2tM?=
 =?utf-8?B?Q0ttSDZ4Q1NXbDMzU1h1V0h0RnF4SVlhdENOaEJHTGpBWGdCTzVKOE0xb3ly?=
 =?utf-8?B?V0Vnb3pwdGNKYWV3SHpkd0xaOGpibENMZjVySDd3Ykw1c2k5K1Z3UldJZEkx?=
 =?utf-8?B?cysyU1c5MS9wN0creU9vODZaeGp3eVZLQlcwSkpmV0h1Z1hNUnNhNHZFeWNU?=
 =?utf-8?B?aXJJa3dnOHRwVmxnNlJXV1BsaVYzMkNpQXovMkhxelgzU3J2OWxuclhaYjc3?=
 =?utf-8?B?dlhLT09FZkVlb3VGOVFEUUYzeXdjTmJLZGtvZnVHaVg2K1pmV1ByTCtaWklj?=
 =?utf-8?B?VmtGUnM3eFlYWGFiTlpYODVZWnlGeWVRUTNnOXpNWHpVMW1qRXAxU3JnVFli?=
 =?utf-8?B?OEg4NHNFdnFjZktzRWlGNi9EekZJcWM3cXRsTTlPdlNud29CNHRkQ1g1ZU5N?=
 =?utf-8?B?Q2lxcC9CcmozUThVOWZ2REM0SXhkblorZVdhR0J1TmxIWHBOZUNuc1FZbGg0?=
 =?utf-8?B?L2tFODZMMU1uSXBZNTNNU0lzczdCMm9MKzFQZm9VaXpZUm1MeU1XeHEzK2lp?=
 =?utf-8?B?SitjbElKM0FDZzZiVmd0a0d5ZTVVYVBXdmxVaXVmVmJTbHRmbDdQZ3UwNG5R?=
 =?utf-8?B?ZEFWcERyWU9SYVI3SWV4ZXBmWVplNEc4SnNwcFRZYlZPZFN0TUlOcHhSdjQ3?=
 =?utf-8?B?dkNEU2dGSmVvWGRtRExSS1g2VTIwc29LL1BqeFlBcmJuVEtBSW9rNCtYb0s3?=
 =?utf-8?B?cUNxR0t2TEdTNENUR05zMjBFcnE2OGFXTjc5VkFjOW4rSTZPK3Nhc1IvL2N2?=
 =?utf-8?B?bExTdlo3TktOenZCa0JHb1BlQ1F5VU5kSTh3SytDdWhqYlNhOUQ5dGFpL20v?=
 =?utf-8?Q?oGwcY2/jOuA0pjNCb2R7Irw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899cc76d-875f-478c-2eff-08ddc3d057d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 18:49:35.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DENtLpKmOMLkXBhxxnyxz3fdnnc/8XHMjb4MixCZM6d+zsP1cYbkIH8ZChmcnb08rqjJyEGI1kNZjx0zyiAmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5666
X-Proofpoint-GUID: R7bJbpk1B5BV6jYc70no3sYJSzQHfIUC
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6876a2c1 cx=c_pps p=wCmvBT1CAAAA:8 a=hAsNFjThZkWHiguqsHKUbA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=_3a471VmrCM3wBtLI80A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE3MyBTYWx0ZWRfXzBits4xJbgIB e1bD98wdCBd2gAjmHCW+/36czp6E7YY331qj9lkiIdzV5OghdU1iiP0D1U7ru3jTwuMhJr5Nwlx fB3wTSDPBq5ZbjgYt3eJNPNKDCY/Rl09O2ETvFhzZXv1jSy4bTWG+2CF58R0+qk+FO/JYvT97BN
 emSrlw0KM7vRCJG11WzYnTjL0X5OeFYQbxHXh/Vdv8zmK+5SQYegy+EhsS5ovM17fZt3TcaL5nd oG8vNyjAcugEswGet8hd7Ev/MOdXyljIW0wCMt6MP7zknskFOfoq8cEMxbsMCgE8INxmTQ6SlqH lFpcI6yDHNqz0OqRs8ETOGprP4twnmBOEqyUlghOv1l/egcx6wS21VxXFZmdOnHaSqonvQUGKki
 EOKvdbWnFb+XPiEHN4BQ117DFu6Om3X8ZU8z6oI77cqEIy6ujZuF478UOJPAdsSKiK4hDzPf
X-Proofpoint-ORIG-GUID: R7bJbpk1B5BV6jYc70no3sYJSzQHfIUC
Content-Type: text/plain; charset="utf-8"
Content-ID: <51D298F4364D444C82BA0C80C4FBA11B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507150173

On Tue, 2025-07-15 at 14:17 +0900, Tetsuo Handa wrote:
> When the volume header contains erroneous values that do not reflect
> the actual state of the filesystem, hfsplus_fill_super() assumes that
> the attributes file is not yet created, which later results in hitting
> BUG_ON() when hfsplus_create_attributes_file() is called. Replace this
> BUG_ON() with -EIO error with a message to suggest running fsck tool.
>=20
> Reported-by: syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D1107451c16b9eb9d29e6 =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfsplus/xattr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9a1a93e3888b..18dc3d254d21 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct sup=
er_block *sb)
>  		return PTR_ERR(attr_file);
>  	}
> =20
> -	BUG_ON(i_size_read(attr_file) !=3D 0);
> +	if (i_size_read(attr_file) !=3D 0) {
> +		err =3D -EIO;
> +		pr_err("detected inconsistent attributes file, running fsck.hfsplus is=
 recommended.\n");
> +		goto end_attr_file_creation;
> +	}
> =20
>  	hip =3D HFSPLUS_I(attr_file);
> =20

Looks good!

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

