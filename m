Return-Path: <linux-fsdevel+bounces-40180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B1A201EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C11652A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6571E04B9;
	Mon, 27 Jan 2025 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nIPVd/TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010005.outbound.protection.outlook.com [52.103.33.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACB481A3;
	Mon, 27 Jan 2025 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021889; cv=fail; b=UD25BNUagXti30y4LW41Y2lN0kPtQq6zpMnu0Tc778taV5LWHyw8P99e98lrwiz4xJO5x5TduimYw4UfbRi09B23jGR08vVRW5QZFiSlTIIISZZ/i3hcvgcpYvUnxMC7/+kzf1bGTM2tz9b0h5bjaqYnkZQIu8//G8ZPaIhxJFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021889; c=relaxed/simple;
	bh=R1FX0j3ccrdp108Bs1PsHyNJF95PBMaPconV1rA7f30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UO9bDfUdEY2mz7yrG/uVa9wu2zm0z/lhFaqGV6G1i4zYFwg0qeN6bU2Fs2+PIV9hLSXqFicaz2Nu6nigTxolNngjEq6HrrSb5xdoHom1fTA3MxKpn/74CqY87lBaj+/RUDk4EEGiB8RK5JC0/m5hz6LX0DU4SZCjVPAUbKKkEho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nIPVd/TP; arc=fail smtp.client-ip=52.103.33.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaT+gc8q3ACwcubS/pwCd3Swzs+XtGKeZP4AagCRKCA4COsli4ZVrPHjw6lnBhk74XYyH5NxxZD0/vfalJUa3hEuw4pv3o566Ee4F7VmDqmDcuWlg7Yg9qZsl5imN9M9XIbGIM1LPZSvLT7iSVT5KY0NB23DMLJr2rs6MSxHQHy6QYDU07kg67YpMk9XmFZ5NYqeuRd9dbOjljl3/1+ZAtuqSnp4q+bKKU/bGNPxrdbC3SxtjLFM+6K6Su5v4MKOi2K/JHGR04h98z4uSBvJ3Qn2rJ0bbK1qv16sLVrQjflcBggkkdgO86xly4rKum7Tro8r3jzNmsZYTG1PcJKQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+lFUOEbNYJBLXwOkeTO7mJz+bvLyupgyonJxx7IfUw=;
 b=f90Fdu8Bvc9l+GcoBBVMVUum1/H5UdTUYJu02opIU02lvzVtt0B7LGOyLavvXjjXAlGJH87/HmXbVCtb9HaTx8TcLeCtWnBfnkPf56l10ZkKSN2d0srwUDnPGcEHTSR0jNxxF57AxP4UWL7xNCri2+6NXouvFhedChJ6sH78LdTzyz2f18T13vjz2K7R/wRVXU1XW1QRq9adZleMyejupTCsdwS22kq6kTt5hT7VYi38xle8BKbvrHWsrU85PBz/f6iNhz168ia7lK8TP/6JgGCKFP31xAMGqkI3IPx/whhFOBBTjo/PU3gBK8HQEd9mv6d6Tl/bhDKBWty1rs4b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+lFUOEbNYJBLXwOkeTO7mJz+bvLyupgyonJxx7IfUw=;
 b=nIPVd/TP+pnraYEbV5LNOtdpqv5iJfIeWtHt4pRH0UnLT8xroTXAAoyHnW6sxu1Ohn3TNBPLYte+MGGNFVBw41w9QbAmNZsLdwiY5n/+z6wd1Vfc1K0+vqQJPFr3a4RMzv9+1GhpWHHyLK3VUkAzEcsnGgCnJUhkC9jHSidnV/sT8fXkuPPBMrjT3IJj0Xjl0WEukhZCXxwPS39tWcP7vIGGRJdL4mqu9wT4CSVLwMvqDukmmRr2pybFesxbXGEZVX01ngS+MF0FOJnjlv5HMqvEj90iuV28S8WP4+kpih/B0e3L78kh1JHjQ6ltQqFzEmwXUlu4zs+F/wiubPbGIw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:51:24 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:51:24 +0000
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
Subject: [PATCH bpf-next v9 4/5] bpf: Make fs kfuncs available for SYSCALL program type
Date: Mon, 27 Jan 2025 23:46:53 +0000
Message-ID:
 <AM6PR03MB50809BB6156BF239C4AC28C799EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234654.89332-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d2c62c-a85a-4700-b2c5-08dd3f2d822e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwzHl+l0QrDzxtSz9aX+kfxHS17O9XMx4Ziwla+/uoUiAnaCT8Xgy+jb0uVj?=
 =?us-ascii?Q?u7bWN3kZjq+ByRFpqie8zjXqUiGESWT65Jmd0Z8hazKDtOxKkJDL+cyrnVDl?=
 =?us-ascii?Q?QRVELj/wk9VrH4r9Bzf4COg6uoNWDqr/C5PMn6c5kElAW1gikhKCwbBsoG0D?=
 =?us-ascii?Q?xwwu+UOpV/JWJRWmMyG8A2XiDjNcqSj+VG5eD9mMFUzZilSTpFCM2HCKV8iy?=
 =?us-ascii?Q?MC5eqgxJ2ldBvYouxYEMtquLGqsI2nszWFHPM5Cb94HyIZvyfvsmGbMCDwY0?=
 =?us-ascii?Q?IGCeQCOxIfh4bmzcwcB62scbhkC5TI3QnWUsScvD+JhwUVbFk+fywycI7saZ?=
 =?us-ascii?Q?qGoyjLlHVTiDSp8ELCqMKpHTPw+TAtXHUZKaVqewNy/Yq271QKrLw/s+zFLg?=
 =?us-ascii?Q?LmKcLVE7S9kLP9bCFEv40SVdnWcl0hXJhnOOnWYqxB4Ww4WZQYOmChRwFZQt?=
 =?us-ascii?Q?jJCkzhqc1H1LxyyvoU7zHhihijmfR/ThNqn28lUKowFUNeDftLF2VIXGPXnS?=
 =?us-ascii?Q?pH/mBFlpkBA0DoEGFVmsoUXDZO1ggBkr7zN18t4SxbgUwhxhXDHNnrR1u5qO?=
 =?us-ascii?Q?dMnEu0PNFNnoZ/cxZdEyI46Vo0bvFCoIOX1Vpm8s+tLIRNFM2s6N2hvPiuqL?=
 =?us-ascii?Q?ayrMuTlTGgOtGurJifYZ5/ESQFwA0CUz7OCm9RTg6Rqud94QzbeKkub/SZyV?=
 =?us-ascii?Q?ZdTHaxy53953bCPSe7P1lI1O5x1AHwkaA6TfwoUkBQsepCTK7xIddzYT5JcT?=
 =?us-ascii?Q?cJkJpV66YhAUY/G5iv6X21AC5f8m/rAUNs7O8swmwFeruPh6d15NHFypyjWP?=
 =?us-ascii?Q?jNG2ke+M4PTMkVDNl/F5E84iDzgzCKJfbDp+D3lTfqxeYByr/LhQCmk4mi67?=
 =?us-ascii?Q?3MPYFChCX6+dwgrB+lz/G6y6NbbWvUNFnOHiMsAkaVCwwwJ0NjFBiiFtdLu8?=
 =?us-ascii?Q?+Rm0yTB/4hav+KyJPfks65CB2DcVD9oXvaDwaw5RS7nTWxGlTh+PEMVeAs2u?=
 =?us-ascii?Q?Atq0foDnX3l7O5tqFee/XzQeF9Z7ODS+vssFZfce2kGGN6m+8uOKX6UaxydD?=
 =?us-ascii?Q?HJglSfo8JqagJ9y15pUrW80OFJF5Og=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Ifmc3VIxipoC4k9tIRgWJ5m7ihGRzkKuVeUnyQIdcSgFIIgDD1pTlMtBjCL?=
 =?us-ascii?Q?j/f2n1sMtEdzSbZFaJXM5r/2eYGxNJ02S9smSZ5Xk9Xihh4bLz6FeoHS4gE9?=
 =?us-ascii?Q?hFQgMj/PBejxa2EGJVJs+S6zFJhU9qjURQWO9Svvmt3JXONu2lD1wwXuHrLp?=
 =?us-ascii?Q?hpMYSjE2A0LXTno+GR0MAKPVI1h+/7FZ4ePlzmOTabUzliFO9l+RtG3wYrYI?=
 =?us-ascii?Q?MD6nOJDe/Hc1bkTfMj3r4qCRenPtF0ktYzUfqt9aNs55HW3fI1ekWUEXGBkQ?=
 =?us-ascii?Q?x40THqCkfufWF0lEHhv+JecFxvZfT2kg66le2Nqb8EIjV2F2SNmnZLGtx/Z+?=
 =?us-ascii?Q?cnK9O1N97UPqhCnnYh2QGV9a0/qXU+GoQIZOoOFxVQYd5orLF41KFfie6fNL?=
 =?us-ascii?Q?aBNf3Q8n52TWV8EfiLQxy1qLUq4jL09FJ9pY7ii+YzThthMUJGnELp4g7suw?=
 =?us-ascii?Q?HXAOsXe0rVxouKL+qSNhBA1PTc31FmZY85Lb/cnKpyXbQ+bUQ8cjnUoQ8cM8?=
 =?us-ascii?Q?tfBJTfnrxyfvJfMt2NsKAPyl/CIG6XxUJL/a2OL/oNAHY5hLMnttSaz7izQD?=
 =?us-ascii?Q?qk5wKQgDDdShg/0dHfcVTcr1lsBMAyBkBmu4O3KYU8k6QgGvgU648pZMlgSV?=
 =?us-ascii?Q?i7TfudOeJL+kia+nflEu5hLaL/rs3Pb6s2JxKyZZUrCL+4hI292Q9gbMNjUy?=
 =?us-ascii?Q?AvzddqFnoigz+V0m77S+cdOEez4LeuuyrqSwhoc3BJ/OXMbOrc5z3Vl55H/r?=
 =?us-ascii?Q?O3OUtQqJmZZ6B73APpZSVuaF39QlZ4puzYDqS5IfL36tF4HDmznUbhbSmAB9?=
 =?us-ascii?Q?+8CqWbhBxc1sSgV4pIHgdy+8VZHK6cl789I03NSKsiT+b2qzUzscDcXS9JLB?=
 =?us-ascii?Q?7q6EICmGP2DFJJwkRp3rkwX40iwYJgj9f5178eoKDRZas+73GkT/SiZsvvF3?=
 =?us-ascii?Q?yz43v/uCXAURq+4MY8416Guze0XNDMLawRRmnenN5v3tVCp7WUybrYrPBf9s?=
 =?us-ascii?Q?tKchaAlK7doh6vQiu6M7LYITJ+LITaITLaU5RpHl92Aw5WtVdjtycPbgZMPl?=
 =?us-ascii?Q?N7NbeB67zCCrMaGXE95tha4TmQuNK4oTXfCa+MYNz5hwIleWBXCgEj67z9GW?=
 =?us-ascii?Q?JejfTsTJrreVbOtKJSPzhrWW14/rUNUTFrtrEtF7c2bLXKfum7ZEiKehQI12?=
 =?us-ascii?Q?s2QygcSS4dtzvtBSblnPIuzLfJATrDXCZSKycOYLgbSev/AicQ0xBuMTSYDn?=
 =?us-ascii?Q?X2IExGYsTwA9Tb18Ve28?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d2c62c-a85a-4700-b2c5-08dd3f2d822e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:51:24.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are general and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL program type.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 4a810046dcf3..8a7e9ed371de 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
  * acquired by this BPF kfunc will result in the BPF program being rejected by
  * the BPF verifier.
  *
- * This BPF kfunc may only be called from BPF LSM programs.
- *
  * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
  * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
  * directly in kernel context.
@@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
  * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
  * any other arbitrary pointer for that matter, will result in the BPF program
  * being rejected by the BPF verifier.
- *
- * This BPF kfunc may only be called from BPF LSM programs.
  */
 __bpf_kfunc void bpf_put_file(struct file *file)
 {
@@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
  * reference, or else the BPF program will be outright rejected by the BPF
  * verifier.
  *
- * This BPF kfunc may only be called from BPF LSM programs.
- *
  * Return: A positive integer corresponding to the length of the resolved
  * pathname in *buf*, including the NUL termination character. On error, a
  * negative integer is returned.
@@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM ||
+	    prog->type == BPF_PROG_TYPE_SYSCALL)
 		return 0;
 	return -EACCES;
 }
@@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);
-- 
2.39.5


