Return-Path: <linux-fsdevel+bounces-22096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B75912191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F56928406F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AA7172769;
	Fri, 21 Jun 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nqJTQ9J2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JL9R+Ouc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190D17167D;
	Fri, 21 Jun 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964384; cv=fail; b=TrK+Tl4QlDA5oXLn0vUWfjo6Navfq0t+CHxVRYysQYCoYcw77yBzdOOQivmexvqjUSbZ23RIo552Pm2DIJyXwOqBsUxrG3lhn5zR2S9bTJuhD4wFU7sdXvK3LTSgGZBUV/TKuL1fY3in22T2j4lnY6D9XmqdIItvhCxVV0hd5xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964384; c=relaxed/simple;
	bh=KAzH654l1l3pcCgnbL0oVGabivRWQAL2eDYEpBhEMgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5ys0hOq5lo7hiPYUETsUz/mjTFmYKO1ZgSFGpNv530NeAN36K/lrayll4kUVNOMGMRnNn1/pw+JErj2d55O65NuEu6375b3FXmB4PXxNsZWYkZABeqsRpKhK8sUcKSiMhl88Hcavl45iwnsn68ag/HJvHjusH12LtcS72EFpN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nqJTQ9J2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JL9R+Ouc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fhvB031177;
	Fri, 21 Jun 2024 10:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LSrsRWhnsw/pxUhwofAbnAqdP463+n+JbVEr26feiEk=; b=
	nqJTQ9J2ZhXgeHVnUje+EmzCSI8ZAKwDoSyrlNAXq1A9rzwMloKr65U8QNDMQhIx
	t8FnqIvtSdx3iOC0v/s6zsj7VvaII7VOLZhLvQMW9WAR/Z6u5MJroBq0jxT15KGZ
	UJQbEel2S5Hfaoe6/1b/a+J8dJRa2gu2W/jMd0iiuKDJvYpYpwRxWp15wZuh5Hzd
	PDgkHl/uKxndIJ7h55IpiwZ9AJexVarHwIRH1os2KbHFCma9LIRLAZOigu1VAYk+
	k6e1KQEHnab2o7GQY/zHL19wnRADbJ7m/xGJWRIujUKm+WjCMFC1qs0NEIGI34Lh
	j80ApgpTng9ybageICQmpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgsg4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8wx1M025270;
	Fri, 21 Jun 2024 10:06:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5wcgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZIszIntd3bGgZ1argkbhQe8/4bJcC8t0sHMXypsephW5PZ51acynJwV+H9QCb51zUUaIfBUgHoeIirRboCrgWL51KC7y0k4lO57vxPCOUlY4qSBOu1BViZgAuIxljJ2xsmjcfre9SQr+yxgYF/9ZaUa4d/zTzMJevEe/Cn2+HR6ou/IO+zR8tf8BZx4TQ/X/VFklIkUDsJ/mOYKRrWefmIogkAuAJ+JbSqK83B36YCMBCjc08+SkPK7uNZhLjk3msY8PWp4iUhUgemBCWamjTZ4Q5+V8J89Oe4AbfcPbKj4A0NGpnGDKXS2XdayRuYMR0uDnOycL79QojhDG5rpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSrsRWhnsw/pxUhwofAbnAqdP463+n+JbVEr26feiEk=;
 b=ArgfedDvvViuBZukuirjh87VC270fSQ93tV9lyi9qSU0ctNvG4DPxWCEVZUCi1WWoAx1jgj1Ikz90lZ0IsZYPUO+g7EQQnxoBRWWELqwzQo4WXIbx7gV94yYmp+uyDt4pyEZK/w+0Hzlk9Q7OYOzb/7hdHoqPHC1yCUpqPZvq0tADQa5fobNbFaAsq3eg/IovkToOVMQBzkffD+ouyK6j2hxLhsfDCNyt2SjHv0DhSIyldGyF0+gXzVz9JVyZa4+Q4JKi2HvyEzihxqP4RnHyeqXkF6AsREeEoKHfBcmpWJeoDlpphNf+Vi+oY7cYi6rUzh2zDeGFEUufrRJzDRY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSrsRWhnsw/pxUhwofAbnAqdP463+n+JbVEr26feiEk=;
 b=JL9R+OucjFOm3YrMV+8RMs7q0gZyHO+JFlY5SK/T2l9ETWj7ycuWoTJREmdP+qeWbdUt/89hlLxrFyxIdZHJhqEh+GtVWM7siGPlBmIu0JvLb5dTDEGFjPcCUhupulIESKcRDpi2Us7dsRAR02uds13xfxDpoh5JxQsZEj1Hhxs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 05/13] xfs: introduce forced allocation alignment
