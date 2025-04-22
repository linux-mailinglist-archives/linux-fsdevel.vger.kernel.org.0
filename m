Return-Path: <linux-fsdevel+bounces-46931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB1A96995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D822189DCF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1432283CA7;
	Tue, 22 Apr 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsFmNDOH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ubEwADZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64802283680;
	Tue, 22 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324932; cv=fail; b=CgmUs+3C9IXdwGmZJBCEtzq7JbsJ2M6ieWAEhddyvlRuqLlBiJtG9368iL9u9d6zRy7p6+5KVNryq4qS8zaMTpEZvodbnGgyqyNqTk9Np6dFWhLZMmAyFWJTQfv+FYOg4gMf8QFG1FXZlj5+ktXQNzAnyg59HAv205BSEGg4Mh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324932; c=relaxed/simple;
	bh=068dv9XImlZnzW12WtVPfp9ICZNAnHZ2liW2DZTv9PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuebBOfLi4hgtsU5aLx/qGiw8bOJu4nY0GC4sVScwoAVihBerCoiHtaxoJ7FmxOEuyQNpcDJYzGzDHL47GeSMnSgXT1RzqqZBmAmmJOIueWV3JRLaLhvUSzoo6Q1TnSaSxJdSLxHCywHlKbFlljxr9eW4rcXS/svesAu3456IMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LsFmNDOH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ubEwADZs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3Vql004230;
	Tue, 22 Apr 2025 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lpktmXmYT8DcJQpgNACg1M/RAnm7ViUWfNS2ntYoMeo=; b=
	LsFmNDOHcvZHVmZezKh7dAtOA+IRuxRD+ltJPqkDPOW91nfTJmQJ151KpgULuF0a
	Xcws3HbrJMUANAxZRTI33TNMwBK4J/dRAStEKBoVJ/H4bZujGQESZRVjcv4Iww87
	44GEfCAw7xPUpR3uZOppGGMb/bILWsl5k/8gskM3aj4ebUtT1jmPmpdadG+2ZO49
	v5PgvStuBb3w0vy8Ep/Xsnes41MW5viInwcSADPC/6AMO1cGWgTkzacL21Kwtgfh
	o1Fmcz+ndmChe+TFgPSGOlhmnU3gChXvhf6SWNtaojBP/VP1UDnxa7WGzi74QDlg
	ihZgFp+5TcsJBZxfp3HMZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8vbud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBOta3033464;
	Tue, 22 Apr 2025 12:28:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rtr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1K97+5P/TLETVerCaCwmWo6Y2kVVpxovBKqYHjwtqyt5rUtIqgrXVxXWhEmwVJpBqigzeS0TdzdPCOCeRaL1Z6GK7CWiWk2DJHnlA46jhxGVAj/3E7eSONAcTEfEMhl5+2Y7Zc0wvgn8h3mB5UIXYFOfvHeQ7qQLJjIvf9BuHG0IiY/sEjDBSflbuEp5fkIbLqSfzmBSRWSVbGEkHwyRbKoUAcNA8pVWxplui5oSesjSIxB/u1kEpjgtPYXDrV8uMtSHIj4x2RkJlZv2oiFWlkD3Jzy+KZJAwcMEWdl5YzfPtvYlJvvsg3pQMRjtA9k1mcPNy8aBOUotRZuxx3Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpktmXmYT8DcJQpgNACg1M/RAnm7ViUWfNS2ntYoMeo=;
 b=CdcgskxKUiMs9BWZqm/Lf6pYJx/SMxQnFvPJCcmnQvZgG0f7X45FkT67NZ4g8xEQHN7pI9jFV2KBSkfDHunxz0P2utZK8Ln7liFtfGZmQTWQIRSdGzo7ZpnX0R3GzbGc2OCbMvKoWO8SIFrCPsAjTR4GxeWwBCXiPLO1u+dQhcClSjU5a5qsOroKpklERa03aJVgdpIyt6VZRaVFL6pLvvZa6E8YiH5agNkfXySyu3M8UflPtMtNCQ14WERCQHHm0vh01hn5oc1s4s4u0iPjGaDbpFI65BocINS0HfeRMhEsZXedy3cJqDENglCqP0cOx9M8MDVmQY4TDotPGZJt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpktmXmYT8DcJQpgNACg1M/RAnm7ViUWfNS2ntYoMeo=;
 b=ubEwADZsuYW0btz+Uyz8wXUgd7tB1UrBspVa6LnCSzAFDWzhNMqaVHe42IjzlTE1HIrykMqWdh94P+8rbRiSqLTXvRh74a2W4CU5ZeFis/aOz3uMknUO7TnHFJEjgZAElm0jSfBmHT32mHlDSEws8gZc1OymmQBAtXxC9nw183Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:34 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 09/15] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Tue, 22 Apr 2025 12:27:33 +0000
