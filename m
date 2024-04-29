Return-Path: <linux-fsdevel+bounces-18145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E78B6093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD0E1C21909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536312C461;
	Mon, 29 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7C65GK7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AwvBgWN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814112BE93;
	Mon, 29 Apr 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412986; cv=fail; b=PWipVrVQjjK3u7AUbFShzkE4bPF5r9wqP6XqnunhXStTS3OAaANf09Azky03xVXuEPVBgbhp1toymFWLLJ5fKsYRTkM8hKO7uSjOrC/lc0nDS5jM0dh+HqeObNuZn863MemGGiexRS0SzwcjbmlFHiFWmuSDo+gUejkXaHTw798=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412986; c=relaxed/simple;
	bh=87VaBi2mzOZ/LRfQ2M+vyZC8Fr4MLP2IC3Jnq3BTyg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IRtUc1zuS39FbSHVTg5/uVop9OrOW5y58ETrZAdnH98DUdu3hFv0r8Sre+hYenEvSx+yIuIPG59C24yuECdEArO0k/VKfAP5GuAvaeLOa6aYr3EP0AjHYIKas6vZ6+gQRPp8u4boQd3AqAbvxSJx/5dTRF682eOt2oIH1NLUzDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7C65GK7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AwvBgWN7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxZ3f008529;
	Mon, 29 Apr 2024 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=v8sKAym2FR1+PywaOrvdp8qefz7dyIVZOstdXk+Mx9g=;
 b=h7C65GK7AYz1crVqTi4snO1P4GedjvesCqht1Dfif7jm8nVQ1HOcWNGf/4XXgazaDgLI
 ktBi3sV57RaiS+5YTcrpdTIsgWOA+ruXCcrlH3cR6dc0+lg6iZx7orVMmfFEvVs6BHMl
 3S96QSemolxGkjc5+0sCJ1fxKYPAXcEu7U8jklllr/lxDcj6iMwusFXEK5K/vJ8q27Eu
 Nf0rNboP3qc+wVefcsT8OUP7U4OEQefJ9oVRaRyIAq6WyNxVs+voRHGgxR0Xe7uMlRJj
 jJ7XIBmNGFUi/uqp4r3VgBTfHHW6LldAwvdqjgusCx9nyrEPugL1jfuqKUz1S/GkF/8c WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ck8xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUQ004324;
	Mon, 29 Apr 2024 17:48:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mly8092TAgQj7gZ/820KdCnPCrL1gPLOhduHYA4sW8tqbR9c1I+04ljTZqIOR35c30Mlh9ydKD/EFLicQUOpSP+KsJJxV4O0ZeIMF1b24zMddd/o1z2wlwUuyH7+xYhffM9b+7BlG811+EEaNjzikT69rvVSxe3CL2EDXn2Su+Y00mQ6Fttne0c0CGfBySTeDYNqr7VmLV5Wjvdgfcdb47o0p7wHtnSad2jErGAwug4YVY8r+rUNmEgupkblq1wawLRCJ0s0IUS8QYjlBDZLS+JUEFw14hH2772Y6MF6sydZq7f+lAOrTFP+dDTFBSaLfr6/xcRTy3yn4mOwRr1wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8sKAym2FR1+PywaOrvdp8qefz7dyIVZOstdXk+Mx9g=;
 b=lyXW1jt0SPRICl8Pyrvn3opagInGGQhcM+0AZjXGkKuBhLrEaz/DS6B0g8DuTql3qLXswDDm/NoAlf3SRs/tMP3FGcpxI+U0WPqzarOz/gZ6ARkbYTkSj3OoooThWjlHEjlQrmlaK+G5oJOF7F+PbDsq79gj3ssIAomiggPPmmbQ7ZW0HnqJTWrR7Sy8wSvraXJCHrsSjY3L19peGm5Y0spo4tTFgq30BB1g8boe3ufD7o5L8kB9ajV6Hg5TJB6dlIx4eVWCzdDc/oGYJJzzVKX7OqsVJII7jb3GdSfkhG3fOoYKOI/NQobdmAY3MCriEetfmCT5dqAUau7pcMUPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8sKAym2FR1+PywaOrvdp8qefz7dyIVZOstdXk+Mx9g=;
 b=AwvBgWN7wlKM6Z0gyO/E5i790HkeorOBG0YFJLeeUqYz/Ey0Vk/FcXfyRDa8VGmY/0Ax3dxFENlJO/nbzQqNTCrGJspqd7nzhv5G3zkenzWEu+JpUVSdV96ASkCt5SVjlZWrXKL4yStTGQBSisjFROHeeHtVzvi+IZDL+Ow6W8I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/21] xfs: always tail align maxlen allocations
