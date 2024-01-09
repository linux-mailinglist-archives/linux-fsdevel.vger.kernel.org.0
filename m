Return-Path: <linux-fsdevel+bounces-7594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398808283F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F731C211BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD65364A8;
	Tue,  9 Jan 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHeMpMND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B/UDYgyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3136084;
	Tue,  9 Jan 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409ALoOi020865;
	Tue, 9 Jan 2024 10:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=C25dKiWng1VxnAsZG7O4Nj1qZbPZnwhVM/h3iLp9wt8=;
 b=SHeMpMNDXeW91wa1s/QG1tEDzM6NjjORDM3VTxRnHJlZFtxWaij4S1URc6dJr83pD19B
 hxzcCJ6VDhz8gkClMkS2zGKGns0HfHcadFaSq4KzjfsNgX48qVDxAxCARc3PFbFomWjT
 tkkTgemyRk61nD4EdFeciRwj6ThWt4YM5v92/u9t72aiBlrRUaW2p+l6UgyOQPQBH8dA
 uIP3F5Afx+SBgfsb0q/LOYwA/AQkdLmeciITcysEgfCBA/BNHOUXpORup9alr1qL4Mse
 MG6gFMYPN0X1Gs006JhVTmcpnAZt64lsjtgphB8+QEyE4e3I1hxdo4ar0ZgPl7fmYAGD VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh4ah00bt-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 10:25:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40991r5B008776;
	Tue, 9 Jan 2024 09:55:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuuhr2tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 09:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh7zODntyiYkL+B1CQFc5tqJDvKceH6FrI2IAqQxnfesyg+RygQHQehReYWoK9xGNya1FbEF42H9aD81ffpdOSIEaqm6e/erl+1wThT2xDL+nCMSBLLNJgCtMHpsslNTUKEJDER5sLoD+QgSgEmxqrvMMfzbo+Ebs06DuZGtUHGX5cFcbyj+NV33RyLHH3hhFIxXpiQEdGLo/lIY0SHsvJrfhnMNhB6aaYApYzboh29sq22dmOpuNvNofJzUoWpaq3YUyqX9TaVlqfMxb/ZSSaRw38MPDjQqJN7eJenIaFZGOGO0BbfweDJuoowfWf8Ut8ABT4exjgLDzHmM9KB+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C25dKiWng1VxnAsZG7O4Nj1qZbPZnwhVM/h3iLp9wt8=;
 b=Hry/cmJdp67vlputs04eC0MybjlxcXIwupqZOeOj/6Oa0PJU21MqstIE2ywtyU/TDJejOfh8bCAx7eXxrof8gL/pJvClTeaTEt/+cqoQhECjc37CgMr1OHHha91Vs0QYojJm4JHW7OZDC//8s1oXR7zXjjcHkhKSeiJy28eqFRpck04JOC3DHBGPGNxa+m6DaibmSHE+bJrFAz5be3w1q51aOm6cQsx5bUfiYWvMK27OmsHi408sK9IQzwoorKkhMiDRi5ooR8SxScSK/bRko7bY7MyS8UggnZtrKgix0XcRNWnUZIx8use8FcAcNGMC+yZqu20Xg1mrrVQhjbhI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C25dKiWng1VxnAsZG7O4Nj1qZbPZnwhVM/h3iLp9wt8=;
 b=B/UDYgyRUdwHhx0SSKvdU/j5Qdxt0DTSlU9zPOBKsZgvZUrXEOAhlJlF90iWiapofhe0KpZptyruV86Xm2Fk8230nq8XFMQRXey5vwOU5CQm1WcCEY5E3fYvr7MRgvod/ZVoo/ii9v2us1LLoe3PRtS7GvQKR1NFmGMpbMt4Kog=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:55:30 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:55:29 +0000
