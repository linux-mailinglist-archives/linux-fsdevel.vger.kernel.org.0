Return-Path: <linux-fsdevel+bounces-78902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0As6EjqRpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998411D9CC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAAD03034DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F538377021;
	Mon,  2 Mar 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="auJIEYia";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RwYed+3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5C286D7D;
	Mon,  2 Mar 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458285; cv=fail; b=HgwHKRY+bZfUqvLxZLnqk71f3V7jErSYQjyPcQxQ8mPNQKqVLXxBt5bKKOlcvAznTZnTSZXtoXMvWBUSlUen7aCv1SrXAXvJ+I13mh2/3yebzbuG5rChmR5EHwfyNRkAD5yfq5+EgmCr8jaAHO6KSgR8ZbK8DH4iFSsU3s47ydI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458285; c=relaxed/simple;
	bh=aMjhWkB6a1PhoVHxyObrO9oYWWb2fU2/7rUaC5p3J50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2Jnxy0GyHzZOpR26fle+ATG8fhfA9VMFjtjtPA601PFLMeeXOjJEhOHr7BwIY2Ay255ryHnyOPV0nH58QmtpQkGQRZI1mvP/uzkRaN9l9Zj7CHRmkZlj6mWb9Zk+F63W6s7DNOJuZzE2VnQkTpwr7hfqO+kmj8x00GqfOiYa54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=auJIEYia; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RwYed+3p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622BtukK1059814;
	Mon, 2 Mar 2026 13:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HnnGjhKZSZ9h3UoLl+
	mjz6VZHSqTUwF3d+sCO60apxM=; b=auJIEYia35V7U/wumkf1jLRKbxIMu4upvV
	CncP1RIwQ/tQqBguPPY4zqLvAdFDCx8OQPt9QZ8V0Bz23jBYpFdFdC4UTiwvcdJl
	XQezPStXDbIFpKEiBX+7Zb/ezJ7/8/Ez4zzZ4S3hAaFKw1UjddOvxtcXNaodkqvs
	wXZTroF9d6+q7Xrzmy+iJF36PoUpQCL2IZW4S9yzRmzgZxpbTf8EXLeShRvy2hzm
	Xe8jqs+8ZN17qEUoQ3GMs7OW+yHIMq/gXjc4VdsW8USGfJ3KgcGgMtlHWdEn+uDU
	hRB475Fy/+Q7Kd3Nl6UVp6qRXO+W4GYpR0JfOuqdivfYan507C5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cna3t073j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 13:30:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622DMbkq037803;
	Mon, 2 Mar 2026 13:30:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptd7dqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 13:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCEg0xjj5ib2ygT/o7oktHQOhTq184v2BFKKADVdJjHH/KuAPNpc8sSagMakXiJPK4su0dBVjgbvOEXkimDMfVNG22o5dXKopRVw8jR2bp3KrDrt8Z1tb+IvGjkqxuGFi0mfSM2nfzMIokDWy2UAIji2+y2ddCyA472v8fZKnROimm7lHQgx9ggwLEB9KpoUdwu3buvpiFjnNfiuonVx220EV2TN6+bkwJ7bIEKj4XBKaAHAIIHei/wSTj9gU/mw5WhFPNrj/o5fVSyXNR7xCnW5oj/PCj5b7+VjPEp6v0ScavrXDZqaxLs6hdJdMtjWeJQQgJaJgUgZD61Hc9DVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnnGjhKZSZ9h3UoLl+mjz6VZHSqTUwF3d+sCO60apxM=;
 b=b9y64HbA5mmCHtqmNQEGcQuIOR+gzHo8qv4cSvHk6SuAAB/+alC4tAw/fEegw6hJJO2PAq+aeLDlSwHlBGhVTzAMHPDzAUg5HYIgbBhIVePt/KIMfPuRXUNqdr72wMfWQohKHn6Sl504iQhZfXBWgQzLD9vOA7ZGeR+uRY+ir2LOwU130rzJYW3y6ySaoyDxBlaSZaXN0Ov0McVpRDVg6HeMIeJursitAqxWS3jca28S+0e+VfWef5CRJc+7iOG3MPEvgUeItoXYa65+9PnnFVcnfDQgLNivj8h50jbp66PbxRqvErcLByQg9nQ3Q8BVT8k0Ugg5Nt6C0ZoqYqCm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnnGjhKZSZ9h3UoLl+mjz6VZHSqTUwF3d+sCO60apxM=;
 b=RwYed+3pH0DLJA3EYcmeL4m1umghEhFBUWkx/T0N7jBs9YQTDagfQskc9zmke3UPVspyBmJ/pUwF+bUkiugzCez++4Wp7G7XYFBnje1BO83Ps4eIwxwUh5gJfH52NaXFqd6jowiCyS+HUeCFqkWQhCAgmRNpCVavXDNwiNQfRXY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:30:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 13:30:31 +0000
