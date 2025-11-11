Return-Path: <linux-fsdevel+bounces-67783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F16C49E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D038F3A7F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A423504B;
	Tue, 11 Nov 2025 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="enqwR40x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A07227E83
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821286; cv=fail; b=TWRcfU3YIe40DqdEgw7hUaTE2PnT/qGvICYQiA458rxy3J7NaqVc2SUeJyu4pASYsDm1thqNetwf2BFtrEd27gTsBL3SG3YZG28GOber7VsKPaagAz3TaF2LuGTdOPa+icApu6+k7sIzX4ULf9fOsI+l9zjUoP03o6/CFPELoy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821286; c=relaxed/simple;
	bh=LAfGhvbiIXhwkdWufaWsnkIaBFCWK7QbDqNS6sgKjY8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=dTkLcPS4VOKKkVxTS7aQ55t+aLinGt1CGEdORaUQ0RKBQHUaQp3RPom6/41jiVdYstubcAYGXrmEmZ9c7nb0DyJYiCbM726WAM+2HUdFC/CmHWQdC0x40wum7DHPrK3CDBhVKfJq3moZLYyi0NHA/vgt1hj0ftoY14nXdq+z/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=enqwR40x; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAENRV6017488
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xAlmuBuIZQMgYEXLCmopKVYgxjhCxTkTdcZ4xfIOHVc=; b=enqwR40x
	yCu2fQ7JoTnUxbEcxpJoSi2fbJqpytEPP6caVO9U3vXdopDihhpXlSFdrARWE+s0
	H1OSF1S3Kr3nKCla5VlyqGDBZe+uKqfHG4l/TvcNyGNCBcwRLfyHCj+m/VGYesXp
	Kn/LTgOFyTE6lHm+asP19Zz2kYaJwGjsuggeo80F6U2uA6cHYUhsQtsjpmFGq7Ch
	v/+4Aa9UEfCNPOn19c2Qa52Lnje8Z8bjgj5uZ8aghQzsDE16qhaNfFslzkyBTrZj
	tD7Z1C/VMJJuKUyF4ih8SRiogfIOf2Oc638eJvzhf08vJK83bAT8dt/C5kCtB1eQ
	SuG/Qx1c8AFeQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk82q06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:34:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AB0YhmE008314
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:34:43 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk82pyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 00:34:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMzfd9HUcgdnyR71jS9K0BHSNGxPMQIGexrMBQTW/jYtEIQvMGhMYXp53QJ4smOvpwpGjW4rY3jvi289r52T+l1i65p1OmMn1WNgtbiYc9Knzaf98POAt2lS8QsaYFEGMwAxSOyCNDi9DObkEoWzaJ1Dc3XU6C3srAQD4/loCrUpZ6z066Lqwt2dLqH47656JHm7WpdyxYpQWqM34QdjY5XXJTh5b0tD7Mr9vFVvj+znB/MJzrm/bqeSbIRn5Y//aczu3SiY3MBac7JREdV4XEFjLLmk4T9Rn2hF+uVJmEL0YToWIKs6zDMlJvys8sn9NJ4IXqlNl5ORY/7QJGs++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYwcMIK8uYzvuFXh1DGhG8hzwDqmsmJrLPZkpiqcSfQ=;
 b=wB6mpeAwDUjZ9gXBiWAj4r5e5ta07QC5vSjD/2+vYnoFkHWZDC19zy25YqF6Cg/57/JPrwcAtfJLJmzE1GRqlLDL5yWavy+0ecxXnIV+lZgOyZj5kHq68Ektbnj8Wjorg/jxMuh+y8diXytDMAsg9w931NB/o/0yE3iViAFffWZTRA+sH9DcHtAdvlSN0/uesYTmtprZdO7csaRw0ay25HCjgHpdi4E5MCf+74NikFLzsaQqr81j/Ao2qSlx0nGMJMlXHE6hrI/IIAOwblfISrK726SowZhMb+YvnUpmP66DRdW0/w0PRz4bzyEMaDjc1l/3zZfhtaV9Wqr485jjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6428.namprd15.prod.outlook.com (2603:10b6:610:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Tue, 11 Nov
 2025 00:34:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:34:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] hfs: Update sanity check of the
 root record
