Return-Path: <linux-fsdevel+bounces-56779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B5B1B860
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8457AB852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490D292B4B;
	Tue,  5 Aug 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CVnGMI91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012032.outbound.protection.outlook.com [40.107.75.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B7291C3E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410888; cv=fail; b=E0PQF0SUzXgDMyWQdt7hnnmuThknkFXaSJ53EHKPDLtgY0GAvM9q8turOJBm4hyiqiMvHjEsQ1JGIizXF61XwM4ISRtjE+rm0Mkz9ZqRXmrpNEgALvUtGiRvjDcdxacms09BtGGhszT908+7C17sExVKd67CrXE6xHwyZi9TkvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410888; c=relaxed/simple;
	bh=/RSjEKPKz8zzS0InvbR73sUeQzYgBgvatte8K7MVc6Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XE4TRmjG1XPvO0WA+LEZrcama8Hvl7PjxyytJQHT2pi2TenPFoTv3bZe7y6jnuOaGLLxSbQRiVp3zlyY9CVOyrpFMrwEsbaB4nDnudHl8ywHyHEHVWSo6I0beZMy0EHpnBX0Tn+eWD2wroTvexRVd1F+CZPDJY7BCrcxh7Pwf4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CVnGMI91; arc=fail smtp.client-ip=40.107.75.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXTqHMFdFxEXLssuS/vO/HmRolNtg5Xq/SdoT1pUUzjqjfziPhkJWmXzdC44QsdnZ5GBuvilit5ihJ/fXJKpY2tEtPZjkN3qA7lvZ1vZelStiZOjHrwaAYPq9aAlrQBxVNgfhxxFU47JhMz+fimhB2Uq4Xy5breKD++XpfHU1dYQ6ITOTCi3eGcEQTsRGuXPksoV0PHvYJRo4N1MDncsPXlGy3zcDBLVD7HEoIwqwgL8+4DBQ2yMi+iCVDavXkzpAtZtqGL6/iUd31qKQzBH/kcza8RdqwO4hyNw6dARejmoD0ZJ1lEZPqPSzYYOq2WBa+TgXfeZjgi39PF/knSpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI2FqMWK1X5Civd2kPHqZbC5k+Uhk7N8vp8lHVRKHsg=;
 b=xpGWRg3bNyc/oPouwX0Rt0A40QoivVc6epPOg0cYxAJNvPpAvlZxHDfFN8lku5ldNZjY2/Gb1m+9LPLn1D6UjVkg72zhBqwQhHfaXZMBqC+I3BidEEhkkn19M8XISH4lgr7KHsWCKH1/Gn7XcTfPfuR+0xmWL9aOIOgIlRLk3e3d0nSrIzpQXPzE5/MiyyA5qEfHaa0kau+a0l+Fe4tFIHqxmMiQTy7HlZ6mhGTN+VMYIpCWhARuiBxekj/SgSX5HgeLBfHE6r1FHdCm/k8gthWngkvDozyb/I3E6R51Jll2rEbXEwb/XTyzYTOboPI0I4BbGTMMJpd2c2yqkvChhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI2FqMWK1X5Civd2kPHqZbC5k+Uhk7N8vp8lHVRKHsg=;
 b=CVnGMI91I4ySeqUnm7UAaIzZNtQ+cGbjrQYX69KedbwQsxTxL5RWGzv8NSv1mkgC/LoDVtVcsbfsHksfpeolAr+C+EXi7paIj06lpWZYUksFTyUzfGA8gGsB8ppSUj1EXR7pAhUpOPJ13evqg1sZfIlyQ3DuiulDNiF0VyPIvzxCRtSkLXweLDGT5BdKJPvxfv05UJ21jUoUYgc3jboIheNQR2yw4J1ZVgz662ghVCNc0F8wmJ7MDDkWEascqvzu2J5LZvK+Oz4hTuCV/2WWVhqyEqp2bAjESaqhUEX60dOfR6FyQIauvKbWJdPQri1RkjJkRB7+KlkObenFZjLNaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6908.apcprd06.prod.outlook.com (2603:1096:820:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 16:21:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 16:21:23 +0000
Message-ID: <897a4ae6-77a8-453c-a5a8-d143959b1a94@vivo.com>
Date: Wed, 6 Aug 2025 00:21:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: fix KMSAN: uninit-value in hfsplus_lookup()
From: Yangtao Li <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
 syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
References: <20250804195058.2327861-1-slava@dubeyko.com>
 <894eb3d4-b7eb-474e-ae4d-457a099deb76@vivo.com>
In-Reply-To: <894eb3d4-b7eb-474e-ae4d-457a099deb76@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 23adefc9-be3c-4c84-705f-08ddd43c1e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFdnbHJnWlNrVFpNOGVXUDRWT1JwTEtzS0pmMnoveDNkVW5oQ09FMFhqMUhW?=
 =?utf-8?B?dDlCUzJBSWRXQWNiMGI3MjA5Z2Q2YTYvMG13dGlmV3F0YzlpWFBuRWdEd2dn?=
 =?utf-8?B?a3pLYTFGUExVL3Z6SVVBSWRBZWh4bE1ESnR2K3diUmQzRVRISlBhdDFLUUNW?=
 =?utf-8?B?QWRRUDMxZDdQTm1ITllpKzcvdGYxVkNkdFlXMHFpUzU4MzluZzZ5Y2tYbUZn?=
 =?utf-8?B?V3FiYWVYY2trcTNqRGhKdFczUGdtbkVpaXRMVDAxbmN3S2hFVWFnZ2Ztbmhl?=
 =?utf-8?B?SjhIVnhlNFZXckhxSEVBU3ordG1rM0pwaEZ0N3k1L0xmUUExU1FMRmtEQ1FX?=
 =?utf-8?B?UEFyQUQvVmdBc0haeWFhS29PNHgzSzVIYnpiajlwaFZRVFg2VndIc1NXRHpP?=
 =?utf-8?B?R0F6cGF2WVRPanBkRS96Z2dXOWsvRW5VejFadDdqYm44ZUZQaUtVWnM3N0l0?=
 =?utf-8?B?RnNRYStJUEZpZTdLNnlzMFVzQSt2NWdqN203VzAvcTNoYy94YUwvOTk3R3NJ?=
 =?utf-8?B?bzRXZ2NDNThabUtWbnB0c3hrOEFsSHlMN2tPL0tmN3N5TExYMDVqaFNlV1Fj?=
 =?utf-8?B?MTB5YlRwVmkzaHVqTDdXamRGa2tCYk5WNEU5N3JCc3VXc3pKQ2syS1Z4NXo1?=
 =?utf-8?B?ZHFydTVRVllrUDJJSE81T3pMTzJCTUMzZUppRHVKWVlIODBxK2lnN3k4K1ZH?=
 =?utf-8?B?RmNNQ29TeXFUZDVEcTAydjNxdXQ3VXNXS0NWSFY0VVRySDdRdlBlb1Nob1Nw?=
 =?utf-8?B?azRUcSs5MXREbjl1dENxMTZ2OUh1N1RvcVFTZzhSY0xVMU8xLzVxTTgvQXU5?=
 =?utf-8?B?SS9aU0YrNG41UWpMYjlOdkJnL1VobkpZK1lXelVOUVdHMGg2N3JqSUE5VUdT?=
 =?utf-8?B?SThvTDhjMDR5eFJnYm1qZ2V6YnNCT2M3WDJ3SzFOSFBIMXBmbnB0bVhhd1gx?=
 =?utf-8?B?M2Fmc2VSek5Eb3JvVGF5RVhvYXhESHhTS0pZQ1RHUDhRVmVXRmF3MTVtdzNu?=
 =?utf-8?B?NjNVUGlMbEJ4Y1JDemc3eFM4ajRxSVF5QzhSU0RHaGFZamZLTTlKaXZqTjQx?=
 =?utf-8?B?ZDZlOUlZTE5zSUlFM1JOU0VwM1pKTDNHZlZvNFdCTDVCbTIvK1lDcitueFoy?=
 =?utf-8?B?VFJocm1pQndSdGpnV1pYVFhEOVFyN0gvRVVqaUNvSEVuRS9QN2RsN2E0cUcx?=
 =?utf-8?B?VmtteHN4VFZhZkN4MmFGSHFtWHZpYlR4b01vUGE1OE5jQUZ0SXlUS2U0b203?=
 =?utf-8?B?SHl4Tjk5cFZkVFFpaDFzZmhkZXdzR2NndkZseUFXc1RhYkl0RUx2VWpzK2lt?=
 =?utf-8?B?V1V4MkJsbHZNZ1lTVGVGUldqblp4VXlWdVoyaEQvcTV6Vk1kM1Q3N1ppRlBY?=
 =?utf-8?B?cm9UMHdjUE1MeklIS3JKaTkxOEdETVFIREpYeHBYZDNPcHp5V2h2clArVGdl?=
 =?utf-8?B?R1lRdmRibjRlNmw0NlFKcnV3SUNDR1VUUjVkWm04VUYzZFJxLzhmWElUUzN4?=
 =?utf-8?B?SUFEenNrbnkydnF2dFU5TnRxdFEyWm14a2hFbFJaMnFkM0YvRG9RUG5SZmdn?=
 =?utf-8?B?RDk2ektqMzBrZkVKN2ZGdjJxbGRpRy81d3BmNzMzWnV1SnBjQ1YzVlpaa29x?=
 =?utf-8?B?VnZZM1Q5L0gwM1ZMM0xGa3pvL1crTWdUS3ZtaXZVNGFjVy9JcUtQQXRoZkov?=
 =?utf-8?B?YUx5RXFJSG1PSXZyY1NNb2I0aDJGZXM2UGNIZGNqbW11UUpWOGI0RUd6bE55?=
 =?utf-8?B?Qmdsc1hDL2VWZy9lVVo2RVk2T0ZkWFczcU5XbFlMbnJiMWtzUm5SYmVSV0ht?=
 =?utf-8?B?andteE5vRi8wQ0ZNUmpocVJ6YU9LYUU2QWNkS3ZRc0RtcFBrcXJ2UnNveGQ4?=
 =?utf-8?B?S1NQaG5uQTdGeHA0UlZRcmUyYXA1c3lVQ3NMbEtyWlZuVTdPcklIRk9taXRu?=
 =?utf-8?Q?ilGk95JSXfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFp0SnErZW9ZYVNnNHpBTjZmbnVVbnZ2ck1NSG9oS3NmRi80MW82RVk4NmJI?=
 =?utf-8?B?TzZoWDhINGN3d0tWblI5V0hqYVFGQ2JOUEF2TENET3JjeUFTMnh1cWlZNlVy?=
 =?utf-8?B?aHBBN0Z1ZkM3V3hKdUQ4N2sxMFk3aGN6UHo4elJyRnhPUWZuNCtTbnVxVlVY?=
 =?utf-8?B?WVZaQ3hXcTdVa0JLV08rWmVBMWJVS0FWVHhCMGl1SDlrMXpWU21sa05CYURk?=
 =?utf-8?B?SmxGOURrM1o1RmVzNmZhTEQvUFpqY1VRbG1JT1BzOHJad1FUcjEzbnMyTm5s?=
 =?utf-8?B?SVUrQ3BjanVITlc2aVhya3FWUG1mcTNid2hTVDRmUC83d2RIMTdKbzhZY0lG?=
 =?utf-8?B?WjVmRTRjN1AvOEhiQmpPOUJyc3htREVmY3lodU5uZ0gzRWRXblRMeUtsa21Y?=
 =?utf-8?B?cnVJem05cVhUUjVmeU1zUHI5OHNldmNsTyt1dE1hbzg4NmhnaFFjQWJudW5i?=
 =?utf-8?B?MnFBY0RuSFViSDVVYnA1ZERTbkpiNTFxdmlDT2xUcTcrT1pFSmJtRlYwZkR0?=
 =?utf-8?B?NnVUZEhPZUJIT05BMnBVZldJZHBYeGxVMG80NCsveTNXb1EvbllERlhQblM5?=
 =?utf-8?B?MGtyQndJTG9wL2tFcDNINm0zM05XY0NvWWhpWit0UENmVEhaNUdxZ2x4RXdK?=
 =?utf-8?B?MFFWb0QyT2xCb2xrTHNDUUdPS2hvK1FST0lxTkRTS2xuTzVSZno0KytHcFQ4?=
 =?utf-8?B?REdUenRpTmh0TUgzSUd3UnNCU0UwVXltUmF3Qlo2NmpqUXZBeUowaGNQaHUz?=
 =?utf-8?B?RWFERUF0WGQzZEZNRzl4RTA1ZEJlZUVScUUwc1ZLKzA2NDE1dVU5RGJ1M3ZH?=
 =?utf-8?B?d3k0MmFCYjkwUjcwaFAweEJUZjJYMXI5QWhjTkZRSExKMzNTeFNYTm1HQkJn?=
 =?utf-8?B?cFYra2NTM1I3UUdQQWdvZlFsYmk0UmQ2TzRXR2FzUy9sN0N6cDRXRlV2bFlR?=
 =?utf-8?B?Q1NCMkZsQ3Y5MUFwQm16RGlrYmI3Vk52bFJzbXpCcUpuOTk2M0U0elRydC9I?=
 =?utf-8?B?ODJpVElmS2ErOGwyQlR5NHR5cWNuNmNaQWhyUjZFSFJYeHo4bjhCNlFaVDhw?=
 =?utf-8?B?NjVhRWk3YkMyV0VFV05PWm1tZWVVeTNNSzBzSmlZZlFyWUltSllFYXpXZmpu?=
 =?utf-8?B?YU42V2ZyNTUvL21sV1ZFbHZqaUNLZzVKOGFuVFFMRXlCMlBVN25URk5rYzNp?=
 =?utf-8?B?UkZsZjhjUGVyOWtjZFFoYW9aTmp0SnlNb0kzd0RZZkJKTWFjUlRQS0Zmamdr?=
 =?utf-8?B?ekJKOEhwaG1wdkdlMFFsWm9CUkdiRHYvREZHTmlhdTRSZEpqUXRJYW8rOGc3?=
 =?utf-8?B?cG1IVXdTdUtja1prcDZhQ1FqaFRqSWFCMjlqUUVrcjU4V1M0cGRyMFYzZDlW?=
 =?utf-8?B?ejNpN3VTNWcwZ1B5a3k1UFlGcnhFcGdONGtzV2YwQnl3OUg4OTV4NytzOVY1?=
 =?utf-8?B?SndTWGVTNTlsYm1obkpaSWlIamZVQzNpWGE4MGVVM0QwRWxXejd0OTkvWlB5?=
 =?utf-8?B?TVdjU2xjUVRGMms1N0JPSWNvekRKZFdKSFJ5ZWdQa0xNbWNIRWFWWTdwbSt5?=
 =?utf-8?B?cnJmcWxTcFJpajBjVVJFR05VZmZtVWp3cWZDYy9TZ0ZYT0hhbnd2WlVJSVZO?=
 =?utf-8?B?MG85dFpBaGVFMFJQMEh5dmoxQWp0RytqY0dsM2xWalRrWFdxL3MvcTNweWRF?=
 =?utf-8?B?aDJ4dW9WR3M2Y0hiaFpTUFdrTFZ3eGczYlowVlYwRFYydFhkK0JzZ1VCTDI1?=
 =?utf-8?B?aWo0bS9YcU1VNWVuU3FaSHlvOXhqWFJ1Q05PMHZJdjRJb3BkbVJoQlBrcXhE?=
 =?utf-8?B?bWJaUC9PRXdUQ3pqdTg4ZHAyTkl0U3VFQStlNUNnd2tZZFhBNFVqK3ZUVU4x?=
 =?utf-8?B?aWxHcEtldU4xRGhzQ0FjcjQyQ3JyMTROSTJET1ovaFQrTjVnQ0JGZjFGelB0?=
 =?utf-8?B?Vkl5d25Ydi9ocFNKTGZQdTEveTlmY1dGRlRJL1pDdFFXYmtUMlgySGhGNnB5?=
 =?utf-8?B?dThrUklDQy91OTNOazdhbWl4UnVhZDN4L2JGT1o5SHdaZlZlTHAvZmNyMjV3?=
 =?utf-8?B?dEpWbUh2eVdwQWx6dHk2a3I1NXc0Y3cvTTdnbW5MSCtRNWlQUXZRcUx1bDgy?=
 =?utf-8?Q?Uyj7vb1bkGEs6DnUH/nZ5VM+A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23adefc9-be3c-4c84-705f-08ddd43c1e66
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:21:23.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo01SGSL9/daiXwcrFRv2o9wHAxklNEfNgyEDerR99IkhWdT36J97uRlX1yDxQUbygHVWwJxi+vRTqGci/OkSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6908

> Reviewed-by: Yangtao Li <frank.li <http://frank.li/>@vivo.com 
> <http://vivo.com/>> 

Reviewed-by: Yangtao Li <frank.li@vivo.com>



