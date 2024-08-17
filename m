Return-Path: <linux-fsdevel+bounces-26191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708F955701
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF5283093
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435251494CF;
	Sat, 17 Aug 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LloWzh63";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W1YZTk9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF51487F4;
	Sat, 17 Aug 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888178; cv=fail; b=HbCthjFCKSr2qMU+1y+yhKdHPt4rAp0d4OHGLM0aAQpLw4GbTuwSPiBAMllxlSrHYwkNBaFxFM3I5+U4kRalWk9LkzbC4oejCKiRJqFZAHAwT+PbeBSztMiQiWq896FA8v+iXhqNb9XHpNIGFZg73/jwh+SG+TxNtfj2aN9DwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888178; c=relaxed/simple;
	bh=Qv8Y6m90GLOx7Fego1WSBH4oDraxPRqQlVnTLDA5pH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f1juDE6qqRtkdGEa5eQoHZk3GMdQKQozqSCyGe4ZVSbP7fx0C3ECJRklmCi8mb2e6NS0DuDVZiN9LWpl0JU6cq1C4QHTc7eZp5HiASaSYmkL8vUkhNhUlUH5OV0faUAVOD8+4+qCBnTdd+Ic4GF51oV+9bkrcXYVEWZo+AOOrdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LloWzh63; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W1YZTk9z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H4979s029885;
	Sat, 17 Aug 2024 09:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QXfLt9wVw+nYMvfs5iT6Ek2lV8aybxP3E79isDYvIU8=; b=
	LloWzh63h2lkfyRiI8TTDKIbo7nq7Y/MCp+t/spicmX3HA1SSpdnkWWPkpK0jaMR
	Pqq5TKBqrJ8oh0ImI6x98idisgOeDaAIst20aKOn0aMiO8E71RAhZxBHPLj6y8Q2
	XozxbTJmdy9/L+c/l0tIZK0UjQ40dHmeCFCYPMJALdzscXwy/rBm4AK3CXu2uZoI
	sCn648pilmw8V/YgUkBtS/B+/NTyOmsuZwYUMYqQBDGjZaF0mZ6Mkf8U7Uh70onR
	D/NqBTIipchuKhnLSsrzzYzhVQ8lAumcKmOahVAYuMyaixfgkQ+mRRN9NvrMEnPk
	rAdyAb3eZgX/rX4wWKaw1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hg7e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H82r2b037215;
	Sat, 17 Aug 2024 09:48:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 412jaby1y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA/NN7TFeSsTy1knXTL/+lH9GRoVe6wYXTJkHwAlG6kgadrPLTmPAAaaWZL0xzbm6vVeAUZAFytB9kTvVVKS7xV4JJ0GSpnCgTNVanOxqC2tjBA52RY0MmrwFmnVIlgbbbU21NZZcYSBJlnJetKVd6q1LrDjRhJDoQfaFh4qT8vgIDd33wpzkj0qXkjI5VRi6GFpkZY/p8fRxlyGI+ztAbP7MmOSwj2tKfWH52v1vgsxa9i9f+saoCk/EPzuk7lnOxc4qdaA/Z00qMZi3KCTgbMtfMUGYBGtk7F+suAbCsfdtmYjiaJ7szNZ2bIqu24NMa2oORP6FS6eaqoqMHPqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXfLt9wVw+nYMvfs5iT6Ek2lV8aybxP3E79isDYvIU8=;
 b=fnwihhMzyfrw7PoHiLNfOnD4GjcvydM4ltGlManqzoFBGOpiEXj07WszT0qGRzzBy1+uCRdt3D3fgDplPEjfk5tTAah5tsvcktQ7W2WOkjRh6DSblff6wWEBFsmIVU15/sysVkNWo14gJbpNmyDI/dEVTmM5M/PIP+DQhi5bmQaXeGgKvptuJ9rnAE9hzwgpyH11qO2uHKlh3VYlgiQlS/jgiQnHsrc/gxUy6peS4ZR4iTq+kNty+onJ4V/Inbe9yaQaRnLC7zaoTtLTDK2HnFB7kLf84v2jyeTgZtz/jgZAKhOIRVenlj6rOUS7WZ7vY2bE9BiSSgFdO6ZMsNEr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXfLt9wVw+nYMvfs5iT6Ek2lV8aybxP3E79isDYvIU8=;
 b=W1YZTk9zhDW68nUeakU0PUAevXc5XkVngc2ZPCr3BhBokHVrbVZRyXGKapUAEFMsI/O12MtTIHOnmkCpRoWeuBDDmiMy1ONRLgyThCaUUMxWS6B/CfhibfGy04CHj/sguytxhhMyWCTkjMXE3E3X3/xzwDA2zIEuD7bSIEh9J0I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 3/7] fs: iomap: Atomic write support
