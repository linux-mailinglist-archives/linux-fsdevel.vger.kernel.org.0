Return-Path: <linux-fsdevel+bounces-19561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C18C70F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 06:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213BD1F24016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 04:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706011CA0;
	Thu, 16 May 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuni.fi header.i=@tuni.fi header.b="eLIkzt8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2095.outbound.protection.outlook.com [40.107.8.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F5E57B;
	Thu, 16 May 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833991; cv=fail; b=ScH0Q2/W5nBnvaGFD3gusoR0W0TKd6vM6pVTUUG9NSxvWKBACVs7ONpgiss3bpifKUk3qgE/8nEPZr6ACbo2ryKbYieEIyHQjPvR27mXO50c0ZtlygHsY9AcVy9iSSn46iXOZ9qTqgyeOqyWp/7Sd4YRTzJmOsRf/dXvdYt2or0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833991; c=relaxed/simple;
	bh=cBQv7zMziWz1JjaCb2khEMCRS4itLvx4pQAqftWrKIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmbMIXf5X+lWzsjf/YMB3l/4ToHqKXJTz1PoORjUyDyVVg7IeldUKKpRuSY83dt9nofXFA5KwVJXCu4mgXZfHiyhyO4yfAUb/vh42PEcaQFwZfBvbnumcMB6Qoidz2sE4ObhJML54X5wINqGRbVnE8mqPjQcp4WiYUn62LL/iTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuni.fi; spf=pass smtp.mailfrom=tuni.fi; dkim=pass (1024-bit key) header.d=tuni.fi header.i=@tuni.fi header.b=eLIkzt8h; arc=fail smtp.client-ip=40.107.8.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuni.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuni.fi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrpC7EHnIB5j6olUk4AU8GFcXjJdGYD+kJjOQMLVSYz1oohRuHjzDFiDr0LJ5AAFis2DxdXkL8CxzIEzmlTzLYPR2onao+6NIgIJ+A1OGN9c4tC3UIjNIvUVT7hS4Ppsmc0t53GaxJQFUv3Apu9BMKRlyjVD+goOaHsbjl/mtuoDv61SfQiPhAjX8Np8BnEZKpSbAgDynRG9ofr70YgArTOvLX5t28Gf2qzfKeCziZXkWHbRDVw9GhxiZhEXLkQx+UbbB9016+etzbNPASdZcTK+3IfRqcf0NpO13XBOD+XLrB6xhalUvWzx6p0JjNqU5vwCOmPJCPFvgEu8eMN2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVxsqWgN0Tc+4ruIdlyMBWsa9RbCPPJMD/QUO1UXeqo=;
 b=dg7U7A2XaRLQ0viwUsrp4CRtxct6V/T3BNbPyJgQRQUuMHazhMuHDYSZXJZYjfSAgpJaH3IbcoCH6ExUftxEMXiZ4bih4aJ+yZlp6mk16sR5EgWBO7wsvnTyWkQ6xGq17IjuCbcIpU27OQKVT1lS9gl91aYWr4/KXcI2ngOfWp+s1NZEghDmgVIHU4nmP2Mo7sSThU1ZIiIdrA0G7nX/hnvBxOesBA8LNGIo8M3eZJ3sxwqVvxl3sqzn47N3NmlgSnYCYVtWEOoX1D3Be+kP5I6BGXwexUO4q06PLKk3Ags1vio5sb+fxVwj2bphRAUCRN3alhtNQaljN9YDkolU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuni.fi; dmarc=pass action=none header.from=tuni.fi; dkim=pass
 header.d=tuni.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuni.fi; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVxsqWgN0Tc+4ruIdlyMBWsa9RbCPPJMD/QUO1UXeqo=;
 b=eLIkzt8h01nCxyWTTwA7HWzAwHgn1sL/7hY8hw4ETP6VdoTu9dGNcvzhGMooKzxMnJUftuydmJiUXjpiX/yd82UY60a4M6NF4DvBb1kEQGkycVUMeWraj4wkARDpDTgMNGI33/PBvdgUshWQwXD564uOwMOQceEDYpAU1YI7d0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuni.fi;
