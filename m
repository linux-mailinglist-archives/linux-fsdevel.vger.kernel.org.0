Return-Path: <linux-fsdevel+bounces-7371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028048243A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CD3281EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738D224E4;
	Thu,  4 Jan 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJNtNnkg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z2VK7W9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EE224EA;
	Thu,  4 Jan 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404CQjVx004962;
	Thu, 4 Jan 2024 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=6qjZnGG3xP9wzx4JgntQBtNhK0kfVMacutcSjrkR5f0=;
 b=QJNtNnkgNatYSd1kr8zDdV+cBR/i4RQxaqNoSpnEfQRgcDvu0k+llEJHAj8T+tHrVq3L
 Gumq0EwHRRI3vAGXMDtNT2cGG46fDte08Tscz8wADp1DnnhL1Nx9x2l43AoGwE8JNAMy
 Ln3nMfqB/wJbdkT3Lxam+sIRIgbzbABtiVWW+RM1b8jdzobtZe/83SpOXuYeg+BqGa8j
 0z7VikQ9WcK/rgVkjHZxm+ppkgjDIKPefZFzzD+TGk7GvBSEepPF+gl7cFzXt/gREPFn
 5QGlGIKvPUlqQQ4N1hjnuuC7dMMcL6heSqCmsqZyxOyQxZg7+hw7ibYm5tklw51ksOY8 6w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9me74sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404EFMC1025852;
	Thu, 4 Jan 2024 14:21:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx900d2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVyRNIXueVz1kuTP+UKeRfMYunrZ/iZ5qthFJ2qZqdF0m4DvO0l47OIdntgQIQU+uBsZhQHJSU8ZbACv1HTLY1+n0p4yQM//lqjkP4P3MAU/BeR2JObRLAU/6NKtNP0LWXT66pbtSqd+0svHuh9bO79DrmvWD/b0BYF94P/Dkx0LLbJgIRY5iK6PhyboYamHL8K3BdIW+5eturCT370+E6gMZSLOZ+K1Djr3GfBYo1tV3PHMbtGZWwSPKhqC98bwE6dW61lxZ5JumFH42BRZyuAnVtqBBKrqW8qqxYDS2/zVtZIlzOUYhdX1wNDW5zNI2xm7krWjrogNjj1iA/Ejzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qjZnGG3xP9wzx4JgntQBtNhK0kfVMacutcSjrkR5f0=;
 b=YVyJME7t8zAyTh53IpHPHzZZAj4Tj2yVtI3E5uvqA5HAB2QpgnGiD4Qa8l/9SBSmgHec4HJo8Ex+HdfBJfuuUIgfoVZDb0OScLCNNup0oumBTbtV9gfvIpCxUcIgByjZmSCpZxVNf9y5HkGlST0RX5Ztif5pbMS+hTkxvdna4IyPLOIA5rPLUBBMarTCjEO9/lH7cbWJrA50Svpgg9jvWuJ2UFg+4HPaqXnwQg9rzSAOO5GD2+g4Ckq+1eSIcdM/M+UolnFVTPk9bl8XRY3mehD5L/rqu51K6/fWLzajZTYrpx9V8xAPWPJCD9O6kagHL0gwHks+1+PGRCdFouz14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qjZnGG3xP9wzx4JgntQBtNhK0kfVMacutcSjrkR5f0=;
 b=z2VK7W9+nzOaWXWVR4nZU1UXm+goNyFUHfA99cWqvyyB2FyKk0EYGvTNRKLGPj5sC9abzEvSpnqBVQaFAewOOPJi00xhMjDhErsuT12Pg3+HFU+0iE20ZLoyPiPAqmlYpcH7Zuv59/0HlNqyUuDp3cDzPvzWfk7q+p+Ol/4VAjs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 14:21:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:21:16 +0000
