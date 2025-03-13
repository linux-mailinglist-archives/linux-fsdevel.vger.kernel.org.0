Return-Path: <linux-fsdevel+bounces-43928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1871A5FD57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6359D1740D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E3E26E154;
	Thu, 13 Mar 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n51o5sz5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eECLHDvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039726BDBB;
	Thu, 13 Mar 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886037; cv=fail; b=RpC1N9SeBpNwIxM8kw6wIsMAGGqtjP7AYUbdS2SZ1DI6A+5nPNW3KmCDZyvH31NvGTcwA9hBAwot5cROLjHGbsLkK6mDET/B9gcTQNfBDTw1cwnJx+FMpZg1OEKoKQ1dDORv185X9wLD1M+yrXeRbTvj7SfZ1npo1pemBdrjiXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886037; c=relaxed/simple;
	bh=amwXJLE1vGPzSSDw8sOJpWQ9heOydSwj/IPv7/GMp8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmbwFOufzMdYxCx0hRaiSS1pfT62ZtqWGfqo9MuE4NQm5F04DOD7KUTi1/aXkfu3a33u2h7r4LopOdHY8GEwEm0LB0Z6aWe2NiIzxH8fNCMNmRXUf0rQj6nFRCSN9upVdpDJvu5AjrSLJEcqh7QqqZSqrtLbtwJE5+m0mem9560=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n51o5sz5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eECLHDvL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtsKO020731;
	Thu, 13 Mar 2025 17:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BIB5CSopTiqGInIb046kLe7A7DB/mOltCKjOsRDD9gU=; b=
	n51o5sz5Tjkggm2kBkUJAB6846vqGx4CCxv+6v40vOgTmt7bFErMBj/3ld5F1hLC
	7dU/sxRFX3/hdwryPzJB445WeOmIdj27ONGtWWo085V8Y2gdh2TsB6D10TPLqSvk
	jRcDPq0R9ZGh+gQ1ZfDYVJNITqeNTsFUXhmLULqSPooxEFfkVbROkdjyM2xOUyor
	nVDmOhep4frCg5oUaNqiD8WRKMPo+Hp1vYvGZoRKPoAURRRFP+b/fmuDjIAI1jEL
	ZPeWEPa0jgEWRPxQtXvXw5LozfygKd0HFZHCiXsIetcvHUau/yin+7BTXvwCP94g
	EvWm1qYT2tMjX5XSJUDb/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvpwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGhBS5022290;
	Thu, 13 Mar 2025 17:13:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmwwrhy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSM3pEa9ln+v+AezMkKLjEJiV8WwjZzbcmkqMKpFzjo64l4Sr2tp//xGGDD6xVhs3TNE9O0fTBwt5mFFSiYyBfCjgb8KkGe9orx2sPYa/7JNjra73esq9hH0ma/9XvI/tGmsHFtEUNqmlq9gTI3TNI5AO6nEsCiKdti8MIh/PM7veqCj8/imCPq9QbuzDvVrtL0wknqHd22i/7Y88wNqUAVk5ccIvgrhyhlrujl9AdkNO1tUxXDXE8ll1F9wVQ00iWmzDXWTcekKmLdXfgHyiiSF1U/4QyRefJu3zYaPcVK/c/e4jP67oqvKwfB8jUjXs1RcPtSpuTksCGRivHtfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIB5CSopTiqGInIb046kLe7A7DB/mOltCKjOsRDD9gU=;
 b=FtZ+3ujKDMgd96VLT/ANO2CDbYEINzNU9JxbwkEc811QxK/RL6IV2kIL3w5N54ASMU32jEZ/k+ULzj+g/TUy+W32DNBEaMLQDRAs3xqT7A9ehRBlW3+s2vhZXz28oZXKrsuDtf8eNCKeOjvZCmT09dQwj/rWfq7DsqpPWQLIfEaOYv37ZngWXyBCWQuF5ZYeL7PQu4Da9lXNyS7I+ncLF25hGSgmX6nNRRU9cKwJIWBuqfN1t1RqYAh/oxeE7BdfZk88NijuEihhzjvSrWZCONSgVUlwpLdo0sgXasEle6A9fbbfdj/yZ5Pyf7TQkIIBZ2PV1zuEVjKoJGRyRl4vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIB5CSopTiqGInIb046kLe7A7DB/mOltCKjOsRDD9gU=;
 b=eECLHDvLOzsnEan/0b5YytgZeH1EzZvr20hiQ6ZXI5AAyKNulIvTFnVufsJXeg05SLfHY82DHOd5iEuXJ8gPM8n+e1WQ6ypROMrBBsgeePS3MhsV0cDoLTJy6N5Npqe6CRcanuC7M/RzKBMX58q4gx8+57qEHaXhgfdevgjDNnE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:13:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
