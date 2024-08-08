Return-Path: <linux-fsdevel+bounces-25419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A494BEA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFCAB25C87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668318E022;
	Thu,  8 Aug 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m45SMfYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552C143726;
	Thu,  8 Aug 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124331; cv=fail; b=macb099KiUb8EtsG9JW7uafsS5TaYMERkxV4slWn7hayUInFozTXtN69EK5/3UdiNDFtxsczQXJjMS1hLF2KHoEZo6ll7z3NsZ1vfx87wjFybAJnDlI96PuF5/G+2TRSzBuNxstXTlqD+sItFR1PKbP2VJ0oXJrOrV0PCK5elII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124331; c=relaxed/simple;
	bh=dMSaUrgbrWFWvQ/HQ+EK78OV82c+l0BDctGG9sFb28g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OQvyXmKxGCWEnwiMOPcUSm2dS0K9ybFV+0FkLjo7ABBfLyRqDqivJ9xAsIAbiazs+hQG06rE3CAXonWJMibSSyKCyPU6sx7qKEKJ9kVZW9U1vrqMBaQEJvsH50AiO8wOJlXXsFDlQPjooFpufRd01XF/HKwzLkZJV+bn/77hgP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m45SMfYm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723124330; x=1754660330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dMSaUrgbrWFWvQ/HQ+EK78OV82c+l0BDctGG9sFb28g=;
  b=m45SMfYm4vbh9AG22+YP5WgSPp2dqjeV92XiSW8qvyKyD8njLa+vJBO2
   z57RcqBH2gPGGSoi/pcGo1C7xeISZoTeqSPnNyp5p4IpuXpbt/ZR1uCxL
   2TqHVrZ8sIuL7nCO3dIyr7JNTggwstAYYH6eIX5j6fpEX6UROezrMuk5V
   dwlPH6uYz1YY9b7tfak31euZSNX4a6ObXxpQl677+mPBKeSWNvuFbGmc2
   0Lo3MtnPo+qkx8HnjUDD6sycFj23BUS3l2ERMjO76pmlIJ7HA8vVjACEJ
   KsdDYDGNqVZ0qlr6TZxsjFOD9hA5OBwdByz+ph+tSXF50qA/UBgYfxRZ/
   Q==;
X-CSE-ConnectionGUID: QtXdjMufT+G0wtZ8g2hISw==
X-CSE-MsgGUID: DZ/UBEDIQBizUAY3VlLtZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25041144"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25041144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:38:49 -0700
X-CSE-ConnectionGUID: 2h3WjS9ISCaC9179H8jzig==
X-CSE-MsgGUID: ghKksS73SiSkQ9apgeiWYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="87874181"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 06:38:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 06:38:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 06:38:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 06:38:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 06:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qynHBsL0yQx4VXxyh+XF8NJmM6QeDrTKWSmT9hD94/ZncL/seHQm/smgizX3HlJ15419q06gpkYXmZS2/OEMobF1c0tHaOXXdd+oTmMQUN+zvVVpHiKGk1wcw87gq87/I/7cNdgO/CQ0nt4P01a9/cZEHytgCH1Ac+wlGadhJNqYbtHWg8au+DfNFglXNGEWzG1idxNEGyOOXvJ4nSCJBTyqfA1dNDvaMEDeJW4GL1fBL+LrBRmZ9dw4FK6oxQjG72SOPkyCvPFMniLGsLzvoVBZCKTJk7J/5tumvmv/vKYXPth6tQrDrXPPUtmX7ZQo1ou2/4DOlWJIXY5Ns6S81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRp4hqIoHBpk5PPiuyw3m/h796lXfam0L5JUBCV4GHo=;
 b=aZaK2QTDPNrvUhTxtv49aa1786ppk6aMaRBKRF9m0ER6BQNLIyuaYhPrgTSUtG7yGEI8F65gbTBuTwtWqB4B2F/EAJAchu3mjPCnsvhxWs8CyMiMeBvTg/ogiy/PFHE0UYOyhjzpVMOJngCtFZRjGOm88z35wkhEKUVAWq1lFqZlTEfaLXC74DAFpgS9nuOyYONYMzKSFRk4+Fe2e72+e9ozYoSZAa3lECzkTlgb3hVBW4LkEr96F9dQ+f0QA4BwiaiWwzOA5vyYJec8okBwu0/LCwS7TvT+ePIQWGX1axdAJ0sAJaS02lEEBXVr9gwydQjOQqveU+EpeIkd2adNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 13:38:31 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 13:38:31 +0000
