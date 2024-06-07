Return-Path: <linux-fsdevel+bounces-21227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4030900764
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6061F24F58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B01A2FC3;
	Fri,  7 Jun 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfbi/Vxp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HBOid5EW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE6199E84;
	Fri,  7 Jun 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771290; cv=fail; b=sQATWjcCM+U1WG+OqdPKbs7WA+VDJLzMQEj2hCMTmaaXUYehGJl9FYFPZ+Wnr3snKWl19t5o7mshhxWPVIZ2RBQquIAH8xJw2uBiOLIi6CMdX1QOibmZbVoRD+c7d/HnQkdH3WlwnthZproYIMMOPXmmJn4cskQsTs52LZnhkig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771290; c=relaxed/simple;
	bh=sdj41mIoQBGbQH4lyMYj4GyA8k17cWtCDhB5am6Wws8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2enZZoI/B89nns/BxwXQE7ptOYMJeg5/nIy8neBBHWgKifJBFaADQnyiSAe9NT5+Uxuf1R4KL4rAVwl1QkusE9Csla9CmAOvV43KdAfXpxpH7i867ybt1k9+C1TgE3/OAJ1aceVIhJsIa3mgrf1+2HOzDFd52GyxV7HjAfn0jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfbi/Vxp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HBOid5EW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CunSK021542;
	Fri, 7 Jun 2024 14:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Mv9/MzONQFwg8V3PMSvsdEWjHuYxsQ92HKHTVNH3vc0=;
 b=jfbi/VxpV/vV9npNWwVaL2xXDn6gjUeBPfTEQwE9UF7JDHQVUgYuFC3WZPCukHKUwp8e
 G1txeqqe5JmROMzsRW8Z24p7pA3RSPcYI0SlIGl/MGzlCh4ehCX9cNU0QeFZQlhSDc5T
 oDrltTsYNpl5G/2lJyd4fYncRegGrqCIxcuNusIevUstXhPjI5blhFFlLTJHQUfWTRLi
 ZXDO625gBpd3gINs1acAeO4AG6KnDsqkdoscTECoogSYGA9ikxFzHB58PFst8Zs3KLH3
 NEglKMwIuUFD5roZEms4cYHlaGy0Lcn6GctEh55qPdK4MtxPKd0KLYHQjjATHA9gt1CM Ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhdugk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:41:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457Dko1i015573;
	Fri, 7 Jun 2024 14:41:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjgqn8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/Kf/mp0XNX0RZA5i2Dbs9xomlUqrreY0gQyuZoXeukeo1EkJbga668auLsL8ElmUrcgeHK3IkCN89LeG0pMVWNFUKpFK+SsUka1RfW46l1wkrtpWRX1r9WbP50qPwQNI7QtypfclsmTsF3Hj0tEO3NZoEvZIgpa1+aag8Lse3kD0oa7z9cePQTGVVwBcPi5oXB/CzN4YKNl3iuOllf+1maubOSBrkvYfENXPut9B3Sx6aDUpvVWCeIvV49imhoyHBY07zLkPscfDbMcf9aENHsqogWeS/NbpRiHLbTAQWhOc7bKq2AqSv5I4oxWA9Ck2nNf38HKjzX8XKckJJY4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv9/MzONQFwg8V3PMSvsdEWjHuYxsQ92HKHTVNH3vc0=;
 b=CdMQE/NA5XyRLNjnQV1Cx808Kp6bnk5Xu1HlcA40pxtPggYp56yh6R7zO9zlyjX3uLFYR0Gd4sl4x+MaE++EB9LleYf9M2CmvAUdFPl0dhFIXN8O5XyGlQ00PvObyXbE5IgXYdEppPyiXaooyb4Zti2XDcGPg3oysrnxo+xolB6QzDIfx6zpS9tUtnZHfeMe9dFP77FZuOJRGXkJyqn/4wrTp2EDP0nnuJXK6zxHF+JDXccf0B1I+2AlNrNxaSB6caK4UXgPJzl5XbRlcqgUqLEKQoZ8BLSPMeqQA/wSlsrGmbeuubl+qPpX5I5x2AZP0iCaWr13Yhn2Vfcx5t5tQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv9/MzONQFwg8V3PMSvsdEWjHuYxsQ92HKHTVNH3vc0=;
 b=HBOid5EWhC3pf6CYZHSLcHK7FbuXjzurbLsFkNhV04KJ/zxV5d8XVawiEa9JtzAEPa4x2NqfAEXkXH43bLoOAaM75OfWzy0FLRg1GfS0MfNAgXfuPLxbfTBhZHSL/0vplPCpcrwSqZqlzVrwelB1dNtp/D4eiZKOsdc/QcbT9o4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 14:41:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:41:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 22/22] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Fri,  7 Jun 2024 14:39:19 +0000
