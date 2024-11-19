Return-Path: <linux-fsdevel+bounces-35230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD769D2DFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4107B38E20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61F1D1F40;
	Tue, 19 Nov 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CdMaQspG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013069.outbound.protection.outlook.com [52.103.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941D1D1741;
	Tue, 19 Nov 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038969; cv=fail; b=SYbrP5JP1jeo5LUby+udvQZc4zsyVJ1/VZa2tNFZmpsk3MaMY6vVm3/NrTo1JXpkqiQZgd5216XQM5HbpsKTMpHal042kIxLBezU9ATjBnzuM4zfM/DsdUMstQErEYxxADs00KITdpWAU3d0IQYcFyiInXrOmyZ1lc+3d/WKjrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038969; c=relaxed/simple;
	bh=Hnb8huvwU3mh/8ZR6urTMVV+Dt50GEkGMo9DjBjDEwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDbn7QUDSVNUobMYxim/l9sRdnUAr0fYj/NHFKnUPtbfluUZtqjF3uNmBdOucrgiNaRTcpxUwiZn5lfOxn0tvRjOPqJKpsW+4Mp15cr65oDxM+jpIhkgwlhG4L7LKl8q78FN+3Cg9mZkeonMNx7X1LeHaKl1tXf+mZy2t2IkyGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CdMaQspG; arc=fail smtp.client-ip=52.103.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBnDb47q81wgxqvXox6XLPyzp+pd9x8Nc06NSMK7QwjX8R8VuBfxe48UpQ9owEXHLCn3d3RtPB7lPyeEIxTp8bJzNCzbQUbJMnR7OjaF9CUbZtb09QFUujCl+qns4DGH3t3cjQyvzNabEpdiHBZS5J5+1XXpXEsWt3V95C8p5Yf9ucTWW7UJIb2y20msiGwI4evpdqEAzfARdgUYuh/DddKSU99kbox0zKiyB557E+r3JQWL6JcTgVAOIp6HfwIif7oarUrd/f+3Q1RdSz6H/HD+478WFfEsYstd528CYurhjjEfLpYcZIwLx4H8K3BQK7he4Yph7Nt6YQJUByCOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKlFj67NarotCICknA5xg6wjcNX48uJQG04GY9xwyx0=;
 b=DNIczyi3cs7c9SzEaD7LW6yrXQ/WOkWlKbKUlJhVuQD2En3loz54WKnqZ1PjGSWqfCYGrfkzk2K/9aj8fphkIL8uyik+A+ZKVOHD1Aj8LjtS3Nc0IFqgCuaqAk+KTGKxTPkFItrJOvglidMO1tbA2/5DgI8CiRhUAo/cSH3m59cVESgOmHx2MXX6ChgUV018rMldokKy6ZaKlLAhpqholFxycAJSLBMgg5tgxExqJU37/EX8Fu9b/j2VC65WtTOiTIdbfYN99zYo+XISc2H3YU7yXL0FGSB1qpekueuaMVH/WOHlANZEsH8fl0tATU91ryGx/qWQR37wBKxW8N1Izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKlFj67NarotCICknA5xg6wjcNX48uJQG04GY9xwyx0=;
 b=CdMaQspGUJ5gVF+WbMihXUnsrU+A1m3pAPyX+rv26dsH15Vy+gsEwTvwqcL39DfYYtJKgDGLU+s5SJiMXFoDUli58OZzqW9/H1VLBuvna34lRpwQnvohWB38IM8mHeF6VBpudKfFEx/qzcGsVAKkJcJUMk4R4pnbTzS1PCabH29m1rjsQLwIKP35+RI+km+4zQDCmbCRJxA8LfgGa9xkWCcwDPRUOBS1Ee1wnQlRTt9ZQS56pXrlNMm84+JR8b2XzBnj3tXIWF50X/ZK0dN+Y+h8P8J/N8cV1IzHCbMwcPoLBUAlLVttveHAabEKP0Veya81Y0Ffk642tNOJFnuuBA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:56:05 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:56:05 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/5] bpf: Add bpf_fget_task() kfunc
