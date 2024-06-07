Return-Path: <linux-fsdevel+bounces-21222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA646900742
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326D728A8A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A141A0AE9;
	Fri,  7 Jun 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WjEFsD0h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dZgGNnqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615219EEB6;
	Fri,  7 Jun 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771260; cv=fail; b=t0t31kyZ5AIa10vb0VkZjy7ZNJcn3Qss2rSDKhYxFqAl9gC5FXAsLIfF5CY+zwzEaB7/B6/tXccyZFwBf/83UJPfkOzsGUbBbE7ZWPV3nlYntRdU0rVw4FB+n/jTrPaP4uymxxKVFtmr9a5N3nBO5TWc1wa7p+NkA3GkAZ3AnF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771260; c=relaxed/simple;
	bh=8/PtKrg62Lt7mBU27WuelTNJLeqbr+BXqLZWZM49i8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHSBUr21Kc2Db5OBB7Hi9XOAKgWxfCUXwynGqLyBB0/gF73+l1vLrk1W9TQe4R8CkCt7wb3MgtMNQGZ6SMybzKcGSpMiC/PBqPnvZr0tHlKirKjpoRuhNJsUoqOHIupDooz5HEmEj3RBLNzZCuAsZvs5zamOjl889bMToLuf+aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WjEFsD0h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dZgGNnqm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuiN5016035;
	Fri, 7 Jun 2024 14:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Kb8pl50D+ErKEnSMAUw1TANts2VCOm9rGSNlQmRfOxw=;
 b=WjEFsD0hIz4W/WL1R1XSiqpj+DIlvAH8/Aw4+E/ke03aRz5Xm3Ni+27132utZ9hqvKH8
 4YuSlK2tV8SVsQcO3VxIpwKd9QMeXsK3C0xC9USNoKnKAoO2v0vfjUI8zl2c2B/B1xpp
 ent9mF+7fED/4bdsALpyzJv3+hAyJC2/ChGV1RaueeE2gnJJP6RWg7deo5S7uRsxd6+g
 Y++w/UW/83+ibNNOJ8+qJM7Xeno6nq2LhvYWq+BOA6Cv1GtqNQzGoIDLrKqTOaookT0o
 YMs4kyOGYQtWxllYuqcQPltrILth//3PSA+192rE2qiFYvhJDvkpv3vlNbMFa7tbOJo2 ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn5u0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ENDDA020618;
	Fri, 7 Jun 2024 14:40:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj6nrrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6SLdoNehPDWGs+dUjaN1a2rcYh4V/KF10NpJK50wGPiKoEJ93PI8K0IqJVinq4s11bEvNd6f5d63k8T6eldmbPE41M5Zedl6se6NGoSHlfj64x2Vik2cvSPt0gmZ9y3fpAakTo6iJgEUYp+We0adamLLYQMjJfIZEqdO0T/P8FU0NctK0u1k50su2XXF9pHYvVpramXM8H/t5mkXOSyo7USrzgxHuqRBfXKPULIlivdKeZS0U+UcwdnIQIj2/eMumxVfcmnin/6oHI8pg11Gcd7JDUg32zKtieXUh+HjZ2oSHpfN+M3XNH439Kq495UaW9Nh2DA/RBt1D8Qlb3mAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb8pl50D+ErKEnSMAUw1TANts2VCOm9rGSNlQmRfOxw=;
 b=X7ApT6LlmsWbOPxPKSlFy16luEZCujDSVoqdhq7YTpMN/bVv+yQ3J6HnpfbwSi08MHozv83g+3durdO+nn3vOYKeCM/SPhT8kROFP5MLL2KS1s8dXbu3G+QX2c+h/ShIEZ92cr7+1usIoHj6bfF2p9Qr9UKS1R2TVhIz7lyq35I27yeZ0O/IA6avAF5R4MuwHSVVYgXX0r86/KoyQzXx9ccqANAUA+uzk97vWTkOJfLOqjyvU8Cc84kVoQwX0AjBMHGC4GnCJcIDsT+q8qeqWBHIWjK7gKwTtwMo+Wb9wRb8iHJxHrql5ksaCv88VggcVAByyY2ZRAxd1dtn47LIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb8pl50D+ErKEnSMAUw1TANts2VCOm9rGSNlQmRfOxw=;
 b=dZgGNnqm5TzBaAx6gN7N9aSIjyzE0uJMb/ZA8J2dTi+9NTzAABtZrPRi5JpifhDbVFybuKMY3xg7Dnl7oHGQEuqhqKDZ4yOL8abmvkvOeAl5ftBCUvgm2Jjn6iEEMMPYkdz9KJlm84Z5XX0YmlL+X2TtagGqjPXy3rjV95WGcNA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 08/22] xfs: introduce forced allocation alignment
