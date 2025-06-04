Return-Path: <linux-fsdevel+bounces-50621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA5ACE0B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F823A7E80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B4291142;
	Wed,  4 Jun 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdGlhCZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2C244676;
	Wed,  4 Jun 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048476; cv=fail; b=IXmAsuPL3gy1XWCr4iAktbexVrW8vDzODPmrlkwwUAbdQiInaNElqeeefWy7fMpG2ue/iYUYgIQNRVegEDJevzFqFITWk1o/03TdrKXOI5WchuNEGreTkvrAYik0WJ0Tvyh9ojFEh7Ii/7IRVQXH1FGQL3k1eqqSJMzfX15UUEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048476; c=relaxed/simple;
	bh=xJtRDhwmiGLFt67gHtY0dSS2UAHKuUHsOeR3JOuQso8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=e/+Ipndt6o4oDUlbWNd9HoW+QJ0xn68iVkVBH04LA3Pd5pS0TByNU02OtYROIPnj3IfsUJDQR+4y0APYATnSZL8WaSIu2K8GfDwnLGk/grzSZVP5ggpcOhOzn02t2hNczRttQaz1DtDodnbEsxImCiqYZhZQS18cyOkOCmzGrNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdGlhCZ2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749048475; x=1780584475;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xJtRDhwmiGLFt67gHtY0dSS2UAHKuUHsOeR3JOuQso8=;
  b=UdGlhCZ2I608zzWU0Sf0NRlgW8cPo9M8TgfeLDPih25X5HQB78mC6Fjq
   EYRkoiHxEizdVrsZzc7adwnkG3dv31Vv/Pg8XwbT6DwO0JOath0zn5+f7
   /SD1bvygDSd71aD93zac9LVSn6rPerPXpUnBH6dKulHWMn5L7mLwbnrES
   D5Q2da/OawXzC3JO6ceJoX4izTR1sVnW9RlpGiLRHBOt1jmp9mAnOe8JF
   NCNRXxAw9Rwe1mL0ZRB/VVLsznMsmLTBmkMuIPFAYp2oMxDA5UZpeYavW
   tU2/EExZ7oo2f9FR3lv+vvMZFEgFiPgeShvJlIsQShxanoygHxgcTL3Z/
   w==;
X-CSE-ConnectionGUID: Ual60CrOT56sEimbDUDVDA==
X-CSE-MsgGUID: N10TNNcVS2ueu90uc6XwMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50250575"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="50250575"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:47:54 -0700
X-CSE-ConnectionGUID: 5nrctUJfT8CKW6A52LUCXQ==
X-CSE-MsgGUID: XQn5rQTaSRucAXlWhP1sZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="176093765"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:47:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:47:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:47:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po0rB37TCwgWBlveLhOxBrcFqts700xXFWmxoFXny/IAF7cvJgbf3n1yGbBdXDn9Cvxy9useCuWr1KDuKl/a2Zv4TOa3CX3X7nKTMu0DvO2bUeWbBu0F3iE5DT4vT/RUGC4LurirnN4sP6MGh67rSMwyaFOBUjtp/onCWdIQir1amz7jRj/zk6JvScbb3pEnOf11TK3vu4KpMsj29ulhiMLh7XCLE4ahhtcyw+P5mPS1jyBLbhFGwwHFbjW55L/CVqb/tqWCfmDaeBMb66d6D+8zJsxONIw3OA+9Q1n53Q8UJRMyprlE5z+V5MqYzURxpaDpFIEaF1jIIcbm1ehXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qPWP4+M7pziXlqKmEY7zQrgMd7zAW4liAvjipUIOxA=;
 b=qA0l2r7lKRPyfku6gBnHiS6skiz2o1sthz25oPgnOmfhiHtkG5dqSXSqjw9iAHaJ1sKXjIoM4KnwYLqvt1v0dXpLMwSJ2OtQvA+nYRCWg9E8A94v+7yDZvioX4dbZkYPPam/bDSrOwcaA0mVqZGiU2oYT4JgNmJlrWAn9NU4wZp6lx8OiFk+NmR+bYgtgdH//b7BPh+/7Mh5kfMQMMTkeiwXzJ30W1LwxiKRZxsi3/jA/04UP3rMkroZK4D4Udv0k1CpmFIxdkNjhFxYO8sk9PuChUxOzUMmVEOtV28j2hbU6A6bsFX5V6kjP4dKsSx+xIej2WkzrXYuHgXa3OYqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH2PR11MB8865.namprd11.prod.outlook.com (2603:10b6:610:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 14:47:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:47:48 +0000
Date: Wed, 4 Jun 2025 22:47:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [pipe]  ee5eda8ea5:  stress-ng.pipeherd.ops_per_sec
 26.0% improvement
