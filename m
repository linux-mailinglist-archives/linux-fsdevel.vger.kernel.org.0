Return-Path: <linux-fsdevel+bounces-77819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +II2Oia8mGl+LgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:55:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A316A840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D36C303C874
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575B2FF158;
	Fri, 20 Feb 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rx67t6Zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF22F6193;
	Fri, 20 Feb 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617299; cv=fail; b=rOrQQMZA0h9PoNyiU8sBYRop9v+M+jkXFvEzct4dIiT68ru1lE2I4cpqPtkjRBrCKIS5VIrE2lFOHTTEohrSamd1M6dd34tGuEJtzO2XFajr1m4SboEi/V2fJW1ol+8ufVq6aaMqE0CoQYpAVxIAiQ7KB68Z2JbcpMPS7CnaPY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617299; c=relaxed/simple;
	bh=eZ5or0SBUzi5tIxzUjiyVo94ZGd+sMEFqW8LsQBKx7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e88m122485fQM5iGZa4IS1cXdhABjzywTuD15ZgbejTIO7icnlPa1IvwUqY6+MS35qQJ+4kteLNO8gQSvWcEhaSZ2KewK4cjwpy+ZvJTv19qcAtVh54JneL0aDshLYao7ruxYsjzUoyXJBSwf44ZaZaaL9/xGXwonQUacTL6Imc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rx67t6Zh; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1/gZcMbKSsz+PyO4aBMST6AQOi5U+9aFitzO8yQhZftkLEetrofpQGiIW0eCc9FuxooB3XMaMH9GuyYK3hGsGr0nRtC2lfzavUhsIDlzpNpWJF3idja+HE67dG+6L4U5IXaqlLVDFCmJegVE+FmqRLwsrT0yfbtMERko6TAFy4ywyFy9lpIEb4v303KeEiPqALWqd8s6FQzS6L0PkQ5Romy8xJFw1I9Cx2uQMJBCs4OgGSbh9HvoX1yZoQTd03G0jQgRYUIL2GXfnk6k15tX0oMntH+2MoMWxqaT646VwwBpi/SK1G5j8Y3oohbgOTU2fHJMTOTOcZKIi17uT8Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwB8q+bpccSYCtr5cbQ1EZb+nj9j/KwFI4mGg2PUENc=;
 b=xYp0Li9BjzF7NZea8j6DFnkXPdEwHbHeY9773xbA099PN5pOwMLlmp8jUFyHvxQJhXrQhZ3f35qKQd21ZQSS+JrN9EDVwAloAnFEEWZTV3CVBLqBwS9ZM6y9Ev9fWdDvRV1MN6+hjv4mva5xoaa9hqCam6d+yoiNbj1mp1PL95mAMlr38K6poXl7Jzd0lu/9L5XtFDrmZN4b751sAtgojC+kjihuW70v8bQXC2PBS3/NwONBIs6aPQu+fTM5S0Ui4wnBsxNJjRHWadDXxL9m4lZmHCDJLzjaqrBxrYwU6G1N1jPW+T0BKUV+OQM2QF7+G+/jld/JrdDF1q+LfrJkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwB8q+bpccSYCtr5cbQ1EZb+nj9j/KwFI4mGg2PUENc=;
 b=Rx67t6ZhovzLuo+o1Eeksv87y1NcKMIVG9GzXjD2uwReursJpRRnZE0zbD3j4nVPjYlTqAb6qVXTfPyXkGh/cWNeCcE2dhdOa/zgVrEjH4PdFfZC51ElI6heSpp/5QL/GtzJvmH+Vu5b4mR5mnG16kSm19rCH1bs/DrptGYR46w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 19:54:52 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 19:54:52 +0000
