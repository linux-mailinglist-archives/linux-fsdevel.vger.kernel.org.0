Return-Path: <linux-fsdevel+bounces-27890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7149964AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C4DB2366D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A791B4C48;
	Thu, 29 Aug 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdbyUeKc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z/H/Gx0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A71B3F19;
	Thu, 29 Aug 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947477; cv=fail; b=Iq7zXTR+CYHxNPqGid17W7rfbOGQMTJ77r3NJkNEkvhJviEVlxPIC6eDRa7gnkZ2/mop/pgZpIxATs4LEJ83ghnWrwfDpy80evmxvpJd5M7J8KhEsKjaOkMeSUO4Z1BhQOaH7M7VneYFulm5PJKVMPAyw+4llIlZSAOgLUmR0jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947477; c=relaxed/simple;
	bh=5U7RVEgVkUv9E/6W6R4bbSNrJZ0PNchVvFEIUxDUZyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJ8eTAbYEGMR/Pz90T8OS4YpDeJrPRbc3CgrbzZXMB7caaoVQvGS3vqlj2zMQoBmmhJIc8wLkpUoc2kgSjm7HV8gNuNBAnwOmjpuoqAhQ3lnySEw5y4ogQ3zXw8WK+sfr44hBsnlOiU8tXxRv+vGKdwSX3rBy40N7ProZwVDdfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GdbyUeKc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z/H/Gx0t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TG2bP9027642;
	Thu, 29 Aug 2024 16:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=P6XNrTixW8+8FVj
	msGG2ZLW4N+gGIbFRUpf33QZYX1w=; b=GdbyUeKconO1+zApRzAvp0yUQXaVfFb
	pwzwQWkrKKIEKsXcLy/byNVAwhI5SpoNn2RHbipDrrth0YIm7oBq1ubbi0G/WtZJ
	zqSxQuivM2WJobxfgWAWbm4pwY8Iw/oMzLGOzLiOPqStdTlUY8wrlzQMW19MGKDB
	wsY4owFAzdFqOFYnvvtkF0JKj6xmRXYmmWFKC3T+IwuSnDmWNt5w9lT88+/spyQU
	PrCsFbTXJLok3HEhPlxSbvXsj+cSWiPxw7MQ9thhqfLpJaltJAUb7uiW+zjv4lx1
	xdnEZtQwhmGquQWMAggFWj/f6VPABUOvSygqGVADQASnZmqHapp+2UA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41av5h0054-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:04:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFlrw8010475;
	Thu, 29 Aug 2024 16:04:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894qx13r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blzjk/vYFYVK/k3n9XW+YOaz1zJGA9csGTeT4YsLNnHaCPWKT04SmUbC7G7aE1vkLca+Ii33fHHQjOaGNBYMRruGNMpgN4IGklyPtGAA/9WgLzjn26pSuYg05eMHmi4ht7EaGfCHExycDB56gFXFTMTUnYvy87STUixkZnsua4sxVLlHntiLcOfwk6Du8S71eENCgKWFrJhh09pz6C2RNATkJIQ7XpHhZubEndXk7GAFm/grjihJN4gl6AHng7wvHhEawd2IpsQAaKbJad2Jr7WfoHcbQobVJjBrBr6VXDk0wytBLKqlodSP5HwNJ9OFX4M1mrSRac1d6XKhzGKm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6XNrTixW8+8FVjmsGG2ZLW4N+gGIbFRUpf33QZYX1w=;
 b=WJvltm+FbkhkrEb5DxhY8PQHJxeX0vvBQ9oJ7W2JOjT7YgvmF42YZlqSBERL86fqUlraRHH5ixp3GlvrzHNlo/3e7WaV7fdJXuiWwylpxJwifbSjIi3zGHHq+rMBZbZ59Bw8oZK1e2W9sM6OEMhU80zh2PRQqXwfTqS7H/fzTMHonF8Oty19WfDOaGYKW1vI49n3X2p/RrRlCW9rNXzmy6Yh+1pw9WkAPyV6s+E9oIdADaaf6IoiwCk5T0SCYN0TV/OZlsgkHM0dfd1eBci7uZl1sFow5QSft0UEwTpdM7iw97GI5/MtXy/NSZtPjcmhMKXnu46ZOggkA3mMwPb9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6XNrTixW8+8FVjmsGG2ZLW4N+gGIbFRUpf33QZYX1w=;
 b=z/H/Gx0tW2TShWbc7auLtO5cKX9qa9yi+xjItiPMpijPM6wlidHMO1N8vE3LD1+s8GMPbL8EiCC0a9U75rOItz2zt92Nn/FBiDBbitNAWYjaBBeK+Ki+dE2aPtIFgPLRarYdQ2jJkhWT44CEjQ2NYNY+HyANPEXYILfnbSGAWh4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 16:04:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 16:04:23 +0000
