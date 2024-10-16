Return-Path: <linux-fsdevel+bounces-32152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A99A1598
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598411C22440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4651D356E;
	Wed, 16 Oct 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZ/T2jSb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y2f8r6Z8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA61D2F6D;
	Wed, 16 Oct 2024 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116420; cv=fail; b=Ke3jkJON1Dju+hU26GGgNeSHRecHGLSrISFNZoYMsQLX+0gMdYTPCVXzqp0KNcJsK/5kgoX956WwyF3k0NglSGKsnIuWrscdceXUrtILAvx+jJVNhhBU+sZT8AqH7HYtnPZOMkTN2oXc4fSJ3CZqYi3LbLjYSUiqp7qY13RN/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116420; c=relaxed/simple;
	bh=imrDaHNkyb5WUFi8M/MJuYu/VC82k0LrJDOyMxgN/ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q4+/8B9O0d6cBm+9DEvuo5/RaWjwKc5JLxjn3xGc8HffbakjSO3ypQtz0KPxFFoTBl60+GRyRZ6Dc34k73/0EznDETU5q2OgLowIL31NqRYt0mlc/TcQtv4ObgIhImRQpnQMfmFzih1Ew9J4rTXnQi8HPj415vIugw2mTRO7cQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZ/T2jSb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y2f8r6Z8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GL0DsQ018393;
	Wed, 16 Oct 2024 22:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SckD3105PLI+Vi8km0vhKlichl+mc20QGn+lFsrWdOo=; b=
	oZ/T2jSbd7nR5QhDVgKrQfI7pFW/YLG3XWZTMQAm5IaVGHP5XYJvWu8UaEELceE5
	GT4DFfXsZIM7YuNcpZNofiPIzIqChroEXwhEn0152aVhwjX1Qrn6alFYUBPNNPqW
	zHPZdpZMh6+hKC2LDKDn1MghtH08xHJQNzwtby593UCcfetLLO7VJVLzf3WdG5X/
	kW4jvpiMQ/Gglt8kcJb80BNmVtPQEDYlvakf3hkVush3wtetkBNxt1E3ApUwTGEV
	m5cruZuKwmcMvAlgNzP2UC+MKnftAgbWy8dp2WyJVBZjOTShkFSOn0SxaJRoGH+Z
	Lx0MpGChMLo78HjI9SQm6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7n1d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKLUSP027322;
	Wed, 16 Oct 2024 22:06:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjg0xw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpX2VP1uBJe7FATzQqUiZr6GOXXWWDQ2TPJX3rqNMw17oX8Wwa0XtZ0typzXodT3LzC3amzmOEaMO2V+KeaLgoJyMzNSagOzlCc19l6lmMV/ym7sI/Azw7auhdo6AAnwIOkK8qssYU26zcDTHOnSTzoTZ/yvtgOw2UTViR71Yvc38gucGHAFGBowLf3R7VH3q3NokaFk5WlMGIhWibMMjyXkFEfaK5syIBw3vw4O9j00FysUU43I3v+iUp+MfSDJvTs79ncSRTHORD+AndgLZ7AG8DhxLn4sxgrI4OLLhqY12aukVqG1BbDiubJLqwIvonD3D8LIbLBVoyikB9bDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SckD3105PLI+Vi8km0vhKlichl+mc20QGn+lFsrWdOo=;
 b=JvPzqBuHwW5mWTNQhI+fn7h/obJHvjeVd/qO1NtVUFF+JIlDpH1SPe9IzHldlmQjxyi8GyNeJSeIt8X/UQDJCAyqpLPwCm1DblYXK4WLT37hPZwZkfn0bUs6bh284d5+G7shLTGk4XIBHeB5+J1hpCD2YXwpFFXMQzxXbXp3iXiyBzgV2/+0fUlpFJdYeAmvSPB1HkG2MlqG3FetC7qYyfvkdwMuw9sVHsc8jjMqVWSEajpHY8r1o5mYm5+X2Kue062HAiUsfShYHs7BUepm+L2x+HU/Spfo0MCxn1hiXUbNNmLmlQBSPRKQ12Lt9l0VtvgxzpkJxi7IvE48nKZAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SckD3105PLI+Vi8km0vhKlichl+mc20QGn+lFsrWdOo=;
 b=Y2f8r6Z8FWxTcg/8UdC6iTNXxXbuKu6bWou7tRMBhEDnhkmKc2IbhoB+5VPzq+eti+Li6lJeaPCRLs7DkSSFh3Zx3VVlaTYfYWWrq9DL02hQa2Az89iekJq6RE6CIJ9HLjn4Y7n6cuz8K3k5oI6HOjFJ2NnvaVZpAhUq99BK2hQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB7997.namprd10.prod.outlook.com (2603:10b6:208:500::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:06:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:06:38 +0000
Date: Wed, 16 Oct 2024 23:06:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 64050caa-5899-41de-b382-08dcee2ece85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUFmMW94RFI5bSttQVNPd2FHa0h1S1QzQkZocUt5OHlkeTdldi9Da3MzNmtN?=
 =?utf-8?B?MTk0OFh1VzB5V2JBbFc0SFNzY3dxaXY5R0oxOWY4YmNEdkJ5UGQ0ZVpLYXEr?=
 =?utf-8?B?eUllUWpubEhteXZ0dHF3MU1pWTRNOVIwWDE2aEc5b29HSFdOcU1Eb095cmRw?=
 =?utf-8?B?bWI3QU1GZFlzenJsN0ZGWW1wY1hEWElzTGpHSS8xak9EaU1OQ0lnbkFDOEJ1?=
 =?utf-8?B?ZU1VVkNYY3FEZGhQYk0yWUszTmxodTBFMmtFanpHVjc4aXMxYzg3aUFKSlJF?=
 =?utf-8?B?R3BPM2dqUUhsOFd6dnlBbXZNaWJjUm5tVGl6VURDUFUxZDdRbTIzZVp2dXdU?=
 =?utf-8?B?ekZZZjV5ODVhcmZpanptanlWS2ZqMytPYkg5Wk5IaysvdVB5ZmdjRTd4T0U5?=
 =?utf-8?B?YlNuZS9USHVqN0ZqMGFFMXNTUGtIZ0FsWC9FODZ0SUVzdlZzYXlOenpjaThV?=
 =?utf-8?B?eTdaSS9IMGViczV6R0hQNGlMamVoS3Fhd0xZMFcyejgyNUZuUHB1QW4weW1p?=
 =?utf-8?B?QVFadkk5diszdUt4ZW1BRlc0UW9MUDZWdWZRNUZWTThHTURXNk9mS2RrQkdT?=
 =?utf-8?B?aERRRXFPWUFkaWk4dDhFV3lNRXRIVVIzOC9qOXJhdnpTTEwxMlgxWUZKWjYr?=
 =?utf-8?B?bDRmZzNSVXE0bitsTmFRUzkvVnllRHFMYXh3VmtIZlUxVUY3MXd0VWNKOVBH?=
 =?utf-8?B?WjlmOWFQcmtEaCtKdE9kZm9rQkxTVE9PQzAzTmF1Q0VwQVQzSlBDVG85WXBI?=
 =?utf-8?B?ZE1SeXhkdG9PY2kvZVZUdGtTdUdEc3dLTWpKdElVOGRnczJWRVNYUHk4Y3kz?=
 =?utf-8?B?M3RkVHRWWGljRTNvRWpXdmMxR0plb3d4VDlVRVBDam81MVgvdHBkSURwWUdH?=
 =?utf-8?B?UWY0ekZkc0puSmdUNUIvak5iYkVKdjN0NnBiZ0hCQTQvNS9pNDJRYktkc1pZ?=
 =?utf-8?B?b0V2a1VFbEYxcmV4MWYxL3RkVlJzTWlZK1NNZW9MMy85SnJDMzl5blJzUlB0?=
 =?utf-8?B?Y1BOY0U0T2J1TmtMUnlua3NnZmJOdDNSME9IOWVsbTlmTEt3VkpZVkozMWU4?=
 =?utf-8?B?K25FanZaU3NkQjVTU2VoVUk4a1VmOEpMM3pRZE1rWnZtV0s5RHRWSmhFVkFK?=
 =?utf-8?B?cG1qWkEybm9zZEJ6Nm4zaEpxZHNUR1FCUUYxdGowL2NRMGVaWFU0bU82dUxQ?=
 =?utf-8?B?KytLME1CaEFNSnZoUEZZdS8yeVNlelhLcmFLV2lJNzYwR2VOQ21IZ2ZySFo3?=
 =?utf-8?B?eC9DN0hwSzduY3lZdnVmblJGRldJcjhLZnN0WHVveTdIYVZuTFBmOWZJRU55?=
 =?utf-8?B?c3FtSFNmME1WSER1c3pPK3hWeEtDdFIwbDNqSjdiRTVaYnQxU2hhcnArbWpB?=
 =?utf-8?B?cnBkYjZaUHRqbU94QmszNFFZYzlVQnRIMEMxcVF6dmU5RytITXJ4OVhnVk40?=
 =?utf-8?B?SUw1UFJyeDJvNVF3eEtXejlhYUVrNUt0SGRUUi80N0MxQ2hWNGJuYTZ6SVpJ?=
 =?utf-8?B?dTlvakNCRlJFak1ZbkhLd2lNa1loRUxWOHUvbklOWnl0elNVbzl1bGFROXg2?=
 =?utf-8?B?akRwS2hxVEZIUmxRdy9Dek9WWlB3RTNhdU43N1cvVnRIUUJIWFoxYnZwY2lD?=
 =?utf-8?B?NjVXakczNStZSmtpamlEdlpBdzQ1WjdYOFlIZXJDYXNZL0x6bjJOUXpqblRi?=
 =?utf-8?B?bGN0b3VCVUZ6QXlVc011TFJBNjRkZVBiVUdXd0pTN1JLR21FQlBBSHBLNUpS?=
 =?utf-8?Q?tCXpvwV65vCkCBPQHUnLJe7r86QBgRkAF6Ot5j6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXVIY0NESEtYbldYM1VYUElNYXBFbnhBTUZLZzFXV21jMFNIM3ErbmFTU0dP?=
 =?utf-8?B?aklqaVdyRnpvV1hLTTBWemdjbFdOWWhuVWc3RE11YmV3ZjJkR2NaTGVIemF6?=
 =?utf-8?B?akdOUzZzRGpZTUI4UnlVVUNWQzRycmdYWlFSZTdHYTFKRHNsY2MxaHFOc0J0?=
 =?utf-8?B?TVBxclk4YWFJeUZxSHVZTnF5RDFEOFNOSGRlKzY3L3pJQXYxNkgvVnJTQStv?=
 =?utf-8?B?NG1LNDRYdEEyNDluOXZtWHY3a2hyNC9CQlpycTJxWXhjdkJPSDA2VUs5aTMz?=
 =?utf-8?B?QStkR3Z3MTZDTE9abE1CV0Z1YjZwZ2FvbHVxK2xiVFh4NU5lVG8xTkVNSnE3?=
 =?utf-8?B?U1hyRy9GSFFKVkN1RXJ5cTZzZFlxOVRpczZ6dStnN25XTkt0OG43aXhtZkZl?=
 =?utf-8?B?VGNvRVd0Q1NzaW5acWFkVm0zeWp1b1ZVaHFNaklBNlpDbno1ZGN3SjlnWWVh?=
 =?utf-8?B?Q0l5VkxSSEVhREZZZnluNGxVbjhQcWFwTnBsdEwzZW1MTnBObC9DTWphOEp1?=
 =?utf-8?B?enN2dy85NjJ3NDFFZU9WalFOdEFFT0NCREh5VjBmTitJTUpxSTRhVmx0Y0xG?=
 =?utf-8?B?SlZMV0JRZEpRNGhIa3VRc1c1aXYrNnY2emtiYXlHaWJmdW1HTk1xMEJEL2xX?=
 =?utf-8?B?RGdoa0d6SmFBVmhmTWZsbG85RDdOMGlPNUxhdjhSTERTaGw5dmc2N1JvNDcr?=
 =?utf-8?B?cWZFVldseUVYamlWVGdEK2Z4K3FnWHNOUGZRQ0ZjR05XRXdJSmhpd0F2MXBl?=
 =?utf-8?B?citZcVV6V2dldTl6V1QxYlVIRzg2ZXJQS1VXajdpallYTnRKRHFLYlZXTTdo?=
 =?utf-8?B?cVM2a2RwZzV5UDJ0bUpzcXRqNDNoeTM4bU8rRXBWbkRWZE10aXpIM2Z3RlN6?=
 =?utf-8?B?WmFwQ3NNMWU4aHBldEJWR3AwbXIwOXhJUEFSeTFUU3RUam8wcUJjcWV2VjRl?=
 =?utf-8?B?dCtwdXFVVk1pTVR6QTNXRzRKa1lOMmsxQjM3bXltR0ZNNS8rMndDYVExSWt4?=
 =?utf-8?B?UXpqTlc4SjE2SnBzRzJpWWMzU3VMNFNNUVp5TVRYQm8yRTBIdVdUa015bytK?=
 =?utf-8?B?RlgrTUlJMk1QMDB6Z2tNSnRneUgvOUJnS3p1dE9oYnlVVXliNWtURTBoajZR?=
 =?utf-8?B?SFIwR3pmbUNrRFdyNGtsWmlDVGdZU3JsR0xEaUFyeXMrVDFwM1hhNXZwbThP?=
 =?utf-8?B?cUlVeU1Lbk5sSmU0MjZicktna2Fzam9EdXVyUzc5ZG41ZXUvTm5YTzY2RWl2?=
 =?utf-8?B?enNaN0l4WWJ6VEZQcUsvZ3o5bXp2WTBuZGw4TlpxMGM4WThaY0V6eXg2Qldy?=
 =?utf-8?B?aXY3emJwSkphTVZhU3dXK1AwTW5qTS82MkhraFlXRmUzbE5qazhkaEg5SEha?=
 =?utf-8?B?YTlzTEZVQ0tOWDIxN2pMbmRDaUhYcS9PQk82MUo0U1M1bkY3eEIvbHlaWWZk?=
 =?utf-8?B?eFZFelFJd2pwZXpPWUU0YzBEM2hoR21CemJuendaa05ib0ZPMmJKTGx0d0VB?=
 =?utf-8?B?UkdPdHZLQlozcU5xTHdEQlk4QWtIYVJ2cFRaWEJtTVMzY1ZkbWRSbGFFMnY3?=
 =?utf-8?B?NExvR2tabVQzTzdLTEExZjJuOWdGOW01TXJRdjhna2xyUVVOM0JvSWkxL2pV?=
 =?utf-8?B?OXBoS1hIdUh3N0xLVXZnZHJZbGZtRnFEYTk4dXpIYWZ6QnRtWnc0YTdjWVlC?=
 =?utf-8?B?a3YwcXg2dWdJUG5rNUt5MGx1Z0JUcERhckhmcU15cW5rV0g5N3paMiswV0hH?=
 =?utf-8?B?MXNkOG1XTllhdXdYYjR6cE0vUkFCNzg1NDArKzZZeDFVdTNhZGpDQmt2Z2dh?=
 =?utf-8?B?a2Q1WjkzU3NIdTFCYk1ndVBlUXUyRzhWUWhuZWxDT09UZXl0a2FhQ0ZkV1l5?=
 =?utf-8?B?dndpM1ZNbHMyM2dnRUNzZXR1WGFYNUtQck5aN0lsMkVyUUMwNndLRWM2Q2ZQ?=
 =?utf-8?B?NlJ1Y2NXbzZOTFMyVFpFbEdwN0ZSNUVJUnpwZGFuS2JwMUZRTkM3d3dGZVVz?=
 =?utf-8?B?Vjl6bFFDMnlOU3dHU2JydEVoSDh6VHIyeno5em5kUHVkbVY3ZzBiWjVRcjdO?=
 =?utf-8?B?bUppOFF1ckFhT3d3UDRVNnlZQ24wdkFFRkV5Vkd3aWpOTHUzVlBWQnJSTTk3?=
 =?utf-8?B?ZUdpSjBUYnBBZTZjNmpOaXpKaVVWazVyRzFEQ1dEUWdiM1BTSHpjUmdYRkI3?=
 =?utf-8?B?VjJHdWhEVGlGM3B1eUlaVm1KSmJRZWgwRlNmVUdNbG4xVUp1ZnhwZEtLS28z?=
 =?utf-8?B?UllVeHlvQXkxazNydllncysyUWRRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q8W25yamMjkEcMa5e8B71UXjL7byG73L5Xemp4IO4uyndIe8UnSUHC6p0/R0Yc+zY7F0fdMBlAnZemFKgsVpwoRo4FSFNEhWx3cEQtYnMbw5jPaEllw/4KJYhrVhKaDsHy8r/rWlR2WIaHRyyGfdtC8k+uzZxx+VO6TjJIEtvccnIx5VOW399qM70ZAyPdiJRaOqr+RV3qB0+ed8AFhYBYCgiVBcQwoVtIf7LPh8c0TqUs+/Ai3OXpQSsOEMrfLqMoIU1OEsnEa9H1DNGl8LLKkjuT/QbXCaYy/3kUC1+yJm/CbifZntgw0H3rPbDZ5Wn6NH6TBruuzB2c05fTrnYkXR6sJ05FkljI2NxbRuP6djGCauQ12zfBxhyPfareg7SzIy/x0/GO6/MaufKc4SoGnrorB0fr67+wAJdtIGeAUFJwQPj+ZWAwpGkfhDXmvI3oZ48Gz+Cnx90pUZL7aS80lJlRiHCfiU2UuIqdyRvkxc1D8mP/Hdv6q99GNyLN6+TC6j8ZrCIsaxsw8XvA85e8YgcQhFFNaCPkA/Xcco7lydYQiZramFrZsJapj58V1jV1lfFEJgmLdoXAssJ0Rq97gAsRbJVvXh8R+cx2ZS+0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64050caa-5899-41de-b382-08dcee2ece85
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:06:38.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shwjo0wGOvbz4QfDWI2CqrUHKa78G3757V86CXIiVG7Dp9NT+En6e0KGPGLeDmQgb9jX6NdqjuQV1BsZJu7tthgqbTaVgbKxCfVOvZ9OXak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160140
X-Proofpoint-ORIG-GUID: nvy3nKaQ8a92NNvyyuLWY8vNxEsuUoQ3
X-Proofpoint-GUID: nvy3nKaQ8a92NNvyyuLWY8vNxEsuUoQ3

On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> On 10/16/24 04:20, Lorenzo Stoakes wrote:
> > Add tests to assert that PIDFD_SELF_* correctly refers to the current
> > thread and process.
> >
> > This is only practically meaningful to pidfd_send_signal() and
> > pidfd_getfd(), but also explicitly test that we disallow this feature for
> > setns() where it would make no sense.
> >
> > We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> > theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> >
> > We defer testing of mm-specific functionality which uses pidfd, namely
> > process_madvise() and process_mrelease() to mm testing (though note the
> > latter can not be sensibly tested as it would require the testing process
> > to be dying).
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   tools/testing/selftests/pidfd/pidfd.h         |   8 +
> >   .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
> >   .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
> >   tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
> >   4 files changed, 224 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > index 88d6830ee004..1640b711889b 100644
> > --- a/tools/testing/selftests/pidfd/pidfd.h
> > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > @@ -50,6 +50,14 @@
> >   #define PIDFD_NONBLOCK O_NONBLOCK
> >   #endif
> > +/* System header file may not have this available. */
> > +#ifndef PIDFD_SELF_THREAD
> > +#define PIDFD_SELF_THREAD -100
> > +#endif
> > +#ifndef PIDFD_SELF_THREAD_GROUP
> > +#define PIDFD_SELF_THREAD_GROUP -200
> > +#endif
> > +
>
> As mentioned in my response to v1 patch:
>
> kselftest has dependency on "make headers" and tests include
> headers from linux/ directory

Right but that assumes you install the kernel headers on the build system,
which is quite a painful thing to have to do when you are quickly iterating
on a qemu setup.

This is a use case I use all the time so not at all theoretical.

Unfortunately this seems broken on my system anyway :( - see below.

>
> These local make it difficult to maintain these tests in the
> longer term. Somebody has to go clean these up later.

I don't agree, tests have to be maintained alongside the core code, and if
these values change (seems unlikely) then the tests will fail and can
easily be updated.

This was the approach already taken in this file with other linux
header-defined values, so we'll also be breaking the precendence.

>
> The import will be fine and you can control that with -I flag in
> the makefile. Remove these and try to get including linux/pidfd.h
> working.

I just tried this and it's not fine :) it immediately broke the build as
pidfd.h imports linux/fcntl.h which conflicts horribly with system headers
on my machine.

For instance f_owner_ex gets redefined among others and fails the build e..g:

/usr/include/asm-generic/fcntl.h:155:8: error: redefinition of ‘struct f_owner_ex’
  155 | struct f_owner_ex {
      |        ^~~~~~~~~~
In file included from /usr/include/bits/fcntl.h:61,
                 from /usr/include/fcntl.h:35,
                 from pidfd_test.c:6:
/usr/include/bits/fcntl-linux.h:274:8: note: originally defined here
  274 | struct f_owner_ex
      |        ^~~~~~~~~~

It seems only one other test tries to do this as far as I can tell (I only
did a quick grep), so it's not at all standard it seems.

This issue occurred even when I used make headers_install to create
sanitised user headers and added them to the include path.

A quick google suggests linux/fcntl.h (imported by this pidfd.h uapi
header) and system fcntl.h is a known thing. Slightly bizarre...

I tried removing the <fcntl.h> include and that resulted in <sys/mount.h>
conflicting:

In file included from /usr/include/fcntl.h:35,
                 from /usr/include/sys/mount.h:24,
                 from pidfd.h:17,
                 from pidfd_test.c:22:
/usr/include/bits/fcntl.h:35:8: error: redefinition of ‘struct flock’
   35 | struct flock
      |        ^~~~~
In file included from /tmp/hdr/include/asm/fcntl.h:1,
                 from /tmp/hdr/include/linux/fcntl.h:5,
                 from /tmp/hdr/include/linux/pidfd.h:7,
                 from pidfd.h:6:
/usr/include/asm-generic/fcntl.h:195:8: note: originally defined here
  195 | struct flock {
      |        ^~~~~

So I don't think I can actually work around this, at least on my system,
and I can't really sensibly submit a patch that I can't run on my own
machine :)

I may be missing something here.

>
> Please revise this patch to include the header file and remove
> these local defines.

I'm a little stuck because of the above, but I _could_ do the following in
the test pidfd.h header.:

#define _LINUX_FCNTL_H
#include "../../../../include/uapi/linux/pidfd.h"
#undef _LINUX_FCNTL_H

Which prevents the problematic linux/fcntl.h header from being included and
includes the right header.

But I'm not sure this is hugely better than what we already have
maintinability-wise? Either way if something changes to break it it'll
break the test build.

Let me know if this is what you want me to do. Otherwise I'm not sure how
to proceed - this header just seems broken at least on my system (arch
linux at 6.11.1).

An aside:

The existing code already taken the approach I take (this is partly why I
did it), I think it'd be out of the scope of my series to change that, for
instance in pidfd.h:

#ifndef PIDFD_NONBLOCK
#define PIDFD_NONBLOCK O_NONBLOCK
#endif

Alongside a number of other defines. So those will have to stay at least
for now for being out of scope, but obviously if people would prefer to
move the whole thing that can be followed up later.

>
> thanks,
> -- Shuah