Message-ID: <fccb20c6-545b-4eee-b0ed-3b58f228f089@amd.com>
Date: Fri, 20 Feb 2026 11:54:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
 <9c1994f1-7387-4d63-a678-8fd46a0310d1@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <9c1994f1-7387-4d63-a678-8fd46a0310d1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 75871541-adc4-48a9-e750-08de70b9e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk81ZlNpZjd0VW5OS0FPZUpyUGhjL1BlZEJpNi91MEJjN3BhdVFRbnc3SlZF?=
 =?utf-8?B?SGNTanA4NldUQVRSYTlURVdaSWJoM0dIenlKN2wwMVFwdVJFelZaRWp1OVp4?=
 =?utf-8?B?TitPVEQ3dGphbWdndWVoRkh2YmxSZEduNmdBemdUNXdMR3FZMWx6OUJyVEZs?=
 =?utf-8?B?WVJuZFNRc2ZrL1dObjFPaWdPL1ZtTkI1WEJGZE40aEVJRDZaR2ZFWTcvZ2NK?=
 =?utf-8?B?S3JKaDhVVm85Z0hMNGVBcTNSY1NBU1kvMUI5ZnUwbXYxTklna0VTMHpJM2lp?=
 =?utf-8?B?VFRJZGF5OWd4b2V3eGFuaWFRbDNaenpvcC9hVzEyTzhNcTlodE5OWUlHejdh?=
 =?utf-8?B?V3VZUW8wOUlJaTZGdVhCYUZ6ZHhDZSsrMWJ4SUpBSGMrTi9xb3JIWlZwNERB?=
 =?utf-8?B?OU14Q09tcTJLNnczYUY3K1A5ampZaW1aRkpQOEVpT2N0VnVUQlFaNXNBZW15?=
 =?utf-8?B?MjltMmkyK0pCcXQvRXVuRU15SGJrT0dBbUluTFR6SUdBejJTeUFwbGd1ZXRS?=
 =?utf-8?B?bWNSRGlIL1duN0pWcVVsZ1E2eGI1dEhsdG1HZGowOW8wdkl1SFZyODhrWFh2?=
 =?utf-8?B?RGowNEhURDVEc0ZMYXBLR2dzVFhTOFUwbzhtT3kzdnVZR1lVOWxiaFNndDQ4?=
 =?utf-8?B?TUxaNlplSDdOeloybkhvRWNYZW1vd0c3Q3JpUkppM0N0RjlUc1V5QmRnRnY3?=
 =?utf-8?B?R2tjbVR5eXNxa0JkRkExRFpDaUNtR04vSDdQci8xTnhtUVlIZFFwaFhrbldE?=
 =?utf-8?B?SURUTGgvK1JSc1pqSzV2eHYrMHFWcjFZd1hucFNmRlZ3R1YveW9HWFVWOGxz?=
 =?utf-8?B?ZjJxUlNIQi9GVXR0TVBnUGRjRXFVckswRVF4c1Q2UVQwMnJ0QWZOdTN2ZXJG?=
 =?utf-8?B?UWlPRGFjblVGZEV6ZEtFb2tqT0hDZVlldGpQU2FzaDErUE9tZmJQYjB0VTFL?=
 =?utf-8?B?V3hqVFErcWgvTWw1RTRLS3IrOVJaZ21zZlIrYXkzS3pjUHZ4S2Rwb3hpc1Fa?=
 =?utf-8?B?Y1RuRTVINVpqTy9keHB2QS80bDFxdG53VG90MXA3VVNTSmhKT1JGRExTV3Fi?=
 =?utf-8?B?eVVOVTVrZk44cXpxNGh2dFFwU0dOdXA4N1BCSm50YXlBUC9ndmF5dWRRVHU1?=
 =?utf-8?B?SzBMYmxUWDNHT0V0UE5HTFZndEVOQ2xSb1RjUzZVVWpCVEJGek5sR3huR3RM?=
 =?utf-8?B?S3k4alNoUDRoRWpyM3owWlNueWlscHVYeTZwMlVSM0lYeERwcTB6YzN3Q0hX?=
 =?utf-8?B?RVR3TFZ5NjZXbHJ5QzZkU3AzekplaWd4QlJwb2Y4TCsxTXI2UitvMlZZVlRL?=
 =?utf-8?B?VnA2bTFlSGE0dmxOVlkwWmg5UTRsR0pCYnE3R3lPNGFzS3dEdXNiVDNOTUNP?=
 =?utf-8?B?STY1NE9YeTJFTzcvUmg3dXJEVlN4SGhIcE1QMHd6cUtOSFA5L1UraDRyaUNz?=
 =?utf-8?B?S3pWS3lYWXlpdk0xU3U2TkN0OFNoM2htaE1xUXU1UXo1NXRhUWpxWGRpL1Nr?=
 =?utf-8?B?L2FEdW5vUkJ5bkVsN04rWTZYeTVoOU1nZWlLQlRNNXlqVVg1OHpCdHE1OTNl?=
 =?utf-8?B?RUF4TEg0VlNLUExWWmQ1OExWU2h1NzhzYVp3dFhkR29Jd09TcUtxTTRGR3Er?=
 =?utf-8?B?WjFnN0ZndjNpQkxMSFhkZWlnWFdWQnFyZnlnK2RYejYyN2h1UkN5aVVtVEhF?=
 =?utf-8?B?VlplS0Y0UXdncU1VdDJoc2dxQkNrRXk3eFBpWkZHOXVZelBhNFI1dnJzNWFt?=
 =?utf-8?B?dnNDeHJ1VlB3K1hmWGV6N0RtdDlXUFR1ZVQxcTViSTBXeEl0cXpMd25McHd5?=
 =?utf-8?B?bGk3ODB2dWo5cCtBdzhlUlJPbWlPSXgvNVNxc3Bybk9oUjRxRjNVTnV0K0k5?=
 =?utf-8?B?WWRWTGx2Z0Y3dVBpMG03T3dTV3dYemF5UWN0aDJacjNZWWdvREp3RkxOb25x?=
 =?utf-8?B?M1gyTjdCS2cxVnVuQUxaTmtVNFNCeUtHUU1PbnNodXR4OTMwNUxLZEx4Y3R2?=
 =?utf-8?B?dHZ1M3ZIZHJoSk0rRUpTUEhlanlMSS93YzhwVWlMamlwZUMzTEJDby9XUWNm?=
 =?utf-8?B?OHNHWmltcGo0WnlyNmNHenNCY1V6UnVrWGRNSkhKVEloZEt2SEloT2hReUVW?=
 =?utf-8?Q?5jlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdZN25KNkVFL0xrcnhFUE1ZS1U0d0NLR0ZRRkFCR1kvMjVLRWxVNjdIMHZy?=
 =?utf-8?B?REt4RkNVUFc1WG5BZ2phVjY3Y0xHOTdTekZvQ0cza2pQTkcvRE5zMFhBTHBS?=
 =?utf-8?B?N3lZRGhtUUtlQ2VxTWhBemV3YjNIWXlUMlVmZ3VNUHdSSlFnamcyZTRlTlly?=
 =?utf-8?B?MWpUa2hTTHJ1TjR0SFErTEZTWUUzNzFUMk1CbFFkQkEyMVM4YUROcEgvUEha?=
 =?utf-8?B?K21XaTlrbHllNTh3dytVR2kvL1hmczdYbE1XTXF4YzJheDg2byt5dW5Gc2lz?=
 =?utf-8?B?Z0xhZ3FDTitwMHFKNldGaDU2WkFKOU95ZnA3djU5SEk1akovNnlNMTF2UDZn?=
 =?utf-8?B?R1Z3NG5sdlQ0VEFydllnamg4MWxJazlGcjh6bFBKTWt5U04zWndMYkt1Q05w?=
 =?utf-8?B?SlcxZWFvczBZVWdpOFBFWEk5Uy9makZWOXZBK1ZDYXl2T0dSZmdtWEZsRTdC?=
 =?utf-8?B?aEpDVnVvaG9SajFkYWFwZTAzSUhnQWMzYWlZbThTNWU4WStvSWtKVU9xUjJS?=
 =?utf-8?B?aVdNdjVUWTJHWGtDV0dDMGxPTFNJZ2IvYU44a0kvSTB5dno3ZjMwZE1tejZw?=
 =?utf-8?B?c2o4a2tTUlhZUThTbjFqQkIzcGNpWFlyOWdRbmsxTGZMRm1YcG1IUmlmV1hW?=
 =?utf-8?B?UGN6VnEzdHNzaE9PTlZIRzFhbGNQakQrNU1zWW1aYXRPa21yUEcrOEFjTE5Q?=
 =?utf-8?B?TnBtVG5UTmJBendRRmcvQnc4YU1oMkFkUXEvOUdaaVhBanA1VjFWRVo1NkYv?=
 =?utf-8?B?MU1xaGJWNnp6bVh0eGlHaTVpcHR1WnBSbXRWbzhqaFJCclBJTlFmMENNdi9Y?=
 =?utf-8?B?MG4xOFFwYmV4WWMybXVzMjFyY1o4VWp2dVoyWHJSSk96ZXp6RUY5TFFGUEdm?=
 =?utf-8?B?eHVoc2taSGE3bTIyN251NTRkSDkrUFRuR05CRXFCbFBtbzllZEZZVXUyNmZ2?=
 =?utf-8?B?VlJ0V3dDQ0FzR3RjUWkrcmJ2UEhhMGZEM2tuSVpobkVDd3Rra1EwK05qcjFh?=
 =?utf-8?B?ejRRdHJZaWxUMW5pcWdaY2d5aFBLeWxvTHRRQnRyL1gwRzZUWHNqRjFJVU50?=
 =?utf-8?B?dHpGVEZEd2d4bE1PaXRwY0FoeGxVMTlhT0F4YkJGSVphZDdqTURpZHFnTWRI?=
 =?utf-8?B?WkFkOUJTUm5GdnQwS3U5ZnpvOEhYV0J5Q2tZTjNIVlBVQk5QemZmdi9CSUk4?=
 =?utf-8?B?bHhnRjBBMVRNVTJVUFA1WHFXV2laVlFjeTcxVHRUYVFKVzhzdHZHMzhXbkJK?=
 =?utf-8?B?NnhFeGFjY0owc1liclpoSERkdi9rcWN2VTNCOHV3ZnBoZVlXVnRXeHNUd3dp?=
 =?utf-8?B?Y3ZTTUFlOFZ6RVZwU1BJcEZ6Uy9yUHJMenZxNXB1ZWpwekxOL1dGYmFpa3JO?=
 =?utf-8?B?OEVtY3A0Q3YvMXRYSVRKa3hXNkwzb3p5M0JKTzg1TlJTZUZSWUVGRHlwcWR4?=
 =?utf-8?B?OE04blVIR0lSSU1QOXFUUjV5RHZEZ0Jhb1B2RUdQcDRmOVBSS1FNVy94WTIv?=
 =?utf-8?B?dFlNVER1djhtMVgwb01pNk1ldEZiek5DWFNJeVAwUTBLbjFHTldPZGVtZSti?=
 =?utf-8?B?YUFvYU9LK2xzRHE5dFZSYmhOa0RSU3JrUHZ5WXVCT3prTUNwNWR2N3NMNHFM?=
 =?utf-8?B?UnY4S2lhVVdhR1BYcFl2Nm51M0IzcmhqOVRyMHJUTjNwY3k4YXN1eS85Q1Y3?=
 =?utf-8?B?bUI5MWdsOGFia1o4ZUpJbkwzYnFTNDQ4VjhvZEc3MmpjNnRCYUdPMkFJTWdQ?=
 =?utf-8?B?OTZWWWhOdCtJbW5ydGVocUlMMGlWR3d2TUM3NzVBUVhscm5rVHByZHhtejQ4?=
 =?utf-8?B?ZFRVZkVJRDNTdVpGRXdDR0tsZnVKSlVIYTYxMFhYQTN3aUtEalUzRVNOc0ln?=
 =?utf-8?B?UGVSM3VVL3F2TnQ2QlAyRDZuUlNZTWhLSG5VampQaEs0VlJDOVZSQk84NXRN?=
 =?utf-8?B?TDFwZlZ5allzbVY1TUx0V2JEZTJiRTZHV0lBR3JRM1JMZmZWZk4xd3BqTE1L?=
 =?utf-8?B?Q2ZqNWlvUndaUU1wUXdyTVdsZEIweUtFZDFISUt0N2xpRVJURXlPaVJ6V2V1?=
 =?utf-8?B?U0RQSUtvdTAzZkQ1dXJRODgyMWJCTk9ZbWh4T2hrMmVpb0phemFGb0poeXpn?=
 =?utf-8?B?VTJjN1c0cWljd2FXUnRsaUticFJBSmJxdytWUjdES3Y4YTNJbVIxaTVidUNR?=
 =?utf-8?B?UHFkUGVsSndmNUhVWnZaZUUzbzlsZGlOUEFTU0FLL2J4N3A1dEJ6Qms0Qk9I?=
 =?utf-8?B?eGQ4T2hsaGVWTHBoZXpRb0lFblpqMGNKRWVCZzdDT1RCVE11Y0NpVjdOeHJK?=
 =?utf-8?B?dzJwTmxKQUh0Z0FLQ2lXbWNJUlI0OFV1R0o4QjM2Y2FyZWptdlRFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75871541-adc4-48a9-e750-08de70b9e96f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:54:52.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1emgTnEV7Z+4Zayl6fQ/R5yEnS5WSUlY7XgmkvKW6XzFWRt/GS49yvnVN/ltxZZPT4NjMbPxJ+AscwIyAMg7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77819-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F0A316A840
