Return-Path: <linux-fsdevel+bounces-25807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E1950A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076EBB23296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8341A38F5;
	Tue, 13 Aug 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0D7nCBt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WBnoJniX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B41A38EF;
	Tue, 13 Aug 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567116; cv=fail; b=EtqPe85k5QYnGqoXWorsqtCaDOQQtyN2vwxfLua5qjCX1IlBZEoNT114pw9dHmdQ8KLHqZzzYf9Kqt17rJDrnM5Kg4f/etBeQ5vlagHKyV5NFPV1SJ4pXQJIgqC6jegGVsEPTHBv/JibfJLaMjv0UVhRr4GC9oqjyk53HCZRBGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567116; c=relaxed/simple;
	bh=B6SMnyeFKBH/KVgsMqCFUs7k3Bv1sSdLtVIYxLSN6ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGMVkwGHZfuKye3MnN4GNAbodq0w+8bFkMCulCMB1M+BMIqH8710CN4HiXuxciqMPfeCuUTcHz2FsEaoxehcAqwnd7SfQVGavkTJmewYYMPjX0PtrxlF9hB1j3i3Y4Zr405jpW8IplailOn1pwT0izx/B88M1Yv3pvu9Xq34vhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0D7nCBt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WBnoJniX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTrP007385;
	Tue, 13 Aug 2024 16:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=J0I4eHC7It2zetelmXV4UCVZgEaqiV1PPZw2a3x/WhA=; b=
	Q0D7nCBtZ3Z2P/5IBRHfZ3UXG18TqewO4/g42eIr9Bf+3SMtl2ArIStkbF7T/4eN
	xJC0L1UE1lzcdguH4kag6JXSaM2g8qvy5NwqcKjdl5F4CHGY+yPot9g6u12FGMDQ
	alPLPMfY2m4hxpP4gnQY1OokbAqAnfjO/kfISPa9Rdz9/4hLx3hCzKfoxcr3mxem
	AaTN2Idpz7/RG6ecqj1hAPtiqoNSWUzDTK1pOCg1D8wzzwIZ8W5pKbZOJ9Kda9im
	2DsmbKPbsMzSl4B+brQOSyiI2Yvsyybkw0vN0+nW15X6j97/qGenaen65uEqyNCQ
	yaDWASATbIjCjf6KPtxsJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0xfgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DFOann003532;
	Tue, 13 Aug 2024 16:37:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8q3df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd/xVKhDUcExYWTFK7VkamPCctNE8Nmz4ZOn2oLSQ6imU1NpT5Gfwah4YNfNmJFGT4eoAc1Ux8GHcJ/IHWuH9bdkcOvxoZ6hISu9UBhVX/b+eCCRLPARiGFmNwseGx5h0LhhspB946GUixs3U8E3BxOAoP1SYSz2q9WrhrrRdHppRRzm89A4oUnwKFOM2eZBQvNmpXmM/ueOpaQKfXKWd0SFPnSKSvUFiaojJABV+P4FM51oxnBVCKjl8RaCSzwRB/vB+9ZtNBG+Qgco/DZOuwwuxYN/FgxgCA5fPZRK5OCnwgLM9am57XsaB07B+MuQN0iO9OT+QJAyB0Ev7VD8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0I4eHC7It2zetelmXV4UCVZgEaqiV1PPZw2a3x/WhA=;
 b=rsfhvbWHYNoYYomjKBnhTmcNYRXcx2dvQDx+HLwh5QmyWyQAKa+6Jug6cWq9oL1z2A7QEMXRG9z5/C+/CBdB6WYB8MdwpQwh/KZuHqgWXtTu7yL+26ADtK6Ui9gfgD3oXaO1ItMreqL1Lip3skCIRyWzTvfqEQ2xLhHzPu8HRNUQP3NMw8PYHYydtOKEtfQl0jGdMqwXqCROoVoDYhNANmVdnpptews0K6Hhk+u6/DyEhF4THDp4YOqhSHces3I1soYtetE6zmF8o8KjcLpp7aPyRFiyooty47IsuJlSdxIej10CRlFA8kr3m5yA1hDuUJHqfzh1Hv9IYjoYoIHm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0I4eHC7It2zetelmXV4UCVZgEaqiV1PPZw2a3x/WhA=;
 b=WBnoJniXUMAwcB4Ew0QtegEngoIut2GtP53KBpE2eKSe6cWdAeNCNnrWuma+4Ierlc6FlX3jDmSb6skq559CA640L4gE2vLe/vwu4ab/m4l56/jvT6SIsJNM/JY0FDwetqUe2GLIyXBBQ4cg7No+zjKJH509elyRIJMbMIm4Zfg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 16:37:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 09/14] xfs: Update xfs_setattr_size() for forcealign
