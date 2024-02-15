Return-Path: <linux-fsdevel+bounces-11757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6ED856F12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AA9B21117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CF13B78E;
	Thu, 15 Feb 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QxShOGmO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7I4arqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED513A88D;
	Thu, 15 Feb 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031286; cv=fail; b=mPwczwLo5nhEAgmcxB2PsJ/1NBRGYktXozWuQCw86YgXoJ6FfOU9S/EqKz93b1YpY14E845IrzHlC3vYhPpmITtsLIq2aXGUsu+oma54lS+G1SEiSyzpCQz/rAS1Zf+NKoWGb8kQsvyTdpWXJy7W35x1I2VVSXpGtKbYhyA/2y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031286; c=relaxed/simple;
	bh=qJZvs+7OBJxUmBc+jBrZboY7c6AVpasmWgXiQ1sdD9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sltCY9YaLGV1nsJGS/dJRoy2dF7xj3u/zw4e/xkzwsXpWQiaBcFD6to/gH8UsYPepvpFwB01+sn6ZvbHTlm9KpPhB5bm/Mx54XY66WH5VL+tdna8fws7QxQWYJo8UhYCCUUDkMcc0BWpJx9W0S5Mb6eQz7836TyAeMwRPe1K5mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QxShOGmO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7I4arqQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFTYuK030226;
	Thu, 15 Feb 2024 21:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Vrd4iJpJZxtEfl3fuzFtCr3m4o08eosQfxcmdECrRhM=;
 b=QxShOGmOlvb9mPoZTjm8WNNl18O+iUKE2MgGABHx1SpHtsb3grXZJTAkwofTgegcwhME
 XZv+SMouLULunI8jLHSWQgipy8KmsgHNmR7Q/7xjCAuwEM94gDp1F4o/tJ+SVxMDeV7l
 BKM0qI7+f4QwpZ2M17gz3XNqEo1t/0MPSD0cvHHTT12Ka31rw//naXVmnP8ZPT7btpZ6
 UdpWsJyWuZEMqlSh8xchsyVxSWdCjaAC5V1P28T5RJ+NjdpGATtdtWxyXf7PuqRiejeA
 m8H+YSOny1XdmXVqSG9rtJAYz0/xaMxns144VQZxMg0NV8tk3mISn+MLn+KpI87ZSD50 mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f03k87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:07:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJqVs7014963;
	Thu, 15 Feb 2024 21:07:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykautx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:07:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIED2/UZedpvg5/UjbFewW7N+pCo4GyVoG8u9EC8DJWjOv4oCYEzmqOXIX1+FH60h0G7lh7Z+KmIezKODb+q4M9ybitVv3Qq4S03JiCj0guRTdk99TBzSy9jjORsKGJic9JzmYtHDajVtjtcqXbr29vLuE9puqr0bjks884AWOfPRTwpvkQDT4bJGmI4JBv/DZoyb8YlYqYV5IdAXeOhzlrt20EFM7/pGJPY+0UoYoosyu/1YdiKScc/eDnNJjcUDt5bSJlM5cgeF6hosI1CwwI0c40A8YbWwk3VkuWlL1eJ3pvQv8xtIOsOprXErTw45cme7C2tcntrkcMSQ2Tj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrd4iJpJZxtEfl3fuzFtCr3m4o08eosQfxcmdECrRhM=;
 b=TzS/V7pg0cNhyvLRhcD9CIc0eXKcQMpkBFRLYkJsad9NIITsLO2aDdx33Ud/RZV6EPpfqH1RyvylXFt0UTHeMPu4eDNBxP5sh4XEQaBnfg6l7DLigbrZS/q3MfecAa1+dDcl1L45Xw18HUnvSV6HAdf1Q9BsHkGRNoa0ckqJRqynO9TSsP1iyYb67y+0Wu2r6HEYc3ba7xh+vLOMMiVa84NaUA62qAlJM09N0zzqm2J8zB2YytSZUAa1C9gK81x94Iz01T/Axxgc/m8faP0Y3b+1svLH72vTdKrPc4+MfT/Jaxnz+KkTlIExEt2HGjuCJTZ/FLOCa4R0FK7s7FivsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrd4iJpJZxtEfl3fuzFtCr3m4o08eosQfxcmdECrRhM=;
 b=J7I4arqQw9URQUcQqzAkt0KX/A92pM65E7kCflc+KyM8kfZXfq2SM3LPaUKKqPc5jjDpgeugHVN4OhxRDGYM/BFW+NXuYpsl8rbgjvsZSVR2Vnc/sHAeZj+uwzKzWqStwY3rovJbi/uGmM2rqt61bjJWSCLuKjfWbtzlK9xtGQA=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:07:44 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:07:44 +0000
