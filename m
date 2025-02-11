Return-Path: <linux-fsdevel+bounces-41521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0BA31014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F204E3A649E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944C253B78;
	Tue, 11 Feb 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDanVEVw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mCgmjj27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE21C5D40;
	Tue, 11 Feb 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288758; cv=fail; b=SNQhzcvnCxp81t+57KW8+UfeIg2GU6wg3zt+zxfGSaOIibxxCoOrLPHie/eCYmhUZBePkBRhBDqHjP/X3rAo+K3aI6pEyA5fYlh9gdZQeuJLzUVFgTjf3xFk+taqggGKn9TKt1zxbbs0sexp7PqoW5xobloDgVfq99EkR2DMC/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288758; c=relaxed/simple;
	bh=3SebwKMVuL4oDZS/JnoCNNXetOTpo1CpWPS8kKVrGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWuzTzpaih6DS+13vHZUIZZ3leX/aFqi3jCxf9lvqzr/pxO9wvVf3ay+QyGsprldQG4sEM1jKqZNh0SDJBw79E6m28cNmm7yq4svZjwcjL6+7TJ/T4vAncmsBwyMjHrtFBQg07KGlh5bZFduvti19b7k005WmDClyxmFKgHT1zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDanVEVw; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mCgmjj27 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDtnQE026483;
	Tue, 11 Feb 2025 15:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t4VHh8DimUpJUKiGueTDDk80HfYQW7xDWBFdBG29VI0=; b=
	ZDanVEVwdqwVzXUx2xhjNN4NW3IfSCvymZlNcWDjk431GpQtMKJxqmiJXCLZCGuX
	Sfxc7+c8FFuFcmbijlIP/X7RcvFwzZ7b5GvbOLfbYBkXyHFEiIjlmkvZ+PVbp3ax
	ayrblaIhRbi2s6tR8j8sLfjqtoUHbAOfCtXFYmk9TzLXUf4N/qDPG4nHMZHfvdy/
	340Dn6o3vllLGB/K9Ml7a/TX5dVrnFe830JOCzfegMbanZ9PEbzbBJU2T2h5bQI1
	uDcbe4GcmMuuZkYaAHlr1EC3wDVM6Hc3oaSFWrpWXvwJTQSOJhHheHDZ4AdDpPLV
	Zq4GU376DodzrCxHGv4q8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn5dhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 15:45:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BFQUm8009746;
	Tue, 11 Feb 2025 15:45:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqf7nrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 15:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnKNOO+KaMMuYXb2VmfW0NqzcQEOrAQpt96k3657Vchujtrn+7lVvRobKgpqHOR2xM+aaU2ywLKyRqC+gHSb2R0ivnSP+vXXXGplk6iAZXJN1gXRlj8HTGpLDhFKUNoO3O7rJZgjd3PadErQ78iTJpkag3F26nwWW6AgBMbRrCSxLnPkrrS8QnCcW4KmUoubSgfbdi4wo3J8lXkR0+/MbbTbajaykV8zHhKJrjjQaQVFjpnMF7pRyyEdTmrkkwaIcKg1GLpo5yhuu2jafR7PoVsgqDw1xmlNq5C9fMMmExskJ5k1fVWl1miAsivRQ92hMyJs9Zx9Q2O/hVJBO9gNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08P3P83XMdtEWyZs+0A0I+fcSX/e51yUqh37bg5nXHY=;
 b=mX7i34lzuiMkD2nP4vjpGP6qDNLFG/bHXq516RNoX597Au2TqWsNKZlzGY2P43wrkuWmCf6CfyTnpHlrQU/GTx5EZ2Z8bTyXj4ZFiryMoRs4QOU20u7wdkUux7ELVAdcTGL/wfwosGg4JfkeSt4MBpEcqFZnYdeWxzNWVRilM2Tyg9KQdpNyN1819CwC38dih9M5IYMKWQomT9LFMuR+2GdjOWAr6juUhgFx4WAG2H1GKR/japyV46FiRCZF3c+Y9livfg1YQxdYU75LZ9DiaocHgDAW1FvmfePYfI+fhBKPXQGcWfhBboekPJFUz8StNGnC5hiyN4hs3cT9QwR0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08P3P83XMdtEWyZs+0A0I+fcSX/e51yUqh37bg5nXHY=;
 b=mCgmjj27yOCEsbzxewi94hnzpEvQfmwQ5UqF4BG3MvmAVt6xb3LPWKksRGtpN2RdQRHcOh8NTcQsf3aU+o4wWTk/DT2fFb1+7YsVIy+S4lpftyWL578wVxdVUFcBinQ5kQzUd3vaSygDbaMBbmzpsovTTC8KnOZHs072ZlEWcDo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 15:45:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Tue, 11 Feb 2025
 15:45:26 +0000
