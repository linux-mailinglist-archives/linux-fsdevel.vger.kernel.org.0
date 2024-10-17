Return-Path: <linux-fsdevel+bounces-32264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757709A2F33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36E0B23E36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432A229112;
	Thu, 17 Oct 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CG9C5cH6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fFm3Oy3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113618133F;
	Thu, 17 Oct 2024 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199193; cv=fail; b=OnxVeCutvYyTRbhnLC696+LtynaUCJnXfckN9RkHtoebr7Yox3IheRyJrxLTa7kfVQ3LflU9b9O0aZaWUjunbGSDCBCG8n6g85zDseHBkndVyIN/639G3iczt9CKNMHY91uKgsC/56AODWfuRxPmgEf/wPKB9qloXtK26cEE0j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199193; c=relaxed/simple;
	bh=hXmMMNpmf/qy5cpWkXBmgSQQpskjdnOVdDUB1byuDs4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qfp068oVw19mvRwWTr+AZZsAial7VY8f0+G3D3o20ArvSq+56DEcgozh+SAIc2RzlSb6GKzvYY9L9vFT8j3IXFQnVO1YgALMijy2dltNMGZ/J+pamQYM18wh099uVteHQP1+z/IVW3FX+A1/65/xsalNeK0saK0/7lWXFe80ZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CG9C5cH6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fFm3Oy3h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtmEI006176;
	Thu, 17 Oct 2024 21:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=NgH20b0nzGzn+JEP
	6Wmh3EBcM6LRnAosz15/3YSNlfw=; b=CG9C5cH6SGu30VE8tiGDEIh44b2BFbMG
	ylVc38ddogvWXRBo4LEcqqfUx+NNmbMcapQIvOWSuDfhrToRp0jo+l+1iC7uJc79
	a9VKCkZ3W7s23jUkvMnt8Zjb/H+ycQLQs9HvY2Dz0CHqPfSei6ROthtO7c/mVQML
	X0gnilW0ixsVmQrdKI4+mM5rScHBGfahipKNhUfh6AmJSGMuUN0kDLL2MXLkiuhl
	X0le115DoyOYiS2gu8FjfrhlHdJEQ+xO8sYNHHgLY5pZqZeJAgN/5gFiW6qVMalV
	s1G96cmVy6D0Ju11OFLDDEYo/EyFC2P9a3HBOfdhv3TsNFN0GDQXXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aq7jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKbB3S019898;
	Thu, 17 Oct 2024 21:06:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjasrb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnfDGu/M7aRlwI+XOJy2TUP1syFRzN5RG0WqNQW9iiaJSJapA0BpN8lyAUhQNUkZ4Xbo74/sPgUHicqv8pVhUCIuBkKH05MWoIDwqKmt12bPRaewjPZfFyXKQm6cN/aV9clukWJLJEnp76oMNG+AMChpE26X0FnMvjMu/5mzAXoxCJvkB4LvuemobWk5T5suBRtBA76JlEi982qPX5ZA6csluejo5OaHllNmOiGXSTuC0zkhxojSksHZQwyiKlNl8ko3W33bu1rhkYX7w0EvTupdssPDa8RapJVW9vQpzZSWRsJruObUHK62qJo8sith+tT2+ocJq7TDFmEJ4oPwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgH20b0nzGzn+JEP6Wmh3EBcM6LRnAosz15/3YSNlfw=;
 b=szY0dbRrioy8ssA/FfbMOCn4jx7d4yD5j6btCGhRqQNmOto1z8/PlNV+lo8bWIp5HAMDxHddblqyOhTA3ey9T4pwUn23rC/LErcIZBm+fBg8VeNDnHrZMnWSQMx7+fBnDvOVhz+fnXHpRhUZus38L0OI5X2Cwj3f+zyZwlzbFu3BR7cdRNdKyhrwUfTglVaxYvq8Rs61TOPEVatDweKQphT8Tyd0ApUPnsLB2FyUMqcTnyNYAxhzXCKvuz1yNsZFrRhRaIpyn5yeGeC1WNhO+Js77SqcXL5z2Ud0dbnGmFHpV+dQxwngXqY6v0CkfHr3CJoO1WfvxeK8xyyYjH5kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgH20b0nzGzn+JEP6Wmh3EBcM6LRnAosz15/3YSNlfw=;
 b=fFm3Oy3hf8LWdZY+hzY1W54S+la9tHPAbBQdokw1VnmpkELrblFcZp4UV9DhQHGa1bddeKaiLcRsR63J6Is9ItWJbCiG/HFXcoEk/lp/bGtXKrBDqLMaIDjdQbWPs1/llYzOzQVRvV4V70I3lzCgSdztaKNVz5OARuOJ5imSPuQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 21:06:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/4]  introduce PIDFD_SELF* sentinels