Date: Tue, 19 Nov 2024 17:54:00 +0000
Message-ID:
 <AM6PR03MB5080AD0C6066EC5D7B1136D199202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119175402.51778-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acd5c80-4df3-4e77-ca5f-08dd08c3701b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVEL9NDfrs65XI+Uu78rEKIi9F55XzzBWBsqgu02p3Ti+KMcceyCyZW3JMB8?=
 =?us-ascii?Q?sZkFzTiUtl+iY4mmvEpU/CZygFdJtrsLHQl+lygjy9WiC/xUxB6AOjS09vyg?=
 =?us-ascii?Q?PXrqsWDLOJixoSIRDtko8PEZtpXcAOk5VhlSIIjeSpSO10syXgcjOg1+o0Rp?=
 =?us-ascii?Q?K/yd02pC1+ov2ooa1Qh9DzfrkHsHLhlR7bcb5SX/sDRjrg+11wRf1sTuwCSG?=
 =?us-ascii?Q?5xMP7FfTseGGdWJjCLS7D6EjUL3jEQjFoKQZXsi/zb9+c7SQwzOj8NQIk68X?=
 =?us-ascii?Q?IZkN7XkwrYkJarj2b4UojVbcpLJNF2hhD6gHe1P8K3Y9FBuk0kPfy0ja0ZQZ?=
 =?us-ascii?Q?+AtLSGiajzmndIh8gMPhwIa04SFrOIqXIDeiUt1M+7Z5aozw+1hzJzTaUOv3?=
 =?us-ascii?Q?sX9bC14WKPTjvNA9B/fGwg7l3dGW5v761XR3GGQmzfn99weBIUiwmuo2ZEeo?=
 =?us-ascii?Q?Z3L0X1wo9KPCgPsPZzE0J8dvpqcYR0SBfA84vhvqH48dWGTTwuOhD3+1bVtc?=
 =?us-ascii?Q?0x0BJdHsyu5pHt0WcQ4Ds9ddp0LnzQqEiCIw0wRCkPOhYwY/D9rf9lZFXapl?=
 =?us-ascii?Q?CQ1iGd1bep80PbTrvXsQoiIDWgfTpg0oUaZa8cWE5Cd1+5oPy+bNf2TD2Cgy?=
 =?us-ascii?Q?T7d/bAjwHOWgoUNqpOFsGgXm0N93GCziN8aPmKnI6aLBTEAGK7EV5RZyCG3X?=
 =?us-ascii?Q?flLX41a+Cd5IEhU/JCKkDHwqEbf4HYxvgl135oVLkhuR6Asb/L6RNA1XWN+k?=
 =?us-ascii?Q?vPTXtAIwkt/M4Gqts7XzkAOc+wOHo7C5TIr/kDCFjFymQuOuRa3wRvR71Vf4?=
 =?us-ascii?Q?SUpcGZxrlJy3PkIXyoQfsbdLFSInEz1Ihy+LYQDQ80gT/XffrkEfF/1GKM2X?=
 =?us-ascii?Q?Y9nYcPuFQFkZzyQNzj1VYbrIZPtxOpGLRgH8lnlVj7mmHv0PdeeQ8Af2Lujp?=
 =?us-ascii?Q?itOP+iIaAIljVqLlZc4UVRlgcZzMYDMfbcfrjGjYa1o3aBpA+Czl8KSN1V9M?=
 =?us-ascii?Q?+t/h?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQh+QWlj0/lf5gqPwXRuMkl2QsLeIfvAu9MqQNVZrbu2ZCk7QTmNdUPX6CnT?=
 =?us-ascii?Q?9r+s0XH2OmcatqtxHcEsuPT11j9GvruXmivPv5CWqvC+PoUkM8BzbtNVMLuO?=
 =?us-ascii?Q?Ct4LCfHTMiWG7OG2NEEgEpvtP4NfXTmq+m8Y3cyi0xTMCVoqTAFu0qhSIclQ?=
 =?us-ascii?Q?c3SRUtP8u7uzM6i6cBIoIxKN+7WOYKhOj2koQQLtZaSTemroQztlUSM0CuEU?=
 =?us-ascii?Q?aqBN331obr7amMy/v6YL/FYvSWDKzr6Kv0R1wTM3wU2w3JFTxRm6j0T4PuHA?=
 =?us-ascii?Q?dt633SMS8+U0Jijq3XlfoDWsjzCEt7R1GJOI5DcdMdEZzQVvw2WKa743vtbe?=
 =?us-ascii?Q?lAVCg7WP4IZhx/8iUp60VoHcAgJLkV9XcjVa/pQkGVtC8REbWneBF7tJox32?=
 =?us-ascii?Q?8J6Ctcwqsb4/M30AVhirD9rD0tFcV62uPaZh9U81Wf456IVdgcu6hVO+fJOf?=
 =?us-ascii?Q?bM1L8FXQJmPMBQlgikg3oFskRsI0+3amSSMjtume9rhPHUcixRo404QuTLMG?=
 =?us-ascii?Q?my+qb89aQQ9ExxkEnQmexh+fFiPrWcw6otTmn6na9eMvOmjsDTG09ZqjKQAs?=
 =?us-ascii?Q?vPC27fd9++uniztttrG7K43q+acIQ8CoOSimPCXLoLmq8Q/vHgYsKsHY545a?=
 =?us-ascii?Q?Cp7St5XzXrYRUSnMyA7fVtGKa+tpaMetGioYu87j2co1TgtjZrjqMNHeuv6D?=
 =?us-ascii?Q?iXkWPZlR1yLTHhGZrPlmpTUUaK4BAO4RIk7qyhs/LZkdVQrYBfUGFNUQzXPd?=
 =?us-ascii?Q?vFz319VA/t7TyNtHBxwGuB5yZoIlI1nayDGI0tx2dDCeDjC/oiQUdhpEPHul?=
 =?us-ascii?Q?GCC28/7R8WADwxPzwmJyaaqKbFaCpb5srH2f6674b9Sp1mW53Kywz2/E/D4b?=
 =?us-ascii?Q?0at0MFTjmCcVYrxfrDjAL1T3lciTKhTyOJjRO6Q3kVefy5VqLFFR0LMJ9D36?=
 =?us-ascii?Q?bwUCWm0u969/Uz/vUrKIhg/vVy5sWjvP6Q/0B/hp2UQP2iFUJnqzVT4JBPZT?=
 =?us-ascii?Q?W3Am6VI8cs3mKRPH6Z6iEPuVh76Q7M6IhMT/urTDsbiYl71+NaWsg2HXgyoV?=
 =?us-ascii?Q?Z51/OQryPCQArYzIuKIMS9uCjafmto56rUNFqK9xzCT+CT8NsplQOifzRHit?=
 =?us-ascii?Q?e+5fUxQRP3Piua9snojL92fPHwCwOW27ZTlzcsT3Rl1V60R2GsfHRKqgDi3I?=
 =?us-ascii?Q?l/PCfFOwLgAyqwownWqg+OrNTShl3z6A+Yof+ukxU7oAfYbnAqGIqDxqZhVq?=
 =?us-ascii?Q?omEBp4D/eRELJn8Xe6Mc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd5c80-4df3-4e77-ca5f-08dd08c3701b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:56:05.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

This patch adds bpf_fget_task() kfunc.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..19a9d45c47f9 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -152,6 +152,26 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_fget_task() - Get a pointer to the struct file corresponding to
+ * the task file descriptor
+ *
+ * Note that this function acquires a reference to struct file.
+ *
+ * @task: the specified struct task_struct
+ * @fd: the file descriptor
+ *
+ * @returns the corresponding struct file pointer if found,
+ * otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file;
+
+	file = fget_task(task, fd);
+	return file;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -161,6 +181,7 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.39.5


