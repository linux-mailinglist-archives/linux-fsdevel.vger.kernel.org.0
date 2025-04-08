Return-Path: <linux-fsdevel+bounces-45961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284AEA7FCF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D33B37FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84626B2AF;
	Tue,  8 Apr 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LzUgKGbb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K3fRIdti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDE26AAA2;
	Tue,  8 Apr 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108992; cv=fail; b=cdyLYMAJFicQMRr6B5li/hHWraoEGyg21bzk4AM7wxIIl0bAA6YfwTbEMguRPy8VOyKHTF5u3AU1wLOOVw+llmBSaYF3ouLyJhIlfq2bZY5M/3+OZZrNKWCKSs6zMSOcofeUa6jobpRD/PHTqVrbfNus/gSuGa/AetJkvOyC16s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108992; c=relaxed/simple;
	bh=2jJkABhnrEyKbe0ozz7no348NBOtrP8EBFxVbQS5RRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e62UpB+Kiiv+2KnPQ7C1DWQvBvfc3AooqFPg4Cr4b6xSLb8+PzGUUxsNeexezZbIZhqOebyj7w0/Ke+bvJ4KoFdn0PElV0BEY3MoApQXO/6OJrVgb6U4LjTho0pPwWZwr/InmdBDUbsXQhpuZI56i8bKt9Sda3NorRYUt7mR9KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LzUgKGbb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K3fRIdti; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u5bh023227;
	Tue, 8 Apr 2025 10:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q1DtlbsLn4J5hJ4GnVTm7CnqZhuyDI2jzTVVRPjjn5o=; b=
	LzUgKGbb1yuQn64NNy3rx0zrGZpeGVVNV8yLcmigDkEu5tn227e4gAJHkPJA9aTg
	5XsM4luVhy7Hz4rR2as2b3abmeyuTJYVzd8SgodMQ8oc/PN6EdXuiGOCLrooPkMj
	V/XlDvoEjmua+R5GcVO+sUourx2QyNiYrcfggk69q7Q000mat6t06aIIgtR7O67A
	PwD24siTm53dgt1xPcUMFe6vswic8/l+FSla+jPJhzjB3up+GEJE+GA9punAVn4j
	EZLzjbf7e2M66n/k6RXvrXjl8Bdl/WJ1Cp1IyGGLFJG4j+GclsUgSzvw323mvdyd
	KbJR0DDIGS+NhyUJk5PuIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9vdn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389F4pw022201;
	Tue, 8 Apr 2025 10:42:51 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9twg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ+wQ/w7z9sze6SusaZE0I2PoT2S16Auk87ipm0uXR12rV4vBeNQgor88kdY15XCFW+r45rEkfTe5vQQGVAUB/Uif2zu37ZpSuAolKjTB8riSTm5kwcQhNBEEFNUY/fHglFGPp7ntFEZ+pB4cWq/iKu73RO5WWW5WlsWJVmK5r8H3KAVUAHC/jd9GMtcrhuCp+2iRheeeT6E3fAcEkUB3OlqbRi2QHYMhQfsKc6pghtjz5aEKlAetg2D3mUyZJvoQrGg8MPiuzFHadgIQl/wJieLI8wCokmbFbCQ3e5SpvuWjh20zVoK/vLitPliYkb3rMnmfBnvv0YFx3OiD60+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1DtlbsLn4J5hJ4GnVTm7CnqZhuyDI2jzTVVRPjjn5o=;
 b=ov9y7PWmNDaIGT6rtyPSNNb5lUFUROzJqfr0Kr1f8kz9qLlwqItlwlvJ1xHwKWCKBeT26+EjE8kRn4n342jZnQPJ8jVshcJg8TSWYzbbdwvzhjI6qqktIZADWTHO568aYLnc/e7O2xFaBD7Hka9xLPwi1VzzFF8abylqliIhhySzx/1W0npKxph+YI7VAxalYt4isBSvY0lRFFXsEfy/BAeC6C7Tuofi0JJO1qs35YHSZdBAlG77BuI4n0LGD5vwMcU/23VzPWnRNyB3/TjYdbHqgzxJSvjLQrYBiAD5FBVi5Jsw+QSffO5z1LMCLJoZJAd1rvlZgGnJPoJ7Z4Xe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1DtlbsLn4J5hJ4GnVTm7CnqZhuyDI2jzTVVRPjjn5o=;
 b=K3fRIdtihgahYSE8QK4OY6nAaRXEUJNdnH3qHvjJK68Kq4Rull9oO33WmVgk7T1YnDumO7GsjmAghtIiGUlmmgFWj+2KtQVkut0zX4ypxgJg6Ov7pbXEG1KFSarOShYtZE4JZYTVKlq9dJL4uyuvQhXQ33XwNbYVSsVGjYfOyLQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:49 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 08/12] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Tue,  8 Apr 2025 10:42:05 +0000
