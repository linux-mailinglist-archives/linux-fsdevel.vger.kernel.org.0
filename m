Return-Path: <linux-fsdevel+bounces-21230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF990077B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822611C238AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEF1AB50F;
	Fri,  7 Jun 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jvyh2i+i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVXPkTC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58311199E9E;
	Fri,  7 Jun 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771310; cv=fail; b=AO3geOMjhcgPO6IlpXLOT4Uo5qX8dP+wBcITDKlM7aYoIvhqORuQzSh9/g2+J+Sltz/4LG8JS0vc/cqWwG8YegImdgRWMcHT515jdVfmjS6ndx1F1T0/DspRSwfkDQye0vMrN9DxN8EYd2NZ47MFQcomGd1QkJDCGn4BgFvebwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771310; c=relaxed/simple;
	bh=aw9d4afd8lwuqDYD2x1U3Ri61kjDZBuk2RzVIu1WCag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVqq/sMfvvVuR7moVK71Zn+ddNTTml5aciUR7bG8aYb5NsRk7dglpFmj5JxAfgKQ8Zu4RPljG+1ol2+I8kt+D+sogv5dHrzYhOZ47U8SfPd6zvSWCZxVrcvlSNJMI779E+q6O6p2ySCRbnohDuJDLV0KY+KTcIThBsWkLgFR7+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jvyh2i+i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVXPkTC0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CurdS021572;
	Fri, 7 Jun 2024 14:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=2bBnIMTJZOgEyaz8lMBZrhqIN0h1912L5QOhkJKC2ek=;
 b=Jvyh2i+ibVZagT58/C7uNh8sXi5oxRkDKzt514tiCcxnGMF9soZ50VHzVD614O7JnqBv
 5pK0CP8MM7vD+L/YN/B/h0h24qByYL++I0QkMhI3POG8wBYgL2f7vB1OXmKxNmtndG6H
 TsYcmFW9ZK6fXU3eNme5+lX2MSrCsw1bVeejQwj7bU+qM3wSf153FfhvbBUh08DA2533
 kcNLBh69bM1bn7xWoQbNL0bW6khHvY9lgu3Ilm728KVh5/DkP+acl2YjS82ezU5kT7Ci
 CeGiuLPGGoZQLppDiqhNqhaaMeKe8y52C/W/ZprfHQtTC+6g89gUpn7rP/RaDfww2+ZF cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhdufh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457EClXa015806;
	Fri, 7 Jun 2024 14:40:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjgqm80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgOE03M1DIIKdZ7jS8wmuvRlB5LMqHzU5Qp2ZMp1Z+7ER5TpK21LkdpMmzxWiOT3iYTM/5Z2H9YXCHoto8Ru0Lp+6oezufZEnPTuMjCa6hGDczK4erWkleLRtgWkYNQF48WCrQupzLnR3jlv3cE2p6tDIkAu6CM7Mij1utuSyC4nLgcSlcVa2JfI7pCn9yLHkeOrRrbxqyqxlLLem1WbRhN4huwZdpTV30dARjoR+FBHMK748SZ/GZs3I/L/AIFAC95YypVswgk9qK1P3BOeN5q/Y5JoEb2l/v4i3rv+TBYvv9uTScVqLXN/wvS9HyXPYUe6vJojAPJIHP1/GNbkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bBnIMTJZOgEyaz8lMBZrhqIN0h1912L5QOhkJKC2ek=;
 b=gs8HBrknKw6aH4gKoYbqYgfLG+r9+L14LAtnvWr4o6kCtfoCVu/FgmoLqFZsaiUBXMkGrUVzXEfuOw5xCkQkmrXJSmEGpLLe8wLAftrCUerP3daKOz1cJQSZ76329cfiX4lhw7tbozkW3zP+4oJ6vNX9e60xIhHJUW3Gcv14q1g7LDrzqbImpJa3X3fgxN34/NRacaPpdzT+TZTZp9Wtl9YX7BIznyPnlq/Ihtz57nG1eVp6t+y4P9LNP/CzJYOeb5gVVDtWkTel99HYu9EXhYkmkcn+0M3kYYY+GtBOwDd+BLTjG/++fqWfEciiBcGI42K7u/rYnv9ZM9OwaOw6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bBnIMTJZOgEyaz8lMBZrhqIN0h1912L5QOhkJKC2ek=;
 b=IVXPkTC0jRyDE1ISB3hfmsk7Z9LEKh/ecERjmEmQEUHnMYkU/O6do9P2G0KrWOy7cplu/TpiiR18iDBVe4Czj0JYR5KRWkrKQ0AtTkZIagq2Jvily/bf67unjU/2AI2HucpTWBSs41f/XhjjZkfUxWJCYYH9xs5IASDWMAhutpc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:40:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:08 +0000
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
Subject: [PATCH v4 06/22] xfs: simplify extent allocation alignment
Date: Fri,  7 Jun 2024 14:39:03 +0000
Message-Id: <20240607143919.2622319-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 56afbaff-5673-492b-39ec-08dc86ffba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ktaWuM2ky5JK+2JB4IXRUoMkb7KlNFXOGRstHUHFOPkXnjIT4ZKWs/o0VnGn?=
 =?us-ascii?Q?F3i0lpFxp7a8I7TwQd7kweyA03Ww8hbmIcvxeUtgDnafaj/OZ00v2kAVtFQD?=
 =?us-ascii?Q?rzVr57d5dOQtiFwlUB6JShzSBz9cBkxHVrFx4zQQuujMeWwC2txHIZvL/tLz?=
 =?us-ascii?Q?rKS9UH7/awC/ZibCTSn/xwsm7Awrwig0ipyLeDP1M7p1G/QPM+reVRpS8DMH?=
 =?us-ascii?Q?lhayKJ+CET71Pvssl6f6HOf5pCA9hxVpYrHhB/YvG++2k9vNxernjhVvqMhp?=
 =?us-ascii?Q?a36hsgvIA75DTb95jofbK9Nd/qSICbvTCmCGHR9usKUpGi1DG5xRcKie84+F?=
 =?us-ascii?Q?/jTUQDTmtVYbibdkyaxkspvwor4B4KNQjvwqKQslM/H5+uBvJMouKUDWLg6l?=
 =?us-ascii?Q?OEGTc8qxdUzCockVCpeo3/lnFISiGTiTxE3fZw3oZjiGfHCNhzP3PvPwTb2c?=
 =?us-ascii?Q?ox+dKBt5g0tWnwlVqcyFVwTVxVdT3ryI+kf6Vrb/WqSORHNEHkvZU2yTZ+ow?=
 =?us-ascii?Q?9BqPSv+E6Py0BJuLmJ28I1kFzNX+ry1lanY8Oz7DJ4pqa0tzppn3OJK8Hft3?=
 =?us-ascii?Q?9gKt2VCh1/gRQ8aDvMVryFhFZiuTMekZ0sLwAvWrLrEr6aVC09ezmNO1/I3J?=
 =?us-ascii?Q?9sh9AC+JL+Mh4VTXZXyQ2iNn1C3LSYVmBqWXlsshENkxRnM4pIaJy5+deOYl?=
 =?us-ascii?Q?iqj5AewBLYu3Gm4buSOqlO2SQ/y3bBdK70ylAxCYBB2GvCfK2FO279VkJ9AY?=
 =?us-ascii?Q?gZ7f5Vvd2D7+YXF9PUffVtYXc6F8ljXQtetF42JrOavPU+Plt9hw8709ztal?=
 =?us-ascii?Q?N+C+2Y8MMHN7rx4iy9jCR0ZZYvoWtK7AZVN6rWoJrinmUTFBYeIjrXcLY6Or?=
 =?us-ascii?Q?AGs+zHRj3Oq2j4sApAUWjwV73KbJxH00Cae6eDQFYnZhxVoHR7XFmYeinjV1?=
 =?us-ascii?Q?JmrHZFm16LhDheti+lWycb8wHF/2/b8mcxSgRDeVb73sYMAVZFpypseXsCTZ?=
 =?us-ascii?Q?80SGgbTBiaH04qQ+6Va1nAVAN/PfYUwsITNgXhajih94URhWcOmthq1KQrg9?=
 =?us-ascii?Q?7DR+R3sTPDkjG3rhxWrDt971AFUQO+dYiVT/qfR4xwJtZeb66bwdpp6I1wzU?=
 =?us-ascii?Q?8IdyqTWetu67ncWAiYSU8S2wukknNdHM2KPMksP+F+2812xkWVKcEt3Ro7Bw?=
 =?us-ascii?Q?MUoDGwXxemrZhr0/X32ATJB2xYcGVA9QtF+c4gUGzr88D7FSj7AlQ79i9R/D?=
 =?us-ascii?Q?S2NITQd+2dN92hfC+vcwgmU8oXdeL/GcZfYCN7QafCW3jXVw23jWhFQgDLut?=
 =?us-ascii?Q?dZItqkJ4Y3PD/yVmsWMSfVVr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NH2ih1yoCQCcSTDBX5BoOhEkG4LtZdv3/W3ObWzhrSXgFTBdxRs83/SNx5Lz?=
 =?us-ascii?Q?hxRSfHxBryNwqpq7Dh7VmxwwdJsUeocDpKSjlC9NQUUNkTcK3dD+JZKeYKEK?=
 =?us-ascii?Q?ymD3kEzGXnBgkClFOW04P2NBrpjb0B9xkJsQUShzxEQuR4h8Gr840+BWgTiY?=
 =?us-ascii?Q?shZT129zZOZ9mPyBSpeqLuBgS1EUxxLlBNZyab8QLVA1mN+WbVs61H2fkH/3?=
 =?us-ascii?Q?OES3VeQ2Q+TUAmVrNs8nXOZHBsczbRw135H9IP2bdmyLI3dwkF1TgBNSLTfk?=
 =?us-ascii?Q?j9ffnRQp9Nv4mSlADNNvJI+ZULzBua1CRqsmOKIk7664cHta5DLn/HpPr5bK?=
 =?us-ascii?Q?t5r21L0PV6cOIlBWSs99KM69Z4xDSe22Rvlf8xSZzAg7B93XeNJcLnk1P77y?=
 =?us-ascii?Q?b1d7E1IIWIznxgS1QQqGdkO+IU0wYABBJ43YONufP+la1IqDPd5fe88Yo9ic?=
 =?us-ascii?Q?7vPodmJM04lwJ+/QQLqwQ4jDKE1BeCA7eKAl8wlvsAO9dzrUnyvUG9XuC+Ei?=
 =?us-ascii?Q?suWkj9w6pc5DP43vXZsIFBeo7H45wz1snOruKlDvfqJVAj+Nv50gAwXAWC0P?=
 =?us-ascii?Q?qDhi+cmrATtQY5lPyioow17htiERkEoTVnzZLWoODD9NHsHi6KqN6CHu83Yz?=
 =?us-ascii?Q?Jsf7Ss2vxwQJOqxt8FvkhxRKviKBh7YoQmrlAAF+QAfGA7xTm9rlcTA2OwJt?=
 =?us-ascii?Q?NMoI2bysEUqt4pNtHI82lVxIKYk1swIiuX7F+QEUuAoq3JZW5YcxvVOTIYld?=
 =?us-ascii?Q?1pauzlDMnMEE+tPeDaNxDRdpitD8xm+a75BjW2UA8opIC0SHY6TfeK2YS597?=
 =?us-ascii?Q?A1/iLGDlABaYulYzxXDcGXwmtFBBbkDgqCAuBumNF87MFAVA1lvIoK2A/RVY?=
 =?us-ascii?Q?GujTA+pFmRhldhf/9QMFU30G1g1u1vqpHqi+1IyugP3Rf73mp1JkshkiIMHi?=
 =?us-ascii?Q?FK9ZLedU4as3nz+5ysj8UABBzkOt9zbDkQQ1JSzmc90NY3Gbg/pUi29pjM6h?=
 =?us-ascii?Q?7uqXX+iK//VJvomjUUSmNMQ9xQYvqpCFiGzdDU8sQmy3x+0V0ZjclktBZ3s3?=
 =?us-ascii?Q?nTyx98JgyUcS6P1vOk/AoXMf5KlgtRNeuqro58pi61lOgFOqbeBU2aWvtIgm?=
 =?us-ascii?Q?V1sGlfd32AbVvGMPcy/sOjFC2PPdJfh9O6p1ORLhkvOXzuwrUArYkHz4w+hu?=
 =?us-ascii?Q?MHcma9EWb0fNlMbQsI1e4kG/CbQwezLWiJQtLFrvjBE468/OQ0ab0/nkOjkm?=
 =?us-ascii?Q?whSf44AEXuBl0IEccIhUu7ZITTtJf9LPaiO9t5mbMFxrl3VgIH2uLmWS7JIg?=
 =?us-ascii?Q?BoyUM7UYayYJeW7yviVWoM5F+mtob333fuHw0CzW8l5xkdqTvfFgoUH8Muko?=
 =?us-ascii?Q?0hwwy5iZIlvTMF8612YikEaeHvW57G70N4MU6Hk4GT996nWzTdi7R9ex59Kk?=
 =?us-ascii?Q?MqZKFomSy1wa1rGyV7ETC4svan3d3T8Xu2uxpZVrdtd4nA8Gv/i/tXJT/7KJ?=
 =?us-ascii?Q?1lAbYhkrf0na+sKk4YdFf6bQybnK9jzfdSy3Ns81rjYHH3uN7lIT/CRKISVt?=
 =?us-ascii?Q?/DRnlGsTL1t9421xU1dQ0s2mLM14Z29TIkT1ti28CkS6vjrANOLUadNmvNMU?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L50sBHpho0wZsLxJKDsA1kOGRMOKXDCle1KJfoRXTUYFsJTbVAltUcxcd9F/aM44oVulEaaESNiTgoryKET8Bm5po5nsMKTLx/4Y1bYN22sBrPO5Ut7WMPkClB4Y+qqCiTiRlAEDLHwSrudIsvUpUktq7Ug+kPSbD8L8eaSl+Ec8ZMUERVy/ZwtYb2c6+PaRTSN/5g3pBY6csHqagHsOdJWpaDnyXiEg+sqFjjks90Fn34nA6Uly/HFhMfr5Zk9Skp80XDxo7h3DXHg7iEinnXfCbaZ3pyS4eNgJriaQkIL80tN4Xdwp4k8CNq1jtRpDfQyeGY5XK6hT5anMfZQXpL+YaxtWudRKMC/mMTRAUzCSE6l097TL8uEm1IJeKxOx2RW3k0Z/IG+laAnyxfZVfrqAvfZJCoBol3t9Rw/w0S8YEqq3+z4BfsKfrsNvuGxDEwYc69F1kje+p5IetjhL0k7OiKtfZWQXtnxGwuT5P0CjGrFhyhpvn9nCbEL1FFMQrG/0Dmik9UOzE6FbYgor12CCCGsFQtO1duJgMXqBsMXY3kM0i0tocMy6JCre+SMl/nm3J91no560zM6NwqCWFRyAOdrbL/CgFEsOTFBAS1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56afbaff-5673-492b-39ec-08dc86ffba46
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:08.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxzIOHIPASjqyiVf6ZcZ7qabS0FPi+T6earj5zDFZwyl/xSKGZK/TE6/K+neescqU6MhCUX+JXvZF9dB21q6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070108
X-Proofpoint-GUID: svGL-qEYkZjh3jrpwGjasuCLoVHyrWLs
X-Proofpoint-ORIG-GUID: svGL-qEYkZjh3jrpwGjasuCLoVHyrWLs

