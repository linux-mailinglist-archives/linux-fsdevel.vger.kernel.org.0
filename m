Return-Path: <linux-fsdevel+bounces-32095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BE9A068A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1052862DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01920821F;
	Wed, 16 Oct 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eYJ1Eds4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ct6k9O+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9E207A23;
	Wed, 16 Oct 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073061; cv=fail; b=K8kqlDSPZ8Z7YJODiP3k+Rl4M1/SRcIpjjbMd6Xm7j7P33L2KszXI7LqJPiuFt3sp4XUwIXnBEW0pwqqpqvE1dLkrQQ44qiTpGX0Ve4CT+BS6/mfSHKo3XuU/0wCbgaVyXBuJUt0jfovWeCGzTGeqpL9QTnPw8LOByLZLIAon6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073061; c=relaxed/simple;
	bh=35kCZDJuXILcU3NkwvBrr0Ysi0FuKpa1dC/UWS+pyR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCJWrBswts+bZuiS+dqYYT1WNEMQmg5TiHsjlE45yKSABYDljMIW25p49yrB2WVN15GNFvBEUKWanBiuvxJ67BVLklLEVRoQYE1PKZzzokmDk78o6Hx5OD85LoOmW6xm1avGPGEs5+kDd7gbJ+R5a+lb3gnpu8GciCfw7XZ3Q7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eYJ1Eds4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ct6k9O+c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9teal016103;
	Wed, 16 Oct 2024 10:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fXAcptUI5TJHzxOmVU1fcsTHJkRm2K9FfPNnHxTRgrM=; b=
	eYJ1Eds41XqQZtTU8W3fS5gtEV8HRhkuG8pxFYInb4ozglBapA4oOJAApXQBehTk
	AVEdFG1kZKcBx3zQbwqiQXyO4nkaLEn+C7sBZQbaFGq/sVpi3Cya8bKJu45kVy5R
	yH/Oh92CLP9VqjY/55fcdifPL4ju060s1kif6wbQSy6MTE+pPqDBYtB8a5LJZW5+
	w2NocpwMzRziLJG4IjM8ADf/uzdvbIo73/B3jDEidE5q1s1VkWlN9vutQ9Tc/0eG
	0JL/ktrOx9DjHG0WX0T5AFflZARHS/eBpMkNi5aXSX01fkNrL9cjNaAMf3ufA1HX
	ycyrbLTFz2b0g6ioYuj50w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7kd3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:04:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8UAXd019936;
	Wed, 16 Oct 2024 10:04:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8mrt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkVz5FtBfRdiTBwiLx5EEI5ImnnMofgu/vTVRrzF2YAnlGW3oQ3Xjqw/uB2byVisDawN2Q3eNnsDB8Pbn2bSl0HPun4sRxt7Uj9FDvYUQgw15U3JSWRhnNmVhjdJzHOqBc7gol6gKesSOvxUmkpBiKN7VGy5267rWdtwh1g4aQh6tH89k39aZ/JnzAU3Oan20stWMxEx6dIw8FO4bt/wS3ZWA9CtIXOVj6NhLcEsn8vvdIXQKCrIIZIgiWnRvwCJ0mx1mDe1G7VcNW13rWO8nP87hjwyjmbIyORLfpYSCkYsuymPpF8MN89Xi+zvUpmtiBoHjAJgXXEPMMC8ubAeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXAcptUI5TJHzxOmVU1fcsTHJkRm2K9FfPNnHxTRgrM=;
 b=pJIIaV8OLhtnwgJ0FuEKfskbn0NGkCUKAjFF8dNI+48FiLAPxo0uXAwx7D/XKcO+RgeSl0AL28guJX71S2po6IzTfSt2r0b00FKw/bcq0oIUvPBdNmYvqS082Xoa4bvIq05vz+PgcFr8CzdSb6f8qdSwXqmbaoypbuS7xC/Z59kuvymLptjBszHmcjqIHfIsuI2rdcWWynxBMkRRw4mmPod9Pg7MbX+/yFon2cvvLl2e9DCfixNi0SVpBy640AlpDJT7Xb+oigQFt0giY92qaJa1jyteDqZHUlAAfOtii05fgMG14KTPA/EaHLh7rZZW8NjNlbCiPvawuf58jq+6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXAcptUI5TJHzxOmVU1fcsTHJkRm2K9FfPNnHxTRgrM=;
 b=ct6k9O+c6oH3gFm+eGZBQueYsbTXppNxYaDQTFTz1K2iy9Ynf047RPeP9/dhJsJz+ejm7Ywk//tFpAjSmptIuJ1HfekF98evZ/nDeKW/ImsreAnmokk4WCKjNskaHVU1of3z3ZNYr9UY5unXAC8R+6imiYa4ZMi+q3wvbt6duuA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 10:04:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:04:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 8/8] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Wed, 16 Oct 2024 10:03:25 +0000