Date: Thu, 15 Feb 2024 16:07:42 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hughd@google.com, akpm@linux-foundation.org, oliver.sang@intel.com,
        feng.tang@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240215210742.grjwdqdypvgrpwih@revolver>
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
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <20240215171622.gsbjbjz6vau3emkh@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240215171622.gsbjbjz6vau3emkh@quack3>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::28) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 095c067b-bf58-4855-3c1e-08dc2e6a2763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WNnxxstXd6zPfodx0IF77gbHGKGE/BbhEPLlfdkkUl6maBr90kyNF59PujRmY7VzOSK/Ey2vYXzj73nmRFOUu2txMo92ykhls0xaNBD4zg6W4BoOWLthaxjzMwOlKWbn29YqLIQaIz58n3qUULXRjPaPPzKXDpV5e8pJ4K2k3xjc8VjbdjcJrwquIotU1+CWSn41UAzxVagB4fh9VkTBeoKgzybJEUtW3ThCtmde4uzi47acyIZBbYY5cT+iPJaVgml3jLVZ9WeKgnrfN9/8ZfKwRf90iL5Qw/97HVtYprMmiO02cxeVAif3rn5H/nmtz8+UhQ2eGt3vNh+qNUHe0bHax0SbBd4PjoDoA70iDNiKmrq3pyk6WklDJidg5dNswSSUaQ2wuZZF7wuK8qVb5vPW5Y+AKmxwh1kUqnMZfe9A1+wx8mC4O+nuEda3/E7SgYt0mo1pFRH+SIHVEmwUxubZuYAsA+RsThrUAXHXdYWDdebFFr1ABLtYQBtjcMh+9dgp4qax9Wfa1RxF+hFds4fT34giO4xTSWEEm1PzOeGtfkPUo6TR2zwA715ciDWO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6916009)(4326008)(5660300002)(66556008)(8676002)(66476007)(8936002)(66946007)(2906002)(7416002)(3716004)(83380400001)(1076003)(86362001)(26005)(6506007)(6486002)(6512007)(316002)(38100700002)(9686003)(41300700001)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YqQGbhCfp2ml2q2P9oTmnK9ZSejMgKnQVTDR8f5KV42CLPERhP8dWe1I1qmu?=
 =?us-ascii?Q?c0mQlWpj5F5xIUfjccC0Mo7muioEgUUpTw6f1Cherg5BU9AQrDgtQhCcLd3t?=
 =?us-ascii?Q?tTJiR8AQ8fi/NC9ckSaUd6JCQjRouC44cj7AoNKlw18O+Cuy+3C3YjIA4XJf?=
 =?us-ascii?Q?mFC1WxZPCTY0ZYv35b2tsKlqNxAe6fHJoSiZPyk9D/Qg4I4y5Lc3UNZsejGH?=
 =?us-ascii?Q?J51V/jwC8iVmKGX/ukp6cFM08LN0B73hXgDYZIPLswQnCY8tbpvpOh8OeK12?=
 =?us-ascii?Q?5Z8/O+RU2gBYsYOFod2+9TLdYt9XQwow1HLaMR34MZF3WAgAvClYYL/h2cEI?=
 =?us-ascii?Q?EeFLZZdNB8K1NDDZg3JJk7k3g6Hs9/LtPuL6mCe2yDpGcT/b97JsIDyCzac0?=
 =?us-ascii?Q?/u9Ge2WutyX5p8e3AkUZzGqeyjWovylA3xxnn4xS1Vhe2ZaF6XE7aA6vqLEg?=
 =?us-ascii?Q?eHWt2AcHEYiTO806L/L+9aI5mEDewoCGIOKisyx4cL455d8/+krsxeFBiRsA?=
 =?us-ascii?Q?/jvKCwuZUhPnBgWftcN9myr0VSZpD/aKNidxwHIx9oBBLYkJ6wnHoFRhJFO/?=
 =?us-ascii?Q?nq1C1UMeBIbCrJcs6o7bMnNstQ9LaoxyUeUkPvjDSRjIxb/3HHSiO9o0TPpO?=
 =?us-ascii?Q?yEnL5Fet4o+vad26R6alO3EECws8l9McCtAgdlfLHw5f/ato2CqAvRWJ4BWK?=
 =?us-ascii?Q?HwOODz4YQu7H2V4adG7jcHQZPYDFmXEcFvsuN8PzN31wdcEGkuse2qZQoIkG?=
 =?us-ascii?Q?1NJV1+6du6jyGBhTBG9x00JHJ9/5xO27JWLuOZIKSrKYZfcWuWkpd98T0tLp?=
 =?us-ascii?Q?YFDH54ZGGEdFvzlQjtdL2BNxyAeI3fOYk1frj+cbQrDjoDTV2WVe0RRz1qXL?=
 =?us-ascii?Q?62o8257z8TekVn4gDdQbmtQnGhWCaMjkuhZUaXUVKUmkd/ddsinsS1uaglwc?=
 =?us-ascii?Q?JKcO6ID9G6UACf3zSzzmapfWzTmHv+pnXu5WObEjzDATVyhpGp8YbCDBsY2f?=
 =?us-ascii?Q?UPxTecJVedphJ6eF+qYpLlRrK3l2vjRqAEGPUOaBeV+uDfPhwrQ9oW+TCyB+?=
 =?us-ascii?Q?c8o6GAyE6l1nyXLBy8gabfWp0WKL0kDDuf+nA0OVl0mQOfs7kJs9hSPeyM4N?=
 =?us-ascii?Q?ZnDZ+LnphV9PB2kVGiPrJaUcLk3yKmLYLOeuuylRQssC9qEEHBvJcZaxtRkt?=
 =?us-ascii?Q?iuLjVTGwbg4l+SWhnIJqvxsJ7pZRmEmUSt+MEM/MqH4Ohv/tQDdESa8eHXjP?=
 =?us-ascii?Q?YQYPiScU9rpOXtMVRYPtwu2+Z6NNtgSxW0r/lltC0BYG3sC+2GpqNvgl7rOj?=
 =?us-ascii?Q?USK/hE3sBj5LUxHYx1QnQL2N8BFeZdlSBQY2m5bRFC5UJEkqMBz5fI9WJslL?=
 =?us-ascii?Q?dvxVgTV37TfavE62hxL774u6YYqkKp6c6bATypUKUl48oT4TlFrO9R/8bJVQ?=
 =?us-ascii?Q?upX9IsTAWYUKhU0JOFBeZo0DIAJsMa55xBguIrUS8RbCJrHM29M5hnpPkdpu?=
 =?us-ascii?Q?wEzTZlpOQaA50jsE9UCtIy/dTxmyORlPL7Hw58GgUWkX6Hguuijj5xXILkor?=
 =?us-ascii?Q?CNd4gjLRjQKKV0buMF7bP6Qce72yC46gtr9wx3te?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8wOjAKhZxOd/Di9MB6W00ijPl+u5OUd2glopO3Bz356oYDsHce0QkxNtRePU6UZFfUfeCdsx+yz3/FtqZA+O0MP0rXAUx5Z/9jicXT16DyqJItr+Btzljol8qw2QDQQnVVm2Yx6Ksh1YPOIiI0hkbVJikwF0Okjrp4cFyPQKscsqc4hSFzGmAxhHsufcyfzqWiLXdBMwaThH8jGpnVKm2HWnd6mud4hw1hs0SDyv0thiN4RiHFE4RBnm8nu081/6WqAvUnjXULUrSsFue9iUQBxneb+c2EFk4YrdMUVHTAy1X8ApTrqdT29nmOhEydng8VN64j3MdE2eQe2z8kC6YNcbXbAp5Xf9w5BqRLXOUbPSAlR1UuB8tC8P9Sswpz58neQmoV3zpyy2l1laEWNr99MpOBxDkZFz9MowlVRf8OPb6qqoVB9wG4p6gL+KDtxwzwnTahsXUh5v7qvb6CSt+3RwQwdtWdXUXLMbkmwRw5BcknWhFpxZdoywzpWvQYreMgi1tjO6UQ7NHzPiWXYeP387ybX8t9Dz1oh4fH3BwSczeOEBi72aIHooUd8gSUqKwfiTIpkGxgFH1E5OCFFZYTpNsiFZCp4em3FQQ2vOh5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095c067b-bf58-4855-3c1e-08dc2e6a2763
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:07:44.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /imG+1tIs0pG734t8k3zr5bMJo7cXjQcqMxOVzXZ1sUn5ffox9/zezpHa2s9b9uCHBAG8hiYzPnoyl6lBQjbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150167
X-Proofpoint-ORIG-GUID: -Y9XfgYD3_Khz1uAWvqhLNTby8eBkbrN
X-Proofpoint-GUID: -Y9XfgYD3_Khz1uAWvqhLNTby8eBkbrN