Date: Sat, 17 Aug 2024 09:47:56 +0000
Message-Id: <20240817094800.776408-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:408:d4::39) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: a255fb06-f977-487c-3534-08dcbea1ba94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35fHRKqQ2Wuz/OIja2JwplIgT6AabfH0X1ovIlrkdDhqgaf01HSug+ovclmE?=
 =?us-ascii?Q?WNMHVXg43Lk5mJU49lqJowNw9Z5lhniFj6OSd+uAoO4zGXqAzdIqlg4JS4qS?=
 =?us-ascii?Q?gR9keuDYrzzflzZZhp8jGg/pEGzZvcd5VM7vOHa1FGeAKc8NZldKUKTeo5w+?=
 =?us-ascii?Q?4LQRTsWITMmFYvqLSE/mMpP/n8TgSu0wySWQbpsL7xp+iD/nIZAKLvPOaHCw?=
 =?us-ascii?Q?+SZNZnB9MfWO5df97Q/4lb1njzD5FyJrK4nacgrh6IXKWSPNKWy/B8v1ANYo?=
 =?us-ascii?Q?dVsBBp/+peARs3JVle5hrN25aqG9GnpVy4cwXOEfkZm7iYRVdszKzBgqqlrl?=
 =?us-ascii?Q?McAkxS+0UEulh4KnzlDjoj8ee7laWUsqQ75ip3Prb3IhBTB4gWCGXciNbO8a?=
 =?us-ascii?Q?GxypVIO2NonS5Luy9sbFuqU6112WZ/+DYGWYtIoHwNC4Ut795yDRX1P4SVsz?=
 =?us-ascii?Q?wHhASGvc9T+38Y2cdgbaw5sfFjLYuY7ave8Qb0cMQQqJ0yjj+QSVLN8u+h91?=
 =?us-ascii?Q?sOhZB3Z1tiG9yhdu+tV1kRlKfDX5fY8d/NsEGbntV+FbESlHbSclHh6p2A4R?=
 =?us-ascii?Q?mXbYmjlS/GldRCe7Ah9POgITDsOjzSATvoQiqlaf5KW5e38QGW0nyi1F56CM?=
 =?us-ascii?Q?nmFXkBkaV/fxhctMP1f+ghoovdGBTWCfDM1QLrrEHtf73aVXe1xngUPltX/T?=
 =?us-ascii?Q?T+yUQLg2m9FSBbFd3vaPbclCZAZsZyPj9Qzo7NMIm21jWo5UIbmckBcgChGR?=
 =?us-ascii?Q?lH0GauZxMtIx3Z0ATxW7aJF0iV0mAHUqx+VBVEWJn4XgFtYHSZCc/vbvQIuo?=
 =?us-ascii?Q?imgKHKeUpG3Sm8gRBVJERwToteIdhBXLNHktI9SIceZwyAPwtG+oqwdpNQbF?=
 =?us-ascii?Q?Z+dyuw8ANS9hrJLu3WtwKOino0BOw9PeUX4j/Doq8ouIOf25fuD8eRqXG4CS?=
 =?us-ascii?Q?k4V4v6cEf4RJV9k4DKyWQw2Eai15YHNOMPblVz1bE6oFN7zcod+km7TkqChy?=
 =?us-ascii?Q?4nHIU1hvTcUgynHMt/u48ef2tFIsxV6P4QcYTfWfXzGinODXcNPvoRFZ4iId?=
 =?us-ascii?Q?RRYiW/MCwQsf8QAHnw7wIrEccKPs6BsK4V5OsqIK01DBmH1rC7Fzj3Csr+vj?=
 =?us-ascii?Q?eahMnofkad3YiWKFeD5ETJkv4S7wpm6eK4wB/jnWgnfXdxoyITGKXdJU6gYs?=
 =?us-ascii?Q?BSTBZ3WhRzhZTE/22KUvRDIv2Na0xbpPwhcBEUIvKzwypLdgQlK8nO8zT2TG?=
 =?us-ascii?Q?N2/QXrhyLAFiEgZwdVLGi3jBU1rEYu6uFb7PWYs54xp2yKPIKfmo+Ee7O+6r?=
 =?us-ascii?Q?6w+5Qow+U/WdziCS18lmjOMcDVP0FFWSfgLELV2aHaDKqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjwYXCQTg2TLkONh70NX2EfirsyYlAo+DSJ8Q1YwE8oxRkhNA9E7EnnsvTq5?=
 =?us-ascii?Q?dBsPCxSJjFRoYCzhZkEgYUSZUa58SIQ1GAVZtdXQ/cF3DD0k1WNhXoBnjHEy?=
 =?us-ascii?Q?juZNOVD+AEhG6B8r+5A0UhEZvi4ms3Xr82aPetVe8kPuOM5Pw0AraunS0mOg?=
 =?us-ascii?Q?KdEHjlmdbtV1WUvMhfZPg+MJ69VnUh9xROON7n2TYRuKTttUKCeA+zqlJdK+?=
 =?us-ascii?Q?HMZnizjNa2fimdvH+54z5VMNlq0ggSluymXzXGxMXaqxVBNInXigVQzQCSaE?=
 =?us-ascii?Q?qa+mZzrYFsRzVsjSdseDdiZs4pateuIXyCsRUI3ARczNLGjx1ribhO3NT+N2?=
 =?us-ascii?Q?jxHlJz52nXaIJTUFkQ5fvX813sJ4vqRPfHtNOLz3fHg7TS6nDaYy0H2nNlrf?=
 =?us-ascii?Q?EOpKEBtVqupSX6x2fHc8Qx0xgR8lwOwIsacEhuMdu4UmeLmig1RbGNPsfKnw?=
 =?us-ascii?Q?3VpwMMDetOwcp26o+nRJkpTZHY10FWM2lBJRT/wWDVzaRJlLzwCLfBdxhvkA?=
 =?us-ascii?Q?i1Np31wS+/GEBOGT3SKSj2PlJRmCwErxIb+EtDgu4drPCp9YA2KOaNH1rLNH?=
 =?us-ascii?Q?4vzZFSSMiga8BsckUwfaT1JNvppY66wqGl5lbdqhjzc097xFiXtXVYbywxfD?=
 =?us-ascii?Q?262Fb0RcwcPjKVo3YpQ+tCd/6XhIiu9I6alwlHOQDQv0sOjnfHOV6CyMj/c4?=
 =?us-ascii?Q?nAxDzbxcu2K2p6fY+zg41NKL2zYmCA6sVaPEnWI9mSshceTMWTPDaPjth8tK?=
 =?us-ascii?Q?O4uQ3cxE+qkdF2ESRiYYORYjDy3kC+z5MnMNr4GmecARzUeZmzvpjOVacspB?=
 =?us-ascii?Q?qMl1it6aVRaTrkR7B4JOd9bM5cZVskXHDAkWR+PdJRu8O3pEwOhudvNWkfDM?=
 =?us-ascii?Q?2urAlzXB175W+99fCWBgnH+fvuVBBVeUQRPYoYwOnlcYpBHllkFi4OjqpNEQ?=
 =?us-ascii?Q?7GpfEJLWaLqkncLvOkovl5BDHQPTJHk2hGAq27tj3ao6N4XlxS/x08kcUETl?=
 =?us-ascii?Q?MPRpM5LCXwiiDkY1XB+f5lDlEjJ7c3la8VUw3B6S0QCS86Q0WNDbzdzh+YYZ?=
 =?us-ascii?Q?C/pUO0nrHDJ/813dBReXK+w9YJPKbuMeF5sezo1z7CMHfv+Mfcd76SFugjEg?=
 =?us-ascii?Q?U5AAnQNN2KJwBk8hCV6YlCGYO74qnW70DX4d6fEkOKHMzlZcM41pkxJ0l//5?=
 =?us-ascii?Q?fxX6Rb8i+1b2UtqObA9pFYeLQo+XNakzFNz2+UNh2Jj35XWTIQNKsMB6m6D+?=
 =?us-ascii?Q?MWy4wX11UaE49bvtOC2/Q+FhxwYJjThUMGkBBbCTJK5RqG8vClfsx9/8GUeG?=
 =?us-ascii?Q?cUYFCWfytJx9+xi9un2W3q27nLuNxzhYpWzxbkx34OML8izbyKzyE03A6pSq?=
 =?us-ascii?Q?w5ivA6kbWMRQL0Tf1PbRnirtwofjMTkHfJkjif9LdE1Fy3/YQ9+zB3UFAl9I?=
 =?us-ascii?Q?I5VEYLRyjvF7IBw4TV9z3CyJHIWoEbpRBUKn9T1+c6rUVxQdj/UNnG/L5VVR?=
 =?us-ascii?Q?4PipfgSRK7sIHPSnTbGV76PdQCxNhjltJ9sy+eF26xqK+IvvPliMDPqUFZJ6?=
 =?us-ascii?Q?A5RxNpwW9y4MhktMYQ/jOKvxc4FuoyDiiYg23r4Ps/+YvwGbessUj8ExoD9t?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fTH96S+tgkuWUW3+8i1UgJMkZbK06J7YIlTVfrE+Qwqt0cWE9jNDHEGK5r3YHRJV28+dq+Qb/xjKL90/ZGeHxLBBKARixUbkSwhCFXlAwjx0NKpB6DKMlB2e6+3T+gZZts2wFijvRnXJSQtyTED8Cj9Jt4SMZvzzVCCWAZH5hLa9Q1lBtBxDzNqljHiUpVGBINxUToirqOxzq21NHco+dNZhitsx93Xf2KkrHZ798fiT2WryhN7ruDZdqqjNLGC08Lo2ilEuaDHApBZsdvWcuQrGxs0uJHgarV2t1tDN5t+jBuvO1qVBvpAtZ6zWW8v/m3yFDluk5TxNsc/zdnSD8HmRZ6fKzkXtnvueO9fIcuGcwQhZLXqG+uqbH6co/b10F8Aq/Kqsw1qzISRwCyCF7jubZEr6tC7ITkNg1hkEinyd5R0fdhs+KGC8oWrPTAfBm9iwXem2SBrHk9y6mG/HTVvwEdNnILUIKdO/ygXZmJQB5WcXgA/VGBuv0/+cUzgPuS721Y8GjlF3O7YZJF9oVUcY5Oxf4OEidgpL3xmANqDLIiD4OUoP5JpmUDI6rziUEfkhgdAKAMIj4xpJ2XNK0sPlW07dsYVLWUwFE4N7f+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a255fb06-f977-487c-3534-08dcbea1ba94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:20.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vNqMxmK5azkdHIsCuC6zhKL45cKoU5o4BK/kdO7aEMPC/wULsRTQd6BCCwkgUsYlFE8gmOxy0zwMb3L1e74PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: gimawJWq14inVYFrZw9_TZg7bfYjktml
