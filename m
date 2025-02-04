Return-Path: <linux-fsdevel+bounces-40707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22871A26EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6908A3A7FF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563E207DFB;
	Tue,  4 Feb 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a5Y+WCDd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XYTi0wqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933B20550A;
	Tue,  4 Feb 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663338; cv=fail; b=HpEuGVEEb2zxUvFp7rO9mSJLgUNH9X35Tvk927BPV4rozLxNbdNS7Lgv+lo6u+iG8YSKqKw/qRv/3auSfG/QBkng6Lpu5cDs/hOt6HlFNNC6KHBywoVwvjhffM21abx36rry8nfgfE5Lz1SjLzDQOUM0BINA4KPVwxp2DVxUm6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663338; c=relaxed/simple;
	bh=1WrbUFOik7x1Audp5E6CCoe960wT17Xw690e1AGLgPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaTG+BY/tdUbhYtV5pM9AlnXa+ktq6Nt/jfDyjLU8KIeVe/AQJWeGugn3RXkwGjo+1gnbjVfBtgq00sxLnKCI/25g/Vv7PBlA8Ns9ZJzwUgscPQj29sUpsYeCvgx1ji2JIKmP/rM7EH1WDSoi9kPU7S/8/Z5r73TEqtizKeUbRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a5Y+WCDd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XYTi0wqh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148tq8I030182;
	Tue, 4 Feb 2025 10:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=W4r3xGyP04U6gJ9p+x
	r1qQD9Z8YoP2EDq2SK4CSk0U8=; b=a5Y+WCDdXWWBMRQ50H4uZY1ugtj89Ki8gw
	ypevmY5tB6BdwrFpn6lDDqZHTzlMYlP11BKDTCMN5dNV1ETZDjgPBe5H7LQFirO7
	uctlgE0ewejy51vBWiRAWNFJ0V8w2p84CH5dz0MaiN1sjG4hWTgCSG+0C1MLEPd/
	FUWHLxCnz4tZPVDwEpuj/72W4JwpybPpLeQTRMT/qF0WSfXvQ4Jcmcihx6bzMepO
	n1KEfZJEfe/LFCD3BdRgqRE0swT9joUTZTiN3XbCeg02f0NAocGKl5+AOvmoy8TV
	JnD3MbUNkdpQ+723hlcThzdcdCawtNI4BTb/rF64yYW86Bl4wvfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtcgdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 10:01:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5148dSt8037890;
	Tue, 4 Feb 2025 10:01:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ggrexs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 10:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Daz1wd8tnzgeggrhb/E02G8xY5bhhlBv3zaXlMTtCnwUH/aSaLZyNFCnjFdm4PunsonAC80C0EMYDgXwQogn/xQusafPqQMcdshpEeetLp1qRq8rdoI6HemTaQHMD0zTFPmgAd5zEqxT4ry/Wzlbgb9lFMIkMI7pOpjWqMLzeuE9XPIDFHOgVAsa6gYpFCPgZ/k6uucIvsnJORULP3invOSOFcbDsZOOKzQqI1VFRCnrPisZO3mYNns34+EK1ZCDqZlC5i+L+5rc+Qx84dI89uQVtOKs7dt1FX+MTH1IqSbOj4V/kk6zNpiBwjAoeqR2kIEspefX/vcndzGRQzie/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4r3xGyP04U6gJ9p+xr1qQD9Z8YoP2EDq2SK4CSk0U8=;
 b=BqAkMsIh3d2jAcsb6dPRgXDCJd4bG18tMWkzWBZpCedxF+rnlgV+Gy4PTRtIZ9bYntbQhEPRGYVPxfxH2TtZMTFf6ti15GpaHhOwSJf7CYL5sDFqpiCPhXOI+wH7ROC5hMSLsyUmE+5T4uN+T4+q2KpZ5X7zMUE6qoLUw4kRtF5Qqpg3T/mN96fqQtuG0Cl6tMrZ44CotHQomi4ky62VJkRxnAaPUtkHHh3eZju5PlxRNpgeLFKB8PUN7FjQfMzJPfoNgulPLxQy6OrdoeiZ3moTRfBX6F4et1goFwue0O06SkMVaElDtDgUujCxu+AvOafGAtDi5aVmXmqt0zAWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4r3xGyP04U6gJ9p+xr1qQD9Z8YoP2EDq2SK4CSk0U8=;
 b=XYTi0wqh5xViIqi/6aemMQqb/4b5qjM6UikBENhxKgq9UO0W+ajahINpnQ98B5pfkXD+rBeA+JBdx+VsrZmWy+6SUcSsmo+OM1QBX+8UdNjHGe+wdDuAGSmQYkxA7HPkIFhMA8eijBDh3NRhgFc/H1pCl2QIIk2pSJMJlZ5Vu30=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6385.namprd10.prod.outlook.com (2603:10b6:510:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 10:01:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 10:01:47 +0000
Date: Tue, 4 Feb 2025 10:01:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <7a8a1719-466f-4e10-b1eb-9e9e1ef8ad52@lucifer.local>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250204-joggen-buddeln-29e5ca75abb7@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-joggen-buddeln-29e5ca75abb7@brauner>
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: e9da4012-d69b-457c-41f4-08dd4502efcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXtGT1qN51iCCtNovTFIuGlf9nqlPMK1HMmAzFYIt9UELMx4IjCFtQbtFlsl?=
 =?us-ascii?Q?U/6FP9yFnYeF4NwMCYjBZohPjm5fvSRysP4JnQ5ERghoq546lNFmi29X2VKp?=
 =?us-ascii?Q?75wFbNTVjy9q/0Ket7wJvToG5h/LqpvTnUdsuCHLNTXGydRaoNVe7Ae+jnCs?=
 =?us-ascii?Q?HAYcM50GsUaTuVr1giUcLc9ljliPMVtzdtkGnMUInPC06di/SAA7ZjQc7DcC?=
 =?us-ascii?Q?Dg0cvY8V5AadwWCyGKWqMQt3I9zP9WgvNenFEXkRmib9+9aIL4Qay24C/g9C?=
 =?us-ascii?Q?xyPuwu4XmdefNCaesbNDD5UCDY/STcg+gQDy/X08lUp+cLM0lQbYyP5W5SCD?=
 =?us-ascii?Q?MnjZyNV1crq7WUsHudLTm6uS6Dto11Nd5xsUDVbQWfE4Dk80ArNRa1RibhNP?=
 =?us-ascii?Q?PWokWeLjOErhwJMoLBdfLe/l2DQM5e+yHzFCXinjBhhWe90pP8aC6WzV3x45?=
 =?us-ascii?Q?bWRwEzC009Raya8sjj5Cf1PoEOGdbRIK36iFsxAa1Fnmn2hunU7m2LoCxB2j?=
 =?us-ascii?Q?G5Bmp5bvn+WSn+qmet5x5azEYUxIaGNOoeY6FVbuv6cJxG6eXao4rtLMg+QQ?=
 =?us-ascii?Q?uav7oiMfjWT+EX8qoYT7gOpQpgCmPQampx/TRwsu7Q4l5P1dyrOZqBkeO18g?=
 =?us-ascii?Q?6qaCy7IMRJPcRtBfTZordT1OSy8NLKK4ChqUyiSGKvl9cPIaigQkPSNwXK++?=
 =?us-ascii?Q?gBqVR7ahExzJILp2aRnx2OCTmxpQzX063YXqDNgXArOiyUSTQSjitofCzNrU?=
 =?us-ascii?Q?HmVTdoQnpWfKv/oVZEL6BahV2Z+8dZso9grp11Jdas/CC3n+bRbvKPYUk28C?=
 =?us-ascii?Q?P06cE9rMHb3P+FTodowzdmIWcz34pDKnOXh4UmhF9rl6LlpqLZb8tTLrQoSQ?=
 =?us-ascii?Q?Mj/IJEDC9GuQ8lOYxJ07QPG9ewnyA95Zb9op159SKis5H5kjeRssnvCg+sV0?=
 =?us-ascii?Q?0kCBGJh1rTcODiVMao2b1yR/6CqY7g08lFfc2kT3VAq3sF4Me2lriZErSCCZ?=
 =?us-ascii?Q?smHNg6Ril3EmgOrD2RbYxb2s+PCwIUstTlpdlbW5iYJ4eVhybP/vqczMvXgE?=
 =?us-ascii?Q?n7ctvfxdiuFGVoq7dahjN1YLxNJjWY9wkTs6uU4bDPuHIn1ZKbawGInFm6PP?=
 =?us-ascii?Q?IN/41UTJ9ZO+wNvQhLa2weNfswper6v5rvPCp9+DdS9KB2NdB6NmCib43YoQ?=
 =?us-ascii?Q?dC70DJdutc5uwjN44j6ekIRk1soCgyb9UIDVYIRvphMQCBWIoTj9bJPE2EVf?=
 =?us-ascii?Q?OCXvTtKR0XxxBqmhBgzTKZ7qTvmTyQmeE0BLIGkUb7YofqVqLNg6/haAuVlx?=
 =?us-ascii?Q?4kb2jhIUW599MdgqBG0P+TuE0Psj5dsN1guccHZRL7S1ulr35gEPKGdTXdZr?=
 =?us-ascii?Q?pgB3l2iV/SGTAe0jzbAt+fAvU5lB1A2FvMOnS+vCPPlkjMu/bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0TiQx/liOL/bzDtvOXQeSi0Zm/JYczVKM28wiYwmzNprX3JWPLQJ3/OvvsAZ?=
 =?us-ascii?Q?yvJD1shk3mNG6orpUAB5Z9hssFGbUPA8Qa/u0AHMVR6MFJEfgoqBNW36sns6?=
 =?us-ascii?Q?PuYxCVrFca8pur+VtVMafzhQrqiLdZu3aAUXDWI1xlCiviCyjFKB+6x4+oKV?=
 =?us-ascii?Q?MhPyYMXLIorkoNLkDj5BgQphGaQlDmTzZu5C9dEUDcc2gLch313ovpxLgZUH?=
 =?us-ascii?Q?CEj8IcSymxekkShQ+ZxfC2sOjeooDfTVvLwA+0V7R3xCI1jqJ5JHn3C2qdi5?=
 =?us-ascii?Q?o5iWGM8txuIkFQtmGONFGHI/ANBTtzHPEg5lezitJpwqoguDGn3a+oolEcd2?=
 =?us-ascii?Q?n43Ym45J/SteDmA4qE1gRciuQK3WapNocZZJZ+0hx6m2zIBWFU78R69eqNcD?=
 =?us-ascii?Q?J4gR/pRF/81+dAmX6UuWHdnKb+8RrtEk40Pc9cDzVKsn/pyi1nmBsAIgS6F6?=
 =?us-ascii?Q?Uiw43J0Nbqu3COstTR0Cy9CqTT+2K5PfU4GQ14K3LkNApWZKtPghsUnBl3SH?=
 =?us-ascii?Q?HU/n2/fJ3JrpeHfyNmMW21gYTfi1jwYk7cViL+KGtWGwASy8ir1UW8BcKPs3?=
 =?us-ascii?Q?wwrbEyjcXPFm4WjawCEFz4d/3AP15p+5ylmPahHEFMRyvImHcupOPKgkMUex?=
 =?us-ascii?Q?D7wdAMGe7bANTo7pGT4G5zYoBOmg9gVGj/CIc74L0ydG/MtUjyQYkVnvGs7N?=
 =?us-ascii?Q?HWPws+7jxKXq+l9WQsSjaGOx4NQmx977TbrY3AZtGDd8EQJguC+fNjRaOAbD?=
 =?us-ascii?Q?lKORpkVfDdG3wzQz9FXvRlzi/LLmFxxlk4gqDqPMbltAi9uMrH5e71mt5cSW?=
 =?us-ascii?Q?Ln4HyJMK7mGR9VQpCFbEOxfV+QEiMqgh4LBmtXHGt2ILRqCW46YpDzsPym5p?=
 =?us-ascii?Q?uAy9+zdsDTnX9k8lYWlwjyla4toXoOcz18AcB0REa3sYSGfYHJeQVaC4gguw?=
 =?us-ascii?Q?6Yxgt0R+AuT8jKGwBhd/4hFCT8smWwYusY6DdS7azGa8wA4dcn6b9jAiC6qR?=
 =?us-ascii?Q?9ORibpI2pi4ZokJPPeJ4xZLNZdb/GNpi4uQPxAfP0SRz1TKU+NDaDWMgeg1E?=
 =?us-ascii?Q?vggKfGLPpkPuBh7QlVbVVSRdCvLbF3/7AnI5qGC7+6BQNN5h4Daibi52tIqy?=
 =?us-ascii?Q?/r5jUMAwETV6hnW3hL/G5T3B4FbIKWf9iJlhC6XCDpAOftyPNEn5vdqRL9+B?=
 =?us-ascii?Q?8diBhGVpumsSkaS2lbhcXF6EhSFXmGXEpBnxKlZ4P8xu/iUtSmdUAznOAaG9?=
 =?us-ascii?Q?eutP3DxFT1wu89jSwaRH95GOmErIcri5beWYG5h97rnwbVL32+1FcWmaQuVi?=
 =?us-ascii?Q?MLabjkUUKi/VXTe0arSq8GtqxY8rBdls2lLBqA8i9hmoGqZv5ivZaTVtj61R?=
 =?us-ascii?Q?fEjQR6Gq9xha5UfwEqqhXrG187kghVV196mF1G22f8iyS0yrYeuPKbRnrbzj?=
 =?us-ascii?Q?DbypnAhsLJ4IF7reaumXnchqC2cBnZpv9+d7Eebv1CoQhtsUENXCb/WaIxUc?=
 =?us-ascii?Q?+nmjgwdgM7e6X4cHUgLqA6I4VssfnUW9kPdLK+C7YFjquElogE6WBt0TOGsj?=
 =?us-ascii?Q?bK8EY2vKjGURPO4jysNPxHqMajT3u1Upml2F8TK0V3PedJ7rU48OXLpxBnCk?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	196jZZ2uq98aLmCIBAxORyxE2pq+PlET6gvyAmqsbR+jhluhaSOr6unCy1HgKwgNB350aMpMbPkIP8T7RxFPO0SiI317w9mJeOqo3f8f+fe2hUCdowifqrNAC28PLiWS3avFu6so+HpAaB1pp7aO+4+/L4wj1/osysvh5DMJRLh3sv25BxsyTI5zc0UqSt9WibWj8HXD0XxMqRNBn6GTu0xqzABioYo0IOFzGI7Z5VxcpH4n3rOx+io0RMC6qCJhYoPv8tgEVY68+L2YPz1Wn5jAn2alMrrCuxCR2MKh07OlBUIugVmtujwINUKOzidQYou0l9DlGgLE9/DCxTr1N68gsT/Xge+cdpQLlTMC4AbG3XIrNhYQOG1Au71qjuP+fzld/8yzFa/G5Lc9ZYwQlrCTUWaOt1CBHqm632OhuqGWmOWFXsfNClPJrAIjNaaAUkPfY9yIcqnUSmtvSiTyNpgqD+n0k5ZUYl8BWXOhTdXm9d1XNf5FNLKXsMNFCuin3JvaXLxmNO91GrrLJ5g4HcH10Z8TDtqSTytetuWdCTOmVWlKzq4dxC3Dwuin42HgFJHGQgacM0arUWxOXKmUsPbpAPM1QR5xcWoyBhEiQdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9da4012-d69b-457c-41f4-08dd4502efcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:01:47.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HOtuE29oadft3NbUDoDPtWhfwbanHWFobw8e3+AZ6CIWuumEeNuzo/DXXClJKMVyCIiqKro0MlTsEgWFdQ/rdW9qwyCucsITXf+blThuks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=760 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040080
X-Proofpoint-GUID: P5doZAyptgW2PkBtXWiZ_4LBTFYHjHWu
X-Proofpoint-ORIG-GUID: P5doZAyptgW2PkBtXWiZ_4LBTFYHjHWu

On Tue, Feb 04, 2025 at 10:46:35AM +0100, Christian Brauner wrote:
> On Thu, 30 Jan 2025 20:40:25 +0000, Lorenzo Stoakes wrote:
> > If you wish to utilise a pidfd interface to refer to the current process or
> > thread it is rather cumbersome, requiring something like:
> >
> > 	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);
> >
> > 	...
> >
> > [...]
>
> Updated merge message. I've slightly rearranged pidfd_send_signal() so
> we don't have to call CLASS(fd, f)(pidfd) unconditionally anymore.

Sounds good and thank you! Glad to get this in :)

>
> ---
>
> Applied to the vfs-6.15.pidfs branch of the vfs/vfs.git tree.
> Patches in the vfs-6.15.pidfs branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.15.pidfs
>
> [1/6] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
>       https://git.kernel.org/vfs/vfs/c/e6e4ed42f8d8
> [2/6] selftests/pidfd: add missing system header imcludes to pidfd tests
>       https://git.kernel.org/vfs/vfs/c/c9f04f4a251d
> [3/6] tools: testing: separate out wait_for_pid() into helper header
>       https://git.kernel.org/vfs/vfs/c/fb67fe44116e
> [4/6] selftests: pidfd: add pidfd.h UAPI wrapper
>       https://git.kernel.org/vfs/vfs/c/ac331e56724d
> [5/6] selftests: pidfd: add tests for PIDFD_SELF_*
>       https://git.kernel.org/vfs/vfs/c/881a3515c191
> [6/6] selftests/mm: use PIDFD_SELF in guard pages test
>       https://git.kernel.org/vfs/vfs/c/b4703f056f42

