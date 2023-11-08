Return-Path: <linux-fsdevel+bounces-2410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00EA7E5CEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B51E1C208C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336C34CF3;
	Wed,  8 Nov 2023 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1j1VH3h6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4632C89;
	Wed,  8 Nov 2023 18:11:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03051FEB;
	Wed,  8 Nov 2023 10:11:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP6hbzKEt94RF91qr7yEKUZPGtID03YCFc2DGMZXW4f1GFx/NfMlVgAt/KvXS9pdGZ4wWn7AqMrK1I08teeGvaJCkV3RZR9aCNlFEs4URp4gfJE37siXDR384E1inO7VIlJQwQtAY1hR/Ngyh/TIoZDHrM5KPWJQmJMP77MbE4LiVFYB1O0PPtRZdL9T1cOfYl2nVBwG6TWCtP8b7wAtqHXbjXy4OCQ85R16TzW4IUnUTWZoZl3hyPOpp1C1dP0gdgBDzMC96xz3YPGCwVEprHG+bMBxARThB3iUHw4GArIeFqxSX3PmTwciWx8COwazfa6pVtmRgiymblPGmum9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NGUrDccQkRFpTCihMotrCkJcwQY68NbYQwV4BJgL0I=;
 b=NQMP1qHQY46cl4Pr8gyVjBLgjALisXnimcFXjC3yGzyNcFx23MXwYL4Zg5q8Sgn703Bz5+xBKBpCQgHlBIlXh/EAaj3RxCB5MrPcR5mzgoymasR9d7df6jDgTCalTqY+N+U1Z1eHLdbMrYcdXU1XBxqdk4g5aF+2CSXVWgXdbmO7Uhzzf7xYOODVORvpPSP+RwcKKQlgeeUcpLGTxoT6kZJn7pJA1V4hOxvckfkr8NStEBfnjJV9zlTsez8EOsmXPLl4rXfDuml2WX6i4nbGkn1vEcOtoPN9G1/Lb4Gd+XOWYysMBBzPHG/Du52q3bInzekw4fteH4UV2U25bmG+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NGUrDccQkRFpTCihMotrCkJcwQY68NbYQwV4BJgL0I=;
 b=1j1VH3h64Ryre+ulj5cjGzIzjvZ6ghcckjcHTR2Rw14GsueDSgN0gXX/BtXU1c3l4hckXMaXmoLl1oEmvlOOmcQeQxR6w+keAfBBHgI5kh01SJXS4fE8elNcXfWFbF0pu53EaWEkpuRgEteCc/awhIBcAykeTv4yWemeE+9Dv+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 18:11:03 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2%3]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 18:11:03 +0000
