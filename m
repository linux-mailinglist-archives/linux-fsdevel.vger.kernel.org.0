Return-Path: <linux-fsdevel+bounces-22106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1A9121CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3AF1C223EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54A17334F;
	Fri, 21 Jun 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q1fTyfbK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h5LcDJJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF116E892;
	Fri, 21 Jun 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964516; cv=fail; b=K+nrBfoDMLT8gqGQ9txpa4iMqzyDYPd2oNdUuPnTeuniHSkQMtdtIuTnLibdVIwyV1XOMOPN5RTTX0OLXuF+LnMBbi6odJ0+lBh+id08JAlqseIeh2L7W9sO2UE83WROwCte5u/fbFmzVB/iA39v+goHOU421/tsxuofPZkBg0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964516; c=relaxed/simple;
	bh=9FTMcA7rkZfmIgyL8VqAmzt5cNENoCeG0+P/w6VgWLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeGcz/diwPd4T2aVg0bR5UFRY/7m6uN8UJ02/K7RPUwgpKoo//cEa96en9HL8pm5iK5SuwOTdRLdnTGE6G/S0znjvjFJHNEY3ygqIhXKUbEKKRdELWVuN9CPiQYhnMO/mRJsa8g7ir9YGgMZxFFI0yHf7kYw9QCcuf+09YXiv9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q1fTyfbK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h5LcDJJs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fV32026946;
	Fri, 21 Jun 2024 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=; b=
	Q1fTyfbKLO3kvXmKEfvqXsrsoVdCQ05rtpr+CWHix8VwIni/vuuoW52V0hDAwWNT
	AWHvvT9ZE1BK1zBAA5KXcNnI28ReFNnnr9rhBJl2mGIqAckV0l4/nO3LBmip1XI9
	UfijRdh6v8/b4+p/8zkqf5a8WlMFX+pwujqlqPa09jxUPR48zO6kwwUbZwuuWdie
	vzi+Ae06DQQfQey0ZrzC+whU3ilBUghXRYq/evQJ4kE4WNeDNjJdZozd809D40To
	vl7WYbbUE9Aan1lLoQVqmEz2b5bBwVqusZvmUiKUEIYYvK4C3Q11Fh73OY8VH1c8
	D60ArpQLCNieozFK4HRRdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkjsfp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8LH9M012928;
	Fri, 21 Jun 2024 10:06:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4erd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkvPFIEM+SxUk5KyjHRn/Hamj4Uy+9fiFU+d27wkcoR8xxJ0WfuA6U34aW3A0dxEjwqxH3dmgFRbqZL6ydS/CoA/QTw6Eqpqim1Gv+E2GLnCIemplNpwmGjhPUzlXAbYAPqHh/LNitDE9wExa9MmlcZFmKr6HpQOOFQzzpPWCTcEQ+6eoPAw7NmeWLD34tIj3dtE5545O2c1ByM8dQ717en9h5AqGwYGCkmAnVQ8hxEE+oqRgu4IO4jQQ/B40i/EIZu14X2sXgIj2DnBZILmR9D2FbGLRzjhUQmXWg5uawoUw6W0YNEX4t/RNtbp2sPA541Q8Rz5rdrZdWwmGh8gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=;
 b=W5ypj8bV2b7P6Qx1okXw9a85UT/5LRsET6mQ4g4PQXo+qme2V+gtdNF1DPD0LqoVbWB67Afdf07V+ATHkK+Iam4eMpbYK2+0cExVSexBGUTrR0LK1kwHHrN1Ky8wnNuaRoMSDR9YZE1J7A0HGJmgEnzink+qwceOveO5DVmUPNkMTMhbyF9qM78nRgaJ1qkSyTRdcekH4wiQ127npznz9hcYKNfFSv1LTh+pxm73JZitYl+DUQQiNtCjOdIe56MHyUgbTGXsIe+6RaHy51DnrN4tF2Cx4Wjht/5iQUpVa31+0VPNAzFnyzMrIa1ic5nPGB6P5Ajb56/ukuOlRe3y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=;
 b=h5LcDJJsCk5sUICiWas0loFaYiCMKxjHu6M4P/7Zo3cs4cZFBIfcdFjCTF+h1GI0PEWfjXQ1KIyDlv8ikayCRofPuC2me564ABdispaKBZQGxjgIR5Q4HK6ZNVqLgL0Ou2zSETdI6bk5wbKQyEkSQYjRPGJtw7o/4Qhj6o9cJ1s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 13/13] xfs: Enable file data forcealign feature
