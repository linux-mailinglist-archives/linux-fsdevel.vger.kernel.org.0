Return-Path: <linux-fsdevel+bounces-5657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE080E925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB7A2819AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7695C092;
	Tue, 12 Dec 2023 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="FaVznxfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8FAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 02:30:25 -0800 (PST)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBFJjIY010538;
	Tue, 12 Dec 2023 10:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=YoWPLdZ//8rMlc/Yy9I633zTp1mMilRLaWuxzHDL9hA=;
 b=FaVznxfVmk4GZlILGsrwacW5ULwfuOvtrGT41TYluJq/nSt/H3gz2zKq+qXmQldaXKS2
 g14z3EFfuHtS40bMQ4WbVDhf00atHrM8d1b3NfBPyeNTN1i8WuXvI3qNx4+ut7PhuK2z
 S7aKfKheA+Le8jzu+pu0PfYir19vdad0cA5b07nBZHNEyCt3A5HYOQ5FifskED9OxmOX
 5FaUEJTu+KqfcRUrtfGRdJGhRmp8fTLYhJaFlTELCASQFmyiNpvVlbPjcr4npjEOmFRY
 PVi7vFfeEPP8JuZmIlGQPlwIsSY5BxEHsOjVecKXOqxJ0m+58grM7W6r1mKah/wc9aFl NA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uvfk1awc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3ZRIGv985l7xJYCy2A12CeSaR/bAkqPhBbshNtGfQW40kQblBSFvBMlvPLwuOdK4hiwzDfICV1t7WWEdZhH0Tu9MoTTKEmUWp78Hj5TrMspcXg1e6wfWlKC0E0nfdgtWrfxL/Gy24eA8qPamMcBhrDTy9IrXi3IivU19dZRIu5WFvQyXj1P9FiR0WNvAUbpMi8AksYZ8GcuWeiAizB1JzboN3Kr0+UBgGLzMsf3vPSOsBn0cBJ5q6q9OzflyPBtPSTPek3MNEMSphxL5nj/sYYUxGOjVNvaNXB1NXA3xO1nqoiHzCr5HjT2iwWYD+vWngkhb5Cg8piQjUmc1LPoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoWPLdZ//8rMlc/Yy9I633zTp1mMilRLaWuxzHDL9hA=;
 b=aKZTqNDK5mXmOh9cbYPTqYoUhu7fW3V5620lyc7pX/g/H6Ajqi012Wyzp0LIaV4t7tmOhKONvOc24190K2pXaMpKStZDAxqOTjp9a1qPeAXsH9Oxx2/FWvDGHM0Mgc6HHtnq3mux75oOKwRqQta7dMlAzmI0L5V40xxL1sHGDvUuwqGb14F/NK0ORVjK6Oy5HIHcQVQPptUzNXVtRyPJuj4S2ov2mke6fMi7hUhRRvqIpM8kDAv+fQoVpYiuzY6dEeCrIwcu2FPnCkGACsOco/MT8K6ZOgOebV/euMlhiJiTj0lAGITlsnNoCEcYYR1Dz8mfTmYwTt2xhDT2ZXPmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7074.apcprd04.prod.outlook.com (2603:1096:400:454::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 10:29:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 10:29:54 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH v6 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v6 0/2] exfat: get file size from DataLength
Thread-Index: AQHaJ2QRA07S+aCZCkuGISZG+wv1g7ClE+8AgABUxOCAAADC8A==
Date: Tue, 12 Dec 2023 10:29:54 +0000
Message-ID: 
 <PUZPR04MB6316D78A5169E0FC1F046698818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63167EF34D0B46A4D418A86C8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd8HieJNdF7poscX0gR0_EBCVW+aACW6bBBCVXKiaORq5w@mail.gmail.com>
 <PUZPR04MB63160A6FD8E7EF04E4342B1B818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB63160A6FD8E7EF04E4342B1B818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7074:EE_
