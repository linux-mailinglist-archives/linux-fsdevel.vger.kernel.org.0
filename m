Return-Path: <linux-fsdevel+bounces-24011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC7937927
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70C3282BA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6113AD22;
	Fri, 19 Jul 2024 14:27:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020110.outbound.protection.outlook.com [52.101.85.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD0137775;
	Fri, 19 Jul 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399265; cv=fail; b=FjRJFzrFHfdt1331Bsc4av1OpQGuHojqC6E+urwNzSqJk9/e9O8XaKYTk3mpDcOQ7oxypyp2Hwc6TkFHDSk8Gg52MUQzZrxTI+3gIyx0TVi2vdBleog7BPQVF4ojXL3TZdfFUwoBRtvCwIpX7u90bRUKtjEKJdcf1c8+J2A5ZGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399265; c=relaxed/simple;
	bh=se4pY0uZ7e0rfzRWnc8qfB9KZhzT87xz3qqUSUt6t4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGDCI+ss7/D51oVgkonA5Uf/K/dnv9SLNe+U+rajCBvw/OnUf0jNjEctGzpFf9fIVVdQ+xgEkuuIf81SBMekRv1v3uz7MRQ8HDF1aEYOTD4WHBuY53rivVmPvSXOvJWD62R/AxFOgaNHt7My/lKQi2fM8pxV52fnSvEVPw1cq3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.85.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=napqNwpyKw19QrywaMQu3yvE6vy+NWCq/WjyPbOulu2+T3LLyBGgdLFynWCXtDrcwv2RPcWlCQnP6xtRVr7uq4qCiYTyTO+2DMd1f5xsWheXekwLxODqwZPZgmd8gWxoVmq4yj+AHlim5tvehYxGxvuByC6Y6yw3A1lv9gY1xf59PyzgX7rFwIMZqwy2P1gvWSuOvHg1MBaUp1VlQAyomGjcgfEPj6wQ9ef1Zyxe3eUyCfn95S/1uVyqXzmEYUGdGc8Hsjm0K1B3o287ylA+iFY06k4Omhg1R7Le+Q4u3qJW91V60iEpZ6nfWDAHglfZMIM3xnNS7zGUCnAXIVW2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVBriGDkV34u4bf04M2NLbmguMuWJojipYM5I3JCITs=;
 b=s2WvIL+tCn1XV2g6KzZinxqcVVXJ8vJoD9HNTg4XZzjW8XydA0UlwjXYIt1TLt5EZ45eIoD/5OglgjdfTc8MDPl9cQkhyMpAlNGw6GpQxWv2EmWRPLJ4cOWaTKGK8l/35KiJNWntUCV9NnM1sV+LydkJqNnO1GAn0GPXjLhFDOwiyFY7CPioamsjC5xZSPlioQjarQyqZs8g1rV9ydEKK0k4285blYY/4Ug7uTjZl1gdjdkrklGZ/E24cToeLjRJhrl1p86IRF2GywULhGcQNsNOF+Cc9Ioj9X6KrfdxY4zOy6zoV7GnJOMCDrXzN1zLWBBLqbg3TWKRvm5yTn95BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 SN4PR01MB7406.prod.exchangelabs.com (2603:10b6:806:1e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Fri, 19 Jul 2024 14:27:41 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 14:27:41 +0000
Message-ID: <129ce5e2-2dc3-4185-9057-4c88bc02c103@talpey.com>
Date: Fri, 19 Jul 2024 10:27:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cifs: Fix server re-repick on subrequest retry
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <nspmangalore@gmail.com>,
 Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
 netfs@lists.linux.dev
References: <20240719140907.1598372-1-dhowells@redhat.com>
 <20240719140907.1598372-2-dhowells@redhat.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20240719140907.1598372-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:d4::43) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|SN4PR01MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e6ad62-c630-42fb-0e7c-08dca7fef241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFk2alF6TmM1dHAwcTNZaUdDTlpXem5PU1Q0NUFXWDhaNVZHVHorVCtXbzR5?=
 =?utf-8?B?Qis5TlhpbmZyMUJEV0ZCMWZFaUxkY3JIaklORlpydWJoSFVnNFZLVzdFU2ZJ?=
 =?utf-8?B?aU9tVHN3Y2NlUUhmcXRJT0crdjFoRUtRTUl0aW5zUkQrbXhHWkU1NDVLbDhW?=
 =?utf-8?B?WHZSQ0tTM1hnbTR2Q0NkdlhqRDBUU0R5MEhnUE9pd0pZYlR3MG54VjU1VDU2?=
 =?utf-8?B?SnVXZTJsVE5LRHFCWHhxbUo5L1N2N3RweXBjLzlGNE5GblJOQnI5Rm9mTFBt?=
 =?utf-8?B?VXM0ZFlZWk0yZkJndFMzME0vRUhYN1dFNFBNYVUwaStLNWlDamFjMmNkQ2dp?=
 =?utf-8?B?Uk5sVTdIZGMveC9MQ242VmxqM1UvTDVHRXFnbUtrbWpFSlhpWmdCMFViWmpB?=
 =?utf-8?B?UC9LY1QzN0VvYjI2Y1FaR3JzMUlMVnJRSUdmYWxaUzM5ZGM2Q2xOWXkwUlhy?=
 =?utf-8?B?MzF3cUMyc3lORDdQUmVYSCs3QVFZSno3dTB4aW1zdXMrTWZlUFJOQ0gxY0lN?=
 =?utf-8?B?MVU2dXlZbkhFK0F6NkY1VjQ5ZStNK1NNRjVDOHF4WGlqa0kxREhFc0RkVk9S?=
 =?utf-8?B?NVJEd1ZkSnVkeCtNUFg3ZWxib1AvaW1qTXF4aTgxSU4zVExNTEo1WnNXcDNT?=
 =?utf-8?B?alRkKzVLYVhTYjZ6M1g2cGhLRDFYcjFBNTdYNDNBTmh6RjhOY2xGSDFFU29Z?=
 =?utf-8?B?bkRtU3hrWG9VaHVzOTRWMlhzMEl0dTQwQXBYMGtTOExDd056ank1YWVOaGhp?=
 =?utf-8?B?SjJ4Tk0xNnRRM3NBeFJFR1lUZFBjbXlyQWszRVlFNG5DdnBmOFZlRDhqaVdU?=
 =?utf-8?B?Q010UkVzUTJMaStPSFFQNTFseXpiY1hLRVdWSEZSZkp5d2VUaEcrSktmZUdu?=
 =?utf-8?B?YUVId1J1SldEaUp3c0xtZzBCMVRGV3h2Mkc5Q2hyZlJKV1lSYldRUlltSjNn?=
 =?utf-8?B?bDVsNWhsNHhzbjUwREt4Y1NBK3FPY0NXRXdveHFSN1NRSTI0bEhsdlJhSnpJ?=
 =?utf-8?B?MVg2SkI0Z21xL2ROVm50b0JJSjNuY3oyMmxJbmhlNEptWmtuWmE3allWN3RX?=
 =?utf-8?B?eTZPcFBoY3YwR21tRHV4dE52SmVMRUd6QnFibVJIaWFqWkY2blRlSXNVN1M2?=
 =?utf-8?B?MklaZjMwRjlJU0dyaVdjY1p6TVNnMXNKbVRkOFVvME5oNzNPZ3ZCeWExMnhj?=
 =?utf-8?B?ZnNUYUlDS1JlN2VzZC9jRXVXVmJnYkQvcVRQVENjdG0rcGZZaUJER0QrTUZG?=
 =?utf-8?B?aldwSklnSkNaVnNkL3R1V3R2SVBJNGdyd1h1cXJRNytXenFFSURBTm1NNDdi?=
 =?utf-8?B?M0svckVtTElKQ1BKUjZVVkk2czNUb0RaQUgvdWlteGhUek4rTi9jWDJVY1Nl?=
 =?utf-8?B?Mk1vdVpJVS9mNVRLMlR1M2laVWNSdm1GWTZ5R3o1dnhOTVA3cnp0YTliZlBC?=
 =?utf-8?B?bi9KbWYrbkNzOFFWUGtzam5GelZpV3dlTzZGY2s0enRaYkVPTEZOTXNzdk8x?=
 =?utf-8?B?cEZIc1gwNnFMVmhYTGU5cjJIODlXSGdYZVlBK2Z5QnVodVpmWnhQb2U1Mk5q?=
 =?utf-8?B?UFZzVmdLWmJEQ2VJcEI4ejNJMndDdGJiWWR5Rmdsd0tpR00zcGpjemFkOHRm?=
 =?utf-8?B?Snl2UUtqeUZHNXl2ZzIxVXVCdmJsMW13Nkw4OWV1NUpvdjlubXU3YTlmTDFC?=
 =?utf-8?B?NE91bVJLbEI3YXBFUGMzcHBsQldpMEc4U1hDR0x3bndUc1diMng4ZlNHRXJl?=
 =?utf-8?B?c0xtOHQ4RnZVVUZKYzNlSEZyM0hRVG5XYmsyTGhzdGQxSjByRFdIMlJwWm9F?=
 =?utf-8?B?YVYxcCtyTVduaE9iZGxkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akkrNHFCaWFzQ0hlNjhwQUNwVXAwWS9RT1ZTSDNzbGJRMzc5WXFyUkdtSG51?=
 =?utf-8?B?RFl0dEZ1di8ycTJKc3g5cjlrQ3FPS3d1TWIxMUdXMWhnaTMyNHBrdGtwMFZt?=
 =?utf-8?B?ZkNNby9HQWx6blZmZERWc1NFVUJVR3lIajloK2hKM0c5UDY0aUN1TklBMkQz?=
 =?utf-8?B?T25KdXhzUUdVSzlMWG0wNWVPVXZSWlFQMFdaU0gzaWtpWkVYK01XYS9TM0VH?=
 =?utf-8?B?WVAxUXl5TUtBNWxubGIzMGhyZXF0RzAxWlFsY3BEUnZwSWFGOWJoQmJYK0pj?=
 =?utf-8?B?cFFWdWQwd25mWWdrL2lRZzZXY2c1VGQ3QzJaejA5UWNJQ2p0N1BoOExBWWJY?=
 =?utf-8?B?UjF3WnhFMmtCS1FEZDYwTjh4WGg5UVMzRzViOUtOMHcwVkpWb0pXSlhuQVZq?=
 =?utf-8?B?T1VJWW45eEZBY09RSlJ2Vm5MZk4xajNQaXNQc3Mvbm9BeVZNNUNURVhpaUxU?=
 =?utf-8?B?NFg5VWtMeFMrVllJVWs1TEVZSTZUYU5uMk5CK1MzbElUZDk3TkQ0RnRuOXpV?=
 =?utf-8?B?ZHVHSUpGaE03MEtGVHhOWHI3c2ZPNWhHaklzK2lBS1h6V25Fb09GdFZhZFVM?=
 =?utf-8?B?SWRpcUZoblgvZDEvY2RGaDc0Q0hZKzhQS01pVWlqdFJ2RUV3dzRJOFhRcFVx?=
 =?utf-8?B?VzNjelljRFFlaGRnVGpwNEd5MGpYeGNNdUo3OE1Gd3N1RmV1SHNNeGxwWUhx?=
 =?utf-8?B?VkdEVW44dGJDclpBUjdIK0s2VmFmcHIvbEt6ZlNyVFVEanlxWGxqWE93L0NJ?=
 =?utf-8?B?OVZPL3AwdzRMWklVZ0h0ZGNJVHR3VzRZdkJZTUNEUmZnakg5WkJsUjljaEV1?=
 =?utf-8?B?V0E0SERhNW9ZZFpwQ0RRVWJCS0R2QmNMUEVZR3dWNTlmWUZmVHlrQmxXdVNy?=
 =?utf-8?B?Z1FGSGl4OFZhS0NnN2ttSFlZRlpyS2JvRC9nL0xmenhaNjIvSmVVVjNxUjB2?=
 =?utf-8?B?dWNxdnBnY2VTeDJkdS93QnlVdjN1Yk4yOVRuS0VuVDFEYmtrYTdDVFVna3hF?=
 =?utf-8?B?MHh0emVaZ052aXkvVFFoOVh0Qk5SWU1kZTlHaXdWbDdmVW5rNzVhdGc1cjJ1?=
 =?utf-8?B?TEhsR2VsZjBqWEI2SmJ1T0VvdEJpVjhaWmowMXliQ1ArU09WR01OWEpEcDFo?=
 =?utf-8?B?bjhKL1EvQ1NJbUppRE1CcHViai9XbHFxVDVuL3Q5THAxL1ZVVmxFNmR1Tm1a?=
 =?utf-8?B?bzNpYVhGRWd5Y2dPNU5IdWF3U2F3NW1xMkpvS2hIczdXVm90L3RsTm5id01n?=
 =?utf-8?B?ZWdYS0RWdlJvWWhNWDc3Z0FZMTNscEN3RkhzbWRsdkc5U05LOWRKZGZ2Y0s3?=
 =?utf-8?B?M0N3VFFtUVdnUGIySytJbGRDS2lRa1JidUs2bVZhYTQ3SEJUM2NNMDd2MW1V?=
 =?utf-8?B?cDBjRm4ySU4xZ0lsbGlyNzg5KzFzVlRvaDRxeURkVWxBL29RQUpTempWVmh0?=
 =?utf-8?B?d0tBUmpDbkovblNrVDBIdHNMNUUzL256VExkUmR3enJwODlMVWhUUUxISUxm?=
 =?utf-8?B?WXV0S3RLTjF5UUJka1ovL1R4bTQ3WkVVQVRVWlE0akNDdkd0STBucDhaU0pM?=
 =?utf-8?B?aTNXYnBkd1ZQaitQV0FZVGk1blI5NXFNNWdtT2JRRCtCNGtpYnhlUlN0S3Zw?=
 =?utf-8?B?V3h2RzBuMVMzMjdJVXJuRkcyUndyZGtmL3VoTzVUSURRdldhSFR6YlhtdmNz?=
 =?utf-8?B?bk5kUTVBak5xb0l1T0tVTWxna1NUS21hMEIzSS9uT01oS0U1bEVHWHNCcUZ1?=
 =?utf-8?B?cnJIN08vZjNlZ1FkRklYeEJIbkVTclR2VFdSM0YxYmIwTFNySVI5ZTNwOE9r?=
 =?utf-8?B?SjhGakx5dkJleHdVOVlSY2Jkb2lIQWdlNTJXT2RZNEdTVHo4MndXR2hwQ0Vt?=
 =?utf-8?B?MDZ5QnZROHdUcGFqblZzR09EeFF5YkxJelRmcGlESXN3a1N6TGZEVUMzb0hQ?=
 =?utf-8?B?WVd0TjhKUkxVbld5OTZ6MFJwc3Z1T1ZJWElXS3VQbGhibG5WTkJaSnRqRE5t?=
 =?utf-8?B?SmM0M0lPbkVxbFVxbjZ2R092S3JyQ1N0SzZPSUxaWkxsMS9EZ01OZUU0WkZs?=
 =?utf-8?B?N1I3d25hdWR2VnFWSDI2UnJVYjlMakI3M3dZZWFLeVdGSXB3cUU2V2greUto?=
 =?utf-8?Q?v+34=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e6ad62-c630-42fb-0e7c-08dca7fef241
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:27:40.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GRUdQPVa7azD5oN4gfLsoI903scEdCrMlSwnPHPboY3X7RSNN1vKqGKrDkrAQO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7406

On 7/19/2024 10:09 AM, David Howells wrote:
> When a subrequest is marked for needing retry, netfs will call
> cifs_prepare_write() which will make cifs repick the server for the op
> before renegotiating credits; it then calls cifs_issue_write() which
> invokes smb2_async_writev() - which re-repicks the server.
> 
> If a different server is then selected, this causes the increment of
> server->in_flight to happen against one record and the decrement to happen
> against another, leading to misaccounting.
> 
> Fix this by just removing the repick code in smb2_async_writev().  As this
> is only called from netfslib-driven code, cifs_prepare_write() should
> always have been called first, and so server should never be NULL and the
> preparatory step is repeated in the event that we do a retry.
> 
> The problem manifests as a warning looking something like:
> 
>   WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_credits+0x3f0/0x9e0 [cifs]
>   ...
>   RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
>   ...
>    smb2_writev_callback+0x334/0x560 [cifs]
>    cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
>    kthread+0x187/0x1d0
>    ret_from_fork+0x34/0x60
>    ret_from_fork_asm+0x1a/0x30
> 
> Which may be triggered by a number of different xfstests running against an
> Azure server in multichannel mode.  generic/249 seems the most repeatable,
> but generic/215, generic/249 and generic/308 may also show it.

Nice fix, and good explanation. So, is this the negative-credits issue
we've been looking to fix? Or just one instance?

I'm very curious why it manifested when testing with Azure Files. Do
connection errors disappear with the fix, or do they still occur but
are now recoverable?

Feel free to add...

Acked-by: Tom Talpey <tom@talpey.com>

Tom.

> Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
> Reported-by: Steve French <sfrench@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Aurelien Aptel <aaptel@suse.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smb2pdu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 2ae2dbb6202b..bb84a89e5905 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4859,9 +4859,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
>   	struct cifs_io_parms *io_parms = NULL;
>   	int credit_request;
>   
> -	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
> -		server = wdata->server = cifs_pick_channel(tcon->ses);
> -
>   	/*
>   	 * in future we may get cifs_io_parms passed in from the caller,
>   	 * but for now we construct it here...
> 
> 
> 

