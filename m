Return-Path: <linux-fsdevel+bounces-14257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5AF87A09E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 02:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703821C2341E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 01:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64296947A;
	Wed, 13 Mar 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXSeyFif"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD878F4E;
	Wed, 13 Mar 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292789; cv=fail; b=mOmUUt9cniNyDb4+c+AlvqaKMJLzE1LJKums32OsJyKYqBQ5Qb5xKFwHbU7Y7rxB2IKpZDwNmF7cBCchiSbmxLCtBZSSmWLSvX8e53G6Uby4u3hBjDFgfNIkPjnJZhclO9TaH0ActR6MlOoeae4oxC3lV4NtBmXUyJAysNOV3g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292789; c=relaxed/simple;
	bh=gvsLUWAW3itp/hoyuT5PKQEan965Fm/YNyVi0vdqIRk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=azW8hDkH9mfNZ5VPc/MQKJTyM7EFcxAarc2nFL+bIxREP6V+z8Gm8iPWAfNyMPgAzxoLAqhLS7KdG8GYC9n5w+m68W4ceL57zB6/sKj0nrETXmDnpiJ80chlj54TFgvbm5LPhPKrD1YD7h/B9tQQBGlanumQX4bMQqBvBxbGJyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXSeyFif; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710292787; x=1741828787;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=gvsLUWAW3itp/hoyuT5PKQEan965Fm/YNyVi0vdqIRk=;
  b=jXSeyFifxhvslweXaqdYNWvuBnIQdOzOu43Ba0/GCJ5jWI5BrkgyXisv
   uWNw/OLQCQGP0J06mxfFj97ysSZ6O5ZPtad6lkNhOlZJoVHoVwoFlHgGO
   h6NHTBixANn4vG6FWl+BwfZuIqQM7Q15fMfJLPgrQ8L9AR6ZU6TAGqpVo
   RHQ1sBX9WhlJpyqYNMXsJuIM24goRnOENc7cKngkSaImygqKxgqyJjjSE
   QOrfgLRv8ZBl+v7lF8qlx410psDQaP9aPEJGK8G0JTrSaC6bMu0o2US7f
   cyIuZxhOzpW3zg/mSt2lv3+qKR6UtPAeYbuHBDapxwaw4mgdURSHma61A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22489447"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22489447"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16223537"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 18:19:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 18:19:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 18:19:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 18:19:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 18:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO596hlFVlZX+EaWNP0VXRy+J2xy0+Oqe1AwvGH+AuPTaBJuLqgCUDVUaU8r5dLhmy+6C+xVAFvUaZ1vGBfAnKP2xhp7nCDBzDxrBXd0e23dMgWux5oujrxqhm6aoP6ncYZ+ASWdbf6KcODOx6KunRKeAQW5+QcHYhyjjtEiR/u56f1m3mxWPgAIiYmQ/sZs2N+HGTMqnWva6cZjX4T+3xrlCaknKwRQ5tBMZFlzVxl/kFv73sN+DrsKz+GsmVAuYA3SATw3L4jpScIk98xhO1xAM1f42dPCaDjKczgSX/4RPeXIG9kuc8i4dntcpbZ6IN4xN8zqYUkJJvpv7AQ3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP1a0SCCPLmgTqfdtnhxKL3xSOXv3tUis8awKiA1En0=;
 b=Zn7HS8jXmXXh/AWFF/JUJvikDCCQJOQpylHsijuD6a4q7rVCpY8y1yPzpUkDJ2iJJAaut9nOY92h101fp8AzmtK0BYvLMsg6rneeH9OJ9qJa/qfES2XJk8jc50PK/5wnWVQdP0b8WYVDpaK0qdMoZpa9iPOa1RDJzBpJnhsZx7TMjJ94wTC8S84Y+RPSBXdcEg9llIVp1Az8K/obJ2QmILyDDyzpYbLn7tZKD6/v0wcI97AeMtPpoPNaQiL290PmIhSphTdVognADNHO6z+cZkYAYwMzXPkqCOfYyNfr2kMDuHqMzFw43JHdWVPsHnenFHsI4HdAGV73MErTfmb5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8726.namprd11.prod.outlook.com (2603:10b6:408:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Wed, 13 Mar
 2024 01:19:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 01:19:40 +0000
Date: Wed, 13 Mar 2024 09:19:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:cifs-netfs] [cifs]  7de1bab771:
 filebench.sum_operations/s -98.5% regression
Message-ID: <202403121627.d0fcb53c-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7616a946-ebd9-40cc-1bcd-08dc42fba7d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oTgG6YA2GuLSPZ74VrWf7oLJEjVowKohnAID3aFZqkmbVY0Y8iTrqRxluIdZQ9kYac1+UljDADcGkY3EVznz4me9su7idS8gkGFrIJuOzwB1iYef+USzpzRXQRlZ+OLD+Dz86nf8NABn6edoXeBPerQ0FFoiPBSUzwm5Ns8hIMw0x1EiMXqb/0YtUOVMMqc9x916C3Wp4YE8NSS5EkaL6bYs11IDiSdT2vqg5j2Oi5y8nh4GZihv4dnkqWUxU6jHsUyUT+m2fyVjIFIJau5SaUeB1qvKg8Sqa0OqZTS95hpc//eC8ML5DvCbdeXDtnHQNtd76u9lnmG8GqHE6jtA7FEpPqeCkcvi1tyNiC+Rb+bhPVXzQ7BGsQ+bD1+WVOqwLYnL1cpehqzYArAUh2QmZw8nnqyCdm8V6y/GVDJY2yqP/wHGFPUUvQAa/ESoqJ+pq0fNMjx5uCfqAbkdmTYyQfrmkPW+oirGL3XD2w6KbIyGK4KMXUpJXhg+YrQEJvtjclR1fMTaK4fCVR9QEGpnlE3tEQ58qfTIkLjOigIBbldz5xgoTxkPmtkYcL6Eh25KX76SieUODumtupsk2xLqqVDBJ1cQrB6mtUvVa7vcnpIIiTM/nBcH8+y7dLsz2bj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DMbTv6FaN2RUbEUT0LEYEIyOI6IBFST419y+SGW9jFEhx8UM8UN69cKXnI?=
 =?iso-8859-1?Q?AxSIkHMh2GiUPMlUbTRglACzHdqLDQjz45VeBDHaYPK+4e0pabTSMyzQlS?=
 =?iso-8859-1?Q?orGckENJfw2DNeSGLYmSQ+Or3pjcJ+b5anzGDyYQmabTgLx/HwEcPeO886?=
 =?iso-8859-1?Q?rfy3GOADydHttl+y1QywekjlzfrJ/hIx0umVhGFGf9wONyGNADzXMoFr5T?=
 =?iso-8859-1?Q?aCqVTHQm1hzDcQrfESUylew7rrqp8lW8ZjR0nwzXGecpJGK5ldnLIYJh8l?=
 =?iso-8859-1?Q?NBnxOb8O1YJJxjlMetBJ+Nud0hKcUNu8s2sScUGUz65N68Y2nH9OhAnq1y?=
 =?iso-8859-1?Q?uOdG9bP7YcmEQclS3ewUZQPg2YOpIaVdVBxa31w4YvDOy/isd0/Zz5kkIa?=
 =?iso-8859-1?Q?qAmyKs9seFdiKBSZz/GsvCuCmJpzrqG4h2KfYQa9K4JLvlwgThJldiDgfr?=
 =?iso-8859-1?Q?XwHRXGtFW2PuiCJchdNCSl4xTfqeoQUqhXjzOgs8iW3bb94Ep57Iq/qoyx?=
 =?iso-8859-1?Q?JFtRPA950CnLJBQM8Xl//UnpnTDoyR3tr7QPHBthWCxsX6N5Zm1zU7fqRk?=
 =?iso-8859-1?Q?WSMKpTnKfVgsBU7thwHx0IyOaVYbUcwNkvjhmLEf9G7B+W8SedeuX2sOBB?=
 =?iso-8859-1?Q?dxWEOnx6+f/KAduxgEcv0a3ND9oF/YkXQF6Vt3uZCqcWT9Bxm1lCd7q9ji?=
 =?iso-8859-1?Q?nwDaNOLxdB4QsUp8ehHuIwXJXQDbZjD2M3VjFk0mKs83WPh6mhxJPUgYCe?=
 =?iso-8859-1?Q?zBLNk/KNNpUaRJEPoJRTBlcSBWsQKpG72otEXYShjg/+SUxAWJnJH8+S3Z?=
 =?iso-8859-1?Q?DP2DO2vBjkvlhRtg8Aer01pstDcY8AQp5kqgxWIiMTjznoAT9yNLngx4AL?=
 =?iso-8859-1?Q?557HeUEI19x5DGh+m7P5xSgpp3qubKak8zKjgaDHPgkWTF4GxTrLX+QuE6?=
 =?iso-8859-1?Q?zB4V3MqugBLdQ1Z9wSy0hLSBPQpdQktTjirKvUMGJJMa0/KiusZ/T3dS66?=
 =?iso-8859-1?Q?XxjPt998u0XghrpG2JkXipUJZvbBwmkdRTNnOcZHA6Ds9gjskTK5XCU9TX?=
 =?iso-8859-1?Q?rJ3zdW3Nv5cnZ5OC0hVEQIZZI/HF+w3KJa1hS1ROlLfhyhDTQKQqkQYfJI?=
 =?iso-8859-1?Q?4DZS7lOXyY4xvI9st04pI7oZ4jjr6gJBJ0aBWE4ihAq7rL4H6I1Q7d1m2G?=
 =?iso-8859-1?Q?Y4NWxskcEHOvM3NfhD2xA3kqto3/GtFpa0b9upFbkk9QNuyylxbC3aXsLa?=
 =?iso-8859-1?Q?yL1NHueVp9zeq4oS483lMjVaROAG9MkWBvOlLwmEgDQjVaLlAA8OW54OIR?=
 =?iso-8859-1?Q?Fi139G7W5HfwB3KPdpQTX2VJVCrc7tG9PJeePxQ+XihsaXJanAixPfaLqR?=
 =?iso-8859-1?Q?cJCDKVpbpIqsrxN+rIziXobSK/9z7Z+F0zkx9/1+roi0w/Da7uBYNDZ8b+?=
 =?iso-8859-1?Q?868yiTO7r1ZXsOw66I9XBc+2klSSo0kXUV3cMwsqg6RYVZaexfH7xRpk70?=
 =?iso-8859-1?Q?3lrWCJpnLAps4CGpPMqUyz4CWvG5N4pn5oMoQceLqzaZ33ZmB4dC9+t5Lu?=
 =?iso-8859-1?Q?+oX/dB7EIBpg+sZ5yGedT6NWA41/kt+pj8NPLWGsYItSefzc5qCvg/p2f3?=
 =?iso-8859-1?Q?Gj1aaVtZmiKRW4KzfJHRyetvWKmdZZ2Bx9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616a946-ebd9-40cc-1bcd-08dc42fba7d0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 01:19:40.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O9f7HS2mATKw66ck2V17rOhVegKW5Kqd72Cun3GOEoHt7C8A8VYMl7CEaZ8nWoSUGZsEM/jtpIS4RO7CTR7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8726
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -98.5% regression of filebench.sum_operations/s on:


