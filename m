Return-Path: <linux-fsdevel+bounces-16304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0589ADDF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D772821BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E09EDB;
	Sun,  7 Apr 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="RpHrvqeC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC814A3D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453439; cv=fail; b=UpqayJs2urz/QM06SWXxHtHCNaAqlHglFe8hdZtJc/Q7T/FrpBKdiBuXB7wyzriR1gRrQW03jD+l+G0rPHyG8//pRojVw0ShtkQRfSU6lzTpLNUjD+vQYUuR8vCy1zjWtgIdCnamoZNp507uUakeHNx/UH2SeTasL2074oVdL3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453439; c=relaxed/simple;
	bh=O7AbvHtZKNMfVRRClRPCyyc8duIr5fJq5H21v05lb1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=peedDS2BfZeQ8zxyiABptKXYwKPX1QafXAHbQDxkWeAMQCLkZejheLJmG0q1d91Y6DMiIdstZj6gTGHAQ9gFoO68Zrsq5Hynmakq4WryDZcihpLhnIALM5GmRINDbioRL7pS6JJIEuDRMvtmfpb+viYv7eHLz5fFblIWrGJL1F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=RpHrvqeC; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43716o3W014299;
	Sun, 7 Apr 2024 01:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=4+zlnuFS+Qd0WkCOcI8BhdQsf2IfR+tVrbVts/hpu04=;
 b=RpHrvqeCBUA71WWqCA3rxarnXKWkCuOMLL67KAHBeDOZgeS1eauK59C+pgdKcTat0QjP
 9OWl1yXffyVJcAyLqazoxFOQNH1DoOU/+CNMC2g5bqgWl9ZHfQgDZhhFuOhoboGVrkH8
 7V3Nr/4aQ3V5hexFFV2msx6A30gaV2OILJttxA8kk/KCRkCJkYuDAzsrxQiWmlz0dxNk
 VwvZviivU4M2+Yl10CWDCWXNCpGXholDmWRBy/0kUmNfis6W4plojGtQgHIHfr9RKfV+
 xHJdWay4t1qA5CUv5C7I0Q9PAb+UfhZNYXFfyTFTROxqSCD3j6Pfqt6J9807Mv5O/Ljo xA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xawr1rgv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2024 01:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOaZrqox284Mmz1GdngkMVlzwaY+18+/kWT9YYnshytQ+dC+8IoYbAuGXmMpjpowlxM2r7Omc5aJ1CJRjhn++hAPgpMnHP9eiVw+InvrUJ9H2YwXNJ4JdJPk0bzAKfClUMR88pwu7pJKZTCuAVXy4C4J2c0DWRQCbbUFCBgLVeA0P7Y9XajH4CpYv+o6sBY6OouGkQTDaKTu68CAZs2XX+5wvZ/6/oHlMB9WohUfuJqhbi491IkBGtgLr+FJmLP06AE0/OIHw3cmSPYoGpgSsl8/9D1V83iSrHuG+FO0B4N53lbZ9313Bf2UMstJoOHX7MEGdqPTslQzVdwm1sKuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+zlnuFS+Qd0WkCOcI8BhdQsf2IfR+tVrbVts/hpu04=;
 b=DcStiSSpIgK3CHVppNFZWkGny0f6/ARSDPHsGfond5thve2K9FyBcGf36PGO9y1egjYMkVkDxszusX6ocD2jIvVqkq6rWiPDWnEk786L+dMlVk1viZvo5++HJFPNzSNQ9/TrHSAFSiBV8OAr1dMy/QKEBz/BSnJb1JcSqHEoSAJ8XASmNRmL8G1xBs+d7H3YcPfMbLwN87oI4WI41xNJbaJJxnVxa+z0t2ha6C6J1CbHjrJi2JKBOpTPHNsF6EzrzSC0GZPxISjAXUlHNn+D3uFDGhtvVubHUHHJSPhTFz5ybQJR8Lh0BvauFWiU4Ab91o8S3YWNlyzNxrmRwbpN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6940.apcprd04.prod.outlook.com (2603:1096:301:118::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 01:29:50 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e%4]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 01:29:50 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "dchinner@redhat.com"
	<dchinner@redhat.com>
Subject: Re: [PATCH v1] exfat: move extend valid_size into ->page_mkwrite()
Thread-Topic: [PATCH v1] exfat: move extend valid_size into ->page_mkwrite()
Thread-Index: AQHahZgmFUuqKOIyxEaWQ6kIYx9dnLFWkJAAgAV2iGw=
Date: Sun, 7 Apr 2024 01:29:50 +0000
Message-ID: 
 <PUZPR04MB6316B38EF0D169F9F7E78E1A81012@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316A7351B69621BA899844F813D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <Zg1eoJToXZYEHqg4@casper.infradead.org>
