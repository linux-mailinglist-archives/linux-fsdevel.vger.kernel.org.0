Return-Path: <linux-fsdevel+bounces-19405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FC8C4D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B47282F77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB701CA92;
	Tue, 14 May 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks/NJG7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1817BD2;
	Tue, 14 May 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674872; cv=fail; b=DF0WC2mSjq+30kwiQDuz7j1BUy3FV5rQEbTR0+RXSK2Uln5cyrfcujboOLIQ5EXuLR8zIpC2p1mjS7fJGtTMeTLoFLa6tXDBEG2UpUQDXT9LNZkBmdzoJHeJnoMomjAATbp1tXoGyic18Pu0KCGO0MBAVimVitL2nclNT9cXNzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674872; c=relaxed/simple;
	bh=oF2Z8sUcg5Dwn5Gjj54z1uZ/I74L2hmd8LO2ehJdGmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gS7M24p6vhePdxzKX1pI/kNvSFT3y8z/Q66ehRJrmdUFjWEM5ihb1cx9OJ5+Shw72iWXytAvh+221iTaSpcJrbTfON9FoyjfzPVXhzv+B3KW3Affx0OIEzklADR5SkAPbvweEcR5dJ5S9AYHt8EXwrnzCCTwYQTHa0TEf3KFl7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks/NJG7n; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715674871; x=1747210871;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oF2Z8sUcg5Dwn5Gjj54z1uZ/I74L2hmd8LO2ehJdGmM=;
  b=ks/NJG7ngIDxf5D+Pjr3oJNWI9AslpnPVdzfXORYSSOMA7TRt9RfDw7Y
   Ux1pwyA/Ye8a12KiZh3j90I0Mwcqxojw8wd7hUG4Mcsd6ed0YFDboJHHt
   iuCDpNgBQG03QwCMr5zl9zWcPcAjniHEUR6be4jD36dHO0YpZ3uTpTCp5
   A4/Vq2deW7jvqYiHrJPyN+wKJKj/loAPk7ezVoFAhT1eR5eUK1rSFvNik
   8QJW15WMCftHqSs/2WwbEm4oQQZxr+e/c1UWbxJfPDF7h5gbAPkmlAPUk
   MY7uZr1MC2/PqMmu0pFlqr44QZjabcO5X2gfUpNQcjzfIo2BosJPNjbLo
   w==;
X-CSE-ConnectionGUID: R/tkbZ66SUmmle1mFmU/Xw==
X-CSE-MsgGUID: ooQmSU9uTxap4upzRejz6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11513264"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11513264"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:21:10 -0700
X-CSE-ConnectionGUID: 7TCLqON4SqyYjWY6ycfjmQ==
X-CSE-MsgGUID: agPYXX7sSba3zwLaAE2B5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61789017"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 01:21:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:21:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:21:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMTSdabjU8GoBpHZ0oGlu5AdKxydN1OqkoQzeePZveDKs4N3b3MwypZqTLk6eubS6JxlE3ilzmBw4KppUitI0C6SyfAezPp4wTMEo/GFLSv9hZd6D2xxcU7H84jMqzfH0izqwGh1dm7CgYcPyEYAE3Di9qJO/P7Tk2ZNsjXuL5usYe/KpEMb7LdogZPTv9mAJaZFzzyny9GbFc3KMHQHS5ixHaRExPsiNg6FaSUJDRyyaKhWLpmgk14SdrDZBni1iyboV58pm+llrMV0eMjOTy2ouhCS9uGMbLY0UZJwn0kqd4OBtINS7G5APYFfWpfkR5V3GN7heMSL2OmBEM0vNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bKAF8uHqnDUpS2udwyvw+hJat+6rFpLwiDKcA54Xes=;
 b=k9m2YZeJKSlZOzUsgdGewDuZQSvmT3QA2J4M4K1EyQSc+igEZpIleq2gHX6aQnwlUUerP2D/uPfcwB/tMwfYWgpp/Zult7Zg6kXk2OsonIJ8pQxJGHKiGOqXuanFY4RAEk04+esMN00RA2XdJi+l0s8hjfg/c1rExVQIk9uD/qfhXGoZ6YnsJW65DSvC+SjcEpUZoa97ADCoyhAvSQyPqyOwbJ5XwoxnXqIZ/VqKl5Ym6FDTlLrZbtWSrl0eDOdFKg5pXDau/LJIHTlHqBeZ4xUbiTxUWnyzW22AVZ0MIC9tNA/ZhBcJrvQwiMjum9fmdET/1PcUfRJkAk4BCSX+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:21:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:21:07 +0000
