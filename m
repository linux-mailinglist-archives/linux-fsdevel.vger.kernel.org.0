Return-Path: <linux-fsdevel+bounces-32246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659209A2B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBC81F21A47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681F1DFDAE;
	Thu, 17 Oct 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwS7g1oF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gqU2kz7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2115B12F;
	Thu, 17 Oct 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186764; cv=fail; b=VAaRT/Cq592K/Kb0SrQdgkVvgzRgB3KA0N0hdpwgCro1YFVEBEqtpzXb3hKeLekpOWnA99iIj7ZrgS0nA4KRvHGChfKGEkvj0KCZKp7/In1xJfvV4NqD3wwG9Tnl/Mf62OMLVT6H10zI0aFIuck/NZIJ3ZT3z/mr0aAbVGoxwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186764; c=relaxed/simple;
	bh=IlaCD9Vv41cAdWN22acMcji3FHk9eOr+bzdeuBwj+d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOnuueoiKVFgm6njpTj/OdK1tyk/pDkUbLX2KWQmFnY+Dce1fdNU7stAgMiqWlJ7w2glCmGk+fc4Me1FXsf5Je08hpBZObvkKtypignDzSiew88lx+TvOHIy10/IboTehccSLVJCn8CAWkWPJ43HLO0n4Lpi/yIR3Oxy1EoJ2/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwS7g1oF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gqU2kz7b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBuss017827;
	Thu, 17 Oct 2024 17:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZD7R+srBq9IoCp7Fg9
	N8pmYq9MRwLEJktkFaikH01XY=; b=mwS7g1oFYzD2Yvsh3VKvIQKAhG+rwC5JeU
	AmgA09tuHyGvwhfVxabF1vKYledFGmAHf07455hk8fZ1YO/PfjPicWpeQq0PxeMo
	GbLSrhzPO/RmZ2QBF0I5lA+1B4+Pd5LsVxJ01/SKP7abKW0cEC0CfEIUKG62KcB4
	AawjRfIsZNIVawesWZ+EsDuVq63DUGTXS0t4BOyR8CNu67lt9zGoH9/w9snYwAn6
	9/pK2BW2zQcbBdPlZWJcBqjt9yifiLSEL7qevcpAtux1FGyjLJyYhkvrW+Kc3rdG
	WkT11Pd5oNkQiNOy/xLniqPKPuPksEeh6Kvz6VvLRwdYTFshUftQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntf293-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:39:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHPhmq019856;
	Thu, 17 Oct 2024 17:39:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjajmqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/54O0amYTiYGlX4/UMt60A/gbo4QIOvVjdHw2gYxhkdRB22wMqhX2Mc4tgrlnXQM8MK0nMDY0bGQhpfVgi+Jx6Ab5zJgzwmhbXYMm0/F0G+6x0gYprVR5QCk7CvkYgHMv/6tefHGnipcFJqucFa9P3HphHuJrHT645AwKoPh3d+3o/El3hqaH6JREumRmZjsXc0h73dky+9VLzEbX/+7MCVz/fMw8hBcNGliY9kPVbCjzzLZSCfBMsjVZ8kToXrI+mes+U8PD6Mb77jc+n6c1w5azK5fpkBwIjO9FQQf/Ofor2nHGGgkGqxRbDL4ACnqjUdu1uAs0MHsS+RI1YuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD7R+srBq9IoCp7Fg9N8pmYq9MRwLEJktkFaikH01XY=;
 b=wuPl9hvtlliPw2w64EeDICB/4NdDckmScVynblv0c6/cT3r9ko7QakFZfZZrZDpDj1dNrTJhSiaKL+3lATuHbLnLQR+RuIjz1wlMwRhACKLI3MM2eBmPXiGko2AXitAKqrQ27Kj8j7KjDosMyyczbUmzsUyflojiRG8dVlbtfOpwWl9bgP8dTIT/PwwKTcC5LvUdCRPkSXJ/6Op8RatR9ubds81+am1Wmn/tzCxME8tNR6HH3BjO6Vkua8Qq7rs6g/Yjw5VlNAy2GNwadi96MxAM8hwfqvVngUuEqDlHZ9Ugw/x5OhQ49u2Vqr+DkFaPwbYW8awaODKmouCEl/uTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD7R+srBq9IoCp7Fg9N8pmYq9MRwLEJktkFaikH01XY=;
 b=gqU2kz7bmufC2004YgZYg1QcNkNM17SqAZb9L1UT7eaUI8MzsvaMWbxqvKrCk0M9M1X+5KOWD0da8j204pwQXtaNG5E/FfnSygWr0nrYpdA4ny1hzV2CoOam8xt0X/Bu5dOrBZ5rOq95ieeW9dojmz/IGuVPqu22iAJ6gP1WADs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 17:39:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:39:02 +0000