From: Dave Chinner <dchinner@redhat.com>

We currently align extent allocation to stripe unit or stripe width.
That is specified by an external parameter to the allocation code,
which then manipulates the xfs_alloc_args alignment configuration in
interesting ways.

The args->alignment field specifies extent start alignment, but
because we may be attempting non-aligned allocation first there are
also slop variables that allow for those allocation attempts to
account for aligned allocation if they fail.

This gets much more complex as we introduce forced allocation
alignment, where extent size hints are used to generate the extent
start alignment. extent size hints currently only affect extent
lengths (via args->prod and args->mod) and so with this change we
will have two different start alignment conditions.

Avoid this complexity by always using args->alignment to indicate
extent start alignment, and always using args->prod/mod to indicate
extent length adjustment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 96 +++++++++++++++++---------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 54 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 32f72217c126..35fbd6b19682 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2391,7 +2391,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2420,7 +2420,7 @@ xfs_alloc_space_available(
 	 * allocation as we know that will definitely succeed and match the
 	 * callers alignment constraints.
 	 */
-	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
 	if (longest < alloc_len) {
 		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 0b956f8b9d5a..aa2c103d98f0 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -46,7 +46,7 @@ typedef struct xfs_alloc_arg {
 	xfs_extlen_t	minleft;	/* min blocks must be left after us */
 	xfs_extlen_t	total;		/* total blocks needed in xaction */
 	xfs_extlen_t	alignment;	/* align answer to multiple of this */
-	xfs_extlen_t	minalignslop;	/* slop for minlen+alignment calcs */
+	xfs_extlen_t	alignslop;	/* slop for alignment calcs */
 	xfs_agblock_t	min_agbno;	/* set an agbno range for NEAR allocs */
 	xfs_agblock_t	max_agbno;	/* ... */
 	xfs_extlen_t	len;		/* output: actual size of extent */
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index c101cf266bc4..7f8c8e4dd244 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3285,6 +3285,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3300,6 +3304,7 @@ xfs_bmap_select_minlen(
 	if (blen < args->maxlen)
 		return blen;
 	return args->maxlen;
+
 }
 
 static int
@@ -3393,35 +3398,43 @@ xfs_bmap_alloc_account(
 	xfs_trans_mod_dquot_byino(ap->tp, ap->ip, fld, ap->length);
 }
 
-static int
+/*
+ * Calculate the extent start alignment and the extent length adjustments that
+ * constrain this allocation.
+ *
+ * Extent start alignment is currently determined by stripe configuration and is
+ * carried in args->alignment, whilst extent length adjustment is determined by
+ * extent size hints and is carried by args->prod and args->mod.
+ *
+ * Low level allocation code is free to either ignore or override these values
+ * as required.
+ */
+static void
 xfs_bmap_compute_alignments(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
-	int			stripe_align = 0;
 
 	/* stripe alignment for allocation is determined by mount parameters */
 	if (mp->m_swidth && xfs_has_swalloc(mp))
-		stripe_align = mp->m_swidth;
+		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
-		stripe_align = mp->m_dalign;
+		args->alignment = mp->m_dalign;
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
 					&ap->length))
 			ASSERT(0);
 		ASSERT(ap->length);
-	}
 
-	/* apply extent size hints if obtained earlier */
-	if (align) {
 		args->prod = align;
 		div_u64_rem(ap->offset, args->prod, &args->mod);
 		if (args->mod)
@@ -3436,7 +3449,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3508,7 +3520,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3548,7 +3560,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3562,23 +3573,15 @@ xfs_bmap_btalloc_at_eof(
 	 * allocation.
 	 */
 	if (ap->offset) {
-		xfs_extlen_t	nextminlen = 0;
+		xfs_extlen_t	alignment = args->alignment;
 
 		/*
-		 * Compute the minlen+alignment for the next case.  Set slop so
-		 * that the value of minlen+alignment+slop doesn't go up between
-		 * the calls.
+		 * Compute the alignment slop for the fallback path so we ensure
+		 * we account for the potential alignemnt space required by the
+		 * fallback paths before we modify the AGF and AGFL here.
 		 */
 		args->alignment = 1;
-		if (blen > stripe_align && blen <= args->maxlen)
-			nextminlen = blen - stripe_align;
-		else
-			nextminlen = args->minlen;
-		if (nextminlen + stripe_align > args->minlen + 1)
-			args->minalignslop = nextminlen + stripe_align -
-					args->minlen - 1;
-		else
-			args->minalignslop = 0;
+		args->alignslop = alignment - args->alignment;
 
 		if (!caller_pag)
 			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
@@ -3596,19 +3599,8 @@ xfs_bmap_btalloc_at_eof(
 		 * Exact allocation failed. Reset to try an aligned allocation
 		 * according to the original allocation specification.
 		 */
-		args->alignment = stripe_align;
-		args->minlen = nextminlen;
-		args->minalignslop = 0;
-	} else {
-		/*
-		 * Adjust minlen to try and preserve alignment if we
-		 * can't guarantee an aligned maxlen extent.
-		 */
-		args->alignment = stripe_align;
-		if (blen > args->alignment &&
-		    blen <= args->maxlen + args->alignment)
-			args->minlen = blen - args->alignment;
-		args->minalignslop = 0;
+		args->alignment = alignment;
+		args->alignslop = 0;
 	}
 
 	if (ag_only) {
@@ -3626,9 +3618,8 @@ xfs_bmap_btalloc_at_eof(
 		return 0;
 
 	/*
-	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * Aligned allocation failed, so all fallback paths from here drop the
+	 * start alignment requirement as we know it will not succeed.
 	 */
 	args->alignment = 1;
 	return 0;
@@ -3636,7 +3627,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3653,6 +3646,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3672,13 +3666,11 @@ xfs_bmap_btalloc_low_space(
 static int
 xfs_bmap_btalloc_filestreams(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
-
 	error = xfs_filestream_select_ag(ap, args, &blen);
 	if (error)
 		return error;
@@ -3697,8 +3689,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3722,8 +3713,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3747,8 +3737,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3775,27 +3764,26 @@ xfs_bmap_btalloc(
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
 		.alignment	= 1,
-		.minalignslop	= 0,
+		.alignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
 	xfs_extlen_t		orig_length;
 	int			error;
-	int			stripe_align;
 
 	ASSERT(ap->length);
 	orig_offset = ap->offset;
 	orig_length = ap->length;
 
-	stripe_align = xfs_bmap_compute_alignments(ap, &args);
+	xfs_bmap_compute_alignments(ap, &args);
 
 	/* Trim the allocation back to the maximum an AG can fit. */
 	args.maxlen = min(ap->length, mp->m_ag_max_usable);
 
 	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
 	    xfs_inode_is_filestream(ap->ip))
-		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_filestreams(ap, &args);
 	else
-		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_best_length(ap, &args);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 14c81f227c5b..9f71a9a3a65e 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -758,12 +758,12 @@ xfs_ialloc_ag_alloc(
 		 *
 		 * For an exact allocation, alignment must be 1,
 		 * however we need to take cluster alignment into account when
-		 * fixing up the freelist. Use the minalignslop field to
-		 * indicate that extra blocks might be required for alignment,
-		 * but not to use them in the actual exact allocation.
+		 * fixing up the freelist. Use the alignslop field to indicate
+		 * that extra blocks might be required for alignment, but not
+		 * to use them in the actual exact allocation.
 		 */
 		args.alignment = 1;
-		args.minalignslop = igeo->cluster_align - 1;
+		args.alignslop = igeo->cluster_align - 1;
 
 		/* Allow space for the inode btree to split. */
 		args.minleft = igeo->inobt_maxlevels;
@@ -783,7 +783,7 @@ xfs_ialloc_ag_alloc(
 		 * on, so reset minalignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
-		args.minalignslop = 0;
+		args.alignslop = 0;
 	}
 
 	if (unlikely(args.fsbno == NULLFSBLOCK)) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 25ff6fe1eb6c..0b2a2a1379bd 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1808,7 +1808,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1827,7 +1827,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1836,7 +1836,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1849,7 +1849,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		  __entry->minleft,
 		  __entry->total,
 		  __entry->alignment,
-		  __entry->minalignslop,
+		  __entry->alignslop,
 		  __entry->len,
 		  __entry->wasdel,
 		  __entry->wasfromfl,
-- 
2.31.1