Date: Mon, 29 Apr 2024 17:47:28 +0000
Message-Id: <20240429174746.2132161-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4398b3-6973-4c29-1ade-08dc687488f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BZQiT9TCZqaoDkybxYdj9ZR9OqKAtoq+3TTKGB/H+hKEOqBeYLXMLZVkD338?=
 =?us-ascii?Q?wMUIwzOLssjFdh7NXCp26Qqe+2M54q060rnfyy5RWvIJRM9mN7mU1GbwNnxK?=
 =?us-ascii?Q?WNhXBFL/4q05pkcQLIMIsrIWXevkNS0cagK9JoyfVeK/4GqlbgKVeDIBMts/?=
 =?us-ascii?Q?peBHcT6rmoMY5ux1A8y47+ollbibVMgsp7nNDbJVxIaTIZbBv6hUEOs2ny8p?=
 =?us-ascii?Q?S3GklcS5VE4XSSFG4DiApxWEm9WCq3tpoALddq+PHhSLix+pTnd1C2L+Jy8/?=
 =?us-ascii?Q?RAzewjNwwmPrdhloh1TscUy6dN0miNyDobQ35I/CklTNp4JhlsgxhZqlSoK1?=
 =?us-ascii?Q?QyWbjB7eMy2FrTO3+ydUbbEu8DF2SKkqYiwm6VHP59kBIFz9/ruJLLB7i/bu?=
 =?us-ascii?Q?FO97FWWLplzBHeK2OC2lIccuvrmrGfV3yFUfhPTLQIlxsCinrDjB89Y/d5Z5?=
 =?us-ascii?Q?LVH/m3a2TNamTx5IBfSoKY/GFYOJsCaAurz+kYtp1iTWnoLJC/z8RSfpMHmI?=
 =?us-ascii?Q?SMFyJyEpd1J2wXKSi09l6jX7iNYwd0xlsbnBPylk0TNbVYT5MvJFyTSKxASd?=
 =?us-ascii?Q?cSksGBMgQqC7QZ0JMkEyVcI1zZ14lk9+MVJSW+SOAOyM92O9/KaIARxyqbKs?=
 =?us-ascii?Q?mLFm/bp7/ylEQlMFHLmvbEu5fV5QCZla1v9TsBWdKtOJWfIAXasDR4u4JJq9?=
 =?us-ascii?Q?wUu0QnaTGLJ9Re1J2cqKyJW7KSCjmZQpw0O1kao6lLT+PMr50G6slwcCwfuM?=
 =?us-ascii?Q?NNN64vV2LTO9MVN7z0fkQHkzBbeADHyJK3tfTnR97SoXSuTjhGKnZLfSnD8n?=
 =?us-ascii?Q?N1x4v1e/l6uYoY+PHZ5BscSpanbjwlr8Eg0x8WGFJw6fKHI0bBXNLJmyPC3S?=
 =?us-ascii?Q?z6eJfEMadSWcS3ZnRsBf3vfRw/sBk3sZ2mPZ8qjKDrc98v3j397D8vPy3DN6?=
 =?us-ascii?Q?1qlpUUKSyN+5qIQAdjHa3rauHPYGo2PXvF+pgzP+Hsrfn52H3+wJErYrVD6o?=
 =?us-ascii?Q?cVl9zaK7XENCWnlG4b58qG1H3dvlORCIAmmRuNEbgVU9ENejl0KXqLjEGXHF?=
 =?us-ascii?Q?kRAWlyHX1Ey9Ttc2c8YSK8BLLlX/PZ6zh5y5y4EhBFFy6wl3ykOJB27+CXwT?=
 =?us-ascii?Q?oxQ/bYIFXKJ4klN4qNzMQXxc4BJ/SfMmTcRe61L9vRjL6g9cf7L6WsLsTGZh?=
 =?us-ascii?Q?BzCJqxLe7j1OYG9hB1Crx5/4e0aBkYKnQc2Ssrn9M0/TH2uKzBgokJuchcSd?=
 =?us-ascii?Q?BqvB5xBhemOSUAVtb25FEq9n4/DZY+9UfyhftIaf9Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KGu8zpbk2ZZfckkC3ndY48sO66rrUfAu+sw/5XF61ZPUdpm7u/Z38jWHAb88?=
 =?us-ascii?Q?hcf5Lgb0xp4m+raPdjo/Y8b3InIrtLRw7IsJmD5Re7Bb+d6OdJiX52dx1k7k?=
 =?us-ascii?Q?9rEpdXp6bvea4TjsBUANBPdpDjPpCpjGGz5rrt3OJ3SpJJuTDWGC9F8VgFXH?=
 =?us-ascii?Q?RmM4naaAkMYQyhlk6F1GLcCC2iBX4KWQSnjvu+tSKDDp1uxClDp0a2aM67Xo?=
 =?us-ascii?Q?ZKE2KzPA0hDTEJ5qkiL6NTm8rrkqg53jqnIMKfRYjRSe5Wnh2b68or32mOgs?=
 =?us-ascii?Q?50T0Q438G4+RzH4ZryaV3tSE/bsMJWoZrVlMwsZIO7lej2feGseH/sglW6tA?=
 =?us-ascii?Q?1mPDg1GG6rM8LJfngRoN5cxuBkhT4zTnRHbHpOr3d7VkDlmAz7nWwhqazLv1?=
 =?us-ascii?Q?Z4ry1S5xGruJfP/ednSZnxH17C5DjGtsPeQA3Q25v8ErGvg1uOLgk3dXjG4w?=
 =?us-ascii?Q?LtR5Ty5zEwfiHTmdtVRxqLTrEkQCvN3+HO5eI4rb14yu+nOB8hN89cj1ajDw?=
 =?us-ascii?Q?GuFtNzZ1GIMPFDsMEfRh0d2jUYGbFfNJ1yPV56VJy0R3gwvgXAHxOOjhtUCw?=
 =?us-ascii?Q?XlJADuXxbT+fXC08FT4WIQBC1euc4QK3tAX1telY7jG+yEg59qOViyF3K1LW?=
 =?us-ascii?Q?TIg0jAXVZYTqm5YyHarvbpCVvO7PDcd3l2Aoctq6E0o8Mr/qUGJGArFJ1ekQ?=
 =?us-ascii?Q?XMpwXzSPLRkahRLZ8DVxm1We/+G4lnMyFmtOeciwqa4TNV+c856B0ktdIMv8?=
 =?us-ascii?Q?4vMlIJa50Ndv01LG4fgS+eZnaUYcRdxp+zmVw4GmucnOiTXHdofXNL+8g+Xf?=
 =?us-ascii?Q?irD1ziFiWSFwoWbeUvy1/NL4eqIby1cF2E408v0eBIQ9aIrzboqAjs5GS6TD?=
 =?us-ascii?Q?mveuRdkY4gMnt+6Xg8CBZStpVFxKadiqPFfGup4VQvxYgKw5BF1zjHcaJd0d?=
 =?us-ascii?Q?w011tRVhUYYqEpT1FQHnDrh0r0Vuhm1Q5iNW8Xy5v9bdpViqtFyPIeU2aBTL?=
 =?us-ascii?Q?Q4Gq/kRPi2QWb//PUtwhgg+o8KG+K+MeC5yxHHcbRWx+E8eAjCHXbXc86kx1?=
 =?us-ascii?Q?ZyX+jGTRCqmO6TGaoNabu315E4YwlwT9kDhUr/X//Jlvw3cFuBFKpoT44Vyx?=
 =?us-ascii?Q?y12mY7Ec8f93Z02NsZNp+i4eP4eN1ppKI1JIFihqmqbjYE6qy1opMAgFfB/S?=
 =?us-ascii?Q?TaGF+w5jghfUa+ch8ogMN+nw0GPtyE9k8ZCQX4u/FQ/8FIfFrPQyuYAwZTd5?=
 =?us-ascii?Q?/BlUQ7I2j61i7Fhq+aGPCAJI/rbUEkuCtXflNwwrBMtK2XeAh2Poma0moGN8?=
 =?us-ascii?Q?czW1bauUuDwyb2q9kowoaeDdU7dqCrxH+43xOeHzpxLfQB54zIvDGRM9kykv?=
 =?us-ascii?Q?qXaT61x3F/mx6OJUKN9OBq50bJEM7+hwn/gRy4RW55HvsqYf99tytFksq4/v?=
 =?us-ascii?Q?Gn/mt6hu5TDkqGocTf3hABPUqmd0Si+XdyqOKTsDhrQNq+LfFYgPFMzwpDGC?=
 =?us-ascii?Q?fgZXLFf5SHc7RwZhC2ntg9SfCNTCIGyQx/sxJKMAtWpgFdTrw88wVAi9Iv9D?=
 =?us-ascii?Q?bLla3Z/uULGUs/+vHx8MfvBwyqRlORgR2OQUrGyySPFCFpNPOG//1bZfAtL6?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k3RyW7BInsIqAiD4m3NC9ex6ziisKNUpQOw25w16mv9kT/t2qnhUDuFceMxgsAFYc4RpETy9mfGCfnovbGS7twA4PaF648xspYOz2nDrw4dzuSx0hyRW40ppdKmAcJOoWQHyjUMoP86dy/LG+JMrYNc9prp0Eyap+yOOJil6GBwqTXXrNXhbWFQJLoww1y4dgGp8C4veY+EYB99eihBG5/t8bsIhjJwCKz2O3WQCbvUGzfe1hHCPHP/5XeL/wYWHm6uEjxMlebbiKwLpZJPHabFPK3JO2HlwwYwjMykCrHAkulbeLpW9Rvj88T7TR6bp3S0JMXteI8LC3wRGVZMlgEk8pXepqv4HKM9Z6PCehDEtd1Hr24eLEzf3RGHUPBClugKxiuTzbc24xASgv/cN4fuX41tTIOeMfGVfl5lIfrF+qMqLNorRpy1LawnqUdRSp3ThC26Nc4xKaoS4gXaSOUi+Qr5vm8hppUtwD1hxjwqjA9ysP2ehXHh2qzXvoezyjWC3IAEGoFRZ+f5rEAIoyTHClFZgKe+e4zSlJ4GJJpCYNllpgWBkRg2c1EJ5XUhATZNvN4VxpHYvj0fvqVI0viZ3F7uT7reUUuqlJvsJKS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4398b3-6973-4c29-1ade-08dc687488f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:10.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYmB/HfyQH0NBE/dbd/Ont/ruCHGai6OPYjZuflaPXEVNS1f4kj626GSIMt/FI0olAa+zOkolmQTALC83yLuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: QOPvHHvD4lejHF6_XX_IolkHdF64Q2H9
