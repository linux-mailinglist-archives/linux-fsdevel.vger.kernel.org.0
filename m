Return-Path: <linux-fsdevel+bounces-11906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42C858D8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 07:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151BF1F2258C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A251C2BC;
	Sat, 17 Feb 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="B9KrxIzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5B1BDC4
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151964; cv=fail; b=fFhFt9s1EtzctKAEoMdUlJkDQAcK0ntPcw4L+ld6boAuBbBREbiW11ynG0lqjdOXLlYQLxdwrAFFiqeLp241/Bq8qM9R9t9RanCnVHWs1DRJEYIokUKsuidK7FxyCwrWe3mC0t5VgD0AyWTpPkmpDXJYj2XjFpPInQbztpzKm2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151964; c=relaxed/simple;
	bh=do9PFALg5/5fC8MWUOD1+So/MW/EWvCmxTUwObNJbVg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qt4ijXcP8y9biT8JRb9nN0pHxfhKd9aDVgYEy1WVEOX0JSxXGSQ8Q+slS7Y8I8zHpeXKK8eH/CVmM3mLrJR13CROENaBDeWb4Pld5xxCHjuNZsxRqln2sS6Z4P6kWiVCJiJvCWaBcJzcpnOjxBMsXW+S6AH1naTWuqLTX8w7kJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=B9KrxIzY; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H6ciFa006812;
	Sat, 17 Feb 2024 06:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=duyxEWRGGkfuQFQE5nrFqcsiPxo0qajJLvPPl4d7bC0=;
 b=B9KrxIzYCGj0M8Nr+m1LfdpyD72nP46kw960J6Qf27PEhZ/Xkz/9z6nOkrH12zgSnveW
 ZXhprYN1FOMG7OKxroGNnRn8T9TM96sK2UWFc8NTrDtG6UbwUc/CmnQIIeFbMnESd7mx
 E81rAqs3tHz/+seXz/oiBygvpTPydOYwetVLTkxbiZB9tgBUUyWDNwVQGdrJZpm6A7bn
 24HzKbIHYSIw1BpkK7uZkLd8BvxerHlYyO+ZptCCK5QodT3CdJNqOl6ARM1+mCO8/TS+
 1b1bm6KiuLbG9YQHacNrj+RA+cK3bx6/tXCzp/RnHs+aylSy4GEyMzLqEFdcZX518XRA aQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2107.outbound.protection.outlook.com [104.47.26.107])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wan6sr25e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 06:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc1ri41HkUyYejJzEmI0UZ9Wg6NmQvxOWCMFF0+3rH5AMDGG8/7mJ7wuFTVUhcddLqQLQ3VE0sxZfu0pOKZpBcfnNnCMJglbcNlN9pEFHwd+7O4WMlJ9va3jcdcGWZ5DBSZc5CDfRcKss0tnC/VhDPhm0uSutYwsu3j/hetOmNyagjSun6V1fK4+MG2gjsvbVy1tvc5XJYemb//+4zfcewTvWIv8ZzpKNhCJahSeobaUGClWQKneBUzuoaKWyna/ca6j9RN+IDTzHdyhXrh3G3fXCTXlZ9PicBUEPMN0yp+nS7TAqriORoHJsiDGpQAGh8QO+BdYjmAetXr6YKmtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duyxEWRGGkfuQFQE5nrFqcsiPxo0qajJLvPPl4d7bC0=;
 b=RndKXiDIQ5rpXS+DKJWwYWO+iBvM1nwu60avIXZVqRqCw/kTkUxgHSvm5CnQdrkmTpAtbRXZFy6ByADBm5zkrk/h8VCdYyFM1wevkd/NQkrHcg8dO4Eu0O+bPn2gwSpkOr9zB+Ox3+kmDySKiqPK8OA/3U3+khewjjhA5fyKxvAOW02rRx7HJ9mwhOsYkClT/EVvBQ96D+ntSN60TPzXGoA9lkZWQi9bYnhGfedqWWNIay62GIYMBQMBrGof0EKBa6RgJBdOrUEm4E4ni8Wvx0UoUTlgWw2Wj9jPCx3rRiZoL9I4RULgJbcspk3tGrIIwkF9FYBfgRtcjO3mc5mD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB8358.apcprd04.prod.outlook.com (2603:1096:101:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sat, 17 Feb
 2024 06:38:32 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%7]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 06:38:32 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "erichong@qnap.com" <erichong@qnap.com>,
        "Andy.Wu@sony.com"
	<Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: fix appending discontinuous clusters to empty file
