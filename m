Return-Path: <linux-fsdevel+bounces-77215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMtxELWdkGm4bgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:07:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CE13C687
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2943D302296C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80D30F532;
	Sat, 14 Feb 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8Z/v7UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653B23D7FF;
	Sat, 14 Feb 2026 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085221; cv=fail; b=An751HxpJFTEqpZZtKnwMEG2mQBPfZ+fWWo+yMMU49/Fpey+KFonz3abdj0elPCMXob/Oz5vAgugZYStdxJja1OQRyk2RCKScwSGZ5oaIuMaUAWkN5mjHS40aUMk8rDBFMZ7FRARX3NAGY4QDOIqz1edEx0hJf1NqLWa1cHg/7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085221; c=relaxed/simple;
	bh=cd0dk1du+fQDc4bglyqT7KadpNxf06TZlgVhv2ZLE4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JI3BBikY+gAv/MJaYFGVfuBIeL9+TWdYMEUXiyWqQ5R9DaLcegbtADBw6/O8GR1BNw+1t/VzoiKgN7hNCfAUrMnRKlCsFLikhalYu4iOBdXm1/5HXVabQANlg3p8HbwazP8D3LeqcGQE+gCQtUkv032beSfGm/ivF2WWtnWeFCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8Z/v7UZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771085221; x=1802621221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cd0dk1du+fQDc4bglyqT7KadpNxf06TZlgVhv2ZLE4Q=;
  b=X8Z/v7UZwlZR31t1BlqNmJrPgvdddSwUyXZSVxCLjDt/1iTV7Iv/gNRu
   dsm3Bu8MwGn5QfBfiwwIhNzQjXlCp3oZPJcQLG1sXuHi4FQ1jvYnqQkmY
   ZztpTUSPtFTHX7kkSwiwfWvg8lV9MRowwBc/IsIFrgdp0ZeZxqH+q+P3M
   qFGgcYIq1jBrQPqNHiBnFwvp6N5WaqtPqbEAGRadABDYtiVtVSa5DmAxL
   N7yhyNunwFjLI01zsLH4+Zjun73MGNasG9LpBCBYAKpwui1NCWuFFeSu3
   csidkvcTUrz/E2Ov17vhA6NS2TUMSMGY93o6IEGCQcm8AxI4c9lDFRE+a
   A==;