Message-ID: <202506042255.d1d90443-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH2PR11MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e42a4c6-db9b-470b-e38f-08dda376c5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/TiLjvYnTqe14oV3/wPUlHS6EeyyUfVyVDfjWVBMuuOct5/IjAamwdJtSe?=
 =?iso-8859-1?Q?zhAdEEhW15IU7FB5ZBBxoAYE7FPg41V0eEd713MKQTIFpRqpc68Qe/4rlR?=
 =?iso-8859-1?Q?130+fnDXOIRs67dpOcLKyQaOIlbNfZyLer4ABlGWPuiu12WD8itBWZ8A92?=
 =?iso-8859-1?Q?zoF1O+btFCC4f9oUECcZ2MdmivYQyW7UYhcLNLmtifmwufQJ2fdNrQwFzn?=
 =?iso-8859-1?Q?AIXuFmjteJvPs1lOfzN5Xlwg2tZldsJJrgnYwIKuwdKALccGkxscYCyB7P?=
 =?iso-8859-1?Q?gsPNRV7KTlpqmakfl5ICLe5Ubwn5LBcmBh0sYQ0bnsPinZbsRF9ZKINGRv?=
 =?iso-8859-1?Q?Gw/vfS2pol0KcDbx2x/6RJqstVzPEuZF6goiEGwOtDfoI4bFsSzz9Roqtg?=
 =?iso-8859-1?Q?J3c5sLkcBTJJXbR+SGOo8grVxqhEG/EUovtvT3KFZkZUK2IdLAjA2F0SwF?=
 =?iso-8859-1?Q?WFaHg8HiWg22s+mYDNCvXsLYS+UxYQD2sUiBMgIWOJvSiMciPmKpfvlw27?=
 =?iso-8859-1?Q?48zb41lLvXsGnLBJkoJ64d51ZAQ+XZs2XTA5HnXRAmLyMB0al27u3X+Vlm?=
 =?iso-8859-1?Q?6nnJp+zpvZMtE4/2yyccJoQhoCljRxLkpPbVex+0d1b18HRTZaeIKiBMCk?=
 =?iso-8859-1?Q?j3dD+QiqRgEvs7E2Zpb2U3htQD9Ea+OWdJPk6KeJPj4VTVXbE8zoSTi4bW?=
 =?iso-8859-1?Q?HwXQlgZoyVjXYTnJTLQCumcoGW2OpQm7+ucM5hcyi7QEWwHpyUbjbrYlPM?=
 =?iso-8859-1?Q?QKGz3jnBNxX55hFI1faee1PbB/d/akE0aXDjjy3Z7zOIm6PtZEUMupNUUl?=
 =?iso-8859-1?Q?7dlEI4yDmw9dXAdEQyAhgbDoQGZvs8naa1S+ruK6ejA4WkFaZg1Fpeq0B0?=
 =?iso-8859-1?Q?gIUMpQbLMpiqYy/K4MkP48RYx4EPhv42oxksYopNafM5RJpffe5O5iCzfC?=
 =?iso-8859-1?Q?nMh8QLh3ivFSReZurNdJbOSFpVM6mGzT+giGLQIMozs0jFTKyPTlRxu+mI?=
 =?iso-8859-1?Q?2LGkn66FBQZqPVks5rCKoVO75BRSEKTFLh1fFwigd+VR0XDyVPU3pCXtn6?=
 =?iso-8859-1?Q?qZdcq5ufT8X8XmyePPYGWWVFePnwxvr8DLcSBa8NWYNsf+Uo+rJ/QbziWv?=
 =?iso-8859-1?Q?pB60HkuBPn3vmNg/Z5SKUu+3pR5rESd7pBcjCAcAjixms2FNr29C/9mGt+?=
 =?iso-8859-1?Q?kbQpiFfGnBdVCVOLGatvgpXYgJXveAyLtstpyrd4kxX2kPNnW+szUGprpc?=
 =?iso-8859-1?Q?KYjqdDodb3BxGG6AxmXoDenTb7U2VT4mF2CvxPJBScbFiz7s6VPYjlbDwS?=
 =?iso-8859-1?Q?jaICPs6F8gtmkFTIHFIKxKQ4jje0BJHeZX9oyo3u0uAk6UpZsqs4k7kYRF?=
 =?iso-8859-1?Q?BbiAsEK+A4W0FeRsAUCSp6N2hF5YOYcdHl9njQj82KhPiKOwK7jW/M3S63?=
 =?iso-8859-1?Q?YKi4hk8UnWr1qtC1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TaDpEQBpI0z/EF56A8uMyHk/GrT2tJt5LkUuefFFoEonyuXhq4BmFuTLxN?=
 =?iso-8859-1?Q?Hr2rCowOvD5Q/9ilfSW4LPAcyYO5rylMInbaxLeYPUuFEMvVdMziQ+tds9?=
 =?iso-8859-1?Q?hAVxD8ptcqZXC/a7Ll3MGDhL5GDxw7SDOaTGEVAChX+h0VorOlUSql9GBW?=
 =?iso-8859-1?Q?o6ztAq9rSTqhDp8PQkP85irxSIPPch/DJVEbRTof8AJ7hgD9yufeliID2+?=
 =?iso-8859-1?Q?3z/BZdc+bpLLOLth8vSvf3QWqDA6ACBwb0rQRj1yl4U2t3GtMJvRe1KKm5?=
 =?iso-8859-1?Q?uHpEyAZ1NFPXYiliaC21D0BckPeCOgxobvnaDKZqOVUsbEiOFlzdQYaWqT?=
 =?iso-8859-1?Q?U2fyYotNhDrEndn1QR6WDJ/8d5Xc/mhNFFgKq0EwiEu0+leyr26Kqd/HMx?=
 =?iso-8859-1?Q?yLB8SnS0a8x/lHVVDN4YUZ+0meLKqCZc9iOpG+J1Slwcd863s+MiIOddDJ?=
 =?iso-8859-1?Q?XJXW5EZQ9lBhrOXB6IDgjBI3Aie7aPLnAKlD42azsTxgl5/xmb0jo7uG+G?=
 =?iso-8859-1?Q?vfTMuOuR040s6RMkp1idnniYAqDgxjZZ5AMbMZVUxbGRcn5cu9itk2F6PQ?=
 =?iso-8859-1?Q?+yzMlMbSdpGhmMp1sC81MZpjKtJ8lNsK1ce5On3/x4SeoPvEXZLZbtlvVo?=
 =?iso-8859-1?Q?hL2sYKsvaPDPDmwbLY4DkzzOU5Ap7ygBUxEZQ5tGBiJ/rdDwpHAzyQ7HKt?=
 =?iso-8859-1?Q?zGgHSDk24TMkV0cexfzI54FIXOJF/e56+fJ7CJDivG/WKtTIV7dfyvFGKl?=
 =?iso-8859-1?Q?IhQ2T+FTnTjM4qAYyErYSDveQLqQBoAgZHpRIgXi6BvtUd1FKXNnOGIe+g?=
 =?iso-8859-1?Q?jGGrbMUvew2zmGGUwadvTm2/9Jym5pdKn6LfzmOVRTvAcapcrvc6bfVmnE?=
 =?iso-8859-1?Q?mdKT+taxAxfUCLXaK4DuzXAhMGZB14uTT9/yqVXWqJuNt40+aefWxXvNnw?=
 =?iso-8859-1?Q?NVDNyRixF6ELptJJGY+gI6yaxYbXzy0QgMe9zP2MtKt0wiH9uSitGNUuQ2?=
 =?iso-8859-1?Q?vQbA7ppTL4rvq+s4sxW/IygfXeOZICy4In52AEhlXZjHZNJ/MS/N463cpT?=
 =?iso-8859-1?Q?ABWJzbRmYT0ckTU30MdUAfrYjstU/fbN1Yp7UBMkGtJX61JgUkCtrH5QHI?=
 =?iso-8859-1?Q?heslsxTyOF1tq7SqaW3LIhH5OzeTRbAYKrORUhhXAdMkKLmp0Y3ZrlYOXS?=
 =?iso-8859-1?Q?9tw0p3d5eFtNULpQXXZqUgdPEyqPR3+j0ASZ0LV/zdQteRT8R04V04g3yd?=
 =?iso-8859-1?Q?7INNm968JkTI7vpZ6go3OtuYjuxjuppoVRI8Y9DY3GSKfos3DpHm1LPJeO?=
 =?iso-8859-1?Q?Q5s7XPuJadMzj1ti263lbVp4k/hbRdBrdmGRrw0KS6pWhR6l68b1hZSVCm?=
 =?iso-8859-1?Q?aU13bmlD8hdSX3UgE5lTq5XQbsDpM2mueSy5COBLcPTO50TekA2ATNHZrf?=
 =?iso-8859-1?Q?bPp4bM0sUkH6V89Bebynpb5eQ5+nwS0Y8TNM7tDFVwleHdGhx5tjRIbw6c?=
 =?iso-8859-1?Q?i/5Ul9vmGWzg6D1w2ncJrmGMyTxJWuyHBEhAg+yJ+DT8ZmmqF9brdMlrnn?=
 =?iso-8859-1?Q?/wELOPP7+d98c3ynE+kktXahGv7lcQgFoo3sUV0r8LVSrkOwdzMCOClmXU?=
 =?iso-8859-1?Q?O1TF8PWAgLTiLGBQdb2sW4UNBkn85hY3tv3Ql4CHFb3vaZBY2l2YIOWQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e42a4c6-db9b-470b-e38f-08dda376c5db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:47:48.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+NiMRFZ5yZt+RreCisRXOVjuRoQUdnwp90nIaTH2VtUpA+XLIVfGGW5bf/4TmqeKe3YnGxJKkIHBKyBHDuPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8865
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 26.0% improvement of stress-ng.pipeherd.ops_per_sec on:


commit: ee5eda8ea59546af2e8f192c060fbf29862d7cbd ("pipe: change pipe_write() to never add a zero-sized buffer")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pipeherd
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506042255.d1d90443-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pipeherd/stress-ng/60s

commit: 
  f2ffc48de2 ("Merge patch series "pipe: don't update {a,c,m}time for anonymous pipes"")
  ee5eda8ea5 ("pipe: change pipe_write() to never add a zero-sized buffer")

f2ffc48de2017c69 ee5eda8ea59546af2e8f192c060 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    138055 ± 18%     +33.4%     184128 ± 14%  cpuidle..usage
      0.19 ±160%  +61380.1%     115.68 ±185%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.anon_pipe_read
      0.20 ±153%  +2.1e+05%     418.07 ±203%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.anon_pipe_read
      3930            +7.8%       4235 ±  3%  vmstat.procs.r
   7317310 ±  4%     -14.5%    6253797 ± 10%  vmstat.system.cs
      1025 ± 38%    +135.0%       2409 ± 19%  sched_debug.cfs_rq:/.util_est.avg
   3586492 ±  4%     -15.2%    3040317 ± 10%  sched_debug.cpu.nr_switches.avg
    474729 ± 17%     +49.6%     710035 ± 22%  sched_debug.cpu.nr_switches.stddev
      3.32 ± 46%      +1.5        4.82 ± 13%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      3.32 ± 46%      +1.5        4.82 ± 13%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.handle_internal_command
      3.32 ± 46%      +1.5        4.82 ± 13%  perf-profile.children.cycles-pp.perf_mmap__push
      3.32 ± 46%      +1.5        4.82 ± 13%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.18 ± 12%     -41.7%       0.10 ± 31%  stress-ng.pipeherd.context_switches_per_bogo_op
    107177 ±  9%     -28.5%      76592 ± 21%  stress-ng.pipeherd.context_switches_per_sec
 2.331e+09 ±  3%     +26.0%  2.937e+09 ± 10%  stress-ng.pipeherd.ops
  38728105 ±  3%     +26.0%   48797851 ± 10%  stress-ng.pipeherd.ops_per_sec
 4.578e+08 ±  4%     -15.2%  3.882e+08 ± 10%  stress-ng.time.voluntary_context_switches
 3.182e+10            +8.2%  3.443e+10 ±  2%  perf-stat.i.branch-instructions
      0.54 ±  3%      -0.1        0.41 ± 12%  perf-stat.i.branch-miss-rate%
 1.723e+08 ±  3%     -18.5%  1.404e+08 ± 10%  perf-stat.i.branch-misses
      4.74 ± 10%      +0.6        5.31 ±  4%  perf-stat.i.cache-miss-rate%
 2.402e+08           -22.2%  1.869e+08 ±  4%  perf-stat.i.cache-references
   7536250 ±  4%     -15.0%    6402680 ± 10%  perf-stat.i.context-switches
      1.39            -5.3%       1.31 ±  2%  perf-stat.i.cpi
   3691320 ±  6%     -26.5%    2711535 ± 17%  perf-stat.i.cpu-migrations
 1.427e+11            +6.2%  1.515e+11 ±  2%  perf-stat.i.instructions
      0.73            +5.9%       0.77 ±  2%  perf-stat.i.ipc
    175.44 ±  5%     -18.8%     142.50 ± 12%  perf-stat.i.metric.K/sec
      0.54 ±  4%      -0.1        0.41 ± 13%  perf-stat.overall.branch-miss-rate%
      4.43 ± 11%      +0.7        5.18 ±  3%  perf-stat.overall.cache-miss-rate%
      1.37            -5.7%       1.29 ±  2%  perf-stat.overall.cpi
      0.73            +6.1%       0.78 ±  2%  perf-stat.overall.ipc
 3.128e+10            +8.3%  3.386e+10 ±  2%  perf-stat.ps.branch-instructions
 1.692e+08 ±  3%     -18.5%  1.379e+08 ± 10%  perf-stat.ps.branch-misses
 2.362e+08           -22.2%  1.839e+08 ±  4%  perf-stat.ps.cache-references
   7395716 ±  4%     -15.0%    6283076 ± 10%  perf-stat.ps.context-switches
   3621055 ±  6%     -26.5%    2660111 ± 17%  perf-stat.ps.cpu-migrations
 1.403e+11            +6.3%   1.49e+11 ±  2%  perf-stat.ps.instructions
 8.691e+12            +5.3%  9.152e+12 ±  2%  perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


