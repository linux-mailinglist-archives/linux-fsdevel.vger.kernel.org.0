Return-Path: <linux-fsdevel+bounces-7995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7F82E090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D31F1C2217D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640318C15;
	Mon, 15 Jan 2024 19:21:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2018.outbound.protection.outlook.com [40.92.89.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902818B06;
	Mon, 15 Jan 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL13MTG1jBs/bOZwWbe99GtS7RqPFove1yz7oKIeEFu+4+sdh1YJqzHZRzhj3a7s4QbpsuFz0r3TeOG95xgbxhIJFYtk2/6eQvkqRkhfS4Z8dd8mQmrrkuC9UA/5irDAW5hxool+TNOLFk9cQE9UwxXFCdrvs5Vf5JcKc4Ry+7M0tRXnLpZlo+ZMUxApjuKfZkMGJB93Hnm9/r+ujN2mf2riDOMKnodpKMH1ehjCH61rRsPPT1F/QkdvEOJCtNGy8SPE3P92Jn2zr2ksIkaaN4pYMxnDlKYXVsssAtFxmasG2JA7Q3ocN4O0C2xSIl9da3sFq/v52SErj+1P3O7rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prKcv9FFHnoPvw/RQdUAK33x217BpS9lQMjRrsTAOTs=;
 b=APzSbBSDeZgUcWHONOA3UXWeG90/BLLRoy7ELx5sYv4JoWxE6qKoFXC0yhTSWQOWjPlWERoV0TBndsdySPc8c2oaA3OrCULBj8nUYibDfpbD/xwhvv1Awjmtg6LZPs2qdagzC0EBBc8YnzDt4EndvVCNU1bKKpOeUBLZpsN/tD7svxcYDgJqw0DQXAKcvVk6p602p9yh1FnLFLDkJADCjRldbaegHLxeIfzxcTSO4d9O5p2uhAiw+Vyt7nHIjTa6aeKQcgYDU9pL0Zj+TmNxAB2C+hKPWF9N+eB9gNE5+9eR9NrQn5w7nUIDAdMWZ6Fbkqgt4yL4UF4oCh+FPGT1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM0P193MB0769.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 19:21:05 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:21:05 +0000
Message-ID:
 <AS8P193MB1285304CE97348D62021C878E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 15 Jan 2024 20:22:01 +0100
User-Agent: Mozilla Thunderbird
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH v2] Fix error handling in begin_new_exec
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-mm@kvack.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [SHb+zh4RstG5HI6Uz4EIV8cNfO6mMuavuQoYeNtxz0ZHc25xJCfsSIX4ELUrdsGJ]
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <70d177c8-9bfd-4dd9-bf05-50b9d0f968d8@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM0P193MB0769:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e9d96b-5296-4a6c-a742-08dc15ff1e19
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qsgKRZUqQTFb0YD5iFDICxYFdJvPAy56QXkEB2QVnlxk5Ii3HEO3TZckaty8ixaTBX5V8R4831XfBN9Rb3Z+BbcGB0mOJXDQflZxCDN7+BsdNejzHejnzcpCyqViJSj1QZNH6rejj103c/fFf2xSflIjsR7QvURXH8mXCrNjXo9p9FyYJQ4YJZOFNoZhx/RbXCkJooXyiJfg0TBfhAweELpQKbxYCaHEcxkZ50iAJNYtcmq10fqiv/WsdrwGMCvJpdwMXddRwGbt2bTgbljSR0bg7l3HGqQoqHu/vofKdUtWs8HU3xmrIZXdOFWBViXXTchjYfJUfOFiLmOU86/xxdKtCVkJx759xWBkZ5i8qeDqN50gSsnjgsL57ArnHP6WMqU9BMivQrstR2jIAYqgXUR70O4+s3jFTT8sn/f0g9zdnqCE1f+BtpXu1xxpR0sO6e9K14PJQWd8u4tJPfj9+S/i4iyxLapatXziJUoS8HTic00HAynk/pLIscPz89XKJYXHff1ei3d1Yr0ChSabYJHBHDONEeegMlSOrZ4p6fMNG/KNZpLpyv/obE+u7hBU6UEcbX1OCj5RJ+0axvi8BMm8ajG8r3NE350y8fN6eNg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTA0MW5KTmlhQUtnU0t1VnpsU0l5OFhaTUtJR01FeThwL3JPTmtNRmErQWU1?=
 =?utf-8?B?Q2V3UVhIdGRoODFtZW5iZVlMODVZcmJuL3VrOU0xUmxCRko3bDRzT0ZwMWhk?=
 =?utf-8?B?aU4vcE9HaUtScW8xbk5tY3NIRFlpYmZlWjYyRWNsaWV3ajBQdTMrbFJudjFz?=
 =?utf-8?B?R1JaS0taYWhjNTNmNmR1VFIrdWkzdmcydFhSME1xYTBrbUJtL3VabkEyaTFI?=
 =?utf-8?B?S2tycHN0R00vZmlOeFh4QkhJWW1TL1ZIVFA1Z0tKVUJmVm1OdVg2SE1RbmlF?=
 =?utf-8?B?QXQ1WjBvTElxRGhUcHhIM1ozWWZKQnBRUmJDeVNmaU5SRk50RGpVb1l5Z1JI?=
 =?utf-8?B?aEJMTlpnVFdqU2xmRTlSaHZDMmZJNUhpTk51YktOTFREaTUzTlBuMWdaZWtU?=
 =?utf-8?B?RVJUelFGd0lXcmJZTUc1bWZFT0h0NGgzUDgyK1BHM0o5aTl2aTBqTzJhZUhq?=
 =?utf-8?B?NGJsa3I2V2oxcTBybkl1T3dHTnJobm9ZVzhXeDFSOHRieFRtS2ZldkpoSFJK?=
 =?utf-8?B?dWU4QytDYko2bVk4dWI5MjFsRVg5M3NpNkY1dDJnUnFzNVBGK1UvcnBYdlRw?=
 =?utf-8?B?aUtYd1hMcUZGQWNRazlUNmVEWnZNeHYvVW8wUGxjK0E4KzhYaW5vUWRXUEpn?=
 =?utf-8?B?YjBpeDIrS2s1ejQ4dythQzNzUUNvYmZjZjVVbStpMXg1QlJVc2R0Ny9jMVk0?=
 =?utf-8?B?V0VOdFNTZ3RKSENHSzdCSFBmcU9FdjNiN2x0ZVFUSWxpTXhPNGJ1VHdtR1Vo?=
 =?utf-8?B?OFNtcnREU2FXMytDSE5FMEZGUHdoMFU0MnBhMHF0aXhKclBGTzNJWk1oaFFv?=
 =?utf-8?B?bk5jS1ZJMTlRMisvY1JvNEI0TkVoa3poK2FKUExsUm5STnFVb1lWditKcnhD?=
 =?utf-8?B?T2dhVldFdmV2S1dONUpsSzQwRkpNa2RvUHJrdnF0NDFrSDFPK0tNV1F6VDQ0?=
 =?utf-8?B?WSs1NThEYyt3MTdvMnN6V09yUjB4KzE5T09mNi9iNllaR2lTcUlDb1Z6bFNr?=
 =?utf-8?B?QWtMZmdXZ0dTcGIyVmo4cGhRMDNLTy8vZWU5NDkwOUEwdkJYMlhmaWFmUnJ2?=
 =?utf-8?B?UG1mMEpqU0oyNWQxN1lOQkJUOWdYK3o2dHVLWElHb1lyd1ErMVEycVRubnBS?=
 =?utf-8?B?OERhSmhtcTk0L1J6V3E3dnNNNFhDV1FYNHlISGNvU3VrOC9rOVJNRlVZVFpy?=
 =?utf-8?B?Vktla1JZdDYxSlY2SGFxRStVQmNzR2RXNm1CRVJlYmRyR0VVb0pCYmI3UEtz?=
 =?utf-8?B?S0luV1FUZ1g3bWEzMnhLcXhsaUdXMnUyTThwZU95aCtpTXZ2WTZEeE00OXRH?=
 =?utf-8?B?RE93c0RPTGhTdUVjOEdBTFErelhpV1hnWWhBcktsYWNWZHRLUFgvMXliL0lI?=
 =?utf-8?B?bDRxbjQxakp3WHVUTTZMVEl4YjlMSWtMN1NaRHVWOEVCSUJqUDdwU0RoSng5?=
 =?utf-8?B?YlQ5Q1h5dFpiQmo5SFI5Q2ZkcVVMRFRDMVhuVCtpc1JHQ013ZUxNcmkyckpR?=
 =?utf-8?B?eVJhaHVYdlplMXNFOW1Gek5tQk1PWDZWN2tCK0dPK1cyTHlqSDhKaEFnYmJ5?=
 =?utf-8?B?c2pKZnNEeTAzWHdmd2VaT0MxYlA0VUxLVHVNZll1OUEwTnpIR2J4SVpyaktF?=
 =?utf-8?B?SUdxRDB5QVFWZDhZdHVLbXhEZWlTNEZPOER1bHMwcnF1RVlBbVdMTXB6cnE2?=
 =?utf-8?B?WmJZVFh2NXZUSVZTVWRETFg0R2JKdUozdFk2YUkrdkhSeEdOTWN2V0xXWi9U?=
 =?utf-8?Q?6vDfcgrwhLPrFpisks=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e9d96b-5296-4a6c-a742-08dc15ff1e19
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:21:04.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0769

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


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 4aa19b24f281..6d9ed2d765ef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1408,6 +1408,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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

