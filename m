Return-Path: <linux-fsdevel+bounces-31949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90C99E215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272AFB25863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB41D9A5B;
	Tue, 15 Oct 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MMTS/Gn0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kv6qr9dM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BC1E7C21;
	Tue, 15 Oct 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982956; cv=fail; b=qlNnRPjpU7kDv9d0/R/ebkGCPmV6R1OIpOazMefTk7qnaQ+v5jQ3pr7VHN/6JfjwoHUW01T5RDINnsbkfilU29kyPpgCBgHlfOooyFI7Zv7D+tZmMNiW4+6MZFdff2HFMju3NdzI2SAjeXbkj/XZuawceKj3OoEawksXqfuGDVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982956; c=relaxed/simple;
	bh=X3U10wfn6VZKScjWTDOaiqO+ijk2vv06rH73YhyzAOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkH3SrqOZUcoUwHY+dk6p+CE5oD/rEjJ3U2uf8gYY1Ltfp2k1CP8PxYqtuuzlwrh5beslRgemuvcl5YHG7/1LGiftid6GdIfWXS/TiWUbeYKnmDN4GJN17um63aLIKntZGNOOPGNa+WFgyMuYeTKRf7VDLonlRfMJFrSuXrQxOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MMTS/Gn0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kv6qr9dM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F53C029379;
	Tue, 15 Oct 2024 09:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=; b=
	MMTS/Gn08zbhyfR9000PL8KE6v2ys5n9QQFsvaoEVxtFTeRYyMo8C1nCgTNqPWx6
	p7rIhFT8uETgd3NafM0nMKmLEm7i1ltqBUCc69gry6T1pKtiiuPO8gW/qfQoiShU
	D2JC4gxv5Wp/Fec/H4Yk68ltqiQ2K9oPPdWfYjg8MA6T3ofQ9dGpU3L1EwjSh0Hn
	HqdkvfMgqRscQTv/W5aQxPV9iFpd+25Z16ZUd7MF6oqJO+bdxATngmHMAFAf50l+
	ShyWTjWuimMzMHCCMLqpvTq+onHnqxSxgRAKT6RrXH4D4GZ1QjCV7cw4up871QIO
	+GX9W9/el6U0eg61tRth7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt8anv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F90aRp010968;
	Tue, 15 Oct 2024 09:01:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdehqu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2iW9cP1jQcko1qO013LuiQkoBzWWP9CJdjZ6AflA5V9C1NMwg6pzTXVECwvHYBpBGyANvgQlknkDA/LZBoQm+/X06mVhTvOTJU4SaLJZX3uLphdcb75Wb5CHHvuQdZ62q0Mq+naucYrWmkp62gAKwF6rcSZWzLwjKsl+Y3vofwpUdY653v3LO7Os/qNY31trOfibVxfTSo7IJSOQPQnIWRSVmVbUo4/DppxsSWlMxWJxoRZX6P55a2Sgvzcx5Zl1fwUqfkELLeZWW8U1pkuYHyFm+TqwdVx/PgTSdHM7BrFAP4X1yGwtqOb3MHkVTS/qJFgRMJaOBq+G9d0OUh5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=FUK/FxWISClT19ZQhTrjEwfXCar++jEASrMzK+m9u3DGa+kmmx1o40uuaIvT30MAHInYNf+eIRIO0fFVXUbXSMJgo/AQibnd+rzOOxMrZqgBWwfC1lUTDZaUNW6a0WlBFp018EPrq7QtZfMY4OiyFLaf8rgwTI6OEq7Fs6aqskzYX29ho2sStHqGFjkq9BQ17UPOMX4PsGCWp+zhwued7Ba8R+4TtnARuabdGR5ECFMGe+737s+RB08iCyHZ+PYe9P7qeCDvQlzqGYjXBjI1blqdJMJUIWU0+Ah1z1CxzWmJ+g0jdySw3OsN2k75uY3FmQN1VxUvoClhh331wW27FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=Kv6qr9dMiyH86pFEwO35YFA6qTnP98DQ6typGT7QAQEjLQnFMnVvNNthyWrnqZR6HKdccGs16V7RaUQyQa+CS/EMnOMu3WRcY2eiIXjoNOjWfUtREYmzrCx7vHjaZiXmzafmQfxWEenEYJq8g+pfs8ZzZKOsNXyrc/NM3tuK1yg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:01:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 1/7] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Tue, 15 Oct 2024 09:01:36 +0000
