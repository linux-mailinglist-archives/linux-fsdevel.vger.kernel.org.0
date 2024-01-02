Return-Path: <linux-fsdevel+bounces-7136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C88221B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9373FB220D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04515AF2;
	Tue,  2 Jan 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="KFSWKqSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B115AD8;
	Tue,  2 Jan 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpD77qjkDgTJPvzKA+FtePdOwt2Wpzpw7If2au/jInvWByk6GkD/Pqg1G57XA3gVWcxQWXDOwJKWeJMkNVn01jZ9MLdiLUdVcWDzHvJmV4P6P8xdoaOz8ID0nHQ1tIp0YkInsOveErfKh1tu9o28m3Ig8cYjXlk52XNmNQJq9igTUzHwW/k3pBHGEGUdpuvRc/YfU42+ZvgvDO9rAoe8DUsdMFxgSP530xGwz8E8mfMH71j70JvSYKiF6hoWjmJTrQPpctQ3vh1l1wPDRzq+5NvY83p8GPIEEj7HE1ggIcRnD7oUF5zY7gnFomuwd2FcLn+8N2BZ6L8bxEVWjp2emA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzeEyJq3m7iAvzRAORC+trfETGy5lzrqQNhSDdnF884=;
 b=YmGlXTubC/Nkb0l+twQgc+cLnv5wzVZWDPop10Enni3LyQiMGWtJmOuoL+CENX0q6/BiRpHlVQ2BYv4EkOHWLuKLqdFes0MuQvHgaYqfJJ/S5sos4Rj/N1n/DfZ9TADtnY46Yrqa9iC6cagW7Q+Y3KJotlgNsIINceIkW7wqEE1Ul6bzsS5Iv1Pa8P25FW5xtORPr6WY42nTdSwDqzgBm+r5VrzihLJVlIkeHCxZRZXKiVVTpumUmi12oSQnuAlHrCAdPrOjTRL3m+B0DseYbJcIXNe8dWSUpPiOzKbGjX74rz2kvBqITC82Yq4SbKe0bWN2NbHw80kwJgAp0GTBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzeEyJq3m7iAvzRAORC+trfETGy5lzrqQNhSDdnF884=;
 b=KFSWKqSae5srlcE7baFWisTJmwBwaPB380VAnSg36D74crjlSSBrLSIJfX7g1AOsDCYMmLRgzaOD4qis7kJtsPRnzuOXcs0xFPMohAdXrbooTzgXWkLK7Xjuel0kF1y3l+Iw0x/Z5piDNDM7M+2Lju0dQtSzLpzvytEobfBKdW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6373.namprd17.prod.outlook.com (2603:10b6:8:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:06:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:06:23 +0000
Date: Tue, 2 Jan 2024 14:06:13 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com, Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>, Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZZRepTEFNFC17fjT@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYqEjsaqseI68EyJ@memverge.com>
 <87le98e4w1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le98e4w1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: b500ee09-a7a8-42a9-28dd-08dc0bc5e944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XrJYzMq24ovzyHu6sLwH6NOGMIb4Zxsj5yhLuYc9h1KMmrN63TtUI+wjPWXC5s9TxYQy1H1QKN2gi+G9aj8fDDQyA0DLiHdtWajfM72EOwKQ7C7lKi9J3RSAALygE0qprvQ0FZv9443Wk3M47zITcMCtojWEmfHo0ymIxm5O0ajb5r8UCOFagi3uoqkwC+FyI/X54xZKUCXrrOsyeDobLfTNAdZzunKtCHIPvaRaN8nlkHdFdjZtnJqeCY77a02u/m+L62sZDL8cCt+aVVAZJUU9p27aRZqaobOsdjUonDLyLsVTiMd5pAfvWN1Smqc9F32meWf4CIn4Fd5S9gH+sWaiXKhL+FKQXxKY5DrBE+WyXZy75BRNBzxdnMCcZTLv4hA3mU7rA2cu6lr+UpklNErTRpIW2+TDNDuCOnUiQGO2s1lz+IJrWKogFAK7R6est14yFvdOeOa7nY5GAEeZrxyzYF/wZs6kGIMBBeFKNwaVDXvKYZDRC99VizNN7i7gEqL/fZ4flavDx62Yaxze3y7HpOLhaUawl/Kd1rBDbdUyrza/aWKgiRHDWgk9OwC2/OOq0ddYmnLDGJSG5DdTykvsiYK8KDx4hLrrLCJD8dVLhXNqAPypx4y0zFfbUxFH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(36756003)(86362001)(6512007)(478600001)(6666004)(4326008)(44832011)(66946007)(66556008)(66476007)(6486002)(26005)(316002)(8676002)(2616005)(6916009)(54906003)(8936002)(6506007)(41300700001)(5660300002)(7406005)(7416002)(2906002)(4744005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yEkyGLYQqosncnR8cLJoKkCkOl/Vjd5T8TqR38eWfxL/22srXbwGxInJ33g?=
 =?us-ascii?Q?qiinAWqICPwmifrx6ha82NsNs6hXJEFo48319AZy+WObMSJvmAXy0OyHJi2R?=
 =?us-ascii?Q?Ij1Kv+qzVK8LgGQQ92d/JHz/naLM44HmdKmIO2bVpPhlGb2HHd2BHzZVRGC7?=
 =?us-ascii?Q?2st0aaD6roel1tgBsKV1FwFMS5Lz1TuSfczkGzGIAsZyAOml3cvm6856+H7f?=
 =?us-ascii?Q?EQv6FnexhPCXgo4C+48jTEziyefbaduYJJq85Z1vtyehtki+33L4cpcwTzIK?=
 =?us-ascii?Q?c7GgS6hNmUUhbEmb/Hgssd6EPA/mZgwvSfr0n1hPxBVNi8P+xPL5i4MKwklL?=
 =?us-ascii?Q?JWXvyPX1Xr4l5aEYasDX5nbPZRdXSgR8XziMm+daAijH/zhwuDBuFT+oyvkN?=
 =?us-ascii?Q?Qvek6DKyM+RIdaxwVhTUy270gN2kmNNWJPgL9FY4J6VHK+/cVibC0fjV4DaY?=
 =?us-ascii?Q?Ctp4FyDLW2rNzsesf7lppNwDeg77Vz8tJL4N7V7s/jFsmX+lXTjgTob1UkpM?=
 =?us-ascii?Q?FauHtWATRroKxq4nyK6tVlR1lM4RErQVDJyK50dAHYPmzhFoISr0x2WNXEYp?=
 =?us-ascii?Q?nAHVsjU66JShrXhPt2I3krSL87zj+/BSvePBvNshCW7qC7CmxCHwks8EkP1e?=
 =?us-ascii?Q?Y0ZohNmzaU/Vl/jwHZ9Cc6MCrBILWam4iE+NcT6Lt7Z1mejTzSUxBYyIeqsM?=
 =?us-ascii?Q?9iFm6/pBurPXZJUKgLOSVPwg/BeKJUbxgQi2fyL/S4UXmENOEYiu/j56IzXp?=
 =?us-ascii?Q?Ny6BVcu1qBJM0ih4CGk2vRoCWQCPuDGvSOuYg+vZ0KQnhZ+5+X/ud+/aRY+x?=
 =?us-ascii?Q?Xu32p8bgyoV4BM968iS4ImHPI0ZrlH7DeRZRTdUEUX0L4Q/Wl2Nsl/iFbRN/?=
 =?us-ascii?Q?X+9je+sQqrWVaJeRL1sa1Y4uK0JP6vwfRKgfP5RQikpyAlc16y9bydfDh+Qi?=
 =?us-ascii?Q?5I8deEs3Tb2HQKrMz+vpxUWurGzkw5516VyPa9eRAcov32FsbN+T/Cdr5nTK?=
 =?us-ascii?Q?IRqv6BzsswSo5nYH25RqB+2KkjIOEgvI2jxILy5G/yHlhDTLRlHHr4WXNgxo?=
 =?us-ascii?Q?6o3ZzC5m0sZbBU6TAg/e9+8LlVzbcM3XUN22+1kBQWSWl4HQzoqIDNz+MOhy?=
 =?us-ascii?Q?q/SfyPyXEeiF3v1HsjgEWJuvBUts81g5M9psvw9yFywhDOe+6K5YaWf+ZhVQ?=
 =?us-ascii?Q?mX2XRndKp3UcPmPh3thYqeWDjR9OBRXciMsLpe24Yau9/q+SWFNMkXEEvTea?=
 =?us-ascii?Q?QrTVpJ+r0/CbTyLieqiEg6isL2NdwacRgirpR9IzIqIHMcrwZVI6z7ek8dRA?=
 =?us-ascii?Q?1R4Ud6UV5MkF2n/VonfKSx8RrPKvKr63yJMtPXxdOnUnUPqhYTZIb53d67tu?=
 =?us-ascii?Q?poNq7y5/F6PUmGFTynJNHGxIzxeN7Gx7h539hxUL8V1Qdnoc65zkSwaGuUD/?=
 =?us-ascii?Q?osdUfvi+VEBLMQ0OwhV28IL6+oV6GzGRoNzyQgTdRhjRvgwXD9t92Pam64Gc?=
 =?us-ascii?Q?Fo+x03t1iClLOqzeMxaz1klAOFVGkSfP2tY0tz6svQquD2DBtpkZB0rARAfj?=
 =?us-ascii?Q?1K7POzUAumX9G556IS+m9wHJ2wSRx4A3IbZ4lDZx+t3sKzV9hy524nKfzyfR?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b500ee09-a7a8-42a9-28dd-08dc0bc5e944
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:06:23.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dm4HAPPVPcJsxV3WxgLwpGV9t91gXyZ34mX/t47ESF6gDKavAYbLowTa8GWwc8LqI5B0ykHAwZUaBs67RZsmSyMuvN0O9FG5m3Xh23+J8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6373

> >> > struct mpol_args {
> >> >         /* Basic mempolicy settings */
> >> >         __u16 mode;
> >> >         __u16 mode_flags;
> >> >         __s32 home_node;
> >> >         __u64 pol_maxnodes;
> >> 
> >> I understand that we want to avoid hole in struct.  But I still feel
> >> uncomfortable to use __u64 for a small.  But I don't have solution too.
> >> Anyone else has some idea?
> >>
> >
> > maxnode has been an `unsigned long` in every other interface for quite
> > some time.  Seems better to keep this consistent rather than it suddenly
> > become `unsigned long` over here and `unsigned short` over there.
> 
> I don't think that it matters.  The actual maximum node number will be
> less than maximum `unsigned short`.
> 

the structure will end up being

struct mpol_args {
	__u16 mode;
	__u16 mode_flags;
	__s32 home_node;
	__u16 pol_maxnodes;
	__u8  rsv[6];
	__aligned_u64 pol_nodes;
	__aligned_u64 il_weights;
}

If you're fine with that, i'll make the change.
~Gregory

