Return-Path: <linux-fsdevel+bounces-60285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C9B44275
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F32189B33F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B627713;
	Thu,  4 Sep 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N+pI6JPZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vokjIVr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7218EAB;
	Thu,  4 Sep 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002564; cv=fail; b=koRNt4oJOF2ZjAB0tGTiCGt9qIalQi3XZyfBcuGeXsG+h1P/wk3W6SvzQdK2p5KLRLX01qY+HAkOOO9Akh7kqMRdg4j6Ia9FiAL+2KwFsINoknybt3JI8+cv8mkyKiPpkgFJ0diaUQHeTCPT7tcYKGkP94wbaSv/9WTF5Pl47AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002564; c=relaxed/simple;
	bh=hbFcBhl9WHlYilYwWwl++6l+9CHIxD3Nt1gkpT6vNBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ni9T/PkZaPXUMgMTZcQ0nbX3HvU0UyQKUypLDPB1b1P7JGRUZpMSsqWx0UpQSTGOAF3skYE+zNIIwconP0+T0QRSR6sBSu+NUK4eq+udfiCSoNEVic/1uzLmfA+tlD/3ECOSKK1H+bWyq8t+/6b4XUbrCWZQMf2lQxTxu082Qtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N+pI6JPZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vokjIVr9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GCLFd005203;
	Thu, 4 Sep 2025 16:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gKR1c8TX6I74b4Mm8wRSVvZ+tbDVIQvR1bKEImS7N5Y=; b=
	N+pI6JPZxXi5PRFc8lAZ1vHx1NSI4fZYG5GWHsIL2jrr6dAbRe8oNZbJHACvR2s+
	wZq0SM9mSNePveQ6qGl6wf9kZa2o7YMbNJqgQp9TQ7WPaRYbmsctttrvKyzjXEKn
	HRonj24tdKlD0bgx6B/mI2DwJd7F8bO8tgvWgjHtidMDzk3T7DGD4VEMerx3cq+g
	1K1JocghFeQ0MLHLfyo8yvIrRWk82IGiWZEx8to3sJHu+AQpsy3+AVI9d1TREo/K
	eZDaGTpEtjDMuPnOEwf4zasoWyUtP0nuxMiPoqIFo1f9hXnRvR4sygqe/xIg1BBJ
	xeFKsKFyUaAbNsOZOA6RYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ydacr3yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 16:15:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584FRQnh032540;
	Thu, 4 Sep 2025 16:15:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrj3efb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 16:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhM3FcXs6bvDfaQDfDTZ9JF2eFwOtT1xUHdL2GkMhEFoUgR23I1dI2kPhQFPO4OlEmV29UhSuueHm9ADCYnr/4Wy9RqYsKq3t6+EpCYMPIXmkPyAKr53pSTvDpwbB9B0Tos25QcATd0cpTHV2wGu7HsJCXfZ5AQwAYvYpL2D1NUGQjg7BrRaV82XNEYFGgf6u8UAHJ9eM3/wDNf7FpJ8MffLCbmElbqg8vHhJfccuG/7VgWLtfr7H/HhiaNlF0OVBZILSTTQop9VfI2yVnmFPW5tJjkWxEQaXNI5r5LZNkDJZQzAl4WRo02nD6hfVL6xEjJ3Om4K2LhgoFjGm23zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKR1c8TX6I74b4Mm8wRSVvZ+tbDVIQvR1bKEImS7N5Y=;
 b=K/bROIs7As9eY30pE6uEQZpUf+kQc62cLWe7SVIegnD8ZgylPkwKGiuypq+HIF2flMbrDi4m9Eepb4sL6VUiVnh2QiDvmQ2DQXPhagyq7nDpF7LmUIBBYeHQ5EQs0liGQtM8IfhG6pw055YpOeiSb/gRWQ1zOhtDSSnRztcvj93bVU6oYtOSglHi1XYpy8PM7b5UfhRNjU3Q2i0JqFMqPCp5BtUAdJrxwb2w+wSKgjPJ92C4A7oFkdC7ZpjwHeNo6mrExRY67/b8jE0LeIwJQu5H0LC2A/2/OhqY3DC4Eebdz2QyZDe0rcoFPwPVGXE3tqnm1OSMG1V4alYMs1cKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKR1c8TX6I74b4Mm8wRSVvZ+tbDVIQvR1bKEImS7N5Y=;
 b=vokjIVr9/bQjdvQHEMXkANXLBHr9B2UpRHkLbGdlDjPb2SxkfzuoqnPyLMbyFPVcC8GgLquPGNK+1wOy8TSOqRFCLsyX3OIh2Nd43zxZSjFUDCfLuOzevQJVBjVzZvUnnhKMKL0cZ/TrzTEWc1aZZ9zNHyXJqkSAv6szK4fkBLI=
