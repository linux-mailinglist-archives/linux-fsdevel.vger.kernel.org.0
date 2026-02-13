Return-Path: <linux-fsdevel+bounces-77181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLeZAJKVj2nqRgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:20:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728E13997E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E97C3024A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9C287516;
	Fri, 13 Feb 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fn6W3EiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EC3EBF3F;
	Fri, 13 Feb 2026 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017604; cv=fail; b=CW1Cag8j/ASQJld1jzB/5LEf3VHnRmAwVDZxefmNLAMwpIejM/hdagDSCO63U69jb0dNE6r5AOrAvY28YT1f7Nu64vYzPE3aArWBCUQQ/bvOVKFBhalhlmerRd4oM6Zw5EY+6JLOjEG9MPfs3tMg+RN8jF7ftzDJFK1OiGZgOG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017604; c=relaxed/simple;
	bh=pYSlpOdfNRwoJ4T8fKXTn8LU5u7lusfF4UAjCbabrJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ae6D2y2eskkJENZ8hngR8ufZdWzKxRuPyKpmRFY127w/e9NjlkIFYjzdk/fF1/Ok9HzdRS/KC61xBb+B/UJTYsSyrFLmdD4dG4m2xnFHgWdKQPAR314U/8NeAk0vKE0XLzkuM7DkZZr28EhfDvx2lYZ0DtuCkwIGW+Rh8GOd2mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fn6W3EiS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771017602; x=1802553602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pYSlpOdfNRwoJ4T8fKXTn8LU5u7lusfF4UAjCbabrJc=;
  b=Fn6W3EiSIsh6pMm7+ef1eLclbMA4J87AclWVA/DzASDFFZ1k634gV32z
   h+TKRIlFgJR0tVsZhj4WYmeJQHkxHdOvrYovzzC2Z7104WPmsTL3wLJ/k
   kaLdOQvwvJHsxMBbZaFvlrsj9o9fkc2UFjI67+UEpTN4vGNmWCKVfK5Xb
   8JmNlLoE8r4ffRyddthYkgO6TuI36EY+QRGY+83mBJ7OSM4dAmxaLxZO9
   dW6Wy+2kJOtq4CSivnpinqL91S1Zfw8tHmW+ZvVG3pjR09msqB/4ZqrON
   wKsAIaiOxYeEhA2EnXXSNKYyaFAGbgFvPXYFg9gOzSCCJpD2CofVxnK4f
   g==;
