Return-Path: <linux-fsdevel+bounces-38687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1FA069D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 01:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C578D1889064
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673428E7;
	Thu,  9 Jan 2025 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTm7lv+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD07FD;
	Thu,  9 Jan 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736381672; cv=fail; b=mHjUPvOJnbKFX3BL/PQbZFIAMhRoEg5ILJhLkTPQt3dh4pjKinm3uJASZSW/+4vlJSKJo+cH+6JPKypNkuOPR0fSMe7oqRGSnmLddmeCOu1wPostwwoKrBC2/vIAqb5/37PpeXdWpd6/Zep04X+bgbSlg439ZbiP2eJTX76xrNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736381672; c=relaxed/simple;
	bh=RNhUvrYzureu1Wcz6QVzpvRxfytm2tn7PdmcHQnmL+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+1U9Wt4fjC0EzpCD1WVWJoE330bcc5+vCSVNIrrHbS2dZcsMnuZ6XhfzXlp1wsRjWMPhBtiFpXXjBuJrwVVTM9ysqfD4VlfWIQmxa+EVD0zHrzVqHi4wdC8hUCINxUJ1Bk9pzYtb04FggjSWZ0hHP4Us7eyYRqN4OEeLRHcTg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTm7lv+u; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736381670; x=1767917670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RNhUvrYzureu1Wcz6QVzpvRxfytm2tn7PdmcHQnmL+o=;
  b=PTm7lv+u3cHWbGIsrhawSYI+zuEOCs9+Yywo+RZOnKrfzO5Xvf+qozVL
   fzG3c0vK08v6gpkrQ7PUQlpLZeIVE/1kJghDiniRNV6n2Re64Shbbknlt
   9ThaW7V8+IpPoRUU2d5IlNSdDDga7iq69lykA9846CuE2QcWlUaMTZR/v
   noJ3RQBlSRmK4uWorq8E0Imm2G5UYhSQxtgAaYVQBdSvq6svw282ffRlb
   lJ9WhsNUZXMzCCbLBYRETPmNdYRWMnrNx0wAmNj987AkdTYqai3qd0RVT
   vZGOzTgDRvTF8hSHyBN3TIOsljyMqjeSAgBJdD/fma/GRwNf4F/FManB/
   g==;
X-CSE-ConnectionGUID: KLxlUZBkT9eHAaS7RGJmcA==
X-CSE-MsgGUID: hOFL5UbMQ/KAtUesRZwJPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36646647"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="36646647"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 16:14:30 -0800
X-CSE-ConnectionGUID: nv7xC/6gTwWlcpkvaHqRMA==
X-CSE-MsgGUID: p4r2fVD4QNCe+brL6wRJ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107292053"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 16:14:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 16:14:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 16:14:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 16:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmOZfc4JdjhCtvRz0kEDFD2H4sMtgFPoNMUlvgfdERDHQU1uuov4NpiJAmlTWbgdC+w+HnEB9LAQP1fOfA8K9tO54cchdI/gCrwnjIeZsF3YbB7dU9RgXWrueUHfbzZqXPwSCHKL/4gCNbU8IJZjRCI0qAi9N4sE+dit4YV0XHekQy5QgxSmRXKoZxgaHDgBjh+ycs+kQBep4ikB9R8pkjl/wDHavewC2lxxt6IOz4yS3rFxhglYomIYWWl0aLstDyGtMD7blTQNZ3bGF4sd6cqbP27/AVLHGX5eexCaCcBYDVRiv4BVRd3fO4DYf/I1NsfFg/i3PHnA7nITX4k9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03LWZx/Dcm2M7hIFkswGHb3oGb9DtsrgN0DKrTJeKac=;
 b=Y4DcpiyCKXcZFvMzOYE2YFepMNXaoK2AxKnf+Jqekep9bGSqMlO8QderzwPO0DQpodRjwTou9QO++mdjmIyE/xwnG/CFJgs3yoCUeF87p2PL/8wIueog16gJNWYejhspLIfulBRL0Jj0nY30OuvsqovppkvOBDSLEYzWb5RBQ+37NV8M28Yn+dFAUWoW3veC5L5WpVP9EYu8CYOFfosJG01/RbeQnozMYgtKv1zhcm4Sjw5rbY3ZxJCsI8T4kp7rZfBQTlGpu+KQbbgQE+86mgrv5vPEM1SKzchwPd/BTvhRqdt9jsXlrZDD1tXBKifu7b6Rp1EWTukFXQodxY4Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 00:14:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 00:14:24 +0000
