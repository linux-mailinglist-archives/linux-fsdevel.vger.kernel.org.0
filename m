Return-Path: <linux-fsdevel+bounces-18137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA578B6076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949AA1F2220C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CE128801;
	Mon, 29 Apr 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HtnPlLOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I6p020Xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF81272D3;
	Mon, 29 Apr 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412935; cv=fail; b=peH6FehkM7iRHpFlOOffm9zhrzn7mA0myPES7fylLzM34lrYIUzFYsozKhkjDQuFwFbvYXe8WiLWjwxzw3vqhW/9QVBFuidNVITHpfs0cayPjHUc3balnWIxtwgbYJD/2jIes0j7AIYeutco45qVv/tYmAvuOr49p62xeVKpJRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412935; c=relaxed/simple;
	bh=DN4HWIb6KH5rd6ktbPAXWJEe37BdzJzg1/90WnjQ3cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgklEgiWOum06hqrQwJSWW77/ddqP/KCbvq6eWaxY3UUjZOIRYEW7zXH4f+D0ojpPUzKbXGZjOeE+cD2vE12Ta6OAStKz26QDBz3tTnvgG2uvIS7D9uz0i75A5F3PRmSih76sxunl58sfjkdrda3k3Jrdnxnjhbkfs4sXH6FtTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HtnPlLOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I6p020Xx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxYYG018146;
	Mon, 29 Apr 2024 17:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=64hoEnrzlSZIzbdkJysfJjgcI/JWZhuofsOPS79G52M=;
 b=HtnPlLOxLyvWnbNfr9GnfhvlJ3PHcuFSJymVZedXmNxqHK5UKTsZLEqlM+4cRLBHQVRV
 KlKdtr6ixhqs4iK9q0gU48J03UDXNW0crKs/zdfOpL1kzZ+DEaJYXejXuBcRRUMnqfXE
 wagdgHoxM/P/SZVjXpe70rDS7jQwL2L0el7ioL+roFhYVZksVFcL5/gDwcbUOHlkQDZP
 DHLlaje3LYRS3VM5vN+Nvc9FIdYATKUrDnWQhW/uHS+YlrE2OmeSvYIri81Ts5Wlv8gm
 DFdHo5AxKJwgfcO/kthUOLf/QjXDeATODWUjLo1KBzu3+ZNC3yqbnZ8aptPeBEdExMEt sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2u92q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUZ004324;
	Mon, 29 Apr 2024 17:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSNURzVGxb2sRvf1tK0emr08j7JkA5FSuApybRTfyVunsbwcCmBIUJQAcC3Xy5JzJ63y0723Aubdm8vImYRF99b0tv0Pg+5ksvcbiTaVc74L9hQPZkHBRl0FUwuyolsTCNtpvfOLu6SxE0np7TDabnCDbZT64iJEPeUmVeVu605378j+ICxNY+SjYuB4ndlI6TnaJGMRrBVJjWi2GnurzjBIu4gQzuIGyXnqA6iG7fWml8IaOWxiJV3wPUo2yUyIoWVSDrGSz585CUKhfN0bC0vryutcJOuKaN2gtC+oXabftWH24NecTdpDAnhSocne+NcqHjW7pBfL05mqPjVwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64hoEnrzlSZIzbdkJysfJjgcI/JWZhuofsOPS79G52M=;
 b=DBcbh4/2xK6oPNpfbxbc7Aq9rHgq8S1DBqgEjbPJCOfZcfxUfsOwjyVElM/2eWNmt9E9bIDW7hfWbhpXDfqpZmpMkbVEG3cDeC9cKk3ROpH9O2+ijuHXgvywZVnoOJ0QC5Ihso+m0IwpxRtkiMfmtddOTybzIHv7UQ77OfXZnr9HwVT67AqtavCpJ612wSyOyfiXXR7+ffd3o3MMMDlvix+bV3oe5LXG7RCuJ2a7l131gpa5jc+IRyraS1hfgDn45gTUySarZ7M/eOqpNT8hY28mKB11eRebZ7r+HQwzPDd+Kn/KyKgJfCIlR9btC+gKsBvexC5d8PjVGgETxzaaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64hoEnrzlSZIzbdkJysfJjgcI/JWZhuofsOPS79G52M=;
 b=I6p020Xx4SQCkGCBiCKJSo1KmU78YWCnzuSeFkGQI1axk1y6oZZ8f6eA1J4eQeJPrgfTP29kOIMs7/YnFIQb0v66rbBE1Oud5pkHCLS54RqHIEvKSgObsLJNt8P7PkRwN6ndb+DUr8A/0CC6w3pgoFT60u79xY26gO7ZZtflbpg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 11/21] xfs: Unmap blocks according to forcealign
