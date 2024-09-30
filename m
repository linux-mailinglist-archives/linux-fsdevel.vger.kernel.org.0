Return-Path: <linux-fsdevel+bounces-30329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F121989DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE971F2358D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC46188010;
	Mon, 30 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KnHv24T6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nL8LDsBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EA17C8B;
	Mon, 30 Sep 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688175; cv=fail; b=pf1cH4UOrPQepiVeMp+sON+EW4AofVX4cBbB/eSpIffZindS4qBa/285rWK18GvQkHAyldWZD9Tb5V+JDEfVZkZHIcg3CpuF8x80zZks/5nG1Irb+5BFvzfdCm0dIR3B8kREqcjTsEjfKvubYUi4pj4tDHNze4/Kb3PA3nFu4s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688175; c=relaxed/simple;
	bh=6NYrhdGFiSN6U826w1qIG6DHl+oa+Ng1AM8iWVSvAJs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gz6OWPI/R/ys9gv3w00XqAzrREZrer8EutmfIUG9hvJHoUNTOHP0xngJ6IfQs0gQbzMOQGQgAQJhvakhKCRkM4TahnzBmYniDyTod/RrA60vctKna7ibW82CsqoautmJeOoU+obgkLu+TB6+7sTAY7zr4X9jWtf0qSp/xudJ03E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KnHv24T6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nL8LDsBm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2tmpT014356;
	Mon, 30 Sep 2024 09:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=rCQwvosJvQI0P1
	cnqE+4LmW7afIbhfLEv7wz84ZRkdE=; b=KnHv24T6pvXKXRXV/ZUQGOW3OX9QQH
	0XEQVdLZqmAm88MDGV5M63LXV3slyap5UmiM3PoKxqhiJNQEXvPKEzJnORxkaOy5
	pCJ1dD130zeoFIOc+plQCXMlxVrGClnCnvRKMI8/tYEa3zYKturMqFK041gL82vh
	DNaEgyYjJhbFGUY4DdKeWoF2oP7a4AdqrnygWv85L3I7rQM7MePDhHE+cyJjZACL
	938mzobnnJkzeTsfhOZp3mXzMUUT3efnDTqiM7/hJXl+TSqsJl++VwH6iA8sIgcs
	hbq9zZFtPmgUTIOg9ShJFJTXpqezQBH8V/Z9xmPqmeOoSy4HSvg//RgQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb2ttr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8A7Yq040635;
	Mon, 30 Sep 2024 09:22:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885stu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kToQDdhd2uvu7bd7ZPDbRg/+SQ+hrflm3e4LA30i0GxiDKOJRgYYN5mPft8SxjmBEGi1EDklHL08aIz/odIOhOc1IPgYn6vBDxBm95Swo+ce4zcxLSsicpBFAXPwoE88JM6DHf0QrnxS3ZrLG+e/n3mRlfA+079f2wJ9TUL+yHrtzXOeZtdDpOmKcf5wnApG2AzqK6cfOp7z9GDOvH3PfGxXaB2xyzq0udG5yZ34iJ0OwfIgcQ/QEPynQ8CdoKWnfew8bL72CPy2SO/DMCvZY6shkI1EWmpSQeRIEJy3bMS4evf/JmpP9z1um8Ettop551AwjtBoGIpwxiSCh+fpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCQwvosJvQI0P1cnqE+4LmW7afIbhfLEv7wz84ZRkdE=;
 b=QaloSIi8Vb5uQ1jbjxmEmqHdDDbo5Yveg41CX5t7ben81wNdPsemA9FNV+ly88H9XjO22gfanqzNhwxhRFCSKVmtPtW9md/5k73Zwb/7d4htr8e2EmMO+P1QA2MBUItH0R5IHezfIh2gruDNQgZwufIRxB1QttOxo+Vo+ESHUhtXQGASQh9odkg668GljAJRrrP0cKKbRlkD5W8+1VxfigGhxfiU0eKn8yuBY2TPLWvgTEGDSeSwjfmCvj4+6kTgqZ3oXsVsxe25BPY+UAqC+IhYhA4UqmtDbMdEXfhS2ZwY5yuAkQH5A4IXPMUc6G45D4svrNc+IWqKZdsOq0Y4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCQwvosJvQI0P1cnqE+4LmW7afIbhfLEv7wz84ZRkdE=;
 b=nL8LDsBm3D53hNU2X/jYWKXjaTHARG5/PO3uA8SluRcCCeeEF6dS3IKmvRfofPmMJqt+8VmEQON7HGP4AxhUinVuAMDzo84IW38fFHslf7oFozvLbbSzwhPDbTgl+ofjP3Z6wV291d4zk3T5U3fHK8+d74Efg2pYa2NyxDMp1No=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 09:22:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 09:22:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] introduce PIDFD_SELF
