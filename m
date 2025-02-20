Return-Path: <linux-fsdevel+bounces-42146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39110A3D155
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F91F1898B68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61F1E25FA;
	Thu, 20 Feb 2025 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Df0CUJ6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3071632DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032536; cv=fail; b=ohDcVgDix/I0Z4G92XG+MKOX0QHGSeSSi6XWJyzSXrIT25xAEp7iU5T1SfE6+uU8dkN+8xdI/0ap8x2ua/EMme6bqJPsNTYeQb0Z9tMFJ++fQMRIkHcmjVy8KaZLQkjUQESKbvla4QE7vuulVR/5TVTzZk7++LyZ+b+A8p5MWCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032536; c=relaxed/simple;
	bh=isExXh6KJir9RSZKPDHppnvTVIC1B0eCxJAw6PSyzWI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Tj38LJkGEeZZgp64rGzKM/ffCJE7RGsMxLFxtz7fiwjhE0vqBbpLYqwmYWEytqm5tWq7PI5ZVopCX5xRMlbj1Z51WAvAOMregGkGB6Y4eOYqDq1l9ehOVcRQr14Yi/NbCRdirHq4LCgQq3CtybKvnawf/4bE4r8iOhvyjdaP7oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Df0CUJ6U; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JNrOil032557;
	Thu, 20 Feb 2025 06:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=isExXh6KJir9RSZKPDHppnvTVIC1B
	0eCxJAw6PSyzWI=; b=Df0CUJ6UQGf/HXrEmtOw345FEWiErcCosONxKG6oPNkpI
	PLJ8UCVVmMjfDS603IBg9w3V+R1Fq1PxYn6CnOj4cLtE8QiC6cKMzr8nlesu2Y64
	vmZjfF/O7OmOPIbeWrdjOYw+l1hjHL++h5jOTXLAEUKN/42QAmMv3tC0+81yWlrX
	QA6ZyZRZlKq+ahqRMyK8L4pNmrKnnbk5Le0XLk28uihxjtTgjyfD70iUQCEBqaO2
	AbVAoba+laTbB2EyOkn+HZ6/WKuwTJRegBDP98hwXCQ6zCGH35qy3vyDyiZ2o1P+
	irmkR3k97N8inXYuywX27JCrk5Tm3b4pBjZ3PClMA==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2112.outbound.protection.outlook.com [104.47.26.112])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyf1fjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:22:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2nOSa8E9bH0H6FEPMRwux5Nh44+PXd8DgKPIT8M330g/3OXd2qZVP1GcrO0qhbQSRWH1O9zFXQNvn4jcVSdwYi2dXwo0r20BY6BMNQYyfSiHCuAWyZ9Sc9Z6cHq9lRSMWJY71ImFWHqB60VApdz8p5WlWNVNhUInCyYbUaYcwXO1zd1iTqK+sgNaSLkXxM4lRotmyYLsuk1bI3lsIBEeq02M12LzMaEhPQdFFmNnUe18r9+wenkQ/8RT/N2+S3xf3GYheYEXB6wJgTi0VQLC4UGqO68Kb0Pkls72IelkxSg/h6RiFDaM5ojQJSIK+xPBUP4wuUMJM2xXumr6T9qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isExXh6KJir9RSZKPDHppnvTVIC1B0eCxJAw6PSyzWI=;
 b=ZJIOctw2cfObaBjxBuEV4AefrQzAwsWrXRzx96ODizKYmX1/nF0neanPAO3QKYYwZp4tDLnBIStRl/ITbdkf1OnDSeMJbScSIGnE2aMnrCEY8sUdd8YXd3VrIFvezQymd4wj7/rv6fUAkXQaiuASTdD85t8y0jrHQFte1ChPQ68JbL/sovTUsfjmLNingLgKxuZFmkhh9WmdBKnzJmyd83S2UI8pJ90rMbDpEzfBsyLBcpquaD2JBLgSws6w9ajWVKRhldUoCPkHDWbe4Q3whDWUkd8CGi2qU9Rb5/vCNtsNK9bHZGLEqnwhQUcOND3m6crs+RnjjNmPmvqmVVeyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:22:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:22:00 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: add a check for invalid data size
