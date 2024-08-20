Return-Path: <linux-fsdevel+bounces-26347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6F957F0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CC01C23834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62C188CC4;
	Tue, 20 Aug 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPAQPgR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662916BE0F;
	Tue, 20 Aug 2024 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137680; cv=fail; b=A5NRQBovDkNtb93K+WCvMB3g28eW76AThTvw32QONsO1q569IC51f7vaYO6jy4pFdUK0Yoe6SNlnBxbUEqI9jiPRS0l6BZZzefK7yvTq3whL8uOog7Xj94v/uExfdLsxtIMPgg67XN1iuPIvNF8DBv8G16GQ+J4dviisOWs9av4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137680; c=relaxed/simple;
	bh=ZTBiahL32hNqmkzWRKy6VzL71XDPYLtt5U1yHXthLNE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g3seqIMk77G0Cq+5V5Gfg7oKGuOecnCiE40Nz54C4LG1ottiN5vKd7xuJzyTqdhz2jp7nBPbZ0+tDjE96adAHefaXQH9Rpw5BeBUFF71guqSpHy92Y60nJnEN5ke97gadaksn7riDN+nGCiTDXZA4hFyjTU+X+y0XLUpjoVTez8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPAQPgR5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137676; x=1755673676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZTBiahL32hNqmkzWRKy6VzL71XDPYLtt5U1yHXthLNE=;
  b=lPAQPgR50BxXvNGRkvsjS7bw3iePY6Wzqq46zpsJDvGREegZZOzWLscq
   IVDAkX6kckJZUWCaYpGchrUDKLVC5uWXM8xqJD8DPM4/W8DRNgFVM3YjQ
   KT26gwSGx95AXNCOD28Ic4NbbU2wHf94lOLjwShNTdD2JSw3t1gDDaQfM
   JBi+ax9sI3MuURyZUYhv3ACy0AC77Umlpx0eSyPOsXfCvFedpkbVlNPRw
   jtGByopV3y49YWlTUJ/QGm5yrqSBk8KCqLplvlC2CGmdXB6lbLg5bRbr6
   B399GMQsBfY2MsAly8tU6VWWukfvR5C8McniFdgAJ/MQcNnC6gucEzH+W
   w==;
X-CSE-ConnectionGUID: 2Z723YOESW+tt0Vf4VdPQw==
X-CSE-MsgGUID: YTtUey4vSie4EMuUN+Wo8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22582702"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22582702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:07:55 -0700
X-CSE-ConnectionGUID: lmlm4r+WQ2y7f3TdgYhDMA==
X-CSE-MsgGUID: 9+G4E3NnSKGrnHJ/490bIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60330834"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:07:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:07:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:07:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:07:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er9SwFFS7SMoEYukHBT03n1SM/HBQ4MkP48syntx85EAmBD2R6FTs9mT8AKo10vDmvIUklxbNeMnFEnpep2O9ym14tFtS2DWgmyvvbTQ8l9mAhfIwOq8B4LPt/pUO84EoF0vsxcLQbVMbIL+3S/G7sI81KFgjj1Fq5kt94zcS2ZaCN72OV+QP2tSYYUt7jcf0r7J5u5rq9OiOJ/1e0tINokotoT46/k7wDkqIDjYMtQLtI/rL6N0HLqSRo5Zi9Zc4w7WMo+zWBGZ09wH9xl5g/IcMD/9qkntsGtUbFsEGcyrDUXtKB5AS61BpGZxxUT3SYNOYgvANw3ckR3puBLMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fREMayC3CWYewnj+uZxMkcim9bBx/zwwMXX1rGPGqdY=;
 b=UThD+uj0BTEXB7X+szi83Vv/tVRdP96maIh5rOu6wjjNJxisVClhNCfOYSN9C0Bgw2nMVQX6joxBWU2UrLucSjLdqfdTYCivPwonF0/nIHKFVtr94fwdNWufj0sDqHYl0UvDA9y+zPUPSi67Zv5g7lRrSXudZW7y5NU9r4AYtH6QSfra6m8sDAmGW3nPhXMMYwynJ4PNaL9vNdtnGajn9CbpO7DYajCT3104Jkyw05oZkxzHD86bW6Dw89TJjUx3jVwDPZzhTMzEY4sIaS826DJBICfoEz3mgT6+gOKUuA685VN5QFTO2FkA5ljqtgeftnii2XPw7S5q0lu/yfGbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 07:07:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:07:50 +0000