Date: Fri,  7 Jun 2024 14:39:05 +0000
Message-Id: <20240607143919.2622319-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfbfe9d-5ad6-420f-9b5f-08dc86ffbd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m4uUtmTR0H460tLFtrAPmDk6OwFL6nSBHXo2+KV6z46REOBeETFI6mb/hVQl?=
 =?us-ascii?Q?53jjHSYMIxTEXCBbekB60+6mHpLKSl4uma4HTulo0+rgJDh/D9JfRYnaT4Nv?=
 =?us-ascii?Q?Qc48hrC9ItleFKK3qzAGhOPdYuG3TzzJP+tGaaTdA3VK/cSXo0HJmCTTWODg?=
 =?us-ascii?Q?OSRy9sxv3cGZ8iRkMzDWtuBfLWKbgjZvek6vz53ZF61nxTONkEzDwvYTxqx5?=
 =?us-ascii?Q?UbejqKK50ETk4UiaNFcoj17EXFYw/hrJtgGqYpaX9FMRIOEsgBu1FBMW7KZB?=
 =?us-ascii?Q?JW1QnPFLcCSGdlyJ5iBAuCD47SruX5pD7VlP1tGIBN+Q35p7BYf0D2IywUkR?=
 =?us-ascii?Q?8ZpqX4Qm6yn1jCkKzAIdzpgtHMZs7EVVNSqUvOmI7dfEYG3TUTODOVYl9dey?=
 =?us-ascii?Q?n79zeQzx9So8hy9gRHdVmJBHemCs34LhofWRttk5WK01MpCo01iJIsEKSyjR?=
 =?us-ascii?Q?DLyweFeQkSB8Kzmk2Gje28vcpg8lv1G0EGinLzbWY/TegOuKG6DqZR3cSfl3?=
 =?us-ascii?Q?D2ui96IOJISJil3cTYpKqlY1ljHdIY1fK06N7B4jaQSB2Q97RgfNrkJioLCU?=
 =?us-ascii?Q?nUsIMm8HumgA+5RLw4JK9TQ1KTpSv5/klHAva97X+aB+20GusMWh7c6IgJIb?=
 =?us-ascii?Q?tP4qlf7/6cJTVLYAQKKd2OgKSs2xz0qs3AiFlxzjyxYTco5ONeLxziuYfoMe?=
 =?us-ascii?Q?/xsacuDNvWD9gSVEBzV+gbJGDm/6lLtScG0chH6CFM418Pmm+jXLSDHVFTZR?=
 =?us-ascii?Q?jXoJn1M8lzV+SMzTNHmwmIi3GhB9V9CgHZZtWelH+aI3KcLmo06LriBl8fyW?=
 =?us-ascii?Q?XLJ/F6Opi3QS2dg2ldNrGHs2ou0EEZputmqcS7io2UalIZfi5EQo/WciL0NA?=
 =?us-ascii?Q?FMufQZQ6fZD9yiky7/EQvC5WCBWO/B6P9ILEb7ZPXoJJfip6d6B6Rjurttqp?=
 =?us-ascii?Q?poa7vPnfUdOo0BPh8eNEtgcprSmd9J+KnSboOa404sCy+d9AfK+3I4SchF7A?=
 =?us-ascii?Q?A6tc5o5TmJwJsT94pc6U8rw8uaoxde5YNl3Un02sru8khu96jQCzWRR6aV4a?=
 =?us-ascii?Q?NsIQV4LA/NMzNf4aBHI+aKtFuO3+YaIIQgKDA/tMaYXxQkS8TgWubWc15cTk?=
 =?us-ascii?Q?EY2q0yBTByK7sludJKiOs5/A68yQQ9lVqojk9W0q0p4AnSrf7bCrk9nwi1DB?=
 =?us-ascii?Q?L5keo3bzx0jhWsw7BYjZ54AvLE+l/Teg7OXJ0AnNDXJu+bKHJuNW8cBxfoH/?=
 =?us-ascii?Q?nyqikqoDUmcjou9BTxn5pVkbZ7eVtOUyjocSOGc4MDcW1p7j6T6nG6DU204y?=
 =?us-ascii?Q?5Bs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yqj0M8+V4DpSGdP+r7jD8v/lUTKulwnhSpGrqv/V0FH6y1eI/tVVknOZJi5S?=
 =?us-ascii?Q?W/Iccb+m2HbyY4ezInLsnbMiTmRnVkFK4gHrQ5C3sFVcBUvSNs6mSbpW0OlD?=
 =?us-ascii?Q?m9J5zi/DB2RJ3h8uTNZ6SMwn9I2m2f0El0yoAs1TBiymGZa447s6wsNjM8Wg?=
 =?us-ascii?Q?4WLqmrKw5HbAJiDtBLBNErIWm0T6Nm5OKJ5yxHG7pvTXMKMrTXjFJ+j97vor?=
 =?us-ascii?Q?P4p4vxtUyL8Q2AAqd1u8dH143R42HYK94pa+Yf/oXFEPLfqehmvwa+6CHGsQ?=
 =?us-ascii?Q?S1J89f0hKaIVW+Jbh6VRL/dAst/M5qNu0OeTqp5fATRD9VecSnkSlhIOzVoE?=
 =?us-ascii?Q?I2nw/7bvBXjCRDCkciCGoQTCtow3a9BsB161WCnvcDFUHvoq93XEuCHI3+ol?=
 =?us-ascii?Q?M8F0s7p1xvJpgMxC3KUht4/hkXryp86Ci/5O5eULXLKLciEQOAhjEwR+vE21?=
 =?us-ascii?Q?6YDuh2syxhrmXHsX+sJfNlCSOwXgnlBnWZqHC+KXyQc9McVtdLyOZ0VWHxbD?=
 =?us-ascii?Q?E47RU1SCfljFHAtsWPbHAI1dKD2qLYBp/31EmNsk7CdBTge/XD3LjNBdkd/k?=
 =?us-ascii?Q?7QvXm8TcYeP7qXnbnrlF1QjL2TcYlv/5a25yCfzdU7e/r1EoDSLg4ntIcseq?=
 =?us-ascii?Q?yif+e7vTwVDyZ7lAGkCN5qLChQfVLLWRFCT/WVFj3vDgVUxqxv9+DeX4nI9S?=
 =?us-ascii?Q?r2zRwsLPGhmTITZPGDzXKUpfLBTh2hMiJ4RvbDLgXuSnUPe7S6tPdOiZ7sUG?=
 =?us-ascii?Q?GOyRxrAYQL4OyIdUp1ftD1G7yrG8RvdHqokMvOMCW7bISVVbA7FyFTCJBcvO?=
 =?us-ascii?Q?4a9us6We/gA6YzZKJibj8V/odfMxRez8BhkT+KsVp4BvGqWx4AAtFI+b+1wF?=
 =?us-ascii?Q?yLaG3XwtvtnmVw1HyJ3EwC+Ru7DXwQuijujN+jnlCX+wNU0mn+MRbbD1/ZAo?=
 =?us-ascii?Q?Xt7HljN9ntAswA4jLMPC1u+k09/YDs4BIwBbdz9rkK4rdAn2UWau4KFJ19ST?=
 =?us-ascii?Q?fgwpHfKsrGONTEeenlSiT/inUc6bzqj8uF004fyO6JE6gyAUPMTHEDANf5ty?=
 =?us-ascii?Q?j2aRE2MfM4Qt8CZo3lm5Q6D1DswwEJdeGg9GvS8IpsWZLDRRoKrXSfm9Huoc?=
 =?us-ascii?Q?ME7Ibd4OfjBJr6urky6BEDHRoYnGtJV4aXTDunoplcMZQjjT19g8ibI7fhyD?=
 =?us-ascii?Q?xDlWCqfaH7q/+HOTWu8amFcNfy8spCHBsHb7HyiKkQ4svgQtBTrX4TFohfTR?=
 =?us-ascii?Q?zC5ya5uvvIfQdADvIMyYvwWb3p0Pe0JAYJEuPEFUrHEyiq43ivv4wCwYLzC1?=
 =?us-ascii?Q?Gkb27ipiHTMy8ESzFbEcOL9ByI/fYepYgFZl+3Vi1RGixEOCyyWcJVS4Sun7?=
 =?us-ascii?Q?nfLRJwghShs4evyKfWulxD8dCj7TlhOPks77OfMgaNIJprPde8OpHscFkBrW?=
 =?us-ascii?Q?o4ewHcnB+UNf+BTLM2xvofWX4s6L7YCRQh6QWXogAiaXnL6lBO7BB6lv3rsw?=
 =?us-ascii?Q?xyceVQPDCayjIh+5Y6A7hKPJCPy66Bc5fGRSDCjPdK2yHBOpCbVRmAKgGSJ9?=
 =?us-ascii?Q?aR3o6+EqBq4qfzdSAEM/5G3rw6RjRp6sH/1kVolsTNzDeEW9fKt5tIWOwiHh?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OZIOZAc29pD6dkuTEJbBHr1jvX3FqV+EanVZW75Cz7DmHogFQiVy5oHLpH8fGxIbctCpwTnKAfoZpNp6aGsfZ6ym7MMV2ymVFJEjICbpikSGIhqiqdO3GeIZcHoXSTA2LeUbwo3w1+ygxNXlasowJl+qO2ImqdkrAiMVeD8fSsPFf+pE5TyFYsWiN851fog3aRh5RuvULofv4ppbOV/C8sDsACrhLo2QnPvKpJBDppcBYnD9K+r+iRbokeyLYG4UYeDOcmAtNCkVgqUXHvCPM7EHqzJEPOleZ0s52kOqvWdNaeKwBjl7uJHysGmayC6NaSpwP/fXnL5j1QLq5SMQSoyU4bL0LXd3B42t7OGtf5YiDTO9pd5Jw6KFwqwNUwat0Q51auK7NuLMhem/iB98mYXH0uhLd6Y8dTFcU9KZhexlL9gMSUJ+/oV/kcHWeEzbQ1STBAGYhWWpbE7iUGLcm9eMd0+y0Er6Ca7Jis8yuwx2itVmCNgi1AuRGLB5EZwcjBYoo+Lpg6TlIevH1yfxdcEHWO2YixX0C2fgFEA+y/fD6776ZOfIv/4KJdstaGWzRef9G9gBk1HzpsjQWNAe1i+xMJ9ty/qZMwPNHbHhRJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfbfe9d-5ad6-420f-9b5f-08dc86ffbd55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:13.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FNHa0X6cyAzo+RIKmOtv44WbO2o33zfXtpgZhAxnu70ygDVUx88v9mrKCdGTQ2onjhoAKCYAHYM//RR/3echA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: CB6qIAGerao2hBupityF-YjdZ-XPNdMI