Message-Id: <20250422122739.2230121-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 53614662-9081-4a6e-a42c-08dd81993339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Bo/9R7pvizb1xc8NR5BwOVUs0gcj1IRNl8c//ZZ2BAUumO9bdgGUQcLCI0O?=
 =?us-ascii?Q?zYf44+92UF4ZAwnRn273XsOLeLr9qaI18VlRoGMss5vSONCOPx17kjTsG1v3?=
 =?us-ascii?Q?FOq2hnhiSGqg1GdoIrXZLZQOijwVnxGaUYBX0an46KL0037fHoAsdIjyZT/h?=
 =?us-ascii?Q?VIVutOFi0IJL2/MRObmzFYKjfARRiIFKxzx3O+wKWSALbpVRqTqI/TU6LSyB?=
 =?us-ascii?Q?aRt574UNzIaYGULHfxOt9pyxoYxjIcdEvciOWo8PlcvhCtIRmlZOJzvJAF8H?=
 =?us-ascii?Q?aRrDpEjwOS51xCWYoNzuLPjvqOeZM1MdOpvAPQCx7BLJm/uGA9NQ4v8hbzYP?=
 =?us-ascii?Q?9/dReQmeR2fOZLuHKyTJmcAdv+Xhsa7gq9z4hIxfpRSCUA189lUdskxIFOIX?=
 =?us-ascii?Q?bn407OOLwgUu+aAQFGBRfPn4oyYdXjBFmPW03O6dSSCjryPju6wkcsv0l7jr?=
 =?us-ascii?Q?HkjZYLLf649rRQchmoemvUKSIhZlbSVLcxM82tLYmlZK8zC91wSDDed9oPaJ?=
 =?us-ascii?Q?EwuV8v+Rw57+X5sMMiUsWZ56VQ7qH12XBK4H95jjCW/mIYD8JNkMnUfLo59d?=
 =?us-ascii?Q?QHjWLFsZ32TUwZfd5WFZw53pXHXvFwlZN2H3bOij09cgmw7FvaxcZXd9TiKg?=
 =?us-ascii?Q?GzBGs4Z2gxmbPk0t0s+tlT28Mm9nT8uvZNtZHlEMCgWcSz+S6Hb5xAiqmaDC?=
 =?us-ascii?Q?vCsO/xVTtBKoAnSCrGBiFX3DlQGPsIMaoStFXavzeq6cy5XdxUtR9w5J0wbj?=
 =?us-ascii?Q?Vjmn1+pT3bC5k4mGVEFTJUuIBXDUCTyPm6Otx4n4B6mexhDSNrtTC2DrrtXd?=
 =?us-ascii?Q?vINHv16eEzCXdIlSUV4KwBDbASDHWdNm4qrHZedkrVgxCpS32jRO/OCGBeYw?=
 =?us-ascii?Q?dxWS1EhOpdPS3G0NkMJizLmV43c8qchSfZ/3qHm/C8l5zJr0XD3OBT8iO43Z?=
 =?us-ascii?Q?HEp6asQoT72PPRn500K3sXG143+fR2be0cE8hM2BcdMF2LqIZ306NnEyCSQN?=
 =?us-ascii?Q?kFQTP9Hr1yeHbVCaDrT2HxhGpKb4QmBH030u+f4jiXdoMUTMLT/OHPRPfAMO?=
 =?us-ascii?Q?fWQ/7KsGn8vAo0GfDx0M0D28I805jsHw3AWiOi6il93qqepIYNLj0MY1R3eP?=
 =?us-ascii?Q?8gcC4xjBZbIdIFhaVWpGLENBkdM0prohLWzP9iJoWtAu3TgNgSmAywhrBj2b?=
 =?us-ascii?Q?y+EKAdQIGZOhRchlv0E7BhWlccnLx0tl6yOxkghV09Hrf+r/Z0XzZeJwwvLg?=
 =?us-ascii?Q?wAKVY+cZsvuGW5Q8mlqGmBHZaXARJz7uc98m7I9g4XzBfkuTzNeTK0EklD7s?=
 =?us-ascii?Q?CaRM65WZkS+LLL6WWKNikm/H9lTnKomV7s6DkGIQkwZVZm6aE909QW2apYbN?=
 =?us-ascii?Q?8buCBb2h4aCgIqgeTz+wsFHXXLdj6/MZsj63/MSdlwJzEB2J466Xc8WNK+tB?=
 =?us-ascii?Q?0x9L9mFM+gY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+93A9rHT8eW3qYH4TYieFgDEwqgeidhQwCRIV6Ui3Pb8OyicLW+j7b66pw4?=
 =?us-ascii?Q?49g0krDQfvnOiwAzHTbbR6CbGKoVgupycAVZ8kBdkj/4p5+c1FLXiuGKZufI?=
 =?us-ascii?Q?amKd5dBERTIWgDg2XHuYFx5nFcFZmFEnAF1ipiVtWqRxBKRNJ8oF2/qieTYH?=
 =?us-ascii?Q?1xe8dWr4HNfJftaOewevXv8h/+BkbDRiqo07UNrH2lt2t044kA6bofBAHST4?=
 =?us-ascii?Q?FwkqvZg9E3s04VqthWutBmRc/4R0zF03bKQLKExq3gHAg2ZI2mEEBos/PuMm?=
 =?us-ascii?Q?oHeLmv3gFFrAF7w8ZRtmPD1xFIdI+9Ufbr0DHYOPhODYbLBt6rMD3yAH1o/U?=
 =?us-ascii?Q?+nOJjiyeYwKv+zxzs7dP2rxQCC8VUFq31xt3FiKvWWjCjm0z3FbTqicNrdRa?=
 =?us-ascii?Q?d1MdqcJ9oq+JtIlhQqH9daMldrHCwB+rQMJaDj68ltVBNXRZ+rUsA9F0lCYw?=
 =?us-ascii?Q?cuhlaLrN8QzZMFWIb+lZ624OONyjAkj7scTZKgMzkVERNUsCHE0B8DLA9v3S?=
 =?us-ascii?Q?C9HYRB//6SeMk4iFls8WTDtEQoicgOx0ZB0DIXYWE40m7o7j2+/my5drsAKz?=
 =?us-ascii?Q?ap8xa/b4jPGTjRI5RBj6YUjQyvQY/4LpSqAL+U7ammeIXq4WR9amH2VrWU5Y?=
 =?us-ascii?Q?YCAMuGOor474D11EgwL0V1f56+0NOXBK7FYZff/ztlNnawH9AtJZdt6/uhBn?=
 =?us-ascii?Q?nGcgqvrv8h0lkdKacWl068Yb19a1NzydZrVoRp7D+/Z8kQISVUtbMu4Jcc6m?=
 =?us-ascii?Q?eV0WWFV/UJUcN5PhxRsd63yIxSJEgXyjf+gfTL54TucGIVINbHxJw/7dIzxh?=
 =?us-ascii?Q?VXXy6Cs8TtGoY+upAWeQNLJr5zp0bVtefLoT+HCVBYGJSWlhnCWa52KJlqmS?=
 =?us-ascii?Q?/PuUUd5W3OMBfxyfSBlzTutmQl5f3ZB5UXBIyeGY2ymp5FMCQe1zmmvzHVPY?=
 =?us-ascii?Q?E77QwTipLIoxdFYxFmLbrbeh7PN3Mq08OP7bMlqJa3haGW8c6OFK64iXO3Eg?=
 =?us-ascii?Q?y0gb+E6DcOK3fbhx/QlQM78aDLHZAnl3GyZVuNGkXv10NMGjjks/OJT5JUCd?=
 =?us-ascii?Q?Igc6HSPhBpGsOAqRNphKVxwNXjo44F9eamuGhbn8RLFx8O+DeFU0o6RPWjM+?=
 =?us-ascii?Q?Q5f5BpdHVcYiNd2MSo012ZfYxQYDM12mBIL3JkIyP/3U0VkdXOfogCxjkYLA?=
 =?us-ascii?Q?khTiESk9WW38j0LosuIqMQzvZF5nql3m1WdGoN2mJlSko153hvDqi8URGTZv?=
 =?us-ascii?Q?VYNHfe6CFW0uoYFSt+ZAJWKzBxrwZupiPCS2zNdAQkJxAWMGm0TfeC2LUnOW?=
 =?us-ascii?Q?gn9zecf8mP/EPPmd9Q/SdhfPlVtl16etq/HEv7wbWFkhL5RCGPj3RkoxTLSE?=
 =?us-ascii?Q?yZQ49rC1MsNcOHDP9Mwr21ZxlLpWgf86wxfEP6kmnlKvjLwn4/fwDs+vMYON?=
 =?us-ascii?Q?fdPj60WsEpmogbauO5/bu3bYkUMsUH19GIVUc/LUM6OLSb0RCOfT8CGgtDf5?=
 =?us-ascii?Q?eOXLgWOxi+C9ogdvfgaDdVTNzVSzx1BP+BhoSRX/MLcDt3KV1K7zAvqIIPOs?=
 =?us-ascii?Q?xon+hpwx4py4gUTtBpgixQMiMko0sKZU84HqSKb8BgnxGDWEVtx/3AWB1/bd?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kip4Wklkwn3xmyjGSsVfUDzOurXnwubXK2aE4kHB08TJXEAGZa2iKiKCWWb69TklkQrrQgJjYW8fY31fU2nTAadH+JGXiyNg1MfxwY6/BJ7GjXWQNQEpMZyJk/xIVcrLtDOC4tcqPttpiiwCZnQNZIoriS2uTXWWn+nRPtCSfU6gWcjv5MhAoyneQ0paGEflo3xZ9N8iyIxgoryASi0q+xncn8jVwTrIk33KYiwhfaB+o0Vf394E2R0dqDVRax8Iy4kxxd5OIM4/lgTw7E1yqGL8BCw2pS0unnYQR2t060yUH2HJA5jjKZerxY/qCajlPZCwfOJFeTcBuO4zLoKh6yU+nuuoM4nKAHr23PfNhQySUjRTfDyqOiAz87tMRriagmiEyek6qE+JsqYfMMbL2WZVGVkkBLhBjHcqVAgusaBV7VlOk1ulv6tOHLta0dKLBzZy1LzjXGWuj+6d4NApUwv7eztIKRxIC751B/E2okx6PNZsvk+oCRRR6aiQjzTBpFuryLg+mNauBSqgkb2zGRqAITYh4G0gYIw5ESWbLW4uEaIA8pWaNhlhwDlandXSjhAmfDaXZruTpAYoBCl25Sykih8riZNfDq5EHVPm9uo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53614662-9081-4a6e-a42c-08dd81993339
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:34.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdtBTV6i7Hj36W6Dr2Ihh3hoNiRvAuJcwIYXnUKnly40WJBemXVaUcC2vuQOJQgaodXbb2ErX6I7IWqw6A9Acw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: emb6_pkvoT7IaMTS0rOxkywYkVW8ttYH
X-Proofpoint-ORIG-GUID: emb6_pkvoT7IaMTS0rOxkywYkVW8ttYH

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c   | 126 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 5 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..049655ebc3f7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,132 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (WARN_ON_ONCE(!xfs_has_reflink(mp)))
+		return -EINVAL;
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