Date: Mon, 2 Mar 2026 13:30:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
        Eero Kelly <eero.kelly@dfinity.org>,
        Andrew Battat <andrew.battat@dfinity.org>,
        Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
Message-ID: <54a4d554-d4cd-47d2-bdc1-8796c5d7d947@lucifer.local>
References: <20260228010614.2536430-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228010614.2536430-1-ziy@nvidia.com>
X-ClientProxiedBy: AS4P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b78dac9-d6db-424a-0d31-08de785fdfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	SISaXIYC1rb9xQb3OfcC3+HtErP/ZWd/xY4aeJ9a5t7T1wyQz9k/bnAXCwyUEHgPSFeHFNlR/8ZO2odCL4ujRjS6itdohqxAWX7/mUCiZ1R5Ozw3amjppYJUSZ26dYTJjdbQdv9CHy1bl7pkOf8F60bDUJ2roja5xIsW9d+vNMNaid04OmxmNTPVT07/I+Qbje6fh++tyRdKGpmr536BBB+MhzVcQv+ZSXagPn717V0uZ3XLqH5wPXwUZhZ43KobOkuYHGvIVFKC0hRUhdErflliBRmpDsFfEoYFvWyw7OHUbf5L0P/S23ghyJ/qLRbF1PAKi3KOKmEcybzyqR3J2ckXYCrJqCLYPcTgUIjJJLle6teCXbCfyo1mhMPEOsZNDZyP+iTcPw93Qijbjy6skS1Z8g+f2iZ8E8JhOXoXu6JxqFVAtKhyQoTyER3wFHimJQhV8AEk+a0luEqq717hobbVxT+gsbVHuwP01Km1uwZEx9NLl6E9xiZ5IvoqKY/Zm2UayiIZB3nCPagwUdrc0IkzAM7S/4SNy5U+7Kz3MvMokyjcIviUlqEH08ftDd8K2e57SvPTFG9T0myyDTsUnqZJD8lsQwAOaBgAOC9zR+GkN5DRp5JWMalLKE94QVlDbsqukszEgEZVaFu8aVZkwXdNHkbXDYn0VN16lQdYZUIy34VMdmEXqaCtoKIbeSGfSzVu0ayRGYi61OexATvxLykNok7wpJfTTtE0zi+/63o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGbIAKYEi08wlnoS1D7xmwwiaZ3cAnFBo5URm6pYxo8x/636TFpVK1sfwDQg?=
 =?us-ascii?Q?n/WpPVxxwCHIMB+sGsMFiNP7vy7f/SzQLsdRp0Bzd2u8RyiZ71QD0E3U4/Z0?=
 =?us-ascii?Q?fDKG3RLSO3t+VA8Wr00pSqTiVyfKHWwfYSoZRxxpP5ccTEmipf5bME09a7n9?=
 =?us-ascii?Q?GgRWQMxZDj2LR8YdykS0CrI2SIRlfPdUHxxSjhwNQQJQ7hEnTdMuXfxKS8QO?=
 =?us-ascii?Q?Q70IVT8uLohs+ooMoTHAFUmPeOmrrEF0azH6jpI1JAlGd4NPsTI4BFV/5tb1?=
 =?us-ascii?Q?pVJygpW5OEo+zFqcc2SZ4ca9GgnF8bEfgkMU5V/FIodlVt3F9UeLTXTWaVkO?=
 =?us-ascii?Q?xdiJUZFAVozDmpUo3uYy0IdPlimNzlTPQ/S0VY5YPWblZywQZmKoA70xSLEo?=
 =?us-ascii?Q?9/fwWhqUx1bM4tx7iO9Z9tbziEdSBK0NyVLLxV+qvUO2WSS2LgEzoPoMpX5V?=
 =?us-ascii?Q?Smu1O5JGN88I2kUccSXVxwJnzZM6x/J+3JBlN+/WlMOHzLPn7v59Yb806SRt?=
 =?us-ascii?Q?waxJEj1FImpuV18Dlp2/BCGzIomxZPXSxyFPRBtz88z4dpYPK2Udzv8x5Jyw?=
 =?us-ascii?Q?dEOzR7sKFmpvNY3/Qafm1BXLSbHyR/MpgjhK+0EC/22I973QzdT+Bza2LVQH?=
 =?us-ascii?Q?wkzTSW7YlnDfWDxloK4uDRWp/VlenVSrXL1HCLxQERYJyqh+98kSfiHOLgI5?=
 =?us-ascii?Q?89uz1mLlb0lb2RB5h3R+JxRaRCncLBcEtBaZVKtgO46H/Q9fJeARt6A1zQX9?=
 =?us-ascii?Q?P1Ox9MlnpzavZkjcC8bp5YFYcHKETv5yWP6+GJ8zPqrHbUOpXISf8ko8kefa?=
 =?us-ascii?Q?LAjVMH/wfqAn1K5AkLZiqGBvaZgB203hD/HjlW0MmFuDzPDlRb0VX4uwUAD8?=
 =?us-ascii?Q?oMncjQM/6YiO9NSNmR/2fez9uYyErunYJ2WAe7NjvkYnsT0s3CuS6vHfL4GH?=
 =?us-ascii?Q?SoLRPgnBx61JweQ7/j3A6hPLnuLKSiZTDPkc1NE8yQsiMngf0VpY4xtQvxrI?=
 =?us-ascii?Q?+flTnqySIq5nXzXRrMGE+MpDhFP5T8vW9KqEkzzXwpAumR/pwJeE4c0JEfak?=
 =?us-ascii?Q?Lp9Tq6v7nuoKo/HYr4ULcfVeBJX+9lZTKQVq8K3GM0s0vUxa+bOXbTy6gZio?=
 =?us-ascii?Q?r8SmDw0APIwbKIu8dRvK3UupHsBkSqKcHiqpTZ15m3RHQdZQt6GT7WNIU+iu?=
 =?us-ascii?Q?L50EmxQi0WCpB6FNlfxTqLG3/6o8zaVAPuNx9QalqhmubYDcoyq+lmlW34f/?=
 =?us-ascii?Q?wDRDhbpLOj/4QlqY7sXFlxUhndd9W4wFKJxzyUX7+6nAhKsAVXwiQ6kuM8iO?=
 =?us-ascii?Q?0CERvN8GStw8p5gfrBqqn6ZHMd78rlzQgQjvyqv2h+C6IPK+JEWk+l7WC490?=
 =?us-ascii?Q?5yE50fsWQWGtxwWUrIcKP8oyrnJMkjknx0bMQbp38+AYy4S/GJXRJpRwsdy6?=
 =?us-ascii?Q?fS4banLd9tglic5yg2RHpLm0EcShhnoM4XTMTh8/wj+Ysb+KGBobxk3b9iq5?=
 =?us-ascii?Q?K8GZuwRlWPlsHRMwZU9Q0OtzDX0FtKNfyc0ZGTj4MXMBu4Usm+ESQQbBskdw?=
 =?us-ascii?Q?rBPEc7Owjs9bdiW5uY7lIo+cfJmTVYmhrtPL5x7rmktuexpgYjL+zfk35taz?=
 =?us-ascii?Q?wWj6OepEXn+wutrsTqF6W3ojmaAFjbXKX3Xxsx+2HlXe4nS01atOF7vXi9nZ?=
 =?us-ascii?Q?dPBrZ8jAJfj1jqWDirRKntV5bNzu99Tk97P+qOYj9S1/5DapraqBR3gTy/WU?=
 =?us-ascii?Q?OZvCjS9KDY/gOqgAtq84K2EoFv/Wi6o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	whCu8vdbSnefCcuAbY+x32pqJyuAHkrAZ/1cwdUrIBdeh5wRbydfqirrcqtjTfZFVVTD2p5RtsbERFfOFRq9kslx+THiSzBiUK69z/aIe8wIfXE/cvqSQVEDRDRoEjUtnD7tk7pNgPagEdV7RnVw1NHOAhTiKZbQdG4WFsrT9h0UE/dPKEs60mrSfIYFlSOUo5iU8rIefLBOfgCScz8tvv5PPC5vGOHY95bmZAAgrq/73585wd8X8+VsSqlrk2RbDrEbXMOAQBErN5zPoBaEork6Hy7hGDhos5jB+wkamvkLnclozTcT/ci8RnXsZ/sGcYkNuAwHlS45u3Dtob+PQM07a0oOSO36xMj6+kXn0PQiSx4Al90z8Y0M0mkodLkBhF+/vY6KnwjrX1mm+0D5KAnivbKmE3Nd+ENEEvSKDJAuy/X9T/LZRXoXvWXKct/q5+YmwzIyaEjZ9lz64D6OpDQgDvy+Gq9AbvhKP403C5xWuX3GU/cO0OoSKSXo40PHVyjCtuZAIV8KAsuCrNpZgrCPCDgP8484KjLJTWZApzk6ib64+JUDnC2MNDz349LXB7iDTLz1Uhzc9yGqALDVOrCzHCnYAkj8vJURqsJxQFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b78dac9-d6db-424a-0d31-08de785fdfdc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:30:30.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qY0noD8vtQf7Snkhrzdlk+Nw72s7GbUXFC5uVynEO/BiFBQRmmNngKBhfHw5Xg36B5+vKfq4CeQJzhK72a0vSILJDPJdW4llsKYhaCJ7XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020114
