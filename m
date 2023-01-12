Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82B668751
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbjALWvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjALWvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:51:31 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13689140EA;
        Thu, 12 Jan 2023 14:51:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RACg9R7CRrcvmc/pGaz4ZDoj5c0HhsaShAvYjSkeH6UhZ9eJ9I8m/CpR2fYY7MaSmkgyZG+Qp3FqL6FCiIsVWlNGEr7uGcAMAJvEIoBDFx9Tp1nu5mXWkh1V4NUxiNT7H9xUeizIDUD8wkUzsVLVTCOjjERNbB2ka2RQmr9q9uv84R1VsO+8BOEFfVt2Ymgk4fljjdFjWahPqTGt5pLZzkCsNOrQUBkz2eQYk9mLQhQ1jmqq0Xa5zXgqR/7mdfI3MbEYXwiGYB3+whVfmhfgtnrVL5wTyOZN1yN2f6aNz450GhGEILeIsI1pAu6c40mLKgPb/OMsVrGpo32KQ1rpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9VGLeuteCdv7YjaSFA1ONkPq8Kc6afv6TMIcfGBWz4=;
 b=ONlEiDQ/y2a3aeaFu6X3V23b3d1oQvsEYifnNFOrG5tH1TAWsRnGgjxu2Gk8j1RP9Sk1b36PFpjgrUByQWh9YHXz7GykogsOOsOnOPQpKQgopX305sG4bvHMhKBFgyAqB4lFhBKs4OXB7p0AK5JMqdnhlsNv8lC8feNZ/5XaQ5m1RafxjzpzhoniU1ZGnMVJsyp+hC4KWCiw8TSPBREJHZ7bhIWU1E0cDU5rUxAjoKpdSzR2YUJ9Y5TS2IXnASQ5SchtNFULoMSGiF9iIX7ReKWsq+GJzlR0XPP6yemW2EQY9gTsGHveHW8z4duI8dinjTuP1sJRRfoP2REzaIX44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9VGLeuteCdv7YjaSFA1ONkPq8Kc6afv6TMIcfGBWz4=;
 b=Uo+ZTOc/sM8HQ51FNYKyFJfeSAEAKlB07Xd8QHp70C6MPaVoQ+QDxLcsTEILcAKmmcfgr5wL8GM3xGclNegB+vljDxPPimgNr3SkYzDnLB3FeBldAR0LyS+AEnuU7YUSm0QEMnbL/IVj13rxpc4/PPRIBJHJ0pCpPrO/IeLXuqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6151.namprd17.prod.outlook.com (2603:10b6:8:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 22:51:27 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 22:51:27 +0000
Date:   Thu, 12 Jan 2023 17:51:20 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 3/3] prctl,syscall_user_dispatch: add a getter for
 configuration info