Thread-Topic: [PATCH v1] exfat: fix appending discontinuous clusters to empty
 file
Thread-Index: Adpg0nMFwt+zG1LXR1ylXU/l2ZhIKwAmK47A
Date: Sat, 17 Feb 2024 06:38:32 +0000
Message-ID: 
 <PUZPR04MB63167444783A68A96C950E5981532@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB8358:EE_
x-ms-office365-filtering-correlation-id: c1403c7a-0be6-4c2c-e9d3-08dc2f830f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7/4stVjq1m1iT3BlU07pVUoqWN1pImBpWwHgbjcpSHHQ8Rd/CahujiewpWAKdYNcZwRI8XH9NpwptsDFKIUf8FXBpuwTq8OX01ULl+hgv8PDs67mLWCFlSjk9j+7lk3UGcH4xe5I38grXV2RkqF6PHXqssZAMDRdn9wfvrdnVt3ombuJ37EyWmykYzWS0RhwbsT+B1m4BdGDLiuBb9pfi/SMhaYGjKYoYKF1/WWa7qNUDyuGlyguB58MbEXCgi8eS7bMXEvQ2ZbW0P0U88Vy7XkyS84TpXV7GyDrgzf0jxnDAkhquMK5WPxWqIgZqkr0XE/Zl/a7LXu+SCnmggp5OReSptFhUnN7FDYIBX3xsrpsR1bMszULfwnXpkJgeSQX/XgEYiKf3IV6yWjDHZtl/xxwhdffcjRBLL4OYnqHILipygOvZQGeAO3+IVKt5LLvDJP5PzOX6KGA99MnBvmiBd3bks/qUFq0QPQ43UPKqfPVUT9dE0Z8QDtwZi/lYiOHHSA6R6aziEkn0cxgOaUJgE3uhd6Lijc5czrqJwz9CbU/mHLT8qGmQcL3aHThgKbjhrcPn4H5Bs4p+NGM/1IxedpEjk9f9ISGBMXlIOnXwvs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(8676002)(52536014)(4326008)(8936002)(83380400001)(107886003)(26005)(38100700002)(122000001)(86362001)(33656002)(82960400001)(38070700009)(99936003)(64756008)(54906003)(66446008)(76116006)(66946007)(66556008)(66476007)(110136005)(316002)(6506007)(7696005)(9686003)(966005)(478600001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b0NzK210TWltenRWeUQwUHZiYTZIZ3FxSGhaUXNPV21DbzFwTlJQK3JHVEZG?=
 =?utf-8?B?MDN3NVNxLzMvMGpzREh0cXg0MUpoM1Vsc2lhLzI1OTYwQ0hleGZaSGFscTI0?=
 =?utf-8?B?WGljNkVhSlFqeDhMM2VzMEFFMFU1ZWVpUTlucEwxQ0FxLzdSYnhINE9hWDRR?=
 =?utf-8?B?dENGSFAvK1RQR2pQR2NGOGRadlYvQzVXRWx4Zi9USk0rdW1LMXRibkVCWmda?=
 =?utf-8?B?dm1nNjUwSDROb1ZrRVZqcjhXM3I0Q0lRakRhOERXd3h2ejRLWFdiZmdjMGN2?=
 =?utf-8?B?RjYrM1N6ekRMVkw3b254Ym5WTkxoRWFMOHpsV2dnbFA1L2J1aytnSWFsTGI3?=
 =?utf-8?B?bWUxdGVtN2FsRUNDVFVMWVhobG5CcFpVNmVPZTFFUXBHc1U2WUFTeEJTc1Iz?=
 =?utf-8?B?OEVxOGhMQS9RYTBpeVVJSG5VNkdFaDJIVHkzS0MwRGttUXhac0RFdEIvSEk4?=
 =?utf-8?B?L1dHaG93ZmJxZjU1cDltYXFBMnFhdThiM0JmZ3Nsa2xuV2FxcThiSnpFeEpF?=
 =?utf-8?B?aGYvSzBUSUpGTlBFU0t2dGFFRVRDMjljdm9pcU82MnZ3ZEt5WWVvZkQ0NEc3?=
 =?utf-8?B?V2M4MEZwS2dJb09LckFsWUtFaEgycWpQMDJPNU92Y3F2ZTV3ODdSUGIzWXh5?=
 =?utf-8?B?aTVYZE0xZStjd2lVMUppUHpkSE4zblNleHhwT2xuSE9NZktCcXFDZmI1cXpj?=
 =?utf-8?B?YXJHdy9GZzlSWVZUWlR0TjVSNWc4UmlrTHVJVlVhOUhMMGJIcG1FZGNWT0l3?=
 =?utf-8?B?TFczZWZaRm9WdEFQa2MxdmRZV2twbStyZEIvRzNGS21HMUpvWXhXaFlEeW4v?=
 =?utf-8?B?SXVRTlVUVklnR240SllhbWd1bnBsb3g0ckdDaGJvM0ZpVG5BckVwcE51Mzlz?=
 =?utf-8?B?azJQTWpIVE1UNzFWTjVSVTVFVTlQeVU1WlY5NXQ5TGUvQXpPNU5hNnJKdldJ?=
 =?utf-8?B?NWhvdGNUUEV1MW9sRUp4SDlMOEtlQ3Jnem9sZ1MrUkpoTk5mci9iZndHVndl?=
 =?utf-8?B?NnlucHhLWU8rNXM1UXp3VktQaTkwMW11aEhDWHVSUHJ5c1JZUk42RERMbEFS?=
 =?utf-8?B?c2pTVkZmYkppNTNabXIrUlpBY1g0SE9IS1lYLzQ1U2dNcUhtTnBpbVRUUjkv?=
 =?utf-8?B?bkhhc3pLUEZGbmRxUGxHOFl0eldMMW1QM3hacmx1eVRDUk4vcGlaNUV4VFBO?=
 =?utf-8?B?Q3U1NmlCMTMrN290WG5vQlUrN3ZobEkxQ0dvTCtjdnM4czFzeSs4djl1clZD?=
 =?utf-8?B?am4vYmU4RXBFYVYzRXp2Ulc1b3NQRkl2eWt0b1RwOG9pOTc3U1Z4VnhPUW9O?=
 =?utf-8?B?QTBFdi9JNWtVdTJRaGZFS2k2R01sR0VhMFNROWk4UmgvM1gyeEl5VUloOGd4?=
 =?utf-8?B?YTdjOTFxRnoxMXRBUWlWMHEvek5YRFAvVFc2TUVlaEdHcWtsMC8wMVoxT2xy?=
 =?utf-8?B?VEdPdmMyRWp3cTFqWFNnOVltR2U4WFNvUmRJRTFPeGN2ZjN4TEY2SVdvZStI?=
 =?utf-8?B?ZmZCS0d1d1crQWtab3hiSlBUMkt0WTRhYmNoT2pKbDVVVjd3K0ZzdE9WTFpH?=
 =?utf-8?B?R3Mvbk52dG1mRzlaTjF4NS9GYzZOckE0eDRzem8wOVEvVUtBN0dXZzZhYnJ6?=
 =?utf-8?B?M1ZNaGtBV0RVSnptTndibHRQOUcxTVR4QmV0QzRKak1XV3kvTzkrWnRCREtM?=
 =?utf-8?B?dER1NFBqMmEza2ZTWm5KYkNERVJpVjRJd2lkcDg1aEh0dTlwZEY1VTBZa21o?=
 =?utf-8?B?T29NMDFWcktqa3p3RVJaZmV6alhHL0RZbndNQTdxanhCMTJXblkxbHd3Q1V2?=
 =?utf-8?B?R0krcHlLS3h5MG9HOUJITlFiU3R5TWNNMkxBdjN5RWtDbUdoV3NxNU1ub1pH?=
 =?utf-8?B?SyticTI1dmppWHFwbGx3ZTJzUW9Kb2V6V3I3aTlpdG1RSXhJc0RuMXR1MHBu?=
 =?utf-8?B?R2x0UHlxSndQdHBsbVF3bHV2SG9USHZCQ0pZMEJTbEppamJkMDBkellYTVpQ?=
 =?utf-8?B?YVI3RTJ6QUFwaEJia09UQUhtUk0wcGFFVEUxRkVlRFVwRDJzY2Jrd05VNzJN?=
 =?utf-8?B?ZmR3NnUzMURXUzZSQ3JjMmQ5dEdxcUZETmM3bFdMeHBMVU1BSE5WRW4yeXYw?=
 =?utf-8?Q?hf3FxoCzHih6VdPpga8la+5ew?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	US/B343kx4jYpkEMWq2bkSKAkPk20MXEPSbihMp+anasPF/n1NKz3qs/z8KHxx3E/q6P6sDpwQ8gIoU8wPJJ5GKg0E4cQ8sj8iB5FACc8YDhdM2/p4ZP+QQhL9DyABuOfnd/6xBXKV3mHm8Fs4Ew+3WdQQsW/+60HUj/MZFi/9drEewsy/X9ePQXjewrrPYILq7gPMC7hBNuWT4UwehuVB0tTHC3ek6sjilY5GRtSuqA1Bmh37a7IBISknFQI7wEnTVGo7CZeMowpBpXvDtQgyorLzn274/vQ/agSOkoGa7+xtI5Sw0wXUwwPG+NjCwUn838VNr/IaIRehBo8ymVsDSnNmbrLaFSSd+0icnf/wiW8YhoBq9oUbUZ1nk/z6q/7JEDE1Vps3YjQTfuD+QgFL4u3bh71e9bNPIv9wceyXnYdqI508hgcQDhFxjUc/eBdW+j+0tM9KsWgN+ov4fPUDHdEWmYBdLZWeEdm1ouOCg7i4Oua/d3cSKqlH6wlPYcq0SxQdE0TBxseMaCd3+8njsVgN7COGLFcDwQbwYlv785yKNFBiq/ZTkBa6HBH3bEjlg33hKFb+4nFV/HVi29SRL2JZrI79xnMWCR6XGQIBknmB+mSkvbzOCftu9KAGJK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1403c7a-0be6-4c2c-e9d3-08dc2f830f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 06:38:32.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ4WwynzK2h9snl/4bW95++g1OQpTRt71hWHhWhb65+ghmajMbtyRC5DUtEum+eoM9J7NOGOMXCgFQrbFy8gjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8358
X-Proofpoint-GUID: iNPtpOOkX2FxQznt55VDJCytUlNemug3
X-Proofpoint-ORIG-GUID: iNPtpOOkX2FxQznt55VDJCytUlNemug3
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB63167444783A68A96C950E5981532PUZPR04MB6316apcp_"
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: iNPtpOOkX2FxQznt55VDJCytUlNemug3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_03,2024-02-16_01,2023-05-22_02

--_002_PUZPR04MB63167444783A68A96C950E5981532PUZPR04MB6316apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RXJpYyBIb25nIGZvdW5kIHRoYXQgd2hlbiB1c2luZyBmdHJ1bmNhdGUgdG8gZXhwYW5kIGFuIGVt
cHR5IGZpbGUsDQpleGZhdF9lbnRfc2V0KCkgd2lsbCBmYWlsIGlmIGRpc2NvbnRpbnVvdXMgY2x1
c3RlcnMgYXJlIGFsbG9jYXRlZC4NClRoZSByZWFzb24gaXMgdGhhdCB0aGUgZW1wdHkgZmlsZSBk
b2VzIG5vdCBoYXZlIGEgY2x1c3RlciBjaGFpbiwNCmJ1dCBleGZhdF9lbnRfc2V0KCkgYXR0ZW1w
dHMgdG8gYXBwZW5kIHRoZSBuZXdseSBhbGxvY2F0ZWQgY2x1c3Rlcg0KdG8gdGhlIGNsdXN0ZXIg
Y2hhaW4uIEluIGFkZGl0aW9uLCBleGZhdF9maW5kX2xhc3RfY2x1c3RlcigpIG9ubHkNCnN1cHBv
cnRzIGZpbmRpbmcgdGhlIGxhc3QgY2x1c3RlciBpbiBhIG5vbi1lbXB0eSBmaWxlLg0KDQpTbyB0
aGlzIGNvbW1pdCBhZGRzIGEgY2hlY2sgd2hldGhlciB0aGUgZmlsZSBpcyBlbXB0eS4gSWYgdGhl
IGZpbGUNCmlzIGVtcHR5LCBleGZhdF9maW5kX2xhc3RfY2x1c3RlcigpIGFuZCBleGZhdF9lbnRf
c2V0KCkgYXJlIG5vIGxvbmdlcg0KY2FsbGVkIGFzIHRoZXkgZG8gbm90IG5lZWQgdG8gYmUgY2Fs
bGVkLg0KDQpGaXhlczogZjU1YzA5NmY2MmYxICgiZXhmYXQ6IGRvIG5vdCB6ZXJvIHRoZSBleHRl
bmRlZCBwYXJ0IikNClJlcG9ydGVkLWJ5OiBFcmljIEhvbmcgPGVyaWNob25nQHFuYXAuY29tPg0K
Q2xvc2VzOiBodHRwczovL2dpdGh1Yi5jb20vbmFtamFlamVvbi9saW51eC1leGZhdC1vb3QvaXNz
dWVzLzY2DQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
DQotLS0NCiBmcy9leGZhdC9maWxlLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQpp
bmRleCBkMjVhOTZhMTQ4YWYuLmNjMDBmMWE3YTFlMSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Zp
bGUuYw0KKysrIGIvZnMvZXhmYXQvZmlsZS5jDQpAQCAtMzUsMTMgKzM1LDE4IEBAIHN0YXRpYyBp
bnQgZXhmYXRfY29udF9leHBhbmQoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpDQog
CWlmIChuZXdfbnVtX2NsdXN0ZXJzID09IG51bV9jbHVzdGVycykNCiAJCWdvdG8gb3V0Ow0KIA0K
LQlleGZhdF9jaGFpbl9zZXQoJmNsdSwgZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzLCBlaS0+
ZmxhZ3MpOw0KLQlyZXQgPSBleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgJmNsdSwgJmxhc3Rf
Y2x1KTsNCi0JaWYgKHJldCkNCi0JCXJldHVybiByZXQ7DQorCWlmIChudW1fY2x1c3RlcnMpIHsN
CisJCWV4ZmF0X2NoYWluX3NldCgmY2x1LCBlaS0+c3RhcnRfY2x1LCBudW1fY2x1c3RlcnMsIGVp
LT5mbGFncyk7DQorCQlyZXQgPSBleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgJmNsdSwgJmxh
c3RfY2x1KTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCisNCisJCWNsdS5kaXIgPSBs
YXN0X2NsdSArIDE7DQorCX0gZWxzZSB7DQorCQlsYXN0X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVS
Ow0KKwkJY2x1LmRpciA9IEVYRkFUX0VPRl9DTFVTVEVSOw0KKwl9DQogDQotCWNsdS5kaXIgPSAo
bGFzdF9jbHUgPT0gRVhGQVRfRU9GX0NMVVNURVIpID8NCi0JCQlFWEZBVF9FT0ZfQ0xVU1RFUiA6
IGxhc3RfY2x1ICsgMTsNCiAJY2x1LnNpemUgPSAwOw0KIAljbHUuZmxhZ3MgPSBlaS0+ZmxhZ3M7
DQogDQpAQCAtNTEsMTcgKzU2LDE5IEBAIHN0YXRpYyBpbnQgZXhmYXRfY29udF9leHBhbmQoc3Ry
dWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpDQogCQlyZXR1cm4gcmV0Ow0KIA0KIAkvKiBB
cHBlbmQgbmV3IGNsdXN0ZXJzIHRvIGNoYWluICovDQotCWlmIChjbHUuZmxhZ3MgIT0gZWktPmZs
YWdzKSB7DQotCQlleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2IsIGVpLT5zdGFydF9jbHUsIG51
bV9jbHVzdGVycyk7DQotCQllaS0+ZmxhZ3MgPSBBTExPQ19GQVRfQ0hBSU47DQotCX0NCi0JaWYg
KGNsdS5mbGFncyA9PSBBTExPQ19GQVRfQ0hBSU4pDQotCQlpZiAoZXhmYXRfZW50X3NldChzYiwg
bGFzdF9jbHUsIGNsdS5kaXIpKQ0KLQkJCWdvdG8gZnJlZV9jbHU7DQotDQotCWlmIChudW1fY2x1
c3RlcnMgPT0gMCkNCisJaWYgKG51bV9jbHVzdGVycykgew0KKwkJaWYgKGNsdS5mbGFncyAhPSBl
aS0+ZmxhZ3MpDQorCQkJaWYgKGV4ZmF0X2NoYWluX2NvbnRfY2x1c3RlcihzYiwgZWktPnN0YXJ0
X2NsdSwgbnVtX2NsdXN0ZXJzKSkNCisJCQkJZ290byBmcmVlX2NsdTsNCisNCisJCWlmIChjbHUu
ZmxhZ3MgPT0gQUxMT0NfRkFUX0NIQUlOKQ0KKwkJCWlmIChleGZhdF9lbnRfc2V0KHNiLCBsYXN0
X2NsdSwgY2x1LmRpcikpDQorCQkJCWdvdG8gZnJlZV9jbHU7DQorCX0gZWxzZQ0KIAkJZWktPnN0
YXJ0X2NsdSA9IGNsdS5kaXI7DQogDQorCWVpLT5mbGFncyA9IGNsdS5mbGFnczsNCisNCiBvdXQ6
DQogCWlub2RlX3NldF9tdGltZV90b190cyhpbm9kZSwgaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQo
aW5vZGUpKTsNCiAJLyogRXhwYW5kZWQgcmFuZ2Ugbm90IHplcm9lZCwgZG8gbm90IHVwZGF0ZSB2
YWxpZF9zaXplICovDQotLSANCjIuMzQuMQ0KDQo=

--_002_PUZPR04MB63167444783A68A96C950E5981532PUZPR04MB6316apcp_
Content-Type: application/octet-stream;
	name="v1-0001-exfat-fix-appending-discontinuous-clusters-to-emp.patch"
Content-Description: 
 v1-0001-exfat-fix-appending-discontinuous-clusters-to-emp.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-appending-discontinuous-clusters-to-emp.patch";
	size=2800; creation-date="Sat, 17 Feb 2024 06:27:59 GMT";
	modification-date="Sat, 17 Feb 2024 06:38:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3ZDE1YTJlZDM1MGU5YzNiZjZiMzM2M2FmMjUyNTVkZWU1NTZhMTJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMTYgRmViIDIwMjQgMjA6MTk6NTUgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IGFwcGVuZGluZyBkaXNjb250aW51b3VzIGNsdXN0ZXJzIHRvIGVtcHR5IGZpbGUK
CkVyaWMgSG9uZyBmb3VuZCB0aGF0IHdoZW4gdXNpbmcgZnRydW5jYXRlIHRvIGV4cGFuZCBhbiBl
bXB0eSBmaWxlLApleGZhdF9lbnRfc2V0KCkgd2lsbCBmYWlsIGlmIGRpc2NvbnRpbnVvdXMgY2x1
c3RlcnMgYXJlIGFsbG9jYXRlZC4KVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBlbXB0eSBmaWxlIGRv
ZXMgbm90IGhhdmUgYSBjbHVzdGVyIGNoYWluLApidXQgZXhmYXRfZW50X3NldCgpIGF0dGVtcHRz
IHRvIGFwcGVuZCB0aGUgbmV3bHkgYWxsb2NhdGVkIGNsdXN0ZXIKdG8gdGhlIGNsdXN0ZXIgY2hh
aW4uIEluIGFkZGl0aW9uLCBleGZhdF9maW5kX2xhc3RfY2x1c3RlcigpIG9ubHkKc3VwcG9ydHMg
ZmluZGluZyB0aGUgbGFzdCBjbHVzdGVyIGluIGEgbm9uLWVtcHR5IGZpbGUuCgpTbyB0aGlzIGNv
bW1pdCBhZGRzIGEgY2hlY2sgd2hldGhlciB0aGUgZmlsZSBpcyBlbXB0eS4gSWYgdGhlIGZpbGUK
aXMgZW1wdHksIGV4ZmF0X2ZpbmRfbGFzdF9jbHVzdGVyKCkgYW5kIGV4ZmF0X2VudF9zZXQoKSBh
cmUgbm8gbG9uZ2VyCmNhbGxlZCBhcyB0aGV5IGRvIG5vdCBuZWVkIHRvIGJlIGNhbGxlZC4KCkZp
eGVzOiBmNTVjMDk2ZjYyZjEgKCJleGZhdDogZG8gbm90IHplcm8gdGhlIGV4dGVuZGVkIHBhcnQi
KQpSZXBvcnRlZC1ieTogRXJpYyBIb25nIDxlcmljaG9uZ0BxbmFwLmNvbT4KQ2xvc2VzOiBodHRw
czovL2dpdGh1Yi5jb20vbmFtamFlamVvbi9saW51eC1leGZhdC1vb3QvaXNzdWVzLzY2ClNpZ25l
ZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZh
dC9maWxlLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jCmluZGV4IGQyNWE5NmExNDhhZi4u
Y2MwMGYxYTdhMWUxIDEwMDY0NAotLS0gYS9mcy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQv
ZmlsZS5jCkBAIC0zNSwxMyArMzUsMTggQEAgc3RhdGljIGludCBleGZhdF9jb250X2V4cGFuZChz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgc2l6ZSkKIAlpZiAobmV3X251bV9jbHVzdGVycyA9
PSBudW1fY2x1c3RlcnMpCiAJCWdvdG8gb3V0OwogCi0JZXhmYXRfY2hhaW5fc2V0KCZjbHUsIGVp
LT5zdGFydF9jbHUsIG51bV9jbHVzdGVycywgZWktPmZsYWdzKTsKLQlyZXQgPSBleGZhdF9maW5k
X2xhc3RfY2x1c3RlcihzYiwgJmNsdSwgJmxhc3RfY2x1KTsKLQlpZiAocmV0KQotCQlyZXR1cm4g
cmV0OworCWlmIChudW1fY2x1c3RlcnMpIHsKKwkJZXhmYXRfY2hhaW5fc2V0KCZjbHUsIGVpLT5z
dGFydF9jbHUsIG51bV9jbHVzdGVycywgZWktPmZsYWdzKTsKKwkJcmV0ID0gZXhmYXRfZmluZF9s
YXN0X2NsdXN0ZXIoc2IsICZjbHUsICZsYXN0X2NsdSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4g
cmV0OworCisJCWNsdS5kaXIgPSBsYXN0X2NsdSArIDE7CisJfSBlbHNlIHsKKwkJbGFzdF9jbHUg
PSBFWEZBVF9FT0ZfQ0xVU1RFUjsKKwkJY2x1LmRpciA9IEVYRkFUX0VPRl9DTFVTVEVSOworCX0K
IAotCWNsdS5kaXIgPSAobGFzdF9jbHUgPT0gRVhGQVRfRU9GX0NMVVNURVIpID8KLQkJCUVYRkFU
X0VPRl9DTFVTVEVSIDogbGFzdF9jbHUgKyAxOwogCWNsdS5zaXplID0gMDsKIAljbHUuZmxhZ3Mg
PSBlaS0+ZmxhZ3M7CiAKQEAgLTUxLDE3ICs1NiwxOSBAQCBzdGF0aWMgaW50IGV4ZmF0X2NvbnRf
ZXhwYW5kKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKQogCQlyZXR1cm4gcmV0Owog
CiAJLyogQXBwZW5kIG5ldyBjbHVzdGVycyB0byBjaGFpbiAqLwotCWlmIChjbHUuZmxhZ3MgIT0g
ZWktPmZsYWdzKSB7Ci0JCWV4ZmF0X2NoYWluX2NvbnRfY2x1c3RlcihzYiwgZWktPnN0YXJ0X2Ns
dSwgbnVtX2NsdXN0ZXJzKTsKLQkJZWktPmZsYWdzID0gQUxMT0NfRkFUX0NIQUlOOwotCX0KLQlp
ZiAoY2x1LmZsYWdzID09IEFMTE9DX0ZBVF9DSEFJTikKLQkJaWYgKGV4ZmF0X2VudF9zZXQoc2Is
IGxhc3RfY2x1LCBjbHUuZGlyKSkKLQkJCWdvdG8gZnJlZV9jbHU7Ci0KLQlpZiAobnVtX2NsdXN0
ZXJzID09IDApCisJaWYgKG51bV9jbHVzdGVycykgeworCQlpZiAoY2x1LmZsYWdzICE9IGVpLT5m
bGFncykKKwkJCWlmIChleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2IsIGVpLT5zdGFydF9jbHUs
IG51bV9jbHVzdGVycykpCisJCQkJZ290byBmcmVlX2NsdTsKKworCQlpZiAoY2x1LmZsYWdzID09
IEFMTE9DX0ZBVF9DSEFJTikKKwkJCWlmIChleGZhdF9lbnRfc2V0KHNiLCBsYXN0X2NsdSwgY2x1
LmRpcikpCisJCQkJZ290byBmcmVlX2NsdTsKKwl9IGVsc2UKIAkJZWktPnN0YXJ0X2NsdSA9IGNs
dS5kaXI7CiAKKwllaS0+ZmxhZ3MgPSBjbHUuZmxhZ3M7CisKIG91dDoKIAlpbm9kZV9zZXRfbXRp
bWVfdG9fdHMoaW5vZGUsIGlub2RlX3NldF9jdGltZV9jdXJyZW50KGlub2RlKSk7CiAJLyogRXhw
YW5kZWQgcmFuZ2Ugbm90IHplcm9lZCwgZG8gbm90IHVwZGF0ZSB2YWxpZF9zaXplICovCi0tIAoy
LjM0LjEKCg==

--_002_PUZPR04MB63167444783A68A96C950E5981532PUZPR04MB6316apcp_--

