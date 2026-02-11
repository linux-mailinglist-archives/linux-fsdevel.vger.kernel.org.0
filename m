Return-Path: <linux-fsdevel+bounces-76959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM7DGva3jGnlsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00F126740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 855633017262
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA9346AC3;
	Wed, 11 Feb 2026 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="GOFQlqKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023089.outbound.protection.outlook.com [40.93.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7933EAEC;
	Wed, 11 Feb 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829786; cv=fail; b=LEVHDu4vwoD+A+VbL58qdIdAUwyRyeOxrC+dTtOVZxJn3iv2UNGB0K+NaWx+LByn9XtjqFyUKIbkEh1ajTED5CTSf0hZXJmG1YnhkpQelBpYXzliBJ2A3l6Vhnwmb6KGL4bCotmZhL70EHcqzHXkJSKhq9gqSCXOVvxhH5o6NrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829786; c=relaxed/simple;
	bh=ylyaPhTl8WHWlWW7QED+gb8A8a9NInqtZffw7U06vF0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q+RkGHy91ANfXUj3ychSbk0gLlXUO+O5zE7SdEZ1V3bZvLJykZFvkfBusRktIq4B2JIxyICnkqgLy2KsGGQfwt26pAVwLbmAxzYbVfskGrhXPTTQb/0yPsHtMsDc8g7SL1THAeJXoVFkFO+Nmi5u89Tdr/njED3f6DPDs3q+ewI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=GOFQlqKb; arc=fail smtp.client-ip=40.93.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB7XeB5n+vEI8qpWS/fRv48Ckrkb7vyBks1Bl63TronxOuv01UYGLPlSY6wanUocdgZMPHkxa2l6N7BHpH9VeA3LYpg0q94Qj3Tq3C9BFwVqKlSkztMzCUVdPYpmMyImBqPllTOTemWvrkHN6w5KNTJZjx6azG4q7yd4sTgVHMssBX2BWaQTUsk3Nw5AWr94yxH+3m5QS81RpWaub85nKQXErPnl/oSR8wTvIgDgT+dw6g77WGqTxe8heIAlDka6wuK77VvOxHsocjqUdiCzS1o2PLPRmCgbkcqwhL9ItTxw5i1pm9nEhJ93P4zfTewjzD0Iaw2ELp2zI8gXVd7imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsD3GSZ0vtKc8V1lHFd6wlpJrqeWQ6bgV0S2oXwLuyU=;
 b=dAFtXZa/7BOXxCOMWi1vbTcM4s/T0VgZczOGnIJaAYZpGngOgbWFxXaIwh07wAa/5A9l8OZ5x8C6UAnhFbHsbFZI/4trKwyuGWt29VmCzyjgwFoYsMY8zHeGLPWpH+6WTDV5XhQ1C3Bk6YrxeM1jDWKHS6VdyDsvP+u8F7zkK7hC0nx6BfvgFEQEDIpSXnOili9JLX5BEzuurbITXEYhCQoRUSKngiDcPDs1KvG5j0LDbUQ1lc3+tPHlO6xRghIg6y80nDM1JAPubZQ6anUsq1aiPmbFbNqAmbqqcukpwngf4fkXQ7J7ENTEMckm34ZGS9vw3TLXOn/PiIVMD6/pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsD3GSZ0vtKc8V1lHFd6wlpJrqeWQ6bgV0S2oXwLuyU=;
 b=GOFQlqKba4CDWyv837C8QppLP27ML5sdtmgO9OsL2+lO4pq4XZy+FYV/m0n1/9kOiR4+sZOUVk3fKatvjC9qO0z38010EkkfESKg1IPgYjugoX/n435swzFIptLrucep50wZSKL7o5nnxkjisxb05XJ6iF9C64+/pkFwGd70g1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS0PR13MB6252.namprd13.prod.outlook.com (2603:10b6:8:117::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Wed, 11 Feb 2026 17:09:39 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:09:39 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v6 0/3] kNFSD Signed Filehandles
