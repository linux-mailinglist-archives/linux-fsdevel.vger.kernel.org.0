Return-Path: <linux-fsdevel+bounces-24813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB799450B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B2AB27DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E91BBBF2;
	Thu,  1 Aug 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P09Pgxuy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gr04oFmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8371BB688;
	Thu,  1 Aug 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529926; cv=fail; b=UFLZz64U8cAncsUp8QPG3h8rlHt6vUzdS50RDSroe8a5iuWooZTAKMdav+VRBUUETTyd+t422evM8rjSu3CvQOfV/8XnH0y5wX0ygcaO3fb59/H4WULeh6037jZuojpBXLWwPmDKChCJ9oi5dG6UZYBqmUbicyy3AKHtHuqDlWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529926; c=relaxed/simple;
	bh=z1AqAu1tJg7fQddCo/GgIMBw7lwPeiVDDZo4ripdTns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UuYOTfiG2aOxXbJmBsq0ioxgkteAhaQLpkzjajzqzSNnvWrkwgH9Ynh7fK98I4u5oIlcGRae5qFh7R7gktchUxcuISUqXB7F16ZmAZiAFyq0QL2ZGLit6eV+m7y6ulYsVJxCKa5xqkYysfung5P06NRBNJ6Y/i8wztIMCfgyzXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P09Pgxuy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gr04oFmK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtXdY010818;
	Thu, 1 Aug 2024 16:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=0bzkiy0u/DAI6YbJeATr2j9i1rFJTZAu/X8HDWVEXB0=; b=
	P09PgxuyD730ARYumSYdldFtxRriS9GeW4K3+YdMRhuN/8KsHRYPrzbseJz+2Yme
	CfqmRQ3lHkFZNgd8fbsHNvfFbUt9kPkpk9OT+hU+vbfs1yonTNyORM01TUxW2khB
	+1RHIQJ1afAUhs6BpLHpwCmRfZyAdVj5RkHqq7A7h4e3JQWs0d76mV72AndQXero
	XSII9jpy4S4aX+vJsseT4Cfjm6n4B8kyzIx7UlnkQvIgAdTVMQwNQit7K+F3la9T
	g/MHlRWt/pbjdGx05Dg6oFYn6Yb4GW0Fo4gWQ2NgFFHOlvHb5/dNwfFo7fmBE8Wl
	MS2u+9ssa1XtXnGipoiFnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtat9c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471Fe9Hi036902;
	Thu, 1 Aug 2024 16:31:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0es54-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJXfK/p46dUQ7oH0Yc74xBdVsPSg7Fg0oGSVsR5FVHyJMHFo4kOYlIHztPWVHMm1CVRGOz3dzK/3y3JCBVYK4tZOAdTB34UyS7D6V9fXlBR3rW04yAUZc3lPs5kv13XUfTkl0vsR5piWXsPUoxSxzG/WgSp/9C/qRZrhHU0XMyJB9j/Siihby4PWEG+X/UfuyfdV8S5T5qemJ7NkXDN++2bo/bVJUislDgYbx6N60iPgyjPU1v1aXIgJLg6rJSFHx+MV4GemJTOmHUgNrtB6sG6RSH1VaglIGDCNeVNDiJhYwZ058NW4RgBqqYeEhlkJ9a7Uq6QvVhHWMoaS0XzwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bzkiy0u/DAI6YbJeATr2j9i1rFJTZAu/X8HDWVEXB0=;
 b=EWZiH9Sxogx8wHelc7tSq8RbRCpIKCuZbibBv3wt5YuVvIaHidmd3WRe72brX9Wliunko77wLcUFH3DpUdIEKNC/mhvFqLovNNxG0usyWhU1MfXQ31ZDrXCagaTQesjzZT8vtLiiEhKmWkDmS54IbNG3QwPO1XEuSIj1cnySEnt1Boz/sXwub0CHfeXM7z9Le6GabrOSrAHozHxAUpTYGTiRVbHidGINUd7JtWnkwk9/ZL8vNcCpnT2CPYL1Nesu5BHIukgAQrk/lGNMHiYdV6fLIth2qHi2Hs1HRRIwfjmX86EOppgduRnJ6mzDgUCJB7etEIxWv/PrUfLIxOk26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzkiy0u/DAI6YbJeATr2j9i1rFJTZAu/X8HDWVEXB0=;
 b=Gr04oFmKZmbLwJgtAWGls6ntK64Lk81oC7dc+qlVaajKQoAmR5afZfE8nRprIZQapE3iFe71EcSV+0PqxDGuMCVfsZiJDQSwTov8KfznWzOt8hzw1xysYNe3Ojyi/IQDdaMdMsvepZ3eU8XHSsep5J4HU5Ol8v7gt2gWiCSHjQI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/14] xfs: introduce forced allocation alignment