Date: Tue, 13 Aug 2024 16:36:33 +0000
Message-Id: <20240813163638.3751939-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 889bd875-6169-4897-4f5a-08dcbbb634a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQ+vJcQhHm3ATBEAUEhTAarRthE9V/MaRh+go676iC0lYWzoStCMf+12JBBC?=
 =?us-ascii?Q?008Xo5KEEbN3ig2s9d4g6suhVQvgMcVHSIYD6gYdoaJaJhbG1L0ywOLDTiGs?=
 =?us-ascii?Q?HGRD5hxMazA0DZP4+57DOExdFE5HdvPyD+VKsQF1TwXBSUmXHmc4klkkUrY6?=
 =?us-ascii?Q?pCoWXjz3DRbGBXCqULBWRc4swczmWCkDbP1CLYITWtr6yJNc3RqYcmgNYQCa?=
 =?us-ascii?Q?BGjTkvxrsZcn876KTKmAsmU+tzaqmySiMaACHq1JhClUzrNhaoxbfKN9IwwE?=
 =?us-ascii?Q?/X7YY77pJHelzN/dXFY0w/VN4PO3DsnA+FuMj8+HLCY9eyKakKEhtbuQpwWU?=
 =?us-ascii?Q?0JOLtVb1scWH8V6Ti5VbydU2S6iTkEWA4BNhL0goGUKFU8XID1tWxk6ZRN9v?=
 =?us-ascii?Q?87QISHUeooq4BxmsRBZuNvr2C7iC6AgKsZA8hKxd3MfaiN+uqqh7o7ExuRTH?=
 =?us-ascii?Q?7zJhbx6H2ZbvnJwz423NkRqOx+ibFkht61KGTRH38W8+rvjTcu90E2CKL8vI?=
 =?us-ascii?Q?Vb6BHfVlPd3V3/OBZAENfYo35MaBxSzZiUD9Q2BnbyyNDln19titmwmfXomq?=
 =?us-ascii?Q?m5FVMNZ6bScOcyQkj4SMDivTDHuHAyzxzZW8c3x2l45cOibSdaQ8Wu4KHYyf?=
 =?us-ascii?Q?3Xst80j+bTKrGE+o78bnqi8pzGt3vE3csDF5wb3q0MENqN8ltQkaEU+oZE1I?=
 =?us-ascii?Q?nTfJ1NS4Uee8HbeT2tnzCUFOddq6IG1wAadOYesgrfCvZPguD67J/md0y7ON?=
 =?us-ascii?Q?F3m3FbJIORHgB3umxbvalS6lhp8J0KA/mZ5Cx72xBeCrIRslAWMoiZVerDLr?=
 =?us-ascii?Q?rS2EHHOW/64b1YDq1vSbx7bmkNZd0unjECBCyq62XcbNTl4l/c1k4wReOfM7?=
 =?us-ascii?Q?7xuui+0iC0N/M8ndjq/svpVvkh0jwP6oeD3fwxMdErNabVceV2p1kWM8Cd6Q?=
 =?us-ascii?Q?hOF2EAuS2HDrYop2/fI3YMYmmAK0QhWyEFTjG7yR5gc8khYvQDrZv/SJkSu9?=
 =?us-ascii?Q?fkM2IPmHOeQSln7TBzJuqvRxh1mdxotWia7qy9/YaD6y55+GN7s1hVsSY881?=
 =?us-ascii?Q?xT+b1pZ+usG+Ckl4NO4iWW8oqEQXkf2gduiUgeVaKMIIoGG02L+pIdlF04O/?=
 =?us-ascii?Q?8C1Gu/+qYFNzf9DT8XRHPyUX1rFSKMdFs5z5+JuxKN6+c91ET6nByYeBkKmi?=
 =?us-ascii?Q?77R/CVyrf6Xep8eqHifMu/uRJGJFUqcI9aW+xVCabR/q7pTddaBSIxZQeCHO?=
 =?us-ascii?Q?JjMguA/2h+cnuowbZBRspZ8aCbmpUwSyFgVoVjo0yXnKGW5gR7R+/KqCmkBz?=
 =?us-ascii?Q?asAV15oci3Pw8VL1bcOeOFgXzaMrQShhTIQxMFkEWnrsRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KA2bh2VtltfUf3356Lh2DNazMt7T9EG/d2GF0jcrcjtZP+NjjgS2TUQlUou5?=
 =?us-ascii?Q?j7paxGQXLerrsDXgSLjsMniEE0QG+0jQbFtzcdT9otcnKpE6ZDBll6zt6f+o?=
 =?us-ascii?Q?ZuEwsuQUtwSnrM9GaX3j565xMrLL1GiST8fBMh13mumdCgTc8D4V/pBvhUt+?=
 =?us-ascii?Q?r8CPH79KGOSeHClrM5kdC1+gm53arnRAid2/UDCZea4IH/XtVutVnCy6KK3q?=
 =?us-ascii?Q?5XN7bNkAfPvZq5MGKv76XkmeJxpOnZST/MmBRj5LRJQ0ysNG3ARyrXbK1dei?=
 =?us-ascii?Q?OHAylmiW2ntHdyRz5Lfky6B6h9T43J/qUOt7rAf/PAhb9ohKRBdgv7/dnPTT?=
 =?us-ascii?Q?taIj5mBXd3smfstkFf1SlZtDzORi7HJv5XM1XID5kimhUZ34jZXmI4u7NDMa?=
 =?us-ascii?Q?X1csuzWgXkOr5oZWPtfiAkBTytV4X65y1CE66jt/jcgJHZ7xbGiJZ/w0JJvH?=
 =?us-ascii?Q?WTtzA9eSVOVD8WyF1CHwIj9r6lyjI7UWwtjH8LARmLdRNqh3QcomV6BIspys?=
 =?us-ascii?Q?Cd3x7XuXuomcU+WXYD4MCgpLpetFR9f1K24B6lsix2RrUncDzVgBgVWBPgM6?=
 =?us-ascii?Q?WQAlSN2vXoD1eV46Aesua+i04mPiEqH584JXs4ETp7Kt7l1xxGOp5Ha/Kqas?=
 =?us-ascii?Q?jb2l2mfSUkQoOO2T8N9XZV21PsmBDqTg57256LMIg+apc31KUJ8g40qLmfpK?=
 =?us-ascii?Q?UldGriX3LUpEOKxWb1Hfoy6FLMifJp3ov0gWaGmSzrLitht3H1Owx+Fo/ycF?=
 =?us-ascii?Q?hRgReAx+2/Nb8d2E9tCYWpLz+ojXaDy37zcP1MvE1BIuvqyRPlY+CjIRG3N4?=
 =?us-ascii?Q?2bhjB5/kIRNgPVW0TmL3ye0xmCm1eMlKppmLK8Exrc/L0VQGTp0+0hJ0n+an?=
 =?us-ascii?Q?t6Va4p4DzZVv8Up9163dBdYDxfG6ZWtwYMZ8IcQW8r+d1/5IW4hLx+y2g/sH?=
 =?us-ascii?Q?UHFGPhwyOHMJEOLs1h7k9UBnEH/x95eMjvYrV++47NaCXP6elFVPuVEK23r+?=
 =?us-ascii?Q?kwqQqOsB53IVvnxTQAtXycwWOjdl1PWAn6M0mTBQcim1YFqD81zgCxJT1sE2?=
 =?us-ascii?Q?jqR+2o1P6WBFLpjUUZ50xvhJQStc/KF8cwUHDxMKDoHv5PHNWAYWOhTENsEj?=
 =?us-ascii?Q?8iCJ33C3l3Yo9hXMtya0g+An6UG/ZLls9rj652cgLYU+vAuNysId13oHjNNr?=
 =?us-ascii?Q?KkZOcy2oXrAo/aUDyAgmXTE5M79FoLcghlzkPuT1mU1VC+rGiu3XHuZmOqOt?=
 =?us-ascii?Q?sThTLmbKLdKm5ynnhCE3xAf7RPOQGfNtVpik/lFd8JSyzjMQ0zzyX7oky9Nd?=
 =?us-ascii?Q?FOVIfKwqip8Ie41rHTNEKFES89Ui6jUM80wkLZ3oQPgfx0rmeXuvWhJVqYsV?=
 =?us-ascii?Q?XAIkiI2GzVpaLLQZczdHPMhZCQdlYnU5WYWel3Spb3+AqkKcU/1cq+osq3oi?=
 =?us-ascii?Q?rFNH+nOxgvaQImx2kRgRuFnoBR2chK1+o4zyOSjpokM4ivG/K3YQcKKAQrhR?=
 =?us-ascii?Q?vzAQCkZEY/YX29yi1FWdOFZq0GIQCh6XBRTX2L51ZbfWAB9qfOhgD6q724zQ?=
 =?us-ascii?Q?mOjOpfJW4WdfI+gAvaRO6DKTvDAQWgoPUicy4nBN6baU1pLf7M2lupTOAlvt?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z6SbtTpOQ05Vkt9Fz5Ga1t2bcjZSQp/4EMbrgLBy/5vFJ11GPiwYktDkX2HRhNRYY1BM0iOKbhCejYYZ7MkC7R2v67mODbHBqYFLkFmKfWaKd2GNLP3Xp4Zz7WNl/eUgCb7/bNIGo7LnM8BtV7QjRzV+THvOkvKcaaNU19/Jbh02JxyPPf+wmnkabAbgCUdbFNq/+DtD8GjpwxYynlMlSHkAxIClUhUciyKz9KUkskc3o2UgdjaF2T1DthxGxwbyTp0YVv5i6vYLH3llXReZ+Yuah6FIKPDleoYayxWUnP4NGi1OFkHDtT+2QgaV6ukBQfDN2TVl6ut3Y4Y7MkfqRT46RE/Ng2cjqPmgtgGw8C2nKOOmEyYqc/761+Qg0M2Kvam/tvdmT5Nt7lGKJ0bA/bBVDYDJPw0eN/kjEMFSK2mZNa1qkzx/fjGHoOKKT5IuIgJXGVpBq5FNRzWEPgDkTXlH3rIYva32+tC9PABiBElYUuV2lvCdFqB6u1rHdCI5aQiE8lP19HhfK11d7QleKjy8jYELbn8R//o8ccBdt9JeA5LY+loyArnQFwiqidIE1Gk3xmtLSnKyU3l+W2UPmY35wb3D34R3pKGLvXC5V58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889bd875-6169-4897-4f5a-08dcbbb634a0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:23.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTrTxfEUQ4PnSbKaoTGQiKrTnfbJnC+koO/4OI5FxVA1NYOcTDjgGjJEZJX7Dtusz0zW65Lp8gI5S7cqtLZ8vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130120
X-Proofpoint-GUID: g7Du_1t26b2ICkobVI8kMxI5nZiPx21Z
X-Proofpoint-ORIG-GUID: g7Du_1t26b2ICkobVI8kMxI5nZiPx21Z

For when an inode has forcealign, reserve blocks for same reason which we
were doing for big RT alloc.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1cdc8034f54d..6e017aa6f61d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -926,12 +926,12 @@ xfs_setattr_size(
 	}
 
 	/*
-	 * For realtime inode with more than one block rtextsize, we need the
+	 * For inodes with more than one block alloc unitsize, we need the
 	 * block reservation for bmap btree block allocations/splits that can
 	 * happen since it could split the tail written extent and convert the
 	 * right beyond EOF one to unwritten.
 	 */
-	if (xfs_inode_has_bigrtalloc(ip))
+	if (xfs_inode_alloc_fsbsize(ip) > 1)
 		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, resblks,
-- 
2.31.1


