Return-Path: <linux-fsdevel+bounces-9498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED5841C9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC565B24FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5452F93;
	Tue, 30 Jan 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ot5PhONU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C53524AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599956; cv=fail; b=AmQRfORJ/lZ0nbqkSvJW1FtO5rbL8DQ3bs+r4c+oV81t6q9o4fFBYuv56r2HDn7x/QVqTmENKyizYm+AYpuWxLzFnvlFQY+LDtd/lLQWg/c2q7kQ1jaf40Ir8pk7K0Et0vjT2SpsFofBrMvifLBu5O3XIb+dEsitqBZJQoLaG+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599956; c=relaxed/simple;
	bh=VJBfL6eZ+P/Th/0H/i1EvAKSsmKhhyeuc8zZ8uhOj1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKXhrNSp1hccCvAUc+fjg6cV01ulHQ4wB9poN8V5J2ZGiAy/awR98D3IpbXw261IReOC3RfSQKNLVJzYjOF9CG7JdgFXB52bb4E5hcuAmuzKTiRNQqea8JMIWP5/1HaQIkTHP5hTEImN6twzGvuzmUp73FS7EtKFA4nvrXqsNcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ot5PhONU; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40U70ZGu005582;
	Tue, 30 Jan 2024 07:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=S1;
 bh=EKxk+BO9BlLZ1nPdJgJjqCUkSbvhQYAhFwn8gXErzmM=;
 b=ot5PhONU7f8Rah1347Dxt1X9MdUXahFOErosfJCx8fkGM3exv3s+DD0Q5P4LhX0VH7ju
 WxLSf2nC+nqt0wErYQZMf0S9bBwGtIcAhWaDDU9+f/QtnH1b4atRrP+D9kfftiN2Cv+N
 /izzybOY+349/gFALrD0q9VyBIVZK/Cz7vk6wpEAAv3uxy7qqbhRadsbEFoDslGe7rOI
 aDzUcgQ4wg7BgegwrFYVS8ptkty+IMaCRVRysYrHj1RLfReQejUwT5OTTjwphll5aW0I
 bi8i+WknsV6vTjA11tO85w9BBeQfKjlYoMPdVlMuPVqxCvGD3cKrbOQROVxpfJixe6W2 eg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vvs62thqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 07:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZERWQGbxZ6TC8duaExR/bmDsdsc4WQpxm/DI6yxDKn+8VBJaqzUz66A2OrgClBRGqB4yEAGwwDmGafz3cjwCB91wOiOcN9ShKqtctPXTa+iHidf+0ss+y9kKcNjTFRlVoAVlw4bPau0RQyEIxXKNPQnDHoa0R6j/xXtpE7DDMLm+spAV9+wK4F94lVn/pxjTMehwcD1yxyVzulmQZjokd+bmz1xinE51eTbgtHlQe7Qm69QcFT5tGEb4qtqjdkIY6gj/k6KYqGpi/UUNbWEWWiwOvN6CeoB3NHsFxnZ81C/TFTQPSepea33I1i0SABtyBM8UwmRgIklrnp76LnAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKxk+BO9BlLZ1nPdJgJjqCUkSbvhQYAhFwn8gXErzmM=;
 b=VspOLEiJ1ytx1KOcXfilx0W1CxeuKTnrwFRvwGFgysioDC1LeY4YXhhg8TszkBX6ls6723zTq/oDpmLlVkV3uAoYciJ+nc2/SMvjd/z5zWUXeMn7ZqRjo2k0ITaH2hMpdiRhJE5zcve7FXaqRfYB3YPMa2J01GclWszZBifejMl7Zc9J50yJXZ3LwajNeQQrbPZ6bf5W/T0DLjVRIKIdVApRY9qcMofVAU1GZh81PpbUQPzpUMCUrpeAKQrqHysBot/PLLeS6+XdAQ4VyC2kNOQF4YDe/YVY+7KcXWNbC88feqPwa5aQtGde6i5oFKzp/LQHYSWs+rgjKGPSOFHcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB6483.apcprd04.prod.outlook.com (2603:1096:101:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Tue, 30 Jan
 2024 07:31:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:31:48 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: ratelimit error msg in exfat_file_mmap()
Thread-Topic: [PATCH v1] exfat: ratelimit error msg in exfat_file_mmap()
Thread-Index: AdpTN0UxqEMN3rFKRd2R4Fso5MmIQAAFuLNQ
Date: Tue, 30 Jan 2024 07:31:48 +0000
Message-ID: 
 <PUZPR04MB63169F97595D70047AF50E3B817D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB6483:EE_
x-ms-office365-filtering-correlation-id: d2c5e810-e9f4-4652-0108-08dc216584f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 M53jwp9iW3YVGMpdjNlrZv0zh/0mL+LcGg8FNFGoTtBdRxchNzwUoGv2f172BLx9w8hp/fCw9LMEw/fjkuxAt6narSKi2OceWRIavgGa2gcPQaaeA0dgZxagT4aDIZksQcg1Sp6tsF2cKVtK+D804tUiMtkkjryLAsnuuUuSdZu+1I+Fn6aVnPrqUBKMGmlcv5Qqep7Y95aFBgq4ePvapw/hqz1eBRoemd8RxoVLjBCI1L1DTg8Dp8VoAf8Vl7tVaZcuOQIXeciXxkuRcHmF0veXR8Zh6AnS6o+DzemAvkFbSdwsJQ6KWWtavIv5Lq+nsipy/oQC5O2iYdZdDR41fAqgxfl/03CUZPToao0HFqfnn9/qERRarJYx8iLTMX3+hWR8MqScJ+zemYRZAUjc94Twffl1BMbtlITRRNWGOtF55EX1q6PmFRqbNcLbbZeDX13RZ7mVb3cINncncnlpuMTIv4vvOzf7V5l4AtWEXRVHz3Gy+G9ts6Gob904SJleGPIjalJMfYn1QQoz9IfqH74Pq6awiLUVZQZcY7DmarCvAKOvDjWIG6inKzlJHyuWEs8TF79fmRpBaQMPBpcrHqxxuMgQyyF0FL6t8vzD7wcUfmRGisWs+mo+3LHWEBHo
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(107886003)(55016003)(6506007)(7696005)(83380400001)(9686003)(26005)(4326008)(5660300002)(8936002)(8676002)(52536014)(66476007)(478600001)(122000001)(66446008)(64756008)(54906003)(71200400001)(316002)(82960400001)(66556008)(76116006)(66946007)(110136005)(86362001)(99936003)(38100700002)(38070700009)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bS96K1FFUVJwMCtnd0pEVGhmT284VDc1VnF2UXZUT0lYRk5WcCtWMmhsM3dq?=
 =?utf-8?B?dFdOVUpJTGw4QllmQ2NQcHNnRFdGOG1GR1JYS3AzcmJkMXBrTzRTZGpMdERL?=
 =?utf-8?B?Ym1MaDJmdEtRbEY2dUpXWk5zUVhuRVM1MzZ5ZFNOci9YWjZRY1pJejBGUUli?=
 =?utf-8?B?L3pyLy9EczJYU1ViZlVDNGxqSEkrcU9jTG9nQm9EaXRKMGI2SjQ2SW5GZWlD?=
 =?utf-8?B?enlOY0w1MVdiRkxBU3BSSXBNNzN1enFlUmhKbGNvM3ViNXVFMXJ2WFllZlkx?=
 =?utf-8?B?eW5heG5ESXU2TGFpMnhIbXR1dE5nei9BTFJtOGU5bkJ1blF2dC9RYzB5MGxY?=
 =?utf-8?B?KzZhNlpkeFNXeGE0V3hqSVdxWGZlKzk5TFJlaDhLYTVldlNLRmNqTWM0SnRy?=
 =?utf-8?B?WWlJRS9YcVVhMkFNR3BwUVM2VzBIcVB5NDNDZDZWZFF0T3ZtQTZDUzk2Ykw3?=
 =?utf-8?B?NEZ3dGVHdndDYVFEZlc3ZTZWWjFqQ0tJZHVSaTgrMm52YTR4TEpmbnY0NzFW?=
 =?utf-8?B?elJjUFJUZSsvUURPTnVTZkhtOUtQRlh5WFl5dk8xQW4yeno2WDM5dTQyWm56?=
 =?utf-8?B?dGFiL28ramp3bTNiK3Y5ZklYYTlEbklNMTlGR2pkYWgwV2s4SlVQTUdKbFhK?=
 =?utf-8?B?T1l0am9neGRvcUNtb3A3TE9IenM0MGtpUldta1FpMUhjRmZVVTU2L3lmbzV5?=
 =?utf-8?B?djI0c2Y1TzJ5YXpMdlYzblZNdWU1L0tvWGtVMFZnSno2Q1Vsc0lnaTRwN21m?=
 =?utf-8?B?cFlkNGlVa3M3WFREVzBIQnFvcG1DOGpiV01ua0RBZlZnWTJCamprSGh1U0Y4?=
 =?utf-8?B?TVhjTldlUTFTbXlnbWJCdjJjb281dEdqblVJUWVQOHpnaEdRT0VGcmxabTZW?=
 =?utf-8?B?UkhjQ0dSS08ydmJlUGxHS3FNMnMwWUtaeGZTMFlmUWNxTEdOU0xKb3hueklL?=
 =?utf-8?B?S2c5Y3A5d1AyZElEN2lCc2JnS0psSFhieXlMSkY3NTl6cDRGK0ZkZzNRNllY?=
 =?utf-8?B?SjJQZldHbks0QkZack1DWmFoV21DMlQwYmM3emovMmJsS3R6SklUUnJqYisv?=
 =?utf-8?B?dGtWNTAwTW8zNHN0amx1NEw0MDVUdElUY29yQzFpRnpoWFhVVWxCQXdkMDVZ?=
 =?utf-8?B?VHVqNklVSUY4aGs1dk52QkhDK2dKTVJ0cFoxQ0EwUVM3U0trZXF3eDhNRVFs?=
 =?utf-8?B?TnNVWjhnRk0vLzZoaSthUEcxeVRXZGFmRTZrTjV2a3BFd3cxcUZrNXRublBN?=
 =?utf-8?B?djZydlo3ekFPM1JXWFBsa0Q0WUpkMUJIOThWeGNVNTZQYlcvOVhBMmVPUVpX?=
 =?utf-8?B?aUxQeEh0ZmJCSS9FMGZYUHBSaUFSbjJSYitFTjZqTHM4dlhNeFVPTkRObU9h?=
 =?utf-8?B?cFhRc1RBRGlyQjlKeHBBejA3eG13VC9reSt1cnlLZ05GWlV5R1hScFB2Z2g5?=
 =?utf-8?B?Uit1eGRXMG5razc3WlY0eEdYcFQxblczazVOclJGWlJ2bWZSTWFOSFRybk10?=
 =?utf-8?B?UytVZWo2LzM4UFRqYXVhMjMxNy9OcUpQdmxxTUhhdnJrRXhVZERzcjV3Unhy?=
 =?utf-8?B?cmFqYzhkWDZVVVpCVmxCdjF2clVhS2g1dmJubG5Kdkhsa2Z3dVk0d3FrR0Nv?=
 =?utf-8?B?RTAyZW1BdWx4L2hMcjZoVjFQS281T3N5OGxrQlJyT1NnR1JtOEFFZ284T3Bj?=
 =?utf-8?B?d2ZLYldZd3plSHhDR3h6MDR3MFhhbzMyT3VheVluZlNKL1pwQWZRQlI2Skl2?=
 =?utf-8?B?S0p4cm9lVE9WQTdrVnN5TGRCc2VMRnY4VlRjajlac1lsYWIra1dsR1RDNzZB?=
 =?utf-8?B?bmo1Qk9ibUpqSFo5WVVJNUdDNGpzNEIvRFpCcFY4THFYUithMDNFLzRhMkVS?=
 =?utf-8?B?QkVSY2JjdkcydU5OTktJdk03YTVySW00SEppNDFZU2xPNzdKUVM5djJXWndh?=
 =?utf-8?B?Y25IckFud0NNc1lxRDJ1NHhTMmtBMEhOanNwSFhmY1NXUktsUTVqODZiZGJi?=
 =?utf-8?B?emVsY0ZaWnFPazhxaEZ1ZG5FSW1YZGJBMFNlbkYyVjN0bjdrUUlaNlRnZk9M?=
 =?utf-8?B?SXVzZjdhdmZoSXZERlNZQW0yMmVhUHg1cnpCUkVnMjZFK1k5eHAzVkIrWStY?=
 =?utf-8?Q?viJajDKXHlvrPEc1lVG9VHi6U?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jowBG8vwq4QawU7v/pnjkTnkRNby4Qi1XKsCRZHOdwVDCpxFJmNM6/r9d5am4zUgmWXbyZQKz5WVajB1+jaUH5fUP1IbkugrEOHwj++ztYYL217F/nHsf4ie6VF3N8Sa/h4PYK9+kUzlzYdmJEF9Lwj6sXEwthrOGoTQD2MFunaZwiGooP++064l4MaIxL4Orgr5x6LjOkV2yM4CPn+xZU+hOKggRmPbfrs7AtbZXyS88W6PP+OL3DiVtkg8zYTPbIL3oMfOeIhExUURucowYYbiU3uPYpOaengFLFeIsbdVlo3yO9l+sbYHmE7KdwIIwnz1tRSm5FVrVhFcl1kWTatPuBPQG2CZEEz0Ov8CrDJPLXqP24l3Byj2hPNRsQ1/54y6DhjBPFqiHxpAo6Q3LgGPXQi/Fx9cnBYWlwx1LiFrRQiGzr3QbLxFTCm+gYgqEX2hOGW6X8vrfVQxIuOP9yYejymDFlzEQKQDEcbznSws/5WaU/tKXQj7Ur/qdqRGSy01dtfS7RpaS5EF0TtrLixdNgmznMy54Fvw0SJqMepxsl6v0dP6GFriyPgwQ/q4C29omHpxryOYwq6SE3bck+HkJU3hl7+9ma3klLfUPpg3vZbgyfgeYLOrZ1ZZTHSz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c5e810-e9f4-4652-0108-08dc216584f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 07:31:48.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBMfhXRQ1qH9NXtiWoRXzWV/2NEMFdhG2627XqcmPpzGCuiMZ1AiFlIGpumWFQg3q00gSNIOV9B25it0mL6lZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6483
X-Proofpoint-GUID: 6Kyv2ww8diddI0BXKN4atTOtmfP-jCqq
X-Proofpoint-ORIG-GUID: 6Kyv2ww8diddI0BXKN4atTOtmfP-jCqq
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB63169F97595D70047AF50E3B817D2PUZPR04MB6316apcp_"
X-Sony-Outbound-GUID: 6Kyv2ww8diddI0BXKN4atTOtmfP-jCqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02

--_002_PUZPR04MB63169F97595D70047AF50E3B817D2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UmF0ZWxpbWl0IHRoZSBlcnJvciBtZXNzYWdlIG9mIHplcm9pbmcgb3V0IGRhdGEgYmV0d2VlbiB0
aGUgdmFsaWQNCnNpemUgYW5kIHRoZSBmaWxlIHNpemUgaW4gZXhmYXRfZmlsZV9tbWFwKCkgdG8g
bm90IGZsb29kIGRtZXNnLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcu
TW9Ac29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgNSArKysrKw0KIGZzL2V4
ZmF0L2ZpbGUuYyAgICAgfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9l
eGZhdC9leGZhdF9mcy5oDQppbmRleCA5NDc0Y2Q1MGRhNmQuLjQ2ZjI3NjBkOTg0NiAxMDA2NDQN
Ci0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBA
IC01NDIsNiArNTQyLDExIEBAIHZvaWQgX19leGZhdF9mc19lcnJvcihzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBpbnQgcmVwb3J0LCBjb25zdCBjaGFyICpmbXQsIC4uLikNCiAvKiBleHBhbmQgdG8g
cHJfKigpIHdpdGggcHJlZml4ICovDQogI2RlZmluZSBleGZhdF9lcnIoc2IsIGZtdCwgLi4uKQkJ
CQkJCVwNCiAJcHJfZXJyKCJleEZBVC1mcyAoJXMpOiAiIGZtdCAiXG4iLCAoc2IpLT5zX2lkLCAj
I19fVkFfQVJHU19fKQ0KKyNkZWZpbmUgZXhmYXRfZXJyX3JhdGVsaW1pdChzYiwgZm10LCBhcmdz
Li4uKSBcDQorCWRvIHsgXA0KKwkJaWYgKF9fcmF0ZWxpbWl0KCZFWEZBVF9TQihzYiktPnJhdGVs
aW1pdCkpIFwNCisJCQlleGZhdF9lcnIoc2IsIGZtdCwgIyMgYXJncyk7IFwNCisJfSB3aGlsZSAo
MCkNCiAjZGVmaW5lIGV4ZmF0X3dhcm4oc2IsIGZtdCwgLi4uKQkJCQkJXA0KIAlwcl93YXJuKCJl
eEZBVC1mcyAoJXMpOiAiIGZtdCAiXG4iLCAoc2IpLT5zX2lkLCAjI19fVkFfQVJHU19fKQ0KICNk
ZWZpbmUgZXhmYXRfaW5mbyhzYiwgZm10LCAuLi4pCQkJCQlcDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCA0NzNjMTY0MWQ1MGQuLjY4NDA1YWUw
Njc3MiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KKysrIGIvZnMvZXhmYXQvZmlsZS5j
DQpAQCAtNjE5LDcgKzYxOSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmlsZV9tbWFwKHN0cnVjdCBm
aWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCiAJCXJldCA9IGV4ZmF0X2Zp
bGVfemVyb2VkX3JhbmdlKGZpbGUsIGVpLT52YWxpZF9zaXplLCBlbmQpOw0KIAkJaW5vZGVfdW5s
b2NrKGlub2RlKTsNCiAJCWlmIChyZXQgPCAwKSB7DQotCQkJZXhmYXRfZXJyKGlub2RlLT5pX3Ni
LA0KKwkJCWV4ZmF0X2Vycl9yYXRlbGltaXQoaW5vZGUtPmlfc2IsDQogCQkJCSAgIm1tYXA6IGZh
aWwgdG8gemVybyBmcm9tICVsbHUgdG8gJWxsdSglZCkiLA0KIAkJCQkgIHN0YXJ0LCBlbmQsIHJl
dCk7DQogCQkJcmV0dXJuIHJldDsNCi0tIA0KMi4zNC4xDQoNCg==

--_002_PUZPR04MB63169F97595D70047AF50E3B817D2PUZPR04MB6316apcp_
Content-Type: application/octet-stream;
	name="v1-0001-exfat-ratelimit-error-msg-in-exfat_file_mmap.patch"
Content-Description: 
 v1-0001-exfat-ratelimit-error-msg-in-exfat_file_mmap.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-ratelimit-error-msg-in-exfat_file_mmap.patch";
	size=1697; creation-date="Tue, 30 Jan 2024 07:07:35 GMT";
	modification-date="Tue, 30 Jan 2024 07:31:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZjAyM2ZjYzZlNjMyYzYzYzFiZWE0NjM3OWJiZjAzMWUwYzRhMWE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFR1ZSwgMzAgSmFuIDIwMjQgMTI6NDY6MjEgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogcmF0ZWxpbWl0IGVycm9yIG1zZyBpbiBleGZhdF9maWxlX21tYXAoKQoKUmF0ZWxpbWl0
IHRoZSBlcnJvciBtZXNzYWdlIG9mIHplcm9pbmcgb3V0IGRhdGEgYmV0d2VlbiB0aGUgdmFsaWQK
c2l6ZSBhbmQgdGhlIGZpbGUgc2l6ZSBpbiBleGZhdF9maWxlX21tYXAoKSB0byBub3QgZmxvb2Qg
ZG1lc2cuCgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
Ci0tLQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8IDUgKysrKysKIGZzL2V4ZmF0L2ZpbGUuYyAgICAg
fCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oCmlu
ZGV4IDk0NzRjZDUwZGE2ZC4uNDZmMjc2MGQ5ODQ2IDEwMDY0NAotLS0gYS9mcy9leGZhdC9leGZh
dF9mcy5oCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKQEAgLTU0Miw2ICs1NDIsMTEgQEAgdm9p
ZCBfX2V4ZmF0X2ZzX2Vycm9yKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGludCByZXBvcnQsIGNv
bnN0IGNoYXIgKmZtdCwgLi4uKQogLyogZXhwYW5kIHRvIHByXyooKSB3aXRoIHByZWZpeCAqLwog
I2RlZmluZSBleGZhdF9lcnIoc2IsIGZtdCwgLi4uKQkJCQkJCVwKIAlwcl9lcnIoImV4RkFULWZz
ICglcyk6ICIgZm10ICJcbiIsIChzYiktPnNfaWQsICMjX19WQV9BUkdTX18pCisjZGVmaW5lIGV4
ZmF0X2Vycl9yYXRlbGltaXQoc2IsIGZtdCwgYXJncy4uLikgXAorCWRvIHsgXAorCQlpZiAoX19y
YXRlbGltaXQoJkVYRkFUX1NCKHNiKS0+cmF0ZWxpbWl0KSkgXAorCQkJZXhmYXRfZXJyKHNiLCBm
bXQsICMjIGFyZ3MpOyBcCisJfSB3aGlsZSAoMCkKICNkZWZpbmUgZXhmYXRfd2FybihzYiwgZm10
LCAuLi4pCQkJCQlcCiAJcHJfd2FybigiZXhGQVQtZnMgKCVzKTogIiBmbXQgIlxuIiwgKHNiKS0+
c19pZCwgIyNfX1ZBX0FSR1NfXykKICNkZWZpbmUgZXhmYXRfaW5mbyhzYiwgZm10LCAuLi4pCQkJ
CQlcCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMKaW5kZXgg
NDczYzE2NDFkNTBkLi42ODQwNWFlMDY3NzIgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYwor
KysgYi9mcy9leGZhdC9maWxlLmMKQEAgLTYxOSw3ICs2MTksNyBAQCBzdGF0aWMgaW50IGV4ZmF0
X2ZpbGVfbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEp
CiAJCXJldCA9IGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKGZpbGUsIGVpLT52YWxpZF9zaXplLCBl
bmQpOwogCQlpbm9kZV91bmxvY2soaW5vZGUpOwogCQlpZiAocmV0IDwgMCkgewotCQkJZXhmYXRf
ZXJyKGlub2RlLT5pX3NiLAorCQkJZXhmYXRfZXJyX3JhdGVsaW1pdChpbm9kZS0+aV9zYiwKIAkJ
CQkgICJtbWFwOiBmYWlsIHRvIHplcm8gZnJvbSAlbGx1IHRvICVsbHUoJWQpIiwKIAkJCQkgIHN0
YXJ0LCBlbmQsIHJldCk7CiAJCQlyZXR1cm4gcmV0OwotLSAKMi4zNC4xCgo=

--_002_PUZPR04MB63169F97595D70047AF50E3B817D2PUZPR04MB6316apcp_--

