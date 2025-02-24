Return-Path: <linux-fsdevel+bounces-42399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36301A41B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D591891BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666E257AE1;
	Mon, 24 Feb 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gf+ow+kh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tb2fCR0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69724502C;
	Mon, 24 Feb 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394169; cv=fail; b=t4CzRw6kZPNXWBD6gtKjS+IdQh8TTRfkt+OnWb1tNp14uSGl+9fGu4Tk86ai6Sw3vwr/QIYw3ckCh+DU/rNIg2PasIW02gxf28GJFgxOUAmE1R2EDhX1GdoOr7Q7XrXVJtnCIRsi8PmHmSvp8RGocXoMHo8IWg/ILrdzTvPIFD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394169; c=relaxed/simple;
	bh=RO+64geS9SjN85brslW06TcYy0wjBHmeCchaOAT8Zww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bukkbF7kWIqV9fLEdEY4u5qcbUyR7epjRah3iEjPNslAefhL2pOQ99BRoa/8pqZMBkHCYEbwfP9A5aRv5KvBs09ver1oGu09E1+LD9imKLf6EH+/5wHljToijy5akcRDgPF7svXjwSlgNgq72I+Lf38QwE46yUjdcQnluhhqnic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gf+ow+kh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tb2fCR0p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7fROV013302;
	Mon, 24 Feb 2025 10:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+TOovHBy3ziS1x56E6
	m00UzJ3SQ5GB+YU6YAedA2W4o=; b=gf+ow+kh+3qjyj+dJb9CIF9nlOuvwyIWdc
	0x+efNZz9C0O6MyZHctuaPddeBebvGR5g3txuTJc9yfAvj3LzQrqqpVuwePRcz21
	fLpZeoUPhr57QbxV/fl0DERyUEqI7F4TMGAfn9tk7yFpuoas/Kg2e+R+SzAH8S1y
	GsR1pVPrTF1pz8AWreKTG6JwBelYOnfc6Jk7dChDKn9Q8gqsFoALFCr4fk9Sau47
	+OnqatGOfHi028O6SdbKnNAJlkKIwz4a5gfqQdiZ0CDN16AWg/It2mjn7wpSMEWA
	uzwSfFi3h0ITRgrQt5MUuvKijpaNChFfW50wqxRS+g68xLCodslA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbj9ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 10:49:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAb2TJ002741;
	Mon, 24 Feb 2025 10:49:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517qyn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 10:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqjpxjvTKCEObQZxgVtRbDcRiMLEFE/T1HFUMQNzlvPkm2U0kIh4Bi9rMikM2+OTVbbPVQ0eJX8Hsb5Doz7msiRQvr6GexfM8CLg6ls0DWKmtzLF+q86HiX9vmaGNWxc62iEZb1TvNoohKeTQ0YHuB3XJmHlqf1wNzMXXzskJGjPVhpPWb6IqLhFyN7Pc9q9Pfczf8qYtOfMAO71rnMQ+6m33wu2lzHocFENbi2LPxLRXGtrYPG718Ne7uMyeZwc+RxUrJDNsRwGecoC8h+HgGlnZBmiU81WfPYcnvoSDB8KAf2PTei9c9PdeLeshbqJYMo4e+sThUWHioUjYE8C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TOovHBy3ziS1x56E6m00UzJ3SQ5GB+YU6YAedA2W4o=;
 b=po/RzilCr3PmtkqwBbGL6ZxL5Jz3KFIkDdOo86gWRDKKF2EGXUQO+ER3pylv8ATglFNrE65W/1ECT3l9e2t3JVBwCjDhX0KAUOMhBPBrn7T3IrVMUJPsZ3FIYW0Zxr+PTPesjB0/lXWoCSZKQ1lsUqthxCkSCQeABgMkD6uy370DT8G2SAvQQqV7Og9RaF9yyoZ7coqs3ho7QxMw30jfYzbiUDcyabjLZJhOVanFsFwp4tALG0vi1dHEaz5aObgsurQKTIIYxNXCZYwHKpuNhU8UGTBEOiXma+Dm9L1Ap9ZCR/FA+zAhf5gXRcJludrO5MzJWq2WVtQhngFF+cQYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TOovHBy3ziS1x56E6m00UzJ3SQ5GB+YU6YAedA2W4o=;
 b=Tb2fCR0p5Oe6E3QbaE4vAv/tEOD/c9EEi//r32MaHnuQufGJXTvJDIgzHclNL/I5F+7WbDx6Nlf953G4xcbqoPONLiR6G6ElqLgmpegvE62PQiArO2OREdEZg6F+5idYWn/Ra6AKRvz3GGkVqoNjwmM8trmcuokvRtBV+jpERY8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 10:49:07 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:49:06 +0000
