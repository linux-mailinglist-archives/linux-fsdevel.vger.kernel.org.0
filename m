Return-Path: <linux-fsdevel+bounces-11734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79E856A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74761F2338D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0413667D;
	Thu, 15 Feb 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VkGXTdtD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l1e3AeAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF633135A7D;
	Thu, 15 Feb 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016437; cv=fail; b=uttGyAXr0tJsn/O07Nk4NObDRn/kk95Xp0SYHOAZAc61E4zt+GrOuuE+ZT3QyUgQfZHrS3x+Hr+4PlDzXe3lEIZeDQrzPqGHzci8i4CRgbO9S6LRWpRu3AVWaXeAlgzpuR1CTtmalfK7Ksh8X0SpKRG56p9ee1iOit+Frwx47HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016437; c=relaxed/simple;
	bh=AAu8IfOJPm32TnkQbtIEl2N5ZPBDr87PoZ2HzePyRwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvAptkXkYYXB9EmGD+Qx01Z2Iq/2Z9BbUwsbhILvvSjwIDV7iiB9UQPm8PqZa612EhfXS5TA3unwtq5L34yTTrQEemYl5i8MrcD6+VHY+vYsVwX/89QQ7kb9Vvhi8ByJmBQHf+W7EdbwbQdm58WoSAQ4p+fOb+5rM/p9OMXALDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VkGXTdtD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l1e3AeAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFTAxS006065;
	Thu, 15 Feb 2024 17:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=9XMZ3bWk4fxGYbfamL42cIowVrBrh7OVWIAKxoR72g8=;
 b=VkGXTdtDFn51nb7HWuhZenTDXaJDsoGcCxWMw68gYq/Wf/XmqrcARSZugy/I806oqaAd
 n6s/Gb/IZBWvZe9sb7DQXVx1hzU/nosylQN+S5lNRDk9cs1tufUydb0HfC006oiW5irK
 4nHEHCIqZvMYw/J2VSlP77JmVGP5cEwrpkzKJ+/8a6TLhmgo0nTbBKysGva4CVhx4SKo
 vJ62UZsOI2YgeyxcIuxWz+CLX3lGUiUF8S5Bjup8As4yeC04mAXVJM8GhJ7B18qeSCK2
 acCUiGeb13yDBE1AaArOBMhAyGeuhoz8nQAD8c367l+OYZvon6DPT+z4VE1/GY/G27+q nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppjq87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:00:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FGfIGs015104;
	Thu, 15 Feb 2024 17:00:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykategs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDzN9zqB2+nfaUdmjrobj+PWEol13Xl/g24Y/ozP/49MXsmBxisi0TfVSuGjMsZyO71V/j3qfc3lYao8dCwUFxmb501Hpih65j58zxrwpDUpTlZmsD2xNDEmVt3rU+8XxRzCDbxomy597xLlRF+fJ5gzxC4BFPuMC56Zsb0WFRIvigwL+KSlCo6r+e82Y8yKyxeFSrgd5xJGDko/tX4PcK7iN2UmCrUvHNb0y6a96nbKWsXGMS0A5nlpGTb1hUKUW7JAIsYIEZWif1Fvgf6DJcYKr0nxQfdnwnxHUFQ17ix4VnpHjx1UrjyofWcGg/i0Fbx6JwaK7cfKZAgGE5lt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XMZ3bWk4fxGYbfamL42cIowVrBrh7OVWIAKxoR72g8=;
 b=BwXLDk1oQCaNsqNSolhOVnAiyRKBXhek1ZcWidFl401zWAXcmce0JGQj3/ch67f5otub+38u5+dtr9j/QjlBKzTFJOzDmCZDkSRr4zyRYFEFGx84/EztBogUIfsEq6DQQAVShKMg4go9AW2kGFrLGZoeQ3bTLr4OUNdpmzYVHCbBgtLtTzqqtaGXPpp9dnWjstU36iHsMIgSWp+cGXwxU9aqy+JHbSFuoUZbR1P7qUtAUPy3Dp8j2bxhuNOfkYe1NJzYXzDXCTLCswQ8lM4Tf2tRunbon5b19Cc8zPLT3fnRhF8kgwJ16hRAU+Se06P4Xysel37cSukOP00owYSPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XMZ3bWk4fxGYbfamL42cIowVrBrh7OVWIAKxoR72g8=;
 b=l1e3AeAqM0wvcXGBhNesemjmfJlRpvL7vlKzig4ZhOAlEou/rtPE7fTKl0cInYNqBvB2+6mC38hmQKNeowwzD8amYVUPzIv56CUK3t0GYSLLqYt4BnyQ7615FTHVlBw+JPbN1owFHPG23FQcjEnh6JnTVAZMT5vYdLXLNu6DRLQ=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 17:00:10 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 17:00:10 +0000
