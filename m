Return-Path: <linux-fsdevel+bounces-58739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5775B30D16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87936040C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1928C860;
	Fri, 22 Aug 2025 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNykLPeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A98393DE8;
	Fri, 22 Aug 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834991; cv=fail; b=HZYAKtWpU5K08Wzo4qL2FqJdqLw7PFtlzdveUI/sLzwXTndoQH7MEYCTkfCUJ0/IKQk274pBZtGR1/Yd6ORY8XtS+2r/TSoQt3enikdeputwZac8S3KjVjDbjwgpQz7FjbuLA62vqVGOVCJ/ctn+nraUgHRmlxToIKLqmNbu8io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834991; c=relaxed/simple;
	bh=hR7KxiLfRFlcgSHOh0K46EK2jxM3LBFEhYy19YPKHT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPEbjZbzvaa1K3CCySjYKC4FE/Z9kddQxf0i4EKBzmreKAlqI2wBD6X0pfLp4uY1K16ENyUE4ErKbWdBj3XpXQj+Kz82/s2irUDjkZEuJFFZwRYHznxHXxZSNd6Y4grkxU2vv/zJ1W5aCyZexSULWPDlXP/bpHsMpfNpYHlp2oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dNykLPeN; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pda/iZkZer4k0hQf2cHU+NLL1BeKn4O4U3Op+YD5EZyfaWmmvKS775zw8OXlrk1y/SFR96Lwcz8mIfNbRaE4nzjrH0s5b8vwIa2RXGgbeAoQv0BdFDe2Vvj+PWb7j7xkrGKsGYssN/QVb0V6YNoC67WuvPAhder60spX8D/3v49JHrNCI0LcELTujE4TEtYRlanvbLB9mGhmOezmhqnQK/lyRgxTz0y/2VxxyH1cNxd9KFJxY/YOB5sYRzxBuyllyoGUA4ZN9nn1G1FQh7azaP4jayCh/MvH/eN2PMWGNAKWoy9+2zCsh5t7A6H37iI7JcSzbovQ5zIcaexMFoItDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLEvQSN5u+y8E81eN8dpf7iGz3zOFuLOyu8no6m3Bqo=;
 b=m6bsZ9xqddJyA3+m7SffdwkK8D+2lK5d9jmS4a5llGTmhov/wAGC5k31bcpRTZB3nv4HjRNArBfIVUTFw3hzdDp9TFpGgKJTScD+WhTMlEo6tFBt4sxEVftV7U2LO5bd7nexoIgTckkB00safWa8+TTImvdIWwHxRvSgTUBwLs4/iKDuaZeSJPPhnEYFxg3kpRcX6lgWrJrxPr7PhYntqFznZjm+EqkDPM/d7AVSSNd8a1Ir1l4IfcREMZIXCf0fsEwyN5LUoawakTe1PfKNExFLhRUbz8kX1PJF9T5lsSmjTKy7r/p9c12Mn/4v50ER7HN5w8qt4rXZ6Vb0xBg27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLEvQSN5u+y8E81eN8dpf7iGz3zOFuLOyu8no6m3Bqo=;
 b=dNykLPeNs8CC3rIi0Vn32DHMSV0tK1DlocYkVVqBbMQJRNxV0F53+4eY6Y/B++Om7nmnjSjP62HooqW/AfCIBb3aKI+qYALflsUBOfVdEynQ0IvsOBasBVWt7U3eKK7HJ+8f2stq/Qt7TeOIN5B9XUdppTtxSSnens/C9Mo6HDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Fri, 22 Aug 2025 03:56:24 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 03:56:23 +0000
