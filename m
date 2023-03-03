Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297A6A9EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCCS1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCCS1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:27:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4DF10A85;
        Fri,  3 Mar 2023 10:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnKrpWCFou7tY8zP9B3wUGQKW57IY84F2dZMFcVDB7VZJIIXBbQGQPENcHgrjC23HTcED2wg2SBDCwnm5uDU3058lU0nvntLZdN1V6sBK4N/9uLzmJ5ZKm+71i4imZk0hYVpBMLsiKjFVclGYGF8Edf2Ab+YnvJ7OgHoHGUKgLhHZI/LTY3WcN3KHZ5NlP4i+YJhrCvchtVVCoHBK1GPNJZuvtU7rh6jmROUEFCrJfanFPZLIlI98C/EhcEvsp9ngsB/5qpWKQ0Dk76wgbmAiSpbG2vcVtvy/M62OApteJkymaLHdo5cn0JJpJclUELdAS3udZypHN6xRDSQET3PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyKSAPV55TpmSAeivDtmd0YblwRyYKrz9w1OBOFGdOQ=;
 b=VQQpwupvV8HAxn8bi+sruCjglFEyKTyHqMdEwiL/nqEvyjaDPOvLslzTuTclK08/aEZhrEHMBm3Q2Xt0yvV3DhGnnAkMvPQ9rXtWh9uOHoAZurbQ29joyu8bxcD6ccy/65we4b6nVlBN1FQLebUk52LKZdMfi8XuTKGXG1V3cXwNjoK7vMvXwQbPv/Xv1GyVf3mlsxOpMWdQDlFPzLm70r01VDc3E7yLjEPrJJKxpcCB7JSTEqBE66I9RTUCHVQVaqU5wxMmTFnRDMECcvlnhkb0m3tc0nrX/SkJ3yl159BshRxzZJUVb2/AljE1WB9v975yIz/zAvBpu9ymCQB/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyKSAPV55TpmSAeivDtmd0YblwRyYKrz9w1OBOFGdOQ=;
 b=zFmhSKAt2DK6MYQ9qUrVmC1yvpR39hJN4+BgtbgYCLtglnJhwADzBO6/0VVV97eHgJroGyUFvXo9gL38XWQNrVKujQ06yhSfMaz2ucptcG5KaqLCMG+L4WsI0zaim5KQ9DICZg0157USE/e3Ippwc7vUQmHWb6987cJqZwrRILM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM6PR19MB4214.namprd19.prod.outlook.com (2603:10b6:5:2b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 3 Mar
 2023 18:26:56 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Fri, 3 Mar 2023
 18:26:56 +0000
Message-ID: <2111304e-6a22-e767-f79b-c72cde42294b@ddn.com>
Date:   Fri, 3 Mar 2023 19:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 5/9] fuse: move fuse connection flags to the separate
 structure
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mszeredi@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-6-aleksandr.mikhalitsyn@canonical.com>
Content-Language: en-US
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <20230220193754.470330-6-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|DM6PR19MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: baa4b04b-88a4-4a95-9915-08db1c14de22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW4LFb+8Wk0xfrSR7sy1SjlXGOHbePg/wezE1XQhr3cwlHEwwj/r8dhSlII7tJgKKYn/kQhqcUHMSaXyFkgzvcRfoa7N9lSbpR55AJFcVQ8Q2Z2BTxoZ1Ds4QnfbOSKzd4edKiKl2akUCbYH41jmkZXG58uMMoJYUBeWzX7Co0dhQN5wa3TdtM8E9RhcSGY4xBjBGn5acpg0GBOo/nfDLXghO8yHZA2Vgje+/sUWB6K1+aKht3+JlalkE2rGBncsZkT7cQnCQUTxPZ/2uWAuJ1mwIWgJQ3ptTOXmvf8QE823uG5IY1CU32jlXEMBC6paEQuUNyIQjBACVTFdotfbhzI/1/GhRzekc+2QiT0QHeONO/+17jA/kEL/BBBkcW9WeiNSkt0DHxW9HenlkEv2Jc7/ZdFdYUJ59gXy991pS8VltUJ+1SFChPrXSYF3EvodGxtNq/2wADFztA9yGWymK1lbKMADNo8Nd8bySVlyEyGL/U2GtdS6d7y50FK6DlNg366B42pXEYutMW1j6aKYAzpbSjx/+LBX/wESnCyqS4SsBN82OQzyDWKO+Ln8tnQn/z0y1REqilYW/YMBh0PNR2l3lzlWgcnnXiu3xL/JSisG09bmDN8IhHQOkIsnasaGuHpQGMl2x/C9YX3mxb11jgc4bPgkgqZxb59cDe9ET+IWXoqZYy5Trqt6ilLaaRMlZDGRpnIOYdj64MmAjbYTW+n/ooaYIGO364bkN5YUvRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(451199018)(31686004)(26005)(6486002)(54906003)(316002)(6512007)(38100700002)(31696002)(4326008)(36756003)(86362001)(4744005)(6506007)(2616005)(83380400001)(66946007)(8676002)(478600001)(5660300002)(2906002)(186003)(66556008)(6666004)(66476007)(53546011)(8936002)(41300700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnB2SkdxVTF6RndQMnp1TTJNSmxEajB3N3NmZWVUeFFydXZaaG9vMjFyWlNL?=
 =?utf-8?B?YkMzRzQwQ3RSMk9xMG9FUmtiTmFCdGp6cStzWWlpODA1b0llSjR1L0RiRFcx?=
 =?utf-8?B?UExQUThKTjVTQnhQdzJCNllRQWhvWFoyQmRyOGtiMTh3bGtRQVgzcWZvb0FQ?=
 =?utf-8?B?bkVrZVhUQlZLUzJYZXRxQk9VNnlEUk5qWTlPeVlrT295VWh3MTVxd2kvVnBt?=
 =?utf-8?B?NVBQUVFyb3VhRjhSMXNBQWp3dkJRWkdrNlpRMzd6ZFkvTHI0RkRBaEVLUElx?=
 =?utf-8?B?ek5BK1NHWUtlZ1JLMDhtVUR3eGt5NExTbzFyUzJWWjV3cDgwVDJ0SlJmQU91?=
 =?utf-8?B?eHF1NndGMWFSSnFEbXRTdkptVmtVRnNzZ0dKMVNjRytIKzNWakpkaEtLVDFF?=
 =?utf-8?B?VU9ZN0hYdWNZWlhFdjU5VFRmSnhKcEpaTC80dlJMMGZvdzFBdlVLRjNMVlZE?=
 =?utf-8?B?bHBrUGNGTUpwa0Jmcm1KZVM3SkR5RytyaDR5MFgydmVLanpjS1Y5MzljZGdM?=
 =?utf-8?B?cFMyV1liWUhUYTQ1ZC9YQ3ZsVUt2UWlUMFJBbGMrMUYzZzNJM21uUU56Y3Jw?=
 =?utf-8?B?cjlBS2hXcUhDTlNZSlh1OXRaUE04d2ZEYXA3aE40cUtpQlJINSs5YlpDTmJ0?=
 =?utf-8?B?b0NqZFVxdyt2aU52VDNMZ0VScmtrM0pNVVdEZ3h3dkk1OWdjZTBrWkdBKzRu?=
 =?utf-8?B?V2lRcHpqcGhWaFVRSHFJZTN6K0NUVnhidzhzbjAyM2FZWkJaYk9CcXpLdWx4?=
 =?utf-8?B?L1ZpaFdraWZWalJWMjVpZGVseWtQN2NaOHpSU00wTnVHQzd3eUZvOXNGaHdi?=
 =?utf-8?B?SFZNdkh1OGFVUkh6Y1pQWWJZL2p2OXlxWjZmdHFTbEk4WStkb0R1TnNnK0tt?=
 =?utf-8?B?M2x6T25aeWw3TzJSM1ZoRGg5b2hrWENScHlsWG9oOEtnUGZ3NnBLRFlmL0ZH?=
 =?utf-8?B?WmwrcURnaVhmQk9DRFloMVZSYUEyOTQ5ZW95cFJvRy9mWEVQelcxcVpBZE9K?=
 =?utf-8?B?ajhJK1NuVzc2Tm1YbXRVNGQzckk1TXcyaEZUTVZQTnhWUkRuOHk2NWs4UVU5?=
 =?utf-8?B?TEZPbjVjcGdrUnd3VGdWTjBJZ3ZaRTFGTmlCc1g3UTdhU1ZTZlNZQWJlRlBC?=
 =?utf-8?B?anl4L2s4K2tHaDBWajdNZ2dnNFZlaXQ5UDdDY0syTUNadE1SQ1o3L3oyQlB5?=
 =?utf-8?B?WU9GVExVNS8raW9RbTJaTXVYSmIzNlJvQ1RKQVJER0pIRkNaa1RienJXT1VY?=
 =?utf-8?B?bWplc2ViVlpHeWNZaDRCd0pLZE1RU3FpRzVGYmFMVkw2bnpEQzMrN2tJT2lS?=
 =?utf-8?B?N3liZEZ6NFRoYkJkTWUxK1JuTnZiOUkvTGZCMENURzRwSXZENGlXeU5hMDFC?=
 =?utf-8?B?ZFVyUDloMFU3NmdiVUtMc0RJUWZiNkl3NlBUd0IzcExtRU53cmJNU0l0VU9T?=
 =?utf-8?B?UXNzZTFXK3p6ZkpJNUNQZ0F5Um4xYjl3bUFRZkkyVkRYYzkyYXpFYngySW04?=
 =?utf-8?B?VE82TkpkWHQzeTY2NDhTYlJlQm5tR0U3bWNvbUJtTEdKMnEvUWhVUXNoVkl2?=
 =?utf-8?B?UFlFMVVEaThZSzF4S3d6ajdtSlFYTm4rZnphUFpROEpEUUZ2NXM0Yk9TclV1?=
 =?utf-8?B?U3UyK1JhTENlYTRPMnRxZldtQkZQZ2tZU3UzUGFHVzlYNys5aU1FZVZOY2Nk?=
 =?utf-8?B?MVd3c2pIQ3loSGxJc2ZTQ1p0ekJzY3E4dER1d05Na2x1WU5kR3RIaGt1aldX?=
 =?utf-8?B?ODBOdTNLZit6Rkx1L1Rnc2taeS90U0hGOG83bVR6LzBXQm85amp1SXRqY0Nv?=
 =?utf-8?B?d1A3TXBWcmVVVjE3MW8yK1d2ZWxuWkIzVy8ySHdMSGlLMjVQRWovd2xWdWdC?=
 =?utf-8?B?UHM0S05xNWxRUXM0NHU1MCs4cUs2Q21FYmJOdE1lQXRqVnllZUp3ekNtYVZL?=
 =?utf-8?B?MFVxb3JQREdJQmFqKzJHdzlBRVMxN1lka2lCMEtzSmJQaWRodXhocDJ1NUFG?=
 =?utf-8?B?WWljSVF3bkhKZDRYa3hsaXJlMzdqWi92ckMxUitKL3BqdEFkYXZQYWpXYnE3?=
 =?utf-8?B?SEZmNGhVNUxBdnJ0enhleUdSdEtSbGVuRzJ1d2p1dW1XTTRML1JyYUpBM3l5?=
 =?utf-8?Q?R7chjMhFstNJtjG65WQJwnCbF?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa4b04b-88a4-4a95-9915-08db1c14de22
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 18:26:56.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSMKp/gMdbBM8XrhGGKue7AKJUpBkvte13wnvKJZD6SGyJ44eb+jNJR5tvsrsnwrgFGGgDg5y4m1UGIOC0ukNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4214
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> Let's move all the fuse connection flags that can be safely zeroed
> after connection reinitialization to the separate structure fuse_conn_flags.
> 
> All of these flags values are calculated dynamically basing on
> the userspace daemon capabilities (like no_open, no_flush) or on the
> response for FUSE_INIT request.
> 

 From my point of view this makes the code a bit better readable, in 
general.

[...]

>   };
>   
> +/**
> + * A Fuse connection.
> + *
> + * This structure is created, when the root filesystem is mounted, and
> + * is destroyed, when the client device is closed and the last
> + * fuse_mount is destroyed.
> + */
> +struct fuse_conn_flags {
> +	/** Do readahead asynchronously?  Only set in INIT */
> +	unsigned async_read:1;


The comment does not match the struct?

