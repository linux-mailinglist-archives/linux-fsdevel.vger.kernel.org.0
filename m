Return-Path: <linux-fsdevel+bounces-36941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C69EB2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED929281D15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7701AAA35;
	Tue, 10 Dec 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H8UFk2hZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2075.outbound.protection.outlook.com [40.92.89.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4541A2642;
	Tue, 10 Dec 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839718; cv=fail; b=mhq31tW/1lA+N7vXJ9Uoxwwzl4Twuy0KQuCgj2ox/Y0WlseFGjypkMY0BJAcfbmSKHpvg+rodvG112J+l5PqI7uScbeHsFXwNeDaG217A7k0H/ZvFvpo/BorkVhupFZOyD/4SXBHm3wpMDmM52MArlIcyhoi14HUqUz/3SPPpC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839718; c=relaxed/simple;
	bh=Hnb8huvwU3mh/8ZR6urTMVV+Dt50GEkGMo9DjBjDEwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwOhyDR+T7UuwmwXXQFrxUoc4HyPkc2Dnag2sBy1xK57kZfdKkCbmTKV+ya2htPorTZ3HyM9E9EpJQe5FXBhQQRmZF019ONWyI5R71I2t01atNlJs7/yh6HOib578bfUrL0Mq1uWYgesVZ5Tg4iGaIT3n3M1FJlY2Dz9ywR6ksI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H8UFk2hZ; arc=fail smtp.client-ip=40.92.89.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc7weUcfrqk30dJQ55hSdGGkPyToiGt7+XCUwO4ubZVsQgqqF18/yE6TDU2+aKgM5mJ1hiyg7BS5maBPNn+8+84vLYZN1eVuRpdHNMfnQAauSZ8stS0pzO6Da9iSo73IHS20X2996xT6XTPpDB+0DUNBLQalYih3CeU7pcqjOFgGL3CdVXukIlJeOeKRSlcL/a2qTR0sMVLZshgeka55HHEFmNdKXgPfJqCB9SodjGg0fi/oXBHtDdtFIzRt2yPglbwgRhpR9AQwTk9fJGb1Gydgoso2ZU6BrU01vf9A7t62atDOTebDbLHYGwIqlIIdPNv87rRaBAfNlWTG7BOXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKlFj67NarotCICknA5xg6wjcNX48uJQG04GY9xwyx0=;
 b=IDkfofYiH324d++ZDSUEIGa2km1557Bid88ZFUGaRWabI9ltEKh88KMLI6IA1RHOHMcwNWOaWSwOHqXbO8VSm8kJl9w/y+b7UgtuB0J1kuErcHQCy8eMIrmYnbIjUkUa2yA1boPBWCBZ9RVEiy4GOnVQat6xiAlu+3aShZJGeXKSsAvQfcOMLuQG8T8jr4AQRAf78XpT7fFOkBrcUVNFrKkAqMEZ7jqG7xFySq05XcFNmZ93JYbCgPyYkdlt18wc8BI1n9R6YnS3KUf0unzRlo9x0OY8+GsKuC42i3rED5RTxQFGLHl4O7dh3Jw1bfEFlBwXBBDXC1VgH2ymL3pflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKlFj67NarotCICknA5xg6wjcNX48uJQG04GY9xwyx0=;
 b=H8UFk2hZn6IJjGnheUTUFltsI1NWVPxU3IBUA4+Gg3IoDXOQbZNleHHI3sSkcgAeX62Nbxv/ndYXSzx2d7ekW0h6JPqx+vVFLiSacaLNikVN98HBw/JwnbrndihdWlvC63ZBHzhIsH+/efm+GnkMv2JB9QazxMLetn8WfUFDzdD6PnrWN9jzajhnobYcysinN4dv/XMxMuIpU3ccEwL1l1GUMC4MNUqtcHhneUHkvBEjOxzIAh/P8rIS+0EasMPSz6WOuqaVPZE6exJXZul8ETO1bUZo2wZUGF9unB0iYYUQJGk18lJyKGvm6ID8QFmvMYqcE+BRT1eDtqbU0hNhEQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB3PR0302MB9037.eurprd03.prod.outlook.com (2603:10a6:10:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:08:33 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:08:33 +0000
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
Subject: [PATCH bpf-next v5 3/5] bpf: Add bpf_fget_task() kfunc
Date: Tue, 10 Dec 2024 14:03:52 +0000
Message-ID:
 <AM6PR03MB5080CD2C2C0EFC01082EC582993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140354.25560-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB3PR0302MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbdb113-7f6d-48a6-a884-08dd192421dd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|15080799006|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLhd1B4yOpW+yRg1lACrHHZ8gODeg/YXP4+7xtWlNp07TWJ3XRe6S5ri3Y7G?=
 =?us-ascii?Q?kNsrjYYNb0McW02nzRb3k3AkuUOh0xKhTvyJfUFPzxyaNz/1WERsTDzc5BsV?=
 =?us-ascii?Q?/cJJoWkIG2VKZyPkHd/wzKma0vxBkv2GeCX/Ao9PvjxrpKazntqgtUEHksYp?=
 =?us-ascii?Q?BBNQuHUIHkT2xmdBh9udPf8SzhlUqGy0c7WHeJaPAqv8liY7A3s7LQLEUDnS?=
 =?us-ascii?Q?FBNXaRJrONrNnnALIL20kYHdIfQ7nTw9SupGtPj4oGeJhSOAmFMmrNoC+W5t?=
 =?us-ascii?Q?Ec+gzfTjrNqF5t6YX6w8b01TzKM1ZFPmwLF4gbuVqHihymuqurVyCh7o3RII?=
 =?us-ascii?Q?18hPsEEr6Ds8ozXnk6b+oN7bQa52v6EZLaGSzGl3LhTW6z4lUnHRdzF9a1Uu?=
 =?us-ascii?Q?89olRzdnNVn5PWmo4Dvv+6ca1nj6z+P30ph/L5I+YYO7KqpzRjp+Be1tmiQ7?=
 =?us-ascii?Q?ixJ6E8n/gDEsJNzNaNMT0Y9VKrvNFKD7qbBTXIanvhAk8wiwO7MELet/L/7T?=
 =?us-ascii?Q?anm7uYBQOQ92QNTiA+DefT1vSi3Mgnk0Fyyg0ENuZwabc3BIhY0sFZB/pNj7?=
 =?us-ascii?Q?5+pkywnb/O3/+y6N4WAQgHlu/VXBIxm7npZUJFabMW2nLk0NtNDR/a60G66K?=
 =?us-ascii?Q?lvEVkHOtYLFlODSbyhQwzEsm9XyGpW7nmlW1lnU+Cjnex83idWIdqqXDUNKU?=
 =?us-ascii?Q?58Sc6uz453a1MqOEIeCb1Nm3q7lgXad0BHDG3CfG/ncHCxCUS8EOkvQ0Cfhs?=
 =?us-ascii?Q?qYeWegTASOvcbrP/WcEzeTfMOb6d/alZVSrijSPasOnagEZOyrmvprUpc8kE?=
 =?us-ascii?Q?1yHlZQu/cJtMTuUF9kubTeaKfhydfDih9bf/upqhuiqaNzHfi2c/8Dwj028a?=
 =?us-ascii?Q?186GxSrNMgNpOr1XUUHij7rJzcOz2IXd0dCXcI1nXKwFjcRtiyC6pvMhmAfX?=
 =?us-ascii?Q?mMKpfmrcBFxxQPE0cMTiZUp4hREzmX5hgp9hKpcWUjDez7K9fA5m/pMfTh3l?=
 =?us-ascii?Q?BUgu?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hD/+LxZWOyCJxDYBcQi/khjPthn6ANF2215K3wIKwnaWZ9HI+BIyTvQ99Keo?=
 =?us-ascii?Q?1R1ko6krDKMYhAQNmCCHxqBNSxFGD3LkfGC91RTgW7G1PJcDZ5MKJESkcqBR?=
 =?us-ascii?Q?R9XwZp31YPRhZdDcARfWrxFS+O6D4IXaatDqaW38CnNFqO8L0o6a7siBeILP?=
 =?us-ascii?Q?R92WUiRecNOS/VHu27f6bCIjQLMmKAr3D282vQYeb0jBbpw/GJP5vfn6Cf75?=
 =?us-ascii?Q?b1lpDQnUE3nclUY2jO9ULGmsyq4+bdvFMuwa1abMa8JsYHgQX4t8M0ofRtP5?=
 =?us-ascii?Q?s8Id05TNnxMZv7cL+8ZPC0EJT7j0HxMI5sJM4GXhxbYZZPJGswBamZKjm0kZ?=
 =?us-ascii?Q?yS2W/dZe81SVehIKtpaSCMGsGbRkztSMOZ/0nWqUxzm+ZVWm04Iol7IIsnFt?=
 =?us-ascii?Q?f/f0IE37MDFccRushVhST5ASOjrlKRJY7/BJyEpAl7LxaWS05BuSkolMu2U+?=
 =?us-ascii?Q?GVFp2GdnnoXakSzNFj5g//KCv/9CZ0RSWMuo8xRykB3k6mO2w05q42DvP3nc?=
 =?us-ascii?Q?xyMoaBzZ0RnSRS8U9ABdXh8W7y0+LWmiXL4ykV1IqvTv/ptavjpktXjSJo43?=
 =?us-ascii?Q?yqZjbjeIhEk+i787oMrDPF3A4g7sd29LoZb/yXi/jZlCMI0F0ba2MqfD5J92?=
 =?us-ascii?Q?rDxdvfcsv8jiR2RM97L1DV9xflrVZEdQPM/frboVSdOcMw79firPCn6a3FVC?=
 =?us-ascii?Q?YykVMgFApA7H+m5wksYwutdgrFjYUuCPol5hW3DgiEyo2AYMVTrQePJd2p/9?=
 =?us-ascii?Q?5sqK9ka+rxhNaMvp34TPfz3nzs3ClIdEjIFfN5HEuF1Nf36lQyX6FKn78+nx?=
 =?us-ascii?Q?kznXk9Js5WUnAjZABCkpecL9nS91mbWD/Gjf9tBkp1eBoB4DYdLAa5W7xniV?=
 =?us-ascii?Q?rZ7k/vQbdwSYLtnSKR8kZ8FAQhgQ6XeceC86LmYeehW+gv8uiiSdN9oU4uB6?=
 =?us-ascii?Q?Na/n4SN7ZNNKghRtXzTEsnTKoxXdWl6o6r8B/pDHJ2Fw4RN/zyK30EAiagB5?=
 =?us-ascii?Q?JoXfXfLwTekab4XrOoGtTHvCVtq6BvcE3zex6w+AhNeptOVpPDxU0HWeUKkf?=
 =?us-ascii?Q?YWxOYcj95LQWiI/61CiPWc/CM8kk21hf16DGBJiNQPKZORUiuWGBlI3comvb?=
 =?us-ascii?Q?BgV2Zoq154nAYQBE0vp90ey0itzprXtZzpBMZXY9RKUamzqvvx0/n3AUYy3+?=
 =?us-ascii?Q?OQokw5RnV3L+xWN1Bkmy/iTFlV78I09P1udC2FsAAD+bJTcPlOUWKj2O/DHo?=
 =?us-ascii?Q?y/Y12khgUKAPDEac2XE9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbdb113-7f6d-48a6-a884-08dd192421dd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:08:33.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9037

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


