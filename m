Return-Path: <linux-fsdevel+bounces-74164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C9D33417
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96E3E30A5B78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508533A010;
	Fri, 16 Jan 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VokZcnYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020097.outbound.protection.outlook.com [52.101.85.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AE336EE5;
	Fri, 16 Jan 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577755; cv=fail; b=KhsQX+hVCRBKMR2KuWGvVjgbpcEjAhN65iq0zVXJ4bQQn43TjhIwekUb7puDFcJetOan6diwPm3LasZEZ8k1NWxmg3H3dP365QXLdxGDRxcckMCiSm//3uSUg33kQL4Kb08X+V01f38Z7o02qYvisIWizGkfeIa7Fv0Q8ugrQ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577755; c=relaxed/simple;
	bh=8lAIhxffDum6CEUHk3FpIL/wek3HYW5OhsxwHijBcgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBh0U+BlFZhI6SeRdgUWmYcJgj8Vr8Ewg//6MAAuI+3jdw5qytb5va486FAGdoeXZ1bLe+kqUs4mUzC/mTCNluMJHVNELGk342c9cw4bvD0JepAo+/h8v960CtgAhQCpSEJAMgYUOCqaTL5QwOPBlYJwDwrblMkqdxkkkCQIBVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VokZcnYz; arc=fail smtp.client-ip=52.101.85.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHlmlo0dEDT+cPQLrw1wHRxEt0BMMtEaeIcgYD8z1N+It2EOHRN5wKkyaoUmlv3Kfs9SWpTtvZTd02DoKdtaZ6eqeJjwlYRYMYbYIhcBwzB+AZ15yx++rkkz4u5fdwwRVlCont+nKTHQfVcaYh+NgKFfi78sxwkMk8CGXZLz24Vvy1j4PTkEzawwmjRL0ca6n19AiqBNQ2N4GxxFSjnESz0r4IwxNloBIxk3pTwxhHqm3nOGBDcMMj+qlVaZUjS+oG/vitRbD7MY4qip7GsynzYaT82C3+lMLULiA9ONsDGajGv/A3tH47EAjzRacrEej+hE4K8tKlZIAHI6bCaCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8xTgQWdj+AiDOvSxxfB0JnsPG4M6rP/x2xXaAjCVhg=;
 b=WvpY3tCg8rwUDCoxBheh9DkkW1bhTp5TUdrZ3NBDX5Ab+8AAqFU97iNAQBfncXE/mLX9l1HmFrPalUiFToRvhGYXw7VvbNPHDhOhG2UW6I9U7EGf5NMcBWKFwT0q6g4Cnl6r0gb4+J31vAxFFHqxQcLQOg/Avrz3UjYc1F94GChfRF7DWcIATf2v6ENGaepiM5IHU7X99FvncIIHu+y3F6WGeBd+rtpOpbSTEN1xmjW0mnG2eHF6ZiGttNp82JhYu7/bXQaMRyZrPdSOu+ydeWARM69FLbjWkO9H3Zo6qT11A0z9HZCMs97oqHBld2Dmu/QwwKjqGVomQqYjVbkvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8xTgQWdj+AiDOvSxxfB0JnsPG4M6rP/x2xXaAjCVhg=;
 b=VokZcnYzygUWDiOsWGCJc2YjKf6UpTKIHfgybALwqWHLtPwqzNjlL/PL5BK4hWWK9E4wjbj1i7XhhdvQDnQLoSZkaIkkcTR3ys8gIGl+jonmRO+NT7WQDo4H9icSy2goxadszTRcCbr4hi06X3LC+FSECT1sNgxOfv4Qoqte9Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA1PR13MB6778.namprd13.prod.outlook.com (2603:10b6:806:3e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:35:51 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:35:51 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 1/4] nfsd: Convert export flags to use BIT() macro
Date: Fri, 16 Jan 2026 10:35:48 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <8F2645AA-9CB4-44D5-9121-8699216EF7CD@hammerspace.com>
In-Reply-To: <15993494-ddd8-4656-8815-2693ee3b7fb3@app.fastmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
 <15993494-ddd8-4656-8815-2693ee3b7fb3@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:91::38) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA1PR13MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9c91b2-94a6-4085-c129-08de5514eda0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9una8yUmHn6GeD0ppYV5IjUbJdUwdvospeaG9iBt75gRmsQeRtNIf/8jODb?=
 =?us-ascii?Q?TPa/cdUF5UG8kfDjxoP18ohDdT4pcbqkLQZjA8WICep1XWphcx37lKYzMnJC?=
 =?us-ascii?Q?rjOXHr1EXK39pYTqS24tkp9VldC62p9XgYMEBfoh5055GobBNPM9fYzNyxT2?=
 =?us-ascii?Q?0psEanZlcB0fcm5AsU8W95K6elx6d+uEh4xbxrXJZ0squD6VqDKZPsVdxVc8?=
 =?us-ascii?Q?J4+vfhfPTFezOb4yDIBnOYwoOA9kFMyhFdvZ5hzmeLsnsGWfLEiptYEfssOT?=
 =?us-ascii?Q?YN9be9k6+PC5mN6MId1mvvfb2UvvhTtJ+TlRu+MmI2uPf5G7GBM2y4Mmvt25?=
 =?us-ascii?Q?FFzY2cNX7IviHsYopws2pu52nFHzIl0i7nFC0SaVOxpV2v383x7BF2idmF3S?=
 =?us-ascii?Q?NwDiPHlFfkALKGTBgqK1fioQqTSaSNhVR8vGlODiEctnbv0nFdNP3uWwmCrR?=
 =?us-ascii?Q?Lt/XaBES8+wNuOofagh1LOQJotJXzdz+qoEwf90J5QqPRR6SDQPhQX8V/4pQ?=
 =?us-ascii?Q?ezURRyXWHFa1VZuK/35o+SRfBeeehVzu5j5owQ/iSjeiE/LeYeGiDGo/365X?=
 =?us-ascii?Q?CBZLroJGRj44oTWprHI59qE9yqUv9M+TNfAaPi2XhHq3Ktz+E6MFkAzXR5rk?=
 =?us-ascii?Q?0QGonFxaIBDx3qF9mZcZFVHma+GdyG7QpTuF6BAlB5b/2Lh3ciWJa+ShLg75?=
 =?us-ascii?Q?LRCYRYViPwO0XOVpQsL2lYscMb/ObwcYIKKzkIByYowSan6uq2n2R8lf2bDD?=
 =?us-ascii?Q?JXFZUtvmgnigpRA9qj8qDIN1OCZI7jvkgtSocnh0y7xQW9wnsAegQ/K9tXZx?=
 =?us-ascii?Q?NDIVqare6VKzj4h8imv/r0ii8v+6VQLh2scFMa/TbEau8qUolAPgS5ldelqV?=
 =?us-ascii?Q?Y1bL7uSG9Dm420PcpcHcbLt/CWacDgsR0TRuF2vB3vUWfh+CJzfB1x6Tno8f?=
 =?us-ascii?Q?lrPz4g9DzUMClZ9ITU6403f/WYwZNglYzDFgFTUoh8yz/Oik69wET+wNdhtV?=
 =?us-ascii?Q?f4oXCzm3g9OU4w+Jc/EhdONzGd01xjkB1W1Ofg5GyTsji3NRnFiTu185Yo1q?=
 =?us-ascii?Q?ImxFeZNK4sPsHMSlFyhD2C4N2wC0an+qWc94IQhX0k4euXgU144q/dl3fauM?=
 =?us-ascii?Q?/CN64+800s4qFcmYWLpuoplpCUhGfP5msgr74fEP7IPANAUBRyvEC80r/JZZ?=
 =?us-ascii?Q?tnrfnrj8yU/JHUAi2yF3Me7xnR5VildY/bP1gPlVz0neM8A6zJhn6KMlZpHf?=
 =?us-ascii?Q?OxOdO2LotB8lX2P6gdnNaFC1rFWLNqfdrII3ruYuqjD14zP00ekhJXO7C3dq?=
 =?us-ascii?Q?x0MduweUPseL+M2mCAbZNgg3ZtGOf+GmUDOtNuEh2cTiJ9eCA7/URXX8gxM0?=
 =?us-ascii?Q?/FbZ/ce+/zBjwOQfDsrw5yRfwRTLDjdO5+jCzA8BuzH+vjUBZ1dV8dyoBuN/?=
 =?us-ascii?Q?561pcb5b5OqZn4nEvUmi59GvcvEPNUFBF7w9V3kxLEkgcamtY7+g2twysXm8?=
 =?us-ascii?Q?TRnsxjeJjSmJGk9vGiEYO3EeDGm3BkaZDEp3eZuJlXJdif+VQQvUBVrTz6Du?=
 =?us-ascii?Q?qH1Eg8yRUx92BZ+iRaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+X/IxgZUDF2kqpw4LqJBPHfr7efSframozFkB4kG1jcjzIj/fHwt5QouDVI?=
 =?us-ascii?Q?/7IqEvnMFn1r8Q+G5uP9sNKyMRxARrvnD3+9HhlLBfOG1i48TeSIQ2IyuBFh?=
 =?us-ascii?Q?iqVbnRByJRk9+dgMDW6Pfc/UYoM0CrtpMER4t88K9GNI2lDE4AY+T4/7fP3K?=
 =?us-ascii?Q?+jOY7WmcVU5e4JiMiE1GWUHDgm61363Jur6QGN1Ty5dQZy/Idfd2H5XUa9El?=
 =?us-ascii?Q?r4LOSmw5O993dHiO324Xb451rAko+c48K6+w3tJx8JAgv/WX7LLiiJLQEtlE?=
 =?us-ascii?Q?cbh05ogJYTfY8IRKcQs9TL1P+Shca89u1BZcuWJWpBofU5t5RDa32LUmJGsc?=
 =?us-ascii?Q?pWlp2bp5GNxekxwJ+gRVY+5KVnTZm2qtajcuK4qJ6Myt06ZIzH050W3+BB0w?=
 =?us-ascii?Q?SQEIx/d1PD7/29um3TgKDcfWaAzz8DQrfZouqi64HlWnJpIpPzQFMgj0TXK4?=
 =?us-ascii?Q?Y+G5MLgPwJaufhKcNZzSJ7f3AIxZR1U/j2yJOI4f890+65s4CYlFsa35o8TL?=
 =?us-ascii?Q?/TjKSaqrotj8UaqSuZyIio8GFFxPN85z+cLN2RgCF2sPRiKB9vCeS3g1+g9Y?=
 =?us-ascii?Q?wtAno9pj9OWPpypFtU1VwJxDQWwm5t1s7WhSOpDM1t+VkGVTW6hr+4CCvKm4?=
 =?us-ascii?Q?+vWmhhy6oB8HJy3RSp3XjeYa7FhVcDTAAgpV2fLVej6KVBORElutn6eDqDGl?=
 =?us-ascii?Q?UTlrASs5yY/JxEUIFKOIK3SevBYL8RXme1Dk52+eynYoq9gM71fWQiOlpuVi?=
 =?us-ascii?Q?H4d+cwxRoRgf6Ok/NLHedFyKJUp07exUVj5wPjouLZH2Z7YpWGma+B+qg1Lx?=
 =?us-ascii?Q?a19GHWATzP+ZC7jIM6/NYEsSQWaQou4K55VNZgBKaIzz9lN6WGE8c6ajJC1q?=
 =?us-ascii?Q?TKj8dVGOzOwnJocFUh8kFWNiroC4vfvh/ApX8C3rcH6sAB9ajCUtaX63u6o9?=
 =?us-ascii?Q?lpnw7ruZQa/cNWEhNbPGADDul73ofx6t0tljclHrnUnNaCYxZkG1k9CILdO0?=
 =?us-ascii?Q?Ol4vWx6uT7/WYmyJrj6Vgc0HM9Ob9XOdgNggRiRSlz+El1mERdhpu/O0mKd7?=
 =?us-ascii?Q?fsnj0c4tnyyJ3vtlkuK0Ky9oZ2S4F+Tr9Rv+b1N4Tj/laZzraqbqpX/63uRc?=
 =?us-ascii?Q?uXtaiC/U4a1toiBw53wpiU27R4Vq2HOI4wcuaTBti0TXU73Mx7EuLaMXDsr7?=
 =?us-ascii?Q?Hhzz9SndHk03urC+ttTLYHrbbHwZUEWPgBtgjoNeLhqXmJDVdnNQKFMIo6mm?=
 =?us-ascii?Q?iDXGtjlgvjyTkdlxP+v4nTRE21+vAmsTP3rUpGXlJU6JVJlXugRaPQ+bpMI4?=
 =?us-ascii?Q?R2fEnTPTrfZ9KbSvBzq7/mFK1yy8XVgGmneZnGJQKDIN0lUVwmAeoBhP5t/5?=
 =?us-ascii?Q?AM+oVNsrgv3DmUo6hhGgSSPze5RSutpQc5qbbrpLttdLtZR3ueBZQbTP7gw9?=
 =?us-ascii?Q?T6WJW5J3XpBi4MUgNfj3Z8LBjrRMdhyIv76rOF2Bs73US3dcsHI6lwq0Dr2s?=
 =?us-ascii?Q?MOjfX47wpcF1Jpvg2FLTggkuk+1WO7TTJxURRLgN/V5LeGezPWt+blNKn7mx?=
 =?us-ascii?Q?zpRW1l7xhCEYLE6EaV/uEeW/7bx4VNXVfJAgm65FSm3KUVKxfVf1jo/ogL+B?=
 =?us-ascii?Q?gAdyu3blUoYsxAT6NsSrgL8lvfZ2mwsFOxsWxRGv8C7N1GxPfTGtTpqRT+IW?=
 =?us-ascii?Q?ouebpwD4/GuU3Xp4AXkXEZ5Uju0CNrW6qDNacTVIk2H1PLxN2fO1vJ5gOj7D?=
 =?us-ascii?Q?gyamwa/nHe8TB0hShjY/XraICsmNENM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c91b2-94a6-4085-c129-08de5514eda0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:35:50.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eqzcqI40DgTstO5hmYcrLjW8Oa/NGgkS5P10HI5IcYuWdfVvoY+K+HF4KMkqQw6HrZu4pcDuTocnj6BP5MYRAG03wX7qLf9RdH/eRMdOF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6778

