Return-Path: <linux-fsdevel+bounces-18150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C68B60A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650F91C219B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498F12D20F;
	Mon, 29 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="At7cDpvn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UJAM1VrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284612A14F;
	Mon, 29 Apr 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413027; cv=fail; b=TNWnqIrz5kwiWBsixKrepk6geZbFaUj+cUQkSu+2k2pOg9nHwzUKHMI/Z7b0/l8l6m40GXPBWKOoD7imhwNJ27DcYJ6kd4FLXYcQFDDVPCWZHVr3XhAW5+IuearUS3kx61vz+vHW6lJldJ501I+iVt60qFYAMLcHaGlqnJTMo24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413027; c=relaxed/simple;
	bh=THmpiG7qab8wx2V6pk+Nl/MtKoX5p5zyVhzc/P+/5Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UkSNPOSJjPnbH3T3ZgBzNYI+7f3MlKxtMZTnpWZHl85oIJp31ym0wt5FV5l6zveReh98CQqxduWYL2ritZnUqA4f4/0Npv0QvYX6IwzPfc6qXwwd6g+AhNYW/6u6QKcN9/vtRuBYPKxZFci6QVOoBb60Bcix7Ukz0BsYweS3tvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=At7cDpvn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UJAM1VrY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmR8002385;
	Mon, 29 Apr 2024 17:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=WSmPREpIWWjXhzmRIzM6atxu6YFV6KtHYXMwIHpJ0aA=;
 b=At7cDpvnWl/3KJJDQJ7flv6g/9igxVL/sn+VVfpAkzvEb4M923x1KL0FVn/2AkoXEwRD
 98WCSgnyRvxC46gR+iXmSR67o9XFegy2wMrVIsBY+8igsyYJ+DrOCPQVV6WkX9qI35x5
 H4POfkKRYyWclobGP83vH9WiuG83om8hOAvSK4FRjCYz4mCBhOBy7wrWYlIANy9Hfldr
 B2iJU7sGJX6D/dSSt5Zq1hTwqyQqsduDvS7WWGgSv5cVbDBR+L3fWfBS7u2vz6hFInQX
 UKhwQcEFQbVWkAuaTiH46fND/c/vlZhRjx+bnEt7kXX6LMvTlsQsKwSaylRUKFa5dfo0 xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqseu6qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGRTcr016720;
	Mon, 29 Apr 2024 17:49:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blff9bH/tAYRxGtRaaBcWE7XmjUdwCx9Bp06BXJFeM+0Wx8rdnV9AhCEi/utvdhBcFIwhrFW6gekBQGsccG/xsQvalpA1ceXwKKiUqJGi4q2Zq9xxuuOlFf+fU21+tPrIqJfINehb3wr68Buh1C5Op5HXnvfU6JTkFoa2pHAXsqRjPToWzQZLDlikuGkyet8RX61WCNyqaM5gPgP+wJGHAw+V0AhgeCPtQAlP0558A2gAgARtKG5t3YUii3pG5S41QaCyGwVeVO+0y1RLWjLIP6wNIZgf+hm20WRpU5tifmQdQxeV144TCIZwItsiiYmJPDCQv73OskCJ1fzsdrsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSmPREpIWWjXhzmRIzM6atxu6YFV6KtHYXMwIHpJ0aA=;
 b=n6pvHp9ZGeY8v+RYfo7wq7QRl2IeCTGPX0/HbFhDwXZp5c3pgGfgHx+1t33nHnmI6h/WBpLT1LCM5u1A4ohp58lZJUw2U53cogPtB84CXhxokFFCtkK/dvLv5E4/kZK67ubQGmRppFRSo53ykaqbSGqdnGFFj0ewPiIb++y6QmwHZHrZCgx7p8A2q4PjRiHN8uw1Sr5BmK7zB0GhYpWu+Cr3P0oNkzc9U9PPPYgfYe9PBZQHIpuqq8R5KLSGw/PQ6b3nzgcfm+UV+CUTdGgNI/8opIXrnwW/gwYcuA44nZRNNAH84MytxU12Y+056HnQTt+TJrZcicNOSCFN2q2SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSmPREpIWWjXhzmRIzM6atxu6YFV6KtHYXMwIHpJ0aA=;
 b=UJAM1VrYPuCHw/jPZnomH2pTNopmMj8gW/XPsdEQg71NV5umuiBbH0Ljzpf9Zp76tXvVoqQnttcXrREuUn55XG6Ud/5dQyY7XMZuKByffA52G/ghUZrHBDFe140u0L8Xxg+ia4vGmlgSi4O1XIOy9eDnSepN4MFAWN2bBHdeeM0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/21] block atomic writes for XFS
