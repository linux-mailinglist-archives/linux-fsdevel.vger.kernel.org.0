Return-Path: <linux-fsdevel+bounces-22097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081C912192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4376C1C22C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD817276E;
	Fri, 21 Jun 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sk+Hb3La";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="olkXFgd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BD17167F;
	Fri, 21 Jun 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964384; cv=fail; b=WMw1mN/g0JFFFrxXEbQz4XWdC0bsKtsz2p11Bc86t2vqXaq/n/n/rXITN4IvnZRAcUTnJDH+7J1OtD27E9tj+xXv3hHCjYKJOoTESn/TZFEGRDRvD5onLx+zmMmZjTBFYs2TN1ET+mpfq8KTosCslyH7zfzBRBxNI3fMcMv1Y88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964384; c=relaxed/simple;
	bh=FC2RJgLz9yeOUXUezzKudOP9tD9llHw5rmERx7B1Lyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7tvbYMHkt8rhuL4/aRqDOZNio233YHX0Xpf0E8f+LNtvOC2jWtSDMpKHW8dNb+0laPSFSRwr2q6LsWYer55PRfFXdtExMX5/693K5/AdUw/IH4gYxsSRI4OVUZr2KEtDgdS0y0d4ikbAXGUINkBTnE+cKbhX3EvQeEcYCXrruE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sk+Hb3La; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=olkXFgd3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fQ3A027817;
	Fri, 21 Jun 2024 10:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=SR4ORPYab+nACGyn8QGiGYRguIGST6W8IbD0XuNB9J8=; b=
	Sk+Hb3LacOTURQQfpJoD+iyFBbb+WftgFC7dmZOGqEArRtwev1T3Ffs0ynDjQap6
	BHLVUEh0xMpkrwr/wWHYEHKGtA7QkN7GwoZfz9/ByFEIsLMLLNQMA6ZdN8tH/vkU
	ZSa4snTZ670ltL/7iD3bH2NRWYxBlYDG+juC/+WO/4gjYvNcWZOHmWx2/IIjL4oH
	pFE+PWjBWS1soPKPkc2bs8gPqOvc/6Ww6sp++dhfEGqCYNbTFDr3WcnhL4AHPoaw
	gKU7SWYzCDHXIMURMracJ2Dh2G9vFGdexXov1OyvsLJs1OpX72z+uKh95Ipqelsy
	rbWPQ4Mb1YnX3Ny0YqySdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktsfxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L91PTZ019521;
	Fri, 21 Jun 2024 10:06:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3mxst-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXddEbP1kL4NNJOXuw8gJL3SwSCN7/RVyvhcO10rtbE2fASW58kAVgS57osmqen4cJSKt6bcXuHsB3dfUlRQn+EJvtyamraFD8W0rpnR25nkTab8yI206MpwCdOVLuqv+PzWz7WOua36YtKkQMofCecsRT/Pj4QcnyVYccxI3c6VhKxzSk0RPOlMrFu3ja0UJYgiKKJSiCzlCwG/2h/DloTq0GogbjvXQtN+5lKsQqtBm/LfBhT4kvpb4JBzzFmXdlts74UT1ZDe1YaFqNzriwsPpfUqTXvVQNwcIRdYyJekfqXjPBL4va7VBuVbE0eebzrgxmaLbA80YPQaK0HXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR4ORPYab+nACGyn8QGiGYRguIGST6W8IbD0XuNB9J8=;
 b=gb1cUdn4G33miJcDA30WhHwd7/34MjUkI3WNgEH4fAotWe9ss048NNGShSvr2qA15jvAqGkWFrWb7YHDfWR/5LSz5FQgvyS3ibeCWFSF25r9Iw9stpLBYjFgDfJSPf2+um9espj8LI2ImP+2+QtgQMrpgmzp/ou/3FSZqTvZW1ysR1Xf9MjByfAtdKhs9FY5Z9Pz6qj0mZn9aK7hgicX28cYYjVMxdfpve3PiiTEoROBEQUim033xJ9knE9x05HgaJUJpGfpmG0VSKlLxGZp2EZ539mCKO8QcmMUVhrjpvahUnGK0j7OM7LdqnNazBmcSyvrtsLmvp6e8WV4APG2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR4ORPYab+nACGyn8QGiGYRguIGST6W8IbD0XuNB9J8=;
 b=olkXFgd37MIh4hS+fFraDsiPvyl+Aq3TyIAZyVVl+lMxkkP9FUzyiySHmA9N99AkTSRX0IRrgwCsCZ2IVoDccv9b4Lln5WW4+LoENYgw9RGvzMZiSFoRU7jTIEcP/eSeGab837HnqGiQqpoUWob50Ilv3cFROC3PCx4Zynu+uq4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 04/13] xfs: make EOF allocation simpler