Message-Id: <20250408104209.1852036-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8a1313-3efb-4477-e9cb-08dd768a1af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VTwadgjP9tqmxlyYno06plEC7pjqneJZLsF9w5pdjTOmaE4GkKvYbc65Ruow?=
 =?us-ascii?Q?fsesbcON4rhnM90wvSNApKdWCBfmfKrL3Mc/p87/R5LAosFY/u1vNi1vqb4A?=
 =?us-ascii?Q?eMJQWVBTOMNHMk58SlCTN4GVAavnHdkoBNA8u0eu+vsNMo6cmo3dG9c50cRB?=
 =?us-ascii?Q?JNqMCXo752fC3+Jugzn8iFAlUJwKDKe4P89PCkKkfzRXvvismnx17AxwQlpK?=
 =?us-ascii?Q?8vsyQkEfXm4U3YdwLVPJCUGEDQH5J6aIVm/HwLrKzfmSbSZd/BfSvp59/Eqt?=
 =?us-ascii?Q?4M/Z/i98t50WTYdELjJoIomOqsPABkFZsGnZSfw3eSrepXgGRUheT3MhKYUo?=
 =?us-ascii?Q?3q+wWaemMPy2c6nn2t0jYpsvNkrKfaS/hm1bp3d3Fl5OMdsU9FSrPHdQnzEo?=
 =?us-ascii?Q?XyreS7N0H3r42mlEhH0kiUz30183zIXAqZkcPFrG0UzYS6yUptSNmJjT0QRn?=
 =?us-ascii?Q?riPCfM6ljdwPI6aiU4U3dZzZj6nHGXfqv0bGZys6hehH5QSB8brGzJIVWK0x?=
 =?us-ascii?Q?ca8cdMTQauZ4uNgpXOGdtU6g9+Mv+zSymrcwBacMnFSFPXyE7OHbPt8HHntj?=
 =?us-ascii?Q?AnEagI30aLbPepnovzMwmVKVyMJFcF3YIvJIlI1nOC+OoUqK0sQhEOoVcd34?=
 =?us-ascii?Q?1XUiIQ4uqrpQIUYOfZ3mp81MOVL7lR9kDCugQC5Lpn2hPbunTbMjTaGiUe+R?=
 =?us-ascii?Q?YO01Se3sMqzgUzZlizg2eRHK+cSo7ZVI65caU0gwjr0lIMSX/S58izIplgTo?=
 =?us-ascii?Q?YxAqKyReyRP80EBKF7dW4rD4E+71zK80I612BcVRzgKI8NqcDy7Mle9iVKjq?=
 =?us-ascii?Q?wrjkIdriwI3RuRtWoOwm/0ks0AFH6DzY0mYx+UO0mQ5rHC7qcWnSQYmqNu2i?=
 =?us-ascii?Q?mNEOGNjp7yZJFh3kEGlvUmaQteQBAqG2dcTUYT3Ss2kRmp0veMaDRYou/CbZ?=
 =?us-ascii?Q?p0/jg1/dcF8Bi1bwTLOpJCrcKafpDZ6tdKM57n0z9p29rZMSzZSg64y/u8uq?=
 =?us-ascii?Q?BayO6wNAFTn/CSwG0OOBFzIARJbYe55zzY2XvwR9tRdy4EXmqbLZLQ9LIpBV?=
 =?us-ascii?Q?B7NbOO2Yc5DmlVV+QytY0We0IqYuQiWyM+WvQtkFpBnR16ZWD1WGC9oFc1Qp?=
 =?us-ascii?Q?wlHrTQ9mo6HkXAoNkEu7lj9AjL1dAsxMeXmMDlHnQvrRCrz0l5K6D1TIe/wJ?=
 =?us-ascii?Q?pIQiUvfVuyEr5j35euJkT+gJp7i+SX667PFpuyAJoQ1XmTFBL9iXADei8aIW?=
 =?us-ascii?Q?fIPwG36JYqFem0kjrkY/gYifjUY5s2iwLzFAKcFmN6q3/DXlJhq/qN7XTVR3?=
 =?us-ascii?Q?A3xJrhq6BfvtQFwSpKxcsmRCfXn9cJ3mh6mI/JkNjxRbYgQvR8XIbv3a8di4?=
 =?us-ascii?Q?TwHmNy2cd1sJWgjqfgwIL65jubWw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZtHSy4p79SV4CJRkj7vh46t2LYLUsW+5Cvp6KPLzjj3Z/kfizoYtjNdHlEE?=
 =?us-ascii?Q?I5EZI0eiSj8ryJ+IXbQ3Md8G55xGZdSR3giGBNP1kOJ23CqXQmRfSjnGBK0S?=
 =?us-ascii?Q?1zZCdZpgcMf4an44zYLL4uv3U5h8UR6enLvBBGRCTb/Tl7+Gu8iMu4odfvk4?=
 =?us-ascii?Q?rrIxUkuAVwE9xIXctqqxIjwnrgwy5U6zLQIGLs/cPJ+MOcytVijT4TcaFjYk?=
 =?us-ascii?Q?+vjgY7s7ONyV6YNAh//0YZjcn9vUjh7qONkrL2oQ43ACF6Brq8U2ddMHH2Tf?=
 =?us-ascii?Q?+D34g8jXMzGETLHKXwK3awULS+WXm/iYx/Ef30tWgGt+R3APjiSCQlDK9+mv?=
 =?us-ascii?Q?LtMW4tEeR2SoDjiPi5DDXrYwdspTrzA9MjZGITRo4cAqNYZHCoZLXl2m2lCu?=
 =?us-ascii?Q?7gZLxriiM1WGJ8rHWqb5Oq1BXG7sGp1PFDnc5M1aaiaDL7xVGlPWxWKg7HjF?=
 =?us-ascii?Q?4fO3A4q8kOSKhT/BbYn/bkPJrpwTNRLgHGknScTjaCz7u1vmTAvrUdiky2C4?=
 =?us-ascii?Q?L+TWiB0WhwokRSAqV7QWzPNXxQfnhtUeSX6JHlh5/jA5/o8/ci6FQyCT3Xhm?=
 =?us-ascii?Q?SW3y9SCS3G4ZZ6iCug7xiuNJb0G2FRHNgG++7FrL5Roe3mLaZfT+qU0yB8XB?=
 =?us-ascii?Q?7F9GImagNu5+eiYK0olPcsXuMhQydk+EQblfWBGifBvJGlJC/xc28YvGkj30?=
 =?us-ascii?Q?Z8GUNcimv54KIQ2uiBS7fhWSosu6mXZvkrp4opH1L3MtuxsWzm5M9zZd2trF?=
 =?us-ascii?Q?iY22XxXXH4M1ZZzKsuqcGJp+Tn0/bX8ZgurKuuwfznbwniyDD1NuMbFTWPIp?=
 =?us-ascii?Q?6S3keabKpp8jVp8iItKd95pMPpFFokRffpyYqVogdsMuDCDlDZIqHlgEUVMJ?=
 =?us-ascii?Q?X6zdCtjBe9WpkmRYB4+/UuBBG/nanYy02i+5ZyAVtMB+zjDQpLHG8ctH9T46?=
 =?us-ascii?Q?E3Kjz8uVftCMXTZsFl1qjjm5mzU3JY89gH0wC9RdIp4RRg0UoSnxtE/WFprY?=
 =?us-ascii?Q?RLn77506955aK0MkC9WmddC4o+25DPhy5vwwESF/uySccU9qVKu/f6IcwV95?=
 =?us-ascii?Q?teBpOxbg2cv59yYrhlK92cBB7p20JvAKTX2s4BVS6xjQefIBpyblNDNw1bRE?=
 =?us-ascii?Q?B53hCGQeeysBRydHNnR8A7RT2n1YqhjL1JzjuqVV83LvLY2A8tAyOIS3mB4K?=
 =?us-ascii?Q?nTYl/qXesOQf/089RCdb9AaWrvYdWbHm82a8ZziP7O/FiNYmMiv5CIvkZ4bO?=
 =?us-ascii?Q?8UuzmccX/3HrRCRmLP60AsMTCu30hGwUw4ORw81Y1bDl23dutDmZRN5yAGDm?=
 =?us-ascii?Q?L4ZlazRHUY9hcZ2eWQg9V2ihQyrm+Jk84ePRcG1FVLxQYg7AtfxrN3znhP3U?=
 =?us-ascii?Q?debJtQL1u/wSiLqCH4Tt8C62RJentAtL7abEzrYWXTYpZNXMEnoCb87P68/C?=
 =?us-ascii?Q?zC0/h2dUTAmRJjnxOk6djkQsbtfAfBIF0/k9n+bgz5Z0HzMMWdp2zkl2olDi?=
 =?us-ascii?Q?XSg2ERJHw85d84j6LwsVCVhxYJH7DViRmrm8+nSIGsDMuTYaaaH/iODeTYz7?=
 =?us-ascii?Q?KeHympA54fARS4eTv7WORIR6N4cJN+4Ns3aOZsMnTyOTH7iaGB9bfkcO/RRL?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ybaMUS/xqgkikIA8HILhI04ZrhFzYjmsqM209R5GMepkl7QSMk/GfF+ur637KZPxCS6wa1PnBSQLUhfSQYmtlGGvwCZSR0CP60JE/TsEY9dKWz5djkoaPuMwjyRyl90QtTAJV+eXgP/s7iJZeZGG5yyMyMAx2Dz8dA7G9bqYVWOPxQh1oEC5dJp1pJjTzTBcF10+jig1am90vQNNNI2dRrZm4EIULPNy5uEHSpGkfib+XoCG7mFtjjzcCdx+QBKdifmjV4FZDEzFxdBw/207pZBNC83L4x59UWMPhmALfZMHmWBI6EGNM+J14T+R88kjiOs7paqP3cWylytcEmCuuf+XdNR9XPWarpe/cXEBtvGkaSrT3w6BVbJi9eHrZuAaoMLCTCtwnD0polHMpjA3XXjFG5M/lVFlOjFO+rDGBVz9FH0N28kuE2qBTgFUlb7DEsa8MmRtigOOHbXMD6/yrMuVEZcsCkycWktUMNt6CiTTMDOWWwsmBs5veHQaQ4nv9lx/mf2ElNb5jgQL1XeHxvIz2v9hQ+fK0ZjWpKHKWBmsw0mSYMVqMiLT2E4fg911khabu8BXn5eY8nZ7704Sj838ZhZudZalGf1SapRMROU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8a1313-3efb-4477-e9cb-08dd768a1af2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:48.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kabsoMEHZMnWY/YI/SesU/Tvjduft4dBnAO8Mr1hgPvdPkme629LOX+iys/oxrQBIXoh28vpoF7L0DDTNToFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: hGLV76rGzk7D5d7tU8a7eGi3PhZ1lbLR
X-Proofpoint-GUID: hGLV76rGzk7D5d7tU8a7eGi3PhZ1lbLR

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index fab5078bbf00..c6b5fb824f8b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,41 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	if (len > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +847,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +912,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


