Return-Path: <linux-fsdevel+bounces-46139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB084A83405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3718A1F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D596219A9B;
	Wed,  9 Apr 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ofU59D1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18B15855E
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237122; cv=fail; b=n78SrruK3M3v2lqoguRJJLaEjCgSeRTM5WLNj7cbgEEUU5FPMmJ1Rpi1oxQTDLJOu7hgJsGHc42xH8n3XhppVpSmJi/QVd/VS483QkoEnJSl3TB9Z1/AfQxG0ewDnp3BcBeyR2VaQo5x3oeX+SOWKQFogbM86GozKvdHFDylInA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237122; c=relaxed/simple;
	bh=mpM0PmhaxcdXt79KU04Enjs7R8TJcADO1fIBnwsSkF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qs+uUKx0ToS7mwkvX135SK7EteaAv9V3B7+jmBtkvE4Vf/RduH5EzKFLaYIWSrOOzi8BypxQWdB+zvFD/+TgxccV9bZrYl9l+KXDUFwRESWZnr1cjaD/LCiB7LV+p1WGqFwnNH/8L/A3R5yvctu+Tn2ezuBzJ8n13Tod6WvKzq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ofU59D1N; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43]) by mx-outbound-ea41-28.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 09 Apr 2025 22:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrYjwjMXqG1PKdWLnt5XKR8IzPlQ4b/PyIn3Kpq6eoB7h/2/NMuTYt3+bH8zOP5+s1H5o7zO6dQJTDYmVtfl3HUuP8HgPSgzUUCpIeUwk8oInKCAKdsyYlgXTFzJ6yY0I59S3yOwhgWUvDc/pg7nIpD4iAQbLy+EVtyyalgpfssLwp4EO8drElED0C/A0k9QXZlz+n7jqn7pzxX0KCor9/md8uiBYtQpW/DvcwtcRxYSqyAAwROJbc6N/3g+R57dBTHxXKeDYDr6m+crhiSrjYDoYQHZGm1F7uIO7B87Ub8Hl5nQGZD9pMcguFTJB407qYd1Xi27qTagZQkwZdzTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpM0PmhaxcdXt79KU04Enjs7R8TJcADO1fIBnwsSkF8=;
 b=nU6kxbbz2qU+VYNPQiHm42fLm7sJjek0JUNgxKpvzvmUs9dxvjWA/1bX1tQOXgK2vvuYoGV1heFP+i/+wmYEUZ0XeBx6CYenu1gsoc4L9BBaHIDOxi8b+3DZZItmjhhuGeTlkEzsKE+oKRxZ7kDgu0ziwbyxQYY47iRpnwIxMsd0+VDwss9dxNx5xyNLZzTxgTv51qDPyEc1VNngaLQIf77PygZUEWZM9AGnoQdRg/Wyzo0gLCzqX0+F3cxKg+9xqgo84FdFUOxWYFYjxauukz7+z3067Tq+auWV82ZnFFoU2WhsiU5iavgAt2mpHOAjclniyujAHlq9Ur/u0c5U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpM0PmhaxcdXt79KU04Enjs7R8TJcADO1fIBnwsSkF8=;
 b=ofU59D1N5LC+Pq9inl9V79ryylXghPzsUTi4y0V9Te6dPKssQa4irf8CxjcnYxZOhowQnDsdTwzUicfcx2GeKufJTtKMZLM60sf2dTxrgsnT4dcm2pWg6XG3n7cksu7xXAZNDXL9Vn9z1JC4ccin/7v+QxeBugl92/VPKopJQ94=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CO1PR19MB5109.namprd19.prod.outlook.com (2603:10b6:303:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 22:18:33 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8606.028; Wed, 9 Apr 2025
 22:18:32 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Guang Yuan Wu <gwu@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbqVp0M67N/vLLOUi6vmMAtVcZE7Ob5/IA
Date: Wed, 9 Apr 2025 22:18:32 +0000
Message-ID: <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
References:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
In-Reply-To:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CO1PR19MB5109:EE_
x-ms-office365-filtering-correlation-id: c4c5fda2-9e8d-4588-8808-08dd77b476e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzI3d21XMnVvdWdhY1JqQzBzOHo5Mko4bDdOeGVaSFdxOUFidVBmV2VuZXZo?=
 =?utf-8?B?cTBGRlh6S3hVWVhxdnFOZk9iSTRuN0VSUTNEcGFSbTg4VjdTbnNldCtmdlhQ?=
 =?utf-8?B?RWRBS2U2STh3dmpTN0RVV1UxWldVQWx2aW9CRE40YVFRZGVxWDNVNHNqTWxU?=
 =?utf-8?B?MVpLT3UrcmFJQm1kUWErVGVKbmovUlRqZ04xald3eldUVVFGVjVzMnlheVh3?=
 =?utf-8?B?Y1FsU0ZHOTdYeUNxTi9OV01GYUh0QzFTN1MxdE9zZWpnbVpBQTAvQzBVVjVU?=
 =?utf-8?B?dzJGNWVBeFA2Z0lXS29HZEk4THcvOXpVdTh0L1dFTW83QlFyY0lkVENCM3Vr?=
 =?utf-8?B?Y3plaVJuZEFZRWRjSkpEcW5SKzlIbDdZRi9jbll6KzlraVlROWZIUkdvTVB1?=
 =?utf-8?B?ZjZaRlJTbjV6OW5DMGVncytadXRndmwyNHpkaTNLRkNhbGFPcDNoZ1hFblM3?=
 =?utf-8?B?SVYzSEFtQnlNc1dMNEZDaHVTVlg3NldZM09EWTdrUGo0OWFocjFacUw0TXRF?=
 =?utf-8?B?RHdIN0pTeXFYOGRrTkRBbjZ6LytYWFpUNU8xRFZvSk9ic1dHb296Yk1LMDg4?=
 =?utf-8?B?akFQdzZvSEFXUE45NU42OVY4VTRIeUpCZWNsMElkLzlOd2tGMTNwNzBoOGN6?=
 =?utf-8?B?NTg0TXQ2QVl3MCtiZC9zUGJ3SzllN2p2MnRzZndBZmhVamxWZGRqQ3RYSmhP?=
 =?utf-8?B?blhnN2U2K1RXYWpWTXBwL3ZPbTNXYXVJRHBaaGsrSHZEQnVoUUx5cmZpMTBp?=
 =?utf-8?B?R3NtMmVOZVA3RjI0RjFVYVlaUDQ2MUM0SDlRY3N6c2VWQnNUTzkyMjdqRkpk?=
 =?utf-8?B?WHY5Q1JzRE9yc3kxRW95RVVZcWMvbHNWMUN5R0xoRWpwdi84K0tMSmIrcDF6?=
 =?utf-8?B?T2U4TGQ2SzliNHFHWVBqZlNleWlTRkNMRGtNemdEaEEybHlHRHU1K3RZSVVS?=
 =?utf-8?B?UjQ3SUhrcTFOQlJYYkF6OGpRVllJcGFGRWhMbnVnRmViZG9rbTRYZWpHRDBw?=
 =?utf-8?B?VGR3ODBxY0JZNzlxVFVaTWZ3MjFSWHlUOC92MjE5cHRjS1Iwa2pHdDZJUXRk?=
 =?utf-8?B?c0l5anY1bmVxK2s2SGM3bG5aTDU0TXVmaW4wS3Q1Z0lGY0h1OFNTaHAyOXJX?=
 =?utf-8?B?bzZZMG1ZaDA5cDZyNDB1RWdmbGprUWwzTElPeWVDdG8vTVFrbUtFTTRJazlw?=
 =?utf-8?B?M09tWEkwTGlQNVpxNjdtNTZkQXlyR0JwY1B3RWlKeHpWK0FhbTRMbDZKSWMz?=
 =?utf-8?B?YUdKTmpJY2dRQmdSZGxuc0lmTGJGQlNnQ0JyejEvWmhDSFVXaG91UUFFL1NF?=
 =?utf-8?B?MmhaZm1IYnNMVUFOdFF5R3lKaVpOOFZ4NVAzSjQxKzdZTEo1OTZHbzhWZEpl?=
 =?utf-8?B?KzVrVEVrZmtVekptUmFIWjZVVWlaM04vUkxCQ2xiOFlrd0wrTHZvOTUvc2JO?=
 =?utf-8?B?Wkl4MFZBVUp3aEFLamF0WW1EMU15aXNSSXI2dkd2Ti9wVlFpMFhYYS9FRHFN?=
 =?utf-8?B?WG03RG5zejh0V0o3dDMzSTFWVUdOVmJFL0UwVDRYNDRxOU43WVFGdjVDc3Rp?=
 =?utf-8?B?bVhUV2lTQk01MERYTXJaSWRQU1g2akFaTEUrK0Z0YkpSNGVJcVJLbUtKUVcv?=
 =?utf-8?B?N29QM1Zncm01MkpIeHlEQ1dNbDZ5elRBdjVVSnpyZW1jcDRZTllMclluODdW?=
 =?utf-8?B?YVFQUzBCNFdqRUppamJQWEdqT29RT3hjb0lYc0FCQ1FDaTlCZjUrbXY1ZHhE?=
 =?utf-8?B?bHJkWmhWamh3azZtZUxpRm16bUl2UkEySEN6SDJycm1VT0pQbmhBZkdXeHgz?=
 =?utf-8?B?TTRqQ3BtUkxGZFRCUENoQkx1dDgra0htTno2U0RQTGdzUTR0RVo2WUR5RERZ?=
 =?utf-8?B?aitpOEw3NzU3cWxSa3V0TzZnUHJmbjZNWktjM3RjMUNJSHRTazQ3N0gzRENH?=
 =?utf-8?Q?6rs2RtITV/D1/49hpLHTmJtMcur0k+9Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmdiTlI5V3BXbm9qNkllaTdmaTRsQ29wb1RvVmlvNE0yNHpPZW8vdVRkQnpu?=
 =?utf-8?B?YlZmNzducUhVbjZMaC9GYzBwd05tdUl1L2FreFl4M3pwQm4wVDJSUzRlYUZ6?=
 =?utf-8?B?bEpWbGNzMXNucFROc0F6ak0xVFlNdjVadFNJNVZ6Z2ZPcE9Lai9VREZWVm52?=
 =?utf-8?B?Sm03MmV5N2R6bEZDUEphS3FiM0RnVDNJQ2kzSXIxNUk3NGVGQW10Um52ODI3?=
 =?utf-8?B?ajF2MGgzeEhYaFRqK2psVkszZU9SL2dBdTNFWDBNQmxVK3E1R3RvdXBZSng5?=
 =?utf-8?B?dW9RdU90YVR5a2I1Y3dRbmdkR1NManRUTzR1UkhmVHhkeUFjRFI1ZStoNU5J?=
 =?utf-8?B?MkFPUVBRYlpQSTdKSDArS1JIYTBzd09yVXV4K3kwUXFrZzl5Y3NuZG41S2o1?=
 =?utf-8?B?WEZLNndmUm1KK3Q0OFZTM1dEdTlpUG1FY1dqN0dwcnRjdzNJMnpXVE43ZUFo?=
 =?utf-8?B?b2RMdmZVdlFDMGRMQ1VHSGRoa3ZsRC9wTEkzcGpGandGZ3ZVUGhaYzZSeEZs?=
 =?utf-8?B?YVNGT0R2cm1TbmxvMnBMWE9qSjlhZ25LY2UrdHNiU1U5RHBQWFdITXorenkw?=
 =?utf-8?B?TzVGeU1hOEx2YXQxL1pvUm5rdWMwV1h5SXBNU1llQ1BuRjdvSzVFNGkvNXV0?=
 =?utf-8?B?QkY5UDc4QkpXcUxKY2dDOUtMQjlEbVJiZVI5bTFxT3ZyenNTaDdma0ZhVlZ6?=
 =?utf-8?B?aFNkbStlVjZ3aHN5NFAwYVN1aU5jNmdoTHUrQTRSTUJhVTVxTW1UTU5jUkN5?=
 =?utf-8?B?UUpZTHl5TkJyRUVSOW40ZWgrdlVTQ0hBcmQ5V3AwQWY0YlFobTlkNW5JZVhU?=
 =?utf-8?B?YXY4MDZBbGlrbkFSWi9EekFZR1pLNEJibVFXb3VWRkFodjVyR2Zoa3N5OXlG?=
 =?utf-8?B?eEdsRlZGL3dKZWJ3Mk1oeVYzQlg1SzFiNG1kRFpyTEs0YkRiVXdCdERuSDBr?=
 =?utf-8?B?aUJ3b1F5dzFZQjRNNjJXVzF5VTE4aXhUSGh0RDl0WHNva2JQc2ZYSUxJcXF0?=
 =?utf-8?B?RFd5cTZzQ2NqVUhoQWhBMzZVN2VraTRxQTYzR1Y3Uk1PR1BFNjluRk1Ha25J?=
 =?utf-8?B?aFg0eHdBUlNKdDVick5mZmxRbEJ3YWM1WEdtVFk3cTJXMlJRcUxRcVNOd0hQ?=
 =?utf-8?B?WFhEN3FzV1ZTeG5ORTRtUG5Md3l5aVBnODRwT3JUZVcrTkI4ZXZ2WHV6RERN?=
 =?utf-8?B?NzhkQkdPaVF0NE1Ddy9yZkhlTzFjRW14WEhsM2hEKzlqcE9Ed1pZL3NFMy9r?=
 =?utf-8?B?QmdQb1lxditndUtGVFJGaExoSmNOQ2toNkpiOWpQWVpTSEN3ZU12S3lFZEl5?=
 =?utf-8?B?TDVjUVFmbCtUaEpibnRnRDREWHlwWlVkYS9ZQU1wSGZqdnkwTmZLNEtxRElT?=
 =?utf-8?B?Z2pmREdGSFlaM1JhbEgyRi93UVBXbWZTZFVYYUNFUjNtcmVmYWliVUFYZE5E?=
 =?utf-8?B?aG9sc1pRNG1kanNVSjZEZnY2aFZUa1JVdE9WaWY2SmVpK3MrbStPOTVYd21M?=
 =?utf-8?B?U3A1OGJWU0d5SEErZUZHeGxBY1RqMk9UL3VPODNsUUF0TVh4TURrcmNWSGtW?=
 =?utf-8?B?Z0RRd2RPK3dVU0s2bWxyWlowRWx5ZjEvMXFoUklCM011cEtBUTZIUVo2TkFu?=
 =?utf-8?B?L2pzN05IOWxnbDBWRHRMcjVPSTRLTDhCR0lYNWJhWStka1BidFBJRWMzWlVP?=
 =?utf-8?B?YTBnaXVzTkcyejR0NktFSk1MbkNnVTZldEkwdXB0TlNQN2xXa3hGaEJNQ1Bt?=
 =?utf-8?B?R1FQMWZRVnBRNVcrTjc0SStRYlVWV08zLzl1RXJnZnR5ak5ZWnVCSGlDQXpG?=
 =?utf-8?B?TkV6L1N0MHFnOVlFQkZSTDlhdlJwOEpqclhmdmxSRmZaVFFJM0RLVkZzaXpY?=
 =?utf-8?B?Y1czT3lZdVR6OEtOS01ESDNES1dRVitEMzFHY0hLVGZqTmtSQXNjMWUxdC8z?=
 =?utf-8?B?bFl6NEQ0Rll4REcyOThSSWFuT1lyQTdVeERNaDJLV1AvM2xCNGlWMVpmU2pB?=
 =?utf-8?B?R1pWSHI4RzdXMU1CMWlNWUw2Vm9vTHhYZFZrNzJEazJLUjVPRUpIZDJBOUwr?=
 =?utf-8?B?VUVOUDF1SkNpWGtyOHJiU3lZNStFcDZ6WHc0WVduTDFFcEZ5ZGsrVWE5djNR?=
 =?utf-8?B?ZUlJMjRHV0s3MTJzWDJ5eGhrYTZDM3lRcStqNml0ZWswRWdGZ3BiK2QvUWE3?=
 =?utf-8?Q?jaCKalgQ98nZlzkBS6AsAaM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BAC1E5F1DBF7B4A95A0B28D5B7F4198@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5qjaCwQNdjaDRXTXRcRiMWkKtYVZhXI76OdVfkZpihLu5Hm9enP49a2c8j9I6v6+IQbN60vLwNgEQAJEBJcHEnkqaJcjs2Kk4w7gINMekPoJY4sr/Rq8ji78wihzmupwBHVLWTSbGrCIbKmnuc8esFE7wXirlBzgdDJyiUZ10JqjntL0Hwrt98dU1Yx5vy0dNTZEb/Ouz6kU/TeaY4ueV2EaV1CWqLM2M0dMrSTD47nFjjc1OczCspLYtCW2koqXbTC12HRW/vI9aId8RI8rA+8h/mddWvrZl0PG8TkhKIX04pJAInvCAW5MLvlOP6cAvZidTE/f5z8lvTrnHfZtufRsS9HwpS+QkffumLawcU8YD9fdLG2AOGImmRJbEm16KejGuxYYJZzfjQ5nMEx1l910WQmRx5A1Y+kprUjh6MyMEGRK7DVVEltSFIYmQlOHC5QUJ/nr8CXYD5QHe2wm6Bhhl59UVNM/fLo61Sn5P450xDFQqoF3feW+TUiaKsG4q9/rgm49EDMAYSYJTCoBJj8p+acpNtwFm/6cFClQpNBepu/dvHEVbvUB6v2nNvrQMv3wCEOTIc/wR5fp7PrAoy1eXuZf14qp9JjMWSlqaL5p5D7+R7eAlyD3R3yXc4EWEMsNs9ZEp4mBw7zMqvr46g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5fda2-9e8d-4588-8808-08dd77b476e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 22:18:32.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4bN6A2YvR42FhW+k+RvZsKtZMej6F5psEXQWZCTDHud9jASP0G5oXGLDMeVG2nMU5OGhS3yZLkMfP0NS0ReRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5109
X-BESS-ID: 1744237117-110524-15800-31862-1
X-BESS-VER: 2019.3_20250402.1543
X-BESS-Apparent-Source-IP: 104.47.74.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGZmZAVgZQMCnFMNnIMDU1yc
	IgySjF3Nw4LdUy2dTUwiLJxNgkOSVNqTYWAGDoMEFBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263773 [from 
	cloudscan20-48.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status:1

T24gNC85LzI1IDE2OjI1LCBHdWFuZyBZdWFuIFd1IHdyb3RlOg0KPiDCoGZ1c2U6IGZpeCByYWNl
IGJldHdlZW4gY29uY3VycmVudCBzZXRhdHRycyBmcm9tIG11bHRpcGxlIG5vZGVzDQo+IA0KPiDC
oCDCoCBXaGVuIG1vdW50aW5nIGEgdXNlci1zcGFjZSBmaWxlc3lzdGVtIG9uIG11bHRpcGxlIGNs
aWVudHMsIGFmdGVyDQo+IMKgIMKgIGNvbmN1cnJlbnQgLT5zZXRhdHRyKCkgY2FsbHMgZnJvbSBk
aWZmZXJlbnQgbm9kZSwgc3RhbGUgaW5vZGUgYXR0cmlidXRlcw0KPiDCoCDCoCBtYXkgYmUgY2Fj
aGVkIGluIHNvbWUgbm9kZS4NCj4gDQo+IMKgIMKgIFRoaXMgaXMgY2F1c2VkIGJ5IGZ1c2Vfc2V0
YXR0cigpIHJhY2luZyB3aXRoIGZ1c2VfcmV2ZXJzZV9pbnZhbF9pbm9kZSgpLg0KPiANCj4gwqAg
wqAgV2hlbiBmaWxlc3lzdGVtIHNlcnZlciByZWNlaXZlcyBzZXRhdHRyIHJlcXVlc3QsIHRoZSBj
bGllbnQgbm9kZSB3aXRoDQo+IMKgIMKgIHZhbGlkIGlhdHRyIGNhY2hlZCB3aWxsIGJlIHJlcXVp
cmVkIHRvIHVwZGF0ZSB0aGUgZnVzZV9pbm9kZSdzIGF0dHJfdmVyc2lvbg0KPiDCoCDCoCBhbmQg
aW52YWxpZGF0ZSB0aGUgY2FjaGUgYnkgZnVzZV9yZXZlcnNlX2ludmFsX2lub2RlKCksIGFuZCBh
dCB0aGUgbmV4dA0KPiDCoCDCoCBjYWxsIHRvIC0+Z2V0YXR0cigpIHRoZXkgd2lsbCBiZSBmZXRj
aGVkIGZyb20gdXNlci1zcGFjZS4NCj4gDQo+IMKgIMKgIFRoZSByYWNlIHNjZW5hcmlvIGlzOg0K
PiDCoCDCoCDCoCAxLiBjbGllbnQtMSBzZW5kcyBzZXRhdHRyIChpYXR0ci0xKSByZXF1ZXN0IHRv
IHNlcnZlcg0KPiDCoCDCoCDCoCAyLiBjbGllbnQtMSByZWNlaXZlcyB0aGUgcmVwbHkgZnJvbSBz
ZXJ2ZXINCj4gwqAgwqAgwqAgMy4gYmVmb3JlIGNsaWVudC0xIHVwZGF0ZXMgaWF0dHItMSB0byB0
aGUgY2FjaGVkIGF0dHJpYnV0ZXMgYnkNCj4gwqAgwqAgwqAgwqAgwqBmdXNlX2NoYW5nZV9hdHRy
aWJ1dGVzX2NvbW1vbigpLCBzZXJ2ZXIgcmVjZWl2ZXMgYW5vdGhlciBzZXRhdHRyDQo+IMKgIMKg
IMKgIMKgIMKgKGlhdHRyLTIpIHJlcXVlc3QgZnJvbSBjbGllbnQtMg0KPiDCoCDCoCDCoCA0LiBz
ZXJ2ZXIgcmVxdWVzdHMgY2xpZW50LTEgdG8gdXBkYXRlIHRoZSBpbm9kZSBhdHRyX3ZlcnNpb24g
YW5kDQo+IMKgIMKgIMKgIMKgIMKgaW52YWxpZGF0ZSB0aGUgY2FjaGVkIGlhdHRyLCBhbmQgaWF0
dHItMSBiZWNvbWVzIHN0YWxlZA0KPiDCoCDCoCDCoCA1LiBjbGllbnQtMiByZWNlaXZlcyB0aGUg
cmVwbHkgZnJvbSBzZXJ2ZXIsIGFuZCBjYWNoZXMgaWF0dHItMg0KPiDCoCDCoCDCoCA2LiBjb250
aW51ZSB3aXRoIHN0ZXAgMiwgY2xpZW50LTEgaW52b2tlcyBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVz
X2NvbW1vbigpLA0KPiDCoCDCoCDCoCDCoCDCoGFuZCBjYWNoZXMgaWF0dHItMQ0KPiANCj4gwqAg
wqAgVGhlIGlzc3VlIGhhcyBiZWVuIG9ic2VydmVkIGZyb20gY29uY3VycmVudCBvZiBjaG1vZCwg
Y2hvd24sIG9yIHRydW5jYXRlLA0KPiDCoCDCoCB3aGljaCBhbGwgaW52b2tlIC0+c2V0YXR0cigp
IGNhbGwuDQo+IA0KPiDCoCDCoCBUaGUgc29sdXRpb24gaXMgdG8gdXNlIGZ1c2VfaW5vZGUncyBh
dHRyX3ZlcnNpb24gdG8gY2hlY2sgd2hldGhlciB0aGUNCj4gwqAgwqAgYXR0cmlidXRlcyBoYXZl
IGJlZW4gbW9kaWZpZWQgZHVyaW5nIHRoZSBzZXRhdHRyIHJlcXVlc3QncyBsaWZldGltZS4gSWYg
c28sDQo+IMKgIMKgIG1hcmsgdGhlIGF0dHJpYnV0ZXMgYXMgc3RhbGUgYWZ0ZXIgZnVzZV9jaGFu
Z2VfYXR0cmlidXRlc19jb21tb24oKS4NCj4gDQo+IMKgIMKgIFNpZ25lZC1vZmYtYnk6IEd1YW5n
IFl1YW4gV3UgPGd3dUBkZG4uY29tPg0KPiAtLS0NCj4gwqBmcy9mdXNlL2Rpci5jIHwgMTIgKysr
KysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9mcy9mdXNlL2Rpci5jIGIvZnMvZnVzZS9kaXIuYw0KPiBpbmRleCBkNThmOTZk
MWU5YTIuLmRmM2E2Yzk5NWRjNiAxMDA2NDQNCj4gLS0tIGEvZnMvZnVzZS9kaXIuYw0KPiArKysg
Yi9mcy9mdXNlL2Rpci5jDQo+IEBAIC0xODg5LDYgKzE4ODksOCBAQCBpbnQgZnVzZV9kb19zZXRh
dHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGlhdHRyICphdHRyLA0KPiDCoCDCoCDC
oCDCoCBpbnQgZXJyOw0KPiDCoCDCoCDCoCDCoCBib29sIHRydXN0X2xvY2FsX2NtdGltZSA9IGlz
X3diOw0KPiDCoCDCoCDCoCDCoCBib29sIGZhdWx0X2Jsb2NrZWQgPSBmYWxzZTsNCj4gKyDCoCDC
oCDCoCBib29sIGludmFsaWRhdGVfYXR0ciA9IGZhbHNlOw0KPiArIMKgIMKgIMKgIHU2NCBhdHRy
X3ZlcnNpb247DQo+IA0KPiDCoCDCoCDCoCDCoCBpZiAoIWZjLT5kZWZhdWx0X3Blcm1pc3Npb25z
KQ0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhdHRyLT5pYV92YWxpZCB8PSBBVFRSX0ZPUkNF
Ow0KPiBAQCAtMTk3Myw2ICsxOTc1LDggQEAgaW50IGZ1c2VfZG9fc2V0YXR0cihzdHJ1Y3QgZGVu
dHJ5ICpkZW50cnksIHN0cnVjdCBpYXR0ciAqYXR0ciwNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaWYgKGZjLT5oYW5kbGVfa2lsbHByaXZfdjIgJiYgIWNhcGFibGUoQ0FQX0ZTRVRJRCkpDQo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGluYXJnLnZhbGlkIHw9IEZBVFRS
X0tJTExfU1VJREdJRDsNCj4gwqAgwqAgwqAgwqAgfQ0KPiArDQo+ICsgwqAgwqAgwqAgYXR0cl92
ZXJzaW9uID0gZnVzZV9nZXRfYXR0cl92ZXJzaW9uKGZtLT5mYyk7DQo+IMKgIMKgIMKgIMKgIGZ1
c2Vfc2V0YXR0cl9maWxsKGZjLCAmYXJncywgaW5vZGUsICZpbmFyZywgJm91dGFyZyk7DQo+IMKg
IMKgIMKgIMKgIGVyciA9IGZ1c2Vfc2ltcGxlX3JlcXVlc3QoZm0sICZhcmdzKTsNCj4gwqAgwqAg
wqAgwqAgaWYgKGVycikgew0KPiBAQCAtMTk5OCw5ICsyMDAyLDE3IEBAIGludCBmdXNlX2RvX3Nl
dGF0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIsDQo+IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIEZJWE1FOiBjbGVhciBJX0RJUlRZX1NZTkM/ICovDQo+IMKg
IMKgIMKgIMKgIH0NCj4gDQo+ICsgwqAgwqAgwqAgaWYgKChhdHRyX3ZlcnNpb24gIT0gMCAmJiBm
aS0+YXR0cl92ZXJzaW9uID4gYXR0cl92ZXJzaW9uKSB8fA0KPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHRlc3RfYml0KEZVU0VfSV9TSVpFX1VOU1RBQkxFLCAmZmktPnN0YXRlKSkNCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpbnZhbGlkYXRlX2F0dHIgPSB0cnVlOw0KPiArDQo+IMKgIMKgIMKg
IMKgIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKGlub2RlLCAmb3V0YXJnLmF0dHIsIE5V
TEwsDQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIEFUVFJfVElNRU9VVCgmb3V0YXJnKSwNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnVzZV9nZXRfY2FjaGVfbWFzayhpbm9k
ZSksIDApOw0KPiArDQo+ICsgwqAgwqAgwqAgaWYgKGludmFsaWRhdGVfYXR0cikNCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBmdXNlX2ludmFsaWRhdGVfYXR0cihpbm9kZSk7DQoNClRoYW5rIHlv
dSwgSSB0aGluayB0aGUgaWRlYSBpcyByaWdodC4gSnVzdCBzb21lIHF1ZXN0aW9ucy4NCkkgd29u
ZGVyIGlmIHdlIG5lZWQgdG8gc2V0IGF0dHJpYnV0ZXMgYXQgYWxsLCB3aGVuIGp1c3QgaW52YWxp
ZGluZw0KdGhlbSBkaXJlY3RseSBhZnRlcj8gZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19pKCkgaXMg
anVzdCBiYWlsaW5nIG91dCB0aGVuPw0KQWxzbywgZG8gd2UgbmVlZCB0byB0ZXN0IGZvciBGVVNF
X0lfU0laRV9VTlNUQUJMRSBoZXJlICh0cnVuY2F0ZSByZWxhdGVkLA0KSSB0aGluaykgb3IgaXMg
anVzdCB0ZXN0aW5nIGZvciB0aGUgYXR0cmlidXRlIHZlcnNpb24gZW5vdWdoLg0KDQo+ICsNCj4g
wqAgwqAgwqAgwqAgb2xkc2l6ZSA9IGlub2RlLT5pX3NpemU7DQo+IMKgIMKgIMKgIMKgIC8qIHNl
ZSB0aGUgY29tbWVudCBpbiBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzKCkgKi8NCj4gwqAgwqAgwqAg
wqAgaWYgKCFpc193YiB8fCBpc190cnVuY2F0ZSkNCg0KDQpUaGFua3MsDQpCZXJuZA0K

