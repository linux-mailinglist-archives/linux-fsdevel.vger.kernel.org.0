Return-Path: <linux-fsdevel+bounces-45046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7FA70A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C66617CCBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE81F3FEE;
	Tue, 25 Mar 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrdq2tHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ljT5YVPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E71EA7C7;
	Tue, 25 Mar 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930697; cv=fail; b=sYQ/nlNzRUo9aNA0xC7OE0Ona0EyZpXmU6uxqTkNhSlh4CP5mHm3jm2aJpPMnp32qrdLfmrZpg6wWJHn9N60tgH4ibmG0z/Z3KhVfuE9z4hWJEcqyo0PS0wpP53SRN5qFMZCM3tlcAT2GYtApZvX/1H1ABKppjtRsNog6wJHMVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930697; c=relaxed/simple;
	bh=3xsz5Gx3BJS7S8m/eM6qmHntPMpSOqWFMWXvCv3iRO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kH7s2NUcQcS3sT8xe04cmJEf9tlw3WyXYH0tFZ+3MvrFNEl3IBhpYG1D38uDRlZbLwYeQnSM7lV/WnujxzO2+FDHr9q7IRdpsSwgMrgE6TUFl+9S6Z4b4yY0q2e09+RG4cRwNb0/32167jFBlwCE9tanRd/CUa94YVV1epZ+qig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrdq2tHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ljT5YVPm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJMwnJ020296;
	Tue, 25 Mar 2025 19:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kb2FKXJWcj0rPaG9CV
	DjKRJvpUNE9pPyvVcWO8xHaN0=; b=jrdq2tHQADdQo0QLDXTeOLdEcJ3fY5QKJb
	/DQyyAlhmI+S6Lm42lK48gYwG/RGt9pdHdY7l/2aUCbpgOhvlMw+OgFfvmqmMYuz
	HbhTzTM1NVNG+L/RoAVOoTz3usEEEao+BmnKPqu/42stNpoeYlK9HIITfxe25aK3
	o+EJHBJeHLU9JAVKbMiStrfD9JPq84JmWBcgbN4tYld/9hkaGt4Xjbo5kk2NWI56
	YdunAxZnru8mUXgBQ5wK3nF/dwcit/olhaGvwN49FxrowQkchlJsSF3N5hiInsJK
	W1p5gZBSdyk2pI5dY2pAm0KePQT5PgUC5TY1VrP6/lHDH2+SFnQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8b8553-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:23:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PIJ7D8008240;
	Tue, 25 Mar 2025 19:23:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6uk3ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN9K+lBv0X2i57LxALytpgy3R5PGRkbgusi+E14cVsI+KpaOYxLis0QFwzqz6i2dkDYZfHc8lNsddQQcG+jPA1ZILpNNfjPv0nou+cMfhoeigXZoWjNldFiqKHg37hnNOWDAm0C6BhS1BivHvwvho9YuIFN+fk1OQ274UrZ93Kn/FChXeCQYDRTuKOFTZyqgWsEGXmHOM2EXLLpqmG4a7yYQdUcc0ThIDlozBAlPdrIrCCj2PuC0pYxyqb5eVNBD1GcuE1LvJaELM8D/Fr5Iqnd2hlggpbWXZ8OltmKZC4Ya4n810w850CaQanngmHCh6gv/ao/dktsHF6sCO4Rtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb2FKXJWcj0rPaG9CVDjKRJvpUNE9pPyvVcWO8xHaN0=;
 b=gFJkabS7szCqDUJPCnJ8XfJmsDUZPz2NFgUaN+fRiq4rcNjxUy6th0vaDJB7B0vxHmudGX7jLNOC4rfWvOhFy0z+5t1/whjBJDVxWJ+A55pNJVF9HrrCJgEAZbRNJO8+riBAUZ/nlqbFvqfP+9AbaYfZUaWymzZsZqHYKoHtVperGcrT8dgiysCqa34z8aWcvjRzT5thTaOIcrWuZt1YNJ/yjDWm67Hx2BP7hkUsmWEzh0f4hnZ7WDcpulO+5E+ZK0IMn5fIyFM37GJL5rVnzPHEDRpj4TQgC8aeZ3fDfOCBokulWH8XmQbbF3JewkzfZBaB1dI45ALCK1OR705dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb2FKXJWcj0rPaG9CVDjKRJvpUNE9pPyvVcWO8xHaN0=;
 b=ljT5YVPmfy/gNaOttPiq3n/NHEYdTG2w2jWXfMls7WA8CXCt5ZId1giKIIQYcjf1xSdMeWGWEOoIGYD3dERXbZyOsrHw5c9WmDJO/i/ov/WctIS3PYYRsAa54Ve2z3FrjE8+tCxfJJOa3Iv/nFGDlXXmVaCj64rKPUtSgVT2Ycs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB5744.namprd10.prod.outlook.com (2603:10b6:a03:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:23:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:23:47 +0000
Date: Tue, 25 Mar 2025 15:23:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, guoren@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org,
        atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org,
        tglx@linutronix.de, will@kernel.org, mark.rutland@arm.com,
        brauner@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org,
        edumazet@google.com, unicorn_wang@outlook.com, inochiama@outlook.com,
        gaohan@iscas.ac.cn, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        wuwei2016@iscas.ac.cn, drew@pdp7.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com,
        wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        josef@toxicpanda.com, dsterba@suse.com, mingo@redhat.com,
        boqun.feng@gmail.com, xiao.w.wang@intel.com,
        qingfang.deng@siflower.com.cn, leobras@redhat.com, jszhang@kernel.org,
        conor.dooley@microchip.com, samuel.holland@sifive.com,
        yongxuan.wang@sifive.com, luxu.kernel@bytedance.com,
        ruanjinjie@huawei.com, cuiyunhui@bytedance.com,
        wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, ardb@kernel.org,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
Message-ID: <svu4xdeo7a7ve3vorvgbkjxzrqmqk5oztgtfpbg556wjw4x7vc@yg4esoipmt7g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, guoren@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, jiawei@iscas.ac.cn, 
	wuwei2016@iscas.ac.cn, drew@pdp7.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	ctsai390@andestech.com, wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, 
	josef@toxicpanda.com, dsterba@suse.com, mingo@redhat.com, boqun.feng@gmail.com, 
	xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, leobras@redhat.com, 
	jszhang@kernel.org, conor.dooley@microchip.com, samuel.holland@sifive.com, 
	yongxuan.wang@sifive.com, luxu.kernel@bytedance.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, ardb@kernel.org, 
	ast@kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-media@vger.kernel.org
References: <20250325121624.523258-1-guoren@kernel.org>
 <20250325122640.GK36322@noisy.programming.kicks-ass.net>
 <0e1d8823-620f-420c-86a5-35495ccbd10f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1d8823-620f-420c-86a5-35495ccbd10f@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: d8670433-3a6b-4eaf-b92d-08dd6bd290fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09EQf/jAtvZmfBkE9Hju9xGtT0+8CQaYXfxsPVm4saOg48RrcfwfQFy5HOPw?=
 =?us-ascii?Q?N6CM8O/u2GB3hRVz78Lt7TV0dU8PznNimSpdvwlnfxGd3glTxV50XL1WR7oV?=
 =?us-ascii?Q?thiyOVMqplVVvyf5QrMvbzSHU816bmrrtRx9tb1tjlKzYb1+oFtdRngPJIMQ?=
 =?us-ascii?Q?+qMr1VSaKw7xX9sKfKiEq9/sqj1GRFvHpAvWFK/7jZLzycn40IzCVjQQkasR?=
 =?us-ascii?Q?RVfD1mB6NmnOy4SCoi+zBBfwJDYlFoNicM5qN8c2LHN1Qb67c75pppnSLC2r?=
 =?us-ascii?Q?KjJv5vhcvhcCm82b748XdFcqb2ZrHtgX9iBAecI/7hu+bSKiOpPCJcfith3K?=
 =?us-ascii?Q?eisQbbY7d/U6dnz5Nru4cPpjdx1UPPypX7dTEcGQqt9ZQmTVs8bJjYe6K1VJ?=
 =?us-ascii?Q?zA/CavcyQLzj/yd22K/A79KV1lAYEGLqB+rRF2DS4kY8tON+KHmKDWRHFIU0?=
 =?us-ascii?Q?Y56rQHHa+8v6jnJXfieKmBKzThf/9EAQH+kM8jpFPyugcR+k6/0WByeH5O90?=
 =?us-ascii?Q?IWlhR9Pwvr1x3BID/s1aRMCV7lzYf70Cv9nrLXlD5vDvVWsHI9VovYDWKvZG?=
 =?us-ascii?Q?XE6Gdl1TvNj5ycvlN4y923sFLg3jj6Sicj86nTbl+9vPKaNkiE5Mk2ViYfkc?=
 =?us-ascii?Q?iG6gDJcsFS4XID4nrmBvQpN+WvQ2g5FZaRXNErRbVNhLJrGDkzpN1RYwxUjz?=
 =?us-ascii?Q?1/A8AzMmZvS3kS+vPSB2iNdjcqhteahZ/9ZfG2OXgoeiuqnVlOKvHWxV2CrX?=
 =?us-ascii?Q?CWBaWaFp8xC+Qj7YMp7hy0G4S0ybncVQ0julds6ACpYt2Rs/4Q8jUXbzw0Iz?=
 =?us-ascii?Q?bQqrn9CJo/CbOir6bz7e9cMRbgz9adwTYlW7DojA0eDbCQ2G1paL+yfyFVqN?=
 =?us-ascii?Q?foQ35VQaD3LRi81Tc8BQOWvSDmdFLXeWccmodfd9qa9rqfiEGRNPeK/So0c6?=
 =?us-ascii?Q?Kufs6iFoBb+Ph19agK2LP9xTkTziXFvib07by9YUsj6p0GQitlurDAUWbB8g?=
 =?us-ascii?Q?wJuYf5wSVyeMPzk60Bj0iQMun1K1/MRXyYK1C7hN15/XAtEahNEW02qozxjg?=
 =?us-ascii?Q?naj9OD/XS/Cre5wl60dzDlMs1Wi0kpotr8BiErM+gO1LECKows7RTVmJQMl4?=
 =?us-ascii?Q?+HcUvO4FAbzsNha+qKHhx2WcRiKvmAMtUaqk3yRSVgqSn8Y8YwsZk1CRW46c?=
 =?us-ascii?Q?Euz61IAcccGgAk2N3bamdQU6N813EUzSXp8eoW0Pii2gnED/ryWDNBc9+/nl?=
 =?us-ascii?Q?3uwWNe+hl4lmIpfI3jQ+rB1zBmE1lWulBlJ9s2YaqJYX//bzPexUhmrq6zPy?=
 =?us-ascii?Q?ziA7ZM44I99OmZkikSftCPj4+Oaop0A50iPYx5cO8aZEudn5CCbpGKR6L057?=
 =?us-ascii?Q?dH/nfpsyji4jgcRBny5CSnlXpeR3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?111Kg08n+4/ITDNNLU86UN8ZNCNtbQIJI0FOZWJImbee2qFQpCUsY0DVzrdF?=
 =?us-ascii?Q?3ep4AezwdTIjuAEMd4KjPEC6z8A7UNBMgLX2uOvd86BbftPleC46fwBWhCDC?=
 =?us-ascii?Q?MLNqB/rsOUwjnAJxYNJHdJE5I3YutunBYeFnGB+s4Ywl7SxTXbrhqN0rYscN?=
 =?us-ascii?Q?vQF+tbJ853A/COGsbh+DNe2UK/wDS8onehUqJWN+gtsHYtsPSFhJG0at92rf?=
 =?us-ascii?Q?Z1za/wv41mTiH2Dhzhw+FQXd7K3dHfwfSLhnQf9ImHFH/PEUVmCMUJXtF+PT?=
 =?us-ascii?Q?PKGQ9f1pN2SmQiz4SBu0cYN5emNcyeXGpeIe3cqaBAYK2GvH94KjJKVZbu7c?=
 =?us-ascii?Q?xVUoQqDi7HjeAaWn0z+0RwtNcLCnqGfYou7GZsjTT0+3wLI5BLWiE+ezfNdC?=
 =?us-ascii?Q?MWLQpc1MQAQTgqeKKq+FUbH3ZwBwgNKMnpfIJ7ivvtP+Lbt9F2GWRawa/nKe?=
 =?us-ascii?Q?/gWnbDWfFUFWmIZPClcdhJcUQd88SrI4VZQHpFCiFMGFhksJRGdIqR+1luEV?=
 =?us-ascii?Q?G+vx6L3rA1Adib+beauhJJWx5I1eirOLMnH9zhvOAlhSIpcGx1bMdiX25LHt?=
 =?us-ascii?Q?k+8YYimYeBWKwRRbatYoNBm7i/uSjc5lkSp1BjupgVYVytcndujsCGUCAd23?=
 =?us-ascii?Q?uNXblQl354nhJuWzE2+1vZIGf1XdD92zoz5bye7kgdgGaO9pegb1ulOiI6qH?=
 =?us-ascii?Q?eUzbbEvgqPUKK0Ra5oEVGId9Qsak2a5gFerHhkfS4ZVwsSxpZdzos9OZAOLq?=
 =?us-ascii?Q?CjmAaJ6awPPnnPFvP86dLUcHdKoLvomXWtS7pGTEvgcd/vyNcOtd5Jh7ofaR?=
 =?us-ascii?Q?kdF9wY4YH+4C4E7xn9n0H+ClJ1bc+KEa/P7fDtH6Xf4nzC8QfF9IhUIriZQa?=
 =?us-ascii?Q?0QYP4frZTSyHOmGQ+oFUZrs/AAxGYN8yXS6fmqTKCsZrJijcoqM3AhgpJu1a?=
 =?us-ascii?Q?8XFbikqRfP8nifLEYMJwdocaF1JURBDks0SJDRycR6dIRMDoQ3XwczL0hiVx?=
 =?us-ascii?Q?4lPUrRxmnjmaxmoCl/MvVWvuFTmrQbacN2bX/qSNctrLkjE5zXUV4buqFf0Z?=
 =?us-ascii?Q?ItavshaUd9cJSzKDxFwTTPKnzpcDCyc5TE7ffOeKAWER/7ETRffOQ7Srfgk5?=
 =?us-ascii?Q?49CwyxXxMYyKYoiJjP64exXfu3eHZAHFWxuYHJOjk8+N3RetqLbPJgeU2h4Y?=
 =?us-ascii?Q?9b03IP+nOhctRAlLxIZTxAp2TNqJOqy4KimlY64l9QGQJwDnZH1HETYu7Td4?=
 =?us-ascii?Q?JxNAv5a55Tf5F3T41tbM0buUYgnuq3f5VvJSqLkJRjj5Qks6U5+SjjxGCeeW?=
 =?us-ascii?Q?mxYpLGQOtmX0drn5HJr5qFnceGsV1nFW8+SeHoubn+N+NnizlttLnMAE6DS2?=
 =?us-ascii?Q?xLi6locEjX/x7VQicKDS+Oileq5CpZAbGCQpyfvQNf1oRRVRawYi2STx4kCh?=
 =?us-ascii?Q?1WGXBMkxXdW6i63mTYqu+VlflJT7IzY706M7Qr2hITj1G2bOMQIbX9JtWqSn?=
 =?us-ascii?Q?pcJNBFW8Js7eoxdPQQNQD7LKDH80/4cmGYqpc75ciavY5jiO3b0DY4l2EYOI?=
 =?us-ascii?Q?tyukeVWvJXyzh/PD+7I/q+ZcvpYR2SFEE6dKkZpn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SUJDSJgpB+C8Ijx7kipRCFJlZ9g+mqlov1BQEKLYwUT8mebubjFNqW7F/4u637Nh5xNVSUkQ8vzNhRr0JdyHy3y0sNXbf5aU8LfwR7u0AK7lZMhJ3ZDUHvP/tgMFm+rFsvLesFloca7SY7zspOhuhxdy9glgO/bRGM6LyaewZZMpih5eYqZTRKC9ogyKvGM93MOnvvcvsr/qBrllrVZKO0ZJMK/m5dzDZ/8jYaHgfoXH7m8/tGfjdfpeclIbYoAkHlbmpVufO++w6pD1YSTOcUARAzQlnZIjetv40VQ/TnjpwyJ/jnLDQJyVb5IeGo2zlZYzhI2MkoasekX8GtgP/tKcynBlExfWRaL1xBQFknSRV+4EoW/yxnTC+5fxwJ5yMCGUbsMJzJh58Vm/jYvKwchsEmLTpzdd0XiGfGtmbzcDXukveY4oKb0QDZMgE2sy2ABDYwLMq+v5jQ+t5wipTm/hagLAOn+liRRS2QdxT7IF/rYfDFyVC6OCOe3a0QGRjPHRtSrRWUaH7NuF6lNgglJfyvPHmRLfOyH2V83kRROuc5oAPoIZ3pKoq/XkTAkEyp8fAvqjntq1vkYkRJdS2crMwn/4kxEb5Jrt1G0/yCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8670433-3a6b-4eaf-b92d-08dd6bd290fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:23:47.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+D4B1Ku05Fl325cql5y1h3R4Tp1gYkkfQx41g+6JduVZIzUTRpcQslfqwjBt2BIhzLUVYpJSQ29vy1zPjAQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250131
X-Proofpoint-GUID: NBcLF-M2ys9gfQOGFZ7I8lCw8SmvW81K
X-Proofpoint-ORIG-GUID: NBcLF-M2ys9gfQOGFZ7I8lCw8SmvW81K

* David Hildenbrand <david@redhat.com> [250325 14:52]:
> On 25.03.25 13:26, Peter Zijlstra wrote:
> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
> > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> > > 
> > > Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
> > > but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
> > 
> > I'm thinking you're going to be finding a metric ton of assumptions
> > about 'unsigned long' being 64bit when 64BIT=y throughout the kernel.
> > 
> > I know of a couple of places where 64BIT will result in different math
> > such that a 32bit 'unsigned long' will trivially overflow.
> > 
> > Please, don't do this. This adds a significant maintenance burden on all
> > of us.
> > 
> 
> Fully agreed.

I would go further and say I do not want this to go in.

The open ended maintenance burden is not worth extending hardware life
of a board with 16mb of ram (If I understand your 2023 LPC slides
correctly).

Thank you,
Liam

