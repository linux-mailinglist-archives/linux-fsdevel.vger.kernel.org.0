Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786684C5F53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 23:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiB0WKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiB0WKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:10:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9824F22;
        Sun, 27 Feb 2022 14:09:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCQkr/DYkQefJRpZ2bIWWgSKVONIiizTAoezN0bRTOcA00XQuu0t3tlsIpcRqdEfEsMTagqE3fii7LuJHAd+6YMPPsb0WHU31hpXxdgNweHK+SnWqw3kJu/967xPOQ+HBSn5txzeAQIuqkYmKrrwzLh40l193iz0lG3ckgRHDIlV4Cq1nMJ/skBG0Y3a4rHGC0RyWlP4RgwXWT38yULR+46cqdVmGTc4rcyvkHgkRJfRz2XJkQf2ie+g4oSvM+cB2cQS4EDyMcVt2IIQ7TZWwYMIFXFzWWnt+GoW0z/JNOshGWjiQB1kJuI5fXjkhG0a1XpSHT1lqcgKucs01rNmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVvpbGbsxWABv377xCRIDpfSX7d5LK04prw/XLki82o=;
 b=Wht+F5/em2tDe3UdrYK4Iz/hs5JxDGkEhQPbhPNZVuaKq/wIJp4asDGhvrRuEUu7xccYJJ4cHB0T3GQgRvn+P0u5XBJOPkfaTgk2RaD9xepx+AVMhtbU+19SsjL3+oB6GZclQiLOxdQEIMhiPOk+JieWklYcggUkgoW2usHrAxRVnx0hFKJx5SWFNRBFVJxvzxOnG4vJN5EhMxYiZk/rB1ZYS+0y5TRqYGCrI2isbkiJF7x9Jmgh/41Iyu0MgedfzPbz6g6K8uw67F+UhlH1k/buTlmtVsXkomvWylmm0HsoyC6nORzuN7nDwgx98HjG6VtiqiqCUQcLjE2db9Nu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVvpbGbsxWABv377xCRIDpfSX7d5LK04prw/XLki82o=;
 b=arK0o5O+3nLMxtD8esHsEzLnfAhXSvXe3zwLZIF+sY5P6X7sZi1eQMpo/B/QdufadAGfiJhUwlQcEoZ6wdrcVdpvHjvfXsKr+pOg1O9spkNoWifyj2M+oOJZPKe5V/sQgsmq1CWdlx6+mxknN3GGv3oqaokQjkSQVrR2xui3WBsqgXB0JnN69K+SE1zcquhktjReUQaJy1n+7sgxCRQh3/4t+ANS+uERckxtR3aNgykwW+RhHLE+nwqIIUCf8kfgT5fLG2OFrijcBfWe7hWS4x/be6GX0Lsid8EmSXw/zICeN8DCps3PN8yq6NxVScAkT+CIZcNrngI6ZznXoXh1Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN6PR12MB1314.namprd12.prod.outlook.com (2603:10b6:404:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sun, 27 Feb
 2022 22:09:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Sun, 27 Feb 2022
 22:09:41 +0000
Message-ID: <db3b5263-864e-dbb8-b3d9-075b6283e5bf@nvidia.com>
Date:   Sun, 27 Feb 2022 14:09:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/6] iov_iter: new iov_iter_pin_pages*(), for FOLL_PIN
 pages
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, jhubbard.send.patches@gmail.com,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-3-jhubbard@nvidia.com>
 <06469550-a679-145f-b16e-2f1ffc0b07af@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <06469550-a679-145f-b16e-2f1ffc0b07af@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9db43f-37d6-4d27-e700-08d9fa3dda51