Date: Thu, 17 Oct 2024 18:38:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
 <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c76af72-1b10-4299-fcd7-08dceed296a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SIsy/vun91FIVQBqkrEmbAmDbnxhFUG+u5WAKEEjYnKsAULdf6da/XyXlC6F?=
 =?us-ascii?Q?34u5uLKxtdsveo+lWQPk/T3jzuV4Y1x4kumQRRBJufY1vDksGvL8+KKZZB4F?=
 =?us-ascii?Q?Few06C301Tzjf2TXWvUF3PCSstp9ZEYTtYHZ+m+edaRs4cZKyPtmpvKtK1om?=
 =?us-ascii?Q?V3ZJmK9B8ik9Ux42ZCLaCiYwThd+mQ7qgSzlucdak4RQ1l7G3QXU2Lidf0bq?=
 =?us-ascii?Q?DnT8X1fVY0uLplova73eWh/YUVlm+hGp/SECtQv93/orSJgHxRG/Z4u1X4d/?=
 =?us-ascii?Q?cTRR5E7g3PD81he9bdxF0vlMKQRFsJuBaX1d7QSzG6ox1WUK/qMiSV+D6nJ/?=
 =?us-ascii?Q?Jmiie73hjVHIFzvCZM7Uc8f3phtEsOaRcPdx5hQ/CxLymZJfwSOLBtSdqktf?=
 =?us-ascii?Q?JXf75cw9vEZNeMa+SrwiBB1r0YIGZjBCE7yhPuj2VYHOV1Ugl81YCJ/JlLBz?=
 =?us-ascii?Q?u9ie5pKwFUfJe+ryyZh0B7MawSoCOSY2UmxASh1Z8qCzWLfhAR3bT+z5GTgC?=
 =?us-ascii?Q?hLNvLfNLIupPJCLBOpBsbokbW3yuVsXf8Q7fBDuRasMwannKUgMUeSuV+RTF?=
 =?us-ascii?Q?9ayzm5p67q5xzIqB/aKDVYD/sOBmmi3VnkmwK2hgLipju1gt4AkW/ALU76DJ?=
 =?us-ascii?Q?ADzTi125/ftgTbDAaSuRxYqmP3PmWjJbMEIGSqaIcLAGVmWmCP2mXItMW9JE?=
 =?us-ascii?Q?MSEkHMP9g9aGBQylfD/HSYAowSP3O4TAt9zXtMNhPmOlvGWA6PRoYKnEgZZN?=
 =?us-ascii?Q?oz2TInCkio5XPEuYfo0qIJAw08Cof7fOdgJD7HWetoU6BwRJ7kmWViUpn3EJ?=
 =?us-ascii?Q?7paKkc7Fq+r2O/qcDfhUk+Ts7ON3xkWYzHateClPGBFIQ75b0HGSnyzoQCjk?=
 =?us-ascii?Q?chGNxHHiJUuPcM9Om3agEabR7/U0fXSLu20ZlgEsdQoQojErLBV8gWamarSY?=
 =?us-ascii?Q?Da1t/R+EvJIEhDAdo0VJD8+qjrkRAQDnnYa4NfrLd43KWDMVFCkIPZRiHKHx?=
 =?us-ascii?Q?ppHQxlssyPwrgixtDnQyuwBXwgw8Nw24EMtAFRBJXmnwDtbILoMNA4vwJ//f?=
 =?us-ascii?Q?jRAkGkKbJw0kBSDOZ+bFlvsGOf+Ujb0/lX4qlw1H6l8nicQ9csA1VFm/kLac?=
 =?us-ascii?Q?5wYFpzbzQzErlL9VdqWsahaDkY3o98bmwrd976BV/Aor9TuCzpMkFk6rReRc?=
 =?us-ascii?Q?XkIkTcv6PTwCSsFushUAkDZpyq3oS7q9LTikUFtgbo0jrO/64DYVF81aAu9s?=
 =?us-ascii?Q?RKEbYMf+a9C3eDm3Bb6uSxtkRHZsHPwCkMAixxbp7VpU1gkSOrZPxgJPC0DU?=
 =?us-ascii?Q?PisEAqcr45xnt5dmN/lUFDHR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nmPm+I9+1O2qTOiJXSpk6rzjY4JI9cJYpJ0ep4xCH35HQno1bOKZJQe05mY?=
 =?us-ascii?Q?SLqTXwWJLAXkxPG3YvEg7pO/EhKCZVSYs3dNhaK5JULXrDmJDc035pHLzeFR?=
 =?us-ascii?Q?/H56To7vFVl0dZG4Nh6GtUh7O4ZZ/47H80mqDIIljqwqz2pYpk6Hu1afU6s5?=
 =?us-ascii?Q?iKlA+2mv78iqBK/hNDY4iD6j69YkpSamrCD8cEDYzjha7eC8u5bHfrgYkGEd?=
 =?us-ascii?Q?cKd1cI1Kf45HyFV8yTdg3vgYn7K47M73WfdIzAeJkJI3h1R2sMpqEdFuYCUp?=
 =?us-ascii?Q?R3zKFUqtV96LPUDIfolkTzc3xsd2hxCMxqW9Xt/xBXtkhgbrP6FKtrqAbk6h?=
 =?us-ascii?Q?Oi1kgSFT8Ki/TQG4z+TIXb4SjkBzXe9IwCnLb4+HBnhYxy0ypgDj/7UqLVA9?=
 =?us-ascii?Q?NftdWFJ4f4yZdJlUZv8VVS8xoewu72g6bZM5YX3KDXGnsJCAsz5BEDJvTO0J?=
 =?us-ascii?Q?xTE93/0DcNqeV+4Scjz4NK+I28VGJCfCoN3mJLD/vSuduZpmxJevIzo9nKWj?=
 =?us-ascii?Q?5PWxdpHbf1Fzdttg5+ClreVL+awjdamYlw+cKec+kgeW1OsEPj32dsoqyb3H?=
 =?us-ascii?Q?SZpb703SmonsrK/IDusEYlTRp2MQHovZ9F5i8ifyAdLTuy/yez/txnrn48IG?=
 =?us-ascii?Q?vb61bWLjBFcAXA9t3/kQHeiTYyx7sfmAle2uMvAPKFdMsSehb8GR9Po4i+bn?=
 =?us-ascii?Q?pQPymrP7eY0IG5GYIkNJhxWeA8IHcRrZzCSd8zhD+ubHup32F8IH676+Hf/S?=
 =?us-ascii?Q?Iw9mHxT2pqdeNiyNsu5CWNCE759eJDXTHVxCyS+B9rqIsM/AZ2W3Gj3KE/5f?=
 =?us-ascii?Q?/5R1IAEp+bia3BuhOCXzatzuiSe2rauwC1xwVe96Xzrv5mEWrr3ymKNlTu8L?=
 =?us-ascii?Q?+PSxmIKTeGP7N8L8aWWVQRr8KiDCiGeK1/iTfqTWjqSImlVSKvSLQjbQCZ6S?=
 =?us-ascii?Q?m2codvMXTb8HAYxea1pAfSbIDyJl/daqgBfizH6B5axxIEIplxN+WCkMBaGu?=
 =?us-ascii?Q?BxcBapyr/cXHYeOgJ7NpyTTbWHp2+kVbD4Ee5kaQy6AeiulgLLhNdXb/5BTr?=
 =?us-ascii?Q?HgFQIOjFtgoDXdu1tuUL50zJPl+P/DLVuZARGI1MhPWYMJukEBxZM08wf82J?=
 =?us-ascii?Q?/U2rjlaMUKBbi1JbSaD7n2m3pcjf/sFB/UZ9noqEe+fFmt96vS/0Dr/yTi8T?=
 =?us-ascii?Q?6tQXNa2LNbZMT0pl5hFTMGYhvBDB0u7xFQ0NlScF5qcGFBui+peK2socgNsA?=
 =?us-ascii?Q?b7/QB45agRuB/TCpZKayEqada4AU3a06jJ2Vgl/sLOHOBjvNfzHK8gl2JU3H?=
 =?us-ascii?Q?tZJguk0duvskOG1DidVUB6MHg0Peo4tqvx9IiMfvpsszFbLBir0dSVyMjppf?=
 =?us-ascii?Q?23TRV9EEGuHXTDEnJD7HN2W54emrAmU1ZTGUK5YAMbcsMVRgiNmR8/H+zixs?=
 =?us-ascii?Q?N7DzACNaAgj6w1bwrbhp21ggT3U1o4+Ze3f+JP6OStQL7rWYqCTduzq9Oogn?=
 =?us-ascii?Q?1/6L/76oq4C0rz4vfdRtDbe7ugYKJjkgm48NehorPHWHdRPSaLOT8J9o9p7C?=
 =?us-ascii?Q?pwI9/ZmqO6x54UQFhg91IpwALHGoBE2ft0dFvPADM45IDnWyBg5acPCMsEb4?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0DTbgukWhEFVKPMQmYikJ4bgjYDQHdD9ogMQvGhl3aBMKrkzNFlgkIjdzhujX9b7jjQYDIQ39hNt9IjhljX5SKpglibyn3Ge7u/Jk/o/+ZkTTx7vtmvewdfhzQr0XxpQtql+NCCUFDrNZ0LuhL0trZwdKmMwd1f9GZCjRYYidmsK/NehXUaGnUIXuZ6h3qx8XqeOE6FCzlMEjNhbsrLoOkiw1ly+O7l6iBFamVmTvrRyqQX5pfFkZtWwM/BpQaSUii8V1ulTJ59310UbBTNrhFwrWbXXX4AOa/K1s/NIIqagvJEt5ZOMVrP6Fs9cEPq2fP1erVbn+1loJOUTjScy46Ku8i2LR7vebZmWdoz6l/r/4MK95AP37rd0K+yIwcfjLLl4LrVb3zYVaA5dl3eXzQkZE6OctVOkh4mgS6MFBpyTzQbi/QgRuRRJe95iJ2e7v9FjkJDLWveRt3HEoPOYYYunThM9htrpCZMmqEuhAEu5QueyTwhgY6EN9A1qGZ2x9uriF7Y4tTqwigjci5mbyVrq961FDWm+Pia6ZWJ2YG5U0eJGdlqp+Z0BtaQiUC8KzIywqxT2auzKLQTezc2WORr7rEsYYzE7EVTUxCnpAag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c76af72-1b10-4299-fcd7-08dceed296a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:39:01.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVWLjECTRKOsHjFWCxIZM8xsqIohCYNVn4IrZ8btG61ZloMshotIRhII9/WsIw6taR7oscGD9HLIEz9dECC1frKAA7wOa6699XHE3ANiQsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170120