Thread-Topic: [PATCH v1] exfat: add a check for invalid data size
Thread-Index: AduDXkoznFOvDQ6PQSuo8rAaljtCHA==
Date: Thu, 20 Feb 2025 06:22:00 +0000
Message-ID:
 <PUZPR04MB63168C6BCDA70FE0BFE12A5381C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: e7c2e704-f147-4a78-9103-08dd5176e295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjdVVU1qaHA1SkttYTMyendzMDM2ZU9NVWx4TkZCbkl1VFFoaXcwR1puT1hU?=
 =?utf-8?B?cmhsT0podG1HZk5odDRaVkRYNjBzMHhMdnZsMzFoVGpMZ25BUHE5WUVCY0to?=
 =?utf-8?B?S3RiSlBQaFhFSFFmNHFZMW1zdjB0czEzVlJ3eU0vc2ZZVWdMV0ZIYVVxT1hG?=
 =?utf-8?B?eVFhUVAwL21PUXJaWlZqeU1QZ251S2lPaUJCc3JmVUxYeFcweXBQdUpLK2Nu?=
 =?utf-8?B?Ylk4ZTB0cWZ4eGhpWGcxV1dVaTBmNGFabUp0V1E3a3hua0d5NmY5QXI3cFF4?=
 =?utf-8?B?YjdNTUtxbi9YMVdTUGFIMXBqOC9DSUtxcWRVTm5VUWN5Yk5HbW1yT1Bjb2tn?=
 =?utf-8?B?czdNcnp1RlBOb0JLMCsrVEJRaW9mbm8zQ2JFYVhiWVpuTEZEdXNkak1JVUd6?=
 =?utf-8?B?Wk5KUHc5NXRHeWRwNGN6RlFKS3hCMHpWa3oyU3pwTEJsb3l0b2VwTHZWUkFp?=
 =?utf-8?B?Y2lHYVZJaVljMFNwR2hpQzhLdU5PQ0xMNzBOcDJobHc5UW5wY3BEUTQvei91?=
 =?utf-8?B?eDlVSFBRKzhxdmNWczhtbUxQV3pNbzNKcG9HQXo4eW93eDFVRENJZFJHcW54?=
 =?utf-8?B?TGhpeFhYZ0FZbHJlZ3RvTlBvTXVod1diWE9kb2RybVdZT3ZqSWxpMkYwKzFL?=
 =?utf-8?B?VzVqN2ZHR0hhdmpIK29aS3NHemZTQnh2WTdZbDRwZnRMczJYWFRyOUsvRW9L?=
 =?utf-8?B?UXVnZjVTVWNhc2NFbWJyY0s5NlMwRWd0dHR0T0RlcFNtN2w1cnh6WENRZnU5?=
 =?utf-8?B?N1o3Z21QbmNJaG9HVjJtcG1wYnFIWlFMbTlZeUdtTUhtZFBJcmNCL1Z3QURs?=
 =?utf-8?B?blpJT3lvdVVhcDZQYk0wUnNxR0Jlalh6R0FRMjZIU0pMRGxVd0poOWVJMlhh?=
 =?utf-8?B?ZnI1MmxYTnRGNGo1Y2ZVMDJGQ05MWFMyVW5qZTI5NnlIK2gvcEpQQnBJNEZw?=
 =?utf-8?B?dnFuYmVOZnJqbGllOTN5UkN2YmZXS1ZBY2U1d0NvWmZKMG9JbFBGTVJiM2ZU?=
 =?utf-8?B?ck11Nzd2aGp3aDZTNHFreDJFcE45bE1QQnRuQ2VmdWZ0czJvSlJyS2dCalU0?=
 =?utf-8?B?bEI4QUtNZ2REYk4valZjZVFRcHBnL1MwSFhNWmhUTFovcEh6WWllYUJNUEpK?=
 =?utf-8?B?RTNKYmdETUdjK0lRdnFxcG14a2RjSUFvbkJrWjJlNThzenpiZ3V1aWJvNTc0?=
 =?utf-8?B?Tmx4Nm1BRkZIdGYrckZzS0ZyOVNjdUUxZFV4VmRnUUl1T1d4OVF5RjR3NjNG?=
 =?utf-8?B?UWpYWGRsWlNMUVU4dkhVUFdxcXcxanFaTVNqWEthZXNUZ09QeFZJVkFFZFlX?=
 =?utf-8?B?RlZ0eGRGVnE1SE9pWEhPaHpBZWZWcUJQM0tQbzZjU0Z2cDRZVzBnQ1I0VFdx?=
 =?utf-8?B?d1dyclJ0d3VFWGVTT2h0dWNzbk1UVW85VEFoa0VBS2N0YjdvbW9wdTFKTEVp?=
 =?utf-8?B?S0d2cGNOakRmU3Y2ZnNTclRBRFovb3gzWFFyWUw2UHFqckx3SWliYkZNb0Vu?=
 =?utf-8?B?ZVdyd3Qycmlpek1yY3BiV1IzeVlyN0YzaFFMeVFrcGNFdnR1SUxhcVpvWmNn?=
 =?utf-8?B?b1gwWkJnS1FXV2RURVk3Yi85b0hmb3lRK2lyb0o0K25IenFOVzJlMXJKclVY?=
 =?utf-8?B?ZVFqQlJPWkpTNnY2Zi9FU05MZ2g2TFJOV2NvTk9mTExJQUdyQlFrYWZoU3M5?=
 =?utf-8?B?bytTWStsenJuUHFXL0ZvOGRpT2oyRFI1VVVDNndJQzd1eVExdVpCVFBUSWNE?=
 =?utf-8?B?R2kvaHNYeVRNWTFiQ1JFYlJ2RnBaNWExK0VVdFdqY3h1b2cySHdVUEp3RFVG?=
 =?utf-8?B?SUpscGw4WUYvV1RZdDl0NlNzMStobUdiTTN3dEtXckk5bWZrQXpzcU9uZHZF?=
 =?utf-8?B?V1B2K0p1akhjYW1USktKN3YyRitRSUEya0NIY2VYbnN2cmZEa01tZ0JVNXd1?=
 =?utf-8?Q?UAOzemGiUFMRWCJZ3fNzxavUOiPmugEI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bURleDBLcXhHSUdkRlBiSFZOYkcxVEhyUkFUOHVkNU5pMXZhUVlBaitGQ1R5?=
 =?utf-8?B?MmJHc2xtUGpVa1dwZitteXdJYUlpOEZwU0RaOEkrc0xDbHoxbTRyQ1pFMktr?=
 =?utf-8?B?YTdLZGg3VCtRVE1ta2kyUkdZQjVNSk9uVFNBeEEvbFBZck9RQ0FtT3dETzNn?=
 =?utf-8?B?RUJtYThKeWN6bCs0U05sU2NVdXcya0wrR0VhQ2IycnZTSlE2YjRodWZxaU5p?=
 =?utf-8?B?WGxFaHRXaTVYYklrRUJMbjVzQmtkK2tCOFZuYVg3aCtkOVMxL24xOEk4d2pC?=
 =?utf-8?B?a3pzdmpwam5GdGVIUnlVY0dnV0ZmY09Pcld0ano1TlhEcXFYY0JYMW1IcVZG?=
 =?utf-8?B?bS9kellCb1kvWlo3UmFNT2dzSno5T1hzTDk1aENxVHZiUjZOWTRvaHU4VEE2?=
 =?utf-8?B?M0w1d1FjMmZjYXo4RUc5UzZ5b0Q2UXZxdUR6T3hRMXc1RVgzaEJwQ2kwWkZF?=
 =?utf-8?B?SzBnOHFmMTZYUlJrMUJMaGVhWDNxZ2d1UG5hZ0FrSEhISmtnS21RUmxRWVdw?=
 =?utf-8?B?R2ZQdGRJY2tLSCtWd1VQVGUxY2c3eTNrMW03RURTNHo2dE1iTG03RmlBL0xa?=
 =?utf-8?B?RUV0UHdJQmh0WFNGemNZSTBDM0NOMGZQQWw4RHZ1TlBRMktjUTVYYXBwRWxV?=
 =?utf-8?B?YlZzUDBYVjlVdGNjNkZsS3RaTitQMnZudjUrWUZ6OWlEaEVYOE45VGxNN3Bj?=
 =?utf-8?B?a2VIdjhtOCtJNVVkK0g4TkE3b2ZRMXVBcHBxQnFnLzNPQlMwRWZyczlWbUxD?=
 =?utf-8?B?NnhYWEtmdFFLalIzanR1eWl5L3dLUFVzQVJxUE5ScW53bVVDMTlRYll5WVNa?=
 =?utf-8?B?d1NGTXVoQzFWUTV0WWIzWE1PTWVLQUhCVTgzQmN0ajRncUFGdUNSc0wxVkYv?=
 =?utf-8?B?cDY0WXdZdnVPWVV0UFNSOTg4WkFJMmlORzQ5OFN5OXFmdWFneFlwa2JndDE2?=
 =?utf-8?B?R25xL2wxdkdnTGVVMWI1aXdZeXdXa0gxdWhJREFtU0pFS25KUEk2M2FGRU5o?=
 =?utf-8?B?UXQ5V3F0OHM3SmY0RWpEWDFvT3V6MnFERjRZblNXdHR6eG9lb3lVdGErQ2Qy?=
 =?utf-8?B?dW5BQjhxMUwwYVFPVTVVbHVNclBSMklrZElBNDdhK0VwbURPM1RQUnRwNDVW?=
 =?utf-8?B?dnNpaXZpR0poRmNyME9GdHo2SkhSeDU4K1U2d2JZczU5cDUwUFRxUTg4aTVl?=
 =?utf-8?B?UHNwM0gyZFBwekRsby9pYU9PYlBQS28wL0hjcG5pRVc1czZNa0N0dHNPdnM2?=
 =?utf-8?B?bUlWUE5aU2NXWlVJcEZia1NQS1dGVFhuSWFicmR1VnJaZXBnREhIbHFnbG94?=
 =?utf-8?B?YXA0bXppK0NiOWJGY3dhOHFJVVl5N29Qald0SU80cDRIZnNNV0hDOGdLN1FJ?=
 =?utf-8?B?V3hDRmJJYk1jN0hSYjlDV2M0M1dWLzlsRm9YRVlEdXMvZm5pUnNlZWpOd1lr?=
 =?utf-8?B?Y2VXUzZkTFpLQk9oa1hxS1pxalo4cXNvQ0x5NkFYbCt6MnQwSjlnSWtBOHlx?=
 =?utf-8?B?Z1NqSDJzY0hLK1ZvSGlLSjhYUzloL0ROZ2h5a1dsNWtLL3NCY0NUd2l5c0hs?=
 =?utf-8?B?NG50VHI5U20vRlZNQVhhQUNVRlJNRElST0RJRjlvRzhTUHF1NE5jaklGWnhY?=
 =?utf-8?B?ZEQwcis4OXk4UjhJb05pQ3JjVGJiWS9qdTVpSDBQemtDTnNxem8yKzVVQzNw?=
 =?utf-8?B?UDZMUys3ZGFVMno1T01uekZ0OEtnQm5aQ1FvRk5CMzF4YStOZHJXUGdGZEt3?=
 =?utf-8?B?ZnRaQldDZVVqWks3TXZ2dkxrS253c2xQTnlkMVJVdkZYLzQ5a2VjNzhxdWx3?=
 =?utf-8?B?bEc0SER6MVpZcEFCUHJ5RmNZZ040OE1ySlJuZjlBV0FYeWF5dG9adG1WOU1P?=
 =?utf-8?B?UnQ3VitMcGhZbW5xOU9hc1oydjZCYjlJRmc1SlY5ZFA5SGRyMkUxdjNhWmQ5?=
 =?utf-8?B?aGVmN0l5ZThXVHRHYjhjczNzc3hJa2thTXJKQStxRmUyeWZmeEV5allDWFlZ?=
 =?utf-8?B?c3hmSWhTUEptcnlsejRjZXZlZVFOOVVWaW4vWHhrMHpnY3haeS9rZ2g3dEIv?=
 =?utf-8?B?VzVaQ1F5YkVOQ0YzSC8weUxQVjJyNUozWXhHY2R2bFcwbi8zNXNLTWN1QXdr?=
 =?utf-8?Q?iB2vWtJsa4HgkcjRVXSvxCQjG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlonKkkKcfkz+UswZeyyguulK8ffnNK9JoEHYl/mMZOApeGsVY5Omo7pQMBMaBdRC4+3UX+Lv/Q2/0Sk/qeGFfPWCO09pyG64sBGu4R9G/KvNWxCpscujHadNdCqH8lK6chS//3NHN/WI3k7gzoeyhH7rn6ORsIRh2C+jKl0pCUFTDoI3cnZB8RS2WA44j6MaFvQKF51jHz6ii+jcL32bBJWvxqjJOTJyaqrCR2mmE8l8OyAiOzPqRuNCXmVbkKz5hUjFei/aFDQMevAAYYW/r8DnS5VNfpET5JIOj+PRyLkeEDBvgiAxJsbvg351/NcjYqoVuqLBhwFt1IraJwBSZxZtjkg3YA63uy+kpRXiA0p+EFD5BnfYR8aew4ZiX7Hnxj5+6oAnpYMbXU0PfQ1B+b+SYzmIfeEy2UHYy1LFCnI9lLG3AEA5jtBMmKxE98rOuBtn66zmeOeikA9d/Cy5l4+YYx/7uSwmxLCnAhf3+piffShZ++mqvEj7frW3ia+1NCSE7uoqf2BzCXEyhD6uZyYzr/KnedVgFvB/pRewesmTGfyH9xecJvq6/j8E7PgSaNg7aW7Lark/GwncW6SXg0glYGU+bxZ+Kt0K+rLivmpSsrIlevNWEtQNFHF2DJO
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c2e704-f147-4a78-9103-08dd5176e295
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:22:00.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02nHNCUpFNbVMxcDKPKsvHLw9Fa9cLPDlBl1HVWFhBQU0OU0hw018zK8TKa9UI7A+U68h94m2WXP50i0n/a/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-GUID: jnOG9tL22xCngeWgotCq1dcbm6bOzfZJ
X-Proofpoint-ORIG-GUID: jnOG9tL22xCngeWgotCq1dcbm6bOzfZJ
X-Sony-Outbound-GUID: jnOG9tL22xCngeWgotCq1dcbm6bOzfZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01