commit: 7de1bab7712daba2c9bb28e60a3e14aa980c7e7b ("cifs: Cut over to using netfslib")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git cifs-netfs

testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: cifs
	test: randomwrite.f
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 48.8% improvement                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=btrfs                                                                                       |
|                  | test=webserver.f                                                                               |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 44.1% improvement                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=ext4                                                                                        |
|                  | test=webserver.f                                                                               |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403121627.d0fcb53c-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240312/202403121627.d0fcb53c-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomwrite.f/filebench

commit: 
  07c30df0ea ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
  7de1bab771 ("cifs: Cut over to using netfslib")

07c30df0ea2d1015 7de1bab7712daba2c9bb28e60a3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.04 ± 19%     -81.3%       0.19 ±  6%  iostat.cpu.system
    430.83 ± 69%     -91.3%      37.50 ± 24%  perf-c2c.DRAM.local
     68395           -39.6%      41301 ±  4%  vmstat.io.bo
      2.62 ± 15%     -42.7%       1.50        vmstat.procs.r
      7534 ± 17%     -43.1%       4283 ±  2%  vmstat.system.in
      0.60 ±  2%      -0.1        0.51 ±  8%  mpstat.cpu.all.iowait%
      0.02 ±  9%      -0.0        0.01 ±  2%  mpstat.cpu.all.irq%
      1.00 ± 20%      -0.9        0.15 ±  7%  mpstat.cpu.all.sys%
      0.16 ± 12%      -0.0        0.12 ±  3%  mpstat.cpu.all.usr%
     24.67 ±122%     -95.9%       1.00        mpstat.max_utilization.seconds
     27.96 ± 34%     -86.8%       3.69 ±  2%  mpstat.max_utilization_pct
    174.67 ±111%   +2482.8%       4511 ± 67%  numa-meminfo.node0.Active(file)
   1495509 ± 86%     -90.5%     142740 ± 62%  numa-meminfo.node0.Unevictable
     35197 ± 18%    +225.3%     114511 ± 30%  numa-meminfo.node1.Active
     30636 ± 15%    +266.4%     112258 ± 29%  numa-meminfo.node1.Active(anon)
     44036 ± 19%    +190.7%     128025 ± 25%  numa-meminfo.node1.Shmem
     17358 ± 46%     -87.4%       2179 ±100%  numa-meminfo.node1.Writeback
     43.68 ±111%   +2481.9%       1127 ± 67%  numa-vmstat.node0.nr_active_file
    373877 ± 86%     -90.5%      35685 ± 62%  numa-vmstat.node0.nr_unevictable
     43.68 ±111%   +2481.9%       1127 ± 67%  numa-vmstat.node0.nr_zone_active_file
    373877 ± 86%     -90.5%      35685 ± 62%  numa-vmstat.node0.nr_zone_unevictable
      7651 ± 15%    +266.6%      28049 ± 29%  numa-vmstat.node1.nr_active_anon
     11013 ± 19%    +190.6%      31999 ± 25%  numa-vmstat.node1.nr_shmem
      4336 ± 47%     -87.3%     551.12 ± 99%  numa-vmstat.node1.nr_writeback
      7651 ± 15%    +266.6%      28049 ± 29%  numa-vmstat.node1.nr_zone_active_anon
      3418 ± 10%     -98.5%      50.50 ± 24%  filebench.sum_bytes_mb/s
  26253076 ± 10%     -98.5%     387836 ± 24%  filebench.sum_operations
    437515 ± 10%     -98.5%       6463 ± 24%  filebench.sum_operations/s
      0.00         +7983.3%       0.16 ± 18%  filebench.sum_time_ms/op
    437515 ± 10%     -98.5%       6463 ± 24%  filebench.sum_writes/s
  39585326 ± 27%    -100.0%       0.00        filebench.time.file_system_outputs
     37.50           -88.9%       4.17 ±  8%  filebench.time.percent_of_cpu_this_job_got
     58.72           -86.8%       7.77 ±  6%  filebench.time.system_time
     10653 ± 96%   +3590.6%     393176 ± 24%  filebench.time.voluntary_context_switches
     47767 ± 26%    +156.3%     122446 ± 28%  meminfo.Active
     43032 ± 28%    +168.8%     115681 ± 29%  meminfo.Active(anon)
   1833358 ± 32%     -64.6%     649107        meminfo.AnonPages
   2151765 ± 27%     -56.5%     935272 ±  4%  meminfo.Committed_AS
   3605993 ±  2%     -66.4%    1212560 ±  8%  meminfo.Dirty
  12072709 ±  4%     -10.6%   10797094        meminfo.Inactive
   1854435 ± 31%     -63.7%     672329        meminfo.Inactive(anon)
  17104577 ±  3%      -8.5%   15642806        meminfo.Memused
      8408 ± 13%     -29.7%       5912        meminfo.PageTables
     67445 ± 18%    +111.1%     142366 ± 24%  meminfo.Shmem
     29689 ± 14%     -85.5%       4300 ±  3%  meminfo.Writeback
  18869056 ±  5%     -12.8%   16462889        meminfo.max_used_kB
     24296 ± 33%     -82.7%       4197 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
    148735 ± 16%     -70.7%      43646 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.max
      1492 ± 79%     -92.3%     115.56 ± 35%  sched_debug.cfs_rq:/.avg_vruntime.min
     17979 ± 16%     -60.5%       7099 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.25 ± 13%     -18.8%       0.20 ±  9%  sched_debug.cfs_rq:/.h_nr_running.stddev
     24296 ± 33%     -82.7%       4197 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
    148735 ± 16%     -70.7%      43646 ± 23%  sched_debug.cfs_rq:/.min_vruntime.max
      1492 ± 79%     -92.3%     115.56 ± 35%  sched_debug.cfs_rq:/.min_vruntime.min
     17979 ± 16%     -60.5%       7099 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.25 ± 13%     -18.8%       0.20 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
      1148 ± 15%     -33.0%     769.39 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
    204.69 ± 14%     -22.1%     159.41 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1147 ± 16%     -33.1%     768.11 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    204.09 ± 14%     -22.1%     159.01 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    826.86 ± 24%     -56.4%     360.33 ± 30%  sched_debug.cfs_rq:/.util_est.max
     85191 ± 15%     +23.3%     105013        sched_debug.cpu.clock.avg
     85198 ± 15%     +23.3%     105023        sched_debug.cpu.clock.max
     85181 ± 15%     +23.3%     105001        sched_debug.cpu.clock.min
     85045 ± 15%     +23.3%     104859        sched_debug.cpu.clock_task.avg
     85178 ± 15%     +23.3%     105007        sched_debug.cpu.clock_task.max
     76544 ± 17%     +25.8%      96320        sched_debug.cpu.clock_task.min
    903.06 ± 13%     -15.9%     759.49 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.24 ± 13%     -21.2%       0.19 ±  8%  sched_debug.cpu.nr_running.stddev
     77425 ± 58%    +431.5%     411538 ± 17%  sched_debug.cpu.nr_switches.max
     10746 ± 56%    +513.9%      65970 ± 23%  sched_debug.cpu.nr_switches.stddev
     85188 ± 15%     +23.3%     105013        sched_debug.cpu_clk
     84462 ± 16%     +23.5%     104289        sched_debug.ktime
     85991 ± 15%     +23.1%     105816        sched_debug.sched_clk
      6.48 ±  7%     -74.7%       1.64 ±  6%  perf-stat.i.MPKI
  5.56e+08 ± 11%     -56.1%   2.44e+08 ±  6%  perf-stat.i.branch-instructions
      2.40 ±  4%      +2.1        4.48 ±  3%  perf-stat.i.branch-miss-rate%
     14.11 ±  6%     -10.7        3.43 ±  7%  perf-stat.i.cache-miss-rate%
  21634671 ±  8%     -90.0%    2172138 ±  9%  perf-stat.i.cache-misses
  85867464 ± 16%     -53.8%   39707095        perf-stat.i.cache-references
      1.57 ±  3%     +16.6%       1.83 ±  3%  perf-stat.i.cpi
 5.198e+09 ± 18%     -72.1%  1.448e+09 ±  6%  perf-stat.i.cpu-cycles
    516.23 ± 44%     -71.7%     145.95        perf-stat.i.cpu-migrations
    847.27 ±  7%     +58.2%       1340 ±  7%  perf-stat.i.cycles-between-cache-misses
 2.703e+09 ± 11%     -55.6%  1.199e+09 ±  6%  perf-stat.i.instructions
      0.68 ±  3%     -10.2%       0.61 ±  2%  perf-stat.i.ipc
      4895 ± 12%     -41.8%       2846 ±  2%  perf-stat.i.minor-faults
      4895 ± 12%     -41.8%       2846 ±  2%  perf-stat.i.page-faults
      8.09 ± 12%     -77.6%       1.81 ±  6%  perf-stat.overall.MPKI
      2.11 ± 13%      +2.6        4.73 ±  5%  perf-stat.overall.branch-miss-rate%
     25.58 ± 10%     -20.1        5.47 ± 10%  perf-stat.overall.cache-miss-rate%
      1.91 ±  8%     -36.7%       1.21        perf-stat.overall.cpi
    240.67 ± 16%    +178.4%     669.98 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.53 ±  8%     +56.9%       0.83        perf-stat.overall.ipc
  5.54e+08 ± 11%     -56.2%  2.424e+08 ±  6%  perf-stat.ps.branch-instructions
  21541705 ±  8%     -90.0%    2157950 ±  9%  perf-stat.ps.cache-misses
  85532248 ± 16%     -53.9%   39455105        perf-stat.ps.cache-references
 5.186e+09 ± 18%     -72.3%  1.438e+09 ±  6%  perf-stat.ps.cpu-cycles
    514.81 ± 44%     -71.8%     145.04        perf-stat.ps.cpu-migrations
 2.693e+09 ± 11%     -55.8%  1.191e+09 ±  6%  perf-stat.ps.instructions
      4868 ± 12%     -42.0%       2822 ±  2%  perf-stat.ps.minor-faults
      4868 ± 12%     -42.0%       2822 ±  2%  perf-stat.ps.page-faults
 4.534e+11 ± 11%     -55.4%  2.024e+11 ±  6%  perf-stat.total.instructions
     10757 ± 28%    +168.7%      28907 ± 29%  proc-vmstat.nr_active_anon
    458373 ± 32%     -64.6%     162278        proc-vmstat.nr_anon_pages
   7749500 ± 18%     -78.7%    1654426 ±  4%  proc-vmstat.nr_dirtied
    901514 ±  2%     -66.3%     303406 ±  7%  proc-vmstat.nr_dirty
   3099419            +1.1%    3133625        proc-vmstat.nr_dirty_background_threshold
   6206417            +1.1%    6274912        proc-vmstat.nr_dirty_threshold
  28637974            +1.3%   29001607        proc-vmstat.nr_free_pages
    463650 ± 31%     -63.7%     168112        proc-vmstat.nr_inactive_anon
     15966            +2.4%      16345        proc-vmstat.nr_mapped
      2101 ± 13%     -29.7%       1476 ±  2%  proc-vmstat.nr_page_table_pages
     16869 ± 18%    +111.1%      35606 ± 24%  proc-vmstat.nr_shmem
     77448            -4.7%      73774        proc-vmstat.nr_slab_unreclaimable
      7568 ± 14%     -85.5%       1095 ±  4%  proc-vmstat.nr_writeback
   7749498 ± 18%     -51.7%    3740811 ±  7%  proc-vmstat.nr_written
     10757 ± 28%    +168.7%      28907 ± 29%  proc-vmstat.nr_zone_active_anon
    463650 ± 31%     -63.7%     168112        proc-vmstat.nr_zone_inactive_anon
    909082 ±  2%     -66.5%     304501 ±  7%  proc-vmstat.nr_zone_write_pending
    104544 ± 41%     -98.5%       1561 ± 21%  proc-vmstat.numa_hint_faults
     55028 ± 29%     -97.9%       1165 ± 34%  proc-vmstat.numa_hint_faults_local
   4677705 ± 11%     -21.6%    3668064 ±  2%  proc-vmstat.numa_hit
   4545169 ± 11%     -22.2%    3535530 ±  2%  proc-vmstat.numa_local
     87053 ± 55%     -98.8%       1076 ±100%  proc-vmstat.numa_pages_migrated
    490840 ± 45%     -99.0%       5074 ± 18%  proc-vmstat.numa_pte_updates
     10895 ± 19%    +227.4%      35674 ± 30%  proc-vmstat.pgactivate
   9467873 ± 12%     -40.9%    5597296 ±  3%  proc-vmstat.pgalloc_normal
    932934 ± 11%     -35.1%     605588        proc-vmstat.pgfault
   8979409 ± 11%     -39.5%    5432326 ±  6%  proc-vmstat.pgfree
     87053 ± 55%     -98.8%       1076 ±100%  proc-vmstat.pgmigrate_success
  11668504           -39.0%    7121510 ±  4%  proc-vmstat.pgpgout
     45770 ± 16%     -35.7%      29410        proc-vmstat.pgreuse
      6.67 ± 20%      -4.4        2.26 ± 34%  perf-profile.calltrace.cycles-pp.ext4_finish_bio.ext4_end_bio.blk_update_request.scsi_end_request.scsi_io_completion
      6.74 ± 21%      -4.3        2.41 ± 34%  perf-profile.calltrace.cycles-pp.ext4_end_bio.blk_update_request.scsi_end_request.scsi_io_completion.blk_complete_reqs
     10.76 ± 14%      -4.1        6.63 ± 44%  perf-profile.calltrace.cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
     10.76 ± 14%      -4.1        6.63 ± 44%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_thread
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn
     10.74 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
     10.74 ± 14%      -4.1        6.62 ± 44%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      6.83 ± 21%      -3.7        3.14 ± 35%  perf-profile.calltrace.cycles-pp.blk_update_request.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq
      9.14 ± 13%      -3.6        5.50 ± 47%  perf-profile.calltrace.cycles-pp.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages
      4.05 ±103%      -3.4        0.64 ±223%  perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq.do_softirq
      4.05 ±103%      -3.4        0.64 ±223%  perf-profile.calltrace.cycles-pp.scsi_io_completion.blk_complete_reqs.__do_softirq.do_softirq.flush_smp_call_function_queue
      4.13 ±103%      -3.3        0.86 ±223%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      4.11 ±103%      -3.3        0.84 ±223%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.10 ±103%      -3.2        0.84 ±223%  perf-profile.calltrace.cycles-pp.blk_complete_reqs.__do_softirq.do_softirq.flush_smp_call_function_queue.do_idle
      4.42 ± 18%      -2.9        1.55 ± 48%  perf-profile.calltrace.cycles-pp.folio_end_writeback.ext4_finish_bio.ext4_end_bio.blk_update_request.scsi_end_request
      3.85 ± 17%      -2.4        1.50 ± 48%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.ext4_finish_bio.ext4_end_bio.blk_update_request
      2.92 ± 14%      -2.3        0.59 ± 74%  perf-profile.calltrace.cycles-pp.__folio_start_writeback.ext4_bio_write_folio.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map
      8.68 ±  8%      -1.6        7.13 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.02 ±  7%      -1.4        6.61 ± 12%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.64 ± 20%      -1.2        0.48 ± 73%  perf-profile.calltrace.cycles-pp.folio_clear_dirty_for_io.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages
      3.92 ± 10%      -0.8        3.15 ± 14%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.88 ± 17%      -0.7        1.19 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      2.07 ± 16%      -0.7        1.40 ± 22%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      3.05 ± 10%      -0.6        2.40 ± 11%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      2.66 ± 12%      -0.6        2.02 ± 12%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      2.66 ± 12%      -0.6        2.02 ± 12%  perf-profile.calltrace.cycles-pp.newidle_balance.balance_fair.__schedule.schedule.smpboot_thread_fn
      3.05 ± 10%      -0.6        2.42 ± 11%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.68 ± 11%      -0.5        1.14 ± 24%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64
      1.57 ± 12%      -0.5        1.04 ± 19%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.58 ± 12%      -0.5        1.05 ± 22%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.18 ± 15%      -0.5        1.70 ± 14%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.balance_fair
      2.19 ± 15%      -0.5        1.72 ± 13%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.balance_fair.__schedule
      0.95 ± 14%      -0.4        0.50 ± 73%  perf-profile.calltrace.cycles-pp.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.82 ± 18%      -0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ± 13%      -0.3        0.66 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.97 ± 14%      -0.3        0.66 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.95 ± 13%      -0.3        0.66 ±  9%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.95 ± 13%      -0.3        0.66 ±  9%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.95 ± 19%      +0.6        2.58 ± 10%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.9        0.85 ± 25%  perf-profile.calltrace.cycles-pp.ata_qc_complete_multiple.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu
      0.00            +1.4        1.39 ± 29%  perf-profile.calltrace.cycles-pp.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event
      2.18 ± 19%      +1.6        3.82 ± 12%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.40 ± 72%      +2.1        2.50 ± 22%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +2.1        2.12 ± 47%  perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.40 ± 72%      +2.1        2.54 ± 22%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.00            +2.2        2.16 ± 46%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn
      0.42 ± 73%      +2.3        2.72 ± 23%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.10 ±223%      +2.4        2.45 ± 38%  perf-profile.calltrace.cycles-pp.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.44 ± 72%      +2.5        2.93 ± 23%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.worker_thread
      0.44 ± 72%      +2.5        2.95 ± 23%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.worker_thread.kthread
      0.54 ± 71%      +2.5        3.08 ± 23%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.54 ± 71%      +2.5        3.08 ± 23%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.7        2.66 ± 48%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work
      0.00            +2.7        2.70 ± 47%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread
      0.00            +2.7        2.70 ± 47%  perf-profile.calltrace.cycles-pp.blk_mq_run_work_fn.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +2.7        2.70 ± 47%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread.kthread
      0.11 ±223%      +3.0        3.13 ± 39%  perf-profile.calltrace.cycles-pp.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
     14.06 ±  7%      +3.1       17.18 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.13 ±223%      +3.1        3.25 ± 39%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      0.13 ±223%      +3.3        3.43 ± 39%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.15 ±223%      +3.6        3.75 ± 38%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.16 ±223%      +3.6        3.78 ± 38%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
     42.21 ±  3%      +6.4       48.66 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     39.53 ±  4%      +7.1       46.60 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     39.52 ±  4%      +7.1       46.60 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.45 ±  4%      +7.1       46.55 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.08 ± 13%      +7.8       36.86 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     27.76 ± 14%      +8.8       36.52 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     31.05 ± 13%     +10.0       41.04 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.81 ± 21%      -4.5        2.29 ± 34%  perf-profile.children.cycles-pp.ext4_finish_bio
      6.81 ± 21%      -4.4        2.44 ± 34%  perf-profile.children.cycles-pp.ext4_end_bio
     10.76 ± 14%      -4.1        6.63 ± 44%  perf-profile.children.cycles-pp.wb_do_writeback
     10.76 ± 14%      -4.1        6.63 ± 44%  perf-profile.children.cycles-pp.wb_workfn
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.__writeback_inodes_wb
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.__writeback_single_inode
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.do_writepages
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.wb_writeback
     10.75 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.writeback_sb_inodes
     10.74 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.ext4_do_writepages
     10.74 ± 14%      -4.1        6.62 ± 44%  perf-profile.children.cycles-pp.ext4_writepages
     10.60 ± 14%      -4.0        6.62 ± 44%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      6.92 ± 21%      -3.7        3.19 ± 35%  perf-profile.children.cycles-pp.blk_update_request
      9.16 ± 13%      -3.6        5.51 ± 47%  perf-profile.children.cycles-pp.mpage_process_page_bufs
      4.13 ±103%      -3.3        0.86 ±223%  perf-profile.children.cycles-pp.do_softirq
      4.52 ± 18%      -2.9        1.66 ± 38%  perf-profile.children.cycles-pp.folio_end_writeback
      7.20 ± 21%      -2.8        4.40 ± 32%  perf-profile.children.cycles-pp.scsi_end_request
      7.20 ± 21%      -2.8        4.41 ± 32%  perf-profile.children.cycles-pp.scsi_io_completion
     10.90 ± 14%      -2.5        8.38 ± 15%  perf-profile.children.cycles-pp.__do_softirq
      4.08 ± 19%      -2.5        1.60 ± 37%  perf-profile.children.cycles-pp.__folio_end_writeback
      3.12 ± 11%      -2.4        0.76 ± 41%  perf-profile.children.cycles-pp.__folio_start_writeback
      2.47 ± 22%      -1.6        0.85 ± 32%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      9.38 ±  4%      -1.3        8.03 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.25 ± 18%      -1.3        0.98 ± 41%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.76 ± 18%      -1.2        0.52 ± 60%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      1.68 ± 17%      -1.2        0.50 ± 23%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      4.76 ±  7%      -0.8        3.94 ± 11%  perf-profile.children.cycles-pp.__handle_mm_fault
      5.02 ±  7%      -0.8        4.19 ± 11%  perf-profile.children.cycles-pp.handle_mm_fault
      3.92 ± 10%      -0.8        3.15 ± 14%  perf-profile.children.cycles-pp.smpboot_thread_fn
      3.07 ±  8%      -0.7        2.41 ± 13%  perf-profile.children.cycles-pp.do_mmap
      3.13 ±  9%      -0.7        2.47 ± 13%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.67 ± 13%      -0.6        2.02 ± 12%  perf-profile.children.cycles-pp.balance_fair
      2.80 ±  8%      -0.6        2.20 ± 14%  perf-profile.children.cycles-pp.mmap_region
      1.72 ± 13%      -0.6        1.17 ± 13%  perf-profile.children.cycles-pp.copy_process
      2.34 ± 13%      -0.5        1.80 ± 10%  perf-profile.children.cycles-pp.kernel_clone
      1.71 ±  9%      -0.5        1.17 ± 21%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      1.08 ± 24%      -0.5        0.55 ± 29%  perf-profile.children.cycles-pp.xas_load
      0.79 ± 29%      -0.5        0.27 ± 55%  perf-profile.children.cycles-pp.__mod_lruvec_state
      1.33 ± 10%      -0.4        0.88 ± 20%  perf-profile.children.cycles-pp.elf_load
      0.63 ± 24%      -0.4        0.20 ± 47%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.46 ± 17%      -0.4        0.04 ±121%  perf-profile.children.cycles-pp.__fprop_add_percpu
      0.76 ± 15%      -0.4        0.37 ± 31%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.96 ± 23%      -0.4        0.60 ± 23%  perf-profile.children.cycles-pp.__split_vma
      0.56 ± 17%      -0.3        0.25 ± 15%  perf-profile.children.cycles-pp.xas_descend
      0.59 ± 21%      -0.3        0.29 ± 30%  perf-profile.children.cycles-pp.free_pgtables
      0.95 ± 13%      -0.3        0.66 ±  9%  perf-profile.children.cycles-pp.__do_sys_clone
      0.95 ± 14%      -0.3        0.67 ± 26%  perf-profile.children.cycles-pp.affine_move_task
      0.50 ± 32%      -0.2        0.25 ± 34%  perf-profile.children.cycles-pp.__run_timers
      0.36 ± 44%      -0.2        0.12 ± 90%  perf-profile.children.cycles-pp.bio_add_folio
      0.54 ± 19%      -0.2        0.30 ± 41%  perf-profile.children.cycles-pp.vmstat_start
      0.44 ± 15%      -0.2        0.24 ± 31%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.36 ± 22%      -0.2        0.16 ± 45%  perf-profile.children.cycles-pp.vma_prepare
      0.38 ± 32%      -0.2        0.21 ± 42%  perf-profile.children.cycles-pp.call_timer_fn
      0.22 ± 43%      -0.2        0.06 ± 83%  perf-profile.children.cycles-pp.folio_mapping
      0.20 ± 37%      -0.1        0.07 ± 82%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.20 ± 26%      -0.1        0.07 ± 83%  perf-profile.children.cycles-pp.affinity__set
      0.36 ± 13%      -0.1        0.24 ± 26%  perf-profile.children.cycles-pp.perf_mmap__push
      0.36 ± 13%      -0.1        0.24 ± 26%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.23 ± 26%      -0.1        0.13 ± 39%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.21 ± 25%      -0.1        0.11 ± 31%  perf-profile.children.cycles-pp.mas_split
      0.14 ± 54%      -0.1        0.05 ±111%  perf-profile.children.cycles-pp._exit
      0.22 ± 25%      -0.1        0.14 ± 51%  perf-profile.children.cycles-pp.folio_unlock
      0.19 ± 41%      -0.1        0.10 ± 33%  perf-profile.children.cycles-pp.inode_permission
      0.16 ± 32%      -0.1        0.08 ± 57%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.01 ±223%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.ata_scsi_qc_complete
      0.03 ±100%      +0.1        0.14 ± 43%  perf-profile.children.cycles-pp.blake2s_update
      0.06 ± 83%      +0.1        0.18 ± 41%  perf-profile.children.cycles-pp.menu_reflect
      0.04 ±115%      +0.2        0.19 ± 57%  perf-profile.children.cycles-pp.add_timer_randomness
      0.00            +0.2        0.16 ± 32%  perf-profile.children.cycles-pp.sd_done
      0.01 ±223%      +0.2        0.19 ± 69%  perf-profile.children.cycles-pp.scsi_handle_queue_ramp_up
      0.01 ±223%      +0.2        0.19 ± 58%  perf-profile.children.cycles-pp.blk_mq_sched_try_merge
      0.02 ±142%      +0.2        0.21 ± 62%  perf-profile.children.cycles-pp.scsi_decide_disposition
      0.05 ± 79%      +0.2        0.25 ± 47%  perf-profile.children.cycles-pp.sbitmap_get
      0.01 ±223%      +0.2        0.22 ± 57%  perf-profile.children.cycles-pp.dd_bio_merge
      0.09 ±123%      +0.2        0.32 ± 40%  perf-profile.children.cycles-pp.__blk_mq_end_request
      0.04 ±112%      +0.2        0.27 ± 33%  perf-profile.children.cycles-pp.__blk_mq_free_request
      0.07 ± 94%      +0.3        0.32 ± 22%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.04 ±120%      +0.3        0.30 ± 47%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.08 ± 73%      +0.3        0.34 ± 22%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.02 ±141%      +0.3        0.28 ± 64%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.03 ±152%      +0.3        0.36 ± 56%  perf-profile.children.cycles-pp.bio_free
      0.02 ±141%      +0.4        0.37 ± 25%  perf-profile.children.cycles-pp.scsi_finish_command
      0.05 ±129%      +0.4        0.46 ± 26%  perf-profile.children.cycles-pp.mempool_alloc
      0.02 ±141%      +0.5        0.54 ± 57%  perf-profile.children.cycles-pp.__ata_scsi_queuecmd
      0.06 ±143%      +0.5        0.59 ± 29%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.06 ± 83%      +0.6        0.62 ± 50%  perf-profile.children.cycles-pp.ahci_scr_read
      0.04 ±163%      +0.6        0.61 ± 55%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.06 ± 83%      +0.6        0.64 ± 51%  perf-profile.children.cycles-pp.ahci_handle_port_interrupt
      0.06 ± 83%      +0.6        0.64 ± 51%  perf-profile.children.cycles-pp.sata_async_notification
      0.03 ±152%      +0.6        0.64 ± 56%  perf-profile.children.cycles-pp.ata_scsi_queuecmd
      0.04 ±141%      +0.7        0.71 ± 54%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      2.06 ± 17%      +0.7        2.74 ± 11%  perf-profile.children.cycles-pp.menu_select
      0.06 ±143%      +0.7        0.77 ± 54%  perf-profile.children.cycles-pp.io_schedule
      0.13 ± 50%      +0.7        0.86 ± 26%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.06 ±143%      +0.8        0.90 ± 55%  perf-profile.children.cycles-pp.rq_qos_wait
      0.06 ±152%      +0.9        0.96 ± 53%  perf-profile.children.cycles-pp.wbt_wait
      0.06 ±152%      +0.9        0.96 ± 52%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.02 ±141%      +1.0        1.04 ± 43%  perf-profile.children.cycles-pp.scsi_prepare_cmd
      0.18 ± 55%      +1.3        1.43 ± 31%  perf-profile.children.cycles-pp.ahci_qc_complete
      3.72 ± 12%      +1.3        5.04 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      3.76 ± 12%      +1.3        5.10 ±  9%  perf-profile.children.cycles-pp.find_busiest_group
      3.28 ± 15%      +1.4        4.70 ± 10%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.44 ± 30%      +1.5        1.90 ± 49%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.45 ± 28%      +1.5        1.96 ± 49%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      4.27 ± 14%      +1.6        5.88 ±  6%  perf-profile.children.cycles-pp.load_balance
      3.65 ± 10%      +1.7        5.31 ± 12%  perf-profile.children.cycles-pp.newidle_balance
      4.50 ±  9%      +1.8        6.33 ±  8%  perf-profile.children.cycles-pp.schedule
      6.10 ±  6%      +1.9        7.95 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.15 ± 30%      +2.0        2.16 ± 45%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.16 ± 29%      +2.0        2.19 ± 44%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      1.32 ± 10%      +2.3        3.66 ± 20%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.28 ± 55%      +2.4        2.63 ± 38%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      0.22 ± 33%      +2.5        2.68 ± 46%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.25 ± 21%      +2.5        2.72 ± 46%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.24 ± 20%      +2.5        2.72 ± 46%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.06 ± 84%      +2.6        2.70 ± 47%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
      0.35 ± 46%      +3.0        3.36 ± 39%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      0.38 ± 53%      +3.1        3.50 ± 40%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.38 ± 50%      +3.3        3.70 ± 39%  perf-profile.children.cycles-pp.handle_irq_event
     14.14 ±  7%      +3.4       17.54 ±  9%  perf-profile.children.cycles-pp.intel_idle
      0.44 ± 51%      +3.6        4.02 ± 39%  perf-profile.children.cycles-pp.handle_edge_irq
      0.47 ± 51%      +3.6        4.06 ± 39%  perf-profile.children.cycles-pp.__common_interrupt
     42.21 ±  3%      +6.4       48.66 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     42.21 ±  3%      +6.4       48.66 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     42.14 ±  3%      +6.5       48.62 ±  6%  perf-profile.children.cycles-pp.do_idle
     39.53 ±  4%      +7.1       46.60 ±  6%  perf-profile.children.cycles-pp.start_secondary
     29.58 ± 13%      +8.0       37.58 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
     29.65 ± 13%      +8.1       37.72 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
     33.17 ± 11%      +9.3       42.48 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      2.40 ± 23%      -1.6        0.84 ± 30%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.53 ± 17%      -1.1        0.46 ± 20%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      1.83 ± 27%      -1.1        0.77 ± 68%  perf-profile.self.cycles-pp.mpage_process_page_bufs
      1.28 ±  9%      -0.8        0.46 ± 62%  perf-profile.self.cycles-pp.ext4_bio_write_folio
      0.96 ± 22%      -0.8        0.16 ± 51%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.93 ± 14%      -0.8        0.15 ± 54%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.70 ± 33%      -0.5        0.17 ± 89%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.83 ± 41%      -0.5        0.35 ± 42%  perf-profile.self.cycles-pp.ext4_finish_bio
      0.47 ± 23%      -0.4        0.06 ±117%  perf-profile.self.cycles-pp.folio_end_writeback
      0.58 ± 28%      -0.4        0.19 ± 40%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.46 ± 18%      -0.3        0.16 ± 54%  perf-profile.self.cycles-pp.mpage_prepare_extent_to_map
      0.46 ± 28%      -0.2        0.24 ± 17%  perf-profile.self.cycles-pp.xas_descend
      0.48 ± 18%      -0.2        0.31 ± 24%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.16 ± 43%      -0.1        0.04 ±108%  perf-profile.self.cycles-pp.folio_mapping
      0.12 ± 37%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.12 ± 66%      -0.1        0.03 ±106%  perf-profile.self.cycles-pp.__perf_event_read
      0.14 ± 20%      -0.1        0.07 ± 84%  perf-profile.self.cycles-pp.mas_next_slot
      0.01 ±223%      +0.1        0.09 ± 37%  perf-profile.self.cycles-pp.blk_mq_submit_bio
      0.00            +0.1        0.14 ± 43%  perf-profile.self.cycles-pp.sd_done
      0.00            +0.1        0.15 ± 69%  perf-profile.self.cycles-pp.common_interrupt
      0.12 ± 88%      +0.2        0.28 ± 59%  perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.01 ±223%      +0.2        0.19 ± 61%  perf-profile.self.cycles-pp.handle_edge_irq
      0.01 ±223%      +0.2        0.20 ± 29%  perf-profile.self.cycles-pp.blk_mq_complete_request_remote
      0.89 ± 14%      +0.2        1.14 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.04 ±141%      +0.5        0.55 ± 51%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      0.05 ±111%      +0.5        0.57 ± 46%  perf-profile.self.cycles-pp.ahci_qc_complete
      0.06 ± 83%      +0.6        0.62 ± 50%  perf-profile.self.cycles-pp.ahci_scr_read
      0.07 ± 63%      +0.7        0.73 ± 47%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      2.44 ± 18%      +1.0        3.40 ± 10%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.01 ±223%      +1.0        0.99 ± 44%  perf-profile.self.cycles-pp.scsi_prepare_cmd
     14.14 ±  7%      +3.4       17.54 ±  9%  perf-profile.self.cycles-pp.intel_idle