Date: Wed, 8 Jan 2025 16:14:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>
Subject: Re: [PATCH v5 05/25] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <677f14dc3e96c_f58f294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <e8f1302aa676169ef5a10e2e06397e78794d5bb4.1736221254.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8f1302aa676169ef5a10e2e06397e78794d5bb4.1736221254.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f2d7b9-6dfa-4f45-4eed-08dd304292d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbrRzBodjh9IUP4TfL5QAzhpBu4j5pffZHY5j807wpdpvDmbntu1jmUBHT76?=
 =?us-ascii?Q?uUmVO/pP2ftH8v+UN43dwOxXf+2/huuqIbQjgpvBBAY3wOJDa98XZzbgOERl?=
 =?us-ascii?Q?yjNm0Kl2pdJeXa7w95rbazz2ez5ot2dDPaTdl4X/PMSFQCpNaem5ni6VjzsU?=
 =?us-ascii?Q?0eJlOJxgWU+ElhskZ8I5b0fyGJIfHj4mULM536cpj6UsSkbSpzWMIvJ9mpQb?=
 =?us-ascii?Q?7KUI6TfQkK8kmya13h4uFPawth5uQ6g2YjCM9FujPFLO6zT61AmlwLM3Uhlp?=
 =?us-ascii?Q?lMFXwTV4mnz2ycKYPGVP/NsSfgz+BpHWu8UERjLPcl/m/WrNTkuD3nOhKQyu?=
 =?us-ascii?Q?LAzF92xR1VMscdGhSNgKf3vDXiiqAL6m2maWD+JQ/1/rBe2URmX2tZjx8ee/?=
 =?us-ascii?Q?mJaKdpg17VKdy0xrG0iYnr59IwpuXti5x+jzcP0Mtv0Y9//X6vq6mKBymYGo?=
 =?us-ascii?Q?1SPY38+r7uWAmRshMJDihXkWXbopJ/dOyUumLzn7fD0oPDWD65xqjhwpDfzk?=
 =?us-ascii?Q?c0KiBjE6PPfDNCwuz4sI0iOqh6xmldLkO28iAdH/wpMA2kGUtoY9ZrEzchgY?=
 =?us-ascii?Q?UYBwCTuT/xyEGFyX4W2Reyrj6d6rSks7jH1QG7vBBg7/vVgnwxU1jP04jKtr?=
 =?us-ascii?Q?mEF3jK3yDjDOlnK2Ujnj/qBwfqcMCAX2wtfH8zWZ6HjoMT3CtObWRVdCZPS1?=
 =?us-ascii?Q?n3mLvvfgusRwwgheoRBCdC3nB2FLS9iI4l05Jp4XVlipjAoVWyWuxSvgLQZa?=
 =?us-ascii?Q?pm9Rt1uMRhqxkYHXi7WI2Y/JZX0iem6f5VesVRP/7HmibksjFltPxmnzibpo?=
 =?us-ascii?Q?24fGGotCcQHO93yc/MmBvZ2H1oF+sDbKNRbfNOXSJsuYmdWhldtgmI/Dg08H?=
 =?us-ascii?Q?dZqkOCyP4C4r8FEN/pXz3UhEfJFHGb3tLVmKBAmLRPh5jnfse8ZSfZVYZMSs?=
 =?us-ascii?Q?fL8NpQVrRMeYPGv0+Qxw6vb3rrLj9VV+sr8hcOsR3WhitzKBKHKZ/ulh4l/v?=
 =?us-ascii?Q?Y1M5mXkzwcAhpo+I6kDfHkbEV4ZGODff9gCtC6Ryug3RBTnDs8dNY8yChIZH?=
 =?us-ascii?Q?+mUxXUDIqKd/Gu/9PFOCfRUnGYMaZEEMntRXXLVBxdWIFcb+zlp+eTDTT35b?=
 =?us-ascii?Q?fWhNxlmyf/tUwsFK5c9AVYy8KBopW2rbs+BuuyDeiR4MQUV1jILfUBngtAKn?=
 =?us-ascii?Q?Lmzg3LkfqBAH7b3TTdj2qapeCmbNYbTcUb83tdFtdvv+/SNmAHcfG4hDzeHq?=
 =?us-ascii?Q?ZjCtKzQNZGXZWDc8iPFY1pWnUkI8A207amm+UbwJ+3Vu0QuY7n+oz7Ukt0U9?=
 =?us-ascii?Q?I2286Cn6Mfo9rHeqiAYcaoDpn9s2iFAwcxPyOS2IvgGCvrIH5nrV2r/wKlFw?=
 =?us-ascii?Q?WH7QEH1lpnpun1SAbOB0LNFLEUBO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYOPjVrmzv1r+jnp1PDAyseNFFmdL2iat+rIQ/BalkiqqozhuvtV9cUcu9Sz?=
 =?us-ascii?Q?rn5B0puQRMD/cXlrNwFas7CdLKr17i25Z6o1SjiUhgUaQu8dGvP8Zta6QGQc?=
 =?us-ascii?Q?k9nQxvPX1oR9GN/A7F/M78WfUqKX8GHzaexXTEr57HbgMnN9xZz56gzkAma3?=
 =?us-ascii?Q?2t0PgQ8XF93J8kC6Vi46IfmenqUDO5wFgy63zmXBshHqmSEhqKITsqGbl6Zv?=
 =?us-ascii?Q?i0r852i3XXDYPXT8VR4SvvJoMQTM9zuQj9A27aTKmbEgcQ8OEIutSiNtSC7q?=
 =?us-ascii?Q?MdDEuTrDyGypcTcRRgY7evJjXu/3ZW0f5e0DdlYUMl/0Pnl12g5y9aQj3Jwe?=
 =?us-ascii?Q?QRTTwaqsf+y+s27QHblVYhGVx7mxvHNG7jK1VeVdkB3prkwyPunfJjT5gM3c?=
 =?us-ascii?Q?OjYY/pEX5NTQYlF15kbZOO6LRol0rtpxNFJJ+n+5aU5zjdR6CmmI0awjCEu7?=
 =?us-ascii?Q?2rpc63rzVy1+zIimGsPEk17nD7RfdBQVCV7RLpu5OTQuqGewEnAog4Nhxs+L?=
 =?us-ascii?Q?Nrni3R6W8D7mOSOKK7/SIwFfqNuhAmL8/+it0Dgsqi0Z2+SwgxTpCuByNIMt?=
 =?us-ascii?Q?iPaG4/xo38kQcl5CxDwkoBKhXSZlyu62GVBAwbhOihz4hmtymb+gLo2qZFVO?=
 =?us-ascii?Q?KeX0rr0kJhLgQHNLKy6wfFBR5hpzVnEneLnmKyxKlqDa4/p2B5sNGv9a3qL8?=
 =?us-ascii?Q?Dob3PY3rgQAaF76Ma4y6gZywgEGE/jwoH7nWjeAxolPa98IQMi72g8s7cKQ1?=
 =?us-ascii?Q?YugW48Jb3SOdL2Jft2g4pAt/aGhIRFmt6roriqgLNzIIuoXbDO6XV40ak34k?=
 =?us-ascii?Q?9KC//mZTDGjoF+cAqlE+Kd2QAsE7xn0+bS0ipSZ8TgVp+7u+P+tZW1EDrPiC?=
 =?us-ascii?Q?SKWajOBAEK8Ldd2vsIl07EOupF7/F59fSQmHH9X4bf5+MT0yKA1xT3FzBwty?=
 =?us-ascii?Q?8y//eQaWNOJrz44OaWBMtnQKVv/IVDMML11KjR0QQzcIk69nQ+uk7jOVMtlY?=
 =?us-ascii?Q?fVdLRxOHaoWKQ7UCDxML1SZOcwg4WcUVIcT9gHbqzUqjdLxb/R8lyPNhlIj1?=
 =?us-ascii?Q?8vvWLc5MrtiAC2ON80JOuCALs1Cb5XbdcHuAePv8xn9Sg3UxYNARFbWv7YJ0?=
 =?us-ascii?Q?1Zb0CCnvma4wKlggn90mroonWuHI9YIboEvkJcg8nuirkkNwcK5pNtWjKBSD?=
 =?us-ascii?Q?HZIoP34bUawjVU4Di5+8HXmaZ8nDX9tFJchBTyq7RLBL3S622BecSV8ODjMg?=
 =?us-ascii?Q?DyjCuaFeHtOyGLSBVYlTE+wAdzk/aJe+0Wco5Rr87UQQe8FvYnLBGKZ26Hze?=
 =?us-ascii?Q?cVmyGQS9eiaMKaP0+mFj3YsazQ2aPAIu+yUk9X3Fq3KDdkPXqjKBkDGO7vGk?=
 =?us-ascii?Q?IoLUrgwpmawmBGRWwFDd8Z9hW6LfoKeg8QDl+m5fCIHTr1jW0JsxAxgm9CYm?=
 =?us-ascii?Q?u4glx83os61X/TTWzOw2dfHb8H44CKqImqJfJ7Uz4SjlNNOOA7Wk4zLctiaW?=
 =?us-ascii?Q?MLya4PbWV5QucRGBeMlH+2rzJXmca6uvwa1JqQUZzIjfxgYUOiV6Uv5xIR/o?=
 =?us-ascii?Q?xSePUBomS8aCMxJ/BKVYEIJsbXHuRCbjEZbCeMfjThncIxuvsPkmO1bfsqxR?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f2d7b9-6dfa-4f45-4eed-08dd304292d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 00:14:24.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5qSL2SlE9Yc4dQnMD5LVxmzx0AmSAgnRcnPu9+ADORw+M8elwJKf36EHOu+ulIJRRMqmUGB+7sRlowXCQBifpCfwwtSrO214/SZd3dDG7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Prior to freeing a block file systems supporting FS DAX must check