Message-Id: <20241015090142.3189518-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cc5779-dd7c-430d-b595-08dcecf803b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQrpOFF9EZrv3f45ucM2YHDTIbjjLuJlO+zkhimK5giCsjhSHOAJb0r9npez?=
 =?us-ascii?Q?gmrXJhMgkZsquy2FsC4yfLLTcPs2R9FLRPqft1w5SASCy3HC8rHiPnt2dgmh?=
 =?us-ascii?Q?dzdKhg4s81vDgkK9+fRHtBkDc/V2Hsr4OQvvZ1jLwev7kVq7v6m7z/oT1DIf?=
 =?us-ascii?Q?60eFbM+jYAyUqe31tJ5f8dwHbuTips6vJzfdvMZBPkAhAJv/kowxz1/NosNf?=
 =?us-ascii?Q?vupMbrXZfXiFIILBBU9Mo4XCt9AAgF1ucI1K3U5PWx0KvdrLk60W0U3/G96B?=
 =?us-ascii?Q?RTvCASOxa2GyFHiMHtx5vJsxMEHQ+N8Jt83OR+0iXWE51LDr2UL8DRcsIA9r?=
 =?us-ascii?Q?CQZAcqjH5FDMRjjfDxnMWe9NIz2VeLDcblUsYOwMmVnK9Y6jJU5aCYVN4WBL?=
 =?us-ascii?Q?Nrq5MLxVerlkB4bOSEi7mgwsGhGlfT5/vfB7oPNt5oIZLi7NvaLCwrRdHgrQ?=
 =?us-ascii?Q?4AIxesWzHIwf2kUw0XwP4zsIFOY6PMWUBIFCKaeMbRPmmumAglXF4iR0GMH1?=
 =?us-ascii?Q?RABspUxyRbsXvMrTT9ZETatOLOtlpZawaaNjNs4dB6XixTa4SLkKcISINaKZ?=
 =?us-ascii?Q?Fd/r2gt/eZ/fpStnYNhDHufXrsdvTmtE7DFbSiZOXZw4lDz0Eq8zA4gcpeYd?=
 =?us-ascii?Q?R6QSbfC3im5HgwVxUH18kFbg8/Lhp8lOQZn63L5M7PKnRa7/iQ28D0C4P1WS?=
 =?us-ascii?Q?PXd5CjH4gMiQF4qP3AUMWRrqtaaAGSxIXGb8aMkrM05X3R97Wec/Ui0pPmcA?=
 =?us-ascii?Q?dMlPFYPyW/OEEVs0vNE8EeXCyWycpXy+0XALJd/xNHSWWJ6hqVrOa1e4mcEd?=
 =?us-ascii?Q?tNZZ7HhJ8xsXYKFCy0ASMG5XvYZogoVokH6h4jSLb7WGFN8yj+iQuvJ1WGJL?=
 =?us-ascii?Q?eNRqVltsYTHf9hu9QvzOBCexEfd3bCMvbF4m/s3mPwYjGIYhtEOYwKQQBZ9g?=
 =?us-ascii?Q?j1wVWXSbVLGwGtI6N0cSmiK91DNnnmBfSBE4/VYopq67nj2APnDyzoCsuP6f?=
 =?us-ascii?Q?hNj9/ffcbumwCxMidzdhsV3kcIJwIp4Pj9Mtrqr2Ft0GiJH5AcZQ4D5XvUvO?=
 =?us-ascii?Q?oyHDZC1V5Caf4pC1kTi5eCmKy1mYsKXgjVumCq0ll+CHOexo0aan2Trvx4+5?=
 =?us-ascii?Q?2Yujs4KW6uA6TY4jFWs7+l9Pito6oRzADvVlljFAAkwKPwzuQWO2CQ3ZINTE?=
 =?us-ascii?Q?fV1sNBJlqgGcyMVwr9moHNbuWfbssyJ9EiP/emyG3YBSuc0yAR7zrh3hzPfT?=
 =?us-ascii?Q?jbLgML9NLW1it2yfVTejo+Z9kRqQruIrwQlQJYLix0t6kxtUlVvxRNx09UgN?=
 =?us-ascii?Q?bDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYfcxssWs4F+0+LOpndbhxQ+/8Cz+LEakq3VOzhKHXcqpR70j0uYR9CNxnKM?=
 =?us-ascii?Q?s0+8KBMi6wZzm5kurxchnucfjHO2NJ81mnSPtt1ebtiwi8ndRkG0X1k5w4q0?=
 =?us-ascii?Q?xtEMnIfCsNdA/kO371vdhMc9Owi8SVrT3Q8a4cpu8GE0Z51PuU3XoV1cPhTD?=
 =?us-ascii?Q?knMu7W1muNSZ0u5WawpvachzH0JPo7ID53QN/tzp6E2mzwca1SYNHr5A9pX1?=
 =?us-ascii?Q?I8oPpPMCjNhUxHAZLTKGvA/R9ZQ5zq+tgtX9TjRoxxrjJdsixQ7tsXNTsEOa?=
 =?us-ascii?Q?lSYX5bWbn1vk4VLo+P4SdjtmSsHVkvrre6gBlm9lyrE0b31SAhkcH9hJUCQ5?=
 =?us-ascii?Q?5Qp1sW+knNdS0c+QNGmmd7NIdapkxiq82iXLyHzlGjCcc5goiftCXm7U7fJ/?=
 =?us-ascii?Q?qF7hEZG5LOdb1IikPUatyc5IbRNhrkouFOdcBPyNkLYoGgk7aVFa6S/jsO7j?=
 =?us-ascii?Q?1+O0aOety98DgFvZymI1JSNTOP15NaQ4f8gqYhf/bopHaic+TZQbZua5HJrB?=
 =?us-ascii?Q?VVg+uwHq7jpATOMKF99zPJRnvvCdK9Bg+et+cboXy5c7Lk8uMcFpR0P9FGPX?=
 =?us-ascii?Q?5gaOoUuvdojAA8c72WP47399sJWbYcTt3EiHiIldB1JvHqIqbYBuBib+nZZG?=
 =?us-ascii?Q?0QgqQdV2TJppMsMqVFnBCEEdiIT9j4trBi1cCDjApYSRAZPtr2T+fPhlYEAf?=
 =?us-ascii?Q?cuhByNwDFpTrawlf8sGUR49lWv6Iybm/ArG1fceA5RfcEoUtyWT07Vm/0cYz?=
 =?us-ascii?Q?7x8yUveEIsKT3mvbdMYI+Bjwj+FEkcUNeRCOwOvWDE7Goi3orlA3VO9F3/kl?=
 =?us-ascii?Q?8giYvdYAIuvCl1fBo062Tc9p1I8KUH5Y1PmzFxp1/icSXN7QHW4b/NpgzMTx?=
 =?us-ascii?Q?dWlJ53lsrF9dxDh22g3foBjuk0r+6ejCTuE4UrVisF3ZsOf7yj8snONCX2kf?=
 =?us-ascii?Q?2EMHcQlxiQO2G6gD8umO0hw6EmGB67Sp3hUmdsQV9rlo3HYTztFcVMwlajCm?=
 =?us-ascii?Q?/Doh5mLbDwd5Z3/RcWPi3zZ9QDOfzCbFQz7TvyMaI+yDDXtTZ2RzgEd7ApD9?=
 =?us-ascii?Q?ox1PO987xP5RG4DHTTZsrRdo/7xkks1EjCjBi/6GVsUZGcj7hk9AZwQkMw7z?=
 =?us-ascii?Q?hxqZ5e6ktX/Ls4+LxmfK4jSMU5510+KjF/2O7WrKir/dvc7QrckOgVx5j7G2?=
 =?us-ascii?Q?qXgcW4HKkwrIl88Mc70wCWiRS3Hv29XYX8V4QNyJSoABuFaYJNC2CCHoEH+N?=
 =?us-ascii?Q?brEz2B0mwCUJeZD/7CyfkVm0Ja98f5rF3vCXr98Jw5eT2d9rrxj2+0OjXjtX?=
 =?us-ascii?Q?quryJOXVjPqRRk2JYU+3chzTEn8ysxDC2XbFm1HEuyqUuRpm6Jjw8Qszi0tc?=
 =?us-ascii?Q?oYi8Lc+xYhskL6XRAOFMOEQ+FMPHCWj0ji2nrdK7/Ncx9LCZvd6ivgPSCj/G?=
 =?us-ascii?Q?Oo95a8I3TlL3vWKgPGBwWhVAMg/uOerqbnO9c53sDR6CKyTKX+RF5/EhdjzD?=
 =?us-ascii?Q?StWu0fycpkbA+9fARjpZ/tgusFkI1POy8LM/hky5fwgergnXmRM9i1MuKWVH?=
 =?us-ascii?Q?qoqTng2hbk4B/Gy5x0QU/k/l1jPLy/nfADenSXzDZS0576ORRMAdOKelIdXf?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RSDZcQDXrN8JD98jSN/3gzylp+wJxTOgP8Ggmkf+twkKYs9RuzM3qJsG+UVuLb/VZgQvfSED52xsW4Jvhabg4qEB4lU5wJiwnsXGU0/xxxVYFycwz+nJY6ReuQSH8nUwvdcgBVoIquU7V8+53+RxAz9lRXRaX+mKicv0rTNCqXbXw7cGLQtNfcXtQGFkbzEDHar49WbWsmG2NraIyjBYQLUXbxFNsgZNfq1+zrhFJGVPdX1KgJuWg9iScqMRt2a0XFIg3IRCa5FoMz0wO0gFTcSnJEFjAahUuUGzdUFeo8BNfcqy3TocyPW31H2ADT7QZOaS8sq7XaZxwOads9vBIbVBzNiVLkysQO4UmVkv2FM+8aoiVA7QZ9esNoPV9GQ9GclfDjc8kdV6vQa1lNOlgeGuP1FcN0BqZZWcnufFl4KoZ0vzn0im36P0DYrv1VYz9cVgMLLkTdeudGWpr9FabEVt91Bor0ZAuSZP3J3esAcRXPI309SrKHGdRRdawYMqD/ykLh8280Mo3iVmJ/iwHmyU4zRmlOBpL8R6e4yo9v5i+evsxnAcOY9OL5+nwvA2HgfJ7ZweTEBKqN1xb/bHIWslcFQp56wSiwcS0UxSo1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cc5779-dd7c-430d-b595-08dcecf803b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:53.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/AzC4Xw/TvcPiMAG07pzDENqEzHBLQFim1Er4yD4McSQlRMUM8pyXP4shS/jpILOKydnAUnYNdhYsPsDIow5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150060
X-Proofpoint-ORIG-GUID: Uqejx3LkqsfNB_L4sD_mFDkjx13CYNDB
X-Proofpoint-GUID: Uqejx3LkqsfNB_L4sD_mFDkjx13CYNDB

Darrick and Hannes both thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 8 ++++----
 fs/read_write.c    | 4 ++--
 include/linux/fs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e696ae53bf1e..968b47b615c4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -35,13 +35,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 				struct iov_iter *iter, bool is_atomic)
 {
-	if (is_atomic && !generic_atomic_write_valid(iter, pos))
+	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
 		return true;
 
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -374,7 +374,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
diff --git a/fs/read_write.c b/fs/read_write.c
index 64dc24afdb3a..2c3263530828 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,7 +1830,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
@@ -1840,7 +1840,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
 	if (!is_power_of_2(len))
 		return false;
 
-	if (!IS_ALIGNED(pos, len))
+	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..fbfa032d1d90 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


