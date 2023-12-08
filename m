Return-Path: <linux-fsdevel+bounces-5286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD63E809748
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 01:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC581C20BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9796FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="o+37JHhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A4171C;
	Thu,  7 Dec 2023 16:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K73n6+PlvmBWh8t1pLJOZ5DtwxBRmna6aVd8/GniU/IvCmyudpDCfwXZtM126p6ZRiw02ELMXOhlj5nL3E8xuNjjU3VybyNMGaYHkKmDDv5z2oX8BRCGqGoe8bu6/i0iCrg3xj2l5M0unC7jAgPUP8sB9jI1Ooa+lBONl0Sr7kgyKlCpXdVkhSZc0yMAAtXqhfURiap5r/p2kMlvXVRtH7FpLU84YKPPatm6ZwKuv6ioUzhw8/jutH/J9GBOv9lNzhRGCp/qMq4JRvtwtIzorgqCZqibTlJMyfciO051hQ3kc8ebQbm5a+eAW3Nu1pKyusgDS1cZnajwGw71/rd9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi6uDaDBJF8VpqKuq9PSPla/rVnh6GWgeSfJDHDp5Jw=;
 b=lKCUEGyF1TUa1sf+NoLuTMq5bqTXOnDjf4oVdDYgegi96MZIQOaLEu9rxZTEv9oIZmeA1R9VE7Fz0CojYkhaJRqqWAcWe+7qGfPn9C7rnA/Tc0Ia+obIqAbLD5Q9kWguduZWbljNr6NWKJ5FLaTW6wK927ADSn8ifx6xFpj8EEFYl+YfyXKe/CpmpxF3TB/PW+Zfhv5sqzLFbr5hpQ+8CLvorp2uUYQxIBf8224ScBUVjtAW5BteP2sBAKeumIA+6lhkglKW5KG5u7ryJ9m2Z8rxC8x7fXrNienL+W9Y57tFE8q35TWu1iFOWpSpGr4Slgju9fWgn9jOfkhC5Yuzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi6uDaDBJF8VpqKuq9PSPla/rVnh6GWgeSfJDHDp5Jw=;
 b=o+37JHhbnRpqsTGNkrHd8Ouyab0yv1Y53ZWBT5eGyw91tOYQmSZMb4Q1/hShnu6fb3Zq/nGMl48BT8SAHF68f9+HGz9jCWZvj2CTztSKOUGkOvRT40J+vrOeDMDFEXXN7bKpBcodkuQm6Y242XK9QoXdBvTbPl+6ucG0mEOTVmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA0PR17MB6371.namprd17.prod.outlook.com (2603:10b6:208:433::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 00:05:24 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 00:05:24 +0000
Date: Thu, 7 Dec 2023 19:05:18 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Michal Hocko <mhocko@kernel.org>,
	Tejun Heo <tj@kernel.org>, ying.huang@intel.com,
	Jonathan Corbet <corbet@lwn.net>, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	Peter Zijlstra <peterz@infradead.org>,
	Frank van der Linden <fvdl@google.com>
Subject: Re: [RFC PATCH 07/11] mm/mempolicy: add userland mempolicy arg
 structure
Message-ID: <ZXJdvmZCjRLDV50L@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-8-gregory.price@memverge.com>
 <67fab0f1-e326-4ad8-9def-4d2bd5489b33@app.fastmail.com>
 <ZXHdhVeel1dOxlYJ@memverge.com>
 <cddbf290-021a-49d5-8729-e98cb099ff67@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cddbf290-021a-49d5-8729-e98cb099ff67@app.fastmail.com>
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA0PR17MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f415cc7-0824-4c7c-9cd7-08dbf781604b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yxyS2HGM8KZ4F4Mg6czGuEQCByj+X09NUI8RdO6Uz5weAJ48JJ/GZpmsOYAIXRvJj4V48ywOsP9/2kFmBKtsXZb5DT4Eza4/SNWusezM9RRiQCoSluSYxL6hljZaSa8dqsC1nkWjfnD1Kpx2CCQKSJEog89YXzRd9X9laE0IQgtKMGRAVt79jvNVd51sZPMTFSXeDE0HSSV7gNnxDQfD+W/d5SXktKhESqGJ7K4uU82b5eQxej4eanHFYzp/5A8bS/qv+z8Pp2vGXURTG7VC0DEJq6kiIvzH/a4O3RVpFVPmij+MemqicpzJjqIdf5pGLmYDto/3C+uAWTbTtRztsbSCwc0gA/3eIqyEIqXjQKAR8p7kr9t4q2OrZT2yzwGiT29KnrIjA3Mmr3e7YeSLZok09D9W00Sjcagj41Epr/tz3geF3lDhiZ/pTPWvRhxygV2hHtENVv6QRmalvNP48UIEXwgWo5+yGt4xVewvAzX4gHyrkz6K2As94YvSHSBFKn+2zOmltRUgpy1fd4/yphMmez5Rn4Sl2VQtElWN6B42+6vro8Wbeyu93NNV6JHg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39840400004)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(6512007)(26005)(41300700001)(66946007)(44832011)(316002)(54906003)(5660300002)(7416002)(7406005)(38100700002)(8676002)(86362001)(4326008)(36756003)(8936002)(66556008)(6506007)(66476007)(6916009)(6486002)(6666004)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmadOaYVVt8S8Kh8qzD4hHjBpSnZmU1T3TxQAVgwNumpF74wLh2y7urvwq9b?=
 =?us-ascii?Q?F6+TMt8Jo2mOf1yGeoUhKIUmQgO+rLeM8c329Ekjzq/xa1G67oluIzy5jzJU?=
 =?us-ascii?Q?mkMavlZ7drbAFcBmbdrKGRGYDiPz5JeJ65S5eQ1RlhvKwcqOVMURenAkSI/D?=
 =?us-ascii?Q?hZ1ZQaw+3r7sknWVTGI1VPYNVNb5ZhdBZxrHVEA62R25aHcbMq59uZWA0qLP?=
 =?us-ascii?Q?kA22i8Hjcf4vgfWDkL9MFiGYFyQEbtmGtuEaUeeihIj/YkkUxWUqabPlipqE?=
 =?us-ascii?Q?Xp/u4KF4kJrCIfNRerXIGt2diyTmQOqrCoMImCrR7mkQk7GP6o1OrFgp3yT6?=
 =?us-ascii?Q?ufJNxB0+h9z0d3MfzZn50NPo+4a6PpHFeewN3MfbSREAuOnjqy7jmtvSHSYH?=
 =?us-ascii?Q?sryrIVQGw7y/6djFJykc3FcOwG/3wfNrftNhVrvLC93zKid4mi2h/C3liYI5?=
 =?us-ascii?Q?WUNN0JUO3CW7e47ZTPox8/73bg1wrsHpMGGJKYv9+jIZy9R66EkJc89h6+9W?=
 =?us-ascii?Q?Qlwq+d1sdPP0EugG8Yqpr8Mtr2r1jMhCoCobmmVMF2wp2LjqatRZZrih3cEa?=
 =?us-ascii?Q?KCexQ7eAaxmgDxAMeSLF7g8u8QGo8xYD4/dLSez0vuXDMDOXVOsBT46pI/SY?=
 =?us-ascii?Q?G24ZAkcEn9uxdbvSjKZLp0ADfsaQ98n0aeRfd9x2TJe9JK5Hy27JqhudcvvJ?=
 =?us-ascii?Q?XSwEMBxz0lgSCblZWFgVfAg0u09nuUX8OQdQNUAYlon3lKBSqr2KQMS+P9YH?=
 =?us-ascii?Q?RVM3beby354Ud1BZQIubZK7oiG2CofT9u+a0KpeLwASediyN6oEr0evIVhYq?=
 =?us-ascii?Q?MV0XQCCzqqrZr7d7DDN2B5YQa1Oj1FGo8oPB3NWBqwf85P8RZ4WUUixwYCrV?=
 =?us-ascii?Q?/JC0m74AJfmbytQdneDnPZbYnGqof5KJKdaJGn0lpd57nuy4NG3172xi7IgZ?=
 =?us-ascii?Q?qO00IdioIR0SXFnKrPVyk2T7on8U64ESoAH+wCF4kamAiYMb5PhoprQVbO7q?=
 =?us-ascii?Q?dnovyGlz7Fcd3rB8byVTJIsuObk+9W+7rolgpSF+xYA12ZkqrBHM0Kd5jXlZ?=
 =?us-ascii?Q?nhm80WDKXjtt872iMxNRUy+q9WUnwKx9vncijFnTMca2G/RJJBDH3Vy5QlBH?=
 =?us-ascii?Q?Uqzmp2IX0CvHaTn0p5ER9v+Vb4jwDAMIxq3IZvICJ7BeNtfsXxqnr/gXlPkf?=
 =?us-ascii?Q?FF2V0oD5lUI1/VDf0Y3FExEUghf7I2RtAK/LPBxHgh15aryQrMnMtKNYlvxn?=
 =?us-ascii?Q?hl0NZ6Znyb0Ix9LtzFPeQ5hjwR6c5LKHcuYDb4K5ZgbEStvbGkUnMS5S3Ee6?=
 =?us-ascii?Q?KjQZRp5iHTfuOqVCFNQUkON02tyoxphLwOzZ6R07uy/iMAS499iwxWTHdEeJ?=
 =?us-ascii?Q?CB/qPcESU6SulRHQr2M4yDWZ9kKXDaIje6eQCAqPXanqwsJy/cvSGdXEW/VC?=
 =?us-ascii?Q?evzsURoDj871TsyEQzynkVbEWFr5K9cZFMc3ALu8t4lVuf91E0mRWCC3Yapa?=
 =?us-ascii?Q?5IKn6wH+fLpd5wyqPd9KrjqQEynFXSrWuQrOnFIP8oSlpn6RYyxtnOpD4bRm?=
 =?us-ascii?Q?bTh96czPlcLNMS8i6rpbO3d13OT5Qg1BMWHUoOUT5sU01u1YPg3oswntAxBv?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f415cc7-0824-4c7c-9cd7-08dbf781604b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:05:24.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvakIcKHlXidbGI3qAlGm/pX23tawRr3opOxMggkhmlLw/yNrNtV/BYCrB5AkRO6XebWAezWBMpVSFa7ydUqVDQAGl8MS1F1Gq6FLSuyRAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR17MB6371

