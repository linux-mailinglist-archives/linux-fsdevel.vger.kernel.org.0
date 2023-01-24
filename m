Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD25E679F36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjAXQy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAXQy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:54:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135618AA8;
        Tue, 24 Jan 2023 08:54:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpDa8x8IJvodNl6JCsBNY6CdIg6T8wHBVoWI8tDNKqenUv31u9r10QI2KZ4TyIj5rSXNyD1J2TFXf10DHjKi8SpJboWO8QdLZqdDhL3vC6AhaLiaNR0ZrIFd9FgmPygN7Re6VK9kP7NF3yT8XPJhCILoBwb9+8IE5Z39Kz8Q8q8p2hAnR7bMhOuMJGTZi7YdGi7h6bqUEKQP97SICOkxERkS+e1EtI/LYwfHdgmBBblqQckfK+E+dcQ+lJIVIxxyRKEtjLR0AM1wZmGPOZJ1rJGjXyJMwXsR5sWycCUAnqssl9XM5WwN9pWsfBZ3uD/L7RsyI4JoDqBrZf6tfnsLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ3jZCoPmaaIYYGQmXeiLZ2avZcVnHpINnVP4aZ5BEo=;
 b=QUFt5ZDsx2DUz84BCTvWRyACU9iG/+VM+3gCM1zYCGw+78sqlQ5/KGv2zx81SKoI6Ei2W62uH+4QDGJLdI/rswFg71ltUjfQ01C+EWxkW2NnN5o+TRTum7fUgVLv+pEk5/B2EG/AoAW4UdrIenlXLbNbhP9k+7uco16wEQzEIau9pAy0g9nQyZOxvJQBxY1igQnYs0eCwTsMldkCykfPh+8IxqrgRpVBkj1oIQweG/eIC9QGZfeljAkikpIEd83hluTidNQTd4MIdi/9Seaw83jzVxsG3hTZH+C9VcLWx8gHRYMmxn9iPgp41CU32XCoVu/H+kOEZsCJIO/kZV8xHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ3jZCoPmaaIYYGQmXeiLZ2avZcVnHpINnVP4aZ5BEo=;
 b=Mf8G1Z6d/13qnea54lHxsw/jQ5naIzngpEKzZwIK6eB8WI4sewTs90LA6sb1rNzSvAlI9UMW0bQrRm0Sk1iRcqO4G09GDS4hN1a6OwrovQijqKkAbRmWUnvfHgAsDYV9KDKWIO7KZNcZh5IzgVMloTD1VPMPUm+7C6tjb8mzTyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CO6PR17MB4946.namprd17.prod.outlook.com (2603:10b6:5:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:54:25 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:54:24 +0000
Date:   Tue, 24 Jan 2023 11:54:17 -0500
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
Message-ID: <Y9ANOfzl+iZSBIEP@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com>
 <20230123195228.GD6268@redhat.com>
 <Y9AAcuomaVM2JRCA@memverge.com>
 <20230124164347.GA28280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124164347.GA28280@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CO6PR17MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d2c4a3-007b-4927-8952-08dafe2ba5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWA4+fukHG9kvzxR6eP7UUW/ANhf5rfHzTE/R00PktsnyxX6eMev5PXYB8GeVGK2DWF3iMEYKW0+4up3YoCuSFBm7i4ua8vUQPpVlsfR/vW/uy54R9R1APGts62+xD8nwa/B65p3JtsEzJIWxLlxR4i+W7UycZ1Ki/F8SEhRlRF8iOvXi8eWDwahqN9NjsGXVnMuJuK09TLTaQcnmFleEh0dgCqHZ0NXmf61Dqvgp3UxS7ibEs+teeGjWZPrraqucBPjDYufEdGfx+Yzfv0jpV6V5VXqIBghDsMQXXmTlv7lDxCkZ8bRsepe7e4zqiqONJkWSRpq/upWkPTUKVE4epBmA+56dl6m8C3TDQgGN81WvmcOu3xyrE22ywwVjR2Az4iwH9t/MCap6UOXqIsuJx4xH9gGAPDKAP/Tqp5HR5zTgVretOnQMf4TJaTMwteCmWE0ZmE6iUhAtx/tXfURn7XLHww6VVdiOZemQsKp5XCXBvqIPVglBtA4LIu1f4m3RfFwhokXGafoHxMoNO84MA5sv3OAQkEOkAJngxLIBf39EDQTKHRRCyozki18I50pomHHt+CBcWKDkGkMGDECAuIHdWyGaK9BRtfZHqJpGbQzgEYVbPWNpugx1CeRHi1o9Uy6w0nGyK9evf3qVfgPu+KCo2gnaCZXS/IdMVIwoKy4QiHa+8vwfk3TKu/0sS9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39840400004)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(7416002)(41300700001)(86362001)(44832011)(2906002)(8936002)(5660300002)(4326008)(316002)(6916009)(26005)(6512007)(6506007)(8676002)(186003)(6666004)(66476007)(66556008)(2616005)(478600001)(6486002)(66946007)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrTc60nZxm+7Z9NpWat5aswmnzh0KkMm13t0S617VOwvg8WqxR+qtfk1Q0Zs?=
 =?us-ascii?Q?W2FGJd2nmvh5Et8/uhlEDeiQsetQCAUvmk4E1DdjgT6AENIY4NpseNckJMKm?=
 =?us-ascii?Q?/Hw/AkWsf4N9a1rjT6Wzjj7VTKl9UgpoItyx4TVpeocAAcWALHFn7GkWyOb6?=
 =?us-ascii?Q?XA9nP+kaVTHsZKRV8qSIKrtaY5DhSiaTGHmRJF/bdGu/csvli0Y6oAB4eV3O?=
 =?us-ascii?Q?jLLeUmY5fX1UPKwOG3loZFWqErO9cGQNyLODDyDb7SkKjNnL9eCHKHe/zrlO?=
 =?us-ascii?Q?HsJx7MxjFrAI5Jcp/J/5be9Gnw414CIuas7n0lJMEKIMH5mDycZDmhXMbS3Y?=
 =?us-ascii?Q?WgPle33S8o9e29uRgG3siqwyTxWiZMfcO3GnVOk3WHMFaYEa4TeKAr89NO7L?=
 =?us-ascii?Q?IJHZo6xIcZJB2vkHu6FwnulnN8Is/bRw9J/w1BmrvArnJWFcHkBP4eidvq6v?=
 =?us-ascii?Q?uJMUoyQPXsLCg9g4VERSv7WQpIPQq6Qe84rwetszKlAFT8I9NOlm9UZ9Y8od?=
 =?us-ascii?Q?1BQdQ4483Bj7uc/aW0hP+r/JY6wl3evXr296DMbfAe4j18eMGvOg3LC6HP8z?=
 =?us-ascii?Q?mY70Rfa+eX0M4k3X79TrN2QejNA7q7FOfBfTGI1Jq6qRURYuYOmyQB4ILpKt?=
 =?us-ascii?Q?R2cYS0uL/FqW0Yn1ZR1KGf4t1Aqrt1NJrxIxPs4U5QyhHCUN1hRKYxgcaeY5?=
 =?us-ascii?Q?vXXHuWU57+S/uS4BsxAQI7bKJDri/rAWgRL4a6/xRHEeE0Jq3OKz3d2j9GZS?=
 =?us-ascii?Q?747Cl6xLAzBdXU2+5Hm8H9wP25zEeQ2P1IkMKIIXLXoM6yjfc333VHiLn6o0?=
 =?us-ascii?Q?FdmdIrIhPWWbejK21N2jaF1cs9mCNq07zZQoO7tL/HoXjnfLwaQElNgl+EoV?=
 =?us-ascii?Q?FqO8+dUrV24af3vPPm9jH9ewnZJ5Lj33kc5bF6BzGEI7CFdLFpGeU6xsObxI?=
 =?us-ascii?Q?xqFKATI1YJztWOjcwMTPue4gU8IPXws7kc34VLV52TdqEYOgmYZDwNTSfjSz?=
 =?us-ascii?Q?MoLivA2AtejULSl7uPbrhVC1r0y8mFap3b4ukA5H7JOHOtbaHqGdsN7jQGGA?=
 =?us-ascii?Q?XO1Dcq6P3mjLmr8Bu8/0ILi0/Dxwmiz9Km/b8pxCu1MOboTuvIFYkmF0phqf?=
 =?us-ascii?Q?MWXQ3ctDT1EZxC4oLy8aun481XBeQxCFz8Y7iwvxaMbDIH3zHh3VKDWFosxn?=
 =?us-ascii?Q?vwfMjRIvWvZCML90f8VGbhHRYLc9z+PMc2SfZhu3eVT6cbZW/YifN8Tys6n4?=
 =?us-ascii?Q?x87zTjKBZqHuw5VlQALCYnVhBbgAgC47ByfCOeed84E8Gl3t61izZISS2t3/?=
 =?us-ascii?Q?gf85kBOF7uIbzPOeB9Vs58ET4/82SHdNihN7W3m68bYqzmMHI+hcV4duA7Q3?=
 =?us-ascii?Q?99jtBQ0zdTVu5S/DuVSQcAFFvhZ3h6D3SywWiEOPMEo7vQKKwiSYbIMsnTf9?=
 =?us-ascii?Q?hEchyhP70amw7Qk55hUX3e9Nk0EFLEQQNH/bETnNDsWuAX0xkyIX1f4ApAOw?=
 =?us-ascii?Q?hT6vC+2fD9hJCFHT5olU896ZtxVIyBp1yQJmnIhDK1inTddeMhspIN7UnCct?=
 =?us-ascii?Q?gPyJugCEEgkDoItJsPvk65SB/avVR+G1McjUf3nrZVFf9gV4yGDGHiF1SH7a?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d2c4a3-007b-4927-8952-08dafe2ba5e4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:54:24.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PXRi3t63DUx0QuSDBg2YbZGHv8eLrXByrowCEs3xgFm18tpoT79nSHCpjuV2m+GGvGZdy835cbUYA9+hXVuL3ZXmlCZE653AvKjzPQPC/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB4946
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:43:47PM +0100, Oleg Nesterov wrote:
> I won't really argue, but...
> 
> On 01/24, Gregory Price wrote:
> >
> > On Mon, Jan 23, 2023 at 08:52:29PM +0100, Oleg Nesterov wrote:
> > > On 01/23, Gregory Price wrote:
> > > >
> > > > So i think dropping 2/3 in the list is good.  If you concur i'll do
> > > > that.
> > >
> > > Well I obviously think that 2/3 should be dropped ;)
> > >
> > > As for 1/3 and 3/3, feel free to add my reviewed-by.
> > >
> > > Oleg.
> > >
> >
> > I'm actually going to walk my agreement back.
> >
> > After one more review, the need for the proc/status entry is not to
> > decide whether to dump SUD settings, but for use in deciding whether to
> > set the SUSPEND_SYSCALL_DISPATCH option from patch 1/3.
> 
> Rather than read /proc/pid/status, CRIU can just do
> PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG unconditionally
> and check syscall_user_dispatch_config.mode ?
> 
> Why do want to expose SYSCALL_USER_DISPATCH in /proc/status? If this task
> is not stopped you can't trust this value anyway. If it is stopped, I don't
> think ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG) is slower than reading
> /proc.
> 
> but perhaps I missed something?
> 
> Oleg.
> 

*facepalm* good point, i'm wondering if there's a reason CRIU doesn't do
the same for SECCOMP.

either way, going to drop it