Date: Mon, 24 Feb 2025 10:49:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Message-ID: <e687dd75-b76f-4eab-805d-7b1bb18b1365@lucifer.local>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
 <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
 <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
X-ClientProxiedBy: LO2P123CA0035.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::23)
 To MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a47a6d-05ca-4acc-2c1e-08dd54c0dc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOR3CLVy9fV07X80XJ1mpKH4KoLoD29nOs/gIjIIHmhM7XBBAJZlLtx06GVk?=
 =?us-ascii?Q?JJA8FZaVg7KG0pwQ6uTVrrEfWetrhrfLouOdqVUbPIXiPK+GpJ6frk2JM9mw?=
 =?us-ascii?Q?13O+feHtpFeY++JWqYImGMBqoVI1t2MInI3RnoHis3aTOYC+4aSrRCQYyE+3?=
 =?us-ascii?Q?bMhXEP0mzCJhJpUI4a/y7GNPG2k280Doho6UW1Aov0jcrZJb79jZs597dFA2?=
 =?us-ascii?Q?UsF91baEHglTaJbzMgyrMKKqY6ZgcfDD3SU0EpdoZD6ork40kWCxoEJNScaB?=
 =?us-ascii?Q?GLHlCGs+cpkk/n67zqFEnz4HQ+0L0/fxhO/b6uTM0bImLhKF5SY/yaaRJL34?=
 =?us-ascii?Q?FttrVajKSFpXK8oyT9vGMmkCUZA8/p6+S1WIKKTz6pX8K1MApPYNCzk9ImxD?=
 =?us-ascii?Q?i24qJU1mNiTSAhyrpA59k6Cyiv0tDkjEtmM3rxrtVALckauX/2laQCiEXXeV?=
 =?us-ascii?Q?0UzVybGQM7Atmy2NuKythnZu9lC9koDtZfJl6ikOvLrwF/FdFdWsI5u0bV5H?=
 =?us-ascii?Q?NzGYQFmA38kTrsCZW5H31njrwI6+uxZ64u0WpWXJpYOvhLz+lS9C++/VNYlx?=
 =?us-ascii?Q?7Ek12p1dmeMkw1bMBmYc9tAahriZVtxxi4YPc48J6IAsTdGaBU+FhoSK3QvD?=
 =?us-ascii?Q?RO+kUyn82HM+5x9Yb35JeCoOgor5vEb5LOJYvrrfmvKPqRIxtOr84hum0D3K?=
 =?us-ascii?Q?8W8APgH1rfDmo+CRw/mkDASMyBWBJ56f7xpWtiYSIrkilbCrYJaVRuMLTQ2H?=
 =?us-ascii?Q?5MOihMVQoQ28+eaKNyIE+PbLq37YfGK9klWQKPv2mcnaNo2SHTGOT0iiUqOU?=
 =?us-ascii?Q?/QQDeOosyt1NROJiZp0E+qsxMf0qXeU55ePPz3CbSfvXFAE7x3976ikkDTFb?=
 =?us-ascii?Q?3V0UNaMrX8IowkqrTwQ3tRrAnSNy3M33t1HsqiuUaC8+6jZQjoHBPud7GYIu?=
 =?us-ascii?Q?raxsoKWCQWRhoWQUdBbyxkhResfA1pkKy0D23m2JzB2TmiRjf7aR4C8Niyn3?=
 =?us-ascii?Q?eWxiBNrz20FZ6WwGbZFmePUA8ED22mO7RjlGFTuuEn26iB3q9tJIKHx1DoAe?=
 =?us-ascii?Q?iDf5XZXu1w8VURa+CnGA0dJv775Tkrj8xI0XhpbvqGr4YfHbWV5y+F2jS1At?=
 =?us-ascii?Q?GDpiq4PXdrLlDvidHGk24e52YSHGv0njH8DKiCpHZpw9fQioBuvJM6LK+mYb?=
 =?us-ascii?Q?MLcf3XiAPLwxsRnn1V4IYM8TXra1pwVf5A8c3ejBHbVcB+9zq2kLLSWVSY1M?=
 =?us-ascii?Q?G4lD/VqrniQ31b54dsO+Z6yqBnwVBV+DyP1kWbT2lklKojQVN0TDbuUm83nJ?=
 =?us-ascii?Q?dK17P/w5iMU4RyE4DAyQEOIPs7EcnUz9zgthT2C3P9yeas23DBz3ah0/U5W3?=
 =?us-ascii?Q?hA+eRLgHznvpCc/K5SFvMT27q15v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZppXIlwrhXtwIrhM4YyDQD/wa+8hcSs3hBXozg4njyn8Y4KioHkO05268WcM?=
 =?us-ascii?Q?YoctYDwgAb3IT5TK+Uhytpn10g0doNLHDCKPKgacXxJISLzgZ20Yuu8vrsZ8?=
 =?us-ascii?Q?FH9dka57TGPEH7sfkC4L5y1ghgnDw05JdviTwP749+LZ5OzejXNJlEiDjPnW?=
 =?us-ascii?Q?kjdbeqBWb1brcGSQabuEEGnGVzH1opMZrt0VtjjKE1T4e982p3OfgSWCq0a2?=
 =?us-ascii?Q?LPvMN+tTcSFqXBtG/ILpgGiZCb/Xgl9EY4yTSe/y5Lvc5gy2wAbc7xem5GQ2?=
 =?us-ascii?Q?X450+shITu78LvJOlAkKuQbjUF3/4OGYkZiz+FMNmJNAThggYdjKh72sBv8d?=
 =?us-ascii?Q?jY7uMMMPY0Tl3QsnUsLfdhasAQpM584uo8ZL9CeivSiGhp3RE8gjar9pDGDf?=
 =?us-ascii?Q?bnL3V8WBAQ4gqsk23OHCnNAU9WIcM18hw99v7EFI72nA2TYpwKgktx25t95T?=
 =?us-ascii?Q?ECVjwUn+xN0psvaJ9+EFmu5n5bhhuMknFZzGaCwjiGqiXl5b5VAidtJXXp5f?=
 =?us-ascii?Q?NDXGNg4t/C0BshtiA1vm7ZTuliJxQqx7ype8N0t3+GHtj79wD7OmvdFU25X9?=
 =?us-ascii?Q?vjA62C0GsIBwY97Mh/ED09SGRXZqjBfvJcYfpTssVQ6V5lnszTFge2m2PbxY?=
 =?us-ascii?Q?Ijjts+Fk/Xu4OkpgH6yjDiQkOk0zV+mZONfvlB3z9A8KffnqIT3SVO+dXH2U?=
 =?us-ascii?Q?bH4/X0FkkClWCYfGe5QZay4zt6yLGcl0P8B6y0wksABdEXGSZCpKBIr8OuQE?=
 =?us-ascii?Q?/p8EVlOVij4RW/Qbx4Vs6rZrOlQeB13sHyB2lfQhThYtI6G36LG+lXb2L6JT?=
 =?us-ascii?Q?+G53AdrUpzSh7UhoJZxUzchIwWcSrlSC0FyVbdsHZOYk0NHsg++iadf0M+rk?=
 =?us-ascii?Q?BiRXMXx91aht0S2He+JroB3YCqtV2xCg3HeAFgceFEgMvLIQttehhaPlgFb2?=
 =?us-ascii?Q?WpN4OAsJY4FiRSP5MqrNdmbisF4qY5eFWmwx2yQvWq9x2Jf6F3XNwy2n/5p3?=
 =?us-ascii?Q?Tu1oisFdlvDHhE6LBe2+aAR0rnXuwFfr7uFV5c/h4jr3Z9BwizGHbmhE/PtO?=
 =?us-ascii?Q?4tsWhmOPwe+ToOGEaZNad/2QJgDWZwArM3mmEcDlHiSzHrRoh+U8ZhzujDxN?=
 =?us-ascii?Q?I7uhR/uZgoAcyAH9lEa5Emt/hwen2OqmX2SktJ3IzIAZPa9adw+svNX5r/uB?=
 =?us-ascii?Q?vwa20pv5Af77E1GtL+he7VMVgOK8E2dBr3apokui4agwdhZSMzHxg/C1aqg5?=
 =?us-ascii?Q?UeJKHUu0QafC3Lv6Ban5Q29JHKEgyVYawJM8B/yjDexQaozLg/UdrH+URE8b?=
 =?us-ascii?Q?FHi5JU7cGS8KnftNswN6nTVHwd9+0Cv5YeQeiaPsxZAscCDc03/KxTH8dftb?=
 =?us-ascii?Q?T5XJnwx5tFI10+hm1IYGZtCb38mYSEAvRKpYDV7OJPKO50BtltaEHqHtL4C1?=
 =?us-ascii?Q?PdYJbZYZ53md6EEHbf3IF7b5LNUyBd/ww/CTsMeaPtkj0Xq7o715hsVKTPkI?=
 =?us-ascii?Q?zZuQGd/JY1CtfK8nLTImW2aeTIG29UrwwirvgRO5LLnLRkHPJ96KZfTDfn+e?=
 =?us-ascii?Q?MLMYnxOmAefulFNM9qALqjWCpHFN43dDdNIMDjxNC3Y4AfQ5d1Eo6tRz9iFT?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DGUCq4ZQn8dSKK07wpeI6C6/Dd2dDg7yaQoPaaJINt2lYehq9MfqhzHr/wqJ5nf5GpfSkIUbjewV/isQNkIaZOTJxmYhHJR6BnW2YQp2oky44IfDJNvYyu4g9Cfbw0MDhwulx6LJ9D64fM+yra/bLe293LclB5MoQWw/C5I9u70b1Dzc22L3uplDOhkSc4RmhF2Ft10E//hOgpfWyZjCyVGzzaCzYBm4FIHMPUP4s0pYTO59R8YaWKC/d3q0859UDzusYx2fQaSNdHuVsF7F5jK6+1a3cx+ViDJsDOgaLOUfVF03YEY8xJnl/AnQp3jJVWf1NyZ5TKQw7a+NCCuD+BBasXJbM30JPfDh9iIbcjddBj3YCAZTRRkzmyXSBeKQdFPbqGcfMq3soN1XZo2Vm3uZ2tAaOYapAjbjTfXgCF0zRWKDfX7WW8XK/UZkkX2PVVY3ykfWrSgzRM0RCgGCkg4cINmlJoUkWgsvo+lq40us533E1Ay1ShQvevsNZI7aRvwz6lEVYCq//ZJt++EfavtJjjJDfG4OT3pQaDHLRocM1YONuC4+VPIKY9nBo+1+jzYBqIsgOl93XtXpdJ56Jsc64isLXOaazdNEKQpx5oI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a47a6d-05ca-4acc-2c1e-08dd54c0dc6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:49:06.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzowDUJgt5bqzK6hanOfClsmREENlucVfE0P5h1nY9rCAjkTPvueXZ9s+Au5MY7ds8M+cBGLMVSr4conf0x78eoCzgdFMjw5+aI2mNQRwSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240079