X-CSE-ConnectionGUID: gHFkgwuXTam/96OyOBf8wA==
X-CSE-MsgGUID: J98PimXzQmGEQYeM4xKwgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82932902"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="82932902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:20:01 -0800
X-CSE-ConnectionGUID: 5q2DQNPeSdWtTzXX+X5a0g==
X-CSE-MsgGUID: pWghf1bnQPip1uc+d+b1rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="211912438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:20:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:20:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 13:20:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:20:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWhxPbsAeT+FWU1BCKbvo21Nh1y9eqf32A+kfPHzQuTjqfT+A1Y0yZw9ShpAMEPQRVk3noc6SooDQtvVTujmeNEC555RT73ojoiZNTlJgv4cfyoXQgv/XwIGU5WefW1wtiFR5XiIYbigPrcprWUkmTtJT0o2xfC2+DmknDjpfl0z7gxH3/hksNGzO8VZaOvhUGBpqhk2bWsHtzBZC6MmmEKNiuk3+ue92C5ZWRmHjHimMDs4ekccOzhHpPP9tZgDnK9KKI0ul59si+oic5zcdRFJmBNQHmqSGskFyMiFrLF2Rea5B1cvRqXtub5/lUlvOUkQ3s7O7DoIjwIbbqN5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0yBpEEW5zQXA06DAQFYIUrDSLJzETqgubZE/DnED0A=;
 b=VqTx97DQiRfmYe5wpz6qSdF+BiU1Jse9ri8bUSYyF0VP92sfXqA332mChd+i65IS1/Z+vFjMFuZvA6HCnKFiu7ZDsAuPiqdTuZTgFiD4QRDq7eqUSVL/kwR0+AsDTm288aEvaGgFwWhKBKZDdprYqoKL5l2DmdbWFFEfXn02NSQvaYeH1UpbgDervRvcbtHElfxggLZdYKHk+KVueG0auvA5qoRWdTlq4ldw5ZI3t96crSaWbFe2CnOLl+QTL/TWHr35baoB/24RWWH7pceycD4OBawjIC51Q+KT2rSImbaMAzfr6BxkTghWR3LjsvEoFH4z05Zci97TWsL4xzsRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ2PR11MB8514.namprd11.prod.outlook.com
 (2603:10b6:a03:56b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 21:19:52 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 21:19:52 +0000
Date: Fri, 13 Feb 2026 15:23:15 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, "Miklos
 Szeredi" <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, "Bernd
 Schubert" <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>
CC: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, John Groves
	<john@groves.net>
Subject: Re: [PATCH V7 05/19] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <698f96436c715_bcb89100ea@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223147.92389-1-john@jagalactic.com>
 <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1e9a6b-b3df-426e-7ddd-08de6b45a095
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hejIhd7DBcvQa0zsnOeB0+TBlVxM1Mpbmo7YQhIiHslWCDoSgp0dCxTHthjT?=
 =?us-ascii?Q?FWPZrIln0VN7AReMCPunesCmhu/5hcOu8xfJlJQJgUUL2WptmrwUtvG4twoL?=
 =?us-ascii?Q?9eEPowA07dxDaYgi+Q/9/3yuvUIK3WxpjFjtoNxULkgTT/GpsRW5VheTjuqW?=
 =?us-ascii?Q?1Pril9xmCPhxK+Xy0T+CvCLJhclr34nRbX5lKeqPGKTWuyt7TB5ZJVy40srh?=
 =?us-ascii?Q?k6xee0lkm5InLV6FB48YazL1ryRuUJsxWwOBLgGr9Lxtaf8DMGWa0v1Vkxy/?=
 =?us-ascii?Q?KoFe0tY3DZgl0KZm28NAjuRNZi7wAzi7NIoId1cH+Ywf/k61Q+Pr7K3Glo+E?=
 =?us-ascii?Q?LIwM8484DdWqvAOf3FqkvO1I+ftg/fUHdsXubfcXL9Rz7osLJzheW32nOgde?=
 =?us-ascii?Q?jj8Lp3p41mLiV5oncp/z9FvkxZMtd9+EH9voI8bjLjKmZYv7WB3LNwnVZ1M/?=
 =?us-ascii?Q?IHVJA34fpY4UuqNleNoMtzAhnwbwsL3kGhriA1Sb4ZfQG1F+X4yJUjDdLjas?=
 =?us-ascii?Q?I+kI2rdlmtwAQQMbXXmNwn2aWbwMqb0c3s+r3jbF0qHDxxZiaNy9k++eqbsQ?=
 =?us-ascii?Q?4ebsqZ0spYvHCTZ69C2XnUGGPhPV6iWVtCBiorvzi0NW3Gg8q1TOxmYQIYvy?=
 =?us-ascii?Q?lSYMNG+0JlHTyoglOYACsGDlmHSNuW28AN+o6bB3H1APqoddRa97dgGyead2?=
 =?us-ascii?Q?O13RsfMjKa+KgjoD2+eU+YVQMNEAi4XNI4wJvheHu/o2EDeEPgHIaxTy0s3H?=
 =?us-ascii?Q?pU5wz9H8bKtUWXvk5ac6SGMNTvXjWBtLMWZ9uLrnlsQyKWvaC0JyqfQsd7wJ?=
 =?us-ascii?Q?DhoJO171C9tJS8xSTXHV/3tznkTuS93XSsmyFPTpI+n+cT1R2Q1JZVNdVbNQ?=
 =?us-ascii?Q?Crzf6o6o55K8WJyeJrlsrJ7cUCiTZ+NUF539/MOzdLzhVGL6zt5joihmI/UM?=
 =?us-ascii?Q?dUxDZe04cxVkxVlc43GKDa1wBZP+CoQss47DsyNFwvYzlhL4P8XwC4IrhWkj?=
 =?us-ascii?Q?2mvBzsEo23EqotUALqP7SJBaDSae4EGaYe1Xs7wqroXlQNgmvhvLSdZgUZTI?=
 =?us-ascii?Q?hyoUsxHDyJQSjxxbWi1N19C4hCGjG+amahX6RH2l6xBSoQ7dMYZcFR8Tah0p?=
 =?us-ascii?Q?eNTX6NITI8sh7NzxI7YS37Ev3/nFGEpJkO9+knhESFXayXH82ODfww5cKHKU?=
 =?us-ascii?Q?xvQRDCep2scRc+vaaB4PG24d7GayFrI7BSlJe3zSyRqmmR8RcKIEY7WD3b9S?=
 =?us-ascii?Q?niL/QMVCKSsUrMA5SdR8UXDRxcMCW5guyGuCwBOzBBwZnXLrJmvYp8NwKBZF?=
 =?us-ascii?Q?G+3g1ivTSx+guQnFK/ZQtb84mUUEQ1zHLZarD1IoFE2f+tw+RdGWBZMyblTW?=
 =?us-ascii?Q?/qyFU+QVdgYkE6VFBRuOjte4NAhyrHku9RZbTbc46Vqt3GfY2hJnqXoPO2Jx?=
 =?us-ascii?Q?9dm6MA2t/U7oCMxuWO7BzL+Z+WhdeRKuhEfxCEEAiDKgimbKDxRBCZ9krfkN?=
 =?us-ascii?Q?P0lt2g2wBP5kQLPIkJyH1/H/eS8fGqOHX9KmSUTUq4id5HNEHHIhya3QQqOH?=
 =?us-ascii?Q?kvaPaMij1kuFwEosDCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzxCYHrCLg0/VoRRHKZVtKJ8DM3qkzq8f09J1Ss/YjbqRyM1qW7Sla6B95d4?=
 =?us-ascii?Q?xwqbRat/2CRdatHGBuVG+Kyo36k77MVFqMktgaBZVvZ/I9yrNcEP8UqTyV5X?=
 =?us-ascii?Q?kMMsYuKPwH/gkF8AWIWCl8zED1T8PTTzGX2feQBnSJ5yw2X21oL60jqUOwN3?=
 =?us-ascii?Q?NdJVv0duwjigBZmQ5lfPqR9OXp45IEbhtIC2g9wnxGZ6i14+bLm76BypKb+T?=
 =?us-ascii?Q?h9t/Kiy0gKAhJLxyW1XXG6dbp6Kya4D6m4UoEARWSBPD2B/jC+PD3S9ExFmp?=
 =?us-ascii?Q?FLUuDPEIhKfWcg0ytkdwExjcCNkJDH3UF21Q81xEHabA0xiL00CXCJ4CkOAc?=
 =?us-ascii?Q?4guv41UYgxtXECzt64BJ6bFSBf5qIZUe3EbKrHMw35jD/ZznZxNVdnzNMY8l?=
 =?us-ascii?Q?nKsOS7uofho98QOo8IbxCsKr85t4EL1WCIlphJj3ao+t1O74hhsT62UtlO2S?=
 =?us-ascii?Q?EHrRroCrbQw2YA9oy1OhzW50tmlq0e6HquwgDck7voDAMyc5YMOnnfxP5mzc?=
 =?us-ascii?Q?84Wlr2M8SnVqXgfWqs0yPqBO6aRyNgXMU8LENqONOJvzbN5k6PsC7xn7C67G?=
 =?us-ascii?Q?FnoP/KbxCpPJfnhvKqnJ/1Xs5hnKo20+P0zOG0WuysDKM7roMnUSYCUW5nUA?=
 =?us-ascii?Q?j9NFb/YulV9WeHgx226l3p9D7P2OsnHogKismNfePqB0y6i5mLfMXnb+jW98?=
 =?us-ascii?Q?j/sf0ufo+YepU5vZeUyz+ZGKLdn/vIY0fQx6N45UcNVa5UKv5aka8gKjnJKS?=
 =?us-ascii?Q?XZlrs1X+us4Opw28qkk8XTjI+nHIg+f/PVy2Qfv2Ghmyzr3OGSVXm+dGfkcf?=
 =?us-ascii?Q?hNj5g7B5nMQB3HjSoPTUs6gI35NSLZgu3Jv/KQWBWSVlpbZBE0PEzhGQ5qh3?=
 =?us-ascii?Q?fPlsP6urxVc6ED1vWCL2wCRgh5EJbBKywRoUxl5X8/PUA+Kdqtf4kqfsMRRc?=
 =?us-ascii?Q?aLoEUXPNDbC2bE6Sf4/LsDpwx4a4FalT74c3zYHG35/7aq4H+OMQkYg4Daqt?=
 =?us-ascii?Q?MYwAJq4AJU2Vtf1XFniv6ShN3ygaJfikyFgI9JDs5wIjkcYDR6Io5yEodCUo?=
 =?us-ascii?Q?Per6TbOrE3+ET8nq2JTgZp8XQHp2iIYUyUYGZ6TuceT5WkQRkADzPQ9DkBtS?=
 =?us-ascii?Q?Uj4+5SGn1gYr22sdhz4YMazCsuKJ0PhSQNX7fx009pPikv671VW3Bvqg0glM?=
 =?us-ascii?Q?csy4VUepRGtTDlgSbFIYmeVJilNQtG61LhA27gnLX1d0Dn8uSBtgtPsFBWB6?=
 =?us-ascii?Q?JPUMOU7Fjcae4Hcne+yDOZouSBik4dY+Yww9Nl9OF7eqzhZ2MZNHP4QKI/FJ?=
 =?us-ascii?Q?nSXA62GhZbZiFX77bMSI602FW3Uu3cnAZns3GSxB5jH8p2drrj6lStn135T6?=
 =?us-ascii?Q?geiInNADyazpydNNXvNnvGpVOYp3rQtBq8BKZo/aSrDSAwuiluCle655eCbe?=
 =?us-ascii?Q?FT0U5oQqUUaHvIIeOqNwDi30ixeML9dMxjjJk+4kuIwgLKD61zCfJJh+Ltzs?=
 =?us-ascii?Q?LI7ay3lRU64D83XYm4K4bxSfOpBh9b7VWS1sYmstuJTs93R+zOEbY4Clwn/l?=
 =?us-ascii?Q?l01O6Xg99vI8V+/vBN5JE8R2Dty1mJWR3VfM2uSFXc8zqHsTl9PseFpB8JbM?=
 =?us-ascii?Q?cfzKoruGAP9LP9PfNpeuA/VJaIwoJz2ePfjg1mqoCLe+GAJoch/2sgj0wYLg?=
 =?us-ascii?Q?z2E4c6gL0xTfIbbJ9keO367C3nqU4xEjk+RFNxXenJKtDDbKe8CjYmZ7jfX4?=
 =?us-ascii?Q?FDZxcGwdzw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1e9a6b-b3df-426e-7ddd-08de6b45a095
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 21:19:52.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwBJGhutwj3+bVyz1+XZm1VkoebsmqNngpsB2P1TegGkQGkhUiWKV/o0871SnPnFoWV4dWOv21QCRQ3WVyggMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77181-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,groves.net:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6728E13997E
X-Rspamd-Action: no action

John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> fsdev: Add dax_operations for use by famfs
> 
> - These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> - fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
>   newly stored as dev_dax->virt_addr by dev_dax_probe().
> - The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
>   for read/write (dax_iomap_rw())
> - fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
>   tested yet. I'm looking for suggestions as to how to test those.
> - dax-private.h: add dev_dax->cached_size, which fsdev needs to
>   remember. The dev_dax size cannot change while a driver is bound
>   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
>   at probe time allows fsdev's direct_access path can use it without
>   acquiring dax_dev_rwsem (which isn't exported anyway).
> 
> Signed-off-by: John Groves <john@groves.net>

[snip]

> +
> +static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> +			unsigned long *pfn)
> +{
> +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> +	size_t size = nr_pages << PAGE_SHIFT;
> +	size_t offset = pgoff << PAGE_SHIFT;
> +	void *virt_addr = dev_dax->virt_addr + offset;
> +	phys_addr_t phys;
> +	unsigned long local_pfn;
> +
> +	WARN_ON(!dev_dax->virt_addr);

WARN_ON_ONCE.  But frankly I'm pretty sure this is impossible to hit given
the probe call, so best remove it.  Also yall already used dev_dax->virt_addr
above.  And will hand back a bad address to the caller.  So...

> +
> +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> +	if (phys == -1) {
> +		dev_dbg(&dev_dax->dev,
> +			"pgoff (%#lx) out of range\n", pgoff);
> +		return -ERANGE;

EFAULT?

Ira

[snip]

