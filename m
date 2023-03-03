Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB96AA037
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCCTnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 14:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCCTnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:43:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24991D914;
        Fri,  3 Mar 2023 11:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQIdmjef4LrtmAp5FSm11jc8drtfunONV184GSILOdNz0Aj8o85r2rn79uNY2fOPomV7E1AT8xegPsJOLPmphrDfUnoTTm4fbGXkNTJv2pqROOZvxOFGQjTcUQ8eO9o33znRZvakJBXdk/XMRNqmLC3P++XNJTSfp/VX3QWKuS1pb8t+bhlu0ye35+OPuVl15E2ZA3WQXIbtqsHHUo5YiJ7PlZJq+oGbA6AKcDtbt4dBAv/yhwfPbTPNmBG/WqviKTcBM+fg8nlvkwRrryWY4LamMO33TfmUXMszD6AcMp7i3lbN7uS6B7X9LbbRewcSZOqtV0dXbqVXfzq+wtuEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfLrVMBZmN/jTZh8/0G6diwNY058LSvqQ+9u5ClrxYY=;
 b=AYhF8jEwWCE1obLPTCAmcIOxQeT6ks/obi+iwvDx+n2WxVkcLoGZwvcL45W32OFKfpyqJol5b3OzwTg/unI+BZNlXAXq9drUcQ4Kfrl+GRLI1LXXPioQhgL8llqRQogyfabPEht+yhBv/PLDuG3A0RY9yEMjEQnJfzmlELUi4UBURjOpwcUGR/6Lzb6J7ZgGC5DyJft0MjzBkw/rJZwZHgjKIy1/XNvMaFJ0imuIagHPk7RcQ5nvRY3eDbcVq/Zn+L4MjlvQmGMWRKS8/qpDWdNVNvs09o13str9lZ3nhl0tqK7sjG+Ds6gWSRlulZIFZjPNJUi++6zCfNjiONwipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfLrVMBZmN/jTZh8/0G6diwNY058LSvqQ+9u5ClrxYY=;
 b=fa4wx2ebW/sCgWSn6UzvC9bMwD7c8rIs55QjMHkg3+STlPrRx6zjtBraAm7bG1YMMhjZcBBEYJACsMUD65G8s+Woi/v1f1DBsVnX21niYKCPoOCCzMRvkLt8ZvYnMrTr32rG9hzkcSgOB4ztwjG6wBksH6aeIf08Z4mO5QylUYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DS0PR19MB7767.namprd19.prod.outlook.com (2603:10b6:8:123::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Fri, 3 Mar
 2023 19:43:01 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Fri, 3 Mar 2023
 19:43:01 +0000
Message-ID: <fc8d6066-a550-455c-c864-f418db3239a3@ddn.com>
Date:   Fri, 3 Mar 2023 20:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
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
Content-Language: en-US
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::20) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|DS0PR19MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: e56af343-59e0-4e20-656d-08db1c1f7f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMmXwivGcK0Fy0nMPgfRoPtw8iBLXE+FGlv36sXiYO8WWS65uDKtXrPge+vgJT+3aJR1Cgn+3tpMYFFvjp2ef5M3WiLqEBd5kmq2DMBKsurJKofN3Ad/EIrqJsqYDLvOL2v8Tgy0uBdaUgMzttch1N8fSs8Hur6vkLdDIQUlFUC7rtb1P1gW0QBHjiFrmr+ub8CqjOjHgWYHhGZwEcg8Ws0CDVqltQop3RyhMj2XJlepAXaMZ4n/4zbDOkNM/zoEUeTp564h6vvGhSuHve28bQ4Gqe6pCLhDy4VC4rcexpibadz3ouyWKWEOYhFK2CEMgfXTnJuNTNUOyBC/4a+x9fNqxl3wWLgbgTt49ofXIb7oh2EP29+GKfUNPp6rajeHo6qc6e0DnwfWcLax+38M0ei9w6PvRfZI5KNdbN/SFygdQYhuYjaADpXlNfdQpfe09TWuuN8Vn187yWRlqnxsB9d1anqmonn8gPKQ9H+/cmXE2NlC2u77h9bmBzDkVMFd5i2OEXLBgdebOOLhHZEwC4zUc3exwDHGPmRpZo9oolvwC4Jc1ycnUNFJN+r7natccndNKs8HVWSub50YYgJpq0vjg/qeaHlTsH46171Ultf1lKVNf100CPTBKXYKGW5/KsyXVDn7k6AnbnGNv09RXAZ8a7IYv/uqZj8+VylCRUIv1fLaXsGIa4MLbCDktAovCgkz/02W/FhO1gpRic+V0/OjtVmnbcr1hnWD3UABX+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(451199018)(2906002)(8936002)(38100700002)(6486002)(31696002)(7416002)(4326008)(31686004)(41300700001)(66556008)(66476007)(66946007)(8676002)(5660300002)(26005)(36756003)(86362001)(6666004)(54906003)(478600001)(186003)(6506007)(53546011)(6512007)(83380400001)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlSTllwbzZGaE5zNDl0TXAweFZGRmxWMkcreDAvcEdMeHFjbkxmRytZVmEv?=
 =?utf-8?B?SitaNnhuMU5jZUpBUWdTVkh1TVdVM042QjFOUWw5MnBjZEc4bmRyQVBhaTFx?=
 =?utf-8?B?UXBCNHhSMnZJcnlXcUg1STBDV0tOU2VPc0Z6Mml0dFZsUEZPQlV0LzUvY2M1?=
 =?utf-8?B?b3J1UUd5YXdlM09mVHIvYXIyOTdaL3MyMDlCNkZudEpLS0Rqei9lREVRcG9t?=
 =?utf-8?B?VzBPM1FJTkJJZUZXOVVvSTFseUxxTXQzQXNGeHFUVkRGVUIxUnRFd0FhN2Va?=
 =?utf-8?B?TXl6elpCcTFzTWcrSjRFQjZrZnYrU3JjWVJQMnI5WXF0K24vcmJTSUJBOW9m?=
 =?utf-8?B?Nk1GTU51and5Yk1VQVovcU1YWEFKVUFFOHZidkc0cFp5eTJINzAvT0ZzcVFU?=
 =?utf-8?B?Q3RyZ3ozYzdLTUdwQ2I2dDRwc2Q3T2N4cDZMQ2RDTGU2YjRMd2dmVkdGU3Q2?=
 =?utf-8?B?eUlPRldxUk56TVBqNG82OWlLeU5QczJKdGUwL2ZKeEdRK3JGejdaVEtNN2FZ?=
 =?utf-8?B?bEMyd3E5NlpKWVNrTlNUZ01BbklwSStEcTcwMkdOcXMva29PZkt0SUFMNDNi?=
 =?utf-8?B?V09uMGJpamoyYVd2U2EvTTVzTkIwaXExUytDejUySit0cDl2VnBCNXlaVnRQ?=
 =?utf-8?B?aUhXM2Z5U2xENnZFNXpzNzFIOTBtUGhIREtVdHYvTGwwdWJER3dLK1liWWIy?=
 =?utf-8?B?RXM0MUZ3V1BzOUYzN1VzNGwveXhvd2xpN3c0U09ETnQ4dEREV1kvZzhFMjdJ?=
 =?utf-8?B?UW1XRWxXTDl2a1VsRytRUlcwZHlwS3l1TG9MeklmSTFBOUQ1aUNzUWNOOVRt?=
 =?utf-8?B?Z2dqS2tWbjRmU01VU0lLY1lUTm1COVdGWldzOG83dFhMN2FJamx2SDJGcXdW?=
 =?utf-8?B?VHM1dWk4dk9OdlZxclFSWkZmSno4SFpnNWY5ekVVb2xTbDAzRnI1aEJJQXJD?=
 =?utf-8?B?cHBQbkdCcVQ0dEYwQWxFc3FCVFhLZFpYa2NOMVAzWS9uRm9qb2tlQWoyVVZO?=
 =?utf-8?B?NFRBQkhiaUZGSGgxS05DbE8xem11RTFwWkM4VHdMS1ViTExMVVI2NVgzL1Zo?=
 =?utf-8?B?bG1Ub2hXcTcxMEp0MUlMTkNLVGNaWnpFOEpmMlFjY2VqUVZZQ05zSWF3cUtw?=
 =?utf-8?B?VHMwaUlkZktlamlycXMvbm5KbXVLOUFDNzBncnYwWFpPRm1UMnJoYld4d2Ni?=
 =?utf-8?B?Q1ptclZXcDhmTmNHL0piVlN0QmYvWk9vaVBTNHRPczFvSGY3ZWZYeUpWejAw?=
 =?utf-8?B?aEJoV3c0b3FkcmRraEdhNFRVTEo5MEQ3VWVxMUZNQXQ3YTlYZlVTaDVrQmls?=
 =?utf-8?B?NS9GMDhpL2s4aHkxSlpuWGVDTHlkamdESmtIdXNmNFdhb3dmeG1uWFJIaXZH?=
 =?utf-8?B?TzlnSFFmUTlJbGswZ0F3MitydFA3WkVIRFpXbkxsWnE4SjJuMUNFOTA2UWRO?=
 =?utf-8?B?S0dQc2lqM0JnQzRKNkVyYTZFaEZTMjFSZDdiSy8rOGQ2WEY1Y0pPL3JQbWwz?=
 =?utf-8?B?V2d5SlEwdVVFTTRra3ZVdzFsVXh4ODJ5bWZKcEFuakRFeDExcEVoMEQrcTFk?=
 =?utf-8?B?M3VNczRVdWRXWTUwQUtQbUp2RXlHbGxLd2VuU0lUSDVyK2ViVlg2aUI5YzBo?=
 =?utf-8?B?VTExN25TRXVucHFPRW8vMFBoeTdaaTJIS0VwV0owcHB6MjdPeVF1Nm5XUmJw?=
 =?utf-8?B?K1RXMVVRVFpNTkViSkxteFBSb3BlUXc0N0hvZGVOR05XaHVLV05LQm1nY3M2?=
 =?utf-8?B?b203OXEyeWxySVNQajN3WXVFc3R6NFQ5UGZnZmg4QjRVb0x0aDJFOG11dTh2?=
 =?utf-8?B?MkFNQmR5NzVwY3k0dE05Mkl6Z3piZTlPRnVLRlpRdWYyV013ODhOT2lxNkh3?=
 =?utf-8?B?WlVQMEFIekFPbjQ3RGFOU0J1UTVjZnB4QjFHbDMvUCtaQVpySGpaSVJqSVht?=
 =?utf-8?B?RzRKVGFDUDNDZkxzRnd1Rk52REpPK1hmNUVZYUY0amhnQVM4a2ZuaVpRTGxv?=
 =?utf-8?B?SmErbGhMdWIyN0M3QzhRUW82Mk8rY0dXZm5UbVpPbldVSUo5bTZMUmpWZzJI?=
 =?utf-8?B?c2pqcExCSklLRkwwcnkrQTdoc2Nyb2wrY2tITjJWKzNaUWxFQnlTOG1yZkdF?=
 =?utf-8?Q?tHqMu8iJW1HTlUIw73mT/VThf?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56af343-59e0-4e20-656d-08db1c1f7f35
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 19:43:01.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MhtDA8zn/xgmKGgkWEq5CpfPYR5Ugp5JMCAIZ6/rrtJ77Kj1LtWousmromAqzDAglcNkGVI5tdLRalYx0AgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7767
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
> Hello everyone,
> 
> It would be great to hear your comments regarding this proof-of-concept Checkpoint/Restore API for FUSE.
> 
> Support of FUSE C/R is a challenging task for CRIU [1]. Last year I've given a brief talk on LPC 2022
> about how we handle files C/R in CRIU and which blockers we have for FUSE filesystems. [2]
> 
> The main problem for CRIU is that we have to restore mount namespaces and memory mappings before the process tree.
> It means that when CRIU is performing mount of fuse filesystem it can't use the original FUSE daemon from the
> restorable process tree, but instead use a "fake daemon".
> 
> This leads to many other technical problems:
> * "fake" daemon has to reply to FUSE_INIT request from the kernel and initialize fuse connection somehow.
> This setup can be not consistent with the original daemon (protocol version, daemon capabilities/settings
> like no_open, no_flush, readahead, and so on).
> * each fuse request has a unique ID. It could confuse userspace if this unique ID sequence was reset.
> 
> We can workaround some issues and implement fragile and limited support of FUSE in CRIU but it doesn't make any sense, IMHO.
> Btw, I've enumerated only CRIU restore-stage problems there. The dump stage is another story...
> 
> My proposal is not only about CRIU. The same interface can be useful for FUSE mounts recovery after daemon crashes.
> LXC project uses LXCFS [3] as a procfs/cgroupfs/sysfs emulation layer for containers. We are using a scheme when
> one LXCFS daemon handles all the work for all the containers and we use bindmounts to overmount particular
> files/directories in procfs/cgroupfs/sysfs. If this single daemon crashes for some reason we are in trouble,
> because we have to restart all the containers (fuse bindmounts become invalid after the crash).
> The solution is fairly easy:
> allow somehow to reinitialize the existing fuse connection and replace the daemon on the fly
> This case is a little bit simpler than CRIU cause we don't need to care about the previously opened files
> and other stuff, we are only interested in mounts.


I like your patches, small and easy to read :)
So this basically fails all existing open files - our (future) needs go 
beyond that. I wonder if we can extend it later and re-init the new 
daemon with something like "fuse_queue_recall" - basically the opposite 
of fuse_queue_forget. Not sure if fuse can access the vfs dentry cache 
to know for which files that would need to be done - if not, it would 
need to do its own book-keeping.


Thanks,
Bernd