Received: from DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) by
 CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 16:15:26 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:15:23 +0000
Message-ID: <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
Date: Thu, 4 Sep 2025 11:15:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Mateusz Guzik <mjguzik@gmail.com>, ocfs2-devel@lists.linux.dev
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
        joseph.qi@linux.alibaba.com, jlbec@evilplan.org, mark@fasheh.com,
        brauner@kernel.org, willy@infradead.org, david@fromorbit.com
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com>
Content-Language: en-US
From: Mark Tinguely <mark.tinguely@oracle.com>
In-Reply-To: <20250904154245.644875-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::20) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f877a4-0e9c-4295-3d95-08ddebce401f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUczU05SMXRBUURUUVQ4ZDIweUU3eEgvTGtpcFJzN2xUNjZyRlNTZzk4S1Rp?=
 =?utf-8?B?NW1CK01KMFB1b1NlMzhMWDhEZlBYRDNyQmxudTVWRXByRndrQkRNS1ZnVGND?=
 =?utf-8?B?RmNvZVRUb2dWUnlPUDU4SENhcVFhSzRzZkkxYWl3VGhNbmIxdVVRTE5Ua3Jz?=
 =?utf-8?B?OGtpNnUxUmlZUU5LTzRxNmpFYjRRQ2xabEczMENXQS9sdG1YV2xVVHFDN2pW?=
 =?utf-8?B?UGtlZmdGQWNJUXN5d1BNSHEzZ21hUVVkdlBqTSsrUVQ3Qm5ESGVjQTdqTGQ1?=
 =?utf-8?B?d0lGQXp1c2F3M0dGYytmOVoreEVJOHZDNjJSNSs0emN2Tlh6S3JKbjE1UDN4?=
 =?utf-8?B?eGtZNkU5Rmc5dWZkTno1MVF6SG1JNkVjd2lVUyt4ZzhJcWhVYmJ3K2ljbU9G?=
 =?utf-8?B?RFRRSkFudW43NFZ4S2w0N25GRTJWZ3g3K0xMd1hVQVJPd1VrTXk1Rm1URFEz?=
 =?utf-8?B?OEJ5RER6YnI0c0cyNGplek9ldndHaE1XRUl0ejk5Z00rM0tjdUU4cWlyaWlO?=
 =?utf-8?B?YnBvaUQxNU1rQXJPWkgrNFdxa2c0amlCVG53Y2MydXEyUDFBbis2YU5GNWgy?=
 =?utf-8?B?WHB2aXpPMlZvSnNkeEpES1F3SGlwZzJkNDJubTBUYTVJa1ZNeDVxOXZPS1Rp?=
 =?utf-8?B?N254b0VoU2NCVGFZSDJBQ291TDlsWFhnOXYvOGhQdE85Ulp3b2dQVUFkaUI1?=
 =?utf-8?B?MGxWU2poTGZkenZhaGRpSkxKWjBEVXdMMzJBZm8ydzROL1ZuaU0vN3BLQWJp?=
 =?utf-8?B?YWFkcWpFTmJvWnc4eUNLSzJsYWgwTFNreDZmTEhNMEhCVW13ZG1uQUhYQ0gy?=
 =?utf-8?B?NGc2WjNiUVpjTDlOVXhtRTJkblZqV1pCRVQ3UGF5SjZCUGVUaUFGU1dtbngz?=
 =?utf-8?B?NXUxdU56ZUg5QWRxWDl1SmVzemlVeVdpQ0pIT3JEbi8yZnRPemNGQ1JZdzVR?=
 =?utf-8?B?S3llZlRlQUIvbzdYTExYRHFVMVQvRnJZWHBkMnh4WFAvc3N0VUxNTlFSWjFm?=
 =?utf-8?B?UG1FWjdITExpY0pQZUxiZmt1QklLZ2srQWcrZ0ViUTN0elZiZFpIVjY1Q2RQ?=
 =?utf-8?B?NW5KMVpPbDFDaE8zN3BUdkhaSmduQmZjWlZIMTUzbGpqTVAwU1h5SUh5UzM0?=
 =?utf-8?B?Z0ZoZ2lyeHAwZFlpK3Q2dEpaQUFack5MNkJTdU1MSDJ0Zi90dllrTzNCc2Ir?=
 =?utf-8?B?dWkwcUNNSkF2QmhucDlOY1pENXoxV2l1aG9BUGtLM0R6Ky93MWR5Ym1WL3Fn?=
 =?utf-8?B?REh3R0FJNmc1OVN4c3lyVDFhOWwxYS9iS1RHQVI3Ny8xWmI5SE9zMEhmcUVM?=
 =?utf-8?B?elQyZ0YvSE9aYnlTRnhlWXNWRjdvQS93TnJWb0VEcFRrZkgwR0g0b3ZOK0c3?=
 =?utf-8?B?NDdsaWl5K0xuY3hBTEJ3UGl0M0IzMkJ1YlMyaEdnQXU5Tm54KzZtMHFZYm5E?=
 =?utf-8?B?OHJvazBOQVBlc2RWVnlCY3lzZE1DOS9tR0R2ZjJtNHcxQmJEdDE1M2c0KzdP?=
 =?utf-8?B?WDB2RmplN3lCVmlvRThvNjdmcnBtbUwvdTJUdFQ0VzNkVmo1WWJXYnpOUzFV?=
 =?utf-8?B?VjRjck5DVHlFaEJkTHZxWTZBblZEVldUR0YzUm9LWW1DeUpvU3pmbElyUG8x?=
 =?utf-8?B?VTR6bVFseGZiL3gxSVQ2aEkvdnB2UXpZNW54ZWFibzFQc0ZDbHF1SlZMR2tT?=
 =?utf-8?B?cFhpelpkMk1kTVRNcjlGNzZXZ1JCSjhnTVZaMEVJMmpNMk9ieTVZRXN3aGpo?=
 =?utf-8?B?VVpITEhsV3hFTjRudXN2NGlha3RPYUI1clRPWGNWemdiSGVDTEFLMnNQakNp?=
 =?utf-8?Q?q67sztKTmyy/JSy5r72kKKONXydt1JspHQxfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykd2Q29kTlRBbE5hbno0YlpkYkEva3ZVV0t0ZFUwQm83N3NTNWVuUjRHWnFW?=
 =?utf-8?B?TDlCT0w4SHhZSXIvdW1ieFk1bjZ4MFpaQ0lpSVhqRVRaUUovNnVueUp1Rkgv?=
 =?utf-8?B?MlduVlJnazlFb2Z2ZllRZkU4bXhkU0hRc1h6VXIxem0yTktxbHZjTDZwbkJN?=
 =?utf-8?B?Vm5OTFlDN2Z0Yng5MEZubWdBanNvTG53RDEyZzZVbWJ2aWxuUWRqaTRjSWFZ?=
 =?utf-8?B?SDg1NjVYV3ZORFJYVENyMnlxaW9hK1BZbk53RWEvR2xEeDJiUEFkNExpNkRr?=
 =?utf-8?B?YmFwMWV4QitXbnRGNnFUY3I5ZXlGYzhkRHFpcmJWVWRBRFF1TnNqd2VtSlZw?=
 =?utf-8?B?ZHNpczFEdk9uMlR1OHd4Nlcvb01UOWdSaklZc2tMUm9GbmdOVVBKVnpqcVZC?=
 =?utf-8?B?aUhkZkFvbjlhdWdnV1UyTUJQMzNJTWZzeDJ3V2xxRWRKN2czdXpOTGpiMWJp?=
 =?utf-8?B?eGk1SjVSbjJMa2R3RTc1emZLYXBiNzN1MWRKcDE2anRRbGErZWk3SDJ2Vytz?=
 =?utf-8?B?QXJVK1JiTkx4KzNVZlY1aitjNVp0cDAvTVA1L0hXWE5EeThZTXdpOXJYRHV3?=
 =?utf-8?B?SEQ2MXV1L2dKRXZXWnRxL2dHQm1QRzV5cnB6am8xYU5UamY0Q3EyRnl4bVFN?=
 =?utf-8?B?N3Y1RUtXcWxDYnJNelZmeGRPT3QyamtGZDFTK2VvZzBWODZkZkg3bE9IVEVH?=
 =?utf-8?B?aHJCZWpzK1ErNnorSXVFNlhIZldPL3FEd29uVEhTT09oZ0NabFduMGFxS1Va?=
 =?utf-8?B?OXRtbVpreFZQU3YvcDlwWkxBRkRBN2t6ZGxMMGNGalNyKzZyZXlHbUg1eXpZ?=
 =?utf-8?B?elVzeEZmVmRjL2lYNkJpRVhSYUZBZXJ0NUZjdmRwMEhoVzllcGVld3U5OG1n?=
 =?utf-8?B?RnVCcnFOR0pSNCtOaTBNeHN2azhrUEhyenB3aFU5Q20vOC9QT0F4SmRxd01a?=
 =?utf-8?B?N09xRk1xNjNmYnBjaTYyczNRUmFPTUFBb04rUGsvUkQ4Z05aV1NGNEsyMDdI?=
 =?utf-8?B?dExSSlllNlJsRDFlZlJyRHBROTVvMTY5U0R4RmpvazFXb2o3aWRlWmJNSmtW?=
 =?utf-8?B?a3N2MVNUd1dMM0J4NERUQXlka3orcExkWUxpNXZQQlJ1WkhFUVRuREJyMGZG?=
 =?utf-8?B?dUs5cVpNTi9HRkxzbjdvaUVGQ2pIZHY5RTJESDJLOXhkY2JDeEc5U0JhOTNq?=
 =?utf-8?B?UVhWTkdvQlVHMDRRZTVhZk5vVWFkUWlkSFM1OFRIT0cyL0Rlczk4cnhmOXZl?=
 =?utf-8?B?SVl1TUg0N0M0YzFCanlOWjV6USs1eEJob0FVUVZjMEpyNjZCTTVKeWZkcTVB?=
 =?utf-8?B?U1hYRWFoY3hqM2ZpL3RHd0grRDhmY3N0NHVIZTdwMjZCUi9lNXhVTjdDTGw3?=
 =?utf-8?B?M2hQVlF2aFJEOHZtcmpPMTBJYUcwTHc5bGo0YnBXbTBaVFVBclkycEp1ZnJ2?=
 =?utf-8?B?R3Rwd2hwbWVIcXdTZzNpNyt1VFgxaURhUHQxOEx4VzdVZ1ZxRngrbVlyTmty?=
 =?utf-8?B?dWo5NUc5NXp4WXdxNEpTcHlFSjZDazlGSUJ6eXlGZzVNTURmOW9zRW41SEsz?=
 =?utf-8?B?bmY5QmUzL3NJREpnd3dVUzBjdS85ZVdGaDZBUDkrOFNueDRZK1NxejJBOG1k?=
 =?utf-8?B?UWQrMVpDVVNPdUx6ZFdzKzd0eTA1K3pFenBxUWZHK2lkOHhTQ3hWSEJhNUNT?=
 =?utf-8?B?Y04xcWpkZDNIWFNDTzkvMUVKbjRTYkZ3TElLM3V4dFBYRlZKTlk1c2w1VDJk?=
 =?utf-8?B?TG9yU214UUoxRlVnNW0xMDhoZndoSDRYbjNlNVlKSE44azBvVTVWQ2VXUVhC?=
 =?utf-8?B?bkRZZHpsL25MRzJ3elRZbHB1eGV0R2g5K3RCbmphOEhjazZhNUVqM0tOT1Jz?=
 =?utf-8?B?UUZGdXN5ME1sTk9uc2VnSm01LzFFR0srS0tDR3FBaDcyMnBzMkNSYWJYVEY5?=
 =?utf-8?B?TE1sa2NWbXpzUFQzdWpQN2JJeldDT2pncGNJa1pQeVhta0d2WjhWRGpaT2Np?=
 =?utf-8?B?YUhFc0JJRkRLUWVvcDEya05wT2F4TitEajJhMVdCTlBSUjhVWWRHRTczanox?=
 =?utf-8?B?UjZoMnhwYlYrMUh1aVgyKzF6T0ZhWmtCSGtYUjBaaG5ZOFIxOU53THZGOXha?=
 =?utf-8?B?YjF6UStMMTk0TVB0MStDSk15ZElONjhiQUtObDRaa011SFl3VHpzOHI4dXlJ?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GrdSY5fJY7SBDe8bf3wIYcjV7xd0iwkSEdcnZQnUVrfmQkzQVKyiz0Qr0WB3lI6p+tqaiK0VpRtqJySw92ayobmODBN0379l5gyCQ0fqcVyYzPlZMkwtsaTHKQCpkeOcSXgjXb5hLZlV+cRuhyeZ3D5TdOlbAkLSCgMuL0/S0vRL0jtBH0qwlDWOPjSSBzFrwgXzUV0U8/85IUFIVFFMmtODhqfJkmdxX2n6H0iRhyMsCX7S5sxBF13AJP0YcyE6FVfrKYCkaDLBnHpcMnHpHDTfjz3w+BF4/Ow+gYkqJFgKu5sNLX9fCP5YHXWPwQTdMHx/3SwVlfkrmQwPsWJA5b1RqM+mvV1Aziyc7uAuT4Pb/vJ3IWZn5DjEV6oGoKCNh8CCq3fsvrGPMi8zLxP2efDFxMoRii00fF1iGty83zuao/3CrTAW9g7LlT2i3vbMXg4DMnOquUE+ByHo3g4rA4obe7GcgvbyX9yX8ESajfzgLQy0mZ8jD4VnnayA8PM0uQXvbbPoKltdVGT2M2UkRWx2VV2FGWnmMUiQrxk33kT0kEDm4Z5H1NwJOTJDACODM50VYzNZE3TAffUaHKhpd7R6qIczp9FJvagC3ArsZ8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f877a4-0e9c-4295-3d95-08ddebce401f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:15:22.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlqiwj1hLtySgk8HxiUTV8bBt1QYPezW5gSt8j/LfHPlmg5gzOtoz3KoUdUDo7pEkUBdC1oouQ9PmNKg4pLEf1l51PuXHsedBcbu/Xtet+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040160