Date: Thu, 13 Mar 2025 17:13:00 +0000
Message-Id: <20250313171310.1886394-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d2dc58-ad6d-46b9-cbb1-08dd62526019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDscj3nXAVakQjvVxc7YSS7/gNPn10CkzIkS/xGvwEtmt6opJAij0UEZFtU4?=
 =?us-ascii?Q?l0r9cb0DT0uaFj5iGDhYu5SMjfN4pmGeKbh+DyjOPLO4waQZjYYcxW2VJuUv?=
 =?us-ascii?Q?sod0L2JiPzwicpl1R1kIesd0qRAPrUaeYCpa8wafYvwIZ5vBktdGAWZC31Sm?=
 =?us-ascii?Q?gdhGZvv/rfjreMsIv8dTYVcCWf2XQwS9TwFUeWO1bzNBnmPT5uf1YoWcEJxl?=
 =?us-ascii?Q?FnyPETtAkeo0BPTdvXqdyoNVeNoumIM2/jwlDlBEW2pOJLzD2F76CHwtosiy?=
 =?us-ascii?Q?ORkCfyxBAv35JCjRzG6J+tVSfNU+BApAaJIPbARiIf1NoGO79+GSl16/x4qW?=
 =?us-ascii?Q?rSoLFADNbKMKnW3/vB+CmSqix7DErA9bVrknbcM0SjCzJbtJfTNORTANBx2X?=
 =?us-ascii?Q?fQpqyl52xIGmvMw1ZdMLyjCo66W/oi37FzRbgzD66rL7vrYBMGu2/OhU5wra?=
 =?us-ascii?Q?VA1ZSGWwQ+BQt/c42fW+ShZFRUNsSFNlV8r6gvdFi+ajUZQ5LZIL1t+T5vvL?=
 =?us-ascii?Q?sE+0qw4MtfLYhvH+LvhcPq/XphBPcanejFurZeef5KWAcREJlBmYZu827GSu?=
 =?us-ascii?Q?EwYU1spNluqeKHAHkD6RZnRsO9IqDK6+VlhE4hvwIAiYhJgCNp8TaIvPJep/?=
 =?us-ascii?Q?ZAp7TGK0f9XnfKVRTOBwBqvGgQt+2e5x9oDpNptR9QcYXh4HG/asqtFFBiXg?=
 =?us-ascii?Q?7ai0EDnI9cBnc2/3spOsLl9wGedz1nW90CiWuDgtDidNmAhprFAHJNu7lwFA?=
 =?us-ascii?Q?Rm0Ln9p+sQKnMq/LSFrc1oB9l42wnQzdWHL4M9o/fNYIVbx4K4tFKUTQDx1y?=
 =?us-ascii?Q?xIlAxi5FbrL4fARUZpvhWeXCiad5ggI28r+fVQwQKEdzeaFJeuuj5PxhYDSw?=
 =?us-ascii?Q?3ckZUSToT4f4qBgVMklBtVGzOh6YwtRpFM2TCm9oSuNBhM0Y70ztVAwo3su6?=
 =?us-ascii?Q?mZwu6AMAEUnBR/Jh4GXF9PfS3idPEatIyNSpO/F8ljk1Zw2IU4/DaxGhUnYd?=
 =?us-ascii?Q?bEvhxLM1HPFm2CV6z1EPuk1i/dO+gGd/WoxU0Jk03Xcs9nlZtVSiDp5ngxJd?=
 =?us-ascii?Q?mvXH7lRiW5HmoMgqdVe4OBaNfVmgIq30uZ3W+KkPLdRuHBYwWlh0uCNq7ODx?=
 =?us-ascii?Q?H5i3SqjPfKjNMSWo5e9TmZl4izhAJHDzW9T2xfMdNzfnCVeLP4908QMLXDBU?=
 =?us-ascii?Q?NzV6bUuJc11n0ibwH9nFAc7wl1HDQvfzblR2ftXONUPtdaXPYA1XuEmvBz84?=
 =?us-ascii?Q?JH+8MYpEAUNp49V2HBoWpmwlnG1VSHeLpY9zLc/x/1BjnEqS3119dCuiXLNK?=
 =?us-ascii?Q?oA5OlgUa/+wi+L1nwTKAlpx/NkhSGU7kDfcpUvzDHdjXLV/sYAAn8VtdScum?=
 =?us-ascii?Q?6wsnjs9yl8/WNExM1sy8ks868oRR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V40YtanU7uNbcjYOK3jvH6bS7E+rdahp9g90iAGjBh/fpo9paHYuvXxLa1u6?=
 =?us-ascii?Q?TeteuiEp3pqEngMKtalF6P9QTfK8z9U5G47qLbGyHCD/+LhkAmV+kpMWs+2A?=
 =?us-ascii?Q?Qn/h296UbtCQsAsg+pVOY31C1t5pQEq/pS2IRziK2Tfwo4nP0PCZ5wuDSnPj?=
 =?us-ascii?Q?iNR7aUsCyo7OLHrLRXh6TcZurK6nkdAb65hGK/9Ftj5K3CKoYj+NhSq1x3o6?=
 =?us-ascii?Q?XPhylcxq8fNItK6PvGAeM4+sMAXMW6LA0HhNEErCDAlFnkg4bfcDR2ts3+HW?=
 =?us-ascii?Q?I9NRWYaHbO+1xFlL0lEJLnTgwShhbCsY6zIJU1pwcKB3qJVZY/5pOxfyE2LB?=
 =?us-ascii?Q?rCfJ2zpPAMB3jjMqGpfhR6MUfLgKGzBWrjeoEUujJC7rTxyKGNMhA2Re4hlO?=
 =?us-ascii?Q?ydhv5BdInVBEPsVNyJ+jf5PJjCId8VqsTza8VlPxDpMnWXEnepaHYAxszU7u?=
 =?us-ascii?Q?TQuq1Wn1kTbGFgvmvy0Gu+8Nu2YirNZgldJlrYBdrfU8OGNlzsH/urHtEWFq?=
 =?us-ascii?Q?bQrtkPCJ5h8zLxbpWUQvFXC1dQvDABlMmVexVwZ286x+dhyWnqk2rFEKvVkJ?=
 =?us-ascii?Q?Vi4UjVJdhNnDTCO+s7g2JPY4QdpLUVFVGmRwOiWXZk41GsQogFw6ZiKs7tO8?=
 =?us-ascii?Q?HIJI59buI5o/djhDisoXBunGx6tUgp7hbOZ2R4U3WqX1f/BBqr5SudavvXrp?=
 =?us-ascii?Q?s8QLX8/21IJfWhOndHMjTfslnwMFptska88SBS9eSNYVjm6CMg7XrJlVs4a8?=
 =?us-ascii?Q?JdcMNv0lgQK5v/q6zzlelVtubb+J8DGdKgDf3N1m2ctzjdQ3KYEVJhc0jWZt?=
 =?us-ascii?Q?b1g6aDboFxLYv0OavjgPJvimQ6/Q/tvv72BxCcNPAE1WrD8K/NNx2Pu+ByHM?=
 =?us-ascii?Q?bJPCxnWjgnu7TZ52UzWOZqUupGnBkU6Zdx4xFug+nkzyUnk4BGuZiKQbjOhj?=
 =?us-ascii?Q?58imxzkA1SSR44Fp9/HBITCZ9YPiIA9OVBFFuU8V10SYY3PPTDnzeMXUU/iN?=
 =?us-ascii?Q?3UWSQtE5u9DCKaQeR7hG/0de0EnoMdiJjScFjiVOgYLFkyAWEY1kJhyxlCDr?=
 =?us-ascii?Q?1csveUpjP/2SOeOwi9TGCxJ7kq8i2+BI/SqToVqXa7v+gbfzlo5SVENeISrr?=
 =?us-ascii?Q?fuYX6GD2CPiTsoGif56Kv67GyjHChG7/2SXm2tAJSbpaI+sZL47u4YcWqKYL?=
 =?us-ascii?Q?EmQLr48tw7s9+NtCwA4ppumSlMwtHXwJ7AEVYnToj7NuVLxT+7jLQD+JRtvs?=
 =?us-ascii?Q?r5K8FU7bZZWjMNOqeUYBWf19p/tMzKA59rZbuCvibEgIOcAMEtb2ltfN99yd?=
 =?us-ascii?Q?JIY1j5H58Ye621GHl5xeDx4kPj0eGQ1gBRKR5CP4RTvOpybOCdy2QTebYRNk?=
 =?us-ascii?Q?yKe84AAtnWT5c0vfSdWiF8w96mQE3ME9hQC0jUls7rE1JbXYEn5ay7yYJFXh?=
 =?us-ascii?Q?yP7hKlEYW68hQLlVEBHZCi//RNaWsV0gTO1Z7+P/Hu1v193mRxh71R7oG2Ip?=
 =?us-ascii?Q?A++zXaUulW15GE8zUcm4Ze6ot1u0BJBA9B4oTgVewCpiMRUyncsYB12NkxN+?=
 =?us-ascii?Q?Qe5+CN+F9kPuAxBpr7gz5JSKc4VObijxhSGILN8JYxETks2hW7Timn1eLbL9?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pI+8nvidveBfH/l959VyjB3PDx7wxt36Q1+gKghSPhU/9mKSZIF+1Xwb9LrT2VEhswCNT5BICwWAqVnBo/mtHhb5L9NCkQd6AjP8KS7TcA2iFrgCVM0muzjckou1Nw7l0MDbwNS7YkTpTW44LCweoxcQg2Wye5TckkbzRGQqQFhlXztbKe8mWBpdNZfNcDuut3ZqUNfjuIEGseGmepFpTt+A1tU4fE6f7Y0bnxOtleVQyzXSk0go1XGDPV48WGnJO53wkYS62G6j8C74doUARQjhFW4NXcMkY28HZ1ebagAoipY8MdHa2kXDF8AneRwQReIhrcLvmiFm+PARJKWLMn3ppYmcnje25w4dCTt9/0SOhQTxXEbHrO43hxtHvvs+vQ2tCJYsfhhSG8bR5GMtELyiIepGIJWpR1przhya/Vcfpu69r3tjEH84/QFao5RSUGYVfHGRd7Zk4mj39+GymKEJhDniygMhvJvWtu8ZkaIGFvZqBJI8X/QjNxxqJLmjgdn517g8+p5Pta50Qqi8lle1FMGBRzl7XrvGNRd66rS3SnwcubWa79xpPhNka5vz+Yirw3ndZ+cDdBJqXj+v/xODhK79irUEUC2LX7s/6Bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d2dc58-ad6d-46b9-cbb1-08dd62526019
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:29.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIFfuelLh6LXenJfxcQXU1CdNrIV8mTWOCYvfE6RGFAJHv/8RIWhoYEXjR2Qypn7jPoyokaFFRzK7Petnoxlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503130131
X-Proofpoint-GUID: XakM119iMDJrPg8xoOPd00FREIsDVXSG
X-Proofpoint-ORIG-GUID: XakM119iMDJrPg8xoOPd00FREIsDVXSG