X-Proofpoint-GUID: CB6qIAGerao2hBupityF-YjdZ-XPNdMI

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 29 +++++++++++++++++++++++------
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index aa2c103d98f0..7de2e6f64882 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
 #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
 #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
 #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
+#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
 
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 528e3cd81ee6..9131ba8113a6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3401,9 +3401,10 @@ xfs_bmap_alloc_account(
  * Calculate the extent start alignment and the extent length adjustments that
  * constrain this allocation.
  *
- * Extent start alignment is currently determined by stripe configuration and is
- * carried in args->alignment, whilst extent length adjustment is determined by
- * extent size hints and is carried by args->prod and args->mod.
+ * Extent start alignment is currently determined by forced inode alignment or
+ * stripe configuration and is carried in args->alignment, whilst extent length
+ * adjustment is determined by extent size hints and is carried by args->prod
+ * and args->mod.
  *
  * Low level allocation code is free to either ignore or override these values
  * as required.
@@ -3416,11 +3417,18 @@ xfs_bmap_compute_alignments(
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
 
-	/* stripe alignment for allocation is determined by mount parameters */
-	if (mp->m_swidth && xfs_has_swalloc(mp))
+	/*
+	 * Forced inode alignment takes preference over stripe alignment.
+	 * Stripe alignment for allocation is determined by mount parameters.
+	 */
+	if (xfs_inode_has_forcealign(ap->ip)) {
+		args->alignment = xfs_get_extsz_hint(ap->ip);
+		args->datatype |= XFS_ALLOC_FORCEALIGN;
+	} else if (mp->m_swidth && xfs_has_swalloc(mp)) {
 		args->alignment = mp->m_swidth;
-	else if (mp->m_dalign)
+	} else if (mp->m_dalign) {
 		args->alignment = mp->m_dalign;
+	}
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
@@ -3607,6 +3615,11 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
+		args->fsbno = NULLFSBLOCK;
+		return 0;
+	}
+
 	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
@@ -3658,6 +3671,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3716,6 +3731,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 90d2fa837117..805a8cf522c6 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -311,6 +311,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
+{
+	return false;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
-- 
2.31.1


