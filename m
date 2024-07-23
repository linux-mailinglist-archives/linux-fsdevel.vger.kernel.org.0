Return-Path: <linux-fsdevel+bounces-24118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A21939DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3065B1C21DF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73814BFB0;
	Tue, 23 Jul 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owpRJwUp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y24zYT3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD882C9D;
	Tue, 23 Jul 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727371; cv=fail; b=ocTeL/lGOBO+TW+rVcOOaAHUkfh4KwYYAzvEmlZnYe4fVTDUXYH+9Qv3jHq/Nonzu2MN1FIEFLax/EC+HVXlIJxmW5jpLDaqw0ZDJwC7FNQs0GTSjjRp2yZd+wmrthWAqyo/WWqSh35HGTUZmQXZ7HEqMkA0R14mwyQbtVuI/MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727371; c=relaxed/simple;
	bh=eOwgWX0dFmle3OPVM483dOSZnC2haEIvyMDVxJSA0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbLNTsL/PP5q8qr9IglTKmHSQRqGwHz4NwkMpLs3Sqz/Xza8gTsxn149mk4pdGNI4d3XGYLV5KA2OU2svMVxuhOM5OnTe2Mi7ipq8gZqrRVBZwOAre+YFZXh7TnZ9zc5qwp283jSgjHQwlKWi+3v8g2w75LwN/cysEqMT934Y7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owpRJwUp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y24zYT3/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BVlp031487;
	Tue, 23 Jul 2024 09:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FnxulDxctWHHQ0Z
	AoueeP5Jax2kRn5UxL7Nu33bREdc=; b=owpRJwUpZ5e9bhfwQv1kpElujpAj+Lj
	9OB3+TkXRftjVbQsb17GwJmI59bsYbVrJFh3ZBtAukg9JzcD1Cj0eJwR4NmICP4C
	Avtan7Ty107Bib8L5ar63T+0zdP8nLvei91M+Umd9JnztA7niSyW+tfRHY6PHrN5
	BIE/OGoXimJev0PawO+WPIrRixvuSVY2+YkWfdjYaNQ7/KzkEvnDoz3gr+xTAi50
	JJiSFVwwHd8NOnA3wnwR3shhlmhaqUt4s9aXCk0iRlVAD4eLeTvC2crLQPkyRdty
	2HDdb/cm1h3IeuWloLdjTUZX5yZDvv1jwpSlZph9cSLsrtIMpCCO3oA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcre0qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:35:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9Fkl5033667;
	Tue, 23 Jul 2024 09:35:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h2695ev6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTsKNSKTx0cndfTaXDbMub2P5IJdcRiewjnbfOjaPY1inPYZM9wNMyVl2MHvylwcmFsUm2YnSEKXyU3Sk/0uZY95Ua+bwWu5RBulRrrjX25mPOx9uP0Y0oox2hV4zR+V8MgAcUb0py8Lq9pbH0uGdCUsLN9llKHxEb+sdsNjMQJ7yELhs7YmRGH4Q68gEOmTT+2tWQvsiTgLnoOEpPgzT4lW44VURe5qAaXXlOvQodrKaEksNuVeuf2gPJRME3Fr/pd0A3xcX6/P2eTOzJmHjtMRs5Y/8mWmCE8MSvms6CsqWVVtVBUpDTZlktXUlu/cT3VUHKyS07sFpI0x6ieKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnxulDxctWHHQ0ZAoueeP5Jax2kRn5UxL7Nu33bREdc=;
 b=UJNeyINQtNJPpI+Oi34zk+6R1TiRrmZ0U59cMxzVe5hF2IRxcJ8OKUsZJBFrtuq8DnH5+CgoG3xOSAuEINuoCA+qbpn5KL97R08bwV0KqLeQTFC/h7V/9Z203UcR7Cj6JQK1TCZBEa0JOhr9gg3G8XbkZAPkTc0at+C73GRN8w71dD8kbK5zV/djoARcTw7bdFCADkL6H7kCoHUSDwDjOpENbeeZI+Jt4+HM+8/NeGM+mfkMJP1G6iGJ9CDk6orTEt07ovwuSEaX0GAiiA2jRdhacsDxy7dhItvfyzVPTpk8Og3H7mjECLV6NIYuYCJtFxOZV8sRYQ2g543ZmwCq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnxulDxctWHHQ0ZAoueeP5Jax2kRn5UxL7Nu33bREdc=;
 b=y24zYT3/FpJiSFZOdkX6XJNcu0Cu/mk3lRJ7szKtjoXhgkMs27ifxf+E4DZFgQmHnfLuOS4fYIUtuisr96ITVfmF6mcFpIeJ9FfBwOjSyN1x4awmyOoBWyBS8c2AUj7N0gqumbIIy9NjnfjkpZJWtfPc7C1sfL4uTjkChaWpw0I=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6207.namprd10.prod.outlook.com (2603:10b6:8:8c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Tue, 23 Jul 2024 09:35:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 09:35:48 +0000
Date: Tue, 23 Jul 2024 10:35:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 6/7] tools: separate out shared radix-tree components
Message-ID: <eabb23cf-d142-47d1-b312-b9c7b76015ef@lucifer.local>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
 <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
 <Zp93H8-sNyWPoO_d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp93H8-sNyWPoO_d@kernel.org>
