Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD367A51C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 22:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAXVjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 16:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjAXVjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:39:23 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F678A51;
        Tue, 24 Jan 2023 13:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3KAJCJVYtPOdol7DojnQaasrRihKj8bogIl1H/P4kk0i+MJZP/xy/9s8QgEA/ioegUOtnxI6RDlsFKbI1Z86ugQpYajLWHhUbZQJv1E6jRxBg3uiDgOJf4ra0KioaC4d/hoy8oeXSD2b/M3OXU0NiOAXGNfDC1U2X+Gp/WQzneT20X2aFNBa8lKFMdaawzH7os1hWfqXPtBq7eVoXqZBPvAUiWaP69bqEaNKp8fY1VABD7O2QNhyOifPpqsSl1w7hfjDKcoAghqDQ3qs18g3JzZpDapns0nuuXLK8YnvLQWoLrztnYiyOtVlkUpPGniD36zV33HSjsdrKRgI0G+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gXmgJ/zet9yfOM6vJYnDCuPsnUqGWb/8+q5JpRY7dU=;
 b=d5n1FwRU2dN2L+GK67XIrecJjUtXp+ANe2xrg+3FXi2H8fvo8Kaur5abrGubwB0cllXajkoO8gzV6Qvv6uP4t60ZjhtZn/EkPX4NyuWb61GVD1iDj1aS1xtUCSvgMA0sx63M4q48Qf1UW22frL9gVIwTqGt93q9jQtfGX9+Szi2pD9TaiVKFY0Wv0yVC9Omy5aIIm7ik95g44zdv4xxC3uDT8CUqoifo+QbDYCGjGrAfbhXbkKWhWHCRIKe0CKJfaUq4rqP2X2njTHYXb0D8vlhrzzObiE890vl9FgGJh+/P9pvTe9yJtzrrwLrn8xbU1U+GqDvQnOK2rJDAHhWPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gXmgJ/zet9yfOM6vJYnDCuPsnUqGWb/8+q5JpRY7dU=;
 b=IzFT7IT2IbdMlsxfSxY8WLded/MtDRJvDcuUW6kFNcmBszJqiEhc9QAxuT+ypK1vGNijcyNoRsbZcvi3UW1uB61Xgc2HFtFZvFqFxMFzb87PqtDs1IMDPH5D+HrEjcfboqZuoxMMO0q5kGc+6+GnTaHHScMgWb24ndecPA09AB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA1PR17MB5718.namprd17.prod.outlook.com (2603:10b6:806:1cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 21:39:18 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 21:39:18 +0000
Date:   Tue, 24 Jan 2023 16:39:12 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <Y9BQAEVp/oGjZz46@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com>
 <20230123195228.GD6268@redhat.com>
 <Y9AAcuomaVM2JRCA@memverge.com>
 <20230124164347.GA28280@redhat.com>
 <Y9ANOfzl+iZSBIEP@memverge.com>
 <CANaxB-wASWa1k6X5umJ=wt-K47uiBo9N5hxc--xz5cmU2bvysA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-wASWa1k6X5umJ=wt-K47uiBo9N5hxc--xz5cmU2bvysA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA1PR17MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: b70f5e88-a335-4b62-ea29-08dafe537275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ms0FHqIBNy9umLwJNRQgx9nQ1TQy09RQX1PQYxzVmpDq0bK0AM1gHQDiGTV8hkVNOna21zUa/qkmBuJR0gTEGiqCvPxsmKGzld0a25MAqYY9mXQdn/RST5ILCBJ53tGdgGI0GU6ihCPx9ANrHp1geZ2gWSEQk1x0woxjcaAsIBSdADrgKcgBWpppAGl4n4IJfdDp1fC7RDKTy3693q8KqnAUBvyo1VQfbGQCUFWEaaZHE32W+JZhy7ox1eZRLgmNGx5VspphBssriq5/7YgRQ8QWhCX+2SvLMmEaJS1clLYDDebUzF3i1PotWfLgA7poSOSs3bBSYmSIUh+/x590RAmdI6gpoJr1N/ZIguAW5rhfn8pjZctjkXqLTftPV20Dj581+PSlldw8vZIrCdmCOQEmVUO+hcJbwHFnGIrDPTNUCOnCpLbGT37L4pguW957uf9HSW9ay/fVlzg29QkpMZmO7Qwp2SHLLQ0anVyiqOm1r9m95qPRqLR39KLUPCBPB8m3W2/cBgiDP+q/QNZzMqPuWVcKqkYfiHSECdpU/AFRevfT90S0BcvKHO2PZMpQnWJ2K9e6/JtvUY/jEbArQ5Cm5uXmQJZGvKuuvPTWpEypcQ3W8Ud2LpO8agpEXP9av6zUhVxbAfgX6ho/0f6WKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39830400003)(376002)(396003)(366004)(136003)(451199018)(8676002)(6512007)(478600001)(66946007)(66556008)(4326008)(6916009)(316002)(26005)(66476007)(186003)(6506007)(2616005)(8936002)(2906002)(44832011)(41300700001)(4744005)(5660300002)(38100700002)(7416002)(54906003)(86362001)(6666004)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jxs1kM22BDxkHJnXEixcczV72z7yCjLnhv9VLGgFaL7h+09ccqZUOH6iz5jQ?=
 =?us-ascii?Q?O+qmhYIQyUD0JxOEEMIoTEH2qLokqaAf+YpLJGo0tL741BUiRJWy+YLnNlrl?=
 =?us-ascii?Q?Lxx06QcWFMzXXsFKO1vRFwT0ik80QJBwoTpwS1hwb2mFRKKG+Js0Zx7pYXq6?=
 =?us-ascii?Q?1A42La93evB1XAFTOrGCwQh7lNljfVETTqEatW7w6cP1j3dQzPhZtMLYSUYb?=
 =?us-ascii?Q?WHhLbV0nGAg+gCGm4mlNb/MsgX4D8EnucW6Q1ae7vTSVFI44P0EMC2ijpiCF?=
 =?us-ascii?Q?3PL7/Rb1/Opibc0xwqgLmfqb7kC63qPGZxf0u4WP3XPgOssFzyQcBWp92N6S?=
 =?us-ascii?Q?aTVxQbDannYh9rpAOpoEhqsXnGtR6YvBR8xf7twX8L+npSxKfOMej6L43Ypp?=
 =?us-ascii?Q?0XD9jgzx1g5peOnCzhZLOZeq8DFGXeXvX2yhNv3dl0B8qygMxSdp8busMk0I?=
 =?us-ascii?Q?gcGU+zi86VEwoyz24cUAbmrlwaLmO+U23Gp3jSDWRakaDRV9kCSPa5mryoEp?=
 =?us-ascii?Q?upPAGQ3KODk/+/ze3MJcbCSBlEpf0uCDcaizv96POUcLBMoBdgmsWxmTW03v?=
 =?us-ascii?Q?TJw3lHScksc3uOBx/Ylxvp2eWLFP/lVP3+lQipGqQXT1+FCKbBKHiqwLuWqG?=
 =?us-ascii?Q?0bJ+voqjHAfKX6xn4/ne990XW0YzKwBmy7N/boVQm0xvazcJygIU5HmPqfQO?=
 =?us-ascii?Q?mH8Sh7Ymmg9kxp/BJojxN98a9yltLs9/pqbz5wsznkKmXqqWYZt2NQa5lP9z?=
 =?us-ascii?Q?mGievo0o4rIEba+QMOib/zXQEs/PBjisbj2gkzTlExYQEG2NRToNMqdThdgx?=
 =?us-ascii?Q?WfedayNyJxUdZhw18TDfXhDfgjAHjtU3k6gZgOd94bM/Fum4/LX8a/mvrZi1?=
 =?us-ascii?Q?PqyySJYVJCJQOhQxG4kf7x9fIzh587oG/CGlqgd9HVmXD+nqUKDYV1emqpN3?=
 =?us-ascii?Q?yP0h+IecFTl8i6QsQhNySjv/6Tc+uatEEjQ+TSG+j2UK9yDgUwn7Vf0Ijt1Z?=
 =?us-ascii?Q?xyzFYBq6uLUqCGKe131FUEQZGsTm9TEOF8RJJUdS2RYnN4ZD4gPrrGkRFXQl?=
 =?us-ascii?Q?Bb5HQVXuFe4bn3n1PCEjktKgaLO//Jzh02df4u7/D8Y7PEvNlcihb9YJAMAu?=
 =?us-ascii?Q?H7nfQvRmcw6meMNy3gjX47ce0CfKsza3stihR7jCr1QIHiT76sQj8e+j9v4b?=
 =?us-ascii?Q?XCSs33452xI9lOEWPUnHFCjwP+0V7maHodjYvxyJbCEFgO+hdgOCiQoEmITX?=
 =?us-ascii?Q?WghH2oMS2U4IPt2v+8XWQiNLg8ZMZY7zNivTaxOYP6sEl7rwjtTGunQGodSz?=
 =?us-ascii?Q?mASM6nBhaI4QQx8m3HDvAE+IxCm5YyOJ2r+RojZQ33lgG0cE1TJp6UMTu8Q0?=
 =?us-ascii?Q?YrofM1TeD2mgyQBmQIB9pVA/B6cVRZrclUwfFaQkgV0+h3HTAxPFijV6CNVq?=
 =?us-ascii?Q?PNyr0UpioukXTiIlO/hlCdjM9XYA+lOzJX1aOQIistHCFuGcgOXh6iZukvmI?=
 =?us-ascii?Q?sJDKmF7UYvrId+9BKkuqIFO8ZT9MLLeUiRtv3Fszgal0NWpHJJho0OJOmdgM?=
 =?us-ascii?Q?OK/bqmfzhawSWF+7NpzenRiof0/ZuDTni4MMBCUy9H4is8WZMM1v69KYngjn?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70f5e88-a335-4b62-ea29-08dafe537275
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 21:39:18.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqekUY+oPUZHL3Ta07etqFHaOipf9jRd9YapzO4ilvWOj1Sxx3ib5KBYfW9rWlDC5acmW1XR7rNld54baFPCa8vAv5F84wKayKC0aTmiEmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:58:02AM -0800, Andrei Vagin wrote:
> >
> > *facepalm* good point, i'm wondering if there's a reason CRIU doesn't do
> > the same for SECCOMP.
> 
> Because information about seccomp was in /proc/pid/status forever and we
> started using it before the ptrace interface was merged. I am not sure that
> this is the only reason, but  it is definitely one of them.
> 

Even better reason to drop it.  I'll send out (hopefully) the final
configuration here shortly.

Glad this simplified down as much as it did.