***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webserver.f/filebench

commit: 
  07c30df0ea ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
  7de1bab771 ("cifs: Cut over to using netfslib")

07c30df0ea2d1015 7de1bab7712daba2c9bb28e60a3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     18985           +29.1%      24514        uptime.idle
 1.519e+10           +36.2%  2.068e+10        cpuidle..time
   1187606           +26.7%    1505211        cpuidle..usage
     72.00           +35.8%      97.82        iostat.cpu.idle
     27.74           -93.0%       1.95        iostat.cpu.system
    455575 ± 10%     -31.3%     313021 ± 11%  numa-numastat.node1.local_node
    522056 ± 12%     -27.0%     381209 ±  2%  numa-numastat.node1.numa_hit
     85.33 ± 13%     -26.4%      62.83 ±  7%  perf-c2c.DRAM.local
    535.67 ±  5%     -31.5%     366.67 ±  3%  perf-c2c.DRAM.remote
    577.83 ±  6%     -57.1%     247.83 ± 12%  perf-c2c.HITM.local
    330.17 ±  7%     -32.8%     221.83 ±  4%  perf-c2c.HITM.remote
     72.05           +35.8%      97.86        vmstat.cpu.id
      2474           -56.1%       1087        vmstat.io.bo
     37.17           -89.9%       3.76 ±  3%  vmstat.procs.r
      9576 ±  2%     +43.9%      13783        vmstat.system.cs
     43467           -81.3%       8125 ±  3%  vmstat.system.in
     71.69           +26.1       97.81        mpstat.cpu.all.idle%
      0.12            -0.1        0.02        mpstat.cpu.all.irq%
      0.01            +0.0        0.02 ±  2%  mpstat.cpu.all.soft%
     27.93           -26.0        1.92        mpstat.cpu.all.sys%
      7.83 ± 15%     -34.0%       5.17 ± 17%  mpstat.max_utilization.seconds
     79.93           -90.1%       7.87 ±  6%  mpstat.max_utilization_pct
     25884 ± 27%     -77.6%       5791 ± 40%  numa-meminfo.node0.Dirty
    260128 ± 33%     -62.6%      97178 ± 20%  numa-meminfo.node0.Inactive(file)
    200613 ±  7%     -30.9%     138686 ±  9%  numa-meminfo.node1.Active
    188223 ±  6%     -45.3%     102990 ±  5%  numa-meminfo.node1.Active(anon)
     12389 ± 42%    +188.1%      35696 ± 35%  numa-meminfo.node1.Active(file)
     30748 ± 24%     -81.0%       5843 ± 23%  numa-meminfo.node1.Dirty
    329646 ± 27%     -65.8%     112663 ± 17%  numa-meminfo.node1.Inactive(file)
    205436 ±  8%     -43.6%     115909 ±  8%  numa-meminfo.node1.Shmem
    134.13           +48.8%     199.58        filebench.sum_bytes_mb/s
   1605830           +48.8%    2388789        filebench.sum_operations
     26760           +48.8%      39809        filebench.sum_operations/s
      8631           +48.8%      12841        filebench.sum_reads/s
      3.70           -32.5%       2.50        filebench.sum_time_ms/op
    864.00           +48.7%       1285        filebench.sum_writes/s
    819752          -100.0%       0.00        filebench.time.file_system_outputs
     13931           -75.6%       3396 ±  2%  filebench.time.involuntary_context_switches
      3583           -93.6%     227.67        filebench.time.percent_of_cpu_this_job_got
      5866           -93.7%     370.74        filebench.time.system_time
    437835 ±  4%      -7.2%     406495        filebench.time.voluntary_context_switches
    238572           -20.6%     189352        meminfo.Active
    204171           -46.6%     108942 ±  2%  meminfo.Active(anon)
     34401          +133.7%      80409 ±  2%  meminfo.Active(file)
   3976657           -10.9%    3541519        meminfo.Cached
     56509           -79.4%      11639 ± 13%  meminfo.Dirty
   1658006           -23.2%    1272751        meminfo.Inactive
    588879           -64.3%     210087        meminfo.Inactive(file)
     28818 ±  2%     +11.4%      32100        meminfo.KernelStack
     77684           -12.1%      68300        meminfo.Mapped
    238869           -42.6%     137020 ±  2%  meminfo.Shmem
    989.00 ± 20%     -97.7%      22.61 ±105%  meminfo.Writeback
     94783 ± 34%     -75.8%      22968 ± 34%  numa-vmstat.node0.nr_dirtied
      6468 ± 27%     -77.6%       1447 ± 40%  numa-vmstat.node0.nr_dirty
     64650 ± 33%     -62.6%      24209 ± 19%  numa-vmstat.node0.nr_inactive_file
     64650 ± 33%     -62.6%      24209 ± 19%  numa-vmstat.node0.nr_zone_inactive_file
      6556 ± 28%     -78.0%       1445 ± 40%  numa-vmstat.node0.nr_zone_write_pending
     47059 ±  6%     -45.3%      25749 ±  5%  numa-vmstat.node1.nr_active_anon
      3087 ± 42%    +188.4%       8904 ± 35%  numa-vmstat.node1.nr_active_file
    110748 ± 30%     -79.9%      22254 ± 34%  numa-vmstat.node1.nr_dirtied
      7667 ± 24%     -80.9%       1463 ± 23%  numa-vmstat.node1.nr_dirty
     82080 ± 28%     -65.8%      28076 ± 17%  numa-vmstat.node1.nr_inactive_file
     51385 ±  8%     -43.6%      28970 ±  8%  numa-vmstat.node1.nr_shmem
     47059 ±  6%     -45.3%      25749 ±  5%  numa-vmstat.node1.nr_zone_active_anon
      3087 ± 42%    +188.4%       8904 ± 35%  numa-vmstat.node1.nr_zone_active_file
     82080 ± 28%     -65.8%      28076 ± 17%  numa-vmstat.node1.nr_zone_inactive_file
      7778 ± 24%     -81.2%       1461 ± 23%  numa-vmstat.node1.nr_zone_write_pending
    521870 ± 12%     -27.0%     380934 ±  2%  numa-vmstat.node1.numa_hit
    455390 ± 10%     -31.3%     312747 ± 11%  numa-vmstat.node1.numa_local
     51009           -46.6%      27229 ±  2%  proc-vmstat.nr_active_anon
      8599          +133.5%      20082 ±  2%  proc-vmstat.nr_active_file
    205465           -78.0%      45194        proc-vmstat.nr_dirtied
     14147           -79.4%       2908 ± 12%  proc-vmstat.nr_dirty
    994302           -11.0%     885296        proc-vmstat.nr_file_pages
    147337           -64.4%      52456        proc-vmstat.nr_inactive_file
     28784 ±  2%     +11.4%      32078        proc-vmstat.nr_kernel_stack
     19698           -12.0%      17343        proc-vmstat.nr_mapped
     59740           -42.6%      34268 ±  2%  proc-vmstat.nr_shmem
     76294            +2.4%      78134        proc-vmstat.nr_slab_unreclaimable
    248.25 ± 16%     -97.8%       5.52 ± 88%  proc-vmstat.nr_writeback
    205381           +36.6%     280548        proc-vmstat.nr_written
     51009           -46.6%      27229 ±  2%  proc-vmstat.nr_zone_active_anon
      8599          +133.5%      20082 ±  2%  proc-vmstat.nr_zone_active_file
    147337           -64.4%      52456        proc-vmstat.nr_zone_inactive_file
     14395           -79.8%       2906 ± 12%  proc-vmstat.nr_zone_write_pending
    987820           -15.3%     837060        proc-vmstat.numa_hit
    854320           -17.7%     702835        proc-vmstat.numa_local
    627454 ±  5%     -11.1%     557885 ±  6%  proc-vmstat.numa_pte_updates
     70823           -29.6%      49841 ±  2%  proc-vmstat.pgactivate
   1573262            -6.6%    1470032        proc-vmstat.pgalloc_normal
    673575            -7.4%     623423        proc-vmstat.pgfault
    413240           -56.1%     181539        proc-vmstat.pgpgout
      5.31 ± 72%      -3.2        2.09 ±143%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.main
      5.31 ± 72%      -3.2        2.09 ±143%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.main
      5.30 ± 72%      -3.2        2.09 ±143%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.main
      5.14 ± 72%      -3.1        2.06 ±143%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      0.44 ±143%      +1.1        1.51 ±  9%  perf-profile.calltrace.cycles-pp.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged
     14.44 ±  4%      +1.4       15.82 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.75 ± 12%      -0.3        0.43 ± 10%  perf-profile.children.cycles-pp.getname_flags
      0.67 ± 16%      -0.3        0.40 ± 43%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.66 ± 17%      -0.3        0.40 ± 43%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.59 ± 22%      -0.2        0.36 ± 20%  perf-profile.children.cycles-pp.strncpy_from_user
      0.31 ± 37%      -0.2        0.11 ± 51%  perf-profile.children.cycles-pp.rb_next
      0.27 ± 70%      -0.2        0.09 ± 70%  perf-profile.children.cycles-pp.aa_file_perm
      0.44 ± 18%      -0.2        0.26 ± 27%  perf-profile.children.cycles-pp.timerqueue_del
      0.21 ± 63%      -0.2        0.05 ±111%  perf-profile.children.cycles-pp.irq_get_next_irq
      0.25 ± 24%      -0.1        0.12 ± 28%  perf-profile.children.cycles-pp.xas_load
      0.23 ± 20%      -0.1        0.14 ± 41%  perf-profile.children.cycles-pp.filemap_get_entry
      0.22 ± 25%      -0.1        0.14 ± 40%  perf-profile.children.cycles-pp.__pte_alloc
      0.08 ± 82%      +0.1        0.19 ± 28%  perf-profile.children.cycles-pp.___slab_alloc
      0.05 ±141%      +0.2        0.22 ± 23%  perf-profile.children.cycles-pp.__collapse_huge_page_copy_succeeded
      0.37 ± 26%      +0.2        0.56 ± 19%  perf-profile.children.cycles-pp.native_sched_clock
      0.57 ± 14%      +0.3        0.82 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.44 ±143%      +1.1        1.51 ±  9%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
     14.43 ±  4%      +1.6       16.00 ±  2%  perf-profile.children.cycles-pp.intel_idle
      0.28 ± 29%      -0.2        0.06 ± 82%  perf-profile.self.cycles-pp.strncpy_from_user
      0.31 ± 37%      -0.2        0.11 ± 51%  perf-profile.self.cycles-pp.rb_next
      0.25 ± 38%      -0.1        0.13 ± 37%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.19 ± 51%      -0.1        0.10 ± 70%  perf-profile.self.cycles-pp.timekeeping_advance
      0.56 ± 12%      +0.2        0.79 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     14.43 ±  4%      +1.6       16.00 ±  2%  perf-profile.self.cycles-pp.intel_idle
   2693379 ± 15%     -99.2%      21162 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3361723 ± 15%     -97.6%      80085 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.max
   1784170 ± 18%    -100.0%     227.25 ± 31%  sched_debug.cfs_rq:/.avg_vruntime.min
    309876 ± 17%     -95.0%      15354 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.42 ± 13%     -82.6%       0.07 ± 14%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.34 ±  9%     -26.1%       0.25 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
     15056 ± 94%     -53.1%       7058 ± 20%  sched_debug.cfs_rq:/.load.avg
   2693383 ± 15%     -99.2%      21162 ± 13%  sched_debug.cfs_rq:/.min_vruntime.avg
   3361723 ± 15%     -97.6%      80085 ± 14%  sched_debug.cfs_rq:/.min_vruntime.max
   1784170 ± 18%    -100.0%     227.25 ± 31%  sched_debug.cfs_rq:/.min_vruntime.min
    309878 ± 17%     -95.0%      15354 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.42 ± 13%     -82.7%       0.07 ± 13%  sched_debug.cfs_rq:/.nr_running.avg
      0.34 ±  9%     -26.7%       0.25 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
    486.84 ± 16%     -69.6%     147.77 ± 14%  sched_debug.cfs_rq:/.runnable_avg.avg
    318.34 ± 13%     -40.1%     190.71 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
    482.67 ± 15%     -69.5%     147.32 ± 14%  sched_debug.cfs_rq:/.util_avg.avg
    315.59 ± 13%     -39.7%     190.34 ± 11%  sched_debug.cfs_rq:/.util_avg.stddev
    368.58 ± 16%     -97.3%       9.91 ± 17%  sched_debug.cfs_rq:/.util_est.avg
    874.25 ± 26%     -54.3%     399.22 ± 16%  sched_debug.cfs_rq:/.util_est.max
    231.72 ± 15%     -77.5%      52.22 ±  9%  sched_debug.cfs_rq:/.util_est.stddev
    602065 ± 11%     +44.2%     868360 ±  2%  sched_debug.cpu.avg_idle.avg
      1841 ± 16%     -86.3%     251.50 ± 19%  sched_debug.cpu.curr->pid.avg
      1347 ±  7%     -30.2%     940.06 ± 10%  sched_debug.cpu.curr->pid.stddev
      0.41 ± 14%     -82.5%       0.07 ± 14%  sched_debug.cpu.nr_running.avg
      0.34 ±  9%     -26.5%       0.25 ± 11%  sched_debug.cpu.nr_running.stddev
      7367 ± 14%     +33.5%       9834 ± 11%  sched_debug.cpu.nr_switches.avg
     24784 ± 17%    +121.7%      54944 ± 11%  sched_debug.cpu.nr_switches.max
      3492 ± 17%     -76.0%     839.36 ± 87%  sched_debug.cpu.nr_switches.min
      3660 ±  9%    +117.7%       7968 ±  9%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 42%   +2382.1%       0.36 ± 14%  sched_debug.cpu.nr_uninterruptible.avg
      0.99 ±  9%     +13.1%       1.12        perf-stat.i.MPKI
 2.751e+09           -49.4%  1.391e+09        perf-stat.i.branch-instructions
      2.56            +0.1        2.65        perf-stat.i.branch-miss-rate%
  11113399           +47.2%   16364324        perf-stat.i.branch-misses
      6.84 ±  2%      -2.4        4.47        perf-stat.i.cache-miss-rate%
   2351784 ±  2%     +51.9%    3572357 ±  3%  perf-stat.i.cache-misses
  18768444          +174.0%   51419407        perf-stat.i.cache-references
      8242 ±  2%     +67.0%      13768        perf-stat.i.context-switches
      3.95           -57.6%       1.67        perf-stat.i.cpi
     1e+11           -90.6%  9.351e+09        perf-stat.i.cpu-cycles
    168.60           +18.5%     199.71 ±  4%  perf-stat.i.cpu-migrations
     18353           -89.4%       1948 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.118e+10           -49.1%  5.698e+09        perf-stat.i.instructions
      0.47           +29.8%       0.62        perf-stat.i.ipc
      3403 ±  2%      -7.8%       3138        perf-stat.i.minor-faults
      3403 ±  2%      -7.8%       3138        perf-stat.i.page-faults
      0.20          +210.3%       0.63 ±  3%  perf-stat.overall.MPKI
      0.38            +0.8        1.17        perf-stat.overall.branch-miss-rate%
     13.01            -6.1        6.95 ±  2%  perf-stat.overall.cache-miss-rate%
      9.01           -81.8%       1.64        perf-stat.overall.cpi
     44649 ±  2%     -94.1%       2624 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.11          +448.9%       0.61        perf-stat.overall.ipc
 3.265e+09           -57.4%  1.391e+09        perf-stat.ps.branch-instructions
  12275081           +33.0%   16326502        perf-stat.ps.branch-misses
   2676269 ±  2%     +33.3%    3568709 ±  3%  perf-stat.ps.cache-misses
  20569992          +149.8%   51380158        perf-stat.ps.cache-references
      9501 ±  2%     +44.8%      13759        perf-stat.ps.context-switches
 1.194e+11           -92.2%  9.352e+09        perf-stat.ps.cpu-cycles
    170.57           +16.5%     198.67 ±  4%  perf-stat.ps.cpu-migrations
 1.325e+10           -57.0%  5.695e+09        perf-stat.ps.instructions
      3423 ±  2%      -9.2%       3109        perf-stat.ps.minor-faults
      3423 ±  2%      -9.2%       3109        perf-stat.ps.page-faults
  2.18e+12           -57.0%  9.381e+11        perf-stat.total.instructions



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webserver.f/filebench