Date: Mon, 29 Apr 2024 17:47:25 +0000
Message-Id: <20240429174746.2132161-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eb46c8-ff33-4959-3005-08dc687484aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GPqD1HZYmXfjkSAlba+64rGizeoDezYOWYvkoiV1kiqD3zlNC7fqI8aEjaj6?=
 =?us-ascii?Q?RkEDh+/fHHIYihD3u8dlX9wC4hRT5USfulFYa10rW51SUelF+KbnyZkH1KVM?=
 =?us-ascii?Q?mnFBV6m2z5wAh6Ph7xMzRj+2EB/Qya0Qxm8wXgz5LOSWbsYdA6FFszq6qWJ1?=
 =?us-ascii?Q?KG1jxZiwVEPEOypNSmx6XOtMxEBmU6fXOrWahASwwBa4SzSKpOjN9E25HFiE?=
 =?us-ascii?Q?XF/teF2YLjIyZ561nDdgSXdU5bMJEtKD/GZ/56K2Qu7LNaOBF7y8mqJl7mU2?=
 =?us-ascii?Q?lO/NOs+pljGCC61t+U2N8DojDp0kOmg59bEOuX4tscDTGZYFd/inaDc1mXf9?=
 =?us-ascii?Q?EzWBylRiNG7o/GPOfbWz+c19LsdxSNvpOhSoIgVsPr5Pp1eMbCZTXI7xfKJz?=
 =?us-ascii?Q?GfQ5Nlu0j3jm00w5Gwnni8rQEyoo3BimsnGYTACZjTvuvvZg6z4mvSoseLnI?=
 =?us-ascii?Q?BSMm7EdV2osVlyC8ehamSx2zBg6dPqUaS6gUDg4pZfj6RWb4iQLG8/tJriJ0?=
 =?us-ascii?Q?arExub0rXc+nkwblVHLWupGr81ulK+iZjq6ln6daCvqC3IKbWphy0DC1SMQ8?=
 =?us-ascii?Q?qABX0ZXn1FYgVdkyQi1XcDIhTma86+eNVH9TouFmyiwvYM7HAwfaQ4yKJ85I?=
 =?us-ascii?Q?evOeOR/lptfg/2sS+9rgNfUzGzH4BhnI0wWT0BMNEsRpso3msebm2KyyRyDc?=
 =?us-ascii?Q?YeCUX/fyBZoAgdl7iQUQcd3acNB4abmD5QLeSAUt/7Xn8CFLiefyGlT9yJeY?=
 =?us-ascii?Q?q8u3L9sXLbrQX8SjsxWG1mm3CwkxmyYwH23Qvn67v9yBNmuxr+uR4KNNbEKH?=
 =?us-ascii?Q?uHxkaFdKcmG+l4Gxugpd7ZmZIBBsIM5o4a9lXnlJvRen1Y4z28oA83MDRy2G?=
 =?us-ascii?Q?JLwfeCVpbV1W55151EPXIwtUAlI4BjuWY8HtozaRv1P+sazAIBdoGuhbiaF6?=
 =?us-ascii?Q?cKFF4/iRacIwbrzXFMROldwNNcBSDFyNA8VwngL91sJqfu6uj+J5PDAVRqwV?=
 =?us-ascii?Q?6rgGsjpunBSlrCi5tahMMkS+arr5RnOTGuK0Uc0ehgLMsHi9xSXSzwXa3+HI?=
 =?us-ascii?Q?VBAZwcnefrXE9Z8oL+zWI4+dM0yq48VLUFC7vCuNe3MBn4lDUw5lCj+Yl5K9?=
 =?us-ascii?Q?nR+wK4M048cVzRG9K6m8D+6V/oLV2MYqLnYYoBm8r+j58lRfpJQjYIkg9uYz?=
 =?us-ascii?Q?hu9iQA170QcQotP5uK6X3rHTN1fwMv5ywltT61f42bQLpRZA/BmN6CH6uvXV?=
 =?us-ascii?Q?Z6UEFlMSqg+V3z+14MnSLqcJzfxXP9aYYCwh5gIt069BVh2CAk7PYftZidw/?=
 =?us-ascii?Q?x5Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ad9InmtT3oJc2iuleuEzbJ3Or3NuzwZd1v0mwRsZwGgxmNaPst7oaE92tkKg?=
 =?us-ascii?Q?Co0NSuJ6pCQx17WPQl4prKTQmRO7XKvsjjPDuLMKfk+8FJbOhzkSGExM0LOO?=
 =?us-ascii?Q?TLri4Ly9zdmWi6Sbpa/1o88t9Md+9NhDZfUt82yup3QXloZdbPNrA+99gMqY?=
 =?us-ascii?Q?ym2yF0jc9hv0+G51cSj9xani8ZmDBtqdOb9Srn3NSyWJWLaOYuHph7Ob4ufI?=
 =?us-ascii?Q?YwlChU3oEweEamMqSrOGGofn+Y18Rh5L9iGEftmBZ4Xm1cGTss5+xhnSAEYZ?=
 =?us-ascii?Q?vo4l6DGyoXx6S02BRHY47fFO82b/bBzedtBDPGVrsthwnsaY97HP4/CZ4fot?=
 =?us-ascii?Q?DuxEqd838EVEH2LvOagicY97nsdk8Ui2aoL15/7Gg+AN7Y4yHAVCP/YYLzx0?=
 =?us-ascii?Q?5kmjUxzX4pXOjPpExhJMyhw1lkPsOqyWkT1ae3au53bkgUzTOtDWCSfQU2wD?=
 =?us-ascii?Q?5RAP62gFXpArEKHW00CCoJsjmH7/GE/kGqOysNLrgRxIfJJNsbTkMKmKE24a?=
 =?us-ascii?Q?5Y8/Ko6agmYyrkYzZhJh1iZTh8UeNTOEYXXZD5eyXP5DmMSeQ0tQEc1/Nqq+?=
 =?us-ascii?Q?nkp0hlCHF3EBzisRa+2OO6tWd2a+GAnxoJIFtqIMHptkQPGsIUx55bGsAdGN?=
 =?us-ascii?Q?p//7JY8sZM64Dv3XOzgg71cGzWMQFsJDxeWL7PuXoQfbwsfylhErAAft2aw4?=
 =?us-ascii?Q?LA8CZwzGVloUXr8lMnjH5NbewDKPLgdlNNOsa49RX8Jc1NzNye6k+rvh+8DI?=
 =?us-ascii?Q?3bztmOeGfv9Pmg1CB9hF5iaJ/Z5Z6PYSSQGiN50PTqqGCN6sUX4ILZS4tqey?=
 =?us-ascii?Q?NsMq2IlpWfyAfyXjInaUXLy7D+AxPVwq6rpXWjVf17FGgnn/wIKW4zq7dMsL?=
 =?us-ascii?Q?H4uvhSKVDsZGHe1AJqU53wad7tBV6H1fstVoATBGV+ikHFW+yOUKNDaVvHAY?=
 =?us-ascii?Q?QuXl8KTD0PAiYUJb3+XNicyN5EiQZ+Y3/sIDAAhBBk2W2BuXaPI0GenUJdOu?=
 =?us-ascii?Q?OJqWsk6wCnc/ClngTjFTSwh4NHlYMT69p1i4qmms2tqjdB60maQ/a3J2RkAI?=
 =?us-ascii?Q?/iGB1AxJ/bG8x0bzZGHBqghyyD+VzYg+R31qinrexmXNSLemjRZFln4jGucX?=
 =?us-ascii?Q?5gB3jj/wqLIhF9TG+JAHc8ykipbaCuIUrMoNeLWOf5x1uBALFNhbqoS3Sfy4?=
 =?us-ascii?Q?fPqcDzPYPmZbNq03lbGJ4SagIIFEOtKS8oTLOIFZiOyRaJB3rf3eDawFmw0U?=
 =?us-ascii?Q?V+WjZV04Y0xpCBpfPgEqKn2HVIqBxio6qZe2z9fI+ZbB8Ks0jo+V14c6oAPn?=
 =?us-ascii?Q?/C1iPN2h0CEUXKRYxvWMN/1+PP9zlkCRUfhKz0LcLqT5pF1JJTvg1MLKlYBJ?=
 =?us-ascii?Q?zAiTeJ+9jAlqG6jLOKiargBHTBBwKbL2Fx0z/jDtSTW0h4YZAOt+tkyl44ow?=
 =?us-ascii?Q?cYknWp3h3vfqtQKjud/7Nt0ridtQaX9Ur+Wfs0e7aqp9MeE529rXUNoitJwh?=
 =?us-ascii?Q?KjY+hJarj+51wRVkpdujMPK55JAG6Vquq6UdwYJZ+GMn67cSeVr8afx3Oc+f?=
 =?us-ascii?Q?bSkXOWHaig55+A3+svh2DBU+Y8FNUdtiwexOBMInMAqBx8Z5MIALGIu8kzrs?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ez34QsK1bUwiswsAuTkf18QisNWoxnz4ofiLcdiDuWKJtQY1QoyPEW3wQ6TV0Fp1KT6J+Imt7DuTBS6FDt0osG9uGItGbZdu4No7OAql6NjLlpVZBnz5Qi0NVWlRKb1IzPBVW0UNq0IoKTJPPo/ERC+o4g41X1MNeHmvyx6HSAgyZqKvmKncAR42CFeqr1iaQr44A67E1z22CJQOxU5SqZWOpVfaIm34rCwt7wajr9aB6hgGlJfASKwG5/AcXfMd5HKMsC6xSR80sCjhclWeSHbAoz5b3yu/RL6LYQQ8C+7x6U1YkokfUX+bNOhK9DF+7zbXBN+uTjyW+i99hatOJDGQZBla2N5H0zMFnOeaEtN/vxYHs7KpsldCRgITw57Vn+jr8XTYboMv04WhvYFigPbXeNAEmwO/aD489LhJ43UvMF2j6lGmG+oJstBo4p2ki07li1hTaseCyE+Dq56UcMRt0mIiLUV7+1awRWgQ0EbwvzfnvLTmt8JOg/bpB/PEaN7VZ3B6QtkvPR1VmE6ftbVzvzuw40Lg4L0Ahb/vpH8z7Aog+jpdM+viqq4+kTE9YvSUw3LYHPWDZbQqq0HesTOtrw8CFHOt2/FW0OzwTZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eb46c8-ff33-4959-3005-08dc687484aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:03.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXq0VXVQM22Cor5Rbjmv1TQUaSx5E0CEuJqonERLrVikaNJFTSvPlDr7Or61Evcrl752YOOiWavU5KHI805xTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: WX_HnO0UtyHgVlVj_Amcr4eK7hfM_A0A