Message-ID: <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
Date: Thu, 21 Aug 2025 20:56:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
 <aKZW5exydL4G37gk@aschofie-mobl2.lan>
 <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:a03:40::45) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dbfdfe-2df9-4953-ae9c-08dde12fdc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdzMHQ3bXh3b0w0bkplMnI1bGd3djBoV2FrY3ZSNEtMaDFNalRIcFZXYm5L?=
 =?utf-8?B?SjFFdWp0S0FuNFY0cmtxbjVNcHBvbHRnRE5qSkgwb2RVT21vditEVDVLZUN0?=
 =?utf-8?B?OVJ6SXFOMCtYbWlucW0weEptOE5jWU9nSlhjTHI0VTRWT0lOU0QwdDAwM0Rx?=
 =?utf-8?B?Y3F3c2xvUkFEK2tUZTAya2ZpamhBK0xDS1pYdTh4MzgvSUJZMU9PNVNsaURI?=
 =?utf-8?B?RTRtOHdncTV0cjVidUZiYTdkTVBOWGxDWE9wcWdBeGtGejZFYUt5SWlBOUpS?=
 =?utf-8?B?SnhMa25YN1VoVEdiQU8vbDU1QVZiVG5GZGJEb1lNQTJORzRwaDREdDl6TGpz?=
 =?utf-8?B?eWFETDV2Rk5GaWxKSm93UHN5WEdjM01WM2YrRVdWWFNkMC84SGtNa2lhRWJr?=
 =?utf-8?B?NUk4OEwrU2RJM0MrcEthUWswSnBDUkpSZE9UT0N5NmI0SXF3V1VHcnIvT3B6?=
 =?utf-8?B?L3dYVnZPTVEvNWw0TzZ1N05hQS8rVk8yWE5hQzl2UmNjMFlRNS9UMUlvdzhO?=
 =?utf-8?B?bFhXK2VhQ2wxMEhPeXRrNk81cHdYVnJkV1dubmxDZENIbmJHZmNEK0NZeEI2?=
 =?utf-8?B?cVl0V2lXYVordkNadUlCeXA3UUIzQTYxVkpYbEtwRHpuemtqVGlDeG81Yzd6?=
 =?utf-8?B?d3F3c2tEM01jVVNaVSsvL05zMzNWS2o0TElUTUhMMDhBb1o4WHgvWG9HaVFY?=
 =?utf-8?B?KzZ6UFBOVUJDK3BYcU5iQ1FpU1pCc2tyaFh4MUpxZlZjYUlCWTJ0VDNWSDdm?=
 =?utf-8?B?VFdMbGdQS0lBSlhrVGRaNm0vTW5nRnB2M1ZtUTN1YTBBNmFCSHRCOWlSMWxk?=
 =?utf-8?B?a2xnR0E4a1ovYU1kZU43cTZIeGlOQXdNTzdVTDlZbXpVWXNZSnNaTlZRcWNK?=
 =?utf-8?B?c1VTS0dFVUEwLzQzMFVFMlNRdU9wTG55UWc4dHhMQTZhTHZmYWhONitHVXVP?=
 =?utf-8?B?MU85d2ZNMjRrc3MwTWY4dlRBVUx5NXQvRGxYbHRNS2tRWjFOOVFNSWxIMDhH?=
 =?utf-8?B?eHhsM0gzZUkyWS8vVmNtdjgzVFVlK2ZoTTk3NnROSTVwTnJrZ3h6RlpOWGdz?=
 =?utf-8?B?aTVzNVR6czExeGdVNXcvU010NnllT2wvWFBFV1VsdHlnZjNHWE9obFczVXY3?=
 =?utf-8?B?V1dpa0RkT2FDMWQrTi8yTEQyTGlheVVhTnl5ZGxsQW9aWWVhZWQ2SlZrSy9y?=
 =?utf-8?B?a25VY2cwZ0pDS0xBbklWbWhCRW1MaEcrdGhSckxmeWNNNm9KaG1BV294dUVG?=
 =?utf-8?B?ck80MnFZNUcwRUFGTXgybzRUNGNEbWpaejVMR3R0aHVCenFwN0RmZll6YWtN?=
 =?utf-8?B?WXpUM09pRXFKVVdqNUJWMmhXYUFuOTlUZ25nbUQ2c0IyN0dPanRiY0xXaU9E?=
 =?utf-8?B?V0x5ekZUcTZ1aTYrL2kyeThQSWZKdHpyWkhIc0ZRQzQwd3BVUytkUUpaU1NW?=
 =?utf-8?B?Um5FdEpsREZMb3VyeEFwREdNZlRTa3ROTmI0WEVCU0Y3S2IzSldac2UwSlJr?=
 =?utf-8?B?UzFjYW0zdGRlUyttN3dQSGlUb21xQk1jb016M1pFL3JvY3lZRkM0K0VEVStz?=
 =?utf-8?B?aEYxeEFOSVN4ZmtBU2JnMW85d0JKU2hNQmNBVjNrOFlCNkFDNDhSMTZXWHNS?=
 =?utf-8?B?ZFJTOFlBcUMxMnBUK3pZb0VjbWduM0w2TlZqNERiRmFINjJMdGcway81RWxK?=
 =?utf-8?B?TzRuQ0hPVmZOUnJJSjJNM3NpYUdKbTVsSHBadXJ6dFZDdFd5UXQ0Ym5hRGpX?=
 =?utf-8?B?WVRGa0Rna1RaeU5SdmljT1dkN0ZMMXRRajh3UFZucCt1TmlYcGlacXAzNGlD?=
 =?utf-8?B?UUZ2S3FHQXFXQnlaU0hMUmM4NC9aakI0Rit2eTZPSjVhNnhCcmdYMkZMYnR4?=
 =?utf-8?B?THFRZ0FEZEo4UWQzNGg1VGVxVFY1ZmxycDN4NG8zSVlnbHJ1ZHdadVI5Zkly?=
 =?utf-8?Q?YvGKGWVxigs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWN0QmRua1U2Z3JzcTgwMENsV01UWlpWclJVL21hZkd5Ry9obHV4NlliNHFt?=
 =?utf-8?B?ais5dlNxYlcxZGhXbUpaWlVKUEVPd3VrK3RaeDB5ZzhhcXhsZ05ZTHNDTVpt?=
 =?utf-8?B?ZzRISTdXUGNGclBEV25hL2U2SHZSNTMzK1Q5SkRmTkozOG50ajBtc1k1UStJ?=
 =?utf-8?B?TU9GeU91SzV5US9sSlR5QytMZ0xSS3FoS2NMZlp3SGJmTVEyaGgybDZ5NFh2?=
 =?utf-8?B?bUtnNzlBMjhKckpYMjRObUpNZTR2VGtSNzN6eVBHYXJRSk80T0gxNGpFcXhw?=
 =?utf-8?B?MVZDZXlReHVyM2NSSTBHZks5RnBvQWlXWHVWa3ZMNUlrbS9mb1lKU0tqVytY?=
 =?utf-8?B?eFNtc04zVXpMeGRXOERMTkZZMDdQYXFBclhScXVrVlI5Zk1jMVhSY1JBZnBp?=
 =?utf-8?B?S3RYcFhwYWdmZzhkUHJOY2tya2Fxb0lLZGxCTFh4SThpQkE3UUo5dVYyVHFI?=
 =?utf-8?B?dm9uYk1CcnE3cGxaMHRzcUs0L1FHb1k5SXRpNnpua01Pb085dFRKYkR2Qnk2?=
 =?utf-8?B?Wk1WL3JoWW9SL2JPT2dPTFo5bnpLWmZMMEx5c0NrZUQ2c2ZNKzd1UFZvL3Ay?=
 =?utf-8?B?SUEyVS9QRlFHa0FvcVVJRHpWQ3dPZzRadEExU21vSWV4L3AxK0lBekVXUEVl?=
 =?utf-8?B?QURLN3lDdlVCQ1J1OURJeG1heWw2cERSblAvU2VXUzlJOGJLbWdPcTcybWVE?=
 =?utf-8?B?ZHlaL253K2VFR2FiRXhNdGJUelJDUW1zT1F3OWJKVFVSMnlWNnBTQXgxenR0?=
 =?utf-8?B?ZFRub2lMNlBXdkVsQkh1VTlZVSt2dFZiTDFTbHRPVGlocUFBRjB3OGVCOHpp?=
 =?utf-8?B?dlF2Y29HZGpVSTQ1UmZ4cy9MdHA1ajRKYUV2RS9PTW1hWmEzbE12aDNqR3NJ?=
 =?utf-8?B?WlBMS3hzRnROOXNOQ2hxSVE3TzVXdE5xT0dOTmEvYzdlMHh0cjRFd202em9i?=
 =?utf-8?B?SldETkdDQU90SlpKYW1tN2lJb1FPYlJYSWNjTGJWSE92TWQ0L2gyMU1BOVN6?=
 =?utf-8?B?U05nbFFERnlEL2VYZXV3Mncybm8vSzRlbXU4UkNnNGZncWtLaHpwV0ErbXFj?=
 =?utf-8?B?VEpwZnRiWVRXSTRtZ0hUMVhML0FMUENnOUovZkliWllZb2h0MHlxa2pHYWhx?=
 =?utf-8?B?ZWNpTzNKNFoyVGg3MVZlVDAvUE5jbHcxSFh3MGRjekhIamRBQXFzc0cvSDl6?=
 =?utf-8?B?U1Y2SGZEZ1dsSDVPWFBwVllIL3Z4SllsQ1BGSWtoOEtEZjRjRW5tREZJWksx?=
 =?utf-8?B?Z3FhRDg3WWtYZlZUNkJqaTVqNVJZYTJTUFQveTBOdXdCZXc4Ryt0bDhZQU5y?=
 =?utf-8?B?UFpIbVI5VTFra1BOYisveHZoRmN0cE5XcmdyOGovOW5UMDVSVlhHbTFMcVVt?=
 =?utf-8?B?UWlSSFdlY1NGd1NRUkF6S1ppV0hLR1VPeTFWVWNDTzRMUlNKWlM2bVlaT0Z6?=
 =?utf-8?B?WHJ4NHpWcndMdnk3TlVVOURwMlZJMENmUHdrenNmaWNTSUo1SVkxNVZ0azE1?=
 =?utf-8?B?a0VKNERBWi9TVXJlZWxrR244ZnVSQ21YK2Iwd0l2YSs2ZWErY1poL3U1WENU?=
 =?utf-8?B?RWtQdmNEbXlLNmZNVEVUNWZ0b09LUFFKeXhoL3EwTTRHbll5Mjh6azdDc1Nk?=
 =?utf-8?B?MkNhWWhtTHhyMWhTeVNIbE1QMEgzN0lxTjNwWU4vdGZJdWttMmJMZE1IRU9C?=
 =?utf-8?B?eHkrYVpCak4xVFo4THhmT29nS3A2WGc1RWgzOW1RV3BRSURkUWZWM0xIYklp?=
 =?utf-8?B?NWRwVndNWFZyZklnYThtMXdBOGZWVGp1SnMxU0wvd1BDc3J1QlRqTDJrN0N4?=
 =?utf-8?B?a1dzMWNGanE3V08zcG5EYW80QlpEUXIxQitmOXROSllza3pQNnczTHlDcU80?=
 =?utf-8?B?Ny9maXBIblZjWFcrV3JxcGQ2UnFPYkxvd050VjRCS3VKdlVDUHFpT3lXUjBY?=
 =?utf-8?B?ZHFqQ3NrNk5JSC9vSEwzU2kxYW11WFQ1WEJKeThITFZzRTRGVGd3MkYrK2dM?=
 =?utf-8?B?WFVVM0MyVVRvRDhZN1p4UlJGTGpSRVoxZG14dFBSb3g0REFtOVBiOVdzRldh?=
 =?utf-8?B?Tm1jeCtMS1prcDdMTy9Nb1lIajMvZVc3cFFab3pkZFNaM1JjU0xPSE1vTWtR?=
 =?utf-8?Q?XqTJBAQPlIiuprxXxMshDRhZt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dbfdfe-2df9-4953-ae9c-08dde12fdc7e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:56:23.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x+6vWPfwtHIxbh1qBbzoZAZDnpM7dKQ5+dIRhqTIyk751d2YOCNvQn7CnGFKEBHi9FhddgjS4Vo2VG4Yxf7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

