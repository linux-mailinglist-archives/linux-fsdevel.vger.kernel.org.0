Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142824C5F6B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 23:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiB0W2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 17:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0W2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:28:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376011707D;
        Sun, 27 Feb 2022 14:27:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGFuRKYHWCKzAcZoqYGeEGUecmD54JUvLX/xZw5J8paSvvUYckPy9ci9elClWAn+SfM4UHxvOny4BfFTtrc0wu/veMWNrLbfM/H3YZOdlP12hSiRnkcIRJZOTWGCkKOu2M+1bF389vt7Aw/PV8/i1vN0bXZcgl4mOlJBpCPhpGjqpKkLhUQv+7K9MDq9CYN7PJ9sJTl152nGJZF0OqiJOCGIXSEesafZ2nhmKNjClHVmPGEvVi1usnQJrxBgQVamD2lQ1REcF3Yx0fo1OHtq0/HaBpmYQo4H0j82EeprmiB4vxmh6FXGl4xszTrPnsFiv5d+aYnrDldfXpFTRtWphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnY7949FvYDcJbLVPGhZM1RF+ByhXo0mPw4/HTjanPs=;
 b=MXoeIlLdcv8bDbZIaqx1AuV+zvUMoZ5rDDm479SUYf5/MRCcmdwKxTRw8nbdmdHuCPl7S3sVyecE+bV/UfCaxjkzzqOfRcfBmM7micofruRpiF7ICb8XgpLqXk7ciBju360kM4vloxvL8szT4PP0AsrG40YKkDkSTIZoHM09LnSjlpjBNGe5MtLTlY2RcGHAlNWCChakNIcb9HSpHfqsY7RBPoUPwbgTJTmITlDo1kYPyDmDzGNC47J5cKta6ynPEIEmuMya49v2npoLYzlTBKdDLdYSY/gJ1gEb6PIdC59Cy1cfj1q5UNq1UhWQrHc+EPCNzgIYbpcGK0l6z+UDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnY7949FvYDcJbLVPGhZM1RF+ByhXo0mPw4/HTjanPs=;
 b=a+upiMUMytyczpKD7BpGO0OiveUy8faMDiCpvY7CtyCZIicuYzykAmi3cEoNvJybt2CrdLWF/04JHvGXXj45GuYUGAN6nyR25YORggm9S+/iEj2ZY2SlAF9ujmbkvrCjJgxoqGtJLWwvopZYadrzClaB0JBxzEiqoVbdWyRjEnjRSYxFCzAz/S39HsnyefX8O3XQhc6WopZbGN3xzjcp4B02WCvOmtVVd1le9By6uO1GD9f3BhgQ25m0PHGmB7S+hgapqWGI/afbK4jG+hZb8auwGefUmD/PLlTcB3fQhFOR/zmwDs3w61xIfmrWl5/uMtNLgFE/As3g65U+j7kkXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Sun, 27 Feb
 2022 22:27:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Sun, 27 Feb 2022
 22:27:54 +0000
Message-ID: <86ce63dd-f6b0-e7b9-c4e6-6b15dc8b32a0@nvidia.com>
Date:   Sun, 27 Feb 2022 14:27:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/6] block, fs: assert that key paths use iovecs, and
 nothing else
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, jhubbard.send.patches@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-4-jhubbard@nvidia.com>
 <Yhv39J4+FwD/B2aJ@zeniv-ca.linux.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yhv39J4+FwD/B2aJ@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afc3d6a-4b53-4149-1453-08d9fa40660a
