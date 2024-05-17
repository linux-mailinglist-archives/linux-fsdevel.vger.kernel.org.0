Return-Path: <linux-fsdevel+bounces-19664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8D8C861D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F4A282449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFB405FC;
	Fri, 17 May 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BK+2a3DB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC754168C4;
	Fri, 17 May 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947565; cv=fail; b=axax2PtukElBcOxBSZLj2hEwE4f+EsWxdEpG/qOmK9ZiAG8agVEydUFPApKdbTwartAAR/qmyCIy892Es5Tv3VK2JbMC+l+Y48tnzQ7jM3yfUQYAVGTtbsuRbJLr0enyIsHQOn0JuoQ4TKxQqK1Z2XkGloDlb5HRFxCVYbcYBac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947565; c=relaxed/simple;
	bh=UUdmF85tfGO2r1bjHMDIvYJqO0SaSbIJDQikJsC25Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oGXEB8/g6hUiyWONKSE06iIDLjKje4335Bz4ZIztj7CPa5krV6HzD+fHvF/9BnsNNSHxlGDaC6XPqfPmYkVYIWST5wkshrG1u5vIJuMD65QB9F2shpgnJDF65L5SmPjMRwx6FE68wcEyljPuIgbEdg6kclFeZ4+/S3qdDwlo+zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BK+2a3DB; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU3AzvTg41ecjoggX/1hGJIiXbzZeeWdaEHNF6Oy4alVeOXSfQRY86qvlZWz9+kAYpC1Kr394qjDBf1cJDaEKXsf3fDh5yuQNvoL+lJfQrkF/8YLHGwW2OtWrF1BnhWmjoCNaLI+VPoXX1SeLdooiGQkoil4iMjbQSWoYqrQloOidjRDKs+RLmFvxB+rD42zIsuV8IEH5jocHtcKvUCkiweFE07/dZIx1dOZB5Mh02V/RYEYBvm4RRJUDxz63Vc4ool6B8ogEOq5BPxOxp+tz63twC3prTs0btlqkwh3vQii/NIcCNYyGtj1i0uJ2AEKmFxFwXqQ5QRvYMBY31WmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX2RG63KmsVdqvky/gv3M2wdVgefLhOP45H3r9W9O7g=;
 b=czOE9cyCQeU781cRmlOFw7i9YATvuXjuh7y05WfG2fACxku+hH3pZbzH9X91b5ByRQE7INQawS6KyDtIxwC6IipMlFweN5j1qw4WlylRX9Z2etlHoywia7fk7NHC3eQPXLrT0lUr96kaEZa4kN9y7xf0rSsPBZC5g1NBXeM+kZX6vajrDtnJP3V+Y7U3RpE12bh6u19qhpI69jg9IgsDszuvNWt9IDZWRHwMF11RNjavLESEoTw/JXSKyV6Dv9EPzJd2XdRqvMGOnJ3o/TWYQiovLZylKwpjC72XQFGDzM7eD+cKWaeyEnt+MYkYSweYntgSZvEFBeU9SXK/aOaecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX2RG63KmsVdqvky/gv3M2wdVgefLhOP45H3r9W9O7g=;
 b=BK+2a3DBHNZ8A6IoQJD/IYov2WoRkY7sz1v8OiuyNx+al7FnoaFlcxayAU79F2Xs5Mv/IZ9EfoKQ6MPhoPqzz11bYvgZ5O5hw/4s0LId9gn2y5EtokdcMMGtgaOewmgEAetH9MZaxUPdhUYJ+SCf0ZXAXCabyqa6Jd/Ku7ehsP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBAPR04MB7349.eurprd04.prod.outlook.com (2603:10a6:10:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 12:05:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:05:57 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	hch@lst.de
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: [PATCH v2] iomap: avoid redundant fault_in_iov_iter_readable() judgement when use larger chunks
Date: Sat, 18 May 2024 04:14:07 +0800
Message-Id: <20240517201407.2144528-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBAPR04MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: acae8d2a-85d4-4ecc-f0a3-08dc7669b5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHxwfIY8KZdupX6F9Xkxyv2LYoxfA7roAPn3bwTCXyOW70Da5cXvxQwOwOYG?=
 =?us-ascii?Q?bHNU80L4VunxbbbYXdaXlLO7X0tlbVRUNFt2vv4LkHpbUwuekIUjQyrK9hk5?=
 =?us-ascii?Q?6SA22O2blGx675H6H2UT4t+puJJE4USOEQimz+1xxrgkPE1UGUyHRZsQGpwb?=
 =?us-ascii?Q?O9MNnJUNwaVCadSK3yNynR8YgKcD9PflAqgK+vWwIfFgm8+KZGmLFw4CWrAZ?=
 =?us-ascii?Q?ueXjifRmLmNWyJQBJxfueT1avLcAXQs8059f+ZILgsEn9INHur1+3lC3OgX6?=
 =?us-ascii?Q?n6pUfT15qjITMIjkPPINA1RVfL5DMHeek3sSmmqBt69/JbZwycaPXxdCUxwr?=
 =?us-ascii?Q?iMmRa5xz68mZhNX+UwV6t0TaecxtR5MMA1pVTzH75EaqFTeWau6Bswjdnhgv?=
 =?us-ascii?Q?y0yNKW9U8r4QsnayanRYwMkNZB440BWlcTf9U/gF2GDs9+stylvO5aKFHz1e?=
 =?us-ascii?Q?DAJexwcz4E0Dbqj3EaIp1KO0OFev6VA8DUC7xdwNKRdhDQ+rCNEBpfsCoFWP?=
 =?us-ascii?Q?40SX/c8b4ykZowPPg6wtb1RcQKB/lSUrLKYuruWt11I5e0jvwYs3QxLPwAHi?=
 =?us-ascii?Q?GHkC6TsGuPwunbMr0jA1VhKQNIkV80HadvnMWP2fQhd20ThBUQvjcdG7uDCW?=
 =?us-ascii?Q?2PGZWQpH8Bqjfkl5bkVD9NZbSP3OSKUrxS22VMRWTivYrGjGpvbOH9Xed/Xd?=
 =?us-ascii?Q?ovsCgBdpT5971pFFlPbaozCe8jWDIN2XslySLqahE32nlX+HhWyoR0kedf1G?=
 =?us-ascii?Q?m+XF3mbdfbzoa9eSITJBZDKiaHtbIPpYWV/K56SLFBLD6uxl7Mu8lmWYUPZu?=
 =?us-ascii?Q?549bmp47igCKyyZPlFzqGlXyaAMf+00RA2ZYlNLwU4O67I2qULl1o1SXV1ZW?=
 =?us-ascii?Q?zdQ+v4u9i4Ma069n9R72LroslfwTm3UO26g4XBqJ+C6mN0SvSSclMkEx+O+d?=
 =?us-ascii?Q?odXU3Dz9qeudumhe/FHhumywoQjLzEJ+F1uWFbqXbeF9DxlHUNnVym8f5qig?=
 =?us-ascii?Q?TaQoSBngjq/6PJFO+U+Rf5VU5x3FMyOo6pdsQzClaA72EsLhnjDzA3LQX9YN?=
 =?us-ascii?Q?QT2jgQ4lgMkp2g34hnhnxsbl6BJo/rf5XNB6Q/mazE4yNhvW0OXD/DP/1aZA?=
 =?us-ascii?Q?yI1NDfYxkRMDX7aNJG2ICB9ivg6W3WiwqCIiAKC65KSOdRyox2CyTU6+ZCyp?=
 =?us-ascii?Q?6YzYV+VlzcPMoR9qINnFC6yXymyjuU8piN7++CiACKFiJ+OZrdjyYkSbHuqr?=
 =?us-ascii?Q?V7ocGYhnm9g9PZKRHfiKFU38JS704UOiDBreBMoXm17aFfqt8yaOjBWMYgx6?=
 =?us-ascii?Q?64TKrwMIZ3ZuK7+4b3YG7LEHMp6ywUvvUbfS7UM6G2Vt3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WwTT8ggmYiYWFfQfv7+48X4X0JczMthhMHjG4zkgmWpwnSPDi/+AwGRQk7l?=
 =?us-ascii?Q?+ru2PREClM0gpY4clhMyYe/n45QF2fK8OXrIjF3uIh2FPjN+M5hZ3CJJil0k?=
 =?us-ascii?Q?Rs18rKOPF8LjJhc56TpfennKMjwwWnyxx4nYYUvzKBjOJTa7ekxBBolva/IE?=
 =?us-ascii?Q?3CYL0COLKILxKZUWrO+/D/FevRJeCDv87e/N4V8d+J4qiBaNVyjHhUQLj3ij?=
 =?us-ascii?Q?TmJ+6f17PtmPKt4hk4yRdlOiFZsfpLPpwZbaQszrmUhuIU3ETKwaV6H3ymDz?=
 =?us-ascii?Q?ra3GLpI11JSN/q0d6A2qZRAymDM9ZjZNtw0G6tNWdAUADG3wqeuqL3eRfXnj?=
 =?us-ascii?Q?sHeeT2nDXWZxAei1bRAT7L0mRc3cNXDK9Tg9SKsu+TbORMElJbHfrAQW5Ov1?=
 =?us-ascii?Q?OagfPiMYJPgyycSmpa0poHYyNm5L23RQTsfiZ37Mz4qXuXfqTDlHyCYQIOJL?=
 =?us-ascii?Q?hkG1uK39Sr/8ogLRDMW2SwfFzZaTxZ0YylOX+F0qFSpbZbCIUULCjdJLc0bn?=
 =?us-ascii?Q?JfzinXwt6WVovegQHqgqT6i2gUx2JGTPkrRClqPxwmadJLiC3C7WUP/Zir1Y?=
 =?us-ascii?Q?MwtZAtQX2RgUeQANP3/WRIv+w+9EpGLzjkUlktdELydRfy+cDQ/No1+zz2+I?=
 =?us-ascii?Q?eDDg+xGF4QDULDMuACDY3jLEX9QntZM7MHBlqnHVXrStTD7vtID2pGqQfEK+?=
 =?us-ascii?Q?PX81uuT2gevKdJdyeZeLlpUfU5vkmaXzrQRuB90oznktVayEfZYexOVN4hxC?=
 =?us-ascii?Q?6y5FXcObVUe6p+A9NZJ3dQ63bobb8JVl7fwzrKQ/ZUlJg45MRv1OFcYUkI4q?=
 =?us-ascii?Q?/L67yyqGawRFTMtfJDJyZTmhg05OisY8sojgRCq5eTKGYKFR3+tBnzovGRKo?=
 =?us-ascii?Q?pTZ1yKoTtG8vyYayhQyX13XRCsag/PNpS9wDdezQlIQ3FJ1fuy4i1rx9Rh83?=
 =?us-ascii?Q?pifRKwzYtzl+h5zwwFhD5mqAMlZH2bQiwEncZOOXs5KMiUZSSY0cEYHwzIax?=
 =?us-ascii?Q?FUUWqpAw7okmUiR3Dz9L7DFtfgiu/iQMxYpt1HmF6vf+RtwwgTlyOjOZBHNS?=
 =?us-ascii?Q?yOR57MaLa7WcoUEWep5jmehZlt1BzK20oMBw9u8LaYrWXVFjaZK1Oyhp/xBd?=
 =?us-ascii?Q?YLUxVKXyQ13CAhgj4zyFX8zTugKTuSRtMbLpuYhpRRUvm/AM32LQAzOG1dbF?=
 =?us-ascii?Q?glW+JKWS/Z85j43607h9F28n1+qsF2G2laIHkKx7xdE9CqhG9CUccKEVc+Uk?=
 =?us-ascii?Q?xoMCsAoVdXj+CSftfwUg+0mwbqqHqc2H/ygCAKVCi7C/wmxH7GvYE4smsdum?=
 =?us-ascii?Q?HnOlFB7+av7YGR8WTtQRUmczP3oNJFtr3WdHv/l+Z+kuF8Ln7KlmpWXn96Ea?=
 =?us-ascii?Q?mb0yGeNuOAI8YtXKoBQFrivpyvTETgQ5CwysKhzrn31t89vtVPaXUbpmDAE3?=
 =?us-ascii?Q?pfKQso1zHv1d85B/tMD6dxnbLKxvko9h8NMkcxcV4sfJzoO9hkeb4ZlcYBq7?=
 =?us-ascii?Q?6Iwx0VDQI+egXqGvE67YZ77MtqoWR9G/uEl80E0p9bM8NTUtPJSH5fQVtsab?=
 =?us-ascii?Q?CiD77b7VTz9/SY2ShcH26MQkLQm8Tbku6h/LFbS3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acae8d2a-85d4-4ecc-f0a3-08dc7669b5f9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:05:57.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2xEIOm+25Y6mSfmM7R4zIkfc7ehxrCS6RsnVB2U0z/wLXvtF4Io1Xpyv92AMFLxCaQFZq1LaDJgEW92lmzoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7349

Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
mapping doesn't support large folio, only one page of maximum 4KB will
be created and 4KB data will be writen to pagecache each time. Then,
next 4KB will be handled in next iteration.

If chunk is 2MB, total 512 pages need to be handled finally. During this
period, fault_in_iov_iter_readable() is called to check iov_iter readable
validity. Since only 4KB will be handled each time, below address space
will be checked over and over again:

start         	end
-
buf,    	buf+2MB
buf+4KB, 	buf+2MB
buf+8KB, 	buf+2MB
...
buf+2044KB 	buf+2MB

Obviously the checking size is wrong since only 4KB will be handled each
time. So this will get a correct bytes before fault_in_iov_iter_readable()
to let iomap work well in non-large folio case.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Change in v2:
 - fix address space description in message
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