Thread-Index: AQHcUpZLAPwxcKLosUu6MBLxDDnp+7Tsj/2AgAANkACAAAMzgA==
Date: Tue, 11 Nov 2025 00:34:40 +0000
Message-ID: <8cad54909f0597b4d9d204a97e8174ad1564ab97.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-4-contact@gvernon.com>
	 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
	 <aRJvXWcwkUeal7DO@Bertha>
	 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
	 <aRKB8C2f1Auy0ccA@Bertha>
In-Reply-To: <aRKB8C2f1Auy0ccA@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6428:EE_
x-ms-office365-filtering-correlation-id: 871d8ecf-79e8-4ad5-177f-08de20ba19cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzBNcTJpcEx1RHlOc3YvalBvM3pERDA4THp1VHZUYVNVckJPRWhWM2kzNkxF?=
 =?utf-8?B?V3RXZ2k5Q2xKMCs3MkErb2E2MjFBNXpuYWFuZEt2SHBUdHJCT3NKZ1M1dzRw?=
 =?utf-8?B?OFdQdmJuSkhGRmIzdDFNZDJweUxuOFVicCtaRlk3OE0yYWZoa0Z4ZWV4eXNz?=
 =?utf-8?B?UXg2U2JrSG43ZEhFSUxFNkZqYXhDTExZWGcyanVqNnhlenl4YUFPbkJIaDBZ?=
 =?utf-8?B?c0VFU0VqallhUDhTS2hkdVFaUGxGclBkbUpCSkhaNnlXVW9rQUVxbk5YMUR1?=
 =?utf-8?B?VWpSdXVuZFBxeEdKY3NQWWdiVWo0YUdSV0E0MmVkS3Bwa1ltemRwWHJ0WUo5?=
 =?utf-8?B?aUpkdXIzQ05mSnZ4RFZqcmFSQXpsZ1ZaM1J0QzY4UmdSWXNBZm0xUWg5WmUv?=
 =?utf-8?B?QU1RSmhqR0l2cDNYaXJHbVZWcFhrQkRpeVZYa1luK1BUNnNpUGk1dk5Nd25B?=
 =?utf-8?B?VGZYVG16aWtRWVJ0Uk84MjQ1QzhqUVN0WERjMHhUMXJyOStHQ1p4SW1WRGx2?=
 =?utf-8?B?WE84bTFhblJiR2lzS3lVOEVySC91QUZ1ZU5DbTZUOVJnS1FxNThDY1UzVG00?=
 =?utf-8?B?R2MyTmF3MnF4Sm04UEptcVNFWkdvcGRBc2dPeXN6OXNYVlUrbnl4ZFUzdXFP?=
 =?utf-8?B?ZEdGSWc4NDVzNFJpVGhKTHlxRVN1WHM4R1ZMNEdESzFYK2lOZ3ZKWDc5c2RL?=
 =?utf-8?B?d24yb2ZXczNMblJ1ajAwWDdxWUNjRmNFcXB5R203ckd4MCsxRHNPSUZMTkw4?=
 =?utf-8?B?RnJEaXRYRlluL0x0ckNzUjlMUS9UYS9Vc0JUajdKRmh0N1EyMVkwTUp3dWlX?=
 =?utf-8?B?WDBXMUxNckpZV2N4cjJrZmN0ZU43MXVWYUhrNnY0SUJYaDQ2NXBKeVU2V3Z4?=
 =?utf-8?B?d1pNZzBuUXZYY0dYaDlqL214K2U1MCs2OWo3WmFhZ0kybStyVUF1d0NUOVh4?=
 =?utf-8?B?cEszU3BZT3ZrYVlsbmkzOXRXSUFYb2hFK21CdWhSZUdsbmRRODdySFM3bE1R?=
 =?utf-8?B?VFFoNnU5SENyT0tla1ZwbWgxL21saDU1aFdSTGVpY0Vlb2hvVVBXTEl5R091?=
 =?utf-8?B?UWRHYkE2ZjJUT3paRFE1dG9CVC9Xa1FXSmpSc1lEM2piL3lTWld3QjhDOEpt?=
 =?utf-8?B?OTNvWGpTL2FjT1V5MWJuMjQzVW9hNjYrYUlRa0xRVDJjcS92SDNib2dmS21N?=
 =?utf-8?B?NTZTTzJTM0RadTMwMDNvSUhhZnJjMnBpL1FpRnh0RmpFU2JEdnIxU0pGOE5t?=
 =?utf-8?B?VkQrREh4Rlo5RDZMV1JQRWpaY2FJZXNZZUNEdHpyRXZ0cHdVYzRkMHRpYXov?=
 =?utf-8?B?SjNkenNpdktoVDIrNm5tVkIxVllpTjZlQTlvbjVra0ZRWjdsTVI2bnc1Vi9w?=
 =?utf-8?B?V3hkWktUbjFSQTFvdENPZzhNZ2NtTUlsVmVmN0pRRlBTd001eFg4eFlLSFpj?=
 =?utf-8?B?R09rODZKNnJyc0duYWpqMWM0N2tNOEVIS1MzZktacnQzUDNaZkxoMUpzeHp4?=
 =?utf-8?B?Zjdtcm8rMlJwb29CL3VVQnFiWDR5bWs4OUJsbU9NOGZETnlpTXpJZHovMlE1?=
 =?utf-8?B?dmJQV1BYNFBpTEZxZnAxUUo2VE15ZTJrNjc0S21wVDNnS0dWSDJzMGdEeWp4?=
 =?utf-8?B?Z29hL1FTUkIybXFPS0FKemw5aUEzc0ZRYWdQb2hZVmdlZ1RxY2hDSzhMdHVX?=
 =?utf-8?B?SVFhcTU0ayt2V2ZnVStXTWFpSHNJZVlLOE1uK3o5T2o5VjFnNUUwNm15RmRL?=
 =?utf-8?B?Wk5Zb1NvTDJLRkRmcWplcU9ndnlTWWFjR05PQmdEQXdpelJLVWNyQmpWSVJw?=
 =?utf-8?B?b2p1cTFOQXc2dVhYT1AyRER5eVpuUDA3UlJwVEhueXNvQytiOVB0ZnBuTTFi?=
 =?utf-8?B?SGVWMjhMUFhDMTVyMWR1akRrY1FVV1BNUHJZWHB4ekFEUUJIdkVwQUwzeW1z?=
 =?utf-8?B?QVpBaGNXb0tlM0toWGQzTVBlT1pjQkdSN0pOZlpSbVAyNUdLMmd3T0JEK2RQ?=
 =?utf-8?B?ajZNL3JPTFJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlRUNDNmWU9rbWFORys4OHFla2s3RUJSbTg3SmJGS2ZYY24rVjlxcHl3a2xm?=
 =?utf-8?B?Um1QeGIzcVVaSkEreVFIRmhpd2kxTkZBUldsOHl6elA2Uko2REZMazVZVVRq?=
 =?utf-8?B?KzB1TTFTRnhOTlM0UjR6eUFxRmxpTTAxUTZiK24vL21SYVIzNVZjdExmbm0v?=
 =?utf-8?B?aHlBeldxYVBIMmJpbXlMb2JYSlFxc0VrWUZYdEdrZWkwZDB1MmJCUHl3U2Ix?=
 =?utf-8?B?QXp2L0NIcmVtTkFVL2xzSXVJVlp0RTUxUzRuLzJUUm5hY3lFNFU2VTc3SHF6?=
 =?utf-8?B?emoyUGVCMFo0UnlnSGhuaDFqbWdhN1RXck9jZGF4SE9HYTVOUzV5Sk1aVUpt?=
 =?utf-8?B?VTl5SkJiZ3BueVZqTVRNaG9aR0h4eWxFTTdGUVpHemt3eGkvcURSaWhHNnA3?=
 =?utf-8?B?NFJyYzd6cGU4MkhtM05ycEY2VGJpNk1tZXJvR0FaZUw2MGxZOEJvL3R4L29X?=
 =?utf-8?B?d091dU82TTZhOFQ5ZkRBeTQrVHRFN04yRDAzcXhOdUt5cjlBUjVKTE5FWWQ1?=
 =?utf-8?B?eVdyZ0V0VVpCMU1OS2h0MVp4azNVODUvWG96WjNhdFBaQjVRRzlvaVNJVWlN?=
 =?utf-8?B?RW5HR3BzWm9LOVVraUxzWjdSSHIyRVIzMnNJZ2hiUGIvN1l4TmhZQTNDYzha?=
 =?utf-8?B?cjB1OUFYQ1FSSGhTSkdmdHJJMXZ5REZQM0t4REtKTGlvTUJNTkNsNjBKcEN6?=
 =?utf-8?B?VkoyZUpaRTlsOXcybFMyTDZkVHJPNzc5RHpjV3dGZHZmZXZkUU9zOVB4ZWhP?=
 =?utf-8?B?TGFSREtSelF4d3NDL2haRnZsdjJTYXlaOE1Vb1JZOEpRV05hcndMaHk0bG5z?=
 =?utf-8?B?WFkyWnhSaVRzM2VlQmVrN2taZ1E5amJxb0lZelltNnZUdnhadTIrU3dkNWlD?=
 =?utf-8?B?NjI4K3ZYTWU0ZVZhNnB6cjNwc1BnWlVWRXFWS002OHZLSld2eFhFL0kvZjh1?=
 =?utf-8?B?Y3pUTXA1di9LeHR1a0xNVTgvOTQ3V25HQzUweGdZcTIxbWx6S2Zkd2ZubFNZ?=
 =?utf-8?B?cExvREpaTDVlWVN4Tzc4V3ZxdnRmYk5oSDlKK0crRkhHdE9TRTdUY0hJMXNO?=
 =?utf-8?B?bjBIZ2l3Nnh6YjA2VkZSbHZJYlNEUzJ1ZFhpMEdYQmtMeFJKYS9TRDNSaW1p?=
 =?utf-8?B?Mll2MDdHUlBrVEVyZ0ZkMFdnVktGSzJWMXN6cjloM2s1dFVFd2pqWUJNUFY2?=
 =?utf-8?B?V2NrZFBuZldWYWtwSkVyK1Z3ZnVITStQb1JOeHpRNU16S1Q1WUMrM0R2OU1F?=
 =?utf-8?B?U2cybUJkOUhqWDUzckJ1QmhnL1hNcDAxRVp5anZOM0dPSGl5V3Zrc1JWNkZP?=
 =?utf-8?B?U01zdVRxRkNMRFpOQjVONTc2b3BKZER2ajlRYURsZWl4OGZHd2hsZGV4UHV4?=
 =?utf-8?B?SWtVVUd0U2hicXR0NlFEZFR2dGIyMk5tVWJSSFN3LzdYK2VYSEdpTXYvMzh4?=
 =?utf-8?B?MEM2MlVsQWRvQXZyc2htVGowbjZ6a0hLbUU0TWU4NFR3dWhpOVNnaUpBZFVQ?=
 =?utf-8?B?RTZNT3laejBac1Zsa2RDU1J1N0lBa1k1QUNUNnV3bkxSdHNGekxzWkRDOEJy?=
 =?utf-8?B?VEg2WjFLVWpYaEx6V3hManpXdXhmQnBadklycFloaUc5RUtpM3JaUFVTeEV4?=
 =?utf-8?B?V0RvbFlYNW5JMmM2ZHpBWUQ4TDMxNU1QM3NvVGtxTWU4YU5DSURHeVRPNnlK?=
 =?utf-8?B?YmFhVzBtdldFa2UzZDVUY1Nia28wTURnZ1A1T01EV1VhaFQvZzZoMlNNQXcv?=
 =?utf-8?B?RTkyODltWi95b3RTZVpQaHdsVXdKQTVyMHIweTA0UFJDUTlxOTRFYm1pdzE1?=
 =?utf-8?B?c3NKd3FrMG96eU1EbEFrZk81YXpLQ2JET0JjZzNGcjU5WDRkU3NTV1g0UkdP?=
 =?utf-8?B?MEJoYnlicGRYMG91YjNVY1pHVlptMVJpeVlvWmFHVGJlcjFSSG0ySmprRldw?=
 =?utf-8?B?bU16a3VySll4dHo4cFVlL3EvRGtJenVtdVlVRmdMYmgyQ2xCRWRRdVdwNlFX?=
 =?utf-8?B?VExYamV1Vzd1cG5aMWtNdE8vWEo3ZUxwYXBlMVZYYWRVWXRYOXR2NEJTeU94?=
 =?utf-8?B?bCtRZjJic3NQNWpsTU9ERDdDcHBtY2hxbmg0ZVFYalRHeTN2aFJKN2JDZ0JL?=
 =?utf-8?B?cE5jRHRyR3NMN2Ywa1hNMmNBMGgyZ3FmQ3RzSkxiSzZnZmwwL3VGSFl2dVRS?=
 =?utf-8?Q?lrNcr90YsSPbEP0DEDEuhck=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d8ecf-79e8-4ad5-177f-08de20ba19cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 00:34:40.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75HWFuucolAi+7Tskq2+JSmIuWyMTJDX36WIvj7HeJN8Pn4DQ5W0xa/HFSbM4Urv6jJifnwKwBDbzFCiGL/Omg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6428
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXwcnifmgeo1Nm
 +Tvjf1WbYMfAnJUhfkxiFbC/S0e2oPFiuQCB2oL6GSqT6x41OoiKhzDaMPW8jDpy5re8c0nxgp7
 U8QJL1B/9Ks/Bk7p0JVQn5vAl2xwofqKmLDqDJNmllHkaGxO22F16D9V7AHZNfxGbp07DKLaYFX
 P5ZFhw2j2zcPwO1sqJJwblrxsGnvaiQhdvKjXinqJyg8rSpNZXR/y+msQtj8riPtwfi+TH7Gid9
 CgTejJJJ3CIYnMF5LMaXNxVICgJlodcMGXu6pBiEJatC3/b9t4sqjTIpLJfc1OljC7xjwBFdLwP
 u1knu5HcHxLNT/6RmmWI/eybZA+nFytKjcZB0BUVLolt6t4HnPNQuG6sGga/W/pXClzcIh5hgCY
 g3j1OPUW/A+0/jQxSZvc5ERS05b93g==