Message-ID: <02d731da-5012-43ca-9b79-cbb7b5a55e8d@amd.com>
Date: Wed, 8 Nov 2023 12:11:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v5 3/4] platform/chrome: cros_ec_debugfs: Fix permissions
 for panicinfo
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alexey.kardashevskiy@amd.com" <alexey.kardashevskiy@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-4-avadhut.naik@amd.com>
 <SJ1PR11MB60835765F536429966023B01FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB60835765F536429966023B01FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 556287ed-7123-4c33-1cbe-08dbe08611c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O2YBwMRcFVz88OK1pVpG/a70uSrmdsg+9OmTospsM7j7PhdXbwzHUEMupUoaAnTV5xeI18g+/4/VwqAAK/SVaE6iaIJaF8y52XwGkWWVbD5JXo3zOkWev54oSHG45h3ApqIFhjuY9ajRYaUiJeXVXg5sixdFoY34lSNPUsm/8R6Pux3d0R1aU/Z2xK5h/YV7GUyeP72v1jQ78+qDQwXkflPFDrdHGSs9TAzQA0tbCP8EidJBS0WLi/RJKFnl8PjX7L3QDI+drSUoD35cZGCVN63bnmjnUWCOw8FwhTGgx8hLuFrCteAgR9RzMo01yJpVLNQUwf6f0dIqd7mho4Gs8ZuSnTFmVNpYLzrmpPIY3tEwh2VqcLdbQxTPgTLr+q1Cv99jkoilLxuGC+ysWUwW3RZ+MpwtTFpJxVOWuJSV8k7IvZ74Z+j+uyp7ReKPVwvir1cYMzBxyTXXugjva9Rowf6MpCUIlCaNjyNTRPOKl4JC8NSa53TzpaR19AI72/8MN/zZQLiYFHIqFpdTlMSvnVbSDohumHfSeEYOwTvrrQa9OMCOLBTqdKHmZXKnjpu7N2CIEf9yslxj7uG1vftMyIre1QxnsqQ4nVIoWkFbtcaAvg2Dx42dolgYsXqH8LdT+OugTOC/XHjnGmyKlIor2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(6506007)(6486002)(6512007)(478600001)(66946007)(4744005)(5660300002)(2906002)(316002)(110136005)(8676002)(66556008)(66476007)(4326008)(8936002)(36756003)(53546011)(38100700002)(31696002)(54906003)(41300700001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm11YWJER24zRG9DSStUTGY2aUMzd2QwRG1TVDgrTnpERzAzVklaU1pjYUd5?=
 =?utf-8?B?eEFSeGRidTQzZDZ2emYrSVVnMXpGOVl1amFldWZjSHBrdlcwcmd0c3lFWlJh?=
 =?utf-8?B?SzNJbWExM0dNRkgzdW94ZE9KTVJMWUNRTmtWL1pEVXVsKzJrRy83SU0wQjRF?=
 =?utf-8?B?QTJBZnA2dWxMUW5UUlpQSjlSMTFPZkNPSnhIdEhGNUEzakV2U2JmeE9RZXhV?=
 =?utf-8?B?MktjZEFOakY3SS9NK0Jma2Q3cHdrYTFnTGl2d0NyYVdqc05OK05ncmtqQ3lF?=
 =?utf-8?B?a0NTSWVQaEZ6U2RveVFFbXo4RGp0NjhhMWxzY2laenFHZStuRVBqU0Eyd3Z5?=
 =?utf-8?B?N2Z4NGNraEw2SVNObDZxSXB4T0NNZWRDYlJYbmN5bnZzM21yTkFnN0g5S1l6?=
 =?utf-8?B?QmRSVmFkMkRCV2ZMeUd3Z2YxbUZya1FzU0hTaTRZNFMzeXdCMFp6NXlCSTNZ?=
 =?utf-8?B?bUF4QUh5YWZxeUhFQlV6d2kyMzhrWW1MVm5OTUhST0ZEWTRCZnVtMUI0VjNy?=
 =?utf-8?B?YlU3bGlRMkt6UWd5c0FtYUovU2R6RFF4YmpIaEpiZnB3eU9sdE1DTkQ3bm9Y?=
 =?utf-8?B?OE94bjhNaHdTZlY2eGVsOGhZRmtLQnNPdlZGUFZlY2hNcU1hU1hFVkczZ0VI?=
 =?utf-8?B?eGFZd2Vtb1gxaGhDdWxCckEwV25XS1hoc2NlOVdsM2ViT2QvaklIUlJxV0xw?=
 =?utf-8?B?cGc1VjBnTEk3cTEvMDlCL3RjeXZaMkFvVnVmSkZhMEExZGxVaVBMZXRBU0Iy?=
 =?utf-8?B?RHpHVS9waEE2Yzg1SWFjNTFRUmxabWJtSllQb1k5NTBhVjB6VEZpZDlENGxB?=
 =?utf-8?B?RDRqd1J3SWNWSUVYZFFveTc2QXRQUmowaTVRamVpVjV2ejlXUTA2N0JjajdY?=
 =?utf-8?B?cGRmaHhGQUVsRVR1OGx5UXlRaUY2dTFmYU9maW1QZTQwdVlqanZsVW15SVZO?=
 =?utf-8?B?RUlKT0g1MHFtbWVZczBXOFMvMEpCRGoxd1plV2VsekNJQ0dBaWM1SERXa1d4?=
 =?utf-8?B?L3JCUEVjRkhXTFVMcGZZYi9uR0ViY2pxNGJSU091QVRaaUZEL3RTOHVMNjJE?=
 =?utf-8?B?ajN6NnQ0azJxSnk3c2g0WVFwWmhHak90NHBjN0JSTWUwU25vd1lCVXN6czNL?=
 =?utf-8?B?dzM0eEFkeXE1VGxlZVZkaGFISGVuVHVtYnNtRjNMRkhzUGlwQTdOVjVBaTBM?=
 =?utf-8?B?U3ozWXB0T3dzMnlRNm9sUEFweWFtMlVIam9DRWZxaGxWRmhFdjNrWXVBSENj?=
 =?utf-8?B?QjVLOHdCYi9uK0x0YXBmZGtDN2E4S0U4L3lWc1J0alRHZGVJcEZIbjY4VXhI?=
 =?utf-8?B?VXRuSkd0SWV0b09zck9sbm5hTDZjbjlSc1NzSVZ3NFh3azN3NmxycHJxUjVU?=
 =?utf-8?B?bHBjNm4zd2IwQ0xYNVNTY1BZeTlDZ1BlcmRtak5wOHZINHNnbi9ubUNDRE4y?=
 =?utf-8?B?ZndISE5nSUlMV0tzQXhJV0wwa090TXVLMTU2b1VmY2V5ZHJMWmZkaE1TZXUv?=
 =?utf-8?B?aDFpZnFzRU1jK0VyYUc5ZUt5cGZJUU9WcXV6NU8veFZNT005Q1JzV1JhWVZV?=
 =?utf-8?B?TXhiSm54OGQ5MFJyQjkrRFdQeHk4c0RkbEdKd3pVbmF2WEl3MEdlb2x5S3Rm?=
 =?utf-8?B?LzFIbFN2L1U2QjVJTWxSaHI2QkxaSVdYbHdzMjE5SXBTMDNpejF0c3lYT09w?=
 =?utf-8?B?cW1LL1RHb3VyenZWQmc2YUF6dzJzY3Q4bkRaaE13ZHVyeFhnZnVaVElXa3RQ?=
 =?utf-8?B?K2lrQVB6a3lVWTJaUlJxZWhYTXN1bW5hSERpODFWVHJROTBObnFhZGN0alY0?=
 =?utf-8?B?VEtjSjFVTnROWFFUWEw3ZzFyc0dlOFJYeTg5L0YvNkFocG5xNUFQZmtkNUlZ?=
 =?utf-8?B?dGhaZlFybmEyTU00VjVFU2dVSTkvQS8zVFplR3cwSXEzRGd3eFNPR3NJWkdt?=
 =?utf-8?B?bzRURGdOejBIYnNkUno4QW5CUVNEeWlUQU4zb0pNUXV3WmttcE1neGp0bmFm?=
 =?utf-8?B?RWtuV1ZleE9DSzZueG9aNkhKZVBPWlRWWkVUYmpJWklxRXFDU3BSRzVvejlZ?=
 =?utf-8?B?RXc5aFc2aS80aGZRVnJ4dDNBM0kxR1R3OThCN3FsUlpIZGk4ajJxK0EzblZs?=
 =?utf-8?Q?xJKiItyNyCcgZxu/sqPkx/Y/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556287ed-7123-4c33-1cbe-08dbe08611c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 18:11:03.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0BQGMubiOCfknt814UthS8PES7xSCyhZnf9GrhtoB+U2eeV1HkY9T1WdD+9JnPxwVn3WO2rwaXJYtFEFuJDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

Hi,

On 11/7/2023 16:35, Luck, Tony wrote:
>> @@ -454,7 +454,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>>       debug_info->panicinfo_blob.data = data;
>>       debug_info->panicinfo_blob.size = ret;
>>
>> -     debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
>> +     debugfs_create_blob("panicinfo", 0444, debug_info->dir,
>>                           &debug_info->panicinfo_blob);
>>
> 
> This just looks like a bug that S_IFREG was passed in the "mode" argument.
> 
> Your change in part 2 doesn't really affect much here.
> 
>   debugfs_create_blob()
>     debugfs_create_file_unsafe()
>       __debugfs_create_file()
> 
> which does:
> 
> 	if (!(mode & S_IFMT))
>                 	mode |= S_IFREG;
>         	BUG_ON(!S_ISREG(mode));
> 
> So this is a fine cleanup. But your patch description about ensuring that
> the file remains read-only isn't accurate. Your change didn't affect the mode
> of this file.
> 
Noted. Thanks for the explanation. Will change the patch description accordingly.

> -Tony
> 
> 	

-- 
Thanks,
Avadhut Naik

