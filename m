Return-Path: <linux-fsdevel+bounces-25797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB709950A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F065F1C22222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD51A38C2;
	Tue, 13 Aug 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GebHMFTl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UUd2+ipa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF01A2C18;
	Tue, 13 Aug 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567026; cv=fail; b=CqnBKyh4IGytUZjyuE5P75Vk4NhnYgDRXTDxYO5QE6yL+ppar7DWRAbf/jGex4+6nNQ7BQEBkzKcV9kcNdA+/Oj3uG2Kj6hkRaG3eIIfd2PlYJgAFKxySHcB0fNE7ohrDwPG3N+G2zxsHoFB5nk1xcIVKkByDJV1mKoU6Fca6c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567026; c=relaxed/simple;
	bh=zWRDLuo/ILWanQJGpQZkcZulk/YZxcolQW3I7gFzbp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8IJDw0EhNzPu+V0eYTxg8Ng33eIEC26ep3KnX2pbHcRE9BK1Vq4IH+ugvTiBBM3NwLoaDMjeymeHMHmJhnLyaiIWFm9oBIg9owIGPCNx/rb4GXo8rfI9ui3OnrM8u5mTa+9S4dSH9POrBFydwQqLgFVvK/MpcZLjfjt07y2zxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GebHMFTl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UUd2+ipa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTwV007375;
	Tue, 13 Aug 2024 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=; b=
	GebHMFTlXJcXbQJqTkv9+LQauWnN+4UH3I43Jqb2kbDjTpsQZKaWcf6IMwCqdSXL
	7ye51fjAk+HDHJLMHf/6OpdjC89mq+n1VauUQ4ritAmfVMKolkKP/ATfLcaLpNFP
	Gwl5lyWuhSX9dOwBSYbUqlRM421N0n0/GIJ6Q1MYPTJP0lXSBpXg5tiaRnX/6jQl
	W9RZ5G2xKxbjJoEB6l/I3jSc/6rmO0bHRkmwoUzP6V+i3OjcWjSbDiNgScDpPuqC
	E/crQDzKlxr1tiH3qaq2F6NacU1D023gusC1XS+LEqlqX5eCwp/K04H2ApIpO9Zy
	yeX8RQT7+uSVBTcCKDtgdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0xff7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DF7Bve010631;
	Tue, 13 Aug 2024 16:36:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8rytn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9SqKbbNJy8xIrk7EVSsCtenU9RBJUs1Sh/fqIA5ChSjmMxe4jetguSsfD1FOQdIedJ3lMZ1Qt+H+xThQdr7rAjUrCp/oYfAcs7xUEhVeVTpoguzcGoRKttqpVfiQlBOX/dymaBkk9l2wr/C+MWNdmj3qdGL4AmNH1AGmCWNOD3mAap+ch9YDVk9RGjATU2uRnoQXmHSYFouA+KpYm+KjQEg+4KhIRpvSod2EBAyWK5lOXU/TOCTRdNqulKZu1YcY2HADnmQGds8FqRiWq+c+ncSkGn6MVO8S2LeJX2vszToCw/2ImxKE4h8MUACBxJj2H4K2ihFL2/6BaSDD4o0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=;
 b=APMgizs+niEm+pY8pw1ndAs1hBdmT1YdYBmegp1flUxb0BvpHHnaRmV9rpZfbQkBi37uUl0wxFo50bJdwuGdXvEqvv/kksM3uwgV/iBXMzrjLXiAX4TAHWd4qld+NQlCXFGr5FUS52oFjlwpE0ThhZQXy/m05cRIC9nkkEvNSESWa/S8E29z3+U68Rn7Q8eNOJBTVDV0LXfasabMNoeiiGFL4/lTzr2MefWkyT76nCKVcxzsycmIpfycs6Yh3Ee7So5pkaEBYMMDweA+EdpzH9K8Uqro0VCsEfbnvksg/a9/mI9JqwHgtBn7AuAGHC2PznCy/B4hCmoyY+jIMf3+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=;
 b=UUd2+ipaxXhl7O8XO3738w3313J98OCjy7EmQXu4sDxyjm4GrMXsNqxrIJBm8UIB6BWe9LsoFDTPuekmwEZ1hcishXuU1kBqkANOZPxp+4i8goHZWkYCrzDF6owxV4ectuX2XIqne5U7lsyM3kgoB2arT2QgpStsbRyTmPQJ9Rw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Tue, 13 Aug
 2024 16:36:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 02/14] xfs: always tail align maxlen allocations