On 16 Jan 2026, at 10:31, Chuck Lever wrote:

> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>> Simplify these defines for consistency, readability, and clarity.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  fs/nfsd/nfsctl.c                 |  2 +-
>>  include/uapi/linux/nfsd/export.h | 38 ++++++++++++++++----------------
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 30caefb2522f..8ccc65bb09fd 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -169,7 +169,7 @@ static const struct file_operations
>> exports_nfsd_operations = {
>>
>>  static int export_features_show(struct seq_file *m, void *v)
>>  {
>> -	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>> +	seq_printf(m, "0x%lx 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>>  	return 0;
>>  }
>>
>> diff --git a/include/uapi/linux/nfsd/export.h
>> b/include/uapi/linux/nfsd/export.h
>> index a73ca3703abb..4e712bb02322 100644
>> --- a/include/uapi/linux/nfsd/export.h
>> +++ b/include/uapi/linux/nfsd/export.h
>> @@ -26,22 +26,22 @@
>>   * Please update the expflags[] array in fs/nfsd/export.c when adding
>>   * a new flag.
>>   */
>> -#define NFSEXP_READONLY		0x0001
>> -#define NFSEXP_INSECURE_PORT	0x0002
>> -#define NFSEXP_ROOTSQUASH	0x0004
>> -#define NFSEXP_ALLSQUASH	0x0008
>> -#define NFSEXP_ASYNC		0x0010
>> -#define NFSEXP_GATHERED_WRITES	0x0020
>> -#define NFSEXP_NOREADDIRPLUS    0x0040
>> -#define NFSEXP_SECURITY_LABEL	0x0080
>> -/* 0x100 currently unused */
>> -#define NFSEXP_NOHIDE		0x0200
>> -#define NFSEXP_NOSUBTREECHECK	0x0400
>> -#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests -
>> just trust */
>> -#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients
>> expect; no longer supported */
>> -#define NFSEXP_FSID		0x2000
>> -#define	NFSEXP_CROSSMOUNT	0x4000
>> -#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use
>> */
>> +#define NFSEXP_READONLY			BIT(0)
>> +#define NFSEXP_INSECURE_PORT	BIT(1)
>> +#define NFSEXP_ROOTSQUASH		BIT(2)
>> +#define NFSEXP_ALLSQUASH		BIT(3)
>> +#define NFSEXP_ASYNC			BIT(4)
>> +#define NFSEXP_GATHERED_WRITES	BIT(5)
>> +#define NFSEXP_NOREADDIRPLUS    BIT(6)
>> +#define NFSEXP_SECURITY_LABEL	BIT(7)
>> +/* BIT(8) currently unused */
>> +#define NFSEXP_NOHIDE			BIT(9)
>> +#define NFSEXP_NOSUBTREECHECK	BIT(10)
>> +#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests -
>> just trust */
>> +#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients
>> expect; no longer supported */
>> +#define NFSEXP_FSID				BIT(13)
>> +#define NFSEXP_CROSSMOUNT		BIT(14)
>> +#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related
>> use */
>>  /*
>>   * The NFSEXP_V4ROOT flag causes the kernel to give access only to
>> NFSv4
>>   * clients, and only to the single directory that is the root of the
>> @@ -51,11 +51,11 @@
>>   * pseudofilesystem, which provides access only to paths leading to
>> each
>>   * exported filesystem.
>>   */
>> -#define	NFSEXP_V4ROOT		0x10000
>> -#define NFSEXP_PNFS		0x20000
>> +#define NFSEXP_V4ROOT			BIT(16)
>> +#define NFSEXP_PNFS				BIT(17)
>>
>>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>> -#define NFSEXP_ALLFLAGS		0x3FEFF
>> +#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
>>
>>  /* The flags that may vary depending on security flavor: */
>>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>> -- 
>> 2.50.1
>
> This might constitute a breaking user space API change. BIT() is
> a kernel convention. What defines BIT() for user space consumers
> of this header?

Doh - good catch.  I can drop this, or maybe add:

#ifndef BIT
#define BIT(n) (1UL << (n))
#endif

Ben

