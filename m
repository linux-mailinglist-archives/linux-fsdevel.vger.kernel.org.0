Return-Path: <linux-fsdevel+bounces-59628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18002B3B797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E521C85DF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79630496C;
	Fri, 29 Aug 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ktl4tAVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013060.outbound.protection.outlook.com [40.107.44.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715C29992E;
	Fri, 29 Aug 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460372; cv=fail; b=JQ5dmvlYdwP5hWXZjiDKkXaDl3QscNZ39xTN6pfVq4GMGK+sK2oGhwIMrC0mcNadVQgWKP0oW0oET1lTa1QfVMFJOtxQkSJrp8qtuQEG1TIYqEy6wHaOpKg2el0ZWtMfrJVbI5rrtb+VGlKn5m2Pf/swfVu1GaTutuWAPTik6V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460372; c=relaxed/simple;
	bh=4GgsVmwfN+cVjIm5NAPKgQm1/FI08hlbbyv1XkTWelY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=syFTIjq3OyMLSARIe6HsyK87PFq26NG6QZ3alzEd6yNiGs/m0FmkcG4bC1Eyh5Muz+KJxNsvYTw+iDhJv4Fpgqwcy5guIFo3aUBEiso3mKN89tn3UELOn8uISFvM9bmaNcazAqmoHH4LLZxI4enArdAtEI/tIYekfZRlDa6zYnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ktl4tAVY; arc=fail smtp.client-ip=40.107.44.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUgx3qmhiEbm2coY84YUitF7kf/prYQnkJ1Wh+AUnQTOh2mLQ/MhgcNp0aTiLfoIS6aUnTcrHn+448H5FQ/qLYp4YC9BZLvjwLfZJwMKV0y/GwfY6TQQt19OasjLjuM/zI3o7mUubPzUONQmkrx+XlYOm/iqN1dzJvfW2rOdEqGnd3a9ddYq925A6l//hmK99IWwPsv2gf3r0CbpcfnkI/iHj2FVJnRI3NaUaqGUQIUsE5E1QPR6GsFZqDoZa8X1W+y7BZAmSA9ao0IzsFXa7yBj5SeHVak4ZHeJJXp1YbaXUOBwZlUX6Xjc3Brb0+tJ+X7lzgsAiua+Nn3zH6mvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXhwmRL2qgJ7VzmUYEHZ8RwucFfFF18U1F4XtTO1yYM=;
 b=iIS3y0BM2qBqPQkWI7PQtxvXcGBLXVrXWE0yV5sVtUfDqi7gQcS/XciH1yBqu0I4mpmtePkq0ch37ewoFkPngK6qU5wBH5jaQG1BqLAjLQC3r7TXHFZzN3CKyZIiwVW2SLBSHP0MGOsglqn0FMo27fsvkmYj+ER2PwEymq+zgtK6LQ6RLRlK/ucWT29gvysVkDLvDTl/dYWYZRG5NxJUjKeTDW1r/ddYCC5CuUsKuWr0n/39ZHT3L1z2QXYFZ4HEe63r/9IUF89fkEVTF4vMBFivs5+7NvnRigosqlw115kxcA8emjh8WmCHXmGC0dkxVb4ZQjF4mRNDOhRcBxOdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXhwmRL2qgJ7VzmUYEHZ8RwucFfFF18U1F4XtTO1yYM=;
 b=Ktl4tAVY/H+F6Ee+PsSpo1SLDb0q2SSQ97vYz6kNRLxzP3zLvGgvEOJu1FZNmCef/FCPl4UyxUCUaZ+YuOHNCFFw/zyIwy8naC0ZAFX0YGpbc8gUJp6Sr+ztZhN5YesMSyBjYnPJS6yL8Y1QFt5mete/iAHk0ItW0zaENcd0RQzvYv5Ns3lGYzYB/Jh0Tp4xILUGqKzSYZ+cTk50zxgPnGYFognmUomooc/JILaapT+PZA9txPW6CmT6VU+8s7OmgDI+U3G65MGsKQGg4HGW+NCQazZv0gw5zO2IQ92ehsFhKjPVcmMzqsshdlQMRyShRmKVaY1Bkhjj9eX8je0UuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PPF56C578557.apcprd06.prod.outlook.com (2603:1096:308::24f)
 by KL1PR06MB6905.apcprd06.prod.outlook.com (2603:1096:820:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 09:39:26 +0000
Received: from PS1PPF56C578557.apcprd06.prod.outlook.com
 ([fe80::3f4b:934a:19d4:9d23]) by PS1PPF56C578557.apcprd06.prod.outlook.com
 ([fe80::3f4b:934a:19d4:9d23%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 09:39:25 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [PATCH] hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create
Date: Fri, 29 Aug 2025 17:39:12 +0800
Message-Id: <20250829093912.611853-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PS1PPF56C578557.apcprd06.prod.outlook.com
 (2603:1096:308::24f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF56C578557:EE_|KL1PR06MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c62861-8160-481f-de79-08dde6dff10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7UPgNNugsF36z/5oAqkmWoEPIbR878mVK1uFbvd1h0YEykx0/vJE+EDnl56?=
 =?us-ascii?Q?3cUOqvl+HD+6C0NTA+fzXsT2OiWFKkKAnwIvAfBKKiH2bUj8UECTCcO957ic?=
 =?us-ascii?Q?DLds8jTmyWG97xC3oAoLwlp2FKpHvPp6E8mh/KaP/E7uv8eaBMA+wzBdpki0?=
 =?us-ascii?Q?Mg5IXCJY2TXN2CktSFMoYEXgieEVV5wQKq5WlVeLU8MMF/bugGrdEHl4Uuvu?=
 =?us-ascii?Q?uo9O4oNwXxJHu/TRpPrzYpNAR7PEAeFodons62qzbHbArBCHc4tmKcFT2h4f?=
 =?us-ascii?Q?y1ftTA49qDc8Uhk23EzDKHP2u4quJcCBIURwSsPdQqoTAoSN+ERcDi/o1Kyd?=
 =?us-ascii?Q?WS1yU/1/BVSAlqTmzH1tA8yz76dTxI/vIeUnK0SZ7oQtrtMai9TVtFC8f5Nn?=
 =?us-ascii?Q?Qa3W7unN9rC5yrDVMkqWlvdVA4akkYzJC3uU0TXM71ps7IxEqVpjVkQtuT5R?=
 =?us-ascii?Q?HzzeZzxqyaAdI21mTvPihZ96PPnTdshdhMTLkvHodXOVF7PdVf70PAh8OghU?=
 =?us-ascii?Q?bc6kmgFx5DnJ6dEX8F02d3orfDWRJJ/b2TGuEgu7Ct7dEjTSWDifxamUX+Jz?=
 =?us-ascii?Q?rJDeYrrjagYOn2lYi1KWH0+YOmScm9w+260hlWl5vW/oD6tGak97R3IPXO9k?=
 =?us-ascii?Q?+farYzWMVXYY4O/slJSJOnhdDs/zAp4cDgMFGqIOS2XcxoT2EoZ+vLOBtM4G?=
 =?us-ascii?Q?pp8ztgQ1b1bUW0rNG0f0S/TSNtSzTIifFBASUb0/WjQFXr3Yj6DAMMofuvBU?=
 =?us-ascii?Q?WsHtshr4XyCXg3UMb0+Zzxg366pivAcd0uAV1qfjKYrEZPOY//A36VIqwzrl?=
 =?us-ascii?Q?riU7jtuaHFFvFevXyKeV3vGr4sRvY6gPokYVP9PCtvx4n0ojhm7jR2NSgIPD?=
 =?us-ascii?Q?gcUYUiEkX5U1YleMT2/bSTEVYM1NE+Lx8LDdjIBi9g/kSxsSJLf3LqdEBS4x?=
 =?us-ascii?Q?j+JQSpN5Dsz7KwhoxkHRDvA+8Fz5qJKgTWo9O5PEq3Z7M+u+0sjOlRDJoAA8?=
 =?us-ascii?Q?wlIP1FATsiL6yezgVWvwrdixNI/ZHVjeUIDdtLypbNKLxGh6sk05V7IBxVhP?=
 =?us-ascii?Q?IcCvM3bPoE0RdRhnJXbS1jLIKt/nxWQgk1BMPxm/Qemt+lEvJm3dNgw3+hP6?=
 =?us-ascii?Q?kXgU4uX54TKv2SYoUblJvL5xTP5i6SfwwucwEGlEN6hftSk+Lm0eifnY3u0E?=
 =?us-ascii?Q?Xvz52YdJrOFCR3pIOdfmp17sSKyUMciIxfZNM51JqLokPekfhdIeyI3AK+X2?=
 =?us-ascii?Q?/A3TswvsId+SxKH/qrgxKuPtBpb/XAGINNvZU+0xPuZQo0PnkpolRCTGIPVQ?=
 =?us-ascii?Q?tAAgHDmVcK9uz23mDkjlEYawwWJ2UlXSTqkYstRSYwtrNGMfn3WKEnOKDZr1?=
 =?us-ascii?Q?cwnadyBjYTJ9eyDj0nZkpX8yFi4xMv9Ti0nqSWXkakPvYl69aWy5LoftU+C2?=
 =?us-ascii?Q?PhLICwProH49iMERtMh8giV0Tpr2Xw4qv4/cF3GRYKqGHCzy6GxwnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF56C578557.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j8uCz1ovSdgF5cn5XevXmwpaZr9Vz20MPCWWqvbGg5uHid3FRfvwvm0idvIP?=
 =?us-ascii?Q?IsELuP0bSuG7jsS3GI4CajuQAkdxXp8UxYqoT8OCJRMLcE4jR1IJnHFrF82Z?=
 =?us-ascii?Q?fFjL4Pg12XpcwV+VedmiVAIfM+fXOD9iqiLYLlz6XR3qg37GOGxmlJdoF+E5?=
 =?us-ascii?Q?GcfHcOjMtjVF47Ok0acJrI+32QFk9xrah6Fjt/yNFqKV+hncs2m0tpJGrmhk?=
 =?us-ascii?Q?le0y2yOyVTLK+w4ZuTETNmgNQlUmLFLM2wV97eL9pzFZIVZKc1/5+FwMMD9K?=
 =?us-ascii?Q?yLlAPf47M6qJHqCX4Ck6605i/Fb5VFC2glMq3MWoO0YoYt1lL0Onk7xp4V5e?=
 =?us-ascii?Q?gt5sQgZ8PPO8MKV+uxqG9XW0ZRJ9lJ16pbVuDFlmlKhSnfGr192v7JGh7Bvc?=
 =?us-ascii?Q?8oTjjtrUsM3fvErqnj6q7q/0KB+zQFQL9uuADB0M5WOsLX0O6giH9QBU4ze3?=
 =?us-ascii?Q?B6KT6qlFdDdI5CVvl4hGm/VoqPo/HRdA+pWO2clVbqaX7QVdZ+EvJTKYmc9M?=
 =?us-ascii?Q?gQm7FChAzzj8wsCL/iq4V5AbGwdk+oUpzdLATgyFptSuknNatdm5O/jupczM?=
 =?us-ascii?Q?7cp8DBVr0yohJQrf3YxYRGb5LkFNqrsJbHHoGSVjDIj3Oqvpm7zD4S/jY7cb?=
 =?us-ascii?Q?7kscUUoRqiqMHr94y8evLyoQ1Xm7VTAhY5UU3OHUbkgXp2OMxJYXB18dz8bI?=
 =?us-ascii?Q?3WJjcvKOQFjTw6tlD0F20jV5UrpMKQCaRqFN1/TlHmraGoHSDINhbsh0970c?=
 =?us-ascii?Q?jJpPYaOG89x1v9HPAmMMyupa/KsBdMoYeOYph8KCBSgac4GKGU8TBWy7GtOt?=
 =?us-ascii?Q?zdDX4s6Fdmilk8x2GUVe9PQ6uFQAt5YOo8pTH1Nx8ejnx6Rsu4VLBlH1Imjh?=
 =?us-ascii?Q?JINn1j+uhHh/90pEAhh2euXVurvtZkO7tOEVMg52tFWmDLRLHAmuRQv/9HW/?=
 =?us-ascii?Q?pz7m809LqdcUVphQ2k0UarFF8NzwaN8VvfgiAEmReq3ffk0TwBSlUPscIMG8?=
 =?us-ascii?Q?yT5TcVwD/whTOGeubs41SBsRCyGz+hHcag7sQAlfjthpl3rBUXvWX2JpgzRt?=
 =?us-ascii?Q?qyxfNSjuUMzM5b21XevZCjA8Kgf35CGig4k6jgkIOE0AXUeecwwovcrtRoxV?=
 =?us-ascii?Q?rTLi33gxhJ9S+E0/oQDciWkVc+c6XHCfb0srZbmm8hT7/doUECtd2CDSaD4L?=
 =?us-ascii?Q?5WuAn1D0EINbFVUT+WEsRYJYV8wFz658kXZydkDKquILEnnJ/4rHReTbut2B?=
 =?us-ascii?Q?gVMsqYE03w6WkRivVu+FqyGmBzk6Hq97VtRMYLm3Guq0AgRH7rRkK+VFB8YK?=
 =?us-ascii?Q?22XTVazo1sxZ+zSHwgUg7Z6rcbjkQJR0dLkXwzJzwloVyPhNeluVq09f2hxz?=
 =?us-ascii?Q?IcrNqgYPDhXL436XBH4k6RRRaiPkwK5l3zT/1lzBNZJ7DmoTyEb67m6F1PQr?=
 =?us-ascii?Q?BxYekgd2BuNL2nvDybpL6IOT1VjWk/WC/2LtzXXyQdxU6MqRZKDiuJySClII?=
 =?us-ascii?Q?y7nIuC7nrAFL483lgTTEth1RncUobIAn03idLA9vr4k7SpgSQhLeFboDkLqz?=
 =?us-ascii?Q?L1OKxGj+UFSer7T7T95bNQGAh5pYqoG1dItyx7/L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c62861-8160-481f-de79-08dde6dff10b
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF56C578557.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:39:25.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tis4UbgJ49WxsiIFA311/ccbnfj6EvF+u6JcZt2+JG85CRXxvgQXVGiwKFApvVnndbpzcVvBnx9KJfZAeO5v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6905

From: Yang Chenzhi <yang.chenzhi@vivo.com>

When sync() and link() are called concurrently, both threads may
enter hfs_bnode_find() without finding the node in the hash table
and proceed to create it.

Thread A:
  hfsplus_write_inode()
    -> hfsplus_write_system_inode()
      -> hfs_btree_write()
        -> hfs_bnode_find(tree, 0)
          -> __hfs_bnode_create(tree, 0)

Thread B:
  hfsplus_create_cat()
    -> hfs_brec_insert()
      -> hfs_bnode_split()
        -> hfs_bmap_alloc()
          -> hfs_bnode_find(tree, 0)
            -> __hfs_bnode_create(tree, 0)

In this case, thread A creates the bnode, sets refcnt=1, and hashes it.
Thread B also tries to create the same bnode, notices it has already
been inserted, drops its own instance, and uses the hashed one without
getting the node.

```

	node2 = hfs_bnode_findhash(tree, cnid);
	if (!node2) {                                 <- Thread A
		hash = hfs_bnode_hash(cnid);
		node->next_hash = tree->node_hash[hash];
		tree->node_hash[hash] = node;
		tree->node_hash_cnt++;
	} else {                                      <- Thread B
		spin_unlock(&tree->hash_lock);
		kfree(node);
		wait_event(node2->lock_wq,
			!test_bit(HFS_BNODE_NEW, &node2->flags));
		return node2;
	}
```

However, hfs_bnode_find() requires each call to take a reference.
Here both threads end up setting refcnt=1. When they later put the node,
this triggers:

BUG_ON(!atomic_read(&node->refcnt))

In this scenario, Thread B in fact finds the node in the hash table
rather than creating a new one, and thus must take a reference.

Fix this by calling hfs_bnode_get() when reusing a bnode newly created by
another thread to ensure the refcount is updated correctly.

A similar bug was fixed in HFS long ago in commit
a9dc087fd3c4 ("fix missing hfs_bnode_get() in __hfs_bnode_create")
but the same issue remained in HFS+ until now.

Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com
Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfsplus/bnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..e774bd4f40c3 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -522,6 +522,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		tree->node_hash[hash] = node;
 		tree->node_hash_cnt++;
 	} else {
+		hfs_bnode_get(node2);
 		spin_unlock(&tree->hash_lock);
 		kfree(node);
 		wait_event(node2->lock_wq,
-- 
2.43.0


