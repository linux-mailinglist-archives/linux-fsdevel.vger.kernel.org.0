Return-Path: <linux-fsdevel+bounces-72544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8ACFAF99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AF430BE115
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623E33B6D5;
	Tue,  6 Jan 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shnXd/56"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69033B6C2
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731659; cv=fail; b=WQ+jbms0MqnJdwvimXExVfNFPSDuuxSL2j04cVJV+UX/9hov9DyykARqPXbFPKJYgwABNQmX3QFivxCA6QqykBJ19CyGs72fESAcN4nbAMnBCCzUayfdn/jz5JLOqR8mx9Vxia8X5uBQ8Ym+xEUAy/KEPcm5T89OUtt/mdBE4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731659; c=relaxed/simple;
	bh=zii3DpAB/mQNo188seABLvudbOwL09YYKQEaOQ37+Zo=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Ufb6hstfSbP2CZPR4ZKlnHhg62oWTfzyr+UhCgdNM/gbMzrwaMC3rqQn1uVIsu24EbP/xG/YpEEK50PMX7RPBp4ViMKv6zKT5A0dccmY7PjCYh0BeEZPo5Pp9isEQfyvrJaAaB7zYGkq3MZZufvV9lEy2P9cy7gWAoO1w5czAYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shnXd/56; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606BbBBQ027625
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Jan 2026 20:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lk1Vq+B/RSZiVK2MRRg2/r44xCK54Z/jkrzTL8xyGQQ=; b=shnXd/56
	cYaTjtVtEverT61ETqWI+0L0RHLSLG2RQshBXOUfk8sRi/mPiHEbc1pUPWg6Oe4K
	FXWf4nzA8aCt/oZGwnytDDFoHAV5pr5g4iQc9vu2ZRhPYrHzhUgLln0HDnm1eV0D
	OmVzF1DFjj6xDcS0RzcTkXPhujREtPtz59pukQLlLjTaL8JpMaFbxxoEKpXc0mS+
	hcC+VJnGn6ewvthoVG20mOVUfpwBzAOEXS4Eyrr8aesePDkfRq4zy8tULO7xv0xN
	9NsW8ZZ+956nTAcW+9OSef37ME8BqAmHOfpk/WcoiEDRhzlpYjOsJtXhsXeFxAVV
	Ys72X0hsZ1HG0g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtmtfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 20:34:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606KHNk5029769
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Jan 2026 20:34:15 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtmtf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 20:34:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIpbp9vi/ZECRr9aar7R/FgnGgpuVKoJPuzjrofzMSNI1AL15ciOazXiS2QgTNksh4wOj7wu37ZwRTQnRW1GHNbgoa+ENW5SdKlCKUzhiyb0vpuRPWFBPhHHWvj9tgCYm0WQDXCA31lFfJkpgLx8hx5rYssK3IK3uKY5XyWhTCvllXx/n/yYN+/n115Oz/p3CXHsSRbMOhB4imETd+mIQn16rYCAstAZFtgd7Jk+xd9C4XCBDTGPTtFsV9XmpkLfQEwEIunuC3JCWHBA6wctlZSMykdwmNMEXcQ9VJoexE6tbNmoMmw5Hkx42xcIjOF0cws9FDpEvdLiNfx8S4S4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRKB7W0QOOW2FpTyMIyDUKy4DQ8sO7qIm2kzPbOw4cU=;
 b=MPE8ryfgCBWbohTCkZabd82uppEsY5NRcIl/NFHaoAekmBxrLl77gGRwFxto7/woIvpX8IxEcYpJ9t4Br3qucYoPyFRIGflmOmsiS2PtOd5256Ab+V8SlFIGen6fGXoabz1ficUCLoS9t/GNaSh1q2gByR7/F8LCVeJuTktd/yEtk5i6iflXiAtG4WkzCCe3UcWrFJkIlC/XlMWp8/RLFzsS6sRnteyrmYtxkUQV5x3OIt4LQ8sl/WB6hhYn2SjaiA4rRjLZCdIGusKdEtVZC+4kRTPuPmMxs1HsiiHlYjp0f7loIBUi6y45+DN9avkgdiefn6kdT6vQnvrf0RZtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5558.namprd15.prod.outlook.com (2603:10b6:208:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:34:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 20:34:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3] hfsplus: pretend special inodes as regular
 files