X-Proofpoint-ORIG-GUID: -6AEAD4hDut7T0jI_HJL7i3ZVx08bcSL
X-Proofpoint-GUID: -6AEAD4hDut7T0jI_HJL7i3ZVx08bcSL

On Mon, Feb 24, 2025 at 11:37:24AM +0100, David Hildenbrand wrote:
> On 24.02.25 11:18, Lorenzo Stoakes wrote:
> > On Mon, Feb 24, 2025 at 10:27:28AM +0100, David Hildenbrand wrote:
> > > On 21.02.25 13:05, Lorenzo Stoakes wrote:
> > > > Currently there is no means by which users can determine whether a given
> > > > page in memory is in fact a guard region, that is having had the
> > > > MADV_GUARD_INSTALL madvise() flag applied to it.
> > > >
> > > > This is intentional, as to provide this information in VMA metadata would
> > > > contradict the intent of the feature (providing a means to change fault
> > > > behaviour at a page table level rather than a VMA level), and would require
> > > > VMA metadata operations to scan page tables, which is unacceptable.
> > > >
> > > > In many cases, users have no need to reflect and determine what regions
> > > > have been designated guard regions, as it is the user who has established
> > > > them in the first place.
> > > >
> > > > But in some instances, such as monitoring software, or software that relies
> > > > upon being able to ascertain the nature of mappings within a remote process
> > > > for instance, it becomes useful to be able to determine which pages have
> > > > the guard region marker applied.
> > > >
> > > > This patch makes use of an unused pagemap bit (58) to provide this
> > > > information.
> > > >
> > > > This patch updates the documentation at the same time as making the change
> > > > such that the implementation of the feature and the documentation of it are
> > > > tied together.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > >
> > >
> > > Acked-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks! :)
> > >
> > > Something that might be interesting is also extending the PAGEMAP_SCAN
> > > ioctl.
> >
> > Yeah, funny you should mention that, I did see that, but on reading the man
> > page it struck me that it requires the region to be uffd afaict? All the
> > tests seem to establish uffd, and the man page implies it:
> >
> >         To start tracking the written state (flag) of a page or range of
> >         memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
> >         ioctl(2) on userfaultfd and memory range must be registered with
> >         UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.
> >
> > It would be a bit of a weird edge case to add support there. I was excited
> > when I first saw this ioctl, then disappointed afterwards... but maybe I
> > got it wrong?
> >
>
> I never managed to review that fully, but I thing that UFFD_FEATURE_WP_ASYNC
> thingy is only required for PM_SCAN_CHECK_WPASYNC and PM_SCAN_WP_MATCHING.
>
> See pagemap_scan_test_walk().
>
> I do recall that it works on any VMA.