> that the associated pages are both unmapped from user-space and not
> undergoing DMA or other access from eg. get_user_pages(). This is
> achieved by unmapping the file range and scanning the FS DAX
> page-cache to see if any pages within the mapping have an elevated
> refcount.
> 
> This is done using two functions - dax_layout_busy_page_range() which
> returns a page to wait for the refcount to become idle on. Rather than
> open-code this introduce a common implementation to both unmap and
> wait for the page to become idle.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v5:
> 
>  - Don't wait for idle pages on non-DAX mappings
> 
> Changes for v4:
> 
>  - Fixed some build breakage due to missing symbol exports reported by
>    John Hubbard (thanks!).
> ---
>  fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
>  fs/ext4/inode.c     | 10 +---------
>  fs/fuse/dax.c       | 29 +++++------------------------
>  fs/xfs/xfs_inode.c  | 23 +++++------------------
>  fs/xfs/xfs_inode.h  |  2 +-
>  include/linux/dax.h | 21 +++++++++++++++++++++
>  mm/madvise.c        |  8 ++++----
>  7 files changed, 70 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index d010c10..9c3bd07 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
>  	return ret;
>  }
>  
> +static int wait_page_idle(struct page *page,
> +			void (cb)(struct inode *),
> +			struct inode *inode)
> +{
> +	return ___wait_var_event(page, page_ref_count(page) == 1,
> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> +}
> +
> +/*
> + * Unmaps the inode and waits for any DMA to complete prior to deleting the
> + * DAX mapping entries for the range.
> + */
> +int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> +		void (cb)(struct inode *))
> +{
> +	struct page *page;
> +	int error;
> +
> +	if (!dax_mapping(inode->i_mapping))
> +		return 0;
> +
> +	do {
> +		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
> +		if (!page)
> +			break;
> +
> +		error = wait_page_idle(page, cb, inode);

This implementations removes logic around @retry found in the XFS and
FUSE implementations, I think that is a mistake, and EXT4 has
apparently been broken in this regard.

wait_page_idle() returns after @page is idle, but that does not mean
@inode is DMA idle. After one found page from
dax_layout_busy_page_range() is waited upon a new call to
dax_break_mapping() needs to made to check if another DMA started, or if
there were originally more pages active.

> +	} while (error == 0);
> +
> +	return error;

Surprised that the compiler does not warn about an uninitialized
variable here?