Date: Thu, 8 Aug 2024 21:39:19 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
	<kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, SeongJae Park
	<sj@kernel.org>, Shuah Khan <shuah@kernel.org>, Brendan Higgins
	<brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, <syzkaller-bugs@googlegroups.com>, <heng.su@intel.com>
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <ZrTKh/UfeOcKLrN9@xpf.sh.intel.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
 <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
 <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd5e1da-46e6-425d-cdde-08dcb7af646d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEjeRl0WjKQZocHuQgB+OyCF2Asyt5YqbDOi9DhX1IRmEF2mMwIW9F2NKnk2?=
 =?us-ascii?Q?tKqsPWhze1KWMMTPcJJxPoi4ePtMlHQSEVTw+LvAhnOz5q5rsstUU7AZH86D?=
 =?us-ascii?Q?quv7ET6NVSlz6Ve22YZHPG8DTc1hKzJrf0H7/11adORXrQGoFvl60IXfgifr?=
 =?us-ascii?Q?4cfexZA6HGe4kbaZpFtNCUALqK6jS51lGvhGrOMRi/V/KQt+/Fhtd9DNWwlS?=
 =?us-ascii?Q?XTkUz1hjp07JoxWMA+2Gow3Azc8WhYbebmSl3vLtdSJ6iFZL1Dl0xt6m3uet?=
 =?us-ascii?Q?gU1xmYunFRwgRB6g8hTKIvI/lwhlpms0Ps6DNJdV2ehSN54tmw/ZYqCmkiUr?=
 =?us-ascii?Q?HOJBp4c4Sjmk4vi25yP4v74d0tXId5uHJXSWOmSFHPjBPHlHDiZRFp6XbHnN?=
 =?us-ascii?Q?cKefE3D2oPs8Vg0nuTKkzS0cvU9wb3gkL+fHiQ+7Zi3JDJnaGwcRA5n8ImLZ?=
 =?us-ascii?Q?U4bxX77btB1kGMjdhKjf9KTFanW2N62yRe9ra+K3crNH8/WbDzGEaUHRr8/q?=
 =?us-ascii?Q?W2+bUEKhwf+ywREi2Z5vI15fVZpl16K8RTSBEBoFGn0Sxks2XSLPs66LbOyH?=
 =?us-ascii?Q?UNbyhWTfY0gxJRv1Wd+r7h6dMbMsAuJk7C9kA1I8HsHccop9mi2U2KJ5+4aw?=
 =?us-ascii?Q?37Q15Gm3Jt6gOcDIquH955+Cs3d0pP+amzbWyYbFyKaU0bpd29Fh9xBUMU0U?=
 =?us-ascii?Q?R0gbWADag1ZBsReMIYkRu+5l8qi9xjnd7H9dunPR95evkFQcm2poXdYcIrw6?=
 =?us-ascii?Q?TbRSuyRVnAO6KEgu13Q/E6OFNTFeSsrVrXlNGm9BUgKkLg98SimXYYFnuh0O?=
 =?us-ascii?Q?1hHgplYGr/DAUrdnAiUGN3Y6Fr5vUpSx/jTAYm8xKWAKHhlqQ18SE1jfttqJ?=
 =?us-ascii?Q?l0pdWB5DBOMT85H0N0cJRQU6TgrElpagn9Ge3Xa8VAYOMDla1bmQ4mnZZb0H?=
 =?us-ascii?Q?KBqK/NYvc38MIwbt7Z+zKnefb1AvUOnElGvkhtORU+2VA8piQnUn9BJ9kJsz?=
 =?us-ascii?Q?KafgEwJknuBYvfo58XjyUwnKc7a6nKTqF7r+ZFRhPE1aQllY5csxoGiCoYFX?=
 =?us-ascii?Q?VPxfb7qUXDMY2srAkOAfFVyYBVJ1JGr3d4sTo2IUg8SG1i7ArlKF56M/Daqg?=
 =?us-ascii?Q?7mB22YFsX5HpncBOWScCa48/QFhI+zyCB4YZ+MM7/riKZENd7EK1+vZRYA7E?=
 =?us-ascii?Q?O5MkzXP7Ny2sstdYI93H0wwy4yK9DvaxTBraUaYL5RbVHNwxdOC5ns2Tz5ku?=
 =?us-ascii?Q?FHNqNHM9byFidDGTBIxfEy2eQsBp603Nx9+EWC4fpjMesON6h31O3m3fm1+h?=
 =?us-ascii?Q?0hpPtfa/RfggvDmN3dTzdjzn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCk4eBpEpbijxbi69xlS+9gr3oTEKBrYNLQNbXNV/2GvkU5ro+uh3vIZDRvb?=
 =?us-ascii?Q?xqsFecgY5k8unlTHPxDjb0N/hFacqmvyv49vP8vmqtsOit+bwYMTusLfLMhe?=
 =?us-ascii?Q?vhZsZbzYO2l9gfCVGlAiG9/FaGP6IT1Bqh3ZBmZEUNukCMIuhzkRksc6+3rE?=
 =?us-ascii?Q?KQ8KhRKwjuAMlMyUetxodCEVfWbR17Pb8+b1AJMYjDz7M/Zz6+TqJwSoQMbw?=
 =?us-ascii?Q?7aHz4OcJNcAhP+XAvigA05Vzg3vm4CrdSOpUpNoq1NgaZqmS0HXPzYm9Vi1W?=
 =?us-ascii?Q?4l0C9zKkpusuC3LsRiJs3DIxU8AsyFkXsDG7jTFSnIw0CcsW/iXOmxXw+JWo?=
 =?us-ascii?Q?0GM6D0qMHqphmxj8Ky6qy7jr9E5WoP96LnZa9gKcXg6EK4ds3y+PYDgQD0jc?=
 =?us-ascii?Q?HD5OtmNWNMaqhC9Mbk4y3CPcbXja7fe0M3HExnw23OCrdVWLp+8CXHzbDPiN?=
 =?us-ascii?Q?xGwehVsqvvKo3wZi7mLC9oeEj2/luJG8yAARKZ9Ve/7nmE2e67lebscVbkPI?=
 =?us-ascii?Q?1uBxXKiJx++xBLk85HVx+GF2X2magrTPl7StXwdaV58o9/oXTpbVYHaArXZi?=
 =?us-ascii?Q?sjjlkKKYL1Xihi7MI0UWyi42QuM2jzJtOeoaW45bIWR59Vr7ORAYoUn/ogCM?=
 =?us-ascii?Q?xWVr0YOzMMNOKdSbt6VXBrrdzkaJPu7TX8TRw7QT6xOQWRaCAPmioDGL7XwL?=
 =?us-ascii?Q?evBebleF+6CTeHqZ6cELol+9acyg9DfqQdVL1mYzu3Ur1fYua/FQbWdlantV?=
 =?us-ascii?Q?JTHMqI0YOJ3TrtqeVAjhBUuWfRXEyY+gEF4ApZAjDf84oLxHJNyDlC8MRgQr?=
 =?us-ascii?Q?/oxzmvWh6qqkzlHatU7wKem//+tDsDlRR0K+EPPhMbLIZaOT3RyUwgiWdMPK?=
 =?us-ascii?Q?yhdgeYtLrllejfpPWUTy499rwJCH7en6NnTojayTg6bU/u45G8sZ/y3Oi0+5?=
 =?us-ascii?Q?57tYYqHGrg1AI0mUk6jgJQLfHkaHyp2jmzqilgMdzi3OzSkos1FLv1Im2h6V?=
 =?us-ascii?Q?VKCLvBN4wgXDVXhViojg5DNarru83+KsXqe10vMXKxFfLCa6I2AalMRGnDPG?=
 =?us-ascii?Q?so62q/4OnNMi4Zc7OTpmH2fLIIXWuZu03JK7JEaYk7tQ2Cy/xXTwzWkV9B2E?=
 =?us-ascii?Q?/jy16s/5EfMHCB3mjArbG1nUjNuSynrKnj84XSXLVj99ogVKfmbuqfruJN11?=
 =?us-ascii?Q?62v17NUc6xknUi6fQsjPskuXzV/VWCPJh2XKJk0qgA65mdCZvBVs9BcxaB7/?=
 =?us-ascii?Q?2kP8eZMv5CutV9gpi/o7nAdrDHJgXUgZ0RLGXxG+j6e/g8x6VHcszM9olUyx?=
 =?us-ascii?Q?VbM9YB4K/GNVRlwXXmXGkTkJF3PkJADQa5llauDPqzddf/WLjYasldffdcpI?=
 =?us-ascii?Q?YPV2AZAE4TgCPP7V54HYivuNrFFLuWEgONWK7JF58OW5qw2/WqgQtpGcj3ff?=
 =?us-ascii?Q?c2Whs2bELnIATQ8LhFxabzscxsd+aVSdZWr5AlopdrftjJrn5D4p9sKS737y?=
 =?us-ascii?Q?VOVTU0rScn3zlMn57BzGExpJG7dwhh57J9e2ZkvV+UMi5ntouh8YousQ9Vcj?=
 =?us-ascii?Q?tDdlJwr/qedxbyLWGe+irU4pwfDPK41LkBr1zPqX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd5e1da-46e6-425d-cdde-08dcb7af646d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:38:31.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAhz5wX5mggYMzaB+jd0LLxhWXlMWZeXHOfFFRNlZ+/gMWQjvo3BDPl/zTXXBIA41ONChFcKYVhnR/Wa3rJXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7484