X-Proofpoint-GUID: WX_HnO0UtyHgVlVj_Amcr4eK7hfM_A0A

This series expands atomic write support to filesystems, specifically
XFS. Extent alignment is based on new feature forcealign.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

XFS can be formatted for atomic writes as follows:
mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1  /dev/sda

atomic-writes=1 just enables atomic writes in the SB, but does not auto-
enable atomic writes for each file.

Support can be enabled through xfs_io command:
$xfs_io -c "lsattr -v" filename
[extsize, force-align]
$xfs_io -c "extsize" filename
[16384] filename
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[extsize, force-align, atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 4096
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

A couple of patches are marked as RFC, as I am anything but 100% confident
in them. Indeed, from testing, there is an issue that I get ENOSPC at what
appears to be a moderate FS usage, like ~60%, and spaceman is reporting
appropriately-sized free extents. I notice that when I disable any
fallocate punch calls in my testing, then this issue goes away.  More
details available upon request.

Stripe alignment testing for forcealign changes should be noted at
https://lore.kernel.org/linux-xfs/083f3d88-cd39-41ef-9ee1-cafe04a96cf9@oracle.com/

Baseline is following series (which is based on v6.9-rc1):
https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/forcealign_and_atomicwrites_for_v3_xfs_block_atomic_writes

Patches for this series can be found at:
https://github.com/johnpgarry/linux/commits/atomic-writes-v6.9-v6-fs-v3/

Changes since v2:
https://lore.kernel.org/linux-xfs/20240304130428.13026-1-john.g.garry@oracle.com/
- Incorporate forcealign patches from
  https://lore.kernel.org/linux-xfs/20240402233006.1210262-1-david@fromorbit.com/
- Put bdev awu min and max in buftarg
- Extra forcealign patches to deal with truncate and fallocate punch,
  insert, collapse
- Add generic_atomic_write_valid_size()
- Change iomap.extent_shift -> .extent_size

Changes since v1:
https://lore.kernel.org/linux-xfs/20240124142645.9334-1-john.g.garry@oracle.com/
- Add blk_validate_atomic_write_op_size() (Darrick suggested idea)
- Swap forcealign for rtvol support (Dave requested forcealign)
- Sub-extent DIO zeroing (Dave wanted rid of XFS_BMAPI_ZERO usage)
- Improve coding for XFS statx support (Darrick, Ojaswin)
- Improve conditions for setting FMODE_CAN_ATOMIC_WRITE (Darrick)
- Improve commit message for FS_XFLAG_ATOMICWRITES flag (Darrick)
- Validate atomic writes in xfs_file_dio_write()
- Drop IOMAP_ATOMIC

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  fs: xfs: align args->minlen for forced allocation alignment

John Garry (13):
  fs: Add generic_atomic_write_valid_size()
  xfs: Do not free EOF blocks for forcealign
  xfs: Update xfs_is_falloc_aligned() mask for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Only free full extents for forcealign
  iomap: Sub-extent zeroing
  fs: xfs: iomap: Sub-extent zeroing
  fs: Add FS_XFLAG_ATOMICWRITES flag
  iomap: Atomic write support
  xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 fs/iomap/direct-io.c          |  27 ++-
 fs/xfs/libxfs/xfs_alloc.c     |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h     |   3 +-
 fs/xfs/libxfs/xfs_bmap.c      | 302 ++++++++++++++++++----------------
 fs/xfs/libxfs/xfs_format.h    |  16 +-
 fs/xfs/libxfs/xfs_ialloc.c    |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c |  86 ++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |   3 +
 fs/xfs/libxfs/xfs_sb.c        |   4 +
 fs/xfs/xfs_bmap_util.c        |  14 +-
 fs/xfs/xfs_buf.c              |  15 +-
 fs/xfs/xfs_buf.h              |   4 +-
 fs/xfs/xfs_file.c             |  64 +++++--
 fs/xfs/xfs_inode.c            |  14 ++
 fs/xfs/xfs_inode.h            |  15 ++
 fs/xfs/xfs_ioctl.c            |  55 ++++++-
 fs/xfs/xfs_iomap.c            |  13 +-
 fs/xfs/xfs_iops.c             |  28 ++++
 fs/xfs/xfs_mount.h            |   4 +
 fs/xfs/xfs_super.c            |   8 +
 fs/xfs/xfs_trace.h            |   8 +-
 include/linux/fs.h            |  12 ++
 include/linux/iomap.h         |   1 +
 include/uapi/linux/fs.h       |   3 +
 24 files changed, 549 insertions(+), 195 deletions(-)

-- 
2.31.1


