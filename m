Return-Path: <linux-fsdevel+bounces-68987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A183EC6AAC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CD3B22CA04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616352F2910;
	Tue, 18 Nov 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LcQ8+1pn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022126.outbound.protection.outlook.com [40.93.195.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632B3730F1;
	Tue, 18 Nov 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483655; cv=fail; b=asn1OdlsYwswd2FVyvQ4l6fwSDgCCWKIFLM5gJVVzZO+JpfBmJagY9T+PUWYE7+S8aACmqYn7gLSeR234yh5labfuFiZ0c/V3QFsGiL4W+AVSDRNgpjzbWo2OhX3zd0jT1xxBpr+EThPMiLtjKQevYsclm9bnPGzwuOW9ReepTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483655; c=relaxed/simple;
	bh=vDPZScKy52yeX3O1/pkdbDKYrGRbzQxVIB2ORQXfXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQv4wZraqfOmBpn0lxKXEYtwTHuCpnSXlrzq3csvuC6NUaB1zvaTr+4WkyJcDwe1UYu3tglxcbVycO5ZRAz88f3n7zZBlUje9bsrh1PBx7V6kQuy56wWNfml8FEdvmWS5CSAqeGEv6arCtekeTYdMdSAko0z7ZLG10ZPKZwGmLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LcQ8+1pn; arc=fail smtp.client-ip=40.93.195.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNFm5IZlFWNhZkgTYIIFNvsG4ObF8SgvyckMa9W1v7jgTIsQJlSVVYJfYFT04qaC5qMAZt8ZHh5/WYXNjujZtA+KoH+QU/6htCf7ruAhzZRYwhg6W8fwMdmtx4wIOLq/UipIXt30NXMl1AnwTwLkKW0Uy4VesWUvdCeRxTK0NudMvLQTEzhIZD68aBIqXjgDrgiGmzD5VITr6ib0Rjn+KjDO1VaFcQjNzLNwOiFegKEZOglICYvaNorUmBh/Khc2EwM5UkKpJW7JqC5BZLN0vwGYi1BNVF/MlchqgVGEJTx4Zm7W2ENf+O6TaHMm8TFAa8Jrl1PWWSuTPyn1T7j4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOSYKXuPmJkHE64d4JaFEsOCf9X+uVqt3MQzEGCnee8=;
 b=lhfEcA4MaxGkGt6TCw25fvwG3vAf/c3F2Wpe6X4OKmA7k7XfHNQguWFh3QeFWN+7DZAH0akaTij8oJhOp7JKaqSl/MiexCT/1rkSY4A8y6EQp42A9KGkjO2bVRsfQNbnI4oLt42mTC91jy/r78MvjdGC2AROGmeuPz075QZzlvkKAdC7W873YzmPW2t6mM+ZlAVZ1e6uCdbhUP0HwYgA8R3q3VSCcuS3AW6hVQLq9uexpe85SlLjKR1gZyYNG0IDs4BV4mjX0ZeAsfXxnPXLlD+XIH39/NX+ovPkHkio92rYr4eL66rQRVWL0BRn/8GawaL7X3KRszLMahsfUvgTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOSYKXuPmJkHE64d4JaFEsOCf9X+uVqt3MQzEGCnee8=;
 b=LcQ8+1pneIOrZl6Zn/BcutrTKsXJLW7Q0NRU9omiy3dnWxCZwhZ+NNtSkogWC8GtjfXl6qAm0eYjq8P9rREcwPW41YRjyVi6LPPCfmTIp6/G6vVlZxBfYAQ4AjfJDH/kDRR3ugxHAsg8EU6B5Hfdu2dba5ZdOVdNaZ8XdP91Eks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by PH0PR13MB4875.namprd13.prod.outlook.com (2603:10b6:510:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 16:34:08 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:34:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v1 3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
Date: Tue, 18 Nov 2025 11:33:59 -0500
Message-ID: <149570774f6cb48bf469514ca37cd636612f49b1.1763483341.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1763483341.git.bcodding@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::16) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|PH0PR13MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: abfebba7-b921-4552-8617-08de26c04c15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SOa2xLoRzD/6clmeqmUwA8/Ur4xFwNL25Fh9WNU6IjfZ7iBjy1akYlN2U2Z+?=
 =?us-ascii?Q?oRSJbC2+vwr74h6EQTaOveGmMKy5ws4mTl8a7jNskphWP3eQxI0ivJNlbWhP?=
 =?us-ascii?Q?0ffgkAxVpLRUfNvN30dTy8cb0XckLPBzKCUe9EyIn22QXSy4dql+PMpJw7Or?=
 =?us-ascii?Q?2tvNVSsiighVUmNfX5W7DEI3JWVaaGT+OhAYGzLp1tTyXOyKcASnrHRAAjdY?=
 =?us-ascii?Q?wexzNej4hZpzKkchyImw8lOqOwsgbBi3cIwFRcf1RRZ4PmPVIHgEKbRnOnw9?=
 =?us-ascii?Q?lHzpuoIwrI3kggSrO2gLV6nlkG4IeTbaCewTQRgnAgDJaBPfonzFaV1gCyzr?=
 =?us-ascii?Q?3sM+L5wwjHc4z6L8I+9G5kccO1Whc99wyetKp2MtA0tnSpSecKH5Cfk2z0uM?=
 =?us-ascii?Q?W9i3obmBT6sXQRkNNM0dYbJ3eyoq3k4NCfCvcKHnXka61my/x/VINWsNe/Up?=
 =?us-ascii?Q?vN5gaEk7zgyZ5G7ku4pfpKYr9cRdzSb0AEahZXXPNXIR1jMbRnuAj+nxBYLV?=
 =?us-ascii?Q?9Sb9nX6PAt/cThAJ32Vzrl1liBFlhJpsF0tXWCJoL78YJf8ldYWc1x6dU6Mv?=
 =?us-ascii?Q?CPAaasMTzB14uMAQomArYBlQFBefzJ5Nf7SBwyZ2VUj7R00SNXV3g5wfiXm9?=
 =?us-ascii?Q?k9wgcx6OMrluYBoQBMgNdpRPDs84hDp9zcLwKgKQ0WII8/tgWVKLEI/xirBr?=
 =?us-ascii?Q?tzHtgzp4w5XMeEJ/ujVeb6BPnlz+09kafRyEYhQnnzxfQWayq2Qwpbslq+wd?=
 =?us-ascii?Q?EN9Ju6jkVD927BCnyWTwFkQ21ReGdH66tixrHtdrsNVGlNyrd+4oBB7PNmNz?=
 =?us-ascii?Q?vjfYVtEFuWwVHRSx7QGfeFX4A3V6DiHk+Uc5TgX2jXOc/DOsaCb1l/h2NlJd?=
 =?us-ascii?Q?BVPV8h1XuHHygdP+7mEbevsfjJn8MA+uvuK6fiF0OCGnMDWVqOVhAK/Pwl6B?=
 =?us-ascii?Q?Zzp6XDJ6vThPgVbW1aKPfpxXp13FOQ1hjYG2LsN+UcjAzjZaXecr7pRFMpyR?=
 =?us-ascii?Q?GN3/4Zw+Z+LTN2K6cEbXrnGeU8wOxjFBYF+dqyJ0JKX/U1lZ4wWEMTovhssv?=
 =?us-ascii?Q?Cu93efwzKKBAUl+vGSyGkB8pTzEGFeBA/dQ756doYPOWUtiY1sm9F3U2Xncg?=
 =?us-ascii?Q?qNXwnUWENyI5fQGRAcfEPDdljH1YAoPYVLEFpQ0s0ZBFGksTHEL1QsfYCJKN?=
 =?us-ascii?Q?pdgre/6A8xoi2+oGdOXNoap1j7EJAEmvwmjxx4Vo41U/oEEaluDGYsNVoWVS?=
 =?us-ascii?Q?A1QVuyJCxc0YtCrotUhKIm6LIO8WoqCiCYTIA3GRaWv+PyufjszO/zVrKOGi?=
 =?us-ascii?Q?8CyLq3gJI1KSAiz0+0UikHZTtbdEStQhDJKWnWXo9WVoVHUARHWHD00O0J2O?=
 =?us-ascii?Q?Itu8c8luho7V/kBHbJqGiHA8aLJ70qNaMqzTwLrSDEKB6vtZf953ZiwW2vFJ?=
 =?us-ascii?Q?hO3jsBqezUHWJsNMw9JwGhc9SuHXwN6O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJelOWlojdsfa+HDStvhIsa6SOnvKpRBItL2BA/yOOZ+8Mfkgb8davnUZqpY?=
 =?us-ascii?Q?AGNbUXqhGN4pNkoa0Ye6OjiTHsYvhXkx6M7n3MBqZvAo8LgRMh3rLAv4buGc?=
 =?us-ascii?Q?QdMVon7hgFmGPbVL04zl40q/sX+6GIfHYzKecBuVmr1+YAJruMDmxQxnn5Eu?=
 =?us-ascii?Q?iynGzN7iBYPiNSO7vhA/MzTay+o8nF1l1vfPj9hqMQSNE0PRxgqnmwDChI9Y?=
 =?us-ascii?Q?SNIFzjnkKR456lgnAx0icAuKRQ+YN/wLN2LKe7fsCyyqGYtN82y2n+C8tm4K?=
 =?us-ascii?Q?bUYEcQ94+cC7vqe3MgfuUBBA3C02xV8mqnRAb9uGqa7MjFgm6THQhuOEgtGJ?=
 =?us-ascii?Q?45Ca+l8gYZdKjqHgG9H3Z90cYFDqflDw7MICuOtayAG7bHPolDzIkf4H7OHE?=
 =?us-ascii?Q?0QuBIuH/qGlK8Z7tvfZ7ElS+rnPh/vqouEsRjlo9D+3QmMD6gvar7b42hfMG?=
 =?us-ascii?Q?2E21KuFLbWiASsaNIZeSHAfz2f29hEbjnEJeU7dixVh/Si6DpaJrUdO7RgYR?=
 =?us-ascii?Q?7hF4xwebmDKWu5qTqFTx0AdJPZFxXX++tTyxuqy+gwB8H1qdbH8j5mbAPRKm?=
 =?us-ascii?Q?PN8vFHRcU6tV72bdK3W8DFQ3HGv/xG40fl1SnwiMEzSzR73LlfYaM5v8SpZ8?=
 =?us-ascii?Q?uEywki+hNNlIZp1mz0i9YGLCFXet/oCalcgV9MqpLTC7CEsdyo2qemFclDwo?=
 =?us-ascii?Q?bdjxBfcfzmc8B26ZmRO1xh5V2V+OPPvK3HPcV1yeuTh3yiLRSf1QwsbauZQQ?=
 =?us-ascii?Q?Pfo83UcAyQ5CIY4PVz7GFd2iQsBSahHimQCEKxoCYygj5pr+y/Xh9PGiZqJi?=
 =?us-ascii?Q?rzFyolZ42J4WqqT3oXXvQNUUC9PvZEUlVoKEGwk5NFAkzgmV41lujTJQIB4C?=
 =?us-ascii?Q?98kEzn+zU3GUAwny/q/QpwfRGjHpPgcDYmTbX1Rvo0GQcK+TofcuirS5Ch95?=
 =?us-ascii?Q?1VAIJGgX7ZvH3COXOCo+LLT9JQwn4Khts8tzNJzBFC5Dz7qaxU5NuhuCMbih?=
 =?us-ascii?Q?mc3sSkl1NoFrfI6UEL771MkZvMvC7rh+klDFwGsxOsJ8P9IkM+78OPR6+b5V?=
 =?us-ascii?Q?82o32Xz3mNpecdvxaLzpNaj9IQcL2RkvMWDazeZrt14QcE41MHtDYbkgc4Au?=
 =?us-ascii?Q?fR+f+wAcoUAnnCM4KDnc7GmHEohAFVHbzq8M9Kwwf/3Makfsx9y9ifBzG8tr?=
 =?us-ascii?Q?7ezagHEApp9v7WmulBOybEtxPQZ9viZavQh+UEdfdtl6e5rndtmOVq1AGtZL?=
 =?us-ascii?Q?o+u0waXnAPQ1kkiY7jtOVDJ5xUjtfJ/x8kqQ8Imb1YM6HRkaTTk2EiyJdZGV?=
 =?us-ascii?Q?xqavSusNUJwMIwVbRUxn11v75Nrki9jQ4lfRoASNZtKpM0j4wkcVK4mqLjZh?=
 =?us-ascii?Q?CU1/GswVIqqrJvhQf4ue6WCyrUzVWpzWZUB9uc/YE15nb6DbX1jE9LajYPvj?=
 =?us-ascii?Q?ppS6agjBrwabuV8Nt9wNCtyV/D3u7jG6fsvjxO5vUuPs/iOO6QrH6d5CUXHZ?=
 =?us-ascii?Q?K9B6HuwNrbhcc7xQ3PBqcH0iTFfSdL0ZcJdBjOpuTqZON6zZa0gStu5Ep804?=
 =?us-ascii?Q?0V1ti8K+QloJvRs4owGXi/CLPJOqnmH8wdQ5mjpFVONIk+cNmPTxZv0MSQ4/?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfebba7-b921-4552-8617-08de26c04c15
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:34:08.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CznXY7ZaSsMyf07CfREqyQBA/l4jF4XPV6KS+jSm8teS8dXPx+P+5akHIp4N7gcFexpKtQWFc5igs+dIGcPcYiaguCAqso8gHEV3/ARJgBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4875

While knfsd offers combined exclusive create and open results to clients,
on some filesystems those results may not be atomic.  This behavior can be
observed.  For example, an open O_CREAT with mode 0 will succeed in creating
the file but unexpectedly return -EACCES from vfs_open().

Additionally reducing the number of remote RPC calls required for O_CREAT
on network filesystem provides a performance benefit in the open path.

Teach knfsd's helper create_dentry() to use atomic_open() for filesystems
that support it.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/namei.c         | 43 ++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4proc.c |  8 +++++---
 include/linux/fs.h |  2 +-
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9c0aad5bbff7..70ab74fb5e95 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4208,21 +4208,50 @@ EXPORT_SYMBOL(user_path_create);
  * On success, returns a "struct file *". Otherwise a ERR_PTR
  * is returned.
  */
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred)
 {
+	struct dentry *dentry = path->dentry;
+	struct dentry *dir = dentry->d_parent;
+	struct inode *dir_inode = d_inode(dir);
+	struct mnt_idmap *idmap;
 	struct file *file;
-	int error;
+	int error, create_error;
 
 	file = alloc_empty_file(flags, cred);
 	if (IS_ERR(file))
 		return file;
 
-	error = vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
-	if (!error)
-		error = vfs_open(path, file);
+	idmap = mnt_idmap(path->mnt);
+
+	if (dir_inode->i_op->atomic_open) {
+		path->dentry = dir;
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
+
+		create_error = may_o_create(idmap, path, dentry, mode);
+		if (create_error)
+			flags &= ~O_CREAT;
+
+		dentry = atomic_open(path, dentry, file, flags, mode);
+		error = PTR_ERR_OR_ZERO(dentry);
+
+		if (unlikely(create_error) && error == -ENOENT)
+			error = create_error;
+
+		if (!error) {
+			if (file->f_mode & FMODE_CREATED)
+				fsnotify_create(dir->d_inode, dentry);
+			if (file->f_mode & FMODE_OPENED)
+				fsnotify_open(file);
+		}
+
+		path->dentry = dentry;
+
+	} else {
+		error = vfs_create(idmap, dir_inode, dentry, mode, true);
+		if (!error)
+			error = vfs_open(path, file);
+	}
 
 	if (unlikely(error)) {
 		fput(file);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..7ff7e5855e58 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -194,7 +194,7 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 }
 
 static __be32
-nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
+nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
 		 struct nfsd4_open *open)
 {
 	struct file *filp;
@@ -214,9 +214,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
 	}
 
 	path.mnt = fhp->fh_export->ex_path.mnt;
-	path.dentry = child;
+	path.dentry = *child;
 	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
 			     current_cred());
+	*child = path.dentry;
+
 	if (IS_ERR(filp))
 		return nfserrno(PTR_ERR(filp));
 
@@ -353,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	status = nfsd4_vfs_create(fhp, child, open);
+	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
 	open->op_created = true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..772b734477e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2878,7 +2878,7 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 struct path *backing_file_user_path(const struct file *f);
 
-- 
2.50.1