Message-Id: <20241016100325.3534494-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 726f0ac1-d8c2-44b8-3f80-08dcedc9dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y8MN7NvplZW1BPNHtE5ZTXjYgqvA1zd1oS8U1Z1nti8XDPDQGxaI6R/lHn7W?=
 =?us-ascii?Q?WrgVvHYUwbo1Zr+0AcEZfgtC8Z/1rWP7lycFW8eteoTCp6oJEWiVh/INn2Op?=
 =?us-ascii?Q?jtHG6SvhJjl71A7FRazVQnvQ0sgOsxi4PAK9PAX2LigxzJAbXktOYykFOQuO?=
 =?us-ascii?Q?G2tKSOcWB2mjAqNCbdHLU1aWcwXFpfQj6D6M997fNswXF8pkSSbGUqEWhqRr?=
 =?us-ascii?Q?ggBTl5ovNqbg6Sgt90HBnycG77q32SQM5kMmo0XOicgzj86wJKRbS2Ocacsp?=
 =?us-ascii?Q?IO33UMDQOZzNWBbIUrQyrkrevvdl2nLlSCZgbW40I/iY8Vya87YqPfBoi/lp?=
 =?us-ascii?Q?cR4C05/mpkJujzLfQbQfVy+LlRZbLoZSvk0nO4yGUt6qXGcWoQkgIXhMrYkC?=
 =?us-ascii?Q?d8hNmfZf7m2Pih6xZ+ocgw6l+Cop2mfNcJOWkhI4rQdT4pUWfiP5oMpRCqEi?=
 =?us-ascii?Q?QMEeT0PdjuIdMhLLw2eVLcLx2oM5zobBonJaZ3NPL3jrfFVdQY9kMInZqMCO?=
 =?us-ascii?Q?EkjkdrVWrNeYKFDIl7lyponoTfmpp/IZkQnECna3IYtIddliRbJWaKf4HQ04?=
 =?us-ascii?Q?jDevxjxXN8/ewoNMXTQrXMLlY3iyoRrpvg2EvNZKxiXDJkIDiugiR5WDlpHi?=
 =?us-ascii?Q?VJ3qZfHjlz2WDL/qeqGJRzsaRrr9DZECxzP3laO9IyVvRpbKpFiLrOnUWDWN?=
 =?us-ascii?Q?Uxa1j3xG+Kx+22Y917Yf5+Yi5zBlqzojTM7kZ0tLT4PaX+wIC0Oiw3+t13BN?=
 =?us-ascii?Q?451wfApEwz6PjsOtT2nQjXoO4XjQ70R7a++NbNda6NQLm3rP2QQXrupnXzaH?=
 =?us-ascii?Q?xsDWD+Z4MIvRrADrTLIJ0b7reFiH6CyG171cSah1dHYOuvzDC3wWXEFmikBs?=
 =?us-ascii?Q?gtTDkALsoY+XC6YCXCIBVCF+HdwJ03zGmTEIxjn+0GUEKFyHuwh8hCD2xzwv?=
 =?us-ascii?Q?6o51d4uy5zcKm1XPkdPCmF0qSwNzUbzvLjj3lJBa+B/ZrMDy+8dk3n7KLjbj?=
 =?us-ascii?Q?J2NtI7aFqyUzMves407Wr6+fpdfaCvpeenj5dJa8fkX5qZv/GWsmZ4Ra2bsb?=
 =?us-ascii?Q?ziBldmqGZFMD9YBheEBDTRO+FLURgt+mFVm+5rvAE4ra4zlwpSk//ZBggPNq?=
 =?us-ascii?Q?swZbh/YmlxOBNoNlKohnL+sGi9yT8xzK/YMmIlWvF0og8kEscj1HmCT5IJxr?=
 =?us-ascii?Q?G4+jYM9YjU4iW2RgwrVgRx4aE6sR7gctel2aaNXVpGMgyWCkkbfmpg4avFrS?=
 =?us-ascii?Q?yGoKxmVZkduj1TC/JZgAuFLqLJP1gDTWrOzMyoan3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o55JrDxo0OaATun6QFqcr3MwZcCm027HgXzPFMkKWgblPHI5VWDytctUy1Su?=
 =?us-ascii?Q?bCi1L3RG2seUpy8gBn/4/8rW5PpFLR5WJuHwQISB+K6lOUXGO75vEOqY38lU?=
 =?us-ascii?Q?be2EB18WddsFQaclTA2p6US3JLh2awsJ2VhXZ8ozI+e+wyo0OEKUCsl7Nrtl?=
 =?us-ascii?Q?+4BwzU75kbtVc4YP8V0pdu/58n6kMyfqsluyB4fm4dendkDfq+BxEguUDXUA?=
 =?us-ascii?Q?Pg9c+lsP9OMi4VJWlcjMVBeMTJJTY72wDeb96bBIFlpThv2FEdjHa5AwETiY?=
 =?us-ascii?Q?VsOHfRv5iocCoVdBV45n4BHVVg6/VH/MAWKMFNQQNFvJP/1dIT/pfE8E+QOJ?=
 =?us-ascii?Q?Dou3VpXLV18q1wzNO3DD5km97FxJjejRbqNmAUjJh+38eUoeyYD2KfvlYWsI?=
 =?us-ascii?Q?MsUyrCeYNtLEVtS4v4r2cUBKNgV8rnmHkmVuZ7oYegy9cQXhxe1fmLxChlV4?=
 =?us-ascii?Q?cwmGQSHCThOnZBwsA72GdUhDfZNICvZ94dcCRuURk5nu25dqe+UtkRgLnrwo?=
 =?us-ascii?Q?VtltSeB1SfFZzgf9zndpittNAGrpWDQSKkkIHgqOszNgHkc/HJmlqukqp8a3?=
 =?us-ascii?Q?w3h0vVowdvrGNN1gMK5UcVMgRgazQ85Dy4/wm147Pxw7K14Ue3VAyzqVj6li?=
 =?us-ascii?Q?mmHtZcIbM8IqvIzCzsRt9BI4x4wtiiIg6BYkymulC0jl/oWkVPrMRUZ3zw39?=
 =?us-ascii?Q?XaQAx2dbd7XWJKF/om0QchNIb+TUPMhGoH8Z0Kputs03YTga0RNDXkMU5IDV?=
 =?us-ascii?Q?8ob+Z7peER12yqnMOtBco4PphCTZG8MpgZwjqOntlcpU4gUgAPkgYihh6RRd?=
 =?us-ascii?Q?8NR+UQmtP+Y8My9+qj2/cNMZrDyp3rRbXPeGRYg/BffyDl5ehSXAPvI//WY4?=
 =?us-ascii?Q?OLf4oDEhv5Q1s4LO3e52bTD1bvGmhrns5YehRItC3GlGTLJEsYKqiRSgVaCV?=
 =?us-ascii?Q?I/Xwxoeyw4Q7HrJKhcdiw83YZS2+iCdfrtcchMNUE2YFUhB2pBCw4+7XXVDU?=
 =?us-ascii?Q?8N5+72dbGmL5F+JRxdPSLFE8k2xynDAdnmChVk+zUgv4HUpdVT+XkBuEREwZ?=
 =?us-ascii?Q?UgfNQXE4XINuTlhyglerJk/glwZEsJBVEMl2VvLJEs/D5TusNnvmRbx406nH?=
 =?us-ascii?Q?saCvNWqyxrXpSx1iOrxrUibbF+kQeHFPsdDqpFAste7l8lJoxIEhvnSMxa27?=
 =?us-ascii?Q?WpT7KksfZ+VM/aDcWktBVu1E0QMJaSQMZ9CfcGrZyLeC3hCW2Z9u+y8CBLQp?=
 =?us-ascii?Q?WR9D8NybYCboPf0Mz7Dx74DtuD3Q9+Poc9fNpdQr6FHg1gNHNQoFmO8+B1TY?=
 =?us-ascii?Q?SNurcHNONzfpkqMruX5p6sd1CxnW+/QmUevqtvpqWfbCcfKKil7tl5f4wy7E?=
 =?us-ascii?Q?QurzBfQCE3DWEJ7YNbZlpLymhyq73On6/g0aqXl1bggJSg5sGnxV/czJqrQw?=
 =?us-ascii?Q?4Bm61wtOI+as9Olx4OMaqnJhSpNteW4fkkC4zf+Q0y1lWXhrgpQ870VW97Ju?=
 =?us-ascii?Q?RDg8Qg7YnwX0eLGduR9e3KpT9ry1bJ1F8Fbontoq+YxAbWg6gzRsSc/nYcRX?=
 =?us-ascii?Q?7kPXTw7RtNkfqlzxeIwR5q8PZ+LqKAJAolpXPXiMvPeJEx8SMzQ2i0Q4am5K?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XjEFgEiqzvLrik3HQAfdTIdFuNRfsvjQzwxCPozA3syadace1MJdcwoAlkSArqrd2oypscakujzjNbN4AH1G50gnGx8QCABeqQ+2z5irGWEkCr3GXA93oqYFq2gnIzSC8U/beR2HqOBHUalarYL9+miFWD1zTwzNYiccbFj7bvzWg+AYH8XirnnLRz4uzW7+3QmqEHRibvc7QKuMF2lj4nzCbwxiiDzN7B88bnGY3V/4FeITq6K5mzwTyRA/0Z/o/U7cC8dLE11KXy6Fp5bLhi/tEmdOI4E+9PSsneVDWNamV5/XWY1Y/Uy6DsBWHDkKJyTCyDfodn8SiORiTT2QGW/8J1Tl9DIzVtO3etRnxlgan7jGOPSX2ApuE8MElSlOByk+mXQm4H3TEkePxLcjhpMLh0eV50VSxoQNuC7tx5BmNUpvt8ql4F4iCTps0ShSML32rwhfBzXOYHtKUdjR5GGmo9WFPlXu6uFPq+fml80qF8M5On5meenER5iicLa6z/U0zb1olFHR09DM1dJejxBykCGAQ67PkolcALW099b4bpbrP0aV5ae0axuCttF9Bx2cXGEEbHF4sSgCMsTOG1JuLZnn7ViiabSqXxPmWT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f0ac1-d8c2-44b8-3f80-08dcedc9dbac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:04:01.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4+w0xeYJalirn6gY7g2m5Y7/LQXOlguLAmwY54WDIJBRqbcspmT8UHBK76Mo6g4kpLwt0tL2Wu5NBWCHDaAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-ORIG-GUID: nbd9HJpZUrjoh6OSUk2W_TJY3pPHRIJA
X-Proofpoint-GUID: nbd9HJpZUrjoh6OSUk2W_TJY3pPHRIJA

Set FMODE_CAN_ATOMIC_WRITE flag if we can atomic write for that inode.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1ccbc1eb75c9..ca47cae5a40a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1253,6 +1253,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