X-ClientProxiedBy: LO2P123CA0034.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::22)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 882b83f4-b675-4a3d-445b-08dcaafad5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KINN82QHAEXvlyfwI4WLBPdNvnQtRQy05LgY5vEcrZIArdKTfxO4zoPSa+Pd?=
 =?us-ascii?Q?DaaMt3YFmYu9wWlv1wGKayqiluinabhUUsI7Et05zsEpNTEctoI6XtmX7I84?=
 =?us-ascii?Q?DmS5yVWXPJFISBoGgGnqmRBUFN9Ns94Whduk5h3jTa+7I4ClAym3E8+WLHNa?=
 =?us-ascii?Q?jprvD+MwZKU2/te9A3qfQo1DTCImsuXwT/B7r8/RJnz2mhn11hObagsSSjjo?=
 =?us-ascii?Q?+byxp4NyXXEiny/i3RSekGvr5BtnRuT5YziE1hDOGhCUkSYfv7b+zHA2oMtQ?=
 =?us-ascii?Q?kcuAfWxf6V2sgRYIYywmwS/KkOgA3jzyGZNtKER38doUNnJuDsoM5oMhY3dS?=
 =?us-ascii?Q?mny7MD9RnM/sj6E25o7W011ybNc/hBxolnnakxUDTd65AJxXC4yRH6UNx0BV?=
 =?us-ascii?Q?uBoklRNkjQVDt8GfhgzQ4zBBtfJWm58rG9n147E9G/n6+2wqhK90B/u2jPtN?=
 =?us-ascii?Q?YJcH7R7d6mDpyBliQoGvTAo5D+/oGYLFb0vo+W0mrTsVl2t4yxQ9upVMpcJt?=
 =?us-ascii?Q?380TsbU0+v6Cx0z5lBShfMG9KQueZAejGRCsyNCCWk/pYerJ4hmUvfQvr92L?=
 =?us-ascii?Q?gn0tfiFfW72ZMeJYwJHVSaTyprerePBEPPQP4wwYL60YVRT4boeIG3BEygw8?=
 =?us-ascii?Q?4uNblHIwJ4uCQ0I61bljVwZewVqCSCgDqlwcfubtjvJ0XZyc6Vpjo/o+ajQt?=
 =?us-ascii?Q?XeAhH4p4KzVJHrUdpYLwUnwcIMoLjPP7GpW6Z0E7dFgvwnC0xza1ea/RNJNo?=
 =?us-ascii?Q?2NnjJoUZMRpdA0KoEsN08ej9E2YfKxNkxQcPxjc3mI/QbXOOHJistp7f7dqC?=
 =?us-ascii?Q?N81paXBSemoyWvjDJjW18aneXu4yTjEz8zkFoL+j2EJ1yUcugI/BuchIsC3Y?=
 =?us-ascii?Q?IUwgbT87nioQ5zWdL7gSTmUVXXEFEY5nJa1XeqrnOiEByXcyOdIHeYFSGBz2?=
 =?us-ascii?Q?tgg968KXT9LbiCx1Rzd4IxfPMauRxeNTBWaArA65WRThBPlWLcHY3FHhFYSX?=
 =?us-ascii?Q?s0KBfk26za5XhH4iVbiSvf7qxaee24n7TO3WpGrsFIhWe6ca9w9BOTHXnEle?=
 =?us-ascii?Q?Hc2JV+bNk6D09jl3z8SB9WXnThhyGQOmNvoAb4tBJxG043BCMP1/1t+gVFZp?=
 =?us-ascii?Q?G3DBXe3hfKK09J28xC4shwXz9ao3wRRKzjIJLRD6chb6AP/KY5r1R04+69dD?=
 =?us-ascii?Q?R/grZTJ2hp5jGIe1i85tjVoZr8ZED7LpAOs1R9kk7M2t9UpCwvxKxr686t4S?=
 =?us-ascii?Q?Tx2GdtRSMCrDQssc7DrhBkFrawo7ngTGgwraFC8zX9k/eJKvoiGC707tnMlF?=
 =?us-ascii?Q?QyAyDBrItSmuJ7BPfCvVOKzF7RU60n/8IBKkzdfJPoK/Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3IDm6v0WKmDkzk+M4MdJFyAqYWW7AlgLLCfRp8NzmN4dbA+g/CoDj097A+b?=
 =?us-ascii?Q?ET3a8QdOK1FwVdSKn9Vpn1wPM3DoSnNJhbTrdrHK8j2CBAKhyYOu8tXSSrcX?=
 =?us-ascii?Q?wFJWqh2zl6LfOdOmqaFaWvZHkp5t0su+JV8JD6lM37IbqxU/dy1XCG98uaUc?=
 =?us-ascii?Q?hVtnZ49PKMbuF97TnKnOhiOSm5QqGURdL4HNaE194hUzIQH3Ar8rPc6bs1eU?=
 =?us-ascii?Q?HYiYiTJ+YQNLXw1vwf61bkyzE1O/FKC0eMYWrIlpaRAR70MZc+fMz6VBUO7S?=
 =?us-ascii?Q?gAKEQz0kInOX7eV7W4Ms4sAFMUGOvbJPivTqv6gq7fEAZY+ZGA8I1aoHlocj?=
 =?us-ascii?Q?2A+JHaBmso5DNx+ggJiQ5KlwaZgEG4Sg0C+tzjXpzCQcd83mtvVXSxRJCb0j?=
 =?us-ascii?Q?g66JQ3v/LjPacbJrbXr0hW1XLV0gMn7lBIKmTUoy7MC947Bx5x3x4pu/rYI3?=
 =?us-ascii?Q?S8a/X+myEis3buSq7cFAkIfS1L6sVZdkt6PJiDRuyvcRVXFwfzVsE4f6t9gw?=
 =?us-ascii?Q?Re3ov6Z4+sRgyCVY1ASLaLJTtX7j9xls3EfDfcBNwW/bt0mGH49Fi1O+0nIY?=
 =?us-ascii?Q?st8KpvZtMgjBuemUsx99Oe1AhnKNzia19+90GAvhPN/kWKKEGE0jQ9Yr1jsn?=
 =?us-ascii?Q?AiIaxtIQTkd4/xnF47dUGonW+/5/uIBczxBf9fZKdXrz3ZVD3PELnhjtwbxG?=
 =?us-ascii?Q?BS/Dla1lopGm37Zv+Y70qeCzz46cxvJ5oVOk2vWYgdsVHmuPXzhm8SKlojft?=
 =?us-ascii?Q?iZnliPtVF9xa/vfXpgG6Tt0kwQNvcj46xdo7CdNHySkVWbNUOl2uaekfJtwg?=
 =?us-ascii?Q?2btoFC/rrLEMTFdAVlMaCho0Ur7QWeWVbkcB3+5TkYhkkwnLAtmZQB8McB8B?=
 =?us-ascii?Q?Scpz4SvkWIWfzv6+lzXl0rkxVNKD+RlgqWoWjV3bXvnEou65hEC7Z+Dlh7O0?=
 =?us-ascii?Q?j9eK9XXYJsUEIG/wsOKDIQWqVED59LPcquS8vFth/tNUw8+txAiX4PK+g88Y?=
 =?us-ascii?Q?KPvtAbbdKGxPG47bFj9XOOBv2p8eIlGu3LxAgddV4B+68QmXh+WRXK51W781?=
 =?us-ascii?Q?d+gTG3U+oeVrEw4/lNVwBatFXz4C7dl0flKMJCD9n/xbM6k5wjWUj3L7uML9?=
 =?us-ascii?Q?ufSI4z5DHKV6KiZh0hv7HZI0KVv34lkHng1/GsAomWjRj5ruCpk5+rUzalfA?=
 =?us-ascii?Q?99bkGayhLiyQPDV1Z6ajS+qbDbE4wSF5V2YBTgZrw1zdD4IIVgXUIuku9HHE?=
 =?us-ascii?Q?xGZck3J8sITUG9IrKYx5yt1ktWqjRa9awnNMCXEOptIBouR7ow0T5qjM+AS/?=
 =?us-ascii?Q?lK5H+v0X6xtz6Obrcbw5jgzR7mLgBjiNvCw4G+BULesWS7SEoDEVp7z59jOS?=
 =?us-ascii?Q?PmZH/2UD213uKucdW7ZUPhrFDyG4zvV2cAptOE+t9LLmF0X/2Gh5hgAHX/4m?=
 =?us-ascii?Q?VJyyNQp0obl/9NHkNQqC9NoTiq8ihMx03NppmZ20WH5h7v/E3PJKVzwX6wy5?=
 =?us-ascii?Q?NUWq+HaTZyRFWY/NO9nFcSy+c7//5rPg3Rg2WqKCzjIaibWNkOVFjLQMI41D?=
 =?us-ascii?Q?bKuYd2zU8CiReJ5diScwDI8fEboMSuIEzDmRM11GM+i7LAY8R5IpibtRjeVd?=
 =?us-ascii?Q?/IzC798GpnXk1GeFb/Pch5lzVcFhyAHsWD2g2rPxXYt4Z784i/thka0o041l?=
 =?us-ascii?Q?7oxGbw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gd1Vtjca+ukDK/Zp3KywgTC9+w4MqvP/yjnzGGHnUWDSA7fmwaXFuPWWypXDv9n69peQT5D8yIldJuWivzBbomSuGughRH8pOH8iffpusqcVKd3b6XkxgyskRdCA3wPbJYf5D8F66T8l3etX6gfWdO4ZZJBd2rF8pzRny+tEsQaZpRNeASZGaq/8IhOKe8j+hdUW6VnfJX6dS92Z5Rp00wooOUozFKK3nuU8eNNce1fgPQp9GnESf5UfDNVdW3xSkT5b/aI8W/+dKoB4joeUG/uSIqcgV9D1TFtGJm7260HqkKMpR6bNYzMOaOqL7bMeC7IOcnFYpuUsql6GvMYvPaNPIzfm/uX3cGGFPvTtErHsGDBETJqQYPf0Mn5eoV91UiImPTPjfyDmkaRb2hX+wVzv42Pz7LxUg07AMqJCeA2IbP9ZwOT84+J9fof27G6F2hpVtQS72b2e3q2f1cxge5Uj90h7zr404C4sLfuYpTeSpw6bTd54QpBumsTdMtnH/qYkDKbMV35Kr+iQglxKLN+gZfm1Lv6uzKdD+2zO/wIfRLKH2Lx+BeO71JgcRJdBsXRH95vQw1KbIBdQqBhvIj5JuIoud+04xQsdIrn5Pjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882b83f4-b675-4a3d-445b-08dcaafad5c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:35:48.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGQFQU6gOIZ/5mqoydTvwVvwUTMw47iDeHk1+p4E/7LeI5EbDpeCQzWf2KTemHY7ZYxMSv2k4lbvVDgoE8PTvrvuuxvd48e+DG8f/OzBO9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230071