x-ms-office365-filtering-correlation-id: ad14e49f-8cfe-42a8-f009-08dbfafd47d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qEoeMmwfKw+M3+zbpG1cBP9B+zUFHhLtyf8toJS1/ISVUmR+IoZJXx/F3VUQwXnx6BCMNhUNaRU28QWCFi4bLA4JcN5dOsNGPOUQi8tOu4f54C+U5HBOELxUCQDYC0HQmzskomJyeDlzm01q/e9b99Vgo5Mitc0cAZYTuAinR9N6o32lXIh556tOomo94vyhMpMSJK7p4NfBpAFmeBOrBZ7yQNuhZ9onGvIPl2avbWuTfaDM6r14hZqC8prSh3ln+kc4TEz2PfrebQ1uEKQDOHaKeuQbdpKNn2LGnG2lFkSvpRNhZPkq4z2R1yAIe4Q1C6twmF6glE/iSXensVmEsonZF/c8zIyXVZG1AmG6LCnbtE4E62VaGoWYI8lYZLjuXhzvSrlVnLAt0tjSTdC8KobYMwcIH5g+2+vK42W98ZFdq1b68viVHKWgn1wsvSBjW25k/FgpPNaq3cD4P5IRVI41W/wtUvYSQUMF6xPpsX5vkHSiGY3w6gGEwj/aI3zOF6MwMIVRHqxshgEBrrUKF1b/aL2XSR8zBz5EuoaDXAx+WQZY0Ncex768Zg1hws2pykjJ0fLv7bnLQnJ1+GEaafaJLGWRAG6u2kjHDtDEVSrFMMiLz5CxdjKWzcuiUTh7
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(26005)(38070700009)(82960400001)(38100700002)(33656002)(122000001)(86362001)(76116006)(83380400001)(52536014)(5660300002)(2940100002)(7696005)(71200400001)(6506007)(66556008)(316002)(8676002)(8936002)(66946007)(6916009)(66476007)(66446008)(64756008)(54906003)(9686003)(478600001)(4744005)(41300700001)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MTRkWTN5U3pwb1l2bkV4N3ZYM0xUMEdsWlJWRVYveTlWclVneTVKd2RVRDdj?=
 =?utf-8?B?M3piVElscDVvbnJXQnAxWElQVHdLbHhMM0oxd0c2MHhSKzlMd0pDQWlhalNk?=
 =?utf-8?B?OGlzWTBKOWM2MzFEUGxweFVobGJLdnJaM2E2U1NOa052UGNZL3hySk9oK3Jx?=
 =?utf-8?B?WmhhOFZ2RzRlTHJZemY4ZWFWZVVZU0VOdytzL3ZqK240bUdsK0NUWUx0clJp?=
 =?utf-8?B?L0UwdXpHSWlJOW8zbGhtcHFVK3M2a0lWWjBtSEVDaXFYdENTYUNXTEdlRWk0?=
 =?utf-8?B?Z01aY1RUODZGMHFlclo2N2w0eVY4SkpLVUp4ZkNSRkZSQVRldnl4M2lsckpP?=
 =?utf-8?B?Y3lKQ1MyOWNtT2k4NlJMdC9ZWSs0Sk1XMVk3N1lXRFZ1UkxrSlpiTEU5UlpG?=
 =?utf-8?B?U0dsM0xZMWhkVE9lcWNRT3k5bC9DYTdFVTljNENQVWpiUjJIUkNFdmFUb1ZD?=
 =?utf-8?B?b1lZMFVZOEpvajVFWDhQcHVyakVpNEdaYXBRSENUdkFjeVhzWG5pbHhWSlpK?=
 =?utf-8?B?V3NucCtMVzVjeThHc2ZZdVdNdW52TnZvMkhZdE1zTUVRdXV2TjYwN1JJV2dp?=
 =?utf-8?B?QWd1eUhhdWtwbGx4a2orU3JXNmMxa1dYWWUyT2R5akNDK1BLekpPakdEbWJn?=
 =?utf-8?B?S2JaajVRTHh6RDk1dFlDVytEVjhwSW4vWlJVWFV4LzVxSGtMaElhcVlzWDkr?=
 =?utf-8?B?RWxRZlY4T01QTG1LNVprVlhIcmhMUGNSMG5pTnAwUmRsWERJNHMyYUNCYlhi?=
 =?utf-8?B?MlJpSXM2R09WYTRyamtCL3RianhyU1ZpRE12bVQ4aTNpME5NL1RrQUNpODJC?=
 =?utf-8?B?WlFaV05ES1R0elVENXZ2MlNyV0NqYWlnM0FGeml6OGRjaUNEdmt2TmRMZ3BP?=
 =?utf-8?B?VjcrbTlDZ3dJVXR3bHVOYXVnTUpwdmJaUHkxV1RKK0hEYWR0bEVnY0JFU1kv?=
 =?utf-8?B?NDV3Y2VFV1JjZnJmalFvcVVHZk40NVdBUkRPc29SS1BXMWZ0QnVpQ1NqNnlS?=
 =?utf-8?B?c29pZUh6VzQ5L3NRTTRHNzFqQXhodENmZk5FNklXeTJHK1hTaWREdm52dWha?=
 =?utf-8?B?SENPWHdZcXgwK0JpOWFqamNPdWVTZjc5cmZqek93dEZXVS96aUJxZlc2ZlFQ?=
 =?utf-8?B?M2YycDBNbnNZU3lFMGoyVUFCNWVMUzFQbndMNjJXNzE0MFVub3lhSUxUZU5L?=
 =?utf-8?B?UlRRakluRzN5N1FtTU5KU0dOc0w0R3Nxa0lPa0RZREtjVWdSZU0wa1AxenBz?=
 =?utf-8?B?a1gvMFFUcnk1bkdoUDQrNUg3MXQySGZIWVg1Umk1Z3FzUGlPbkhpT1N1YXVK?=
 =?utf-8?B?Q0lvdTNmRkc3amt1Z0FvWDE4S1Rtc2NEYVdUNmlkUHo4QlgvdjJpZGp0Skxm?=
 =?utf-8?B?bHF3MjArKzBORFpPV3h0N3VLNGZoa29yNzkyRGhBWXF1NUdBRE5oRDVmcDAr?=
 =?utf-8?B?UjV3VitUa2ljS3p5Z3h5U1JHYWpLeXI1bUlIM1RQWkhkbGhlaUh6cWJ4Sisz?=
 =?utf-8?B?ZWRybUdpbU8zYmFrMnlHc2Y2MDRjWjBRNVkwTFl1ZW9RRXRlSkxYNGJ4ZSth?=
 =?utf-8?B?VVBCK216YnlLdXhXU2FZdmRkZHpNVUEwUS85TFpOd29nTm5ybXNhek5sM1RC?=
 =?utf-8?B?WGZJeEMvdEpRZGdIOE9lWm1rUE1LV0Y4NmlRTWRpeG1MWGtuNVNNQ0RzcmxT?=
 =?utf-8?B?ZU9LWVR6czF0b2JHbkEvVHNkVDdJZzFnczNUMmVraVpGK3ZQbFplVnM3TmZS?=
 =?utf-8?B?YWZWVmZudjJuQW1HWkQyWm9Lc0Jyam8rZ096b3hFVDFYcjF1YWFjc09yTVov?=
 =?utf-8?B?a01nUXU2OWQ5TTdFZGFRRDBHbWltd1VpY0NxRC82RTVjTHB3Y2ZIdW42cmda?=
 =?utf-8?B?R1dIRUVSQTB3UWNIQTBtblFhTUxVMUhJOFBBUmFDaHZHc0tmbCszQzhGdEdC?=
 =?utf-8?B?cy9VQkdONkpkSmFtUVpoYXN0dGlyRUEzTXhXK0V6aDZ5QVl5VWVBQzF5emwr?=
 =?utf-8?B?dmMyVmd2S1VweU1JMDdaUnUydGZkbmN4RHhxa3hTRTRPTzAwaFRhNGVHbXor?=
 =?utf-8?B?UEJVQmRyVTl3dGVoWkhPeXJ6SDVFS295Sng1b1J6Q3hmcUlJRHBCVkwxVDZ0?=
 =?utf-8?Q?KdIwY2KhKsCYCwLm2Xl3yTSTH?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	doVQ9/SDegzHPVIGvTlGY2NqGm7N3RghGWVKFA3cySQT8Ue+Jf+m3iILSpYGpa/2wYx9KVr71OIwf0jzXFAsNlYGw0q881922Zl06i4Ih8ay4KYjVfWctxCCniaKY6k7AxhgP1TM+PkXQpwBooPNHK6OYwiNC3Z2qD/wVYD5eyWdlD4z/JSVzbNmdfsOzWo+fvlgPik9R7jt2dzAxfowaEv87KWHKnCVaG5z0aR/CiJFQn97tY0P1k8BxiuU0fwcDY9ssLFFf/66dU3cpW52L8F8cK+9kwu+b+PKtHdCGdUaL3vnQzqHwh33kK+gViPIhhetBXPdSi9c5AQWTBFQ1j1D2ZwFccA/kJtKlToqalPCihVuj5VrqIwSyf2xuKCdeaGC7PV8dzuzBwMIOetGFmgiUg5jQkG04hAi2AfjF4Dv73N6EEhf9ZPE63CPNFQg2ELZSvU1qsiyP1F6sIYg3PKKMfUyS3oYT7w6V8VQ9PdZZazdzzpQphoF/04fiAbYJTHyIzwCeJKPoMagN1AKAbEXZafBA4afJSvxsZPmvEK/miYAHNGk5TSunGr+N8j3L3yKUOGC/c3ObNgFQs0BEE7a2Ke0rxvJyn/sOag9qhTONp6Kapccbe4nCjlWJQjnG+eAb4PFQK7oTLquzKQXd8gQg4jXDYnPvtQ6luAjS072cczeq4yqQgdy+nUyefO5H5Afo/Ul0Kmb8M0jxrxI/sHc8m6TYYCiXhSZqw9V2ITNa1vv0bbi9SjSOb+xJ/QuHSaAuTufIff2azVXJ2e2zwRXvI5vZsIuLNKMvNUj8/V+teoyyMdvT7VU39BTnP6nBprwDgBqkDccgXSV84/nc/1SBBVxXodcnXxNRW10nvEUahstRXjzPmHHWsSu9kEA
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad14e49f-8cfe-42a8-f009-08dbfafd47d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 10:29:54.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yh4fOa0Gd9yoLQk5FJr/oNw8D0jNfGLommNDWjlz9U2i1C6asWICIr5E9bUtdGPct2F6lL78Dzakt2QrpB9HeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7074
X-Proofpoint-GUID: YsKzi8jbPhZCh9EBrzIc2FNq3HHOWVXN
X-Proofpoint-ORIG-GUID: YsKzi8jbPhZCh9EBrzIc2FNq3HHOWVXN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: YsKzi8jbPhZCh9EBrzIc2FNq3HHOWVXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02

