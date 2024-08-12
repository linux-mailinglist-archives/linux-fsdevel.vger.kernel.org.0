Return-Path: <linux-fsdevel+bounces-25723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57B94F919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A28E1F23280
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6B1957F8;
	Mon, 12 Aug 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="CIxRxyYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965B4D112;
	Mon, 12 Aug 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499236; cv=fail; b=n15Xj+Vr7F5FmWzwiAeCsSwZoggJenfxarwqWvF0nRwW0amXRrS9k2SGsDmEEbjNl1mGZ68Oy1WRNaEg8NlWrhG/EjjSI/myHk2NxaRvqvvPzO1M1RwIyr3mCXFh4FgW/hCTFiem6gx/dxivqRUt9LIyf9f2f7GdJ4gn1eqMw98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499236; c=relaxed/simple;
	bh=MUKb5ZFpZQFgLv5Htb/Oko+44QhjElBywzeoIHy1KVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ikoxh66MqBCN76decGq7NZ0puCp1eSrxSXr19jHjIw1g7jGWbDESrRoWffC3E0v4aNQo0gCb0Yp91dgJP/yqX1vAb6WSIde2lL7mil51Y3VXAUlSV2avrI4xMCh4nwjF9zsDU0TMC9GOqg9gi7tIkGtKMqxX0dTHLVgsSrXDW7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=CIxRxyYO; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723499235; x=1755035235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MUKb5ZFpZQFgLv5Htb/Oko+44QhjElBywzeoIHy1KVQ=;
  b=CIxRxyYOMJsZq4YySloI4mbmUHWBe8cpYWGpwE2jzCsi7NAy3Kx2VRQD
   YQNiIncvWoMfznqrQCrOjBIRc17UXnee2RnQCPbpHojIe5pP2nrEDTYPW
   PJsQZc9q5KA+N9BDji90hIkcmtT5hGq3AkAmJJpNluzopPbCcQodY0Eye
   4=;
X-CSE-ConnectionGUID: ChIke+K5RRSxivyxnRlBjw==
X-CSE-MsgGUID: PyKaXpq7RmuMW+QyVZRD6Q==
X-Talos-CUID: 9a23:lKHWMmD7Pd7g5Yb6EwJn1U0ZWeN4SEfm3HbOMl++M2JDSqLAHA==
X-Talos-MUID: 9a23:WVnYmwtMNf3Db6Y+ms2nvCBBPfdw+vuUDV0ortY/qve2DwAuAmLI
Received: from mail-canadaeastazlp17010004.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.4])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 17:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbkOyhHliCLjl3rJePm2BJL5e0/VQKy5Sfixwaez4ZXbEX/cpkBq3kob1Hi1ZHDlnKar+E/c6v0Xx5qGm2N9ZiIy/zbT6Gkxt8J6gGa6ZthPeHBAU8qNElLaWKWBId+JUpCieUid6vZcRw0pvRreAMwYPu9rdrU1t5H4HvRfjrZLoxCYI8enasRcFWJOLH/F0EXXsYuUZhiyo67Bzqcmt4h/SX5POYwoipywFlKR9+yht1VS+ME18EI+NeQf0szXpV1Zn9yhRZpDYd42AMupPUaJy63l4KR9ydZUGOUDCxpfuJYwQWuTSRfuk7B5vLpMcI3zhCbvTyYhuCZvl6wCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joypUo78jRi37mEuyQ99EfMDSW9XR29hR7N1EiftIlo=;
 b=DJjGu4YHlbDeEE43DqdIng6IMet2LEdpmX+eSMs16S7ubekJLTYK9gD1018AzIBQNzSjhCmdCthuGK7uONPDsgh8ba1aF5Ac4dTSBX6x1U97UVcQXUp/igfT8gqbXWzPi2jcPJPwXwFvYpdOpQKqBRj/qw/SeuS8wcvwdWkc8xpsor/9YazCwA8c7sY8ymK8I1rly1r9LXE5+qY5H8ZtCEMua69jxKxkZrfumR8jrKJ0uFFxCkCfFKssNSq7yQbK8dr4XyhWaYGzcogOqa9jNK8SvggeelI6kwlPA895jB1opdZORbN7A9dK5WsCVOhnnj1hZnCEbdZnLBPKQTh/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR01MB10832.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 21:47:12 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.018; Mon, 12 Aug 2024
 21:47:12 +0000