Date: Thu,  1 Aug 2024 16:30:48 +0000
Message-Id: <20240801163057.3981192-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0357.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a348af2-c745-40a8-75e0-08dcb2476e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06QgEZLkp0z7cZQ2HCNnybvd2t/dh08XfJQPkgKbhahp2UnhBv0qTTTXGbxF?=
 =?us-ascii?Q?0W10k8p6jqTe/Dtd+SRUsYwPZoaiEONGRk02htK1i6AwhmWXrc0mr5zLgv0f?=
 =?us-ascii?Q?tjqZk8BtYg2XgMiiBQpsn1NcDmnoFf4p1ENI9wiZX2+9YGyPofVxered4sJF?=
 =?us-ascii?Q?H/49a62MfUiHXgpxpITZL7HIrpCgssW6+NS6naUKE6GyD8HHD8TuVjymn9z+?=
 =?us-ascii?Q?k92bl/7aNMcemXi6LqP49M23iru+Aduu69bWrvgVANwMhsZJSGJo7eZrr9KC?=
 =?us-ascii?Q?9v1LDuV9aaVRbc6KnYgNqfrXxtASyHgvgMloh6Rwng9mOu8BytJI32pp/+Yg?=
 =?us-ascii?Q?rM3ZAjSLaZJDwB7pbjQaeHciI54x+zE5cVgR1MHY0z4sBgjYMqdqbvQSu/Fg?=
 =?us-ascii?Q?vZqo4X/xV91r/FVDn3lNu96uvXa9iXMhaq3QGyvs78knIBwHc0btN0ODzt2/?=
 =?us-ascii?Q?wrqae9naO/VSSlaIdG5CKE6AVq9v1/5XJXrSpObylYF8OJxphdL6jaJZ8VlX?=
 =?us-ascii?Q?tJylqAZdrye0VmDwM/3M0IGQIq7sKex9bBMXMzFDyfnmgdO7huW3IOiBeXFR?=
 =?us-ascii?Q?i5Tp0Fhah2d05GrCLEpmpEXaydQ2p0VnMBNIPj0TqKoXmAcUEKf3S3oOMhZC?=
 =?us-ascii?Q?gTxYTFstjGF7l224vfe6lJp9LWBkYdueerVQDo4NdNkcWxvkRkqu2IsNMifU?=
 =?us-ascii?Q?PcWcu8jPD8KJrdOBvq9k7Ph4StZIqbSrDcdnxBgZ8VNnkXAyP+ajlritq/5T?=
 =?us-ascii?Q?fU9jnI3rgytjgyc2ybYwE0Zsr1ObLA1T7IGq1jqVR4mnBdIp6NDhYQNXvhLH?=
 =?us-ascii?Q?kj+Wvi6PcuVqU0F8OjS5oBEXq9pwC/rkA9VXrf4PIQAxkXSgIcAyakpI+7UX?=
 =?us-ascii?Q?LjgWQhau57hsJA783BBh8n/5yXQ0i29x40goD7N4O4WMj6rd2EUJbxa44hZp?=
 =?us-ascii?Q?Ex0sYVVNe6LqkpDITGK2Og6Ce4L9iPuHCsXBaBOXqXDc1fyP3nIhhgUr9ic9?=
 =?us-ascii?Q?5iHozBGau6JFjIayy8uYrYMQn4XmHDilLI1xVKvpNAeIHYQqHwHYRXGIpeYX?=
 =?us-ascii?Q?9Revm1JXgQ4vAWTDQeEsnpXR0lIRMbiB7zp/ndSk4nVXkc3ofyVaoQBCKlpH?=
 =?us-ascii?Q?pbSkHaPj4t9azaMRh0szgK/1e+hOy7qFGQoyc2uWUa1Or5PjKOWEpgvp9fWY?=
 =?us-ascii?Q?o2y6NtxZ+H+B7WiwW73hhrlS81dvyoTv+YuHXod4SYhoho9p25gBUu5Ga1hy?=
 =?us-ascii?Q?UGGAVyzs+Y4FN07A8TinSkRFC3WqF16kIdj5j51NDovO2xvoYJggsVBeW1n8?=
 =?us-ascii?Q?z8WBigLgTK3OsGwbNP3nSsiTxGs/hrYfPZV00pEgpf45rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KaCrfVtBTJa9223MpEYEXCTqeGK1JxUNhnkJcLdE7XYDdrEPteGNPOupWuqJ?=
 =?us-ascii?Q?eBWByBr58EFpyc+z176VqvdfgscwL++ybiXUKnNjlA6QHQsuzTA5g2W4BJRH?=
 =?us-ascii?Q?iAvyzdt358UkElYlHmJXfjlwJ7BCTRp+4BNcfbtNIqeI3vrynwODTc3sIpVQ?=
 =?us-ascii?Q?gruTM97Y38MjPoLBGeDV2Ugjrcw5PrtR4oKI6rZEXTsUcqXxU4t7pW9S/bnS?=
 =?us-ascii?Q?ecLV6UO7ux4zaZE2usOjbonYuzT15wdUEtKh0vc4lW/7duiJOSASVf0kVcC1?=
 =?us-ascii?Q?u9AyYVKT6UEGxkMLnK5LMJnNSKXRee2EO6UUTuUEwUUDHA/Pp6DjYpzQQYMy?=
 =?us-ascii?Q?KY2MPUXUWB45OatXHUG4HyHBcaDkmEuY6MR99po/JiOVZsaCerrk6d+6Ixsg?=
 =?us-ascii?Q?9+hRvefvKrUF7tXo8CYIokYZDst2kQY43P9YtDTcoi51R1q0q7bzwjlPMKo6?=
 =?us-ascii?Q?d1X4WhIqUdGYnCT36pKVBCvLF6K5/7snvXzczj+BfFvLzyLjrao68JIbnwJ/?=
 =?us-ascii?Q?BNmRp4td9ChIp3IDTdp4zqEjKD3LCDGpS8DGaEmukZfnGPWyhMHHWGVg1LG4?=
 =?us-ascii?Q?dg8ScKAsQM77P1owi3ZFTbnUgi6tPZSje2bSOJ9JbToQw+/HViF0a8xNX4NE?=
 =?us-ascii?Q?nqcsSQ9ePajhsPfy2QJN0RFu9bAxkkNQhPrXQN1/dr3kn7pMizWK8Ih6oc8y?=
 =?us-ascii?Q?Wzogx8U8OIRgu2jXd6WH4TDqn+PtGF47FBDBXagFgbIAXMIg9vbtadcHPT5c?=
 =?us-ascii?Q?rX8eCYtW/YjRyimoWthL5H8YTxcFvLYC02RmJar4zU6WWeVc1WlmSi/XKBIs?=
 =?us-ascii?Q?T3nt8qqJ+6nYTZFn0MawpPFeeCz3rZRUd+sR2eOA/HRCOY2Up7f1ZS/+wUn6?=
 =?us-ascii?Q?TyRNvESSWQVHb3Zvaql45OxgdMxjThNTlbZi4TFPGBpUZ+mVURy+pW6MAs6I?=
 =?us-ascii?Q?CEbSD7uR2pdVtZsR2VjEkp1PZjU36TnV8MsOqaeBQlMdh0cYnlMsrJIgTmVa?=
 =?us-ascii?Q?CGnyL6hcy815sG3MUzfM7xHjOooTLqvcYqPoEpr8oazYAk4YWD8ox7wP3m7s?=
 =?us-ascii?Q?c3+uCVgdvZuQqnvVE1smoX/MgJc/qdmhMbl/psLmW+JfHNbTJZSOmXVsw1sQ?=
 =?us-ascii?Q?7ASmlKlSh8HXt9X9YReAfAwre/fM2weu5ImZ/Idbhiu4T+xdqZayML/hfaPn?=
 =?us-ascii?Q?bH/GYyqcQ6siyp5WBrqX15pC+zYN7dHX1IS2F33KtSrUc7P0skdfOeJKPtcE?=
 =?us-ascii?Q?FxgVDvzOwdUo0cpvCcSMx8n6j0d75IAHyZdFLnxwHEh8HxSUr7tzJ+uQ3jCN?=
 =?us-ascii?Q?ofcMAi7tvp63tyQOw7ynPjPwUhb7vdo2hZySyILQ+Bv/LARHg7t2BW3poqvG?=
 =?us-ascii?Q?boVfvbabi5QhRiqLsM0qFz/Nab8Sh9jVeJXEtro+ZdUPLnD7zB1Fu4PUflBj?=
 =?us-ascii?Q?RRGShwIZxoWpHVBma+0hjFPDXy7sbwbKjyW2FyObHk6qFDIEeF+IwHh08urE?=
 =?us-ascii?Q?tPuz/V4s587lIgjLxtwiltByamKNd+ywAo243YneKtZGWJgk3f3wpGPC7fIa?=
 =?us-ascii?Q?vp7rzfde7g5mgZHzuJ+PD7Vsl0vH0iJwAYNKoKbGGTp/bdiK2jh4I38yWui0?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18qF7F3R3IDDRclRydaH1D+SUGCja49LpQrPX473dP831MsEYNlBEBQ+PsWB8p0DQ3iWBhZ/F+frtINDwoif6EsC7ghTUSFHpKVT6lHO/IlU/iNl/6CK/K7tiZxKc5ah7bgMPzIIZ0s5GMC9J2+OJasKl6JeNiHhhSdvlezKbAEEN3wVppoPJ0NuCxr4Ig8BTX+5lx9clskg6StrO7hqmBICitvCKTPIhqCP7Dr/OFKn3PAnRSoMRkl0nCK4LeY9I3Kp8b0R+fCz0pHfNZIDf1k6CaakvpeTocfCDs9NEHBABJBRnTewA3MHBxC/MoAkKWWIWg7sJz5oDRivGTV7iGz0n8UsYOs7o3XCpkGWJy3IUAGefhRHq0D+m3MSdnkzLwcFkh3b6NnDDJpuqodlIj2ytA9QJY1LK6twGpRpkZDs3XPj03nVFgLCNtvOEt5024J9JcOjICumorN3mBZrsTUnk0URhuRtcQejk6SsIAq9q8qAzkN/21BaaBffkOb//VXRf4UOEqrHXdpJj4E4ingIrbuyY++H0pJFFZB4RD1unTXTe5EJqBPDBVi2qcDphGfVcZ0BPmNDMDiJzB9NPc0kjGdBonqDKdagq8JkMjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a348af2-c745-40a8-75e0-08dcb2476e38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:44.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kr8uVHQ+bcHFL2oCTCQRbMIQWmn/W6dh1kDdG1yTUSpB0pjXKIgn0QUG+us/+gObcF3Q2ag/hmbDAilpqqUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: Tk1_fTFvMMQ75znzE7jlZz_wk9IsJD73