* Jan Kara <jack@suse.cz> [240215 12:16]:
> On Thu 15-02-24 12:00:08, Liam R. Howlett wrote:
> > * Jan Kara <jack@suse.cz> [240215 08:16]:
> > > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > >=20
> > > > Liam says that, unlike with xarray, once the RCU read lock is
> > > > released ma_state is not safe to re-use for the next mas_find() cal=
l.
> > > > But the RCU read lock has to be released on each loop iteration so
> > > > that dput() can be called safely.
> > > >=20
> > > > Thus we are forced to walk the offset tree with fresh state for eac=
h
> > > > directory entry. mt_find() can do this for us, though it might be a
> > > > little less efficient than maintaining ma_state locally.
> > > >=20
> > > > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > > > there's no longer a strong need for offset_find_next(). Clean up by
> > > > rolling these two helpers together.
> > > >=20
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > Well, in general I think even xas_next_entry() is not safe to use how
> > > offset_find_next() was using it. Once you drop rcu_read_lock(),
> > > xas->xa_node could go stale. But since you're holding inode->i_rwsem =
when
> > > using offset_find_next() you should be protected from concurrent
> > > modifications of the mapping (whatever the underlying data structure =
is) -
> > > that's what makes xas_next_entry() safe AFAIU. Isn't that enough for =
the
> > > maple tree? Am I missing something?
> >=20
> > If you are stopping, you should be pausing the iteration.  Although thi=
s
> > works today, it's not how it should be used because if we make changes
> > (ie: compaction requires movement of data), then you may end up with a
> > UAF issue.  We'd have no way of knowing you are depending on the tree
> > structure to remain consistent.
>=20
> I see. But we have versions of these structures that have locking externa=
l
> to the structure itself, don't we?

