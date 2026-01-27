Return-Path: <linux-fsdevel+bounces-75601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IQSORjIeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:13:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B9995735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783033071278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25928C869;
	Tue, 27 Jan 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9KoTX/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hRqkxI/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3C1DBB3A;
	Tue, 27 Jan 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523002; cv=fail; b=A83r8kTCmRrq1riBYY3RB2M81KfcS2AFyvE/fI12EcOoAx0EBePlRYjgwtjypek9nh1HRw5Tk032t0Qu3IAS6YOaLAbMHfAPHF+TqbpjK96wChplXEKd0JTNDRiXsH5B/M7M7eLLZIBIG1HaIwLP6EmfWhZmBpp7mvhY4BHDoEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523002; c=relaxed/simple;
	bh=9regKZ1H3mC3WQYPrZrj1Hzqksye8Jq5HyI2+HoXCT8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=cj3bcCFgmoAq+ceHV14L0gf+FK8Q7hZNLPrqCW20Q56bFUzFNI5dOnK+z6LlfaiK4wwDn6j0T4OnsWsLFsP2aCFW9nmVLg9zbNj3uwU5wwi27djpWTAL3XS16Qi3Rzn/TFE4FO0uTpZirX7xyrcgivWLuhyyizFSYridZ1hFKD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9KoTX/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hRqkxI/L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEMOk454960;
	Tue, 27 Jan 2026 14:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2F+trVDu90KSNBKOK0
	oFOuTCK17rdl4sMPCbWlcpCyA=; b=m9KoTX/5u/prCVhdKuG/NCYfLqyGqRQpNy
	zI0YpIoYkGy9uh6HCu3p5t9FSh/sRv0a/+jEoHrqHVTaH4rFONF3Dgh0SuqIqKNX
	BQ+Hs286BsUqjLBOe7AHQ8I3vwq3eKqwYfwHVPcyCqwhZqSOmYlGNXxUseqWlmtm
	CKJpbd74YpLbW3VX9CTMCIT32ibVLh8Pw9/MvkvH1L8fVs5BQ877J+g3kWxqbmEp
	10NEFUU5sCgtvqpG0qa7cwBBPb/Y3fTlk3NK8JuNq6DUJAv47kIR90ntC+E+3OXX
	m29qpVh1AqU9gbhl6Zf4hTPZShKXFt1HPJ/k4HRPmDJY0cV9HQVw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bv3gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE4alC020001;
	Tue, 27 Jan 2026 14:09:51 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmherauj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZs74TZKw4XhG1pvQeC2DVvtlIhbA0olS+477ojFtAeG/l+i7fFtc/7orL3CfcNPnJJEP8OLzuBDraJbjssmR+6vFIA4jyw07t1Ir3C6BgH+x3GrLMlP1AQ2oqiidmcotc2KgUWJ7/ZWaWBVvPrH6CbItdVLCHMPxtOQhvHQH3Te4kw2urW/l6fPO4b42x/LTj8NnfwFNggu/DqQmZH2vtV9hsV9Tkxjg5IgWY5b5V0CR2R1xh6mFq/8I0ZwJfAaNmn5jSlgRKV3DgVMGLVLiyT7LlqqkRNW/gUIPxwuF9xfzb5CRXYRvnfyYkRX2yMZMZMcd+3yJlFdnNI4U9AVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F+trVDu90KSNBKOK0oFOuTCK17rdl4sMPCbWlcpCyA=;
 b=p5b8SAq8EtMTFR/EcDgCF0AsZusooPBZMM5wpNKzMoggrCV6rROEZjSJ/3W5ZwMyw2GB/5zfEkQfDN+BnWSmIKieCI5Mn81jD6aqLU7X4aUsPSbKDlPaUsIq79CxUnN6Q70AcW1K8bb8lGLXxkrow7VMSbAG+9MfXxQ5q84NoUgeVfXgPGgMY8rHDak/+IwvOy5PHvQRiTU47ZWE12l8O/5vZ+KaCP5F4MnUHnkp035NESbHMXNFs9mldPNzGyi18FXrDzOyGjUyOXhtXHo/CCqQ1Iw5wQdl17I6z2OFaNrU7nfztBrz2VYuh8FdWC+XNIxV8PeG7lzpD3hMeecxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F+trVDu90KSNBKOK0oFOuTCK17rdl4sMPCbWlcpCyA=;
 b=hRqkxI/Lgc1uBEA7g8uF/Diiuay1m6Q4Bx8h68YnxtD2YRwJJNEHd1Ziq0m+msa28837TiZKlvAbAf7AYF1gKxsRHd4g3+1nlP51SHN53E2qJIbWKOjtIXQi2DxZJWLkIrLy7FGlNNuCgbssd3RZsfHu1R1RbytsfcUYts8x7vQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 14:09:48 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:09:48 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/15] block: prepare generation / verification helpers
 for fs usage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-5-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:12 +0100")