X-OriginatorOrg: intel.com

Hi Lorenzo Stoakes,

On 2024-08-07 at 13:03:52 +0100, Lorenzo Stoakes wrote:
> On Wed, Aug 07, 2024 at 11:45:56AM GMT, Pengfei Xu wrote:
> > Hi Lorenzo Stoakes,
> >
> > Greetings!
> >
> > I used syzkaller and found
> > KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.
> >
> > Bisected the first bad commit:
> > 4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ct
> 
> [snip]
> 
> Andrew - As this is so small, could you take this as a fix-patch? The fix
> is enclosed below.
> 
> 
> Pengfei - Sorry for the delay on getting this resolved, I was struggling to
> repro with my usual dev setup, after trying a lot of things I ended up
> using the supplied repro env and was able to do so there.

Glad to know the repro environment is helpful.
Thank you for your patch(I verified it's fixed) and it helps me learn more.

> 
> (I suspect that VMAs are laid out slightly differently in my usual arch base
> image perhaps based on tunables, and this was the delta on that!)
> 
> Regardless, I was able to identify the cause - we incorrectly pass a stale
> pointer to userfaultfd_reset_ctx() if a merge is performed in
> userfaultfd_clear_vma().
> 
> This was a subtle mistake on my part, I don't see any other instances like
> this in the patch.
> 
> Syzkaller managed to get this merge to happen and kasan picked up on it, so
> thank you very much for supplying the infra!

You are welcome. :)