QWRkIGEgY2hlY2sgZm9yIGludmFsaWQgZGF0YSBzaXplIHRvIGF2b2lkIGNvcnJ1cHRlZCBmaWxl
c3lzdGVtDQpmcm9tIGJlaW5nIGZ1cnRoZXIgY29ycnVwdGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBZ
dWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5j
IHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCA5OTk2Y2E2MWM4
NWIuLmE4ZjlkYjJmY2I0OSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2Zz
L2V4ZmF0L25hbWVpLmMNCkBAIC02NTEsNiArNjUxLDExIEBAIHN0YXRpYyBpbnQgZXhmYXRfZmlu
ZChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IHFzdHIgKnFuYW1lLA0KIAlpbmZvLT52YWxpZF9z
aXplID0gbGU2NF90b19jcHUoZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUpOw0KIAlpbmZv
LT5zaXplID0gbGU2NF90b19jcHUoZXAyLT5kZW50cnkuc3RyZWFtLnNpemUpOw0KIA0KKwlpZiAo
dW5saWtlbHkoRVhGQVRfQl9UT19DTFVfUk9VTkRfVVAoaW5mby0+c2l6ZSwgc2JpKSA+IHNiaS0+
dXNlZF9jbHVzdGVycykpIHsNCisJCWV4ZmF0X2ZzX2Vycm9yKHNiLCAiZGF0YSBzaXplIGlzIGlu
dmFsaWQoJWxsZCkiLCBpbmZvLT5zaXplKTsNCisJCXJldHVybiAtRUlPOw0KKwl9DQorDQogCWlu
Zm8tPnN0YXJ0X2NsdSA9IGxlMzJfdG9fY3B1KGVwMi0+ZGVudHJ5LnN0cmVhbS5zdGFydF9jbHUp
Ow0KIAlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBpbmZvLT5zdGFydF9jbHUpICYmIGluZm8t
PnNpemUpIHsNCiAJCWV4ZmF0X3dhcm4oc2IsICJzdGFydF9jbHUgaXMgaW52YWxpZCBjbHVzdGVy
KDB4JXgpIiwNCi0tIA0KMi40My4wDQoNCg==

