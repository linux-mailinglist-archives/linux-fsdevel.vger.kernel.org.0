Return-Path: <linux-fsdevel+bounces-54625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16499B01AC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A87B7B217F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A12BE647;
	Fri, 11 Jul 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFHXvn6v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uWfW8UyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB229E10A;
	Fri, 11 Jul 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234000; cv=fail; b=uproCuSWQYQ32e3SCYFmR1T6GHMfqpyHKNaQVhUowIq7v0mwp6unwbBpzm01BsdDNYrswtMOQpecvOKbyKqZ5YmeCvE6K8c9eSfk4uBNzVVryQvDyoiuNzm+1jbDOliXP5sXj4f1ZAVDRuZoTQlKnUP8o0+h0qpbp6B/6sLBG4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234000; c=relaxed/simple;
	bh=x2WfqaXmOANO5D4YO5/TRIo5NHLzlQt9N2l6zLrb9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwUF2P2wCQ5WX2xrD4NEewIEBtL2txDavKTaf1PXK1hdatafd+3O3Ss/Vq+PMHQtYEV+YYdqXIcLcFyUlVGxMPpD3mbJRQkxVoKp0lWUP9ltGztF1rRowbJ7q9EBRUpV+y2FsJsgQv3UjCNvw9J/YjvkwGnhlczm0ZmXsu5vw5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PFHXvn6v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uWfW8UyQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbbXa014552;
	Fri, 11 Jul 2025 11:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=; b=
	PFHXvn6v7HOzC17uDOUPKvDO1q7L7KZm8ZgRg3wTeu0boYQfugT6QyPlMNRsuFYA
	yxQ0rG2tJ4Tbt4PgKVjVTS8PzMoUF+HLDI7F94ksXx5KelXWga9ZLshOPdyTJ+va
	j5ccIeSM19S+WkIdJNFBzgVucxiCwhJiGRBkjCSM3KkiDmpLrwkLQSnns+yYfH9i
	kSUEwy0ULQblxQC3OXfNLXbKRHpAuJnnioaUNt5FQKisNyuW38ezpaC4wMBkxwWv
	mdoQY4r1Yx3Q4gb5GSLJDEoFiFt42m3mv2byEqAza8wEPKbb6ywRDG4Foow211vB
	99GXOX7ruj+6jm4oGO2Zwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w1g01y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB5CNR021609;
	Fri, 11 Jul 2025 11:38:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgde6hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/bXGSGz3hQDmT6ovdOKHiDQ83Xb4Lbt+EZ6e1e9fuu6vUQuj40S7gnLqV+7phuiEh2h8+F9YkbV2PgantsrfE8B85xE4ufazkTGWFZiBkxHt28BZtx5MXE6Z6N2wSC7bATCKIYQnHGPANW1dTgjPgQN9dEvwn7Olua/VMpFroINftfjvhDEElDBSZkiP9EzmXkApskwXF7gKJSNYsM/Zpugm1OSqHcrIKcKHd7Q+YB4ENC/C6Ow4wN5/27mLRKXYAZ/mWP0EdMElGnoY2p2mLJOXhN4Ast52mpb1lh48ZKv8CRyRav1nzkhs7oRzmXmdL7jhVnDi1sXnwVxVGjV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=;
 b=njHjHLaJe1uqTHC5CVpsaSc9cAp3ABcegdChII09n9rFATnaV7Osn/+j0jMpVORzgDeqg8dMiRmfA2SqF1aEbSabY3NPnt+dLMVw2t66Fob+Y6IloydFPCQmOT5QpfrXE2kaJBrlT05xZv9N7LgyyGO30pUwWp2YvT7hwsfzWOlah1dHaIlriKpjkGa8Y1EilB2ubuKmlGRcMEHS1BCp5Z+P16aOXHFeRSnaTDd6UV5+XaAQDQbHho71nWCZHRUiny20GAS5qcbsItfPJ8dIUGtYyfldCvCWNX0s/Lkud4TiOScXMTnpK7Sk7vlZ8nkmQWTBQgVWGEToRZ8apM02pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=;
 b=uWfW8UyQXTHs/13YJnN7/8RVlCaJ65Ito372EXQEJNTjTV4gp0NhzCQNsSQE1OndV+h6om6w9MWlFXuSnDuyVfskoYLIGGscQ9/FGzNb2Dv5LF3mlK5wRl02HO8R33K/hiFuP/euV8ZSsVAK0po+lnaDBsRVjHeLB802C0Jogks=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 04/10] mm/mremap: cleanup post-processing stage of mremap