X-Proofpoint-GUID: TQyUlSADdYl2R6cTdN22euu4z48B_Dyq
X-Proofpoint-ORIG-GUID: TQyUlSADdYl2R6cTdN22euu4z48B_Dyq

On Tue, Jul 23, 2024 at 12:25:51PM GMT, Mike Rapoport wrote:
> On Mon, Jul 22, 2024 at 12:50:24PM +0100, Lorenzo Stoakes wrote:
> > The core components contained within the radix-tree tests which provide
> > shims for kernel headers and access to the maple tree are useful for
> > testing other things, so separate them out and make the radix tree tests
> > dependent on the shared components.
> >
> > This lays the groundwork for us to add VMA tests of the newly introduced
> > vma.c file.
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  tools/testing/radix-tree/Makefile             | 68 +++----------------
> >  tools/testing/radix-tree/maple.c              | 15 +---
> >  tools/testing/radix-tree/xarray.c             | 10 +--
> >  tools/testing/shared/autoconf.h               |  2 +
> >  tools/testing/{radix-tree => shared}/bitmap.c |  0
> >  tools/testing/{radix-tree => shared}/linux.c  |  0
>
> maybe tools/testing/lib
>
> >  .../{radix-tree => shared}/linux/bug.h        |  0
>
> and tools/testing/include?
>

Right, I was also wondering how best to integrate tools/include (and by
that token, tools/lib) but there are some fiddly include path precedence
tricks used by the various Makefile's that might have made this break
things.

Additionally I think it'd cause some confusion to have tools/include and
tools/testing/include when tools/include is used by a bunch of testing...

So I propose we take a look at seeing if we can't just integrate
tools/include and tools/lib in a follow-up series? (maybe these should
actually be in tools/testing/... too, not sure if there are other tools
that use them as-is).

This one is making a one-shot super conflict-y bunch of changes to mm/ code
I think it's best to get it in asap, it'll be far easier to make changes to
tools/ stuff in isolation later.

>
> --
> Sincerely yours,
> Mike.

