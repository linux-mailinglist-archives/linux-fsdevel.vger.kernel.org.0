Return-Path: <linux-fsdevel+bounces-32021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7AC99F48D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517FD1C21A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C76227380;
	Tue, 15 Oct 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEo91h5x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pUGOMHTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6611FAF16;
	Tue, 15 Oct 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015002; cv=fail; b=KEX9pG1HbOq0WlzrjbDLAHit0QC5pdK6wrE1/T/uV+EiJa4J3c8KcU66DTMmvvvX3AEOUfiwjXjBrvKtcACcNrkX13Ond/pmsLaoSp0HuxJ0c7Pkx71f9myP3kpchOQ1OtUjU/sdYs1kxha7TOoKnzTMT37AFH6cdBGZHV7k3nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015002; c=relaxed/simple;
	bh=kKQIVSjXtjCuVpsryGWfDBuDn5t1M97zoVQ/aMpr7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YT64LzJb2f0sq+RKtS2YkqhQvAhVyVbeAUdN3uDtXfFi98f9Iq/4K7e1yCPEMP2I5gR+XSVTvbdRZBFhKJct8vj/cD9Ee9A3mEiKgNKoRwOijYFzppBgPwapQi0TCGKAwnBGDXkg+DwsJywOuZeRM5232deo/AOUl7KJhRpU0SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gEo91h5x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pUGOMHTL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtfub008297;
	Tue, 15 Oct 2024 17:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=05Vlkq3Xmq9GA1USXavexmhprJXWFzls7cqapKWzTvM=; b=
	gEo91h5xsF7SKSEaMc2SaLhtbljG4MvGiKRH9NK+g7Qmz4FxFxPkJNupEY+vU+38
	D/oWhCw1pVwGVoCIuZJCq1qymRcYzX6Q8EAof5h9beSCdAoRdQmWgywkd11GlYuu
	Qa/3ZnhW0bhh2M4aYax3Ld0/ytKid+obidVc1q7AsS3bXwNsuuYXk3904b9Dvn4J
	KhKJlBuOpx1099I7wg108Bs5+SfhKHvfa6y2yVBR9i8v3Sm591yaWhYNseRIAGXQ
	tZd7mzf9d6qzSYl6iSUL70yhpJX17vzNIt10SuSR59NS17GTiUiv2Y7Hfi6vAv1G
	aS6U9cHVS3jsLawTNvoB7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt9vjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHQMhr026416;
	Tue, 15 Oct 2024 17:56:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7swmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIdtnCW4T67xzUSM3jU7NO7nNb52ndpWTU8ZJF8M/OrAxDglB44inl7UuTp/laozKS+Z8L3z32y6gScu1C/thvTJWSkC0O7Cu47rVjpz+9wzqR54ZYEw6QbDT4IpIaEyazmaNrhtNtkBWn1gCXxHMXJZuBZpjHYWx/1t2GF5GlkSRanuEMHW8jl7g77+E1rLLq9za+Rf6OR8BzuJUa2c/6Q6W1RrXYAqSGVKxuSBSznYppIZ2+E0MAMpKMkxd+39/fhiDKmIVdyn7jN3sYULLZezd73L3tew+Jann7gwa/aF+Dcakt5yNLhoz0U5cRm8E2ZDGanOzfC1Zx+oDnjdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Vlkq3Xmq9GA1USXavexmhprJXWFzls7cqapKWzTvM=;
 b=lEbH8LYjQ7en4NxxgOAVWQHcktUq81vYmboiQWZ8wVZF6wkEHMB7aweMkLcqY5z6JK7GogG3iOA5lHQ4qFrMD+c23j0a/3D9W8hshpX91qSWnbs09LLNVVfS6Qcybz3ISwxlz1CyBqxp2Kao/DlL4kXDpptSWIfYV6Lfrxomh6pLB3hmrRScfHo0f9e9X+GfD8E/tHMJ7eBnNVM8A5zl22h/N/Oii2LAbjISCQW7YBtXU8nT0q4kLWJkcubJJLDIpxcQjXl8v+05BCOIS7FH6QXpa1iBGAo+HGP2R/gVww3xLmE5ewwBFSU65fqhJd2nZgzNHsleQDtefyZNR9HR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Vlkq3Xmq9GA1USXavexmhprJXWFzls7cqapKWzTvM=;
 b=pUGOMHTLhGi6nhg6XeCPeDGxi4sq9Gt77+E1MjZGS6vdGeHSRvEKmL+WbwPVFOh4Ro3/jMqx/3wsuoeSVauIth93+Ln4sGJIT4Su/8ST0ZavkfI+GEEUdwpFAr9YYdvAGyXdfFlab89mR/c1Oc+kCLDBXWoze5C5ZNoJahGH+E0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 17:56:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:56:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH hotfix 6.12 2/2] fork: only invoke khugepaged, ksm hooks if no error