Thread-Index: AQHcfvBiVTSkfWKP2Umegt+dQKrWMLVFmbwA
Date: Tue, 6 Jan 2026 20:34:09 +0000
Message-ID: <8a3d218e739b6ed7bd46b823c442030ef69ea3d0.camel@ibm.com>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
	 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
	 <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
	 <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
	 <443c081b0d0d116827adfc3eed5bc5cba4cf7f30.camel@ibm.com>
	 <d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp>
In-Reply-To: <d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5558:EE_
x-ms-office365-filtering-correlation-id: b641caf1-d160-4909-822e-08de4d62f20f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjJKL3VDRW5jWFNaOXhiRUZ5SFl4MWJ2cXF6NWFIYmYvcmRHa3l4ZjdvbjFV?=
 =?utf-8?B?UGpVUTJ6QkQySWtqNXE5Z0szUzJYYXFQT0dQZ1BCTFk3c0RCN0lQZW9HcWdw?=
 =?utf-8?B?WnZjZld3QzUrMmJxeGEzemUwejFwREx5ZlNjRjd2V0lWVndLWjJqSkNvR0dT?=
 =?utf-8?B?WHU0NkVnUmkxWEJZRlF6TGFRcWJMbkd0L3ZjWjJqY0RJYkMwUyt0blBYZEZQ?=
 =?utf-8?B?YStoMW1vUnRYVGVYSmFWS3JHUGl5RUxDVWN1L09UWXZqRXhjRWFtbTMwL2lU?=
 =?utf-8?B?WUF0NnR2OE9ZRTZnUElyWDB0dUU2bUhKaTRmODBVRnE3bVZ1RUxHWFhDMHBM?=
 =?utf-8?B?Vy9qWUxxQVd3WnljR2M3MGRSdWZ4V2tXWStzYTN0ZHVxcmF4elNhamRiZjhZ?=
 =?utf-8?B?ZWF0MU9oU3lEWFoybU51SFpVVExINUNMVll1UXN3MThXM05MVzBOeUdmS0NM?=
 =?utf-8?B?T1owbG9QT1ZlTkVOcXV4RVNyNlM4aWtqK2QvREhMNEhqWTRFekFEM0xpUElO?=
 =?utf-8?B?aEtjKy9WbnlIeVJPZUx6elhFMUdjY1ZiVGpoM3hlbjVicG9OdzN4OGQwZWVQ?=
 =?utf-8?B?RVFSbmp1VFN6R0N1NXZxZU5GYkc2RkR1aEVIY0YyS2xnL2J4VVEwV0dueUc5?=
 =?utf-8?B?UXBsNy9kT0VMd1NjTnJFSW8xOHJGSjVHUG0rY0VFYkNZc1F0MW1vWDJFeXpq?=
 =?utf-8?B?VytqZkdOMDZFWU9BUzZyNkJjdFRPeTdsdUU5UEQ3aFk4VVlNbWdxdGtuUGEx?=
 =?utf-8?B?S1BWd056ZG5VYm01VXdiT1Q0cXRhRkFneHFHM0hCTkRDTGdxNnJKK3FNcXVC?=
 =?utf-8?B?MzdvT3lkMTJTUi9oMUtYd3IycnNWZ0hQN1NnS2RDYncyU2xUWmRBd0dobEVm?=
 =?utf-8?B?TC9zSGNjN3FUS3Z2WGxCWWRLWTRxTDFXcElIelNocURQVFZXaHVYblZSTTlq?=
 =?utf-8?B?SnFMbm03U2dDZW9VYnpvMEVUc3NuZUIrYXkxMlVXdmdrWGp1WnQ2U0RSSE5W?=
 =?utf-8?B?bTFJSmt3UEtSOG5EbDJTVitva05RNVdZQUdPTTZMQkNNaS9Jb0hxSGNIOXFG?=
 =?utf-8?B?MkgvOGttcHhuZVRHOTJLM003czJUYngrOEhvczRqbTJ1WTBMQWRzbzVwc2hm?=
 =?utf-8?B?VmNSOUp6SEFaQjJJTGJBSTg5U2tkYm5MTXc4OHFySE5jamN6RzROYzVCZVhZ?=
 =?utf-8?B?N1hIZk42T2F1N051VWdQbWtyQWJPZ3dNempYek1jaXN5VFY2UDFJSFNKQ0Vx?=
 =?utf-8?B?dmhjbGR3MGZjd1Uzd0NlcWpGZWtORGlHVWdBRm1nWmlFSXE1dU9NekZ6OE1p?=
 =?utf-8?B?QmFSaHhRd3hOMEZUVVNKZVhURXYrZ0lRT2M5djFGZ05lY2JXT0RMbVRCbUMr?=
 =?utf-8?B?cGpjTXZmaVpEUlExY2ZPdnlLbjBaS2pOSGhRSEVtMzhaa285OXhFOWRSbEZp?=
 =?utf-8?B?QVNZbXpyTzFheUtXSzRQOXZQOVJrQm9vaFVkVEE4NklHa29jd3M0dzVHZ2d6?=
 =?utf-8?B?VGdMVlRSQWd5SGlRcThnczJuSzJuTzNoNTFZVEx3YjQwZXZRVVBXSXNocllQ?=
 =?utf-8?B?dDJqMWVXYXlSMEtqcWFvaTZ5MlZNbmttVHl3bDlwL3lCcG1TTEYwL0Rhc3FO?=
 =?utf-8?B?RXZtd1VtZ2ZXRXRudzhpNVhWR2lTT3ZKWWJCeDl1OVF4bzcvdG5VUERVTENr?=
 =?utf-8?B?VkZpTVl1MW9rVjJoNzR6WHV4RXF3L21IYXhvNDEyTFhIYmhvOTRQR29OdjFU?=
 =?utf-8?B?c0tJVG1UOXZrdG43UHczYTJmVTUwRi8vbGhaRnAvSUVmRHZwcjZhckM0d1dP?=
 =?utf-8?B?VnNkMFlBaWl1ektvNGpxNHBYTlNkYytROVZ3UXZMUWkzeGNlQ1J5dml2Vk9q?=
 =?utf-8?B?Z1RmdWVvckZFSXpaWVRVNHBkeXdJQ29PQzE0N1plUDZEZWtjZFlkQ3pYYmZ1?=
 =?utf-8?B?NEVVZVBDbkh2VjkrZ0VGaTBkRGFzdmpKcGp5VFMreTR6MFVsQU1hVEZVTE5u?=
 =?utf-8?B?QjF6R0hLeDZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVBoa0ZYQkZOMDBUOFNUMEF4WFFYZktuQTduRTgyOEdCQmJOV29nVVdndCsw?=
 =?utf-8?B?RlNIVUN6MmhWV0I4emNCb1cvcVlEa3BGc0wrNnRFVEtOZ0J4WC9Obm9Gd24v?=
 =?utf-8?B?QklpL05jOGNjZDBmdUhISGRveEg1Q2ZOZmhJV3hoV0FVT2RGRzhTbXNhMUZV?=
 =?utf-8?B?UmlRLy9CRk5oSWx5QWYwbDdibldHN2Nkcy9RZktpeFVFQTNxWEdJbkluK1pK?=
 =?utf-8?B?c0RNT0pJbDlLZ0t6dnk5c21Wb0d4UmNTVTlzYmFsZXQvVW5iek1JbjJxVjZG?=
 =?utf-8?B?dk9SVWM3ZFVmS3E5MURreUltV3RBRkFTM3llRkdSb2hZKzRmeE03YXpxYm9S?=
 =?utf-8?B?QUhRR1JTd3IxNThDOGhNK3g1eENGRzNoeklZakRGQlRZZ0Y1UlI1Y1ZDb3Jy?=
 =?utf-8?B?Y1MyQjdkUFplb2pwSkhzODExeUNBQW5HVHVYM3JIYWtvWll6ZnZMK1RuV2tq?=
 =?utf-8?B?dmxYV2NyakoraG5mdjJQZnllV2hKQnhvai9GakE2Tm1JcUZtWi9DVmgyelJZ?=
 =?utf-8?B?eW1melhxZmJRdnhrWkc4RUZySzJvaHNBU3o4Y0t3NnBrVHNOclhrS2hnT2NY?=
 =?utf-8?B?bUxaUlc0b29qVER0dVA0c1R3SHIrOXNHa3puZy9yMXBSRGVhNXVlY3FDdFRM?=
 =?utf-8?B?RG1UZG12TzUzMlhnNE9xeWxEZFZOdmFHeldOTmR0Rzk5eExSVVRuMEVpN1B1?=
 =?utf-8?B?aXUvNHk4NWVoZmxsZ25jU2tZTTBFMVVNSmw4NENtYk5SdjVLQmhVaTlRc0xo?=
 =?utf-8?B?ZEcycUtPR0ZaaVpmSzFCR2dBK2RwWjBYcjQ5a2pXWkFBNmRsUGxsOUluQkJr?=
 =?utf-8?B?VFdrWFZXUVlROUJWZGhQRVNvdzYreGN0YzF0clZoZ0p6TEI5SEJvbVROM1NP?=
 =?utf-8?B?ZlV6Ykc2V3NiV0ZWZE12M1NNWG8ycHQxTTRZdlZpTUhsOVdST2VvclduMWkr?=
 =?utf-8?B?dzRCeFQ1NHNEeUFMZmdqN3MxaXBpazV6MGZFSWc5cnRaWnRaM282Qm55R3Z2?=
 =?utf-8?B?ZHY5d3hQRFMvNExKa0tpV25XT3R2a2QwaFNMV0lmT2M0OHFHbGFpVTcxOXFN?=
 =?utf-8?B?T28waDZ5cnRwWEt6bnRxWXpHaDlHR1dxTnlLKzFEMjh1Ty83aVNsWVcxMDBH?=
 =?utf-8?B?WXh4cnozZy91T21SWVdVTlJQdjdFRERzdHRJdXJTZVZZRndYQmtUdmNVWkFR?=
 =?utf-8?B?aXlZalE2eDNKNFM3SE5tZjA4SzdsTDU4T0FsR2ZGQU9hcGhJZVFuVTN6eEdQ?=
 =?utf-8?B?L3dvVWJFcE5NTXc0WW9TV2R0ZWdNalZGVElxenhmTnBlOGN2dXMxSm1adjVX?=
 =?utf-8?B?TVpWTTZhcUhWSi9mbGpmNzBvME5hMDIzSTA1eWFEb0RZbStwZWk3SXhPanV5?=
 =?utf-8?B?M1JYYkk0c2JyRFRUd1dhazlFUXVEdlBYQlV6d1VqWVd3R3pWZU5kem9jT1d5?=
 =?utf-8?B?N1Bkb2t5bmEzbGg4NVBLd0J6VWZWaExISDBhSlRhR0pVMTFoSGxadGNzUEcy?=
 =?utf-8?B?RmFxSHlsWUZHUHdOZ1pvYnhlWHAya09KbmJjY0Y1eEkrc3h5K2hDc0QxN0V5?=
 =?utf-8?B?UHYyeVRsVjhqT2NZdjhuaVlFMDR5WDZ0L2JlSWlrNFBjRTFmNzloVHFUUE1p?=
 =?utf-8?B?Q2dyTmFoQm5XTVU0NDl4cWtldjZqNVhSOHAxbkY5cU8zUjlpVkwyNFEwTGo4?=
 =?utf-8?B?c2dONnFZWTZraC9Lb2dOSXRvUGduYWdkYWtqeUVtcmVGZVJLck1KdjVKT1c3?=
 =?utf-8?B?cThSRFpKVE5PNWt2Z0pOL0tEUjQwdWtIck5mcXJ5RnltRWJlMStjSEFnNXJs?=
 =?utf-8?B?TWh6d3RXblZ6K2VGbytqdldKOE1tSXIvVUJ4bGcrTXhEbWxsY0Nua1NKSDhW?=
 =?utf-8?B?OXJZMFBUdTBRTkRBQSsxWnBCV05uckN6RXhybVZMblJaRTlsUW10OW9CZDU2?=
 =?utf-8?B?Z0R0bjdhWWNPTGM1eWIyemh5MXRqWlp0Q2o1R2svNUNnaWkvMklLZTJoQlpW?=
 =?utf-8?B?MjhGVEVuNVFDbUoxNlM2TnY3SU0vdFk3MGdPTndjVDllSFFJTVVmQVFVeWRo?=
 =?utf-8?B?cDE5Ly9FTGxsTHlDcFU3YTAzcXA4R1NBZFVHcEFFZk12UUFxZGhEM3orUU5l?=
 =?utf-8?B?QmVuTUJ5SzJac2Vvdk1Ca2pYSHlDN0pLRHNuMnhBVVFrNkJCZ1V4NG5hNkxT?=
 =?utf-8?B?MXRneGYzNGxpTXFBSng0NFBtcEpsN2hyQzZWbHFmenhjaWVyaDBLRHBwT1FB?=
 =?utf-8?B?akFhSnhKQWRwY01EU3AvQXhFeXJkR2NIM0ljaVpCZTdYVWZrT2hMdTZsT3VN?=
 =?utf-8?B?OVpyZWdZMmtwYlE0V0kyMS8wZFlGdW1XYjZYRi9oODJCQmphSDE1TUpXWkpp?=
 =?utf-8?Q?c2+TYqrDin5QGwWUoJxhOOv+FOV37P5cjYuJE?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b641caf1-d160-4909-822e-08de4d62f20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 20:34:09.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aj4uK0UV3juPpnnSjwYosq1qJaDhgoXpZGNP+RfmB9LBT9KNZL+GY0SlQMBokMs/BgJiSSqiGbQvBmXgtIJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5558
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d71c6 cx=c_pps
 a=fvoc8Rb8ruZSznP819E46A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=wCmvBT1CAAAA:8 a=E3x-2L7OUUt2cCDIQa0A:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: u7iAdBwDeSpTeDxcF1ebR5s_VKNk_WNp
