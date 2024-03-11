Return-Path: <linux-fsdevel+bounces-14095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C4877A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FB31C2048D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5979010782;
	Mon, 11 Mar 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Thr3Pgf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A406DDB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131110; cv=fail; b=QvArRyM4yteAP8FpXBm/8vlnUEOosf3zZP8q03/Ph/i9h+gpgoje5J7IWMWSDPoHouIQj0XQTVW5NA4wDjJRt3yyRC2PKUE9MgSk3h1w2azJF5b3O9RxcKq+AbIGUl88wa3kat2/h6HkFHTsFwzT1CL6PhUz59C+pRwgI/woFC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131110; c=relaxed/simple;
	bh=cbagQHsRGqW0PGM/A+CpX2N7jObvpnw/qv2kxgiYSGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljPXn1HpnSpCU6rXD4hiAZ8Phts1fEhefifzp7X6ap7Od1F+KjZFPi38uGtYPyLwpGkbXtZH5NOkczahZWBHFvaezq8sdo4sqAhHvnuXEIwZyh5urxmUZDUNA+hdnqWl4ZpIDj7Hz84pSFDNFbhmkE69IeK8em1Hhqf/aMPZ8uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Thr3Pgf4; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B3mRaE007468;
	Mon, 11 Mar 2024 04:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=cbagQHsRGqW0PGM/A+CpX2N7jObvpnw/qv2kxgiYSGA=;
 b=Thr3Pgf4H/aRs15T2rQDT9Z51Acgm28f3yBcf6joo1FlHbrVQCVtItnWb/dsTEfLcx0y
 S7YWsDMkH2OkO02W3OJ8xuTfQmsBt27YOFHzB+tRdANZPWts3CFTV7VsM/jDrhbI7IaX
 HdnTe+BZ7x2yxFQn+k1sscrQeHnHsbBrhWst4WUOov7cO/inf2xalZctmt8IDfifd9PN
 Z+lfCy8l2N9UYgfYe1QwTHSLP2lSkhvJXuVitYZevBfwb7I0pGnJX60m2I6dK5zfufIz
 gz8DdArhELwzoMvsumLNkbxneZWBNXJyTsz6BZlWBiPsedm21M7BLstXiYFM+GbiWiSe gw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wrej8hd1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fepmXMXGp4it3JfwK7gTAWVoX0Xyb+OPLNQa4sSeVbyG4F8Q2YPW5yA3QB58FHuMC2lzOkKnl7xuORKnEQkAfxhf6RAz/dPG+/L657NNCAzXCs2cU8IIo3QFxJHu9+7/ZMnlIHEVkBaqeS+qc2/Wzp0YIsS+JCAXKzof5cMlzSzJYnPdpNdV5ZQNC50YnB7RKwrvJDBOPfD6qdT9AdhLDMcfSkORo1QzH0/ufJU/ddQgMOVnYIu6/8fNhXnkI2vaNz15Jqoz9Mv0uKaKMBCw86obt39WP0Ztvv4F3XBdVS+WpMP/MDAFlN+eUbB61LHkom1vpZmlfDfp1drwoUkh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbagQHsRGqW0PGM/A+CpX2N7jObvpnw/qv2kxgiYSGA=;
 b=j/A/lnNaH8YHtbM3i8NORCACdK3TCEZqyJYN+jI18k8+FgvR6mazPJvPmis+R046uADtPFgd5O2RPfu8uXI95otTGSz+yl+5oM2NFLdQUQGWpLUUCX/D02I4D6g3hlKIBHAsxxhVNoIesjHKgWvRkuwwTtGEjAEmrPO4dL01YRlYO4YBlZEPmIw2nYZuhQlV5pjA791UMe+hvzcv2NAz+x09IQhHVJXo0vrNJKk/P7qHDX+ZggSmgg/cvF7CdvyaDtok3UX4CgUx12BcQ+YzABM1scAssg6dnPX6n1ENu3rcg6lxRHaikvIj3trK9Ll31I/uSeOjKTMQZTZKFli38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SEYPR04MB7362.apcprd04.prod.outlook.com (2603:1096:101:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:24:39 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:24:39 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 00/10] exfat: improve sync dentry
Thread-Topic: [PATCH v3 00/10] exfat: improve sync dentry
Thread-Index: AdpzZF3k6YdeFU4NQueKl+UjuQm0lQABPBNQ
Date: Mon, 11 Mar 2024 04:24:39 +0000
Message-ID: 
 <TY0PR04MB6328049134D3D769E12E607F81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SEYPR04MB7362:EE_