Date: Tue, 14 May 2024 16:20:57 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <ZkMe6Qsf6knRzZED@xsang-OptiPlex-9020>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2145544.1714120442@warthog.procyon.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2145544.1714120442@warthog.procyon.org.uk>
X-ClientProxiedBy: KL1PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:820::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cdcbc6-a61d-40d9-f96b-08dc73eece0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3R2U012RXB6ellWRXpvRkM4TTEvNjJuMHp4M0RCSlJ0WW9WVE5KTGc3djQ1?=
 =?utf-8?B?VGpDM3ZpRUp5RUx6cUlzSHh2aGZaTHhiRTFVcWtrZ2V4L3g2SGFsamMvYUJn?=
 =?utf-8?B?TXZXQ0xKKzdranltbUNWRTRCdmV6TytDSWt4VVdKWlZ5ZFM1eDRBT0dZdWNk?=
 =?utf-8?B?VU5HOWhTTFpoWXdVbEV1SE1QM2RKRHRjVUxwUGxaeWNDVEVpNG5OQ2hVUTJ6?=
 =?utf-8?B?eStqa1NYWEJUREw5d0JTZ1ZPN2dhSlFuZmtVWlhUZS9hZitVWjFwQkw0RnVU?=
 =?utf-8?B?eUh5cTRIdys2V3g4bWNCa0VwTUxtSVRFYmgxbk9XNFdnbE9zTFZpMHg0N1pP?=
 =?utf-8?B?YnpOR1VhQWY5WFcyNTZyVUJ4d0NtbGxmSFBIVkRJQkZxSTFReUpWek5XSnFn?=
 =?utf-8?B?b3ZORFk4UFpQd3ZRS3FtZEc3QnZqeUtBUWxlK0lGMWcrNTVlMnBxclZhTHQ4?=
 =?utf-8?B?aVVtR3hoWkZJVTE1T0M3SzZ5bG5yaFYwQk9HVk1DNFluSnowMDJnbWUvRVJv?=
 =?utf-8?B?TXg5UkVSNEIvRzNGaDJZOEMyaTd6WTNZQ09IRkNsTHkxQnVmeURmamFXSEdZ?=
 =?utf-8?B?bE84S1RnNldyd2N5dzFCZU1rMS9XZEZWdi8vbTBSMWUxUzMxWmxBdkYxNU5Z?=
 =?utf-8?B?VTJmL1psTTlMdWw3WVdrLzlFVSsyRGZPa0FMay9qcEF1TnVSYUNKdkM4YXpR?=
 =?utf-8?B?cGI0OTNYNm9LV3RoODlJVjVTZmRONU1EWDdEQWhUQzVRNm5jNlFwa1phTXd6?=
 =?utf-8?B?bnBzREVZN3N6b25rSHpLUTBmRnpUYlhiUW5lSGJra3hzU2IvUjZtRjRMaWFX?=
 =?utf-8?B?SWdHQXB4RUVXMjJIajIxUFRyQzMwcWRYendBRlE0NXpxdTdHS1lKYkhVUGFW?=
 =?utf-8?B?K2tmMzBMdHdJVmlBNEVEVHVMcEttVGJ5VXNvZXM5TVVHcDBGek0zVm4zSlE1?=
 =?utf-8?B?dXNvNEZFeDZwSWc2YXlweUF5ZENXUzV4ZjdpdlFxNS9nUjRiV0tDYzlSaS9o?=
 =?utf-8?B?cGQ5Y09GQ3QvZm9ZTjEvd0RVK0YxYVJTZ1FUK1pnL2RtU3Vjd1RScVJrQk9r?=
 =?utf-8?B?cEd2cGhLTkZoYVZWc3EweXhBemRhRHBpZjJuSG81TWVmYTlPRlg0WVhaWEV4?=
 =?utf-8?B?clZMYjRoRC9vT3ppdkh3WUpjZ3NXSjVoMm44WlBTU3VIVG40b0UrWGJKeWVt?=
 =?utf-8?B?N2FpcTAvbE4vRFhkaUg2QTd5UUpBNHI1TC9pRnNFTXNXTk9ia1hjMU5ObEpv?=
 =?utf-8?B?T0UrWDVFUklKdmhLQUR5b2FhbURQcndudStHelMvTHFUSm1JU2JpU2MvbGUz?=
 =?utf-8?B?eEdPV2tiaVpjNGpITlNpaEVpRFVPNitBK1pNSUg0MTlsK05yNFdSOS9xdklP?=
 =?utf-8?B?MnRiWE9jVWdEd0p6aHBhQVpINDVpQTgyTm4xUEpMRkE1VzN2aTM3OUVXZTEv?=
 =?utf-8?B?Q0dQd04vSDJDYTBEK3hUWXZTanY4U2RGZ2RsZkYxUWl5d1FxeC96R1dBRXNW?=
 =?utf-8?B?eWtFcU1qM05sdEJlaThLb1VwTHNWZzZkS2Y3cmZscEhSU2tYMFIwaUpoekt4?=
 =?utf-8?B?SkQ4Y3FocEg2cHgvU2hPVWN6S3ZibjlsZFBWTVVwbEhrMSsxK3AxSWMvdWt3?=
 =?utf-8?B?M3pPOTNmeldtcG9DNFc1Rm9QZE5HRFQyc0NzYVZjdmtLU2krS1M0SFI4aHVw?=
 =?utf-8?B?U0Q4OERNZzY5djB4ZzNCbkE4VW9sTEZRZVRzdnVIZWxFeDJKeXk3SW5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRWYWpacjgvQVhtZWtGMEZGWFZ1WmpObU5nMFZ4VGYwOHI3alpLUnFmOEww?=
 =?utf-8?B?Z2dhR3R6RjdhS0tWWkx2UVBaNVlXVHZCdVZXMXhDR3pxMC9xOTd2REgzQUJn?=
 =?utf-8?B?emgzVEFMRmtZdVl5Q0Myd3ExTTd6L1ZJSnBNSUxUeUxZcjNQRGpSbjFUdXQw?=
 =?utf-8?B?S1JHWU1GVDZLenRnZTRKMVk1QVZuMzhtY3RlaHlyai9XdDBCTFFFd01MRlp4?=
 =?utf-8?B?Q3M1djJQR3ltazNaNHFmMy9xeWFmRlBqSmNQdy8xYWdzUTBMU0Vsdm5PS1Zi?=
 =?utf-8?B?cWJYVWh1eVo4eFRuYlM0TWNGNzhnc0JudTdHaW9YbUNGdXAxWUNDVVFmc1Vy?=
 =?utf-8?B?NGxUdUR1VmttMk5DazA3aFh5L2tBUUZlYlNGWHUwbFlSZnZ1ajVaWC9TczF1?=
 =?utf-8?B?dkp6TUNjZzJpWE95OGVGK2JHb09sMVJEcDh0ZWhzRm1tMHFaWVduLzJGN1gr?=
 =?utf-8?B?MnRsYm9IRzMzOEovanZVVGhTU2c1VEU2QXd3YjcwK3hyTmxUbXk0M2xjczZr?=
 =?utf-8?B?c2xsU05OaldyVzJjQVlGRHBFcmZqczhqZExOMm0yLzRzMk52YWhSdit1UDkr?=
 =?utf-8?B?OE9TUGZ5YXo5NEUrQVlodXFuTlkvc1g1SUtvcnIvL3pOUlJxL0ttYlpXeDdh?=
 =?utf-8?B?M2ExdkMxTTJvUGx4aEJrNjlubHQ0NFgxQUM0ZVNkdTFlRFA5dU1yVklMOEtQ?=
 =?utf-8?B?MTZLNmpzSUVKdHpUdy9ldXlmWUpIdCszakphWjB5ZGtRRGJSWGZpSU9KcG5i?=
 =?utf-8?B?ZHZYdnR6TDBBTE9oeDlGSTMzak1BbWdZd0I4d1BBYXZTZmM1Y2tpMG9Va2kr?=
 =?utf-8?B?SExXY2liQUNCemZsM1M2SkVNQm11ZHBlT1ozaUNmcFQzdVRsYXdJME9RWkF2?=
 =?utf-8?B?UXB0RDNBbkVjaWVNZEdsclIzYVRRVUwrVHlGV2RwYWdHY29rbWRUWXBTOFVl?=
 =?utf-8?B?NlAvSGt1TEx5YmxrQm4wMk95ZTNoTGgrQnVjK1ZSRkZkOTJJV0hldFkwU1lx?=
 =?utf-8?B?YXVwOGVqYXB6Wjd2eGJ3cnZEMk9XUXVLbXA3WFU0bUpLRkJMUG5aSDA2Q1Ny?=
 =?utf-8?B?QXNwQWpocmg5MWtHWlkyMkV0QndRTWtQbHFnUTh4ZGZWQjA3ZFRmSFVPT0cr?=
 =?utf-8?B?UUxIME84Z1ZPV3dPV0pJaTljanRPTzFvTnZtT3hlN1FYd1BUS2QvcTcrYXlV?=
 =?utf-8?B?TkZEOXdFOS9uNkRoSG5NelcyK3RHS0w0cmFRM0FGRXVOT05vcm5QeXdEYjNx?=
 =?utf-8?B?c3VoczZ1dFZZY1NObFZ4b041M0JzRVhLK0pPZjFHQVJxaUhKYzRmU3pZRC9x?=
 =?utf-8?B?dmhUMGtoekVjOUM1bm5lV1RodG4rSDhMRDFPQVVZeTdtdzlqOXFsK05qbTEx?=
 =?utf-8?B?d3FIVUoxY0pReFQvYVZyeEU2b2xkSnA4WVYwMVd5Y1d4L3VoSTdMVDFETWxm?=
 =?utf-8?B?ZnBYVDZnYVBudENkamVWa1FZTFUwdTlCc1hiTVpTczhDb3V3M2s2R082Qjhi?=
 =?utf-8?B?OUdLcnJnTzBmMEZmZ3pSKzBKMTNkNG9GSHZvc3NiUWg4TXorcGlqSDB0anpp?=
 =?utf-8?B?ZU5uc08yYTkyZVV2RG1JbHR0aDdUZXRJbFFxemRKT3czUU1XR3Zlam1ZRjEw?=
 =?utf-8?B?K2dwUWFnNzRDbUNBVmVUTVdIWEp0WkxFYjhiQ0tCZ0lmTVJHbG9qbEJBbHhw?=
 =?utf-8?B?SjhrOUp4TWg5aWhrbWFtYTk1Yis0a0xKYjYvNHI0LzhYeGxGU016UlIxMjVL?=
 =?utf-8?B?TWxFUDdYVWdaMHdmNm9ZcDBNcFVmV0VDaUd1QjRDV29RTXRMUXBGVmpRcW1R?=
 =?utf-8?B?R2U5L1RaU3JUQzJzclJrR0l3VkN2MEZMVitiQ2gzYWI4aEU4eDhqU0dKbXNw?=
 =?utf-8?B?bktpVGd1a3pRYzI0Y3h0ZEtWLy8yTi8ybXN2cWtCMmx5ejNXWjBuazBVWm8w?=
 =?utf-8?B?YkRGQVMvcTNJNDZjYlpNckNCbjZ3cWEyOXMycWs3WmFkbmZLbGxiYTJFU1dh?=
 =?utf-8?B?dy9TSjQrbDF5WmwzQnFvbWJ6bGxQa1dNTHpNcitjUUI5K251OVI0RkF3NU5v?=
 =?utf-8?B?OVduTkxPUS9KNDFOSDQyeDF0THBzT3llRnhSUXNJWGJ0TlNGM1VkL2kyVU1Z?=
 =?utf-8?Q?Jm3bOKG/VBs+VL8bIWRk5WGDF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cdcbc6-a61d-40d9-f96b-08dc73eece0d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:21:07.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1XhAKgYWy58YsIS0bqjg+C7aQdJ6mNL0A01SpGF9UPHFoQtUOcJQY7Qf46TD/I70s/nVe+XdowkC2/Qdp7tsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

hi, David,

sorry for quite late. we made some fix recently, I will reply your mails
separately.

On Fri, Apr 26, 2024 at 09:34:02AM +0100, David Howells wrote:
> Oliver Sang <oliver.sang@intel.com> wrote:
> 
> > I can pass "sudo bin/lkp install job.yaml" on my local machine with fedora 39
> > now.
> 
> Note that this causes:
> 
> systemd-sysv-generator[23561]: SysV service '/etc/rc.d/init.d/network' lacks a native systemd unit file. ♻️ Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it safe, robust and future-proof. ⚠️ This compatibility logic is deprecated, expect removal soon. ⚠️
> 
> to appear.  What's it doing to the networking settings?  It shouldn't be
> touching those.

we didn't see this. we will try by more reproducers.

> 
> Also, does it have to install its own cifs server?  Can it not be directed to
> my test server that's already set up on another machine?  

sorry, we don't support a remote server now. the whole workflow is setup to run
on a single host.

> And does it have to
> build a kernel?  Can it not use the one that's already running on the machine?

there should be some bug before. no need to build a kernel, the latest lkp-tests
could use local kernel directly.

> 
> David
> 