Date: Tue, 20 Aug 2024 15:07:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dominique Martinet <asmadeus@codewreck.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>, Marc Dionne
	<marc.dionne@auristor.com>, Ilya Dryomov <idryomov@gmail.com>, Steve French
	<sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, <v9fs@lists.linux.dev>,
	<linux-afs@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <oliver.sang@intel.com>
Subject: [linus:master] [9p]  e3786b29c5: xfstests.generic.465.fail
Message-ID: <202408201441.9e7177d2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b380c5f-f1c2-48f9-77c6-08dcc0e6cd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2/ZhI/5Yep08hMglVzbVu9y1BgSwpWUTitAMqM0+HRZ704GfojI+Y4ULyKUT?=
 =?us-ascii?Q?DEE1kfEf+RIVLHppI6W7qFPj9LVaA8KLKCgxHYOUm65mxW2CfEDxk6Gks5AO?=
 =?us-ascii?Q?SvFGK5AV4geLB/7JRnXPtLuj0NPL9m6ujN7uYhOfKXfmc6zobxmO6f41NTpO?=
 =?us-ascii?Q?IfOHR0f1lLq2Yhxv/IG51edtatPF7zyXcyeP/qCO+xTAggseJxiaADx00JkE?=
 =?us-ascii?Q?11/TBQ1fkGijrJc14ItRccrumPTvXmxFAzp2iuU3fbYB6DBXugNIV7v/9uSt?=
 =?us-ascii?Q?XUQyaTudHGv25j2K80fHz8u3GGsflSyOXISuSVZt/4r9y6tZfJ1eYy+RVlWC?=
 =?us-ascii?Q?N4EMxonLZMrkdA8DdoLsIQXv/IKKKB/t3BZjpfEQXqAW0ngett+KnDS/OWS5?=
 =?us-ascii?Q?RnTqRgwAyY1EPZFg2PfKzxZthDSgn4sFny+QXSEShXikqq+Jb5Zoo+pbl5oA?=
 =?us-ascii?Q?Tpx1bh9Vcf2nOrliAzZ5U2YetVQdSluHUuAgclfADxNNbhM/Nt5y2lQqEQWc?=
 =?us-ascii?Q?fBrhAHz988H1XrocdlbOxrCk/5aI/2B7L1LJxU7wYTeK9Z+vT5ieHeNiZ6Zr?=
 =?us-ascii?Q?2hM+XbGosGwuM6T7NmhJv7WlmqaMR1SkXwSCjbnP03pYB6lBKwxgjWpT34+r?=
 =?us-ascii?Q?KYoo1qzwDBUMvEieVzL54+3aYJkWIII8RHvigFMCBMfFFu2dujM2mkRY3YoY?=
 =?us-ascii?Q?cwZiMLkyZEvdxF6N1blIEFkKmKiKrASWGlkbumXrzyCQX0Io/r+i4IH5F1F2?=
 =?us-ascii?Q?ufyk1VxyrnhJv3oQ6iJtKSBC5GG4Ivik1Rjo0LjpvXdj3pEmR7b8pzxBw9Fk?=
 =?us-ascii?Q?GuTXW9P6gf7TzHJBApPL5Wbx3VE0mboroHUbbPu50bfrTI9PPYpYHa3fMEPw?=
 =?us-ascii?Q?LG3xMA84nmLNUh9qOBO456rg6e7eKKnryFGYTxBiYIeTfjEy/kc3GOdvSE2D?=
 =?us-ascii?Q?lsxxb1436rylQI8dhY/OWbFE8/JYm3TTlXjf/TQa4reRWO4AXinVc7zF5ycn?=
 =?us-ascii?Q?ib5WyNIQu74f/M9Ys55Z3TdmGAfPPIN7KxRmbGGxHGtZ9BbIb6h65R+6IeZ4?=
 =?us-ascii?Q?iEncfdZgZ089+hI/CER5V46XR1yV2ot0fQKDHBH0BPP4/ge+DEooD1Wc+xGs?=
 =?us-ascii?Q?9m2i533Hgi5N6Wq1ARuHqE3pBIibogJ1niU8esRUCfCxwpaxNxiKAcRE9004?=
 =?us-ascii?Q?QUzFSLY2nCdFACqSZruY1MyNCvf4MAomq4uSwBJ12jZG6Tjzr2sE2wOQcTJp?=
 =?us-ascii?Q?vCzguCad2K97kVEU75Yq00ADMYMNZjDoGDWirQueds9Pi5JFHVHQESwwj5tF?=
 =?us-ascii?Q?kLgu2WvkAlSDC040/efiOi5h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEOLT6m8s8vQ7hS022swBKEmqm3SezAVLCDgI7Ws9ycD206JhYOlr+vGSIfm?=
 =?us-ascii?Q?gq2hFxKvCtutzmFONajL02JVdiv/f8njOSC8oN7fF9InzwAp/QIckaZqmpjH?=
 =?us-ascii?Q?t3wx18jEm6Udab9cn3XYZEmldQgBkqp/qFBsvEfYWA5MjUWoru3yhcOKzvgK?=
 =?us-ascii?Q?K41i4s2ysRV5OuGFJ26SVSt2sH9kqqHxYS42/Kwn3vB4T0WymJ37lknheMR7?=
 =?us-ascii?Q?fN4ECGMh4griiXFqka9hJH1zbuoJ57OFq1mGQigWLmaZ4zRhCZAuI+GNgjEE?=
 =?us-ascii?Q?O1RK6Kx/flWnfRxT0R5yHOROcJc7m4+GhWtXob4Iv148XUHP34B0R3uas9ey?=
 =?us-ascii?Q?zdP7+hefepeEagYD/9VAT0LJKX0sCzVky5VCt2+G4eqH+eQ8ctE+VJ96tCe4?=
 =?us-ascii?Q?jl/2sG8zJZgIdi0dAJNumvQEwT1enqifaiVn9Ilt+kMGZdNxXymK7TqEj9OY?=
 =?us-ascii?Q?cXGOYacDLaaBF5y0BejNo0KfwUA9v+lHDloOwPuAWNU/bQXSAsJgFRK1CHee?=
 =?us-ascii?Q?FRg2R5sSbBwyA0C+HVO0KOzL6n2FzoAwgMfLtpgfC9PTfupzygTNs2cPmUXE?=
 =?us-ascii?Q?vK73uUyBd+fEwLbC3kJDo2hCUEIsaaStVdVC/k9i8vZr4YHc0Kcq8IxQ9Lq4?=
 =?us-ascii?Q?YggmweCLnuii5lYaCbGYdKYZareM8aFuV01vfG23pdhKj19EfXU+TE7IEGWw?=
 =?us-ascii?Q?lVwIPPGdMM5rQopt9TZkQBfBZTa1K2b43+4VHnCoEyVhqCi2lVKZcQi6RYkH?=
 =?us-ascii?Q?KIEkLTRv9pfE4sZjrmsqS2P+ef1XjLC8uzA9o3vL7a5cHYsKvnXxs6QZwIak?=
 =?us-ascii?Q?fbwE3jBay6oT6rtv1Vr/6aVMAkMvXSGsHeQG++dkfe+067BAECK86CIyo/D/?=
 =?us-ascii?Q?PIAFk3fgZJPE27Xu/EX+tcu5SWccXocXEsDKZhVDQbBWBbXgD57WhzNXDiGc?=
 =?us-ascii?Q?6YrAVxfMNJMzg1nd52S2xcAb/a/4OpIBsPmieT+TX4kyjALkpqdNZRjnGzHI?=
 =?us-ascii?Q?HXVyFQmkI5/5IEpddRlgWDmLRd8IbwdgIK7YGQ/M1njO9bxX2GAoc5MsK/Gz?=
 =?us-ascii?Q?d3TT2zzN+7V97IBx8M8JQA8fBBN4ykAp9h0ZC7xEii9h3jXQ86OLlt8rZPfZ?=
 =?us-ascii?Q?UVPckJ3xJOWHBL2u1Z1BsmwmI84/oIc66DXW9ltNBYIVf1zMOsCvqVtQAMc9?=
 =?us-ascii?Q?BBMXVagy1xZ21YJ1MOfpij8etMGS5ityZmwwoxuSAmg9oIycWyqjnfTISTur?=
 =?us-ascii?Q?ITQBRgBTS5PYqdW2XWUCwpvjHQ7WHFKeUvU5g/Hw51jc40TReh7NkbjgTrOA?=
 =?us-ascii?Q?oprezJpx6h6DqKGNHEUhngqyKTBH5PbibSfbGZ6gDifMmmy48gfXW0kiag5N?=
 =?us-ascii?Q?Fs0naCiAZOfqX3jWzNv6PyipnUCOU3zxp9iL+BeSaj4ECz6dI6i5SwqZqIKV?=
 =?us-ascii?Q?uDy9kQ+OtMJ86ZNURqzfIhqnAOEdMKVEa2CnazzipP8JFKLrIdwywlPWNa5T?=
 =?us-ascii?Q?vfG76UTlG7UibEyNFudwyrYFlg0cCC5TJrhgAvaUDNDfc6kTLkfb54siNaKR?=
 =?us-ascii?Q?7yrR3Jvreb8YhWCQ9DP2gBnU/pHX/LNFYFSPcZ/EvcL7H7HdggFa4Do12TVJ?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b380c5f-f1c2-48f9-77c6-08dcc0e6cd5b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 07:07:50.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wLFrG7gMZmpYi4mcIjGupFW4KUKDzv7pdqROP29TqOqCbZqiwwJvBuv0+RY3w/ySf2E+iAlpZU/KIefLHHvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.465.fail" on:

commit: e3786b29c54cdae3490b07180a54e2461f42144c ("9p: Fix DIO read through netfs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: xfstests
version: xfstests-x86_64-f5ada754-1_20240812
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-465



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408201441.9e7177d2-oliver.sang@intel.com

2024-08-17 02:14:44 mount /dev/sda1 /fs/sda1
2024-08-17 02:14:44 mkdir -p /smbv3//cifs/sda1
2024-08-17 02:14:44 export FSTYP=cifs
2024-08-17 02:14:44 export TEST_DEV=//localhost/fs/sda1
2024-08-17 02:14:44 export TEST_DIR=/smbv3//cifs/sda1
2024-08-17 02:14:44 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
2024-08-17 02:14:44 echo generic/465
2024-08-17 02:14:44 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/465
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.11.0-rc1-00012-ge3786b29c54c #1 SMP PREEMPT_DYNAMIC Fri Aug 16 01:36:30 CST 2024

generic/465       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/465.out.bad)
    --- tests/generic/465.out	2024-08-12 20:11:27.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/465.out.bad	2024-08-17 02:15:42.471144932 +0000
    @@ -1,3 +1,597 @@
     QA output created by 465
     non-aio dio test
    +read file: No data available
    +read file: Invalid argument
    +read file: No data available
    +read file: Invalid argument
    +read file: No data available
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/465.out /lkp/benchmarks/xfstests/results//generic/465.out.bad'  to see the entire diff)
Ran: generic/465
Failures: generic/465
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240820/202408201441.9e7177d2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