X-Proofpoint-GUID: gimawJWq14inVYFrZw9_TZg7bfYjktml

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

We rely on the FS to guarantee extent alignment, such that an atomic write
should never straddle two or more extents. The FS should also check for
validity of an atomic write length/alignment.

For each iter, data is appended to the single bio. That bio is allocated
on the first iter.

If that total bio data does not match the expected total, then error and
do not submit the bio as we cannot tolerate a partial write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 122 +++++++++++++++++++++++++++++++++++-------
 fs/iomap/trace.h      |   3 +-
 include/linux/iomap.h |   1 +
 3 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..72f28d53ab03 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -37,6 +37,7 @@ struct iomap_dio {
 	int			error;
 	size_t			done_before;
 	bool			wait_for_completion;
+	struct bio		*atomic_bio;
 
 	union {
 		/* used during submission and for synchronous completion: */
@@ -61,6 +62,24 @@ static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
 }
 
+static struct bio *iomap_dio_alloc_bio_data(const struct iomap_iter *iter,
+		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf,
+		loff_t pos)
+{
+	struct bio *bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, opf);
+	struct inode *inode = iter->inode;
+
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
+	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
+	bio->bi_write_hint = inode->i_write_hint;
+	bio->bi_ioprio = dio->iocb->ki_ioprio;
+	bio->bi_private = dio;
+	bio->bi_end_io = iomap_dio_bio_end_io;
+
+	return bio;
+}
+
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, struct bio *bio, loff_t pos)
 {
@@ -256,7 +275,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -268,6 +287,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -275,21 +296,23 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
+	struct iov_iter *i = dio->submit.iter;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
-	int nr_pages, ret = 0;
+	int nr_pages, orig_nr_pages, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	    !bdev_iter_is_aligned(iomap->bdev, i))
 		return -EINVAL;
 
 	if (iomap->type == IOMAP_UNWRITTEN) {
@@ -322,15 +345,35 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
 	}
 