Date: Thu, 29 Aug 2024 12:04:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 10/25] nfsd: add nfsd_serv_try_get and nfsd_serv_put
Message-ID: <ZtCcA5ozV1v5KGD9@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-11-snitzer@kernel.org>
 <d51eb15966a1b879c295d1933b8d9585a6acf3c4.camel@kernel.org>
 <ZtCbSHvr2HrxyGLM@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCbSHvr2HrxyGLM@kernel.org>
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b16ac3-5098-4717-2276-08dcc8443f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6y5hOJ2+7DdGwdn5KI2lZRdc5pGH+cYIWNAAlD6EUhpVfAig/UWvmPT3K4Ze?=
 =?us-ascii?Q?DQ7VOeruYPHu+24dT6qcmu0l+d1yfePPOT3TVTQ9ifP8ZWecIDZHRvTTMVz6?=
 =?us-ascii?Q?fGwmzrGTlT2K1UqYZsrykmt7eIasbacBBmUb/2EbJmxf7ZtAUFW3fQ2feq+j?=
 =?us-ascii?Q?rpZl8dcVlIVJyrlOsZfNpocmlTIHRS+KlkcwofK4TU0Y84xUXby/tdAd1tx2?=
 =?us-ascii?Q?mLs84k8M2V1i8hdfCWoXS2estznbNWtUkr+2ySYvYVxa+qjgGghaIz3qbN6/?=
 =?us-ascii?Q?mY/z8jZzZAuatg5bBYtPtNsGRmzMYot7MsRZFytv+mgIiC+mYV2vi+oYxt3E?=
 =?us-ascii?Q?kqBxp8PWThO5p2pqMZYwDG2sxz+2/TlCVfJctG/4J5yyQgqbp9KjXE1bQ6OX?=
 =?us-ascii?Q?uLd5BSZHoQO/EtHX7Cw1fUCaHv/4KDlrIuyPI5SX9CTetQX7cdc049Y9jExp?=
 =?us-ascii?Q?gsvqpcpzOe8Bx/lXL1ChhAzMLJgOGjYJegTHt8snQtCl/YXGZePw2D/rNQfh?=
 =?us-ascii?Q?OXsp/6hHqfWDD10KqcHXL2sbNTht4gWY3XSG4wtKBt0W1Qo2iHxRxgtogOiF?=
 =?us-ascii?Q?W7oO/ViLWTC4EJ+I77aPuze221z4t7GYFbPs/MzDTcbUYxo5rQoiBymgGcAt?=
 =?us-ascii?Q?RW5IihjeHHBeRk1oh9msyTzG2NSXNhbwoNMYugooNz2JCipf/kVhOucUR1sb?=
 =?us-ascii?Q?XBZWVuR3X+rdXh62cNJ4ANmdsg2c8eBbYneHwyVTFNFWF6xY9y86danEeOMV?=
 =?us-ascii?Q?BzwCevPE3WAKNiq6fZNyl8lxNWyZoRM/1YaRoxx5Mfm2pRNlIkRPOiXtYJNM?=
 =?us-ascii?Q?AU8V/3Kn1J5bLO/ss2eoAX7HCQ+sgh+dsRgJIilW1lVUouzMba9EeW6bmKjN?=
 =?us-ascii?Q?zpILUR4anPHQfVQVnHb6kzczsuV3UOY7zRmYIgUfwXzpvIiOheZUEnqPFJon?=
 =?us-ascii?Q?NgolrGpaAicMcJSm2OQR+Anbm+i04PHVwnm6viLMeUqjY8f5Z6Nt18iDGO0v?=
 =?us-ascii?Q?JbswuvPNwN0m1jIgKl8H4isrnQNNX6eI3KepFekTDM56qbs6YYlOViF3k+Sn?=
 =?us-ascii?Q?XE2rJVWX3jDpoAjCA08kV5P/UUQJxVP9SKKmBMzro7g4qRRo1PgUF7J+T3PF?=
 =?us-ascii?Q?sdMZzjlQMLKvGGs5jhnsHtYlSOteccePbfb5sXIDq+RyYU9bux5Vy3cIvR+E?=
 =?us-ascii?Q?5Eh4CpUCWVLpoMwJaaf1ZtIWVTAhCg0HCq1qyATOAOEUtfw8KDoePXK6eOF0?=
 =?us-ascii?Q?FaqmWPlbnzHhSbcDyx5X7L+kYh2Iw0MXrOh8DV1IP/mrZNlwv60goAm7IPA9?=
 =?us-ascii?Q?natjfuW2USf3zISkUoV7DWxeIkgqo0QiwNcZYNZXvPodIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX+ZcxCk/4FpyJ6DU+cW6S/VFThbyVWi0GTYZt5WuTSIjDZ4K2NHIcEkJ9EE?=
 =?us-ascii?Q?bklEvFZ2ImeE2xY3C4eSFY6m6GyRQ7H8ZuUeJ4DmIARnMXYtAi9SzEjc0ngU?=
 =?us-ascii?Q?Nr83jjUMWsLAt/+JHvCIIGNqq2JS4NTUkaHP+ItIYoHkp9bcW94U4cjjvNO+?=
 =?us-ascii?Q?2VmglcdVsCRud6ZqbOZzI2nn96gaB0k3LCp2rXIT17UgSB7QU0qiSEF41c05?=
 =?us-ascii?Q?ytIRW1IjEX6hHGf8QbItHQKCJXMEBf7E3/jRsaRncBKzrZ3KT8Iq3yTVG/V8?=
 =?us-ascii?Q?pW+IsrNUVgqbveFoM5D7fd/sKUWs3HVfV2G+GeZkgqFGLHJbXQKqYnyzWUDm?=
 =?us-ascii?Q?69jLNrTR6jdKeYlA6GE1y2OxUY/5DARlTVDa4VL4HvwUCErxEIYRJues6hcg?=
 =?us-ascii?Q?UfQHLE8nwao5Q5IENLstmWiqqfH/n+JqN8D47fVdN2kY436h792PblBthq5j?=
 =?us-ascii?Q?2ANMG9DluXFuEuFPK+PA7Ft9xfANZ+YHnh3b0zDV08nz7YaSeiUtAr4ACSbQ?=
 =?us-ascii?Q?u8VCL6S23J4Sei3IvqUK8vnO7PpqsjB0z9vnT5y7eX/7kOroOkLVh/uJlXaw?=
 =?us-ascii?Q?yXHJra7dILmJY9+HX479yImRmBBKbtpqcx9/6cHrH6P/TSPJUnene2KyA+41?=
 =?us-ascii?Q?src7Q8stJKumNIAbj7ScKlPoIO6byeuzYmcI0fccIRKcEw1r3+QRZpuCNhYu?=
 =?us-ascii?Q?52ehll2O5agxxkF4FPaja6jQA8nvTzF74tTRTtFRZUHQJu5NwbMFhl+iJx4O?=
 =?us-ascii?Q?sTlqhKMSTkdk08g8z9ZoDpHkQXsCtNvN0n5160/slSsy3qfx2zD9w3iR6mnR?=
 =?us-ascii?Q?Ki3tGQx4rbHLL08sd/Du8j05pFsnfro0pP8VL/Z4WbA0/xbmfhOwOjQm1kWj?=
 =?us-ascii?Q?1m33+yuwqSdQjQL+OyQ0YYImfkXWHbpXBuzn7ejZx7hVR7xCAfaczGtufres?=
 =?us-ascii?Q?P7Dg+/6C1fhc7YW5VT/UeXPnBifa3OCA5PmxzNBFXDLWyZ3kfdljwqzoFaq7?=
 =?us-ascii?Q?nXmhhRS+eSk6OFxNVCsLJR4eEvafWdFEKHcLRYIzqJmQPSOFNGtQz+XZY+Zd?=
 =?us-ascii?Q?AFowg4FpLnSoJ0vlmFCJhQoRoPuPtow+iXKOKpcHh+PzmiMZgRLj6/sUVHys?=
 =?us-ascii?Q?Q8W5kqA7svD7dT5WLhKRzxKmfwiV5g3KjvzU+vh8hQGhUdRVBA9fqEKPX/1E?=
 =?us-ascii?Q?1wDXmrPFDZB8ZZ7eFbLxiKhDsdmT2j0lmD57lA8nOTYBD08fCF/tLuumDXlO?=
 =?us-ascii?Q?toaK8ch3w7/YZjpsSdcu4knRHKeBMDpsGACRg8z0c85sxOab1TJaslvY6G1i?=
 =?us-ascii?Q?8VEkdoYKsANLBdkeQKXy4krJGoBc3RChrQJUU2/8sLNXFn7CytNNh+62fdZv?=
 =?us-ascii?Q?z1OQGwoCAX6e9FXDlh5vNWql0xfLyIP4a6uGol+xeQVS/FVXMI4/rO2RcFTJ?=
 =?us-ascii?Q?Erz6RBCS74H+R6Rxwne5J1urqTkSku0ok5ZumCFAJSl/JDQQWonBWoMo376f?=
 =?us-ascii?Q?ZBEyNYEdRkSkihSpbvWXqGhSRq0qmA0rxPxqgiUW2FPnA7Cp6ryfTeSQ0+jb?=
 =?us-ascii?Q?5PKN6lQmxpTcPApHsSpx98vSlW755RnfyO/stePxcpY+v92IBdECon7ghNRE?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Oe5jHuzrk0OXMP1Q0uF+FGrMYWMZsKWLZq24aiz1UhVEcrtB25u+5NhgFWHWwWFOLgCZV8F4z1aAvQgmV4DzhS5JYpeA1hms3FzAI4bvVADiey85Igd9ovv9qewrkzXUYCGfAcAeiLZANr3dtwNgv7UD+C8oh4qLhsx221HHYia3qjXTVMsuaMM2WZ0+Se5hcAoWnmUB2eyu8SYg0k5jA9mphnkGO4MJIZjV3yQxRwqBr3CIVYAbWsEE8qQFGW6eLlH8gtTkU27WtrKThs55dwHDo9WRZ3kc9V07SeiStmc4dTXoiwq6VuL0BKpa27eJpxuZopeThTjefKxOLgZYqwsaBavnkqeFD1GPIBN7D4ZTyEnkoKfGC79X/7L+xBSBb6ZfohabfbV5CAAwILNNXXJLvaiOy2gZRHtNyyEYdRwyY/rxmAYgxL/MICmNf8jWrvexOMxj0ixwyuxRxa1aZ3DIQ6ThjsPIIdzu9jljXOZA+uxikpd9bZ8c0B08khwDmZ47rKv9vxFofctdjaZhznzi9pssUdSNuZBNKnUASDR/IMWmVe5gW8pU9Mr4Tg+YhM23P9T8IXbADMnikKv0xTZmP1yte2wjGFIvOJ9pw78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b16ac3-5098-4717-2276-08dcc8443f8c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:04:23.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAb7uBc6j6Q8+VTlR/0IY2MlPigZEYovxNRjpIt0n1qRH4E3HyygIoPoDxHkxoL8ecm/OAXIpSm6lT2QAyAo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290113
