Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0134C61D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiB1DaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 22:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB1DaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:30:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE259386;
        Sun, 27 Feb 2022 19:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPfdAZAoaBywkjNz3XiLReXMrcE39RZWx25zxtx/nmU96UXm8yA3TnhpckuhJz3MdtPpLUv0q6HSEvpiNCZc8g423pZTMn5WqWWwTwCyQsgaplafs42+gTdOOxfoPWPf4N0OcMpjl3df9Rx4a11Hyyw93jwSvxFSFVNd1StcAtmFX7vQTrGjPk531Jk/jQyjk1TMIho3DkLKuDMKlg3JpNVJT2LmJWw0RmHRvDMJz/PfYiD6xFBFzQoBrERQafUsnuLUUkUzBS/U44c1WCGuhaUPcFL1YpLu649i+kad5YqGQ/b2DALNWCgG8UGemH6zO95aPulza0XPXP75aZ3N1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDJuF17peCJ3N3oAUITIo8PN4xeSQplp5neDv3xHQno=;
 b=mw3m671OVqEKOaTAkHs5KgRF/v93eUb1/Ztls8VGmxCkW0cgC5cx1fb5C8tTCGCYSI0SUUGEpDZecfZMVDt9As/Ee4x8uaxuafuZ1jTda2bQB5WPM+o/nT0Fi42i3UkOt3tSbxXrBy7YaVHebwFJckRqAlFgwx/aytVduq37OrMx1TcZx+s1Vg3CM1hE+Hd2g5sihOD0axRQe5X7Z7ajTTjKFcAUniju1c5qrRKuHJHqotfXSiLtR30SuVmkue+EySdByGhfeq9AAuWYnvDqwnXVdlZ2m299d7XToGo5HcSeoqI9JGaHHHFc+M5vKRhikWXMB2YeBeXHTIcS/ygskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDJuF17peCJ3N3oAUITIo8PN4xeSQplp5neDv3xHQno=;
 b=GXbe1Yw/IGSZBnqNZDr1UaWhsrrh+Uq0smygu7FVmi6Ja9Xs56PQhqBPHt6USIWGKtqhdBSw791ohXzJgW3OaVlEOmCOM4WNrZ+Xupd/oM75XA7L6FtSOf5xCIvN8bwIhqGyhbvxyBbh48BbkD7RuSN3qDrVjhEwAoQEr6bJ2PUoXevHQLToji6Gh1abfZEmSBQ71Su5Oj0bSwrdzg81Gi9S18HYGPmsuvHEv9/XnSPXQWe+gIauCkGZQ+H0vvMyaAuOK3GfFWIOoVAFKhC7MGi4ye/Qc5NfpVrOm46EoId6Wj+JTXf83wwTIlUj7u8UVgEcgRUCWFBjRr2fhhg/Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 03:29:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:29:42 +0000
