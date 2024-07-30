Return-Path: <linux-fsdevel+bounces-24608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B2941383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137FD1C23562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5051A08AF;
	Tue, 30 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AM5XyoH5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l0Y4tKB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D341465A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347292; cv=fail; b=OtJE/V/znCSZgCLKvDe85wKQIr0OFimzQYdpCTXhfs/6r11P1PsWl5RX9GZJEGRUuunz1RMQblHuH0wBJSiFbWCTkX4kPjPIgPlInk3/c2syHsKOQhMWhvR5NgmxFXktfSfvwtWk955TEw9JM8qGXwgC3XsYPUbF2e0s3bLw61A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347292; c=relaxed/simple;
	bh=eVnwN/rgCgNypiBzdv78KZVxN908RhmGtOPYLI3yxgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DbhB01EWUEVNeW7Uh5f387j5wuYp0xZ2F7WVkyL3mf7v0DsRwC0CqrGvwYut/PLKwTwFqHynXyUrkGsJAKDi4hpbimTU/SBCaXi49aLnIMo+Ooc/cTRzv5FZxCCaoPkm6mkCl+vD6qXONdHdawt1mu4ve5wpC0V9f4VvxbrvaPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AM5XyoH5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l0Y4tKB2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UCtRKa015357;
	Tue, 30 Jul 2024 13:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EtT12i0gSlwrHsO
	4yQwSyT54+twQ1RU3dGoUzq4KtnU=; b=AM5XyoH5LYAxx8sBLK532IhNeNwQBww
	QT0VBpeXs/5YATO21OrB0adk9+Y19BqFjmj4QmHt7Vvbub2Af2mGn1HOdqt8Fpbx
	VoXZigZAuBeIUZBwt1tDHndnxS/Ucw4dokTys17QVIkZh867W31kHXVm2lu9ncXW
	BIQFavQrdlAOgw3pz0BmzIQTbN0aIgI1IINyTnXbqE/QxuQvGoOpNatyD1lW4FAR
	m3zNR9NHQ13qUYQ8AcQ+FPgkXUgbrSTPMusB3LMAV7p88a0K8moVl0Uqz1CDUJET
	usndQXdEgjlkVj+3KNKfj3Mr/T4toRG9SpyfZuvhEuyiUlQEDeeBeDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1w490-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 13:47:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46UDTI3n036482;
	Tue, 30 Jul 2024 13:47:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnw8k24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 13:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVnvWgiarMo4xtYP22gLays/f0V+na5a+4+SP43eV1z/BUrzMFnRu3PiOjWvyVthRaFTgWW4n6TChSnRC76mnLzDz68q4iXR9MjkIwWYDhTy5AxRflQnwBIpg84r6/2zCRMgKp0rNV30iIXgOT4v3PLLui2PA9TYI8yCEfZpXg2E+moS0t8If6q20/0ZV+7qNgKrWHarX57o+ZSnsRAVp3HSwgqgz7wR9BN2By1gzWaaq21ozbWGMmmb7A3kojueQIYtbzl5rVE3csRB65Dmksphw87KDC+4li+cxor1POQZFvQnKG1qBK60Tu0SOEnLcmjPnjPccNxLOecwGE9wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtT12i0gSlwrHsO4yQwSyT54+twQ1RU3dGoUzq4KtnU=;
 b=xcpaAY7lyDuI9lkWjeh+7kgc3kjqdY+K4xs1Y5/H+PU2nZTJyWQ3VuQ/2JwDWUni02eP92QnUMgMFyDgjKp7Zum04JdDbFyrzBf61m0NCEMi45H4w6IV0Muu+hZKgPKN36mPJkXPu2VpjWAO2j1/6yfmr4E5lkaTkzW+MSPouSB8Alr9W6yZq55c7f6RwYqJrqMRVKGmpgloAqJqsGTiTk8+eWKeKsftpZaFyzjAvUGPHkODV5Ygm6WRkU7vCT1/NTfyxerlw+qxZfMHK9NM2aQq46/6OcBa5Tmijd+rvfw3AlMSLFP9B7PPqhI5L5d5RbP4+31StkPL/3iXc7zvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtT12i0gSlwrHsO4yQwSyT54+twQ1RU3dGoUzq4KtnU=;
 b=l0Y4tKB2K+zXvept65gVV9J94jHLOg7W3hH1N9jf7Hk38oDyCvPw6D8NWsdLsqp/Hvt2JyDKHd+vOZSfFHJov/66ZLjjqI0VpvNplVX/1A5sJ9hzI63N0IDzT/YudMEhH+Mbey2sg0OoPHcyrAwA2NHbg2XJQVSNnlMbCLh6k6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:47:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:47:55 +0000