X-Proofpoint-ORIG-GUID: Tk1_fTFvMMQ75znzE7jlZz_wk9IsJD73

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[jpg: Set XFS_ALLOC_FORCEALIGN in xfs_bmap_alloc_userdata(), rather than
      xfs_bmap_compute_alignments()]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 28 +++++++++++++++++++++++-----
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 473822a5d4e9..17b062e8b925 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
 #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
 #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
 #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
+#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
 
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 42a75d257b35..602a5a50bcca 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3401,9 +3401,10 @@ xfs_bmap_alloc_account(
  * Calculate the extent start alignment and the extent length adjustments that
  * constrain this allocation.
  *
- * Extent start alignment is currently determined by stripe configuration and is
- * carried in args->alignment, whilst extent length adjustment is determined by
- * extent size hints and is carried by args->prod and args->mod.
+ * Extent start alignment is currently determined by forced inode alignment or
+ * stripe configuration and is carried in args->alignment, whilst extent length
+ * adjustment is determined by extent size hints and is carried by args->prod
+ * and args->mod.
  *
  * Low level allocation code is free to either ignore or override these values
  * as required.
@@ -3416,8 +3417,13 @@ xfs_bmap_compute_alignments(
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
 
-	/* stripe alignment for allocation is determined by mount parameters */
-	if (mp->m_swidth && xfs_has_swalloc(mp))
+	/*
+	 * Forced inode alignment takes preference over stripe alignment.
+	 * Stripe alignment for allocation is determined by mount parameters.
+	 */
+	if (xfs_inode_has_forcealign(ap->ip))
+		args->alignment = xfs_get_extsz_hint(ap->ip);
+	else if (mp->m_swidth && xfs_has_swalloc(mp))
 		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
 		args->alignment = mp->m_dalign;
@@ -3607,6 +3613,11 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
+		args->fsbno = NULLFSBLOCK;
+		return 0;
+	}
+
 	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
@@ -3658,6 +3669,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3716,6 +3729,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
@@ -4151,6 +4166,9 @@ xfs_bmap_alloc_userdata(
 		if (bma->offset == 0)
 			bma->datatype |= XFS_ALLOC_INITIAL_USER_DATA;
 
+		if (xfs_inode_has_forcealign(bma->ip))
+			bma->datatype |= XFS_ALLOC_FORCEALIGN;
+
 		if (mp->m_dalign && bma->length >= mp->m_dalign) {
 			error = xfs_bmap_isaeof(bma, whichfork);
 			if (error)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 51defdebef30..bf0f4f8b9e64 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -310,6 +310,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
+{
+	return false;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
-- 
2.31.1


