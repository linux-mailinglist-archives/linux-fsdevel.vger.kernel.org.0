Return-Path: <linux-fsdevel+bounces-32870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B29AFE9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69465280EAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70C1D90DC;
	Fri, 25 Oct 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aojlg+fK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="arBAV2EF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520E1FBF50;
	Fri, 25 Oct 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849335; cv=fail; b=iGLf22jS8GBN0xc9iWUvkjGnYfPHuQuEjfkrQmTgWPTfSiHZywhTfaI3EkGDWsEGbqh+K0ir56TDHob7LO9BhEs5hZP3/uVbIw7LeQmDDX/7iuWrrr+e1LSAyK56av3E81y1HqF9nMsjZG5FU3QxPLu00O4kQOa2KsEYN5PQW/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849335; c=relaxed/simple;
	bh=kGXVtdaQIb521qU3APu1XFO+uq3Q/fUT3w4fjLT70e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjA/NmXPZW9S4ieLFYoYL9/7ioLSGYttC5bWb3+o8xVBDSYdOFyYEDd/h+DIjTTyWH1w3eu4qZtmKyM0hA4c2OS4HlKTB4sQ88ImIIVYWqFHHWwwm+nWSZBH7GyzLYgvwomTefVVOCN41OzOsZdX9VerXyuSd9QXOenqL6M29BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aojlg+fK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=arBAV2EF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BaME014274;
	Fri, 25 Oct 2024 09:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=; b=
	Aojlg+fKaQX4H6xJF+nRy5G9M0/Cq+6/N1nIG2LJUk+JHtrDgmxd/2kV1FIEVPzG
	F456ojeUr4PFhrjnET/SZ9g3E4eS1905gN4MatQQGiHvdcADnCWCwkLI8sPTxYZH
	aiKAfSHjaiduV3AEPp5xQyuq/yIwhldXrfAgl80rtXl7T59MfqSQhtpibe9/EpKG
	a4u2R1PhS29TrDm9AnxKilQlvzezmakdBHMgUUd4+0kU3tBM91C1Pl4ZlI8QAnTz
	jeOpfDMrn53B4dmVG5Xb+mPw614buQsf7ajD2sGzFKJ7mA9iaNIITIS6JZkpiP85
	SSjpnGKZCGjSrFUeHdqcag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55emffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P9VBDq036957;
	Fri, 25 Oct 2024 09:41:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh53wkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+v0D3t6JTOyNtaLO4i1XkGEjoUkT8SXDlY23GhUnrMYHeXpWRBchqE7jvT/CxgD3bNkPo3u1h54DQDYvM51ir7TB5D9gwsQWhy4C1naHqSeoMsBc0BRWwx90JzyM7S4UAPWNSXLFD0zRfs7BvDVVTpPK6wu3h5PQdj78hCwJbINzY5EtnflldMyLMKqqqmS7l88Dm8IuQxEnaB/hXSKG6bqoSeC25sfs9goz4gNoXx7R3/WV+/PhEMfRQ/UoHFfurpOffgau5Hzg3nRrN8uQSpJiQRJc5ngCyEvNn2Ch06dieR14ULOKSY0huHZfb98cIQE5QYSr9FRjVKBYapavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=;
 b=Xj+p2PxdtciUEAqCX8so7EsNJhzjxabq4egQepes70TNfk+H4rlKYtnfg/6Jq4P93s7BopMorUIOSqrhM5h72eYezMCqwldTrTRbqL9KdRofR5aY0O7HIe5GQFTCfMjvp0vNtGcRw94iqgIIGtweaV4KjUpN2fLOcsZDwtWpJnECk6hCvdvyTIHhnvMySo0e6G80yCBY30vcWbgt4+pYyNdsEAc1IZ6X3/Bnd+7U6eFabLlg2Ub/XVjh/gkr172UeBBtIJKJlM73BOycnIzikf6HHHVxJqeAxdH4dD9euXl6ZruhjtoVGSZPFYgZd2l1MBPliuapTnXH+EW51aTHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=;
 b=arBAV2EFzZ3i3mY4LbDkIiQ6dGJ8B3Aai5/eUg02j5pALog9xI/PB++tY6NviMMCA6VHHbAb1G1Be0y4hfT67YblWJ+am/AOVfWcJh3++pBtjozOT2nKBZyTNoBJ5r4WQHZF9LzBrcTLvuXS9bE7dEz2twzZgp4tCgFPFham3Dk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 4/5] selftests: pidfd: add pidfd.h UAPI wrapper