Date: Tue, 30 Jul 2024 09:47:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] filelock: fix name of file_lease slab cache
Message-ID: <ZqjvCKqqORc70UZc@tissot.1015granger.net>
References: <2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com>
X-ClientProxiedBy: CH0PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:610:10e::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 512bf27b-967b-46c6-aed1-08dcb09e36d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E/yFVfh4bjRq7y/4w80DpoJRdINb/AsdzSiesFGHwC4kCjJ/FFWAZYWcN70E?=
 =?us-ascii?Q?EkoRKnnyINd2zqJlE2fhwWtjag6t0Db50mLCjC5YstLddc/1MRQbcen4RQrC?=
 =?us-ascii?Q?qNLoGD5j6dAYu2BtIsx5ygcUp+IyC/jR1c5AxfNS5fbpNXAHYY7Lnm60ZI46?=
 =?us-ascii?Q?cbwzHLkFkGH5SFOvaFgM4ucmRwoVxehKtEGmXbD78D3YFm3R5nNhzRuqsYwx?=
 =?us-ascii?Q?v2FBXLu3Vlm1z6aHEFN+HFsJJnw1s450bT52+3GW/1B7jzjyp7+iwdkea9ag?=
 =?us-ascii?Q?F6rA84qutDPALREIotKDLky5dh2EckPmiPBpeifVuHna8ZUsm4eJBDiZYoFu?=
 =?us-ascii?Q?ocIfnTtG5gRcNJMf3sH2paJT1n+TTybrtmZ3Q/OLAd+xkwx1NE1kMuyXIvNN?=
 =?us-ascii?Q?mJ9efpjoF7wg6RCQaWLzfaTu08Z9sLTvOb9956dZgohpr8WQ0ikm+59L3uAD?=
 =?us-ascii?Q?axJ33WOF+XAeorxZcT4uKDoSsRFuQyoll7gVbb1AaftLxrM5Uwrjsew+6Mkf?=
 =?us-ascii?Q?fSIyGlBunXN0C0/6fpjCkErKxUfm6uqrM3vGq4xXN1sZ8mlp0xoHJ46pbgS2?=
 =?us-ascii?Q?2cjlnm/Cvu6fipgrXVumdlyKv/tPKzkx0/+TKanOMib+h8cS43JwX2xsN3Um?=
 =?us-ascii?Q?SnYjs3/VTsu/Yor0xrjWDDChk81wLegHvIWfkRxSfmuX4kTgQuc1WBAJzcLy?=
 =?us-ascii?Q?RlFvuqQ1ZQ66iDT6KpxzZZvenbzfARM+J4xJ/0FiwCShVGbUG2qQY1XM4Byd?=
 =?us-ascii?Q?h5bAUpdziTNVGRI9/NY5El+sCRzcmgvfay/3H5ckTmenqsmixkVv1U47Qj0D?=
 =?us-ascii?Q?VKAOjHGm79SiTHVdXZhtw39tEJBCSNdx1KnfoF+G199BbFgid5y8bLSKwrwD?=
 =?us-ascii?Q?C5O7ZErI9+4CGYCKblqkf4JMemXy0+qaIR7MTMr0owo2ffAbffr1eAW8y3D9?=
 =?us-ascii?Q?H1PM2qQcH0v5H0PDez7czGGwe+GyFmOUIHw9vcLAqQWhBKApmqZHDGaxHO3z?=
 =?us-ascii?Q?Dpfk/CLqeQC8unPA3vI8Uzkj4re7oKgvgz1s4hpWR0wvYND2hV8aYCEf5lQ7?=
 =?us-ascii?Q?O3Xe+CESSHRKVZORqtEfZszt+LtLE6N5Gb8XyaRU+zGfuzD+biw/QgfgHYpg?=
 =?us-ascii?Q?zT26eaQpPReos/HFJFzo2QOSWv62g7B40HhaZzF87jobFMdq+g1Ag9UOcW2b?=
 =?us-ascii?Q?JRZsyB9S/QhTzBa2d+a5pTKSv47z0prFuP6+l+mBxYt5qK986pyUyI5jrjFk?=
 =?us-ascii?Q?l3+Lry1gTV7/I9tnVxgJNVfjzIpkGG1hswCc3fWolaQqbBs8TAkz/WzW2fQh?=
 =?us-ascii?Q?F2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndxaz/boCEl3qZPyOfBOnrHacfHVWMPfyCZCKyyWIuu8hO5mUCqSg2vY189O?=
 =?us-ascii?Q?E8EvsWPtWkmmo3RCCJkNJB1quFDVxnbyA2VXvqfHqxhGDM89Idq7DxZx/XQk?=
 =?us-ascii?Q?f5X0PCShwXawgktwpzxVJAuEiaN75ZQ3co+Iliu1edFZuNM8oVn/Kwk0xrcQ?=
 =?us-ascii?Q?ut2EABG9wn+Bk7wjMvLAiENLDH+Im03QY76cIowwX8TNtvVwKuegnRlNZJL8?=
 =?us-ascii?Q?/s5hTC3F/SwIS5HbliwbTkPKsvmGzBes+2uLLITGGZ/KbGKoZmSJbDWSEcpI?=
 =?us-ascii?Q?doT7eaYY8abQKsbAp1AOwiwOgE3kavfsmmJjFvST2t8ofIinU7/sdWjsrcbB?=
 =?us-ascii?Q?HOJvBxk1OBl/XfsMmsF7SNa8gJ9kx1F5Y0xd4FJfrse4ntDopuDZCjYt7qk/?=
 =?us-ascii?Q?L7NMF06O1h0ZNJKa8vgx637jKTLZLXjThD0HpR8Hr9tToqAGnrj4H2TqSnFM?=
 =?us-ascii?Q?IA3/ojJlFBojqXf2yy6MR/iw2ySK9Fe5pWiaCCRZcCTsU+VpuErIeSqjYZoG?=
 =?us-ascii?Q?KIANde78CS3kClxuI2q5QSpn2imzZzmRz/aKVlNgDH++Edd1AcO3KVHP5GTe?=
 =?us-ascii?Q?tvXQVXjCxjjF12lbZe+HG88TYJ/hYNIqwiFicBCoN8mydvf1aE6lB9WnTd2K?=
 =?us-ascii?Q?WzZCAoWBSosIGL9drVoPyBhefHMc/VSP15Vvu3e5tg36Qf072H4SI7jfgwRb?=
 =?us-ascii?Q?t7QUFwtnmeYx5cp+1uxN5vokiv7y2Q8K0A8chg+KzUAjEG9tA6gBkRa2karu?=
 =?us-ascii?Q?wQOqzuG6KYPOVPqAaqRPINqGw1x7QSB2hSrPw13fErYevQ1eOZYOeTvJCyWE?=
 =?us-ascii?Q?CCuzS1c1pz4by/2UIES1XVxfh2kJFl5DVxG3IEL60kH5msMgmsq7HRQfyJ8F?=
 =?us-ascii?Q?ev2rKvKbbvVpC5Ll6l+LCCkyqe7xxWfsKXZJfht2KS0iMgIJqmcn55e6nAFm?=
 =?us-ascii?Q?Anjjk9YyF8Kuf0PiCbbyeZtz7EZUCwvIg24eeL/70Ejqt23aVvuuaZqmZn3/?=
 =?us-ascii?Q?nBA69zp7MWfexDuIxJN/RYu0ujCusOcq+4uhdLKCMvBBrhFR4DhKEFQ0s9jG?=
 =?us-ascii?Q?65jWMqysF/x2V+jpWQtfWh4N0Vhbv4A/kzKmVhaiul6TbycWS7PILD8pfxzR?=
 =?us-ascii?Q?ODGWK6c5g1ST+tuz+AG2Btwpz1fmJiIgBmtQsEHqjy7+/Gz23fIMV1NrM5RD?=
 =?us-ascii?Q?sXCiKj2zvxEuKvXs73mSqIXVslY3BJSCYFt0zHv+FjUzNrKJIsjSM4b3zP7r?=
 =?us-ascii?Q?WIw2OCbel3t67bmVQE8UTlCI92Jx3KzGukiHK0OJcBRDRNEbUZ7i2wDsWtB6?=
 =?us-ascii?Q?yGqt80LKokSjztvoWgshQdk2BNVYKluK+aqJexQadQDxnEdLU0laV6sLhwq6?=
 =?us-ascii?Q?vq6SfNtWq/70BdJPyeJlnVDcWvo2TmwwjKBgF4YDpr63KxPbkdRPTozICzDU?=
 =?us-ascii?Q?ysVhI+OpuxnYZHpbpNZW7+bHoxpX8lWPjWrsIHJpG+WXpcOajo7f7By+fx+u?=
 =?us-ascii?Q?IbuU8ScxGL5gmeS7LW3N8/FqOMXj/YoKcCkjjPVr7lqLLDwrXzSGDgYyhXvz?=
 =?us-ascii?Q?IIvtJNI1qYrEHPIO2fvhG05ujl7tZ2sABhuR7rneGr6iBKeeQXdW0bTCmBGW?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XiO1JBAiSTp6plYzyWQ09+pjWDM8PQ9n3vmovCGB+znte/RMV6ORuhEkVFi+wsUe41WMohQRX6RSvAST6p4SxhWpZT3660acH+FH4jvrFxqkkGgibHLt+8ky+4GOtRlwpH+nUU7znRHuvIAHARiFwe4P9PzTQwQVI6aY6V8c8y109MHltMRxVdAr9t7UC+3JkqehXih8Z+8wxMe/xT1UAuCt4ia46o6z+4RaycJvkOAzz7KH/MTH823NWqsiV4eak4PbW75ukb1JajdPd0mRVOFyIxQ+hIQ3jtjYvkhDIMWhy3TeuBtaGt1j8Z6ktD8GDELUJ8PvjrktWrVZeU5+rfDWQNP+6dMomAu/00rh4nE+m8nSDlUq0hGlVSck4PONvaiQSXOwIHfy5MYViMdYxgOZQjGI/ah9utZIdI3i2aflk02PPCH5aiKEo61Tgue7oGwOUURWMRVKl80oh9S00N41OmFb6Y6zYBnsGQAZWV96SQ2AxrS/FJB4zQYSKqDg6rhaGUJViA+zW1OX+YdnUNLtgiqIVeu9PMauJGfeVDulk2sGSaEvGtJWN0GwKuNmW1s6BYirx13JXatd0FY+u0/DKWYke0dpnSG7zWl/6no=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512bf27b-967b-46c6-aed1-08dcb09e36d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:47:55.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WELsZXnVRx3KKvhgeWYWUPKPA3vjORGrqfSMmTBaHcQTfjQC+6k8UDTuOD8wjy30nqjezv+mjRkx7YiJaLigYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407300093
X-Proofpoint-ORIG-GUID: OJYaRgUGZn4aKiIcYDzu9uUVcC7lum3P
X-Proofpoint-GUID: OJYaRgUGZn4aKiIcYDzu9uUVcC7lum3P

On Mon, Jul 29, 2024 at 03:48:12PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When struct file_lease was split out from struct file_lock, the name of
> the file_lock slab cache was copied to the new slab cache for
> file_lease. This name conflict causes confusion in /proc/slabinfo and
> /sys/kernel/slab. In particular, it caused failures in drgn's test case
> for slab cache merging.
> 
> Link: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/tests/linux_kernel/helpers/test_slab.py#L81
> Fixes: c69ff4071935 ("filelock: split leases out of struct file_lock")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 9afb16e0683f..e45cad40f8b6 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2984,7 +2984,7 @@ static int __init filelock_init(void)
>  	filelock_cache = kmem_cache_create("file_lock_cache",
>  			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
>  
> -	filelease_cache = kmem_cache_create("file_lock_cache",
> +	filelease_cache = kmem_cache_create("file_lease_cache",
>  			sizeof(struct file_lease), 0, SLAB_PANIC, NULL);
>  
>  	for_each_possible_cpu(i) {
> -- 
> 2.45.2
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