Message-Id: <20240607143919.2622319-23-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0394.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9c9441-aaf0-4567-4731-08dc86ffd95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tLzA62p/94sBWNiXA43ijGRqcxbfxIyBww8bhwErLmBwcUehE9AzXJd9fxfh?=
 =?us-ascii?Q?1k044Zu68bG1tYsrR/PpxB3AhXWsN0o/w6zWQc6as3U6mzc3YXUZEEvGGQzK?=
 =?us-ascii?Q?irTVdeuAk1A0wj5vqaqkh+3Sq7vkZnMzUYSCfg50/S2eDPIK580lq+4I555o?=
 =?us-ascii?Q?BAtnxhwcisYN72jjT95RNoQ9ySXvGjs9+nRj8WgfSg+T22Etk8bXYJb/8Tgy?=
 =?us-ascii?Q?o2sfQlmApjtblYJ+LXX0Cy71jMWuNAtYRDALs43kvO4zRFdVcUy0UHTUuFJT?=
 =?us-ascii?Q?nBhxKgCFAVYrZkSmR4FXgkPasvxceHwwkSfm1wymigFRalprac7bP55Ta22K?=
 =?us-ascii?Q?qYJpAg18t8ww5ZJvxQ9cYSBx3L5YiKRVJ7vuWi9kngw38bntyWLif+0ygNTF?=
 =?us-ascii?Q?Q3KxdPcVpCQrh0FTitTkd1GZWFAHhSB5AlBre6vLCf6XPrJNOsv45rmbHTpe?=
 =?us-ascii?Q?VP6ZQEkFDPv2g3exkoCZP7xRAHH5Dcw6bnLtid+Lo55sevhDYPYOc0Pk+NMF?=
 =?us-ascii?Q?aizI7mct2yoxK6Ipgsfv30O+asdTV3b/TqKrZWjU0mAy1rzYshYcNFlCJOVz?=
 =?us-ascii?Q?9QegEspuAnPkr2PeQJezR1qoPyJEyio/XvdqMq2l1hAPvf9+UGXN4geOZTe3?=
 =?us-ascii?Q?m4zSFwAJPfSjkoYjK0sYtVmIbanWSl+F5jdzE0z2iLLXvS6yhwHuB91miemY?=
 =?us-ascii?Q?Cun1LIeAD5ls6STSGlYLQuFCRvC2ivfXlU+Mj7VbzzucY4HL6UHycQEbDk0B?=
 =?us-ascii?Q?UWCUMJnei5hrDzxJhSVgDbP31FRb9sGCM5xGfRFjP8ksd/mLxzEnAUQhJ5dW?=
 =?us-ascii?Q?fFnEazDgUTVgwSk114OgtLmd/VGjP3AY1Pj8kFjWQdF4Io76YA7f5OZTaF+Z?=
 =?us-ascii?Q?/J6/KX+vQIiba3aPF25j2sjGHjXYowyl9CxfdLP6uFesBgY8QNiOsS500nqd?=
 =?us-ascii?Q?uZKEQO4xrV6tQk1ZFInXBJKX1AClentexTuanJN3s2T11P1aO2R9h632hEMw?=
 =?us-ascii?Q?BMhWX45MqqfuWD6fQnAg/icIcEo7wrAGhVw89O3n3cIBCZ1qC7vobBqXfRTY?=
 =?us-ascii?Q?oYbCpluhu16L6YAu3SmwUnDszgomrPwxwnpEHHi6qM2QFN36ExWXOUPCZfw2?=
 =?us-ascii?Q?NxtZ09pJFHbgeSFCzaEnRIvOfnk9Au5AZqrLLC28ro72K1dScSMO21PhrKqS?=
 =?us-ascii?Q?u4de2GcxgmXtwukfIQEhd8c+JFMZxXyy+CWuxHZpRzG57AY8TKnTXSztpHP3?=
 =?us-ascii?Q?6tDsBNLZ5ZCqC6mQai2Ob6VbVjiibn+Vgv9NmIYgA/k8LigzwUSHQoYcwOvA?=
 =?us-ascii?Q?Iz1tW3/D7GJH8HLOaYf/+u7o?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A7+M19NB8IVfdMlmZo5czzp6K/qXALUfIN9gPsu1Vf5ua6smtXw6DZ+YluBD?=
 =?us-ascii?Q?jNjfq2EyyKESQdfTPUSbM0X43DTfWoara0xy98Q+wcgW44JgJ1EEKEBV6Puv?=
 =?us-ascii?Q?Y0/kxlwnFRekxHc8I/kMH3e15ZdE/RUpxvuQqa8Um88TMScoaVQKFmn+TPg1?=
 =?us-ascii?Q?w66x6U81R8ntRVwswcs6lNVq4e/qBfMFjnzMEPWC4bZ+hHtm5BIxr4JUBcbd?=
 =?us-ascii?Q?8iNJ7YiSade3yKEtfAPpVlOevPBiGvCE3osSWfa0s8LGt+bDDfLbkeA7tuPa?=
 =?us-ascii?Q?mtePEqcbSQjaoP0IqfEyJGykP7Anc/bOUZ4rK0ggZ0paeH4LlrdjlHD8i3xw?=
 =?us-ascii?Q?NeiDQKeNxjp7OQHZckbhzObjT9IDI9wNrMM0WJ4iRMrw9Y4h90COx/J9T6Zk?=
 =?us-ascii?Q?Zp/jRdPGOIitLgCLn4BPC18zEzZiYzeW0NtFCszjEGiWF1sJcQEUY16XfaOJ?=
 =?us-ascii?Q?pYfe+MjLevTP5BfLmTGEQIWmdhwxQOs6zv/MKOprXzxkQaBdHpMagpO45G1h?=
 =?us-ascii?Q?OP/5y7PlkjU15/aubqLZTKy39RKRvi30RaO5G/kCey1gcEHWIybnBFM9A+ik?=
 =?us-ascii?Q?r/BjaxMv4do5ciUfnIyJ/WeIva+f0bOQJK6Ju8EosCnN7PEHpIMLWntZepVT?=
 =?us-ascii?Q?igXS5idOG1u6UnWQhHND/jiElznHf1O3xgoT8RL8bfgOyDTWx/SZmQnguK5v?=
 =?us-ascii?Q?8jw2YDfEGs2eqvR/A/F7vIJpPGik195TaDZ52cAXbAohzwAlz9QlfOj0swAX?=
 =?us-ascii?Q?7Y89IDmZC+gWlNmneqKmrlrDdpEgefuj9RVquy5/CVa/ayQ8Jmh9ZYJCJfhq?=
 =?us-ascii?Q?PSE8b5E9eE9qJ3HcL5ZOwzZDwJwLKSs9G7KhAy5fOryc0L30skBjGlLuoSXi?=
 =?us-ascii?Q?1DfdOOuf7droPIEgZqYQM0iqDZdv7bPO4uOowPqInHUsfsYRWlAZQdfszcAs?=
 =?us-ascii?Q?Q1bIaIB1GZBvP9GLK/i517P4uIx1431voWsNq9wbBCR2Darfwwjtsk6IdxiE?=
 =?us-ascii?Q?5Lub59wpsLsD+sNKtvudTg142xdKiYYTvaQC+Gx4CormJFK5AqFZ+o6KX2vP?=
 =?us-ascii?Q?LjhWYXeptVi9M7n/r5ft2Y1io40PNrJfobIQ5Q7BBRUdb6MckYCyq1VyohSB?=
 =?us-ascii?Q?l1D3qPsAqzNkX5Dv30+ZrLgv5hKqGaDbcay8VBuo54XXYs4Mptcod1ebAYfq?=
 =?us-ascii?Q?Gy5HH1+JgJR8wH6nuWZ8aQjR90F8W7w0DNfW4fcuEdpBm0Tm0MYu4JTYGcVX?=
 =?us-ascii?Q?5ra+k7YfUf528/RXNp7wdHzcvRqD3EvHb/PpS4iYi0wbBPDMak9b1gaCl128?=
 =?us-ascii?Q?Uy/KFyE8DvRuVNMGfK3SbaQWUIRWPvsI7eBvlQSemonbP88vh/ROQoY2BACx?=
 =?us-ascii?Q?1rjqBfeFCwM8O+cwbU/vJrtmQcBlU+mz6efFX/K3NI/tNJbCcG5LBVIvr1dO?=
 =?us-ascii?Q?Otxh39yzJHKgMZ42onUiYqilZkyVDYLquF4q/lPIIIoE+HohtJkD7FP/HW1N?=
 =?us-ascii?Q?LgsDoV50s2nNRhPBiB41n82FmNytmi8Gg6zIjJpw6RjjP+zDZ0cuYaJ/kDXJ?=
 =?us-ascii?Q?f9yAHj2MLdeBg3j5YORH242Rdmu/QTSK4JUq2lVZeYE1IMaK8vnSnP9X1eFB?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XMJQe4eZmuMGu+LK/PYNYD5ikMqGMxpq4y8kF7FpnCgh6m8tT8vbT6HFYcbg5+VTl+5pnJh6Jw1M9VXgAlCcNZvMH7w4urrN1rr11GOUphZAherkM2HBABQXo6CYv5Tool300o48LzbO9kQ4w0/KuUQBAP1kdwTmLfaK8FAGQvYaos8jT7pdEdm8932VTL3lYWmkr+YTF4/iV90zvEJBTEJxoj607H2Cjfv3SVoT3Zg3Nx++rbEVtX/6WOp9NZu91Ab6MhAlKNg8CbBu0msIXtJ8fdWgDiNSuu0cg2T+8mgrSeQkZbbdZ0pwi9LSmBtwrw4spMHsKVlf8te43QxgETEbPyiuhSmEE7igUwEjpYNQD8ODKY1OeZqSLGgZmm4KTDS0jZlLPP+4N0rWH3YxfrgFCyZ71Ot/x0lQmeD8O28Z8UiKpSWseVjN/r8zr5hypGVRxHeWlRcbZ12UL41bEd4/GYe2enV8+iTJIIz2uX5ljrlJ98exknJP367zr+ArBlFqK04eWTYq7xVryMPdxw+52Iqc8lNUfnmVZodSaxT8AB4B4IzZGzHYKTzZi8hwZVgPPddObzehMT8IbLhcy5DjWPwq9hWMyCDX1sLycEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c9441-aaf0-4567-4731-08dc86ffd95e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:41:00.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KU90j3ttufSbEAWqDMOiOe2WdEDAtfRX2GgsSqveZzpCpxzB9tSyirsVXKKMckgj7mRUAf5SUfT2Qf7vjXcDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070108
X-Proofpoint-GUID: Ioz7OyBSiK1iIMNRgI8gcY-YFor100Ex
X-Proofpoint-ORIG-GUID: Ioz7OyBSiK1iIMNRgI8gcY-YFor100Ex

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag. Only direct IO is currently supported, so check for that also.

We rely on the block layer to reject atomic writes which exceed the bdev
request_queue limits, so don't bother checking any such thing here.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index eeb267ae2bf2..88ab743929fb 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1172,6 +1172,18 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+static bool xfs_file_open_can_atomicwrite(
+	struct inode		*inode,
+	struct file		*file)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (!(file->f_flags & O_DIRECT))
+		return false;
+
+	return xfs_inode_has_atomicwrites(ip);
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1180,6 +1192,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_file_open_can_atomicwrite(inode, file))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


