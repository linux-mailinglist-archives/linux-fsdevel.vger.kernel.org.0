Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABF679E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjAXQAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjAXQAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:00:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759ABA;
        Tue, 24 Jan 2023 07:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juCJLe5fQe7IUPsxrS2Q5VEfB7fzhzTlztUbkeZYfl76MedmA9CRW+WwlWVJbAOscD17nhr0DEX02Z8LdFNbuPYBDI8QsoBXA2RAvbySMmw2Icvt/xsSFKhW44F4jcsfDbmUd6CcU1PkvqN+IfS7WZdAdqejZYexKgnc0Rn/NkHdASLUqfZ6UmDIPmnIUAPwhaqfiR6399JhQmc91GaRu0qXSrR5RQz3aLcpm6wvPYPyqHaYWkkc28z7TxMGUNnyyS7heGKmz1LxTVShTt6XIKOUGgzpTHtBnxBfJ9tW6CeC21JuooIkttun1114ozDQtMu2ezl693yNhS4ubc9lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYFd9SN8uyt7sDJWr1Z6HvxkKuUrSIfTeO5zURDGchM=;
 b=lZG9KgZLB6ghVGjHMYj7axap06mMlca8JRNWqy41EEShG+GcwFgIHfgMsF+YfLrfy/LLk788GaJFQAPm/lpkrkGFlFir5ie9UWM68eea/sbx+mYyaRDa2EY3YvRlgm+TGWMPrbfB9BoqSaIV1ttZiE+drlQNs8MHgGbMZA4xWuPQfFqBxeiSxat6Ciob+UX/EgckNLNW344dtWeTdTlQiFu/TH9HH+UovU60F361LK0nEsvP9m+miwhhDknSO7fabH4KGX0UwMhCkcak+TFWiwbujRRp+si3IMu0g0062kGTZamxyFGke0LjbBxcaSagizHZX3ZOkDatvMjKzHsa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYFd9SN8uyt7sDJWr1Z6HvxkKuUrSIfTeO5zURDGchM=;
 b=S4XFGy6Iwau0WKgXzkqaY6ZnHQcWXsRnlH4HH6/8mhdGcFx91n570xVdPOXiopeGOe92N7+z8FKe2aerGp2FOJ6C/E+U5c1j17CNUe+HgDjZCasU9AjXwJjrl6bIYu8jx3nCMLinZuwToUo3j+Norki0PFS+k4tLMdLBKvsIlpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA1PR17MB5106.namprd17.prod.outlook.com (2603:10b6:806:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:59:57 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:59:57 +0000
Date:   Tue, 24 Jan 2023 10:59:46 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, avagin@gmail.com
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <Y9AAcuomaVM2JRCA@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com>
 <20230123195228.GD6268@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123195228.GD6268@redhat.com>
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA1PR17MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5c9749-da80-4c63-1148-08dafe2409ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbjWVF3sZCW9rgIj7RTwCFlBzX2mGpDIACid58ne9XXCsLkKPbwGEgHZ+zil34g2TFrkpauZQYUAlCpgP+0YvtLnBrZJ48Qmc2oRbaJADIKA44WGe4GUergXR3ENtLFlgeJsPaXcblvEB4l7wpRRjpAIPTTxDQ0Wvo1YdCNve0/8N3pmCK4TD5DVbM0FyhIiBXKAxyQBUYH0jgdjwDo6GpRKQBd/O2aklo+ka/gJAVmE3GsRx5Fnr27iqMGgtFjz9B91ZFnkLmdVGCXtBU1GP37zlY+RtU3PpqZkhzJcd3gRbtzbFqwr81Z9c8UmPMNmHQ5Sv+nhDJLYQEl4lxIOG83sePaHPeH+URWCvuSjNctjukwVzwGdPp5B6pITpoPC0KU3RijDIGmEBr4Ez0c6PVAPOcbQkFbrzJwd8tRAKF90ciDSGwmgexhCT7x7LkUWU7HCg69xskLw1Ec+Wz6tehB0r7C2YvAM3a1p2JGtfDtCD3QvSO7zmoPqAxK98MGLpRS+Y4Qm00j08SYPaafCWf2PLsZcC7vK2h9DR/JrVUhFvJQUe1kA97yHssxFEdocz1C0K1k5c9kbAS6YNbxIW0+VYIUV0gaqki3leIUgiwFAAorNWN5COsUfZpUvQAdYTlX8SWI4PFEROXBBLdE4sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39840400004)(396003)(451199015)(36756003)(41300700001)(86362001)(7416002)(8936002)(5660300002)(4326008)(44832011)(2906002)(38100700002)(83380400001)(478600001)(6486002)(66946007)(6512007)(6916009)(26005)(6506007)(8676002)(186003)(316002)(6666004)(2616005)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo0z7Rc2krAkqAQgfClILT9QFEv9mYrw0j2WsWDbe5ZojbnwBYoVHeEbMqON?=
 =?us-ascii?Q?n6SKpAhSKrk+VSnqk6dkVhyWUgu8XxE6ophAk3u31cQDWiamD52mnOgOoODe?=
 =?us-ascii?Q?tNpK51pepudTe+mC1TMXjRNl5ofilR39t50nKGUgLYEdvROMo6t/YnLsUnql?=
 =?us-ascii?Q?qnHeoHMGFA5OXcC9VG6F6oPIZPJaNde8KplxfgQAYFAQhXH8YSLV0w73OSCl?=
 =?us-ascii?Q?x1pj0C8If25atXCwsrvvRcEbk9JfMntF/qSSlzKjH3aMSh37nXAkWz4j4Bgr?=
 =?us-ascii?Q?kHq6Vf91yrLFgP5MpNr5Zjj5dr18nbsprIwwyYNFXNl845Fso+/w5oW1js5z?=
 =?us-ascii?Q?kUlk6XzJGTuCb6USGsbESS7+VVA/1C/pD0ABsNC2wP4up6036xB4vmFRCYlz?=
 =?us-ascii?Q?lA9E/dE68Utcg8E6bn/IBYErUTJgMyjR32uwbFCECggU40vJKx+gHIzdS5Vz?=
 =?us-ascii?Q?HUR3X4/dHi9tof2WsAV/GzIwnEkJmZdC8UjPBpW1KZpVZxtjUaOFlz5bcULK?=
 =?us-ascii?Q?AUwMuzO1J0r/xfVmNM1zq0nOwycSASsnl7F8fRLVeAxlkr3JRD60vwJI1Ghr?=
 =?us-ascii?Q?nrUxGP+OLFflH3QDIDYyLP28kGPuY0STbECJ5kAVlzvQG6w0LhEPWAL1D+ie?=
 =?us-ascii?Q?CJPZveR6bfZiwP6PZh70b6FZ9/fxV2f05Wv9950WDj5fyAFe4CfxQ3EB5CCO?=
 =?us-ascii?Q?qncTmr5Wule3fs10aDzHA9J8fQ9oObxEPahUdcn8SVyZqd4lMt4v2cFPjGr9?=
 =?us-ascii?Q?V5k2DTmHcmABtaFcRr4JYy74CIO3/RCCqNjVp0BJiYpi+20Ej2nQbmT8ZGWI?=
 =?us-ascii?Q?0QkwlyrH9C7JELS1jtV+1LxQAP59PdTPku+3iYzB2dvvwZIS+h7qOmocfu2L?=
 =?us-ascii?Q?weo5X3QZAAebH5lFsuwwRRWvorLTgbnsWTz42t63FOb2it9BA6QI8Gmwfr8h?=
 =?us-ascii?Q?tuXqA88Vlmm55aY+eZt7z7mF8b2ntkuloI2xlQp80yheJ95+zkUD53EQQ8u+?=
 =?us-ascii?Q?29Lrq54RDBsu15AGiY8q6qBVFty1gfUOOMgkz/c5DYLsZvTTmTCdMypH69fu?=
 =?us-ascii?Q?nyorEh7OqDMKZgE1C75zZacxBCbNd4C3GBSJxkvxzpRtefTQqTfMvLoKPE33?=
 =?us-ascii?Q?TKeVB2RtNjiwADAiJAh68dc1cLESm9LuWsDMnVZGsj8IY+/DecnmDhFRumNH?=
 =?us-ascii?Q?hp4LyPOIWi65E476eQsrFo3im2VPFB4pjGXkNpylTtqw7zXhOpndP7yS9KHd?=
 =?us-ascii?Q?N6GD38sjh2ifPAQ++clBQx6kovJ7o24Qz6uwnT+RFxaMBVTLLDmE2UWkZmYC?=
 =?us-ascii?Q?YhhRtwLxkmLMNniZNejX5/O+tjgmmmnZRvP87RjTSW1cCjvLE5WlxG0JSa9O?=
 =?us-ascii?Q?CgGfWu25HZSren6t0QaEhFgf9UfomOTm+0kUsi+ztqpzzCDk5NJlcvqKSnMl?=
 =?us-ascii?Q?QnJWSAWXF7NQe+0HuNcncUre1iUUbjB0UaEpUpBJ1Fkf+mTM/abHusqIiAmQ?=
 =?us-ascii?Q?zXYHgA8/zZTycGcevsaVF5SoMbXqUZTOp31bCBK6eD5hNe8/tWDVcR9sPsWT?=
 =?us-ascii?Q?VZSBFS2ZSZ2bwrbHKE87KqffV8Ui6yfLoMv+W7WlCOkJa//zlc+T6bKOx/MW?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c9749-da80-4c63-1148-08dafe2409ef
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:59:56.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIkMSvEKE0e9qbnXuJN9n9EYLsNn2+4lzS8W+31LqMEv1egP3eb/RlnHi1SlPOV89WLZxCmc/PDu3lFRdfSlf2Sfs1yotA25h73gTasnvNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:52:29PM +0100, Oleg Nesterov wrote:
> On 01/23, Gregory Price wrote:
> >
> > So i think dropping 2/3 in the list is good.  If you concur i'll do
> > that.
> 
> Well I obviously think that 2/3 should be dropped ;)
> 
> As for 1/3 and 3/3, feel free to add my reviewed-by.
> 
> Oleg.
>

I'm actually going to walk my agreement back.

After one more review, the need for the proc/status entry is not to
decide whether to dump SUD settings, but for use in deciding whether to
set the SUSPEND_SYSCALL_DISPATCH option from patch 1/3.

For SECCOMP, CRIU's `compel` does the following:

1. ptrace attach / halt
2. examine proc/status for seccomp usage
3. if seccomp in use, set PTRACE_O_SUSPEND_SECCOMP
4. proceed with further operations

The same pattern would be used for syscall dispatch.

Technically I think setting the flag unconditionally would be safe, but
it would lead to unclear system state (i.e. did i actually suspend
something? was the process actually using it?)

To me it seems better to leave it explicit and keep the second commit.

Thoughts?

(cc: @avagin if you happen to have any input on this particular pattern)

~Gregory