X-CSE-ConnectionGUID: Pfh4D/ldQKqeSwXQura+ug==
X-CSE-MsgGUID: ixtuor6qRv+LoPPKvksahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83345030"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="83345030"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:07:00 -0800
X-CSE-ConnectionGUID: 4pOauSvqQvK8sfICTwkEJA==
X-CSE-MsgGUID: rfoKo5TISW6ZGrJ9zzWdqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="212049148"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:07:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Feb 2026 08:06:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 14 Feb 2026 08:06:59 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Feb 2026 08:06:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxTKf93dxhSqESRpYp4osyXJWHnmr7x1Y6tat5GkuxGZ26FFriWgXft5EgFmdQG0BXMxBXSb5u1YV+UtfVPgRCud1bSygVqcGkZvsOwYt8JPCNsOnHpRfBR0oJFPw85bGP4jhzGOVcYIThjOe/QI3nIlLVfDgKpncr6WXlgt7XJUJJsMB3MXIAqv1Hwx4QaOzokmKDHgXykfs1yVFlgiAeRyVq8ByVvLvm+tDZpUc7lmbxsQHrukZyhch1YVY+dI/ggoZbLvHZFOQpNoCCYyuGJimv2VIsty4Ez1SbPwQiQvyYpMorXVS5alU9FkHFMN/TlXOg3mqCMxhjVs0W4GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZNqWEM7n6wp6C8EoUjgsh5S78YEmKX4YuurDtJMzEg=;
 b=uzsOIgilVTcV6MyjXyait+D8SZ7sns9svRX2N4j8GVfPXdCeJTkOYjbJVbK4DL1SAtMLpiS73x+hqOuDTVGYnSMdlNw4Pp3io3Kc9MgBARYq7RajnryOprfv/OBKNbSq/Up/614cniJGa4OgBLWaQRythYXZY0tnw3j4OFib+gn0R+93qZNxog/zC6so8RM6umhp4o6UasYXR+r5XkLRXc48pdpyMtq63ghDAekhfZcEhMREQ5VcqaPjB91gH9JupmuwZzAVYY2bIuTSuF8y+3Yq5ZS3MfsBrYboUrNv/f8p6hGQM38+c2SmmGagpUXuPqYy8zVbK6/bBaGXe2Ge7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CO1PR11MB5169.namprd11.prod.outlook.com
 (2603:10b6:303:95::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 16:06:56 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9611.012; Sat, 14 Feb 2026
 16:06:55 +0000
Date: Sat, 14 Feb 2026 10:10:15 -0600
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
Message-ID: <69909e6740f2c_14e0b410047@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223147.92389-1-john@jagalactic.com>
 <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CO1PR11MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f52a0bc-ae9c-4d1e-6285-08de6be3132a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SCqAa9sMDz1xiBe20AcLs6JyoKGM51+Op6ZDpc/zuUOLQgBSKmSyaOxIuyIY?=
 =?us-ascii?Q?4cq2ivgL0KPFyFpqGcOKVQmd1xWRWsxpxVPDQA+PTWk99Mk0JQPFhrEdB48h?=
 =?us-ascii?Q?q93TrW0Nj8xxhveKc7t81pyPO2avuHhJ87qy7/r8IFADLZkJmQLtX1Oxey+N?=
 =?us-ascii?Q?+7917z9Ua5Efv0P1qIy5qBzdTqenZ28CdSclZkbi/VW9Xu9AvBBsHbS5Wui2?=
 =?us-ascii?Q?XdC54R/+1KC7WGA1TR6jkqIGO2JOF3rtpd4uz8fE2L6y57O1KTCqE9UgSr+N?=
 =?us-ascii?Q?Bw29zWwDTAX/0X4UptOBzf1d1dLeZALRjr/pUk7WTyi0EmFflgr/ZkUfDZQh?=
 =?us-ascii?Q?iG8U7J/bkjMSENbqsiKK6KGBCLESPt9dwk0YHCVtJ7SKraWz2fkLpSlpu9Nh?=
 =?us-ascii?Q?wK/vV8pEdfzObNs6k1NVZTFyyGFTJAEvvShvZacQIgBN93obLmMS+f4D0R1F?=
 =?us-ascii?Q?jvoWqj9atPTAtOJFlFlv/gD2GumJN9ga9gvfYroV2TC22ylpvE9cIJIfP+Y7?=
 =?us-ascii?Q?LsShW1irOWRtHVTkbJFJ5Qi1gtWKb5hDBLYrB0j1CnZtnQOvntIRK/X6HKx9?=
 =?us-ascii?Q?7coP8VV8DaiK2Cx1A6+nyATfOcS23g5Adb7mgy4D8kjR7lr+4BAwnVqPckai?=
 =?us-ascii?Q?Qq9I+O79elMbP0bHeSCob2pQ6J0SLcleKjeERdDTsCnW/4FTIaNXOh6nbrq8?=
 =?us-ascii?Q?1qQgdKNLLvZjIAUssaqsiaRkmPtn1n/IbtZn4jU8BAh7GgRanILjIEaawXNJ?=
 =?us-ascii?Q?TbCU66xBe6iLhDzcO124yc/KP4PmAFXTU42KS9+7LBjfcq2uzpBVfQsU9lk4?=
 =?us-ascii?Q?IcCmBdgSInwOXoOdfozEaEPkQOiIhszmE165GpmO7ex+nkWFdVpHj/GlVRVx?=
 =?us-ascii?Q?V/eAN9iPM1tXtme1wTn5qfIXxSjlOWiQeArOc6+JzmxJaFZQ8DbiuNxWBVS+?=
 =?us-ascii?Q?DN6YH5Cyd5q1OETNczgMP1etz91QbOGcArCEhVaGdE4PE+TPhrXP9QwWxyJb?=
 =?us-ascii?Q?k3mvZG5zRDfEC2cnDJcvHkGM8i9cgEVwDrUVpIwucuNxZITjGYx/L3CHOMF5?=
 =?us-ascii?Q?m4hXEJXI5jg6OuZdiqbmy8XNvzn5wqZaUXnQYS9xLyMBwlJz0wHKAwfuDNhb?=
 =?us-ascii?Q?jgfQIgqOj+aiDJ67Bi+bx5rj5PgjkskMN65RHRJNa4URULMkC8h2/iVh15P0?=
 =?us-ascii?Q?C6NB35RQaLFhANlwGOxsYgc/+oqj995oqkGGH4JMsWvIXhXteyhXn71DPb9D?=
 =?us-ascii?Q?4oW4gr3Z2Whqy6v5tJayObj+xK07KVVQ7UVkE3FMhL4WE1gaolhP7xU3wrkM?=
 =?us-ascii?Q?UIOerb1ja/3IQYeFzbhA9KHEq9lzCBmC8N3S/MxSh7HYKkcAVD2NBYTFcfr5?=
 =?us-ascii?Q?+qGF0qoyI237QQ8B9UFBciXUOrP8HJRzUeWWwI3bKWj4R2CogmtNcqM5L02x?=
 =?us-ascii?Q?XZHrQ19LNMYhuZX6ZWavJhtTmkW0aZV7BFzHh56nPeUKG/dufl8tTQMvuphQ?=
 =?us-ascii?Q?Cq2O7uFHSfXz2uh3I86gqzs/uV21EShC+LIAOajIFTzCNfYY8pqHaHMrPjkv?=
 =?us-ascii?Q?qFdFyFchEE+l8UJYZng=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIBJa6kpG2/O0Sx2KFso93s38i3UcyCrZrg8QeEwjnJv11AJu7Maaq9mTtQP?=
 =?us-ascii?Q?OJ+1+atCwWvoKM04Bb7cpLnztCJf7rhjYo0qUyYrJrpWhNOUcuiFH/KBiCeJ?=
 =?us-ascii?Q?mUB7jC5wuioaPu5tH5JEbRisk2hxCTEeA9NcAoGkkYITrAnI8ZtAWuqUO5jv?=
 =?us-ascii?Q?dG83yJ2lCLv113uKB2YM0dIoi5qNBpbEPPhBd0G26LNoEuOOhNILVGUBavZ0?=
 =?us-ascii?Q?YUHyOZCLV+OtGi9nfpHf6g6uT5Xj1jEXHmiUFDUhAQPFOl2Oxpz2J7S4OsQs?=
 =?us-ascii?Q?YawVwazESlFSFRnwnUJi7SZZXbbQnJlkqob9fjvR1RF2z1vbd0qRpB6pBHcr?=
 =?us-ascii?Q?Vy2GcAWa/84zZWtDZhluQ/yDiVC4EM5BVT7oQNnuFj+vG51THfiWB2BcoYfq?=
 =?us-ascii?Q?5k6IphXgc1bOiQRrIjyLJGnmJo92RnFTVp3BCHoQ0WT/JLgK+t55H1rmkPfo?=
 =?us-ascii?Q?iyZVdlo68+NP/a0Uf5+pBYR4eHWgtyBQwW0ItLIVmJCxnlei7/gbTZNyLn4T?=
 =?us-ascii?Q?dwOhu3hT1vrkwk1PFTcNZdiChnXekhnmaDXTN7H/4tcTUUjI/+tUJKNWTrdY?=
 =?us-ascii?Q?ctvbTQnOgaQxJU+EdKaCSjnqos4paWTjaSFLw0JPcIOSidLQxVBmvQwQSBTi?=
 =?us-ascii?Q?hAapCz2KwPE4a8d3WMCb8c7UwkMefvAteSY2x8uRjxoRhysxeXTAPOJSDHfZ?=
 =?us-ascii?Q?Uf7fkntKeqsFDqb0whBhjOEJX/GU4kbOT3eGG1ZGf4x7bTB2Yf5BxBMF2uDi?=
 =?us-ascii?Q?9uhwc6gJVB8JkABdkONqli7BH3zb9EDhF/O7Ke0Y10ZjcXVLErgRKyNoyeBM?=
 =?us-ascii?Q?wdSBu6O98b94PaiGxX4N+Qir6KPYhc60EBFfFksSwgt5OGRU75XSw+llE4MN?=
 =?us-ascii?Q?t7HbkEPrn38eR8CBmCosqWpBY1MN9knrkYwUD4G+9EBY/hzM7CTw5d5Z7jpy?=
 =?us-ascii?Q?x5+txqLI3ytFEgcd+JmoT7YGEr6lHFd07uH/BMiBBPDi07Ng9XgcVV4pKcHr?=
 =?us-ascii?Q?CspZ/UgQmU1Y+gHW+5YoJQSBIXQaMqKaYcItvkITUZ7mb4R/GiabQb9Ih3oO?=
 =?us-ascii?Q?9jXgV7GDv06z7PMOFaeTSY/L4F162weQf6AqdhDsqmYm6gGRWgm28IX/JcPH?=
 =?us-ascii?Q?fIsCxLRZt3pEALvWbSDPArF3XsjaPJtb7+ULbG+GAGI8aGCkRkvFx/qyQnKn?=
 =?us-ascii?Q?ic9C7LoGeMrclG1Z2FigMrRYi2t/ZGrSm3pLstkQGIDYGNzPu/BOvoqvZA70?=
 =?us-ascii?Q?431Z1QFUh2gjpWa3q/zqwQsynCmp8u5xeSPRrFd8ZJFZhvE7qg39zwXOwohE?=
 =?us-ascii?Q?qDDHEgzOaRYhufeXg420xyySD2EAYHn2O3DZtKMs7clFm8MUhNtwtoC9xMUH?=
 =?us-ascii?Q?1sHEiRhE72hO2vGUp8jB9PPRbfbpjWUWYoessPDhEPdPrW7UU4rphb6hH+Lh?=
 =?us-ascii?Q?PU5iPQnRHcuTul26N0+qCam6Jprk1T3evhpkH0T6twz9J18FT1rNRO5eP5BE?=
 =?us-ascii?Q?P4BgsXmwNxBYKRWjkTWI8iSuynO5u91FmO8u1Z10p2txceITfOP71grZT5DC?=
 =?us-ascii?Q?fZ8V6ZcHA+KQqaDkrifgBllpqNq2NyILRy/8R6TUIap5z0GIvM6fUZhZlF7d?=
 =?us-ascii?Q?yXHVDcVDugtTKlXpH8ZQ4rVf3mzR7O6HAA4d3YNkTiwzC+mzWHwFW5CYepgB?=
 =?us-ascii?Q?Fyndah3G+4yxo4J6Q8eoG38Vb3/lc1/7hAcOFQFUfUnU4wmwctxndvFuL7P7?=
 =?us-ascii?Q?WyOtib+2xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f52a0bc-ae9c-4d1e-6285-08de6be3132a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 16:06:55.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zIQlM46H7CRvU1oeQo++DEamYQaHDg8TdnNP+qFXJutnrotiJV9jMfHp8r2kCSxP7A9VEhAwdV9S3LkM1pH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77215-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,groves.net:email,iweiny-mobl.notmuch:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 953CE13C687
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

I thought this driver did not support mmap?

> - fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
>   tested yet. I'm looking for suggestions as to how to test those.
> - dax-private.h: add dev_dax->cached_size, which fsdev needs to
>   remember. The dev_dax size cannot change while a driver is bound
>   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
>   at probe time allows fsdev's direct_access path can use it without
>   acquiring dax_dev_rwsem (which isn't exported anyway).
> 

None of the above explains exactly why this code is needed.  Rather it
just explains what it does.

I'm not 100% clear on why this is needed in the driver and why this is not
a layering violation which is going to bite us later?

Ira

> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/dax-private.h |  1 +
>  drivers/dax/fsdev.c       | 85 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 4ae4d829d3ee..092f4ae024ea 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -83,6 +83,7 @@ struct dev_dax {
>  	struct dax_region *region;
>  	struct dax_device *dax_dev;
>  	void *virt_addr;
> +	u64 cached_size;
>  	unsigned int align;
>  	int target_node;
>  	bool dyn_id;
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 72f78f606e06..5d17ad39227f 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -28,6 +28,86 @@
>   * - No mmap support - all access is through fs-dax/iomap
>   */
>  
> +static void fsdev_write_dax(void *pmem_addr, struct page *page,
> +		unsigned int off, unsigned int len)
> +{
> +	while (len) {
> +		void *mem = kmap_local_page(page);
> +		unsigned int chunk = min_t(unsigned int, len, PAGE_SIZE - off);
> +
> +		memcpy_flushcache(pmem_addr, mem + off, chunk);
> +		kunmap_local(mem);
> +		len -= chunk;
> +		off = 0;
> +		page++;
> +		pmem_addr += chunk;
> +	}
> +}
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
> +
> +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> +	if (phys == -1) {
> +		dev_dbg(&dev_dax->dev,
> +			"pgoff (%#lx) out of range\n", pgoff);
> +		return -ERANGE;
> +	}
> +
> +	if (kaddr)
> +		*kaddr = virt_addr;
> +
> +	local_pfn = PHYS_PFN(phys);
> +	if (pfn)
> +		*pfn = local_pfn;
> +
> +	/*
> +	 * Use cached_size which was computed at probe time. The size cannot
> +	 * change while the driver is bound (resize returns -EBUSY).
> +	 */
> +	return PHYS_PFN(min(size, dev_dax->cached_size - offset));
> +}
> +
> +static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
> +			pgoff_t pgoff, size_t nr_pages)
> +{
> +	void *kaddr;
> +
> +	WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
> +	__fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
> +	fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
> +	return 0;
> +}
> +
> +static long fsdev_dax_direct_access(struct dax_device *dax_dev,
> +		  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
> +		  void **kaddr, unsigned long *pfn)
> +{
> +	return __fsdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,
> +					 kaddr, pfn);
> +}
> +
> +static size_t fsdev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
> +		void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	return _copy_from_iter_flushcache(addr, bytes, i);
> +}
> +
> +static const struct dax_operations dev_dax_ops = {
> +	.direct_access = fsdev_dax_direct_access,
> +	.zero_page_range = fsdev_dax_zero_page_range,
> +	.recovery_write = fsdev_dax_recovery_write,
> +};
>  
>  static void fsdev_cdev_del(void *cdev)
>  {
> @@ -163,6 +243,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		}
>  	}
>  
> +	/* Cache size now; it cannot change while driver is bound */
> +	dev_dax->cached_size = 0;
> +	for (i = 0; i < dev_dax->nr_range; i++)
> +		dev_dax->cached_size += range_len(&dev_dax->ranges[i].range);
> +
>  	/*
>  	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
>  	 * do NOT set vmemmap_shift. This leaves folios at order-0,
> -- 
> 2.52.0
> 
> 
> 