Message-ID: <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
Date: Tue, 9 Jan 2024 09:55:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221065031.GA25778@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::18) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 666b903f-0607-4f32-7bff-08dc10f91cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LELSX4IbclZ6sJr2Trnu4oiqJ2o601J+d/W4b+D1XNPg07wgdamyVUYFOEfBSs4OwzaohBCM12QLjyF6JfGd57RU+MkO1Wd9bQt9JPBNhxp0VkZDhTCqJCBzzH7YoWqxQ13xz4tXqPuU39nDoq3bk/NOB8A8nTwlod5iW3HVlJSRgi6SHpeRwl5429ZNRlBnSzAVNz7Nra2c82or7N1hTYYAoI8+oQoASzQzUh3mDGD2zI1HfDH0IbVd3V0xQsW2lr9CNzQnW15/pbPqo/6iu88lL/wVTTxVhCV95QsfEhTZc4XDi6fxyDFkkP+g7k1ZwnUH4Qet11h+ngLWDbwBM22j3DJ+dvCf6CJqZk02Nw7aHD4jXYCTp7FtULH3CVhI3hJKp4cgSM+IZk5c6bxWZku8zp5npZDziv4Dp63wXMxiBgro2hjd6RZOsy2Jf8l6m0SiYwPc+Pql77TMKEdv7cUYYLiq0n51fIMEuOt83tllFPUb3djO2pJlkgmrHg7xldRrCwRmP2KQbBvJruAAdAU6N2RhMcGpAd/l8oozusJrHSbWxPbt4VzjVvw/01kA/WuIbuXa2BJqn5y0k7hGNV2nNcOBo8WzcSKg0BV/9NQhK9q/VVxmh4za00I6da+lfdaJVk6XFNnedbEwg0wf8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31696002)(6916009)(38100700002)(4326008)(5660300002)(7416002)(2906002)(83380400001)(6512007)(6666004)(36916002)(6506007)(478600001)(53546011)(316002)(36756003)(66556008)(66946007)(26005)(66476007)(2616005)(6486002)(8936002)(86362001)(41300700001)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWs3T3lyaDNqbHRTeHVzMXNMdHIwanBPT3pkTEwrRExtc2xNTU1Lc0NSSlRy?=
 =?utf-8?B?RGdtNEQzZ25iYXJtNWx3alRDa2tKTEVTbXcrUytaRWdYMVAxZUx2emNSVVZU?=
 =?utf-8?B?bm1ucFhGRFhHZ01rV2ZGTXdvNDBwdTRxajRXcmtQdjNTZlk2SFJQMjZmUjNu?=
 =?utf-8?B?aWgyUDZOUlAwSE8yK0pGK1JzQXYwdHNBdzNiREQrWWF0SzNDMUh6T1JNTDly?=
 =?utf-8?B?Rm9FbjEvMWkxK3NubkVpRnlTQ2txc3ZaSEVCeXF6blk0U1JtY1lpZ2lYV1po?=
 =?utf-8?B?ZCtwSFluV1lFaE40VHo2YWRCNTgwajVkSzBzTlYxNFdiNTRRZFZMNVJXd091?=
 =?utf-8?B?eEhIRzJ1Z3VqVmsyeXVNNHo3dHVaNUlBTjd0NXY2MW45TXpiMk5Sa2hQdVN1?=
 =?utf-8?B?RHd5b292VUs0QVpwdHY2YUtPQUZPWG5EZy9GTzhOVjdZUzFNeGdUeERWUHZ6?=
 =?utf-8?B?TzlvendPZEVDUWpmdlQ4NU40clZpWlN5OTd5YiszZk42VTFkdWZhVGVPQVZJ?=
 =?utf-8?B?c2FObUlFazNCYXVTd1lVY0xRYVVLOWtKT3pkdXE3Rk5WZFpWUGVZam9kV3J3?=
 =?utf-8?B?ZHdPZjVBOWsxMVBqMGgrdHNGcDg0cTNPVGtvSmlPeVVxL1g0MkU0VVJRMTNq?=
 =?utf-8?B?dHpCMHJTM3hxVlVFdWt5MkxQemZUUDRUYVc3MjRhS2RRdUJ5TjhGbUcxTXpk?=
 =?utf-8?B?ei9hTGxWNVh2TmNSb2szVnVmQlM5TWpzWUJoOGVuNE5MM2hpdmhKZm81Wndm?=
 =?utf-8?B?aGFVdlZFUGxLVE9WSU4xSmxpV1A2K1I1T0lZaU5xTGJEbGlTZ2ZURFZUdkpm?=
 =?utf-8?B?MEFjOGgrZUlxOFNlQW84YVoxdU5UaXl1emlXS1lNcXhNSmVtbDJVNGpIOXBy?=
 =?utf-8?B?Y0dhdTNyLy9OTTN1U3RvYWFkSE8rYy8vOWVRNE54WmdBNStTVExHM3A1Sy9K?=
 =?utf-8?B?VmpKdVdWbVR1NlQwcnhCbDJEODA2Z05yUDNQZnFQaXVGK25ZblNaRTZZWXVS?=
 =?utf-8?B?bFVPd1k0SWlHZjdjVS9oTFE3RDlUNjhBRmxMQ2pVUUNaMDVTU3NOS0dVRUQx?=
 =?utf-8?B?dHFGMkRGakljNDlOb3NrSGtXTUJXQUdNSm5LRlV6MTN6WCs1MlJ3YW4xWVAz?=
 =?utf-8?B?TnE2KzVrWUw1d3VsZiszME1YL2g4eWc0YlQ2dlNENjFrYzQySUhGbjFNamRn?=
 =?utf-8?B?NTVwc3YraW9pQm1Fa1dKRHl4SDJCeGlaa29rU3ZOZHNncnhyWnFlNG40eXUr?=
 =?utf-8?B?WlJQRjg0QmZtL0tVazRoaEk5YW9PUTdNYWNBMlNNcU5nZ3pFQXByTjVOK2tJ?=
 =?utf-8?B?dGtUaEFLajU4YnprT1A1MUxqYkp4cnppSldhb1VLRGlDRmJiWjgzTGIwRmVa?=
 =?utf-8?B?SWl0ZmxkWnBmKzBIeUFCT2hwbmRuUUJxVXk5akZuc0d6bEo5dXlUVHFUcEdY?=
 =?utf-8?B?Wkc5Uk5TNWk0eC9wWFdmVitjRWZTbjFGVDBENkRYUTd3a04rQmF0ajVzR0sw?=
 =?utf-8?B?eG1GQTZhU3BmVEpSQmVzeGhNcjlzcU82ZzZvNlQxaVRTVUQ2MzJoZ3NtMlo2?=
 =?utf-8?B?YTFLaW5tRUFLRWZpY1VUY1BhWURXaHA2Y0JEbUZPSDd6SlNhYktTQVZrTlZU?=
 =?utf-8?B?T0kwSHV1RXkxZ3c2UmlQTERiQ0w4aGxTUWZhUENhaXNUOFdocGlraGtsbjBQ?=
 =?utf-8?B?WGYvcVVVaEJNOEcyb3dWVE15TFJSNzJLdHB4T25QNVg3dFJwWHVjaTdadVg0?=
 =?utf-8?B?OE4yU0pkMHY2UGxtQVcyMVY4Wnp5WFB0Sy9FdFFQSVZKMFRFWitvYUVMczdO?=
 =?utf-8?B?bGZXcG1kczBwT1lqVi9lL3pZak95MldsdkJMajdQU0JNSXgvNnVGNVY2Q0N2?=
 =?utf-8?B?d0xaNmR0cEZ6L1ZkRHhvZ3JYeHBVVlN6aEtCU2xINWd3TTVaLy93bHVlTVAx?=
 =?utf-8?B?WHhnZEVrdTBBSWVmM203SDVEa01DVjd6bDNtVDdRQU1pcld3QUpDV1Jydk9T?=
 =?utf-8?B?K2dvUEFnMUk2V3R1UFZBcFNUQ1oxM3Fxemh5eDR1M0ZrZW1GVVFlQWIzV211?=
 =?utf-8?B?ZzBFQlJkdkN0VnowVldJYncyY1R4WTlHOXJTSzcwTEcyQkdOVHV0eDJPR01R?=
 =?utf-8?B?Mm9mTVJkeldLZXRoV1RjZ2pEVnVHRk5NK0xlYlVodFVRL1F2UEV0TkMwK0lq?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	msMzTbYbQzDATVzVQPLOSmXWF+vQGqD73GW3+s0+pmWV/nUB6mnU823Qlu+9uNJjjV13VHxyUeQ/swqJ7a1o3XXdRtJreNSJvb41B3UlzzIogtmRol5cE5d+9cRhpyqW7Y6R6xwi+WuV68EWvB5X9hgYI7g/BD4CTsImlea/fR2bw/JHDLpy+FzzJnPIhasolH+q7MF3oGqaEKpXUox6LYxdGPAm2zNJzQ1DlpuiZ+duq/N/vmIiptAutxr1dd8P1TvhaqX+V/pGc74GimdHxLPL6wDsDKisKrYAlJa6+7mlwxwrFJ/NsDYSU+vtPoRGnbdK0aSRk+Ug6/hvJlr2K6xjBhIMvRFZk6Dw1rfCG+GWJT3Z4plZsHOAq0MMU3zmEnbJWQDQUFh9WqokODT21BCdYs1+bikHOJa93c4LRDrFDqzU3BDp5ixtGXxdsRz20zxkPxAND6oyRYLr489DbXdC+0w+qMTuqxTmi547ALN2v2VgFcvdH97Zr+v3vixHt+o3T/hHwQwqqaZbo8d+pmVQJGURSNXQxOYUT5f9Tt9mYB3eJoKJLasVUO+JAxnh7IoIxN35K00+pnazAl19ZVtD8YeHVAMsz/Uhce8cSeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666b903f-0607-4f32-7bff-08dc10f91cce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:55:29.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbIcRviZ1xGU7YTxPpo0fRL2Merc7++B7shqejkm/I5RwdCZy/B4huKleINr9PUJ4zD0yuZmBt4zzgml0S/sBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090079
