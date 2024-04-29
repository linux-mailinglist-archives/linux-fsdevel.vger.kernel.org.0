Return-Path: <linux-fsdevel+bounces-18148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E675A8B60A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9638B20A06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90D012CDB2;
	Mon, 29 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hRC9W21d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bHGx4Hc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D30129E98;
	Mon, 29 Apr 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413027; cv=fail; b=g73qhdG9Y88lBdoty7Lb19yWfDLGGs6LhvEjW6w1YykIsrVyAIJJW/gKssrxVV4bRZE4WomX2dfEVroHeC8wIrbysL3Parp584tsFAxkg7VGeIKHbPQGWMQdEHhmf9bYCSSLiuiZvUMW3yjMXPnYmUR13mYdC28QWw0KbsVOzas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413027; c=relaxed/simple;
	bh=JbkPmEDEJ8rNknM+tCPz5T59A1WSee+u+OSydeKE6pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d35kiKOWsOOfD68RiMp92Aup/xZXEMf8yss8y1Ha1nKvyekHRLEE8FMNpwBvCkmlKGHEUbtay4XCYt5jXZDT0ckhPR5q6oh9aQMqkn5gn4v6MqQO6Fx3JFpaqz/LZLh7NGyFjne1iURj6wGP5bpidtqeW7Uwm4iLVdkOvm/9P6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hRC9W21d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bHGx4Hc1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwkoB004990;
	Mon, 29 Apr 2024 17:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=61sLh2yOZ3zQoNsuxoSg6LFBJxWtPicx4LLisInDs38=;
 b=hRC9W21dWgUIscIc4C6kNslis+B16GFcyFux+zMAp9rnR4kj58nCQqqRf8Uk+NZO3S1w
 p+3BZlmgMzyR57cm19SuAuNkk8ReFjmnaNGQj/LStcEV4fULzPzy8oN6z+vFlFUzARsx
 5LP1ZFxYbYREE/OibqA2jRfosDn3Mu9R0zWgMRprNEWkWIaLlgI74TUGtKX+n1RQE4Us
 KIPSMEnDVuc9o/33XFrtLcLqZ1FLsMgHESgkaWgmSkYtcWLV5eApcRUts/JdJVFtG7Tq
 +sOP5Jgf0jtNxwfHrjfrxwCExJCoIfxQ6PNhn6/7w94d3ThdbFPu3wNWrFskN10HVHRY Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdek6cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8c016783;
	Mon, 29 Apr 2024 17:48:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyoF4haLvyleKMDzXvUG6rKhpxBZJFoXWZqRNgaEqCzofDTk6ImWmkyyOgDfKD/ZkoKqxOas5MBkRXDEuO7MIuM1DfgQXT6NPvBmSS+xly3AEQWob8g0fPg4F7WVDRCfvfqtNzJcVUPnLp+AHIFBtc0z6890CYNvavZRIXwzdWfClOmElO0yawPEkpGcqaezB0yJwm6a9CRFjsuO5CkxU8GfRdPkEg2JKzbpFFvKFxHVQtxVWKVvi6A4/1v4uh8d2yOI7b1AtYzz4Q+ZfZZ27OZ88yrGxgW5sAeLPyEqvgK00e3BPqRDOpflmriq1gB+696W5fEHEiIF4xhtqzAl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61sLh2yOZ3zQoNsuxoSg6LFBJxWtPicx4LLisInDs38=;
 b=OCQ9Iwvjhv73EHRKQ8Ta3b5o6kcAWkkjQLIEAwC5t9Z37ZI/VUyH6nZWL54Mamew2J14TXFRIj0qgIKb0RWvdvTjDrzwyRsXGMmzc4tDuIgnkjCK2wjXIxztMrYveTy48HdKWWw4XWpQAORaMLPYnoJz5iXGwyu52ShI1H4jL8enXEu+e2wXAvdF2ibVkYMPUK1qm5g612htI4HEm/0+ol4yk92+NEHgp4HQeYLDlnKDpi8iXP9TXgJtk/bBWIJGrw8eW7XXhOw8q5wlIbBPHNr4X2NWb5m0gsowVCjDdkYv8yeHc7xLcnAomHFsirCGFNX0nzop7EWilAnG2J+ZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61sLh2yOZ3zQoNsuxoSg6LFBJxWtPicx4LLisInDs38=;
 b=bHGx4Hc16ei3nN/KLdNE8hqy56ywXLYHs5den+x6wyWVNWCQoU9KUcuKYerTSVLDoQcbI1WS2Qpoot7Dbq5QS0g+3J3hnj0MKW3fdh7adjsMJZrt/+/+0DaBC9eWETUqEKRUOPbzKzhSaWJM8fvn2RIvBtmYm1aVOq3Zn3fRtdA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 17/21] iomap: Atomic write support
