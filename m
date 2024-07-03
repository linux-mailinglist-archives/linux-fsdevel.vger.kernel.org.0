Return-Path: <linux-fsdevel+bounces-23018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4850925F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A67286284
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27517334E;
	Wed,  3 Jul 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7nZmoD3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P6ZTGnGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2317279B;
	Wed,  3 Jul 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007890; cv=fail; b=JG8Zj0VaKHDnGYlICRC22HKGWmeBc6rixRz/iYtUik22AZ2xegUgwxfarUb8qdV9tOYi2DY4HskziacF7BC/8nbQSTYZUEuHrB6ffybAwO5sd6NYvT2aDeqMOMCFj/KrKcHZhni0OFIgi1QwvMs6HicTpXKcDgFBSC/8uaegvUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007890; c=relaxed/simple;
	bh=joovCA6tTf/WC/LyaZ4ASW+6cdUfuERHk/jN617EfcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kakd3WBR+W21okxk8s3pjxobZq99lEOuPtd1xkA03HW/wc9H5NRJS7PuxiS2gslR58JmLHcvIsOHclHe2dqXtCGEuJgNiu78aO437hj5aJ/pP/svd8U3fi3//7w8JaUP3M9YE3ukqy3DXQYgYTHCVPRV0xJxP1dTljGBme+ZRJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J7nZmoD3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P6ZTGnGB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638ObPv009722;
	Wed, 3 Jul 2024 11:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=dPhy+DmQ+ZERY/
	aul5Y8xk7n5JKx9bKAeWSWEH5zfAY=; b=J7nZmoD3lOGdzd4eHIHJMHdgdg1rHH
	X1fnYDghfC9oTPIc/pRYpbUFhJAiY4al0LlJoTvMiT9wD5GLkeCNLNoxMQyzlUsj
	ucM73fXxIRniHsyeEwzlVFYC2J3TnB5YYmEqQZKM1CS9DUzIRihF54XUr72qxa7h
	4uOXFhdF2rsiLmNWJQyKwd9bNsYSJqo7XoRKwdWZb5+EPYt4XTnL1tdWgn/+o77X
	JuYd67yPDQn9g9MSCBbs+no/SWeHwKhmH4FZlWI3NPHjtG8F4uNLi2eI8hI18c8F
	ffkO1WBno1d1TsIU1UiFtGTg2vMXAP5Q4/wvsWj6HKs+mnpB3UYK6f9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0r1ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:57:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BJVaq023511;
	Wed, 3 Jul 2024 11:57:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n101e98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrjalrJK332FyHXlFWzOOs2H56dXsqOy5LaRackN9No2EKcRhjsQeEbg+pZ0hGvb73gDX21SqDBnSWgJFt1o1AD8XAyBimtyEY7+vmQ+lcJjVRlxNARXOAV8wi6GZFfXtJRAnIX1fKT9JIwDVeDlyLJ/7LGA3NJ2y7/B2FpAQEhuSLCJF1ZpxmYVrhgqLZTOyEbVX/yf5VZ80sBVPbSsf9UtTOhR8QCHvqHELfut4nfLtyzlSm6Ma08Aw7nFMBNf/tV0MnpMNWMAOU3dovU/ZukZpkBL3eZV+zIpYolcaapu9SQKtU0Ly2iiCvLWa4W/nTXKqdSm/a8BnGIOIshyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPhy+DmQ+ZERY/aul5Y8xk7n5JKx9bKAeWSWEH5zfAY=;
 b=QinOHFPmj53H+TaEy1n67rl7hmuGA8ygdpfMLxGt6bT0UGIwQGUtymcuu+jY8gho6PZJRUHClfv8oBFbEsjPq2tzLnQI4CwDhWHDGu81jcz2nywgamY20kuC5Vte1duyuXDUrw+x7IdxZQCyr+ggz3MEMkVLCDGN0n9u5DDApKYKQ12FuZ3fAMS0R7ecQ2jwofP+UzFfomDA7B8Yw0Vn9RWGD5dJ+lsRn7rzXtkc5PNskdPUApAoQ56lb144xVDvN4i0ln+uchqB+upvruvbKWOHHKAUppc/ZBKKfBX7/mpTf+FkiUao3yxBSaB7Unyu7SZd9sfRr8nOo1gRddboAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPhy+DmQ+ZERY/aul5Y8xk7n5JKx9bKAeWSWEH5zfAY=;
 b=P6ZTGnGB5wcljpzN0lTY2bBj6rspVN7726Skvnmo3YAEw0uMRazwKYI6YlvjOoSWSS454VR3l9vbL16l6TJf7iooA5iDFC2BIlfzz/cpt3w/VtIW06L+JCXSafCObHeVpk4Qtksn7VXhaqxkRMxd1pauD6enfTCT5Jfv3LEh4go=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 11:57:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:57:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 0/7] Make core VMA operations internal and testable