X-Proofpoint-GUID: n3ZwaKhzHYOh3rvr1Ta0Sq5_JgpSXDfe
X-Proofpoint-ORIG-GUID: n3ZwaKhzHYOh3rvr1Ta0Sq5_JgpSXDfe

On 21/12/2023 06:50, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 04:53:27PM +0000, John Garry wrote:
>> On 19/12/2023 15:17, Christoph Hellwig wrote:
>>> On Tue, Dec 19, 2023 at 12:41:37PM +0000, John Garry wrote:
>>>> How about something based on fcntl, like below? We will prob also require
>>>> some per-FS flag for enabling atomic writes without HW support. That flag
>>>> might be also useful for XFS for differentiating forcealign for atomic
>>>> writes with just forcealign.
>>> I would have just exposed it through a user visible flag instead of
>>> adding yet another ioctl/fcntl opcode and yet another method.
>>>
>> Any specific type of flag?
>>
>> I would suggest a file attribute which we can set via chattr, but that is
>> still using an ioctl and would require a new inode flag; but at least there
>> is standard userspace support.
> I'd be fine with that, but we're kinda running out of flag there.
> That's why I suggested the FS_XFLAG_ instead, which basically works
> the same.

Hi Christoph,

Coming back to this topic... how about this FS_XFLAG_ and fsxattr update:

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index da43810b7485..9ef15fced20c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -118,7 +118,8 @@ struct fsxattr {
        __u32           fsx_nextents;   /* nextents field value (get)   */
        __u32           fsx_projid;     /* project identifier (get/set) */
        __u32           fsx_cowextsize; /* CoW extsize field value 
(get/set)*/
-       unsigned char   fsx_pad[8];
+       __u32           fsx_atomicwrites_size; /* unit max */
+       unsigned char   fsx_pad[4];
};