Organization: Oracle Corporation
Message-ID: <yq1h5s7w3iy.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-5-hch@lst.de>
Date: Tue, 27 Jan 2026 09:09:46 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: 01020d10-10cb-4c56-4a2d-08de5dadbae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5l980xTZo9LzHsxvFBZxlK0a5KVRRqYb2phA21xqWwnRIrS+PMTQqZB6OuEo?=
 =?us-ascii?Q?4sn5buXILE3XA1ppQXsetmNcJ7kk2yWN+l5Nwe2++NYnlb/faz5YgXS/96xz?=
 =?us-ascii?Q?HzHqOFOvmklRNamZ3Sl5X1nRUJz4/ggVeMx0gq2ny2D7jrk5sUTIWM7QbLCI?=
 =?us-ascii?Q?CKWaYz8qs7ngNyPSOyEFmPr+Tc6iimsmvV7vpTp2ZS+u/Ujt5WtjUKdD8PNR?=
 =?us-ascii?Q?2Lzo0UiH3WGuB7L6lJPMzRxqb4dHo6N97b0mmdnudtV6WQ6VABQB8OnaTd8o?=
 =?us-ascii?Q?cpZMpidCJi84w2juI6oCJEZHcYO9g8Ktk/Zp43zBgJQTiGbOC2of5IsTEXEQ?=
 =?us-ascii?Q?UQF/tJ+Ab4F47kvcEpF5IwWgOUycDHcY3IXh+SlxSTT7Hz6GBZUXkU2V9sqx?=
 =?us-ascii?Q?DY1iB0wR2UAFboM4RtiaNe2J6jcf61Zn17wkY3XgbEBOre2r+AecFFgLqVt3?=
 =?us-ascii?Q?Ok5YcmuxqxKiR4iNitlXZ6ih7JsrgHTUuISNXZBHVTx7Pv7MvWmS6zLX/Gb4?=
 =?us-ascii?Q?teFboe+haWLgjvoRubyNjjN3LwQLthkCgUopzz8tLKuRVxYO3SW6NRv7ofJi?=
 =?us-ascii?Q?ouwokMt4J47WJUnas6ZaM6DF5GbAXTeCtpr9JClz5c4ZXnMFrdBMftMF52+X?=
 =?us-ascii?Q?vq2Ap46U+gyTvnQadbx75vY8M66e3MXzDJ4uVUdYhbH6KMlWMlu3K2sVYIMw?=
 =?us-ascii?Q?MSSqrmXXiir+8aOytOUCq4c5bWQoaMsdFpSuJaytETWNeYgx5HN+wjGnxXiQ?=
 =?us-ascii?Q?0nmwvB1I4y1vPO/ZdUCQeg3/b34FsGRiEMeBBnyjBOOk0pLv7MxTCTWuF7vx?=
 =?us-ascii?Q?ZrkjlndvF24Nilj+KhQE36k/+4V3JDSpS4Q5eDRHkR4Ztw49VRkwlf5MowzF?=
 =?us-ascii?Q?SmlxVchjjhM/pge9IsIrwXCrlY75CNCuTU1I8rjJO54OxbhSxnjvzk5E9ylg?=
 =?us-ascii?Q?5BFpoaH5fBfrSb189DdrAho1VvxrC0XK8KgqgAffdF1XPw5RNKx7JXRnOnLH?=
 =?us-ascii?Q?WkWXYVLbB1EHbLLwYcuEywSNLIlGommAVwVlzumYshusW0Ay9XlvH4Krzz1H?=
 =?us-ascii?Q?7QZAzZA4js0BUF7GAl3Xmb/aabozWyu7Nud4NsVRmkLK6glTkLr1UIEijrre?=
 =?us-ascii?Q?p4uTdzEumErgmLkZNDqPwp8ofFkaYJ77eyjglPRTLzBA2MbV3f1OPXweNNQ2?=
 =?us-ascii?Q?itDRGgI1hC7WMG40mcHvQLmRILg02oBQe8XgCsUVufBrKgLmes+7oB8MeQ7Q?=
 =?us-ascii?Q?0emWO51qObK9ozLON8FhN4kxmeEYCcCoOhBYykrjPycNho7hfteUzL1ZMF7K?=
 =?us-ascii?Q?8qdeS7S+kElpTpBJPZ4gOD6hMau05ahj3WimQOs6ouGyUO5tmQ3DT0W5OLIR?=
 =?us-ascii?Q?CBYr7jKRdjRY+oBAnm6vZbkGGWCrLCeYi3FkDlpmqqiI2EiJI7CYBu9G8+Ue?=
 =?us-ascii?Q?Lt6J6F/2wV7+KKoi3Rb5K6wPbqh4k4yNHy01Ixr/hZg1j/gfjckPX8qX4Cgp?=
 =?us-ascii?Q?Kxg+3IW8r7odaY/zt3Aji6z2vQaEB369Yu6v6eoIqltZhwUWsr4cKiuwg2Tg?=
 =?us-ascii?Q?SjV6981w0C8AY5Ya89U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDVxPuN02XDWzFA8n+XQIYgGV7L7wyzdyRhEJW4e1Sp7SAjZwJVAp2iX2Y49?=
 =?us-ascii?Q?ordPKyVj/PWpZlhz+zQMVoAcdy8GxTRSFI9l0Z6RB9783hb0siUj77chTfDz?=
 =?us-ascii?Q?MINymioosQ94OPLy1m/J/fpwEEwaAVgEsLKHysQEvOKJhMa0ZfvBBPmhCjl1?=
 =?us-ascii?Q?XU/9SefXXI2CMgRW7M21LnF5NKa3vP4/3+MZzVJhLmNbAhQ6JQFuKwOZvh15?=
 =?us-ascii?Q?6fnK45bBsPXjpSeq56PX+NP2SqCJmlfynAdo27PKV/j+jQOYPQlIy4bYPjKk?=
 =?us-ascii?Q?p6hiSGwWK+o0VwGlupZtNhV0Rboua3io8bPT7gIy5KLkDpIi3nbmRxteXlJp?=
 =?us-ascii?Q?YW5LxEy2e7GM/tyetNipE38juHBBCY70xs6jdqkWxAA/ZGhLOfPwghTUsVu5?=
 =?us-ascii?Q?N2QApPhXkjEEplL/47GqZB9ZVWp3r96ZNQIk2kHXlJ4Ntejx/LB6HT9wqzUu?=
 =?us-ascii?Q?2hHmFGt5uj326t+l4ufrj5qJPKauBVUwQ7IdsE0LCbK3LU4LgKwqXHYSi8H1?=
 =?us-ascii?Q?2quv2PkPJ8I8IGRgntKU2Sxh+bR28aEdJ+oWVLOb0SGU+sE5uTbcLzvT1PnD?=
 =?us-ascii?Q?BM9/5F7A+cYrE5HG7dMhP6W5WM+hEPHsors8TsGWCBZNNuNA3hocEOY6tamK?=
 =?us-ascii?Q?t23IiyDNOY/Ce6nKsrLrZqlh28hiNu7B3UO/Frt8yfguX9PD07L0SHiwCHN7?=
 =?us-ascii?Q?0SC4TxfU/X5plpzbOTJVlwTOEa5V0tZKn3o/6RfRexnwDzd2sqaNb4dLethw?=
 =?us-ascii?Q?1dcqCnHypw0SGeCFQPvnUqZ2VY+SR6jlXQx6FL9el0ZpzoB2MJPywCFwBbuN?=
 =?us-ascii?Q?TT1TizLLqZ9SokNtceEe+jBaGGoW9kY8GdxihYcyJ9rjyZahEV3d3ILjTkKc?=
 =?us-ascii?Q?0+yORNJAhhzmJ8Zml9ZwRCcjoKaLO/2QNz+FxdMNdgeBzFXTC9pBP3GwLd6Q?=
 =?us-ascii?Q?41wwcOTfldYmSt7MpxZQD+5ZL7t4L2qkKkCYKZdTwHsF7TjPB08rOzMjszyY?=
 =?us-ascii?Q?IOQPYVAsk4jxnpQrgWF79beaTZbbl8eWKjOBZ0bETwXUD0w3Ql46hWWVlubs?=
 =?us-ascii?Q?suDOqCG2Xue42MSC/HbzF1EqjseWRl96H9nAGBseZUGsttaT4YmJY9hgFznp?=
 =?us-ascii?Q?7pths9Rm5Yd1x3DCSuPkvdmsPyS/aks1mqTtWErNhbx80wQTJ0YBAfaSXRPq?=
 =?us-ascii?Q?whviDLIY9jBTEFlRy4vMK5fJccHi263XkRO01u+mr/h0+HbSUjMdxbS+t35g?=
 =?us-ascii?Q?s758JpH79BoACyN2gaP/GlWp2c+NpwOr2LBAHXYRt/C32lzdEsONhS7zUq4o?=
 =?us-ascii?Q?Ax2zdOUZSbCgmJ6Y6rU6bu8ucOwfvEroAXVRMLZAXRMeSJf7HxvtBWOxfmcl?=
 =?us-ascii?Q?gO5ZY5G4DMoRRI+wVJ+z1XgNNXgeOssNgANRNxa5TSc7biA25eTynRghnJuO?=
 =?us-ascii?Q?Vvt2mlywzDdcalQwO3cSQzjqx49IlztO1aLH34dojJgNaLvbmVETmn1Zh3ev?=
 =?us-ascii?Q?Q9+RC/bXk5PsiNguy9+0SgfGd5ag8Tc6rVmxAJs+WH5cK3YZa5Y7oGYy4tQd?=
 =?us-ascii?Q?BajLRrtOwrDhoozoImRlTwzt/a6BaK7IBhUjv9Sb85V6LguQZa2PYX7Z/pi8?=
 =?us-ascii?Q?+4WKtZF5ypRXALphtbbbrVFYqaUavi6J4UC4wcOflmV1ULljImWtlx9QF2ZR?=
 =?us-ascii?Q?nb21PxLLKikdhY8Xn8621usBVpT854Ymr02TjNydAb/VN+MmB3iW8R5T/kT+?=
 =?us-ascii?Q?1GsYqP9+1A/p/9Pb2tPY1HORdAXDY5o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h9W39d0O219KTRQOWGdLFN6qGZ6rWjrYdlwC0lzRJucBFZIhC+8DhZEHwGx6t51nfUrww5Drr4V2liq/k+KppFHyLRz34BMGM76m/iS380PTLgGGLV782r3OWiOV0ZlSX1ysTVTnz1crdCzhXakQa77ecSbo85xOMH0cUxXvlj2nvpjRpJCQKzxkkV7LBdZiHl53/6JrawhL6czktYeSexVEVd8cXpMG+f2Ud1Zk6ndo2oTGOx+J+d8pqYTIAKLz///ICwjEJ5y4VtNsmr2NoJ5dhrQF2XXFBpALUpRupAiPNA1y9x3hKSY/TfN42HJPlr3ooF5TuOttf5TTi0A18eH5Tvjw5cLRgWk30BKS8UhUMfnQXm1AN4SMvKCu6H/KJ1pXLEvJ74XhBISetaE8T0ZTCfC874EiKeVTfKKaGOvrHnwHDdprGEuRAsKiSjNX79IOxNG5C9/u9lcCz1c662Pidhw1lzMQcHWWysJLpYoVEN5KXPprcBipnLtKiKW6jhRSBQVjdqYtsuURJ4rox5G5iSeLkbKmQc2dixw2j2VnCV7PDHfDFeGYb+R43RTmg2oHbOtvm/lFYHEcuwku4h2UIGtF6+AFURca0ds2AqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01020d10-10cb-4c56-4a2d-08de5dadbae6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:09:48.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4D3MG3J22ululTln+1TqGvnRkIc5qX97/GNwgdCpxhepG6akzdh4yzB2j+uPlvtD/YXCPPF8X6NdRtC/lg/he8KiMLj9W4KLxxqnb9Tn8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270116