Date: Mon, 29 Apr 2024 17:47:36 +0000
Message-Id: <20240429174746.2132161-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3affdcbc-7577-4cf5-9c1d-08dc68749420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZlGmEVXSHDP6J0J/4xI86BwuRf+oFY+s/EcxTxCZhOFPrgYGCs33C2uIw66n?=
 =?us-ascii?Q?dcH41fC0NU5uKkmQMbLR0NYcqtPERtWqWYHAPpg5SP/I7llI3aMPgLXoSGA/?=
 =?us-ascii?Q?R4V0gailZnlmYNhB4hJjpEAKjUgPtDPXiNzJ9mLDEWr6yCcMl+HzvqqCnHjK?=
 =?us-ascii?Q?LjCzjQAxxaaue/hLCoF1qL6kwj20skDjqVItuyq0j4gwVnD04/AdpieyoaLi?=
 =?us-ascii?Q?/22D6eqt0SyXI/CM/b9YIzsCc8ly25pERiPdqr32Wc4fF7VuM9hO1swF4VRd?=
 =?us-ascii?Q?N4VfjbfDVxHdO86AlnEJFAsSaxpqrXgeZELvOxyZx7IyGoZyb2UxMInKGDdJ?=
 =?us-ascii?Q?MGkmqpB2drXM5ZxVn45bbGi93MVOGST/gFOYxdMIxG49bgvQ+rCBiZopXn+G?=
 =?us-ascii?Q?ojYQLS+R5XxksJVuD+VaYSbJjHom8OIGmgbzae9Lar75ekgFLeCczPzawQ1W?=
 =?us-ascii?Q?Vx9+W21zvxKU6/gtJYhbsHWjQlCYVQpHAE9ZsEtZIdE+4o6S+nNnRMXi+TcK?=
 =?us-ascii?Q?iBctSVg3GRYn1LWGQezc4rjhO4Pzi48fVcuw6VXriaDvhu1K5NJR3+CHpIFM?=
 =?us-ascii?Q?DnO/DpGdt894TLGbk2XYvXDJRir5DSqjikJITH5yvphFwNXJAeq3t1/fTMYH?=
 =?us-ascii?Q?1TFVGXKrGWQnr3lHf4BnpFN1sgS4lHaXbmiGKpsXAQ/7CW4dwwLCG+KStrMz?=
 =?us-ascii?Q?vVgnb9x7wRrb3GN+W3YHdRh7OCeFO9msiMLFpbBARAZYxPA8T70+LJYqEsAW?=
 =?us-ascii?Q?0Xra+UVs0Lgfd2hNMiBQwW1oTMToZey2/rPWEL3/nT2ok7HDYMI2CNAUFVIQ?=
 =?us-ascii?Q?Fbs5VjK8XzfXnZAdYN+lQh4uyjRtbiPwAAvZjezuwNB5drRuCq62arrHgX89?=
 =?us-ascii?Q?hzpY8IlP82cZ0iQbExUHs+Ya6fEJGw5jwynmcRT45t8M9eRumrE1sqI/N1Wt?=
 =?us-ascii?Q?Eb5L6rYJS5K/kaBNu7vX1CtTL80n3A80K6DnuKsnTNfXONI2m765bEiVaML5?=
 =?us-ascii?Q?BX1YY7InROv0yXRew6TUL6KeJFTFa+ECEiPUkThJLhA/k87h+X2sWYmrT9EL?=
 =?us-ascii?Q?GdVs9bOIUJc1l66YBB37nvdmEunddKNzBroF+EdRdr9EysF19+XP1JKAdXlU?=
 =?us-ascii?Q?ISpOMOi3ehIGbLCbo3G3WwVQADQKH8sHnH6vQ+d5uuuzy8zDR5pCGnV2qFa1?=
 =?us-ascii?Q?KbKuvfhMEQkRuxSzjqaLLppRDYwpkilr5HxAO4t1SyIA7M0ea576B/BtO9xa?=
 =?us-ascii?Q?AgEQkTYhbwIUlzVwO8C8NZIFse8IGrsIc+DR0Ybv9Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qnUUv9ywoAOiBuQkDexybCyRK1h1H2vuU4aBL3PEZ0c58hOKD0cYLaSfKeOg?=
 =?us-ascii?Q?xczLtmRWI98A+Q1gbXXNEjXqnRX+ybUoW+v+r/1K96ShjsWwVZfvqXRk8c5K?=
 =?us-ascii?Q?+CjQqDt4VHQ44qLVXp11A6h62C48hrXV3do+9JsoIfR1+OP4IQLII0sqzDft?=
 =?us-ascii?Q?hw+eZHC7YoONSYKsU2XSX3R54KQSCTaLLVNPtgDyBfArsvgua2c2DwH6YFgf?=
 =?us-ascii?Q?zn5aF8sP5jD9fjqgdY41zSlkkZYKEQlgX1j2wVOZ7cuEsPK3J9YrTncnaGTR?=
 =?us-ascii?Q?PPXxLpi/+9Zfe4NjZMCrXKvCKMLNL14parvoKTZwB3L54f7/kmSbvigU3fyr?=
 =?us-ascii?Q?f9puiCO4foiKPfUEhDDUr4ASvg17cUEuPjRJfJSDW8mvdrWFHuyfEHm7ot58?=
 =?us-ascii?Q?07cwScKWavIeZ22eDRrtYyVw8GC1mnIMXw4thwJR98k+g44cYBxapL7Oz+2o?=
 =?us-ascii?Q?XHmtIba4mGhJ/4W9bsbDYtOzB9oo8m/JdN9IIDd5f2anIaXeN/eajyZZqdyQ?=
 =?us-ascii?Q?S5VfPpjwL6xFuJU0GXzN4tqVqKFnkyiUpOuHBFpKtwKa44h1JAl/CpoEVk3M?=
 =?us-ascii?Q?WEj3nZjdEMg1PAGo8+jFoDlcXXlyuydd7mG/EaTK6bciprUU75vt7jDR1k/h?=
 =?us-ascii?Q?DvQdJAjrmDMUCNW8gBwvooQr8MjaM5ZJTSSjXtquqAALTrnD8lq1mKIu1mv/?=
 =?us-ascii?Q?yidxVOZCmU04G8ONfdSKkKR2dhgJdbFXUT5ZDDqzCVGi7k7bI1nzFT9lUu14?=
 =?us-ascii?Q?7ZwbjwJL9jTlU3yqsercUK+Cg2dCLuevQXF7L/U2muS3NtzMISVCoiRf6Dca?=
 =?us-ascii?Q?/wBDP3u3N0YO/Q6lztvocyI2MN/Jnj6STw/RVFPuVdo2O/nzpO1mEYfwSImU?=
 =?us-ascii?Q?5sDbONy8UK7vboek3Psz8/N6hJeydHvbQ1DkTkj+m0M4JUR6rDUyJgZ/sMLI?=
 =?us-ascii?Q?UgYnYzYftglF1hh8jVESIwa4/YW/FG9FtANOKMyl4WfYUnxtYDXdMwB+R4HJ?=
 =?us-ascii?Q?Qzx+cgCoLTVYSS5tHrE5pbaEPyWc19k3FxNcWge5/wMlX533YHNWS8oPNGJ8?=
 =?us-ascii?Q?nAz6jo1p0uM0+3thJe1FQmv+Fa0Hza13EFQ+Yfva8nvqHQeTkWGQSg1/Y+Vu?=
 =?us-ascii?Q?a3HudMWKTDAFY6evuFS6D/9XMya+EhUV3o85zIQKxBhS1COGuNjRjOuxA8Is?=
 =?us-ascii?Q?Gn6+WOvd+39jnx+TVz9kbt0mnewuPKLT2C2GdWgcjuq3pQugqNsYxV/cP6rq?=
 =?us-ascii?Q?NUfMTYTC6CQLNu1L2rDoj5RrsA9eTQ8x5ik0SdUkvWp4oTwtCtMxUsxBCuTs?=
 =?us-ascii?Q?+ljLhDv9UvCDdzmD5nr4S3z/skMWVk76zdeYZwb9Ng03QGPVxCAjbVaIBqj8?=
 =?us-ascii?Q?qZKbrhEb7B0WqAQC7pkSfUw5bAt4UDXzF6lL2jFeQMFZUSooxGDBqfwbte/v?=
 =?us-ascii?Q?AtOviumVVv0QL/sz9M1RXc4fEU2jHgsriiBqOQuuEP403ltWIEDU4q+xLohO?=
 =?us-ascii?Q?+pu2aOF9f9xz7atBfFnHglmhxzTmxsrfJ/2g/VuLMoTXA9Eono2OQuvOiDPz?=
 =?us-ascii?Q?rKnbS3C4O6u4vw1nTRLhS1DENRe+bi07fLHYW4Vcu9h6DZURf/Fi4B5atoJB?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HTRfjn3giintsNfyN5PIZdhEPoaip9/qKpVDbzSzMy+/UvSZvazy+FuqFmPkKDY5WHWymmTKQl67GzOvC4smMN4UTaLN9GGFNmavwoTpRgZW5CfFRNMFhoV1FoDL7at2FHTl3+jSWi7RGOlTGUwHHgcr6Fy60O2TtMRrJZiOePCwBHr/nPCyh6Rxf8odEksgVRSsTLD5Oyl0tFPGrp1uT9FIBEY8aSSykdypReRAcxjFAHbKMNw3jm4Aa2Gq1xBkVRifGkpU3DFSuN1Y/UvorE4UQiLzrEV4AuN7iYBRNO8lA5zbHwNbGTg+w81ojxtDQaAjmVYJ2lZHQoi/LLwvBEjvCuPluQ/mollrbJWyJRdZJl3WHXMOn/EDdyd+ywsk9+QqE1R/Vlzpf0TjA08PCZ05OIRdDwDpeqng4rcFj3A4O+mnn90jd8X1jx79BtmqbWS16EgH8N7yXzh9N+5AsF1Olb7o1ebHuS3cd/7tkZkiawSz5FtSXZf1Zt5vmMOos1Zw71g6y7Ltw7dq0QA5aTlaNe9GONe79yEwa2av3+FFnNhsV6rxVzvx94igjPe4mLaFs4y2clv8vmrctIy9E1fuxeV9W/iRRAxtfy6j7rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3affdcbc-7577-4cf5-9c1d-08dc68749420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:29.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH2DmNqHluUsvPB1X2ma1SSBQkG5WjmJ+qb849QjLKIDqHHOrXFae6UH2xyFaIzb/hyP+aWbjLW3ofY4bbeFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: UQsdTb0sNUBlD5dv5_bmf5HrNoiyv2xm