Date: Thu, 15 Feb 2024 12:00:08 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hughd@google.com, akpm@linux-foundation.org, oliver.sang@intel.com,
        feng.tang@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240215170008.22eisfyzumn5pw3f@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, oliver.sang@intel.com,
	feng.tang@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, lkp@intel.com
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215131638.cxipaxanhidb3pev@quack3>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::17) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a2c004-b24b-4721-9956-08dc2e47918c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mm9SC2z0RD8XxJJ1b7iyqU3w/MnmUhLr67n/WU8Nm0072nF5/DIRKJoQc9YtxdsvypzjpOn7oSAZYqM8jRmFuosdRutw4dbOhEIpvIt891g/tNZzCCxE6dY5/cqScwgJT0nEAkPjiHyILAr2Rj0ZOLKjmB+EzKQu7yBK1BL9O5kMS/YQIkxwJFk3Umi6MaEA8X8QGp5HihzWNf+QrL5ZyrYEffl2o60dRJwcycW1ZQBMeq3KhjLtzVOk6X/L3wm4GZYSQgqn2T8GGYylNvNCw2rOGp6FfleH/4z/7vy8Z0K831dm9o5/lV24mX0DWY1cAqHN3FVRP0HH85SKQLCa06cQfVJXAaNPTsVq6zGE1935xHJxTF5enA6PRuKxQs1bD835tFA2qU7wOFFP5h0k5lqdkaWBaxVtvlda3dbHmGii/56Rr4TwxZW1ieKqNDuCcB6VUhMQDczM3lZ0MbXKRCIaotmUOJIylEDcCgzXzT06tgVQhu9o96XSIyNlok7bXLlRkh0xM+IP2Nn0qU72ARnjrx3tPnVzCh+T8QRVpAv/YV39EBeLMdo9ONdU0ic9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(7416002)(5660300002)(2906002)(38100700002)(86362001)(6506007)(9686003)(6512007)(6486002)(478600001)(83380400001)(41300700001)(1076003)(26005)(6916009)(4326008)(66556008)(8676002)(66946007)(8936002)(316002)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xugnSBF1OUL6ZCLtAkKz7JHsfBICRxjF4UJnkwp8mEEARd9bhrnrzjAA1XN0?=
 =?us-ascii?Q?ObqF5Wm2I+EhLg6Fb3sZb+xQQJ1+FA6H/0gj9WnRXcLWYraxrXFAT3HWg/Z1?=
 =?us-ascii?Q?F8ajaU0ixQMdNcz/xrLfINy4tyonDOb0dqXAxtoe1QXDi26QgGtg7yN7weED?=
 =?us-ascii?Q?3BkxJ/++g4DLlA2vdeygnJfsGBueJBOH1EqBmGLrT7loOIVCnAHxC82OY0YP?=
 =?us-ascii?Q?bV8/TsBFhzrbHW2OcSaUftXMsv+5/gT+cze61RslWN9Wo1cUtj1Qs9GSXClj?=
 =?us-ascii?Q?yYdgmBRV79PEJyeDqcOeQL/y+BWWx6mgsR2V9jBP/fS2DSo1ekiTfA9tgJDt?=
 =?us-ascii?Q?20WbulnCp2tzbP/Q5W3rDcjb7D9XnsQ23rSWX4P2kmDy0ZhaMm23djnn3xRU?=
 =?us-ascii?Q?qDbCqsGQF2btsGyDF3PXQeQ/wWJEc8ZMkxiuCYNtHLtwmswdrQXetuPm3ABf?=
 =?us-ascii?Q?2bx/eCT/yrTPmGQ155p196jLcSrc0gf1hv88glMyb1PPY4GyUdmDYuCYeROJ?=
 =?us-ascii?Q?hnSzBN+7cA/m9bT6PK2VdQkIC37ErTqJiLygMABHOsNifbzs3FhgSDyNoXJA?=
 =?us-ascii?Q?zyV5Qd+VJGO7FKahOwQZSO68BVi+YCl6H4QNPO07ksJ1AtQG4jbKoBp+I1Wt?=
 =?us-ascii?Q?dtgGu8Q8wZmu89WeRgOeQPpFWQWmf7GbhlMZ7II06Dn/CkFtCuWHX/zvzSdT?=
 =?us-ascii?Q?7qlELqMWcnoxDew+mEEslg8I5nG2LAvjwJZNeA+8EszUC/EmQNN5L1AbSctt?=
 =?us-ascii?Q?ICMTI8mc5/GcjN/D7O6uR2evBPFOMRGlegkY8VkZaUfOxKX63XuxZQPmMeR9?=
 =?us-ascii?Q?j2biJh7w767ZLxj+I2uDL6uByZHI0WXqJQU44IARDqjGW+vMB0yO8GhIjgWN?=
 =?us-ascii?Q?TEuoW7lF6L4jbFQlRByo7PHKJoi9XJzXp4CY67TOWEwJcw2NAMaYw0N69NkO?=
 =?us-ascii?Q?q8uGBjQtvsZ40rmaiIBqgs8OZpUU56YjvG/B3o4LTMnK7dnqkXSpT8zKYmEZ?=
 =?us-ascii?Q?S4+b8OlvQXvX+KwbMf3e6ABxNYk1ENsXssipZXtP2gZ9wauToDJWFRO9OP7I?=
 =?us-ascii?Q?WhOZSTsA7RsA4Jp3O0MGT544FVjJoC2J1a1j8UuD6KOO59hiF0vOrHhe+qj7?=
 =?us-ascii?Q?NcNGTHA8f1Gtm8yzUF2R2vxpFUaKA7tQ2Pclxa/SwyC9vCul/MQ7GZfpsFHw?=
 =?us-ascii?Q?7D+9VkUAgYT4w3mpDWUTnq25DHGUv8/E7KlgpaSiJ9pusYk+lKgWECw5JYkg?=
 =?us-ascii?Q?QkCZuf5XzOfGqGs4RsM3fzJZJ9YD3buIc6ngLNKV3CkNk2SjGiBBjdmRpCmD?=
 =?us-ascii?Q?J5I/T4OqfFzuK3zIrW9bvkpwNaPCk6X/52QrpBYdKQa8Sq/V/Ck8H6jYjhWW?=
 =?us-ascii?Q?g5R4aKGAn8Li8/qSmYV0xbmR7bG0KHx4ey02ls8JCdG8FRV5cjRpW2PISwGV?=
 =?us-ascii?Q?Dnm4EjpYwwwpKU6eXRvgh9r6h3BDL/nFjuiv0e11b55aG8safipZE1u6Xtyi?=
 =?us-ascii?Q?rTUOsDoiU8JczLPIkcEPvmM3T2vicwaI5lJu8h/5ifOdtNK8BOif/10ftNvT?=
 =?us-ascii?Q?vFR/B/e5FppV60I0k96m6o/8CzLSPSJgdrcE+VoU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vuVCnurKvRMGT3SZ5rCuVJaG7VwCqoAbsnhBiiRlQOzwLc4JiIVGfSl4sISXm7ylpE1hwT503SQtBRZSXtLrktkqWZL1eFsAKQFhrsQcbuT1KNOvH5l0laqtOFvQmK3aqCjfVvf7jpHz5rBR8I7bDbPaOUdfVdjU0H7cmMAAwPadVvj8W8CW1AAr2VRMcVqMx2jUngbhL7FICZNLLCcAUxlr8avqKoEkSQ/4zUar0TOTqduWzR9BauY18Qq2RCrCkQPbQlkzupxa/SZR7VCji0oJEeJIx/djWDFMZ2RTPgP+2AMHWM3DoGsgWelNrSz2EQAX5qUca66j5WZ2lDZRgVnZ9uYxMpFRtFltR6t8Ct+nFeWzoqmOjk6jd4FDnoZvgsEPq5oT0bt89Os0glVHDlARGeoNtPDF9hemxvgjnmpfCRJIxV2KAjYz1x0Wbb8Cqk7PX5q17QLO8QYDnOItP+4OY2E9Mv+TIJsHhE55hriolHplxKUBqAF5WeNJ+k6hTWyasj4N/j1zdlPiDNMfs48UjV8SWZurEyLUBxh0rb9pXB7JfN5XSZIA8x9LDLHJzk7EC7Dz6hKxx/Obnri36tOH8rUkXaxtRrXF/jTakEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a2c004-b24b-4721-9956-08dc2e47918c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:00:10.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5uPryHXC0h+2W9RTtWUDjUDjcprVnbPlLi/lXJdAqLiL3DQlIHf3oW59fRKILnBkY5AYYoMYQeaILh5XvDhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=911 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150136