X-MS-TrafficTypeDiagnostic: LV2PR12MB5942:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5942020143774F35C289DFDDA8009@LV2PR12MB5942.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSIwFFbQxf91X/z138o+8CPlGwjfRthyXzlesjj6cK7CNCTQ8RWSvxfkdinHFGBQJ9oKga6DhTzIfhXbLxbj4eXXg48p4ALz0anMsCP66p/mR1HBwrn2nk6rriJBB+5aiXtzVoIOI9gssg2wN73loFAFPbx8nEB2SeLfiufAjCuzRAUWIQVqnGqPBHGQ+fRjvqHniqFZp0uK/vJ2wvwwKVADn+/I5aTH81oZwpJy7tkiEatV0OatC4zc/wISvGvIwmWqIxBakryyS78jScrImz17J3dF0XcIMjax9ftUDIJRn6q5M7THbIAon5DMqFXYDNAL/ssUjNwCTbgyhy0vOOLJkTIL1mq1pIuRKMQ/duFouMqJQpAgyJZHmjIPpiJ+BrkXMzugYOs3OhFmY5pPCZWwQ7zYMy8/Gow3gNIkxVVfrox9w230w2TdJHpz6AHLH4hVsnoEsXSNPfYTlJqftRtk1hF6BGPBsoYEv4JcdFCt/nJUJx+O63EgnUxSx7dDId6nd+1DK4Dn3ES+rB72aCWukMnLuT1qNAMY3QpETQu43bEHnaMVwQtX9SUQvCoQelodhCOUehL4I2S055R79SVVi5VVH1wbftUvkzX9jh98kET6iaOSdyi1dNR5FiJa/F8aIDbzRnX14H118FzG7nkVqoJ9ILsbRapLNjgomsdjbUlOP4mc1b1jQGaJeylYDHgDnR2DsvmT3ZnLTS68xzeC0mVovh1FDhS187sY30yOedCaESqlH+BZnjdF8VF1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(5660300002)(4326008)(8676002)(36756003)(6512007)(54906003)(508600001)(66946007)(8936002)(66556008)(66476007)(53546011)(6486002)(6506007)(31696002)(86362001)(2616005)(7416002)(186003)(2906002)(26005)(83380400001)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVQwam16WlVlSFdtNm5qNkdYdWlOMTMzZHVDTjhrY1RldDBwNHBMNE51aU1F?=
 =?utf-8?B?SHE3VG90WHV5QzJMeHlMSnVaQlVmaXpuekI5K3Mvd2ZYRHZ5Nml5R3lONmpn?=
 =?utf-8?B?SU9HZS9XZ3FHTHM2YnZYYXhwM0tCMmxmTHVuaG5KbGZBeDE1cjhGbThETWtY?=
 =?utf-8?B?aDIxZC81R1NMcHJ0bmdYZGNrOEIzTFpXdzM4TGJCQlFRSW8wWnEyd3owbnVD?=
 =?utf-8?B?emV1c1VCV0pOU1VCVjZEcEl3bnlTcGZsMDFHSWYvWEpJUG5WcFdVSFFCU1pH?=
 =?utf-8?B?c2wxeUpqSUFUb2ZIQTBwclRDQkVENCs5VUluNGtvWGlZczA2QWNTL2hJR1F5?=
 =?utf-8?B?NGZ4RCtUN2RPOEMvUVh0SkkwVVI1U1FIc3VzYmhBNEJnT0N5czEzTitYaUJ0?=
 =?utf-8?B?SGdNVm9sa3ZiTEMxTW4xRDVTSVdPWU9SY01XK2hUbnQxb2UwWExpcWpNcS9a?=
 =?utf-8?B?NXcramJKM3dUR092SzFxSUNqTllsb0xjN0NLZnFGTmNqK2Q1RjdRRTJNR2tP?=
 =?utf-8?B?UXdzZW1tbEpjU3Nxc0lRbHpHWXczUnJTY2hpTTdoNzBla1RDZjFXaXJtVGFz?=
 =?utf-8?B?L1FCY1VhMksxVm56QTYzMmtJTy80akNyQjZaUkhQVklZazE1MDlWYWd4RitD?=
 =?utf-8?B?U0srUGhkeXBTMTROcUxhalMvV3VOZWk0ekJSNHpqMUtVa255OCtEUDVuTDNo?=
 =?utf-8?B?OERXMGZSeWdwc1VwTW9zbXhsK0t4UTI0SEJUMGJqQjFUeDZsc3E2cDNLWmdX?=
 =?utf-8?B?YlhiK1R0V2IrVTlyWm5RNHAwTUxRdHJobWRBY0xPM0Fwc1ptQm5jK0NXK3gx?=
 =?utf-8?B?U2hlQjBoSTZsOGxVU1JsMDU4YnFCb0VGVE42MlpXejNLQjF4VmtDdzZ4OFpl?=
 =?utf-8?B?SmxEaTNpMW51ZG1UZ3N3TzVUdklNWmdWN3E0T3NwVnZGb0l6VGhSUC9BWGJr?=
 =?utf-8?B?VzJSdzJIcDNVcldBRElIZG9hQ2EvVmkvVVpQT1owUDlub3hwWHdEOVg0SWtF?=
 =?utf-8?B?KzFnZTBRNnVUVHZJNmQ3blpIdE44Y0gxdkRUSndLYWpkNWlhT0oybnpYdXA3?=
 =?utf-8?B?VnFESXFqWjJJUGt0TEJYYVp3eGYyWDJSVm5XZGRsNFlERmVMNUwzR1lwNmg0?=
 =?utf-8?B?RmZrZXJWTldld2xjTi9OWjU4dmdXUnRyd1pPZXNaVHlTaUlQMVdTZFhtSWpD?=
 =?utf-8?B?NUZDbVhyTVFtK2pYTkxtUWNOR0ZFUXVYbDJ2bVVjeEJyU2lYbzV3d0llUFVK?=
 =?utf-8?B?Zk50K2xiQzJwemFOdGtkZ2szbEN2S2NJaXV2aHFiZ0JrNmFSaHAwZGp5ZWhP?=
 =?utf-8?B?SjJoKy9aWnpxQVh1QkFTQzJrY0hOKzQwMTdpVDRqTXhXUDNYa3ZCWG1BS2RF?=
 =?utf-8?B?aDY5cFA0RmhMT295ZHdHY0dra0tZSGxBMGorSXpoZFIvckN4MDhEVXdkdmFS?=
 =?utf-8?B?S1pxbEIxT3k1TVYzSDFxQUFjSDhHQjVkeE53VFBlSkp1NG9TSUFTdU5qbUxy?=
 =?utf-8?B?c2Q1VU5pNWxQSDlhODFiUlpncUVZdHlsQVA2K3BONE5oa1pGV3ZLSXhnRVRy?=
 =?utf-8?B?RVNjYXRpNWRBbFJxY3BPazdIdjRQWlpNdTBwaEYwTDJlbTJuM00rcmRZT3Nm?=
 =?utf-8?B?ZDBMUUdmdXBXZTcrcW41cDRxd3RYUGMvT2RySUZwSDFadjRDZWhvcEhXVGVJ?=
 =?utf-8?B?NWxCaWMrcmxoM1FYMlV1UnluamRCRm8xRzFNd2N3WGZwdHNySG5zdVQveUZw?=
 =?utf-8?B?Mk1Ca21qbWtkTUFMWi9GN0dQYkhHZ1lMcEVvUmNKbmY2bnd3OTg0ZzF2Z2py?=
 =?utf-8?B?RXhLZzFoWE9WSmpBM3ZBRXBwUThaZ2ZHNloxUmcza0lrZkhjdk5wb2RXT3JR?=
 =?utf-8?B?NEU0b0FMTmVsRnYwbXZXMHZ5ZXFnVGZaM1RMeFViMWNLeURiNWE1VlhPRlFq?=
 =?utf-8?B?ZXAxSmx2ekszS1lybVZxVkRCemlLdDdZL3BpM3lFWWt1bEZxTDZGQTQ1WXl4?=
 =?utf-8?B?OXdjTnY3Z1RpYU9YanJJZklpb2Rld1dRMkhvTHMrYjNBV1BGM0VEUG1wZlFj?=
 =?utf-8?B?VjQzYXpFV01EcEFLcVcrVFlyU1dWV0ZibENJL3FwUWc1RmZJODlXY2QzcTQx?=
 =?utf-8?B?bCtvRXlYQVNCb3RzOEtJeS9YVXRvb0ZJQmUvWXNtMWtOV2VVME5iWlpVbXpO?=
 =?utf-8?Q?G9WuvAvkA03Rhlz5Oo2FCTQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afc3d6a-4b53-4149-1453-08d9fa40660a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 22:27:54.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpZEbfmoZTWOM4jExPCt7d8TjVqAqhiPRfoxHyFPD0WBOw0ELZm5eboLmPi7w3X3gOVS670fExJHjEcw0pPTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

On 2/27/22 14:15, Al Viro wrote:
> On Sun, Feb 27, 2022 at 01:34:31AM -0800, jhubbard.send.patches@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Upcoming changes to Direct IO will change it from acquiring pages via
>> get_user_pages_fast(), to calling pin_user_pages_fast() instead.
>>
>> Place a few assertions at key points, that the pages are IOVEC (user
>> pages), to enforce the assumptions that there are no kernel or pipe or
>> other odd variations being passed.
> 
> Umm...  And what should happen when O_DIRECT file gets passed to splice()?

Hi Al,

First of all, full disclosure: I still haven't worked through how
splice() handles pages in all cases. I was hoping to defer it, by
limiting this series to not *all* of the original callers of
iov_iter_get_pages*().

This series leaves the splice() code pointing to iov_iter_get_pages(),
but maybe that's not possible after all.

Any advice or ideas about how to solve the O_DIRECT-to-splice() is very
welcome.


thanks,
-- 
John Hubbard
NVIDIA