In-Reply-To: <Zg1eoJToXZYEHqg4@casper.infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I9Sw2s1+rN+YbKrzMgmONcvGbaW7MaP+/KQEhN+09LfqiWr55md3dHxVbN6SsOEMCfOB2wLY0qqiqSgDAHrBEiAtKJp0lexKvqoYIPY2FyuY5Mj6dW92ansMRwT4J3UIq0QffqwcQSQMPLJqHI0M+QmEtFqO7vpEO4EbApouaSCUVe+j1H5yZZF9WZesGxr+XA7kIvSVVEapr335K1oL9uAEH93DpHtVDdUWPZoLbiqNr2SjVHvdSuOcwI6jWMAQ/1XlS0mlfHMtd0aJAeX2m3J1vEtgeDfdRR8HaBF+ezEjmpncOIrJQHZF5AHfr9j+WDi6dvdgxmevUh76K9bLJJssganhesYU7pc2ZDt0hz60D/Mr4lO1geM7yqGAkuHzFFObbkF1B4zN8Rv1zTwRIgYLO4cLK+UeeWJc8kUne/4BpBRNyCkN8hLbx0WSEfNhSltHCB05QqNyGLwrmZuMUzqN8+rTPuIJttKkCBJqvrJs4XJzFZFmJBT2pF38mrIzPYoZO7FWWoT/O8NsQa2uhjTaxqex7ISkFD2+B100jZguHJpqlB+0H6PsgDd9k8zzE3TrKT3D8+o5BV6VWln2C3azNr5TVxSUM28FANRQ12k51WmWHLCVWym159OKSO5ZH8lzVz6RkjWWAmE9lDhDdWtpMTeLw1Akc+Xxq/pQCy8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?tlnbXw4wl9Gz6N+ULBP4yVeMA3J7QEfQfXDTsfID2v3tIdtUy5wQj0TGmu?=
 =?iso-8859-1?Q?UXbNykrmOhF/6hBy3Q+in818R+/mQOuCe1Q5nmrlRf2REQIyqv52MLupMn?=
 =?iso-8859-1?Q?vR3bv6ysWHce0emzkWNgRNAkkJS1o3BME+LUDTse4w5603DoHHSKOLsQyW?=
 =?iso-8859-1?Q?iqA1PuKluNOLMkQb7+drgx50Q4+D+l+Ri77uw4bR9qBv+dd35uzswPiRQP?=
 =?iso-8859-1?Q?s0PVJLfL4VcGo3zfahbakVPzOnUvxmIthan9KXAV67qSmHrJzewjMmFRrH?=
 =?iso-8859-1?Q?r6g2U7DGWsD9Nv+8hkt++75zRunDJ/nTHxxbKdMe6NczojyuHVMkl7bnZg?=
 =?iso-8859-1?Q?ehmxwXsSI0+3COuIsOPZBbxALsRxn4LD6Sek5obKINkG3mkz9q9TcpVIM8?=
 =?iso-8859-1?Q?pT3By+iqGb7M0mbHEJ978FM8tpbl0nHz3iQRUCAv24DkPyppHUlplQhycr?=
 =?iso-8859-1?Q?y4tQ8jB+X/Hf5467FbAg9uQyOqcTsTvDpNdS7ecRtjME184yzNjuaSKRq4?=
 =?iso-8859-1?Q?zstFjlRIqoZmZxi6cfuxcLqVFYEbRjbsKlcpp25StcHZ6qBlBd6aauDQYd?=
 =?iso-8859-1?Q?pGjN2QsNbXecISjGqpsBYZ0YxYea2/VoWPiW3ENHtVlIusam2Grpj5Z/wL?=
 =?iso-8859-1?Q?U+yPpGTrfM1mzwHxqkhQHZrHTsGA1ojuymmNucOqyRuIxqQPGuKe8pPK9I?=
 =?iso-8859-1?Q?pv9Fke2CgJxdL4kP3w8ZnTis95acVt737PIT27BhTluW8Ooh/I+vn2bncP?=
 =?iso-8859-1?Q?JGif+4gWMyAUo8BVNgTHrIvebS1Psf6lz0gtxeyJzeOFzOquBZrzWU6dgE?=
 =?iso-8859-1?Q?91MgFWyAATXmKutSSYgWBnf0679xCRg0X56LL2Qa19z4pXvxUER6z7qnUu?=
 =?iso-8859-1?Q?c6vuC9J8FxvUkrweiXJNMlOV2JPrspCSPqOrY6R0fcHdH4mpamnK720EF0?=
 =?iso-8859-1?Q?s9QGpLBBlGNLEevpwkHBlP2PsiEQZL1LIMHzd8Sh/nB/hnA9BvwVJbco/j?=
 =?iso-8859-1?Q?fYsK/KLkdx2Nax4gIK3AlKT4EXwQ10RHOv+SOcLshcWAdf3bp5kovXiBpJ?=
 =?iso-8859-1?Q?T4oT9pN6zKsitVFbOM4eAXM8tRj5/vXkgRXw1vuvoa4VBagSq48B62sgNb?=
 =?iso-8859-1?Q?nFb+Nui57DKlK68KqGIR887FaZ/Gg2d6t1dKtMaQ2BQfg9Z5gF0dvo/sAe?=
 =?iso-8859-1?Q?jQ5J/uMNDetpCe4VcUoCgBQutZcxadXIwsegYZMdVtNUwZQI1nd9bGpCQM?=
 =?iso-8859-1?Q?XiZUBD/WT0o75mxF801moFPNSEt1TuMEkan8D0bzm9cDovNWumnEFjbCNU?=
 =?iso-8859-1?Q?6RP6Dop7SL5t5Bh7KE8+wFpSBijvd6jUqSFODHVjp+VdP9zxCLp5gokgC4?=
 =?iso-8859-1?Q?XwXOV5ksKm+85ydKbcwxigmQvJli/elwF4G3sXr78Iy9gFPtRrbMn1Jo2A?=
 =?iso-8859-1?Q?VDESHVHHmuNjUCqLm14orCXl1v3HWEN2zxsVhu95XB7fBiiBtWRW3ggGyW?=
 =?iso-8859-1?Q?dj9jookZtrprinpetNWPF4acL6oPUN/zbhd7zMQM2JCEJAEPWEg4hTXMFi?=
 =?iso-8859-1?Q?25SNDRBxCT1ybX/95PHq852YWCZIxpsicWTwkP8p7GFXMvEPrHLrFNT4ki?=
 =?iso-8859-1?Q?wXEOPbkhcS2iniMlnQk9mu/qSFWs3f72yrfkiysmoA+JH0kxShgfznombx?=
 =?iso-8859-1?Q?wORiKcptCfNdDWglUNc=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Jlf2G03k/uHO/fK6Ew/2O8PqdmWf8nUp5RL8ZZfB8ThJrhhYSKSvXd26zBqknWAvUSl9uJ/4MtiOQJOx7MNjbCo98iv04mS/3eOpAMC9EvR9Fzp5E2DeOhN3CNyOLrzjc3MaI2p5gyTgvrqbIx0LTmEhJ2pW0Umogts49v/T98YgTWkZBJBPf0pBCKilGXtR1rwMlQO9HAcYdOdkJoLPSnPtb/onZ3ory1tAb9UxXvaR9PxEiAep2TXTmn6uOjwe6dbwh6YWHM7Z83wJQZ2KUgxy4WIzdykOYOKVsDSnpAOOTPA8gY+ZqmrDwnlfmI+x7OZX5DI9xJ+juzkBS40lFj6/+CID+Oh6531JdEHSo93Y9kCet2GbpC8OnREojIby7qS5nVsuNO5BuPuOqGK10mc/foW9YTloERNjnyzlECX7/PISzJ0ryULTpdxKwLmm4brWxnIHngZP7sKWigHboTNcioGRb6uvnI5L4gJR0vTb+gqVB5A+WLonp8SSbSeQ0bUYY5u4ss1/i3kyZ5tTGVM/ji1eqMf6y+sUjskz508bekYBz5H7XlnzC82cU3U0xxVnlf1Tl1D7Li17MAbC+xJo8SUsn6sanijgnc1Yh1/S3wi6b8XwArP5vlI1WkgI
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521ecbbb-bdb5-4e3e-5a8a-08dc56a2381a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:29:50.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsc6UtaVONwcrboNNQX3gkey48cs40Xz/UGh1RBAjwUYRPyhTxR1dUFrvSji83fN0ajKwq2f3dKo/nJ8Gd05Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6940
X-Proofpoint-GUID: 2kQP7L3qfNHnt85W_CZu_lYq6wLEJNrX
X-Proofpoint-ORIG-GUID: 2kQP7L3qfNHnt85W_CZu_lYq6wLEJNrX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: 2kQP7L3qfNHnt85W_CZu_lYq6wLEJNrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_20,2024-04-05_02,2023-05-22_02

> On Wed, Apr 03, 2024 at 07:34:08AM +0000, Yuezhang.Mo@sony.com wrote:=0A=
>> +static int exfat_file_mmap(struct file *file, struct vm_area_struct *vm=
a)=0A=
>> +{=0A=
>> +     struct address_space *mapping =3D file->f_mapping;=0A=
>> +=0A=
>> +     if (!mapping->a_ops->read_folio)=0A=
>> +             return -ENOEXEC;=0A=
> =0A=
> Why do you need this check?=0A=
=0A=
This check is always false, it's no need, I will remove it.=0A=