X-Proofpoint-ORIG-GUID: rmYxf3c_BARMosyURxMafHEm1VzjznF_
X-Proofpoint-GUID: rmYxf3c_BARMosyURxMafHEm1VzjznF_

* Jan Kara <jack@suse.cz> [240215 08:16]:
> On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Liam says that, unlike with xarray, once the RCU read lock is
> > released ma_state is not safe to re-use for the next mas_find() call.
> > But the RCU read lock has to be released on each loop iteration so
> > that dput() can be called safely.
> > 
> > Thus we are forced to walk the offset tree with fresh state for each
> > directory entry. mt_find() can do this for us, though it might be a
> > little less efficient than maintaining ma_state locally.
> > 
> > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > there's no longer a strong need for offset_find_next(). Clean up by
> > rolling these two helpers together.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Well, in general I think even xas_next_entry() is not safe to use how
> offset_find_next() was using it. Once you drop rcu_read_lock(),
> xas->xa_node could go stale. But since you're holding inode->i_rwsem when
> using offset_find_next() you should be protected from concurrent
> modifications of the mapping (whatever the underlying data structure is) -
> that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
> maple tree? Am I missing something?

If you are stopping, you should be pausing the iteration.  Although this
works today, it's not how it should be used because if we make changes
(ie: compaction requires movement of data), then you may end up with a
UAF issue.  We'd have no way of knowing you are depending on the tree
structure to remain consistent.

IOW the inode->i_rwsem is protecting writes of data but not the
structure holding the data.

This is true for both xarray and maple tree.

Thanks,
Liam