X-Proofpoint-GUID: UQsdTb0sNUBlD5dv5_bmf5HrNoiyv2xm

For when forcealign is enabled, blocks in an inode need to be unmapped
according to extent alignment, like what is already done for rtvol.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 39 +++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_inode.h       |  5 +++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 4f39a43d78a7..4a78ab193753 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5339,6 +5339,15 @@ xfs_bmap_del_extent_real(
 	return 0;
 }
 
+/* Return the offset of an block number within an extent for forcealign. */
+static xfs_extlen_t
+xfs_forcealign_extent_offset(
+	struct xfs_inode	*ip,
+	xfs_fsblock_t		bno)
+{
+	return bno & (ip->i_extsize - 1);
+}
+
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
@@ -5361,6 +5370,7 @@ __xfs_bunmapi(
 	struct xfs_bmbt_irec	got;		/* current extent record */
 	struct xfs_ifork	*ifp;		/* inode fork pointer */
 	int			isrt;		/* freeing in rt area */
+	int			isforcealign;	/* freeing for file inode with forcealign */
 	int			logflags;	/* transaction logging flags */
 	xfs_extlen_t		mod;		/* rt extent offset */
 	struct xfs_mount	*mp = ip->i_mount;
@@ -5397,7 +5407,10 @@ __xfs_bunmapi(
 		return 0;
 	}
 	XFS_STATS_INC(mp, xs_blk_unmap);
-	isrt = xfs_ifork_is_realtime(ip, whichfork);
+	isrt = (whichfork == XFS_DATA_FORK) && XFS_IS_REALTIME_INODE(ip);
+	isforcealign = (whichfork == XFS_DATA_FORK) &&
+			xfs_inode_has_forcealign(ip) &&
+			xfs_inode_has_extsize(ip) && ip->i_extsize > 1;
 	end = start + len;
 
 	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
@@ -5459,11 +5472,15 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
-		if (!isrt || (flags & XFS_BMAPI_REMAP))
+		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
-		mod = xfs_rtb_to_rtxoff(mp,
-				del.br_startblock + del.br_blockcount);
+		if (isrt)
+			mod = xfs_rtb_to_rtxoff(mp,
+					del.br_startblock + del.br_blockcount);
+		else if (isforcealign)
+			mod = xfs_forcealign_extent_offset(ip,
+					del.br_startblock + del.br_blockcount);
 		if (mod) {
 			/*
 			 * Realtime extent not lined up at the end.
@@ -5511,9 +5528,19 @@ __xfs_bunmapi(
 			goto nodelete;
 		}
 
-		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		if (isrt)
+			mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		else if (isforcealign)
+			mod = xfs_forcealign_extent_offset(ip,
+					del.br_startblock);
+
 		if (mod) {
-			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
+			xfs_extlen_t off;
+
+			if (isrt)
+				off = mp->m_sb.sb_rextsize - mod;
+			else if (isforcealign)
+				off = ip->i_extsize - mod;
 
 			/*
 			 * Realtime extent is lined up at the end but not
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 065028789473..3f13943ab3a3 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -316,6 +316,11 @@ static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
+static inline bool xfs_inode_has_extsize(struct xfs_inode *ip)
+{
+	return ip->i_diflags & XFS_DIFLAG_EXTSIZE;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
-- 
2.31.1