Date: Thu, 4 Jan 2024 09:21:13 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH v2 2/2] fs: Create a generic is_dot_dotdot() utility
Message-ID: <ZZa+2YyxlDCixQYS@tissot.1015granger.net>
References: <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
 <170429518465.50646.9482690519449281531.stgit@bazille.1015granger.net>
 <276a17ed09cf6d53d17292b5182a8e08695251a4.camel@kernel.org>
 <CAOQ4uxhKVaL3gvwrURSWFSBf2HH6vg0qwM1LVPkmQLfnvTPrdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhKVaL3gvwrURSWFSBf2HH6vg0qwM1LVPkmQLfnvTPrdw@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 782b83d8-012f-45be-3dfc-08dc0d306971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bmLh0KtkpWtvZDofR/bSbQSVgDk6FkCCpSD/v9lVBR0oyK/OzteOGtJ5coG1T4sxrtaC641d/cvd7vfUY0yr0GE8PAroIpPOubtib6Di9BHJh0GxRYc/2L2SG3RXnLCyNDQ04RHs0ld7q/Aap8duLOtU7m5obiF5FnPIXAXz/LsER4m3nvTjKackIlUGWoiI62gDhNGdOzgZyV1My5sxH8qMTHpzXfpeUWgQrCKW0DUJBWj8ll+LznrWmbZk/6iqk5EbOvzHYVWwXTwlNLXKY+sW69QUCx1ylEenDU7akmtofEaY/eph9gzdi6DERKbAMXrYUFK8ebB1QIwhxgAjq1l4IF9KFQT7w1kOnM3bCF5WuJzPn55qII8JEFm8aCxgIXtfzm7ncJhNzXuMsqw0vSRjFpFRb92z11upaSDhIj0y+KBmLEqmzvnswCZ7eJr3XLxIOOLC1EXk+r9eiS9CIr58vkLM9qNuRZQ2vO5+/5UtGjL1bdSwB8jVuy/L+L4uSJ+lBWU9wE5/soZZ5/BztjCLiMO9T1I+RIDDHGKKrW3+xoSK1el4YXjHDL/7hutaGlhy0XPQXg7qM2fAWyNU0401nXlYwipzptTJmfQi0p18YB1ikyKdKeHztaOY2BlmBrQRF4WWXxrZtj5MQrpxFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(86362001)(26005)(6506007)(6512007)(53546011)(9686003)(6666004)(54906003)(4326008)(316002)(8676002)(6486002)(8936002)(478600001)(83380400001)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(2906002)(41533002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFZCN0FUTnFxQktDSFQxRXRRZy9nYTBxSkJSZXI5QXRTejVmQkNBZUROTTJT?=
 =?utf-8?B?M0MzYjFERGlodzI3S05zZEtsTHJpbERQbFNwSmhnK0VRL3htS2ZjK1JOSzU1?=
 =?utf-8?B?c3JqTHdjWkVOeHU4T3BtY0Uva21NRmcyUFFUVGxnNmNsN3Z6RzNPRnkva1ZL?=
 =?utf-8?B?MW1OVUxnNXlzc2FHOVlBbE51dE5UazVvZWhHYWFIYTEvUzFRVzdjMnBTdmlD?=
 =?utf-8?B?dHB4V0xWRjZua2UwYkVrbmVSbGl4YVViamdtL3Y1Y1dVZUNCZUNoNllUWkF4?=
 =?utf-8?B?MnBYNjZFNzNtOTI3K3RKYXJuUU5nZHJKaWIzWXcvRW5IY3JaNjhKNTVMK3Nw?=
 =?utf-8?B?V0gwSEN6R0kwYWc1Wjl1ZitxM1FIeGp0blNJOW5YWi9pd0IwMkdVL3ZGOTRF?=
 =?utf-8?B?VFRvYUoxVUhnd01vWFUvN2U4UmpPQm1EV2YxNEhTZ2RrZmxuMEhGS0szOTRa?=
 =?utf-8?B?dmNVczRUc1d4LzR3SHQwUlp6OWg5RDZ6TjFwem5NWXcyV3l1eHdzUnh0V2tx?=
 =?utf-8?B?ZlM2QzdXVDYxblpBL2pFd2ZCRU14TGVlU1BQOGpodi9ZZ2JpMjA2NUJMamNk?=
 =?utf-8?B?SHJ6UlFGZ1BkRktiT2xwcXhDbWZNQ1IxRzgwQU0yc2dYYVJXSHBueEJCODdG?=
 =?utf-8?B?U1dmYytRSGN3aEpMay9lM0d5bEJjSGxBWW84dVJxZXVhVHV2eTgxYVpNdGEw?=
 =?utf-8?B?dHV6VnhhWVRpQmFLeTJ0L29WbHN2UjFvUTZZOElxdGZ2TFYvYW9zK0l3cU9w?=
 =?utf-8?B?QVd5c21Gbm43SXl3TEJZcWdCZzltV1JGUkRQYjAyU0FkUCttTHJiVzVrRW1x?=
 =?utf-8?B?UktEay9uTHhRQWZ1Sit1OHBqSnJnM3k4WUdXNm5pb2ZoVWE3VEpwYTB2UTM2?=
 =?utf-8?B?U09mVlNSUlBxZ3FzRDl5Tkl3SUxZcGN6L2JzT2IxbjBmdmR3bE0zbG5MRGcv?=
 =?utf-8?B?YTRxMnJxcVpubThjR0FoaFZBaGlIbTdRUDdXaWtPL2Jvd0UrYWdncENXQ3dY?=
 =?utf-8?B?NE4wZE5hQjZ1eU54SjhLVzVJa1VzcTZoZTAzcUlhUXZWTUZTd3YwV3hISUpk?=
 =?utf-8?B?TndXNDFjZ0twc2RZeERVUmdCQ3hrN1ZwTVU2Q0JnNUh4bVdBdjhCYm84a1li?=
 =?utf-8?B?Ukg0QWl3aC90MHM1VEtZU2VoUTF0VzkwZUF6dlpoL2lZNTlVV01acmZnT3lY?=
 =?utf-8?B?Y1FNaUJxU1ZMaVNReTV4MjdsdnZhYXFMR0s5VE5RWFhYdGNSbWYwTFNBVlQy?=
 =?utf-8?B?RHJ2aHZnd2Q4bFI1ODdKU2E2Q0VBcWw1cmozcWs4NVFOYVEzc290cXJTMFd3?=
 =?utf-8?B?NGpOMlhjYmUveU5zeERyVHViRmc5cVhrUVA0L2txZXE5OHVGa2lPNHR2eFJy?=
 =?utf-8?B?djFRVmRod2pTNmZFSXQ3RG93VnMyNXdMb3dVQnBqRytxeW5tcHVJcXJNcE1v?=
 =?utf-8?B?ZkVxelJjcXF3djRieHdjZ01uSmMzaUhmeTVqaW9GZ3RHeWNPdFB2ZDNRNnlG?=
 =?utf-8?B?R2VjaUVnS1ovR2QzY0ZielZmWEIwQVF3K24zQloyWFMvNmtPUm9DNzJ6K2xD?=
 =?utf-8?B?UEY5SjQxSXRjbEtnKzM5K3ZWSStpUGdOY3o2KzlGZElsV2NpNVJPeHdFMTFl?=
 =?utf-8?B?MDE2Y2hXS1BRVVlpTjk0MVV2OGI1YTB3K2FDWGVBdCt5aEUzR3JJeDdjTkxa?=
 =?utf-8?B?L1ZudmZNVUxZMkdKRHA1MFFYanoyTnQ1M2xVeDJnWlRieFBqSnJLYWFzc1Jk?=
 =?utf-8?B?aU9QNWNRbG5SRkdrRmhXc2pmeFRBMVJuSjFLNUx4VXZBVnY1RXFQME5LdVhz?=
 =?utf-8?B?RFF0RFZ4WmR3UDJ0dEk0Mi8rWXZuWVM4SFQvRDdpRmd5ZDVZOWt4Wm9MQkhx?=
 =?utf-8?B?Rk5hOXc0eUVnKy84OTJPWTI0NHNTc1RYUDBQbFNJajNlNndoUEwxK2M0d1Fw?=
 =?utf-8?B?M0tKSXFiTWgrKzBZMWhQNkJuc0Q4ak1tQTY0WjVCSG1KVTVWMEU0Z1RxMkpi?=
 =?utf-8?B?Y1NWb2E3Z1pxdzBaQjlWK3J5US9NY0NUdUhtamtEYS96WE0yenZpUS9laXpD?=
 =?utf-8?B?R1k1bUR6T2k0SVNxWFJZcFd3Z3FQaWExM09xVDBaVEszb2F3aElKTk44UDY1?=
 =?utf-8?B?SFkwenlBL1NHVWdJY1RBcktHNkE1LzJBNXU4NTV2aTgzWG4rc2FtbktxaDhL?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h+IO7A07lC1LD0iUChhgtcEfqsVM3hDRDIezOdV68PJkXK6oGL2GxrqAw8xhgLfrzmX7vfxtdr8zqvnM+JhGRxS4a+v/75GS7ahh0Vk+5ChJuy/+pE8WsE0xXYYRSkpzUTnzUg53g6NCx3EekqUtneqJh9bX0JYB01bvMoPI6+MiST2Im8/Z3diqIDRhgUu1QWheZM1su1wXQ6Oo/mCZTsWmUgVRQyv8YMHvLwy7jULNi8zqv+xS+PTEWO2h1v+Pd8xqRLT0yI2TcWbAU0kHxr7u4f+ZbY2Z6Hu0R2106DpoS9pSge9TmSjT/NwUWJmt9PyI7Strd4dTxg3FTGJeG00lFObKDkzzCgith1A94XvWNN9e4wnwi1F8viySAgeCmJvc6fZigzZcCefTs2Gy+tKXdM9quYTp74aScVdysAlIf+RljVju3qDVCnRtIj9a9/Mu3gyWbfyH5e8uoFjI6wUAnrWpIunGxvFuAFASkGEg/yDwVwAE6+ZQPsFPJFjgqAWMD4fRX9WYhuOepA2BEvsswz+A//FG8ItrcimvOm2CYcbdzcS24BflFXxj+Wf9JrNr7MSzfXCFOg6R5tPiFPWn5CNsOAuE6d88Oi5CnmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782b83d8-012f-45be-3dfc-08dc0d306971
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:21:15.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEao7MCrbvIi8q//j+FCZjyLZ35Ybo5lOK7PnPVQV0aGYp0IZoIxUnLnNoHNjqfkESAJX9l7MHi3Ui9HHJTmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040112
X-Proofpoint-ORIG-GUID: tK8ZnlYpQBOu31LdaXpVY00Wo-DLUJd4
X-Proofpoint-GUID: tK8ZnlYpQBOu31LdaXpVY00Wo-DLUJd4

On Thu, Jan 04, 2024 at 09:46:07AM +0200, Amir Goldstein wrote:
> On Wed, Jan 3, 2024 at 9:08 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Wed, 2024-01-03 at 10:19 -0500, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > De-duplicate the same functionality in several places by hoisting
> > > the is_dot_dotdot() function into linux/fs.h.
> > >
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/crypto/fname.c    |    8 +-------
> > >  fs/ecryptfs/crypto.c |   10 ----------
> > >  fs/exportfs/expfs.c  |    4 +---
> > >  fs/f2fs/f2fs.h       |   11 -----------
> > >  include/linux/fs.h   |    9 +++++++++
> > >  5 files changed, 11 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > > index 7b3fc189593a..0ad52fbe51c9 100644
> > > --- a/fs/crypto/fname.c
> > > +++ b/fs/crypto/fname.c
> > > @@ -74,13 +74,7 @@ struct fscrypt_nokey_name {
> > >
> > >  static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
> > >  {
> > > -     if (str->len == 1 && str->name[0] == '.')
> > > -             return true;
> > > -
> > > -     if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
> > > -             return true;
> > > -
> > > -     return false;
> > > +     return is_dot_dotdot(str->name, str->len);
> > >  }
> > >
> > >  /**
> > > diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> > > index 03bd55069d86..2fe0f3af1a08 100644
> > > --- a/fs/ecryptfs/crypto.c
> > > +++ b/fs/ecryptfs/crypto.c
> > > @@ -1949,16 +1949,6 @@ int ecryptfs_encrypt_and_encode_filename(
> > >       return rc;
> > >  }
> > >
> > > -static bool is_dot_dotdot(const char *name, size_t name_size)
> > > -{
> > > -     if (name_size == 1 && name[0] == '.')
> > > -             return true;
> > > -     else if (name_size == 2 && name[0] == '.' && name[1] == '.')
> > > -             return true;
> > > -
> > > -     return false;
> > > -}
> > > -
> > >  /**
> > >   * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
> > >   * @plaintext_name: The plaintext name
> > > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > > index 84af58eaf2ca..07ea3d62b298 100644
> > > --- a/fs/exportfs/expfs.c
> > > +++ b/fs/exportfs/expfs.c
> > > @@ -255,9 +255,7 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
> > >               container_of(ctx, struct getdents_callback, ctx);
> > >
> > >       buf->sequence++;
> > > -     /* Ignore the '.' and '..' entries */
> > > -     if ((len > 2 || name[0] != '.' || (len == 2 && name[1] != '.')) &&
> > > -         buf->ino == ino && len <= NAME_MAX) {
> > > +     if (buf->ino == ino && len <= NAME_MAX && !is_dot_dotdot(name, len)) {
> > >               memcpy(buf->name, name, len);
> > >               buf->name[len] = '\0';
> > >               buf->found = 1;
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 9043cedfa12b..322a3b8a3533 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3368,17 +3368,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
> > >       return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
> > >  }
> > >
> > > -static inline bool is_dot_dotdot(const u8 *name, size_t len)
> > > -{
> > > -     if (len == 1 && name[0] == '.')
> > > -             return true;
> > > -
> > > -     if (len == 2 && name[0] == '.' && name[1] == '.')
> > > -             return true;
> > > -
> > > -     return false;
> > > -}
> > > -
> > >  static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
> > >                                       size_t size, gfp_t flags)
> > >  {
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 98b7a7a8c42e..179eea797c22 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2846,6 +2846,15 @@ extern bool path_is_under(const struct path *, const struct path *);
> > >
> > >  extern char *file_path(struct file *, char *, int);
> > >
> > > +static inline bool is_dot_dotdot(const char *name, size_t len)
> > > +{
> > > +     if (len == 1 && name[0] == '.')
> > > +             return true;
> > > +     if (len == 2 && name[0] == '.' && name[1] == '.')
> > > +             return true;
> > > +     return false;
> > > +}
> > > +
> > >  #include <linux/err.h>
> > >
> > >  /* needed for stackable file system support */
> > >
> > >
> >
> > Looks good to me. I took a quick look to see if there were other open-
> > coded versions, but I didn't see any.
> >
> 
> The outstanding open-coded version that wasn't deduped is in
> lookup_one_common(), which is the version that Trond used and
> mentioned in his patch.
> 
> It is also a slightly more "efficient" version, but I have no idea if
> that really matters.

It probably matters in lookup_one_common(), but not in any of the
other callers.


> In any case, having lookup_one_common() and get_name() use
> the same helper is clearly prefered, because the check in lookup_one()
> is the declared reason for the get_name() patch.

I will send a v3.

-- 
Chuck Lever