Date: Mon, 29 Apr 2024 17:47:42 +0000
Message-Id: <20240429174746.2132161-18-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: b06148c2-5b0a-4b29-94be-08dc68749db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?caEE605iHTebpLrVZ4eLkE9tzeESz3VZpcyGmbOnWI0IwK5xcS0YEtdbQ+uY?=
 =?us-ascii?Q?7wRqUltyRCnxNrXOiZzdFeDP00MGI8oLdqbkLljkJB1uUSs22dW71MX6+GTn?=
 =?us-ascii?Q?5IUxhttF/GiF9kSeZ+YwiHpKaf6z4PU0Pm5PD08OJV+9akbMg9O2DKPifdKb?=
 =?us-ascii?Q?qqxy1A4fc1LLssdILsBwKYYn+oW541Pwb6SyiuyVFEigzny589/tC7RTLMBJ?=
 =?us-ascii?Q?N+IpolqR7hv2Nt95hsRrSVj4c3k54PKitI68FxBpixrx0eZ/d0lYGzGWbUKs?=
 =?us-ascii?Q?NuqL02sk6crAJtfHIaBR1iW1xbZ0XXePzj6U6OwUnhkIYXe8denXAbwvCvBR?=
 =?us-ascii?Q?XuCARtdJG6lquxR8kIxMNO9NaJ8TZu+fhWUXoaymG+2+qQ7/2mUkJoT58Tar?=
 =?us-ascii?Q?4UmdC1o1TzVi9Qe1KcRWZtigk37wLFpUbB5ndxK0ybOE2rGI0V5lex9UMXrE?=
 =?us-ascii?Q?vRCviCM5YzaXe02EiReKgCJhvRqJ6XS21RIZ0nBIu3Ik7W2izm1BkBM1QiW+?=
 =?us-ascii?Q?IrspkzVH8OpCOitwEyGHQUaf3yF9wiWXxOKYYl56w9kHB0oBJ1cdEFwarDGj?=
 =?us-ascii?Q?WAUFjSJrb+0cyRRiXDgw1Hak7P6a/ZBep0D89GWEWtnHg272sy+pvcLs+Q4q?=
 =?us-ascii?Q?GJOzqHKxREICNRcTdk/jSo0JIHi48/3WOfZ5udxcKNJZ9hZAosiE/Gkhg7Kz?=
 =?us-ascii?Q?2V7ffg5xjHiOwHn1YRfhQG8IU7oIVgqbu8FEfRnvxabyXK/JvvaULQFIl1lt?=
 =?us-ascii?Q?wvrwkEtWDvAmyj3Bq7tXyXdpJqIjXkqE7Hl1RRthHFnVUN4mQyQ6KH+qtBdM?=
 =?us-ascii?Q?Ww0zNzmy68ee2Naw/IcYpfRJHyKyxb+hUZh3vb8kSEmZQZC/uP1SIC3ikWVS?=
 =?us-ascii?Q?6wOwJzxqH6gDPfrS5/2y5DnON5n2G9/T9BZoxCRlKLPlxmJZ2P+TUUTv7cWn?=
 =?us-ascii?Q?3WVTxq6rUXUO3sH/y/zRHn3PCeuhWEjWLoa2NOIeSb/5a63nRUUS1WrEZqux?=
 =?us-ascii?Q?pnvEQK5C0gjXZg827ex4m6DYgmemF5V31hnS4WVqCSJgFDuXBTMRmGDHKiPC?=
 =?us-ascii?Q?KKPd6cH7A3UXRRW7FPTlzR5lyI9QZW+P4zPZ9wFxxNjmx/Yn8K35dH5ik6/b?=
 =?us-ascii?Q?1YUZyxV4LduDdgG2oJD8vmodGawB8DWeVj6XOF0F8zH0wFC5X8m5EQQqi1S8?=
 =?us-ascii?Q?JGk+t5bI5p82BarFtYOPp7GRH95YS1dEzVKWzOtY5KyARBjc9hyG9WTarI8X?=
 =?us-ascii?Q?ujoPFVk+MzqYuhyk7KgMuRKhGVFyJkGcFTNuwcrjjg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UBCqII4TqbJL+4el0XlfMrxMqPjOQ6Z2zw6eW/qzvZr9k00zkxCQJoeeYzc1?=
 =?us-ascii?Q?IXk+rtF76Cm1nDBjKwQoRqS2Ehc/Cjove1PjrQsbhBbhjv8NHVDQdj6vWu7C?=
 =?us-ascii?Q?ArgyJXa7YxPlP2fiZ9btMaEBXel37b+z+n4snZqM4Qs47CJmdiZziIjd155R?=
 =?us-ascii?Q?XvTq9F4s4ypXbws8KdJbeN9QMsrKh0vpRYtzgKKqOLFdIjBCUI/xlhyYPgXh?=
 =?us-ascii?Q?jHK2++xIRfBTUvhMCFOI6oKKWaXphK612/lFlSQ15LMer7DznYKpgGtyihCw?=
 =?us-ascii?Q?nWV1HQhqMak98owgF00GrQvq48p98q0F7M4gaBUmdE0yhDlXZ9x55nb4hbYk?=
 =?us-ascii?Q?YQ5eNM3HMmBDXEfQGk7JOJwVnysJMfl8EYRb+F1FRdj23KuQ1e9ub9zGXyT8?=
 =?us-ascii?Q?E5nLbw721hDaaIq5Eujx2gSm/0PxxJidLMF2HuJFZYWQsferumzKc2+tlybg?=
 =?us-ascii?Q?bJQsSDCPTmcHy+4nVAlf8HPYZXR8EuRBJfjQ3xxcISRgNUG8YUmGK/OwgkyF?=
 =?us-ascii?Q?nJBN4ODiI1hON2QCrCGezLkbUOuAIylIi1GecFyAw+cZAK2rDbnBgJRO9buz?=
 =?us-ascii?Q?+xutZjaJ58Lj0lnAUoNJMrGju/DorAlQs+LfCLXLi2Fj44frA9/cCDpeeOEs?=
 =?us-ascii?Q?BZfO0OEHQ75TmtPpYIjVX6a1mlil7gbbp/nGJi0bQtZdj53b5dNPUu08F2nP?=
 =?us-ascii?Q?QxprlJnzesW2ITO6nylND8nGrCtdmBccbHvao/kCwQKE8C7RrebDqwl3N+sI?=
 =?us-ascii?Q?r8wnyUcris6XSPZDuzpZDZQcun/Pvj3H1JnMc1KpUgvfcCU1rgkbqjc0jkUz?=
 =?us-ascii?Q?Oa83KtSWgVnG4PM1W6GrUtxxSRSzCrixcG5CNIS+5Qn5xXl4yjvZq7SX7SbG?=
 =?us-ascii?Q?O0oYe7Im/iA9+4FjA3MF1ZiYKTmJzDyBUeu7w7wyOw+Aa8inPYUVwPf16Z74?=
 =?us-ascii?Q?kflRuILkqwJoEl9hXESRrvyZJd7zw0OuXKodTsqnK1VkIphRpmGEMGRyLF0G?=
 =?us-ascii?Q?/I3ErnEca3vACq5wYgwfO9M6y9TOuR/Tf+aj2y6h3BsShLcYyJiLHCRyy+FH?=
 =?us-ascii?Q?1uGdCCRmRl46orMu9Q06OMh9Uax8rxyEm9jLdAZg36xH5uOqObTtsmnXoYOg?=
 =?us-ascii?Q?SnGXDKGxaRymY7uCe7iXqeQzmCeEmaI1HeHaKMgTQ/yDfb8ad1G4580bW4Zh?=
 =?us-ascii?Q?kHTGiYAVtDI388neWG1jYKjSVjHQMCOaJLFFDugffuz8thSiA/zX6Tdlm7TV?=
 =?us-ascii?Q?rwsEWhYNLgcZAsNzRFxHvjLYqRd/O/+FtX3Pz2gsACwRFLmb9G/qx7TSJSdH?=
 =?us-ascii?Q?ElxEF+ChVFn+2h01L9SMo9W6rUK3Y1GIc5E3SufiQa3A1LrzSbb/WMI8P8Hg?=
 =?us-ascii?Q?ArR5nMdYdbp0oyoOY6YWA28SOCx1NRbiM4crd0JeE2T2EMckImWOXiqrpFKM?=
 =?us-ascii?Q?TgI0j9jx7SMP1PUmBya32JnxzpkoLAezblW62+DVoYRj8/AamhrnVA+RWRZb?=
 =?us-ascii?Q?T5vsRoQT0Eyyizs/5LJTmUFJn949OvywMQwvyRz5aVTfqud8e6GBoaFqR01o?=
 =?us-ascii?Q?W2mY8sNhJnixkzzH0NqOicL8AAUv+3qPELimZJNBJfCZ/c8f1IqiDM6vPZMt?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y24vc8+nCMvJSOnAXrsl6InKcI/E4Lh2AEeVf6UyuP8JBrk/hukrJa7dwm46YWlVY1XSU+j+PQTQhQCfYxTnTly0hPLYJMS91CR3Z/RHCKCdVqy18/WJHV0Yusf/awICen01ghFpOO8d+EkII98KG/ep/e0GaliMw29NJKbkNTIYOrpNFl+1/jIc/qrq2rCWW8AY7+XB5kjvr2NBKpsdQb9pB+15XDdPbKKSf8cN77SebANRHzNpICXRnZzwdjuHFULZxEwiKj6miSuAimg6GzRFmJPOvaBwnugqDKjp5ccGO7zgGj+vcZNEimAcia7670M1KSl3EN1lq5IJ1cVrFFr69Tz3q4Q9hHsX+GLwVcr5hkN9FOpPcYabvhmp4qAQiaQ+dJzXHttE4dtbcLdTexQk33Z5F8opuNTaxwPpmsO0eXeiDLrwIMBlLCRLR9i09HMBdOU3KxWXaucFxMPexhggKNG83CIR9FSC/LduGnqwGwXzXuhiv+v+kzc7GCUA5DkfuRIo7OzgdFRJqRF66KAlhERXuuEnyt7dRQnksPj5VS3CvHD+7q06XCRjM3KdfxC85Z4rS1UZzPObTQFGFV2g24lCY4rYf9TKZAA93R0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06148c2-5b0a-4b29-94be-08dc68749db3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:45.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7ujqYL59XztNftBQKT466lItzV0vYZzZVQy8cXRTaf17NT1tw5+nXWzQ7EFrgOWxLvZniK0EbH4Pb6eDixHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: C1qosgTCqetTfyof4vZ3cbmq4rrdBfMO
X-Proofpoint-ORIG-GUID: C1qosgTCqetTfyof4vZ3cbmq4rrdBfMO

Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.

We rely on the FS to guarantee extent alignment, such that an atomic write
should never straddle two or more extents. The FS should also check for
validity of an atomic write length/alignment.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index a3ed7cfa95bc..d7bdeb675068 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -275,6 +275,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool is_atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int zeroing_size, pad;
@@ -387,6 +388,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = inode->i_write_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		if (is_atomic)
+			bio->bi_opf |= REQ_ATOMIC;
+
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
@@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (is_atomic && n != orig_count) {
+			/* This bio should have covered the complete length */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto out;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
-- 
2.31.1