PiBIYXZlIHlvdSBldmVyIHJ1biB4ZnN0ZXN0cyBhZ2FpbnN0IHY2IHZlcnNpb24gPw0KDQpZZXMu
IA0KDQo+IFRoZSBwYWdlIGFsbG9jYXRpb24gZmFpbHVyZSBwcm9ibGVtIGluIG15IHRlc3QgaGFw
cGVuIGJlbG93Lg0KPiBXaGF0IGlzIHlvdXIgdGVzdCByZXN1bHQ/DQoNClRoZXJlIGlzIG5vIHRo
ZSBwYWdlIGFsbG9jYXRpb24gZmFpbHVyZSBwcm9ibGVtIGluIG15IHRlc3QuDQpJIHNraXBwZWQg
dGhlIDYgdGVzdCBjYXNlcywgZXhjZXB0IGZvciB0aGVzZSA2IHRlc3QgY2FzZXMsIGFsbCBvdGhl
ciB0ZXN0IGNhc2VzIHBhc3NlZC4NCg0KLSBnZW5lcmljLzI1MQ0KLSBnZW5lcmljLzQ1NQ0KLSBn
ZW5lcmljLzQ4Mg0KLSBnZW5lcmljLzYwNA0KLSBnZW5lcmljLzYzMw0KLSBnZW5lcmljLzczMA0K
DQpXaGF0IGFyZSB0aGUgY2hhbmNlcyBvZiB0aGlzIHByb2JsZW0gaGFwcGVuaW5nPyBldmVyeSB0
aW1lIHdoZW4gcnVubmluZyBnZW5lcmljLzQ3Nj8NCg0KDQo=