On 8/20/2025 7:30 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 21/08/2025 07:14, Alison Schofield wrote:
>> On Tue, Aug 05, 2025 at 03:58:41AM +0000, Zhijian Li (Fujitsu) wrote:
>>> Hi Dan and Smita,
>>>
>>>
>>> On 24/07/2025 00:13, dan.j.williams@intel.com wrote:
>>>> dan.j.williams@ wrote:
>>>> [..]
>>>>> If the goal is: "I want to give device-dax a point at which it can make
>>>>> a go / no-go decision about whether the CXL subsystem has properly
>>>>> assembled all CXL regions implied by Soft Reserved instersecting with
>>>>> CXL Windows." Then that is something like the below, only lightly tested
>>>>> and likely regresses the non-CXL case.
>>>>>
>>>>> -- 8< --
>>>>>    From 48b25461eca050504cf5678afd7837307b2dd14f Mon Sep 17 00:00:00 2001
>>>>> From: Dan Williams <dan.j.williams@intel.com>
>>>>> Date: Tue, 22 Jul 2025 16:11:08 -0700
>>>>> Subject: [RFC PATCH] dax/cxl: Defer Soft Reserved registration
>>>>
>>>> Likely needs this incremental change to prevent DEV_DAX_HMEM from being
>>>> built-in when CXL is not. This still leaves the awkward scenario of CXL
>>>> enabled, DEV_DAX_CXL disabled, and DEV_DAX_HMEM built-in. I believe that
>>>> safely fails in devdax only / fallback mode, but something to
>>>> investigate when respinning on top of this.
>>>>
>>>
>>> Thank you for your RFC; I find your proposal remarkably compelling, as it adeptly addresses the issues I am currently facing.
>>>
>>>
>>> To begin with, I still encountered several issues with your patch (considering the patch at the RFC stage, I think it is already quite commendable):
>>
>> Hi Zhijian,
>>
>> Like you, I tried this RFC out. It resolved the issue of soft reserved
>> resources preventing teardown and replacement of a region in place.
>>
>> I looked at the issues you found, and have some questions comments
>> included below.
>>
>>>
>>> 1. Some resources described by SRAT are wrongly identified as System RAM (kmem), such as the following: 200000000-5bffffff.
>>>       
>>>       ```
>>>       200000000-5bffffff : dax6.0
>>>         200000000-5bffffff : System RAM (kmem)
>>>       5c0001128-5c00011b7 : port1
>>>       5d0000000-64ffffff : CXL Window 0
>>>         5d0000000-64ffffff : region0
>>>           5d0000000-64ffffff : dax0.0
>>>             5d0000000-64ffffff : System RAM (kmem)
>>>       680000000-e7ffffff : PCI Bus 0000:00
>>>
>>>       [root@rdma-server ~]# dmesg | grep -i -e soft -e hotplug
>>>       [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-6.16.0-rc4-lizhijian-Dan+ root=UUID=386769a3-cfa5-47c8-8797-d5ec58c9cb6c ro earlyprintk=ttyS0 no_timer_check net.ifnames=0 console=tty1 console=ttyS0,115200n8 softlockup_panic=1 printk.devkmsg=on oops=panic sysrq_always_enabled panic_on_warn ignore_loglevel kasan.fault=panic
>>>       [    0.000000] BIOS-e820: [mem 0x0000000180000000-0x00000001ffffffff] soft reserved
>>>       [    0.000000] BIOS-e820: [mem 0x00000005d0000000-0x000000064ffffff] soft reserved
>>>       [    0.072114] ACPI: SRAT: Node 3 PXM 3 [mem 0x200000000-0x5bffffff] hotplug
>>>       ```
>>
>> Is that range also labelled as soft reserved?
>> I ask, because I'm trying to draw a parallel between our test platforms.
> 
> No, It's not a soft reserved range. This can simply simulate with QEMU with `maxmem=192G` option(see below full qemu command line).
> In my environment, `0x200000000-0x5bffffff` is something like [DRAM_END + 1, DRAM_END + maxmem - TOTAL_INSTALLED_DRAM_SIZE]
> DRAM_END: end of the installed DRAM in Node 3
> 
> This range is reserved for the DRAM hot-add. In my case, it will be registered into 'HMEM devices' by calling hmem_register_resource in HMAT(drivers/acpi/numa/hmat.c)
> 
>    893 static void hmat_register_target_devices(struct memory_target *target)
>    894 {
>    895         struct resource *res;
>    896
>    897         /*
>    898          * Do not bother creating devices if no driver is available to
>    899          * consume them.
>    900          */
>    901         if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>    902                 return;
>    903
>    904         for (res = target->memregions.child; res; res = res->sibling) {
>    905                 int target_nid = pxm_to_node(target->memory_pxm);
>    906
>    907                 hmem_register_resource(target_nid, res);
>    908         }
>    909 }
> 
> 
> $ dmesg | grep -i -e soft -e hotplug -e Node
> [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-6.16.0-rc4-lizhijian-Dan-00026-g1473b9914846-dirty root=UUID=386769a3-cfa5-47c8-8797-d5ec58c9cb6c ro earlyprintk=ttyS0 no_timer_check net.ifnames=0 console=tty1 conc
> [    0.000000] BIOS-e820: [mem 0x0000000180000000-0x00000001ffffffff] soft reserved
> [    0.000000] BIOS-e820: [mem 0x00000005d0000000-0x000000064fffffff] soft reserved
> [    0.066332] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [    0.067665] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
> [    0.068995] ACPI: SRAT: Node 1 PXM 1 [mem 0x100000000-0x17fffffff]
> [    0.070359] ACPI: SRAT: Node 2 PXM 2 [mem 0x180000000-0x1bfffffff]
> [    0.071723] ACPI: SRAT: Node 3 PXM 3 [mem 0x1c0000000-0x1ffffffff]
> [    0.073085] ACPI: SRAT: Node 3 PXM 3 [mem 0x200000000-0x5bfffffff] hotplug
> [    0.075689] NUMA: Node 0 [mem 0x00001000-0x0009ffff] + [mem 0x00100000-0x7fffffff] -> [mem 0x00001000-0x7fffffff]
> [    0.077849] NODE_DATA(0) allocated [mem 0x7ffb3e00-0x7ffdefff]
> [    0.079149] NODE_DATA(1) allocated [mem 0x17ffd1e00-0x17fffcfff]
> [    0.086077] Movable zone start for each node
> [    0.087054] Early memory node ranges
> [    0.087890]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.089264]   node   0: [mem 0x0000000000100000-0x000000007ffdefff]
> [    0.090631]   node   1: [mem 0x0000000100000000-0x000000017fffffff]
> [    0.092003] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdefff]
> [    0.093532] Initmem setup node 1 [mem 0x0000000100000000-0x000000017fffffff]
> [    0.095164] Initmem setup node 2 as memoryless
> [    0.096281] Initmem setup node 3 as memoryless
> [    0.097397] Initmem setup node 4 as memoryless
> [    0.098444] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.099866] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.104342] On node 1, zone Normal: 33 pages in unavailable ranges
> [    0.126883] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> 
> =================================
> 
> Please note that this is a modified QEMU.
> 
> /home/lizhijian/qemu/build-hmem/qemu-system-x86_64 -machine q35,accel=kvm,cxl=on,hmat=on \
> -name guest-rdma-server -nographic -boot c \
> -m size=6G,slots=2,maxmem=19922944k \
> -hda /home/lizhijian/images/Fedora-rdma-server.qcow2 \
> -object memory-backend-memfd,share=on,size=2G,id=m0 \
> -object memory-backend-memfd,share=on,size=2G,id=m1 \
> -numa node,nodeid=0,cpus=0-1,memdev=m0 \
> -numa node,nodeid=1,cpus=2-3,memdev=m1 \
> -smp 4,sockets=2,cores=2 \
> -device pcie-root-port,id=pci-root,slot=8,bus=pcie.0,chassis=0 \
> -device pxb-cxl,id=pxb-cxl-host-bridge,bus=pcie.0,bus_nr=0x35,hdm_for_passthrough=true \
> -device cxl-rp,id=cxl-rp-hb-rp0,bus=pxb-cxl-host-bridge,chassis=0,slot=0,port=0 \
> -device cxl-type3,bus=cxl-rp-hb-rp0,volatile-memdev=cxl-vmem0,id=cxl-vmem0,program-hdm-decoder=true \
> -object memory-backend-file,id=cxl-vmem0,share=on,mem-path=/home/lizhijian/images/cxltest0.raw,size=2048M \
> -M cxl-fmw.0.targets.0=pxb-cxl-host-bridge,cxl-fmw.0.size=2G,cxl-fmw.0.interleave-granularity=8k \
> -nic bridge,br=virbr0,model=e1000,mac=52:54:00:c9:76:74 \
> -bios /home/lizhijian/seabios/out/bios.bin \
> -object memory-backend-memfd,share=on,size=1G,id=m2 \
> -object memory-backend-memfd,share=on,size=1G,id=m3 \
> -numa node,memdev=m2,nodeid=2 \
> -numa node,memdev=m3,nodeid=3 \
> -numa dist,src=0,dst=0,val=10 \
> -numa dist,src=0,dst=1,val=21 \
> -numa dist,src=0,dst=2,val=21 \
> -numa dist,src=0,dst=3,val=21 \
> -numa dist,src=1,dst=0,val=21 \
> -numa dist,src=1,dst=1,val=10 \
> -numa dist,src=1,dst=2,val=21 \
> -numa dist,src=1,dst=3,val=21 \
> -numa dist,src=2,dst=0,val=21 \
> -numa dist,src=2,dst=1,val=21 \
> -numa dist,src=2,dst=2,val=10 \
> -numa dist,src=2,dst=3,val=21 \
> -numa dist,src=3,dst=0,val=21 \
> -numa dist,src=3,dst=1,val=21 \
> -numa dist,src=3,dst=2,val=21 \
> -numa dist,src=3,dst=3,val=10 \
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=110 \
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=20000M \
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=240 \
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=40000M \
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=340 \
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=60000M \
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,latency=440 \
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,bandwidth=80000M \
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=240 \
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=40000M \
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-latency,latency=110 \
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=20000M \
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=340 \
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=60000M \
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,latency=440 \
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,bandwidth=80000M
> 
> 
> 
>> I see -
>>
>> [] BIOS-e820: [mem 0x0000024080000000-0x000004407fffffff] soft reserved
>> .
>> .
>> [] reserve setup_data: [mem 0x0000024080000000-0x000004407fffffff] soft reserved
>> .
>> .
>> [] ACPI: SRAT: Node 6 PXM 14 [mem 0x24080000000-0x4407fffffff] hotplug
>>
>> /proc/iomem - as expected
>> 24080000000-5f77fffffff : CXL Window 0
>>     24080000000-4407fffffff : region0
>>       24080000000-4407fffffff : dax0.0
>>         24080000000-4407fffffff : System RAM (kmem)
>>
>>
>> I'm also seeing this message:
>> [] resource: Unaddressable device  [mem 0x24080000000-0x4407fffffff] conflicts with [mem 0x24080000000-0x4407fffffff]
>>
>>>
>>> 2. Triggers dev_warn and dev_err:
>>>       
>>>       ```
>>>       [root@rdma-server ~]# journalctl -p err -p warning --dmesg
>>>       ...snip...
>>>       Jul 29 13:17:36 rdma-server kernel: cxl root0: Extended linear cache calculation failed rc:-2
>>>       Jul 29 13:17:36 rdma-server kernel: hmem hmem.1: probe with driver hmem failed with error -12
>>>       Jul 29 13:17:36 rdma-server kernel: hmem hmem.2: probe with driver hmem failed with error -12
>>>       Jul 29 13:17:36 rdma-server kernel: kmem dax3.0: mapping0: 0x100000000-0x17ffffff could not reserve region
>>>       Jul 29 13:17:36 rdma-server kernel: kmem dax3.0: probe with driver kmem failed with error -16
>>
>> I see the kmem dax messages also. It seems the kmem probe is going after
>> every range (except hotplug) in the SRAT, and failing.
> 
> Yes, that's true, because current RFC removed the code that filters out the non-soft-reserverd resource. As a result, it will try to register dax/kmem for all of them while some of them has been marked as busy in the iomem_resource.
> 
>>> -   rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>> -                          IORES_DESC_SOFT_RESERVED);
>>> -   if (rc != REGION_INTERSECTS)
>>> -       return 0;
> 
> 
> This is another example on my real *CXL HOST*:
> Aug 19 17:59:05  kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measuremen>
> Aug 19 17:59:09  kernel: power_meter ACPI000D:00: Ignoring unsafe software power cap!
> Aug 19 17:59:09  kernel: kmem dax2.0: mapping0: 0x0-0x8fffffff could not reserve region
> Aug 19 17:59:09  kernel: kmem dax2.0: probe with driver kmem failed with error -16
> Aug 19 17:59:09  kernel: kmem dax3.0: mapping0: 0x100000000-0x86fffffff could not reserve region
> Aug 19 17:59:09  kernel: kmem dax3.0: probe with driver kmem failed with error -16
> Aug 19 17:59:09  kernel: kmem dax4.0: mapping0: 0x870000000-0x106fffffff could not reserve region
> Aug 19 17:59:09  kernel: kmem dax4.0: probe with driver kmem failed with error -16
> Aug 19 17:59:19  kernel: nvme nvme0: using unchecked data buffer
> Aug 19 18:36:27  kernel: block nvme1n1: No UUID available providing old NGUID
> lizhijian@:~$ sudo grep -w -e 106fffffff -e 870000000 -e 8fffffff -e 100000000 /proc/iomem
> 6fffb000-8fffffff : Reserved
> 100000000-10000ffff : Reserved
> 106ccc0000-106fffffff : Reserved
> 
> 
> This issue can be resolved by re-introducing sort_reserved_region_intersects(...) I guess.
> 
> 
> 
>>
>>>       ```
>>>
>>> 3. When CXL_REGION is disabled, there is a failure to fallback to dax_hmem, in which case only CXL Window X is visible.
>>
>> Haven't tested !CXL_REGION yet.

