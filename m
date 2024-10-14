Return-Path: <linux-fsdevel+bounces-31847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD7699C13F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3967B283BDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7A1487D6;
	Mon, 14 Oct 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="P9vx3E46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FB224D6;
	Mon, 14 Oct 2024 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890900; cv=fail; b=JMVPV01OIk6Zj1NqT50eHjGC7E9unM+Lm2+IF1xQ7iwUIOOZ/9KZFUjfeld9+qOWIaABwZRiQrkLWE5aaz4P6JRqbcm/ZTTu4aNc/qQ6W7fTqrcfaiCUgey6M01ZXwXHhbYRRDCHF2u5o3yUiGi1Rm57O7x21VnTa4X5N3aUbOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890900; c=relaxed/simple;
	bh=O/hiYNhtZHqqu5VZswII1+xYe3GYS7UrLqRAjg8bRZ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Er3KM6NSuFmkkR3XIu1F84C5PcHw/ip4Kndc1aGWybj2wlqPl1iu3aw7idF6xkXewX94pzpbmMsrTItSPDBk6zIt8FKjG0gGs2sZYa757CUOrYxvx9DZ/eRUng/v5R6t3LEa9+6PF/eFSJNKId0UiEi95EiYagkP8zn8uf7ikXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=P9vx3E46; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E5buWQ016670;
	Mon, 14 Oct 2024 06:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=DMu8yS/sCn4IXIq2cfElj+oXpGQzGL0
	YN880WWSEkK4=; b=P9vx3E46sojx+4bZbCwC2R2OPQY0Prdopkk1cZ4wj90kY6j
	5CO9nA4XHjnT8aW5okAYCfHIRh9PLK6DYRcPMCjbw1ku/L1tLaP8+PBTiglImifO
	IezUj+MAxPW9a8zSUsfEHNAA59bqAf7LCGXTmtglcVmbiD+ItnGzyyj9rK9hg6YH
	IvoCVSVnHYGSHqSs3m7mkeqioUqvQiiulRvI0/RsEeI190yU4F7U3MoLDjl10AHs
	Gq3kWxE+3mS9UH7PGuVSXNm7CsyMAvarjviYCBJIzmYA+tPZOZUufkfYftYO6Jiu
	C3gkyTDwnC1HQMD/ILfYhMPwBZBBNcs8SWLtK9A==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 427f0j18d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 06:39:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCLoqDbSJLuo7RLrvZ3lx540oakn363Tvm+mYt+xdsNBbB4KXU7DtnHcaF28igI4y8AVCMmy/QDZ7BrFQ0fOMW1foG+K9bVMdhNXndR6WSECoS9/N3c9H06MFs4T/2O80QGRZtfwoDDbVrP0/8b7T2WsfhxXO+UwgiWzsAkiDeuEg0deHVnU9k2SinjtioeabIaZaPF38wwKKc3SeEbA8sm6apb2yfhbpNXRLo/c8rCG0QWLJ0B7fVEPHOcjvTo4n/09eOoHHm08MsZ0x7fxAs9RgKugoKLLoMtYspOqpLW2ab4t+lYK7FrQauDQix0LHGF1Q0LIivt62vEsiACYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMu8yS/sCn4IXIq2cfElj+oXpGQzGL0YN880WWSEkK4=;
 b=qJBJXP6R7Z6GoaH0tAKFahhmf52fR4a7yWwtxHmbRTJol0oaWVlQAfzlIPOe7WmDKyVHEwyv+Y3FnBwUGrTulop2TWM9eZDwb8TrlD1Ezeu7aVRjMiw50lV+JgpxVvPIW/lpNesx8MFKabKLWW1WcgSgtm1JDkRMuCCFhzo2H+iYNiMRmFW0DxGXvmuZ+JIyl0w9nnDgNSx/ADJG3CQIAUumAa23hMXQCCY/88A+3Uxc1cPErIVynds9Jfhqll95oVVDaMFI+REfy15gyVCEf+4WYDqfNw5rYwXdfZlSHiFMNW46dX0lV0GdN4x9ZMrBYLffaPjG7nXOGSXMxV2vOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB5731.apcprd04.prod.outlook.com (2603:1096:101:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:39:35 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:39:35 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
Thread-Topic: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
Thread-Index: AQHbFzNtsSHN6rrdo0SFh1Or7Dwrw7KF1NNw
Date: Mon, 14 Oct 2024 06:39:35 +0000
Message-ID:
 <PUZPR04MB6316D062F577B655E85385E381442@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <67014df7.050a0220.49194.04c0.GAE@google.com>
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB5731:EE_
x-ms-office365-filtering-correlation-id: 98f0c265-91dc-45cf-bb4c-08dcec1af7d7
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3JjR1Faek5mUmZ4enJ0Qzlzd1NTZFRHREVPNHNtMDExMURtK0ZPZlRJZDI5?=
 =?utf-8?B?UlBaZVM4Y3Y0SEVhaFFoMHBVY0RrdW1JelhubnhHZ3g0RlVyM210bWJIUVAz?=
 =?utf-8?B?UXZ6aG50K05PTDZKMENFUjNwMGNWTEhUZEgxTFI4eWh6WHQvazJ4NWxNd2dJ?=
 =?utf-8?B?ZWZnbE15ZUNoeDBJUHJTMm4zMjBxUXhxbEhadDVnWm1sM1ViYjdTNWE0VUIx?=
 =?utf-8?B?SXhXVUVWWXpxcVJXV3pIeFZFMFRvSGhyNVhIaU42dlhJTXRJMnhXeDVoY0No?=
 =?utf-8?B?Nys0dlhyMmRwbzljSTlKbzlFZ2t5aEpYc1Qzalhad1AyUkpHcnovaC9lUlpO?=
 =?utf-8?B?b3ZzZUpmNDNLbWZUSTB3VnVCOTd1OXlpQ2R5VTdrTkFEUzFVVHRlM1NMblZu?=
 =?utf-8?B?VDBWRWY1cFU1ZjZDRFlYdGxjdHN2YjlXRTlUc0pJU1hvNDkrQUhyekhBVWlR?=
 =?utf-8?B?OHpNZTFvOG95VVhrMHhsdU5UbnMyRzFhRGtNSThUb1JBT0JDSERDdU96SWQ3?=
 =?utf-8?B?RWxEZGFBTllwem9qb2FQNCtkaUJ2N1pIblJjSWJ0d3dJbXVKRURLdlBhMXho?=
 =?utf-8?B?c2xNdGFKQkl6MG4yemV0S01rS2pVUDRkSFh1azIxOEEwb0tPMnRUTWhYMlla?=
 =?utf-8?B?VER2amRNZFlvSjY4WWN5MUEwYW56Y3dDVWNuZUNiZE95OVE4WU9zUFJ4USt3?=
 =?utf-8?B?dVNHdkxaQ2tWZkZkQmYyTGlnOEQvRCtpdFBybEpabVNPODFYaHFDczU0bytN?=
 =?utf-8?B?M2JsdGR6Kys4WWduSTU4NjBaRmRxQ2pkYUQzcDR4M2w4Z3JQd25TKzd4R1do?=
 =?utf-8?B?bjJ5RTloajUrMFFhdWdnekphM2UrMU8yVTZhU1ljdFRTeDFDRGl0UHBWN0VR?=
 =?utf-8?B?OXgyWG5IVy9aVnBTZW0vV1k0MXdsRk9DQUU3dUFSTmhaRFh0TWlickJkSDZ6?=
 =?utf-8?B?V1ZmSHE1b0VYc0ROVUE1ejlwNDdmekxmTHhnQVozVnR1M1hOTkpSNWY0aXYw?=
 =?utf-8?B?OExwRzhUaGFoVUxJN00vYi9LZ08rQWpSUHpJVENvc3VZU0RDMWJXQVlXcWNK?=
 =?utf-8?B?bGpkSnBKYjlITWd4RUYyNTRzMlBQeklOanZBdGg2NEVPUE1HeTdONU9TV0Zx?=
 =?utf-8?B?RDRTQnJBWDdNUXdIVisxd2QxTG1EK0taTjdOY05KYVRuRXlvVnJ3YTVidTkw?=
 =?utf-8?B?UnJJLzJFNE4waktuTCtteCtpQzhJVUphVXdlUTkxMUt2TXp6cjN2UmVaMnJk?=
 =?utf-8?B?c3JQRzZ1N2dMdXN0Lzk4ci9sdzB5RTlpYnVESU9hNzFZM0lnbDJpZEFETmpi?=
 =?utf-8?B?cEVGOVVucDdpaU4wR0dMMitHWXFIQzh3U2VZeFJBWXRwRnBNZ1BMQm5HdWxt?=
 =?utf-8?B?TEc4Wkp1aWZ3UWliRXNWbnZMRGFqTDBqMGVJeVJzYS9LaWIxbmVXWW1uTi8y?=
 =?utf-8?B?SElBNGVPbGhVaUZqYU5ZWGVjcDhWeWhsTnRpUVNWYTl0dE9DREtkM1RkVW5t?=
 =?utf-8?B?RTBQaHhpb2JrOHRRc3E0dHFTZFZFaENNWHAvZWx1Q01sUldZekh0eENLTi9r?=
 =?utf-8?B?YVJqazUzY25RMUptUTBmNk8xL3RSSitTTXBUaEdHbFVZR0Jsc1IwejNqaXJq?=
 =?utf-8?B?WHJubW5GSXprQ2ZLV0ZBc0NYbXcwWDQ5ZzY5Unh5QmNUck4yNG13S1BvNVNF?=
 =?utf-8?B?cjd5bjVjVDJkRVlvbWVvaEdFWnoyZnVDQkRYM2FrelFMY09rNUs4Q3B0QjFs?=
 =?utf-8?Q?a3hshMlsReTLXPw4e8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzdOTkxFZys1VEpqSUY3YlcwSVNMb0VTdm1PUTZWK3JzQnVhUDZJYThxRU0v?=
 =?utf-8?B?WjhFK3JzMUFKY2x5bE40VEhzN0UzRTJybjBMcnErUWlKbklZSGE0ZUcwMGU5?=
 =?utf-8?B?R2ZvanpQSmppU2J2clVlcE1qdWdWMjdoT0VYS1ZKNVhDa1ZSUURYalJNcW4y?=
 =?utf-8?B?WjRKeGdtQkdNYys3TW5MY0I2NDFWanBOSTV6b1lNU0Eza0ppa0gwRkM2ZjI3?=
 =?utf-8?B?V3R3NEhiR0txMkNPbmdHVlh5VkY1VU9zS3lYeHltTjZ1eW95NVlkZVhmWTg3?=
 =?utf-8?B?SXE1NDBIV0psUCtjL1NuTW01TFBWdFlkbmVOOXoxc1BiNHRtR1F1YXNSZzQz?=
 =?utf-8?B?a2NpZjcrckM0c29UZ3hWd08zcWVvKzN2QUJ0VWh3clRZZkpacDJDZEZuWlph?=
 =?utf-8?B?ZC9ZcUU0amdrWkJ4em9CWTRTZE0vTmFkYXFXajZnMWZKZnhYb1kydjBIM3RI?=
 =?utf-8?B?alcramljWm9sMTlFSzFuUjUrZ0FSd1BEVWVIQ3BEb1J2RFlYV2x0Qll4Z3NH?=
 =?utf-8?B?MGR1NHVQbEEyQnNhVG1iSk5STUk5VUgreGw2cTByLysyQnJiN1hhM1hFVXFy?=
 =?utf-8?B?VlhDR0lNZTJjVVhuamVXdmtzVmJrSVdZazNPS3Y2QnZDWEMrZGpYckJobEZZ?=
 =?utf-8?B?TlVvV0RFa2NWWW9JNjkvZ3BvdHNYYmhmSk1ZRHV6bzM1T29ZUHJEYmluU2xG?=
 =?utf-8?B?b0NFbnU2NkUvR3FHY1QyRU1YL1hnZlZIa3IzQWZ4QWtLRVZ3Y1N0dloyN3Mx?=
 =?utf-8?B?Tzd2N0cxMEk5dzhuOWhIMlNBOWdhdXNkWThxVG1zNTZjNnoyTmlQWEdRYmox?=
 =?utf-8?B?cFJvQktHbzh4NTQxUW9lL2ppa0tKTDZBbTFmMHZIU1JRbWk5Z1BnM2dndVlV?=
 =?utf-8?B?UzRKMFZ3TW5PZTVaZHA4YTlGQXZLWnBSTFZIanY0YVdFaThWeS93WkRyWndq?=
 =?utf-8?B?aXhWbkxKYlZhMHZPVVRMdDZ6VklkZHVuVlBRMndQdWx4TVJQYk03aSs4TG9n?=
 =?utf-8?B?NTVMZ2JIYzVNNCtMT1IybjN2bjBDRmRENThWOVc5QndCb2tzNmR2UlJIRzQ2?=
 =?utf-8?B?UmRiS3R2KzBzVDc0NWNsZWt5U1ROZFJJcWtiOW9zL2FsTm1NdStab0xwcDlt?=
 =?utf-8?B?eHZ2aUFUajBzOENCSzJDZDJyMXVrNUoxYnRObVV6cDI4b2o5T0tqSldtKytU?=
 =?utf-8?B?Wk9adnlTOGxsUFhXT1V1anpNSTVZSjIxZjVsTm5TWlRPbFF4RzE1c3c5S1Nu?=
 =?utf-8?B?TGhYQVZJT2tOMlYvZWRjT1A1bVFyVnpuRWlxcWljbGZVZXMweCtFU0VtRndw?=
 =?utf-8?B?TEY0SldMR2NuU0t0UWs0ZzZURXF3SzJtQVB5MVdRTkZlSmcwMVlzYjA2MDFP?=
 =?utf-8?B?Mi94VDBxcFJVYnRhV1dHUTFOM2kzRlY2TGhvQ3lhQmZHcVhNamxBN2l5SklH?=
 =?utf-8?B?SVN1RmVLODVQR055VmpGZHVyR3BvNzdEaXoyRzRQMXg4cGw1V2w5L2hSSlVO?=
 =?utf-8?B?Q0tqSENjcllrU0dDY05qV0NxZkRFMkRIOWNmRk01WnczTlpieTVEVDUxVWxx?=
 =?utf-8?B?ejlkL21ickcrUHdzbWd3ZVdSMWwxOTQyN1plYzdXVDRjclVVdlR6T0dsZUxx?=
 =?utf-8?B?amZEWXNCOXpydlBUT3JGay9hcnJrVnRlWmU2Z0hXcjloM2RhM3YzTWNXTFNi?=
 =?utf-8?B?ZHdLRGVCQlhmN1ZBSVlNZlFLN09NUlBxQk9ES3RnZzJJaVV6MDlBbE8vSy8r?=
 =?utf-8?B?TkxKQVJpQ2VIYnlTL2FuZjJMYWNna2xYMUR0anFzRXNKQXRFYlNyZDhnRFBM?=
 =?utf-8?B?TU5oT3JSNXZGc2RNZDBQNndtbFBFSnNIN1NBcSswaFB6Zmp2L2txTWpGc2tO?=
 =?utf-8?B?QUd3QUNWY3hUUU52azhZWHkvR1VVRnZmVXEzR3VWVUVxejI3cGg5YW9mNEJ1?=
 =?utf-8?B?UmY5U1hmYnlWMTBnaURENkdvMUFqMXJ5MW5yZnNEYXJuNHN1bFRFTFJNdWtZ?=
 =?utf-8?B?eVBPbVM2TGRRSElJT2dlTUhBWWViMlZrd3FrdC9GZ1c0NTd4K20veUV6aVRW?=
 =?utf-8?B?ckZpOUVWMnUvQTVJVUxQTjdManBkNXIwMnZBQXVCL2xOU05EQjgxd2w1K2lt?=
 =?utf-8?B?bjBaa2lsZFhzMjNvWFhUUTlJNWFTMERZNzZRUnB6RU5FWEp5ZHQ3dTVaQkpj?=
 =?utf-8?Q?tCrnwwetWstsHbHTMk9anvU=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316D062F577B655E85385E381442PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tnwIN8kmCWtWzCLaY7dw7pRF6QXJwBn+In7ObVSqYhAQllikGd5fUCUn7MjxbaEU+W4S80XtxAh8u/FSM0jFRqDG83kSJGkWkDOtC7DmIUozD9z1uDlWs3vQtO3RJzEZgt2U6HlR7Ab/a2+oshqTssjTSfcz7e/aWEtNnNY7FjuPSEEqsdfnwAgAo5IpnCopVNKJh8/5uExQIrYs5j9rT80XuuJsOkYW0bsaOGmkpMFLaP1ir4lJHCTszTICzcFcyN69gEV5DPfVcE1HBgzY6T8Sb2Qbws3NxgneDT/2KA/t9yInwFWqm+O20l46NnDsM2ZUUSMvGcQm9pYqwOvpqzbV8AAGfwJyAb3Wtj3QdbCH+1LMAwAk6dVQ/D4t2I908szCNbxT3HYauURmqfRWms92PXXdymFZWndge+IesQquMK8cUYXHj+ej0UGwSSiSxsh2awUhTPCZb0BljqzSDeM5dO2VBEBod/q2qSrtU8Auw8OH5wEs3fyPT9NPzBUyQAr2XbpSnumbT1SdIozxSpGhWwfoo+1k75CuHjHOipw6AH8yP5UccSZxlG3RfX5joxaAF6QJHX7tTQsU54BJtpiJhzWHfO5eeUcx3e/M72fU9X6CE3ymv9WOS+6atWsG
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f0c265-91dc-45cf-bb4c-08dcec1af7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:39:35.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDXSU9EAVZOuV9ynWSZX0hqxYk33mfN3jwCW8A49QF9/1iTxZ+nO1UgB+79j15LiAAEj3JjzWLom9oQKOFY/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5731
X-Proofpoint-ORIG-GUID: ggxT1CYkLnvXRe2x2Clv8DN9MFkcZDMq
X-Proofpoint-GUID: ggxT1CYkLnvXRe2x2Clv8DN9MFkcZDMq
X-Sony-Outbound-GUID: ggxT1CYkLnvXRe2x2Clv8DN9MFkcZDMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_05,2024-10-11_01,2024-09-30_01

--_002_PUZPR04MB6316D062F577B655E85385E381442PUZPR04MB6316apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

I3N5eiB0ZXN0CgpPbiBTYXQsIE9jdCA1LCAyMDI0IGF0IDg6MDLigK9QTSBzeXpib3QgPHN5emJv
dCswMTIxODAwM2JlNzRiNWUxMjEzYUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tPiB3cm90ZToK
PiAKPiBIZWxsbywKPiAKPiBzeXpib3QgZm91bmQgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoKPiAK
PiBIRUFEIGNvbW1pdDogICAgZTMyY2RlOGQyYmQ3IE1lcmdlIHRhZyAnc2NoZWRfZXh0LWZvci02
LjEyLXJjMS1maXhlcy0xJwo+IG9mLi4KPiBnaXQgdHJlZTogICAgICAgdXBzdHJlYW0KPiBjb25z
b2xlK3N0cmFjZToKPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTZjZjdkCj4gZDA1ODAwMDBfXzshIUptb1ppWkdC
djNSdktSU3ghX0VGTTMxSnhESV9zQkM2TmhXd1dJV2NqYThVVVZCWFpZCj4gV3loSzBPOXZVdVNz
cXktWk9sYTRUdWVwTlRBM1gtYnRCbXplUE1JT0QwQ0dlR0Uwa1NGNE0yaE93Vnk1Cj4gN21yNXlR
SWJUQTYkCj4ga2VybmVsIGNvbmZpZzoKPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9YjFmZDQ1Cj4gZjIwMTNkODEy
Zl9fOyEhSm1vWmlaR0J2M1J2S1JTeCFfRUZNMzFKeERJX3NCQzZOaFd3V0lXY2phOFVVVkJYCj4g
WllXeWhLME85dlV1U3NxeS1aT2xhNFR1ZXBOVEEzWC1idEJtemVQTUlPRDBDR2VHRTBrU0Y0TTJo
T3dWCj4geTU3bXI1MElmU1hPZCQKPiBkYXNoYm9hcmQgbGluazoKPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTAxMjE4
MAo+IDAzYmU3NGI1ZTEyMTNhX187ISFKbW9aaVpHQnYzUnZLUlN4IV9FRk0zMUp4RElfc0JDNk5o
V3dXSVdjamE4VQo+IFVWQlhaWVd5aEswTzl2VXVTc3F5LVpPbGE0VHVlcE5UQTNYLWJ0Qm16ZVBN
SU9EMENHZUdFMGtTRjRNMmgKPiBPd1Z5NTdtcjUtSW9ZT0t4JAo+IGNvbXBpbGVyOiAgICAgICBE
ZWJpYW4gY2xhbmcgdmVyc2lvbiAxNS4wLjYsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBEZWJp
YW4pCj4gMi40MAo+IHN5eiByZXBybzoKPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5zeXo/eD0xMWNmCj4gN2RkMDU4MDAw
MF9fOyEhSm1vWmlaR0J2M1J2S1JTeCFfRUZNMzFKeERJX3NCQzZOaFd3V0lXY2phOFVVVkIKPiBY
WllXeWhLME85dlV1U3NxeS1aT2xhNFR1ZXBOVEEzWC1idEJtemVQTUlPRDBDR2VHRTBrU0Y0TTJo
T3cKPiBWeTU3bXI1OFR2VkN1cyQKPiBDIHJlcHJvZHVjZXI6Cj4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTExZDA2
Cj4gNTgwNTgwMDAwX187ISFKbW9aaVpHQnYzUnZLUlN4IV9FRk0zMUp4RElfc0JDNk5oV3dXSVdj
amE4VVVWQlhaCj4gWVd5aEswTzl2VXVTc3F5LVpPbGE0VHVlcE5UQTNYLWJ0Qm16ZVBNSU9EMENH
ZUdFMGtTRjRNMmhPd1Z5Cj4gNTdtcjV3MlNncDU3JAo+IAo+IERvd25sb2FkYWJsZSBhc3NldHM6
Cj4gZGlzayBpbWFnZToKPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zdG9y
YWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvMTYKPiBkNGRhNTQ5YmY0L2Rpc2stZTMy
Y2RlOGQucmF3Lnh6X187ISFKbW9aaVpHQnYzUnZLUlN4IV9FRk0zMUp4RElfc0JDNgo+IE5oV3dX
SVdjamE4VVVWQlhaWVd5aEswTzl2VXVTc3F5LVpPbGE0VHVlcE5UQTNYLWJ0Qm16ZVBNSU9EMAo+
IENHZUdFMGtTRjRNMmhPd1Z5NTdtcjU0Q1JDeWp5JAo+IHZtbGludXg6Cj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3QtYXNz
ZXRzL2EwMQo+IGJjOWEwZTE3NC92bWxpbnV4LWUzMmNkZThkLnh6X187ISFKbW9aaVpHQnYzUnZL
UlN4IV9FRk0zMUp4RElfc0JDNk4KPiBoV3dXSVdjamE4VVVWQlhaWVd5aEswTzl2VXVTc3F5LVpP
bGE0VHVlcE5UQTNYLWJ0Qm16ZVBNSU9EMEMKPiBHZUdFMGtTRjRNMmhPd1Z5NTdtcjVfOWZ3c1oy
JAo+IGtlcm5lbCBpbWFnZToKPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9z
dG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvOTNmCj4gNGRmYWQ2OTA5L2J6SW1h
Z2UtZTMyY2RlOGQueHpfXzshIUptb1ppWkdCdjNSdktSU3ghX0VGTTMxSnhESV9zQkM2Tgo+IGhX
d1dJV2NqYThVVVZCWFpZV3loSzBPOXZVdVNzcXktWk9sYTRUdWVwTlRBM1gtYnRCbXplUE1JT0Qw
Qwo+IEdlR0Uwa1NGNE0yaE93Vnk1N21yNTRIVTg0WWokCj4gbW91bnRlZCBpbiByZXBybzoKPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29t
L3N5emJvdC1hc3NldHMvNDMKPiAzYmEwNzAwMTU0L21vdW50XzAuZ3pfXzshIUptb1ppWkdCdjNS
dktSU3ghX0VGTTMxSnhESV9zQkM2TmhXd1dJCj4gV2NqYThVVVZCWFpZV3loSzBPOXZVdVNzcXkt
Wk9sYTRUdWVwTlRBM1gtYnRCbXplUE1JT0QwQ0dlR0Uwawo+IFNGNE0yaE93Vnk1N21yNTF4NTVz
aVckCj4gCj4gSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBpc3N1ZSwgcGxlYXNlIGFkZCB0aGUg
Zm9sbG93aW5nIHRhZyB0byB0aGUgY29tbWl0Ogo+IFJlcG9ydGVkLWJ5Ogo+IG1haWx0bzpzeXpi
b3QrMDEyMTgwMDNiZTc0YjVlMTIxM2FAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+IAo+IGV4
RkFULWZzIChsb29wMCk6IGZhaWxlZCB0byBsb2FkIHVwY2FzZSB0YWJsZSAoaWR4IDogMHgwMDAx
MDAwMCwgY2hrc3VtIDoKPiAweDcyNjA1MmQzLCB1dGJsX2Noa3N1bSA6IDB4ZTYxOWQzMGQpCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBC
VUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX19leGZhdF9nZXRfZGVudHJ5X3NldCsweDEwY2Ev
MHgxNGQwCj4gZnMvZXhmYXQvZGlyLmM6ODA0Cj4gIF9fZXhmYXRfZ2V0X2RlbnRyeV9zZXQrMHgx
MGNhLzB4MTRkMCBmcy9leGZhdC9kaXIuYzo4MDQKPiAgZXhmYXRfZ2V0X2RlbnRyeV9zZXQrMHg1
OC8weGVjMCBmcy9leGZhdC9kaXIuYzo4NTkKPiAgX19leGZhdF93cml0ZV9pbm9kZSsweDNjMS8w
eGUzMCBmcy9leGZhdC9pbm9kZS5jOjQ2Cj4gIF9fZXhmYXRfdHJ1bmNhdGUrMHg3ZjMvMHhiYjAg
ZnMvZXhmYXQvZmlsZS5jOjIxMQo+ICBleGZhdF90cnVuY2F0ZSsweGVlLzB4MmEwIGZzL2V4ZmF0
L2ZpbGUuYzoyNTcKPiAgZXhmYXRfd3JpdGVfZmFpbGVkIGZzL2V4ZmF0L2lub2RlLmM6NDIxIFtp
bmxpbmVdCj4gIGV4ZmF0X2RpcmVjdF9JTysweDVhMy8weDkwMCBmcy9leGZhdC9pbm9kZS5jOjQ4
NQo+ICBnZW5lcmljX2ZpbGVfZGlyZWN0X3dyaXRlKzB4Mjc1LzB4NmEwIG1tL2ZpbGVtYXAuYzoz
OTc3Cj4gIF9fZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIrMHgyNDIvMHg0NjAgbW0vZmlsZW1hcC5j
OjQxNDEKPiAgZXhmYXRfZmlsZV93cml0ZV9pdGVyKzB4ODk0LzB4ZmIwIGZzL2V4ZmF0L2ZpbGUu
Yzo1OTgKPiAgZG9faXRlcl9yZWFkdl93cml0ZXYrMHg4OGEvMHhhMzAKPiAgdmZzX3dyaXRldisw
eDU2YS8weDE0ZjAgZnMvcmVhZF93cml0ZS5jOjEwNjQKPiAgZG9fcHdyaXRldiBmcy9yZWFkX3dy
aXRlLmM6MTE2NSBbaW5saW5lXQo+ICBfX2RvX3N5c19wd3JpdGV2MiBmcy9yZWFkX3dyaXRlLmM6
MTIyNCBbaW5saW5lXQo+ICBfX3NlX3N5c19wd3JpdGV2MisweDI4MC8weDQ3MCBmcy9yZWFkX3dy
aXRlLmM6MTIxNQo+ICBfX3g2NF9zeXNfcHdyaXRldjIrMHgxMWYvMHgxYTAgZnMvcmVhZF93cml0
ZS5jOjEyMTUKPiAgeDY0X3N5c19jYWxsKzB4MmVkYi8weDNiYTAKPiBhcmNoL3g4Ni9pbmNsdWRl
L2dlbmVyYXRlZC9hc20vc3lzY2FsbHNfNjQuaDozMjkKPiAgZG9fc3lzY2FsbF94NjQgYXJjaC94
ODYvZW50cnkvY29tbW9uLmM6NTIgW2lubGluZV0KPiAgZG9fc3lzY2FsbF82NCsweGNkLzB4MWUw
IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjgzCj4gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDc3LzB4N2YKPiAKPiBVbmluaXQgd2FzIHN0b3JlZCB0byBtZW1vcnkgYXQ6Cj4gIG1l
bWNweV90b19pdGVyIGxpYi9pb3ZfaXRlci5jOjY1IFtpbmxpbmVdCj4gIGl0ZXJhdGVfYnZlYyBp
bmNsdWRlL2xpbnV4L2lvdl9pdGVyLmg6MTIzIFtpbmxpbmVdCj4gIGl0ZXJhdGVfYW5kX2FkdmFu
Y2UyIGluY2x1ZGUvbGludXgvaW92X2l0ZXIuaDozMDQgW2lubGluZV0KPiAgaXRlcmF0ZV9hbmRf
YWR2YW5jZSBpbmNsdWRlL2xpbnV4L2lvdl9pdGVyLmg6MzI4IFtpbmxpbmVdCj4gIF9jb3B5X3Rv
X2l0ZXIrMHhlNTMvMHgyYjMwIGxpYi9pb3ZfaXRlci5jOjE4NQo+ICBjb3B5X3BhZ2VfdG9faXRl
cisweDQxOS8weDg4MCBsaWIvaW92X2l0ZXIuYzozNjIKPiAgc2htZW1fZmlsZV9yZWFkX2l0ZXIr
MHhhMDkvMHgxMmIwIG1tL3NobWVtLmM6MzE2Nwo+ICBkb19pdGVyX3JlYWR2X3dyaXRldisweDg4
YS8weGEzMAo+ICB2ZnNfaXRlcl9yZWFkKzB4Mjc4LzB4NzYwIGZzL3JlYWRfd3JpdGUuYzo5MjMK
PiAgbG9fcmVhZF9zaW1wbGUgZHJpdmVycy9ibG9jay9sb29wLmM6MjgzIFtpbmxpbmVdCj4gIGRv
X3JlcV9maWxlYmFja2VkIGRyaXZlcnMvYmxvY2svbG9vcC5jOjUxNiBbaW5saW5lXQo+ICBsb29w
X2hhbmRsZV9jbWQgZHJpdmVycy9ibG9jay9sb29wLmM6MTkxMCBbaW5saW5lXQo+ICBsb29wX3By
b2Nlc3Nfd29yaysweDIwZmMvMHgzNzUwIGRyaXZlcnMvYmxvY2svbG9vcC5jOjE5NDUKPiAgbG9v
cF9yb290Y2dfd29ya2ZuKzB4MmIvMHg0MCBkcml2ZXJzL2Jsb2NrL2xvb3AuYzoxOTc2Cj4gIHBy
b2Nlc3Nfb25lX3dvcmsga2VybmVsL3dvcmtxdWV1ZS5jOjMyMjkgW2lubGluZV0KPiAgcHJvY2Vz
c19zY2hlZHVsZWRfd29ya3MrMHhhZTAvMHgxYzQwIGtlcm5lbC93b3JrcXVldWUuYzozMzEwCj4g
IHdvcmtlcl90aHJlYWQrMHhlYTcvMHgxNGYwIGtlcm5lbC93b3JrcXVldWUuYzozMzkxCj4gIGt0
aHJlYWQrMHgzZTIvMHg1NDAga2VybmVsL2t0aHJlYWQuYzozODkKPiAgcmV0X2Zyb21fZm9yaysw
eDZkLzB4OTAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDcKPiAgcmV0X2Zyb21fZm9ya19h
c20rMHgxYS8weDMwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ0Cj4gCj4gVW5pbml0IHdh
cyBzdG9yZWQgdG8gbWVtb3J5IGF0Ogo+ICBtZW1jcHlfZnJvbV9pdGVyIGxpYi9pb3ZfaXRlci5j
OjczIFtpbmxpbmVdCj4gIGl0ZXJhdGVfYnZlYyBpbmNsdWRlL2xpbnV4L2lvdl9pdGVyLmg6MTIz
IFtpbmxpbmVdCj4gIGl0ZXJhdGVfYW5kX2FkdmFuY2UyIGluY2x1ZGUvbGludXgvaW92X2l0ZXIu
aDozMDQgW2lubGluZV0KPiAgaXRlcmF0ZV9hbmRfYWR2YW5jZSBpbmNsdWRlL2xpbnV4L2lvdl9p
dGVyLmg6MzI4IFtpbmxpbmVdCj4gIF9fY29weV9mcm9tX2l0ZXIgbGliL2lvdl9pdGVyLmM6MjQ5
IFtpbmxpbmVdCj4gIGNvcHlfcGFnZV9mcm9tX2l0ZXJfYXRvbWljKzB4MTJiNy8weDMxMDAgbGli
L2lvdl9pdGVyLmM6NDgxCj4gIGNvcHlfZm9saW9fZnJvbV9pdGVyX2F0b21pYyBpbmNsdWRlL2xp
bnV4L3Vpby5oOjIwMSBbaW5saW5lXQo+ICBnZW5lcmljX3BlcmZvcm1fd3JpdGUrMHg4ZDEvMHgx
MDgwIG1tL2ZpbGVtYXAuYzo0MDY2Cj4gIHNobWVtX2ZpbGVfd3JpdGVfaXRlcisweDJiYS8weDJm
MCBtbS9zaG1lbS5jOjMyMjEKPiAgZG9faXRlcl9yZWFkdl93cml0ZXYrMHg4OGEvMHhhMzAKPiAg
dmZzX2l0ZXJfd3JpdGUrMHg0NGQvMHhkNDAgZnMvcmVhZF93cml0ZS5jOjk4OAo+ICBsb193cml0
ZV9idmVjIGRyaXZlcnMvYmxvY2svbG9vcC5jOjI0MyBbaW5saW5lXQo+ICBsb193cml0ZV9zaW1w
bGUgZHJpdmVycy9ibG9jay9sb29wLmM6MjY0IFtpbmxpbmVdCj4gIGRvX3JlcV9maWxlYmFja2Vk
IGRyaXZlcnMvYmxvY2svbG9vcC5jOjUxMSBbaW5saW5lXQo+ICBsb29wX2hhbmRsZV9jbWQgZHJp
dmVycy9ibG9jay9sb29wLmM6MTkxMCBbaW5saW5lXQo+ICBsb29wX3Byb2Nlc3Nfd29yaysweDE1
ZTYvMHgzNzUwIGRyaXZlcnMvYmxvY2svbG9vcC5jOjE5NDUKPiAgbG9vcF9yb290Y2dfd29ya2Zu
KzB4MmIvMHg0MCBkcml2ZXJzL2Jsb2NrL2xvb3AuYzoxOTc2Cj4gIHByb2Nlc3Nfb25lX3dvcmsg
a2VybmVsL3dvcmtxdWV1ZS5jOjMyMjkgW2lubGluZV0KPiAgcHJvY2Vzc19zY2hlZHVsZWRfd29y
a3MrMHhhZTAvMHgxYzQwIGtlcm5lbC93b3JrcXVldWUuYzozMzEwCj4gIHdvcmtlcl90aHJlYWQr
MHhlYTcvMHgxNGYwIGtlcm5lbC93b3JrcXVldWUuYzozMzkxCj4gIGt0aHJlYWQrMHgzZTIvMHg1
NDAga2VybmVsL2t0aHJlYWQuYzozODkKPiAgcmV0X2Zyb21fZm9yaysweDZkLzB4OTAgYXJjaC94
ODYva2VybmVsL3Byb2Nlc3MuYzoxNDcKPiAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGFy
Y2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ0Cj4gCj4gVW5pbml0IHdhcyBjcmVhdGVkIGF0Ogo+
ICBfX2FsbG9jX3BhZ2VzX25vcHJvZisweDlkNi8weGU3MCBtbS9wYWdlX2FsbG9jLmM6NDc1Ngo+
ICBhbGxvY19wYWdlc19tcG9sX25vcHJvZisweDI5OS8weDk5MCBtbS9tZW1wb2xpY3kuYzoyMjY1
Cj4gIGFsbG9jX3BhZ2VzX25vcHJvZiBtbS9tZW1wb2xpY3kuYzoyMzQ1IFtpbmxpbmVdCj4gIGZv
bGlvX2FsbG9jX25vcHJvZisweDFkYi8weDMxMCBtbS9tZW1wb2xpY3kuYzoyMzUyCj4gIGZpbGVt
YXBfYWxsb2NfZm9saW9fbm9wcm9mKzB4YTYvMHg0NDAgbW0vZmlsZW1hcC5jOjEwMTAKPiAgX19m
aWxlbWFwX2dldF9mb2xpbysweGFjNC8weDE1NTAgbW0vZmlsZW1hcC5jOjE5NTIKPiAgYmxvY2tf
d3JpdGVfYmVnaW4rMHg2ZS8weDJiMCBmcy9idWZmZXIuYzoyMjI2Cj4gIGV4ZmF0X3dyaXRlX2Jl
Z2luKzB4ZmIvMHg0MDAgZnMvZXhmYXQvaW5vZGUuYzo0MzQKPiAgZXhmYXRfZXh0ZW5kX3ZhbGlk
X3NpemUgZnMvZXhmYXQvZmlsZS5jOjU1MyBbaW5saW5lXQo+ICBleGZhdF9maWxlX3dyaXRlX2l0
ZXIrMHg0NzQvMHhmYjAgZnMvZXhmYXQvZmlsZS5jOjU4OAo+ICBkb19pdGVyX3JlYWR2X3dyaXRl
disweDg4YS8weGEzMAo+ICB2ZnNfd3JpdGV2KzB4NTZhLzB4MTRmMCBmcy9yZWFkX3dyaXRlLmM6
MTA2NAo+ICBkb19wd3JpdGV2IGZzL3JlYWRfd3JpdGUuYzoxMTY1IFtpbmxpbmVdCj4gIF9fZG9f
c3lzX3B3cml0ZXYyIGZzL3JlYWRfd3JpdGUuYzoxMjI0IFtpbmxpbmVdCj4gIF9fc2Vfc3lzX3B3
cml0ZXYyKzB4MjgwLzB4NDcwIGZzL3JlYWRfd3JpdGUuYzoxMjE1Cj4gIF9feDY0X3N5c19wd3Jp
dGV2MisweDExZi8weDFhMCBmcy9yZWFkX3dyaXRlLmM6MTIxNQo+ICB4NjRfc3lzX2NhbGwrMHgy
ZWRiLzB4M2JhMAo+IGFyY2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9zeXNjYWxsc182NC5o
OjMyOQo+ICBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo1MiBbaW5saW5l
XQo+ICBkb19zeXNjYWxsXzY0KzB4Y2QvMHgxZTAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODMK
PiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3Zgo+IAo+IENQVTogMCBV
SUQ6IDAgUElEOiA1MTg4IENvbW06IHN5ei1leGVjdXRvcjIyMSBOb3QgdGFpbnRlZAo+IDYuMTIu
MC1yYzEtc3l6a2FsbGVyLTAwMDMxLWdlMzJjZGU4ZDJiZDcgIzAKPiBIYXJkd2FyZSBuYW1lOiBH
b29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUwo+
IEdvb2dsZSAwOS8xMy8yMDI0Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KPiAKPiAKPiAtLS0KPiBUaGlzIHJlcG9ydCBpcyBnZW5lcmF0ZWQg
YnkgYSBib3QuIEl0IG1heSBjb250YWluIGVycm9ycy4KPiBTZWUKPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9nb28uZ2wvdHBzbUVKX187ISFKbW9aaVpHQnYzUnZLUlN4IV9F
Cj4gRk0zMUp4RElfc0JDNk5oV3dXSVdjamE4VVVWQlhaWVd5aEswTzl2VXVTc3F5LVpPbGE0VHVl
cE5UQTNYLQo+IGJ0Qm16ZVBNSU9EMENHZUdFMGtTRjRNMmhPd1Z5NTdtcjUwaExCRUh1JCBmb3Ig
bW9yZSBpbmZvcm1hdGlvbgo+IGFib3V0IHN5emJvdC4KPiBzeXpib3QgZW5naW5lZXJzIGNhbiBi
ZSByZWFjaGVkIGF0IG1haWx0bzpzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbS4KPiAKPiBzeXpi
b3Qgd2lsbCBrZWVwIHRyYWNrIG9mIHRoaXMgaXNzdWUuIFNlZToKPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9nb28uZ2wvdHBzbUVKKnN0YXR1c19fO0l3ISFKbW9aaVpHQnYz
Ugo+IHZLUlN4IV9FRk0zMUp4RElfc0JDNk5oV3dXSVdjamE4VVVWQlhaWVd5aEswTzl2VXVTc3F5
LVpPbGE0VHUKPiBlcE5UQTNYLWJ0Qm16ZVBNSU9EMENHZUdFMGtTRjRNMmhPd1Z5NTdtcjU1RXli
dWI4JCBmb3IgaG93IHRvCj4gY29tbXVuaWNhdGUgd2l0aCBzeXpib3QuCj4gCj4gSWYgdGhlIHJl
cG9ydCBpcyBhbHJlYWR5IGFkZHJlc3NlZCwgbGV0IHN5emJvdCBrbm93IGJ5IHJlcGx5aW5nIHdp
dGg6Cj4gI3N5eiBmaXg6IGV4YWN0LWNvbW1pdC10aXRsZQo+IAo+IElmIHlvdSB3YW50IHN5emJv
dCB0byBydW4gdGhlIHJlcHJvZHVjZXIsIHJlcGx5IHdpdGg6Cj4gI3N5eiB0ZXN0OiBnaXQ6Ly9y
ZXBvL2FkZHJlc3MuZ2l0IGJyYW5jaC1vci1jb21taXQtaGFzaAo+IElmIHlvdSBhdHRhY2ggb3Ig
cGFzdGUgYSBnaXQgcGF0Y2gsIHN5emJvdCB3aWxsIGFwcGx5IGl0IGJlZm9yZSB0ZXN0aW5nLgo+
IAo+IElmIHlvdSB3YW50IHRvIG92ZXJ3cml0ZSByZXBvcnQncyBzdWJzeXN0ZW1zLCByZXBseSB3
aXRoOgo+ICNzeXogc2V0IHN1YnN5c3RlbXM6IG5ldy1zdWJzeXN0ZW0KPiAoU2VlIHRoZSBsaXN0
IG9mIHN1YnN5c3RlbSBuYW1lcyBvbiB0aGUgd2ViIGRhc2hib2FyZCkKPiAKPiBJZiB0aGUgcmVw
b3J0IGlzIGEgZHVwbGljYXRlIG9mIGFub3RoZXIgb25lLCByZXBseSB3aXRoOgo+ICNzeXogZHVw
OiBleGFjdC1zdWJqZWN0LW9mLWFub3RoZXItcmVwb3J0Cj4gCj4gSWYgeW91IHdhbnQgdG8gdW5k
byBkZWR1cGxpY2F0aW9uLCByZXBseSB3aXRoOgo+ICNzeXogdW5kdXAK

--_002_PUZPR04MB6316D062F577B655E85385E381442PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="0001-exfat-do-not-update-valid_size-in-exfat_get_block-if.patch"
Content-Description:
 0001-exfat-do-not-update-valid_size-in-exfat_get_block-if.patch
Content-Disposition: attachment;
	filename="0001-exfat-do-not-update-valid_size-in-exfat_get_block-if.patch";
	size=2488; creation-date="Mon, 14 Oct 2024 06:32:53 GMT";
	modification-date="Mon, 14 Oct 2024 06:32:53 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMWY2MWU5ZmQ2ODI1ODU4ODkxMGMwNWRjYmQ1MGFmMzgxZmU4Yjk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTQgT2N0IDIwMjQgMTI6NTI6MjggKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogZG8gbm90IHVwZGF0ZSAtPnZhbGlkX3NpemUgaW4gZXhmYXRfZ2V0X2Jsb2NrKCkgaWYgbWFw
CiBmb3IgZGlyZWN0IHdyaXRlCgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcu
TW9Ac29ueS5jb20+Ci0tLQogZnMvZXhmYXQvaW5vZGUuYyB8IDI0ICsrKysrKysrKysrKysrKysr
KystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMKaW5kZXgg
ZDMzOGE1OWMyN2Y3Li42ZTEzMTJmMzA4NDYgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMK
KysrIGIvZnMvZXhmYXQvaW5vZGUuYwpAQCAtMjYxLDggKzI2MSw4IEBAIHN0YXRpYyBpbnQgZXhm
YXRfbWFwX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNsdV9vZmZz
ZXQsCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgZXhmYXRfZ2V0X2Jsb2NrKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHNlY3Rvcl90IGlibG9jaywKLQkJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaF9y
ZXN1bHQsIGludCBjcmVhdGUpCitzdGF0aWMgaW50IF9fZXhmYXRfZ2V0X2Jsb2NrKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHNlY3Rvcl90IGlibG9jaywKKwkJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaF9y
ZXN1bHQsIGludCBjcmVhdGUsIGJvb2wgZGlvKQogewogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZv
ICplaSA9IEVYRkFUX0koaW5vZGUpOwogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+
aV9zYjsKQEAgLTMyMyw4ICszMjMsMTAgQEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3Ry
dWN0IGlub2RlICppbm9kZSwgc2VjdG9yX3QgaWJsb2NrLAogCQkvKiBUaGUgYXJlYSBoYXMgbm90
IGJlZW4gd3JpdHRlbiwgbWFwIGFuZCBtYXJrIGFzIG5ldy4gKi8KIAkJc2V0X2J1ZmZlcl9uZXco
YmhfcmVzdWx0KTsKIAotCQllaS0+dmFsaWRfc2l6ZSA9IEVYRkFUX0JMS19UT19CKGlibG9jayAr
IG1heF9ibG9ja3MsIHNiKTsKLQkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7CisJCWlmICghZGlv
KSB7CisJCQllaS0+dmFsaWRfc2l6ZSA9IEVYRkFUX0JMS19UT19CKGlibG9jayArIG1heF9ibG9j
a3MsIHNiKTsKKwkJCW1hcmtfaW5vZGVfZGlydHkoaW5vZGUpOworCQl9CiAJfSBlbHNlIHsKIAkJ
dmFsaWRfYmxrcyA9IEVYRkFUX0JfVE9fQkxLKGVpLT52YWxpZF9zaXplLCBzYik7CiAKQEAgLTM4
MSw2ICszODMsMTggQEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3RydWN0IGlub2RlICpp
bm9kZSwgc2VjdG9yX3QgaWJsb2NrLAogCXJldHVybiBlcnI7CiB9CiAKK3N0YXRpYyBpbnQgZXhm
YXRfZ2V0X2Jsb2NrKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNlY3Rvcl90IGlibG9jaywKKwkJc3Ry
dWN0IGJ1ZmZlcl9oZWFkICpiaF9yZXN1bHQsIGludCBjcmVhdGUpCit7CisJcmV0dXJuIF9fZXhm
YXRfZ2V0X2Jsb2NrKGlub2RlLCBpYmxvY2ssIGJoX3Jlc3VsdCwgY3JlYXRlLCBmYWxzZSk7Cit9
CisKK3N0YXRpYyBpbnQgZXhmYXRfZ2V0X2Jsb2NrX2Zvcl9kaW8oc3RydWN0IGlub2RlICppbm9k
ZSwgc2VjdG9yX3QgaWJsb2NrLAorCQlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoX3Jlc3VsdCwgaW50
IGNyZWF0ZSkKK3sKKwlyZXR1cm4gX19leGZhdF9nZXRfYmxvY2soaW5vZGUsIGlibG9jaywgYmhf
cmVzdWx0LCBjcmVhdGUsIHRydWUpOworfQorCiBzdGF0aWMgaW50IGV4ZmF0X3JlYWRfZm9saW8o
c3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBmb2xpbyAqZm9saW8pCiB7CiAJcmV0dXJuIG1wYWdl
X3JlYWRfZm9saW8oZm9saW8sIGV4ZmF0X2dldF9ibG9jayk7CkBAIC00NzksNyArNDkzLDcgQEAg
c3RhdGljIHNzaXplX3QgZXhmYXRfZGlyZWN0X0lPKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0
IGlvdl9pdGVyICppdGVyKQogCSAqIE5lZWQgdG8gdXNlIHRoZSBESU9fTE9DS0lORyBmb3IgYXZv
aWRpbmcgdGhlIHJhY2UKIAkgKiBjb25kaXRpb24gb2YgZXhmYXRfZ2V0X2Jsb2NrKCkgYW5kIC0+
dHJ1bmNhdGUoKS4KIAkgKi8KLQlyZXQgPSBibG9ja2Rldl9kaXJlY3RfSU8oaW9jYiwgaW5vZGUs
IGl0ZXIsIGV4ZmF0X2dldF9ibG9jayk7CisJcmV0ID0gYmxvY2tkZXZfZGlyZWN0X0lPKGlvY2Is
IGlub2RlLCBpdGVyLCBleGZhdF9nZXRfYmxvY2tfZm9yX2Rpbyk7CiAJaWYgKHJldCA8IDApIHsK
IAkJaWYgKHJ3ID09IFdSSVRFICYmIHJldCAhPSAtRUlPQ0JRVUVVRUQpCiAJCQlleGZhdF93cml0
ZV9mYWlsZWQobWFwcGluZywgc2l6ZSk7Ci0tIAoyLjM0LjEKCg==

--_002_PUZPR04MB6316D062F577B655E85385E381442PUZPR04MB6316apcp_--