Date: Fri, 21 Jun 2024 10:05:40 +0000
Message-Id: <20240621100540.2976618-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: d75f1902-84fc-43ee-ed7c-08dc91d9cd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zuBeenhKtI4ihsTPdMgBhTzRg9isOXJHCtJF21J9jAZoIUAovmjPQCDi/Rhd?=
 =?us-ascii?Q?voDrR+WWJ1ChfZqNd0XheV24jziP+jvEIkvlHBh/KL7ESxBbQ5lC4FdY7fct?=
 =?us-ascii?Q?M9rZhSv8iypcZuayCF6WFYqdwukNK+8vK4bs/H0RXQsdSBu0keOyspVM6T22?=
 =?us-ascii?Q?Rf3Zv+4DpjDaSazk+jdlFvodgEQQaFMtFg3Arq7/eqy/z2jtTUmkUyUqL6J/?=
 =?us-ascii?Q?w+39hbEopffkuwFsp2+o2qxOti046mUpfjIDU754JoD5V5ndqY+rUa88k49s?=
 =?us-ascii?Q?GcR3+siFAnVwMOuQavPbJn4ROiqMwHAtgyGHxcekden/68BFFdpNEfEgjBL3?=
 =?us-ascii?Q?A3mvd465LypUhTr69q1SZDj67kNCWGfqxmsckRBUNzXELRwG+Plh4eluSoMF?=
 =?us-ascii?Q?y1WfrK30blcstjGISoj0yMU45a5d/sKPTj0UN65aZC3l/T+LI5OsI5itozI1?=
 =?us-ascii?Q?NCjKr05vco2d+U8b+WuE0WawgLN3vjw53kVZ6bQ8Mv9rYykIWFyPXnjr1iGv?=
 =?us-ascii?Q?2iRn/QRELxK9EM0uHUxKuZfBD9k2ZhJhSKuLAqWSbNwQE+UYWxWNQOKGpSQ4?=
 =?us-ascii?Q?SuyiSF6vnAABplekTOn678u6PT2E5mF1vI8xqzXICROvxsFeMcAC88V6pcCP?=
 =?us-ascii?Q?HQSjT+zmDCZo7pKO6IS2ArVdO9PKVHfy4hXO4W3/E46HwJciUXVF/OELnuwJ?=
 =?us-ascii?Q?5jS0ZqWaMBvTWER1Z2ipqO2Q1iDdmC8Vfq03Akf4Ql8oNbKeSuwGecFWwfoU?=
 =?us-ascii?Q?F49q8Mk20Q2Wk3tSS7sXnRj5KQt4fWrht0GpWb8brWyL0B8/r4IjLW4uiQ5x?=
 =?us-ascii?Q?5jF1QPTLyZBsSK2ckQmbPSHOg0BMnDIE6fpsxhcneu9yaa2Pj0QUrrjT6NRM?=
 =?us-ascii?Q?sH5hkIqhuwzQ98BS8s7fMhT+L8LSCMGqHjC4Hfphm0vZKsZF9sdFP6R8/01K?=
 =?us-ascii?Q?8cq/n35l9RTol/7/h8SDLJ4qK73kUwJdEBB//L5L/COtiB1WJM+WxZ4kGd/4?=
 =?us-ascii?Q?759nI7hsaNbJFj5ljszk5b8AS5wFEdF/YwgY6iE3q8Db1pf95Dd+040hAlc6?=
 =?us-ascii?Q?w86oODrLGAYhyvvHfKG9hLPvLtdygckq0oRTsa5lO+JxnN7fHBEHTZPDxht7?=
 =?us-ascii?Q?tM22AgPBwG8ZuAwN1/rj05D5ScKCotik/6/kf2UfAAG2lssu2v9NNyNiSNj6?=
 =?us-ascii?Q?Ts1/NYnlyRMb3rbFGD+nj0W0UNtIbLeQjUyNhTUYvqPSWsuHJg11++auud4W?=
 =?us-ascii?Q?Y3v1aLINBr17nAg+qYKSap6zXoysk5kFXrZCfDSoMLD0JGCOVdbEj7bz4sNF?=
 =?us-ascii?Q?waaeMnCugDzjQPA3us5RwRWW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VL4QDDJnJvh7dgxrmQaigG5H3GrQH5sTa0NjZUYQ1GZa36sjJodjTNiyfSX0?=
 =?us-ascii?Q?jOQMFD4sYQg/NUkZTAOIUi4fz6aNrpTHshx31HphqXTl/r4BibMCbDRksfEY?=
 =?us-ascii?Q?hxIsoh6GzkblMJnF77t+grAlnZHzcDQia+YZEyW6BAvaCDLs3r+ztlWoECAT?=
 =?us-ascii?Q?4hn0ivJjOPF98OzYaubhRPuilAu+bl7TcYuk6joM+RFoeZNg+b5EYuP/OJhz?=
 =?us-ascii?Q?2UWAi20oyZO7yGSnOtiUG6EbeoQuuzKhK/WtYT0CvAwsuBjOcQub3lSwM/ge?=
 =?us-ascii?Q?IlIzRVUnEzp7DF1h6cF/5f1ytm3G+kMCzcqoZb9O6SaL7IsH/Se1xK50ZkYB?=
 =?us-ascii?Q?MuuzbKqP2vnVpca2VFPbzM6SRTTdzH7z9xVeUc5dDKwJn64SPzvkc/0SvqtD?=
 =?us-ascii?Q?hyNfl9wD/foeN/jsc15zZ7RZBXPlN8HHyDbepXYeFYFWftK7HS0qeiABfEJr?=
 =?us-ascii?Q?Z+zr7hDom0a51MKGoqHbQ0cCequLQ0Oxl1ON2/QE+p0HvuOu+6vuNEXnrZBd?=
 =?us-ascii?Q?2bqt/xaHSdi5GoeJihT7thKl4SVHSizUWrIhOMBNxqVSgafHyHT7yfj10S4S?=
 =?us-ascii?Q?FZPFEj4ubR8fkM5OBf98zyB0lpOowr0ocRyO+MNe/pn7kCicsuvRpwfLdeYR?=
 =?us-ascii?Q?Sj50gLLaYQ9Qpmcd8acJTICNSlUmyWEq+e9x+XMCzx3ZdYnyTshlBIRZ+xH1?=
 =?us-ascii?Q?9345uCyHNkEte4sZR7cxjwviPSe0Y3gYeKohgX2PbAllihJiDXjWLMgYZN/i?=
 =?us-ascii?Q?Sj1EUbQGuoypodnzxdxT9IQPHccM98ZumhPtZB+Hu1NNidVcdSxsS5MxLaSU?=
 =?us-ascii?Q?ehYt5v3p3McOl3fTVV39CvwKj+6OWd0ETAOQD4v0LjmPvGImfYthyPpfSzaf?=
 =?us-ascii?Q?0U87oLyitNKbaVbv8HhfDMnRDD21wetIdatHfv0pFIMmvHVvT2BwQuU4bzxP?=
 =?us-ascii?Q?TiOYalnXntf/614ne+NpbRnGGRdC0EfvdfCgpXnae2nAIaevOn3TvyrYc5lg?=
 =?us-ascii?Q?yWB90Wkv8TCUKSsaCIHBawmPRxc6x+Ywb4V29xuyIV/eaSahL9jMCWAqMAOX?=
 =?us-ascii?Q?ln0vzkyzk281/d7Z/xpCUEsPp0YvUD/8lF/BqIQsGIktX41GGcCSBfA/zUc+?=
 =?us-ascii?Q?Iri3Wdakr5/Hf2tUjjPu0chhp3jp55oGX0ARJ70Npy5VsS2n0gqQ/grYXQ1O?=
 =?us-ascii?Q?ZjG4/Rz8PVi55eO/Ax8oGaF5Y6cx6rSkN7hwREwltic5/ZClUfEWxf5Q01Vy?=
 =?us-ascii?Q?49YFbTk+/qpr+iPeaBS8zInZ1G/UqbUeyt3a4aV+4b9DGEJ0TzXz7MHco8iz?=
 =?us-ascii?Q?yViR4IhM+9seZrlJr9dCiYuF4qFoa5UONw7rnd0b0rdzeVdfUXqCSvDTEOS0?=
 =?us-ascii?Q?b4UhmJe37tnMAKL15mOcGKJGkqJYoPttwGkLiOlfVDvEzrUWP0WxI4E6PdMd?=
 =?us-ascii?Q?ALQ+rea9WlqATjsntKS8kNG1T8IFseHdrVG2wCtG2b+1Z66dYc818b6r+uTf?=
 =?us-ascii?Q?uKxpNJqE5YJ3yWZ+MaMn8CkfDgPB/xR/KLsmcI0LPQ+BCuiJ1Sw810kMUEq8?=
 =?us-ascii?Q?mLZfExpyM3TYqgvFDU61jd9NZ76YhRNV1/ZOKu4AWHM6bldTCh2sWczLuu1q?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5jA5IDeDIMuGDsUu78SQL3UjgZU9GqoTS4gcW56UNOIviEFOklnhgYAJ6T8TT76MiagbBL6RupMYCOBTDaCxKNhohFqke14jDlKRvf0sirTxQrjlZKMMG66bQUZB0siV9mrqE8pgmC/PTxa9J9NLyOdEIvtjj+mkvLuJ3YOtlMgJGYoNZqdFP74508Kzgm7l4fcrmQVw0bynggc+5WQLXjWmaIHCuTGaSfLVSmOgqeg7+Y7oLhbGITkbpQe+SrzywVjx6NkHG5K8lHLidijhZo6QI+gryysdirJurjcDWowFwg4sxkoRvBMbunLfKvNd41ub6fSjnWNNVv7+zb5+5gV6otLxXiomDQloYPVcOjQ14/wOFsqifvjBSV9rN4QadySed8Q+1g30Ptd94D5FsLWVL9BXquEY23hfxXU2+NKtXUA36kmsQEPuMCOZCa931Z6b07YaXJwpNv95JHNvOjpSo3U2dYGfSR5SKOHqJuc7YpulUySlvljzuM+pvzHrU2WF/Sye+OR89+hBcBFUggjpNMBMtIa+9rnQ2muqOBb1xeloffPU/z1hJb2zhAbFnkUwgmovLktHZ/xyQkrxOurRX3wO5Em7xYIh0Zfxd+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75f1902-84fc-43ee-ed7c-08dc91d9cd0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:21.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqEvcq5xBaopwvzq+HPpZI3nY3gZyjLBKJCvu4oBPFzyGknEFMt/Vd3HUOrvMfmOpjRhIpfZbA7ndjl7Oap74g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: aI4QdKtQHjEcP6t-X-9bMUp27dg98eH7
X-Proofpoint-ORIG-GUID: aI4QdKtQHjEcP6t-X-9bMUp27dg98eH7

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index b48cd75d34a6..42e1f80206ab 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -358,7 +358,8 @@ xfs_sb_has_compat_feature(
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.31.1