Message-ID: <Y8CO6E0oOcEuveaD@memverge.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-4-gregory.price@memverge.com>
 <Y8BOSwkISphWtEQ5@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BOSwkISphWtEQ5@gmail.com>
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 646fe0bd-d8a6-4bda-495c-08daf4ef89fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOITiUyVNo+h380lvlUaH4uYNfeoXuG5tV9EfbvIbTiteRC+B0+iekdMD4NPl/RvMWoUJRYzEw9393uQJKYfDcSDcDXY3etChS8K4OuDPVbt+HozyDBm+Yk2hJE5xz+dwnwe7jiwB4dcaMDVYkdiWIPdc+UfLAi+NVEP1eo5g3ChxuMyq8IKz5rtttyMjpN4Uh0zQhZjWud2I31npQfVngrYoMOcNExjY84TyzWdQC+gWEEOjo8UXOy/LYtwuH7KFnCECRNrI2QuA4omH16pU4N15au3C6dzDcsfqgC+GbIqaP+QAm0O5kyJjs+hxSGpb6sdc3Y0z8/VwTTJjyKozmWm+x+zjjon2cVjSmO8KJB1kwK4PwPQ/KDsGL2EhSBpaHXkD7ZZ6GvDvPsyVFEtse3R/fDKz4xEqvTeQqvfXij9v+f81TPCvjtqFbiLhWbkDOZhE0UBFZ0DnGB1a8etCsOtNrV/MTxrPMVqKpQess68Dcy2e5EzLfmHpvpGL2OCiEM4dtlJlZJLFg2HMI22ErQ5H3YHOYahcsdMdFdLLP697ZpwB7s4mmSznwwayVPUrvvwmyKU5ThRqyMIDicbvign5uAjOD0wiMMun7fnpafsfCPTOzPsyDU50cqiSjZE5YqUBOUb7ZG5GZOYznkLzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39840400004)(376002)(346002)(136003)(451199015)(6506007)(6512007)(6666004)(26005)(186003)(478600001)(2906002)(6486002)(66476007)(2616005)(66556008)(36756003)(66946007)(6916009)(8676002)(316002)(41300700001)(4326008)(38100700002)(5660300002)(44832011)(8936002)(83380400001)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/P6nEXLjs74d6utjzKjzIy91WR84CqeKprgmgiwSpr+VJUZ3jsRYAZWvWscc?=
 =?us-ascii?Q?B2pCNlH0ffDumk4rTEJWguQjDYiDtQyCBNFgz7uxyjeomSutvgmz6VJ/YswK?=
 =?us-ascii?Q?P+Wy9apTmN9oX1wCSVRD3DU8BN/h0A/C5CDJ3ShbqUtq7Bw9MtYssnR+o1xO?=
 =?us-ascii?Q?vBsEmadBqegfjmSQDFc0yAvjt8PhNATxbp9T9FC8SuuIuPP3aVSBKYhpzboJ?=
 =?us-ascii?Q?XIZcvUe87uHJeXT59M+M1z1Ig4ZIszKQOYPryXx9xeu/A74viNl1HH3yqvrU?=
 =?us-ascii?Q?4oDwE8nwptPDhZC0Ygf7OE+pbOUPSMKpt0e8PjKQe/b4BK0nH+SV4Yel22/J?=
 =?us-ascii?Q?IfQBgMghuSGpvDpfBWOAB2OXx5/aSr9Jz3ULaZccC0EYRyP2v9SZJRheQRqA?=
 =?us-ascii?Q?m+0tRccsirnkyjAZmXAgYUHiLFKYNiIIesb+AAbP8JhQkcKVI1OHco4YuNK7?=
 =?us-ascii?Q?fnXHM13N1ThEqyGoYN9dEuT4vZ9OwsLnldfoKneh8YcT/NtbnFmhZ7VOJpgy?=
 =?us-ascii?Q?FeuHyZW1/M1/dF4qw72cNnJ8qP6T5ugDQbg6o6Wz2xuNLdl5REklFbSQKM2A?=
 =?us-ascii?Q?xmMP0ifxQq8MvhpoRkPkesuUJCkO/8AEO3ueQGYQ7Z44nqejeE3GJKoS4mtF?=
 =?us-ascii?Q?3uJl7VkDMuTXaylejd30FF+0l94vldgp841oRWEifL0HgAVqxwS6UK+qx1Um?=
 =?us-ascii?Q?oA8MxbTC9w/9wrb69OE5bpHbyz01rKZ0Ctl7EGIZMIfBalO5GZyyfW8NiDJ1?=
 =?us-ascii?Q?szSojzRsKcBx5vELEK/yQBNrfjEx6k9FA/P4lGW4txDmfp2p44J6LTu9y4fT?=
 =?us-ascii?Q?iFJ1igq6usDEm618m2t609x/cp+LNS1qyyafV7ebp8OyHB7VDkeah/jmqXpM?=
 =?us-ascii?Q?aX9S8ROHahHJp18E2pofwiwn+qd+1OSPgNwFSrSMIbyGVr9em7UVQ/OlmgoH?=
 =?us-ascii?Q?7fGQzj4FiGR8X6wNhH8MhenkENG7HzMtEvi4cfWdbsWoyrJprkJRqtkSNv6K?=
 =?us-ascii?Q?kYqX66O/dKa9gj18WbIZd3yUWf6CsiAegk5rXxc73r4LOj981TABckoin+rY?=
 =?us-ascii?Q?yoQ5/Jchlz16qnxBoXD4Eun4iufO7g+awEf03tI71HPF5wpnIBOgBZ7fqHSH?=
 =?us-ascii?Q?L/AjSEqS0z3rMcXC/5rJUq4eOwx5amPDe00s434u8fLDGFqOfBCqKdYjph/J?=
 =?us-ascii?Q?+mEstyquK7k1o+GNvL0XiNljjsNfwj3DQGrhrzufIFuQUT9I6WwOa7J1dpX7?=
 =?us-ascii?Q?n2xArXofSnRZ3LJhVRo96OPr8hH70cSixnDY2evJj6br+725GEh+PiMI/Zzs?=
 =?us-ascii?Q?0zt5y5fYk71gwVi78xIlO5OR0PDfcsYI/hiRH//8ht3Ld47RRMxb8Oh7rM3w?=
 =?us-ascii?Q?s2y9BrbGYml3QJM9NFDkoy7i+jyug8StdNXbpTs8K/xEUxP4zq/jfyKGo2YW?=
 =?us-ascii?Q?vEDcfdNEToZUgF99B6aZmPib3qiYTOIIVdikws445hxx+ei8fS2/kkTLplMh?=
 =?us-ascii?Q?sTO8imWtTXHl5yRWE6aT7bOlKYixXu5wN0XvFPJtwlF+2zJUi7yxe5gkqNbb?=
 =?us-ascii?Q?fBOGMrQUJiFO6wqIdCKMBY2lzLFCk6gR3IbsdLcB3sxnvM2We2gtu/l7PtIB?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646fe0bd-d8a6-4bda-495c-08daf4ef89fa
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 22:51:27.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPJvCnAFiKukxuskUx76Zhn4tfUIctDcCUFRmhwzewAwcTFpEcrgX3/Mq2Y+007F2sgslFl6mjOlfV+4WjOUuBt0jRnFXLNLO8SdE08wfyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:15:39AM -0800, Andrei Vagin wrote:
> On Mon, Jan 09, 2023 at 10:33:48AM -0500, Gregory Price wrote:
> > This patch implements simple getter interface for syscall user dispatch
> > configuration info.
> > 
> > To support checkpoint/resume of a syscall user dispatch process,
> > the prctl settings for syscall user dispatch must be fetchable.
> > Presently, these settings are write-only, making it impossible to
> > implement transparent checkpoint (coordination with the software is
> > required).
> > 
> > As Syscall User Dispatch is explicitly not for secure-container
> > development, exposing the configuration state via prctl does not
> > violate the original design intent.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > ---
> >  .../admin-guide/syscall-user-dispatch.rst     | 18 +++++++
> >  include/linux/syscall_user_dispatch.h         |  7 +++
> >  include/uapi/linux/prctl.h                    |  3 ++
> >  kernel/entry/syscall_user_dispatch.c          | 14 +++++
> >  kernel/sys.c                                  |  4 ++
> >  .../syscall_user_dispatch/sud_test.c          | 54 +++++++++++++++++++
> >  6 files changed, 100 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
> > index 60314953c728..8b2c8b6441b7 100644
> > --- a/Documentation/admin-guide/syscall-user-dispatch.rst
> > +++ b/Documentation/admin-guide/syscall-user-dispatch.rst
> > @@ -45,6 +45,10 @@ only the syscall dispatcher address and the userspace key.
> >  As the ABI of these intercepted syscalls is unknown to Linux, these
> >  syscalls are not instrumentable via ptrace or the syscall tracepoints.
> >  
> > +A getter interface is supplied for the purpose of userland
> > +checkpoint/restore software being able to suspend and restore the
> > +current state of the system.
> > +
> >  Interface
> >  ---------
> >  
> > @@ -73,6 +77,20 @@ thread-wide, without the need to invoke the kernel directly.  selector
> >  can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
> >  Any other value should terminate the program with a SIGSYS.
> >  
> > +
> > +A thread can fetch the current Syscall User Dispatch configuration with the following prctl:
> > +
> > +  prctl(PR_GET_SYSCALL_USER_DISPATCH, <dispatch_config>))
> > +
> > +<dispatch_config> is a pointer to a ``struct syscall_user_dispatch`` as defined in ``linux/include/linux/syscall_user_dispatch.h``::
> 
> syscall_user_dispatch.h isn't a part of uapi, so I am not sure that it
> is a good idea to use it here.
> 
> For criu, it is much more convinient to have a ptrace interface to get
> this sort of parameters. prctl requires to execute a system call from a
> context of the target process. It is tricky so we want to minimize a
> number of such calls.
> 
> Thanks,
> Andrei


Thank you for the feedback.

I think you're right.  A Ptrace for this seems more in-line with the
SECCOMP filter exporting that CRIU uses too.

I'll look at implementing that instead.