Date: Fri, 11 Jul 2025 12:38:18 +0100
Message-ID: <27a8583cdfdaf065dcb2d16202ce540dbbc6da1b.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0689.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b7f5a9-cd11-403f-8749-08ddc06f7adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKy1k9zFGkqHo86uG4WfgKrlFtZhMQz6GhLxqMSVfxDmy+9FZp5Fa286nmrZ?=
 =?us-ascii?Q?WcZx+0dSf5ec9eKRYBu1MblJl0bRJog61/qA3JiaN/5gFCoFn2khLkeo12xc?=
 =?us-ascii?Q?OOk47MoOnPMti25MubPF9gvPVxIaNtiTF+3rQ+48qourdTtKCIe0CqW+MW/R?=
 =?us-ascii?Q?o7VlPL8ip66OWv1xV4+inO72Bf6D2uAXG/xKk0qCuqh9k02LTuyPvT6dzNcN?=
 =?us-ascii?Q?qdNeXdQrdNiZ7DYJ9Pf6VehU6QbAcp4eWrntm3iAyEfMu8Dd5eOT1034/j9v?=
 =?us-ascii?Q?P/Ykyej+W0OLsOI3X3q56lHvOIWcwGg/s9cvWIJeg2B6ecnTSPx17JK/iQpX?=
 =?us-ascii?Q?fWmA7wOCk0XzGYc+plvACBjRvU09RNmPwLrKInvhY5amVr5DQG1Ujrh17pPx?=
 =?us-ascii?Q?+PnuyUE+fKBf5hyOgvO9ESFydIttt3nApOCSWAdVkxdZmL7SYt0rMXJmw537?=
 =?us-ascii?Q?PawfLPOXsRcJ5nTgEKwIiVMmHHIjqgaCrxPK7fOBO1aVMwr/uh6pTIWNRCVg?=
 =?us-ascii?Q?Q8e0MS8Y8HTl0XQ1ETuYiajyawq+3d4wQg5OUTyPzL0mspKYC532v8kdBTlP?=
 =?us-ascii?Q?dL1XLB/FJieyr+fbrnH6Wx+Z2kOdw/p1sjh45fmPFBoTECO/kwW7S01oXjLF?=
 =?us-ascii?Q?Yg6J0ro0+TEQESfjPVAq1Fo08J5KX3mHuz7IihW29fgazGrL1YmvGYtoLm7w?=
 =?us-ascii?Q?iLcgSnaINn0vRjsK66j2U8O2UmitIyl/h2/iP7mhUEFDdnGFHYNZuvGI9gIz?=
 =?us-ascii?Q?si1eorsluZ/5riypE3svsTM2WagZgSIvXEzlYGFVpSMkdja9Uq1CtvvTobp8?=
 =?us-ascii?Q?HJdyzPMXO7rMz1UtC/b3eXtF+1I0S7PuVVPPRw1V/PQCCasPV1m6eJqVq+80?=
 =?us-ascii?Q?ObTsco32+EgEXdiRNiVOMgGW7/XicOP4X39Tx7xXKGCZl71mstDL/p5EE2nY?=
 =?us-ascii?Q?TgFuP4G5d9m8tFquw2ierW0KQOJ4a9+u6kLuJB6HyBXJLut8O+NLios3UlWr?=
 =?us-ascii?Q?Vbafz9iciybrQngHt0IWd+DyabpevSaM14TagD6ARvE+vnWgaBAXWF25ftKy?=
 =?us-ascii?Q?UycwJ18PlI1jxEPyy4DdJC1gfqB2/sVexf0f0SY0Pg85CDWq4HsuT+bZQRzM?=
 =?us-ascii?Q?71d1eSyeuwVKoJQ1Ob9bvewFbIgvmaKHZaEaNiOvfGaSXck+Kl01KxkGVVba?=
 =?us-ascii?Q?dnIV5sx+tbFMqgeWBvqMvhIhmweCtAoMmdBiUskQ9sJTEUqSKA/xBPBbUPB/?=
 =?us-ascii?Q?Qm50rGGIgp3w/OulMeoFLufnJXKZNI0fDCup6bcJ9IQLp4K2uJuiPtEHEdlW?=
 =?us-ascii?Q?Hm+vsOcnVJ4Ud5KaXdtGH4rxVMpSpjICmMNJ3jpLzo5PeRD7OUoYl9RUqC4G?=
 =?us-ascii?Q?UUfjMKNMT5nWz2Q81gZ3CvzFM+gKQmzx18CymVHZ813XU7OEowH8Mt0yfvP0?=
 =?us-ascii?Q?qxCrbzKtimQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7mMS37WKZeaKG3iImlA4fRFWyCzSB1NVpvJUb8lAbtJ3YYQJ3OiDEfnsOVF?=
 =?us-ascii?Q?c+CtiLIaXrS0Yzz1X4eqtReHYoB6VSnYW3KPLMcKRHefRY7RpIQJ/qKNwrID?=
 =?us-ascii?Q?PCaLaLZvW7Cai3hI3jwlsHT8NyjVFQSytkl+udsEdy18MTnif8RKqLElGpGX?=
 =?us-ascii?Q?Qwzg1TEUZH8RfaVSS1a9GbeU3QjdYEryhYKYZ+5eINS6D1UjNFNZF1cJRSOO?=
 =?us-ascii?Q?xywMQkZgCAhy4twh2Gn/1Rbnx8LUYqcPCVu/Z4Ux8YL34xxssNXoUhmG64Bw?=
 =?us-ascii?Q?WfDZlzRWOhA5zHgGCGAr1iqgtKvwchkh5/UVlmH4VLO0L7zrDreNsfBWCR/f?=
 =?us-ascii?Q?adxbPFx8OLkv2l8+zjjLeAq7P8JmKR8e2pcbJUqHjFADENN6yp0PZ2Omurpf?=
 =?us-ascii?Q?wKiOSi7gY7EzohXgWcesyPnWhyjRmiIUXc6qOxjbgkooqwKTnob4EBF5Xf08?=
 =?us-ascii?Q?oSdVVUazr1M6/sBUztR/k4k5HU+YcWvlKHO5qU/HfyAv7ZNHosjW8Fs3vvDI?=
 =?us-ascii?Q?9nGsrBVSz8HYAGhKwQ9eJu24nEHLlULtVonhFvuyr9OMmCWoXUYFturpQaXD?=
 =?us-ascii?Q?Luw10eT1n/LkG7LFUoRuW2rl/No8sRd3g+LKw2dTGuuym+pBF7QBFA+r0t+7?=
 =?us-ascii?Q?SAeRQwVCMf6xwwdWFVXeeM7zyySSEUNE4Y6dKiqdZ+U3WkAvJRv+wF4l7aY0?=
 =?us-ascii?Q?F5qIJ8q+OGSH+bX+E8/oaL84t1gEjAyR863qhEykdujNY4COOXiEmCtLwsH3?=
 =?us-ascii?Q?owZGA+rYRo/I0+du9OC6IHKo36DX3xlDII1UdNFRDZ0hmeuauucw+gvBK1ZV?=
 =?us-ascii?Q?KL4MQAClpSKPOU6FQ2bO9cmvwUeYQBZySnet201gJO27TCkBP+op2TI1FB0d?=
 =?us-ascii?Q?Pexg/lqlbefqJSHvhVP51zeVlMbQQ/oHMgOl3kPQ2gsL1+IbURmnvTUS5KhF?=
 =?us-ascii?Q?+7xZSGE04yLXYQAc09oUqo5f37a9d4FEpmSPaNPq2Ftef2+zqhCBIZcyFMyR?=
 =?us-ascii?Q?3uzT09m2B49wtMil4+WWG4uxPSDFesNqw2A0wI7o7REK7a6TjNE3GnXFl9zV?=
 =?us-ascii?Q?D+MGaYPVlQv/5fZsP0OlPxRMnTSPkjXPuBHDen/U85qlp5wouEGNVZudcoxM?=
 =?us-ascii?Q?gOREgkOpoTbaDtzOWTvgjTXnAdw4kxmK9gFRNqCReaaeEHefqa71IsRIk3uj?=
 =?us-ascii?Q?0FazsAQtaOyLx/CCFbaCGyv00MB01rXDX/YRIJETleg7Gw11l/aocGz7Uoya?=
 =?us-ascii?Q?254P9DqRZm/VqDzyawMgPCuMQLCYiowjunAlA/lz12CqMuFXKSd/nATHRdR9?=
 =?us-ascii?Q?iOamCrDuJdd3axOE9JvPixDBUE3J3b5tSU/viiqA2E5wkW/h8PWOblDr9mhV?=
 =?us-ascii?Q?oPFZnwWjWVRoYOxmvSjCkfcblfQxS9y4AzPtJBANNNWV1eGYFnO8sLypJDxB?=
 =?us-ascii?Q?UBZR7yDSQjBnRDAqgD/2KvuOPW9YC8GRfCwdLYDAerQF/8BOwNX0rzKMlSG1?=
 =?us-ascii?Q?K8Kxuo5dAVB3H1D1g7SepsxgP44bcDl2yaaBAUFEmJDCFgN85GEHXGwKko0W?=
 =?us-ascii?Q?nUaAh/up9LRlVVYTIKBKxlAxuxtBiG3heMhsBGIkWTdaVk4sX0Q3cv6tCesY?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHHpUnMc24oG9WcLj5jR7pi2/CVZLxx4ZezNPgcEwk1UhMuGqpxPaQ/n/jYdWgimwbcuWvax4bZkrZMBk/1ECQDxedg00Op2z857xOA68E52nk9aBpJ9kD4DFMMCPOGQVUb7Y6rNEVeLQZSP4GIFHq/bSZ/G0L3eUYmsAxLfb57TzXDKEDOSDXurKRNOFdWFznBxnposKVxyLEwcn1FeZ/MMvxmKkixWw6jY1d0OGFQTnmBXMA2Tc/N2k4Yn8b+qWAlT+C/yxJK6NhjitCu8fLYHgj7Rvxtv5F+7vTgp9Xt4gzxwzQS8SoZHQb8PtscxW2JL5fq71im8v1baWkvSk0N+yNj044VYuSWvmFoBbJAHgMsyWwl/1lLkQICbrA6sBAZrF+WGHCj0yADDvbGpGAyv8FFoEFnBWg4Yo7t+xXcM9XMAygZBTxjKNAMK0fxGfNOy+tl8RHvrZi8DqeJH1//RxzgBWg7y64kt0idVsdvMsIkmSHO+Dk1TFwCpC4RvnloaI3HdIQHiAlO2fEr2Ad0l+0edBDEm5IS/yjnpFQkDqf+6hKUETEUpHtN9W3rEOCBq9GrE5wgxBMihuQRn7h26XqaPTJlX1iIA9kRvnfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b7f5a9-cd11-403f-8749-08ddc06f7adf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:39.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+YJUIIUXia5Kfy80OFgmdSE/lIlKFZFEHo/aIb7pbJGfgkMxfL4W4asjviDuW/JZWeYpGlcwQpRDJuczlWuNb+HYbXyG2ek+QGlu9cDtbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfXywE91h/qBP/X aufcGbVL2EdIF6khuHYTk/McgDDEwA6NbrD+i82U0YM7N1v2+KBzxk7kLUdKRg8IYydzk6e52DC 11WmVLgF7qMyC/xbrCfiE6SUOL+fT0GPTrjw4aiiHB55Yb0VCMw0sHnFD3W8Q1uUcKnSwSefZ5+
 QbB9CA7YU+CwbNmCb90zm/YoRmRGpNB33GEzM9FeWJHhAnC+b7vnAaDNc/RlG4GvioO+ZUt8ku3 Vgs6/5PtGGtG/xwYjBElhnbfWH5TTJbiCA2ft2gh+1xAYA1JZXQ72MWb60LePErAkk3kCJL2+71 aQGdU2tjMN+szjA8RdAC6E5myGwqYdV7bWBgC0Fs+U9RCShtjOAbmmw2uMJgSB30VK1RvnHZwpk
 dGhtm0aSXEdHWcFyONh8EUkyYAh09ubqedbmeDipSywu/Qx3i/5cYOK+Kd/hGtTOjTO1ANgX
