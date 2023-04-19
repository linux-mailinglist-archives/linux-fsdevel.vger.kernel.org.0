Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE26E786F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDSLUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjDSLTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:19:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F301544B;
        Wed, 19 Apr 2023 04:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVBpop+mNOvEAArgJWKkWzf2RRdwXrf6i3pBoqhZcAoYdes8Jb0jjYGt+3x3Z4dDFQxMD2oT+kSVn31/e+uyr2zAU5cMzNprDXu87gUQuFHHsEcgeTgKgjBjQzXUqJYd9oYmUNTyZnscWNzJ0soVoFVi/7KB3CSMLNB/ZMP9gMMgRUI30aDpoXRXl2EvJMPJAu+PtEU4cQsWjFoZ12IlEXFaDocVdC3jQlM65icLuZt/mYcay9q5fbVlL9qgLzkAHJll0xx5TG75byNmjc4LHJemUgNJ+HdGTjflmx63fFbyQAPz98b1Vc04a9XM1qXPPTP/mRrneRT8lSNSMRo5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PFXW8vvV1t7Dh+pfPWp/LqlvoBQylDlK3itafqf/zc=;
 b=N0x7O5EK0WJpxDaNEwWqpyHnsWfyGDXhNIQaSctdXV1vmU43xnXgNDBZNL612QTIn/5Ely3gzNoEqLc2RZtRhOQc1V8L3HpRF0vMQz9Xs1gsgSTTdcGiwO2PRw+yKhg4wdAdy8fzUpTKyy3on72mgVj79opncx9CMU4jmMyeiEApesySh6JTb8ms0y9BAaDPvGNFAroFNVLEzhQ0ktBYAFBmWwxWUdj2+UK1LaeqoeKbBfYg6STt9DAynGJnt2zcVPd93LcHKUSakTkN4UDrpagBMGXaYsv/YU49P7IKLR9LAEvb2CWQ3TAgdYE6mOx/NkdTHZMjPR3hR0ZlPATSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PFXW8vvV1t7Dh+pfPWp/LqlvoBQylDlK3itafqf/zc=;
 b=k6SL4qxrECs4Ta1oWSBAVfuMLcWnGq5mtKNtIqvV4MayWPaTelKjHhYSZzKbX32sB6GXW3CK0w3mBe41ymfHCJgBOV81CBEu3DXFcAfO8R5Bma9nBTQZRDNg5vHwmC9jQhVbFkHVIAEIvhtERTKecuVqdVxgyrbRVd3qifwhKFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 11:17:21 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 11:17:21 +0000
