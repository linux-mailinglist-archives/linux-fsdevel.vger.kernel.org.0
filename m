Return-Path: <linux-fsdevel+bounces-46172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF4A83CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4901B64D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901F20F07B;
	Thu, 10 Apr 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="O62pIBpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771620B805
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273282; cv=fail; b=AB0exkCt22Zm01PxDNk0msbuPyaOqXO3kQSV4oq8yWrudxwEZ+moKxsEO7QAH2C7gk49RBwKcwqjh3DR038suO3yQ15dT7t7PX7vkcWNce0P2ZNULeXUM0BvcSmqFEMeN8dYkOwxMM4cSoKGv5aaR8we94sJ2nopLoIpJuyWKw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273282; c=relaxed/simple;
	bh=B2Sj4g4PGKrv092L2XwjQY4rpIhdWV1p51LMA0aGKO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQcuMbXHVGCs5luULN35IQN4u7w8ocOx4fwzper4oVezgcNRciluaBTzsoRiGLHPB4poB1iEkazg2ryhsJYr+DbQMc5YlgBMRiW71xWiz7oQSmGV6Y1i5oKEwSCAKdleR0S+fGMCqaPMuDiOcOP9qkIdrE6o+inxJa9hYM9VIeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=O62pIBpt; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound8-255.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 10 Apr 2025 08:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jgb+J1og7q5a1D/u5UnigBkvrPM/8yn+FQS7DI8u97VLaiUfJ1RDbZjALDGOvTMAQAbd/Z6tCmOffKNSgK4tMJv0rKsXiW3Mld4mLlVOUdSFLYd3iZBUb9Winsl6IVPqhZKVTOG0Axzc4s5Xp/crFyhYGrQvWrQanVzYkqOxVurzP8H1sxkrel1WctdPCktC3LhQUlk/77QJa5SZWQ8sNnxroKhxUO9MalYxPoRk+G5LaLrwq5oLp4QwwVUNy29m/9qQCWBgnwmcOhCH7dW373fdrjZKhuuylbpNxTSaVaDaCPUJuo2w5CrKHvC5NKM8RbjNb/RVrYWxrY6Vu3eqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2Sj4g4PGKrv092L2XwjQY4rpIhdWV1p51LMA0aGKO8=;
 b=PGW0xhczRU04bAFEkNti9hydO/aLdOxC5Q5mXRqF6FE/uc76VGTtSjCAXceU3jy+NSy3wC4raD9eAe7aumwBaoxIURHwz1+Pdd8Yaj1caBtyWd4oZlzPMu4vhnqsmA+jbIYHhcvMrQF8zSfxzVsB0RHlX/nbPH/6gV8YwJpytePTBrs33YEgfp7nUkw3BOjNsqERYF0KrR5K6DzY/kco4oMzB3HcHzjYmq3FjrXpnrlwfmYwaWTHy10zJwjif0mbxtWAH6ugDJzOKYs6JqBOJIno5dIPk+qdDxH1NbFnYRvkoQgnLMWg7sPtoaDKvZSxBIVU2SU8QzEt0825N0y9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2Sj4g4PGKrv092L2XwjQY4rpIhdWV1p51LMA0aGKO8=;
 b=O62pIBptLZx1RDpCcUk8TMmvp/lWPSYAi1OXU0xQe0HIg1QrpIrvxEz0TiM0l4d9Mjp4KkwJtaprVyeoPJlq0+Rns1+aP/GFcytTx771TSuvoxbNw1hISXbefwBhHBE2UYNYc8oE7BuSlLcPrMNGgYO6cGepBBOl/+4IPmxxPY8=
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by DM3PPFEEA59039F.namprd19.prod.outlook.com (2603:10b6:f:fc00::762) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 08:21:09 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 08:21:09 +0000
From: Guang Yuan Wu <gwu@ddn.com>
To: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbqVp0M67N/vLLOUi6vmMAtVcZE7Ob5/IAgACafqM=
Date: Thu, 10 Apr 2025 08:21:08 +0000
Message-ID:
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
References:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
In-Reply-To: <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3187:EE_|DM3PPFEEA59039F:EE_
x-ms-office365-filtering-correlation-id: 1de2a6fb-3cfa-4353-f2a2-08dd7808a5a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QK0OkK8Qcaw0zrcnLIXC8pFCwF1YQfwRwgkaASTiuUTmJkvS3d5zkmry3D?=
 =?iso-8859-1?Q?eDz3JOxZNNL6Ei647jqtFl4aMEDsdSDtFu35Dp+TkqL5WPs76gJt4rexuk?=
 =?iso-8859-1?Q?Ur1eQYlmPHJbHbf5ffkxrocYNo5t3WFpRRyY9pPUlaZdHPbjdqHE/Mnf/S?=
 =?iso-8859-1?Q?C18U6LHUtHvgv3ZOj+Eh8vQEA1HBLJk0n6Hvj1plY3OMamfkd6a5Tk4EWl?=
 =?iso-8859-1?Q?1gtSau1vRuJ4QI1QqIAOHzY6j3dpgNidDGOY3ou0raOgqcVsW6jIa07Wp4?=
 =?iso-8859-1?Q?xUkbT+grJuUvIdKOHX2UfOt+tg8IxZbjQoO7Cd5Yr+ML1IRpiyT1VBB1Fu?=
 =?iso-8859-1?Q?dMV8YZXK/ZoQ7HYaJ3+NBQ6ySPJpDvWl9u+W/RHxg8u3noTI+D4OnIApTm?=
 =?iso-8859-1?Q?nutORh50Ob51Wq0T7TdDRSv3Kqow+5h4+8xmiPM9KDvXL+ppMA8j0vqPgo?=
 =?iso-8859-1?Q?Ug9Car0zNBq0EUnfr63UKRqSVmTVXG7Gg7acuh33MKCsO3pNY/NoHnw8w3?=
 =?iso-8859-1?Q?ukrao8CQb3T/xLOki4KB08TBElzExUgc7nb9rD9OEwZOS28w2rGvpPD5RA?=
 =?iso-8859-1?Q?C8tznhYxdqolPfG6ZZMzsGgofasaOZ8+vkYrRr2L6Y3J2THP13DK8I4hIh?=
 =?iso-8859-1?Q?dH/Ry+YaGhgZWTHeZrFMJlla+OfczhMvxPBiBzqQDF6DwWnkQE6yJwCdQ2?=
 =?iso-8859-1?Q?dNphjR0OeFganSfD/b2Fpf1eUY63wHcYSgbcuJxtrKkk3LHKX0cYTQ4DWE?=
 =?iso-8859-1?Q?aq83q49J60AEWyRHOhGmnXEzLhOxcdWlw3FHgY0LDvtYjh5W7dgWi76zE8?=
 =?iso-8859-1?Q?ihqWnaCXnQ5RTrf1VuSGAdQkA6MDU2/F/YAoOjeNKKyIqLu+ez7LEow7SE?=
 =?iso-8859-1?Q?/aZy4ndlBeWcmbTd4O29fMAHDVpaTLzGDotxoWIK1XrVt4hSb5KzmEpWfM?=
 =?iso-8859-1?Q?nuynb18SGv+SrxDmOopgigOPwVAQa7O/e44BLJTZphB2M11hIeU2Xpsmxj?=
 =?iso-8859-1?Q?/xkelNUMKt0ZlenCyldj9TaVACrBp9zImnRPn4YJmeryC9an5Va15e+e9F?=
 =?iso-8859-1?Q?M6uO/8sIlPevhG2AosTMFla6fLYSt8Vg7gxlqTgAVsVgeS9VhP08YS418s?=
 =?iso-8859-1?Q?f6o7Fh5SM18casfcUpc0eaKj7IBG238DuQx4I0xhQyW7uM17fI4wnFZOEF?=
 =?iso-8859-1?Q?a/TI6JSzfw9bAHBEFnq8X0DM2+dy245fq3BqUwZwcm6wZtVGK7J3NM37tb?=
 =?iso-8859-1?Q?m2WiX3JKRX7b+aHdO1gRydkGtQ0FsKoLNTmDLWgRjS0A7vz79jGaOUBr1I?=
 =?iso-8859-1?Q?IlDiBlsOh22X/4Tm0mJjCxvWGtNGPemc9EDXFIoTdipxw54CBB4L2cuJ3S?=
 =?iso-8859-1?Q?ql+Tes1r26yV9i3Pg3GKVKSOtXwzZ+c4JZLUR0HcVeavHlG8XqJdBF/7Mc?=
 =?iso-8859-1?Q?d1zJveYuP9gSmH7xP33/sy88B36rOeOBwSwuQFhdzdDlLC9DOW9YN4Tryd?=
 =?iso-8859-1?Q?1w+mt/3j3bDHStGGBKiWmx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VwNtK/7sT5MpzOP6180Wo0AgwRhDgq673BANKBdEFEJUN93D2TPm5dsLgy?=
 =?iso-8859-1?Q?97dpu7L/JMFOJeLXM0/ROB6XlUY3eB6EuHcA6OGDvC/jhICYtUwkjQzUc4?=
 =?iso-8859-1?Q?/Su/DiTf4p+kUnPKLT8DydVTMi4lfNGkydbYNKjPtISRZPuwQTslQXb7m6?=
 =?iso-8859-1?Q?pY4ji3EkhXSD5Bh9CNXKoPKr68mywd5RoTaY12k4XxHchI4hGEb47yUgSr?=
 =?iso-8859-1?Q?B4SD2qJ6n68La6i1b2MVexj+hIO7RUcfIxoD+f3unyALz5Jefka7zk8fmU?=
 =?iso-8859-1?Q?SyMqCYRDqXViPOKOhzBW2i4TO3uYid3DvlXk2u2Xbo1BTkqydOMQseNiHp?=
 =?iso-8859-1?Q?a+gGxonSf/Bxkck6ezowRBGUO/6TaML1d42TvOU6Qnlf3r7Um3NAu2H6F4?=
 =?iso-8859-1?Q?mwxPq6NJ4wHU1zWHYfV+OuT7A5GAIMqAteC8BMWMslP3xAqFmq2AhAgEk0?=
 =?iso-8859-1?Q?G9jjxtlL7yX6/YCvBu3QjEM/0LA5qwPxS8lOodt2N6YLdzGQPNXIP2jnqI?=
 =?iso-8859-1?Q?EtEc6y3/CGuZ+gLzl0QH/8NHauHGxPrr3SrfLFjTLNbVSLeB0P/FT9Lxmh?=
 =?iso-8859-1?Q?u0QksGRSsNT4J9lYmKIUPDojRq7hRIs/GdxcnyD6AfZVoo4mc7HfLfoC/0?=
 =?iso-8859-1?Q?qiNR2yMyB1kRkIrjVcGPBS1RqBD+Vuaek0h/lPzC8FqwG4pLWttudA7RPu?=
 =?iso-8859-1?Q?//kePYJXC+pXjfzgZ2nLoIrZu5NfuQRpzyY+Uuwg+IVTMoHgJ36Vqy3A8s?=
 =?iso-8859-1?Q?34vSiI05ABWkE+412e4B1bjQ49rFzaqcDXMXAOBtbbrKVOyF7Xk3wYmc19?=
 =?iso-8859-1?Q?Qo77JiByDTBZ0OFKcaGudlEmkTgIPnvuIKUUehs0J5L/lDHuan4p851c3b?=
 =?iso-8859-1?Q?mBclBV6arQsrDvVZpMoGVh9JDbEJ6u/6CqzHKMtHz4nKIuSnOks50fRJj1?=
 =?iso-8859-1?Q?r6FREvhQfJMjyzbMNLnRrRy8uzatA0tLdjpVl3Muy39zwhd7UW+LKXihrT?=
 =?iso-8859-1?Q?/PbpRjJf+jeQz8q/TG8jEctrjx7OwtfwVbEmHz6qfV5US+K3umtl0X6iXc?=
 =?iso-8859-1?Q?POjM8/Xr9nVjn/zheLTaPcXWC3Da2KHHD+y9//CLsoyl/vDlDa4AXf+H1C?=
 =?iso-8859-1?Q?ZZuLn6xzmEwE7srR0g7NN5gH3CE1h7eJUyW6f6J7ghVLYboOzAtGRvMm9R?=
 =?iso-8859-1?Q?Ijq/la8A7D0iMadEoh3/X6LlVdGKG3BNkvwS+XcaEgjkrRNHFqX+XEdZLM?=
 =?iso-8859-1?Q?HuoI4rHS7QjshZizZ5uS1XieyST/4LhcFYEksP76cwZrwoJNXTuhYnqAGU?=
 =?iso-8859-1?Q?x9YNmqUpGu2VCOxp0Td+XOfJDiu+V6nptoRFzqzJqD+mZ/Md6bti7UxRh0?=
 =?iso-8859-1?Q?tQGUx7eBe6fkizRAT31B39h6hShsqJMYjhWPzBJRRN3G4r9eR/V2DGijHb?=
 =?iso-8859-1?Q?hUOSbIoeYomIridZ9ZEMcxPPFBsFxqZ3z+YBtzuW70Inm8qW8Rx+UaPJ/J?=
 =?iso-8859-1?Q?UUVWWLOxwHZiAiV/YKq2I0dmDYP8ai3XqcczvOQFbelJFrEUf43fm2PNei?=
 =?iso-8859-1?Q?6wUPoVuxnWKh/vasWM5nQTeRGggSKJnwFHIPtouh1lzZTwTP2HNyZ4R7Y1?=
 =?iso-8859-1?Q?TS7hp58v9+7VM=3D?=
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
	/0zQLzFqMUquoS8tZxkE/uFtLrejGP5NSMk/xotP0mImVvHkwZvooUr7N0+lwKZ04OOJuQFPING+3IZ9DghBVox+zFG10Sk3wRr3QCHLNgiK1FHt0m/HdVMmzj7nONhvbZ8QG84mj/lnX+IrmjfHyft3nncLHSy/18Xe5TGZBAlfwYEPeT5EkiTiymy8pb3Dht4Se8CX6Ko3fytCPf+OZhEwyW5PFnKStmHNWc2CSEtSGSfT91m7xHCOKUo8FWzU059EQ/Pas8hpVf5S5heyy2rz6lLYwYWrbXHanI+3oTTrEcp8PzLEF1d3/MQV3NyL7hFmGO4ZeTrJbAd+ysuz8a9oC4qqqTwzar7kJuhkcu/YX7Hn5lfhegE8GajF1+v+wwx07iSfDI2MB4oeRvsyqHX0dkpSLVaymQt255qmXAThV9qbtgb5La35u6z3TR/7hbOPz4lPme+i1eWmLSiSkTHfyqNDz8NP+tONKbuxxQH/fodAiiJnsmSAPudFDXC+4gtR+drNdqcD39laeQdMhpCYdgVECDrNyO9lH7VC+6CtH+77ObVu5d3mzCjcmDzGBeYeVGdHUxTq8kq7nLo/WdK6BCJUS1lAnqlf73mue4KFPzXt5MX0Zwdq8EIPIA396KZK14IKZJ2WWMpETNZq0Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de2a6fb-3cfa-4353-f2a2-08dd7808a5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 08:21:09.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDjV6PpOfMf77QXvCCJiwaGU+2r2smeNORaTb5TBvtiFa/AYunwOC6WcSSO4GIgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEEA59039F