Flag IOMAP_ATOMIC_SW is not really required. The idea of having this flag
is that the FS ->iomap_begin callback could check if this flag is set to
decide whether to do a SW (FS-based) atomic write. But the FS can set
which ->iomap_begin callback it wants when deciding to do a FS-based
atomic write.

Furthermore, it was thought that IOMAP_ATOMIC_HW is not a proper name, as
the block driver can use SW-methods to emulate an atomic write. So change
back to IOMAP_ATOMIC.

The ->iomap_begin callback needs though to indicate to iomap core that
REQ_ATOMIC needs to be set, so add IOMAP_F_ATOMIC_BIO for that.

These changes were suggested by Christoph Hellwig and Dave Chinner.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/ext4/inode.c       |  5 ++++-
 fs/iomap/direct-io.c  |  8 +++-----
 fs/iomap/trace.h      |  2 +-
 fs/xfs/xfs_iomap.c    |  3 +++
 include/linux/iomap.h | 12 +++++-------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ba2f1e3db7c7..949d74d34926 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3290,6 +3290,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
 
+	if (flags & IOMAP_ATOMIC)
+		iomap->flags |= IOMAP_F_ATOMIC_BIO;
+
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 	else
@@ -3467,7 +3470,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC_HW)
+	if (flags & IOMAP_ATOMIC)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9d72b99cb447..c28685fd3362 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -349,7 +349,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
-		if (iter->flags & IOMAP_ATOMIC_HW) {
+		if (iomap->flags & IOMAP_F_ATOMIC_BIO) {
 			/*
 			* Ensure that the mapping covers the full write length,
 			* otherwise we will submit multiple BIOs, which is
@@ -677,10 +677,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
-			iomi.flags |= IOMAP_ATOMIC_SW;
-		else if (iocb->ki_flags & IOCB_ATOMIC)
-			iomi.flags |= IOMAP_ATOMIC_HW;
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			iomi.flags |= IOMAP_ATOMIC;
 
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 69af89044ebd..9eab2c8ac3c5 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 30e257f683bb..9a22ecd794eb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -831,6 +831,9 @@ xfs_direct_write_iomap_begin(
 	if (offset + length > i_size_read(inode))
 		iomap_flags |= IOMAP_F_DIRTY;
 
+	if (flags & IOMAP_ATOMIC)
+		iomap_flags |= IOMAP_F_ATOMIC_BIO;
+
 	/*
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9cd93530013c..51f4c13bd17a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -60,6 +60,9 @@ struct vm_fault;
  * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
  * assigned to it yet and the file system will do that in the bio submission
  * handler, splitting the I/O as needed.
+ *
+ * IOMAP_F_ATOMIC_BIO indicates that (write) I/O needs to be issued as an
+ * atomic bio, i.e. set REQ_ATOMIC.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -73,6 +76,7 @@ struct vm_fault;
 #define IOMAP_F_XATTR		(1U << 5)
 #define IOMAP_F_BOUNDARY	(1U << 6)
 #define IOMAP_F_ANON_WRITE	(1U << 7)
+#define IOMAP_F_ATOMIC_BIO	(1U << 8)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -189,9 +193,8 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
+#define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
-#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -503,11 +506,6 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
-/*
- * Use software-based torn-write protection.
- */
-#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
-
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