Date: Tue, 13 Aug 2024 16:36:26 +0000
Message-Id: <20240813163638.3751939-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: eaef908b-0916-4ea0-b3f2-08dcbbb6219f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t37LI1OkaXGQwN0WGDs8h6GC46Cxq4ibyopdB7VmM/HnpuXASeic4M68t/tT?=
 =?us-ascii?Q?PA6M1PAyUG+pLUIPJk1Q9BPKjjHyn2w6Wl6okuiqal2EiaNDw6WnxFaKgr8V?=
 =?us-ascii?Q?slbA1FRZc4XZi/t/46LLGPSXbEDdsApH8DOSa+uOVkGL/ctJFNDE9TBbZEY/?=
 =?us-ascii?Q?xwhdGTNi3v26bGzNmd5SSrWDTKufVnvLQe/xf8DSF82bFgm0uNdl/7UvKXkV?=
 =?us-ascii?Q?EKeWCkenEZZ5ryTRKdovXQTu7rgRVnqkLxuYqDqMSsaCStXo0xgW9bXXVwqF?=
 =?us-ascii?Q?pRvA/E3NpuYXdlAFJ4rPmFonNurVUaSslmwx51cV0W22HcWw8oV8CcU20xmK?=
 =?us-ascii?Q?OcBsuymBCfE5UKLdRpQH+4fgXzRB0fAkl6Eg3A2qnyIfvifvKaMZlHkQOwLD?=
 =?us-ascii?Q?2BsQ+fvyYXMJvfIrMY13QZBhbiD7PTkXJlO2fzmPL+zf5sn9dAdkfR4FZfiI?=
 =?us-ascii?Q?2PvvjM+7KHN76F2B9Kw6B1BLhnIh6u74V/Aw1f6CzljBDduLYZz5roJJqGmi?=
 =?us-ascii?Q?RuCbzPVSGKU+tRFxsaFbVca/PMbiMVKe8/8SV+4Cs5fs9+PgAkQP728oyqx+?=
 =?us-ascii?Q?VP0+vul38AF80ttmQRvffnJRW3SYsxgAaWhd6+XeAYxcrv38fK7KDJYWYqLo?=
 =?us-ascii?Q?a3fWtSjfyn6U93IaN6Rpd+L53Jr4nReRM9ejlotUE+3jlceQZNOl3mp+NW+A?=
 =?us-ascii?Q?+cnV2uJZiFbAuORlNA7HADLe5Xedzu2u5J3EXthHInNiqLOV9bg8mxZmpoiK?=
 =?us-ascii?Q?b//QoQEzflKbJwjNRS743eaoZiHfbTJ+Uy6gnZ2s+ZYCEIeC7RyEWDIupzXt?=
 =?us-ascii?Q?vVXBav56v5KrWcrreVpVS5Ef3rLOrjjnKF7c6UzuSuhQDsq2i7ZPwFJg5VYE?=
 =?us-ascii?Q?/zTvxxBjuSrrs15aBfODCt6zIAUc8CxJi9XbrUPgpHOzySSqFrk/RuxJz1zX?=
 =?us-ascii?Q?2pgfSpFjN42MxxJ6APo/50wVZOwIXpNwFw0j8ZfXlw9ojym0N7tQGEC3j/ZD?=
 =?us-ascii?Q?ygeEXK0mpu7srALBhaw9m3jaaRNwpoFf0ZoVvcsvWWszszML3IrXqr3zrynn?=
 =?us-ascii?Q?EEA+96JZah7TXhb2l7Y9JtUeiMU5lIBq2kHZIydyvsjzvYRtiIqsfLcO700y?=
 =?us-ascii?Q?mZEj02nYVz2WeLeVKnOuvb8F8xgE0NAQ9Pr1EIVSKU166E1PydQQGCRp6rOu?=
 =?us-ascii?Q?u7zk1n5WEHQyN1SsKTPE7Gs6h/2ENv0lW3qfwrPgrFkuvvEKG6uwqE+OENW1?=
 =?us-ascii?Q?1vCxjq21vAXNepBHQ6LdqX8kgOtjnfP16c860sF3d0ORmQMCyl/Ur5lO/F3v?=
 =?us-ascii?Q?8QCxB5VicTA/hlrKwarzOVgKI2N9ZuutQOa/2/jiGExxQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/jm96ua/n4u6KJAfoQXwgsrsCw6cmi9rmUMw+pT8AuqrLNNmbFxoI5XCRls?=
 =?us-ascii?Q?5nXDgzslt6qBEFD+IVbmmkBJDQdAPLbm2ghmE/vVtbl6d3DJim6W87Hg4vHf?=
 =?us-ascii?Q?PsGEmbCPBW8r0YqTIfm2VjJIHdcOf4vvwkyahcls9Y2KMBNRXOy4r4keghnl?=
 =?us-ascii?Q?xpxRnIVEcRuyNs9l2WJ9LKPbcLahokEOqk7y8zNyP3O7vLSTZSyzmYfoqcmM?=
 =?us-ascii?Q?OlxOf7IeuvQQ3EJHhyIBbfQo7+1JGS/bRDVgXES6CWv+PxoYo4R6M4eLdQ2G?=
 =?us-ascii?Q?/7cdfYPq8fQAoaJNR3RIVoxE14FebE6b3E2QbsWMAGRcsypcjKyRMq/kGqvt?=
 =?us-ascii?Q?/MBVlBtVDD+jF/APnmrzQya3b3nGZuvbVbPH0ssGsyi4fnh44xMg5g3zAcAS?=
 =?us-ascii?Q?HPONfyMUy/H6vkdyrKWQbn3qHdCLgtuw8SEOEvfksTC6Psz4cB63QKjTt9bK?=
 =?us-ascii?Q?WwtRqwPcXtsEe+yaYGmEVKX9PpmaQyfyhPjENDRFIjt/JP5WVYOVhbbBNWQK?=
 =?us-ascii?Q?QndaWd49UAZLY5erK12UX8u2KTFF/nOQknFtGJ3wpK2VWkH2hu8HBZv7fEVE?=
 =?us-ascii?Q?MSoByehWx6/mdwGGVNCFAccQTlH3oGQsqiZShzvZBAHTsVnr352QK4S4YgT8?=
 =?us-ascii?Q?ST6yFb8NlfRDTK3+5lHAdNEA8StD+ER5gSM0Fs5zWNmxSU5C+14oJ20tdr/d?=
 =?us-ascii?Q?Hk9q1NPEhssZ+5vIqA0te2qnpjDfZ08hJCiQK4ylEAUf/ubWw4T8IeM43amT?=
 =?us-ascii?Q?kUgIUAE2O8Y8S9d1vsZkCaKAbeY5swWTLOilS4jEP6uF4/oGzWeVrj5krxzQ?=
 =?us-ascii?Q?5ZW3vhkZKOP1LbYqnjHFX2VIwWatgUkH3QkDhfwBCxmwQrm6ofGUds0MLy9c?=
 =?us-ascii?Q?p3IPQU0PgUIaONGl6l0EYCN4wE9NAiYv5xAWzXx1K6tcaeI15xXvTshN2L/J?=
 =?us-ascii?Q?brtrdxgP7sZATKjasTvoHqTKcJ+jsN3KCTKhFyBbvjrzxg/chU6vMOLXiJ6c?=
 =?us-ascii?Q?Pbpxf6T4TcNpY+PNbDX4oa2l0joj0b4FaDK4NtB5sk8O+/oNLhW6Xj3rHcZm?=
 =?us-ascii?Q?5TkTGlyX0EiuEbxqvdkNpSE2+GiMPhK+WJxTBjDDy3HGb8a1ftpYoFtfcG7t?=
 =?us-ascii?Q?AF5ETETBQ4gJm5GHRapCKPl96NH4SwRXiz1pq43PP/lZ3uIexQo35oZr8hB+?=
 =?us-ascii?Q?DlzmceqhMM1OC09djRQQQyqfXdXq89HVpzb6eIxv+ZEYmiOc6YNbr0VAPB+r?=
 =?us-ascii?Q?f0DmGRVcvWe5iXNkjqBvePqP/5/8t5pH3R80bp2ugLWCff2ASv3L4m22qv1F?=
 =?us-ascii?Q?QkYQOClrw3STbAjTetVnz9oxosbndbr3qBT9Q0pRl6Zll6IIBgnZlhNh49es?=
 =?us-ascii?Q?876YIqwyUsRrb9dn4skXMSpXuOf4M7FXAsBHlrBrlBg901A0Gpssce+85I0U?=
 =?us-ascii?Q?OduioObAQHB3AJ3FdfY6mugnKN/vTjVikw4yi9fVNQKVpXqPUUsW4qrm52Jo?=
 =?us-ascii?Q?s8MEsddXQEHRgQtZQ69B0xuzmTIulh09378b/yl16Vt17myF1Tbgb1dM3cJq?=
 =?us-ascii?Q?VRqPjRq6821bhYroA1F3zsoAnfTzrNR8jdNsiCs74/MBDNaKyuB3EdWkjuBt?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AOo0fQaTX9cgUSfNorzwuaG5vC8oLhmXEZsewNPNxmFF7VcPjt/itmgKCslZYVqPl+d1lQo2255SuNCSYNxOQRIp1XWcgcDV5MOtllLMGeJhVR7vOT705V/2DEUxWDiQVVKF81wKFgGeBHgfzO8hafSQ8KPIOzR0v1uwRO9GWWyS8difktsgqcAWG73qQllnru1w9NPqyXPeIlcxUQi6aoHRa7IG8eKO33UrqPWqDBy77S6TV8Y+POqzixl+ofnasXkV6lDNkoocOUpOmkHe8LPvOAmSJ4Wu3togRpj2IbxySoM0zAmN/QtTLPLu4+MzT/v4nAYIF1wwvFJ20DAUi4KFYjoxLi85u7YzOVYP6xnP5Ljq3sfJv5ow7HNygTuB3yLI9ddxuh5agRMgmJVsDX2xVNN4myOnI5GAvQhqLSxBwnb9qzelObhqARB1Y4D4c9p3N41g8WrblrQb0Yf42SSlqYl6yxNc4IxX2b9O/HcH9Kx22E5XCbscgphiWZ505fCAQY+Ff7FNeglVE9dvW376dJIGmc40UsU307tz+Y9An4aeqs4O8eLWg0EpxhMO0F3s2R1h6tHN9+qWzDYNQj016RVu53veFvX8vjFgb3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaef908b-0916-4ea0-b3f2-08dcbbb6219f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:50.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo9r/NfD2nFSy0ErQA+S7snN8wRYTToTRPAigCGrM2WP97MVk6IocD/sf+laDavROlNYCHo7hC1lNdwN+2OHUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-GUID: nRN4WGXnxfwQXj8aqQC5g_sKKlVLJzbJ
X-Proofpoint-ORIG-GUID: nRN4WGXnxfwQXj8aqQC5g_sKKlVLJzbJ

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
alignment failure to be reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index d559d992c6ef..bf08b9e9d9ac 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
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


