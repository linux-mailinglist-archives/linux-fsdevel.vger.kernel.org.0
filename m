Return-Path: <linux-fsdevel+bounces-46927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C458A96966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8656A17A0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533227F743;
	Tue, 22 Apr 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcH8vusk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMwzBz1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602327CCF6;
	Tue, 22 Apr 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324922; cv=fail; b=uEOUTPhKaPzSwBG2h2gYaYT5iIeFc6U2QajQXq1r7pJBuWTekneVSQWjJ7sQ8XS7kh5oj8IOkQK4sFJR6/t1CdTnwm5mlIGai/pfkElwGs27nupmoqEX+EoiKGH44tKQspO9ZE4oDx1fBIgACd5knJVOfISY0k78Px76PgE3BjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324922; c=relaxed/simple;
	bh=/Gc9YxwkEPXlQwpTWBqIaTS+N0I2IhLUfDnljXWFgSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6X2diB12+r7YxygsHVWhGaAsmdc9lR6pbuNXS3kSuC5OwOyZRQFUlm0R+Kpt5VCVWjCwEPdkkdVQU/ujkiLjkJ2XWD2qa1+FcPWuuMWzEZ+cUWVtCD8k1PvxfvwfhrQFiLQCCFW7s9jEbTcwgiPHBck6XZADBhCD8TINZ34dPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcH8vusk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMwzBz1j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3VOZ008552;
	Tue, 22 Apr 2025 12:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=; b=
	OcH8vuskO/p4DtJ2uKKnxrctGA4ZJmvtQgH5V6TJW91HcJK6S3HxM5pwt0esYzl/
	hTI9z6AupFgrcGfCx5TjgDqrtbVnZufXvz+AILsAWPf632fUSUqqzuSnBhMKABjp
	1vunZjG/ajrChtoVaHvgf/w3UxsB+5gCOPHs8VK1fKV5jEXZBJTOXd1YKYBwqbkl
	2+lKhCtpLEn8UE/P9nw/iqcVDfhHah/E5bgW92+c5TsdvL4TJda5hCUGNKx56dYU
	c10dTIg/wV8gYM2xURDUDz2XScSPqYQ3mURChJvkQ73BMh9CCH7XCDwtEkYIgHy2
	n6aQc07Ht3FtYbBgq1rs1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cddx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBidUZ033447;
	Tue, 22 Apr 2025 12:28:27 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WToPI8gfZSPpbXjAUcxCvZkJDOxrJ7aB3Z18KqXBFil5qud0dsV5D2D4kKIwa1a8RYskhBM/lISm2s12lNMtg0cyQ5JSRO51mXcrIoQLnknhcPEXr5pGEolmP4gzzr+f0PyowCNI5wQogv3z0USmXGXdPB4VpIVVIDUlsRIlyN6XA+mDPTAbkkPUEZFIKKsoPVXuwy+W4mJps8tBYvXw7YONAdR5P0aSewg44GqdDBCFl/FaFkE0rw+i4EAh0500s9z96FacF02mfRwxPXoFrvGIon5Uexa/kwLCq7t5pTYH63vPEI44uGbm8fH7Bsxhb/tZzi7APqrhX5YwUokTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=Lq0xfDl2cikf+D05vjjX2qj9bVbFYjmsfKZNMMFsNCZZDxxni3qU0uvt84mS+R1xjlHQkF785Y+g/otWjyaxknpT6TryM/mc0EEpfyuado+/kSqQX2vfAMUkEgeXP35Zh3uDgJT8Zr/8/2E/ikmvFJ6D3/2HAi9QddvJlbcXnd8NjU0Wp6F2TFmrFqJJ077kNQr8wzJGvXDNcr4CxYs/uUUQGnPenXnxN7QMljten7aqh5AULD5trMJUOFc8inxRyTSxaE5Wpqif1XagXJA12H7fHwAeL6YOGaqkU8dq1abfb7pqEYSnVpY1TduBPrSze1L4en7IVZrzI4JRRFIqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=OMwzBz1jktTbo+7irYxc8v5tFcBPuN125WhjzuAIHL6mliY0ZDrvKgAiIwcsyasM2KqvpuGFjmWqsMJqPhKmcvxGVVK2TEZIUIoTdR/QsyY8kchccnLONiGcXMXKY863MbkI26QVx4QFaUe+iqn4Qxep3Txr6oaRVgCogw/bCtc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 02/15] xfs: add helpers to compute log item overhead
