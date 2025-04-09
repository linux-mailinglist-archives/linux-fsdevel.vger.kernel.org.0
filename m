Return-Path: <linux-fsdevel+bounces-46095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D0A827B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5811A1B668E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627D25E836;
	Wed,  9 Apr 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="PA9SlHDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854318CBE1
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208741; cv=fail; b=IoDr/bgGZo21FRrnoG8g0ni33e4vvi5Vy3jhSO059CKEA36ujo6AjTRBi5KRSo70uI386HZ8WkGrXNoW650n7RPGL17NkfoR/vqJ2QUY2zotgrky/FjKfE8kZhwMUi0eK5RErgkcxl7eYJvxLvi2EhIwe4fei8wyLiFGg1my8og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208741; c=relaxed/simple;
	bh=vZZHpnIh7QiPr5t08T3Brjy1p0cqtQEqeYKAK9DAPNw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tY4AcU5XfNJn48Z/gwXn01OfWRCTNER0u24izHwpKs8VLyaaxhGm+oJIoLJB7Rp8k7E7yrM1PZ7Bb3gvBC2GnEq3pPjYEnKKfObZtgH1v3vAAHnineJSIVTBQBguOswMitdspyvn8sGysEKqNy1smHowe0d2rVmcTn1vr8wifbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=PA9SlHDO; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174]) by mx-outbound-ea8-37.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 09 Apr 2025 14:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDxr2qDnOKNUYfY90qPDhROlUh2Gxgg5FMbHXjJVFpvL2vdJCRoQMZQd/5rsK9bIyXpZfbqGcntC8Mq4lDc532I3xVQw5I4XP9ss5aA/E62LnCGohBUY6Th7qLRA6DWwQu7hbVS3sglzqcwgwhtvwv1gH709ZUUvFbbgrNk09GpQabfvVhRx5Obd45+CVbqVotzovCmVWdyqnVxCLOaJekpNV6PgOG6uEkgE8eva13lHjWtZQzwZNe+CCCmFH0pdnwJGhu6EKyioik9ZeCpCgNvB+xIVo2BM3b5aGaLwTzYyFil8lemoL056onzRR/OJYZVJi0mCXVKL9aEHLVdB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZZHpnIh7QiPr5t08T3Brjy1p0cqtQEqeYKAK9DAPNw=;
 b=HSveP+g8Z16HNrnozH0QThY2XRaXPyqL+rsXHVygwiQ2CGjY93L0u3AjpcMn0MBPynIfdJZ89DrF9LhDWvyUS6o6OC0fcZnicqLk3WBX4fqPBs3WUIVuA7vsP7tkMzucN3AmWtWAnYEG3eSdPbjO+Tdvk1neUDj0fYu60YM/vTok0n9aduWw504eJC3xTPRw43fR50iCEXnVX/wR0Nf00rgtHfnZgmL9jsHtr4U9x2eu7X9k6yf4L+R+1UbCPKI4Y5xYlq8eXZVHcGBfh3tS2Zfzo2huEnsaxDIhmDPYjn1RIBwocQ4g2lrW7vj6sLcaoyzEEWrnpu7uUB96xLyKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZZHpnIh7QiPr5t08T3Brjy1p0cqtQEqeYKAK9DAPNw=;
 b=PA9SlHDOOugZjNsc/s9nqaTrKmSQrWFkFa1iRXXkBWu1yPKmHLivIiMHGVmkj88wBkYHbB2U25eCMF82glLVGks0loACftmVMVwoTHPnDbjOWA8B3iGBu83NBmwg3syxmOk07tNMAyKNSH8koabvl7vKHp7lPvSK1P2pTJibcUQ=
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by DS7PR19MB5686.namprd19.prod.outlook.com (2603:10b6:8:71::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 14:25:26 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 14:25:26 +0000
From: Guang Yuan Wu <gwu@ddn.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>, Bernd Schubert
	<bschubert@ddn.com>
Subject: [PATCH] fs/fuse: fix race between concurrent setattr from multiple
 nodes
Thread-Topic: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbqVp0M67N/vLLOUi6vmMAtVcZEw==
Date: Wed, 9 Apr 2025 14:25:26 +0000
Message-ID:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3187:EE_|DS7PR19MB5686:EE_
x-ms-office365-filtering-correlation-id: c88b2553-f837-461e-7f31-08dd77725f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nGGtDHQkAtlPwkdwxQCubGgeV1vBKKxu3I+HymHa3cRRKw0VcQ+dTGSX9x?=
 =?iso-8859-1?Q?uo/ua/OqOhhLhPTSSfkIRXXj7brP95YD/EjH8yHLM3KDrAISaWhuT7Od6n?=
 =?iso-8859-1?Q?JGtuLiOQKMeOjOeDbvejAnNPJ4Hlh3G96HbV7wxoB1rCsIO59oZx+eM7AP?=
 =?iso-8859-1?Q?BuEXU7/S3PDNCPOHkc+cKPcqQhQSVgpOytR0sgVivJw2SYWeZfsK55u7gK?=
 =?iso-8859-1?Q?aHO1z4Lsv53EKWC6eBdxzj/Zt9MkKoo5iZwp4uYuVC0q7yqv7Wm+8/s1gC?=
 =?iso-8859-1?Q?xCIXgMnal71h3QoneRhXHp1mEnJJX6LtRNWLseVH10dvL1w48gad+P4RaW?=
 =?iso-8859-1?Q?o7XnQvUyzugseAZl7b9sUsKip3MaWJAVUNOwGGRyoI+iFkue0Oc9S7sag7?=
 =?iso-8859-1?Q?CCVtfhsNLoJTu3SsbHekjCRlBewlK+CCNoRc2TzHtiRqvfRObi0uF0mXOC?=
 =?iso-8859-1?Q?X7AjiASIMrCYGxsZoSlPwHrNenh2SyAzTb+iZaAmOTeq26PQZ+KgDrmSR3?=
 =?iso-8859-1?Q?JRy7QXxCHtAI/+KeY0MTVJmv2m7wajJgzTlxl6yU3v3oQ7C77CI3jlOMaZ?=
 =?iso-8859-1?Q?LDToAT8/oL6Py4TRHpq7zPRTR1bgRQBLIWMbq3u0pCCTfInxn7k70WrM3R?=
 =?iso-8859-1?Q?53wzkPVz8xs4z7C7uRa3e8xwkK48RLEZL238voJE8as9lH5bag+FN1hahf?=
 =?iso-8859-1?Q?2ajlezhxPAAwjXN83U8Rl7hNO/XT7ck52/MTYi6vbe+GXLKHyvxpTBlsRj?=
 =?iso-8859-1?Q?gVT3aO6XubrMSHVDa4Mu1G4+8yXW+uKlinqX9jjnYSy94qbwGSRNg0cg4v?=
 =?iso-8859-1?Q?JbBBZAjlc2MyPaQlb810XAhRbp+9hHWEVZiHlqb8lMdgcjQFba3NRyTERb?=
 =?iso-8859-1?Q?E6X6aR6xuPGXIHEz90fRE8zeKMqOjPv0H6vWI/eJGXmJ6o/cArL6YsZE+/?=
 =?iso-8859-1?Q?02RPOSvSsOhSrXZ6x/vehA7WBSFnghoWqELCCNrPqiWrpeey4QfM9Ua7FG?=
 =?iso-8859-1?Q?NRqArvq1kMTa38USd3o9O5J42uYLGjhhozSrXcmmQn35Y8nMekSNs4Pr+z?=
 =?iso-8859-1?Q?2huabzl50GJ6PJc781+je37x3aQhkNZTeU/ri2gT+5EJ/dRyO4nkV586a7?=
 =?iso-8859-1?Q?2N9s3+XmC03/TR5DyjV87PfG/QOvKhVtwAiIU7oiJzuabxi514icDMmxje?=
 =?iso-8859-1?Q?L49ezhWEKZoHJHKvK3Pb119RdY05+YI0RDzwizP8GpqKWSCCm7L7kvf+E3?=
 =?iso-8859-1?Q?Mbwa/5F/K5YTrWi5OmKndfSNN+wEJrUFBeuACoZ8lQtUNspJkyOom0OoXO?=
 =?iso-8859-1?Q?ihPOSjmuPegLXDyNL75e4o/Fsm+JomMPzDuR4aZvavUa7UOypatjroVt6m?=
 =?iso-8859-1?Q?QEgiz1z+CubC4Tb018uj4dbS9ktWybWkHsrjn7YtUIDzgzx3SAW3gBGz/L?=
 =?iso-8859-1?Q?I1nmEuOsHAmX2A5AY/ZlcpnPSxVtZ+bOxuyHHT6/0KKjBSfU52B1VKYtyS?=
 =?iso-8859-1?Q?foPre6PlC8zQrZXhn3RL3fdt0Q7qXrxHIkasxaqWF6wLxRO7gjYV5l5I1e?=
 =?iso-8859-1?Q?F7UXO6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1OglKFpep4TwcIMciW0P9JQQJsCtJcr0Obemo3c3Q9ESCDWuXunmZuBtnZ?=
 =?iso-8859-1?Q?S9b71pbk+xxi7ly0gd8b9AZQ4UfXF9NMT9QmY8EQtSdTkxCFLTB0gYgakL?=
 =?iso-8859-1?Q?f9gXE129C3kZ/tKi+9a8WqT0DF7/01cUkyC/pI13coE5Jxt5MvnZCnANLI?=
 =?iso-8859-1?Q?/fR24XVzRbgIeixMivj3FJBhUu6bCG90+9aJQhSO0oFTJJNY4Q/A/BrjPE?=
 =?iso-8859-1?Q?I1lIIsSXafSPAi/MpJXFNAZaFIMIG6K/bRUVYdNmf8aVvG0A+NaVRdVnuC?=
 =?iso-8859-1?Q?JJm0A82+NX/MwESiKUWQaUKKn7soFcWNus60SIj+2ROnQobqU0HUWsy6fA?=
 =?iso-8859-1?Q?kamvr36QBAn2o/wZOC8IW2CDvq9BptnFwIZFId9OwmkBjUNaeVc5K0oWJK?=
 =?iso-8859-1?Q?kWZLkcSsyRL3KmsdEj5nZS5z96iEZGSa+qAVQ/gXVtY9MsQRDnIN9BOZXD?=
 =?iso-8859-1?Q?ztcPIMzPZlIHmQEfkmBdw/5ghKxRl1+amH5t3xHKiualkS5YPr5wdxXIaF?=
 =?iso-8859-1?Q?5BNuTlX0l4ppRx8OmHrJIe8oRcDsTL/0tCDkzTbYXepnC0M+VZEUALOWyM?=
 =?iso-8859-1?Q?FT4UOk8u/7BMfOhBKRGpMwx3596J21zEn0ayNinVr2wD1+/x1tp5a8vxLf?=
 =?iso-8859-1?Q?16jLBbpI1PDTyE6v9GNcSDS++Iol7FLF7xopw7cnY7L0ITO3fZC7WS1HxA?=
 =?iso-8859-1?Q?EsYCOoafdXIfGjnd1Kk45Pd3g2H4DVmv+K6Qt+UIHfAMT4o1U92jjMdk90?=
 =?iso-8859-1?Q?qB9rTjqrVwwZwBAD2gR2UA/8sF4isiiTCTiFrxBfPnhqhRNmFygh2soTwc?=
 =?iso-8859-1?Q?dzY90uueZNFpGSrrNAL/ehFMxVKFfwRpdp3r1g0B6tAGyvS73J5oCcoCRl?=
 =?iso-8859-1?Q?ON3/DWi6dVQQzfjHHPSVeWlhmfWl1dhjIT3uelfcqiHG92RSn7bMf+Uucl?=
 =?iso-8859-1?Q?uKWmH6qMAmYR3eiNnJ3DPSW68eqgei/19ktESJfxbeWhbFjZKuZzcQGdiQ?=
 =?iso-8859-1?Q?MrfX1VdHrPpixMHxrCH12YXVHYSnLF/xJO3oK5rQ/CREvaqLYAu4AlZNwM?=
 =?iso-8859-1?Q?WGCFxfrKtDZvp1fYjZ9MLOcP0tqROWVN1XERmAPelWmnMsHDvv50eLsrQA?=
 =?iso-8859-1?Q?wZMDs0Itfxm/AGmgj4rmeU03Sfh2XUfS/vYODAqS3AJuHnTA9qQ8RrKaTD?=
 =?iso-8859-1?Q?PTwXRNHYIUkbqz8z3EEB3K+xvzOEz6l5cNsa//ZwJ3e6iB2ghbhl1YAvhj?=
 =?iso-8859-1?Q?texmYL0MHW8TIIMt/yVi42it1y2vztVsfOf33XqDdVYVcdP/ZcicuWPTQ9?=
 =?iso-8859-1?Q?W0w3n3/LElWTnV5M0+MPn9NvQ6pFv3fiyQM6Qrfyg9B1KlYr1VqmMcJos8?=
 =?iso-8859-1?Q?3XgsKlKuopvDswcIaQZYgPbIiph0ZAVSci/0mALB4USSDSDT38ZB9k4pb9?=
 =?iso-8859-1?Q?pC2HMMOapEmGjoFje3ED0+HNAOmzTbyF/52FG9uer2Tb3VP7zYIRwRif+2?=
 =?iso-8859-1?Q?A+dRfBSrAcp22Qtv0dCy1Yr8Y7zii5VvRQYyZeACRvNnoHS0YG/iWIOI3v?=
 =?iso-8859-1?Q?RksYVAcTwdcKVyyM2OUWYLuItt3qrTZv+pV20Ijwki6Wl0qvjiufdypssd?=
 =?iso-8859-1?Q?uzECoU+5HMRi4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gacutVEweVKjtuvL31HcFx72OGvnUajbs7qy7qV18k+5je0EkeCdOI7ULySEEb+VKG7O7FcjU+/GG4pQ4pkeQ7fQKCBsoUe7WNVD3Xc6HK3zqJFyuZktJCkzK1DtmVPk1ds16+aNXt2eX+t+e3KHjvMvefnqYwrK93P1b5LOYr73gib5HszUcb1pXBM9wgqjaTckNIHTUatF4QhG0eno+A43NhJ6VHPibLR2+BEeP64TxQzj5bOGVUhvb2YPWyXPVjimxhMd8UuioKLCwNGoIFpNVK7aLVL/NLUmt6DuWRE0g43JSuTFjp0ymKpoLLGH1kFM42N8BwecAsEqcKdvFgZY/E8/2sj5XiQOqR3C0eOMNut+Jx1VOFSb6vpYM/LcnfYCuIeFzodRwoSYI6U20l1nxmthNluyEqOiIbFZBOLu4ognYirmTBO6oDDcS/yNtX398TyO3h5I1mji3I+xM5SgL1w3DLsHLw++W76oX14H4kOI2biJi8tN7yWbUGZKeAH1KPoele5Qm6cDP/ImMqtkGgVB5YMwziY2EzRTELnLcDmhdgHAfBFsNi8d+5aajPARrE9dB1f/qgbt0fTNKKvzAIoiOfwnASqKovrg/RVOM/6KaW9pNpdeRMjCzdb3aNtsJkld0bini7Aouzw/IA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88b2553-f837-461e-7f31-08dd77725f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 14:25:26.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hc0iR//KWI5qKc/MkJeE2UCupdTLBWCUbhFtAnEdsX4RFuXWJatgO2DnHNxGOo91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5686
X-BESS-ID: 1744208732-102085-5643-8472-1
X-BESS-VER: 2019.3_20250402.1543
X-BESS-Apparent-Source-IP: 104.47.56.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZGFuZAVgZQ0DQtLSnZyCLZyN
	w8OckYSKalGSdamqcmmhpbGKaZWCjVxgIAma3D20EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263765 [from 
	cloudscan12-84.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

=A0fuse: fix race between concurrent setattrs from multiple nodes=0A=
=0A=
=A0 =A0 When mounting a user-space filesystem on multiple clients, after=0A=
=A0 =A0 concurrent ->setattr() calls from different node, stale inode attri=
butes=0A=
=A0 =A0 may be cached in some node.=0A=
=0A=
=A0 =A0 This is caused by fuse_setattr() racing with fuse_reverse_inval_ino=
de().=0A=
=0A=
=A0 =A0 When filesystem server receives setattr request, the client node wi=
th=0A=
=A0 =A0 valid iattr cached will be required to update the fuse_inode's attr=
_version=0A=
=A0 =A0 and invalidate the cache by fuse_reverse_inval_inode(), and at the =
next=0A=
=A0 =A0 call to ->getattr() they will be fetched from user-space.=0A=
=0A=
=A0 =A0 The race scenario is:=0A=
=A0 =A0 =A0 1. client-1 sends setattr (iattr-1) request to server=0A=
=A0 =A0 =A0 2. client-1 receives the reply from server=0A=
=A0 =A0 =A0 3. before client-1 updates iattr-1 to the cached attributes by=
=0A=
=A0 =A0 =A0 =A0 =A0fuse_change_attributes_common(), server receives another=
 setattr=0A=
=A0 =A0 =A0 =A0 =A0(iattr-2) request from client-2=0A=
=A0 =A0 =A0 4. server requests client-1 to update the inode attr_version an=
d=0A=
=A0 =A0 =A0 =A0 =A0invalidate the cached iattr, and iattr-1 becomes staled=
=0A=
=A0 =A0 =A0 5. client-2 receives the reply from server, and caches iattr-2=
=0A=
=A0 =A0 =A0 6. continue with step 2, client-1 invokes fuse_change_attribute=
s_common(),=0A=
=A0 =A0 =A0 =A0 =A0and caches iattr-1=0A=
=0A=
=A0 =A0 The issue has been observed from concurrent of chmod, chown, or tru=
ncate,=0A=
=A0 =A0 which all invoke ->setattr() call.=0A=
=0A=
=A0 =A0 The solution is to use fuse_inode's attr_version to check whether t=
he=0A=
=A0 =A0 attributes have been modified during the setattr request's lifetime=
. If so,=0A=
=A0 =A0 mark the attributes as stale after fuse_change_attributes_common().=
=0A=
=0A=
=A0 =A0 Signed-off-by: Guang Yuan Wu <gwu@ddn.com>=0A=
---=0A=
=A0fs/fuse/dir.c | 12 ++++++++++++=0A=
=A01 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0A=
index d58f96d1e9a2..df3a6c995dc6 100644=0A=
--- a/fs/fuse/dir.c=0A=
+++ b/fs/fuse/dir.c=0A=
@@ -1889,6 +1889,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iat=
tr *attr,=0A=
=A0 =A0 =A0 =A0 int err;=0A=
=A0 =A0 =A0 =A0 bool trust_local_cmtime =3D is_wb;=0A=
=A0 =A0 =A0 =A0 bool fault_blocked =3D false;=0A=
+ =A0 =A0 =A0 bool invalidate_attr =3D false;=0A=
+ =A0 =A0 =A0 u64 attr_version;=0A=
=0A=
=A0 =A0 =A0 =A0 if (!fc->default_permissions)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr->ia_valid |=3D ATTR_FORCE;=0A=
@@ -1973,6 +1975,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iat=
tr *attr,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fc->handle_killpriv_v2 && !capable(CAP_=
FSETID))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inarg.valid |=3D FATTR_KILL=
_SUIDGID;=0A=
=A0 =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 attr_version =3D fuse_get_attr_version(fm->fc);=0A=
=A0 =A0 =A0 =A0 fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);=0A=
=A0 =A0 =A0 =A0 err =3D fuse_simple_request(fm, &args);=0A=
=A0 =A0 =A0 =A0 if (err) {=0A=
@@ -1998,9 +2002,17 @@ int fuse_do_setattr(struct dentry *dentry, struct ia=
ttr *attr,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: clear I_DIRTY_SYNC? */=0A=
=A0 =A0 =A0 =A0 }=0A=
=0A=
+ =A0 =A0 =A0 if ((attr_version !=3D 0 && fi->attr_version > attr_version) =
||=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state))=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 invalidate_attr =3D true;=0A=
+=0A=
=A0 =A0 =A0 =A0 fuse_change_attributes_common(inode, &outarg.attr, NULL,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ATTR_TIMEOUT(&outarg),=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 fuse_get_cache_mask(inode), 0);=0A=
+=0A=
+ =A0 =A0 =A0 if (invalidate_attr)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 fuse_invalidate_attr(inode);=0A=
+=0A=
=A0 =A0 =A0 =A0 oldsize =3D inode->i_size;=0A=
=A0 =A0 =A0 =A0 /* see the comment in fuse_change_attributes() */=0A=
=A0 =A0 =A0 =A0 if (!is_wb || is_truncate)=0A=