X-Rspamd-Action: no action

On 2/18/2026 10:05 AM, Dave Jiang wrote:
> 
> 
> On 2/9/26 11:45 PM, Smita Koralahalli wrote:
>> The current probe time ownership check for Soft Reserved memory based
>> solely on CXL window intersection is insufficient. dax_hmem probing is not
>> always guaranteed to run after CXL enumeration and region assembly, which
>> can lead to incorrect ownership decisions before the CXL stack has
>> finished publishing windows and assembling committed regions.
>>
>> Introduce deferred ownership handling for Soft Reserved ranges that
>> intersect CXL windows. When such a range is encountered during dax_hmem
>> probe, schedule deferred work and wait for the CXL stack to complete
>> enumeration and region assembly before deciding ownership.
>>
>> Evaluate ownership of Soft Reserved ranges based on CXL region
>> containment.
>>
>>     - If all Soft Reserved ranges are fully contained within committed CXL
>>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>       dax_cxl to bind.
>>
>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>       region, REGISTER the Soft Reserved ranges with dax_hmem.
>>
>> Use dax_cxl_mode to coordinate ownership decisions for Soft Reserved
>> ranges. Once, ownership resolution is complete, flush the deferred work
>> from dax_cxl before allowing dax_cxl to bind.
>>
>> This enforces a strict ownership. Either CXL fully claims the Soft
>> reserved ranges or it relinquishes it entirely.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/dax/bus.c       |  3 ++
>>   drivers/dax/bus.h       | 19 ++++++++++
>>   drivers/dax/cxl.c       |  1 +
>>   drivers/dax/hmem/hmem.c | 78 +++++++++++++++++++++++++++++++++++++++--
>>   4 files changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
>> index 92b88952ede1..81985bcc70f9 100644
>> --- a/drivers/dax/bus.c
>> +++ b/drivers/dax/bus.c
>> @@ -25,6 +25,9 @@ DECLARE_RWSEM(dax_region_rwsem);
>>    */
>>   DECLARE_RWSEM(dax_dev_rwsem);
>>   
>> +enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
>> +EXPORT_SYMBOL_NS_GPL(dax_cxl_mode, "CXL");
>> +
>>   static DEFINE_MUTEX(dax_hmem_lock);
>>   static dax_hmem_deferred_fn hmem_deferred_fn;
>>   static void *dax_hmem_data;
>> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
>> index b58a88e8089c..82616ff52fd1 100644
>> --- a/drivers/dax/bus.h
>> +++ b/drivers/dax/bus.h
>> @@ -41,6 +41,25 @@ struct dax_device_driver {
>>   	void (*remove)(struct dev_dax *dev);
>>   };
>>   
>> +/*
>> + * enum dax_cxl_mode - State machine to determine ownership for CXL
>> + * tagged Soft Reserved memory ranges.
>> + * @DAX_CXL_MODE_DEFER: Ownership resolution pending. Set while waiting
>> + * for CXL enumeration and region assembly to complete.
>> + * @DAX_CXL_MODE_REGISTER: CXL regions do not fully cover Soft Reserved
>> + * ranges. Fall back to registering those ranges via dax_hmem.
>> + * @DAX_CXL_MODE_DROP: All Soft Reserved ranges intersecting CXL windows
>> + * are fully contained within committed CXL regions. Drop HMEM handling
>> + * and allow dax_cxl to bind.
>> + */
>> +enum dax_cxl_mode {
>> +	DAX_CXL_MODE_DEFER,
>> +	DAX_CXL_MODE_REGISTER,
>> +	DAX_CXL_MODE_DROP,
>> +};
>> +
>> +extern enum dax_cxl_mode dax_cxl_mode;
>> +
>>   typedef void (*dax_hmem_deferred_fn)(void *data);
>>   
>>   int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>> index a2136adfa186..3ab39b77843d 100644
>> --- a/drivers/dax/cxl.c
>> +++ b/drivers/dax/cxl.c
>> @@ -44,6 +44,7 @@ static struct cxl_driver cxl_dax_region_driver = {
>>   
>>   static void cxl_dax_region_driver_register(struct work_struct *work)
>>   {
>> +	dax_hmem_flush_work();
>>   	cxl_driver_register(&cxl_dax_region_driver);
>>   }
>>   
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 1e3424358490..85854e25254b 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/memregion.h>
>>   #include <linux/module.h>
>>   #include <linux/dax.h>
>> +#include <cxl/cxl.h>
>>   #include "../bus.h"
>>   
>>   static bool region_idle;
>> @@ -69,8 +70,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>   			      IORES_DESC_CXL) != REGION_DISJOINT) {
>> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> -		return 0;
>> +		switch (dax_cxl_mode) {
>> +		case DAX_CXL_MODE_DEFER:
>> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> +			dax_hmem_queue_work();
>> +			return 0;
>> +		case DAX_CXL_MODE_REGISTER:
>> +			dev_dbg(host, "registering CXL range: %pr\n", res);
>> +			break;
>> +		case DAX_CXL_MODE_DROP:
>> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
>> +			return 0;
>> +		}
>>   	}
>>   
>>   	rc = region_intersects_soft_reserve(res->start, resource_size(res));
>> @@ -123,8 +134,70 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   	return rc;
>>   }
>>   
>> +static int hmem_register_cxl_device(struct device *host, int target_nid,
>> +				    const struct resource *res)
>> +{
>> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>> +			      IORES_DESC_CXL) != REGION_DISJOINT)
>> +		return hmem_register_device(host, target_nid, res);
>> +
>> +	return 0;
>> +}
>> +
>> +static int soft_reserve_has_cxl_match(struct device *host, int target_nid,
>> +				      const struct resource *res)
>> +{
>> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
>> +		if (!cxl_region_contains_soft_reserve((struct resource *)res))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void process_defer_work(void *data)
>> +{
>> +	struct platform_device *pdev = data;
>> +	int rc;
>> +
>> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
>> +	wait_for_device_probe();
>> +
>> +	rc = walk_hmem_resources(&pdev->dev, soft_reserve_has_cxl_match);
>> +
>> +	if (!rc) {
>> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
>> +		dev_dbg(&pdev->dev, "All Soft Reserved ranges claimed by CXL\n");
>> +	} else {
>> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +		dev_warn(&pdev->dev,
>> +			 "Soft Reserved not fully contained in CXL; using HMEM\n");
>> +	}
>> +
>> +	walk_hmem_resources(&pdev->dev, hmem_register_cxl_device);
>> +}
>> +
>> +static void kill_defer_work(void *data)
>> +{
>> +	struct platform_device *pdev = data;
>> +
>> +	dax_hmem_flush_work();
>> +	dax_hmem_unregister_work(process_defer_work, pdev);
>> +}
>> +
>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>   {
>> +	int rc;
>> +
>> +	rc = dax_hmem_register_work(process_defer_work, pdev);
> 
> Do we need to take a reference on pdev when we queue the work?
> 
> DJ

I thought it might not be required. But correct me if I'm wrong.

There is only one hmem_platform device. Also devm_add_action_or_reset() 
registers kill_defer_work(), which calls flush_work() before the device 
is torn down. So pdev cannot be freed while the deferred work is still 
in progress. flush_work() blocks until process_defer_work() has fully 
returned, and only then does device removal proceed.

But this needs a deadlock fix which Gregory pointed. If probe fails
after work is already queued, the devres cleanup calls flush_work()
which blocks on wait_for_device_probe() while still inside probe
context. I will fix in v7.

Thanks
Smita

> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
>> +	if (rc)
>> +		return rc;
>> +
>>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>   }
>>   
>> @@ -174,3 +247,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Intel Corporation");
>> +MODULE_IMPORT_NS("CXL");
> 


