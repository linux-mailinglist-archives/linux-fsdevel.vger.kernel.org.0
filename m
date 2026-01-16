Return-Path: <linux-fsdevel+bounces-74129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76558D32B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012F0313BDDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC5392C5F;
	Fri, 16 Jan 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HTh5/YrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022142.outbound.protection.outlook.com [40.107.200.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC02472B6;
	Fri, 16 Jan 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573951; cv=fail; b=Hle4EDrS6Z88pqDB80i6s3pWSCg/ve4L/LfP4cRBYTJ/XzgzT9fM8icg2b8ItN7okAmbl5vP3TqqgL6pe7H/FnwpmKJfxMIrYIEG6uWDOZBKhGXVRVwdhVZXAy3SiUL3LttvinKtpASDBnzbNPCZiftJJ6QJljMbReab5D6nrpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573951; c=relaxed/simple;
	bh=6wss//5KmIFnFZLP3O8IIO+NbBBy3vYvsbZ3NP6ee5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6SVrcbE2GtosqD1oZOCHR1Xy3RrEkCvSVut3B4goKTGO6q/+xBjX3kHYL9sA26Wp7Qx5HJdJYwKz3EGrhtQZModC/vrSH0/bAL1D+doPXx1uxOo8kqFc1IOOwDpUP0AjQYpic/8LuHFuVrkv6tC50eBoTPTHd/hNEcVRWKqx+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HTh5/YrD; arc=fail smtp.client-ip=40.107.200.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUHs3/iGIdLtktuZ84h6bH3IGB8FOUmbE4+hHdTavcHGYM6yCJOqU2Evzj0mRal942Gshv8uFF6N3yBF1I2EINgg5Vb9NSfc94WB9hKTJCfb3qx9G4bvRs/PLFwHrBk7wdNKuUJoDZf2RzrVvhVFSgka0aHXp1vzivNMV3al8RtB7Z8Xvxm2j2/urHedLeOAHN46DvcSReT2hIF7tk8j9vryzawCG/chCtE3DMs6+5WzEKZp0rS5eybZmtmgELpsq8YVFyzi4bRti7dpAp7udONPtw9KMgU/YH1UZf2Zb9DvU82vhG39UnKB/aR7/7dThsNzWuUhxxuEjbzBQLGXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4xLriZgsDA+x/VdrcNSWuv82GuSOSEoj+sGWq1nfYc=;
 b=sB8OnF2whjID0/iXysPpIm3fbwqoerdAjbfPm7QFTPJgmUhqWGVRNVDbmq4D2VeVG46vzn29ECp0TXIrpziF7gwXzLZ34Ur8z7CskCpibmfc2/hy4t9NQUFQZz3V/CsgZ4Fs99OzQAm6phKbuD6k0BdciGGeWr3RFQCbtxAI1FxRNtGsS/S4vd57HsRwr89IMeWto72Q09C0RZ5QTOgOWUUIIAmQjbzhrvHbqabErprbg2A1o3cJysjl66xrJIg305lccvu+eBZp0AQX0/Sh+v7uFSPdsay3gC6vXdPQ8V5vhjes9GFE18oPygIWvJ709R5w250Nh8h4uYM3BTRXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4xLriZgsDA+x/VdrcNSWuv82GuSOSEoj+sGWq1nfYc=;
 b=HTh5/YrD4jHvgNTKseOHadhYvbdPdL5HNa/U9gZGwJI0c4E0n9HJeTFEELr6MZPXX/JSmWSRZp9csWAw72OCEbewlCH97GexUHxt7Q+xcKG4WESbqAgy84D/+R54ANl2tsEiOO8xT2snZRModRTppyXgAXTYIaZxDP/NYJv6kh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB4716.namprd13.prod.outlook.com (2603:10b6:610:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 14:32:22 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:32:22 +0000
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
Subject: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Date: Fri, 16 Jan 2026 09:32:12 -0500
Message-ID: <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca788dc-55b6-48a0-0f4e-08de550c0fb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bo3BAKq+FlLcEAPL0Cl/BxYEKpI6Oh2AJ/G4Fb7VJ37mo2pixXwhhEUcNxZ3?=
 =?us-ascii?Q?kSjC445WAaaCcP1DjWOP/YcN0VZf2d6ggrE6uQm/tYvdHvFqprNF6Q8NvsVC?=
 =?us-ascii?Q?IWIlbkOjdjsAfu7KqvKJVmsZacHerici1pjQCsHuGAqmG6ItQYfhro048xbm?=
 =?us-ascii?Q?0Sy/PFv1taPsrgaLK7NBuMde9daehj6c7IwNril/TtEk4DTjtrffiAH+0PDq?=
 =?us-ascii?Q?AmzeEUH+/iG88ienSaWoD7OyrAOwYXYPf3T1mf8o50n8X7ThlP7ILbtLFh9H?=
 =?us-ascii?Q?pCgwfw1jc6pidoDDBGcMrS622NeP7RrUkLFrtSDIfQbe5O5rc2I5RqqVMNmD?=
 =?us-ascii?Q?xM9CACUKltfKbq109CbDrVpX8hrTzjvyrLxhR/8XACVhaRPy4dI6P7RK3gqs?=
 =?us-ascii?Q?F/+9IVhPXo8CIBRUPXGtYg0DHx7+TvXYYxIBASKd4nWM+nmaBVM2XLguEDM6?=
 =?us-ascii?Q?B7tMZaZpfoS+5eJdxwUMNgw/2btGNLb69NmwP7fp+/TtaSQ9hJ4oQ3lflFoa?=
 =?us-ascii?Q?XabhgZeZYhfvZMvmdlSmvzg7yUUhHmfVaz+NwKDgvnc/WCjWLp028PJvStCB?=
 =?us-ascii?Q?jFw7K8l+zd60xqgsJ5vALh3ax/XNrCQetHCTVAHkKl+eoSQq2IbxPVWGVOT/?=
 =?us-ascii?Q?h88nxNv+YgYVWvLmBfpHss+EhtmuH3vu0kMxt/8LnL1qVwbIxS9hnFYPOW7+?=
 =?us-ascii?Q?hK7JuuEtNiBDgA/JYpNURd6BkMfsGUUbXhyZI33Kvh/56NRiXDvqroBE2gtL?=
 =?us-ascii?Q?D1dNTA4Lb7oGMAdo3yH8IHbtoSqsxcnsvwTCrWQ7Ewnx8rE20Os44xa8SjHZ?=
 =?us-ascii?Q?WaClTz6jqs2QpnQe7M8+tlHtIwr3o9guYTHbquW1a1wLqpxmCN6NkvroIYP4?=
 =?us-ascii?Q?OdE8GGrqCx0ALW/KuwZW3UU1nIVI5sRPWAWSeWs1SVDA5uSbDOedsVcHqt57?=
 =?us-ascii?Q?fgPPjldAUXnINKGYInMySBH328pLcVcaEoe0XhvzTSLO2LQZshwqZW0AV0sd?=
 =?us-ascii?Q?E344/F1A5MSCIvYtrYSgHVT8sZhiKOUOJ5xTQCdK3K6sxanbuBel82CcRKgk?=
 =?us-ascii?Q?JNMyilCbOVx5tcolHgu+PIFBm/v5F34aGjZ0Xqj0tEMRHtmxyNHHroV0sxmM?=
 =?us-ascii?Q?3J9qalrIBMo1dUop6r0bjk+ys0NyWxumGm5wsoJZXb6b0J4jQW6Ra9I/Ytw+?=
 =?us-ascii?Q?84JROpl4TMKCh56isoEYdeCAziuDFZ/Ri7SOeUWbF+D/JwV+KBWs/r5volQX?=
 =?us-ascii?Q?H0/7+0XwGqXEsaQRdADP8oyYKtMjS3W8gM+YKHKaho1xr7lmSWw0J62hCnBs?=
 =?us-ascii?Q?irMBsKszNXNbQB8EntF9z/ukkViSdd/SGHDzivPA5vTI5h8realHz4otrtiu?=
 =?us-ascii?Q?pUBADXNqlX5AX6aQe+97frC4DAp6vKVCZymu2wLDQl6vHjSdBigHoaqpXCXD?=
 =?us-ascii?Q?QK/wSBoPrv5CFE338XFaTR0Wh2UHp1Dbbh/xHwnhtL6Ulypco7TIl/RwYYtt?=
 =?us-ascii?Q?1kQFi9uHj+bachxlcdvgvGRodRk66pi0YxgtZHOGLa9a7g1HzxDzQ1gsTAP8?=
 =?us-ascii?Q?wnqdwI+NFuV8R3lIZhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HQx/v1AJSpNb35AgHzP7WvgxeaLcYLG/jx5Pjqc6l2iy5by5T5sMQiF3vJH?=
 =?us-ascii?Q?zKgluSJ85iUDZtfssUCjJtRCX+xYX1lYFwh2Qt7cZFpPJi8GXnnJO38UFtfr?=
 =?us-ascii?Q?UyIVpXML6TrutSIbeI9WMIhZaPnJ5h+q5Ubs+mhWlf0EPyXfsZYpK/utY39c?=
 =?us-ascii?Q?Wb1c3HFuUJ2K5fmhxOeH9rrQXk1osBGMkb4wxC3Pz1KmUnHTKf6Ku/E5mBzl?=
 =?us-ascii?Q?Ie6Fg/I+yeALf35UdeArawTTlAe4RNIae4lZlrUNyR8ApYJGlcPPYg+wRt8v?=
 =?us-ascii?Q?sWydT/YNowI/kgHAscpS93WMsUg3+byM/AsrQmXkzMuMPS4Zm6dm7EbPxgKD?=
 =?us-ascii?Q?+oCEmnjVe8WvZ7xeJTZ0KoK3XZRKk+kjjDvFfRwbQ5nRduve1TYwupkTFikj?=
 =?us-ascii?Q?3ZVZnN5MKc3B2ak//5cOg9E9gRQJ+/2EH7t+YoSXai7WNv/mRXxA+DzpIIpf?=
 =?us-ascii?Q?tq+PUrT6lZY6pr7NwFcompL5uOcxF+X//j6SObDEVngWJORt+T/KWHre+ghe?=
 =?us-ascii?Q?EjQO9m7axDFWPE+G2c38P+/miZqVg79GcFAldqV6MPXPOpV8GTjSmsnt0MXi?=
 =?us-ascii?Q?GhA/4jAPPsS1qLeaXaoRiIce7VMVHsSR0qHmIgKliaz8NEawPHOqaCRP0KHY?=
 =?us-ascii?Q?nAYSPtqiWqmU92aEBKQ2er3bkwm/7FiVWy9p02T05fGqSaxmS1fD+x3QH4vR?=
 =?us-ascii?Q?IAevnhX4p1Mjb+EP2AGYiHpNm3pqjh4rONd1WT2+G/5EPCX7Q6P9hu9I4gSe?=
 =?us-ascii?Q?DN0Od4kVNFD2/6iKqmWoflThYcxDFtimGflFXlZ3SrQyEt4DDNO3wKnDJP/H?=
 =?us-ascii?Q?Y61JuNJRnBB80Ow/tPWQ5awdvuk9Fle3N6yy7gRs5W8Dxzl8gzjEJothkCfM?=
 =?us-ascii?Q?ruQr1mx0YfCGMkYNCnsew32IWYwl6A5Dg7GmcgM3+0ILBfZXVtVEJhCW79a2?=
 =?us-ascii?Q?TrNqIjWzMYchydneohjQ3KNImaf2sO495DLbMouduxNMXXqgYO8bSlldsHAU?=
 =?us-ascii?Q?u2nj6XgB3zi5q9r1/I/nt2g/U4QyezIR/iBdiQF6Jn+0VzFt+A679bmJxs4l?=
 =?us-ascii?Q?NDGc9z6xcOjniv3dLSfU7qAmTYniA2K7EtUyjK0RUAwMH70h7R8TkLB6ENe5?=
 =?us-ascii?Q?ofbnYDp/M8lYP8Z+kYp/YQMfuxxf57pwEYZYN/HJ6Sg5n0fD1hD7ukeR8rYP?=
 =?us-ascii?Q?9ASZvCfLOKOi4iLlrPh0k4lZfaPT3b9zctAIUytwcqaWYH2fAiO9MsG+Ctrw?=
 =?us-ascii?Q?u7wMyBu42SR5lu2VKtUIZYRCE/LynUV3eMsbiZUJaH3HTcv4Rz0MnW6LZgxb?=
 =?us-ascii?Q?WDesiuh684MjN40mrZJj1nsWEpAlnTlA029aYa90s6hOob/60m1cHP9uLIZW?=
 =?us-ascii?Q?NFy0HF0FCeKqNjUUzhV9irWOqbvbUgyqYF4jEhD+xvArh1Q/zjwzRLNAl5R+?=
 =?us-ascii?Q?Zz8/uS7Ap6LfBMgAHpRSqSOBhUORm3+YuWSkqzGJwUbo7fOYv0Ih+W0N2cJu?=
 =?us-ascii?Q?l7lnZVlyp8WHgoogta9VcIDZ102LoSKgcfal/HTJ4Kg8edmetIFnek9NCHLV?=
 =?us-ascii?Q?5YEnneYQ8x/HxrzAymHP4zod4eOkAszGlI3490MAxef113ANM1BvcssaD0z4?=
 =?us-ascii?Q?Nxtj4//gXaNjo9Ovhw8wm9owwE00ysD8bSL+f8kwpVdT28HsFI+K8Pe/x8KT?=
 =?us-ascii?Q?bOgYSWiyHb0/uJo9biLOzv+CF9vKebSOVVTR7Agxp8BRz+cz6AKROvRZloy2?=
 =?us-ascii?Q?5Ga4BDzOJ4gkEs3vBAiXEchFSBQDB0M=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca788dc-55b6-48a0-0f4e-08de550c0fb3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:32:22.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u64kb5VAANjNpoo2Lx0kElwXAH4fqMU4kKcsD39mggjzQEuDjJW0AQo1w1ZsaEPmGuML58jQR2luXM+u5hB2R/6SaLgWHkenju8w0nGOg0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4716

Expand the nfsd_net to hold a siphash_key_t value "fh_key".

Expand the netlink server interface to allow the setting of the 128-bit
fh_key value to be used as a signing key for filehandles.

Add a file to the nfsd filesystem to set and read the 128-bit key,
formatted as a uuid.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/netlink/specs/nfsd.yaml | 12 ++++
 fs/nfsd/netlink.c                     | 15 +++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/netns.h                       |  2 +
 fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++++
 fs/nfsd/trace.h                       | 19 ++++++
 include/uapi/linux/nfsd_netlink.h     |  2 +
 7 files changed, 136 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index badb2fe57c98..a467888cfa62 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,9 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
   -
     name: version
     attributes:
@@ -227,3 +230,12 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: fh-key-set
+      doc: set encryption key for filehandles
+      attribute-set: server
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - fh-key
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..98100ee4bcd6 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -47,6 +47,14 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_FH_KEY_SET - do */
+static const struct nla_policy nfsd_fh_key_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
+	[NFSD_A_SERVER_FH_KEY] = {
+		.type = NLA_BINARY,
+		.len = 16
+	},
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -102,6 +110,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_FH_KEY_SET,
+		.doit		= nfsd_nl_fh_key_set_doit,
+		.policy		= nfsd_fh_key_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_FH_KEY,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c..84d578d628e8 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..c8ed733240a0 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -16,6 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
+#include <linux/siphash.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -224,6 +225,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8ccc65bb09fd..aabd66468413 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/fsnotify.h>
 #include <linux/nfslocalio.h>
+#include <crypto/skcipher.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -49,6 +50,7 @@ enum {
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
 	NFSD_MinThreads,
+	NFSD_Fh_Key,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -69,6 +71,7 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
 static ssize_t write_minthreads(struct file *file, char *buf, size_t size);
+static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -88,6 +91,7 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
 	[NFSD_MinThreads] = write_minthreads,
+	[NFSD_Fh_Key] = write_fh_key,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -950,6 +954,54 @@ static ssize_t write_minthreads(struct file *file, char *buf, size_t size)
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
 }
 
+/*
+ * write_fh_key - Set or report the current NFS filehandle key
+ *
+ * Input:
+ *			buf:		ignored
+ *			size:		zero
+ * OR
+ *
+ * Input:
+ *			buf:		C string containing a parseable UUID
+ *			size:		non-zero length of C string in @buf
+ * Output:
+ *	On success:	passed-in buffer filled with '\n'-terminated C string
+ *			containing the standard UUID format of the server's fh_key
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ */
+static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
+{
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+
+	if (size > 35 && size < 38) {
+		siphash_key_t *sip_fh_key;
+		uuid_t uuid_fh_key;
+		int ret;
+
+		/* Is the key already set? */
+		if (nn->fh_key)
+			return -EEXIST;
+
+		ret = uuid_parse(buf, &uuid_fh_key);
+		if (ret)
+			return ret;
+
+		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!sip_fh_key)
+			return -ENOMEM;
+
+		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
+		nn->fh_key = sip_fh_key;
+
+		trace_nfsd_ctl_fh_key_set((const char *)sip_fh_key, ret);
+	}
+
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n",
+							nn->fh_key);
+}
+
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1343,6 +1395,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MinThreads] = {"min_threads", &transaction_ops, S_IWUSR|S_IRUGO},
+		[NFSD_Fh_Key] = {"fh_key", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
@@ -2199,6 +2252,37 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	siphash_key_t *fh_key;
+	struct nfsd_net *nn;
+	int fh_key_len;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_FH_KEY))
+		return -EINVAL;
+
+	fh_key_len = nla_len(info->attrs[NFSD_A_SERVER_FH_KEY]);
+	if (fh_key_len != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	/* Is the key already set? */
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	if (nn->fh_key)
+		return -EEXIST;
+
+	fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+	if (!fh_key)
+		return -ENOMEM;
+
+	memcpy(fh_key, nla_data(info->attrs[NFSD_A_SERVER_FH_KEY]), sizeof(siphash_key_t));
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	nn->fh_key = fh_key;
+
+	trace_nfsd_ctl_fh_key_set((const char *)fh_key, ret);
+	return ret;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
@@ -2284,6 +2368,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..2e7d2a4cb7e7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,25 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__array(unsigned char, key, 16)
+		__field(unsigned long, result)
+	),
+	TP_fast_assign(
+		memcpy(__entry->key, key, 16);
+		__entry->result = result;
+	),
+	TP_printk("key=%s result=%ld", __print_hex(__entry->key, 16),
+		__entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..29e5d3d657ca 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -90,6 +91,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_FH_KEY_SET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.50.1


