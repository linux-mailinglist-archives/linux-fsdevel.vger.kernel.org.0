Return-Path: <linux-fsdevel+bounces-4318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E27FE852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69233B20C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79520DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kUWrJ0zK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062210C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 19:10:09 -0800 (PST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU0GcFF005456;
	Thu, 30 Nov 2023 03:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=njTA1K9IEubiI/kq/FpFWTg00khYaVYsMiM3zPJnTvA=;
 b=kUWrJ0zK1Xh7e7l/QkTMDTSaPwSZnmeOTJoDFxgjo66mtg/Gzz7eY8kTVl25ZSlWSByJ
 biRAIUDX01m1XSMtnK2WJ2cmlkf/a7VJgymApVW35zQGWT6AnR6Y+OPce2M1InnnARZ+
 6vfVbAX05kYGM5sxae2bVcmas16u2PQC6Jmvbq0msE3FEtRCL+Zy8q0nmSfqkIURXwRf
 skHSkzvcCU7kC+gR4ciDrJZOKFB0F2cC86RDFE5rg1ZrY1PVEczQps9yS2DytaIs6QbN
 K3nIKXHDKXrfaVqxchdB91x+YrRymIo1eCVsmgM4OwvXuWo+uYzSuY+phrW0qiryDVHO gQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2110.outbound.protection.outlook.com [104.47.26.110])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk74k51c1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 03:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoA9rQ3KwpwHjrQ+0dkGRVBh/TDoYRwCh8M3zIUruf8Z5AMKYcLXjKc5Vk2Vl6yNGvlKx1eEwnUjquWFCkvOiQXfXDhjMGsE6i+CMVtkbbOmFRDDYoPq/WiH2X+bFCPntajDMZBuKIyqguqh9gin2WYI6fqphSLOsgMY+o+Qoso04uweDyZ/eceqPNSaZagSDE4Qieo7NQt4+kL5k/A1BL0U0TvdGKH8YHtLEZsZAGBAS0STo23ZKYsLeki5AENs3R7PFkGZl1lfQMveZugxsMgiAwLFARXcjIV3KDV7JmeY1uP5rO9KbMaYWCzsn+8GE0T72KBrLOsle3yriGbCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njTA1K9IEubiI/kq/FpFWTg00khYaVYsMiM3zPJnTvA=;
 b=IFKNUUjhNhgt7STb5upREuE4jMKZgFveUIIawuJnYhXq2k+tmF/JRxywc/kjxbVgoxCmGYkKhyC6lyvmK+rkjLzrxWljdTwWcRZ5mhl7/kZLSdOvO44Z+Q5eb8s8yRAisOkCBUpIEpfknjuOzBK24OhjSiypAn2jEnh4lyp9XPPvegCWLmh1N1iFBcg8PQoxiHaxdca8NtrngsSJ/agApHSoGFdAIJTblUuoXmESWhff8PwObsm/NNLlWyyhJwYJMc3ZKXuBUnz9JwOKfq0qK/ZrOApNn3sEpA++1DzliKYmDKNTAD9dmmjr3a8AGisI0UzKVifaee8tDHb3eBsMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI6PR04MB7955.apcprd04.prod.outlook.com (2603:1096:4:249::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 03:09:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 03:09:56 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: [PATCH v5 2/2] exfat: do not zero the extended part
Thread-Topic: [PATCH v5 2/2] exfat: do not zero the extended part
Thread-Index: AQHaIzqx2EwE8CcrTEWOX6kqOI98NQ==
Date: Thu, 30 Nov 2023 03:09:56 +0000
Message-ID: 
 <PUZPR04MB6316DEA8F474D138BDDD206D8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI6PR04MB7955:EE_
x-ms-office365-filtering-correlation-id: 09aeeb64-1738-4875-ee8b-08dbf151d477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hXgzP16w7Xlyjpit+/XXJ8eTt0KCpgYu8rZrOeCxLdAJ0jPrIooo7iHC9sb2RDiHRNHASd+9bvt2vlPKLnFg6xoP9sNlXhy77HiFdrMCE2IV3wvUghGKiM21geyJZmIzwMMtzyWDrIn5MmYUJnpqWVvns2+U4G8yITissXnZnDpFo0zvenW2xA1/B3qxJMedOUWu1A7Py0pyPUFSHFP9lSN2A/1+maVMUDuIyQvmg49W6NWYjmvatPFRfS2gEsaT/MRjSO7b3bkFb08LKRjRt+2yFtsKJX96XJVDYK61HG8WU4t0K9tH/Wjy+bMzzZbQM9qENnCsE5z1hw7iP0AuSKwj+w0qSTAE8OZhRKu5cFSq+aVMyWPqUaVYIwIuTXV9/QZAmU3G7FXsULs5hTu74vcF87t76Cr8VU5fzeAobrlAiDVsnWs25+u3PRNadEhG8NL2IAeCl4UBdoU98kQmgi0ddJ86yeMv3tXOkl4qj4Hy6O2NLGOpBawK/3tjyxLhmdD11jMoTH8Wy7VAOAmtsWpZx1dXEt1kCYqErDiuZmDuJyP4EPE/7LzEQl2w3hv37Z6TApRbJc2zcuG3tcsQmQKPnxde/KW7c9EiavVhpQmKtqkQRfbVeulrPosMF3+5IV6ByvzsFLCY09MY9lSyafW2LfVeffKuKUTOIpN7Cxo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(478600001)(26005)(9686003)(33656002)(7696005)(6506007)(41300700001)(38070700009)(38100700002)(122000001)(83380400001)(86362001)(71200400001)(82960400001)(2906002)(202311291699003)(66946007)(52536014)(110136005)(76116006)(55016003)(66446008)(316002)(64756008)(66476007)(54906003)(66556008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mlh5Mk14am1LUWZJcUFJY05EYjVJbWs0N1JXVldZZ2ozaEQ4OFhzWE9iUFY3?=
 =?utf-8?B?RjY4QzJDbGVwdnRsZUgvWi9ROWdtTUNtQ2VxV0Q3MXhFemkzY3JHRDdReVFt?=
 =?utf-8?B?K2NZQjhDd2hKZk4yTEFxTDNTZkYrODE2MEJWUUhrYVlBK1pGM003VXpzczNw?=
 =?utf-8?B?dmxuYnJvb1lGa3orUW40c21NeURQSktLR25KWS9hYTJNL2hteEJQOXpYTkp2?=
 =?utf-8?B?bkNEdnE4dW1GbXlwUGkxbWdNTEhMeWtBaEdpUko3M2tMWitoaVMvWDVtY2NR?=
 =?utf-8?B?d1V2ejRHUnNMYnd2eENhRVhxNGpyVVJTeWc4M3JybHZ6WUJ3dUZobjNJVFcv?=
 =?utf-8?B?OG9kekdIandZZWszakxteWZYMzVUN3huSXhGN3hpRTJlZGcwelBrbzRRMEZu?=
 =?utf-8?B?aXB6YlNTazJ0MXdLZGVUOXJPMVJ2UFA3TTVOZy9sVFU0SnBnLzAraVF0NFJG?=
 =?utf-8?B?L0RKQkJZSXlFd2lDYkZKRVZOMExUdTkyWGJKOXhSSzd1S2dDZys4a3VKRWh3?=
 =?utf-8?B?NFFaSlF6eW5qTFJHZmpNbUpYMVZqb2w3NTI5aHF1YnJMQkhxR2xEQ2kvQ0ZX?=
 =?utf-8?B?QVdKUkordFR0a3c5aDdmblBWeXd2cGQ1dE1vQ1ErMTI5b3lsVVMrTjR2a0pX?=
 =?utf-8?B?ZTlGQ2ZZVE1IR3pzbGhGRHNlbklxaWF3Y3NENTY2ejJiSkVNWG11dWMrVTJI?=
 =?utf-8?B?V1VjZkxyM0hDdk9YMzBRNElLOWpQVytjVkZwMmFVSXBhVlRhVE80VSszSVQ3?=
 =?utf-8?B?bWtDMXJTZ2RtSTJ4WXVZbjd5L2IyZlBxL1BpT3U1bXN3WGllUHRXdDVOdzZu?=
 =?utf-8?B?dURkYWJqNi9PRTRiaEpkN3h2VnkwQWR3VEtyb2FRc0U1UkVSTDFVVTJkSk5k?=
 =?utf-8?B?QWpsNW9BalFVUFNDQjluUFVwV1d5NTRYZG9jbmhFVVVyeE1Kbkpwa3dlZ2lF?=
 =?utf-8?B?eG5IWGlLaG1saWZuSDRLcC90SDFCV201MWIzTjVrNi9JclpsTGZ0cldJMlJL?=
 =?utf-8?B?aVVRQ1pQam16Q1A0eXdhcmg5K0FvRjlSVUtvMEI5NDkveUNOYUlmK3MxWWdk?=
 =?utf-8?B?N3hTK1FFT1NsRS92dllGTDEwbm1rbzFWbDRmdzQ3NjViMGlIS2JCRUNHT3Bt?=
 =?utf-8?B?UlIwZnhzclZ0Nm5SeGdvTkt5T0ZYMnk3NlJaa2pkekQ2bUQ1TTl6bjlwRlhy?=
 =?utf-8?B?QUJ0UU1yQTBBM01zSFUxaFJPWFNiVEVsUmMyZkhmYUNKakFOeC9wTlRhMkFi?=
 =?utf-8?B?UUlOcENta2NMdDJYN0hIYVFwOTUrb05RTVh0QXZiWXVIbjh1S0tOK1JNdmVF?=
 =?utf-8?B?bU5ySzBpVlBWRVNkdjZ2YVZIOXp6UzFzMnJlSzdnOVBMc0pqZnZGRU8xSUR1?=
 =?utf-8?B?Rzh2dEFvbnhSK3BmcG50czBqUHVDMnlKM2hrRGZOQ1dEdkhDaFByV3NpWUc4?=
 =?utf-8?B?ZGdDV2FLa0d2a29qNmNwUGVMKzZRMGZqRVVzVVZqTHVtRXNsQzlIbjdQWFJQ?=
 =?utf-8?B?ZWM1cmVBQmFKZFdxejNoNDQ0QnJzV0xVVlRJbW52Z0k3aWdaWDJJTlFiQjdq?=
 =?utf-8?B?M2NTNzRYNGJ5eHMxcDUzQ3NsN3hEYk9LYW5teXFMRllKYjdZWnNBWUFCTng4?=
 =?utf-8?B?TkpsRFlHS1ZvdW9acFB2dzFZaDd4ZUJMYlc2T3IwZmVxZktjR3JoTFpaRHc0?=
 =?utf-8?B?RENBa1NWUlV1UGk1VnlvckprZVdJbk5RNXNQdXQ3bEJmczFWMVh4OXZSL2hD?=
 =?utf-8?B?Y2tRS09UYml1V2hsOUdIbE9VcFdmVzVQN3A1NnhQcXZYd2ExaDZXaWFyT0hj?=
 =?utf-8?B?SXJMVE9rUDJmWExXTXZaK1BscU00cnZtcVJvWnVOWnBhWFJ6TjFkcnk4ZmpG?=
 =?utf-8?B?cURSejQrVEtBWDRJelNwVURUdnZPejZHU1RGV0ZscEZJM2NLa29YWUhqSWVu?=
 =?utf-8?B?RFZLOXBFMEQ1dTFwWlhwRVFaMGYvRnNBZ0p5OUpmTDlyZzU4UnZVZXRpSUF5?=
 =?utf-8?B?MHdHRlZpWFVyMlRwc2dxNHJWSEZJVXVBd1NKZmZqVVZCM3FnV3FjOUREaXcv?=
 =?utf-8?B?YUFqOEp6VU82dElBaUZFSlFhVTRtZDdnQVJWL3c4eTFxWkltaXF3b1paR0Jw?=
 =?utf-8?Q?j9wX6s6we9xju/2DmPvqPKoRg?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WprjsCYzv/truNzKr1yzFwpLLrLjPuXe3Fp6oiYMOhQPBFLBV1lydGtIpfOKGwUgRYIuZMsQSIwTKp4asF+Rj10CpB2N/A/xwoGHLm3rFdPyYssiMCmPYdplytJjh72K9109egc1fobQUbqTNqiUs/TeEoDeM1WcndKwIgAiFs5jJviW5+VGe3xRB8FOTAB0gMIuavXmfuHLu8aY0QbJrjH8mumy2SN3kA90JncvO+dWqzaNg54i9cR6xRU7LW0ldTE5+WKdopZG8GVeyer7EXXp4px6XRD1eX9snzNZbBzr+gT0lbDjIwXDRuX+c0y80qbY2HUXV7OguFgag/qmXWoIPo0SnDh9s/pIVLqwz8aT/96YXOWaATnbxGkvmkPOHH4CFGmqttBWKNl2wRfPaBJ/cBbwueGyMFALRSVEz/vCUUd3Anbug8PSMp0VlFbExs0yHeuuiHrT3GkV9n8aicAplxBXQ0vMAuJKfxDsGL3z2ekWfLt+D4zswhCDSFjdiPqSeJsvEo3h/xyymAXsb+raV43Znn1aRIazkncoOF2LdPSIViVJzdWdLBnSgWkSrnxOn1sQfgcKK94medeuSykCRaaWEc0SpstGi+owI5L3tPYv0zAXdqanNcxY4e8Tuc7a936RBq0jR58pM1kXGXwisTW33Wn+F43Kh9782aaXEN93ZsQezx+DQ1DB+bnb8ENCPZYbzB4CCAH5ZheKQm0q2waUNhiU+eS7CRo3lwHo/V9eGCGJxOHqimX5MsjDKVLValI/f8Fd/sZlMuycsi4H5Wsa1gzCGxUiDjbeOTyJu30NU+uJrGYjF7+5I27ZIVgL6MiWsho3WboxKOL1KA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aeeb64-1738-4875-ee8b-08dbf151d477
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 03:09:56.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHC44U/Fa+/Jbzm+iKmKhgZpkRL3Z3qb8dgxXRg2VoW4N+W32oCdn/RLJqyudhnecQq50Z8EzLr3qtAH2fY6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7955
X-Proofpoint-GUID: wQty-wx7GzeW_fWNSecezAelooq3QHLn
X-Proofpoint-ORIG-GUID: wQty-wx7GzeW_fWNSecezAelooq3QHLn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: wQty-wx7GzeW_fWNSecezAelooq3QHLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9p
bm9kZS5jIHwgMTQgKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCsp
LCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZpbGUuYyBiL2ZzL2V4
ZmF0L2ZpbGUuYw0KaW5kZXggMTU0ZjM5YTAzYTY5Li4zZDAxYTRlZWZjMTEgMTAwNjQ0DQotLS0g
YS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KQEAgLTE4LDMyICsxOCw2
OSBAQA0KIA0KIHN0YXRpYyBpbnQgZXhmYXRfY29udF9leHBhbmQoc3RydWN0IGlub2RlICppbm9k
ZSwgbG9mZl90IHNpemUpDQogew0KLQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGlu
b2RlLT5pX21hcHBpbmc7DQotCWxvZmZfdCBzdGFydCA9IGlfc2l6ZV9yZWFkKGlub2RlKSwgY291
bnQgPSBzaXplIC0gaV9zaXplX3JlYWQoaW5vZGUpOw0KLQlpbnQgZXJyLCBlcnIyOw0KKwlpbnQg
cmV0Ow0KKwl1bnNpZ25lZCBpbnQgbnVtX2NsdXN0ZXJzLCBuZXdfbnVtX2NsdXN0ZXJzLCBsYXN0
X2NsdTsNCisJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQor
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCisJc3RydWN0IGV4ZmF0X3Ni
X2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCisJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCiAN
Ci0JZXJyID0gZ2VuZXJpY19jb250X2V4cGFuZF9zaW1wbGUoaW5vZGUsIHNpemUpOw0KLQlpZiAo
ZXJyKQ0KLQkJcmV0dXJuIGVycjsNCisJcmV0ID0gaW5vZGVfbmV3c2l6ZV9vayhpbm9kZSwgc2l6
ZSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwludW1fY2x1c3RlcnMgPSBFWEZB
VF9CX1RPX0NMVV9ST1VORF9VUChlaS0+aV9zaXplX29uZGlzaywgc2JpKTsNCisJbmV3X251bV9j
bHVzdGVycyA9IEVYRkFUX0JfVE9fQ0xVX1JPVU5EX1VQKHNpemUsIHNiaSk7DQorDQorCWlmIChu
ZXdfbnVtX2NsdXN0ZXJzID09IG51bV9jbHVzdGVycykNCisJCWdvdG8gb3V0Ow0KKw0KKwlleGZh
dF9jaGFpbl9zZXQoJmNsdSwgZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzLCBlaS0+ZmxhZ3Mp
Ow0KKwlyZXQgPSBleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgJmNsdSwgJmxhc3RfY2x1KTsN
CisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQogDQorCWNsdS5kaXIgPSAobGFzdF9jbHUgPT0g
RVhGQVRfRU9GX0NMVVNURVIpID8NCisJCQlFWEZBVF9FT0ZfQ0xVU1RFUiA6IGxhc3RfY2x1ICsg
MTsNCisJY2x1LnNpemUgPSAwOw0KKwljbHUuZmxhZ3MgPSBlaS0+ZmxhZ3M7DQorDQorCXJldCA9
IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoaW5vZGUsIG5ld19udW1fY2x1c3RlcnMgLSBudW1fY2x1c3Rl
cnMsDQorCQkJJmNsdSwgSVNfRElSU1lOQyhpbm9kZSkpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJu
IHJldDsNCisNCisJLyogQXBwZW5kIG5ldyBjbHVzdGVycyB0byBjaGFpbiAqLw0KKwlpZiAoY2x1
LmZsYWdzICE9IGVpLT5mbGFncykgew0KKwkJZXhmYXRfY2hhaW5fY29udF9jbHVzdGVyKHNiLCBl
aS0+c3RhcnRfY2x1LCBudW1fY2x1c3RlcnMpOw0KKwkJZWktPmZsYWdzID0gQUxMT0NfRkFUX0NI
QUlOOw0KKwl9DQorCWlmIChjbHUuZmxhZ3MgPT0gQUxMT0NfRkFUX0NIQUlOKQ0KKwkJaWYgKGV4
ZmF0X2VudF9zZXQoc2IsIGxhc3RfY2x1LCBjbHUuZGlyKSkNCisJCQlnb3RvIGZyZWVfY2x1Ow0K
Kw0KKwlpZiAobnVtX2NsdXN0ZXJzID09IDApDQorCQllaS0+c3RhcnRfY2x1ID0gY2x1LmRpcjsN
CisNCitvdXQ6DQogCWlub2RlX3NldF9tdGltZV90b190cyhpbm9kZSwgaW5vZGVfc2V0X2N0aW1l
X2N1cnJlbnQoaW5vZGUpKTsNCi0JRVhGQVRfSShpbm9kZSktPnZhbGlkX3NpemUgPSBzaXplOw0K
LQltYXJrX2lub2RlX2RpcnR5KGlub2RlKTsNCisJLyogRXhwYW5kZWQgcmFuZ2Ugbm90IHplcm9l
ZCwgZG8gbm90IHVwZGF0ZSB2YWxpZF9zaXplICovDQorCWlfc2l6ZV93cml0ZShpbm9kZSwgc2l6
ZSk7DQogDQotCWlmICghSVNfU1lOQyhpbm9kZSkpDQotCQlyZXR1cm4gMDsNCisJZWktPmlfc2l6
ZV9hbGlnbmVkID0gcm91bmRfdXAoc2l6ZSwgc2ItPnNfYmxvY2tzaXplKTsNCisJZWktPmlfc2l6
ZV9vbmRpc2sgPSBlaS0+aV9zaXplX2FsaWduZWQ7DQorCWlub2RlLT5pX2Jsb2NrcyA9IHJvdW5k
X3VwKHNpemUsIHNiaS0+Y2x1c3Rlcl9zaXplKSA+PiA5Ow0KIA0KLQllcnIgPSBmaWxlbWFwX2Zk
YXRhd3JpdGVfcmFuZ2UobWFwcGluZywgc3RhcnQsIHN0YXJ0ICsgY291bnQgLSAxKTsNCi0JZXJy
MiA9IHN5bmNfbWFwcGluZ19idWZmZXJzKG1hcHBpbmcpOw0KLQlpZiAoIWVycikNCi0JCWVyciA9
IGVycjI7DQotCWVycjIgPSB3cml0ZV9pbm9kZV9ub3coaW5vZGUsIDEpOw0KLQlpZiAoIWVycikN
Ci0JCWVyciA9IGVycjI7DQotCWlmIChlcnIpDQotCQlyZXR1cm4gZXJyOw0KKwlpZiAoSVNfRElS
U1lOQyhpbm9kZSkpDQorCQlyZXR1cm4gd3JpdGVfaW5vZGVfbm93KGlub2RlLCAxKTsNCisNCisJ
bWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQorDQorCXJldHVybiAwOw0KIA0KLQlyZXR1cm4gZmls
ZW1hcF9mZGF0YXdhaXRfcmFuZ2UobWFwcGluZywgc3RhcnQsIHN0YXJ0ICsgY291bnQgLSAxKTsN
CitmcmVlX2NsdToNCisJZXhmYXRfZnJlZV9jbHVzdGVyKGlub2RlLCAmY2x1KTsNCisJcmV0dXJu
IC1FSU87DQogfQ0KIA0KIHN0YXRpYyBib29sIGV4ZmF0X2FsbG93X3NldF90aW1lKHN0cnVjdCBl
eGZhdF9zYl9pbmZvICpzYmksIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IGE3YmIyMzRjOGJiMS4uOTc5
M2M2NGY0YWQ2IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQv
aW5vZGUuYw0KQEAgLTc1LDggKzc1LDE3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAlpZiAoZWktPnN0YXJ0X2NsdSA9PSBFWEZBVF9F
T0ZfQ0xVU1RFUikNCiAJCW9uX2Rpc2tfc2l6ZSA9IDA7DQogDQotCWVwMi0+ZGVudHJ5LnN0cmVh
bS52YWxpZF9zaXplID0gY3B1X3RvX2xlNjQoZWktPnZhbGlkX3NpemUpOw0KIAllcDItPmRlbnRy
eS5zdHJlYW0uc2l6ZSA9IGNwdV90b19sZTY0KG9uX2Rpc2tfc2l6ZSk7DQorCS8qDQorCSAqIG1t
YXAgd3JpdGUgZG9lcyBub3QgdXNlIGV4ZmF0X3dyaXRlX2VuZCgpLCB2YWxpZF9zaXplIG1heSBi
ZQ0KKwkgKiBleHRlbmRlZCB0byB0aGUgc2VjdG9yLWFsaWduZWQgbGVuZ3RoIGluIGV4ZmF0X2dl
dF9ibG9jaygpLg0KKwkgKiBTbyB3ZSBuZWVkIHRvIGZpeHVwIHZhbGlkX3NpemUgdG8gdGhlIHdy
aXRyZW4gbGVuZ3RoLg0KKwkgKi8NCisJaWYgKG9uX2Rpc2tfc2l6ZSA8IGVpLT52YWxpZF9zaXpl
KQ0KKwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBlcDItPmRlbnRyeS5zdHJlYW0u
c2l6ZTsNCisJZWxzZQ0KKwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9f
bGU2NChlaS0+dmFsaWRfc2l6ZSk7DQorDQogCWlmIChvbl9kaXNrX3NpemUpIHsNCiAJCWVwMi0+
ZGVudHJ5LnN0cmVhbS5mbGFncyA9IGVpLT5mbGFnczsNCiAJCWVwMi0+ZGVudHJ5LnN0cmVhbS5z
dGFydF9jbHUgPSBjcHVfdG9fbGUzMihlaS0+c3RhcnRfY2x1KTsNCkBAIC0zNDAsNiArMzQ5LDkg
QEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgc2VjdG9y
X3QgaWJsb2NrLA0KIAkJCQkJcG9zLCBlaS0+aV9zaXplX2FsaWduZWQpOw0KIAkJCWdvdG8gdW5s
b2NrX3JldDsNCiAJCX0NCisNCisJCWVpLT52YWxpZF9zaXplID0gRVhGQVRfQkxLX1RPX0IoaWJs
b2NrICsgbWF4X2Jsb2Nrcywgc2IpOw0KKwkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQogCX0g
ZWxzZSB7DQogCQl2YWxpZF9ibGtzID0gRVhGQVRfQl9UT19CTEsoZWktPnZhbGlkX3NpemUsIHNi
KTsNCiANCi0tIA0KMi4yNS4xDQoNCg==