+	if (dio->atomic_bio) {
+		/*
+		 * These should not fail, but check just in case.
+		 * Caller takes care of freeing the bio.
+		 */
+		if (iter->iomap.bdev != dio->atomic_bio->bi_bdev) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (dio->atomic_bio->bi_iter.bi_sector +
+		    (dio->atomic_bio->bi_iter.bi_size >> SECTOR_SHIFT) !=
+			iomap_sector(iomap, pos)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	} else if (atomic) {
+		orig_nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
+	}
+
 	/*
 	 * Save the original count and trim the iter to just the extent we
 	 * are operating on right now.  The iter will be re-expanded once
 	 * we are done.
 	 */
-	orig_count = iov_iter_count(dio->submit.iter);
-	iov_iter_truncate(dio->submit.iter, length);
+	orig_count = iov_iter_count(i);
+	iov_iter_truncate(i, length);
 
-	if (!iov_iter_count(dio->submit.iter))
+	if (!iov_iter_count(i))
 		goto out;
 
 	/*
@@ -365,27 +408,46 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
+
+	if (atomic) {
+		size_t orig_atomic_size;
+
+		if (!dio->atomic_bio) {
+			dio->atomic_bio = iomap_dio_alloc_bio_data(iter,
+					dio, orig_nr_pages, bio_opf, pos);
+		}
+		orig_atomic_size = dio->atomic_bio->bi_iter.bi_size;
+
+		/*
+		 * In case of error, caller takes care of freeing the bio. The
+		 * smallest size of atomic write is i_node size, so no need for
+		 * tail zeroing out.
+		 */
+		ret = bio_iov_iter_get_pages(dio->atomic_bio, i);
+		if (!ret) {
+			copied = dio->atomic_bio->bi_iter.bi_size -
+				orig_atomic_size;
+		}
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
+		dio->size += copied;
+		goto out;
+	}
+
+	nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
 	do {
 		size_t n;
 		if (dio->error) {
-			iov_iter_revert(dio->submit.iter, copied);
+			iov_iter_revert(i, copied);
 			copied = ret = 0;
 			goto out;
 		}
 
-		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
+		bio = iomap_dio_alloc_bio_data(iter, dio, nr_pages, bio_opf, pos);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = inode->i_write_hint;
-		bio->bi_ioprio = dio->iocb->ki_ioprio;
-		bio->bi_private = dio;
-		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
+		ret = bio_iov_iter_get_pages(bio, i);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -408,8 +470,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_VECS);
+		nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
 		/*
 		 * We can only poll for single bio I/Os.
 		 */
@@ -435,7 +496,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	}
 out:
 	/* Undo iter limitation to current extent */
-	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
+	iov_iter_reexpand(i, orig_count - copied);
 	if (copied)
 		return copied;
 	return ret;
@@ -555,6 +616,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 	loff_t ret = 0;
+	size_t orig_count = iov_iter_count(iter);
 
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
@@ -580,6 +642,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (bio_iov_vecs_to_alloc(iter, INT_MAX) > BIO_MAX_VECS)
+			return ERR_PTR(-EINVAL);
+		iomi.flags |= IOMAP_ATOMIC;
+	}
+	dio->atomic_bio = NULL;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -665,6 +734,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iocb->ki_flags &= ~IOCB_HIPRI;
 	}
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (ret >= 0) {
+			if (dio->size == orig_count) {
+				iomap_dio_submit_bio(&iomi, dio,
+					dio->atomic_bio, iocb->ki_pos);
+			} else {
+				if (dio->atomic_bio)
+					bio_put(dio->atomic_bio);
+				ret = -EINVAL;
+			}
+		} else if (dio->atomic_bio) {
+			bio_put(dio->atomic_bio);
+		}
+	}
+
 	blk_finish_plug(&plug);
 
 	/*
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..8fd949442262 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


