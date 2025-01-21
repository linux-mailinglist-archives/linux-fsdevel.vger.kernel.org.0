Return-Path: <linux-fsdevel+bounces-39775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80429A17E81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992BF3A387F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202CF1F239D;
	Tue, 21 Jan 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ctaGWRbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011020.outbound.protection.outlook.com [52.103.32.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24361F192B;
	Tue, 21 Jan 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464910; cv=fail; b=mKAkLg1nstsK7JGxHl9t7ImdqMAy8pSQEKg1vBkwXIbYL3muT+2Xotn8P3/W6rVGdzcJ646UTwobihNOksZiSwS2C6iMWadd5aZip5dxVC+tYQiBevoISeLVWlS2Krq1oIsDrbLpGiKRilWGrEKPNfEgXI68vJMGdIoz0IXYcGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464910; c=relaxed/simple;
	bh=KIxnMIr3pjygOZQfnbAT4gl8laW2esmTBi9+dragCrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHUsNXU0pi8zSP5bpNK/w2Zk3wjotK17rlTuPVikGBquzVoFNTstTk9QqfvCitXM9jBx8U4lsSRh5rxgz4QuBEiwql9HIEdCr++Gjo14N0Nw7bpv0zqhlNm8XeqzSFu3iYc7t4qFSYyt3ZFi/2An1xpJZ5tmqSIgO9A4JgHl+ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ctaGWRbZ; arc=fail smtp.client-ip=52.103.32.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzeowbuIX10La/FWPihtGRVTFE8LMfsCB9OuojYwTBovm5/dZk/Gl+56LRyHKkBLO8lwHOCFfqJ3wDJIVzcnZ0Qln3vhShbwtjp89cmUG+EbUAkoTnu6aC5oGNSy/2nNziwveVBrW91v4dZrlBfWoZpXK5lPJTRkAZtfc2dlDwqExAr4TdX2o99yY6DuUBCrcVNL/oYD6nJjtbb2oeHp4N5EfC0HLxhZjpn5LPNHw1xBeJyYh1Opmon/d1I3AgvtZ1UJP3ExBGd/ewvAqf8ZXAZyrUvQ9jSV1IoFHtKRGops5PWps4Q0Iad1W2WYKIzNWdfp3/Csg67NwIB9WdG3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=kGvxiTPrqerHDu+IN98dZeVUruPkvY9tPJ3LQkwk6JsfG+mLl5anzOr6C0EULk9MPeLLPpn5p8LqoHvaKaKd1b+8RAD37n/e0gLRCJuag5vQPZZ2q2zkD0Ju2Zjt2k7YvoRfF7keEGIkzDsVRHymsOCfys2mY2BpADfsuKriCvSIhsJ9FcZWMmiImr/s5YnnpJxF2djXOxi0nVWBT50GVKRX0PLrFluutgwucV/X90dUjKCG7R9cyfvf0xonKJOjJQxacTPMKtN+sOW5SDTm+xY9gCg91/4cTkClw8r7iANwv/Fd4+bSCNnuKfU3y2X/FsFpfDD/KvT0Zq33oWPbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=ctaGWRbZjzAix5gfN1H4fhvw01w/QziTqpYutnm+pI8xucORZ1+5xV7A1Zr6FTFLeT0drJoZasTfgsoQ5GuXSFLRMUWaAKh4FDfT3Ke2qnL9qbpYxf/MdU3v79LIMCiooxo7Lc+voSnTQn88UoJ3OZ7tsdNRoAustG6R44uCQcWmwsEwt3VrY30iyLdamjWmvJ7h57vf+zyvA26m4YlN5m0cRgvoaHLLOS4NmTygt+Vufof7HoyGm+SqC4YYPXTYzCCZaVw4O5OXB9InNRoUBKMnfQZ7xslVkp/nPQ+HqtV0Qs1M6UWKgUSRbRaoIU68MzUYU0LceOjKQGtJkHigKw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:08:26 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:08:26 +0000
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
Subject: [PATCH bpf-next v7 3/5] bpf: Add bpf_fget_task() kfunc
Date: Tue, 21 Jan 2025 13:03:04 +0000
Message-ID:
 <AM6PR03MB508083A4354A88B0B6A219CD99E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121130306.90527-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: fabba333-6ed9-44ec-c311-08dd3a1cb0fe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5vSyT68aa2r1CSuQwJSpgZnXjtgjKkcrMVBNJ8i1+9rlQCcohsQTGXHvd7Sj?=
 =?us-ascii?Q?NpIw5utM7LwISLT2/rW25AY9mwsD6hRrHwFo4H7Pt0GZHVTViid+qhjvbcqf?=
 =?us-ascii?Q?9TCAiC9UCBMj2h3DX9LV2fBFiuCu/hzx7ww9iY0a/0doa55SdEDedDGCaDtK?=
 =?us-ascii?Q?blMotw7FrYe0lZKrGCxYr155aC9vDxiCXwywfS25T45A3CYV97k4o/2x8Eyp?=
 =?us-ascii?Q?Hq33iod5CI6Y4gknWc8T3fTlyZcXx5tTLGCygtw3uBuS7kMq0xMbXdeIlLDi?=
 =?us-ascii?Q?AXCZB6oh+fNIEIsZz0tOZBWxyqEkL4HPIVseGxJaX3QNG+qzFZ9AI/dGDtXK?=
 =?us-ascii?Q?P/a0qZF/pWNIY2pjijf2pt4qphFR9gW6CEkwdCqcXac2+iifZNLTm22IG8Yz?=
 =?us-ascii?Q?SzEaTLkiltMI+08j1at2nfrK7hdQboujLRqkYksWdC0lH5wyq2rU03ZpsDMi?=
 =?us-ascii?Q?JlJnM8smtlyvgyli6pow4QXTTQbIxZeLa6JsDET3URtIpdOUPc5PD5YUDsQo?=
 =?us-ascii?Q?qZgaefmkczbnpC3cpPerPml0gtl/m485G8nZkbRHtEtiGozMKr8Amw9s08Fs?=
 =?us-ascii?Q?2Z9e8OQUjtuowuv6aMz4zlwBjQUlLmjFt4WJI0PK4qKew3Vsg01tFdd5gwQS?=
 =?us-ascii?Q?clnQ7eL4Qua6S5VW0BnOG60yz6cZXsue0cEswkjaMCHxhQQ9l8Zhe5Rf6bt4?=
 =?us-ascii?Q?wLnhdgLmlXyNuqfgf84IUlgS2VoVjOD5MKUlR+UXH9WgqWhEAnVAwV5mNKaa?=
 =?us-ascii?Q?JHp1LAuinWQbA6+93iXOw/Nkdp3jq/Ez0ZZPtqNxh63o0WXhSEX55RXqq6cc?=
 =?us-ascii?Q?SDwmNEDYdMMYOPwGYfs9l9aO2/Mqc0dFXYaB05kyWCnpUhr36aeOTK+bFgSz?=
 =?us-ascii?Q?q4+A8zPMMe3v0/dqmaNK630zlJxv0yv0AkdOhqIMAnsVrmT4RpPozFeXtom/?=
 =?us-ascii?Q?e0eQQ7hDhkVBJGsuVfoGPRb1TagO/aYESbSJX5Zj/WEPUzphlT16fwPw1jKm?=
 =?us-ascii?Q?R+rPp8hiAFi9OK5OcDYmEnapoH90JLr9iQtmGljKitQhdBmD8EWOYeK7leEw?=
 =?us-ascii?Q?7pMf4YQTWip10kDodfeyZ9w56Ytxbw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMgPA3L2rU9xnujOZV8iNM8y8bzn2qWXgvdTLG/qHysLR3ddm7u7KpNHeDCi?=
 =?us-ascii?Q?nChz9e3UW+h8InMl+eLl+GFWDl5DuCBTuSziyUuzmYo/uyeWxQIAuk5VjNvl?=
 =?us-ascii?Q?fL9HMIJyuVkCq3It/0GRE6flx514P57O8hico2tjvs2Xlr3ONTqUQlBJsV8d?=
 =?us-ascii?Q?CZ7aK6jgPPp2/BwqK6tP9G8+nfonV80+7Ok0MDpYH5PAUkQWIaE20Lh3dUHQ?=
 =?us-ascii?Q?ANLox9ppcSYqsWld500CyTYhLpT+MmtXx1x4ULPlNEnNznaXe1qqveCDuna7?=
 =?us-ascii?Q?dwdZ1xZOzbS0MeVKN5uvJvjJykMQAI3vqwlByx5sMR2gUUHmYyGMvVYmZ84c?=
 =?us-ascii?Q?6LsHmorSXm1wvTEpaZ/j13hUSpf5gz8Zf2ov37as8GhEmU87B7C8oJUks1dT?=
 =?us-ascii?Q?Nq3Db5id4YWBiqB+r5T1sHX5FTWIlEHfKDAEkQitb9fBcO78rfLyoq0Y5XXO?=
 =?us-ascii?Q?PdmmObf3wzv9IzzrcWJoFwscrzbUqsSQM/LuQup7NXXA9assEZFL+YwpvNfH?=
 =?us-ascii?Q?hGEAv08YdLNx4cUDYbbZWo2R/XcZhP4hKS0M+6W5Xs5+6DL5vLVs6x38US5b?=
 =?us-ascii?Q?VGqMBVG1BB1IG9mWbMKFwJPgZ5MiTJkS1dx6DVUrC6goZ8f4ZmEzH0bmIoBU?=
 =?us-ascii?Q?xBLcDxoHvRzrqx8EnmLXW8UKIyyLDmnw53BCJtOFMAFMy7rzqZe68uVcrEQq?=
 =?us-ascii?Q?5iQa6BIw2a7IUNXtUW7a4ongPOM1FuIbFRlAOD43S8CDBXOkWy40YfNdRhZr?=
 =?us-ascii?Q?j1TB6/xDvNr5aljLcBAdB/0auElsJYULoHChGMRSWDyzurQi8qETeT23vrsj?=
 =?us-ascii?Q?KQmxLHMis9W7Su9JnOd2hCiHq1FrLltny2lPHEaY3LgVHottwBGK1EV5OmDg?=
 =?us-ascii?Q?9WAvrxtBijSduk42KygQVcHcTIXcd2UYne8Ak+SZBU5jRZy9lGbBx+4CnNlF?=
 =?us-ascii?Q?JxupT7zs0US0tmIzATUbxwYPbToGZVh8DAVOWBPtjwIJ9jmb7FBqC4M17dpS?=
 =?us-ascii?Q?8HKnymSoth86kT6+0BWKA99zizRsayfzncAhXALaUXWCXD8O7CzvDpk0///O?=
 =?us-ascii?Q?8CbBGZgw6K6lNC4J0UdDYr+gLgq9oLhzi35AlZ7HaJLW7N3yqbTMALwAUecq?=
 =?us-ascii?Q?d/Jpmb4NEbM2ezaGVVQjpYn04nuedJv9UlgvVXI1FqoiQ+AfyTJ6xkpUHupK?=
 =?us-ascii?Q?MYUX+hksLXXzhJgayMTQADy0D8Db/yoXSlH1Yza4csVrRrEOAaX8oQcBcqO6?=
 =?us-ascii?Q?aUvPGYawZUnmfRx/ea5m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabba333-6ed9-44ec-c311-08dd3a1cb0fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:08:26.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407

This patch adds bpf_fget_task() kfunc.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..4a810046dcf3 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -152,6 +152,23 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
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
+	return fget_task(task, fd);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -161,6 +178,7 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.39.5


