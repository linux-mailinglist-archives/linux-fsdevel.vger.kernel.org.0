Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375174A3D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjGFSdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFSdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:33:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2117.outbound.protection.outlook.com [40.107.101.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15F1BF8;
        Thu,  6 Jul 2023 11:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6F2/aWYB2C6dXhV8WRJlR4aSjtDeg/egbSDBZE5kwepZZ2z+j0XntLkWF2j1KuiWC/cmYXxr651LntLeD0zciiJ7NSvGT53IgVrKfj0gBngcdV6/dxIukJUvDfcOeG9wWlYvIJHgqOI+UdSjYZOplfcaM7dkfwAIfeOYqLwfQpTswkT2gbmPFS+mPJDdQcj9WyI87s0e5TmQSEuZFeaErjY0oBjZKTyW/47YIrD/aZnuGOKn49+rv894zpX8sCZ0juJ8YN/Ql/pHivrqehP4CKIvYhlN9Wd4JJFYG2Y9z+L+1a9ilU+Z+mrRDqvORbQlHcGXmTBKy++ECZ5Cn27cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itrPSoeDsLJol9w/4FSUKciz+u6gsXsPKPZT36bXWFg=;
 b=levksOjsMly1bKBRP0+j1gyY8q9k32G0eUa1SD/8KZ1nA89+GmMWWiUWeWweCCM6Mubf/+F61bisBjrUM2LrEOdIOOoINaxXdjbysSy51/wC1XIy9HpysUDzhVENK+WvOY9UVAlp9KvgjSNr9Yj6dvNvZXhUWmk5WmdajLPO7/LdA9f5z4RbzrsqflMLlDqnXjpetEzFv1KFbKlbskkRjYQxJamG0u8d+yBWziEx3QqdnX7lLu+V2ajZJv2irUgPZPRRT3IVgr11EhIDcyRHCBxHmD1bNZ8KsViWbkA7AWwgxjMxPiR9DeGJKNJzeCsp7kveUYZctQOCP51q7EmMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itrPSoeDsLJol9w/4FSUKciz+u6gsXsPKPZT36bXWFg=;
 b=PIShxFydmxud9cf+pMurDEqcuJe+aIR6DgsT0zknrgxeSaxd/f6zHt7KxZ3bj5EhULC1bJ7JvYBMASR5bNuRrHBV9EN41D83F24hWfsVxpU2aUw4jRE+jvSA1Fcax2CsJ0wW4nozC0E5bX4xohMAj4NTFQQcLCtpttOQC7XPhEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 CH3PR01MB8361.prod.exchangelabs.com (2603:10b6:610:17d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Thu, 6 Jul 2023 18:33:04 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 18:33:04 +0000
Date:   Thu, 6 Jul 2023 11:33:00 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     David Rientjes <rientjes@google.com>,
        syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>,
        42.hyeyoo@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>
Subject: Re: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in
 ___slab_alloc
In-Reply-To: <CACT4Y+akPvTGG0WdPdSuUFU6ZuQkRbVZByiROzqwyPVd8Pz8fQ@mail.gmail.com>
Message-ID: <61032955-4200-662b-ace8-bad47d337cdc@os.amperecomputing.com>
References: <0000000000002373f005ff843b58@google.com> <1bb83e9d-6d7e-3c80-12f6-847bf2dc865e@google.com> <CACT4Y+akPvTGG0WdPdSuUFU6ZuQkRbVZByiROzqwyPVd8Pz8fQ@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|CH3PR01MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f38a5d-e88b-490f-885a-08db7e4f6f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBRjCtEAhULubq3swCHnImTv7qfsT6yTgJEyjUSYsnZN6aScD8mcFulwd7EBqIw7zCfoDPGuIkorZpaPoqEFJz44vGszNHGfIPni+VF27SEfvOkh0d4syR0qdjjQYckwsoUXaM3E7eWULAosmPgYHpz8TwDScdWwzuIldFRNsUVFfEV7d1RUk/HDKLFIYVycpfa3IbrMnwICSf8w+AouwIv4KSS6MrOrNSS2d9C2BLYvNhFluByagaQcJRpbkuYhjLLkV3JEi22+tkyJkb56fDk8eym0h62GGoF8MEU/8FzjtFbZ4T1+ZjIlZsiKl7k63wnInYUFukmB+4S+dLe0Ft8ELOgkNDBYxe97iCXTaVLKEI/JvAATPGGRss0mMm6gHQ2t9IhMRQnV9UkkvSnBdPD0qaMrbnJfz1utup/7/uggdXWOTDRKdYlob+x2d0VdhR2LBA8LexDMChsvmB8q0nXc1S2ZkNjX06nKWiSsnwPBtNZ8aUL3zzhJMVyOirgQulx1rTPPdEu6Gjjp6Mg9RNDBnJpRW8HoqTS/hAxb/vb7jYUNoelykYZwo7ziM7RA1bD4Z5FsAsErZTxw1gvzhmuWOqAHL22vtS1XPYwnlSGEIdhANQEBChRiN3TtY3fL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(366004)(376002)(396003)(451199021)(316002)(41300700001)(4326008)(31686004)(66556008)(66476007)(66946007)(6916009)(86362001)(186003)(26005)(6506007)(6512007)(558084003)(31696002)(2616005)(2906002)(6666004)(6486002)(38100700002)(7416002)(5660300002)(478600001)(54906003)(8936002)(8676002)(101420200003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHnArghEJc97KjTBPR2Br8CdM+AEVxMmB2oYnLyKIdJb2G529ACXMAbF7xtu?=
 =?us-ascii?Q?c0gH2eKKGbiKIBH9mEL1xnDqQbU4iHplWGd/cF46yFG/cjP4CZnycRU5aAZ2?=
 =?us-ascii?Q?k40tcserth2jJ/nEuuLiDNRn14uRA6JWZJJcMMmlSBPC7vXrnfk09wx6jJ2U?=
 =?us-ascii?Q?zq3BAVPxQHIuj6OQiEc2IP6yLMzalcSy8LliMLpSQsrQzRCzE347Lo6J4W9z?=
 =?us-ascii?Q?7vawZ/57LuczdwYznyYl5KhIEM+E0/yb5uOC4ty4B3x5RkIi2UVdEpDChBJ4?=
 =?us-ascii?Q?ceD9ydDx88huWgim6l0QeVfVkNvUXEo+Ebdx8td2JoN0jiMCnr3HlDGIUjAi?=
 =?us-ascii?Q?aZjD8e5wOdhKM2qvKC+rQDT9qU9LEQoZeqPi0S2D35ksLU9PG9jGn8vszPsQ?=
 =?us-ascii?Q?iASAECbD82IvsfE7BpCPsp8AF1cSrwPzPnPBOyKIY4LBD/iGLD0ZLqTWIE3+?=
 =?us-ascii?Q?mbRehEiXR6Uv/BSnehV4vCcsmbVMXMgnF2/4fnCvVgTFyqvNH6552vt/RZjq?=
 =?us-ascii?Q?gTaeTcxc0wbYpDonUdAXZHj+i2sAPClH77u/wbTxQm0iixZbbkTfXxwWVLu3?=
 =?us-ascii?Q?g2wgbD2iCvKKW/f8y0UL4sHT2aadMJYTfoBEfC9UAfIQc9gEJ6TERMyGMpmS?=
 =?us-ascii?Q?r7w8aAKQef//NNj16584uZzePAzBnsKY3TVRZBucOdD81JXB5qNKvwjg/oo6?=
 =?us-ascii?Q?nauzZD9xlP19iVxcGnDe3d37dYZWTePtEn8k9kcotxPgP2b+5gDKWYtx1nJ8?=
 =?us-ascii?Q?81Jk4xmQSwyhsfzv2zyuKfYIdYLVnn05022Tu9FgolDuXKdYf1RcMUuRa5is?=
 =?us-ascii?Q?P+28tuavRVFUhfsUFVyb54UZGa7NH+v46L5LiDhf58HCz82JePUBH+0yBgwf?=
 =?us-ascii?Q?rHJGyKJNB/QSNW2MC1OPa1J/wdgp9vXmEqOmmS9JRoXOT9+gmlvttfSTLt5s?=
 =?us-ascii?Q?gbh4f99rExkRjABCQr+EGxoBTVrd02+tg0+NamJVlZ9zh2LYex4mMrX/7Ei0?=
 =?us-ascii?Q?h7o6XnTHNv6EDG5mzbYYmYUJGbOXjgj/41N16Bwh4f6CKvjY0eHDwxYFAtE0?=
 =?us-ascii?Q?vUY6WBRwC4HNsm5RHIY8izB4EHJ77ZkKZ9j8IalvAYLdD0QFouKTJ2qSDMxw?=
 =?us-ascii?Q?LUZlnRLnlbJh7noLiePyegY2sgHjgSZ9SHxHBmEPC8W53XkBl9h1H/OfZw0K?=
 =?us-ascii?Q?kKFlWGSHKDaqu/5Z/2wXBt1OOH2CBz0z4U88EhQGwVnkkvBsP2xnJ1EG7iFr?=
 =?us-ascii?Q?STc36jsFSe+VAdbfWqxygluuvWzK4k4EqfO6fQA+M/LpVaxmj2IJtVPFuJvU?=
 =?us-ascii?Q?mSg8bNoSbUrxnHdom0rfubQVv9F4bidPJyq43cFw6WDazYC8HRhQImljFD/2?=
 =?us-ascii?Q?15LQ+z4ipLwFjuQ/FG/RpZaM2xi0coUYwtWSGg659Tuto7SyksKjbOHKrOmU?=
 =?us-ascii?Q?N5oAe29IsUHMiKUDPlvtUxNR3TpQjNneDvKWjtK1PwjQtu+7S3ZftDSB364z?=
 =?us-ascii?Q?T8DBK3ufGvEDH6R4ouNjUzMtvXhD+JZRANUZH4EEqn0e13FHD1J6xU+V3bT2?=
 =?us-ascii?Q?ZqvJKd6SkweH2Aju+xJrb2L2ABZTR0Y7MZ7C+U2zc5gpDK+f8QSgyxxi9Oh+?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f38a5d-e88b-490f-885a-08db7e4f6f5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:33:04.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttlrK+G6/xhhFsntafNPXSc+NRGXCxLMPTGep2uCaBFaNpR8rExrnTQ/yKIg598QskrKxysYdyQeL1ca8me2MZ/nEI6qJAGikzlhTrAasRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8361
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Jul 2023, Dmitry Vyukov wrote:

>> This is happening during while mounting reiserfs, so I'm inclined to think
>> it's more of a reisterfs issue than a slab allocator issue :/

Have you tried to run with the "slub_debug" kernel option to figure out 
what got corrupted?