X-Proofpoint-ORIG-GUID: XyNnII82yltjxqSK9YIqk7je5oTR2f3K
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6978c72f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JS1w2vAPsfvKxWZqQNgA:9 a=MTAcVbZMd_8A:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: XyNnII82yltjxqSK9YIqk7je5oTR2f3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNSBTYWx0ZWRfX3JK8hFu/yilb
 EcRHjJjocWkvo0YiO6PuHjAyNVfK0lzR/z2IZOA2+G7ULNv6bFYowQ9VaM+1Ffbf1Msi3ocQcRO
 q/A9nfxTgFVnjYihbMdIX0sDk/5OIAXuHm3o6VFBjBKg3oQSZNxgUtCFBc/wA5JgGvEB551Qe8h
 OCH6OL7PqemcZ+EUAURPTF0lds/um75XN9PgTclTOjLt7FtDPHrN8/Hs5TxQAZMuK2IXy3Qg7xD
 g2d2I+ENHuRW5pZTytORv20a1aCZ5Cqv+5bOuMF/0dcjDTRZYs8x0KxrnsXWfrDeSxVannCja4y
 fwAWzG9ZWlj2H7pGeQiL3qkIVu4AbhwOQjF8NrKJoLlrkL2nj6yZ43X0alBsT/9QwELXG7n4OG2
 uwRRN50j7a5I5MqBkmN5V40bDRA3E4wx1H7MOBVD6himHCJpxXjP1envkMvZrF8IxQqjDoy0hnt
 TGQDMMBnmFozO48MH3KwGe14y7UNeUa/bexhrmE0=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75601-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 53B9995735
X-Rspamd-Action: no action


Christoph,

> Return the status from verify instead of directly stashing it in the bio,
> and rename the helpers to use the usual bio_ prefix for things operating
> on a bio.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

