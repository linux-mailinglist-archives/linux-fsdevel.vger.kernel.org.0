Return-Path: <linux-fsdevel+bounces-35983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421389DA7D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9B5B27A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551AE1FBEB7;
	Wed, 27 Nov 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M71zU0ta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD91FBE80;
	Wed, 27 Nov 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709925; cv=fail; b=N7amki+qhdNrrQHpwKQi6ZLiNnh5TccE2sMXG5ZK820Aug+aPkbqJ3KPlfHJXrkV2W28CtgjO9p8hkAXHQnQxBFS8Jmvjq8oyMFxXNXN2RxmhW57tcmRMtDWJ9HlZnhDY3jG+/nu9Ab/3abO7Vex9POgMyEUsVNxO64MQd+zQXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709925; c=relaxed/simple;
	bh=kilqHWrRRaaHXcMk/klChtvksP4SDUflTgeTAkuj4Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvK28/qLD2enHdyyxzFfrF/2SKpdUONk2oG5L4b1EtHrZPnlb/z5rr5g6v9drrNcg2zbm10GpnQTphTA/WMccXUanXEon4QHxF+9KHJWfRuhZHxdfeQYQ4DAlkznVFT905Rtd1ZhaYlQqZ5lX2Nnqh8C+YXAbiQFz8pum/+KI6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M71zU0ta; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpzcLEV2fIitZpI8opXmpzZqOFmK8xG7m3ocYL7BiRGtoJoXLwzoZiOUbIiwvXbgXezos90mpwqqD1eU8P/CPcIXoME9vIeQC+qKC60hv3z7NR25LQIjmUBDTQ3FjGM33qFbqXP3q3JXzHw53KK97oklrjOeHbnQxMDWuuPK7hORe8WlUZYQ9E136MQml9cyxFsGgbGX9nzOSqvNOOcJLt1ms6hQ4X7nbjAVoVCeJIiHLMHHMD4uXL7FTOnYiNFW1BAV1Z2/Z1P4dd0f7U4Lv08PNXIVN5TiV0uPBGIJTqe2QkJoGH4m+pchC7A3UJzVHBhwb/Mp74pcI4f3DTvQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9rxv4yu9TfNbmUZXEOAXMKbjeyz0SWduY20BxKv/Yw=;
 b=H1ZZhNTideppr0uzZE3XHXgybz6EKyX3JaYx4dzTZUILUFZeh6oEOGPUkQMQuX8RZd5I6V7q0JlcBoraQ4py2v7lT+J7au0j55fflDtBdw47fsP8I+n7x5aJ8N4wiRCFP33hCgQG+dSQjHpABGMwxbewk/E6e5wp6FQyEwEdXZEc/VWV/FiQ7dRT2Sl+YuW9nnxz/MCTWC4J+gnrUy10aEMAnbT54tWQuALdFAE+opPdaaNlzROP9KioK7g2yQccqGi4wI4Y8993YRiHrz57zwXTlRLeQ98r1+e2Fffz3WB+rJKLwnapbVIelqcI9w3Hp4gmuqdOHLZ7hzbhXApomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9rxv4yu9TfNbmUZXEOAXMKbjeyz0SWduY20BxKv/Yw=;
 b=M71zU0tapmd2NH0sjeyYZ7LKVAmLXjkmRbhZumjkAy4B+pWfM8rNYhSRkOlhQqoU22zVvepjuKJ6T8eBROCrzo9kpcGFF4vEpiEYaLWaw57Fv3xFaclwPBRRpjX7l4rGHNrR0obHgQBDcq76p4F+xkvEfvCOErnS9X6ieoR0hKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Wed, 27 Nov
 2024 12:18:40 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 12:18:39 +0000