Date: Tue, 11 Feb 2025 15:45:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
Message-ID: <dfbeb51e-f6ce-4cdf-9b91-a7d4f5e995dc@lucifer.local>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
 <gij5nh63s73dj5u33uvzl5lbmsvoh6zr5xnqpnfltwi6aamy7j@47iop2wgtdac>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gij5nh63s73dj5u33uvzl5lbmsvoh6zr5xnqpnfltwi6aamy7j@47iop2wgtdac>
X-ClientProxiedBy: LO4P123CA0503.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: df87fe22-6946-478d-8c5d-08dd4ab31ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hzKNY+6cuXfWOn9oKWk0/81+3g5If0JkkiTw342Scp/hCIwP3EJVAbe9s/?=
 =?iso-8859-1?Q?XruWWiWZR6BgzIDT52vjJGl3w4kPoPQH81Vn5EtL/2yTcojYcKDuf71u1O?=
 =?iso-8859-1?Q?I8vX4RbMjBG3K0nQeJEuiXV8Gh5bfjCMXffkiCLJZ7PT7sPZJQJouabH0z?=
 =?iso-8859-1?Q?9/RNrPbVTxq/S3AWH10J+y5P34fMUX9EKBJXAJZkCPWFZj9+umL8BNYrcL?=
 =?iso-8859-1?Q?V2HKFjAlvrqfTInIKlTfrphUV9z2oLWckezEKRv4a3ZPKiRuWd047unIDZ?=
 =?iso-8859-1?Q?slhEDmaq8WvFYVxn6txJgWz5MlTIvtOG8nN3uxF7RQCcHC2dCPp885m69O?=
 =?iso-8859-1?Q?nkHMWH6pHIB90IY86oLoiKY319vJxv5DuuzIIviWPtfux2znDLvlsSfvQ6?=
 =?iso-8859-1?Q?/z5r1MflTT3xnaGhD784WP2UFLsNnfNSdWrw1XVi4sIMOZmXW7CoSk8Gpl?=
 =?iso-8859-1?Q?8tkwyqESQjPF4tsyzgJCJSUzn/jMhAkLEFor36kElzvwAzFG1zu5A/uUDs?=
 =?iso-8859-1?Q?38iVZJsTfDXaHG8brg2DvWXLca70GtY9wE3yXvyCIVnMxvncyTypxe9izw?=
 =?iso-8859-1?Q?DbwgQ5Cd+HO4l9sJa4MU7jsbOUJUg1xHu3gxsafYluWIrC0g2F0hnZq5wQ?=
 =?iso-8859-1?Q?IZXqZ2f1hVLso5uy14N+CnQpUXK/ZfL0QJyRVF5et8dotNU15cgLN+U7/I?=
 =?iso-8859-1?Q?TYHsIxsK9e97ZQ2TWD87XSh+2Or1BV+A8+K1kRCffcU+e9hzc3gCiqUDrz?=
 =?iso-8859-1?Q?MBWeMpnE47O4fezf+GqxgzVPcTMGbyTr8JhsTYj+0ZjWa0aRIWJTj2ksDB?=
 =?iso-8859-1?Q?Xf0/+nnBsq0jPU83asH4q/7sD0xiHjXqmHwFQ8jo2bIliJgMnXkG4fnigz?=
 =?iso-8859-1?Q?ooHtgQ0vEG6iYGtH0bedaeFdAUhvqrRkRzfu8asAz38lRIKNa3WJwtQ8Fn?=
 =?iso-8859-1?Q?Cuf9HkPgcoUTvStmf4TxuTaFxpZwkvNZwBA2Kjd03b/ozMqQa+KMc9KdE5?=
 =?iso-8859-1?Q?ushyPangwa0ICo4RcUeTzKmIKhWUiJrcWk7s2GCzmCSW9sBlQ7/ihOuTVn?=
 =?iso-8859-1?Q?sPnaBz+gFqCl22Hu+5rKfhQ/c0bFk9Ov1HOjky75XUNZKFNETEULGqGQ7y?=
 =?iso-8859-1?Q?Acn7shRfxbM6kA7tw8B776r3lsc4R6IsvYdEEAwT8ENJb9cGFa2by8S7mh?=
 =?iso-8859-1?Q?+iQnK4jHHXT4+Am/jLBKRoaVFqJ+95muQsGzg866k0RJQdnTCgmzynzJqH?=
 =?iso-8859-1?Q?8zjNmk7RElVQG7Mgde6Nb6HQ6O3mw8QQqLlfxX6hIrJB4PAwiZlpSua+JJ?=
 =?iso-8859-1?Q?MMLoniLAAFP/2hOvVXl6312YSgelRsKyBWiTqpaEaQLTJHHeAPxr+QKlwU?=
 =?iso-8859-1?Q?UhLOEFVbD0W1yO4MnCiOejo7V7B0EkGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kjpruXyZbfet7NQWq4UsCBYXJtbh4hb8u49ABwwu7PjDRjV2ZZdi2KuPI3?=
 =?iso-8859-1?Q?sFq1x4cIIqm6zmCOceWqB8W8SrwT2suogzZClYMQRG8rOlrMlmnIZMjUYL?=
 =?iso-8859-1?Q?1fORUPrqYXL9Kt/g9KOYnDkJA8eg8P+5eGyELnVSODnGbKQK/Voxv/jJYz?=
 =?iso-8859-1?Q?SPEKAlZMXm1tY0YYaUXhyu431kXf03K2sjlqTSGCr7XCrWcz+FtuE3rXFm?=
 =?iso-8859-1?Q?7Dtx00KlPhQvuz2YaUXYDRaI8VUBVxcnNNUU72si8PUVZyShJe4OQEmdtN?=
 =?iso-8859-1?Q?eND5Sspiso4ehF0xc/k0ottp3+TOuPBghAN6AAoegaT0gs9OIV8EPQNwra?=
 =?iso-8859-1?Q?KXDFwR+gu8f/j2i2vLW3o/CJiMo4pX+u0zEq30odfO+SKxg4DKZvN1y8Ug?=
 =?iso-8859-1?Q?ELFbl03+k+QVVH/0PtSOd6GLb3eECxivbG+WGmwVuf2WAdRifaQsLaPsA5?=
 =?iso-8859-1?Q?5SdlSoMX7J0RzHCFcv02uj3HuFXRKGWKDXApZSGfMxtY0J6fiUADb+XZmL?=
 =?iso-8859-1?Q?h/mJRA89Gy5PLcfyqY3HBziMKVSo9RYrVMh5Jm+0m9gs9Fv5xnA2JCMtt3?=
 =?iso-8859-1?Q?oXgCqwKR0+nWChHs0lL8TDGKTdvguVHKSGHlLnbYrfLV53EXlH2zMdCgzn?=
 =?iso-8859-1?Q?phB2V5OIn/hDa0cBv5GjdT1DYfnRae5dqrO2XND9VFEb5XVeRWeUgyJOzo?=
 =?iso-8859-1?Q?onfQ2ZydkdF4vvCFv6k2Ip7h0z3/PA8Wfm85sz3B/Vv07Ejqwf+W+bzbf8?=
 =?iso-8859-1?Q?6ZdalVDH4pB9tTKy6ikD9bvS/lw0Ju8BJM8IUGn4rFajjdW/CIlDSw3G5q?=
 =?iso-8859-1?Q?v/7PGXRHGgGH9ZsOm4oe5fJ8Fvn3s9QquBRnxCBUEYz4yb90tlpPfqqKeV?=
 =?iso-8859-1?Q?JFOF3zWyy/vI9H4oHq5k7l8qVEmmwwl1xOnzepyC3LGPOahX4DUTmMZu5p?=
 =?iso-8859-1?Q?MOpcYTURPXb4+VAz+XQpqlZ2iu68irUPsejdH+hO+arERwPdwv6umUxUyB?=
 =?iso-8859-1?Q?HjhBz/aLBH9aLeH6Jwcz1J0HGosdmewG7DAzcEmR5C7nuvhaHZDFdw9K2p?=
 =?iso-8859-1?Q?ovPFCoEUi7VNtqQcNT1mpcw32xxulglkeZ2n2H+4QcEVaHAHOVPoinFGb9?=
 =?iso-8859-1?Q?9ENXPCIHqOwrKudtpFcqSzRux8uYrC/DhH+kEo5gtsdUBZyHo4mVp2TuNu?=
 =?iso-8859-1?Q?Lf+zPebtG3u25tVV1ditOPkfe/+h1HtbyzFV+v3rIm/lsKkC3+YYjZfa8J?=
 =?iso-8859-1?Q?9SflwolVRFP7vwqRX4HgJV9c3VmUrGd7XuSr2ko+TsoFo4SRjrM7O1udcZ?=
 =?iso-8859-1?Q?SiS2NO0xK09vw9oLyHqJdbWykgCGXLbsCYZejQhnPaFV/JRg+s6XevAdBU?=
 =?iso-8859-1?Q?f51qnksMvyL+XY4FeaAC6j+s765qOTgzRhL9WkCtPqTINtDU6OkBtVbnbe?=
 =?iso-8859-1?Q?C5B6VcFl/xLzgoYA7sg+dvTG4ERdbQE6UjBfr/K3mPHjAYowWg0NPylj62?=
 =?iso-8859-1?Q?AqA1oWjB07m+0EgpKH+aMvboHnodDn/5uUwQUAwIZH8s4Nyrue9er662CD?=
 =?iso-8859-1?Q?u6IBVIdkLZ1WazD78/DJlsTjMTzrkBPLK3gJw39uyKwjqsmHBkasjFH8PB?=
 =?iso-8859-1?Q?QNVr29XX5oPj1zGAznCzLrguEv8d+o/GoZCieBDTsKEDTu5l+CZvwl5A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e8OcxFiEA83+uBps5WC6H6t29sudkLvvdLrJCpTzp/pvQ3UHCo1jQZMkmaFZdY05aeuWklhaVyayIs9D31p0m6C4U1DdArD9/qcBSpfWxwmw63KZRhZHm3gsqeRy9U7ch2ehCOCJqYVIxsfXn0OcbhUa7qSLtfmMiPn7Z6zvvfTi+uxtEbEBQQhxMNWYUoMwk+FgmCw5iCWCCQjKQRALwr9Q/7fJ5AYdN5RhUe44+JrLz8+XTJf3dBr4ekcRUFSUX/VkFbMPs8SVGTcc3v0oM+Gyd9OCFUyIsgZax1syJHfTgHPlRY6sup4bNLv2yNcp6lywZ//+vRgCAqCcvpDx5CDeMWzJQi4c5MrmEWBc7A8nFF73hXLVAKFyeLqOORgfD4CLFLZc7NX4w2SqTCTKSIJa+jMqKgW7kYpWzXfnkHsVPOpcla1lPS2y4adIv414GcH0UkQa8tgKuc1ttaVogr92o+fx74xJyI7nCm+/9uxaVQ/rhVkfqOtBi6Ni3Yv0c6NBmtOGd2dEp+t2kKbywqWrUr0Io252j6rJCvaQ9LkaILX2GB1ZmpAk+JX7UqUYh/MfxACryhe3g6a2nWavVZtp6mwqsravIhTDRV9t2Mw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df87fe22-6946-478d-8c5d-08dd4ab31ad8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:45:26.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U/LdFRQwL8fvKX97xmiO2W7Ooo7DY5SgglKg/qPRfDPYKsy77fC4QghAV6sPXRVt6BLJL9XHDSZYPgknDuuFtNymKPE8asBm6OLglh/gaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110104
X-Proofpoint-GUID: rgjWJEkjEpz2Xs-9e1u6Ne48IbUewvqJ
X-Proofpoint-ORIG-GUID: rgjWJEkjEpz2Xs-9e1u6Ne48IbUewvqJ

On Tue, Feb 11, 2025 at 04:24:07PM +0100, Michal Koutný wrote:
> On Thu, Jan 30, 2025 at 08:40:26PM +0000, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/uapi/linux/pidfd.h |  24 +++++++++
> >  kernel/pid.c               |  24 +++++++--
> >  kernel/signal.c            | 106 ++++++++++++++++++++++---------------
> >  3 files changed, 107 insertions(+), 47 deletions(-)
>
> Practical idea, thanks.

Thanks!

>
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > + * To cut the Gideon knot, for internal kernel usage, we refer to
>
> A nit
> https://en.wikipedia.org/wiki/Gordian_Knot
>
> (if still applicable)

MY GOD. Hahaha. How embarrassing. God knows how 'Gideon' ended up
there. Apologies to all, I appear to have had a senior moment there...

Feel free to correct Christian, unless we want to leave this as an Easter
Egg?  :P

>
> Michal