Date: Thu, 17 Oct 2024 22:05:48 +0100
Message-ID: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::34) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e84d1cb-ec06-46d1-f196-08dceeef8726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCjOQocPxaOsqhsLt7a7oSlpPOcqJ/ie6MQqDzm6K6zH/A2iSLBtKW8M6RGi?=
 =?us-ascii?Q?ztQyWuHGV8fX65CRDxSxdK4FHxqEM0lTnjjDfYLuFR6e0udj9R6UbmKd+g2v?=
 =?us-ascii?Q?W4KIL4TYFvxKH8b5LtXPKHOPlvHOt2lsWx11SVM8WCslwDU6Of3CWNJ4u4Hx?=
 =?us-ascii?Q?gbqJkf/9K2mPERBg/6aeYvha6dB81fbCF9JQmdcUWh1Sgt9vC4RFP89mqeYa?=
 =?us-ascii?Q?TZfNDxEDNJfdMT3sbtySJhVF5moatot0Yas7BsLIrL1q2e0vQbbbR8vOAYTt?=
 =?us-ascii?Q?ooRcgUXWG1yEyX1fmlvJSLF9q51C959NWcVWgLyGuoOxDyp3IpkbLW7EDuwO?=
 =?us-ascii?Q?VkH+PUcLezzstBh4DSJarcA5W6JTGKG07FpnVKcZ6xU5ofo8IaCt7RyORaex?=
 =?us-ascii?Q?/gqgNGmYVyO0VX4KkTVxd0f9s1iSHeU2xrwTwYBAznNnvo0zKd0giIO9FPfP?=
 =?us-ascii?Q?ra2UxXkK5bWez5cb4ySL5Kr0/njUfev1xeUlCy8Mb1XKN3E/2dRlXv32O+ep?=
 =?us-ascii?Q?daHTHmpONVO3qw+kjy5U1nJAXvxksEQwYSwk+Drq/0ZxeAHzrIWDmsFci02a?=
 =?us-ascii?Q?0saKUTzkz86EFyHFp+fFzXtn6Hn9p3v59l7cdcZbU1sq7fnmgib8WCk+38iA?=
 =?us-ascii?Q?TPu5+XqivAbkEyIo/OkTYcvZnL5OqNuseLkRwHx0ZgPXhdHM9kCsySXdmu6X?=
 =?us-ascii?Q?P1MJGp+laTWJkR/uU46/6VTy8J9ZICnCmKtN2ntgR8PE0RjFlMgVbbNfX4Uz?=
 =?us-ascii?Q?eOjWFmvkp5Ae/3qwRQJ46wZQKO7y/BZ6NcyLmdfytBLGtbUdGINQ7dqbzpHq?=
 =?us-ascii?Q?48r6fZXOTyTcAf9DPaeNQ80a5QrOmXC0lnJsuAfkJzXPGLK4GD0KaoOSK3pw?=
 =?us-ascii?Q?iWidFiF36YRNvtv8BV6BUl3iACnU8R6RmXjhdZHEujye6QgVppShM/R1f/Rg?=
 =?us-ascii?Q?Us9+0WQmlAkK6RDb2PL/0gKa12snU816AuZYtJteI4/pzxOyEvnDCiJgkRea?=
 =?us-ascii?Q?L97W9UBidJqNx2JjHLUd94xhs5R6d8tUCTOmsU5oGw9zjAhEJAOm94ok6Zw+?=
 =?us-ascii?Q?xzSQzol8PqoLl8F2lCMU6918Obq2JLlA39/8LVR/2prLbFuLh2rQuSOp3JTA?=
 =?us-ascii?Q?i+dL8+NlXi4+Wbut/QIHfYidAhH5ShB9jOONLRvVvKj6E+Fv1TZbqfdZqeKM?=
 =?us-ascii?Q?jHRVuI/GrhUf1UOQPznXeXNZ4kD0pvwXgjmo6sVf2AaccHbE4L0cbLSk1ZjJ?=
 =?us-ascii?Q?FE1TNkgrplSE5Lk2Xw8DFlC3sbBR3aFgu2LTrL7XVzhajQ/3zI5JtU/hqOtQ?=
 =?us-ascii?Q?lGSpldexDZ9INSxb9LD1liat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W8A8CK9N4AUR9o6p+cHHAIw7LowHO2dMVgJNP7osdCUDeCzy8v3jHhT5MoqL?=
 =?us-ascii?Q?+PDkZu4OP3/u1jca+DxluT86Sqxy6g2OZR18lI5HDMQNwCsChcGbGZPJMkkE?=
 =?us-ascii?Q?0EW+X/GYDp8mow0XY0b1TyTPCX302GOeCPN8Y6AzWFpZsXZvzPO0EIAHzzFP?=
 =?us-ascii?Q?qQwWW0WtNP5q1Qa03MfstYMVGp0phgBZA9OS7dCvewQTlpppSLTwU35XxGXi?=
 =?us-ascii?Q?TUpBb/BNGKPPkaqUZ9DIODwJqPdiBPXSQm4tQZrbsT2jiGdMoCT90/Vrwd9/?=
 =?us-ascii?Q?21ENEjqagdV9yrb/B6r+q8kPaF49chjvryBw9V/3jvfR5WTaU58i5D2B4Q1m?=
 =?us-ascii?Q?bakAwHBL9N7T/jeHPhDP/666nGNLmJwEdxqXUubdxty2P2L+wst/orsz6Gs8?=
 =?us-ascii?Q?ld0hE+ovAzEjsspK43YdI4L83W+5m+b+J29Vl/ogpBdn3fwlN8V3/y7w9AWr?=
 =?us-ascii?Q?L/ofDQYqrFUOM/BdeyENQ30GlFDg/9AU7FjVPSncuHJbQc/Z9jrN9jj+F79g?=
 =?us-ascii?Q?V2OPO6aSfOSFhlchu703vFW9Hwakk3wLKWKDLevubbjKGOzQ/QLpICoXJ0U0?=
 =?us-ascii?Q?S8fygIJFha3Ees3q5g66nzl5iaMj0fPioNs1T5THmRl60oYtKzzoCnkOcyH/?=
 =?us-ascii?Q?A54pR2exnMXkSZaTmeYr41kLR6aFeHQio/rhDvcpVQMU2ApOxM4jyU6ZqStJ?=
 =?us-ascii?Q?GmSQaOgqLdMaaonl8EgoYPqHbQ4vXfCNv/bW0DuZqmVhkF8FIMkD1NrF7gcs?=
 =?us-ascii?Q?1S2+5MYiRGZSFuuVu3KQR568EqEpMOaALjq2zGCMEJrPUwCmkDahxqtLDk+t?=
 =?us-ascii?Q?dVJ9MTe0VAA8if2CfOWrlaDks+ejexiM6vZEsJ3FWZ1qvLIpX90J5QP39cOo?=
 =?us-ascii?Q?xxMI3Fo1fIZI9M0R5GbgzI7WDiKD/+YJxm9vyTYXA6S8gy8W16NQRY6+dNif?=
 =?us-ascii?Q?ZTQu5Foz24Dl198XTcOpgmyWUYWv0egCmVIAF8KoWu6zsdxhSbwqNllvCRZX?=
 =?us-ascii?Q?b/R8o59u/rPfgTVZRBk7SLcEErgnEZPOvU8OOqBIDNs2JFJulbS2fg+JMTIg?=
 =?us-ascii?Q?hUCu9rTMBBO62Ok+uA2+fgFEqQ5w5itdgyWRzPRrp0dTPnOQirOD32GJMTLK?=
 =?us-ascii?Q?uBc5vmbQUJ7M/3sVUDLqCOrKWypDOHE6fvxYNnkeWi2WWonBibqbSMg/WyNT?=
 =?us-ascii?Q?jZLTUGKgHezEJ1ZzQbIYFNGvM3ebSbos3OO9PmS5I0okgjICkWjYv2KS3uvi?=
 =?us-ascii?Q?wt9ZcXAlnhNLNTPjmN1mMlUCAEWtL1RkjAzjVIfTrBlfczt27M5EbAJ0mftJ?=
 =?us-ascii?Q?5daEaVUwU7mFlUKY/x+KzAHSF/z9K5apSPvXAOd1NpAE4VAZe55IRCmTdYsi?=
 =?us-ascii?Q?seFDwl9uyShaqZsg87CzrL2U8uJvnoQs2xF+kkoRO3mxegqQmMQNm7iwGdeW?=
 =?us-ascii?Q?r3SiJ16+7ZBU9IQAUoV3u33N083dtKfMnSSj0QzDTAHnaq5m1g5nqXeVprd0?=
 =?us-ascii?Q?nJfeYuI9jWLZ7v+ux3WJ8CxbKVlOwJd4ptIllM2pxh1yOVKj3Ge/aAiJetpr?=
 =?us-ascii?Q?e1V7HPsYdgJV1YBRHa4aWAT16BvM1YpYBGf0zEz67qjCsyV3RYk0QQ+cY2mT?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jwh7dWLWmVjbLAcR0ZJX9AxvwgIZQOYk01VPvTiiIoqBdKuS7oC45MEBxpYIW6VBPsGJdeYfHh6CbsXWaG8UVc51zN1pxusJ7gAu03x/1R4/0SfG0mWt1svgnZN9lyAlYIvRNXCsTLQS5u0QV0P5MucIltzNrhSmUqXIqtdBzMZCTr59idqPccwvHeSLhF8jUP7qG9d6WdQSZwVV9QmSDShCc3GIL/WAO2Kge70mhuxH8CrT/xmIVt101ss4z1voiuuG//VAe2hrIxyNNatf/j8xkkwUFbzsDsi7BQjAn1BHOn217LkXKwsQOD6tiBamGTax0G224BTQ8Z796OwyNMgNRjMrkwVAAoY4Wo+HW+/l4YulkT6M3gS0Mwm1y15j5I8eOJR9x+bmiM1IDl04k5LlX2kEsZnlXT2kc88vuKiyIi+7UgI0e9Z6fjKJtAFlhjQw99sxx1dx/KKPDO9lJXTsoQb/M7jEY5w9LoXqmQiVVayXeBj4BOYP3CGA8wWy6RlMyHeHXbrqZMGeXeCoHJHtmjw+DljQxpOoiC/ZybMg6iHzoKtWzb6oi0QKWQibw0oEgW42oHgJfxyF8Guj5M6+qXpnSmbkMIGgvzplfeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e84d1cb-ec06-46d1-f196-08dceeef8726
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:06:11.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUmKw9iHm/VvkmCgevnDTgww+xRBez3rEwX8+HCFirxrKvYlzNzwIPMGTlWvQHQUzIDkQVBVyCF44uh4mBl+VirwgWn2S5hSLZoFMdwM3Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170142
X-Proofpoint-GUID: PpRnyT8ZRqQyg-BX4vFD2OMSXVNFUhCz
X-Proofpoint-ORIG-GUID: PpRnyT8ZRqQyg-BX4vFD2OMSXVNFUhCz

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