Date: Tue, 22 Apr 2025 12:27:26 +0000
Message-Id: <20250422122739.2230121-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa8e2fd-dfd2-4a04-8aec-08dd81992d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vi2L3Ak1RcEMMQC3fUkrDhALuaZf75goPViImbavfo1DRZ4J3elcNIhADG91?=
 =?us-ascii?Q?9+J7t/wR6YSGtdDnuy7CgJZCPNxpm3KOgdgTrpXlVqImDs2NL/L/zxNXwPsr?=
 =?us-ascii?Q?TWBUse3trG7406vHtzadoBGFv+WsXMv0RWX7WqoryMPNL/O9EGHxF1tyxwGa?=
 =?us-ascii?Q?GA6QJam79h1NPQDz8EEsKGE5fUvLqU74biTChGvXapVLNkRIt9nQtwQ3Jr0C?=
 =?us-ascii?Q?iPAl9a4G7KSPHMcLQCLweFHViTY3i2nzUvwrLIR7ME8LfuMRL2A2crjYecBS?=
 =?us-ascii?Q?S+6WnMyDfv0xccwP42qeoWZZG3BkHZi37SGXShA7W8IfEY0Bml7YNokNK9sp?=
 =?us-ascii?Q?suZ1d8T0vXE7xdh2gFNCqx3v4oK8yJ7Q+iMyvscBTOkC0idb2WWvRDHPhE0i?=
 =?us-ascii?Q?7UbU36Nikevyc/Lwh8utdevQKruCpPmz4KD80iVZ2ot+4BlYgWLg1XOBsXCv?=
 =?us-ascii?Q?9nVIKuf/9gEt+Rr8RO2GCcdRYDfuxt6UY/QBuxHHQsZtgbRqTkHLgbEbWYW3?=
 =?us-ascii?Q?rwHyg1oPo8mQSfq5XQ5oQ6fkhlmHvad9NjF4tFpPb3TfVqbUcA5b+vsF1ciU?=
 =?us-ascii?Q?TvngVOwvoFqB2BMY4NvxePzFLb6UDNYQdJbBeDEY5JorGwZh6pTtY0PbdOiM?=
 =?us-ascii?Q?wSn5vgWmSltWHWd3CgbsMSB7Y7rqK2GryeQjehTS+6YNoPK/S0aEtUHpVWwf?=
 =?us-ascii?Q?GuJsTci4fD0JITRmkoYBxSATsG1de7JqTOWRhC174iEWnoY9eX1sCConxso2?=
 =?us-ascii?Q?XbnReYtCpEebq6cXCPBHHQyTHFyK33O7RyMpbcvov6drwTWK9ZdnlB6n/Lq8?=
 =?us-ascii?Q?x6ysK8EMprOQYVAX0WcaIt1DCRT4LmxkJ9QTXz0N3GEwQGUtH1Zzc7z6zZpg?=
 =?us-ascii?Q?DQ972SsstK7/wpynZYNCCY0yR0slBfoZorvRHvvXcIc6q6v14oI6Xt6ckHqP?=
 =?us-ascii?Q?XJpB1rBTBe4WrWQ5l9466xrkTFAJS9BhRNbVgoru51wzbR3WffIjsom1xqY9?=
 =?us-ascii?Q?YVI8vNdCIAB/wNtEf5yLOYTGK+RgGmp8g2Eatate8BoTzaXqULZaI7+o6CNd?=
 =?us-ascii?Q?ieehMU9J0esuvdQjP2tQmz2iQ81FCIe2LqjPKMJrb5Zqf9SM1UJeSxGD11if?=
 =?us-ascii?Q?xadyFqD2+8pYnXSaCGXeKZ8AbmqQEOAmiNj6Lu59FXcgFMvmQrOI7BD7Fs+p?=
 =?us-ascii?Q?iu+OglclKpFKDWKxjO3+NqLSMjvdtUi2HctH+7IdTdWk9uXNkYrqaESXPZ5t?=
 =?us-ascii?Q?W+ExY7vW9mlOj1kcRGA9rOgMStl8znj3KhJTNzTIeNKVn5toOCgh9eIpy/Fb?=
 =?us-ascii?Q?+iEITm/DY6FYINeN92Ig2Sm+qW359ZLAW5w38lkPL5sK6uA7VnkqTaGYVRtL?=
 =?us-ascii?Q?+l3s3RZwH33/GQrdV7pz+k8K+zacluoav6ColmAzd5i+jypk4rzFUNA1pFEN?=
 =?us-ascii?Q?Efzsc1Df+/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtl4NRES/1ExzyR/wzcwuFPk4/Oyfvja7duYmBrublWgyouJyB5yDsbB+yq+?=
 =?us-ascii?Q?e38udu3fGyQ3Prip1CJjePJ40/8PA/9CDrS7ucYFUREn8Wg5TLe4Ecud7dFL?=
 =?us-ascii?Q?7C3No7svyr9CiR46pYjBfnB9Zj2I62TmCyOuNNoeY0wRi84OP5stetdQlIHM?=
 =?us-ascii?Q?SXDjoccR35yHncAdy4VxXucEyCnJexYnBWO1pJ9xlAc1sIJwLZcJ13URFwcs?=
 =?us-ascii?Q?zSRnnBUKHR3LVirZpEWF1NObFDgaOeOK85qFSmAzSP27GC04Hh9vQdC4RY2j?=
 =?us-ascii?Q?Yorebq3EJeflTKyTK3dOpjk0Kk4ftAT0yQs4WEhwhXKakxdxf2F/4+uGj9BJ?=
 =?us-ascii?Q?bLrNO6ZNI3ygbkyzeGGXjwE671h/R+bXj7NPl27+nfDtvR6pkAIRcLDv5Aiy?=
 =?us-ascii?Q?Eya33Y/PaNoujkbCRZTV7cAlS9A109DmTD15QEYS7TcNnxvDnuc+o69Ce3wB?=
 =?us-ascii?Q?/FqMOz8mCN2yg4dJ6UhF86F+47R2aQ0aaZi9gsvN1JV3lHjsiJwq9Jn4YN3d?=
 =?us-ascii?Q?R6ucosXG7pdJwpEj6qvxMvqWCyxiy/dTckMgQvR1wH2B9cEr/1+svhk8XssW?=
 =?us-ascii?Q?7Z7DdaOsroFdg9fZmFQqmhS2Bj8RzU+h5++sOHN2pF3jOZ/a5a+ah9Wy+1jA?=
 =?us-ascii?Q?F8W7K3FmW5eVWoEQ0CThazRW/JKqV2oPSya8gUonFoYMfsxhu3vt4oR5WzBQ?=
 =?us-ascii?Q?qiyGtVeNZSO/btwkUd9YL3E8yA/E7hwoqygEISbJ2Fdnjat7JFbk1LB8D02H?=
 =?us-ascii?Q?RG2+OsexiqCUz1vbu1TocaQ9mh7jTjdapkIGzwwI6hngl3ctNGBVmx7QFwev?=
 =?us-ascii?Q?BD/rnYg7wh9KBtA0s5BGOPviQqfQ3Yxun4MxIaeh2enK+nqijBv5GuMl6Twl?=
 =?us-ascii?Q?K1nHhKUmA/N0Y4qdFWjG6VeqizUBVXR8FaN6+u7R/sv26NceFyAAhdyJ3fu+?=
 =?us-ascii?Q?33o+lBDPy30jvun4LrNHppeI5gZLxyln8XM1j73+cBFLu5DBA56P7JLOFG63?=
 =?us-ascii?Q?ICiIGRghrBDxkBJyihmV3dkJ8PghrJ/0G19HC4vwD/rej62x2T39R/34NPEd?=
 =?us-ascii?Q?5YhZmWuaHIN6zHVnN+Wn4UyLD0JJowuhW/lUFAGCT6krp+Swl2HbCEEF2uZ3?=
 =?us-ascii?Q?uJbjIkD/jhcCBCUCNu78QO+kmy7sIBcbmEEgwEYrF21Zorq6SUo46ppXOK+g?=
 =?us-ascii?Q?1OctBnMSQicWJyQoCnidqyQebBAvzZ5CXONNHujM+HKh36wYrQLIq16ioe02?=
 =?us-ascii?Q?nF8idQvJxkM95/MDmQcB8IBBPFQkGrXAJwxE/wJWJoiUAwS2zz76noPBOsPH?=
 =?us-ascii?Q?Mvsrcsxb2PIGknafBi2OYXSqSSKPl9jwkxl14kQv7JT3yxJiXUqOhWV4wiuW?=
 =?us-ascii?Q?prrCei2Zxso2llTY4DE4+eJ0tEpzB8Z8DLqTcKANfM9XLlGf1e0IcL6xis4S?=
 =?us-ascii?Q?ChWZxnoDUGo74kuDn+JbBgC+OSE6j1U/tW3m53wXyezugH260ZgeW/i9AwwX?=
 =?us-ascii?Q?nhdBabDQ7psMf0aFVxXGcWmf92pGywDJpLr+jOgkc3cUJ+q61UOhEzWl0mhC?=
 =?us-ascii?Q?dE7uyioMlA9mbPgKEPK61aWtbw/6BKg+EipZY/9ZAmVcOnYqDhnuVh8NeNTC?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lPnkL2GZ1kQp070lmo4MxyD6Wrb1HsOl+reRQVPFSfiPrIExfpq0wXntbgms2MUWMozCRr8jJX9TSPzdXNQebvSFmAhF5Kb1+U88ce4GrlKoj2hZE7b1L+m9u+a6QqFTaZ/RwuByk6KZW0I2MLRB1JAUBwJdKBvjwQCxBcS5hIav6+840hArfdz6fQIFxTmFcghCx2AW4szu2zCdx6JRcvt2I29BgkOeV0UY+Yf+d5WYTn0/lJfS9MCelPg35Jm/o2+UISzhcgU/hPLTGpcC1BrYRiJ26DbeCTltsm9NAyNS797lPUaOtID61+hoZM3coHg60+mNZ3daIwTOKANriK+kq5BXkdhAnGJaRqWBbihVBTQ1pLB5Jj+2ujKqv2Q8C+5giQ98AIVa+hHGxUGbKC8Htb5nfvuFJoclDzOLUI60xlLcM3W8915aicthskNPGCufbxXWBtXYH9KuiyYQdK6nYzDNgfbwdgACR4mhaPzpJJ+Iu+xFSNSTPUB/x7sqsmHn4zhTIyNHipPWfSTqdcBDigmEhwzydfUdHVbqADpH6oyO731/2uORDoqVUlCOx4N1QosMv+Ip0bpBX0aLAuosIqBVKGCQSCUYExS2VX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa8e2fd-dfd2-4a04-8aec-08dd81992d12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:24.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1llzq7pQ2w7Ru6dvZcbEDELDUhBWSaBYcFWvJKqmAURn3/k7D+LUsZgYZbmnQ6Q+GTC0R9til7V11pK52SBGCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: YFHNpZh8WP8FitKDzQaIPPGbWVnsgHmj
X-Proofpoint-ORIG-GUID: YFHNpZh8WP8FitKDzQaIPPGbWVnsgHmj

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