X-Authority-Analysis: v=2.4 cv=L9MQguT8 c=1 sm=1 tr=0 ts=69a590fd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=m6ntEmJwAAAA:8 a=Ikd4Dj_1AAAA:8 a=QlgwaIoH2ZZKSwNeNA0A:9
 a=CjuIK1q_8ugA:10 a=-07UcHROD-JCDqjaZ46G:22 cc=ntf awl=host:13810
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExNCBTYWx0ZWRfX+BiSuuFe+tZ6
 uIUxAwGlq6miXjX/T/m6pqOaDhuvqaqEEGcYuPf/SG4oS4PZr2xlgMBfLZxWHLajtp9qQB49UwE
 ScZfQ+kecXo9+9e2t44by92oNUlh/Q/Y9avuWUCKAZ4cNQwpRHhv6YzltfRWQKJEc3t2YX21XyF
 s5yiKGfmDQfnhKOUBDBwz2OS6qBIHGFQXDBE4xt2/v6NXIxFq324nqvGd7+2SBc/0xUZB5MjB67
 OFooIATWuYs+Cy6xtDuJeD3ErTXyUlyQ71iK/gwAJ43dweaAMowG7mrZTL8qkUTfXWU6Saa0SkG
 u2/bTsan34/L0t1JuAzRyBY9kFmq+70hB85MF9Pun2/12/9hRwW7q7H8sVWoYL/Sdhw513DFa1M
 melWnKoc4ulRg0yVfK1js2zGVX8kp6YmYzW2qw/1ZL/QDKi+ksXdBzwiCrWlfXOQaHOp4dUhRrn
 bgtQULBz1LwL41PxME4OgWSGJ+0iJG6af3Cl+LTE=