Message-ID: <9b3d8ad0-7e91-4b9d-9ffe-b11c10e7344f@uwaterloo.ca>
Date: Mon, 12 Aug 2024 17:47:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 5/5] eventpoll: Control irq suspension for
 prefer_busy_poll
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-6-jdamato@fastly.com> <ZrpuodWa6cKh0sPk@mini-arch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <ZrpuodWa6cKh0sPk@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR01MB10832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c13656f-cbf7-4944-e5a0-08dcbb1852ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFBpcVRWc2doMUNuVVJ0am45R05vTmNjdWRFalFtSjN5M2lKWTZUdjQ4V2I2?=
 =?utf-8?B?d3RhcExWZDkyZGJSZURvK2hhNWtyaU5BdGlXRzFmR0cwOGdSZFppblg1RzVE?=
 =?utf-8?B?NWhZTHRFVmZUU3B3UElodDNVUUJTN3g1ZjNSN05JSEpQcENyYmVjZVlVdEt5?=
 =?utf-8?B?U044ZWpQaHF6NVRpaVpWbXVCanBVZUFHdTg4QU9SYTBmMW5KVi9FenNVcG1C?=
 =?utf-8?B?Q1YzMHovZWl2eTFaRkI2NmxOQkhZQmV0ZUVvTDJoQUlHMWxkYzJWSjlJZTRy?=
 =?utf-8?B?OXlYUTRIMTBYbUtac3ZtaEIvU1F3eE9LaHRLYnQrb254MFRsTnhibGRDMW4w?=
 =?utf-8?B?SHRaZkRsZk9WVUJwM2NoUm5tNjg4WEhRUmlOWGcxQUd6RHF1L1FnbUw3MFlo?=
 =?utf-8?B?WDYxOWFSK1N3UnNwUE9hRUFKTWdlcVV1bFQvQnBLSW9iZ3BiS0JYRVgrL2tM?=
 =?utf-8?B?S01MWUlmamRLbU50ZUtqNndINHFVWHZEdVpZMzdUcCswdGhlNUVEWHdLdlBN?=
 =?utf-8?B?R1R1VWhFK0JkN3NjSUw3WjJXRnRsbERPZ2ZsMEdLeWdoU1ZxZ1JuQ2N4cWFG?=
 =?utf-8?B?QTBTWllvMzAzRVI5NVdINGd2TXVRMXJsb1MyVmNmU3JtRmJWem5UNDdleEJN?=
 =?utf-8?B?NndSR0pwUUdDd0JaY0M0ZldlTWxDVkJTVG9JWHdzd2UyRVJOWHByWGw5SVJI?=
 =?utf-8?B?ZkhTQUFBb0UzZmFoT2lvV2NtNDJmV2hjbmpndGtTWm5DbDJhNDF2UXptZnJv?=
 =?utf-8?B?dVMvdmMxMjJNSW02SWJYK2VySnBlaitlL0hxcUZTUXN2dTFVL3JVUFVSMDlu?=
 =?utf-8?B?b0RzY3NzYjhXTnFQQkYvTE5Dckl1TXh2eGtlaS9FYnF5bkJKTlRHa2FrRllo?=
 =?utf-8?B?aEZSa0dGdm9WY2dDNnJ0bmFmWFJhaUc5TGM4c1Ftc2kwM1hIZHBhYm5ReEly?=
 =?utf-8?B?MkNDRWxRbHdBUStEeVBDWjJEbjV6ODdOaGdiZGRoN09FSWV1U1lsdDlBZGFx?=
 =?utf-8?B?N2k2TTlBeWxaTHczWFNHYkQ1dTAwRGFtY0UvWm5OM2d0cmQwMXNYT0I4S0s5?=
 =?utf-8?B?YzF1VGJmNHpWemREZDM3N2RCWlIza2FWbFBxZUlJeGNrWFJlOEVXUEtJRmJX?=
 =?utf-8?B?YkRLRit0S0I3U251YkFranF4ZXp1OTdmSXk3Y05wTXQ2MnR2d1A0SDhKZmhW?=
 =?utf-8?B?aXNOK01BdHoxcGVKRWMzQ2dsbE5VWHA0TFdHYS9LN2IxSmVybEdxWFBWM3JN?=
 =?utf-8?B?eGx4aVlHTHhQTGdWRFBtWTVMNHlPUzBxbFd5YnErWHQrVFF4SkRjT3JBNngr?=
 =?utf-8?B?VkRMY3htN0krQzBoekxCWjdEek5McU9BTkxxdEUwTlZjeS81MU9CeWJBNlh0?=
 =?utf-8?B?RE5tRWNLTjFHWU9ZMWRmYlNTSVpCUVdWVk93SURsRzIwWmlwTDNmdi9LOEpC?=
 =?utf-8?B?ckhYcXhCZ3pmdXUrM1JEeFFVMDRQVmE2UVBRazUrd1BoUE5ta2J6Z093aE9D?=
 =?utf-8?B?ajdOMkY0enlENTBBVWlTcktncGt1NmIrRndDRVN6V01SektDdnhYVllaRG9p?=
 =?utf-8?B?czBSdFB5MzJhQUYxNXh4RlFrbE1aQUJKaVJaUlhoQkJvYkYyOXAwNHlJSEMx?=
 =?utf-8?B?SGxQMFJFR2IvZjNqUHZQbEsybXh4dHhKSitWWmJETE9hdTVYV3JnbnNJZmdE?=
 =?utf-8?B?R0tHaHVHNWx5Rm1pUXhDSnYwMExSeVJiZjZOMFYwTGh0WDN6RU8xcU1XcC9x?=
 =?utf-8?B?SndqUnJNZ0pISVFwMmhheDliNHZhK3RPSDV5Nk5Nd3NoSUNsalBHM09YS2Q2?=
 =?utf-8?B?MW55QXdieVFHTzlmSDFjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdSbm4vYktiblYrbEg4R09obGNjZmlRcjBaaU9iWm4rNHhiZlBWQ1RQREtr?=
 =?utf-8?B?djFkMlJCNmQ4OFFjNTNsR1hBVzhleHJ4T2VpYTFyVEI4bVh3d0pzY05nL1Vl?=
 =?utf-8?B?SHJhOS9YNGRyWGNQQUl1a2hqTitRTCtzQ1ZMZUhJRlJMbkcxTWo2b25MVjVo?=
 =?utf-8?B?emxqeU4vQ0xCelBIY0Qvcm5kN2NWdzRVcDBlV2UyVHZvUE5kZHdsY01Ia3FQ?=
 =?utf-8?B?VWlTMEc0RUpTRS8ydEhISERxUG55bHZGWGhWRU9zUExYUU9JOXpNTk82UEoz?=
 =?utf-8?B?cEhNbEZmR2JTQ05JZUVZcGZwcU9UemxLdUhwVHdNK29UeEkxbVc3TjdXdDFs?=
 =?utf-8?B?N3ZkVmhSTFBzczRkTFYxN3RsWGRBOVQ3c0ZPYU0vdnhwdHlFdGlKUVg1Ty82?=
 =?utf-8?B?WU5aV1BmQ3JUdExkWHNwWkkxTTlyTXdnenMzY0dJUUIzT2dDY3lHZ2FlcEcx?=
 =?utf-8?B?b2t1T2JUczlUQnNuLzhVU29ESEtKZzZRVmw4RjFJVE5WSTAzaHBjVWtpOHIw?=
 =?utf-8?B?VHg0bVJVd1hyMFVkLzgrM2VNTFIyRDFiWVNMZFpCa0xiRnBlc0JVVkpKWGRX?=
 =?utf-8?B?S3Fmc0RnbGRGVThiTnVYWGduUVNqT2N1aURIZExZdXRJMldjQ1VzQTE1cHFq?=
 =?utf-8?B?NHJJQ3RWaXB6NERBWUd5Wmc5WHE1a1duTkFwVzUxY0c0aGw1b0VOWlQ0OVdB?=
 =?utf-8?B?RE5wbm5oUVp0d2tDRFhrREkwelRvZmpVQnJQUEhvL29oQ1IxN2xTMEwyOGhv?=
 =?utf-8?B?c1RhRnhZMXJxeXdkSUdzQkduZExNY2ZJMXFYNEFXclpVWmxNOGVkcTdCQmEz?=
 =?utf-8?B?RDB0dWJvR3IwdldtUDU3TVg5Z1VQTWhCQ1QxQTJFN1FwTVNpMzQrZ3ZweWVG?=
 =?utf-8?B?ZWxpK1VpZWY5S1pFUytQV01iUHhuR1FoYkN5b2pjTkxZbnU2cS95Slh1enRC?=
 =?utf-8?B?SmFDZ281ZTJRQnUvSjBvZERDdU9tVmM3QitpcG92Q1pqME5LTDBDSWxUVllZ?=
 =?utf-8?B?R1Z3aEZXR1Nqc2JjN1dua1Uvd1ZJUEczSk1sNnVTR2k0Sk8xZEliQzRoM1JM?=
 =?utf-8?B?OWxGQUMrR2lIa2xoV0pRY0tXYjJIU3lzck5tRFFVUC8vRmsyb0t6SHArM3Bv?=
 =?utf-8?B?Nk1TM3N3SUVlb3UwZmN4RVV6MklZMTVWblZjdE10OXNqYjVyTmJHcW5lVmFl?=
 =?utf-8?B?V1VLOGJ1MFc4OVE4d2NaaUwzOWM5OUc0b3BmNlBXOUtXdzNFRnd6OWpnKzQr?=
 =?utf-8?B?anMzWS9jR3hPV0w0U2YwM0w4WWNuZWpZdlozU3hNQWJML0F4Sm0vc0c1bzJl?=
 =?utf-8?B?cUpXdTA5WEFuWG5rU3JiazFyb0I5WlpPWnVIMTcrL1Fqcjhoa1pEbXZwSjFL?=
 =?utf-8?B?UmJMVVQ1cjJqZ1Y2eEJZd3Ywek96cFlzUW1PemtjVVdnSWNDTnZJdVI1ZDNM?=
 =?utf-8?B?cCtCeVliY1kybWw4ZXZzVE04c0YrTjlseG9JSWE2NUYvNklsWm1qaU9CRzU0?=
 =?utf-8?B?UEJSTVFDQmYvRlIzNmtOU3gwNGlJK1BhYmsxZmhqVGR5YVZSZ1dKNkFTdjFQ?=
 =?utf-8?B?Z2FEbUp0SlUwRHd2eVoyYWFUaWxBUWpkdGZsVEszcE5kcFJ0SEt5bVYvdUxa?=
 =?utf-8?B?ZHQ5ZzN3UUcxYTVTMWpWYU1JbkhvK25Ua3BQY3ZZa240SlpnTnJ1UVM3aXpt?=
 =?utf-8?B?VlVzT3ZDWUhBK2pSVyt2eVlJMS9Ia0k4dXgrN1JuamFiTEwwZ0VWNkxsSGg1?=
 =?utf-8?B?T2ZBVnY1UmVtS3VIYmFTekJidUhJRzA0MTlrZTFpd05FdXpZWlBUQjY2Q0Vx?=
 =?utf-8?B?dUJWUjdFRU5vZGJtSVduTHNIdmh4YzJFTWNrby95WVNZeExqMm1GcHF0V25V?=
 =?utf-8?B?TDRtSEY1RFh1SXZrM3VOS3B2Q25JN2JFc0hySnRzcmc2ZzVZSjFUL1BnQXZu?=
 =?utf-8?B?NUVFUkllQmc4MEJQb3pQNmZQQXdpMm1tMVBDL25VUytPWkVROTN1WWQrMFlk?=
 =?utf-8?B?MjlUK0tMVlpscDNYR2kvRy91MWdiL1NJdUY5TU83dlR3TUhtcHp6cXJKa3Ir?=
 =?utf-8?B?dS9ETU1qazlHQmVJRmlmdWhjeEd2NDJpSU9WUitqSHVOdnFGSzV6SXhOaGdY?=
 =?utf-8?Q?cUNv6BsOsVtjKM5ZZf6TBFYBe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F8lT2RDoiUepWcuvXSi6ukK0Q0Xt+wynDGWVY6vuVvEo8HMg9zGsuxGpdrfsuMq9TRu2oQidMwhenggtIAHPhOBq6OYnMTaFK+VgSGjYkIlMd/r5hMYYAhsJqOb9XhiBHEyU+hU6yHXw3CQ6WNiohY9Yda1mBC/ANE30ScIUgxdGvlj0cEIcCYXRpsX79FLDT+xTNsPh7qT6l+tCppVRcfOfyHl1arRjdXXJ5j84tt7VFpqV8pdYaTVglmnS3L2YNnLW6v/QZzkJDAtcFTAHqGXK9Po7LNvJq+QvJ22Ka9vIzsZ18Rer1L5fx4rw7ziw+4SPYgVJM+aSl3c8k9uAs63GoKVDuqrs2WBTWNDAcCGhH9gvxBejyRqxkH0zYoLObeGRPJLWeTsdh3CeBI7rR3D0Zir2ra8EEweK+VxnF3ZAA6HUNa9Nmd4jLTA4Jq5u6Oh9ngHEMCtcY22lBx6Bb/I7AIPytCNO0qqIGrI5XkWBMd1gLvxYh27IxDVxXM7YsBXE9BhR34xVQPnXoJ2UM2WV0SXzp3qXldphzVfhGl7Siw2Xjvupq+zrykSf7dp+s5hpbOiz+UswdecGbhSVrsLiMpkJuId020zAt4gEpmQfmQVTTWrSyHvnVje5QFnW
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c13656f-cbf7-4944-e5a0-08dcbb1852ac
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 21:47:12.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0yVkfgLseBMoOlACmc6o6nrF+00CnhozTib5E4vh4tixLi2anSRrX3jXgbpCEacqVjNMa+GHCYcCtc+LGkuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10832

On 2024-08-12 16:20, Stanislav Fomichev wrote:
> On 08/12, Joe Damato wrote:
>> From: Martin Karsten <mkarsten@uwaterloo.ca>

[snip]

>> @@ -2005,8 +2023,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>>   			 * trying again in search of more luck.
>>   			 */
>>   			res = ep_send_events(ep, events, maxevents);
>> -			if (res)
>> +			if (res) {
>> +				ep_suspend_napi_irqs(ep);
> 
> Aren't we already doing defer in the busy_poll_stop? (or in napi_poll
> when it's complete/done). Why do we need another rearming here?

If ep_poll finds data present due to previous softirq activity during a 
sleep (or application bootstrap), the timer is armed with the shorter 
gro-flush-timeout. This timer rearming with irq-suspend-timeout 
kickstarts the suspend mechanism by injecting the larger timer.

Thanks,
Martin