Oh ok well that's handy then!

>
> Ah yes, tools/testing/selftests/mm/vm_util.c ends up using it for
> pagemap_is_swapped() and friends via page_entry_is() to sanity check that
> what pagemap gives us is consistent with what pagemap_scan gives us.
>
> So it should work independent of the uffd magic.
> I might be wrong, though ...

No a quick glance makes me think you're right actually.

>
> > >
> > >
> > > See do_pagemap_scan().
> > >
> > > The benefit here might be that one could effectively search/filter for guard
> > > regions without copying 64bit per base-page to user space.
> > >
> > > But the idea would be to indicate something like PAGE_IS_GUARD_REGION as a
> > > category when we hit a guard region entry in pagemap_page_category().
> > >
> > > (the code is a bit complicated, and I am not sure why we indicate
> > > PAGE_IS_SWAPPED for non-swap entries, likely wrong ...)
> >
> > Yeah, I could go on here about how much I hate how uffd does a 'parallel
> > implementation' of a ton of stuff and then chucks in if (uffd) { go do
> > something weird + wonderful } but I'll resist the urge :P :))
> >
> > Do you think, if it were uffd-specific, this would be useful?
>
> If it really is completely uffd-specific for now, I agree that we should
> rather leave it alone.

Yeah agreed.

>
> >
> > At any rate, I'm not sure it's _hugely_ beneficial in this form as pagemap
> > is binary in any case so you're not having to deal with overhead of parsing
> > a text file at least!
>
> My thinking was, that if you have a large VMA, with ordinary pagemap you
> have to copy 8byte per entry (and have room for that somewhere in user
> space). In theory, with the scanning feature, you can leave that ...
> scanning to the kernel and don't have to do any copying/allocate space for
> it in user space etc.

That makes perfect sense!

I think this one will go a little lower on priorities + I'll come back to it but
I"ll put it on the one reliable todo list I have, the whiteboard in my home
office :) everything on that list at least eventually gets looked at, majority
get done.

>
> --
> Cheers,
>
> David / dhildenb
>

Great minds think alike though ;) as soon as I saw this I did think about
extending it, but seems I mistakenly dismissed for uffd reasons.

Cheers, Lorenzo