X-Proofpoint-GUID: uFSq6QlJdSzAp782VNfpEM2bJ9Bkj8Jp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE1MCBTYWx0ZWRfX3obySJ/6EZYi
 MuRzq0Iely9rzaB/8Yu7tOKvneCLEkD7nXDbwGH5PHVqGknCDI133OI+O+8nw/LK1Cun4gW3rZU
 itKgWrV7umKOsbI3DDhtPENNUUt4MoZI4FGHSqCVYxzb5hW8KN7xThbvy6Gh+0ahXUD4adCvJYb
 yHwoFEc0PW8AHTp9e/TurfdUC9ERmwy/v5sXQfkzkAAOqLPEXXr1vu7yvd/iQHOOCxHOYCF3lPI
 tHb0UT2TRR+p8aTZyowwvcC5m2Z4tHkzo54cqyYAeVReYwBMp0UznzEYjQM8uYhZZkT93DHh+n3
 c7YEQp+ftsK1TLHiMsg8J0/D0jiV8cnjMiFoDRlLJ7iZ18JJPzFZvSnsuKGLpTTyknzfJ7tIZbW
 fUqBVqpyYK10m55QSz2AmFXP4TzbjA==
X-Proofpoint-ORIG-GUID: uFSq6QlJdSzAp782VNfpEM2bJ9Bkj8Jp
X-Authority-Analysis: v=2.4 cv=TuTmhCXh c=1 sm=1 tr=0 ts=68b9bb24 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Xcmt9cC28M023SyYxpMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069