v4:
* Avoid returning an fd in the __pidfd_get_pid() function as pointed out by
  Christian, instead simply always pin the pid and maintain fd scope in the
  helper alone.
* Add wrapper header file in tools/include/linux to allow for import of
  UAPI pidfd.h header without encountering the collision between system
  fcntl.h and linux/fcntl.h as discussed with Shuah and John.
* Fixup tests to import the UAPI pidfd.h header working around conflicts
  between system fcntl.h and linux/fcntl.h which the UAPI pidfd.h imports,
  as reported by Shuah.
* Use an int for pidfd_is_self_sentinel() to avoid any dependency on
  stdbool.h in userland.

v3:
* Do not fput() an invalid fd as reported by kernel test bot.
* Fix unintended churn from moving variable declaration.
https://lore.kernel.org/linux-mm/cover.1729073310.git.lorenzo.stoakes@oracle.com/

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.
https://lore.kernel.org/linux-mm/cover.1728643714.git.lorenzo.stoakes@oracle.com/

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/


Lorenzo Stoakes (4):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  selftests: pidfd: add pidfd.h UAPI wrapper
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  34 ++++-
 include/uapi/linux/pidfd.h                    |  15 ++
 kernel/exit.c                                 |   3 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  65 +++++---
 kernel/signal.c                               |  29 +---
 tools/include/linux/pidfd.h                   |  14 ++
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |   2 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 12 files changed, 333 insertions(+), 61 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h

-- 
2.46.2