X-Proofpoint-GUID: bjZiND8EdaUm3ni92seQTdgWb5R36B8h
X-Authority-Analysis: v=2.4 cv=FsIF/3rq c=1 sm=1 tr=0 ts=6870f7c2 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ULdmrcW3YHslXA7JyQcA:9
X-Proofpoint-ORIG-GUID: bjZiND8EdaUm3ni92seQTdgWb5R36B8h

Separate out the uffd bits so it clear's what's happening.

Don't bother setting vrm->mmap_locked after unlocking, because after this
we are done anyway.

The only time we drop the mmap lock is on VMA shrink, at which point
vrm->new_len will be < vrm->old_len and the operation will not be performed
anyway, so move this code out of the if (vrm->mmap_locked) block.

All addresses returned by mremap() are page-aligned, so the
offset_in_page() check on ret seems only to be incorrectly trying to detect
whether an error occurred - explicitly check for this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index d57645573e0d..87cab223f2bb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1731,6 +1731,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+{
+	struct mm_struct *mm = current->mm;
+
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1756,18 +1765,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
-	if (vrm->mmap_locked) {
+	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
-		vrm->mmap_locked = false;
-
-		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
-			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
-	}
 
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
+	notify_uffd(vrm, res);
 	return res;
 }
 
-- 
2.50.0