Date: Mon, 30 Sep 2024 10:22:27 +0100
Message-ID: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::27) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ffa0aa-8d37-4634-a772-08dce1316d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UazVXaK5Tr83Qw+eMJsjFwJWH30z9zCb9vaHvTJFt4W/RFj0mLOlIZlvRXa6?=
 =?us-ascii?Q?I3AiGJqU0XqdhLozv3Os73MQL9QctXx0ufMYTvoiil4F5acM2fdNmjBga7tE?=
 =?us-ascii?Q?RmSXfgiRNvZf5mKsDT5YvIiZUAAnpPkQ6GVPhpt3q2lgtNlaAxBkeQQ79Vmm?=
 =?us-ascii?Q?uXQCD+Bh/T8hHE4sTycymWAIjUu6f4FnGkeeRKXymMas7F3eZ5JFZz93dau4?=
 =?us-ascii?Q?0gMKs4LyDgyLbYf06YqV6h7VVcSIO7PE4HO1xcejkclGglBmhjjG4LPL3SKB?=
 =?us-ascii?Q?VkGDcPSGsxKFaHWtl6B3orfqyuNfg98ZLA7YHKkLJo06rbR1QUKXc+hk/sep?=
 =?us-ascii?Q?/fWOpWrJBTmxtwfidJseqIxaZMCBXcckBXZhY3vwdz+Axm++qAV4aOQytX7e?=
 =?us-ascii?Q?O+2nItRx+JSrRv0lzNsIIPf9qzJUBTIbl2yWEZYsuNa24mgpo2FImzWhHx0D?=
 =?us-ascii?Q?Gez8/R/dN3Xa1WwIEtS+WQDpS6vTcmZoBjMMuyNERwkuhFJL5E9qJC+/nEWX?=
 =?us-ascii?Q?57S3XFj8GcXOLXgP7HWbhCUl/sFl+9mZTkYKl+0MZQqGhpXSkYcE+uhA68eB?=
 =?us-ascii?Q?a1TkBbMSyZvQAypkOYjOg6ycJFTU0YY0Xlgjvj9FZhvvrF/lWzFB3/KYRub5?=
 =?us-ascii?Q?4vFb1NLehbYi+qNszMEQOp1yFBEY+x6B4aC47WgPOE6cdu4dnVp5g+79igAg?=
 =?us-ascii?Q?5hgYotEUNxeonQc7e4f9N0CAbWKUH6lfcHh+2vQZjetS3XFvXPE6S24nP0Yp?=
 =?us-ascii?Q?6eDHtmE+NhwQMDpu/9s85dW35+O30tBwDqv6Kxosj7+AQC4V1xAzA5PASA+j?=
 =?us-ascii?Q?+do21twmlhRpZuq2s3AksnLB4wYtvMtvrLCngj3NX4W8sLTN7i2BYuDi8Jc9?=
 =?us-ascii?Q?k4R/e9bwEZLsEln4PtqAZ/K19+Tudsm3xJgXhpHjNnj0BnVIYhBzInZn2HqM?=
 =?us-ascii?Q?AAzQJidr3d87acGBluflv3/dqZoXPL0HMLukMwbGFnMbJ3BZmfjfEsatXU5J?=
 =?us-ascii?Q?RNQSEtPg2qMViifHnJmfYe4QgExbZ7Uf6hR64/kBA5VcScTOADO4foEFe0zu?=
 =?us-ascii?Q?71QWluqd+fkIg18xhQeWO7D9zQm/0H32yHbRbBe6jZwCGG0GLFNq6moyOcw7?=
 =?us-ascii?Q?T/pr4FkALBylXXZS0pcY7KZdhXCo5vydzLfHctS+gMOXl59DVITNCj97+NR2?=
 =?us-ascii?Q?q0L9ZyMp7IzFXquqR5E+yu2+1rKFKxC9i04Y9HbZzlto2vFNdfqlB5xeoDbu?=
 =?us-ascii?Q?nrBMwtTg7gP38yyLCVJf0/HI1TDmhs/3fLE5DJi4IguxwboiZjrXWA5ANgux?=
 =?us-ascii?Q?kva+IzirY9f48itobOEBMQPMFmB1i2GGt8wY4mKbkfNOqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4yIoksWxFcVc6Bj8HEHwAUqtJRX9Q6fMXK5lzu/7Q8LOeBmLt1b1lX7Mg3r?=
 =?us-ascii?Q?SXdu3AV6ffETq46QRHo21wQ2jNNwIp28A5LXbvFDpwqfdQ8v4M8eH62hyw2F?=
 =?us-ascii?Q?1KahDZ4Qihf9gV8g9AG3x2rgSBaccYrxKsAr4cYI4pMQwNlW2cMkOoSm2TvU?=
 =?us-ascii?Q?NhbXTkH98S5immwuzNL1CeH0QyEneQnFy6geludWPemspPYeBsEcp0mwDzL5?=
 =?us-ascii?Q?j6hnMg3TERWzEE3oPZWBSBVCH+lz11M9DvblfGQZihLbhodYqNDvDe1bCmnc?=
 =?us-ascii?Q?WoaT4VWiMEGbObWRROx/25b221Ln/5BdFmYhEJeP4OJAVjYxOWrjZfe40JSN?=
 =?us-ascii?Q?tGuOTCvBBIgihecXsrZN5zE8Irk/6oX5OvJ5lhVKLoa6F7ER9eQPlY7Qc7fi?=
 =?us-ascii?Q?+bCJgrbr57LFtJgsgnpUVXHQNRgUjPmwwwzNC0YgYoPVi7R99VB+sgo6XRM3?=
 =?us-ascii?Q?lyWyvRZEd9YGPj8lNNB1Jg6HJlOw9mwCAu0YauCdf/UyY+H5LAlMkB/EY++8?=
 =?us-ascii?Q?W6yNysiO1xtZAyrEyPr0z5/Dt6yLeoDAjHc9L1opGR3aqkVa8juEXQanP/yr?=
 =?us-ascii?Q?xdpMO8/ipaGcZsuTamxPv5HXSZ3HLVsb4NWJ8mBlmzA8ddtZmgBP1ka6E/It?=
 =?us-ascii?Q?Kp9nXd9R4KNxM6lICDCHQR6eKGZRAW8UmQ610XLtyT4t9jIiM7QkHbzDPoSU?=
 =?us-ascii?Q?+j/KzrlaC987e/uqEK8+UBZSwmxRKr4wdkG3iRAnOSVf1WSnANkh+LDbFtkv?=
 =?us-ascii?Q?e7hxuXhhMLUooAqLXvApEQrQwZ0B/zipSOpi6u7FObxuZumAhUL6hEc8l0cM?=
 =?us-ascii?Q?O/LQePluQe6uVxgatdyOBhOl36ZhJkqpBZjUJFj7ph62Bjf+OG2OwgGTbLyK?=
 =?us-ascii?Q?0EVO3VpYUTBw5d4XCedlQ19FV8tjY/2B6Zug5KYTl0z2u41UpBjesdPXHT9y?=
 =?us-ascii?Q?jX1QyNqc4EdAGngP/HFhqZwnsR9Gv4ci4reOTijOo2ZrQM1ysshlWyx3LwOb?=
 =?us-ascii?Q?iyiWZZ+lP1ivF9iH51/BVWA2WUD/MLC001iFWTC849CePiY+3hlsW0QN213X?=
 =?us-ascii?Q?Q0Jzuia92s5waJbqOQa2O3+4cF00RuX8vIQR9/OPPq5crOz/mAUaEsEeMIk3?=
 =?us-ascii?Q?rRLct873bb9P1Bomh0x3q1guFtweL4QnXLgUyn2YZ3WKKzwpvVcVD8P6KXGc?=
 =?us-ascii?Q?FMANmVtZPcE7mahMqDM8F6ccHJ3Ny5YUFmdq0jC59jig5QswE0VtaPYm3sOw?=
 =?us-ascii?Q?MuE9JQAyIQngadnfUQytucJGod+tvNkd0Ky8aN/euGagW5Cxk9QouNSbpsiU?=
 =?us-ascii?Q?kiMtghFv+hys1nRtHsg2FH3FyFNteoqXiVZ94Ryt8blbZEeWQsNaccLqz1b6?=
 =?us-ascii?Q?2Z3JXrC3IKxDT/DO0HutsQBHoZXTOwEQRQhNizhGfHj/AlRf49PB4WyAWhln?=
 =?us-ascii?Q?AixVfCXvYCFhiNzyqESXxTP3FFRH098YjBTg27Xi5oaczcWmm/vT08cOZYTr?=
 =?us-ascii?Q?MZjrXOyLAKNV8xa/psSuCQrLxExVSb18IlEHKwGcaaB+8KyshUp1m5xq438d?=
 =?us-ascii?Q?OBUYPgmyJPchYW69Ch2HIluFi4RC2ii6POhPgrqFCnQoe0JU0ZE54eQvtmoE?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xf1nQYlDuO6tIlR1YqiGgsQYByNsH6Gy/rDVyfsF0l+JeGGakU3ubQY1nOjxjNEDAWDfmbJzbc+1sGyxmZU/tBl6POpAUYQWjO38r+/p7xfYC0F6H1GhwTdqUJdhBxuiamn2+ciDzZHjz6E6v1wdxB/wHdj61xbPqlaHchrJ7FubTfxVM/sdln7YddZ7S5apjPxFmK5aAzlcIQOza5Ofs55glYMbl/LzFmOVdlRDYrCasp9q9ZCIfrlxRSXwwkj36WM75Fz2Eyd/f4/uZd7VigZKvvQFUy4rPKKC1jCfmuoJtNevArT5hlL+Q7h/HSs1kvaqyRfbseZHw4JjVN9NeVFK0pexHyNhIb/NcOX/plB9a0er5CQTIJBP6H6VAspXykh2tWpSx9DO/4uZexK4pEawTntlFSOgho0nNPby0hMv8m82wvGJLfTEsH5w8qSvuL0KnjZuVtfJRwBqJIHzSXRUaSd75B6gSg01Mfwu1KZkCIjUz7TvGmR+6sy72+4g186mNeJiJRNz/iBAoUU7Dz6cKVuHOONwh2jSKoNvn5IZaeDVTKH3FUDg8daVbn4eTfvVb76U7xqqTvNQY+qazzdjpjxqeol02RwnsG+QBF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ffa0aa-8d37-4634-a772-08dce1316d80
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:22:38.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfehvdfeXUdPd7c1HL36IXrj69aMYTgvmbXHX1Oe2CUE5wm/wrGGUQh42rjLt/6hpgv4rhRooJh5P2dRX6aT5ZA/9/J8jWrgurJc6GAG+Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_08,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=369
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300067
X-Proofpoint-GUID: jPHW4st28rztRHqyTNmQyh53CAtT__sE
X-Proofpoint-ORIG-GUID: jPHW4st28rztRHqyTNmQyh53CAtT__sE

If you wish to utilise a pidfd interface to refer to the current process
(from the point of view of userland - from the kernel point of view - the
thread group leader), it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process.

This series introduces such a sentinel, PIDFD_SELF, which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

The only pidfd interface where this is particularly useful is
process_madvise(), which provides the motivation for this series. However,
as this is a general interface, we ensure that all pidfd interfaces can
handle this correctly.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

Lorenzo Stoakes (3):
  pidfd: refactor pidfd_get_pid/to_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF sentinel to refer to own process
  selftests: pidfd: add tests for PIDFD_SELF

 include/linux/pid.h                           | 43 +++++++++++-
 include/uapi/linux/pidfd.h                    |  3 +
 kernel/exit.c                                 |  3 +-
 kernel/nsproxy.c                              |  1 +
 kernel/pid.c                                  | 70 +++++++++++++------
 kernel/signal.c                               | 26 ++-----
 tools/testing/selftests/pidfd/pidfd.h         |  5 ++
 .../selftests/pidfd/pidfd_getfd_test.c        | 38 ++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  6 ++
 tools/testing/selftests/pidfd/pidfd_test.c    | 13 ++++
 10 files changed, 165 insertions(+), 43 deletions(-)

-- 
2.46.2