/*
@@ -140,6 +141,7 @@ struct fsxattr {
#define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream 
allocator */
#define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
#define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
allocator hint */
+#define FS_XFLAG_ATOMICWRITES  0x00020000
#define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */

/* the read-only stuff doesn't really belong here, but any other place is
lines 1-22/22 (END)

Having FS_XFLAG_ATOMICWRITES set will lead to FMODE_CAN_ATOMIC_WRITE 
being set.

So a user can issue:

 >xfs_io -c "atomic-writes 64K" mnt/file
 >xfs_io -c "atomic-writes" mnt/file
[65536] mnt/file

and then:

/xfs_io -c "lsattr" mnt/file
------------------W mnt/file

(W is new flag for atomic writes obvs)

The user will still have to issue statx to get the actual atomic write 
limit for a file, as 'xfs_io -c "atomic-writes"' does not take into 
account any HW/linux block layer atomic write limits.

FS_XFLAG_ATOMICWRITES will force XFS extent size and alignment to 
fsx_atomicwrites_size when we have HW support, so effectively same as 
forcealign.  For no HW support, we still specify a size. In case of 
possible XFS CoW solution for no atomic write HW support, I suppose that 
there would be no size limit in reality, so the specifying the size 
would only be just for userspace experience consistency.

Is this the sort of userspace API which you would like to see?

John