Message-ID: <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
Date: Wed, 27 Nov 2024 17:48:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com,
 willy@infradead.org, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F1.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2d) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f2fca6-2392-4623-d516-08dd0edda035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBqQ2VEYVBxU29jQmI2Q21sZDgvekN1UlYwYm16WTJmY1J5a3llZzhvWm9w?=
 =?utf-8?B?TXp2aU1WMkJGbDUzWlZJaFc1Y2o5WkU3alJVL2NWY1BiMEZFdk0vQ3BKdktw?=
 =?utf-8?B?cndFZ0Q5dVZNbkptRlU3U0hmeVpwU1hXK3R3N3U5eHREUFRuMmNqZzdhak9l?=
 =?utf-8?B?MS9TUnJPVnpVUmZpUXBSMktpZE90VmdNVmhYUmd2M2I5YnVlbWNBSzZ4bW5z?=
 =?utf-8?B?Y1NDY29RUXFaS3lGbEtSNCs0TUFsbEZDNTdibjFtd0FuTmNXNStpVEx0UWt5?=
 =?utf-8?B?Qlc4Mks1Tk9GM0VwVCtQQmp6STlpZWFwOWJkYUl2WmxyeDh3cHdaWDFiL2g1?=
 =?utf-8?B?TEVlQWlnUDdIYjczcldqWkFvZENjdklTc2JVQUVBaWh4OWNTN3puZ2FjVVIr?=
 =?utf-8?B?aGcxK3oyRjlYOFFtMzZpQmFCOHJHOU55djQ1WDB5WGJkVzZncTZXK0lwSGY2?=
 =?utf-8?B?OUVLY2V4WWxjM2ViUEoxekp6bkgrY3JiTDM0bHVhN0JRL0wvUk1ZSStrNzNY?=
 =?utf-8?B?WDh5dFpxU2RUeWtVMy83blRtTkM2WmczNXpyQWRtNGoxQmUwdndnTE40eEF3?=
 =?utf-8?B?b2FMd3I2L1ZRNmorS09zd2JLVlIzMCtjTVZoSTZkN3RVVHBXSTZPd2dFV1hq?=
 =?utf-8?B?cHdmcXZLRVRCVC9NT1NtWk1HemFsdkhORkV3R3QrTkxIOU5zd2xLQzBpKy9V?=
 =?utf-8?B?cG9JV3AweWYxa1ZTNC9ud3kxb0RBYWpzeFVhQllNd0k0V3U1NjFUM0lGaU5Z?=
 =?utf-8?B?RzQ2azgxSWU0cWlGdWVQdUxzYllla24xNVFGeDhmenQ3UVZ0YTJtLzViMmRu?=
 =?utf-8?B?TExBdGUxbndzRmhtSXhWQUIzZFh0QUIxdzR0TXJJb0ZqUUI3VnFmYzJPVWJ0?=
 =?utf-8?B?bW4wMUZZUHhsQWVYNkFWSXdad1B4cEhpbWQySXR3R0RDZ0FrMDFYK1RnaDRW?=
 =?utf-8?B?MlJJdUl3MElFTWllWVNOanhRanJRYlQ5dHNobFBPbllhZXNWeTJVUWIrV3pj?=
 =?utf-8?B?TUx4VUlxRXRxbTdZUnhnNW8wNmZMeWw0OVM1YWdKRmxUY1dNV2t2K1NWbnBG?=
 =?utf-8?B?R01waHJ4YVNwSFh5STh4MnNkN0M0VzliZ0c3OWRzREkva2xRMER4bU1EUXVF?=
 =?utf-8?B?RHhSLzNNMTZKcldIeDM2dTJBVlZQbXlKMUV6dWVtWHFsYmpIRkdzWGNJaGJZ?=
 =?utf-8?B?Mm5UUlJEcjRubUJmTGc2MmdhaHNZU3FvajFpcTZvMmZqM0VtZ01PcWJGYlhJ?=
 =?utf-8?B?UENaWStqRWhENVh1dEJObkhhOTRTaVVSRmdrdUtnWmVjNUJLbWR4ZHpBQ2lY?=
 =?utf-8?B?aXpPUVIxZklSNzhvNlMvY09nU0JaUUZZdnh4QnBFaVVhVSsrdmdreEtwSnlk?=
 =?utf-8?B?YllJTGZDZkJtZWF3eGJidy9IeU9CVlQvaEJja29DMFdQZ2F4eFpQSXRVY3V6?=
 =?utf-8?B?dm4rcXk3eU9mWW1tZmxnVTIreFRXUmZsREYwWlU0SVFHOUFiVWlLWGNyVzBo?=
 =?utf-8?B?OWFHQnJ5L0gzN25SMHFvT0kzbDA0UlZQZGNLY0JCdlRvQjVyTkdxaGl1ajdZ?=
 =?utf-8?B?RnpkYWdFTzdyNEZhbXZrU1hkbWxmUnNyZTFRK1FDRHRuckFlTEVtUmR6WVVV?=
 =?utf-8?B?NkRFeGtWU1FDaDBlamRIa1RveHEzMUNpZEI2S3BybGpneFFkZ2FTc0p3eW1k?=
 =?utf-8?B?b3I1RkR2ZDNtT2hINEx0Zk95TkYvM2Z5R3krbDMzbXd4UXM0M2hmWkNjZ0sv?=
 =?utf-8?Q?t471PB44AEuLc+wmyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFNmaEZkc2tIanZwSFVmcE5ZdVNxWjB3bStDZzdqSzFRQ1l4QnhOc0hFYXM2?=
 =?utf-8?B?bTRJcDNFbGtnWXBjZWltMnJYSjRDTWdwUUMyZnNrQVVjN3c1LzlPeGNzU1hM?=
 =?utf-8?B?azdxNEF3ckxOazZVZUxqTThZRVMxbEw3OTVxZW94aHFsNk5BVk5qeW1BdTFL?=
 =?utf-8?B?R1gzOUc2eVBjY2NLUDNNUTZUSmgwWnE1bVRSbis3ZkFqTm1uakNhNEh4RmZV?=
 =?utf-8?B?ZUgwWExFZHQvaUUwQVc0RHEvbVlTaUlnU3FBVFV3K2FhODJxMnBFNW9wMURr?=
 =?utf-8?B?eTRFWi9OOTZtMTZQVWgwNE5sQWZSU2tsSWpTNDJBZXV1MmpCOTZydnZKYmFx?=
 =?utf-8?B?LzVjV05wZGZnUnhCUGxkbnBZa0RiSHMyUnRpNURrckFwVjhPQTFpVVFMYTRH?=
 =?utf-8?B?ZVoyUm1pMS9FUVY3YkFFcWI2aFlKV2J6UnhEb3Zrcmx2S05UZmNLQ3FuRjBH?=
 =?utf-8?B?VDlDYk5WU24wVDVmMDhnTUJJVFFhSzFtM1M0cCtJNXliQ1JrRHhYNjNhUDVE?=
 =?utf-8?B?azBoTjRXWisxNFFwaUpmK2tCYVJOU3IySng2TjBZUFNOVUNKTXRybXpIaktx?=
 =?utf-8?B?UGN0SEZ3dEVYcCtFTzlmd1BuYkFOOElTV0xmdW82aGtEYWtmTHJ3OEpGTWty?=
 =?utf-8?B?ZnRMZVdOemZwUitwSHZCREVoTUtOUnVicjFQSGpOQm1IQTkxelJrOHBieWR0?=
 =?utf-8?B?TVNjYzdITHdKeXVyaURWMG5lWXlNTFRlbjQwdlQwWXhSbjJWWGRwRjF4M0g2?=
 =?utf-8?B?YzNMSStPTU9JUzZsM2poNFgxUC8zV1NpQmh2blA3amZYMXd1YVRqOXVFaTlD?=
 =?utf-8?B?RllWOHliODBjT1ZYSmFsT1k1eW5JKzJIb2M0ZHlpeVNwNlhPNUNwbnhhSHlN?=
 =?utf-8?B?alZzNGJOdk1rcTA2aElpSW52eGhQTmNZRVNEM0RDNVZWcXZ1aVE2bW1IbXZa?=
 =?utf-8?B?QnkrY09ldE9IdE1CMFMzbVFCQ2xKZlpMWXJ3NmU4UDZaK25henJHOEdRSW9x?=
 =?utf-8?B?V3lYZE1ZMHkxUFRuTU9xRy9QZmhxR2xoTWtDcm1OZXZyWFVvTW5iS1k3TG9l?=
 =?utf-8?B?TmtxZGRzTHVpaWQ2T29IbFp2N3JjM0czUEhWd2Fvb2VCYU9aTmJaNmdTdFl6?=
 =?utf-8?B?VURTQ1c2NGZDd0tTRUtWOXBQVkwyYjd4SC96M01sbWJKUjJvVkFpdDA3dlZD?=
 =?utf-8?B?bGRTcDdnQk9KS1ZhOTJVSDRJSWNGbnpPQXlwenUzTC9TeW0xd2krM0NNSFRI?=
 =?utf-8?B?QXAwMzBQUEpHYmFhT1QyeDJRcDVpdU93ZnJIY2h0d1JHYUVIczhIWlhVNGla?=
 =?utf-8?B?TzRZb3QyVEs3Y3RyVEZHV0VoQkdua1d3UTAreXlxZGVpL2kvRzJNaDR6WmdL?=
 =?utf-8?B?UDN6K3BaUzZrNmt3eFRwbjNPT3FvTzdVakpZOXdQTkt2dElrUTNtVXhlZW94?=
 =?utf-8?B?OHdEaXRISkprU3VaMmRZL0ZsWjhKOUtTY0prNTdBWUN6bGo0N2FvbG5Qek5x?=
 =?utf-8?B?NDZ3WnhmZklkb0w4V05SbVV5NnVnNnBlNUU5QmFkRE56dHhoRjNlcFRkUlB4?=
 =?utf-8?B?SEV2ZFNrM2R3QlpuL29naEVISWdSZHhobWZKSkxGai9YbUNobWMxWlZidTE0?=
 =?utf-8?B?cHJuUjhiM014R3grMFJ4eGp4cUkrN2JOSU4wZ09sN05tTG5KNW1ZeUJFTUJ2?=
 =?utf-8?B?ZjQ2S3BKNVlvVkE5NW9HTzY5K1pwUWF1QzNTVmhSRHlQdDRhWHJtM3F5YnZo?=
 =?utf-8?B?SWFUNGJhczhFZ1VleXRzM2RPV3p4R2FjYitGT0VWeXB3NWw3YndTZU55UUNS?=
 =?utf-8?B?bkhJUUhLT0tUN3JvTjltc0FsbHZnYTJ5ZlV1bDRmVXJqZzJya0JVYnduc3JQ?=
 =?utf-8?B?ajAzbDJJMHJrYXlleVMzRkNKUXY3R0dwNDk2N3phTWJrWHdWRm4vbFZycW9s?=
 =?utf-8?B?ek5UMHlSZXJsdS9Sd3RJUWlZY203aURBQjRBVG1mRE1rRVRhSHpSbTV1SXNO?=
 =?utf-8?B?MVhmK1RSd2JoNVFmS0pncisrclJBZUU0L1d4cTBabWFrUWNWT0NJUCt1VUlV?=
 =?utf-8?B?MndkRDVoa3daMFl3bHB2T3daU0pwcG0rRUx6SnFwQlcveEM0SThCS3pMd0ZJ?=
 =?utf-8?Q?9QvPbe3imyzCiaXHjoLPt9c59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f2fca6-2392-4623-d516-08dd0edda035
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:18:39.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEhw4pFl5v/6R37NYlez/oHu3up1uWSJXs7bZMdOGjUgyMFGeY0svyDwp0YxMHS6syCHWeDJBZKOVL4yIfrBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