When CXL_REGION is disabled, DEV_DAX_CXL will also be disabled. So 
dax_hmem should handle it. I was able to fallback to dax_hmem. But let 
me know if I'm missing something.

config DEV_DAX_CXL
         tristate "CXL DAX: direct access to CXL RAM regions"
         depends on CXL_BUS && CXL_REGION && DEV_DAX
..

>>
>>>       
>>>       On failure:
>>>       
>>>       ```
>>>       100000000-27ffffff : System RAM
>>>       5c0001128-5c00011b7 : port1
>>>       5c0011128-5c00111b7 : port2
>>>       5d0000000-6cffffff : CXL Window 0
>>>       6d0000000-7cffffff : CXL Window 1
>>>       7000000000-700000ffff : PCI Bus 0000:0c
>>>         7000000000-700000ffff : 0000:0c:00.0
>>>           7000001080-70000010d7 : mem1
>>>       ```
>>>
>>>       On success:
>>>       
>>>       ```
>>>       5d0000000-7cffffff : dax0.0
>>>         5d0000000-7cffffff : System RAM (kmem)
>>>           5d0000000-6cffffff : CXL Window 0
>>>           6d0000000-7cffffff : CXL Window 1
>>>       ```
>>>
>>> In term of issues 1 and 2, this arises because hmem_register_device() attempts to register resources of all "HMEM devices," whereas we only need to register the IORES_DESC_SOFT_RESERVED resources. I believe resolving the current TODO will address this.
>>>
>>> ```
>>> -   rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>> -                          IORES_DESC_SOFT_RESERVED);
>>> -   if (rc != REGION_INTERSECTS)
>>> -       return 0;
>>> +   /* TODO: insert "Soft Reserved" into iomem here */
>>> ```
>>
>> Above makes sense.
> 
> I think the subroutine add_soft_reserved() in your previous patchset[1] are able to cover this TODO
> 
>>
>> I'll probably wait for an update from Smita to test again, but if you
>> or Smita have anything you want me to try out on my hardwware in the
>> meantime, let me know.
>>
> 
> Here is my local fixup based on Dan's RFC, it can resovle issue 1 and 2.

