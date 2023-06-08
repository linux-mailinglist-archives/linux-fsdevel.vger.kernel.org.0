Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC467275F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 06:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjFHECu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 00:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjFHECr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:02:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BD10EA;
        Wed,  7 Jun 2023 21:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXph4IgRKeRgh0qmQqhFfw7U/ComRB6DvcSaA4W4Wc52B+y5aWsRypN8c+xeluTh2QUDyoxLuTVfs4gmPewZLDq2xGE83mjl2TH1lWHMyCITz4cu7Pad6IRuFmA/ecmE39GlXSlsjQgcPelDO7TaCeAUxv4Vdjrm3chZGdI8y2i7y0hUanX5qvuXMmld376bvBgwOmgRZQDBx2NVxOYM7yHck2wSLHHTiB6FUbCyfhPrKsiQW3xNbvCgGUp7MVxTWJJ+58Uq22My+NynV6JnVQzxbXKQAcRRJp6TF18MBwn9+j/r06jYh5ySr1fSfmsBGQupbAzrVeQP1QJjULdRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAtE6KU8YF/qEVKn0/iDmz8xKM6asMpK+qXfho9HpCk=;
 b=gzS/4eUQEYgatCDperpCQRJ0MFDXjP1S2n7ocMpEJCvdgu1wDAOcY8ZzWdDgx9yLk6cVeIvxr6Wt9F6WB2jBPoDCvVDF8Ge4Odj/qMl4bmZmS8JpQRZZ/MjbTGBvPYQmS6C/on0YT1BVPgQd/MTxaIPxs+zN4zApgbkVvKQFhIPGQ1PTXk2HXRQOlpr483zO/Rcv7ZV4OYPUtJVtvaFE1OKRrXrVB8lO7NP2WiK3mU1D2Kwxqu284JIu9eJ/rEtFxnXEMUGbG6VeEf9GTBrKFkSsm40t71UvPgLlgDO9EiLe75RhCLrrG10cqND7KJLwA8iXAvc1QhFxhp9byp69sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAtE6KU8YF/qEVKn0/iDmz8xKM6asMpK+qXfho9HpCk=;
 b=k1vIIsXnR9msm1ImA3mGIc0MiI0plkDyRFGTxLlAikwgmbVR0AMi0B2W5SpUSnRkVup+yW3AMYbvMxE/2E04P9RFukrn0Clftl6xEmBmveYY3e9TmKgfgjhf8VGeMTd/XhuYtYJ8IUBmvzT5WhxpLbv9HrGg2T8PMyRxYSmXSU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 04:02:40 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:02:39 +0000
Message-ID: <a310a133-8d4e-0870-adef-0b7b47a452e7@amd.com>
Date:   Thu, 8 Jun 2023 14:02:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 2/3] fs: debugfs: Add write functionality to
 debugfs blobs