X-Proofpoint-ORIG-GUID: 9kyQAXoNhUYohog6SH3EdEjPr27lJur9
X-Proofpoint-GUID: 9kyQAXoNhUYohog6SH3EdEjPr27lJur9

On Thu, Aug 29, 2024 at 12:01:12PM -0400, Mike Snitzer wrote:
> On Thu, Aug 29, 2024 at 11:57:20AM -0400, Jeff Layton wrote:
> > On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > > Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
> > > to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> > > caller of nfsd_serv_try_get releases their reference using nfsd_serv_put.
> > > 
> > > A percpu_ref is used to implement the interlock between
> > > nfsd_destroy_serv and any caller of nfsd_serv_try_get.
> > > 
> > > This interlock is needed to properly wait for the completion of client
> > > initiated localio calls to nfsd (that are _not_ in the context of nfsd).
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/netns.h  |  8 +++++++-
> > >  fs/nfsd/nfssvc.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 238fc4e56e53..e2d953f21dde 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/filelock.h>
> > >  #include <linux/nfs4.h>
> > >  #include <linux/percpu_counter.h>
> > > +#include <linux/percpu-refcount.h>
> > >  #include <linux/siphash.h>
> > >  #include <linux/sunrpc/stats.h>
> > >  
> > > @@ -139,7 +140,9 @@ struct nfsd_net {
> > >  
> > >  	struct svc_info nfsd_info;
> > >  #define nfsd_serv nfsd_info.serv
> > > -
> > > +	struct percpu_ref nfsd_serv_ref;
> > > +	struct completion nfsd_serv_confirm_done;
> > > +	struct completion nfsd_serv_free_done;
> > >  
> > >  	/*
> > >  	 * clientid and stateid data for construction of net unique COPY
> > > @@ -221,6 +224,9 @@ struct nfsd_net {
> > >  extern bool nfsd_support_version(int vers);
> > >  extern unsigned int nfsd_net_id;
> > >  
> > > +bool nfsd_serv_try_get(struct nfsd_net *nn);
> > > +void nfsd_serv_put(struct nfsd_net *nn);
> > > +
> > >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> > >  void nfsd_reset_write_verifier(struct nfsd_net *nn);
> > >  #endif /* __NFSD_NETNS_H__ */
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index defc430f912f..e43d440f9f0a 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -193,6 +193,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
> > >  	return 0;
> > >  }
> > >  
> > > +bool nfsd_serv_try_get(struct nfsd_net *nn)
> > > +{
> > > +	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
> > > +}
> > > +
> > > +void nfsd_serv_put(struct nfsd_net *nn)
> > > +{
> > > +	percpu_ref_put(&nn->nfsd_serv_ref);
> > > +}
> > > +
> > > +static void nfsd_serv_done(struct percpu_ref *ref)
> > > +{
> > > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > > +
> > > +	complete(&nn->nfsd_serv_confirm_done);
> > > +}
> > > +
> > > +static void nfsd_serv_free(struct percpu_ref *ref)
> > > +{
> > > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > > +
> > > +	complete(&nn->nfsd_serv_free_done);
> > > +}
> > > +
> > >  /*
> > >   * Maximum number of nfsd processes
> > >   */
> > > @@ -392,6 +416,7 @@ static void nfsd_shutdown_net(struct net *net)
> > >  		lockd_down(net);
> > >  		nn->lockd_up = false;
> > >  	}
> > > +	percpu_ref_exit(&nn->nfsd_serv_ref);
> > >  	nn->nfsd_net_up = false;
> > >  	nfsd_shutdown_generic();
> > >  }
> > > @@ -471,6 +496,13 @@ void nfsd_destroy_serv(struct net *net)
> > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv = nn->nfsd_serv;
> > >  
> > > +	lockdep_assert_held(&nfsd_mutex);
> > > +
> > > +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> > > +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> > > +	wait_for_completion(&nn->nfsd_serv_free_done);
> > > +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> > > +
> > >  	spin_lock(&nfsd_notifier_lock);
> > >  	nn->nfsd_serv = NULL;
> > >  	spin_unlock(&nfsd_notifier_lock);
> > > @@ -595,6 +627,13 @@ int nfsd_create_serv(struct net *net)
> > >  	if (nn->nfsd_serv)
> > >  		return 0;
> > >  
> > > +	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
> > > +				0, GFP_KERNEL);
> > > +	if (error)
> > > +		return error;
> > > +	init_completion(&nn->nfsd_serv_free_done);
> > > +	init_completion(&nn->nfsd_serv_confirm_done);
> > > +
> > >  	if (nfsd_max_blksize == 0)
> > >  		nfsd_max_blksize = nfsd_get_default_max_blksize();
> > >  	nfsd_reset_versions(nn);
> > 
> > A little hard to review this one at this point in the series, as there
> > are no callers of get/put yet, but the concept seems reasonable.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> Thanks, yeah Chuck asked that I factor this interlock interface out to
> a separate patch because it was a bit much buried in the next patch
> that actually consumes it.

Yes, and to add some rationale for it. I know folks don't like the
addition of new functions before their callers are introduced.

Thanks!

-- 
Chuck Lever