commit: 
  07c30df0ea ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
  7de1bab771 ("cifs: Cut over to using netfslib")

07c30df0ea2d1015 7de1bab7712daba2c9bb28e60a3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20130           +27.4%      25637        uptime.idle
 1.507e+10           +36.6%  2.058e+10        cpuidle..time
   1108270           +19.2%    1320797        cpuidle..usage
     71.73           +36.2%      97.70        iostat.cpu.idle
     28.07           -92.5%       2.12        iostat.cpu.system
    495045 ± 12%     -25.0%     371127 ±  8%  numa-numastat.node0.numa_hit
    105156 ± 10%     -50.3%      52213 ± 63%  numa-numastat.node0.other_node
     28441 ± 38%    +188.6%      82066 ± 40%  numa-numastat.node1.other_node
    409.67 ±  6%     -34.6%     268.00 ±  6%  perf-c2c.DRAM.remote
    437.00 ±  3%     -60.1%     174.33 ±  8%  perf-c2c.HITM.local
    249.50 ±  9%     -35.0%     162.17 ±  7%  perf-c2c.HITM.remote
     71.78           +36.1%      97.72        vmstat.cpu.id
      5469 ±  7%     -22.4%       4244 ±  9%  vmstat.io.bo
      0.05 ± 21%     -48.9%       0.02 ± 31%  vmstat.procs.b
     37.30           -89.1%       4.06 ±  4%  vmstat.procs.r
      9861 ±  2%     +34.0%      13218        vmstat.system.cs
     43072           -83.2%       7243        vmstat.system.in
     71.41           +26.3       97.70        mpstat.cpu.all.idle%
      0.05 ±  3%      -0.0        0.03 ±  4%  mpstat.cpu.all.iowait%
      0.12            -0.1        0.02        mpstat.cpu.all.irq%
      0.01            +0.0        0.02        mpstat.cpu.all.soft%
     28.27           -26.2        2.10        mpstat.cpu.all.sys%
     37.83           -92.1%       3.00        mpstat.max_utilization.seconds
     79.51           -87.0%      10.38 ±  7%  mpstat.max_utilization_pct
    222823           -43.8%     125162        meminfo.Active
    200194           -48.9%     102285        meminfo.Active(anon)
   3983844           -11.2%    3537341        meminfo.Cached
     48579 ±  9%     -81.4%       9031 ± 18%  meminfo.Dirty
   1680180           -20.7%    1332070        meminfo.Inactive
    617842           -55.2%     276833        meminfo.Inactive(file)
     28534 ±  2%     +12.2%      32018        meminfo.KernelStack
     77304           -12.6%      67532        meminfo.Mapped
    234890           -44.7%     129947        meminfo.Shmem
    135.72           +44.1%     195.53        filebench.sum_bytes_mb/s
   1624888           +44.0%    2340594        filebench.sum_operations
     27077           +44.1%      39006        filebench.sum_operations/s
      8734           +44.1%      12582        filebench.sum_reads/s
      3.67           -30.3%       2.56        filebench.sum_time_ms/op
    874.00           +44.1%       1259        filebench.sum_writes/s
    815745          -100.0%       0.00        filebench.time.file_system_outputs
     14070           -72.7%       3845        filebench.time.involuntary_context_switches
      3627           -92.9%     257.50 ±  2%  filebench.time.percent_of_cpu_this_job_got
      5913           -92.9%     417.54 ±  2%  filebench.time.system_time
    462382 ±  5%     -13.2%     401542        filebench.time.voluntary_context_switches
      2.95 ± 13%      -0.6        2.39 ± 10%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      5.58 ± 12%      -1.2        4.41 ± 11%  perf-profile.children.cycles-pp.sched_setaffinity
      2.48 ± 10%      -0.5        1.98 ± 11%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      2.12 ±  9%      -0.4        1.76 ± 12%  perf-profile.children.cycles-pp.__sched_setaffinity
      1.78 ±  7%      -0.4        1.43 ± 10%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.22 ± 52%      +0.2        0.43 ± 10%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.41 ± 49%      +0.3        0.70 ± 17%  perf-profile.children.cycles-pp.___perf_sw_event
      0.53 ± 33%      +0.4        0.96 ± 14%  perf-profile.children.cycles-pp.set_pte_range
      0.21 ± 58%      +0.2        0.43 ± 10%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.12 ± 67%      +0.2        0.35 ± 41%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.34 ± 52%      +0.3        0.61 ± 23%  perf-profile.self.cycles-pp.___perf_sw_event
     43177 ±103%     -87.9%       5216 ± 53%  numa-meminfo.node0.Active(anon)
     25196 ± 35%     -83.3%       4219 ± 30%  numa-meminfo.node0.Dirty
    326851 ± 30%     -60.9%     127747 ± 13%  numa-meminfo.node0.Inactive(file)
     58630 ± 18%     -43.4%      33160 ± 52%  numa-meminfo.node0.Mapped
    146630 ±  7%     -13.5%     126862 ±  7%  numa-meminfo.node0.SUnreclaim
     62192 ± 76%     -72.2%      17264 ± 49%  numa-meminfo.node0.Shmem
    228307 ±  6%     -21.6%     179046 ± 15%  numa-meminfo.node0.Slab
     23386 ± 25%     -79.5%       4799 ± 29%  numa-meminfo.node1.Dirty
    291082 ± 35%     -48.8%     149154 ± 12%  numa-meminfo.node1.Inactive(file)
     12921 ±  7%     +24.9%      16142 ±  4%  numa-meminfo.node1.KernelStack
    157660 ±  7%     +17.3%     184865 ±  5%  numa-meminfo.node1.SUnreclaim
    189395 ±  8%     +27.8%     241984 ± 11%  numa-meminfo.node1.Slab
     10772 ±103%     -87.9%       1302 ± 53%  numa-vmstat.node0.nr_active_anon
    107066 ± 34%     -80.3%      21057 ± 23%  numa-vmstat.node0.nr_dirtied
      6338 ± 35%     -83.3%       1061 ± 30%  numa-vmstat.node0.nr_dirty
     82231 ± 30%     -60.9%      32142 ± 13%  numa-vmstat.node0.nr_inactive_file
     14918 ± 18%     -43.3%       8451 ± 52%  numa-vmstat.node0.nr_mapped
     15561 ± 76%     -72.2%       4326 ± 49%  numa-vmstat.node0.nr_shmem
     36655 ±  7%     -13.5%      31712 ±  7%  numa-vmstat.node0.nr_slab_unreclaimable
     10772 ±103%     -87.9%       1302 ± 53%  numa-vmstat.node0.nr_zone_active_anon
     82230 ± 30%     -60.9%      32142 ± 13%  numa-vmstat.node0.nr_zone_inactive_file
      6388 ± 35%     -83.3%       1064 ± 30%  numa-vmstat.node0.nr_zone_write_pending
    493158 ± 13%     -25.0%     369904 ±  8%  numa-vmstat.node0.numa_hit
    105156 ± 10%     -50.3%      52213 ± 63%  numa-vmstat.node0.numa_other
     97100 ± 37%     -76.4%      22872 ± 24%  numa-vmstat.node1.nr_dirtied
      5867 ± 25%     -79.5%       1205 ± 29%  numa-vmstat.node1.nr_dirty
     73230 ± 35%     -48.8%      37513 ± 12%  numa-vmstat.node1.nr_inactive_file
     12925 ±  7%     +24.8%      16136 ±  4%  numa-vmstat.node1.nr_kernel_stack
     39412 ±  7%     +17.3%      46212 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
     73230 ± 35%     -48.8%      37513 ± 12%  numa-vmstat.node1.nr_zone_inactive_file
      5910 ± 25%     -79.5%       1211 ± 29%  numa-vmstat.node1.nr_zone_write_pending
     28441 ± 38%    +188.6%      82066 ± 40%  numa-vmstat.node1.numa_other
     50052           -48.9%      25564        proc-vmstat.nr_active_anon
    204167           -78.5%      43945        proc-vmstat.nr_dirtied
     12148 ±  9%     -81.4%       2258 ± 18%  proc-vmstat.nr_dirty
    997524           -11.2%     886006        proc-vmstat.nr_file_pages
    154498           -55.1%      69298        proc-vmstat.nr_inactive_file
     28528 ±  2%     +12.1%      31983        proc-vmstat.nr_kernel_stack
     19606           -12.5%      17154        proc-vmstat.nr_mapped
     58750           -44.7%      32502        proc-vmstat.nr_shmem
     28353            -3.6%      27326        proc-vmstat.nr_slab_reclaimable
     76072            +2.4%      77930        proc-vmstat.nr_slab_unreclaimable
    101.46 ± 57%     -80.5%      19.80 ± 40%  proc-vmstat.nr_writeback
    204166           +34.5%     274607        proc-vmstat.nr_written
     50052           -48.9%      25564        proc-vmstat.nr_zone_active_anon
    154498           -55.1%      69298        proc-vmstat.nr_zone_inactive_file
     12249 ± 10%     -81.5%       2269 ± 18%  proc-vmstat.nr_zone_write_pending
    990021           -15.7%     834721        proc-vmstat.numa_hit
    856401           -18.2%     700408        proc-vmstat.numa_local
     66332           -46.9%      35195        proc-vmstat.pgactivate
   1593795            -8.4%    1459563        proc-vmstat.pgalloc_normal
    672143            -7.9%     619257        proc-vmstat.pgfault
   1525590            -7.4%    1412060 ±  2%  proc-vmstat.pgfree
    906688 ±  7%     -22.6%     702007 ± 10%  proc-vmstat.pgpgout
   2567541 ± 12%     -99.1%      23679 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3156597 ± 12%     -97.4%      82643 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.max
   1620235 ± 23%     -99.9%       1406 ± 52%  sched_debug.cfs_rq:/.avg_vruntime.min
    282702 ± 11%     -95.1%      13739 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.45 ± 12%     -80.6%       0.09 ± 35%  sched_debug.cfs_rq:/.h_nr_running.avg
    603.06 ± 23%     +48.1%     892.83 ± 22%  sched_debug.cfs_rq:/.load_avg.max
   2567545 ± 12%     -99.1%      23680 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
   3156597 ± 12%     -97.4%      82661 ± 13%  sched_debug.cfs_rq:/.min_vruntime.max
   1620235 ± 23%     -99.9%       1406 ± 52%  sched_debug.cfs_rq:/.min_vruntime.min
    282702 ± 11%     -95.1%      13740 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.45 ± 12%     -80.5%       0.09 ± 35%  sched_debug.cfs_rq:/.nr_running.avg
    514.62 ± 12%     -67.4%     168.02 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
      1358 ± 11%     -29.9%     952.00 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    344.46 ± 10%     -39.9%     207.08 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    510.60 ± 12%     -67.3%     166.84 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
      1177 ±  6%     -19.5%     948.58 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    341.50 ± 10%     -39.6%     206.28 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    394.72 ± 12%     -95.6%      17.35 ± 51%  sched_debug.cfs_rq:/.util_est.avg
    245.12 ± 12%     -68.6%      76.93 ± 39%  sched_debug.cfs_rq:/.util_est.stddev
    579808 ± 10%     +43.7%     833020 ±  2%  sched_debug.cpu.avg_idle.avg
      1932 ± 12%     -84.7%     295.72 ± 42%  sched_debug.cpu.curr->pid.avg
      1380 ±  6%     -29.1%     978.89 ± 22%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 74%     -64.7%       0.00 ± 11%  sched_debug.cpu.next_balance.stddev
      0.44 ± 12%     -79.7%       0.09 ± 35%  sched_debug.cpu.nr_running.avg
      7189 ±  8%     +25.0%       8988        sched_debug.cpu.nr_switches.avg
     22948 ±  5%    +168.4%      61601 ± 19%  sched_debug.cpu.nr_switches.max
      3634 ±  5%     -78.4%     784.83 ± 36%  sched_debug.cpu.nr_switches.min
      3362 ±  7%    +155.7%       8598 ±  7%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 63%   +3820.5%       0.37 ±  5%  sched_debug.cpu.nr_uninterruptible.avg
 2.739e+09           -51.0%  1.342e+09        perf-stat.i.branch-instructions
   8305116 ±  2%     +58.5%   13164374 ±  3%  perf-stat.i.branch-misses
      6.72 ±  2%      -2.4        4.29 ±  3%  perf-stat.i.cache-miss-rate%
   2041169           +53.9%    3141417 ±  2%  perf-stat.i.cache-misses
  16613426          +183.6%   47108029        perf-stat.i.cache-references
      8501 ±  2%     +56.1%      13267        perf-stat.i.context-switches
      4.05           -57.2%       1.74        perf-stat.i.cpi
 1.012e+11           -90.2%  9.925e+09        perf-stat.i.cpu-cycles
    172.15            +8.3%     186.48        perf-stat.i.cpu-migrations
     19782           -89.2%       2132 ±  3%  perf-stat.i.cycles-between-cache-misses
 1.106e+10           -51.1%  5.413e+09        perf-stat.i.instructions
      0.47           +27.5%       0.60        perf-stat.i.ipc
      0.10 ± 52%     -71.0%       0.03 ± 58%  perf-stat.i.major-faults
      3358            -8.0%       3088 ±  2%  perf-stat.i.minor-faults
      3358            -8.0%       3088 ±  2%  perf-stat.i.page-faults
      0.18          +224.2%       0.58        perf-stat.overall.MPKI
      0.28 ±  2%      +0.7        0.98 ±  3%  perf-stat.overall.branch-miss-rate%
     12.79            -6.1        6.67        perf-stat.overall.cache-miss-rate%
      9.20           -80.1%       1.83 ±  2%  perf-stat.overall.cpi
     51435           -93.9%       3162 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.11          +402.0%       0.55 ±  2%  perf-stat.overall.ipc
 3.235e+09           -58.6%  1.338e+09        perf-stat.ps.branch-instructions
   9060686 ±  2%     +44.8%   13115982 ±  3%  perf-stat.ps.branch-misses
   2335691           +34.1%    3132375 ±  2%  perf-stat.ps.cache-misses
  18263949 ±  2%    +157.2%   46971447        perf-stat.ps.cache-references
      9778 ±  2%     +35.3%      13230        perf-stat.ps.context-switches
 1.201e+11           -91.8%  9.902e+09        perf-stat.ps.cpu-cycles
    174.60            +6.2%     185.51        perf-stat.ps.cpu-migrations
 1.305e+10           -58.6%  5.399e+09        perf-stat.ps.instructions
      0.11 ± 52%     -74.4%       0.03 ± 58%  perf-stat.ps.major-faults
      3375            -9.3%       3060 ±  2%  perf-stat.ps.minor-faults
      3375            -9.3%       3060 ±  2%  perf-stat.ps.page-faults
 2.144e+12           -58.8%   8.83e+11        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


