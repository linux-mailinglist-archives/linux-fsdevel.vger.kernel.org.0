Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5667843E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjAWSMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjAWSMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:12:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596A199;
        Mon, 23 Jan 2023 10:12:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Str78asDM7PW5IzE+9aEvtGQwzW2I8zBP76VXV2Erb/klydhEWNKSiKe+evX0saX1lQiXQxfIAbVKujg+lVVLBd/90jUQkaj+t75ZPrBTziYXgtEVuWFfCS4dmu9Zf4xdMvrgbqROdrskfD5xuTa05852/PlZOG437pOEuD/7uRxL70lrQ+A2w1KnjsX8pOduSB2gTkMo0DBtxqy3RrB7Ukb3zOx7jqXI45yhj8rBLKo37TZhRkbSsNDvU3ALhgefQ1flsMlWHGW3fiEAe1ORWvwi1RgFDsGmY7E82OXEjPY6PhT8vvCrCmhQ9f4ThjAJmDb5FzvUggcZmY0PitsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUYPshG0lkASZ8zUrp0OY0kzq7mZQ1AzAnrnBcMoPrE=;
 b=BiSFEBTbjJVbm6Y6Gs23P5YLktLuEwNMBrKqmXNtgmV89GCENuOmWZr99CVqQaHV5DxWah0MhpKZ7QxGtFBczOKF2Tu+cZIlYem+mgM2/q2arE8A5ehBHY4+nKeNs42Prq97c6Ogo8bUvu8mOJB8PwqmaET4+Pist7X0GWCs/fs8rpA5ZVZoeL+wEZfuTisiBALo0R2++qHzZZRpUc9tiRGqdMmjB9qtFjZQdWwFrEmeEWBONG5/I/q/EkVLbcl936hBEVj+ULwbfzT+SqmrZhE2GFBocCa+UB4HGV97SFmGNCEoXpjQFcA1akWJn7vlkRYDhO5x+msFQHn1lW4N0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUYPshG0lkASZ8zUrp0OY0kzq7mZQ1AzAnrnBcMoPrE=;
 b=weRtu+zPdrfVmaeKfT7mfT757bZpW4ZqLFJ3veK9Ogv7vifw+b3zqjNedIkzU1kwv7gyuEuyjCgWKB+OotBxevImRJLmVURQcShO5Rx2JoV2OJiTXZgSwW2roI/znZJ6IXJNDpfgt8TFpQwfKS3J+10LJFl4n2f4IXQ5s3aJP3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY1PR17MB6831.namprd17.prod.outlook.com (2603:10b6:a03:524::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 18:12:40 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:12:39 +0000
Date:   Mon, 23 Jan 2023 13:12:33 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <Y87OEdDXwZG8pmmE@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123154101.GA6268@redhat.com>
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY1PR17MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9271c4-6c06-4b96-ee10-08dafd6d695d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqxCvm6O6Igft/keIbQgGr5CdAcrl7bdQcTPPS7JeQwfagJhmjVBkcYK4JTk6gc+hHAykOXUqIp1ex5wcAkVMRlF/MMaZ3M24mYa1Tlc8bDPTv+WxMwu2QQQcNFmQ/pEKmDglE/GMroDiq10qafyD+U0pEI4tA6WGOZf7BDTMqV+5g1ATlZAsQpSs3UaO1k4LHvVMJgI3yj0h/TqS5PfzS+q3QJevSVbn+JQEQ9xtEXZORmQe4QRzydHNA34qZwt2QWO08ZsmZjfb6ZDxzyX/PsGdpn38YTvU7/2jIJNUCdD2pLs42FAdgbvIeBhBaG7T2AJCafEdLK9cXG/MUqNXT9ML9Ih3qwotA5VGh24u1HgDmpeyKtppduL5CaKrHTdHJbhJUvjO13+WGwr1YkLlxHE6mz97HqLnS0pHMc1vdyPfAxigQKlYRhmaWndOQ+dElXBku8heuf9INIv3w9w4UFvTgmm4XfBwkdmDZhw1xZAf+F+Ntqz8XFqyP9fJgXN4tvN0AOr847qxFDMqlHOI4Ojxgwcwu6+0XkZV3QwLm/F1DbDb/9OIVnurFtpzzWe9xAgmosDda+5eqMzDMzMdhLJm3GKoOcC/oByNSpxhXEBfJ+bjzP4PsMBt13TbGsjs7de7/GLxzJQnaVbL4rwEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39830400003)(366004)(346002)(376002)(136003)(451199015)(38100700002)(83380400001)(7416002)(41300700001)(86362001)(2906002)(44832011)(8936002)(5660300002)(4326008)(6512007)(26005)(8676002)(6916009)(186003)(6506007)(6666004)(66476007)(66556008)(316002)(2616005)(66946007)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SaBStsA41s3/laouuDYsr/GCYG9/ryGXPnWvKT2zNRktCSJneHUoqI+FohPP?=
 =?us-ascii?Q?V/5mRIHC5rxuW2hLvnWrV3xClDxhKxusVMmzBqU122jGF6teDyRHTn59yKdp?=
 =?us-ascii?Q?UK1XBVye1h43qRuqKn/9aHxOeb/0Unr7dpPT8LIddXCQxoLJtwkYyUBJz/6t?=
 =?us-ascii?Q?OgEvcaPpuNG+zdiqOeWGgavGJyH6pJTEj1ZHwQFvNXKdP50vT3O6X45ib5QP?=
 =?us-ascii?Q?Ux70GP9hs1TjizPH8/0olUyxIKTg1irq67GKeqJRNwBqhbz350qktx+gqBcV?=
 =?us-ascii?Q?+wierXbESt6wm5EKtgcMnx4yfIN3mja+9rLdbUDIVyoKX7zJ50owDdayNEFe?=
 =?us-ascii?Q?gzhnygJMCkPpr1UkXOTZLxtJfRQ106VO4v4WIBe9RQRSG3BH4G9I2iZsYvpP?=
 =?us-ascii?Q?30YPRndSh7klLO98qbrjfbLalkgjCIqmE7fZirlltfxPi3OyCSaVoeHLUw/4?=
 =?us-ascii?Q?D3YlZ+JRD4nqFxVX4Y2yhZYUOwsUeDeho4VgKAlranqest3s7SVvnddwUT23?=
 =?us-ascii?Q?syMuiejrOllwvIOPvNhrIbtEXNyJmd+/MicChF1evFysiF3cfxZMgJrpAgTs?=
 =?us-ascii?Q?6Wy/Wryffz2NI0v3Lz+8b3OH0GbR9Th2XNWTgTrdWJfnUYhO70dlUADoVY4I?=
 =?us-ascii?Q?XfPU7XSrhtm6fp/fiQcSof7spChn1HFPY72fUhNjKFRwuvuB95kfyBxPjkbH?=
 =?us-ascii?Q?cfFJu87ApkZ3FzKgk8yyUHZX0jjAfE94GksvHEf2yVTRjcErRe8/QOIubUmn?=
 =?us-ascii?Q?8Li2je+P6zG3/eLuMLufKGEQeNKgP63J5w2VNQ9ifdhBLDxxZAAbSWWgCwHq?=
 =?us-ascii?Q?rx6QGhIKL8VuVpGdDO5G8garZdhBYNIKX8s8Ai8WcgnrlIve5wwNx0TcSufv?=
 =?us-ascii?Q?nmqksDneOHcdlmhpDjUGlNnGe4dCXyvj7ir0ptojAhwobfW8wRYyeU9TNcsP?=
 =?us-ascii?Q?sDYoPmCYfNWCEdxIA06u1uAQPVBogfYWTqg4CXxcUvJDUHUD303S976vDrZ7?=
 =?us-ascii?Q?CZT10GBeMDKEGDYHnjjKMV2rA4V3r7xtvnl7MUU3jEACr0ASYjz+SHHqtwyx?=
 =?us-ascii?Q?wUP6LYR+3I9IQbj1e1v1cYyqpQT0Y5qU+1YtzDeXbcjjQoSL0xRxHtxU9nTP?=
 =?us-ascii?Q?LIqMS4AollFnDNIUzJi5EgqMfbU4npWFmYlQqhWX3fs440INz17Pa53WUfae?=
 =?us-ascii?Q?oiolgvPeAYSaSbbnThTagtysN7umkyQ/BKrbg/Or3LYKDEYLlbezmLmAcJX5?=
 =?us-ascii?Q?x4oGyrcxtfcstprh5ZixYgKqCT2vVG4LOWHC3lOK2yfhggcWIa9jP9JultxX?=
 =?us-ascii?Q?o83+M2L6uYIHrHY0Sc5Rco/X5qLHtWbWgX2dzRlARfg/egsXb1HPyBApJeGN?=
 =?us-ascii?Q?0voMoeR91raHkpBnW4gbQ+2bOoMsJt20ozYh8N87fLfdDlkrEwJ0YARil97d?=
 =?us-ascii?Q?3Y5sBIucyiK89c8qdzwZtsMWj6tvEGv0runwQ650DF0dFkKPiWiT4kFFjEjE?=
 =?us-ascii?Q?EO72pxtF8g/mh1CeDPX3dxEOhoUdnTLKm0+a80xiPJ86VSMQGV9kGu26W4BE?=
 =?us-ascii?Q?uhaIMAWowtlq15e3XfA1ZSAy7rI+wliG4oUa4bI7gHCLQvW+ZqwL/+t1uI+P?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9271c4-6c06-4b96-ee10-08dafd6d695d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 18:12:39.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Mm7bqF6L7R0zNC3FOEcmT+Dv57okheyF2bJkb+GXZaX7xA0PWK/2vkijH0lqiDUOS2TH0/u/eoWSC49JEvSDUBeItwsYP4xnPMqchpQTWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR17MB6831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:41:02PM +0100, Oleg Nesterov wrote:
> On 01/22, Gregory Price wrote:
> >
> > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > +		void __user *data)
> > +{
> > +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > +	struct syscall_user_dispatch_config config;
> > +
> > +	if (size != sizeof(struct syscall_user_dispatch_config))
> > +		return -EINVAL;
> > +
> > +	if (test_syscall_work(SYSCALL_USER_DISPATCH))
> > +		config.mode = PR_SYS_DISPATCH_ON;
> > +	else
> > +		config.mode = PR_SYS_DISPATCH_OFF;
> 
> Stupid question...
> 
> Why do we need 2/3 (which reports SYSCALL_USER_DISPATCH in proc/pid/status) then?
> 
> Oleg.
>

Actually a good question.

My original though was: CRIU uses proc/status to determine whether to
use seccomp dumping, so i may as well implement the same thing.

On further thought, I think you're right.  We can just always read and
set these settings regardless of the original state because SUD is not
seccomp.

1. if GENERIC_ENTRY is not compiled, and TIF_SYSCALL_USER_DISPATCH is
   not available, these settings get ignored anyway.
2. if disabled, offset/len/selector is guaranteed to be off
3. if you try to set something other than the above then this will fail
   anyway (see: set_syscall_user_dispatch)

ergo
4. It's always say to read/write these settings.  As with anything else
   you can certainly cause the user program to crash by setting garbage
	 but that's to be expected.


So i think dropping 2/3 in the list is good.  If you concur i'll do
that.