X-Proofpoint-GUID: Qe9ImHWT0U1AMtjDBGHWlANrK2l50j4e
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=691284a3 cx=c_pps
 a=fY0JyvE1RNjZr0fjhzOn9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=3HEcARKfAAAA:8 a=1A-INFXWiI-RQzT7PFMA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-ORIG-GUID: Qe9ImHWT0U1AMtjDBGHWlANrK2l50j4e
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9C29EEF8176564CBC08E46015DF4056@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 2/2] hfs: Update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511080022

On Tue, 2025-11-11 at 00:23 +0000, George Anthony Vernon wrote:
> On Mon, Nov 10, 2025 at 11:34:39PM +0000, Viacheslav Dubeyko wrote:
> > On Mon, 2025-11-10 at 23:03 +0000, George Anthony Vernon wrote:
> > > On Tue, Nov 04, 2025 at 11:01:31PM +0000, Viacheslav Dubeyko wrote:
> > > > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > > > syzbot is reporting that BUG() in hfs_write_inode() fires upon un=
mount
> > > > > operation when the inode number of the record retrieved as a resu=
lt of
> > > > > hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
> > > > > b905bafdea21 ("hfs: Sanity check the root record") checked the re=
cord
> > > > > size and the record type but did not check the inode number.
> > > > >=20
> > > > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae80=
3d21b     =20
> > > > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > > > ---
> > > > >  fs/hfs/super.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > > index 47f50fa555a4..a7dd20f2d743 100644
> > > > > --- a/fs/hfs/super.c
> > > > > +++ b/fs/hfs/super.c
> > > > > @@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > > > >  			goto bail_hfs_find;
> > > > >  		}
> > > > >  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> > > > > -		if (rec.type !=3D HFS_CDR_DIR)
> > > > > +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be3=
2(HFS_ROOT_CNID))
> > > >=20
> > > > This check is completely unnecessary. Because, we have hfs_iget() t=
hen [1]:
> > > >=20
> > > > The hfs_iget() calls iget5_locked() [2]:
> > > >=20
> > > > And iget5_locked() calls hfs_read_inode(). And hfs_read_inode() wil=
l call
> > > > is_valid_cnid() after applying your patch. So, is_valid_cnid() in
> > > > hfs_read_inode() can completely manage the issue. This is why we do=
n't need in
> > > > this modification after your first patch.
> > > >=20
> > >=20
> > > I think Tetsuo's concern is that a directory catalog record with
> > > cnid > 15 might be returned as a result of hfs_bnode_read, which
> > > is_valid_cnid() would not protect against. I've satisfied myself that
> > > hfs_bnode_read() in hfs_fill_super() will populate hfs_find_data fd
> > > correctly and crash out if it failed to find a record with root CNID =
so
> > > this path is unreachable and there is no need for the second patch.
> > >=20
> >=20
> > Technically speaking, we can adopt this check to be completely sure tha=
t nothing
> > will be wrong during the mount operation. But I believe that is_valid_c=
nid()
> > should be good enough to manage this. Potential argument could be that =
the check
> > of rec.dir.DirID could be faster operation than to call hfs_iget(). But=
 mount is