On 9/4/25 10:42 AM, Mateusz Guzik wrote:
> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> fine (tm).
> 
> The intent is to retire the I_WILL_FREE flag.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.
> 
> btw grep shows comments referencing ocfs2_drop_inode() which are already
> stale on the stock kernel, I opted to not touch them.
> 
> This ties into an effort to remove the I_WILL_FREE flag, unblocking
> other work. If accepted would be probably best taken through vfs
> branches with said work, see https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.18.inode.refcount.preliminaries__;!!ACWV5N9M2RV99hQ!OLwk8DVo7uvC-Pd6XVTiUCgP6MUDMKBMEyuV27h_yPGXOjaq078-kMdC9ILFoYQh-4WX93yb0nMfBDFFY_0$
> 
>   fs/ocfs2/inode.c       | 23 ++---------------------
>   fs/ocfs2/inode.h       |  1 -
>   fs/ocfs2/ocfs2_trace.h |  2 --
>   fs/ocfs2/super.c       |  2 +-
>   4 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 6c4f78f473fb..5f4a2cbc505d 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
>   
>   void ocfs2_evict_inode(struct inode *inode)
>   {
> +	write_inode_now(inode, 1);
> +
>   	if (!inode->i_nlink ||
>   	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
>   		ocfs2_delete_inode(inode);
> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
>   	ocfs2_clear_inode(inode);
>   }
>   
> -/* Called under inode_lock, with no more references on the
> - * struct inode, so it's safe here to check the flags field
> - * and to manipulate i_nlink without any other locks. */
> -int ocfs2_drop_inode(struct inode *inode)
> -{
> -	struct ocfs2_inode_info *oi = OCFS2_I(inode);
> -
> -	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> -				inode->i_nlink, oi->ip_flags);
> -
> -	assert_spin_locked(&inode->i_lock);
> -	inode->i_state |= I_WILL_FREE;
> -	spin_unlock(&inode->i_lock);
> -	write_inode_now(inode, 1);
> -	spin_lock(&inode->i_lock);
> -	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state &= ~I_WILL_FREE;
> -
> -	return 1;
> -}
> -
>   /*
>    * This is called from our getattr.
>    */
> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> index accf03d4765e..07bd838e7843 100644
> --- a/fs/ocfs2/inode.h
> +++ b/fs/ocfs2/inode.h
> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
>   }
>   
>   void ocfs2_evict_inode(struct inode *inode);
> -int ocfs2_drop_inode(struct inode *inode);
>   
>   /* Flags for ocfs2_iget() */
>   #define OCFS2_FI_FLAG_SYSFILE		0x1
> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> index 54ed1495de9a..4b32fb5658ad 100644
> --- a/fs/ocfs2/ocfs2_trace.h
> +++ b/fs/ocfs2/ocfs2_trace.h
> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
>   
>   DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
>   
> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> -
>   TRACE_EVENT(ocfs2_inode_revalidate,
>   	TP_PROTO(void *inode, unsigned long long ino,
>   		 unsigned int flags),
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 53daa4482406..e4b0d25f4869 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
>   	.statfs		= ocfs2_statfs,
>   	.alloc_inode	= ocfs2_alloc_inode,
>   	.free_inode	= ocfs2_free_inode,
> -	.drop_inode	= ocfs2_drop_inode,
> +	.drop_inode	= generic_delete_inode,
>   	.evict_inode	= ocfs2_evict_inode,
>   	.sync_fs	= ocfs2_sync_fs,
>   	.put_super	= ocfs2_put_super,


I agree, fileystems should not use I_FREEING/I_WILL_FREE.
Doing the sync write_inode_now() should be fine in ocfs_evict_inode().

Question is ocfs_drop_inode. In commit 513e2dae9422:
  ocfs2: flush inode data to disk and free inode when i_count becomes zero
the return of 1 drops immediate to fix a memory caching issue.
Shouldn't .drop_inode() still return 1?

Mark Tinguely