Date: Wed,  3 Jul 2024 12:57:31 +0100
Message-ID: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bbe9fa-aa82-4d0f-0b39-08dc9b575a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SvYNSScwCRd90JlxoaBhVjoA4U/3/bWHhX3Ak4ULNJVx4T+s7UFF+NJxcdNl?=
 =?us-ascii?Q?dLcNiykkTtG13tlJq+6GzkY0X274BW3yH0kSzZIndio4rlGlMJaJYZv4PY39?=
 =?us-ascii?Q?jsR77u6e/6hnvcHcawOpzOP60EivIcrg56l0oZi9Y1VqkyEuod7MTckZRVOq?=
 =?us-ascii?Q?sJKbAjmqkXhMoGDUzPnGBNL9WmcQNmgzJOw9Mw6CYE4+XZgQppWJxD6P0j6k?=
 =?us-ascii?Q?ud3jupHvXQtYPzNRD7Iqak7M39k1GSXqp40TVFt/KcLUj/WKeTJInuq73WQP?=
 =?us-ascii?Q?J88zbIR97g+XyIaaP2+yBdcMPDXqV5FuVjIQcoEfBGC4FdK1f4CeNg6lhhyr?=
 =?us-ascii?Q?sYyyQI5d1O/SaJ3HVCIcu7z0MySFQMzVNgpDWR/rtca3jLCP4MeFUFLkyJZC?=
 =?us-ascii?Q?qStzNJJxDXLQYM/JR4PEb+ITY9LGE0mLBBOAGAlhc2XT8wmsEvj8tN0LYa/H?=
 =?us-ascii?Q?MKo6WIrj3vz22qoaxAw0QVpkbigFzqj0bmJJWvRGZaGAIi3rVzo6XnF8ANuu?=
 =?us-ascii?Q?VCPKFhheS+g+OjhtxNcgoMk6XPtCkKMnRlr6025V6w9uPIvUi47sEE2YcXJ0?=
 =?us-ascii?Q?eZlMkX4rGEICgmJPVMzYybJlAfnvU9JnZlEW4BsSfuJCwWIdFzkyvTQRiEQG?=
 =?us-ascii?Q?EaL4pcVVPBT3dWwVtRGY2VGsPiib0LYkxyHgR1Z5/+qbVTCBQyPSpXg/boSA?=
 =?us-ascii?Q?zVzuQuxYY9M70dVXHdXPHMJ6PcMYaj8R0jsVZETCB8GzNNRA5lAIw+RVXh6z?=
 =?us-ascii?Q?2h/5/hZsAenKVacWdzgIO8WpL0nZrA7PcPhPK0tBPZi8/zivj9m33EUFNuUL?=
 =?us-ascii?Q?tjXIzAgVhGhgXVXgoccNg7ylnWY4LOO1fKGAIPHrjeJ8Tg9Ubc5MoonNxRzU?=
 =?us-ascii?Q?0MjT8fSJF2clvTLabUa74N/VrxDdGwQvGh+8uPsL3tNTfw76zG5O3BS7x6+N?=
 =?us-ascii?Q?02zXQJWGP/U2EG/Od4DCP2eF7UED8RpvhtnVIEduSlmuWNilaAGDc4qRR0HQ?=
 =?us-ascii?Q?qLkgg7uBnsHr+MWitR3P0CS/0PFc6pdIz0PxvCW9yK8sxlIgmqcsRTcuex1i?=
 =?us-ascii?Q?MyiN7suraLRQsRLlha5KmrwFha7Xg69wCeVGgrwqQt7WjpY1RbViE4xXNJXe?=
 =?us-ascii?Q?4m2+R5Vyf5WMTfQ1ezaP0lCG8HBguP/dl5QPJZoYtNnytAXyTARgHFN61yuH?=
 =?us-ascii?Q?+qADvAGj9v+el4SFKChqmUFSB9hhangrVwUg6VMOIBkJ4cqf9QLr3Gx87uSQ?=
 =?us-ascii?Q?v5A3fZMepjUE/vsBYvdrhsHwZb9T9qJofCRVmUFFzLnyN8Iz1b5MWZ7d9ejJ?=
 =?us-ascii?Q?XwME4hXcKSfwB4PHeSo4Gd8H?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k9o4vHc0MG7Nk18pyRqMU4G8OMy/jpf3bn9M/WRi8SmDdzTaia7hDyNAVTEX?=
 =?us-ascii?Q?qOpuT30nuie684Da3PNLOb6FeH0WhGFZP4IN/SwbH6rpoHk/F3f1d/ddBHjK?=
 =?us-ascii?Q?DlQDH8rl+oW6m/eGx0D6T2iLEEGGTarFlvqVWCmJ1FBfWwDKzbWGIqt5Lsv7?=
 =?us-ascii?Q?pxBch1iqXRx5Lf+PdrseKMvKOCOYgVrfM4sMVFYrKIoMeNlmwjNcXw7yI/j1?=
 =?us-ascii?Q?eMk6yjMY19BJ9d2LVNhTwdstJIZpzK3wD8F2L77yo4cBUI7Yp1tkCrO5Grqw?=
 =?us-ascii?Q?cFUZe1jq+MCDOSMtKFiMldhrecSz8ZN1So46vYPgKrApAB9nQO/O3PHFY6HP?=
 =?us-ascii?Q?0ulZMfvEQNd6vN7d2qTKTNSLqDAn5ILC20V2OJwE7lWdM2yvtDJBwW+e53Mj?=
 =?us-ascii?Q?/X2Yy4VuHSFzOyDhOlC/IOgeJJbGOaERLsTzWuoSNeM36vvb9RRafYKo4AZX?=
 =?us-ascii?Q?Wi2uovXubO3rJh9r7bYagetCBNIan19CDuDyr1m6pjde2WwyGl92YseY3sDA?=
 =?us-ascii?Q?NKnXn54Pc5u7T8L11K8jZv3+GBGsR1/P0Y6/H5XIYA9jO3YWBI4+rW3MUdt7?=
 =?us-ascii?Q?mVeS83j3Mmq2Rli2jCqvfF64o8P9xvi8prh5QhSGbMz+30O+J1AEUhF6Q0Nf?=
 =?us-ascii?Q?oALFiJ66l0Q7ToMm1rbbZsbb1JZniQSJh9ldH72mHz9MNbxt0L3CyA3Rch+a?=
 =?us-ascii?Q?R/+fjdVlzNkHd7QQRDoE+D2ItxfvxQsnqJDZzKwVTzep+DrI4+A8sxmmad7u?=
 =?us-ascii?Q?Tw4WCy5C6FUsbKLdKR0gxm4mBNQlMOF3pr1dxFJf3ET6cRUwjBpjX09+PNFc?=
 =?us-ascii?Q?LZubffQJB2dGDNGayVzMW+LWucspB4PhtHku22VnnHniWxuFsQ8ZDwJztVi/?=
 =?us-ascii?Q?aK+PjhA+G5uNwLF9LSKGTq73+A4dqr5AYtNR0nXcTWs9DU6OsfIVKvVFbHc+?=
 =?us-ascii?Q?VwFZyvcDlLMzZh8q4mR1Z0ADqLQoaeaA35UJYys2oLlB09wzdxrDPoENckSx?=
 =?us-ascii?Q?WyOYgqRYE8Hq5v1akQ6GukIE3VGRiIdL6yHpQebQ3q+6MV4WD5KjCj+iRzi6?=
 =?us-ascii?Q?nmem42TpNwe8lHMr6wknQKQiIq1bRBLaceUlF3Z8EMRoadVAW4t6M+iuxUc7?=
 =?us-ascii?Q?bVrZy/OVbPz8H5myQnKvw4DFkkuad/HZYqWQbKdPN2nFdOiJP7pkGxbgGGUb?=
 =?us-ascii?Q?Pw1VhQu31CNbGpYv8bn7jex9LoK0VJojr3uC2OLG3PKJEAG1QGMha367R5pC?=
 =?us-ascii?Q?ogWuZl9TWQo4dCitKdv67xIVAveLqQA4HWMX+9no6syEOlzmhELusFrYrJDN?=
 =?us-ascii?Q?c57eXXASWflLkEzwOV1UHlIlhG9RdayyLMi3xwfqLhN/LAXwFSWbwiCj8S4e?=
 =?us-ascii?Q?MYyPCOcChyoybOpPb9MQpDqYaNNPzWFSsyHt/01X5KjH0dhUBNIX4wjuumi7?=
 =?us-ascii?Q?m8lkMivS3LJMoiGSRfsVUhs4xDX4ZoCk4rTCvzVm+LBPxfJEIeCw6SFvPCFw?=
 =?us-ascii?Q?t9MUn4f8vJtJN3LHyJw32LatCAJ1UappcaeEghpoqvXnyE5rNzWWmMwRt/Re?=
 =?us-ascii?Q?7qSZvwWBLM2xhEOaEjdzCjNV9qOMXXecbIWXv+KKx2NrRc2ykMXRMwg+wiea?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6Ll+aiNJLjMp2+QXDfcZR4ie9zkmwmU6srcrT3fhuKjX5VEvLotqFHpx5KD9bNRp8FeUaXfr8zBn/5SozRJk1ZvH1IAa7Zb9oBH8SPlSsD+eFl3eLfGMm2lkR2qYxNXeTer9VBM9QLuXoSZaGkhrSeCeQydfQhcEbN3Di0TLMomnPf5pFs21gmh1mH32VqshHo5TbnEJ4YHa9A7I59rA6fFThilozAyeEeF9U/tEchZqr1AsBIZ5nnTAY8jpZluKOB1iQOR49ud4eU4mcBzz7V11Z6J72+D+AhDi74Wt9K3bhQ4C49hobVr56mttmE9nbclHnFNXGWzCZqZyfkUqCkBA4Zs6Wu9WRBYHDbQLzN2oRqfycBA8OT8ILlsExFG8zf8yskqyGyTVZbqq7YvcCK1upJsGO1CATG378V7xQ8UFDyssj048RkqIbGVUVxkvxRzNU3TWouVu41stKxRFS6Bi1weMFvaV5aHqE3uLe2roaYG+c9HxSZPgrOPp9ZBVcQupGjPCatCks91nIAQ7l/QHkqn7tPOJuOW0hsKUjkt06547AxVcKOQcdtBKuTcT9j4jR1DlImH71c0c7NWk8YozfoQ4WiTeGJRp//Xj8h4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bbe9fa-aa82-4d0f-0b39-08dc9b575a67
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:57:46.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZSwpXb2a/FXN/nq8IE7iPcI9hB1Luv3E6UPR5SzQKdt9u8QimmrQNx4JXhqD3uKGvx85qSf/CQnCmvGS7DdAO7Ieo4BwyM2RtSEBNqJ+WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030087
X-Proofpoint-ORIG-GUID: d5RRhL8xSGopcWELNi7TF76TZEShdpnw
X-Proofpoint-GUID: d5RRhL8xSGopcWELNi7TF76TZEShdpnw