I almost have the same approach :) Sorry, I missed adding your
"Signed-off-by".. Will include for next revision..

> 
> 
> -- 8< --
>    commit e7ccd7a01e168e185971da66f4aa13eb451caeaf
> Author: Li Zhijian <lizhijian@fujitsu.com>
> Date:   Fri Aug 20 11:07:15 2025 +0800
> 
>       Fix probe-order TODO
>       
>       Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 754115da86cc..965ffc622136 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -93,6 +93,26 @@ static void process_defer_work(struct work_struct *_work)
>    	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
>    }
>    
> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
> +			     unsigned long flags)
> +{
> +	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	int rc;
> +
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_NAMED_DESC(start, len, "Soft Reserved",
> +				     flags | IORESOURCE_MEM,
> +				     IORES_DESC_SOFT_RESERVED);
> +
> +	rc = insert_resource(&iomem_resource, res);
> +	if (rc)
> +		kfree(res);
> +
> +	return rc;
> +}
> +
>    static int hmem_register_device(struct device *host, int target_nid,
>    				const struct resource *res)
>    {
> @@ -102,6 +122,10 @@ static int hmem_register_device(struct device *host, int target_nid,
>    	long id;
>    	int rc;
> 
    > +	if (soft_reserve_res_intersects(res->start, resource_size(res),
> +		      IORESOURCE_MEM, IORES_DESC_NONE) == REGION_DISJOINT)
> +		return 0;
> +

Should also handle CONFIG_EFI_SOFT_RESERVE not enabled case..


Thanks
Smita

>    	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>    	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>    			      IORES_DESC_CXL) != REGION_DISJOINT) {
> @@ -119,7 +143,17 @@ static int hmem_register_device(struct device *host, int target_nid,
>    		}
>    	}
>    
> -	/* TODO: insert "Soft Reserved" into iomem here */
> +	/*
> +	 * This is a verified Soft Reserved region that CXL is not claiming (or
> +	 * is being overridden). Add it to the main iomem tree so it can be
> +	 * properly reserved by the DAX driver.
> +	 */
> +	rc = add_soft_reserved(res->start, res->end - res->start + 1, 0);
> +	if (rc) {
> +		dev_warn(host, "failed to insert soft-reserved resource %pr into iomem: %d\n",
> +			 res, rc);
> +		return rc;
> +	}
>    
>    	id = memregion_alloc(GFP_KERNEL);
>    	if (id < 0) {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 349f0d9aad22..eca5956c444b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1069,6 +1069,8 @@ enum {
>    int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
>    		      unsigned long desc);
>    
> +int soft_reserve_res_intersects(resource_size_t offset, size_t size, unsigned long flags,
> +		      unsigned long desc);
>    /* Support for virtually mapped pages */
>    struct page *vmalloc_to_page(const void *addr);
>    unsigned long vmalloc_to_pfn(const void *addr);
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b8eac6af2fad..a34b76cf690a 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -461,6 +461,22 @@ int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
>    			     arg, func);
>    }
>    EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
> +
> +static int __region_intersects(struct resource *parent, resource_size_t start,
> +			       size_t size, unsigned long flags,
> +			       unsigned long desc);
> +int soft_reserve_res_intersects(resource_size_t start, size_t size, unsigned long flags,
> +		      unsigned long desc)
> +{
> +	int ret;
> +
> +	read_lock(&resource_lock);
> +	ret = __region_intersects(&soft_reserve_resource, start, size, flags, desc);
> +	read_unlock(&resource_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(soft_reserve_res_intersects);
>    #endif
>    
>    /*
> 
> 
> 
> [1] https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> 
> 
>> -- Alison
>>
>>
>>>
>>> Regarding issue 3 (which exists in the current situation), this could be because it cannot ensure that dax_hmem_probe() executes prior to cxl_acpi_probe() when CXL_REGION is disabled.
>>>
>>> I am pleased that you have pushed the patch to the cxl/for-6.18/cxl-probe-order branch, and I'm looking forward to its integration into the upstream during the v6.18 merge window.
>>> Besides the current TODO, you also mentioned that this RFC PATCH must be further subdivided into several patches, so there remains significant work to be done.
>>> If my understanding is correct, you would be personally continuing to push forward this patch, right?
>>>
>>>
>>> Smita,
>>>
>>> Do you have any additional thoughts on this proposal from your side?
>>>
>>>
>>> Thanks
>>> Zhijian
>>>
>> snip
>>