Message-ID: <c8952ba3-07cd-90aa-20f2-e24d40599160@amd.com>
Date:   Wed, 19 Apr 2023 16:47:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1770755.1681894451@warthog.procyon.org.uk>
From:   "Jain, Ayush" <ayush.jain3@amd.com>
In-Reply-To: <1770755.1681894451@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 547046d5-8b6c-4435-8418-08db40c7a4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzlnUiLNSvAay4sgBYfNkPp4+4Mll9Hx7wYNrQD7AJ3p8T8J1T8FEPdwNAv4AUrwgqMjBkzek/mKzjutJXA7cBIqCiyNO57zmHexE7aVAeHO5r6IdpRpehyeJqqDtqh0e1rw0qqe2dQX3QaMRD3mlr8osfyOPdzBNjFafowZ1X3h9nRnGabmp6/UjK8NMeiQloQ2r7P0Wx7YZfuJYD8B0iftOg8AS6n/jRyGJwvKhEJ52+lvQkXUqg/XGkrT1Ub37f+OYW1xKe6ezk48n8kgNrpGppGOyIE6H0LBKTx670/1jLlw5d6o5KOeDDKW95GZGLnsOCs/V0ttS+9HcCEtiw4WgnDeER4ZoxbBemVifKGW2mzLEMWso7pg185dSZaqUJJ1t9MUZaq4irib+Hn0PVM2Rh5DhMIp6tB/eAiTDXNXcafikG3WoTmtWCSRRdk9fdNmgG4+xEO6H+WKnkpUHqT0p/QyfT1+nLnt6psg5vMDANt58iACl2YPoF2UQt934bjHNCEK/MPNvVF9Z4O+hVU8m9Pp4cRPpqaIMCeo5vMwf4vAFxTgG+rsSySfna0kTH2wsUlaYpoL/NiYaAe0yfJJFzA0hGkrVt7lVdUWHTrqxKfrKj7Ug91fKAXpPhgr/LCv90c21JDU99f7iugE/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(6512007)(478600001)(6666004)(110136005)(6486002)(54906003)(45080400002)(38100700002)(2906002)(83380400001)(186003)(2616005)(6506007)(53546011)(966005)(36756003)(4326008)(5660300002)(316002)(7416002)(26005)(66556008)(66946007)(86362001)(31686004)(66476007)(31696002)(41300700001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRtdkJxU0EzZ3dUVGR5cy9Qd1hEVWNHMnhCa2Npdm5WdUtTRjBPeEhCL0xT?=
 =?utf-8?B?c2Z6MXBoZ0dzL21rRUdMOG1ZbDREQ1BINy9IZWt5ZFM2b1Z3Ukx5SzFuREtF?=
 =?utf-8?B?L1VFbGU3Z0JLSFBTbWUxS3JGUkFqU2s2YjU2K0xTdjNlOTgxUzRxR3BCWnJ0?=
 =?utf-8?B?MDVlOEFLMXJVMmtGdU52dUpYS3ROTUZRdmk1S3NUN3lldEVYeWNmd1gvWDZJ?=
 =?utf-8?B?cnkwOXNGMDRMa0RXUTM4VlN4S3V5TVdPYWV5WHNPdnVKVFpwTTE4b1E1Zkg2?=
 =?utf-8?B?TTN3a1A3VGcySjZkOGwrNXJzN0N0eXpnSlBqQStKT291TUJmZnpURHFSSDhT?=
 =?utf-8?B?a3RpNno0REV6azFmb0VnTXNLQWNUK3BlZFZTaFlrcVJGNDh5TWJFbU5GOUxn?=
 =?utf-8?B?dWZBV2FDbDNNa1RHeTU3NU55RlVqNUo2ZGp6ZDFzOHhmZ2Q2cVBtSWtTM0Y5?=
 =?utf-8?B?T0FSZmh2RmgzMHEza1Y1K1FNc1BkMGtIRWl3ZDVCK25MSFJqcEk2RjVpd2lw?=
 =?utf-8?B?K0N3cDB4RHRqNnZHSk94ckR2RVZKaDZjb2RaS2J0WlJpdVkySVUrOHZyOHpO?=
 =?utf-8?B?ZkxRT0FPaVhIU1lnRDdRYkU0a3FoK2hBejVDWGRQS0xieXNCS1Q1Smp0WERG?=
 =?utf-8?B?aC9FTzNUVWhCcGFpR3RwajdXTE5vRXFPTG5ZZHdQNXZjVXJLd1hnWDcrMmtl?=
 =?utf-8?B?VVYvMEQrNDF2Q2dBM2VOT0J5WGs5eGhUZWh6ZWVLZWNEaHRrakl6WHBSdDFN?=
 =?utf-8?B?WTVQUk9YWEZNNjJPTjk3MENXRkFSU3NIbkFDa2NSUitYODYrR3NEeDRvMXA0?=
 =?utf-8?B?RWtHM1VieG4xWnFUYmpkWkZJQVFaYVh5cThOOS8zVGh6TmxWbEMwQ3RWUUVD?=
 =?utf-8?B?QTVLdUpSeXowSzdrSEl1N1V2bUhZOVFKc0wvWUlCMHNpUEdsZUtibC95ZzQ2?=
 =?utf-8?B?WnVIS2RCOUUvSlhaK2wxdVdiU2xNSFRMbEhkSWpIQjYvQ3NaOWpnVjJqQTdz?=
 =?utf-8?B?TDJtalVJT0FSVkxLY2R5ZHQyWkRTaTNUblpPS2VENDdSdXY0K29WOUR3bUZN?=
 =?utf-8?B?OVRIQTNKRUg0RlA5NWZQeWZ6WmgyNmF5bTVUZGVGa2JuSFUwajlQVkVsaHhw?=
 =?utf-8?B?NHFqYWkyQmZ6WEJTeW1YaU5la2RhZ1JXMHZXUC9MRWR0SWs3VHBEdHB0anQ5?=
 =?utf-8?B?ZThrKzNiUjV1OFFQbk9NSklvVFpNMWNLTmhma0lHS0pkVlEzMy9MRkpSdzNk?=
 =?utf-8?B?V3gzR3hsaUNJL0JLVTJLc3E3Zk84Ujhua2Y5Y3Z5dXpnTllwQVVjTDh2NEow?=
 =?utf-8?B?NnVmNGYrbFNjN1BBNTlraVB0UUxIejBWRGdVdjUyMXBpOVhSOGtZOFIraDZy?=
 =?utf-8?B?VERtOU44aEN4amVxZVkvRk12VVB0TmszbDdESUN6dW52Z3dwTHgzMmhNZFRV?=
 =?utf-8?B?ZTliQmJkK3EvQjM1eU1XOHJVMGxESGJmeCt0Tlg3bk5DQjRvc1ZsYTRMeWMx?=
 =?utf-8?B?SWVVSU1uN0xrNTd3WTQvdW9jU3ZTaUpLWEw1SzFIclFxN2NpMTAxZWFob2RE?=
 =?utf-8?B?YWdyakIxNkJ0cEJycmt5a0VOdGhhU0tJMTEwNXZJM0tHWnpTclA4MElOVCta?=
 =?utf-8?B?czE4MEFPRmY0TXNBYXRqcUhEUDh2RFl4V284eHBUVGtGUi8xRTdsTUJPUjJR?=
 =?utf-8?B?b0lHL2hqRndVRWNIbS9KaDRrUDMrM1NOQitWMXdmLytBcmttb1NOT3dvcmM2?=
 =?utf-8?B?MFRkMmFudmFFWkZONDhVSEpHYlY0ZnYwTmtFL2ZmMjVER1FGekFhRE5rMjZh?=
 =?utf-8?B?dzRzYzUyM2NQOXgyd0s1YnNvVEFwUXZnVU5OcjR6dVdpOWRwNm1kaTZsdzVm?=
 =?utf-8?B?aHh2ZEJQMUpYNzlqOHZnNHNEdCt3WU53cUxaZmYwS21lMncwcG1uQ2w1WFhF?=
 =?utf-8?B?Wm9sc2dsVlJJenpZcjhJbGtYM0tUbkdUT1hBWVRiK3JqR2JxTU5HTFZwYzN1?=
 =?utf-8?B?R2UwSnpWVHRRNmhPSkJrcFA2ZHhxM3RqcjV3WkJDUHFteDZ6bFp3RHRQdFkr?=
 =?utf-8?B?M3AySTQzeGdXVjJaNXdVNXVBcjUzeC9EVERGZ21BMU4yUjF0eUZtRGFZWThB?=
 =?utf-8?Q?LgWrmopQHF/A1pA4c4QCmV0MX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547046d5-8b6c-4435-8418-08db40c7a4cf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:17:21.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWquE6G8xCHqYHz0dcx90EsTtwnEs9R+NFbf0TmOuXC+SA48TnDxWnM0hT5/jtSD7KtuYzYzhy5DtWGuotzpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

This resolves the Fio-test issue that i reported in
Link: https://lore.kernel.org/r/0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com/

On 4/19/2023 2:24 PM, David Howells wrote:
> Fix the new filemap_splice_read() function to get i_size from
> in->f_mapping->host, not in->f_inode so that it works with block devices
> too (in->f_inode points to the device file, which is typically zero size).
> 
> Fixes: 07073eb01c5f ("splice: Add a func to do a splice from a buffered file without ITER_PIPE")
> Link: https://lore.kernel.org/r/0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com/
> Reported-by: Ayush Jain <ayush.jain3@amd.com>

Tested-by: Ayush Jain <ayush.jain3@amd.com>

> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>   mm/filemap.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 470be06b6096..f86cc8acf33a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2902,7 +2902,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>   	do {
>   		cond_resched();
>   
> -		if (*ppos >= i_size_read(file_inode(in)))
> +		if (*ppos >= i_size_read(in->f_mapping->host))
>   			break;
>   
>   		iocb.ki_pos = *ppos;
> @@ -2918,7 +2918,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>   		 * part of the page is not copied back to userspace (unless
>   		 * another truncate extends the file - this is desired though).
>   		 */
> -		isize = i_size_read(file_inode(in));
> +		isize = i_size_read(in->f_mapping->host);
>   		if (unlikely(*ppos >= isize))
>   			break;
>   		end_offset = min_t(loff_t, isize, *ppos + len);
> 

Regards,
Ayush Jain