X-Proofpoint-GUID: zF3iJdA6A0V_lDIfiq1GKHZzciYznBRH
X-Proofpoint-ORIG-GUID: zF3iJdA6A0V_lDIfiq1GKHZzciYznBRH
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78902-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,nvidia.com:email,lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 998411D9CC9
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 08:06:14PM -0500, Zi Yan wrote:
> During a pagecache folio split, the values in the related xarray should not
> be changed from the original folio at xarray split time until all
> after-split folios are well formed and stored in the xarray. Current use
> of xas_try_split() in __split_unmapped_folio() lets some after-split folios
> show up at wrong indices in the xarray. When these misplaced after-split
> folios are unfrozen, before correct folios are stored via __xa_store(), and
> grabbed by folio_try_get(), they are returned to userspace at wrong file
> indices, causing data corruption.
>
> Fix it by using the original folio in xas_try_split() calls, so that
> folio_try_get() can get the right after-split folios after the original
> folio is unfrozen.
>
> Uniform split, split_huge_page*(), is not affected, since it uses
> xas_split_alloc() and xas_split() only once and stores the original folio
> in the xarray.
>
> Fixes below points to the commit introduces the code, but folio_split() is
> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
> truncate operation").
>
> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> Reported-by: Bas van Dijk <bas@dfinity.org>
> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/huge_memory.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 56db54fa48181..e4ed0404e8b55 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	const bool is_anon = folio_test_anon(folio);
>  	int old_order = folio_order(folio);
>  	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
> +	struct folio *origin_folio = folio;