Date: Fri, 21 Jun 2024 10:05:32 +0000
Message-Id: <20240621100540.2976618-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc42425-b09d-43a4-1f69-08dc91d9c5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tdTZ9MT8gZ7paCuttRqFVR1cFHqWh29iln7j/Y5iWepiDxtKvsvgNCflF6de?=
 =?us-ascii?Q?zZIsg4O6hG+gclmcp5AcEjIutcAMczrsnty9IKaljZpTmk3Bi8Q8dK8Z5Fgk?=
 =?us-ascii?Q?Ghggp5Yl344Y8KedjMIc+6rBDNodOCDg2AVD3urGDYOEPeoxT3f851H5/n67?=
 =?us-ascii?Q?ofWrl2Gj6s2VLhB7quJE0ZSHBVeY63r2vXlZCDiRYOJrePDClh9ApPWPT59r?=
 =?us-ascii?Q?RuUeI6nSpmVStk1teoXLCY/KQW8dT4zghbuJIU8TiIZyfeNbMiJoHfBYSL5Y?=
 =?us-ascii?Q?xZnZsDoo6Q3EiOTQ+lP8seVBP/Ws5yEvf+OH1ZYueufwJxtP24J9ME8iVeBr?=
 =?us-ascii?Q?2y7IA53RSss2KP3ZJjrKkwRYrSuqOzddLS3vzSW1wYQYMvJk5gDWyF+Y28pK?=
 =?us-ascii?Q?k1neBIlaPxFoxJo0ykYhYEokQh8OrXETUfmr7em44oOPoSqyL/LBGuC+bOeE?=
 =?us-ascii?Q?hSH6bPRiSwm7BWKrGf41Hlmh9lNGHAoEe7OAGrGi8Eh92i8XzXH+TUIFLjbs?=
 =?us-ascii?Q?Dlvr+1Q35XdtHlnH6jZWVAZYNiuANQiSUODaeX8zV2X2yLlGmRa6rpFz8sPq?=
 =?us-ascii?Q?NqX6+PYA6SXSkyI7z5poeNduv7aO79gL2Qo0BBnzV3M8zRPPw+XJJ+RaUvUk?=
 =?us-ascii?Q?tKLrlatkInxBFc+L4DL0GmE9y5x3c86dgvkjiA8E4c3z+ZKWkKq38qpkDe0X?=
 =?us-ascii?Q?VM48L5P31izASbzl7NdP27W64dLpKN+DYIbWNGE1Er102ztSl9BV68wOOFvq?=
 =?us-ascii?Q?SlBk8enld4mIBkdS11tEDFNF4Rw1WpZqlaBPY1kzHtAXxxeQcGVXZveHdwAn?=
 =?us-ascii?Q?uUwyEz0pdLnnV7xe8JjiK5hdSoxic/OggHyAbUsbFQtzJo9PEIRWG9zkPYyk?=
 =?us-ascii?Q?HzcogolItN5/pvM0/e73LSQ4VPoxjOuTVwLzhWUQJShjkGdcktjjpN5wVTOX?=
 =?us-ascii?Q?V2PKLHtSr9cUN65gbTPMu46p1X1Gb16iwpF/yIDxVW1NQNYrok+LjFyNhIZs?=
 =?us-ascii?Q?cSV+ocw981M/Vf2bSvyXSTp63VD/ri1GMBqNvxvZPux7efK+DHtOMlv7nrX6?=
 =?us-ascii?Q?lXjGiFeQOo1jx3p8+62ehCJM9RC9CsFWvgA3BId048qp3GPgewO6CrLjVxVn?=
 =?us-ascii?Q?sDTMtOk1otw2JQ7aA7Hszf5CSGgQpGQwvBBqjUxcUgA6gPrV0KauGRFZbGwG?=
 =?us-ascii?Q?mkoaRbAssIgh4HZJEZI5RfNQbnAOsccgoc1qfox2M4Z6bCsxjb6V6h/xBDKw?=
 =?us-ascii?Q?APq2w2lgJuNM6AxY51e23zwCjZBjqsoMr/uwhgGQoJzDBuM7h561NAzSPrY0?=
 =?us-ascii?Q?pP4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0Oyrd6ctG7OHohupbE/P9eYvzhNiGeXVv+bKv1ckbRHew0/3FpEtaVGIo0R8?=
 =?us-ascii?Q?DJcsQQJKbfNvk6zHPqrcxcO74lBIYXF4sB+T1a1z5GS3Z+tO5usyDbpUQftK?=
 =?us-ascii?Q?E2lNEdJOMUD5l86TI7iM7ckvbb99l/H/UTT3HN1B0Ac69Hesuqe3uU1XHfiM?=
 =?us-ascii?Q?aDM30yGty5AEUczn18L2mUXnLCSV/pBVqB1QaCv8KLPylTMVEaUBDYLVb+42?=
 =?us-ascii?Q?toyjQ/t76t8RxbH1eX9l/nLUswWurz6oYZLTRvfeEAD148mV2hIzew/yGJ7j?=
 =?us-ascii?Q?1d6eyFAX3FPvEKL6JZH2wY2cAq8A0bWbj0nlofT532gyHi/kndypScUy6EU3?=
 =?us-ascii?Q?5TCAchk4wyl9A9GqZzsnjnpYDJZ9fbvvC7qxQUJYavLrPvT2VW9nBo1ZhAs2?=
 =?us-ascii?Q?9Pxdp82o2ecxegRGRFX3ZwfkLTRAHsg9NVx2Y5PmPj7hloSgDMouW3PdFDFn?=
 =?us-ascii?Q?v9HCFdxUlwJ7c0yPeHi/o64mCkBZtfgDuevYCQNp8n17FMlQQzev8+n+ci80?=
 =?us-ascii?Q?cXmIWHAmX/+xRzeyzds32Vtee84zIWQJPt0bBN1UZJS8KgPuLMaj1G1PTW67?=
 =?us-ascii?Q?jn2g5WC4kL7wYZBuLw9OO30c/zjcw6vNExNjCX8cbcr2C24amzauTuHwwLba?=
 =?us-ascii?Q?DB9/owT7a78/4jnS25/xmWjcusf4b423PKhuz4UujFQfcNFhGpElXyXUVSHx?=
 =?us-ascii?Q?Yh7QXOpRON7TZDq5Wj9reH1LbwjmfGTxxjWigii1EDqIY1PuyxpDJwaSkfpe?=
 =?us-ascii?Q?jBdf4m/WOUHfrW5BPDJObVPvanQQ+GY/OUATVPsY0gKXAyO1ZuLQscwecoy9?=
 =?us-ascii?Q?tZxrdWh/rG9VXbRVpe3Xwi98j8tP6qlSVoPGOxaaW2zkQNz2g76czNeKwzTp?=
 =?us-ascii?Q?2O7gh6SxfpIUzFlY56yh/51gCTecc+NNjqIYlMNqPkbpgUBiTRqlfIUgNUaN?=
 =?us-ascii?Q?SZgb+lnF87TCjbQptSSKl7n1RKpZwYqL2v4NS3Q44FMw+EWKNmjjPu4rC+6E?=
 =?us-ascii?Q?EhviOy7Su/mobnZMAJA8B+zehi7Y94H7dM0/P2UK8KU4RL/S1QHiqC6y2+ia?=
 =?us-ascii?Q?9kIJQyICQsflvoVSJ7vtEx0RYdd6ST0l8RKN9HKFaI28nPb5DwZp9tWHvMl8?=
 =?us-ascii?Q?lJQu420DN58foplQOA1lJ98TM/XR6YBh6aEHCkFmwtGTVpb9jKZGP7hY2kN4?=
 =?us-ascii?Q?ezT/bEzjbved0xv6xKU9UedgayXEc0bJ4Eor/s1KQH0ThxnMpt6KO8Ra/Vhg?=
 =?us-ascii?Q?lscYKpoP6wxZh5rsRIvRUYMZvlMTFlLLITnDsvDBkZ2r4C7MsaWGHIDggASh?=
 =?us-ascii?Q?CTLJSa+USRlN//SVAwYOkTwjhtyfNyyKK+DsS0/A9mUo/q7P81HRmzc/bFfe?=
 =?us-ascii?Q?okknNySf1w81e0zsklBrycIAU4kAiJLquMAkV3yfP2BTBt+PSbkmgmoLElRP?=
 =?us-ascii?Q?u8ASxV+655vz8fzjXtuE7wjXuqekQA7S82gEsS1STwUbl/TDPloDdsgHw9QW?=
 =?us-ascii?Q?u35oLPXRByplKmczNV1rQ5VcL2QFwrJlFLHwQdEIOIa/n8/AGAMGpwLzFAtt?=
 =?us-ascii?Q?qi2IxXJrkHsTG0M7pcSTfTcMSxKYmJDRNvvJioEzTU2YM6vySE37le+ES/qg?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YR9dxj0KjUG63K0zzZ/G7IbbJKTnfG/fQ56rWDrSN9BGV6OEMckb3yDxrg1m7V4kgoxqid/3hxijbvrFl6VnJwelVDSYhjc6z8HOxDvNjeeBYE124BgR6qibN6IHRN6P1UUJJxg75JAn89WDauElQgx/yH6YdnMcUN2QPhUVePYR47LHggEZ+ZZ/DKEubzgYqisxj6Ey3wTU/A5xNEKFs9JOhmOc7txUI8hJt2UZzmENfn+XG15PnZYDJjHbx+n2HzxgpArAMACbYb5pySyX+AOGonw5XqSXcDtbsNq8w2P7FbDikV8y1wTepL6kLtr1SWh57kkHNG9LpaMDx7fyP6ZXlnxehIlyU2Lry5VvpivTWOtPId8DVHXUTpr4LN58Hpkcp1l76idINAo8czarg254zSiIr/ZRSHqL2z6/2aRQ5oyf+geUCFXiOBUfRH4ZPJSryjcng64qTtYnYeBnJR1230tZyn/Va/02Rm6ieBUSS/JaYNE389Hqc9HJExARNWi8nwckbwcrxx0KaKPD1t0VaiYlSMHehy7F0vbOoNqe5L7eNX3Edw9TqujvP8sZhzwyHjhvc7qfcZLGfxdT5GLUj8LpwMf9C4OnG8wP9W4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc42425-b09d-43a4-1f69-08dc91d9c5a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:09.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiyTJus88lqvrEHxb/LT3MWcCamfqvTIOWDkDB0gfVk4Lh9pk6KZARhv/N5QPxlLuTorW10uy96zHUYdAPKLHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: 0cTKTN1MRSW2uWZZ42dX-tew0yKMAaWt