X-Proofpoint-ORIG-GUID: GCc76ZBI809zHLlquuMwv-idNxmFmw9X
X-Proofpoint-GUID: GCc76ZBI809zHLlquuMwv-idNxmFmw9X

On Thu, Oct 17, 2024 at 10:37:00AM -0700, John Hubbard wrote:
> On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
> > On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
> > > On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
> ...
> > > > 	#ifndef __TOOLS_LINUX_PIDFD_H
> > > > 	#define __TOOLS_LINUX_PIDFD_H
> > > >
> > > > 	/*
> > > > 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> > > > 	 * work around this by setting the header guard.
> > > > 	 */
> > > > 	#define _LINUX_FCNTL_H
> > > > 	#include "../../../include/uapi/linux/pidfd.h"
> > > > 	#undef _LINUX_FCNTL_H
> > > >
> > > > 	#endif /* __TOOLS_LINUX_PIDFD_H */
> > > >
> > > >
> > > > Then the test code needs only to update the pidfd.h file to #include
> > > > <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
> > > > the pidfd self tests Makefile and we should be all good.
> > >
> > > Yes.
> > >
> > > >
> > > > That way we always import everything in this header correctly, we directly
> > > > document this issue, we include the header as you would in userland and we
> > > > should cover off all the issues?
> > >
> > > Very nice!
> >
> > Thanks!
> >
> > I saw from your other thread the idea was to take snapshots and to run scripts
> > to compare etc. but I suppose putting this into the known-stub directory
>
> Actually, I'm not running scripts, because the only time things need to
> change is when new selftests require a new include, or when something
> changes that selftests depend on.
>
> > tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
> > here.
>
> This is the first time I've actually looked at tools/include/linux. That
> sounds about right, though.
>
> >
> > Or would you say the wrapper should regardless be in the uapi/linux directory?
> >
>
> No, not if there is already a better location, as you pointed out.

OK perfect, I have a patch series ready to go with this (and addressing
Christian's comments).

Shuah - if you are open to this approach then we should be good to go!

Thanks

>
>
> thanks,
> --
> John Hubbard
>

