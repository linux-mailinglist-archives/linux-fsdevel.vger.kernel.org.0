Return-Path: <linux-fsdevel+bounces-4159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E577FD105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300F5B20D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A033125AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Gz9Aux/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632D5C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 23:25:24 -0800 (PST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4MjwW010824;
	Wed, 29 Nov 2023 07:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=peBVhGZfmI3nT1OuRvexM8f+ljtc3odlsrlc6CKBq2Y=;
 b=Gz9Aux/iP61G6gIP/ENLCDa4RBb0BLrSaNbhDXWw48DzXGCevSG7PZHFnlBph/YOVuoH
 NC4E/I0x2PLScwOht3995HeGXWP5l7f1xhA29q8TQGOSWREdn7ZmQS8OypIeopWLIvEi
 ZrdY4GApa7OPOsvNkpwsBY0cH5Xo4vqOENiNXSYffNP5gVVGbIRDuZUzwVBUFbQQc0QM
 GFBVDDdWCet1wxvyLvP2189fP/uYON9eu4AcXd7+/De5p+oM3twU/ld2hlZO0yVEiSHo
 V7Wz2wegPADGus2pSDLzU3idHCrcaKVq/mG5WHyIgJ8OyITbNeY3fB2Y27U2n2RIv82l wg== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2108.outbound.protection.outlook.com [104.47.26.108])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk74k42hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 07:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUI1KBfH58vmsAV29Uz3hCfYmSQVfa4HJicyX4RyHJXLXybueV8HbqBo0mm5RGLYK26URWP78TdZX5nY9RPiw7CDwhZ0HzpVdURnyrxIsRTCNNVmCk6MDoeUiNm7VLk56VmtEtAgjgatzKBdgqsnRy9ENk8gHZQsRkoUAtMYtUXUw8UJrNb/g5c5rAPeql9yP8zsb581OXOY9n3D/2xEv4eYg6f/dsKn5GiA51FIqyze18RoWPX4P5QNIfWNyi9/RHeojWSxEw0XRuYkeljrU7kVmVYBDychvM0Pv8+8kJJOSvMO/ZaHSNU6TScVlvLODyjuShgXlOJzx9Jxee4PVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peBVhGZfmI3nT1OuRvexM8f+ljtc3odlsrlc6CKBq2Y=;
 b=YAz5e/Bkb/Sb4npdTqfd4JqjSuQ4x/VMikMgXdhof5VnHSvIhDMTuwmOHORn+UhhWoq3TIf06NhuuNWQTFUuFloJw8LgHGaoSbZP14GwQZMa49W4TRJEW4Ilnc+GgL3DQ89kRnhL0mFElB2ahTL5fD89NbWrUtm8c137eErC/r33X/81GoaJgCGe5xTNgVASreAcr3nxfcQlY2pzbwFP4AGGdoUPPZPwXBjwFNpysRotK46KdAWwXpNHhim45PkRItvKxxDAJhpisHzU0tLcLucmqigDDGSVmK7t8SEL9xZNy6bV9xG4qtpNV91HXr6AVlgqvJL7+Is0wfKv9vsmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7877.apcprd04.prod.outlook.com (2603:1096:405:8c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 07:24:53 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 07:24:53 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: RE: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Topic: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Index: AdoNcqiciL5m7DeAQVy9qFZcQUwgXwUaYyaAACw8KJAAAGr18A==
Date: Wed, 29 Nov 2023 07:24:52 +0000
Message-ID: 
 <PUZPR04MB6316FDA1CB1C7862C179F2CF8183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b@epcas1p1.samsung.com>
	<PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1296674576.21701163681829.JavaMail.epsvc@epcpadp4>
 <PUZPR04MB6316FB0EDA2C6B92617CD4538183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB6316FB0EDA2C6B92617CD4538183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7877:EE_
x-ms-office365-filtering-correlation-id: dad8a99d-6b8e-4e0c-5bd8-08dbf0ac4752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 s6EdzbKzbjdaQlaN0XRqhfI63H96SuST6qZ0Mf+VQ31Z60Z6hJPcvEneo2esWEBb0rTKosp02uR/PbV7du4qtGMpjE/OOItHIvkFwQFbxlNtW9SwGcyP/b1JWC0U3JZWBoZ2m3Fb0jKHw2txKboN83OkPu7KXzafhkUUV4ECWO0yHkBOiOvG07X2Y4og543DpScH/K/DZyyhkHbzT+hCo/lhY0dwEnR5GKgV3laJp+xuVXfdjMvu5M81J+u0Tt7EDhg0qdDScgnSvMrdlF+YMV+6TQ9Do65FOjt0JwQoC1Sa2NduDu5KbOvsyAVTISKnzFnc3oY9RIRcpF7Tj4MkVRxwmY6OxeCufa38J72ZRMGoRnxF1/5Xe7mdD4TRZS477yfPk2wvtT8GGvZMedELqwRsOsUPZHevC86ZdViKQ/DLaBWuoME1iX3sTjLUJaZVZiLV2raijkPty17Zs0/a6Rc6GHJdTB34yQKk4fA8EQOJU/X/IZSkrNJKNFv+HOp44vRBO5pVHV8BSMKfFVW0giYEW7hPHMJSbYExaEC+v/HJQxYLB/kfPkCX9d/OtSbtNY2DCtvlLMhVb1SfqyhpXHRsP3xdcKZN9ULq2ilwHC5N9eWAzaVMmIjOv2TT9PiB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(122000001)(26005)(9686003)(53546011)(478600001)(7696005)(6506007)(2940100002)(71200400001)(38100700002)(38070700009)(82960400001)(86362001)(33656002)(5660300002)(2906002)(41300700001)(66946007)(83380400001)(316002)(76116006)(110136005)(64756008)(66476007)(8936002)(66446008)(8676002)(52536014)(66556008)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K25wN0lSY3VUVXRCaFl5YjloMlVYMTlMNFQ1a0lsWWtzcXFkTzhxWDI5OGFC?=
 =?utf-8?B?OVg5MDNwbUUvTzI3cjdUNWVUTlg3SnNORkc2U3VCK1lKM3poUjJvamlDWnJS?=
 =?utf-8?B?UHVWL0t4RmxhN2ZmbC90N1pMVmxpWGJSL1ZadzU1eHg3YUF6eUpQS3REQmVr?=
 =?utf-8?B?T0FJbkpYZElqQ0J5UjZSalY3VEdIZ2ZEalZDWnhaVkhaNUxZak1sSGZqTUJP?=
 =?utf-8?B?THdGcXlMRnNRVTljbEpSUGttR3hDYXNRdU5mMEwrWEhiU2NhK0s0dVJ4YnRU?=
 =?utf-8?B?NzdoRFlaZ2srVWRwOXFjTlZuLzlaek5iT3V1Y25xbFcvM2J1cmV6L3VEQkNw?=
 =?utf-8?B?c291NTZGcmdUQzNWbmdXWld6bVNkenp4YUZ2dWFOUXlVWm9SOTdJcVJsWTFs?=
 =?utf-8?B?VFM0RVlQVU1EM1dObkxnL3BmZ0QzTzRRVmVyU3FQWHljMUxCL2FneS9vU0Zw?=
 =?utf-8?B?ZG5PRzZjcHVlLzJ1Ukt6ZHZQc1oraXFDck9FMW1wNnBSRDY1THh5NkdhWExh?=
 =?utf-8?B?dU9weTVRWUx5TDB3ZUo2L0VSUzVWZDV3cmhoNUR6U0w2UmRjcGE4NUJpNlBE?=
 =?utf-8?B?bTNDZUE4Z3dYNDJ2eUNKaWhnMTJDQU9PcWVQSnJHd3F4M0llOFNqSTY4Y3Vv?=
 =?utf-8?B?KzFqdStvNXUrcUg4RW5mbCs2TWRpdUhJN1U1MEMvemNneDZXenlYd29QU2p5?=
 =?utf-8?B?Vllrc0pDME5lK0lncEJWdUl4eXk0ZWFrM2ltTFdVUHJzS0FhS2pOZXJkUSta?=
 =?utf-8?B?MFpHa3RvUU1Ka3drNWpPYVREZFVTOFFHeTl1OGVVMXpKTlVYdEwrRk9lKzdM?=
 =?utf-8?B?SzZaMUxxK3Q2T0R1VE53clZnTzRSbC9JblViWXlWQzY3dFFEZVZEZUxMYzhm?=
 =?utf-8?B?MWdua3Q5aDhNdDROaEVPZ0ZZcW5POGgxanZiQkY4SHlpUEtZS1FBSFpsMmhj?=
 =?utf-8?B?RFFpeHVqYVVTYXUrT0c5QlA4S2dCS0ttRzdETTI3SmdJdmJCODVSaVRTVTlX?=
 =?utf-8?B?WXY3NWNkWEhlUm9YQVZCOWlOeHRaNm1YcXdQdnFTdis2ZFk5NkJpMXVHUUFU?=
 =?utf-8?B?K2o5ZzJ2L1p2ZllrczIwUGkwenJHYTlrTDg4cnMzVytoSEREQSs3RjgxY3RT?=
 =?utf-8?B?eHZjT2RybU1wc1IwTUhCOFBKdnl3dTExemp0MkxoQlI4S3k1VGQ0anRySVRh?=
 =?utf-8?B?bGc0a3VNbEZtOGEzNlhwV1RCeCtHYlF4SWQySnZDbVZOMVluSUkyZDhSVzBI?=
 =?utf-8?B?SU5PUGJUVXdGdExqWjYreTBqRDltOGRJMFB2M3hsZFAvalFnSEpoaG9UaEts?=
 =?utf-8?B?VFljbko4ZWtGQVJLTGd5SHNUSnVtQTl5UGxSLzIxRU5NaXZUNExPNnhmVFdo?=
 =?utf-8?B?bHdWdzJEaWdROHFvTkdWN3VXcjh4WG81S0VYazVYV1lQODNpTlpQVzNtcmQx?=
 =?utf-8?B?amxGOG5FMXROSGJQNHZPcWFQTjk2U05CUnpPZHR5cC9SbEhFVzc1dEF4WHpy?=
 =?utf-8?B?SC9zcWVDWHhhN2NOakNyTFN2THlXdldtajlvb0VHNWFvWUhTWlJMenRrYWkv?=
 =?utf-8?B?Z2RCMHV6dWxBTDJHUkMwZW5pbzlWVVlQNkV2MmFaTThrZFpmejVJL0FaMlRG?=
 =?utf-8?B?eWtnN2xvK1hPSURacGFPWUV1VEd0SnNFejZOL2VRRW5zTlhhdkFGdzc4UldT?=
 =?utf-8?B?a05lelRZWk5MdFI0dGUxZ3JkV3haT0JOdDRHZm9xYWV3QXovNUpDWXA3dThu?=
 =?utf-8?B?cU00WXkwNGVJV1Z2cVMwalpXc1V5akkzSDBqcmlYTHBPZ0pjMmtSYUdlUEdl?=
 =?utf-8?B?b2dMU1pNVVBBTlc0Ryt0dXovcEIyRWd4VmdHUWE3L1lJZlRnVDZoQkh1UG9K?=
 =?utf-8?B?aC9VanFaN1hycEJwV0FGTnNMSWJQNHBEVHhkaHVlL09xVDM1L1k0Y1NnSTZL?=
 =?utf-8?B?bGNPeVFseE5YOVB0NDcvVjNZRzlRSUpoYnRTNzZENXh2YVgxZUJVdldubVg4?=
 =?utf-8?B?MXZkdnluVGRoeHNnbTdzZzZiZG9DUEk3dmpUTG9Kc2t4YUxOMmpQYmVMdjI3?=
 =?utf-8?B?ZkxxbGJZZmJyNkVDOSs5ODdsZ2N2cWtWSFJRQ3dXKzlFWG5EL01FaXUxQW10?=
 =?utf-8?Q?IjGxp9ZE2EF3578gKsvi5nVAO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RWEumFwW6cKbZBQI5TeUaeGkW/J2zeULRIDzU/3MyElCPnSIwGUK2YVcr39TYro7BUlO8361I5P1dCZGU4qrd5OlzbjzjdYkSdRWWagk2I3T83fvqQubFZdO8b0t0fVfEqVF/jOAx9kVadTXcZzD1OA1diC3/NPUL7p3ta8LXQSPt3a2wuPndk/zXpPqZEpzHuLLAHslPReYRm8OAoY6Kp5YclT3PMRsezdsRGErud7Yb60oAtt18zCjRv9yESVhN5/8FnHIP3mAb5uYCrCHXyPyYCIVrZaJ8tSctWDht/OYdLz1Rhs9z56DWgVn0gpJ5yfTwU9tch0+aGekaG4dSK6xD/Ky+5h9yZ5q6WuItYAH1+bdPjMSpdRBgP/iCjUjHPa5ficayFb8IVMxWWLkFSC7bnnZIrOlQEAOM+9HGTUR7gx9L0uWUUcpVmhmtFK1ZhagAaWATE6j2VujFKfI4r+kn4HnBlx77QBiV/eMNGXKJkWyzNo2oqazIWdYAwuBDn6TYvypq/7F0PLghzu72qZOteC8zG5ldslpnVqZr42YuWLxCVkzP5udfte4eYhkGTOV4K2/pdxGylk5Xywy5swSsYDcCwDKy4qNW1nIPUnLS6M4EgnwqOm7UOSOMvKAT2yrmX/CXLjG8tUTot3a8231vALPT82CUNidYfIqZJp9BkDhPJewQxKPf5/vn3iI5rXNsHJ/aXSSMy33w1J4lcSfOLPKQFK9rSq8st7iJPQ9RecxA29PMpOJZW3bP8MYA+xsOcSTF8q9XOMd7vZ3dljDm4Fp26rj/9akd8qcpom46llqkwRlS7mgb0bfyzzJGN9z9cM89GEdzrSiQbISig==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8a99d-6b8e-4e0c-5bd8-08dbf0ac4752
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 07:24:52.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llDmJ1PnIu+Pa1MwOT7APDc3gq6mG2mJWobF4CuZ/9z1s45ilu8u0sJg6rZf3pOxKVSfO2CeIWsBJcPkhP2oDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7877
X-Proofpoint-GUID: flUIswST8EXz2OOk-BKsSVW3uqR6lhkr
X-Proofpoint-ORIG-GUID: flUIswST8EXz2OOk-BKsSVW3uqR6lhkr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: flUIswST8EXz2OOk-BKsSVW3uqR6lhkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_04,2023-11-27_01,2023-05-22_02

PiBGcm9tOiBTdW5nam9uZyBTZW8gPHNqMTU1Ny5zZW9Ac2Ftc3VuZy5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE5vdmVtYmVyIDI4LCAyMDIzIDU6MjEgUE0NCj4gVG86IE1vLCBZdWV6aGFuZyA8WXVl
emhhbmcuTW9Ac29ueS5jb20+OyBsaW5raW5qZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWZz
ZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBXdSwgQW5keSA8QW5keS5XdUBzb255LmNvbT47IEFveWFt
YSwNCj4gV2F0YXJ1IChTR0MpIDxXYXRhcnUuQW95YW1hQHNvbnkuY29tPjsgY3Bnc0BzYW1zdW5n
LmNvbTsNCj4gc2oxNTU3LnNlb0BzYW1zdW5nLmNvbQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY0
IDEvMl0gZXhmYXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KPiAN
Cj4gPiBJbiBzdHJlYW0gZXh0ZW5zaW9uIGRpcmVjdG9yeSBlbnRyeSwgdGhlIFZhbGlkRGF0YUxl
bmd0aCBmaWVsZCBkZXNjcmliZXMNCj4gaG93IGZhciBpbnRvIHRoZSBkYXRhIHN0cmVhbSB1c2Vy
IGRhdGEgaGFzIGJlZW4gd3JpdHRlbiwgYW5kIHRoZSA+IERhdGFMZW5ndGgNCj4gZmllbGQgZGVz
Y3JpYmVzIHRoZSBmaWxlIHNpemUuDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8
WXVlemhhbmcu4oCKTW9A4oCKc29ueS7igIpjb20+DQo+ID4gSW4gc3RyZWFtIGV4dGVuc2lvbiBk
aXJlY3RvcnkgZW50cnksIHRoZSBWYWxpZERhdGFMZW5ndGggZmllbGQNCj4gPiBkZXNjcmliZXMg
aG93IGZhciBpbnRvIHRoZSBkYXRhIHN0cmVhbSB1c2VyIGRhdGEgaGFzIGJlZW4gd3JpdHRlbiwg
YW5kDQo+ID4gdGhlIERhdGFMZW5ndGggZmllbGQgZGVzY3JpYmVzIHRoZSBmaWxlIHNpemUuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8bWFpbHRvOll1ZXpoYW5nLk1vQHNv
bnkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmR5IFd1IDxtYWlsdG86QW5keS5XdUBzb255LmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8bWFpbHRvOndhdGFydS5hb3lhbWFA
c29ueS5jb20+DQo+ID4gLS0tDQo+ID4gIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgIDIgKw0KPiA+
ICBmcy9leGZhdC9maWxlLmMgICAgIHwgMTIyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgOTYgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICBmcy9leGZhdC9uYW1laS5jICAgIHwg
ICA2ICsrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDIwNyBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkNCj4gW3NuaXBdDQo+ID4gK3N0YXRpYyBzc2l6ZV90IGV4ZmF0X2ZpbGVfd3JpdGVf
aXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdA0KPiA+ICtpb3ZfaXRlciAqaXRlcikgew0K
PiA+ICsJc3NpemVfdCByZXQ7DQo+ID4gKwlzdHJ1Y3QgZmlsZSAqZmlsZSA9IGlvY2ItPmtpX2Zp
bHA7DQo+ID4gKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsNCj4gPiAr
CXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0KPiA+ICsJbG9m
Zl90IHBvcyA9IGlvY2ItPmtpX3BvczsNCj4gPiArCWxvZmZfdCB2YWxpZF9zaXplOw0KPiA+ICsN
Cj4gPiArCWlub2RlX2xvY2soaW5vZGUpOw0KPiA+ICsNCj4gPiArCXZhbGlkX3NpemUgPSBlaS0+
dmFsaWRfc2l6ZTsNCj4gPiArDQo+ID4gKwlyZXQgPSBnZW5lcmljX3dyaXRlX2NoZWNrcyhpb2Ni
LCBpdGVyKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsN
Cj4gPiArCWlmIChwb3MgPiB2YWxpZF9zaXplKSB7DQo+ID4gKwkJcmV0ID0gZXhmYXRfZmlsZV96
ZXJvZWRfcmFuZ2UoZmlsZSwgdmFsaWRfc2l6ZSwgcG9zKTsNCj4gPiArCQlpZiAocmV0IDwgMCAm
JiByZXQgIT0gLUVOT1NQQykgew0KPiA+ICsJCQlleGZhdF9lcnIoaW5vZGUtPmlfc2IsDQo+ID4g
KwkJCQkid3JpdGU6IGZhaWwgdG8gemVybyBmcm9tICVsbHUgdG8gJWxsdSglbGQpIiwNCj4gPiAr
CQkJCXZhbGlkX3NpemUsIHBvcywgcmV0KTsNCj4gPiArCQl9DQo+ID4gKwkJaWYgKHJldCA8IDAp
DQo+ID4gKwkJCWdvdG8gdW5sb2NrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IF9fZ2Vu
ZXJpY19maWxlX3dyaXRlX2l0ZXIoaW9jYiwgaXRlcik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4g
PiArCQlnb3RvIHVubG9jazsNCj4gPiArDQo+ID4gKwlpbm9kZV91bmxvY2soaW5vZGUpOw0KPiA+
ICsNCj4gPiArCWlmIChwb3MgPiB2YWxpZF9zaXplICYmIGlvY2JfaXNfZHN5bmMoaW9jYikpIHsN
Cj4gPiArCQlzc2l6ZV90IGVyciA9IHZmc19mc3luY19yYW5nZShmaWxlLCB2YWxpZF9zaXplLCBw
b3MgLSAxLA0KPiA+ICsJCQkJaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX1NZTkMpOw0KPiBJZiB0aGVy
ZSBpcyBhIGhvbGUgYmV0d2VlbiB2YWxpZF9zaXplIGFuZCBwb3MsIGl0IHNlZW1zIHRvIGNhbGwg
c3luYyB0d2ljZS4NCj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byBjYWxsIHNlcGFyYXRlbHk/DQo+
IFdoeSBkb24ndCB5b3UgY2FsbCB0aGUgdmZzX2ZzeW5jX3JhbmdlIG9ubHkgb25jZSBmb3IgdGhl
IG1lcmdlZCBzY29wZQ0KPiBbdmFsaWRfc2l6ZTplbmRdPw0KDQpGb3IgYmV0dGVyIGRlYnVnZ2lu
ZywgSSBrZXB0IHRoZSBvcmlnaW5hbCBsb2dpYyBhbmQgYWRkZWQgbmV3IGxvZ2ljIGZvciB2YWxp
ZF9zaXplLg0KRm9yIG5vdywgaXQgaXMgdW5uZWNlc3NhcnksIEkgd2lsbCBjaGFuZ2UgdG8gc3lu
YyBvbmNlLg0KDQo+IA0KPiA+ICsJCWlmIChlcnIgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gZXJyOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0ID0gZ2VuZXJpY193cml0
ZV9zeW5jKGlvY2IsIHJldCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
K3VubG9jazoNCj4gPiArCWlub2RlX3VubG9jayhpbm9kZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gW3NuaXBdDQo+ID4gQEAgLTc1LDggKzc1LDcgQEAgaW50
IF9fZXhmYXRfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgaW50IHN5bmMpDQo+ID4g
IAlpZiAoZWktPnN0YXJ0X2NsdSA9PSBFWEZBVF9FT0ZfQ0xVU1RFUikNCj4gPiAgCQlvbl9kaXNr
X3NpemUgPSAwOw0KPiA+DQo+ID4gLQllcDItPmRlbnRyeS5zdHJlYW0udmFsaWRfc2l6ZSA9IGNw
dV90b19sZTY0KG9uX2Rpc2tfc2l6ZSk7DQo+ID4gLQllcDItPmRlbnRyeS5zdHJlYW0uc2l6ZSA9
IGVwMi0+ZGVudHJ5LnN0cmVhbS52YWxpZF9zaXplOw0KPiA+ICsJZXAyLT5kZW50cnkuc3RyZWFt
LnNpemUgPSBjcHVfdG9fbGU2NChvbl9kaXNrX3NpemUpOw0KPiA+ICAJaWYgKG9uX2Rpc2tfc2l6
ZSkgew0KPiA+ICAJCWVwMi0+ZGVudHJ5LnN0cmVhbS5mbGFncyA9IGVpLT5mbGFnczsNCj4gPiAg
CQllcDItPmRlbnRyeS5zdHJlYW0uc3RhcnRfY2x1ID0gY3B1X3RvX2xlMzIoZWktPnN0YXJ0X2Ns
dSk7IEBAIC04NSw2DQo+ID4gKzg0LDggQEAgaW50IF9fZXhmYXRfd3JpdGVfaW5vZGUoc3RydWN0
IGlub2RlICppbm9kZSwgaW50IHN5bmMpDQo+ID4gIAkJZXAyLT5kZW50cnkuc3RyZWFtLnN0YXJ0
X2NsdSA9IEVYRkFUX0ZSRUVfQ0xVU1RFUjsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJZXAyLT5kZW50
cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9fbGU2NChlaS0+dmFsaWRfc2l6ZSk7DQo+IElz
IHRoZXJlIGFueSByZWFzb24gdG8gbm90IG9ubHkgY2hhbmdlIHRoZSB2YWx1ZSBidXQgYWxzbyBt
b3ZlIHRoZSBsaW5lIGRvd24/DQoNCkkgd2lsbCBtb3ZlIGl0IGJhY2sgdGhlIG9yaWdpbmFsIGxp
bmUuDQoNCj4gDQo+ID4gKw0KPiA+ICAJZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW1fd2l0aF9lbnRy
eV9zZXQoJmVzKTsNCj4gPiAgCXJldHVybiBleGZhdF9wdXRfZGVudHJ5X3NldCgmZXMsIHN5bmMp
OyAgfSBAQCAtMzA2LDE3ICszMDcsMjUgQEANCj4gPiBzdGF0aWMgaW50IGV4ZmF0X2dldF9ibG9j
ayhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzZWN0b3JfdCBpYmxvY2ssDQo+ID4gIAltYXBwZWRfYmxv
Y2tzID0gc2JpLT5zZWN0X3Blcl9jbHVzIC0gc2VjX29mZnNldDsNCj4gPiAgCW1heF9ibG9ja3Mg
PSBtaW4obWFwcGVkX2Jsb2NrcywgbWF4X2Jsb2Nrcyk7DQo+ID4NCj4gPiAtCS8qIFRyZWF0IG5l
d2x5IGFkZGVkIGJsb2NrIC8gY2x1c3RlciAqLw0KPiA+IC0JaWYgKGlibG9jayA8IGxhc3RfYmxv
Y2spDQo+ID4gLQkJY3JlYXRlID0gMDsNCj4gPiAtDQo+ID4gLQlpZiAoY3JlYXRlIHx8IGJ1ZmZl
cl9kZWxheShiaF9yZXN1bHQpKSB7DQo+ID4gLQkJcG9zID0gRVhGQVRfQkxLX1RPX0IoKGlibG9j
ayArIDEpLCBzYik7DQo+ID4gKwlwb3MgPSBFWEZBVF9CTEtfVE9fQigoaWJsb2NrICsgMSksIHNi
KTsNCj4gPiArCWlmICgoY3JlYXRlICYmIGlibG9jayA+PSBsYXN0X2Jsb2NrKSB8fCBidWZmZXJf
ZGVsYXkoYmhfcmVzdWx0KSkgew0KPiA+ICAJCWlmIChlaS0+aV9zaXplX29uZGlzayA8IHBvcykN
Cj4gPiAgCQkJZWktPmlfc2l6ZV9vbmRpc2sgPSBwb3M7DQo+ID4gIAl9DQo+ID4NCj4gPiArCW1h
cF9iaChiaF9yZXN1bHQsIHNiLCBwaHlzKTsNCj4gPiArCWlmIChidWZmZXJfZGVsYXkoYmhfcmVz
dWx0KSkNCj4gPiArCQljbGVhcl9idWZmZXJfZGVsYXkoYmhfcmVzdWx0KTsNCj4gPiArDQo+ID4g
IAlpZiAoY3JlYXRlKSB7DQo+ID4gKwkJc2VjdG9yX3QgdmFsaWRfYmxrczsNCj4gPiArDQo+ID4g
KwkJdmFsaWRfYmxrcyA9IEVYRkFUX0JfVE9fQkxLX1JPVU5EX1VQKGVpLT52YWxpZF9zaXplLCBz
Yik7DQo+ID4gKwkJaWYgKGlibG9jayA8IHZhbGlkX2Jsa3MgJiYgaWJsb2NrICsgbWF4X2Jsb2Nr
cyA+PSB2YWxpZF9ibGtzKQ0KPiA+IHsNCj4gPiArCQkJbWF4X2Jsb2NrcyA9IHZhbGlkX2Jsa3Mg
LSBpYmxvY2s7DQo+ID4gKwkJCWdvdG8gZG9uZTsNCj4gPiArCQl9DQo+ID4gKw0KPiBZb3UgcmVt
b3ZlZCB0aGUgY29kZSBmb3IgaGFuZGxpbmcgdGhlIGNhc2UgZm9yIChpYmxvY2sgPCBsYXN0X2Js
b2NrKS4NCj4gU28sIHVuZGVyIGFsbCB3cml0ZSBjYWxsLWZsb3dzLCBpdCBjb3VsZCBiZSBidWZm
ZXJfbmV3IGFibm9ybWFsbHkuDQo+IEl0IHNlZW1zIHdyb25nLiByaWdodD8NCg0KWWVzLCBJIHdp
bGwgdXBkYXRlIHRoaXMgcGF0Y2guDQoNCldpdGhvdXQgdGhpcyBwYXRjaCwgbGFzdF9ibG9jayBp
cyBlcXVhbCB3aXRoIHZhbGlkX2Jsa3MsIGV4ZmF0X21hcF9uZXdfYnVmZmVyKCkgc2hvdWxkIGJl
IGNhbGxlZCBpZg0KaWJsb2NrICsgbWF4X2Jsb2NrcyA+IGxhc3RfYmxvY2suDQoNCldpdGggdGhp
cyBwYXRjaCwgbGFzdF9ibG9jayA+PSB2YWxpZF9ibGtzLCBleGZhdF9tYXBfbmV3X2J1ZmZlcigp
IHNob3VsZCBiZSBjYWxsZWQgaWYNCmlibG9jayArIG1heF9ibG9ja3MgPiB2YWxpZF9ibGtzLg0K
DQo+IA0KPiA+ICAJCWVyciA9IGV4ZmF0X21hcF9uZXdfYnVmZmVyKGVpLCBiaF9yZXN1bHQsIHBv
cyk7DQo+ID4gIAkJaWYgKGVycikgew0KPiA+ICAJCQlleGZhdF9mc19lcnJvcihzYiwNCj4gW3Nu
aXBdDQo+ID4gQEAgLTQzNiw4ICs0ODUsMjAgQEAgc3RhdGljIHNzaXplX3QgZXhmYXRfZGlyZWN0
X0lPKHN0cnVjdCBraW9jYg0KPiA+ICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+ID4g
IAkgKiBjb25kaXRpb24gb2YgZXhmYXRfZ2V0X2Jsb2NrKCkgYW5kIC0+dHJ1bmNhdGUoKS4NCj4g
PiAgCSAqLw0KPiA+ICAJcmV0ID0gYmxvY2tkZXZfZGlyZWN0X0lPKGlvY2IsIGlub2RlLCBpdGVy
LCBleGZhdF9nZXRfYmxvY2spOw0KPiA+IC0JaWYgKHJldCA8IDAgJiYgKHJ3ICYgV1JJVEUpKQ0K
PiA+IC0JCWV4ZmF0X3dyaXRlX2ZhaWxlZChtYXBwaW5nLCBzaXplKTsNCj4gPiArCWlmIChyZXQg
PCAwKSB7DQo+ID4gKwkJaWYgKHJ3ICYgV1JJVEUpDQo+ID4gKwkJCWV4ZmF0X3dyaXRlX2ZhaWxl
ZChtYXBwaW5nLCBzaXplKTsNCj4gPiArDQo+ID4gKwkJaWYgKHJldCAhPSAtRUlPQ0JRVUVVRUQp
DQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwl9IGVsc2UNCj4gPiArCQlzaXplID0gcG9zICsg
cmV0Ow0KPiA+ICsNCj4gPiArCWlmICgocncgJiBSRUFEKSAmJiBwb3MgPCBlaS0+dmFsaWRfc2l6
ZSAmJiBlaS0+dmFsaWRfc2l6ZSA8IHNpemUpIHsNCj4gPiArCQlpb3ZfaXRlcl9yZXZlcnQoaXRl
ciwgc2l6ZSAtIGVpLT52YWxpZF9zaXplKTsNCj4gPiArCQlpb3ZfaXRlcl96ZXJvKHNpemUgLSBl
aS0+dmFsaWRfc2l6ZSwgaXRlcik7DQo+ID4gKwl9DQo+IA0KPiBUaGlzIGFwcHJvYWNoIGNhdXNl
cyB1bm5lY2Vzc2FyeSByZWFkcyB0byB0aGUgcmFuZ2UgYWZ0ZXIgdmFsaWRfc2l6ZSwgcmlnaHQ/
DQoNCkkgZG9uJ3QgdGhpbmsgc28uDQoNCklmIHRoZSBibG9ja3MgYWNyb3NzIHZhbGlkX3NpemUs
IHRoZSBpb3ZfaXRlciB3aWxsIGJlIGhhbmRsZSBhcw0KMS4gUmVhZCB0aGUgYmxvY2tzIGJlZm9y
ZSB2YWxpZF9zaXplLg0KMi4gUmVhZCB0aGUgYmxvY2sgd2hlcmUgdmFsaWRfc2l6ZSBpcyBsb2Nh
dGVkIGFuZCBzZXQgdGhlIGFyZWEgYWZ0ZXIgdmFsaWRfc2l6ZSB0byB6ZXJvLiANCjMuIHplcm8g
dGhlIGJ1ZmZlciBvZiB0aGUgYmxvY2tzIGFmdGVyIHZhbGlkX3NpemUobm90IHJlYWQgZnJvbSBk
aXNrKQ0KDQpTbyB0aGVyZSBhcmUgdW5uZWNlc3NhcnkgemVyb2luZyBoZXJlKGluIDEgYW5kIDIp
LCBubyB1bm5lY2Vzc2FyeSByZWFkcy4NCkkgd2lsbCByZW1vdmUgdGhlIHVubmVjZXNzYXJ5IHpl
cm9pbmcuDQoNCj4gQnV0IGl0IGxvb2tzIHZlcnkgc2ltcGxlIGFuZCBjbGVhci4NCj4gDQo+IEh1
bS4uLg0KPiBEbyB5b3UgaGF2ZSBhbnkgcGxhbiB0byBoYW5kbGUgdGhlIGJlZm9yZSBhbmQgYWZ0
ZXIgb2YgdmFsaWRfc2l6ZSBzZXBhcmF0ZWx5Pw0KPiANCg0KDQo=