Date: Tue, 15 Oct 2024 18:56:06 +0100
Message-ID: <e0cb8b840c9d1d5a6e84d4f8eff5f3f2022aa10c.1729014377.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729014377.git.lorenzo.stoakes@oracle.com>
References: <cover.1729014377.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd1990e-93a9-480c-dbac-08dced42adea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74hlVoDjMTkUZvvELCNFxuntYqq8CJJSaXRRmuTazWAqJjlgPt+RKuPKLYZ8?=
 =?us-ascii?Q?JfElPFVF6SGegXubFyuGT2AmGtFKd8Msnz/dX4nJCTOq8i7tHguQp45Lq53M?=
 =?us-ascii?Q?0Xx1Gmsxn7REJQIi0AdjRBW4Xzw8DwGJ4BI+uLB4DjVWTTNBDwygGAxp6zEq?=
 =?us-ascii?Q?smYRCwnsYv0dIsSQVBUCE+MfflofnJNcIJAbFnqNgQST/U4YQPuAWupwCcfB?=
 =?us-ascii?Q?8q12KJA9NGjWfJw6WXCuEZLwO5xGn+tIlSxOimSVCld7jgfTFPTvKDgEpdY9?=
 =?us-ascii?Q?mMxp0k0+E9/lCXd8rIruTPnrkdlfQ4A3Dy6iXp8brNN8hKQ03SwVMXKKuoQw?=
 =?us-ascii?Q?kFybQTeVQKH9UU3uVTk6Sxcgtt783FtC/ik265yMZZ3kfWJnl5wpbh1CZBdu?=
 =?us-ascii?Q?VemnYhd6heYU+UENInkWm05CoQhVLFGN2CNimjIXpLbCyYl2M6fhZK3LtHtu?=
 =?us-ascii?Q?Mc5P7D36QjJthoPiQ7kcv1qTEztxd9HaFYFJbrwtWzzUXT71owGqmhjwkb+b?=
 =?us-ascii?Q?tqdvD+p7owZ5xJeskIWBb4J/Cb2+Wa8g03g10ejzgMoshz+D9EzYBn3VXoGZ?=
 =?us-ascii?Q?tvXNo4Q/3GnML2bsR3PdcRKqq6MuYbvl2FbNYf6sZX7O4HYhaf9tftmVETVx?=
 =?us-ascii?Q?3GDJm/0N0WPeg93IBbWkjleLtD5HGRyt5EoSQn7Htv/VWjKZI/BU+d1ICbOK?=
 =?us-ascii?Q?055a4oEBaRnwXvrpgZAe3PDGkTRHrEYEQbww6ezq4R3L3zwcQOvJ1xDYJLh/?=
 =?us-ascii?Q?V9/M0sX386U18qJS/mGvqw2NiQBwohui3GEj4/szRRGRtGqmwRPHU3RZ5pDA?=
 =?us-ascii?Q?xlq7rjITbjeNCe4cKlvfqJR1Ui7JzPu8yKNFPtLUIibjqT9Kqc/N0LmwzPBd?=
 =?us-ascii?Q?1v08mUdR0frfkAAEe0H2+q5kJ005NMKHJi5fl+gYiqZbdit5Qc9nm8YH2c64?=
 =?us-ascii?Q?XYZgv2C9GQsH6ZmbdqvfPqjC0QTWcMiPrFT5+qEKjuQp9I1pOQJWngyrhEMz?=
 =?us-ascii?Q?t+s6jpBBYi/I6WUozOBxI2bYw0VTbCX6kwcw99t6ZDoi6AhrnPqoo+Aspmsl?=
 =?us-ascii?Q?uDq5nydX+AsKdMxzLAqi2vNJlgZV92zpC7byBURrF3ovV3PIuKaS/dYXTqkR?=
 =?us-ascii?Q?AVjr4O7AgoTk1vbG59Z342XWaFeI6h1zWv7w7A+0+3J/fAKEVceFmKG0bASw?=
 =?us-ascii?Q?Y0KXf42/uPC4TNPm5WXaicK/SnDGzGVCGiK3/Xqu7UQ+Lc1rkOQychd+VlXr?=
 =?us-ascii?Q?XfZDPBN/BMU04n4uuY2L7u7MJ7WAZtQaqoRH3dJktQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubi33RJAMRLysJ1CZM6QrP08VyggS1Q3iAJaVDiUkujDuNjhE63gsspjNsMK?=
 =?us-ascii?Q?ulmt0KTcMCuBCDV3aaMHUvWVyCeA5Q4MVkleDgC0H+AhqqRaRYBeC2Q9qCeQ?=
 =?us-ascii?Q?WBGhfkFLDtOwOIqRQbDMeq8hLe9NUh/vZAd/SM+LzPaZpwa2wdVrcgHijRM/?=
 =?us-ascii?Q?7gP0PNTZqMwDvJeRS8PBkuhdsbH77MeTor8/b7eFuF41aP9OwDMXFoZ3YgMw?=
 =?us-ascii?Q?znIUpyUucCkJlViHHdqE4c657mrxioaGohOR+/wkkEqLH2Gq83mx0UlR7MOy?=
 =?us-ascii?Q?lzhSkvv2Dmk0BwciPQoGZEImiJnwMJs2mRE1eMJyUy7aV0wgfrnSCC3YOJAp?=
 =?us-ascii?Q?wAjk9Ea8NB/YdHWgoGwOjb1NxWXZfgDHt+DwhWyamZxZCoyB2XRnitnXyqBb?=
 =?us-ascii?Q?aanYBpSbwLNQp8atsu6J2LfLKfIgPQkDTWk0qSIYgvk2oDKfblnzRtqPGlav?=
 =?us-ascii?Q?sLSx1ZTiPxzUy8YtHTStvFu0+8x7SoAlm34d9K2WzI4mZYYMUgMqwec6G53q?=
 =?us-ascii?Q?yn9zjZPTIaww1YfmNwtBS4P19KUVxUJIgLKtW77QcTYPNmCP09lJ4JkZKyxl?=
 =?us-ascii?Q?L+lNTkW4Lid1jTUI3iNRGvDXXTczr9XXXb24yhid8QmpOnNztwbzdjr+D7T7?=
 =?us-ascii?Q?+WxGVhXhE5WuY5dj3eKwNWUfQFSNTaDt8pQ80wTqYDgNpt8NGTFBHqbAi0zq?=
 =?us-ascii?Q?rmPW/MTSnVNfqTNaqdRpAKIMk4x6TnQ8xyRP+HTta9g+ogSiqJaYgP6ux9lP?=
 =?us-ascii?Q?HHPDnRQmmY7NS/4oHSw8MKeS+Y8+TZ6/UYfPuwVPV6uZtTLWMBMnLEn82zyf?=
 =?us-ascii?Q?FOCTxbpmmAS3ipBCopgUIxmsm+ythhPPF6hL93/ETQR330UQ3R2FdAZB1TcP?=
 =?us-ascii?Q?aUSnISmLoRvwd1FmU7JWeQvtiDLBwg72jrGc8IDFD8W2zx0hmJJOJLATSgy3?=
 =?us-ascii?Q?p3WeAFXn5adRtgqORt2RldHA2vgTQx2NWM2zXBNhFAowvThc+Md28dIcyDfi?=
 =?us-ascii?Q?xdxCZ8Y7vc5FpT81ehMz5ZdcU2zxC+NYgOIo5JtvXFGFj4Id4zozOtWZgFe1?=
 =?us-ascii?Q?BvArqzPrCLuLC16I4yz16yWqwWdan1w7M6bh1eBpTjMU3ZRQ7X/KSojxy+MD?=
 =?us-ascii?Q?TVhndLh4pQk9PGAErZ2qAd8wuOCh8EexCvs0tQ8dPD/KLH/SISkz2q0uR/o6?=
 =?us-ascii?Q?TMn2Rkv1h3fEyFphn0728/GlgEHEM386Lh+U8PAkZND1+huL3SMRFUJoEzxM?=
 =?us-ascii?Q?N4j3eSM6RWFLtvcvDkZTiZqg41yfd2UuyGsL7nknGUfcf4rnVYYWR+6wbsf3?=
 =?us-ascii?Q?8RCczBcztfX/zJfFPWNZpB2ta7tfFVNUgHA2b0u5eJmNjYd5Sd3dBRk1Peyk?=
 =?us-ascii?Q?5Hy+Pyy3JJPYPMBUps94/OzDxJ9stIdTrwUJsBTxEVGV70YcBinoKzfmZcR2?=
 =?us-ascii?Q?EZ7YfR8erEF10UHm9JIevWA43vE0Tr4zxwUduijeL/kVkK2ULs+8X5BUwc8n?=
 =?us-ascii?Q?ueoMi7mfM46XCJTUEAexM4/aaVzy+JgwztEZ3ExsQ1fdHIDoVGcdU2YcvE4g?=
 =?us-ascii?Q?fe0iGEeeYAyXQm3Ho/B2bw3w8Wn4rOCWhQulnAdCutUJz/SINqGr8DLcqd9z?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IL9ZwwZ6hrUyt0AEHQ2EaADYzeH9IdjWg+HuvKoFryZcU0WytaVOWZBlJzL+U5ZE7zLWWf3qcvxGT4mt7GTuF0Q+Sh0HWtAU1E4dKmjDxMuWlyNmlAubkC6RIhCm7le6jot1YJO+IaEIANuZDq+o3DYCjlVR0jaMRshhM9fyjN1Z83uGkgOLnz5SKAcMKe7j4hRFymufweEBBc3ib4psno00faSmzrKtOa3Hm/TOco+wmZ0EvsiuzvxGwxEjHwXAGrPSzM19HoBnoX9jioOVW1oMjHgMWa/ZmnxaiP1wmYO+c9Pm07TtBLtJY2l914Kxt84f2AutUwoXKidTzDLpfcYolPDDQ1tzOXUiAw6C0VvplTj7gL+q5POS8IuFfDeEWWW2QWbzEs4NfpXXoHKwv3iRFRstjPdkbpsTcirWuO98mkzy0XQLvPqSZFdoOfv8y1oUmHiIbiBUuQlQ3F/0DEpxpKzrMZijt6EaaWdOPAvxJBPoiH+n5vdV/5UPICKmOqtLYNqUP7l09MUuoSaJ00Ig5FalP1iKVqVMRQylcXMmMUqt2JXrjVVUXkPaunAHXQOMbVbOpEz8ER+/ihTL/bMJHqCnkGuI5DUKGCVPI7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd1990e-93a9-480c-dbac-08dced42adea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:56:22.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0TUINwOuHF0I0hViDqI0p4NRynnwAKeGm5XlzQe3PWpU0j1w5IGT4X3NbyNfqbM5mFApQ7nG+npNDgeQxf9jtjL2ohX3urBRPuyNTjlSpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_13,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150122