X-Proofpoint-ORIG-GUID: 0cTKTN1MRSW2uWZZ42dX-tew0yKMAaWt

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 29 +++++++++++++++++++++++------
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index aa2c103d98f0..7de2e6f64882 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
 #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
 #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
 #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
+#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
 
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 528e3cd81ee6..9131ba8113a6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3401,9 +3401,10 @@ xfs_bmap_alloc_account(
  * Calculate the extent start alignment and the extent length adjustments that
  * constrain this allocation.
  *
- * Extent start alignment is currently determined by stripe configuration and is
- * carried in args->alignment, whilst extent length adjustment is determined by
- * extent size hints and is carried by args->prod and args->mod.
+ * Extent start alignment is currently determined by forced inode alignment or
+ * stripe configuration and is carried in args->alignment, whilst extent length
+ * adjustment is determined by extent size hints and is carried by args->prod
+ * and args->mod.
  *
  * Low level allocation code is free to either ignore or override these values
  * as required.
@@ -3416,11 +3417,18 @@ xfs_bmap_compute_alignments(
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
 
-	/* stripe alignment for allocation is determined by mount parameters */
-	if (mp->m_swidth && xfs_has_swalloc(mp))
+	/*
+	 * Forced inode alignment takes preference over stripe alignment.
+	 * Stripe alignment for allocation is determined by mount parameters.
+	 */
+	if (xfs_inode_has_forcealign(ap->ip)) {
+		args->alignment = xfs_get_extsz_hint(ap->ip);
+		args->datatype |= XFS_ALLOC_FORCEALIGN;
+	} else if (mp->m_swidth && xfs_has_swalloc(mp)) {
 		args->alignment = mp->m_swidth;
-	else if (mp->m_dalign)
+	} else if (mp->m_dalign) {
 		args->alignment = mp->m_dalign;
+	}
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
@@ -3607,6 +3615,11 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
+		args->fsbno = NULLFSBLOCK;
+		return 0;
+	}
+
 	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
@@ -3658,6 +3671,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3716,6 +3731,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 292b90b5f2ac..42f999c1106c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -311,6 +311,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
+{
+	return false;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
-- 
2.31.1