On 27-Nov-24 11:49 AM, Mateusz Guzik wrote:
> On Wed, Nov 27, 2024 at 7:13 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On Wed, Nov 27, 2024 at 6:48 AM Bharata B Rao <bharata@amd.com> wrote:
>>>
>>> Recently we discussed the scalability issues while running large
>>> instances of FIO with buffered IO option on NVME block devices here:
>>>
>>> https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
>>>
>>> One of the suggestions Chris Mason gave (during private discussions) was
>>> to enable large folios in block buffered IO path as that could
>>> improve the scalability problems and improve the lock contention
>>> scenarios.
>>>
>>
>> I have no basis to comment on the idea.
>>
>> However, it is pretty apparent whatever the situation it is being
>> heavily disfigured by lock contention in blkdev_llseek:
>>
>>> perf-lock contention output
>>> ---------------------------
>>> The lock contention data doesn't look all that conclusive but for 30% rwmixwrite
>>> mix it looks like this:
>>>
>>> perf-lock contention default
>>>   contended   total wait     max wait     avg wait         type   caller
>>>
>>> 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wake.isra.0+0x42
>>>                          0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
>>>                          0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>>>                          0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
>>>                          0xffffffff8f39e88f  up_write+0x4f
>>>                          0xffffffff8f9d598e  blkdev_llseek+0x4e
>>>                          0xffffffff8f703322  ksys_lseek+0x72
>>>                          0xffffffff8f7033a8  __x64_sys_lseek+0x18
>>>                          0xffffffff8f20b983  x64_sys_call+0x1fb3
>>>     2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_llseek+0x31
>>>                          0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
>>>                          0xffffffff903f18fb  down_write+0x5b
>>>                          0xffffffff8f9d5971  blkdev_llseek+0x31
>>>                          0xffffffff8f703322  ksys_lseek+0x72
>>>                          0xffffffff8f7033a8  __x64_sys_lseek+0x18
>>>                          0xffffffff8f20b983  x64_sys_call+0x1fb3
>>>                          0xffffffff903dce5e  do_syscall_64+0x7e
>>>                          0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
>>
>> Admittedly I'm not familiar with this code, but at a quick glance the
>> lock can be just straight up removed here?
>>
>>    534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
>>    535 {
>>    536 │       struct inode *bd_inode = bdev_file_inode(file);
>>    537 │       loff_t retval;
>>    538 │
>>    539 │       inode_lock(bd_inode);
>>    540 │       retval = fixed_size_llseek(file, offset, whence,
>> i_size_read(bd_inode));
>>    541 │       inode_unlock(bd_inode);
>>    542 │       return retval;
>>    543 }
>>
>> At best it stabilizes the size for the duration of the call. Sounds
>> like it helps nothing since if the size can change, the file offset
>> will still be altered as if there was no locking?
>>
>> Suppose this cannot be avoided to grab the size for whatever reason.
>>
>> While the above fio invocation did not work for me, I ran some crapper
>> which I had in my shell history and according to strace:
>> [pid 271829] lseek(7, 0, SEEK_SET)      = 0
>> [pid 271829] lseek(7, 0, SEEK_SET)      = 0
>> [pid 271830] lseek(7, 0, SEEK_SET)      = 0
>>
>> ... the lseeks just rewind to the beginning, *definitely* not needing
>> to know the size. One would have to check but this is most likely the
>> case in your test as well.
>>
>> And for that there is 0 need to grab the size, and consequently the inode lock.