Content-Language: en-US
To:     Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     avadnaik@amd.com, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-3-Avadhut.Naik@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230525204422.4754-3-Avadhut.Naik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0117.ausprd01.prod.outlook.com
 (2603:10c6:10:1::33) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: c5896d16-6e46-458a-31a4-08db67d533a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2Kxm9mN1XrtN8Ac3zHLk6LjCSb6hqXt0PxjqTmDn0N7bzcr6DRsh0drJiL9ADwl5hIz66wMHfC0+O2C+/7MDf6IWpKR5RHln50xYdXQRDzDlNC8C6DomzO9fGmvpPFtBFEqplU+BEaNcIVatJL45KCPnTwWFn1yBged5PoShyqFhyEfwh9i+bVQFDTGU19jYysn0ZVxzniPKbB/Dlh1QQ6O4dVBdg2qIJLqTEKGSu4lj3dx9CNfMue9IkIn4Wbf82YrZSyodfey25ZWrWTayTR4Ox1AEzvBwh2v422TmFgsWJc46jxeD5GqIKI++2gI+mdTVQQSHvEfqa1DxyHdHCSKu6HNJCjO+VJwinQRowGjhKnWdUq4BMndREB+WQT9WnAnhbudYQJXJeZyKyusriBd+XyoMM1aXVA6GPYGg0xfRYM9y1sOOKy/qB8AqSCZy+88GOOFN5KDVjE2B20pNtJ4GIMYUBeZSDP6bs04V3kOd7w/GdyB/eLSM8cnxlYYyU1gwkdy3E0T5fWSSM+rkFq5eqQ1pDm4TsSrpjgOB8nlKbdWMwMfONxGynNRx6qDUVsbEKod9obOaA8eo4Cswz0DLHChVWTSky3Sz5yP22swLc/ie5vkSlAN9//TACML5hwxxx+qAKC3zePqHLsMRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(5660300002)(31686004)(186003)(31696002)(26005)(6512007)(6506007)(53546011)(2906002)(36756003)(316002)(8676002)(8936002)(41300700001)(38100700002)(66476007)(66556008)(66946007)(478600001)(6486002)(4326008)(2616005)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1h4TExPbDMxcXVNRkxyY3lvNitPeXcvWk82ZVhseHdYUkNqNXIvcU81TXB4?=
 =?utf-8?B?dUlodi9uUGRSQVg3SC8vWnF3Y2JPYVRmcC9SbUNsN3hZcVdhcGxTOTFZWGhw?=
 =?utf-8?B?empZWE5NS0xoWXdVMEhleGR4Y2ZDWkVVcUFGc1ZoMGZtT3drRE1NVXY0ZGw1?=
 =?utf-8?B?cjhjRHlIajVyQmlaNFlUbFVmOGRUMzNFL0hBbUJzaHFhNnRXT3R3NFdITnBs?=
 =?utf-8?B?Mys3akZ6b2kzemNLN2YreXloOUg4WDlLNDh6TmpCKzlpZVZsei9tRFQ0eSt6?=
 =?utf-8?B?Uks3RmRIVW01K2twaW1jRitGU3RMamdRTlQ0V1BIM0YyTmpRMCsrMXhJOTZM?=
 =?utf-8?B?cUh0RkNiLzY3NUN0QVdub0ZuRjB5d3JnQzJLYktnb0ZtR3BjU3Z1UDlReDkw?=
 =?utf-8?B?ZHdJQU5xNTQ5OFM3dlJtOHpxdFpMTFQ1ZEhOUnNCaWtURUoxUnNOZXRmaHV2?=
 =?utf-8?B?TlhoQlZZR1gweVpXVEZDYVdCM0tueVRIME1CdytRb1ZlTm9UTkE3cUFtZGY3?=
 =?utf-8?B?QnFydFJCMDVIUGxhTm1MR0gxR2tIVGpXNGpJUWtlM3ZHUjQ1ZnVRamxuRy8w?=
 =?utf-8?B?S2NHbTByUzRoSUtrbkwrdS9aampvMHl5aE8wUE45NDVvbGFmZFRMR3AxdnRP?=
 =?utf-8?B?UkhHL0tXcUVQSnlOM0lGbUZnNnVtTTJyYmQ3eXZSMTkzem43TG5tQ3B4Q3lK?=
 =?utf-8?B?VTRadWpMcmJEQXBwM0ErWjZPS01VU2tJTDUrbCsxWjM2V1V6dC9KRlBYYThY?=
 =?utf-8?B?STBNdEsyUVBxOW1jWG50V1NIaVhQbkdkbThZN1hZbmFCS1cxV0JkT2ZTS093?=
 =?utf-8?B?aFdaR2xYeVFIdFdDVW5Ldy81akFDRkk5NmRlTnVEU0djaVhEbXlaR0hvSlBw?=
 =?utf-8?B?OVhGRzI0WGdLb1hId00yNDlWRDhMS3VlRkdwNXNQcWtFTFo5VEdDNnVNciti?=
 =?utf-8?B?S051MURkYkFCamZYbkI5Y2cxU09xRG92NWh4M0J2MnYzRFFwMjBOeVdPeHpD?=
 =?utf-8?B?THdqdU15ZU9CSjNxdlBlczhyb2xROWl4ekZpNGFvNXdWeXBiL2VVV2JWM2w0?=
 =?utf-8?B?SVRxNWRKVmQ3V0dTc1lEZk02SFAwcUNidWhsbGtQSnJRY0dkQkJESXF0YzJF?=
 =?utf-8?B?ZFlod2o2RzJiMC9icCtyYWt3REY0azNmOGFQOTlFL0pETGlvQUVMcXF3aUZq?=
 =?utf-8?B?VGRET2d3Q0lJd2xsUksvVDd4NTVUWnJ5eHBleUNNUnc0ZDhHdjFOL20zc2dL?=
 =?utf-8?B?ZXVsTE00NnV5N2IrUjN4T05wbkdSOGxyWWo2TUtxZWNqZ0h4Z1RWaVduMURW?=
 =?utf-8?B?aUhtTkdMczIvMEdMa29qNEJUUHFaS29IekZJRGdoZi8yK3BXY1MrQkZRRnhR?=
 =?utf-8?B?OVhyQU0zbWFwaUM3emswNEVYb0pLL2JrY3pGcjdlMFBabjdwUDhLcGtOYmd4?=
 =?utf-8?B?dDNVS2ZuN2NKTUJ6cTE3MnVoWmk2RnkyZDdvZmczN2xwQmEyd1Z5OFhGaUQ4?=
 =?utf-8?B?NWlOM0RxWnNiSFFNYXRGa2JCRjBnUmFuMXNSTkZHekgraGltZUVXRWEzdGZo?=
 =?utf-8?B?NG44MkhXL3pDVVRmdE42VEM4UmVpNjZQRVpSOVZRRnBURGJqcjZmc255anFx?=
 =?utf-8?B?NVhKUW9mdUpEN082MldSM0lRVEtZcGZaN2M0R1FPQVFod0dQRUk0dHk4RnpY?=
 =?utf-8?B?ZE1rRVpZajFzaEtUUmJ3Y3EvWTBYZnY5eTBLd2x4TFBGOThGNmFKeEtrNkVw?=
 =?utf-8?B?Y1Fpano4UjBJWDNtZFZ6bi9DTXI4WVJzODZvSGI3ZzYwa2xudjdPT2ZvZ3BH?=
 =?utf-8?B?QWhGY2pBajQwTTA1YnFqSy8xV3YyRFRpYzl4NjM0OXBlazd5MGh6OHhyT1ph?=
 =?utf-8?B?b3BsaHU5STlROEE1b0c4aGZieXJiLzh2MzVaYUFjcHppZEp6eVJMM2xDc3BB?=
 =?utf-8?B?Sjl6UzhTRVNScjRaK0d1QTBZT3NacERJUmFRU3dNK3hxVEw1dUp0N3JsTXBQ?=
 =?utf-8?B?MXlDbDdNUTFmNDE2aFF0T1FwSTBBOUlkNlBMZWdoY0taOW5qZTFlaUZiM2tK?=
 =?utf-8?B?bzNYdFo2eUhXOWp0b2lHQmIvYTJ6c2NYWFRBa3pCRnZTbC9HamJrd1RuQ1J6?=
 =?utf-8?Q?SxoURPTkg6oAHPdtOlL9Ksxo9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5896d16-6e46-458a-31a4-08db67d533a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:02:39.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuFkki4NTL1IwHwDyfr2+I+nk+v6TYXpUHimJZkzbCgGBUMId4NLWtzNOgKcpYhpKCusBtTLsLYlBBCV8uPM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/5/23 06:44, Avadhut Naik wrote:
> Currently, debugfs_create_blob() creates read-only debugfs binary blob
> files.
> 
> In some cases, however, userspace tools need to write variable length
> data structures into predetermined memory addresses. An example is when
> injecting Vendor-defined error types through the einj module. In such
> cases, the functionality to write to these blob files in debugfs would
> be desired since the mapping aspect can be handled within the modules
> with userspace tools only needing to write into the blob files.
> 
> Implement a write callback to enable writing to these blob files in
> debugfs.
> 
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

> ---
>   fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..fab5a562b57c 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -973,17 +973,35 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
>   	return r;
>   }
>   
> +static ssize_t write_file_blob(struct file *file, const char __user *user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct debugfs_blob_wrapper *blob = file->private_data;
> +	struct dentry *dentry = F_DENTRY(file);
> +	ssize_t r;
> +
> +	r = debugfs_file_get(dentry);
> +	if (unlikely(r))
> +		return r;
> +	r = simple_write_to_buffer(blob->data, blob->size, ppos, user_buf,
> +				   count);
> +
> +	debugfs_file_put(dentry);
> +	return r;
> +}
> +
>   static const struct file_operations fops_blob = {
>   	.read =		read_file_blob,
> +	.write =	write_file_blob,
>   	.open =		simple_open,
>   	.llseek =	default_llseek,
>   };
>   
>   /**
> - * debugfs_create_blob - create a debugfs file that is used to read a binary blob
> + * debugfs_create_blob - create a debugfs file that is used to read and write
> + * a binary blob
>    * @name: a pointer to a string containing the name of the file to create.
> - * @mode: the read permission that the file should have (other permissions are
> - *	  masked out)
> + * @mode: the permission that the file should have
>    * @parent: a pointer to the parent dentry for this file.  This should be a
>    *          directory dentry if set.  If this parameter is %NULL, then the
>    *          file will be created in the root of the debugfs filesystem.
> @@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
>    *
>    * This function creates a file in debugfs with the given name that exports
>    * @blob->data as a binary blob. If the @mode variable is so set it can be
> - * read from. Writing is not supported.
> + * read from and written to.
>    *
>    * This function will return a pointer to a dentry if it succeeds.  This
>    * pointer must be passed to the debugfs_remove() function when the file is
> @@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>   				   struct dentry *parent,
>   				   struct debugfs_blob_wrapper *blob)
>   {
> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
>   }
>   EXPORT_SYMBOL_GPL(debugfs_create_blob);
>   

-- 
Alexey