NIT: 'origin' folio is a bit ambigious, maybe old_folio, since it is of order old_order?

>  	int split_order;
>
>  	/*
> @@ -3672,7 +3673,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  				xas_split(xas, folio, old_order);

Aside, but this 'if (foo) bar(); else { ... }' pattern is horrible, think it's
justifiable to put both in {}... :)

>  			else {
>  				xas_set_order(xas, folio->index, split_order);
> -				xas_try_split(xas, folio, old_order);
> +				/*
> +				 * use the original folio, so that a parallel
> +				 * folio_try_get() waits on it until xarray is
> +				 * updated with after-split folios and
> +				 * the original one is unfrozen.
> +				 */
> +				xas_try_split(xas, origin_folio, old_order);

Hmm, but won't we have already split the original folio by now? So is
origin_folio/old_folio a pointer to what was the original folio but now is
that but with weird tail page setup? :) like:

|------------------------|
|           f            |
|------------------------|
^old_folio  ^ split_at

|-----------|------------|
|     f     |     f2     |
|-----------|------------|
^old_folio

|-----------|-----|------|
|     f     |  f3 |  f4  |
|-----------|-----|------|
^old_folio

etc.

So the xarray would contain:

|-----------|-----|------|
|    f      |  f  |   f  |
|-----------|-----|------|

Wouldn't it after this?

Oh I guess before it'd contain:

|-----------|-----|------|
|     f     |  f4 |  f4  |
|-----------|-----|------|

Right?


You saying you'll later put the correct xas entries in post-split. Where does
that happen?

And why was it a problem when these new folios were unfrozen?

(Since the folio is a pointer to an offset in the vmemmap)

I guess if you update that later in the xas, it's ok, and everything waits on
the right thing so this is probably fine, and the f4 f4 above is probably not
fine...

I'm guessing the original folio is kept frozen during the operation?

Anyway please help my confusion not so familiar with this code :)


>  				if (xas_error(xas))
>  					return xas_error(xas);
>  			}
> --
> 2.51.0
>

Thanks, Lorenzo

