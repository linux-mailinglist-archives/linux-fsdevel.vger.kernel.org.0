Return-Path: <linux-fsdevel+bounces-13442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43A870082
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ED4284650
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569AC3A1A6;
	Mon,  4 Mar 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hEthvDQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817839FCD
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552314; cv=fail; b=lfMrls8gInc7Y7jgBOVAL7dAD8k2K37FG/40lWQX9Sqyakx5uLIIvp26Mlt/QhG46zAp5r9p2WojI9FTrgCAsjpsFaMUR+mpGIFiNTBl6ukmx09du4v5LowK2QvgTTHeUZMYFbexIQSVFTFeS/1MCffz8HbIe8ae5tz/7JOBCSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552314; c=relaxed/simple;
	bh=NAfrfZBAeqD4UuoFOuWcFBXjZW8u7ajPEQYDAjeBh/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JE8UVWk/z2uYuhJYF1/NBB+XUx1SWFRoiUhA9ezwx0B3UGAStfQXsvdhQNH+Wv+9WJT22FXDc8YelK+Y5I+SVMeZ+nM6Ak2nQCEkgbQePqkPWP3/HEqRHWRdHY8RnukOa+7s5wq9451TelRiWJ7G5NYcLmdkfnK+9xVfgzvj5qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hEthvDQi; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4249uwDI008507;
	Mon, 4 Mar 2024 11:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=NAfrfZBAeqD4UuoFOuWcFBXjZW8u7ajPEQYDAjeBh/0=;
 b=hEthvDQijENevkDIb3s/U/DxbUbbCpuwjfeG4qD15oHBDTyyWPdjA6kuDdKjXZdHeIzD
 xX/NxPXG/DjJzW0j5S6jVHgE6L491q6wdQ2YJEYk+okegNTVm4/5MdzGs10AaV4ZU9pn
 Gn1Ty2wOTJ1UwihmGQlo/YPg4qh+Us4t+eHXlz7SQcTyVcicKv+pDBFCwRrKzFuo3Dw3
 fAvk403PDG5//yHeHtm4FdQ8cu4WGLWF62dgMUcLGPVOs/QXWoxaxkOZbWQu92N6ITUv
 fXFfoMOPW7Qzo2n3F7Zy681USpyNaH7PKIzdrcPF3cpJ496FnsF4QYyvWvoeaJAtVYn6 8Q== 