Date: Fri, 21 Jun 2024 10:05:31 +0000
Message-Id: <20240621100540.2976618-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d70a4ef-c311-487e-4df1-08dc91d9c46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kU7s7jkJ89+a04eQ0SCjhwe4JLi5V9p3tATaRr8xxBXzEMn3vYNXoQXEEtn9?=
 =?us-ascii?Q?T88TS2XirPBSfwkmug051bM8ChwbkdoIFgZasbEEnco3Fd122yAnanRMBO1u?=
 =?us-ascii?Q?JXQW9pcvow1et9mr//iVX8wqjjI+cLuPLjqcybtY0XRkHuSZZeTU9mF6w1ke?=
 =?us-ascii?Q?S3zJmxvSHT1XuR/YBVQ13oRAqOLGitOXkYLGDemu3QfhjkCMqtOQ7EJ374Ax?=
 =?us-ascii?Q?D9ScrO4eIexH6OHPKXKaIVd+/9XCk0tJPVUlamF1a3SZuyfEB5q+qsSyAkzU?=
 =?us-ascii?Q?mNomWz0KgTW7ffrXbhJTJsdiToowBh3KS0mSPKoYIPVQ4nGIrPauAXeoYB79?=
 =?us-ascii?Q?2JKpEHQSIZRZ8ZstS3enjkaa4sIBXAtXnWJGivoCwUUGUKdo9VWHutxoqZbc?=
 =?us-ascii?Q?WJGaV7qDEQSVK4adaQG113ukkDyyoeBEPiYqnfx2L0w1siWlJ+C/KvDu/9Ht?=
 =?us-ascii?Q?SBwL3UR++eHDwngj4RJC7D/anFnkUc9IvDGizEnPXLf/k+iXECJyX9ecveZl?=
 =?us-ascii?Q?Y2125duF8hb76J6JufSFamhkwQzcaOdg2c3bepAgOR4ohidKdX7/UxhMeAls?=
 =?us-ascii?Q?vhirN0Bf+JjJL2+u6O08kLZ7cyVA/lDGDsnkGlj6VU9wt93HO0joeCLMVkcQ?=
 =?us-ascii?Q?OrsjuzdfykJc/+K3D+o9//7HAqJLWgqthoezMVKf36aK8HVkuz37b8hRk2Qd?=
 =?us-ascii?Q?YseeyJr7xGjsY7wauXPy1C1yVRcQcKGOFRtMibkvODwJ5FSsCb4mtwSMfNAA?=
 =?us-ascii?Q?p1HnGPBURD7VL22fpq3F0E5j6VZqStwbrXXU/C5e2QvcgrctJVCEoeApzxg1?=
 =?us-ascii?Q?GnhhnRdhSmOMxlss/YletbZNtS2Ntc4HdHaQ5c5rp3pRt6Z7UzBoHLYxzQtm?=
 =?us-ascii?Q?iWQFh/V9pmG9IgDOqRZzsFcMebf0IsB8C9SJVaq4JXstI2khsyviJ14z6sY3?=
 =?us-ascii?Q?MWZpLCQ+XYHuWSxVbslzixJ+2SYq53NaYuoP/WMrxoQqVmGB5Hf3jIDFX4k/?=
 =?us-ascii?Q?YLyTP0qomBP+PcrwJ254biI0Md5k5x1T8+j8I7IezXs8vvNWBwf4cNeDkeXo?=
 =?us-ascii?Q?GxbYYrl4MQQWTiEOTAk09vAgwc0wob6JaIKW2xhWCJGmAH8zR8TkUHPtXwEx?=
 =?us-ascii?Q?iRJTDBpf1lEE9g/5+Wt1Bvef/XsROIxcVEZ5NEgh2j1Wh9jHkdfZv+R/+cxN?=
 =?us-ascii?Q?Eq7ujecP9CoIaFlMjcMrHphwGUj2NKSYzjZLRh+qThjf/7NOzd8lb+ZMcmPB?=
 =?us-ascii?Q?qtDYNnqF/zcKd+UBSp+swTFKhObqKE67/qblTwh62poCaJ6109/gF40bwhQa?=
 =?us-ascii?Q?Gd4MrWs7ZTF9TqBnZSRiJRB7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DS0gQduUUP2aIJi1wJkxOsmfNKczR6XbKd0IcfmFn+XOIhKide6nrtYopBfg?=
 =?us-ascii?Q?jqguEHqwqNngDM5ra6v3TezqElGltISFzih70SulRnWN/RBkGNa4CmMX2nZu?=
 =?us-ascii?Q?KNgWmtix8rQlaRGX3SAV1P9rYC5G+5IpbnMQWkjAWV+MOqTFiDijsGQk36rY?=
 =?us-ascii?Q?vEE8PQl+170G7oRvLmbjoY67M1LymeUDSsZjtLVS/LMyaAFvp+mDooU/gyJB?=
 =?us-ascii?Q?f9FwP1Sh2Kpk+nYeVgdqCzHdxhwmaHrB+GvLoEi5SJVZ3k7FCBz0HNc/zZBG?=
 =?us-ascii?Q?ph0HZ/KDIIgBx9T+Tidym03+utsf7SWswU6mbmBxlCod3sjLXk8EFX3nwxGV?=
 =?us-ascii?Q?By95Z3FOPprOWm/IKoVQh0rlP0vEw/q1pWsOZP55wXPAfqKXZ7GAZ0k2lvzu?=
 =?us-ascii?Q?SEqV4W2x4sZPpt+m6hA8C/TQx2eqXrc5f9v1XCuoXHe8WeEVB/mlq95B2lcP?=
 =?us-ascii?Q?cJFJeFQm/XS9oRJWcklFPVmCmCKLF4EbCXwZTiVz09uQUdWIwASjVjADkR/H?=
 =?us-ascii?Q?RaU70ltY9cPn/ekzZMxpRJNggaFlBJfVpVpe+twuYE2iaSHCTcNeo1wjJW06?=
 =?us-ascii?Q?6hG/is/WCSMm/HFjyHrru8bA26PXc7OxBOmhfruK9Em6+lSBLOOihFDT4lMG?=
 =?us-ascii?Q?RNtjebOPBFpfPSYux2yTlHCHiDUAqeCMLPrXqmqZRMi/OaiC0SjHSR3A0ewd?=
 =?us-ascii?Q?/wMqPtOA1ewWTrdGW+Zyi08pFd/c0tKty6fIINRjM+wsgmXYut0fqV+tLKAB?=
 =?us-ascii?Q?SsBbJl5xwBKxRGTxgp/6mlzxtqq6OquH9xtpcgwFeDBRW0Lq3X2w2iMPhnx3?=
 =?us-ascii?Q?cNy5UU07LKVMmM8rsOQ3pIcBK947sz2hKnoTFcYZ6YLYGLjunRoOrmE1UdLn?=
 =?us-ascii?Q?6jba5+py575/C4Ad/oQ1FhMdoNxZXQC3nv36JRNu6e7KbJIX3WOuQWUldCAm?=
 =?us-ascii?Q?5gqTAN+HyVVXNkiu1lcDpatFmugvEE48sZlT3UX3Ufq29q3CCZ7dN5QQJ52Y?=
 =?us-ascii?Q?kPGxP9GmFynwbBZjHseCJDKsYiAct/KmmGDduq8013zeMhmips6ghH7D6k3J?=
 =?us-ascii?Q?IZhUxVb6i7DA6VU+qJ4uIQJ0kTG0j1YTa4wX2RyTjkKTZKUuc09g0QbQ8fY8?=
 =?us-ascii?Q?JJLMfw4/V9wwtc5Bg1z80ZUAHikUSivP+o9yiC7D4rNQroZ7NkXvxcCjw5px?=
 =?us-ascii?Q?1c7F8uxY+5gjsVIA0HwsFcWZB3cUfxxHLvH40XXnrpqCZ8+Bv64q9qpALeu1?=
 =?us-ascii?Q?msc0st1y2KfbcsCxZdokwh/dp+jJSluXZC7rArL0lngmpEJVHdYNmNmIjS7P?=
 =?us-ascii?Q?c/sYtws77gQuzEKj3rDkE6juDMV6TSJtxbh0Jf7eEv8auaHhOE0DTSjvsraR?=
 =?us-ascii?Q?Wav5rSYoRjtccQe8sBFNYgsGfLxLdXen2kH/Cxzz6jJrDUnyhcfaugqts8a+?=
 =?us-ascii?Q?JsEcG3OS89/sZbSN4dSRyZVITqfv8CiXG5Pef+OtyChLBcgg5+RyBKyntX2q?=
 =?us-ascii?Q?7E/Td/8Vq77vLv+NCP42Cog9q9y8sDkj7G6VV4holNmZ+8yTTrRQW1A6fGCV?=
 =?us-ascii?Q?SnPdlDdExJhfIW/bs0PZr/CayAMpeBWfrWCtTflTP4IVWrjC2BRpQeFGTgBi?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N1f5ZOqoKLk59acWMNrhyRtHgs0T9U8Fm6QETEt5JJ5uZopmW+KFc4xxRH9iRCVSc+VqnQBY9ladF0dEQ48VjLFi9Vo4KtgHQfXnj3rDlkV/JxuIQ1mevrDiM0Rlc1A45Tig7Z1oJTXmPXCJ2jCm62kdFGBWpwCU8450ROUBm28fYM7g747sYuVIQZSoc6ebm4zE+UISyaCUO0yoRaH5XzCVazEGoqlqu9rONykwS2B4SvddCM5mbWQcQlUNedGPMW3VlsP/Z0MN5PLFBn/y/i72kzNeYC2eeiipBlTNXqBnSUW6Y44ylX1r5PS4gBW61pyahstttzTXVVO5UFM0etEIniVi9Q7HVzJYvVga432kzUdqJcfRPP49JkvzS/Akc3T5XtniZFogO76AkOjWCYFiXVxk3DsZA9FXCJhpeNZFAR+0r05RMbi9NVG/PpYeTiyOsGf/fy2ra6JMXYRZRPn5gIYn0fsnsU2X5LNsju9jTQWRd4rV4ePThICVornLMlkIkRSIGg39FfaFQnbPB8GryAhyNzLm99pJzS+nJQTM7zcA5gYOG/vce+rGsmxfm5xiW/pqldXzNWAzN/ftE1uYseeIZViKW1zeN6G4aU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d70a4ef-c311-487e-4df1-08dc91d9c46b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:07.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwLfCLVfZy9GvMr8uCwAdt6MwdyEOy+0xHnpxYoBqarMutQvI6Jf8RBEqWsdIINWl/7piyAEodxuHeAMVD9Kow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210074
X-Proofpoint-GUID: VW1JPkgKJbu6kzcZdiZCdbf2kWUMUg37
X-Proofpoint-ORIG-GUID: VW1JPkgKJbu6kzcZdiZCdbf2kWUMUg37

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7f8c8e4dd244..528e3cd81ee6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3310,12 +3310,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3329,19 +3329,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3551,78 +3550,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignemnt space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3715,7 +3683,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3726,23 +3693,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 9f71a9a3a65e..40a2daeea712 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1