Message-ID: <36223c44-d23f-18be-186e-08bcfce496d2@nvidia.com>
Date:   Sun, 27 Feb 2022 19:29:39 -0800
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
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4eba9c-6108-49a8-c08a-08d9fa6a8efd
X-MS-TrafficTypeDiagnostic: LV2PR12MB5775:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB57759786A1E90FD15CF6A947A8019@LV2PR12MB5775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUkV1O1mADnfLMw//5U5Sz0WJ/UyZujgztfgZcHqyS5xzIzPqjCP3Z4oamTNVSBg21OyWun3b+9Oco82O2UWu1xT2vMfsIM/rHVJg5Jgh8Jkv83eaG9oE+lGZTUo6CBwz7b4LZsSzafxgWYqmabUSZrVy0cizgQSMyBL8yNWa+7NuTOw117xLbyrS5KFTRqtafVwPIhp5VFQ4rjHkTwsmhJmQ0ea7c/wlVkFitTf2sMogskNDH+3OaLAk24CsAUvlnAOFGdvty0YYqgrqe3RPwvAllVJm7rmxccEyEH+O+ZwsE8IViufqg6n+YDrTxkArXZdJ/3hGhnl7bXR3kF9NjMhKYlMpW+fP7p5q9ozPP4/sMK0LlBrtZE8gC9LF8rdE01mkUDgcrfPZwvUqS1zuiCqpfC8Xy6/1K/iX2uUcGMevvT/7fQewsCmbW/75xWHAzK/OQb9EJbJ3bGlaAis8p2WD1ZvPghxsWaI216sk/7JXAtesWJeuQzPQtsnazcAG//bEaI8iy14XUKTkw/dOMstVRPX3WBrGzMiXHDW+TIixm4JUvJGOPKbNviEo0Cw8ZTj7viV1P+AfvzHLrVbXopyjoIdqLfgJ5rzaB21m5cYGs3g3Lyu4PFxf1Sx/CV1+KLhkmPFuRYsLCy4Y2M809VrI22AnYyvG3ilvRh9iFo0xSudKYHlwzp5RE8meMPOI0H0McSlMsEemqdIHCkhovUxMO0Yipjj5OCKV7WUdNgSh0fOxVNpF0Du+DtVWyrJ/JUWTScoICOCuRq4YtyEwgnv0DopmKXOppwxQKXJBv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(6506007)(4326008)(86362001)(6486002)(8936002)(36756003)(54906003)(31696002)(53546011)(2616005)(186003)(26005)(6512007)(38100700002)(31686004)(6666004)(66476007)(7416002)(66556008)(2906002)(8676002)(5660300002)(4744005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytVNlU5RnJjdllBSkZmcU9yRjZRcFBxUnZ1M1BHL2dnNjc4ZnJ0aEsrS1lq?=
 =?utf-8?B?UEs3RGdmb0Ewd2R6WWZNWWlFYlg0R1BXNEh0a0lSbEpvbzFXcjZiTkcwTXJm?=
 =?utf-8?B?Rk0vbWFNUGlFYWpCeWkwdGdhaGdXSk9VQVU4bzIzK0tCa2VuU291RWRWQjZR?=
 =?utf-8?B?TjYxYW1qbDd2M3E1empIcGp5aVAwMXhBTzVZUjZVd2pvdU0xSElhRDZieDBO?=
 =?utf-8?B?NTVaNnR4R3BzVDM1bHN4aFJXL1lja3RWR2kwMzRwVmdzakNHc2dwSTV1a0Zx?=
 =?utf-8?B?bTFGODJjYzhueDFMcWdQV0htR3hyV3dNMGFXd2pWeVFqaEZHUWVKdTRhNXps?=
 =?utf-8?B?YlNIcUh0TjN0dFVWSmtoeVE1WUxvRFJ3S2YyT1lzSE5JSVM1enN0ckJwSCsr?=
 =?utf-8?B?T3dsZHVhK3dwVTVOSGlDU1RzellwS0JUYVJVQlpJNExPZUdyamxNTnBzWmpy?=
 =?utf-8?B?SEMyLzV3Zi95bHRSY09YcjZydlZHczFjcVBsa1k1QmtmaDZqWlVXRjYrbzV4?=
 =?utf-8?B?c1RyNE9QdjNwZ1BpMVo3MDUyeHpYaUN1eVVXc3dzbjRIMW5PRnN1Z3V4Tnd5?=
 =?utf-8?B?VHgvZEk0aEhMMC96MDBRTHV1enZGaWc1MDQ3RWtIZWVyeCtObkZnSmxaMVhn?=
 =?utf-8?B?T21adXMwNTNoUFZrN01vRzc4aDhVS1BLZWdtZk5QZ1phblNrUEtTb0dHYkRE?=
 =?utf-8?B?eXdvQzBZcE9oMjhDeGpPcXF3NkFObHhZNElERC9uWmZiY2JJWG5LT09uYmo2?=
 =?utf-8?B?Y1piWUcvTnBmRHYzSFpvMllVUm1wL3A5S2psdlZZY0RHRmVSejdtSUYrU09J?=
 =?utf-8?B?RFRwajQwSWlIR0NtaXRRZDRBVXZabkpsRzR1b0FuWXZJSGVvSGNwc1MrRW5J?=
 =?utf-8?B?VGIreWNrR3BhZisvMzJjTVp1Z0ZHamZLeU8xZnZ3cVlCSENpcGFPR08rOFFr?=
 =?utf-8?B?VW82R3k4amhpVnBTNkN6MlBGMlpNWVBmdmEvOUM5dm5RNHdtVmZadzZyc1RY?=
 =?utf-8?B?MU1xVm4zVGJ6bzFEQmc2SVpxYSs1bDMwWnFpV1MyQ0I0ZFF4aDBPYlJtMXRp?=
 =?utf-8?B?SWVQMHArNHVNbi9BeWxvVEJ1Z0pmRE1BYWpVSVdPZlRFOVpXTmpxWXg0UUxz?=
 =?utf-8?B?YmNGVHU3aVRlSmd4aDZpVjVHWXNRUEN0MTNiSzc2L0pzdnpmMTVmdDdmSmd5?=
 =?utf-8?B?R1JIZ2NxNW1JakZ0UzlSOFJvMXdKckFib3cvZmtwWVpsR05Iem5Ld2VSeUxp?=
 =?utf-8?B?eWwvaTV6QXV4OXQ5YjJFYkxoOHNIbXY4eTdSLzJKM2dzUjVHaS9jb2M0WUJ3?=
 =?utf-8?B?ZjJIUjdlTXJGM1M0K09oQVN6KzdqdmxSR0k4a0FIQk90amdLSnlHcmEwTEph?=
 =?utf-8?B?My9YN2doallVZWRSQkJiR1lnY3lIckdnNnBrTTNhQmJCUEJ4UXBXZEI2cVA4?=
 =?utf-8?B?aE9laU1JMXErZXJVMnRpK0lCQ2Yzb0pZeUZLT2MvRHh4YXpOQjZwMVEyNkFL?=
 =?utf-8?B?SG53QVhCVUZHcjhUZ2tNU1JZTGVsbkpjSTdSQzZoNHV1dWdPZXMrYXNIQkxa?=
 =?utf-8?B?S3Y4MDR6RmV4cnZWUVo3c0dXeDQzeEorWFNsWFpibFBMaDhlMitEWHhoRmwv?=
 =?utf-8?B?Tzh5a1Rjcms0OVZjRmtnL0FMalY1bzlCNk1UcHFPOW1NckpFS3g3bEtXMVk0?=
 =?utf-8?B?cTZRMEFaYVRLVzlOUVZZdTE4S0IySnhscm9VL2NhNjBDR2hkM2JGUFN2MEVY?=
 =?utf-8?B?bTRoT095Z1JRNjU4Z2xwSUJkVXVHOFE1ckt6WE54a3ZkTE1vQnY1SnN5SHdz?=
 =?utf-8?B?Z2FsYzVCTHpHcHh4UWorclRRbHpMU0UzT2RLNEp0dC95c0RXUW9IdUNSRHUx?=
 =?utf-8?B?V1JlWldKQXU2Rk9UQ01WN05ZaEo1UjRoSDYxOTlkYm96Nm0wWEpRdFl0Qndw?=
 =?utf-8?B?OC81bjhISENNUmZCK2d6aXRmNFZRclpEWThtUXBHM081czcyY25EU1B1bVBT?=
 =?utf-8?B?U2srYWJTQ09VNFpiSmhseWhEcDl5MFZ2ckxXck83dThUd0lRd2FiMWNnUFl3?=
 =?utf-8?B?N1I0OE4vWW1aYmdGWXpCSlBEN0hxQkFkVHNQL2JEKzBXVHU1NDhiYjdQdGFY?=
 =?utf-8?B?VlRITmw4b2lkbnRWQWtRSEVqeUU2VW55NGRNOFlnSjFTNUtrOExISmsybHFQ?=
 =?utf-8?Q?y8YW1ZxxPGEmsGkYGboBuHo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4eba9c-6108-49a8-c08a-08d9fa6a8efd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:29:42.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXzmTVq2WxaGecxOMjyeeSYyj9YOlq+ZSZughncDpHJvfEm6bLsomzfWK7E6EY+jmEFupu6SwyaFCn5t8yOW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

OK, right, this is not going to work as-is.

Any of the remaining iov_iter_get_pages*() callers that do direct IO
(vmsplice, ceph, ...) will end up calling bio_release_pages(), which is
now unconditionally calling unpin_user_pages(). So this is just
completely broken.

And so, once again, I'm back to, "must convert the whole pile of
iov_iter_get_page*() callers at once".

Back to the drawing board.

thanks,
-- 
John Hubbard
NVIDIA