Ah, I do have them - but I don't want to propagate its use as the dream
is that it can be removed.


> Then how do you imagine serializing the
> background operations like compaction? As much as I agree your argument i=
s
> "theoretically clean", it seems a bit like a trap and there are definitel=
y
> xarray users that are going to be broken by this (e.g.
> tag_pages_for_writeback())...

I'm not sure I follow the trap logic.  There are locks for the data
structure that need to be followed for reading (rcu) and writing
(spinlock for the maple tree).  If you don't correctly lock the data
structure then you really are setting yourself up for potential issues
in the future.

The limitations are outlined in the documentation as to how and when to
lock.  I'm not familiar with the xarray users, but it does check for
locking with lockdep, but the way this is written bypasses the lockdep
checking as the locks are taken and dropped without the proper scope.

If you feel like this is a trap, then maybe we need to figure out a new
plan to detect incorrect use?

Looking through tag_pages_for_writeback(), it does what is necessary to
keep a safe state - before it unlocks it calls xas_pause().  We have the
same on maple tree; mas_pause().  This will restart the next operation
from the root of the tree (the root can also change), to ensure that it
is safe.

If you have other examples you think are unsafe then I can have a look
at them as well.

You can make the existing code safe by also calling xas_pause() before
the rcu lock is dropped, but that is essentially what Chuck has done in
the maple tree conversion by using mt_find().

Regarding compaction, I would expect the write lock to be taken to avoid
any writes happening while compaction occurs.  Readers would use rcu
locking to ensure they return either the old or new value.  During the
write critical section, other writers would be in a
"mas_pause()/xas_pause()" state - so once they continue, they will
re-start the walk to the next element in the new tree.

If external locks are used, then compaction would be sub-optimal as it
may unnecessarily hold up readers, or partial write work (before the
point of a store into the maple tree).

Thanks,
Liam