Received: from hk2pr02cu002.outbound.protection.outlook.com (mail-eastasiaazlp17012018.outbound.protection.outlook.com [40.93.128.18])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wksc11ske-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 11:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvBKiY+Qff4ZgZXDZWm/QogZIs6+1H1Ar64YAFrf/U+WKtZSTnyN2QbzAsRZbnThfnwIXwBYwg1ZXhJuMS0CCDUfPeT2nnc8L1qzwVLhoGeT7z165Xu22VBKvMcoiGOIzQgolMjKudbjYaMrmyOhFvmIFd8eKKdSo2k44rml35W2+H30q5prIenLIGb1wK14NiHtnVM3WhHOSv+UtfJ3/VOX84Ok7KQ0kpBWBiwSlpAiM6lrE8wyGBUdvc9Z69U2e+26n++1UdJ8Sz0Mi4oMGjAyH65R1/PWEdq1QTqpYASBWCW0thd+Nq43al2N1saQimUxTP7K2V2ee/uqqAkvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAfrfZBAeqD4UuoFOuWcFBXjZW8u7ajPEQYDAjeBh/0=;
 b=I+B6kIFg+WLVs775VkhQ5lN0e/uGV3AOSAQBy36gqQiOGBQnmORwfzwXHHMpZRuq7bFngSjI0eH2z/n5QONY52x3jgAN+WKsZARC/+zwNJoVQvcidktoCfmknV87CVg60pfej+ZDNLlg6FFEhOb/yc52bQ+sjqMhkzoVFwQCgtAFCY24ONzCKCFyv2SXx834e0jZ6Q6LRXwRvzCAQcrfB+/biMnlX5x3g/KP9CCGtb7T0laUyzZIOR5QMRzkTDHhty1VxNhwOCT8xIwc7X4yNWpHVNg5tvbe0ET5OgHMaw26S1oaxorzP09aBo9fCo/P9zy9ZsEcQx0+D44+noOYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6122.apcprd04.prod.outlook.com (2603:1096:101:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 11:37:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:37:54 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: AQHabfTBkMYHj72XUE6nA81OpkBY9LEnLUGQgAAWuwCAACcu8A==
Date: Mon, 4 Mar 2024 11:37:54 +0000
Message-ID: 
 <PUZPR04MB631617947452ADC288E8FD9281232@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcms1p1>
	<1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
	<PUZPR04MB63166D7502785B1D91C962D181232@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1891546521.01709541901716.JavaMail.epsvc@epcpadp3>
In-Reply-To: <1891546521.01709541901716.JavaMail.epsvc@epcpadp3>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6122:EE_
x-ms-office365-filtering-correlation-id: c2e8ca22-7366-4826-dfaa-08dc3c3f882a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jwKMJMdX5wk5zfi6WrD5+M3Hy7VqMBwvjsMKhHBnGgb6xw/GAZ+8M3V++EncFHYpGHGCY/PBfx5gn+cO9R6KDDvlwPEYYG1o9iHsuvi0bSrXQK+Hxs8gZnUNTgnbDlZNGE8rp0C1r+ccBvNWXWCDFvFfJofBAm0vb5gnFB+foM9esuZn9P1I9yctKHrmYzsRBU+lsHWQ7gP5wjr+eZSMRsAU7YK9wbrI7JPylQc8LxxUW2IyTG5BWYH/djYSQQD1LklnZtYnsw07ExPR1AGVudxs3ClAmIz0WWBxgjImFnyYAsMY5F3IYRZiZxIyKP8T7rTvFUzaeaHH3cKAuGviwV7ykunFgtzE+I5/h+12SgOM35iZ/0lL/a3zojLmJYkC7WwUgrv05kYoOMlLSBuuRddneDlvHF3Ot/r3omv9L9L+DltpsJPwcDb20GEeJiiyc9G8MxOngIy+yxFeGYfafoafGbBk/XT3zdXOo0RE7Eq65GVfYBUam4JiMVqnXnLXG0CqDOP+LEbKCzpzQECB2Sq3EUoZVE9Q/VmbGMpf0UFILIyjcXHO0vbWY0uy3Y5qiYJSslrw6+Kr1SqYP2xviAnr8jtzTHEQDjSn8JcQhxPFNl+wTi4fdMyzmmhTg3MO7yXJGKur+Rg/Yb03nOAk3RQfu+Z+EaavMG8bD8LiUc6Ew4GfQ/GgckwtJh2YOLaazSUZgxCMqGL3dufzmhiVlH69picufK1BGokiDB6Cers=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?Q1BEWlRLa05IeU5zUCttNGJwYUNEY2ZsRWUxMWNzallsVzVBNWFTYjdsZzA3?=
 =?gb2312?B?M2xJZTc1RWl6NkRhcEZhZ0ZjNlc4L240aWJadU1FQW9jNjRldUNpZU5OWkRV?=
 =?gb2312?B?OTQ5Z3p3TW5Ub0F6ZCtCVE5Ubkw3WWVSM1dLYmxPVHhYRnBxalVVaTNtQVJT?=
 =?gb2312?B?bUEvclVPa3F6MTNzSk1PNlp4V3liZ1YyYjUzdy9FUmxWdk5uZnB4N2grVllZ?=
 =?gb2312?B?L1c1a09aMkRpenM5cVZ4ZjU5VHVoUTlkRjdGQUczeHRSalJsRlA3KzRrcndU?=
 =?gb2312?B?WW0rKytJMk5JeVVjRjFwK1JLZXk4bC82S3c1aWs3TDBaaTZ4VnMrZElXb0dG?=
 =?gb2312?B?K3pFeWU4eDIzdXh0WldZWHNubDhXdG1JTCtiRFo1WGRSWFB2djc2b0lTS3B3?=
 =?gb2312?B?Z2tORXBQQXQyeTdpSnVMd1hBRlB5cVpKM29zV2JmL1A3ZXNlQ2FialFaNU1F?=
 =?gb2312?B?QUJCOGtVdWJhV3crSkM2akkrL1VMSDhNV2RFdEhzeHpORFNBVUJVVWI2RDll?=
 =?gb2312?B?QVRReGxvSy9KN1ZQYjRCSllNRWRXQ1ZLSzVUNURranRaMXM2dGRreDEreU1n?=
 =?gb2312?B?dG9QdkM3cWpNM2llRUVNQVk4eUZIdElLZkplU1RoVVUweE9rWW9reEd6N0VE?=
 =?gb2312?B?MUpXTlBCWnQvYkUwdStldi9UQmd6R3JiN3dRalpISVZvR1I3UEVPemprd0Uw?=
 =?gb2312?B?UE9HYzJrMVcyN3pBS0MwWGhNNFgxWHc3VnFhWE5SdXFJMkN6dDV3SVVMdVpX?=
 =?gb2312?B?VVB6bzhPU2dyMjNXTEwxRHlJOFI5MjA0aWVFOWNMOFkrc2dYZVExR3lrR0pY?=
 =?gb2312?B?bklvVnBZL3g0YTFMaGlEOFpqeFJnTFh4K21xNElSY2syQXlHaUFCcFhEN2F2?=
 =?gb2312?B?Y2haYnRZcWloOTVIenM1YWRDQ2d5YVVpZzljelcrYWJtOVZxb2lOSzhkTVVW?=
 =?gb2312?B?MG5ra00zV2tKV2psS0M3RmFlL2xGRFBoRW5vMTZwYjdoM25VcEx3K3FTYWRp?=
 =?gb2312?B?NGVHWXFPcFBXelJrTDgxUHVhMHY4K0F5VnFpVExlQytsYnhWYkFweDVYOXRO?=
 =?gb2312?B?eEw0RHM0aUV4bHRzeitoZCsxRXc5dEMvOENIY1NlN3pxOUZxZWRIYlhMak1a?=
 =?gb2312?B?bStIdjQ1dkVkSlJaMjFMMDJORjlNWStvQndzTEFSUHh1eUhKTnZocnJWSjA4?=
 =?gb2312?B?UHFRamZKa2szS2V5OGZVUU4xQnFMaC9MbnVhQmdLelVKRnJOdC9HT2VkbklW?=
 =?gb2312?B?cENRN3liWnhPdVVwSURjckZoSHVtNzV6VTNyZ25tSENUbSs4ZTVOcFJ4djRQ?=
 =?gb2312?B?YWdVbk9ONFJPK3I5bnlpeU05SG9naWJNRS95aVFWYlJGVmhEK0x1RUk1dExm?=
 =?gb2312?B?aFIyRU0yb1lCd0t6UmtxN1RGajhZNGxiODRIcGd6YXkyaWk1WU91eGJPR2l6?=
 =?gb2312?B?dDZMUzIvdWx5SHN3THFBQ1hyOXlHQk5UcllzN0w1TytPQnozU0toSXQ1eHBu?=
 =?gb2312?B?SU5Ga2x4OUQxZU9JWXRkM1NQck5talZYSWY1eVNHc3MvT3hZQ3VCWE1pemRH?=
 =?gb2312?B?RUdnMlJQdVg4MGRkcTZRRllIQ3dhU0h1N3R0ajFQS0E0RVI3SUVMdis4L3JT?=
 =?gb2312?B?Qmoxbk4vczJPSStic1VEUWxHY3MrTzcyaWVYQXQ4REhIWEY3UVljVmtqVTNa?=
 =?gb2312?B?RytyZzc3bllsMENjYi9MaVoydUViOERPcXZuTGVsRndScnJURW5kR2FJbEZL?=
 =?gb2312?B?MDgvbHlzUnRqUmxZRGdYajZrY2VxYithUCthQzM0WmRRMnJybFRlbEw1MTE4?=
 =?gb2312?B?MHpJcE9Sa29raFlkOVRKRkdDTkVKTGdKWjZjbnNKWlNKRHo1Z3lwN0hKaVZN?=
 =?gb2312?B?TXlrR2x3SE1pQUxuL2JpazNYMlBScXZFL0lla3NPYjlNd0NmSEJCbFNUdXBE?=
 =?gb2312?B?ZXVCNVN1YmpPNE55NEFSOEl4aTloVTNFRy9ScmJXWTU3QVY3bm0yK25UMTIy?=
 =?gb2312?B?SitVTUMybkIxWVpPSEdhS2Y2dUJyQVRLY0M2bGFlMDY4MythdUcwenlxK1pp?=
 =?gb2312?B?SkdpZXc5ZjZJUEtRZ0pSeGphQ2wxZ0xnUkRMNjVVeGpvSkpOQk9ESi9sMTNC?=
 =?gb2312?B?L09VTkorWHdYVG5HcERZMExsSElKQ1h4enpYNGthTkU5dGFTK2tmOTdyVHE2?=
 =?gb2312?Q?h85S4/VVY37C3Cr5cBcS0Vo=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HwEaCpYDVG4QL1X41tw2FfP06TG4M1t+8829AZZIQmkRF286qgDNUbPy0tB0Rl8RL15FaUqWjWoEXW/OZc4/6IRuuap3vvzn1lcVen23+FtehJoNRRAdBn/oD0AReEv/EVubDpvbKiE0hqOZRJLUEa+j1sOUHaC1+sJgo5hONWKnfpO/9Bpob0e3vFNM9/OBPAcjhkNzjrd8Ofba2NARCMTEyY7NN+tmX6HnrsiROeJjIa2qPqBnxJzKvNxguVw3grpdn1Oh+M+ZnPUDPAVFXts4Lk2u+f+5WcJB09RWihgj0V0by/IamTzL5OKGkb5gyHw0emyEyI6J8JXo8AQR3GzBcmSxGhcMsMIFyd6yABZjgNPeB6qiisTSBHSvXoi7m6MKcon4zuNwSJtLk/cw6JOaXGfNKo6Co/SXO/5C1AL9M/oNjFGrEjWU+meB2SmXnKE3Kv6maCxYGz0gp3EhQvJLw4GcgBO43uEIkdY0kUBu98lxrDxMHgefWxdnILxCigxZJ5xqhCi7xW0nnsQu1ktbExTKBFcB2ifpfm1MZHIOqu2WOGMxAQ5Nj6o8+7PzEghdG9oEwHyNiVsXyZT/nlBIJYJe0PeFTqgGdPPpJ4m17ZEpyefY6r3VI43o/1Fx
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8ca22-7366-4826-dfaa-08dc3c3f882a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:37:54.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +trhdJJDB9EUqtotGg3Xg9qlzcSFFNy3M8k46EvqJd3zGYkFYYRf0x2Bibq4XN93F7nK1EU+J35ZjrVSqBLAIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6122
X-Proofpoint-ORIG-GUID: hYl8_zP9HkdUAtAHfoUMWOUTN7k5SPfM
X-Proofpoint-GUID: hYl8_zP9HkdUAtAHfoUMWOUTN7k5SPfM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: hYl8_zP9HkdUAtAHfoUMWOUTN7k5SPfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-04_01,2023-05-22_02

PiBGcm9tOiBTdW5nam9uZyBTZW8gPHNqMTU1Ny5zZW9Ac2Ftc3VuZy5jb20+Cj4gU2VudDogTW9u
ZGF5LCBNYXJjaCA0LCAyMDI0IDQ6NDMgUE0KPiBUbzogTW8sIFl1ZXpoYW5nIDxZdWV6aGFuZy5N
b0Bzb255LmNvbT47IGxpbmtpbmplb25Aa2VybmVsLm9yZwo+Cj4gPgo+ID4gVGhlIGZvbGxvd2lu
ZyBjb2RlIHN0aWxsIGV4aXN0cyBpZiB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0LiBJdCBkb2VzIG5v
dAo+ID4gYWxsb3cgZGVsZXRlZCBkZW50cmllcyB0byBmb2xsb3cgdW51c2VkIGRlbnRyaWVzLgo+
IAo+IEl0IG1heSBiZSB0aGUgc2FtZSBwYXJ0IGFzIHRoZSBjb2RlIHlvdSBtZW50aW9uZWQsIGJ1
dCByZW1lbWJlciB0aGF0Cj4gdGhlIGZpcnN0IGlmLXN0YXRlbWVudCBoYW5kbGVzIGJvdGggYW4g
dW51c2VkIGRlbnRyeSBhbmQKPiBhIGRlbGV0ZWQgZGVudHJ5IHRvZ2V0aGVyLgoKVGhhbmtzIGZv
ciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uLiAKCkkgd2lsbCB1cGRhdGUgdGhlIGNvZGUgYXMg
Zm9sbG93cywgYW5kIEkgdGhpbmsgaXQgaXMgdmVyeSBuZWNlc3NhcnkgdG8gYWRkIHN1Y2gKY29t
bWVudHMuCgogICAgICAgIGZvciAoaSA9IDA7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgewog
ICAgICAgICAgICAgICAgZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7CiAgICAg
ICAgICAgICAgICBpZiAoZXAtPnR5cGUgPT0gRVhGQVRfVU5VU0VEKQogICAgICAgICAgICAgICAg
ICAgICAgICB1bnVzZWRfaGl0ID0gdHJ1ZTsKICAgICAgICAgICAgICAgIGVsc2UgaWYgKElTX0VY
RkFUX0RFTEVURUQoZXAtPnR5cGUpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIC8qCiAgICAg
ICAgICAgICAgICAgICAgICAgICAqIEFsdGhvdWdoIGl0IHZpb2xhdGVzIHRoZSBzcGVjaWZpY2F0
aW9uIGZvciBhCiAgICAgICAgICAgICAgICAgICAgICAgICAqIGRlbGV0ZWQgZW50cnkgdG8gZm9s
bG93IGFuIHVudXNlZCBlbnRyeSwgc29tZQogICAgICAgICAgICAgICAgICAgICAgICAgKiBleEZB
VCBpbXBsZW1lbnRhdGlvbnMgY291bGQgd29yayBsaWtlIHRoaXMuCiAgICAgICAgICAgICAgICAg
ICAgICAgICAqIFRoZXJlZm9yZSwgdG8gaW1wcm92ZSBjb21wYXRpYmlsaXR5LCBhbGxvdyBpdC4K
ICAgICAgICAgICAgICAgICAgICAgICAgICovCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICh1
bnVzZWRfaGl0KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwogICAg
ICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICAgICAgLyogVXNlZCBlbnRy
eSBhcmUgbm90IGFsbG93ZWQgdG8gZm9sbG93IHVudXNlZCBlbnRyeSAqLwogICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodW51c2VkX2hpdCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGVycl91c2VkX2ZvbGxvd191bnVzZWQ7CgogICAgICAgICAgICAgICAgICAgICAgICBp
Kys7CiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gY291bnRfc2tpcF9lbnRyaWVzOwogICAg
ICAgICAgICAgICAgfQogICAgICAgIH0=