Best Regards,
Thank you!

> 
> The fix itself is very simple, a one-liner, enclosed below.
> 
> ----8<----
> From 193abd1c3a51e6bf1d85ddfe01845e9713336970 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 7 Aug 2024 12:44:27 +0100
> Subject: [PATCH] mm: userfaultfd: fix user-after-free in
>  userfaultfd_clear_vma()
> 
> After invoking vma_modify_flags_uffd() in userfaultfd_clear_vma(), we may
> have merged the vma, and depending on the kind of merge, deleted the vma,
> rendering the vma pointer invalid.
> 
> The code incorrectly referenced this now possibly invalid vma pointer when
> invoking userfaultfd_reset_ctx().
> 
> If no merge is possible, vma_modify_flags_uffd() performs a split and
> returns the original vma. Therefore the correct approach is to simply pass
> the ret pointer to userfaultfd_ret_ctx().
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Fixes: e310f2b78a77 ("userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c")
> Closes: https://lore.kernel.org/all/ZrLt9HIxV9QiZotn@xpf.sh.intel.com/
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b7715ecf292..966e6c81a685 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1813,7 +1813,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  	 * the current one has not been updated yet.
>  	 */
>  	if (!IS_ERR(ret))
> -		userfaultfd_reset_ctx(vma);
> +		userfaultfd_reset_ctx(ret);
> 
>  	return ret;
>  }
> --
> 2.45.2