X-BESS-ID: 1744273272-102303-15649-21223-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibmhsZAVgZQ0CjJyCzVyDwlxT
	DNMNUsJSnR0Ng42cTMOCnRwjzJwjxZqTYWADyBQFpBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263782 [from 
	cloudscan17-242.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Bernd,=0A=
I think in such case, although outarg.attr (reply from server) is staled, b=
ut it is still valid attr (pass above fuse_invalid_attr() check).=0A=
set it and then mark it as stale, is for fsnotify_change() consideration af=
ter ->setattr() returns, new attr value may be used and could cause potenti=
al issue if not set it before ->setattr() returns. Sure, the value may be s=
taled and this should be checked by caller.=0A=
=0A=
Later, iattr data will be revalidated from the next ->getattr() call.=0A=
=0A=
I am unclear why FUSE_I_SIZE_UNSTABLE should be checked here, can you provi=
de more detail ? Thanks.=0A=
=0A=
Regards=0A=
Guang Yuan Wu=0A=
=0A=
________________________________________=0A=
From: Bernd Schubert=0A=
Sent: Thursday, April 10, 2025 6:18 AM=0A=
To: Guang Yuan Wu; linux-fsdevel@vger.kernel.org=0A=
Cc: mszeredi@redhat.com=0A=
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from mult=
iple nodes=0A=
=0A=
=0A=
On 4/9/25 16:25, Guang Yuan Wu wrote:=0A=
> =A0fuse: fix race between concurrent setattrs from multiple nodes=0A=
> =0A=
> =A0 =A0 When mounting a user-space filesystem on multiple clients, after=
=0A=
> =A0 =A0 concurrent ->setattr() calls from different node, stale inode att=
ributes=0A=
> =A0 =A0 may be cached in some node.=0A=
> =0A=
> =A0 =A0 This is caused by fuse_setattr() racing with fuse_reverse_inval_i=
node().=0A=
> =0A=
> =A0 =A0 When filesystem server receives setattr request, the client node =
with=0A=
> =A0 =A0 valid iattr cached will be required to update the fuse_inode's at=
tr_version=0A=
> =A0 =A0 and invalidate the cache by fuse_reverse_inval_inode(), and at th=
e next=0A=
> =A0 =A0 call to ->getattr() they will be fetched from user-space.=0A=
> =0A=
> =A0 =A0 The race scenario is:=0A=
> =A0 =A0 =A0 1. client-1 sends setattr (iattr-1) request to server=0A=
> =A0 =A0 =A0 2. client-1 receives the reply from server=0A=
> =A0 =A0 =A0 3. before client-1 updates iattr-1 to the cached attributes b=
y=0A=
> =A0 =A0 =A0 =A0 =A0fuse_change_attributes_common(), server receives anoth=
er setattr=0A=
> =A0 =A0 =A0 =A0 =A0(iattr-2) request from client-2=0A=
> =A0 =A0 =A0 4. server requests client-1 to update the inode attr_version =
and=0A=
> =A0 =A0 =A0 =A0 =A0invalidate the cached iattr, and iattr-1 becomes stale=
d=0A=
> =A0 =A0 =A0 5. client-2 receives the reply from server, and caches iattr-=
2=0A=
> =A0 =A0 =A0 6. continue with step 2, client-1 invokes fuse_change_attribu=
tes_common(),=0A=
> =A0 =A0 =A0 =A0 =A0and caches iattr-1=0A=
> =0A=
> =A0 =A0 The issue has been observed from concurrent of chmod, chown, or t=
runcate,=0A=
> =A0 =A0 which all invoke ->setattr() call.=0A=
> =0A=
> =A0 =A0 The solution is to use fuse_inode's attr_version to check whether=
 the=0A=
> =A0 =A0 attributes have been modified during the setattr request's lifeti=
me. If so,=0A=
> =A0 =A0 mark the attributes as stale after fuse_change_attributes_common(=
).=0A=
> =0A=
> =A0 =A0 Signed-off-by: Guang Yuan Wu <gwu@ddn.com>=0A=
> ---=0A=
> =A0fs/fuse/dir.c | 12 ++++++++++++=0A=
> =A01 file changed, 12 insertions(+)=0A=
> =0A=
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0A=
> index d58f96d1e9a2..df3a6c995dc6 100644=0A=
> --- a/fs/fuse/dir.c=0A=
> +++ b/fs/fuse/dir.c=0A=
> @@ -1889,6 +1889,8 @@ int fuse_do_setattr(struct dentry *dentry, struct i=
attr *attr,=0A=
> =A0 =A0 =A0 =A0 int err;=0A=
> =A0 =A0 =A0 =A0 bool trust_local_cmtime =3D is_wb;=0A=
> =A0 =A0 =A0 =A0 bool fault_blocked =3D false;=0A=
> + =A0 =A0 =A0 bool invalidate_attr =3D false;=0A=
> + =A0 =A0 =A0 u64 attr_version;=0A=
> =0A=
> =A0 =A0 =A0 =A0 if (!fc->default_permissions)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr->ia_valid |=3D ATTR_FORCE;=0A=
> @@ -1973,6 +1975,8 @@ int fuse_do_setattr(struct dentry *dentry, struct i=
attr *attr,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fc->handle_killpriv_v2 && !capable(CA=
P_FSETID))=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inarg.valid |=3D FATTR_KI=
LL_SUIDGID;=0A=
> =A0 =A0 =A0 =A0 }=0A=
> +=0A=
> + =A0 =A0 =A0 attr_version =3D fuse_get_attr_version(fm->fc);=0A=
> =A0 =A0 =A0 =A0 fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);=0A=
> =A0 =A0 =A0 =A0 err =3D fuse_simple_request(fm, &args);=0A=
> =A0 =A0 =A0 =A0 if (err) {=0A=
> @@ -1998,9 +2002,17 @@ int fuse_do_setattr(struct dentry *dentry, struct =
iattr *attr,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: clear I_DIRTY_SYNC? */=0A=
> =A0 =A0 =A0 =A0 }=0A=
> =0A=
> + =A0 =A0 =A0 if ((attr_version !=3D 0 && fi->attr_version > attr_version=
) ||=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state))=
=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 invalidate_attr =3D true;=0A=
> +=0A=
> =A0 =A0 =A0 =A0 fuse_change_attributes_common(inode, &outarg.attr, NULL,=
=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ATTR_TIMEOUT(&outarg),=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fuse_get_cache_mask(inode), 0);=0A=
> +=0A=
> + =A0 =A0 =A0 if (invalidate_attr)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fuse_invalidate_attr(inode);=0A=
=0A=
Thank you, I think the idea is right. Just some questions.=0A=
I wonder if we need to set attributes at all, when just invaliding=0A=
them directly after? fuse_change_attributes_i() is just bailing out then?=
=0A=
Also, do we need to test for FUSE_I_SIZE_UNSTABLE here (truncate related,=
=0A=
I think) or is just testing for the attribute version enough.=0A=
=0A=
> +=0A=
> =A0 =A0 =A0 =A0 oldsize =3D inode->i_size;=0A=
> =A0 =A0 =A0 =A0 /* see the comment in fuse_change_attributes() */=0A=
> =A0 =A0 =A0 =A0 if (!is_wb || is_truncate)=0A=
=0A=
=0A=
Thanks,=0A=
Bernd=0A=
=0A=
=0A=