Here is the complete FIO cmdline I am using:

fio -filename=/dev/nvme1n1p1 -direct=0 -thread -size=800G -rw=rw 
-rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=sync -bs=64k 
-numjobs=1 -runtime=3600 --time_based -group_reporting -name=mytest

And that results in lseek patterns like these:

lseek(6, 0, SEEK_SET)             = 0
lseek(6, 131072, SEEK_SET)        = 131072
lseek(6, 65536, SEEK_SET)         = 65536
lseek(6, 196608, SEEK_SET)        = 196608
lseek(6, 131072, SEEK_SET)        = 131072
lseek(6, 393216, SEEK_SET)        = 393216
lseek(6, 196608, SEEK_SET)        = 196608
lseek(6, 458752, SEEK_SET)        = 458752
lseek(6, 262144, SEEK_SET)        = 262144
lseek(6, 1114112, SEEK_SET)       = 1114112

The lseeks are interspersed with read and write calls.

> 
> That is to say bare minimum this needs to be benchmarked before/after
> with the lock removed from the picture, like so:
> 
> diff --git a/block/fops.c b/block/fops.c
> index 2d01c9007681..7f9e9e2f9081 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -534,12 +534,8 @@ const struct address_space_operations def_blk_aops = {
>   static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
>   {
>          struct inode *bd_inode = bdev_file_inode(file);
> -       loff_t retval;
> 
> -       inode_lock(bd_inode);
> -       retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
> -       inode_unlock(bd_inode);
> -       return retval;
> +       return fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
>   }
> 
>   static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
> 
> To be aborted if it blows up (but I don't see why it would).

Thanks for this fix, will try and get back with results.

Regards,
Bharata.

