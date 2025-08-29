Return-Path: <linux-fsdevel+bounces-59665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1933B3C462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A98188D985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8E27054B;
	Fri, 29 Aug 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGGt0crL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E061A314F;
	Fri, 29 Aug 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504431; cv=fail; b=aXfxe0tz+PQafqAr++z9HFplgc859nktOeAVmtH/0udrnCLaHiGOyU00lY20yrWSAHeHkQsYjbW5YqpXyiAfDdMRHdUXt5qgcnGv/DVMjOrLRD1fxXl38uwUdaVq9EF83Xfmh6z/lETZKohadJ511IQo8TCkPZEA2J6UPgv7YPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504431; c=relaxed/simple;
	bh=dRhzzBPTBatVR9pAxAjf20IBhrKfKR14GTWRnI7q55U=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nYFRl3zRAXIK8Ou0eUf6T6G3puAAPa9mBVcGrJhNUFwJn9jre37CoAVZ3DnUSbGkVdbF6u0sGt4EJe4nSwJdyxhx9sXR9szMIcihMFtnbIcpp8MyBFQJK/KLfoHrXMRh21kdB3CxNo+ttLKSnI+sbVScDOuqu2g6z6ZHICHDalk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGGt0crL; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TICEBu007501;
	Fri, 29 Aug 2025 21:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=dRhzzBPTBatVR9pAxAjf20IBhrKfKR14GTWRnI7q55U=; b=RGGt0crL
	hxxh4Jg2Wj1csDS55F0UbWWl5ryAh+YhW7gJwDWl0oz9M0dehbL4MReAhPWw2qlw
	nIycXz0tAjZH5I8CcZq5LG3DnL13QLTOKa2eBvpHZOl105Df1hYJ5k9HbHHR/4kT
	KYnJzQpRY/nIlGd4fbQwxfBUv3JlLaJvVS18m2TUj/ziSPxWot4JRP2wRqYkJd+3
	2ah5WHGk3DvZdpNBbh+9GpqWFkW+YtU2ltoAIeDsUM5KyFB+EUnAeZup8QOGkVqt
	gQBWu6dqxCL9Gq9uKdaMVWkKNPIovIVFuClJiVy8r7viAyAQpqtNmQ6jyYLHMlrb
	dmY0P5KbroBr1g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tsv9f5qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 21:53:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFpJTIiWoaxNOwohgI5rRZUle7T95IHncrpWzN1OBAo18uBoN6raJ2WN78lzjwcmKMvydaDRiwuuJU4EJdMz98IyAiAHtMrnOKBH4Aa/KUsixblWB+QzfErU+PUX5+zqiafx9NCBDth0cVTq8IxJkxVyFXXS4vRmp9utJpAwY5Sjdn477JgKws3k8pkjMHUZ1U5Mlqo7ZTHxIHFP8x0LwvCmgt4Qv+sWnp62nFWc8Jjybr7jM+f0empwDFc5u6Td527hwnrHMKmIDBoSA8n+hetFZHnpsJ1t3JVHV5XRz5q7sFXoZHIGiLuJzCRaE6yMpTCApBZPDJPLH8f1xVTX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRhzzBPTBatVR9pAxAjf20IBhrKfKR14GTWRnI7q55U=;
 b=JGdbk8oPNSMaJLwwoHfZYBc4YVcx4Hc80BZE3FV1qyh2IkStQ4jcxnBTRucgMjrZpG1NA8HUdfA44jGqdVDZJfrzFFYWEEkKJ1I/RDFx9c3IEgIXcfel9QSOYIXVlvSjAQGnkU2ZBThKGnY1xum8bbglCkeKOAPzGWo5TWEjTJgpJOE9+4mQnjoU32pa8OnGg5y2y7Ql4M0RujQdi25ui7x3NpmRlliwvuWFTMJVAkhiYa+PrmVlcBjWdtWgUcmsOswPZMUeggP7+ayh3YfHADY6GI5xFU94k7BYxY3qxqr1IvIO6l7BuTjkMwg+Qd71TvH3sx3aouV7W664hrNnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by PH7PR15MB5450.namprd15.prod.outlook.com (2603:10b6:510:1fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 21:53:37 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:53:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "yang.chenzhi@vivo.com" <yang.chenzhi@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com"
	<syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: fix missing hfs_bnode_get() in
 __hfs_bnode_create
Thread-Index: AQHcGMjaTplGJ0lbJkWCuCW7TuF9prR6LSwA
Date: Fri, 29 Aug 2025 21:53:36 +0000
Message-ID: <ef87d43380a08f86be080ba4bc438db9c83b63f5.camel@ibm.com>
References: <20250829093912.611853-1-yang.chenzhi@vivo.com>
In-Reply-To: <20250829093912.611853-1-yang.chenzhi@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|PH7PR15MB5450:EE_
x-ms-office365-filtering-correlation-id: dc97bb91-b3f0-49f6-4d7e-08dde74681df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N09IK1BYMjBZZENZV0krVDEzK0ZnWktaS1cwUzVCMnZrd3VENlZoYXB3QXFG?=
 =?utf-8?B?YUNjMWJ3b0FuMGdMaFAvSXNHVWhUR1dtVElZNndoWEpGVzZpK2Z5QkZDVUdY?=
 =?utf-8?B?elc3LzhIb1hybHRFbEJIVnIyRGlITnA3ZXNNRzRXZlV1Snoyb0IyQ1lmVVc2?=
 =?utf-8?B?YkNFcEpxcWJrQUpRRGtGNm9jZURCZlJ1dXYyUXZkWUlUcHlROHBua2NDcitp?=
 =?utf-8?B?ZGxEK3JnbU5Pc1B5SnR6bzN6MFpiMm50eW84V0g0eGhTUUprbENDSXhBRnJj?=
 =?utf-8?B?bXIxVXBxc1VQdVhjT28xb3RhQ0dLbFEwS0M4R1o2TWRnb3dTbDNlbm9pd1pJ?=
 =?utf-8?B?a2duSkM1Umh6REkvdHp3aTNWTlAyUHZabUkrS0UwWGdMQUVSVVdxbk53UFpD?=
 =?utf-8?B?YWdYTXJtRm9Ta1FTYkFvelA4WGNVTzYzWEZJdEF2dmh5dUR6YTdzNjlYR3V5?=
 =?utf-8?B?ZEowd3RnR3AxVmlaMTRQb3Z5VUUvOUdlbFpWTG03N0JndkFhTWVJSm1VbWx1?=
 =?utf-8?B?dCtmNXdUaFVqZndObzVIaG9jTWE4N2Y3THFndnlQVGsxcXJvNm0vRDFLZnhJ?=
 =?utf-8?B?Qm1QYUNRNmFhaW5PYmo3SWpkUUlJL0E1RUt4ekNpaVRENXZ0cXlTMnpxeGlk?=
 =?utf-8?B?UyszaTlmSUd4WGk5R2g5cXBZNFdjQUR2YUZZUXhDb0h4MmV5WW9BaFlLRlRY?=
 =?utf-8?B?Q0VlVWQ4WHAzQlpUd1pWbGMxTWRuZUtsblJLU0laaXFHRitKS1B5L2J1aXRI?=
 =?utf-8?B?NVlkbGJTaFBGd2V1YTlhZkRCdkZPL2tyaFdCZUlvY21zMXFhdjR0U21TbTVI?=
 =?utf-8?B?UDF5alRTbW9iNWRDV0NvV1dqOXRvM0lwbXlZcDh3UnlUSXIyUGVSUDJROFYr?=
 =?utf-8?B?aGhrQ1pWZnhCcDNmbS9PeGwxSEdmUUhHaVFyQ1lWVTc0RXBVWUdveXBoRys3?=
 =?utf-8?B?MVZ4NnZ1MlZMZUt6MmpmZ0dkVzF3U1JsQ0F3aXVhUEpNR3JoSVBEY2JhdTJo?=
 =?utf-8?B?RENjemxWQmU5eWdQQ3BaTVZiV25jYU5jQitHcGZDUjR4cVVUVDloL05EY0h2?=
 =?utf-8?B?OVpVbjdxa1JVYnY4UUJydWNWTWdPTkNTTDJuQkgzUG9QOXpKUzJXb2ZjenE3?=
 =?utf-8?B?RVpMS3laRzBGMGNJbnJmVkp4dXJWNWpaUGE1aEhkcmxkci94MzZZcGRXYlZJ?=
 =?utf-8?B?bnYxc0s5L2NSZlJQTUx2bHhmVzVMT1ZCYUV0S2Q1aDdWNVhUTWJCMkRDV3c5?=
 =?utf-8?B?NmducG5ucmlEWElyWWdTYjlmbjI4aFFya2tTUkxEUGw1RlFNNUd1aTgzUGJ5?=
 =?utf-8?B?V2RTUmdjakZJVXI1c1pub0VLZkVONVVBUzYwdmpDUjlSZWtuREw0eXZSSk1z?=
 =?utf-8?B?YlBReHY5NG5nSG1jaHFDQTVPMndtaWxmbmFSOHFSTHRzbTA1QVJWKytUVUtn?=
 =?utf-8?B?cXR4eVVkQlc4SFE3UDFrbGQrazZqb09OOGc5aVY1cWcwbVFQMnl3bDA2eWNR?=
 =?utf-8?B?NXd5bm1WamQ5UVF6dUZPTFJ5eFc2Rkk3ZnY3VWhlZnRhaHE4ZVRENXlUaFhI?=
 =?utf-8?B?d3k5c2RYSTRpdVo0aVlHbForUzFFVTJxdXZEU1BTdW1Pb0d4SFNRWElkWWdw?=
 =?utf-8?B?L2lUV0hscUl1bDhBVG1tWHdWREg5ZFFzM0pJWWlaSnRrOWhsMVF0U1NWREQ4?=
 =?utf-8?B?SGJrSnQ2UEo5UkVUSUZkSmwyYlZWU1JxR0tJb3FkUTluNWlwa0NJc0dxekIy?=
 =?utf-8?B?ejBZMDJNME1MQk1xN0RSZk1BRkhLb251SXo0MjZDZzF4NncxWmhGMGRaZzRU?=
 =?utf-8?B?YUlzR3dUUWJyaHVjUWZDR2tDZCtGSWNhOXMrcy9JMFZCdXU0aGk1b0FNeW9v?=
 =?utf-8?B?cjZQa3Q1L1g5cFRNSFFKelpYVXlJc0E0NnczaXhlVmdVSGVmemFrL3ZudCtP?=
 =?utf-8?B?VllPWnZZTW80akNyNlJ1U3dHd2pMNTV0WUtxd1BzOFdXK1ZFbjBqT0VIeGFH?=
 =?utf-8?B?ZDFRQVRFYVRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE5vTWhMTG1qdm1tdW9iYldiZ05HNzFLZHdTbDlPUmo5Z1NmZisvMGpCemRL?=
 =?utf-8?B?QlFFazFUdCswVTBkZHEyaVE2WmZCNnVibDJpcXJkeUxLL0o2SEw4a2hCaVNI?=
 =?utf-8?B?akNaZGxKRCtMbVp0S1R2OU9vOWlKbDNXWndTUm9VckFiUU1SNkNOWDk1dm5t?=
 =?utf-8?B?QjF3UCs4TEc1MlErT1Q5NEdBMGhBMmlKeVQ5UTNtMTRKOHhqRC9vSDg3M2xW?=
 =?utf-8?B?eFpDZVpCNy9SZjloZE5BbWc2WHJBUXQ1MzlEZ1RQbC9qTW03RlRoSW90WlFj?=
 =?utf-8?B?VEdja1VJZGdDODdiY29YZlYwQ3N5dTRFL1hNQmZWNkswNHVGSEJMczR2bkJ5?=
 =?utf-8?B?L2FCOGttNU96L3BNWHQxMHhsVEo0Ni9pU1NwaW8zbVJheHM4VzBremJmZUp1?=
 =?utf-8?B?N05jK2ZRQXpvU0NCZVhMbVMxY2hjU29vUnNhZUI5WXFQaXNVZkFsUmJtR3I0?=
 =?utf-8?B?eG5WZDFSakVaYVdmbTNuWlBqMUlQUUpjWlVwaXRBQk0vRmpOc3AvYUw0Zngx?=
 =?utf-8?B?czJ6R0kydk5CLzN2ck5mTFFkRWhuTGJDSFJvcERjNktDMkNOTE1hV0d4aEk3?=
 =?utf-8?B?M0JKdEFKaVZVYmwzbmJCZDByMTVKb1JMWWtTWG9aSzNDL1VtMnpkaGs0RVhr?=
 =?utf-8?B?VnRibHY1N3p4ZU9Ia3dJdEpNckNJZVloaGsvS0xOWlRpaTNhLzBid0pESXR3?=
 =?utf-8?B?Ni8zVmdsMGFzNjhqSHY5R3pqeFYvYmlQN08yUDVURlFXSmVDZXpXbEgvTEN2?=
 =?utf-8?B?cFVCUnNxRC91R2k2SGo5S0tITE9aUnVFcCsvRUlzWUtqOUpUanRTMm1tc25a?=
 =?utf-8?B?OWREZGpoMk1HeDVQQS9Mek9HbHFDQXRINkc2YkpBVk9kSW1tZXlURTJ2amVF?=
 =?utf-8?B?bEZGY1RFZTlrOHkyaWRVVkg3Z0R2SlhqRmFxb2pHbUdPUkxTaVBMOHZOY05M?=
 =?utf-8?B?dTVzNW1HWU1vdUU4Y2gyVmErZlh0eVVnR21USkNmREZ4WU9hRGV0VlZhY2hH?=
 =?utf-8?B?LzIrR0dZdHFIcnYxenBzTHVKaGd1SWpTRUJ1M3RHQTQvb3BvVkg0NU96VGNX?=
 =?utf-8?B?OG83M2lDRFZkWm5RNmhlQmYvb01HdlM4eFZoWDNBUVpCZHkrS1N2WCtCRDAv?=
 =?utf-8?B?djRPVjRuYzhiS21PM2F0c1BXMHFGbnRaUmh0OW4wYlN5dmZZcDdBcWNyaVBU?=
 =?utf-8?B?R1NBUnpMN25Bb3huazN3Q3lZTzR6SmxST3VnMjQwUlBQVUMzK284MGtHTVZN?=
 =?utf-8?B?Q0FnUDkwUWZwVVBSUDA0YkV1TFNYZzQ1aUc1UERsUys1bVQ3aUlpN0FNK1RS?=
 =?utf-8?B?M1FkWDN2bDhFU3hkdGNVWG1UdkhrdTlSRHBaYVFzb1doZzZ5cG5qWVJGOU5G?=
 =?utf-8?B?M1VGa29NQi8vVVlUYlJsSy9RU2tDL0g1NFFCLzg2L2VRVWgzZ0Rjc05RY0R0?=
 =?utf-8?B?Vm5GQ2psbmI3UFJ4NUt0OVlKN1VkdnIwMEVVbk5GajErRkpCaTRzOWd2N3Uz?=
 =?utf-8?B?MlE1M0UrUkNLZERtajhTNUNhR01VejY3NDhZeWhIaWNTZkNGSk1CZzFhTXBq?=
 =?utf-8?B?blVIZGM2RDV2NnpicVlxQy9iQmdROExvdWpjTzFuM0xkMUwrdUkwZ0FYZkJv?=
 =?utf-8?B?alNjM1dRMXFqRTgvMjRhQ01Vd0FmZ1hYQ1FRY1pDajNsYjlWc0RqQnJIczlp?=
 =?utf-8?B?L1pGcXp3M0o4RFdqc2lpSDhHVUtiWXpuOEZleUU0V0ttZFRjMi9hMitxWTkw?=
 =?utf-8?B?bW5pMEZLTmo4cTloV3ZobStaVWlON2pBTi8rN1k1eEhHYll1Q1lBalorSkxa?=
 =?utf-8?B?VS85Tm1WdTBTUnNReUNlSkhvQjZLck5Cam9kVkl5SmVnVXVlc0FPWElJbzht?=
 =?utf-8?B?ZFJQTkxLSEFJbFpiczQxdWtVK1N1dTNwT1J4c1YwR3hFNGdCc3J0MlZqTTlz?=
 =?utf-8?B?aVYyYkw4dmVUbTEwOUhqOVBwSGpkLzJ4K1ZCTWJNRXUrbE4wVFVxTXF4ZGVy?=
 =?utf-8?B?Y3p6c0tIZDBQZUwreERVS1JZQjQ4czZXVmFoQURuNm1NbVNIRXU2YzE3aGwv?=
 =?utf-8?B?WlJVMUdBaUt3cDJjaU9NM1FVcVZqQjl6UFpVeU5rTnFLeUl1S3czZmtESjRX?=
 =?utf-8?B?N0l1aStwTzU2cldNalpYWUdJMXZxQndYZEM1SFFrVFVlY0NteisxYTJPV0hD?=
 =?utf-8?Q?cZxOStW1NYDJeF7fJJjr+fg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3BAC83DB097CE4D82919E762E31F4BB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc97bb91-b3f0-49f6-4d7e-08dde74681df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 21:53:36.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8VrOAZO3Yel6XIxSXEZLTPUpdRplGI1Q2dB8sCvKtzqxeV/Y8Hkeb7ikC55gdxMAajUEFIDecXbeO5ICuOBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5450
X-Authority-Analysis: v=2.4 cv=GqtC+l1C c=1 sm=1 tr=0 ts=68b22167 cx=c_pps
 a=RjtLz+qli6Ia6ygbqnDkgw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=hSkVLCK3AAAA:8 a=VGYd57MmXxBNQBNDH6oA:9
 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: uQ7xyCYWBK6r4DsoxTVBgo6oNiYHYlpn
X-Proofpoint-ORIG-GUID: uQ7xyCYWBK6r4DsoxTVBgo6oNiYHYlpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyNyBTYWx0ZWRfX5p0mvuYeVUtU
 SITgmCXnkerLice+3Nx6wvpimW2T09pPvEX8N/1rKAlJVIHDbjFCbdqoJjmA5FtLAJPLoDImV0a
 wrqG8QIG+sVR4tTKbRFdQkeZFsfrbx4E4gGnbbpRlotcIQlgNwPB6X15qH4hA3WiJcaLW8qHbzL
 XP2SbpgODgv/whUlKeBtZRyyVidZo2K5R3BS5Jxff4QTfgPgoxQ2qXovoChS8x8ABgRZXYMDpY0
 O7se4YgTyTvkYtd8HF3tlmhnVgEjskg2q3vY7GhcprJCarX3WUbmbCu0Fj5Jq3Y1Apt42lvKuek
 tq48qEFt4PWBoVgSeSHMENjbtg5MTVzWRwx8ne0g71X+W8s+rsMU73YRGYxFgNSkGX38iGCI94D
 lIZIBdw9
Subject: Re:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 __hfs_bnode_create
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280127

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDE3OjM5ICswODAwLCBDaGVuemhpIFlhbmcgd3JvdGU6DQo+
IEZyb206IFlhbmcgQ2hlbnpoaSA8eWFuZy5jaGVuemhpQHZpdm8uY29tPg0KPiANCj4gV2hlbiBz
eW5jKCkgYW5kIGxpbmsoKSBhcmUgY2FsbGVkIGNvbmN1cnJlbnRseSwgYm90aCB0aHJlYWRzIG1h
eQ0KPiBlbnRlciBoZnNfYm5vZGVfZmluZCgpIHdpdGhvdXQgZmluZGluZyB0aGUgbm9kZSBpbiB0
aGUgaGFzaCB0YWJsZQ0KPiBhbmQgcHJvY2VlZCB0byBjcmVhdGUgaXQuDQo+IA0KDQpJdCdzIGNs
ZWFyIHdoeSBsaW5rKCkgY291bGQgdHJ5IHRvIGNyZWF0ZSBhIGItdHJlZSBub2RlLiBCdXQgaXQn
cyBub3QgY29tcGxldGVseQ0KY2xlYXIgd2h5IHN5bmMoKSBzaG91bGQgdHJ5IHRvIGNyZWF0ZSBh
IGItdHJlZSBub2RlPyBVc3VhbGx5LCBzeW5jKCkgc2hvdWxkIHRyeQ0KdG8gZmx1c2ggYWxyZWFk
eSBleGlzdGVkIGlub2Rlcy4gRXNwZWNpYWxseSwgaWYgd2UgaW1wbHkgYW55IHN5c3RlbSBpbm9k
ZXMgdGhhdA0KYXJlIGNyZWF0ZWQgbW9zdGx5IGR1cmluZyBtb3VudCBvcGVyYXRpb24uIEhvdyBp
cyBpdCBwb3NzaWJsZSB0aGF0IHN5bmMoKSBjb3VsZA0KdHJ5IHRvIGNyZWF0ZSB0aGUgbm9kZT8g
TW9yZW92ZXIsIG5vZGVfaWQgMCAocm9vdCBub2RlKSBzaG91bGQgYmUgYWxyZWFkeQ0KY3JlYXRl
ZCBpZiB3ZSBjcmVhdGVkIHRoZSBiLXRyZWUuDQoNCkkgYW0gaW52ZXN0aWdhdGluZyByaWdodCBu
b3cgdGhlIGlzc3VlIHdoZW4gcm9vdCBub2RlIGlzIHJlLXdyaXR0ZW4gYnkgYW5vdGhlcg0Kbm9k
ZSBkdXJpbmcgaW5zZXJ0aW5nIHRoZSByZWNvcmQgaW4gSEZTIChidXQgSSBhc3N1bWUgdGhhdCBI
RlMrIGNvdWxkIGhhdmUgdGhlDQpzYW1lIGlzc3VlKS4gU28sIEkgdGhpbmsgeW91ciBmaXggaXMg
Z29vZCBidXQgd2UgaGF2ZSBzb21lIG1vcmUgc2VyaW91cyBpc3N1ZSBpbg0KdGhlIGJhY2tncm91
bmQuDQoNClNvLCBpZiB5b3UgYXJlIGZpeGluZyB0aGUgc3l6Ym90IHJlcG9ydGVkIGlzc3VlLCB0
aGVuIGl0IGNvdWxkIGJlIGdvb2QgdG8gaGF2ZQ0KY2FsbCB0cmFjZSBpbiB0aGUgY29tbWVudCB0
byB1bmRlcnN0YW5kIHRoZSBmaXggZW52aXJvbm1lbnQuIEFuZCBpdCBjb3VsZCBiZQ0KbW9yZSBj
bGVhciBpbiB3aGF0IGVudmlyb25tZW50IHN5bmMoKSBpcyB0cnlpbmcgdG8gY3JlYXRlIHRoZSBi
LXRyZWUgbm9kZS4gSQ0KbGlrZSB5b3VyIGFuIGFuYWx5c2lzIG9mIHRoZSBpc3N1ZSBidXQgbm90
IGFsbCBkZXRhaWxzIGFyZSBzaGFyZWQuIEFuZCBJIHN0aWxsDQpoYXZlIHF1ZXN0aW9ucyBob3cg
c3luYygpIGNvdWxkIHRyeSB0byBjcmVhdGUgdGhlIGItdHJlZSdzIG5vZGUuIFByb2JhYmx5LCB0
aGlzDQpmaXggY291bGQgYmUganVzdGlmaWVkIGJ5IGNvbmN1cnJlbnQgbGluaygpIHJlcXVlc3Rz
IG9yIHNvbWV0aGluZyBsaWtlIHRoaXMuIEJ1dA0KY29uY3VycmVudCBjcmVhdGlvbiBvZiBiLXRy
ZWUgbm9kZSBieSBzeW5jKCkgYW5kIGxpbmsoKSBsb29rcyByZWFsbHkgc3VzcGljaW91cy4NCg0K
VGhhbmtzLA0KU2xhdmEuDQoNCj4gVGhyZWFkIEE6DQo+ICAgaGZzcGx1c193cml0ZV9pbm9kZSgp
DQo+ICAgICAtPiBoZnNwbHVzX3dyaXRlX3N5c3RlbV9pbm9kZSgpDQo+ICAgICAgIC0+IGhmc19i
dHJlZV93cml0ZSgpDQo+ICAgICAgICAgLT4gaGZzX2Jub2RlX2ZpbmQodHJlZSwgMCkNCj4gICAg
ICAgICAgIC0+IF9faGZzX2Jub2RlX2NyZWF0ZSh0cmVlLCAwKQ0KPiANCj4gVGhyZWFkIEI6DQo+
ICAgaGZzcGx1c19jcmVhdGVfY2F0KCkNCj4gICAgIC0+IGhmc19icmVjX2luc2VydCgpDQo+ICAg
ICAgIC0+IGhmc19ibm9kZV9zcGxpdCgpDQo+ICAgICAgICAgLT4gaGZzX2JtYXBfYWxsb2MoKQ0K
PiAgICAgICAgICAgLT4gaGZzX2Jub2RlX2ZpbmQodHJlZSwgMCkNCj4gICAgICAgICAgICAgLT4g
X19oZnNfYm5vZGVfY3JlYXRlKHRyZWUsIDApDQo+IA0KPiBJbiB0aGlzIGNhc2UsIHRocmVhZCBB
IGNyZWF0ZXMgdGhlIGJub2RlLCBzZXRzIHJlZmNudD0xLCBhbmQgaGFzaGVzIGl0Lg0KPiBUaHJl
YWQgQiBhbHNvIHRyaWVzIHRvIGNyZWF0ZSB0aGUgc2FtZSBibm9kZSwgbm90aWNlcyBpdCBoYXMg
YWxyZWFkeQ0KPiBiZWVuIGluc2VydGVkLCBkcm9wcyBpdHMgb3duIGluc3RhbmNlLCBhbmQgdXNl
cyB0aGUgaGFzaGVkIG9uZSB3aXRob3V0DQo+IGdldHRpbmcgdGhlIG5vZGUuDQo+IA0KPiBgYGAN
Cj4gDQo+IAlub2RlMiA9IGhmc19ibm9kZV9maW5kaGFzaCh0cmVlLCBjbmlkKTsNCj4gCWlmICgh
bm9kZTIpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8LSBUaHJlYWQgQQ0KPiAJ
CWhhc2ggPSBoZnNfYm5vZGVfaGFzaChjbmlkKTsNCj4gCQlub2RlLT5uZXh0X2hhc2ggPSB0cmVl
LT5ub2RlX2hhc2hbaGFzaF07DQo+IAkJdHJlZS0+bm9kZV9oYXNoW2hhc2hdID0gbm9kZTsNCj4g
CQl0cmVlLT5ub2RlX2hhc2hfY250Kys7DQo+IAl9IGVsc2UgeyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPC0gVGhyZWFkIEINCj4gCQlzcGluX3VubG9jaygmdHJlZS0+aGFz
aF9sb2NrKTsNCj4gCQlrZnJlZShub2RlKTsNCj4gCQl3YWl0X2V2ZW50KG5vZGUyLT5sb2NrX3dx
LA0KPiAJCQkhdGVzdF9iaXQoSEZTX0JOT0RFX05FVywgJm5vZGUyLT5mbGFncykpOw0KPiAJCXJl
dHVybiBub2RlMjsNCj4gCX0NCj4gYGBgDQo+IA0KPiBIb3dldmVyLCBoZnNfYm5vZGVfZmluZCgp
IHJlcXVpcmVzIGVhY2ggY2FsbCB0byB0YWtlIGEgcmVmZXJlbmNlLg0KPiBIZXJlIGJvdGggdGhy
ZWFkcyBlbmQgdXAgc2V0dGluZyByZWZjbnQ9MS4gV2hlbiB0aGV5IGxhdGVyIHB1dCB0aGUgbm9k
ZSwNCj4gdGhpcyB0cmlnZ2VyczoNCj4gDQo+IEJVR19PTighYXRvbWljX3JlYWQoJm5vZGUtPnJl
ZmNudCkpDQo+IA0KPiBJbiB0aGlzIHNjZW5hcmlvLCBUaHJlYWQgQiBpbiBmYWN0IGZpbmRzIHRo
ZSBub2RlIGluIHRoZSBoYXNoIHRhYmxlDQo+IHJhdGhlciB0aGFuIGNyZWF0aW5nIGEgbmV3IG9u
ZSwgYW5kIHRodXMgbXVzdCB0YWtlIGEgcmVmZXJlbmNlLg0KPiANCj4gRml4IHRoaXMgYnkgY2Fs
bGluZyBoZnNfYm5vZGVfZ2V0KCkgd2hlbiByZXVzaW5nIGEgYm5vZGUgbmV3bHkgY3JlYXRlZCBi
eQ0KPiBhbm90aGVyIHRocmVhZCB0byBlbnN1cmUgdGhlIHJlZmNvdW50IGlzIHVwZGF0ZWQgY29y
cmVjdGx5Lg0KPiANCj4gQSBzaW1pbGFyIGJ1ZyB3YXMgZml4ZWQgaW4gSEZTIGxvbmcgYWdvIGlu
IGNvbW1pdA0KPiBhOWRjMDg3ZmQzYzQgKCJmaXggbWlzc2luZyBoZnNfYm5vZGVfZ2V0KCkgaW4g
X19oZnNfYm5vZGVfY3JlYXRlIikNCj4gYnV0IHRoZSBzYW1lIGlzc3VlIHJlbWFpbmVkIGluIEhG
UysgdW50aWwgbm93Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCswMDVkMmE5ZWNkOWZiZjUy
NWY2YUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgQ2hl
bnpoaSA8eWFuZy5jaGVuemhpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvYm5vZGUu
YyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvaGZzcGx1cy9ibm9kZS5jIGIvZnMvaGZzcGx1cy9ibm9kZS5jDQo+IGluZGV4IDE0
ZjQ5OTU1ODhmZi4uZTc3NGJkNGY0MGMzIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2Jub2Rl
LmMNCj4gKysrIGIvZnMvaGZzcGx1cy9ibm9kZS5jDQo+IEBAIC01MjIsNiArNTIyLDcgQEAgc3Rh
dGljIHN0cnVjdCBoZnNfYm5vZGUgKl9faGZzX2Jub2RlX2NyZWF0ZShzdHJ1Y3QgaGZzX2J0cmVl
ICp0cmVlLCB1MzIgY25pZCkNCj4gIAkJdHJlZS0+bm9kZV9oYXNoW2hhc2hdID0gbm9kZTsNCj4g
IAkJdHJlZS0+bm9kZV9oYXNoX2NudCsrOw0KPiAgCX0gZWxzZSB7DQo+ICsJCWhmc19ibm9kZV9n
ZXQobm9kZTIpOw0KPiAgCQlzcGluX3VubG9jaygmdHJlZS0+aGFzaF9sb2NrKTsNCj4gIAkJa2Zy
ZWUobm9kZSk7DQo+ICAJCXdhaXRfZXZlbnQobm9kZTItPmxvY2tfd3EsDQo=