X-Proofpoint-ORIG-GUID: QOPvHHvD4lejHF6_XX_IolkHdF64Q2H9

From: Dave Chinner <dchinner@redhat.com>

When we do a large allocation, the core free space allocation code
assumes that args->maxlen is aligned to args->prod/args->mod. hence
if we get a maximum sized extent allocated, it does not do tail
alignment of the extent.

However, this assumes that nothing modifies args->maxlen between the
original allocation context setup and trimming the selected free
space extent to size. This assumption has recently been found to be
invalid - xfs_alloc_space_available() modifies args->maxlen in low
space situations - and there may be more situations we haven't yet
found like this.

Force aligned allocation introduces the requirement that extents are
correctly tail aligned, resulting in this occasional latent
alignment failure to e reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 215265e0f68f..e21fd5c1f802 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -432,20 +432,18 @@ xfs_alloc_compute_diff(
  * Fix up the length, based on mod and prod.
  * len should be k * prod + mod for some k.
  * If len is too small it is returned unchanged.
- * If len hits maxlen it is left alone.
  */
-STATIC void
+static void
 xfs_alloc_fix_len(
-	xfs_alloc_arg_t	*args)		/* allocation argument structure */
+	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t	k;
-	xfs_extlen_t	rlen;
+	xfs_extlen_t		k;
+	xfs_extlen_t		rlen = args->len;
 
 	ASSERT(args->mod < args->prod);
-	rlen = args->len;
 	ASSERT(rlen >= args->minlen);
 	ASSERT(rlen <= args->maxlen);
-	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
+	if (args->prod <= 1 || rlen < args->mod ||
 	    (args->mod == 0 && rlen < args->prod))
 		return;
 	k = rlen % args->prod;
-- 
2.31.1