On Thu, Dec 07, 2023 at 04:43:03PM +0100, Arnd Bergmann wrote:
> On Thu, Dec 7, 2023, at 15:58, Gregory Price wrote:
> > On Thu, Dec 07, 2023 at 08:13:22AM +0100, Arnd Bergmann wrote:
> >> On Thu, Dec 7, 2023, at 01:27, Gregory Price wrote:
> >> 
> >> Aside from this, you should avoid holes in the data structure.
> >> On 64-bit architectures, the layout above has holes after
> >> policy_node and after addr_node.
> >> 
> >>       Arnd
> >
> > doh, clearly i didn't stop to think about alignment. Good eye.
> > I'll redo this with __u/s members and fix the holes.
> >
> > Didn't stop to think about compat pointers.  I don't think the
> > u64_to_user_ptr pattern is offensive, so i'll make that change.
> > At least I don't see what the other options are beyond compat.
> 
> Ok, sounds good.
> 
> I see you already call wrappers for compat mode to convert
> iovec and nodemask layouts for the indirect pointers, and they
> look correct. If you wanted to do handle the compat syscalls
> using the same entry point, you could add the same kind of
> helper to copy the mempolicy args from user space with an
> optional conversion, but not having to do this is clearly
> easier.
> 
>      Arnd

I don't know that either is easier, it's basically just what annoying
way do you want to handle this annoying problem.  I'll poke at it
and decide which one I hate less.

One thing i didn't really think about, probably the iovec/len
fields should just be args for mbind2, rather than embedded in
mpol_args - since mpol_args is supposed to describe the mpol
while the iovec/len describes what it applies to.

Simplifies the mpol_args structure a bit. Doesn't change the handling
at all. (bit of a rubber ducky comment here)

As always, I appreciate the input

~Gregory