Date: Fri, 25 Oct 2024 10:41:33 +0100
Message-ID: <1002ac9d986cacf44dca8cdf392d62e26528eb83.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a015b8b-97a4-44b0-a390-08dcf4d94228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awErcbrjTu0Egf/QTjvxki00G7uJ7Qzp76ObuLB5bI89SZmmyWpcCGwBRBg2?=
 =?us-ascii?Q?KgxZA6bbYhjeTrneXWVRf6nHzbdfhMpsiMLEccB4D1PkVaqz3UhbI7ZnKXtk?=
 =?us-ascii?Q?WLylGTgeLGWANrZBhGJxRxxWgmwegy2MyeolD+sKuatYy4+AdX7cmQ+ISBL1?=
 =?us-ascii?Q?zr7X79+t2+E9s+eDFoP+pm8QEy2K6jthuG+wiPvURai0f8KHkGw3jFA0YK7e?=
 =?us-ascii?Q?AgfB9nQx+EcdNmWSA+1duz26BZpIOOD6W7HvfWpa8dNsxJKGDracoXA8xwEr?=
 =?us-ascii?Q?WYLhu9YFyuxpTYF6tSd+hv3iGHdH/6LvR7S/DyDko7w91KkI7yN/js+x2oir?=
 =?us-ascii?Q?UdgMKJGJ50czwx7efJVtcujbdPX26BDX1wA7HdMoT/w6Cd+wJeG1naRNlNrA?=
 =?us-ascii?Q?bpNOIjTgPy+nGG2uVK+e6vl+GATl9nE4wJSfF9hf+sbi2FeIRBH/yupwxnmO?=
 =?us-ascii?Q?WNITMMbEyR/ORDvJdjOFRlGfUg2GMhp8j+fRW0jOpZAXrJfRD3iRON2/PBpr?=
 =?us-ascii?Q?zhInYdCRN+M6U4E3yCOcLTqSUCzStSlkyBCH1W/Zr8PMbJcCC1fiSE0hcdyw?=
 =?us-ascii?Q?lbjnX/QOb87IRDaG/Ao2d92J40RqmUtrQg5TwHTOWxITp0pJuMa8OXcDfPW1?=
 =?us-ascii?Q?dQGj/BGD35Z4l2/I5upq6DRZgaw3pK8/p2U5L41ev9tBnbSNc8YvacMfuYVM?=
 =?us-ascii?Q?dYGqU2WuqKCLaqy4c+MMzuT5eMlqa5t50nS3nvelRpZj2OVkjLM7+pNB4stw?=
 =?us-ascii?Q?GKbmwaMCU9kZuy4Sc+hP0dW5j2B/IM1NZxS53RML9cHTyOInWqWoW9qABsgZ?=
 =?us-ascii?Q?XEEfpIe3gIKYLTCa97/Ipo6ty+g/pkIUyB3Wfk9qapFbbLBHBpNclyJqSGzO?=
 =?us-ascii?Q?u4Czm0kpa3Ag8Sbr1qAKMuZ/gvfnXh4MYasNaA/Fd5bnQbekTBlRP1kIk1AA?=
 =?us-ascii?Q?XD1ZpGCGOiDF582YFYjTau82tz1kAP/2wAZu76Vq1nu2NnGtJZKqhQCFVxYD?=
 =?us-ascii?Q?f//OqZTIWeJ6S1KnB0qbpO8mq3N2zt0HVUUW8fxWAleb/9A9XJgatCmQFpfZ?=
 =?us-ascii?Q?ZL3tsufl77EQXvIz9TZogXd0sXsjA8wuCM3Nq3LveLhDguqyIb6ek3/vqu7t?=
 =?us-ascii?Q?GZtUSBbRp+U3MGlcI7xuuCbCjIyx6hzLyegygr94hDVMSVPeeUwf81uY7Blx?=
 =?us-ascii?Q?I6yP4Exchtx6OrC6xPg9LGaYPrg89GkVWCSAJazUUDGLIBFrVjnJduWCuAIm?=
 =?us-ascii?Q?IPYhTqNjMCm/vlp6o8UcOIeu6fHUDup2uGV5O9qqvWJPB6gu48rlmJ3pe0Ja?=
 =?us-ascii?Q?58oJy2yr+7Y9uUVP5hcfIQz8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6bfDWLRWtXpybuPezo/EXfYtkdZgcpex7QDMmjA4WqAled//N+62c4vYlCs1?=
 =?us-ascii?Q?AI11Ca4OaR8frISiujxPvywCd1ra1SnilHpkLjY/oUtaW3CLzXQ/AS1XYkDy?=
 =?us-ascii?Q?eCTxg4f/lI3W6VXZCDis9a0y1K7okbjpTY4v4SrxxJ/r8r/AXu102y11O7Fe?=
 =?us-ascii?Q?3CXOdL6FotXTh97Mtkx0P+hcVUw9rnpxU9xT8K++sQnY9tJdwtV68mUGT9bD?=
 =?us-ascii?Q?uMaGxLS6eTt5084/nijyRVxlkFFYGV0T/F2QEhjcNxlmNTNxIK4gcuKu2Lke?=
 =?us-ascii?Q?mAAlmBmaKyAibzVDtXMRlpnWZR2BlX83butMbIW23gFcubCddavfXny4cJpw?=
 =?us-ascii?Q?n9UMxOBmE4JbWH5rCw3RKVzmaCOtaEpp3fEP5jmk1Ilq0CqAVW5YGDWvw5Qt?=
 =?us-ascii?Q?WUsZGVXZIyTxjf7zBBRDkFcVAqBucNAIOzEcY9Nv5AeCQ9+H4oXR9BoiuZy1?=
 =?us-ascii?Q?I9/ZFpEzRnLYnj1f39at5deKKeWTTH/fBgdT+HADNd8AHacIa+VxgRtl6DA1?=
 =?us-ascii?Q?Ulq8Jo92LklSPQBf4WTtKq/6S2pqUGf36WTm2oBegwurAgD2qO5+529U0teW?=
 =?us-ascii?Q?nY97XUIBXm6qjgID85TIXUiJoUgxCh+7WvMv1c54vRlVckmmdfQNrNx+P20V?=
 =?us-ascii?Q?tjLHHw/D4n/mf6d/x/yJKnu8b/DmnX3lHNxQ0TbtKLnEeGLHcicSMoYy3Lx1?=
 =?us-ascii?Q?bMT5C5ZP3pGtHkPy0J0gbhEps5BAMSUAa6wJUnqbfGdQPCGYQg+z69+L3JMl?=
 =?us-ascii?Q?4zbtJWli3uEUPkk7XGy04AnmsPneTcjCoIs2OAawnZNa1LDIHFtbxzhCARPT?=
 =?us-ascii?Q?dxknoMzbR97/sL/vsdJvMoowvaSm7UG0HOAAYDF452YOGCEgLSz2pxKnFOUK?=
 =?us-ascii?Q?jfu5v/g19ylSs6NcRcUvpFYTk/dEUrfOGo0RQMae/KwrSjuBUxiPY+9iRLbT?=
 =?us-ascii?Q?4nXWbX6YF366+iTzMBhFySdpBC021n6ht76u7zGyPh5031zXfYqhjmj2y5DO?=
 =?us-ascii?Q?25k3xAsOFmZSfo99AAOJuz6RRx9VMcHfxp4EeFfFh3maaNxERES2MMg+X5y/?=
 =?us-ascii?Q?HzQLB0rqpdkI84isnGFrH51JCo+sVWgtatcMCS2c4WHV+iHt/Nbc/W0fQUME?=
 =?us-ascii?Q?tkF1mh6l7vu+CCmWoUkWUAWy9LxgJJ/EPMbJcW+rLZp0zQCSgH2Sdrqp+s/e?=
 =?us-ascii?Q?XK/KCLEh7o48W6qdOdX3QjuS43gNv8OF3MNeBAxHanLA1zF+Gx2R1g0mGTan?=
 =?us-ascii?Q?Dr2Vazj0czlUuVWU4N9vNhQNlL/IasAp46cC27NNlriAwDqWauSDok7K2+Hj?=
 =?us-ascii?Q?QTw3U02IiNPaISLGwrLVxQHrtgGAnbTyCXefV2kxm9+hmYAnv/+76nUZDmMq?=
 =?us-ascii?Q?2Bn/AYp6YPAtjT8dXyAnNj+AQ88fMa6NYlSIwAcY1OZpUkjeR9lpV6iOxfOh?=
 =?us-ascii?Q?SvYfoZlGyBfgT2W7KuHHmYAjQa/L2qWC9uUJP3ywv/f6d0/jU8L4Snf/5zfo?=
 =?us-ascii?Q?YEkYssToyfQxnDy8gN4W1NMA+yXdQYNqYZtDmCuxiliePfgu9gXKnN80VDzU?=
 =?us-ascii?Q?2jekPm0qKiYKdEAnAqYKf2oc3MZV/wd5KYt4cYMHPKpg1OhOuzoDVnqi8kqJ?=
 =?us-ascii?Q?CEkQYNTOsXJAraw/lA1rfdnz56+g6DZARBT6K9kMVL/jdZ51tgQVd51HlHfs?=
 =?us-ascii?Q?8biMyA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkMfr6yTh6GoXiCSPpUXWiVED6YWG5T25wwVMeNjOeRjixcFlhN4XeCyNR/2kzbtEOkPIDlND/qCm6V3O3sqYqhk0kVnJ+d792thElck7EX3chG5Y2ekJIr3GAD6gnV1CFrG+FHehkfB6HhFcNOEc7201OBJbi1lV9QtEXi7oQhTs8ZbsXHX6jV/cuTHocrjfA3gyAvO9i1nDKOqVCO8R62IttO67flXBqRlkgvJVEH8U0GfkFbjBbqLnzUD697TT1GI7SfUAbyb9+ZOy9EO6HEmbCmKrFNl0/Qt8SbHqQZJKJDk73LFOaliYkfBCxZPoZysko/kiktvDJ5eAkrPmJXnb+Y4ncTpsbVg1AJqN9wJk9DEh35qien3AbzExb0d9UaXyxksli0cUf7Lx09WhVbIiI6J90tx2Ds4lP/3yO8TJflyAkFPmvwKc5IjH45Da+4dUe2SPymckEFEstAM36g7BoXV+j1zmAJjAWaMK8PvY0xkZWQIlp1ki7iECeK5L4SEmbp2PsnosaYiRGV0Eoq9NtwVqwtgsDBHw7nCJGsZ1pl9N0EtZUtEN8bKe6TF5LplXQupRATrkRA1+tbrDxLnA5fTdxLd/yTbKMgtV6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a015b8b-97a4-44b0-a390-08dcf4d94228
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:53.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enKY8pkm2t0s/rqlC15lPTIsAGIDhROiAz+mRld2+/M0a0+wSIuNv0wCFeLRL8lns6ELPOk+n/Q6n7HmyvrXN4JbDeOT0B7t2VfIlIqnjDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250073
X-Proofpoint-ORIG-GUID: H9G-8VMbDrnKc7wRgbtI08FpLtwuQbRz
X-Proofpoint-GUID: H9G-8VMbDrnKc7wRgbtI08FpLtwuQbRz

Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
the linux/pidfd.h UAPI header.

Work around this by adding a wrapper for linux/pidfd.h to
tools/include/ which sets the linux/fcntl.h header guard ahead of
importing the pidfd.h header file.

Adjust the pidfd selftests Makefile to reference this include directory and
put it at a higher precidence than any make header installed headers to
ensure the wrapper is preferred.

This way we can directly import the UAPI header file without issue, use the
latest system header file without having to duplicate anything.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/pidfd.h            | 14 ++++++++++++++
 tools/testing/selftests/pidfd/Makefile |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h

diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
new file mode 100644
index 000000000000..113c8023072d
--- /dev/null
+++ b/tools/include/linux/pidfd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_PIDFD_H
+#define _TOOLS_LINUX_PIDFD_H
+
+/*
+ * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
+ * work around this by setting the header guard.
+ */
+#define _LINUX_FCNTL_H
+#include "../../../include/uapi/linux/pidfd.h"
+#undef _LINUX_FCNTL_H
+
+#endif /* _TOOLS_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index d731e3e76d5b..f5038c9dae14 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
+CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
 
 include ../lib.mk
-
-- 
2.47.0