Date: Wed, 11 Feb 2026 12:09:32 -0500
Message-ID: <cover.1770828956.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS0PR13MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 373e8efe-c3fc-41a0-bd50-08de69905728
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfurN1rCQHh9jcaECN/ltBucOpOt+HENwPrkg2mjdSSN6ycMP0EeiO2CNmBW?=
 =?us-ascii?Q?FbT8JCXRaVudTfsxIR5UaCwn/Xj5DjJxyrK+nl8RteeB6/WNiGM+spmd0/q9?=
 =?us-ascii?Q?9+RlqnTuHZksdFIMUCuGksxRwEXqQymUTZCl+rNQ9pdHHl3k/+JQOduvNf8B?=
 =?us-ascii?Q?gsElOLHKLju9cJWUBHb2PRM3K3gvu8xO+a66TkYIP+3Wr+1IkgG0jfAn4K2r?=
 =?us-ascii?Q?+3uiyAwGqD4xW3q8tpS6ghMJZA1efT9Xs/e1ckAjkDJv4B1Jpwk1vY5+YznZ?=
 =?us-ascii?Q?DEqmR/vR/ag6b3J8fkrwW/mv8JPyXJO/EU3VslfC5+IGT7fPjUba+KSNwOU7?=
 =?us-ascii?Q?MGktz6AoI2tIl/Hm7TgYJ9NyYk/jNtKxqiFu3N7OO6ulVdQy/WDRwKlcrVZF?=
 =?us-ascii?Q?gKmF96uI6e1gfsOf6Zx1s/cGtSha36ncl3l3mg2iQHhkxRMW8ZxnwI+LI9nD?=
 =?us-ascii?Q?BRdEDhnjTmJjVDazju3muglopffumwR3pKAdFHrYKwzeCW4XWnfWvZkeu07O?=
 =?us-ascii?Q?VCLY4wOFNJnzAgjZI9F2jjVRV4l+g/fEAyxOgIJTOdtJyZbfmwXcMXf9AyOV?=
 =?us-ascii?Q?Zm9R6t4QfNcrhUH9EtHxlAbbmPNMvuRkZqpcAK8eAF8zvgQ42h9MUoQJW7ez?=
 =?us-ascii?Q?AkKyVEhjYxMvSqshAKsaah1JxpwdQrp6FrlNX2I+5CWACgUUuK7VRjUgc9D5?=
 =?us-ascii?Q?nlflvgyDUL6QGGtx0wCY7McKXsFQhrTOStWXlVW9xX1lO1OKv2JAqP1xixN2?=
 =?us-ascii?Q?rrUa2DeEp5Vy7rnkUNy2JAXvSQYKNwnIH+RywmAXmhihufTr56Df379/snTy?=
 =?us-ascii?Q?2F76inm61a0uKBYLGP6D5pElPjPKXWjNX7QAzQaZVoczRZGW2hauQb9oojyP?=
 =?us-ascii?Q?dramE7pqb3kWaKqb0yFGgUPj0vVhqQuU26VQRHqwcuZyKRORd6g72wNjdebU?=
 =?us-ascii?Q?SBYcGHZQ5Pi9haitvvGq+Eiz9NCxr9T8R1Lmjd6N2Wi3mgLNRydsmGcN1Ixu?=
 =?us-ascii?Q?e9Z7jgL9RhSU+dfYWDM1cIq9/goneWFlTeHg68B+j3m4P9ArTnfR898acfmB?=
 =?us-ascii?Q?LKxo4BuLoLkKWsk6jb7jasKTd5lOA5X/cTgrVo0HXNrMqWqAEI9BCO2EiUP3?=
 =?us-ascii?Q?LKM8pstZzvASnnfPafbgu/FaAE6DTYjTS76QBTbZfeCMXsVqa2vXZcp9wNAv?=
 =?us-ascii?Q?KY7pw6giCu3d/N5nIZnvocC/0LexfPNpF53lDk5yXk4ttAxtCKKihRU/c4SG?=
 =?us-ascii?Q?LR+uU3OUavn1PAd2/8shGzo051P3ZM6EXvtRJN3voVWNqvD+rbp8b5onk+Rg?=
 =?us-ascii?Q?9EiNoD35fZffCvrjVbaTNrMaQxfxc8nR94yPumNRDoSJNfk6DzPbdHBvq/JT?=
 =?us-ascii?Q?e8bFT2PvLi4BpbAknVcUVCM1quoMFlafrx53IR2P7B12UszrKSHVXCLM0mNR?=
 =?us-ascii?Q?WuNAGEkHC9UKZAs3q+1ngJ5HbbG2HKEHdFqnAnehyiQ85QTZTh3IjbCFlc8D?=
 =?us-ascii?Q?WpYHEruISwdvm3uR4hzP8igYwUTbm29AZ2O8nvUyZXd11Zag20TwJQmy4d7O?=
 =?us-ascii?Q?mJ+jFYs6DUucWDbx8Kg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8WNJRrx8/2ILa7bZIU066FK4rWuS3/iqahn5juTTO5wIl94W5T140L8aumvz?=
 =?us-ascii?Q?auPekUDrokpl1fOuvpKM1sntpTelGPLnQx58AGWdOfkFshzfqfpghCXgnGR7?=
 =?us-ascii?Q?TCknD7I7mmvLNVEH+W6XMXkLuhTMN3qYTv4yGV2Vq5o+S8ONzwwJTyedzG7H?=
 =?us-ascii?Q?Kf2jH6Knh+q3jJsY91Ybkt0O7RgZm4nBYB03cm0d+zAJqf22xt/JkcaAKoTu?=
 =?us-ascii?Q?GrygrfQRAMn4C+Pz4TYM/UHIL178QBBuiktFvufG+jGaJn1VMM4ozBvGZuNy?=
 =?us-ascii?Q?so/SFwc0mblEOgWykRH9jnnddbt2iC6XbyNaQaEDqCfo17fT5eOY2DJjmIWi?=
 =?us-ascii?Q?QVjBkN2wB15JdHcKkdtn9Ab6ZSj0kUxQ+O/vY0hlc9FEI1EbiMxgX1YwLv4D?=
 =?us-ascii?Q?UFeXZn/Tw9fM+sFJ0EvME366/IKEQ7sGPHYdUukWbJnRpdssLUZJvSaCnwo+?=
 =?us-ascii?Q?encjcXmDZD8OtT5svyLkbseD93Y9pbPR9OlBqbRLTPSf5Y84J1oAcYLiJbP/?=
 =?us-ascii?Q?/HiKiawTU53wKoiA8ncuebLOMYYnpXf/hfag+fJNxhjDccC0LSLu3T9vqpGL?=
 =?us-ascii?Q?4m4anWqM0EkFm+MKdM30GNIvlraQYjMlxinAmgOdNvSruQjOLCQKqhgOIqpS?=
 =?us-ascii?Q?gxpSl6pPOgg3JOUADo3WK8X2g2WxTd4tsLhEM8rQXiSOIalm6hi2vl4T7XAw?=
 =?us-ascii?Q?3d02i4+UryZ7Rw6zsEWkMo6NaP1q4GYmaCrNjRh53ub4zTrTqlvCyaeCDXeW?=
 =?us-ascii?Q?YHS/LbwVDNpImbs2VDjqe1O2QHAgXFPiq4cuBn2RSpl4iQrCGSVMLRYAVHGx?=
 =?us-ascii?Q?7xFgHwctlZHLlGqJ1nVWiVDspmO13W8pm9S/lWJRph79rORaB5W1aQgOZ9JT?=
 =?us-ascii?Q?oexyutJIDY1grnRIEJFmPp2TTeZ4KQyHPakQOEpuddqmwguvnaQKIhER2kQ0?=
 =?us-ascii?Q?WJeSGLptgUeAfWaYblbgxLXWorZXWo0KTY8ZEtrYuAZjr8/nwRnX4r/r2SoF?=
 =?us-ascii?Q?dtwgqUaOaQffpysDskUb8bglwhR/gzQDGmPM4Ve8uJUr6TtKvCBDTix31SJj?=
 =?us-ascii?Q?rJ1bE7CMtynic2xH+ghARcCz2RgPZVqdUgC4niYHKeWsiHpAsyf5JR59JnLl?=
 =?us-ascii?Q?kx42hCDyj+mtBr77Ztk2neOluAwZ5Nll/8qY5SDTQC28m+WCRAWQQIJAdqKl?=
 =?us-ascii?Q?wUhtjSdVTIOKnGt9nGr0r+ckfzmI9zaMVjp6h4C1PYyGpx2rcE7Xvlxc2OgX?=
 =?us-ascii?Q?C5XfaORFirc2R6QNiA7g/R3pgtGSK6zNzfX9Hnnw1rYW47viOKe7Df9lejwb?=
 =?us-ascii?Q?DuJoT49EClMg21p12IgxXjhWS4KHQBPB3CWh7mDAgqHK5uu8684LNWN/qajG?=
 =?us-ascii?Q?D4IhgjpwwpOhYgpaW9Xi+Vl71NSywGZKf0bzLvon6Z4bcM7rDg3+X90I9Ry3?=
 =?us-ascii?Q?M1WJJhcFFOtgSVNUaCOck1I+AfFG3zLPeAxJDEEzrO3+919y7vHn8LU5kZ8S?=
 =?us-ascii?Q?VvO+PjjT6RvXvY/5fexN2pLa1aiUSk0p1k9CATNXHYcDptaPRF8zZqj9i9y2?=
 =?us-ascii?Q?CrhqGtoMjOizMrobS1+ofHYjw+mWBcXuSkp/5UJLfqh48ng2NAH2LIH7rueH?=
 =?us-ascii?Q?VenGwZL7tCp5rOJwV5O/WDnNtjLSnsMYXRVo3eFCREcWqyOJWNuCTBkPvEl5?=
 =?us-ascii?Q?bTI/ac3RiJRn9IA8oM2uQ3mW/wCl6DpMOEy4k4ksIp10Ho4SVMWloxjLgGvu?=
 =?us-ascii?Q?oelj+ve1CrRk9OjJh+zfrb8MIRkckyU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373e8efe-c3fc-41a0-bd50-08de69905728
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:09:39.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S4CVodqWtbHJB17E1/jbplC24Ycs/1679NJvkNHN9KxYivWQGV9cKZ6C292NLppOH78L4mzAME2gx2khu4i6eMQue+OeDJrTdPrjY3f7k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76959-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: DA00F126740
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Changes from v3 posting:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
	- /actually/ fix up endianness problems (Eric Biggers)
	- comment typo
	- fix Documentation underline warnings
	- fix possible uninitialized fh_key var

Changes from v4 posting:
https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
	- again (!!) fix endian copy from userspace (Chuck Lever)
	- fixup protocol return error for MAC verification failure (Chuck Lever)
	- fix filehandle size after MAC verification (Chuck Lever)
	- fix two sparse errors (LKP)

Changes from v5 posting:
https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
	- fixup 3/3 commit message to match code return _STALE (Chuck Lever)
	- convert fh sign functions to return bool (Chuck Lever)
	- comment for FILEID_ROOT always unsigned (Chuck Lever)
	- tracepoint error value match return -ESTALE (Chuck Lever)
	- fix a fh data_left bug (Chuck Lever)
	- symbolize size of signing value in words (Chuck Lever)
	- 3/3 add simple rational for choice of hash (Chuck Lever)
	- fix an incorrect error return leak introduced on v5
	- remove a duplicate include (Chuck Lever)
	- inform callers of nfsd_nl_fh_key_set of shutdown req (Chuck Lever)
	- hash key in tracepoint output (Chuck Lever)

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  1 +
 fs/nfsd/nfsctl.c                            | 41 +++++++++-
 fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
 fs/nfsd/trace.h                             | 23 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 230 insertions(+), 11 deletions(-)


base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287
-- 
2.50.1


