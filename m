Return-Path: <linux-fsdevel+bounces-55290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471ABB09530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055341C441B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C1F21B199;
	Thu, 17 Jul 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W2aqJFKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D7194A60;
	Thu, 17 Jul 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781797; cv=fail; b=aSLBuZIVYbGnDJYgd3Kcp06o2TCEewaNA6nlWET2F0yvmWrtt2qi+0jIx65PPtNSCVDftGAaNuNBuHDrwULjhQUnrhWJQ9StZZ4l0oFySmwFb5I1Fy8aPEqmfmnx2SHb3Uofv9kwpEXYOAeX3hRapYWMRJJOESvczuMQm/icA3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781797; c=relaxed/simple;
	bh=WfCvgmzSe9oQ29UMY9VGNMNzVOqVGjKN4DOAdFXOF2U=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=J2uOIRjLC8uLK3E/PtMjJZg/lUsdScrRlTfT759StVjfdje311tgOund4U9QedBA9bZR5tF3bzb91qoSu+VNEtZ8g3YHXfQp/YIt2y/4b0fgPeoPK2A+2ufO15LvUIh6GNngf03t2fqkEcOSEHkjjcoegf786Q1VeIm+KP6JFBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W2aqJFKC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HI6G4s031797;
	Thu, 17 Jul 2025 19:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=WfCvgmzSe9oQ29UMY9VGNMNzVOqVGjKN4DOAdFXOF2U=; b=W2aqJFKC
	RM16mBf/1WAeb1k5+/e3/ttSkOBoH6LZCMhWf8ThBJ5r5MPKaDEVcAlahl4VGVBV
	bIYFxUQPx+eZSdhPzLb/axtrXUSvJz7TdlfVe4V5Kd9cHz0NatyoTAUQO5U/XD6u
	CCQYfDdwY89UTE6FrNc4953bvDPyqilFmBLQQEsQsJTMYcfQYE3cJpH8jSIVkXiU
	KBSkQqvIjZ0rbb4y6m6bAwwOilll7X0aQKqd+cXmD7vbjX6wgm5KSjHH47sK38Z4
	TL6TRvKnNn+FyIzbYnlQnGHhlO2egOE7b5mS7MnxDFPEPnk74xaDBe3/4BpOORM9
	RgrZoVDWaRGCJg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7d0kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 19:49:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTny2zLpZ0SISVizd+efP+HM4og8uxtcr28hZfp8sJC6u6tjSMPzPWfxqMrmHQas/YVis0LRT6bDhOeavrcipIcZCh3nr/6HM6XwHpffLQxIFLAQlolbSGJ3zEiN9tZZRbEW+97NkYtEjZN8xn/N+0iYQqgsGoCbAq0SaM/GVlV7s7bW4g+S1oyVVbUJbhszWeJIjRqjmgYVg9VTJuTCM9XjCZdrSdvj9QZ2YiL9mHAMSnt2q4xCwuwJdK3jsVLlSOxihbIKPjolECrM7JI+nFT94Np5RUTR9LDE0y9uew4rfZN2RxK3Bh7ddJCzQX0lb7xJSK5Hh73iqs3Xquc2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfCvgmzSe9oQ29UMY9VGNMNzVOqVGjKN4DOAdFXOF2U=;
 b=uwYJHjQkl2yqH9yMFylWugppxDo6lFvzJdqkDQLBTw6OYPIg7TXCspSMziws+ZjyoYPZj8mgx1PfQDL0z3hysEuwfw3rhUtN4of7kpZrQN7voHX3V0qnwaSyZB+sj+AptUYNylX5QSf9JV8wbHp7EaYYUhFtsfrEw/+d9CM7rRFdot0x4/AG1wQirSFKK9CHIjCco1ADSY9Pu4vcDIQnMWpNs3iSHZEDBbICIYKMke4LzqfblHZphQd0X7FgmI83kFbzoyFm7j/4mkYtWVY2+K48nmuXGbpfv1p+cYbwOSzP5ucYQdk9igwkeBFl5v0xCRW5gvZe/kyvli1r2CE8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB5279.namprd15.prod.outlook.com (2603:10b6:a03:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 19:49:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Thu, 17 Jul 2025
 19:49:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index: AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqA
Date: Thu, 17 Jul 2025 19:49:41 +0000
Message-ID: <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
	 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
	 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
	 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
	 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
	 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
	 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
In-Reply-To: <aHlQkTHYxnZ1wrhF@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB5279:EE_
x-ms-office365-filtering-correlation-id: d95758f6-24d3-4a4e-07d4-08ddc56b1278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUIzdS80YUpDaDUzMEk4L1BvbklPcFhlSnVwWG9yS04vcjZpMWxnMU1ra3ZL?=
 =?utf-8?B?emNNd3FCRU1PWTRvWTdHdTJUU2hUN0tNc2dmdVhoNzVGNkF0UlAyKzRsNGor?=
 =?utf-8?B?OVJIT05lRTFLdUExU0JWcHkvSWoyQk9ScERWTVJoaVI4dGMvOUxwcGpOTXdH?=
 =?utf-8?B?bkxIVHFwaDFGeFVJSjk2QnR2eHp4NnpwVzhyKytPT2M4dFhQQWRXdnY0VVg0?=
 =?utf-8?B?ZEtZWFlPSndmdldQZk1zeGwzV3lnR0JETE55QzN4NlNQNHJ5V3ZyazRGUHp5?=
 =?utf-8?B?NDRETTEwMkVvMlRqVDE1OUdvWE9xSjdZcG40Wnc0OGFKdFlCM0N2Z1VyL3NQ?=
 =?utf-8?B?b3VaUHEzK0p4SG1HeU5BbThYSmNvd0E1eXhzR2JEZkZNVEptR3k5UWNyMzBL?=
 =?utf-8?B?ZzVJb0xxdkpCeG1abk5JMHkxU1JzV3NQRkFPcnorVTVuWU9ubVhXY1AvdUhp?=
 =?utf-8?B?TTJVYjluTndCOUdxUE5kTjJ1YWlIUWJ1VXFrRFlIUEsvR0p5VHRmZVd4Qk5C?=
 =?utf-8?B?WVBxQmVBK2J4NjZka09TbG5YYXdaK0dwN2dwRFdLN3phMVdaMDJZcHphSjVI?=
 =?utf-8?B?bG5qWnE4dTl1TldIellDNUo2VkxpV2k3Z0F4SVZ4L3NPZS96UTFnWnFZeU9n?=
 =?utf-8?B?dlVLWlNjSmFwOVJCMGhJNWpqR0p0a012QUNBQ3BjdGpuY2w0NmR5aFBRYjcz?=
 =?utf-8?B?SUMvK0svWnovRzdRN0l2S0RhbjhzYkRpMmI3cUQxcVVCNTVrWEJCTjl4Rnll?=
 =?utf-8?B?alAzSlBBYUdzVkxrTWI2RTBKQjNoUyt5UTMvR0ZQT1BDZk9sbkNqVEV0MEJ6?=
 =?utf-8?B?TmJNQyt5VjZnSWdLZXFMZEc3TUNYV05pbm1DajNCK3FXRjlyeTB6cjBzQnI3?=
 =?utf-8?B?ZW9hRDF2bUlMSzc2QzZFdzlRcllLd3BXSy9pK3d1Ulk1SUlhYUM2MXcybDA5?=
 =?utf-8?B?MVJiMXJiVUZjM0sweHprTjdKWXJDQVhxMEJDTzQ3Qzd5NmlhN3hvdkZlRDRj?=
 =?utf-8?B?ZWI4T1RTbVJBMDBlY08reDFob09EK2F5T1JUME82NnNKcjU1Y3krTW00Ulp3?=
 =?utf-8?B?WHJmRitWS2gvb3ZQUHFPbFFSWkI0MXRtUjh6SGcvQTl3TVRiTER4cVFNN1ZZ?=
 =?utf-8?B?WVJINzUrY1Jnc3ZRL21VQ01JZ3N0VDVRVW1vaUd5ZGJ2cEdVcm1icW1PUUp5?=
 =?utf-8?B?WjcrK296V1JzWGIvUnZmdXFvU29kSjg0dkNqdWk2OFlYc0lvOVBVSVBpQzha?=
 =?utf-8?B?RkJRZ1ZIMU9GVEZRMng1YUVudjhxRXFZaG80RFdMQlVYdmJPODhkTzBVR2lw?=
 =?utf-8?B?ODlBaXpodE5nUExmNXdWSTlFdW4yaW05ZmtSYVRnaGtDRVJJRGpsWHFrKzlN?=
 =?utf-8?B?bnk0a2ZJaXlUWTlwMWkyQThHeTM1VVhIb3pBTWZJU3JyMzNOL1c0bjBnV1hu?=
 =?utf-8?B?cWZRNGp3aENqZXFBUDBMa0Q1RnlZeGdGZTE3VmxZZ1FWMGZML2pPa0M2OHhR?=
 =?utf-8?B?blVZalU1T0dGeTVSRC9RaTlyV1dDM0J0cEJERGJvUkNSZG02bXhsS1h0OC9Y?=
 =?utf-8?B?VG8yQWZRWG5ENjUxZXZ3SkJldVoyNWliQzN0Y0JmYU1qMS92MHc3dm5XcHpl?=
 =?utf-8?B?SE5oSjBja0tjRTVJU0pzd3pYR0ZTUlVERkVTY20vOEhacm54NTRwNWhNWkMx?=
 =?utf-8?B?Sm5lZk9VNlI4UUxxakdaSHVRMSs2d0t0dFlhQkQxakpOM0hvSTR2VEg1d1FK?=
 =?utf-8?B?T3NYZTVYV2JvKy9PT0NXcnhTbWFQL3FiMnN2aEQyS0h2cXJnMjVLODFSQ01m?=
 =?utf-8?B?azYvN3NpdmJMZUN4cG1hcTE4TTB2YUV6TGxxT1lwSmdpVEFaTGR3TzNMazlX?=
 =?utf-8?B?Ris2TlBLalZrNnY4clFXcEVyOGFMRytUV2Y1ZzdpeFA5WkRldXZzTGdFWjFl?=
 =?utf-8?Q?Uamgt101As8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTZQRStwenZRMEhMd0I3M3YzMzVFVXV5S1M0SU5KaEhSR1JEckdsNHhpNnZZ?=
 =?utf-8?B?bGVOSmxlTVFEaFppMXh3WkQ0Z1d5cDZKYlNLaWwvOGhiWnJqVnNTSzgyL2tY?=
 =?utf-8?B?MGVWZG4rUDFObTBvMkp0MDFxd1MxckRrVjZhK3NLRlB2a2hjRmh2M3BEOGlY?=
 =?utf-8?B?VmpJczdHMzZvOG1RTk1sZEdCYnlORXF1Z1ZSalVjU3AwYytXelM2YnNhdzEy?=
 =?utf-8?B?RFZINUlkdmxCb01hd1NEb1JFNHlKZ1pCRGVhUzRlLy8ydHh6NWhDY1MvMTBw?=
 =?utf-8?B?M294SHhRWXpZM3QxSzFOU25zSmF2WXhybjFaM0QxZnNjSHFZdnUvbE94QVhs?=
 =?utf-8?B?V1VhdkRMV0VrZEdNc2EwSk5UNFY0MERVbm9MOSs0MXFxMXRyZ0FFb1VRZWo0?=
 =?utf-8?B?Qk1TSW1wYWROVFNGVkVFeGJFOVpJa2JrUzB1Q2dYdmtsS3NZNHRwTUR3aVF6?=
 =?utf-8?B?WUpvRE43Wm1aWU40c1UrcXJSMnlaeHRVV002aGRLYzYxWnVzbjlaU3hJQnM3?=
 =?utf-8?B?KzFodGhqMEdPRUR5cWZOL0s5eWFqM3N4bnh2M2E3K2pCdkFwb2R5ZXNjdTAw?=
 =?utf-8?B?WU9GQ2hkQnFMTWFyd2huNk5yK014TGZPQlU0RHB0VVJxT1l6RnFWclN6M3Jj?=
 =?utf-8?B?VUlrVlRod25CenNzYlpoUWR5QkJWOE91Y3ZRUHB5VUc1bXBCSndHdlRSdGRj?=
 =?utf-8?B?QUR4M25tamdoN3crdDUvdmNPUEVlK2lzMDYxSEhrek5rMlZNWjc3ZktpZEln?=
 =?utf-8?B?RXRDUTBMdzdoYklHL2lIWjdHV21RbXNES3liTCs3Rno2czZGbGlkTTk4TFYz?=
 =?utf-8?B?U0VzaU1HZGoxc1g0WUZnbU83VXRjRjkyRnZYYlJIakdXUm44STdYNHl5Q2c3?=
 =?utf-8?B?Z3lEdzc0ejlMNXo0NEt0MmYyUEtoSmhKNVJGSjYxbk0zS2lXNXd2Y0w4a3FV?=
 =?utf-8?B?dXhXU0JSaWJjTjcwYi91MXcrbGZYZjZFSVl5YXYwbzRCNll1SGduUjZzRlRp?=
 =?utf-8?B?c0xLOGQ3cVpVSVlVcDZpWDFnSUZ0ejIzbXgvQkQzSkFVdWNRTldRUW9MY3Yw?=
 =?utf-8?B?cWwraE9WeUZoaGN3L2dVeDFTT3JwOXpwVzRYR09wbUh4WUtZeXlaaEZSU2dO?=
 =?utf-8?B?eXppeURFQ092RnZ1YmR4bGFIODE5a0w3Rnh1TXV1a2k3YkJ4b1FxOG5vV2lR?=
 =?utf-8?B?Umk1ZmhRaHZyZlNNbGxuNTVmbXRUTVJYY2pqdEVGYVhYRzlRSDlnSm9BZ0hs?=
 =?utf-8?B?UUtJR0ttYml0ZDF2T0FiVHhxUkJkZWV4OXpxb2R1NEhHVGFRUGljVCtJb2NV?=
 =?utf-8?B?ZVFTOFpvOHpPUE42OVlaVGRnNVJQcURGdVllcDZ4MDA4YlQ0L28wTXJ6L25u?=
 =?utf-8?B?dnJqK05wTTdKbXd6NUg5ekc0Rk5qaEwya0RoN1lPNkh6ZHlWRzZ1WWx5MkFJ?=
 =?utf-8?B?MHBLTFBUNlRyL2hkS3NTUUthcGJ0Y29ZZ0V2K0RMbldkY1pZMUJwc1ZRTXZN?=
 =?utf-8?B?QVN6NVl4T3gxWmNFUkxNbWdkNEhGVS95d3p3MlVDaFFYaFc2cTJ1OENXNnB4?=
 =?utf-8?B?UGZUY1N1WUtBY2ZQWGVvWEg0a3paKzg2aEtkWXN6eHpYcWR5MTdzN0UvM1Vk?=
 =?utf-8?B?SW13QUlzSVJzbnMwY0o1aDFVRDRsVHdrTERwK1dQdnEzdGRGV1JFZ1JnVEk1?=
 =?utf-8?B?am5IaWdXS1JZMzZBdHdXTVpyNEh6OXZ6QU16WnQ1TncrZkU1UWJjUWhrczc3?=
 =?utf-8?B?SmYvUm5BRkJrdFZMQXpuaDVPUlRsQ0ZjNGg0cC8vTW1TMG90NzY4elpWTFA2?=
 =?utf-8?B?TXBEcDFVWkFKUnRvZnBwYnI5WVlDUS8zTVhqUlc4MjdaaXZac3RSL2tVc0Rm?=
 =?utf-8?B?Q3JoNkVLZm11NkZzc2ZtdFY0VzNJazRPMVF5OC9ubTZpOVpGYlp6S2FKSHJF?=
 =?utf-8?B?YWJFUXlrS3VJRk85MXpJUXZHYWJnOCt2QVVTdDMzbDkzc0pQZC9oU21ZSGNE?=
 =?utf-8?B?RjI4OHRjNHM3Y0FYYnp3QkJwMlVrSGUrWUlXS3UyVlZFd040YzV1V3RhUmx3?=
 =?utf-8?B?YnV2RFEvZjVxSzJHODc4ZThEc2EycGtCcGZFMndKZmdXYWM0MG8vQ3JLem1h?=
 =?utf-8?B?V3FDSk8vZWZuSWZLUnBSZGlFRWpSTExHRXFBcEUxaG53eGpQSXV1WlhWT2Np?=
 =?utf-8?Q?2n2FSLjFAgVjWLoUSRHVtH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58ECC13038DF444E8EBFA3F5913D8B63@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95758f6-24d3-4a4e-07d4-08ddc56b1278
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 19:49:41.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lbWnTkgU66cTGpQtJXt/PafJBlbiGi7Vb3Gz5cnaNvwnsIlgU6brQ7Q5YqW0iFmMGNQz40RNvKEwV8moB+hVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5279
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=687953d8 cx=c_pps a=vLlm6fOi2ONy/6Pih9zO2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=57b4JOh_m3fvBfV8oEEA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NSBTYWx0ZWRfX5SvwhmL38Kdm 8zUZ1HAp5YR5MQ3y3HFlLbT9GjP4+AiRrMGYWVSATKxSaBwfIMokVMP+JYLjRLOCBR2/2Hz1Jm2 l4wgtoLTm9ZtMGZmJ+8k+++NKJtcUO+uCjW+iUHlF879k/KxwDFVBCVJAq2Wi5t5aPohX1ud8JS
 gwP5CsG5IHLZhWXhv0D9EcCg32HLIYFGBLAURW38LIbtVBtpqUBxU8dLkH1PEHffploJPd8BoQv iBHNHR09Rhcqp/8wSxdrEWhbwp67hcOu+q5Bna0zsshsQEXBHqTWVixMJgpOsejUKH1Dx2P2WWv BjoRvXuLxlDeJIIlk2kd1NULfW/PC5+oczyQnuJqucsODPxgzdhYaiI1PmwNv+hcz33Fjn2+tD8
 JPZ7DXuXPy7YNhTCo9vTI2ibvYhzKujzxFZuFsArRLagWYUByn72BSHpbjgH0Pb5lMzcCxRW
X-Proofpoint-GUID: iAEMHCZiRjCOnrRNXV2WkxOD_PlSiuAe
X-Proofpoint-ORIG-GUID: iAEMHCZiRjCOnrRNXV2WkxOD_PlSiuAe
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170175

T24gVGh1LCAyMDI1LTA3LTE3IGF0IDIwOjM1ICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gRnJpLCBKdWwgMTgsIDIwMjUgYXQgMTI6MzI6NDZBTSArMDkwMCwgVGV0c3VvIEhhbmRh
IHdyb3RlOg0KPiA+ICsrKyBiL2ZzL2hmcy9pbm9kZS5jDQo+ID4gQEAgLTgxLDcgKzgxLDggQEAg
c3RhdGljIGJvb2wgaGZzX3JlbGVhc2VfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywgZ2ZwX3Qg
bWFzaykNCj4gPiAgCQl0cmVlID0gSEZTX1NCKHNiKS0+Y2F0X3RyZWU7DQo+ID4gIAkJYnJlYWs7
DQo+ID4gIAlkZWZhdWx0Og0KPiA+IC0JCUJVRygpOw0KPiA+ICsJCXByX2VycigiZGV0ZWN0ZWQg
dW5rbm93biBpbm9kZSAlbHUsIHJ1bm5pbmcgZnNjay5oZnMgaXMgcmVjb21tZW5kZWQuXG4iLA0K
PiA+ICsJCSAgICAgICBpbm9kZS0+aV9pbm8pOw0KPiANCj4gQXMgSSBhc2tlZCB0aGUgZmlyc3Qg
dGltZSwgaG93IGNhbiB3ZSBnZXQgaGVyZT8gIEluIG9yZGVyIHRvIHJlbGVhc2UgYQ0KPiBmb2xp
bywgd2UgaGF2ZSB0byBmaXJzdCBwb3B1bGF0ZSB0aGUgcGFnZWNhY2hlIG9mIHRoZSBpbm9kZSB3
aXRoIGZvbGlvcy4NCj4gSG93IGRpZCB3ZSBtYW5hZ2UgdG8gZG8gdGhhdCBmb3IgYW4gaW5vZGUg
d2l0aCBhIGJvZ3VzIGlfaW5vPw0KPiANCg0KUHJvYmFibHksIHdlIGhhdmUgbm90IGNoZWNrZWQg
dGhlIGlub2RlIElEIGF0IGZpcnN0IHBsYWNlIGluIGhmc19yZWFkX2lub2RlKCkNClsxXS4gU28s
IGl0IG1ha2VzIHNlbnNlIHRvIHJld29yayB0aGUgbG9naWMgaGVyZS4NCg0KPiA+IEBAIC00NDEs
NyArNDQyLDggQEAgaW50IGhmc193cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYykNCj4gPiAgCQkJaGZzX2J0cmVlX3dyaXRlKEhGU19T
Qihpbm9kZS0+aV9zYiktPmNhdF90cmVlKTsNCj4gPiAgCQkJcmV0dXJuIDA7DQo+ID4gIAkJZGVm
YXVsdDoNCj4gPiAtCQkJQlVHKCk7DQo+ID4gKwkJCXByX2VycigiZGV0ZWN0ZWQgdW5rbm93biBp
bm9kZSAlbHUsIHJ1bm5pbmcgZnNjay5oZnMgaXMgcmVjb21tZW5kZWQuXG4iLA0KPiA+ICsJCQkg
ICAgICAgaW5vZGUtPmlfaW5vKTsNCj4gDQo+IFNpbWlsYXJseSBoZXJlLCBob3cgZGlkIHdlIG1h
bmFnZSB0byBtYXJrIGEgYmFkIGlub2RlIGFzIGRpcnR5Pw0KDQpJIGFzc3VtZSBpZiB3ZSBjcmVh
dGVkIHRoZSBpbm9kZSBhcyBub3JtYWwgd2l0aCBpX2lubyA9PSAwLCB0aGVuIHdlIGNhbiBtYWtl
IGl0DQphcyBhIGRpcnR5LiBCZWNhdXNlLCBpbm9kZSB3aWxsIGJlIG1hZGUgYXMgYmFkIGlub2Rl
IGhlcmUgWzJdIG9ubHkgaWYgcmVjLT50eXBlDQppcyBpbnZhbGlkLiBCdXQgaWYgaXQgaXMgdmFs
aWQsIHRoZW4gd2UgY2FuIGNyZWF0ZSB0aGUgbm9ybWFsIGlub2RlIGV2ZW4gd2l0aA0KaV9pbm8g
PT0gMC4NCg0KSXQgaXMgbXkgY3VycmVudCB1bmRlcnN0YW5kaW5nIG9mIHRoZSBzaXR1YXRpb24g
aGVyZS4gVGV0c3VvLCBwbGVhc2UsIGNvcnJlY3QgbWUNCmlmIEkgYW0gd3JvbmcuDQoNClRoYW5r
cywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTYt
cmM2L3NvdXJjZS9mcy9oZnMvaW5vZGUuYyNMMzUwDQpbMl0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjYuMTYtcmM2L3NvdXJjZS9mcy9oZnMvaW5vZGUuYyNMMzczDQo=