There are a number of "core" VMA manipulation functions implemented in
mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
expanding and shrinking, which logically don't belong there.

More importantly this functionality represents an internal implementation
detail of memory management and should not be exposed outside of mm/
itself.

This patch series isolates core VMA manipulation functionality into its own
file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.

Importantly, it also carefully implements mm/vma_internal.h, which
specifies which headers need to be imported by vma.c, leading to the very
useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.

This means we can then re-implement vma_internal.h in userland, adding
shims for kernel mechanisms as required, allowing us to unit test internal
VMA functionality.

This testing is useful as opposed to an e.g. kunit implementation as this
way we can avoid all external kernel side-effects while testing, run tests
VERY quickly, and iterate on and debug problems quickly.

Excitingly this opens the door to, in the future, recreating precise
problems observed in production in userland and very quickly debugging
problems that might otherwise be very difficult to reproduce.

This patch series takes advantage of existing shim logic and full userland
maple tree support contained in tools/testing/radix-tree/ and
tools/include/linux/, separating out shared components of the radix tree
implementation to provide this testing.

Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
which contains a fully functional userland vma_internal.h file and which
imports mm/vma.c and mm/vma.h to be directly tested from userland.

A simple, skeleton testing implementation is provided in
tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality work
correctly.

v1:
* Fix test_simple_modify() to specify correct prev.
* Improve vma test Makefile so it picks up dependency changes correctly.
* Rename relocate_vma() to relocate_vma_down().
* Remove shift_arg_pages() and invoked relocate_vma_down() directly from
  setup_arg_pages().