x-ms-office365-filtering-correlation-id: 9927ff1b-3a39-42eb-ae11-08dc41832af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O2hUF6PjrlAopn4NrPtwCipJJ2PjiiAjtgclNSHLkXTIgjbW3Iqaz/L+doq5TE0LguUAu4o03RTlVRG2RJY8XECTQ7KwG51pgXlB7+njWK5n812FWzXd0YlXOKbR2M933xxaj6YSnsWdVuizX+AAUNxMm4htQvKRZ7kplHetATSkhaqolVsAoB4zxOLUB0Ioxqi9UgnNDf/DmIBNB9v5810FhHlXg7dtx1VBHKJec3Xs696VyPPCmyWMgWlGtC7rYjpQOjxpOayjyN5itY0lwau0dflhmPKYDiSHKsY/paMw9c2Co3qZNsGQTCzSf4zFaKjXrEPobQg1XO7VsMLwWuW4rVCXdQ7JoMAhDwQ/X0Msu9g5clkw6EF24zFKUv8ZCys+hxC340GokUZaL5mjJgoqpWYGMnL/GooWj8YeMToouTElq1bCcvEhZoHiS6x6ZK8KmmIrPXrd4T5xvmlM/BuSK0z7vogyaqvaQxXwOOnqLloMtm5t0yGtEXYRUIFiLQ1po7Hi2N8U6BWC7e4TbyvBWfURou5OEZqCCXFhT1vNcLwE9yqq1sHKmyRKjUhlLb+Z+BkqyEvBBIo2d4bNRGjqYxfs8WOzQc9nq5FNAA8FAOT+nLYzRdIJCqIyob/Z2++INYyhhAuJgXiUJvypta8ycnmrkNULvgQ5ZxLGE0dleABfTmvy45bY1WTG1jkfvaz8DLsLAJ9622wod1vXNcl42xA2fXR0uiu96i+tSyU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S0k3Mk1nV0NUREVMdlpNRytnODZvT2JtaC80UXpsSWFSa0lzK2k5OWpkSy9Y?=
 =?utf-8?B?QjdnTHgrQmtCTWI3NlVFWVN4NDJiM1NicEwrMmdCS3pnaUZGUHU4akF0T0tx?=
 =?utf-8?B?NzZha25kdjlXV0ttcjZkV01KbkFTVGN2OHdGcHpSQXJNTm1nV29CeGd2cjYy?=
 =?utf-8?B?UWQxYXZtVzBYd2FjUjI3d0N0bmFaU3huZnRtMjZWVWxWNFlnYWFlaEJqNDFH?=
 =?utf-8?B?OW9BenlIaXVTMlJOVE8rZW1nUCtWVzdIVG0xdmtPeTRPcEJsWko5NGdzVk0r?=
 =?utf-8?B?eCt3OG1Pa2hDMDZLYURDTGVjcDcxTzJzWGY1MVdkUTZ5RHNmSGhtL1ZYb3Ju?=
 =?utf-8?B?ZEJJeWJxbXFyajFncEQ5cTlLYU5mZ1V4dkV6T29IdWNkakVMTFVpY0xBZVJJ?=
 =?utf-8?B?Z2lxV3NSTDZUc280SWpzUEY0NFNJVEpSMHNTRU5SVDk1RGxqK1BQYlluTDVW?=
 =?utf-8?B?a2ZqWU9MZFNENFNacEV1VzJ4aTVLN1htQjZCMFBtQlozeE8zTDc2amtkdGlj?=
 =?utf-8?B?YVowWlM4MDFRYXZ0TWh5N096WVZ0OGpHb2FaRWhHTEZXcFp2OFgxd29GUWlF?=
 =?utf-8?B?UzBpaFR0NTZzbExRODNEVTk3eDBWSEs3TitrRlY4RkZkMjdEOWV4VitXUWhh?=
 =?utf-8?B?RE16Z0IyUXVLN1JJVlFWaTVZMVVSa2pJRTJzMUhwN2JQMjY4bm12VzVUUUd3?=
 =?utf-8?B?aDl0WFAzVkZEZkRmWUdZZlQ4VEpRK2MwL3JQd2NxaG5hcFFYT016VkhYUERT?=
 =?utf-8?B?amduandFSjZ0TjEwM2pVNmxyaFhLYmZCY1pTZFJlcmFuOWcyTDdzMkxCeVBs?=
 =?utf-8?B?SC9wcm9YOU5Nb25JalU1cDFyUmtFajFib1pYdVVUTU1rbmtnN1ZmUE9RL2hh?=
 =?utf-8?B?RUVzRXNhbUZFS0E3M1FQOVVDUWs3aktCU050ZzhEUUhhT25YYlpMNGJuN1RN?=
 =?utf-8?B?RHpEbS9HalBxd05XTDE0V0FNVUNndlp1aUtweUlSZEZyYUtIdmRmTXZEM0x3?=
 =?utf-8?B?NXdzNVdrb3hIUVJMN29mbmtRcklxT3R4dG9xMEppb2xIcGwrcFBGK3JET2lo?=
 =?utf-8?B?bmN3U3c5NlIvRXM5dm42V3k5bkVCWCtXcnZMdVhRa2p1elg4Zi8wQlYzZG1O?=
 =?utf-8?B?TjJWR2VBOFZRZTFnRXQ2VnZxd1pIOUpISC9pZFBTdm5ScVkxemVYMVYrV1Q0?=
 =?utf-8?B?Q0IwS2IyNEg5Ui9OVzdsV3NSL2EyVE5FRDcxcEdBRXZWbU9Nc21ROW9jTC94?=
 =?utf-8?B?UTlJUWlDZ0FYU3Y2TDJYbWQyUG8wZy8wV042dUpCaG5lQXFIY0lIckR4bmlp?=
 =?utf-8?B?WGZKMjBSSVViQ3lOT3lFbXJ1RTVueCtBeElnMnA4RkdQS2NHVHdDMnlCSFpL?=
 =?utf-8?B?bVBiWUZrSXY5R3hxV0RYOHdlaWRUWE83NFgrSnRUenNOUHhRdEh6Qk5ZbVdp?=
 =?utf-8?B?Vm4rRGp1QitxZ1FzL0VsVHRkSjBZQktQTUErZmc2Mm1XRXE4ZzlCMjUwMUhx?=
 =?utf-8?B?c0FUMHVFQ1BYdGZPNmRjTDFqcy9wanAzSGh1dnZFV29Fb0YrRENxNEl6WFB5?=
 =?utf-8?B?QkdIeTFUYjZZM3M4WnVxZEY4cU0veHZnQnNHNXU4MC8vSUI0STRwaGZGdVlr?=
 =?utf-8?B?K0FIK1dzRlE4bTdid050YStIRmErWDRRaTFHRFE2UmgvV1d6eXZnSTAyd3I0?=
 =?utf-8?B?S00zcnJkUVVIdmwyaGZOUENxMjhuRmdkTXZySjEwdXNENFdTT055ajlLK0xI?=
 =?utf-8?B?ZWx6K0hMSG5OYzZIN2tNUFBJekhlZllqVlliYXRCcGdYTzRTMFRZL2pWNnRj?=
 =?utf-8?B?YTBSaUlMaWordFNSejMveUYzaVlQYkpKMXVGY3BIY1dmUUR2Y1c3dkpCMnAy?=
 =?utf-8?B?QVh4bGZqdlFlbldZYmlwMVM5THhmSS9oYy9pRzZydGRoUFNQOEpwamlCK1Zu?=
 =?utf-8?B?WllSdEsvcjhZUWY2SWduV3lZK1haQkhkOWpaL2RKdlRURlZVdXdQaTFhSUdB?=
 =?utf-8?B?S0RGS3FyR3pFZVczOHU3YlhwQVh5bWF0NHF2V3RPZk1yc3BDcVoxdzY4b0xs?=
 =?utf-8?B?anhDWjM4T3F4MXJPNm5QdURLaExldWRYTFlzNk1DY3ZTMmRVWnMwUWxFME0w?=
 =?utf-8?Q?C/BvwfzkFLtSQc1D3iVNAYhpD?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RBoSn9dbK3dKRekbm+AkI6A4C/scWosugmSRJbw/PbwTPDp72RPXKCauZF9bsCPchKAXawcfVEt4kLdBJ3xWNWFz9qtyfF1X12Zmkhg7VLcD3hKk8LkcfqEu/Hc2Ri/dlkxIdCWlejvjstas7mIPIIJAehoXiAYYkr4V+DNjGdql9/iVan8ANh1Hu+faCYPm02urzUu5sIeXFrlSjm13Elw+nzByBuMorojVkMOx09V61BArgrQpqcDLqQxKrph9c5NgY3UEgVPbK3cl1TxgjZ4GDkXvs4910+/qgYj3mg0mVdj3bQHdmrojTwdin7hNEH4lTA9gOVKxkJ4H891r+CJbRL3E9KbGVLl3NeJkGqMOT4oTwgHafeSLIijBjKsidrVeM+Oueia6bPlg2JHgUcEJ1lc3W1FNGwLwnZqGlP6h/FUMbIa5lE0WuUr1PQoQd0lanQWnBoCsy+872tfFvfl5ZwxqveYiSC23hpP8J72eXdeSaYrkV4RMAOqhmPXPJADozWWHCm/JvTSC6Btd80LcfSLRg5PV+q54GhxrQB2vd0V5kUSWFA0AKdo5y76725e0KWGpiRo/+ll25Q7+Bb96QrJtg2V+eEBj8Zkh+6LL2TG5fQFB9Nvn4DmA6RDo
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9927ff1b-3a39-42eb-ae11-08dc41832af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:24:39.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezBy/Er9jM82ZhbQm1lxR+3SfpRdk/W/3FRjaR1NJpizEqd5fQXnJvA6UI0dSmRajtfNwBGQMh4FUaUFeHIYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7362
X-Proofpoint-ORIG-GUID: yyVhAY_7CI2KRBxn7BrwZ6JILucvfto4
X-Proofpoint-GUID: yyVhAY_7CI2KRBxn7BrwZ6JILucvfto4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: yyVhAY_7CI2KRBxn7BrwZ6JILucvfto4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

