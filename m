Return-Path: <linux-fsdevel+bounces-19662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4F8C85E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF7DB2125E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9813FBAE;
	Fri, 17 May 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qZ+tC0pT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92883DBB3;
	Fri, 17 May 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946985; cv=fail; b=SWLTVdL/vxNf7Elu3PlOgDyV0Gi/YDGi+50oFDqcrNIlDoICvpxg3qQ0RIbG9LBJvdyIKZ0z/6JnsrNuwl8abI9IrKSAix15+5RLlt74xw2Jf25HpmVBafRga8XncVKGhw9eNIj1p72SUbP9P+Sdzx8ZsgIbEShNuif6RXba5cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946985; c=relaxed/simple;
	bh=wSZ+TJAJf6my7sO7HnDxfasZJ48RvuI2zdDVtcO08+s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hkyxog+7CzhZdExHzmYALBwsLDsP1BY3WckDfiMGPjJxggPvPHIYycFRue2TVmKbl7ZIjJJSP5MhJiOJxny5DteTi/v74ZQBaOx2Yj9Sk5rVoeziKTUK6c0YiqmJkrW4DmtcZGsk5SYx+biqZ+62pxSCjboBPAcDFlyfZRAWT88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qZ+tC0pT; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKAOSlB6ysRPO3zoiZyM/YVHWLKfIOgRh74bAAtJ6Iu9QNZzagCE1nWnyaLu2g9YmfA/OBuaGadFIzJxwsL4pD9Hfvi7KdrK6So2A6XWoaTE2PJ4qKV8LkJhhgLvXFvFNcCeBXB87Ck2+jafKHC1OA/ybtscNQeVeW4qJ8MrfhQ/kDQ2WlTXWeBd8dfGh4Cia6AySCZp+DuwwC1if4O1+UFMqxUf/PEV2E+CDGKm00qLSzYcv2YZ1NDXpGLkXRZtY1vtMDjzK7SE2YW6lzLcD2d8HlKUPeD0t6R58DHuLOOqzCsf4TZv2Ui2d7LIDFH70wD2Qc0HQqcfijOiva1ndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfrCk/kb3JzeC6qyeK76h/PziCXFxegdfQMNgeDOIe8=;
 b=Nz9DqnrMJ4LafmDGO8l1y5b15u/HmXrpfanzZw1FFSxoZknSgKFhutuAErji3ITjZ6L8IY3Ef8aymI6/XeaBeFqbTFX5a0/oFWhTBQWuQeKj7bTLC0Q2nE1HPysA68Kltzg+kK2cdQRSIUCaNxSwTB85Qe2s56tFRUOG8Bu6Rfiz3FkJVRJO0t5b50PgIyTU7DRUHAoPB3xbK1Jgw7wej1ElJVtfKlaH6lL7OKMN3l0thyefu7fYBMAS/qxpHenpT3P+ASnI/wH8/7P/oFAsSnx6Khr4YL7iCaXUKThD1g3+Uenolr4VhqtJ3gKGyXfq5QcVWokBakz89WxeVM0jYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfrCk/kb3JzeC6qyeK76h/PziCXFxegdfQMNgeDOIe8=;
 b=qZ+tC0pTCWoIk2X/0WSE+WW7bfAVOvizwvTwn/UcEojWh7oZJNbZxpvFKy+EFiUOa4oEsLgZVhyFz1uaOT/YFouj7SKkAAJ33v2/0GC8Rs9e0YZIHmre+q4blQDAo2/85Xax4ndxTBNEhqnbLIt8QS7UFN4fvk8iP4xb6F+7LEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI2PR04MB10883.eurprd04.prod.outlook.com (2603:10a6:800:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 17 May
 2024 11:56:20 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 11:56:20 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	hch@lst.de
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: [PATCH] iomap: avoid redundant fault_in_iov_iter_readable() judgement when use larger chunks
Date: Sat, 18 May 2024 04:04:20 +0800
Message-Id: <20240517200420.2144011-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI2PR04MB10883:EE_
X-MS-Office365-Filtering-Correlation-Id: ebea04e7-771f-497e-0942-08dc76685d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wfc4X/ty8htB5ZyzFzE9e9BygqNs3rRNIACAy8p4FUKPZVujSC6DV10PdKTn?=
 =?us-ascii?Q?UgqWSE/Dq/WlMfun35ckhDdwR3fywrmMPsCYScEDHkd9MTv9c7DKOdH8iijG?=
 =?us-ascii?Q?96vYgWoO/y/DLmNXYFy27ikUcsGzw/6CvOJwkfMHPg0qW/zwRlAURHJWvmlj?=
 =?us-ascii?Q?Fn2kszSaJ/OOxeBGgKjM6ek36ukmMnYAqPz7Yzo10eJnXoHCAHmBpGmMlcej?=
 =?us-ascii?Q?d1wy+HMaM+NAWjNiuZPq3l3gSbDWKHb9xvUd4cchdPUKWgsPs39N/1VIsg2E?=
 =?us-ascii?Q?gxVHPyj/NflpjyyJQ7kDa4uqs95e79nGJg5ccZqCQkX3w9hABDJ2eKdUAdv3?=
 =?us-ascii?Q?nIvSFonSpE8P3aLpp7bayjyots3eoQb1p+AegNOwKYEmcOPKx7R27ANJoLa5?=
 =?us-ascii?Q?gKSjPQQB6olILcb2jfME7qd3Hq9wnOsRRQlRXLvYvyBbtavihBFCQYxI9+PL?=
 =?us-ascii?Q?RcO5SzIrjnq2PWNMPieRpm8XE8Gm4/MY+7dQuyZ+FPfBojfe6p4AzfUSxt5T?=
 =?us-ascii?Q?xHDQnghQKeL+K0GbafD1A+6hP3qh6rhrWOaQ7REkP4Id1//nZgpoQSeZL2/I?=
 =?us-ascii?Q?Ky0bhrbsFwNaFPMDp/b2Gcz3CIV5PlMIO2RFZhlgVHqR82twwLVQkUD0zwcA?=
 =?us-ascii?Q?InYFy0MS2bp+jTe86zCO1t+OQXTbjMUGv5lz/UhHXhDwI0sBA6+jTy33KAhV?=
 =?us-ascii?Q?6gTBv9GeQVDgnFcqKAXfutUmY7+VxdpFGE4aOaOLN8QAEv2EIUFj/UAsCLuB?=
 =?us-ascii?Q?b4D4J54e0TT9D8jUaJ973dJQdsejPOd/JDMD7eZ/3AaGD30frnf1+NU2VsLU?=
 =?us-ascii?Q?fl0EMP7LdJm0+a72MAcGmE4MFMVwSBc/rXYaijbGnaA85LdCrRDhNHR4cv+Z?=
 =?us-ascii?Q?yraIrsqvp+BAW87chEKIbd0hCMnS+Og0jgwr6zhz4wus8hveZglsWdtT0jKu?=
 =?us-ascii?Q?MjzrQtB/NLfjPOEpAtOJEncmCeFEU8+f+QWQF4/fLmewvL3NkiySyebmPh/p?=
 =?us-ascii?Q?QlK9wzB3Rl7zQk26ux2SBkMPTTs+5OQdxt6ZTwnbRdEeSCDjssMrtC7yYoAT?=
 =?us-ascii?Q?jSbxp92af2D70x07+cfcVzOVU68k0hMJ3pf50ka6etBGCp9aYu13A41j8YTw?=
 =?us-ascii?Q?lGVbFUFjWbY8M2TCmPSc9n9M8TiCpLg62EmUzyB5TGrSCWfzbj43Xr7NLMpd?=
 =?us-ascii?Q?3o4YmT4rLjVfRT9foFLqyKQijIhgrHi/SlaU8ZfMxj/5pwk0Q41q0sXLiJBh?=
 =?us-ascii?Q?uGWxhj/nxD0kTroVK0rTSy4j8m+KgHBLqfvEBORvg8iT2GbjZiaSnIN08+Xc?=
 =?us-ascii?Q?V7ZwQ1TTTqaHhHCB3aLETse2L3Zg6WTnHBc4ijjQujQDWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bW9EeupDjQMnFf4SXGFj4ECwpx83eo2IeIo1TPUsq+frVGVXrh7f49tnz0Pe?=
 =?us-ascii?Q?u+nW0FAWNe7TtBB+WR2FBGsCoUJslrcGby1pL7JqLOw8A+QeeLx4hG6Z0E96?=
 =?us-ascii?Q?hkxUe6qYw+RLZiUcbchlYQabIoknC3uh18VmgnG52kJOVABtJxghFo05v4Bk?=
 =?us-ascii?Q?0B+KfQ4dQwnEpf72l8vBajgX2nSx+jAHnCGWlw2IVCkFx1X6tFVM9wGKGB0P?=
 =?us-ascii?Q?8ut1+AB2PxKLdUVd8nzKv4xcBxXd+zw6EUfpfaEKxr8HdhVwRQPKLzLtdLYR?=
 =?us-ascii?Q?M3P1KEvVu/j12Mz5jh2s/jGiv0tESOJCKnt4Br43xqsz1qb+1LZH5/ZO116R?=
 =?us-ascii?Q?2Jt3Bh+FX+ftC5sRpm3GJExXkIgcDakO2PePNYWK9+9rz6sV17nXOVhT7eMS?=
 =?us-ascii?Q?uuAlzdxhKqptdrfec11tmeBcbs89xGBhZeLZpwzfGaycU3EC9g+A2JgsrVVC?=
 =?us-ascii?Q?S/uEdXBTikUCUDyPW8opbqB3FkuSzVrVP5wK/rXlTbdzaUT4gnnQBAwUOA25?=
 =?us-ascii?Q?nx804LXVWVvf0G7kU9WSraTKkpYIWNWy3HbVdBc9juqR0oLWWMfWSvQV3zK4?=
 =?us-ascii?Q?MhJHBFn3ulZdBx4ayhGWsaXNA6TEVSKwHnPvTEQdKn/v2Z5+FOEgdmudjvlP?=
 =?us-ascii?Q?pLsOVVqUF7NvB2hTL2U/LFoFrV+Qt0w2ZZ/8X+SPZrXAo5ynbwDFC2XsjYRu?=
 =?us-ascii?Q?q7Kod7V+y5+OEDDg+uJxNVrUN5XJ3Vlf+SrzOCGU3QzDq2jWwKMWveiSapLT?=
 =?us-ascii?Q?1WMLqsHserJtKbxGM7eawnivzGDBbWofCJjiesUSPNYzjdldUbvRmkFOpIp1?=
 =?us-ascii?Q?Oh6Y293jLv2vw8ojm2V4Im4dZSYBMwn0TUedFMT2dgdW5nIWyOk4ml1zpKns?=
 =?us-ascii?Q?WP9YvtjOZP9+/C1xyfHJDbdAfgazw9EFR+QhXcuDp7EhotyL4nuKncg5msYm?=
 =?us-ascii?Q?+isGK7JpySM2b06tPSS7Y6FUEKU/Y6B0Y/dDYIms87lTO+WSDpbZ0g0qDO9W?=
 =?us-ascii?Q?cKcNlexzKxTW14pMUTFmv+CkL0+2xVll8wTZlQGFNrB29N/rYkt7GZdRa25D?=
 =?us-ascii?Q?gYXVcMWf/KAcg/w/GeP32/+PFzhadf9ftsomdBG6WG0HjmIqWUosG8VXYIdd?=
 =?us-ascii?Q?Shs07Be5L0bSWvT6gCzW8kqdm76TFurLlorbwo9YAe5hT0A7dfZBFrBRhXXP?=
 =?us-ascii?Q?HriaDaLp6YeDksKLPYsbXYFY582CcS0B7dZC57aunzLDF/t0M0xCYRy0my5c?=
 =?us-ascii?Q?SrKH0QMXFay+Gfr9Qh1d6YvQbzsx3lZQ4+wgpPqi2OssRC0SAUGGfHgwDX16?=
 =?us-ascii?Q?3xhg5OFfqKu9dgkOCwOuk8SPvyU4GZEx/s5VObuclsf5/zXJXMQ5OdrMqavF?=
 =?us-ascii?Q?0sgjmxbusm6lwrumgnrpkO3KgmHxcpAyDUwhCmfFuTQLqYQp6CFHp8xZUSKy?=
 =?us-ascii?Q?1nCGmnYwgAevuimWbjzcl+XOU6BFJAMM9LbFqVfkr69vBPgcRRRwWN8BY5nq?=
 =?us-ascii?Q?EVlgc1GmjJDM7Y9h6FIAQn0ZI78Pr/I0SnGs61eUUmkmFs0F31h+0QOf9CKr?=
 =?us-ascii?Q?6fw+TzT2HNRPbNXooPnr45QYl6+ONqJq3BZsAvMM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea04e7-771f-497e-0942-08dc76685d83
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 11:56:20.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IxICLRaAL6wP1VEUX67FCV/nQX1uisYIBYo4KFrMHVjVEaTEacGQhjhyb13olIEjFZVMaORSGw9A1JGX6aujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10883

Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
mapping doesn't support large folio, only one page of maximum 4KB will
be created and 4KB data will be writen to pagecache each time. Then,
next 4KB will be handled in next iteration.

If chunk is 2MB, total 512 pages need to be handled finally. During this
period, fault_in_iov_iter_readable() is called to check iov_iter readable
validity. Since only 4KB will be handled each time, below address space
will be checked over and over again:

pos         	len
-
start,    	2MB
start+4KB, 	2MB
start+8KB, 	2MB
...
start+2044KB 	2MB

Obviously the checking size is wrong since only 4KB will be handled each
time. So this will get a correct bytes before fault_in_iov_iter_readable()
to let iomap work well in non-large folio case.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41c8f0c68ef5..51ca31cd94ae 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -925,6 +925,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (bytes > length)
 			bytes = length;
 
+		if (!mapping_large_folio_support(iter->inode->i_mapping))
+			bytes = min_t(size_t, bytes, PAGE_SIZE - offset_in_page(pos));
+
 		/*
 		 * Bring in the user page that we'll copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
-- 
2.34.1