* MAINTAINERS fixups.

RFC v2:
* Reword commit messages.
* Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
* Make move_page_tables() internal too.
* Have internal.h import vma.h.
* Use header guards to more cleanly implement userland testing code.
* Rename main.c to vma.c.
* Update mm/vma_internal.h to have fewer superfluous comments.
* Rework testing logic so we count test failures, and output test results.
* Correct some SPDX license prefixes.
* Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
* Update VMA tests to correctly free memory, and re-enable ASAN leak
  detection.
https://lore.kernel.org/all/cover.1719584707.git.lstoakes@gmail.com/

RFC v1:
https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/


Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: move vma_shrink(), vma_expand() to internal header
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   81 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/atomic.h                        |    2 +-
 include/linux/mm.h                            |  112 +-
 include/linux/mmzone.h                        |    3 +-
 include/linux/userfaultfd_k.h                 |   19 +
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |  167 +-
 mm/mmap.c                                     | 2069 ++---------------
 mm/mmu_notifier.c                             |    2 +
 mm/userfaultfd.c                              |  168 ++
 mm/vma.c                                      | 1766 ++++++++++++++
 mm/vma.h                                      |  362 +++
 mm/vma_internal.h                             |   52 +
 tools/testing/radix-tree/Makefile             |   68 +-
 tools/testing/radix-tree/maple.c              |   14 +-
 tools/testing/radix-tree/xarray.c             |    9 +-
 tools/testing/shared/autoconf.h               |    2 +
 tools/testing/{radix-tree => shared}/bitmap.c |    0
 tools/testing/{radix-tree => shared}/linux.c  |    0
 .../{radix-tree => shared}/linux/bug.h        |    0
 .../{radix-tree => shared}/linux/cpu.h        |    0
 .../{radix-tree => shared}/linux/idr.h        |    0
 .../{radix-tree => shared}/linux/init.h       |    0
 .../{radix-tree => shared}/linux/kconfig.h    |    0
 .../{radix-tree => shared}/linux/kernel.h     |    0
 .../{radix-tree => shared}/linux/kmemleak.h   |    0
 .../{radix-tree => shared}/linux/local_lock.h |    0
 .../{radix-tree => shared}/linux/lockdep.h    |    0
 .../{radix-tree => shared}/linux/maple_tree.h |    0
 .../{radix-tree => shared}/linux/percpu.h     |    0
 .../{radix-tree => shared}/linux/preempt.h    |    0
 .../{radix-tree => shared}/linux/radix-tree.h |    0
 .../{radix-tree => shared}/linux/rcupdate.h   |    0
 .../{radix-tree => shared}/linux/xarray.h     |    0
 tools/testing/shared/maple-shared.h           |    9 +
 tools/testing/shared/maple-shim.c             |    7 +
 tools/testing/shared/shared.h                 |   34 +
 tools/testing/shared/shared.mk                |   68 +
 .../testing/shared/trace/events/maple_tree.h  |    5 +
 tools/testing/shared/xarray-shared.c          |    5 +
 tools/testing/shared/xarray-shared.h          |    4 +
 tools/testing/vma/.gitignore                  |    6 +
 tools/testing/vma/Makefile                    |   16 +
 tools/testing/vma/errors.txt                  |    0
 tools/testing/vma/generated/autoconf.h        |    2 +
 tools/testing/vma/linux/atomic.h              |   12 +
 tools/testing/vma/linux/mmzone.h              |   38 +
 tools/testing/vma/vma.c                       |  207 ++
 tools/testing/vma/vma_internal.h              |  882 +++++++
 51 files changed, 3914 insertions(+), 2453 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/errors.txt
 create mode 100644 tools/testing/vma/generated/autoconf.h
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

--
2.45.2