X-Proofpoint-ORIG-GUID: u7iAdBwDeSpTeDxcF1ebR5s_VKNk_WNp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3NiBTYWx0ZWRfX2aKmcbJSrkyc
 t6wHJey7QZdnjbcQ0zyVp/eCaLLx083xrzQ9qlkomXt+V+NDvxMC1qItBsOiQ2853qw6/7I32F/
 7Bu8S6kqtUgWVDT5732Ntlmgp0aErAWF/3l64YZa1c0DJy5zRKIxs6UgEI3FfW6GoHN3+oVm1wU
 b+JBkLy+T/K+gzKbqX48VY7+8qH8EqLJleql1EikN6BzN23hvb9Md+vgYagE02ISWImt1qLo8+K
 tTgkwT5JhAPy2rsv2ENEojzI0NXMmehRxP4ko1FI84MVlfT/IwUupsm8GK6XLbKUogYj72bd/79
 ruDnmKoYqlNVski7M4IG+qwfpPhRS1B65vXRtCErsS2ycnn6SXUzSTS7lg0ZVSa8w3JI0Vg/gLq
 mRCUCqCyX8e9WuX703Peg5E/LI3171Nu3oPpV0EYm7BkkO+0pjunqvRXtcHIVPygccTD3fkv1Nu
 ge3MUpjmFjAAqSefsEw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC5C5784675A5242BDEA970E252CAB0A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v3] hfsplus: pretend special inodes as regular files
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601060176

On Tue, 2026-01-06 at 18:39 +0900, Tetsuo Handa wrote:
> Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
> S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
>=20
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfsplus/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index aaffa9e060a0..7f327b777ece 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -53,6 +53,12 @@ static int hfsplus_system_read_inode(struct inode *ino=
de)
>  		return -EIO;
>  	}
> =20
> +	/*
> +	 * Assign a dummy file type, for may_open() requires that
> +	 * an inode has a valid file type.
> +	 */
> +	inode->i_mode =3D S_IFREG;
> +
>  	return 0;
>  }
> =20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