X-Proofpoint-ORIG-GUID: vthpnDlnal1iTCXoT8Mmzt3v0eUEehph
X-Proofpoint-GUID: vthpnDlnal1iTCXoT8Mmzt3v0eUEehph

There is no reason to invoke these hooks early against an mm that is in an
incomplete state.

The change in commit d24062914837 ("fork: use __mt_dup() to duplicate maple
tree in dup_mmap()") makes this more pertinent as we may be in a state
where entries in the maple tree are not yet consistent.

Their placement early in dup_mmap() only appears to have been meaningful
for early error checking, and since functionally it'd require a very small
allocation to fail (in practice 'too small to fail') that'd only occur in
the most dire circumstances, meaning the fork would fail or be OOM'd in any
case.

Since both khugepaged and KSM tracking are there to provide optimisations
to memory performance rather than critical functionality, it doesn't really
matter all that much if, under such dire memory pressure, we fail to
register an mm with these.

As a result, we follow the example of commit d2081b2bf819 ("mm: khugepaged:
make khugepaged_enter() void function") and make ksm_fork() a void function
also.

We only expose the mm to these functions once we are done with them and
only if no error occurred in the fork operation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Cc: stable@vger.kernel.org
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/ksm.h | 10 ++++------
 kernel/fork.c       |  7 ++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 11690dacd986..ec9c05044d4f 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -54,12 +54,11 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 	return atomic_long_read(&mm->ksm_zero_pages);
 }

-static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
+	/* Adding mm to ksm is best effort on fork. */
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
-
-	return 0;
+		__ksm_enter(mm);
 }

 static inline int ksm_execve(struct mm_struct *mm)
@@ -107,9 +106,8 @@ static inline int ksm_disable(struct mm_struct *mm)
 	return 0;
 }

-static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return 0;
 }

 static inline int ksm_execve(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index 597b477dd491..3bf38d260cb3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -653,11 +653,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;

-	retval = ksm_fork(mm, oldmm);
-	if (retval)
-		goto out;
-	khugepaged_fork(mm, oldmm);
-
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
@@ -760,6 +755,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	vma_iter_free(&vmi);
 	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+		ksm_fork(mm, oldmm);
+		khugepaged_fork(mm, oldmm);
 	} else if (mpnt) {
 		/*
 		 * The entire maple tree has already been duplicated. If the
--
2.46.2

