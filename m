Return-Path: <linux-fsdevel+bounces-63340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A55BB5EED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 07:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629E43C7F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 05:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696D1E32D7;
	Fri,  3 Oct 2025 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="zH1teMcm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020123.outbound.protection.outlook.com [52.101.84.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55779478;
	Fri,  3 Oct 2025 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759467844; cv=fail; b=qPo2e1UAe9I0xP1dXNRJ17vtminpq6ubS1dW8STZaHjMy4n4P5SCJisN9P0NXSe6pMmhpRZVr748cGM1LISAPQ4thnufc2AV1R70340/sHaerImkdZGi6k7d+l9IpDlQiOdKG789UUG14tbNutP1eLG3+zEElZ1qBnabtP2L9gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759467844; c=relaxed/simple;
	bh=iospVju5byoibDmsXlfJpcE9lCkyi5LeSiBfv0VJrn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EdDRdfyE9z9IkhJApk1cXt7bJuzS32XT+W4v2nfmAub5YTxp45r6GQn9u7GxxXULEoC3gv5RxfS6iV+7nT1q53Bxg/oVZZdKdkbKCHyp2m1PMN9hcCJ/XYSFc8j8w6uyDWlZb7Ue+0H4tL2wL+J3ztr6XrXTSkUML9Qhwa4+kxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=zH1teMcm; arc=fail smtp.client-ip=52.101.84.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVqw8GL5tueyAYfeelxo2z77rO/l1tw0XcFuIjpSlSBuHytpKDzJPt8K6w8s2YTLAf0ncmRmfa0tiKi8inciKrEoMIdr/bu4QmWVgnDWk0tngS36jWSpBGggd/x5ZD2jqcy9Dfxp8QODQCLP0b+7+oiicbvF9eK1srkBr/GCHScyktWSJcz1FZDFlvFc2zOPwcdnbaUUeqgW0qOGJl/WWa+IIOsKPoSR+ca2nfRXsFaLDFzM5dBPKlk17N7Um2wMUhQOXySh2eSK5B64qxjieS87xA6G391Nqzhuypb+EXBTEaoW5QSFBZPA/70oYeLMLrsGS12JBcn744B1eAKC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeUpfODYRlGjTpIUBMlQ57xZNj75BBddiYrQNzwhOIU=;
 b=CgroE9AAstJL4MTCTqs7EhrYg8PSVfFdDofKvbULlYh7a0jUQqO46UbevsXIksT4YYXlV1AEWqZr0Xtps+cbPRRFtFIPhOIIr9qIgVKGbYlpiVip6CF7xNs8Yaf7kzFJnqqENaNj6o6G0Jx8hCR2gDxjZW0VO/FGHm7KIJIFwesnibsOqKKG7z57BKw93W9Xcc1JT6kGMnHBm5e33yxNAI79Ktk/rNgofL9cyBOdcGKsVGXdOYiW8wOqe8q1aZ7JOSBg0sHOOSRGUNKXKRQJkbVFWkqP+XGjd8W+ofCccsW6/6MtB1BaRrJpyHvaD+gE77wKB9gBmLK9b/6COrPyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeUpfODYRlGjTpIUBMlQ57xZNj75BBddiYrQNzwhOIU=;
 b=zH1teMcmPfrH31In0Md1lIuHIlyHSFUxU9P1EZ1VdV0vRA3EfP13bLsAwCkDJTxgCKlqXZkfCFcPY25G9F5bioWW7J5BRhZOM9I6mQwB9JfkT2cgP8OyXqDpABqCgN3jAoYJrxYE6lAT/sro6bRdk+NlLcsvzzwjn2FiIT1+mhe7TnkgncNEU5yiI3BzQGz2dC2U7bV5KYjOPpFlnZSNkg8fuGVrv1jAZ4uixf6wwcgHjxeg664Cek/tbVrpY9PKUcTkuGIRTM/Lwht2qKRrbWY2sO8doYwzqZ4SfUJQovpSoKBA4vAhZ0xLubXr2g/Us1yAc78K5ypIMK41coavkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB9PR08MB8266.eurprd08.prod.outlook.com (2603:10a6:10:3c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 05:03:54 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 05:03:54 +0000
Message-ID: <7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com>
Date: Fri, 3 Oct 2025 13:03:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
To: Al Viro <viro@zeniv.linux.org.uk>,
 Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
 Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Andrei Vagin <avagin@gmail.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
 <20251002125422.203598-3-b.sachdev1904@gmail.com>
 <20251002163427.GN39973@ZenIV>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20251002163427.GN39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DB9PR08MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 85be47de-0bed-4d8f-e77b-08de023a404e
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGRlWW4yVkVITTNBVXoyQWJMVGFYU1ZEVzVtLzVydzh2NEk0dVRmSVVtTStS?=
 =?utf-8?B?dTRFTWpEUE1hK0xsdFQ0cm0xSTdxQi9oMDBrekwzcWNlWkVWYTlTK3l4RXh0?=
 =?utf-8?B?SGV0RFlucFF3R05jdGlZVWl2NnVYbXZ6REdHZkFrM050UHBMZGtxbnNnOUNS?=
 =?utf-8?B?TFI3NGo2RXBtcGRSbEVqUjZVRDJXTitHR21pdmhiSFBjMzJZeldma3paRjI5?=
 =?utf-8?B?d0NqNTh5bVN5dDRobkp4ZUlhKzUyelorMEFVYmpTeXBJYWhXa1JvaHNEY1k5?=
 =?utf-8?B?bFVrVWlqWVdncm4xcnFsWkxFTVhQcHltYUxicDVJczI2eTNMWlJPMEFIclQ5?=
 =?utf-8?B?aldDRVBnczZyVmM3T0N5akl6ckt6ZE10RTdHRHIycncvRnNRcG02aVRWcWlL?=
 =?utf-8?B?MlhDSDZrRWdmMXBkSG93eC9adlhlZlg2WmZsajBleWpLSXRLbUlqdG1pRHF5?=
 =?utf-8?B?Q2ZmeHdrUTlGRi9EMDZYZG9pMkpOUHBGYy93Yy9VNzlnWU1HVlo2ajhhaWxs?=
 =?utf-8?B?YlptbVNmUml3em1lRndld1VNVFpETDlFMnpqejFINkFPMEFKcDRiNm1rMmV3?=
 =?utf-8?B?cGhCb0Z4UFFYeTcyODF0Z3ArQ0pNTnAwTXRVbXNWZnVheWlHYnlGR2djVENO?=
 =?utf-8?B?TG1uQW82VnBBaHN0MGRIZHlOQnA3YlRLYXRHMzU0ZE50NnlnQWpYeDBTeUx1?=
 =?utf-8?B?YkdZNnZ5cS9nSnVBSVlEZGxkNHFzblM2RzZTWmZEUFdiQjc2YXljSG81TSt4?=
 =?utf-8?B?UWlVYkZTMW51Zm9MQkNuaS9wOWRYZUZnMS9RN0U2SXhTSXNRWHlOMkJvTThh?=
 =?utf-8?B?dS81bTBjWHhwc3NkQ29aZHBPOHovSDBKNmdRekVmeHVQQ2lSd0dpRzBSY203?=
 =?utf-8?B?RkFoTWdJaVZXcU9sTVBMZVJRcitpR2R4VXdWeGJhc2p2TmNlMjdpUXZnbTQ0?=
 =?utf-8?B?N2lzNTJLVEZHYU5YSWZ5azNxaGh1bG9KK0VCQjN6R0RWdCs3MVRNV3FTU3pt?=
 =?utf-8?B?RUhKZW9uTnIvUnpsNlo5VHQyZVVld05pVGtrdHQ1bnFzWFV6NWdhS1EyYW1U?=
 =?utf-8?B?M0VaZ1JONkRka1ZnaG5JTktHK3dWNnk5M3pvbU8yUnFLOGpyQ3pVaXJGZnh5?=
 =?utf-8?B?bnNZMGpzRGhIb1MvdWlEbDlpek1tOHk2UXZLaWdYMjRCQVNJcXhLRW83bDhW?=
 =?utf-8?B?NWhpdWhXRTZ1TzlLczcxQ1FjWnJoNE82eXVFYXVTWnJ2V0RBcHRDM0VDR2dX?=
 =?utf-8?B?K1RFZURDZGdIMk1JelRLeVNBSWFWVE1ZTnJjR0lKV1U0VUg1SC84ZlptMVpw?=
 =?utf-8?B?ZUFoVjl5KzRBaGRmdHJSeU8vRDBJRzhmVkpLdkdHbnl1aGw1SFZ4a2lvcWV2?=
 =?utf-8?B?aXZwdkhUVitWeG16STBVWEI4RTJoVVJ3dFc5R2RxclA3M1cwWWZtdWlKejF1?=
 =?utf-8?B?S2xSS0MrQUY5TTBFQTlGdGRFQjhNc3JYY1hFZVlycHVpSmZwVTRRVUx6YWRB?=
 =?utf-8?B?SmhLWEVHWlB3N3B0amNEMWplQXY5ODVkdUUxQzg2TUgzT1RlRVpyVTVuR0hN?=
 =?utf-8?B?V1VEajRYNnBvKzJnbnJ0OGZXRWVpQkNGUlIva2VMS28yWEtXV1FLYmczNmEz?=
 =?utf-8?B?V0dKR0NVSno4WHZZK21GdGNxS3hITHhFSjdCUmRUdHJINHpTVzNIcjBXVktq?=
 =?utf-8?B?eXE2N0Z6TmVPaWtyOERNSU82dlhmVnIydmFkWDFuSjRORGFZVXR2Y1VIUVpn?=
 =?utf-8?B?Um9wUVQ2anpobVVWT3U1VUIyZU1QQ1Vtb3BrMHFHc2dZKzhQbG9VbjEzSTRt?=
 =?utf-8?B?RktHT0hRM0xFSWQ0NTdZb01HZHVtWjhKZVZUVEIyRGUyd0pjMklnT1p2VGJW?=
 =?utf-8?B?NTBjSTdMVHFFQlJGNURzVEx2U0RQZmV3Tk5hQnhVamdXby8xY3FPd1lNQUxa?=
 =?utf-8?B?T2VhNlI4bUFHSXV3eFhldDBnNFE5dFA0bVowQXBaWGd5Z0RBd2tQYXRaZzJo?=
 =?utf-8?B?aG9rcURISXRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhabE5OZVFEQWJZb09ub1JKbzlFT1kvYS9RVWkzbm5vbTdHSXpwWEo2WTBn?=
 =?utf-8?B?NXErcjJ2ZlJueTRYaWFrbnBzdlk2MXhqOFI5VVpaejZhSmRnZEJmc3NKeHR3?=
 =?utf-8?B?bXkyMmZVcnFMMEJSK21ZUzRmckxabzZ0QUduNjlnMjlINE0zdUkzdlgxeldS?=
 =?utf-8?B?QU44aUlhV2duK0hEc3BlNXpHbWVOSkpnS25LVUx5RDZIL3pQV3FzVkhrMjRx?=
 =?utf-8?B?NUlHZ3NCaDUzbDV0U0c5MURncXArOGEyQ0xJVndmWGhtRExSNDd6QjBPb3ZI?=
 =?utf-8?B?L2RTZndXYWVGNVJnYW9iY0pSb1JtdDJpUnljb2lKOER5VWZEdS9oRnJmV1M5?=
 =?utf-8?B?TVVLYk5QTlBWT0Z3cjBGdHV0OVpFR3BJZVR6a05HeWJHc2tvTXZDMjJRclow?=
 =?utf-8?B?UDFNdkVrRXdTYVFXSjlEWndjckJkMkZzTDFFTlpSVDB4b2h0R3ZYK3FORjlX?=
 =?utf-8?B?VDZCUlc1TlpEU1p0VmFjbnQ2Rkg4RWNpRjFjM012clVpbTRJSTRFRVErN0l5?=
 =?utf-8?B?YVE4WnNkUlFEOUdYZFdxRTgvK05VcVNTR2xxUG1Uak90K0VVekI5Z25ON3E2?=
 =?utf-8?B?MHRQYjBGSXVtdVhEQ3hiYXpUUnFsNFZPV3FOd3pLclFWQW1sTFo1dmk1TUFn?=
 =?utf-8?B?bmp3Qmpub3ZrOVBLWm9ISlpCUmRqeUVIby9pTm51cjk5Z09TejR0SVczVmxG?=
 =?utf-8?B?aUJZZHY3RWQ4QXVKL1ExTENGUkNVQ0ZLMlpJRUwwUEtub3M5ekxkdnp4dXRP?=
 =?utf-8?B?RElCRUNoemh3NlFETnp5MWFrNWdsN3JLRThBQTNaa2JEOG9Jd25CK1dhT3Vt?=
 =?utf-8?B?Z1JtdjloSlNCbEYrZkRnektxeDVmME5DS0ZUTmxmNitHYXdGY04wYm5TL0Va?=
 =?utf-8?B?V055Y1loY2dDeGVGdkRvOW80Z2dyTHdvc1NCSU9GVC84dFpoa2dtSDNsNitJ?=
 =?utf-8?B?UWdqa0RHT3VxbDQvNm0vWmNNSG5CdnoyaUZadEhoLzN4R0krT1BoeE5KN2ww?=
 =?utf-8?B?YWcvY3AxMTd1RElSM0x1ZWZpbDJYOW96cEV1bzZNQ0tmK0xjdDNIdUQrMVlG?=
 =?utf-8?B?NVNLSEFldmF5VFpja2x0NkV6OG1Ya0owL1lPVW5uY3F3V0ZQdURjRkdnbThy?=
 =?utf-8?B?a0dDZmd2ZnBpRzBwRWEzNFBXa3ZEbURaYlpuazhEQWYyOG9sVmNKTkJhR2V0?=
 =?utf-8?B?QXllSjlBRDJ5MnZIRS81WlZyQzlnSVhrSm9aZWRzbmFvSFNheVhOeVlDQWYz?=
 =?utf-8?B?L29KOHJKcDUyVTFwVTVhekxFUnRwR3I5Z3JFTXpkQVQvQ3EzbnFqaFlMZnBD?=
 =?utf-8?B?T3M5QUFvUm55UTZnUWVTcy9UbXdtcUd2VDBYYmpKYXBMR1RxVnFCd0hobENY?=
 =?utf-8?B?Y1JKUTkvR2pnSHJKNnJoWFBJTURoUkZ2UHljNEtSRUdOdFRVbHBiYWtIK1Z5?=
 =?utf-8?B?Rkc2ei8vczEyOEt6WnFlMzh6bmlNcG1DQVE1SC92b3lQeVBQK09vVFBybGJq?=
 =?utf-8?B?WWhaVkloMjhydlpHaC9KWVg1ak04bzZpUmZzb0lJU1orN1E0c2I1M0dkVlY1?=
 =?utf-8?B?VVg0WHhpelloVHlYNUUvVjMvN0EzUHpDWlAyTHVhcmwxcUd4WnpDaEJEWkhj?=
 =?utf-8?B?emVxU3o5c3NibzluKzdRNTZMWGRHalZIUVJJOWc2TFdWa0RUaTZCQzJVZzhy?=
 =?utf-8?B?c3J2T0hMeE10VzVHY3FCSXltRkE0SUZDN3BaUUhERFR3a2xWL3JLN1JBd2ZU?=
 =?utf-8?B?YkZ1ZkdYaE9mRWtyZnA1Wmh0cXRLLzk4QmxWNFBSRWg4emNXR254dWZEQ1NS?=
 =?utf-8?B?Y1JDVXVvUjlJclpOb2JXU2p1TndTRi82d3NIbG5oNldWbVBIdW8wRUxTYTlT?=
 =?utf-8?B?TDU0TWJ3ZFF3b0s0L0lUcUo4YjM2YnJ4ZG1VYW1xeDZpRDIvYUlTRGl6NElN?=
 =?utf-8?B?TEc5R1FIcnd2NDNJbkxJNjIxVFBFNnA3aFFPS0VGUnZOSUhnRWkvK3BwQ3N0?=
 =?utf-8?B?UVRUV2ZwTXc1M2VZTFhSaE0ydHMxWGZYWjZ4eEFWOXRKVE44U0JvTUNvUkN0?=
 =?utf-8?B?M2tISXo0dkxmcE0yOVMrRXlOMU1qMTZLWkMvZ0M0UDcvZkQ0MXhyU3Mxc3I0?=
 =?utf-8?B?S2tOaklJT0FtR2NPVFhubTh6bU1xS0RtelJsWS9QNjlIaEdHM0hxVW0ybGZD?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85be47de-0bed-4d8f-e77b-08de023a404e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 05:03:54.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTfG3PmGMIL5gKY6kRNJmPb7qbC7zIgDU1RrMAcj8yc51l7soYU2GdhqIWhFV0Vs1ym0Sf9IsHa4tkTrBzwURff7U5yeO7uoUUPDZPB1RCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8266



On 10/3/25 00:34, Al Viro wrote:
> On Thu, Oct 02, 2025 at 06:18:38PM +0530, Bhavik Sachdev wrote:
> 
>> @@ -1438,6 +1440,18 @@ static void mntput_no_expire(struct mount *mnt)
>>   	mnt->mnt.mnt_flags |= MNT_DOOMED;
>>   	rcu_read_unlock();
>>   
>> +	if (mnt_ns_attached(mnt)) {
>> +		struct mnt_namespace *ns;
>> +
>> +		move_from_ns(mnt);
>> +		ns = mnt->mnt_ns;
>> +		if (ns) {
>> +			ns->nr_mounts--;
>> +			__touch_mnt_namespace(ns);
>> +		}
>> +		mnt->mnt_ns = NULL;
>> +	}
> 
> Sorry, no.  You are introducing very special locking for one namespace's rbtree.
> Not gonna fly.
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

Thank you for looking into it.

Sorry, we didn't have any intent to break locking, we would like to 
improve/rework the patch if we can.

1) I see that I missed that __touch_mnt_namespace requires vfsmount lock 
(according to it's comment) and we don't have it in this code path, so 
that is one problem.

I also see that it sends wake up for mounts_poll() waiters, but since 
no-one can join umount_mnt_ns, there is no point in sending wakeup as 
no-one can poll on /proc/mounts for this namespace. So we can remove the 
use of __touch_mnt_namespace seemingly safely and remove this incorrect 
locking case.

2) Another thing is, previously when we were at this point in code we 
were already out of namespace rbtree strictly before the reference from 
namespace was put (namespace_unlock()->mntput()). So no-one could've 
lookup-ed us, but after this change one can lookup us from umount_mnt_ns 
rbtree while we are in mntput_no_expire().

This one is a hard one, in this implementation at the minimum we can end 
up using the mount after it was freed due to this.

Previously mount lookup was protected by namespace_sem, and now when I 
use move_from_ns out of namespace_sem this protection is broken.

One stupid idea to fix it is to leave one reference to mount from 
detatched mntns, and have an asynchronous mechanism which detects last 
reference (in mntput_no_expire) and (under namespace_sem) first 
disconnects mount from umount_mnt_ns and only then calls final mntput.

We will think more on this one, maybe we will come up with something 
smarter.

3) We had an alternative approach to make unmounted mounts mountinfo 
visible for the user, by allowing fd-based statmount() 
https://github.com/bsach64/linux/commit/ac0c03d44fb1e6f0745aec81079fca075e75b354

But we also recognize a problem with it that it would require getting 
mountinfo from fd which is not root dentry of the mount, but any dentry 
(as we (CRIU) don't really have an option to choose which fd will be 
given to us).

I share this in case, maybe, you like it more than adding umount_mnt_ns.

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


