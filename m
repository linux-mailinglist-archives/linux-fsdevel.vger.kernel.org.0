Return-Path: <linux-fsdevel+bounces-8470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F311837176
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B1B2939D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECC50A8A;
	Mon, 22 Jan 2024 18:33:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2054.outbound.protection.outlook.com [40.92.89.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93A3CF75;
	Mon, 22 Jan 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948405; cv=fail; b=UvZfCCxwc1xpTIv6Ct0hn+dlxcNNWrmcbpKiSv78lcXQ8ZafUi3jm22mUc6n7zgAF1bPFOutBevvXvFkym60TLe8rReg3QC2OzRLdpl/ixpKPB+BjphhnDZxiT20/LYav3ts8UC1uroEXZPNDQg3Yw8d0q/CtorFmay0/tx/N2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948405; c=relaxed/simple;
	bh=Ecvv2e9tns5KE1K6Jzhlh0/48ShEbOyp0+SrsRTurUk=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFj+xEvB39R+szNcz0a1dZNOWKkeUsvRQxCwffYGqP+r/FscbDXulRofQ9YeCyPFUkQiwMylaPGwfDH7ancKtqpXXmPRQL9gE2DWE4mmBGVgIOD7+MGl0maZJnt3d/qBAmhcCaXEm6FIMZO0FUXUHHIszGVWfOQ7Y0WOP7CmbDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.89.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkOdTRwSE6+PIQIH4NYVDoXe90P+bT856Eg6iELqh+OIu0gWDikP0T19jJ1uPF1EWcvW0qVvgBwkNR1ZolQOupqP1B6QxbCJaltt4ocofTVUdE7BTBRfW2p3t/6knwFeEguQe+VLZN9y6Rr1XybMJwrgvoXC6CKydKmUadXo724EV7CDQqk/EEye5c4mtwKIc3uJTl8E/CDVINNH5rOb3En8YFX3k4gLa1tirXiZwLFRDw+H9AnLJskwhVXf1+yJjN4RR68g9TyKXwldQKzNlPEUqUXyC6WWXsejGY6XmHe/LN6XnFvwCIJL3LGOy9KHn4pXBOHJJ/A9flUuGJytAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkLkCMGS0Kslf9FUZQDS7mtYKmevNVfHKUnmnRDYttI=;
 b=hbDK0LcsR7lawkduQtpnV63zn7KkogsCdg1k6N6x6Vl6Z2CyEVs6tBDZCTDRP0VHA4Cdf2hLNpUxtr4/UA7EKbugBjki2ggzoBinPM5qLa0n+5YbUFaPIKMnFRTUGh1J6Iy9ze2+uQiu/j/ILngLD1X5c2mXhez5m7gCXxKKMx6VBCvBjIHW9EF23EamhaxtH0+FaKe/QDms+UVTp6s7sC/xmKgGIE9bIJlYULEtf9LeFRTojTLLTG6bvN23nKs8ECqtkQgrze6DOyaOfJgYhzqfMdiVd+pju4UvLU0pP0WB+aHnsUPHPQOJapT0h1WRbiF8tzepiGrCLC/s9RJ1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AS8P193MB2111.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:33:22 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 18:33:22 +0000
Message-ID:
 <AS8P193MB128517ADB5EFF29E04389EDAE4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 19:34:21 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] Fix error handling in begin_new_exec
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-mm@kvack.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285304CE97348D62021C878E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P193MB1285304CE97348D62021C878E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [FGDY1yHzdZc6FFv+Zt52tbL3ygr+LKpoOcr/HFmWL0igZMlPLETmsvVpaEXSjg6t]
X-ClientProxiedBy: BE1P281CA0479.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::23) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <1656ab24-26f4-4572-8bfc-663b533db78b@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AS8P193MB2111:EE_
X-MS-Office365-Filtering-Correlation-Id: 59987384-b291-4ad9-0ba0-08dc1b789cad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1esE7zODz6EQvuNjGr+whIqrgLTYUoN/wLktW+mrjG5HP+1Ri+7rRIrQp3RyhMz9eQNEofwkI8C8tuh0lOP1iTeEydh2bONLWQ7EatyH3Ma8YMvzIA9en5+0yssdRhCC8LDTbkBMTvxqWkzrXGypTe5ckz/dbjeZWh71e3I0nfZzhq1chVqf5iXu2YuMFVIxX3sa5rKY8UTVyvyTWTCyC5KuD/a6qA3iysOcWhWHo2no6jPEGjTmwLMUaBb2inPyNvqGqeqMcnez+fjleK0JtYVlj6C+e+TbO6BxX0l7feS1iZAI0Rj9RMtrBrBUIm88iEhZVEMmGHAD2YHrrf5PydVFa89aKO8A6t8sH6eaQw99cNd0uUSvfQfTd8gG6CrAxv/MduedwBmYcOlKIcXo+Kwn1x6F1qc5C1H08adQSClyTI3Cw9IrZGb7vz1mLun4Q7OLBqVsQy3oWIMyGX8Bsr2zoao+KWTLMXvLBHDXfUfw8oEsyNTc1Kaep995A5R8lRmtCnbpZs2H6MUf5dhdcVW+gwGY45mzfubIt8eUgNpGw2Oqrz8SukLDhrFcLKAa9aOzMLT3tf45R6A1FZ6p/RR31MpiRY7CG1oo510P2NE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akdybzU1VGhaKy9heERWT3kvUzlvTkxOelBQY0N4YVF4MlJodjV2V0pnWnFP?=
 =?utf-8?B?NmtXTDFtNGtnZUlMdko1RS9wZWN3SWw5dTFYTXU3d2dXSHVmQVhkQWw3eG5D?=
 =?utf-8?B?akdIZ2ZRUHF5NThSNk5TdExsSzV3Wm9lMFp2ZHdCOHFLNm1nMzBJRnFVaXNu?=
 =?utf-8?B?ZlF0ZmIyWUZ2Q0xtZDlRNDY1UG9wTlphTGtReE5nV3RBSFVZZXBQZGZia091?=
 =?utf-8?B?RTBYMWEvUTZSMjIrS0pJcC91WXY0dldLWGlPajJod2Y0RXJLUUhEc0ZaVmRq?=
 =?utf-8?B?eVFabmpzcGYvSEFJdDVMWHFhR0d2SnlQcVo5K1kyNnFYSWdkb3lQUWpoK3dn?=
 =?utf-8?B?RnNISG5Zb2w2TEpHTWQwd3pFUDNOeDF6aEhaUG92anpkZ1VnT3p1K1pNRmY2?=
 =?utf-8?B?S1A5K3d2a2JoWWlpcUttelNVOGZoMlV1TVBWMy8yeXI4TC96dzJ5WWN6aCt5?=
 =?utf-8?B?ZnBrQUtJOEUrTVFBYTJCV3AxcDVzV09tUnlXamQxbHZONEhqYzJxblpEVFox?=
 =?utf-8?B?ejFHL3JRbjR6SjRmaW1Ld2ZKS1h1bDBHaDdkdGJMUGRjVVhaVGI0UkF3eGFu?=
 =?utf-8?B?M3BLTHBkQjNiaG02Y1pvOUdxOS9rdmRraHpWMk5WMjhKWmNzSTRhT2llUWZO?=
 =?utf-8?B?emdHaGJaemxZaUhRUm15ZE5YMFV1cTdVMWJXcUppdGJQdXJ6OS90VVlZMjNm?=
 =?utf-8?B?OTRpT2FzcUpEUStxTWR4Qm41R1NVVFNhMFV0eVZDRGNPRmhUNFpoRG52SSs3?=
 =?utf-8?B?OFJ3a24vVHNwbGhicDNWM1JKV1FkT2xmSEw3aU56TUU2YTlyemJPWGVmaGha?=
 =?utf-8?B?YkdGOUVudXRpdk1BRkxZdTVLa0ZTMkZjMXE3ME5sOWgwdm41cHM0MlFHU2l1?=
 =?utf-8?B?bW5Od0g4YXBuaW5ZSjBTQzl5eEFWOS85NzFuS29yM3IrSWQrRzNJWVp3bm5Q?=
 =?utf-8?B?UlZqWmxyL3hmTkRUN2YrbFRIVEdyeE1IRjF5ZHM5Y1VjcXRVSEJsSXprNlNJ?=
 =?utf-8?B?MWFOYnBNRWdEdHh3YWYwRFE5bEp1NUV6aWlWazJodTlZOVpxUHFjelJZb0sx?=
 =?utf-8?B?YWpyWWdIeVV6Z0pleU9ici9zZitnbTdVeEh5U2FyZU1KSDZCcE1HRWw0TU9l?=
 =?utf-8?B?QXp1WEJnUnJRTmxnSm9peDVsN1NzS3FpNXFwNllHWGl2a3VPTUZPZlVFVGdQ?=
 =?utf-8?B?a1pxREUvTlBMR1VIeVRVNTBlb2hDaEhJeEFId3pnZ0d5dFR0eFZIczV1S3Bp?=
 =?utf-8?B?cURUS0MxTkdyRXlQdlNNSmdvRUE2YWpmU3VPZ1drNjhRZG9JWTh6UUo0NW0y?=
 =?utf-8?B?V0dnMTZqZFFQbFFjZW5sYUhDdTg5dS9vUldJSGpEd1pMa3JQY3Mvc21IazhQ?=
 =?utf-8?B?R1BHTnpUNEZNSzk2MEZkR1pXSGdNSDZCWUp0MnBiT1pKY3VYQ3ZnczByaDkw?=
 =?utf-8?B?dEpRSzdDMWxmODBmNjZFM3F2Q3hiVHRRcFdQWXRUMG9oWFQxbHNtb0RWL3F0?=
 =?utf-8?B?NGtMRXNVZzlVQXRPZGhWS0tjSS95Y0RNakE1UlR5TGdBTGg1NVhrYkt6WUxE?=
 =?utf-8?B?alpKZlRFZVBZcUcxWnBWMXZ0eU9ncEZhQ01CNGF2aDJMQUtsNSswaVppSDdZ?=
 =?utf-8?B?czNLWFIveXZFMitmalRML0N0TWZyRkc5ZjZkNW0reDA1ZXM4OFhnc2p5ME13?=
 =?utf-8?B?bzE1dGJ1MmtzZ2hoUzN6d1doSXpvNUlPN0FnajB6YWFsTDFnc1RqZm0vOTVo?=
 =?utf-8?Q?/UyhavO8ZZ4Mbt61ig=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59987384-b291-4ad9-0ba0-08dc1b789cad
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:33:22.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2111

If get_unused_fd_flags() fails, the error handling is incomplete
because bprm->cred is already set to NULL, and therefore
free_bprm will not unlock the cred_guard_mutex.
Note there are two error conditions which end up here,
one before and one after bprm->cred is cleared.

Fixes: b8a61c9e7b4a ("exec: Generic execfd support")
Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

v2: rebased to v6.7, retested and updated the commit message
to fix a checkpatch.pl style nit about the too short sha1 hash
in the Fixes: statement.
And retained Eric's Acked-by from:
https://lore.kernel.org/lkml/87mts2kcrm.fsf@disp2133/

v3: removed empty lines after Fixes: and Signed-off-by: header.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 8cdd5b2dd09c..e88249a1ce07 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1409,6 +1409,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 out_unlock:
 	up_write(&me->signal->exec_update_lock);
+	if (!bprm->cred)
+		mutex_unlock(&me->signal->cred_guard_mutex);
+
 out:
 	return retval;
 }
-- 
2.39.2