Received: from AM0PR08MB4019.eurprd08.prod.outlook.com (2603:10a6:208:128::20)
 by AS2PR08MB8501.eurprd08.prod.outlook.com (2603:10a6:20b:55c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 04:33:04 +0000
Received: from AM0PR08MB4019.eurprd08.prod.outlook.com
 ([fe80::56ad:d730:545a:9a57]) by AM0PR08MB4019.eurprd08.prod.outlook.com
 ([fe80::56ad:d730:545a:9a57%4]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 04:33:04 +0000
Message-ID: <59ed566a-3331-46c5-b24e-16d321fe7e80@tuni.fi>
Date: Thu, 16 May 2024 07:33:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel panic in 6.9.0 after changes in kernel/power/swap.c
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Power Management <linux-pm@vger.kernel.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>
References: <ZkVvuKHV-jdOMnB1@archie.me>
From: Petri Kaukasoina <petri.kaukasoina@tuni.fi>
In-Reply-To: <ZkVvuKHV-jdOMnB1@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0000367E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::39e) To AM0PR08MB4019.eurprd08.prod.outlook.com
 (2603:10a6:208:128::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4019:EE_|AS2PR08MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e9e70-5f05-4d80-2ba3-08dc756146df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sjlpbzg4aXppMUJ6czVxTllKYnpjanZOUzBJTTRIN1NYTmlGNVhqNU9BT2Rr?=
 =?utf-8?B?VHZ6ZnNKZXNCMHNqZ08yY1RhVUd1K0pWNXdLRjBWWWNIMUV5d1FseDFQdjBn?=
 =?utf-8?B?R0luY2FkczUraHU4WUNnYjN3cmhZZ3RqUUlUVGd2ZGYrc0tkeEQ3TmlaaHAv?=
 =?utf-8?B?a3M3V1Z5R25jeU5VQ3JFQ0I0dzU1dWN3eUIzRTJoQ3NuUUZsQk1LaWFGUFlr?=
 =?utf-8?B?WTJ2MWNzNk1mYmNMbzErL2J0Zlp4RzBuL25GWDF1dkV6NmZtSnN5YVVncTUz?=
 =?utf-8?B?N2VORmx2ZC9FL28yV0lONk1VQnBTK1FiclN1dGw2aUFhaDF0L0w2bEV6NjBT?=
 =?utf-8?B?bFlPTHFWV3ZuakZZNVFKbUFMQUNiNFJZbUpSMWViQkFMK1ZZRkI2eHBLTkhh?=
 =?utf-8?B?NzlQOHhiV3RLSTU1WlNiL2YyeGdDSFlXdXdrOG8vcFN2N093WmVPWHJTWlUx?=
 =?utf-8?B?Z3h2ZndoUi9teHBDcERtelhhRjRGRGlqUytOSmxiRzFKR0N4OFpUMHQzZUNJ?=
 =?utf-8?B?NlFzdUxjemdjb3pxNlpMalhEWWloK3NyUW9vbWJiUkNWMURZZzdGck9wQXdR?=
 =?utf-8?B?SDIwV01TVXBIQ1cxMUdXYVpwb3pkRG1QeFZ0SnE1V21LbGs0YjFCVXBvWjJy?=
 =?utf-8?B?ejI2TzdCWTVPSnBoUDhLY3R3TFU2YUhxZFkxUDJMdWxlUG1iMVRJaGg5cGdT?=
 =?utf-8?B?SHlRejFyU3VHUHFNaVk0bVdPNzh0anFCTS9TU2Z3T3l5Q0tLRGI3Q0lqeFBR?=
 =?utf-8?B?MHhwVXNGQjJQSzdFYTYyMFh0dk9JU0twZmxqSU40cXNMSkNzVVhvT2xOQUJo?=
 =?utf-8?B?TnRUS29jVWpLTlVSSGRQOUJvd2xWUFgzaHVHdTlhYWZXdVU4QTgwWDZoM3pL?=
 =?utf-8?B?dXJyeS91SWxONkVUTnE2RWVSZXZyVDNaaVRyUHZibFNlMXJXL25tUFg0MEdn?=
 =?utf-8?B?Mk9SU04waEZPRmNtaHdWcmxaOURWV3JKdmNPcFlpTkVGejA0RTJQTWpjV1JY?=
 =?utf-8?B?KytOZk1NWlVZa1J1NTUwWUZBcUREc2cxbEVCelJvQThkM01tNHNia0lnRTVO?=
 =?utf-8?B?YjNBQkhqUjlqOFlzWWl1ZnV4WXJPRk9OYTl4SDBNdkY3SFlSeHhGTEVUTzk1?=
 =?utf-8?B?OVNLTGFiTXBubW41NU1CaHAvcDNBMG8wMVg5NHMzdzQrQjBnTldWUS81KzVh?=
 =?utf-8?B?dnI4QllZQUM2Z0kyemNqNllxRmhmejlydUp5RHFsMzd5Ky8wOSt6eVV2Nno5?=
 =?utf-8?B?WHpnTCtpMjZ6MTNrV3RSZnBReEM2NVdlSDRkWHpiRHR2bE9HbG16YjhSQjhC?=
 =?utf-8?B?WlFZeSttNHVVOWxPZ0FMYmRpK1ZPdUU4ajBOcjlaNEErVjcyOFlDeEl2ZzBQ?=
 =?utf-8?B?QWM4NURTM1FLdHJMc2VkS01MMWZqelVXNC8xQzA0NVgwR0lRMFJCYkM3M0Ji?=
 =?utf-8?B?azF2L2t1YWZSSjJOV0xVVW5aK0duRmFMZlBiQi90ekluRU5FWWF3dXQ0UjV5?=
 =?utf-8?B?NHdCOFllekpsT3FZdTNhMEowVUx5NG80Smh0Wko5a1ViK0Y0Rm9iaWNLR3J2?=
 =?utf-8?B?M2FldXNiQVJpdDNjU29WT0hiWnQrWm1KOEFibTY0WjY5OXJBZVdPakNPLzU2?=
 =?utf-8?Q?SAGgnc6zog5HasEJAVwsJDKEK6fkBfEARksienwohjoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4019.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3BuZEtqYzlsSndNclRrSHUxU0c3VnpTMXlNcVJzM1lEZ3l6eXMwR2twQU9q?=
 =?utf-8?B?VS9Cb3dkT1BVSW8vL3VjaU1SbGpBa1FqNTBBL3FFSWlsL1NYYjFTbVhuSW4r?=
 =?utf-8?B?VWRYY3pNcHRWUVUxN0szNTZ5TWM1REVDRTRTMkVBTGJPZ09uZ2NIZGxqSXov?=
 =?utf-8?B?MWpNM0hJdC94Y1NpM2hxMUtNRHRFeHNVN3FKd1RHVTRUVDl5K1MvQVB5QWVM?=
 =?utf-8?B?NnhjN24ydEdJRHlIaDJOcHRkTEljWG1Rd0VHeEFpNTJIMFBOZGcrd3A2a1V0?=
 =?utf-8?B?YU5HSC9nMGFsaElrUWVNQWV1ZFhEMDNnSW82ZHRoWUtrVWUrL0o3VDNMRkRm?=
 =?utf-8?B?QzlGVGhYL2VTam41djhCandNRmpFanRYZnJsdFduZlMxSEs4Z2dlVlhqZUtp?=
 =?utf-8?B?S3FWYzlhek5oMERQUElIV2o3ajB0U1p2TEhYaTVkNEJtbnFmU0VKcTNraG9i?=
 =?utf-8?B?Qi8raFZmS3Z3NGRLWkRnaXdkeHdEODYvTHIrV2ZCZDZLZ05jeStjR3lQd1Vz?=
 =?utf-8?B?RThkK3NtV1c1YnJGdG1NZVMrc1ZBM2p1Q2RrMU4vOG1Mb2E1K2sxTU0xQ1ho?=
 =?utf-8?B?Qm5vL0tkRVcyZXRWTHBEUEtoVW1ScVk1R29ZM0t3MlJZTmRJZWhXL2lXYkYy?=
 =?utf-8?B?YUhXa2xpZ2lGbngrNkJwTS80RU5xZmJNSFpBUS9rd1NGM2ZxdGQvSTVsOTA0?=
 =?utf-8?B?bEJ2ci9wdkJkTUY1c3FVVmJNWUV5U0d3WHNod29hcGlxV3UvbVRlQXNBWVRy?=
 =?utf-8?B?Sm9ZdmhWdjl6elNVS3paVGdyQTQ0a2oxQWwxVlNGMEhKZHptSE9HdGVVeTFt?=
 =?utf-8?B?TGFMeHR5aGhMTm9NNXhMaUJLNFpoTCswbUloYlVFZm9SQ29hL2NHWEo1dWdE?=
 =?utf-8?B?VEFjRnpGQXJ6b0xYT09JTXZMNHVTLy9pdUtoSTNSNDZnV3QxMThYTHB1eG50?=
 =?utf-8?B?QVBSNXlkamI1ZC84ek5FY3VLTnhudVJaQlZIYlVUZENYSXRwZjliVGg0MTMr?=
 =?utf-8?B?L1hpUTBHZ2JiK2tMdDdKOUtHdU5oQ2REd3ZHRTYveUtWclg5NDFyeDYrMG5Y?=
 =?utf-8?B?NVkzODc0bGRGTXFhZzhMVWhqcEs1RHhPb1RFcW1zOEZ6NTdpU3F2RER1V0dw?=
 =?utf-8?B?NjNVVkhDWlJxMUxnTVAwWTE1UTU5bHFsbk1iOCtNYjIzWTdXcTNBakQ2TUFq?=
 =?utf-8?B?cWgvUDV2WVQzN2ZxYzV2K1hET2ZrRThVOVI4eklmZUVDd2NLZ01nYWRwZG5U?=
 =?utf-8?B?ZStrT0hwS2w3WFBYb1lCZlVNQlVRajNNbnpabTZHbXVmYXlqTjg4d3NMOTIv?=
 =?utf-8?B?enpNQVNsdmNBUms2K0d1VWRYbXhWc2VMamVYL0RaMFVVYXVSaXVGMFdUODFJ?=
 =?utf-8?B?eUF6VDRCK1dZamZIV0NzYjMzdWwzeW80aFJId1NwWkhTaHcxa0tlMFFKa2gr?=
 =?utf-8?B?R2tTRDBPY3pKYTM2Q3NHR3IrRzBUTFRkclZxejVYMjdQSmZxSjU0RXBDdE8y?=
 =?utf-8?B?SFBYMmo0WGE5Nmd6Yks4U0l4NjlxRDM0ajZZaXl6TXBmcnJOTENTQnBwS2pN?=
 =?utf-8?B?alhtWTQ4MHJoUHQyRVY5YUdOeHFoU2VZd0NTWXJmd255TmpTL2tiRjhnMytS?=
 =?utf-8?B?OWN6RldlY3FlQXRjUGNMRTNTUjV3SkdCeUEwREMzWEZJVVhITUE0Q2gvbktO?=
 =?utf-8?B?SnhNcWhUem9QdGd1ekpFaEFud2RGL2xFaGFYMWRDODNjc3hmelZKc3pEaEtN?=
 =?utf-8?B?OHh4MVR3Z2VrUW0ydjdrdHBkRU5yNk4rOVllNGdEUzVGaDBlaEZKM2JoanM2?=
 =?utf-8?B?TkJoOTVaUFNzYWl3ZkFBVVZFaWZreXR3UDcrUmx4RUdWYmpoS0I4L212NUl5?=
 =?utf-8?B?aldDRFB2cVp1YVdqNTZrN2tvaVVhbVpIL3k0ektQUlZIUmRrMlAxUWpqMXU0?=
 =?utf-8?B?aXNwa2hYWDNQVWUvdHBPa3lOZWdNankzalZZUnJZWGY0VmJQZzB4aHdvZDhx?=
 =?utf-8?B?VHRhNDdBR2J0WC9UdTZUZWtYRGM1a1VJeTJkY2phcWRILzg0blNFUmxvL0lV?=
 =?utf-8?B?bUVVSGtrTmlVdGFDWjI3U0ZKQmp3U0ZTY1JuUlZVT0EzaWlNa3hudGtzWnR1?=
 =?utf-8?B?RmVFYXVsQWYySFBRR250NVZtWXdWRUNMZk50UURXODBZVWFlZHJwOEQzdlNH?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: tuni.fi
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e9e70-5f05-4d80-2ba3-08dc756146df
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4019.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 04:33:04.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fa6944af-cc7c-4cd8-9154-c01132798910
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT+Ge+qIfLjYFUXfldNsvpVL5mfkTDZVooKUOOsTH5GPQOahYohf6aS2aqBLqS7d1qkPL8gSwWz1Ml5iK/QrtSnFaIHZi1biXaXcGbgwbf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8501

Hi

Afterwards I noticed that after I managed to boot 6.9.0, it hibernates 
and even wakes up OK, so it can read the hibernation image. The panic is 
there only when the system is coming up after rebooted. Then I need to 
edit out resume= and resume_offset= from grub to not get the kernel 
panic. (grub with non-UEFI legacy boot.)

-Petri

On 16.5.2024 5.30, Bagas Sanjaya wrote:
> Hi,
>
> Petri Kaukasoina <petri.kaukasoina@tuni.fi> reported on Bugzilla
> (https://bugzilla.kernel.org/show_bug.cgi?id=218845) VFS kernel panic
> regression when reading hibernation image. He wrote:
>
>> 6.9.0 crashes on boot while 6.8.0 is ok.
>>
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)
>>
>> bisect result:
>>
>> 4379f91172f39d999919c8e8b2b5e1d665d8972d is the first bad commit
>> commit 4379f91172f39d999919c8e8b2b5e1d665d8972d
>> Author: Christian Brauner <brauner@kernel.org>
>> Date:   Tue Jan 23 14:26:23 2024 +0100
>>
>>      power: port block device access to file
>>      
>>      Link: https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-6-adbd023e19cc@kernel.org
>>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>>      Reviewed-by: Jan Kara <jack@suse.cz>
>>      Signed-off-by: Christian Brauner <brauner@kernel.org>
>>
>>   kernel/power/swap.c | 28 ++++++++++++++--------------
>>
>> 6.9.0 with only this reverted did not compile. This has something to do with reading a hibernation image from disk. I use a swap file, not a partition. The system was not hibernated, though. After I removed resume= and resume_offset= from the kernel command line, even 6.9.0 boots without panic.
>>
> Thanks.
>