> > rare and not very fast operation, anyway. And if we fail to mount, then=
 the
> > speed of mount operation is not very important.
>=20
> Agreed we're not worried about speed that the mount operation can reach
> fail case. The check would have value if the bnode populated in
> hfs_find_data fd by hfs_cat_find_brec() is bad. That would be very
> defensive, I'm not sure it's necessary.
>=20
> Maybe is_valid_cnid() should be is_valid_catalog_cnid(), since that is
> what it is actually testing for at the interface with the VFS. Would you
> agree?
>=20

CNID is abbreviation of Catalog Node ID. So, is_valid_catalog_cnid() will s=
ound
like Catalog Catalog Node ID. :)

Thanks,
Slava.

> >=20
> > > > But I think we need to check that root_inode is not bad inode after=
wards:
> > > >=20
> > > > 	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> > > > 	hfs_find_exit(&fd);
> > > > 	if (!root_inode || is_bad_inode(root_inode))
> > > > 		goto bail_no_root;
> > >=20
> > > Agreed, I see hfs_read_inode might return a bad inode. Thanks for
> > > catching this. I noticed also that it returns an int but the return
> > > value holds no meaning; it is always zero.
> > >=20
> > >=20
> >=20
> > I've realized that hfs_write_inode() doesn't check that inode is bad li=
ke other
> > file systems do. Probably, we need to have this check too.
>=20
> Good point, and similarly with HFS+. I'll take a look.
>=20
> Thanks,
>=20
> George