VGhpcyBwYXRjaCBzZXQgY2hhbmdlcyBzeW5jIGRlbnRyeS1ieS1kZW50cnkgdG8gc3luYw0KZGVu
dHJ5U2V0LWJ5LWRlbnRyeVNldCwgYW5kIHJlbW92ZSBzb21lIHN5bmNzIHRoYXQgZG8gbm90IGNh
dXNlDQpkYXRhIGxvc3MuIEl0IG5vdCBvbmx5IGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZSBvZiBz
eW5jIGRlbnRyeSwNCmJ1dCBhbHNvIHJlZHVjZXMgdGhlIGNvbnN1bXB0aW9uIG9mIHN0b3JhZ2Ug
ZGV2aWNlIGxpZmUuDQoNCkkgdXNlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIGFuZCBibGt0cmFj
ZSB0byBtZWFzdXJlIHRoZSBpbXByb3ZlbWVudHMNCm9uIGEgY2xhc3MgMTAgU0RYQyBjYXJkLg0K
DQpybSAtZnIgJG1udC9kaXI7IG1rZGlyICRtbnQvZGlyOyBzeW5jDQp0aW1lIChmb3IgKChpPTA7
aTwxMDAwO2krKykpO2RvIHRvdWNoICRtbnQvZGlyLyR7cHJlZml4fSRpO2RvbmU7c3luYyAkbW50
KQ0KdGltZSAoZm9yICgoaT0wO2k8MTAwMDtpKyspKTtkbyBybSAkbW50L2Rpci8ke3ByZWZpeH0k
aTtkb25lO3N5bmMgJG1udCkNCg0KfCBjYXNlIHwgbmFtZSBsZW4gfCAgICAgICBjcmVhdGUgICAg
ICAgICAgfCAgICAgICAgdW5saW5rICAgICAgICAgIHwNCnwgICAgICB8ICAgICAgICAgIHwgdGlt
ZSAgICAgfCB3cml0ZSBzaXplIHwgdGltZSAgICAgIHwgd3JpdGUgc2l6ZSB8DQp8LS0tLS0tKy0t
LS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
fA0KfCAgMSAgIHwgMTUgICAgICAgfCAxMC4yNjBzICB8IDE5MUtpQiAgICAgfCA5LjgyOXMgICAg
fCA5NktpQiAgICAgIHwNCnwgIDIgICB8IDE1ICAgICAgIHwgMTEuNDU2cyAgfCA1NjJLaUIgICAg
IHwgMTEuMDMycyAgIHwgNTYyS2lCICAgICB8DQp8ICAzICAgfCAxNSAgICAgICB8IDMwLjYzN3Mg
IHwgMzUwMEtpQiAgICB8IDIxLjc0MHMgICB8IDIwMDBLaUIgICAgfA0KfCAgMSAgIHwgMTIwICAg
ICAgfCAxMC44NDBzICB8IDY0NEtpQiAgICAgfCA5Ljk2MXMgICAgfCAzMTVLaUIgICAgIHwNCnwg
IDIgICB8IDEyMCAgICAgIHwgMTMuMjgycyAgfCAxMDkyS2lCICAgIHwgMTIuNDMycyAgIHwgNzUy
S2lCICAgICB8DQp8ICAzICAgfCAxMjAgICAgICB8IDQ1LjM5M3MgIHwgNzU3M0tpQiAgICB8IDM3
LjM5NXMgICB8IDU1MDBLaUIgICAgfA0KfCAgMSAgIHwgMjU1ICAgICAgfCAxMS41NDlzICB8IDEw
MjhLaUIgICAgfCA5Ljk5NHMgICAgfCA1OTRLaUIgICAgIHwNCnwgIDIgICB8IDI1NSAgICAgIHwg
MTUuODI2cyAgfCAyMTcwS2lCICAgIHwgMTMuMzg3cyAgIHwgMTA2M0tpQiAgICB8DQp8ICAzICAg
fCAyNTUgICAgICB8IDFtNy4yMTFzIHwgMTIzMzVLaUIgICB8IDBtNTguNTE3cyB8IDEwMDA0S2lC
ICAgfA0KDQpjYXNlIDEuIGRpc2FibGUgZGlyc3luYw0KY2FzZSAyLiB3aXRoIHRoaXMgcGF0Y2gg
c2V0IGFuZCBlbmFibGUgZGlyc3luYw0KY2FzZSAzLiB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0IGFu
ZCBlbmFibGUgZGlyc3luYw0KDQpDaGFuZ2VzIGZvciB2Mw0KICAtIFsyLzEwXSBBbGxvdyBkZWxl
dGVkIGVudHJ5IGZvbGxvdyB1bnVzZWQgZW5ydHkNCg0KQ2hhbmdlcyBmb3IgdjI6DQogIC0gRml4
IHR5cG9lcyBpbiBwYXRjaCBzdWJqZWN0DQogIC0gTWVyZ2UgWzMvMTFdIGFuZCBbOC8xMV0gaW4g
djEgdG8gWzcvMTBdIGluIHYyDQogIC0gVXBkYXRlIHNvbWUgY29kZSBjb21tZW50cw0KICAtIEF2
b2lkIGVsc2V7fSBpbiBfX2V4ZmF0X2dldF9kZW50cnlfc2V0KCkNCiAgLSBSZW5hbWUgdGhlIGFy
Z3VtZW50IHR5cGUgb2YgX19leGZhdF9nZXRfZGVudHJ5X3NldCgpIHRvDQogICAgbnVtX2VudHJp
ZXMNCg0KWXVlemhhbmcgTW8gKDEwKToNCiAgZXhmYXQ6IGFkZCBfX2V4ZmF0X2dldF9kZW50cnlf
c2V0KCkgaGVscGVyDQogIGV4ZmF0OiBhZGQgZXhmYXRfZ2V0X2VtcHR5X2RlbnRyeV9zZXQoKSBo
ZWxwZXINCiAgZXhmYXQ6IGNvbnZlcnQgZXhmYXRfYWRkX2VudHJ5KCkgdG8gdXNlIGRlbnRyeSBj
YWNoZQ0KICBleGZhdDogY29udmVydCBleGZhdF9yZW1vdmVfZW50cmllcygpIHRvIHVzZSBkZW50
cnkgY2FjaGUNCiAgZXhmYXQ6IG1vdmUgZnJlZSBjbHVzdGVyIG91dCBvZiBleGZhdF9pbml0X2V4
dF9lbnRyeSgpDQogIGV4ZmF0OiBjb252ZXJ0IGV4ZmF0X2luaXRfZXh0X2VudHJ5KCkgdG8gdXNl
IGRlbnRyeSBjYWNoZQ0KICBleGZhdDogY29udmVydCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KCkg
dG8gdXNlIGRlbnRyeSBjYWNoZQ0KICBleGZhdDogcmVtb3ZlIHVudXNlZCBmdW5jdGlvbnMNCiAg
ZXhmYXQ6IGRvIG5vdCBzeW5jIHBhcmVudCBkaXIgaWYganVzdCB1cGRhdGUgdGltZXN0YW1wDQog
IGV4ZmF0OiByZW1vdmUgZHVwbGljYXRlIHVwZGF0ZSBwYXJlbnQgZGlyDQoNCiBmcy9leGZhdC9k
aXIuYyAgICAgIHwgMjg4ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGZz
L2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMjUgKystLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgIDIg
Ky0NCiBmcy9leGZhdC9uYW1laS5jICAgIHwgMzUyICsrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCAyOTEgaW5zZXJ0aW9ucygrKSwg
Mzc2IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMzQuMQ0KDQo=