X-MS-TrafficTypeDiagnostic: BN6PR12MB1314:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13144AFB8ECFDDC7D37A403EA8009@BN6PR12MB1314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXbF2c4w54HLNgnsnAQlwGh2Sb4/rnq1ARqvr24Pfbt3M19OaeSF1rDUrts82HCwYucG3lJc1e0AoUL6JeMp53criqvQ99IgBF/pOa4fRqQqQ715bCAu80qV7H1IRkeR1znD/Gy78srp0aRyEfzg3f9lUWMP/lwJsAWvDf8h/Y+B0UxCPcFmMRb4WSErO56Ls4mnWFqmBPbLtpI1gb4iVP9VuIJq3POcm81Yrau+H4TpLjhxPzV4BsKdgqe1wxT6V2t3x3zWyMBXKjwYs86q91OZCGLhrxYtFBDN3BTDMhy6SOUdlSFBY7Hbp6rV3d6OrwSVY4A8oRK1HGmdnJS0bzb7dNs2wdvkEMyr9VtLkbTKI/IgALteNbwaB3zA5agDXt2wKQBrYPYruK91V5kz39JJJSWVxGuciioKEVh6mvJBXmyW7GgBp35T+EZdTIQkHcQMjatZPFZDJVtB/PAIgVsMbhJv4lI9d2mKCFDoNTs1nnbQUZTmGJxkICNRluYsM5y7U3Hw9rRVVaQyYkdnY9cir9XcTnKwfHMSWOp32Tu66gz3kgIa2bEXI45M7szBukjB0mCsfH5GtG9oSlVzszuV5PYnPBDwHPFnYlzDSVqFvk0FRPneljY+miewW6SSN3pj4dmwwIWwbi21YBWeRAVR+ZnnIMFXd/QfthreDr+uNe79Q39OMTildzjmu46ygp0JjyPy7eve74X4ha+9try6s/2DCnVd0y8clkLdDVcSGmLh0a7OnSS/3wRxFrOk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(31696002)(2616005)(7416002)(921005)(36756003)(5660300002)(4326008)(86362001)(316002)(4744005)(6486002)(110136005)(508600001)(6636002)(66476007)(6506007)(38100700002)(8676002)(66556008)(53546011)(31686004)(8936002)(186003)(26005)(6512007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFQaUNtN1R4VVlTL0sxbUNaV2ErUForUElsRGgzZTlyVnhObHZUcWJaZSs3?=
 =?utf-8?B?d3dwZ3J5ZHNveGgzQ0k0cHczOHZKeXZhQ0p0elVPRkVlYXdhZHJnc1BBNVli?=
 =?utf-8?B?KytmbS9QRFJBZTRCSUN0cXA3bXlvajhkOEJrNXpLTDF0YVZSaG4xRnZUNkI2?=
 =?utf-8?B?cVI5aVh5SmxFcTFYZXRQQ2dTQTF0UWlINlgvalRRaUJGQ2ZNZ1cwL0tiRENP?=
 =?utf-8?B?NnJRRHVzVjhLaktnaTg3cUl4WXlQL1pZRnRNUkt3elRxZHJkQTZvV3B2ZVM5?=
 =?utf-8?B?SGZsR01VdE55WTFLTmJHQ3RTQjVBYUtGc1VwTTNDTTBSWmJYN2wyWFY5dDgr?=
 =?utf-8?B?MlF3Tkx0TUtIV2c4UzFkWlBaUXVSd2RuMEQ5MHpsK21BSFJuam5JNmQwUFA3?=
 =?utf-8?B?TjRleG9pTk9ZTlNNcHVVVHc3ZC9TSWJ4dHQ5N3hZandFSitkbkxRWVYyRFdw?=
 =?utf-8?B?cENQSDJ1TURZc0dGRFNYeS9QenJyWGFReGhTYUFSZ0ZEWXpaYU1neUVqT0dn?=
 =?utf-8?B?RWpZTHRyV0tkZVdKWjZ4L1NPeFIwZUhGVGxCdzBUaWwvV2ZVckFTMlNmRnRh?=
 =?utf-8?B?eVZrRFYyZ3NXcUJYZVBHNFhna0hqUUQ4bG5mVWdGSlFBWnhJNXhYaEZnMCtj?=
 =?utf-8?B?YVIvU3F6M3pyRlk0MUw3ZHE5WXRnQXVNcDg1N0VDY0o1azNCWmJpRVBkK0g1?=
 =?utf-8?B?SnJ5OWdCbkJMYmpnbzgxM01uTzFlcXVtaFJMbDkrK2JrYkpiUWY4bktXQXJM?=
 =?utf-8?B?bklwZXFwWlJEZnFVcmtKNDFrZ0FUamtTdlFkcEhSMGVjYU5yYkxSenBheWsx?=
 =?utf-8?B?ajJhcy9RSElPamR1Q3I5VG9vaXBXVTJnNWpadUJpSVJOVGQ2bXh4aDdCaVpZ?=
 =?utf-8?B?aUdJRTEyWW1VZGRHUjh1QlI4d3NGcnRUbUp1M2llcXgvWDRMaEIwNGJkdC9G?=
 =?utf-8?B?Z1NlVXdlMktreXBDK1VzbWl3d3dYWXBEaWk0WFArNXVSR3l1Qk0zVFN4NVMx?=
 =?utf-8?B?blhVRzF2cFNMNU1hKzhsbnVZT2tvZnJNR0RScHN6QS9ocTNRSHJhZmZSVVoy?=
 =?utf-8?B?K0t3MFNka2dxT0FJMm91RnRWOUN6UURsV0gwd1pxcjZtZmYwaEFKbUZTZ1h5?=
 =?utf-8?B?Zm5ZUFVMbzdmMHN6a01xeFZMNldPbzdmeXpHbTlDVmxJaDNPNHQwUlQxRnFz?=
 =?utf-8?B?c0NTMzlvYW0xZlNHMXJjQVR3UjQ5NUI5QTcwcFFmcWV0STFESnRNMTNWYmc1?=
 =?utf-8?B?NldVSTVzVmhiY0hvbHJGeU4zdFFvTm1aeFdoSnh0SnUwZENCNFhUUlRHdWd0?=
 =?utf-8?B?TlV3L1FFVEpqbDVWbTF6Q0hGc0l3NGVRaDYrcE9yT3N5b25LaEpuclJLeHlr?=
 =?utf-8?B?MG1QOUcrU2JFOHJHbVdISitMeXFTWENsVmFWTWh6K0FGNURCZjJrYlNEWU9C?=
 =?utf-8?B?UjFoelpEUUl6dllEcCtkS3lRYStzakZRMUIzYmU1Y253aHNkd1U0Yk16Sml1?=
 =?utf-8?B?V3lielpoanBRZXBocE90RU9WZndMOVhIVXROSjRQQmdlRVZHNDA1d1J1THg4?=
 =?utf-8?B?TjZyeUxTRnQ4VDBsdlJUcXFqYVZ4RFBkb0xzNHZUd2Q5T1RGcFM4Q2cxdUtl?=
 =?utf-8?B?UVpPcXlHWm1odDNWZ3l1L0JoZWtHUTJWamh3eEo4VFlINjc5VG1QL3UzL1Y5?=
 =?utf-8?B?V09yenBSRzRvR25BNVU2TDBDRk03aENwdDRxQml1cjhBQWFheWVKdk9DSHBy?=
 =?utf-8?B?OEVyVXZNVFNnQ1ZtMkYydWw1bi9xYlJ0Q2xYZkJFUG1UQzZjZXVuUXEvQVZP?=
 =?utf-8?B?VW9LMTFhZklzQTIyZVVielpadnVRR2lzek1ZcXZIdlpsQ0s2YmRDOU5rcGNV?=
 =?utf-8?B?MjhKRkJmK2h5MDVOd0xZNE04c21nVkJnaUxqcXJNRHFDb1NuTjY5QlZ0WW9T?=
 =?utf-8?B?K203QWM5VXc4NzBGbG95NjRqcy9QZzQrRWtUWnY4ZlNPMVZ1b2xyOUFNckJN?=
 =?utf-8?B?QkJYYnV6NUN2QU1hMVc4SXJiYkJ3QlUxYU9nZ241RS9RQkp6eFE2K1RmaVRk?=
 =?utf-8?B?MDN1VURuT1hnamJLR2x2dkpIeWpybGxoQ0VCMjFQK1pOdzU3K1J4Yi90bk1O?=
 =?utf-8?B?TEpoWEV3aFVrTVFYaEtTNlRBVWRBM2tkcGRiN045ZHF3RktZUVpWcG1lUXdk?=
 =?utf-8?Q?DF3eBhgQ1Tpp15jH3ED/SX0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9db43f-37d6-4d27-e700-08d9fa3dda51
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 22:09:41.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp0WmL6T7pHskJyyxQAywJ0zCDE3KthmlufccWPw6SqmBRD4w2oHIgjrGWggNubtaNnECk9w0G2kQ8z1rVHx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1314
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/22 13:57, Jens Axboe wrote:
...
>> +			return res;
>> +		return (res == n ? len : res * PAGE_SIZE) - *start;
> 
> Trying to be clever like that just makes the code a lot less readable. I
> should not have to reason about a return value. Same in the other
> function.
> 

No argument there. This was shamelessly lifted from
iov_iter_get_pages(), and I initially calculated that keeping it
identical to that known-good code, where possible, was better than
fixing it up.

However, I'll go ahead and simplify it--with pleasure--based on this
feedback.


thanks,
-- 
John Hubbard
NVIDIA
