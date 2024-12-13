Return-Path: <linux-fsdevel+bounces-37317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719C9F0F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB74A28349C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0E1E1C0F;
	Fri, 13 Dec 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQEKIsvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wCmddWSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D581DF975
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100874; cv=fail; b=rg5DEAjvu8N/ljG1XL/D+GZDp0UNKXD6Ersts0CixVym0v5HsiONnn18+9WfxCsvJC7WfLjuWuIjwWezymU5hRM+/ZDysX5jPVRYKGexeMbc9Dq+Ypae/JiZWNsEAq3zqGf7L/NhSV29bJAJ8UO51PzHqiPP7bL/NP2If9300Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100874; c=relaxed/simple;
	bh=x0mWW/4GQMFfDNxZNwYxQKazhM3ImVTC71789sSjjHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvYEo0Is1SPZjoD4QqVj7J6OBbYMi6GVJyxgjc8qxuBh+I7aeIio71SWaPdqeVmoaN3n8Oxt996NrICpG0wsiIp0EOdFrdnjetENCVxtRGg8rbYOlln/iOB4RWbX22xxCXIpT6UeP9ywJPziPXuGRHMeEefyLi8GMKzlgQ+ylx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQEKIsvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wCmddWSG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDkJwe004570;
	Fri, 13 Dec 2024 14:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zjDyprh+Ac0DjSKym+
	1DAz2fCxZtqJ9KaV/7FhtsSZY=; b=gQEKIsvr/QUs7OXtAvTjhO4n6SwGOX9E8c
	V59ZQ5AkpIX/hwSpbylqUpvKbWz16sF6gS0eevMfgmkfAt1opmCkF+TBDMxsN3SS
	F/md3twVrPpDQ1MSnktWOQb2+RAw2g1/Hwiu8tVUksNqdULORXzibnoSbiFJRsB3
	kRJsWhpyvAwo8IzDguKNEd+HckoWJ5TfMQTAvHnn4T60x6k5wZU5JgZkoPjqJEvK
	JlmgPabUliOSLaD9EDYIhBvQJOM4a8TnPy66f1VURtJS6czsNMrvkAuJqB2hPgw3
	tNe6tVc3+cOPHEMz/A4txlGjF5DmVqqnmNcHWFiXkYAkfWp9gYhw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt5f24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:40:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDOrWw037967;
	Fri, 13 Dec 2024 14:40:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctk5pdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:40:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbCGZzdwe3TzST9hUF5i1mHzrnUpWops4lk1oS8ZBntkc7PkQEyhfJ9P9qb4Jyw+yW6ekXfFFjnqWGFyvwfUCgnFS59hNtDQFwlh9m/z5ef0dD1SZLdiA3OdtTsZquIX0ELmxKOUyfVev9jppwGxoUpeltOwyJHmTI1te0GYu4nPbZUVN6IJEhDr4s3Td4mbeZhmEVnUwDcd0rQvGwiSzjljYKmnGiVePkIwt7S5flW+4ejoV0wER/W1wYW/NkLXHKO9fqKGkVYpXqrvJkrXkXKA+svvD5r1vK2q6n+DpSTuW1I6E3ePCiMpNXsV0DplK56hHnSF4yZVoSwIP13FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjDyprh+Ac0DjSKym+1DAz2fCxZtqJ9KaV/7FhtsSZY=;
 b=cGf8zYBiLvvZC37JQ67dK8Zfyvo4P477QPLqWz6CltcAGTDAdfW6g2BlHsOg2/ILaS990NZWQXDM28vDJNe4SqsMmn3hXoYuzL4HCovd/PK/XE6pWsqQWQk5SwIk9Ig/D0WYLP7O6DaJ4y7L4czgndYZ7BWQ4UVNa+8rqOoJx+BgEnao23gihCSX87rjvnfbvcrX+BXJHE2p5tpCgKEG5biYlmmh5neIBT6x4ZYB2Rzgt+w34GmkzLdH6RrtgaosrnVlpsdM4MTPnILpdBADja3xoxivbl497kfLk83MG+lEOoM1FO7CGtXKYU74zPHGGoVYDwgAK4WXGpUVVXPwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjDyprh+Ac0DjSKym+1DAz2fCxZtqJ9KaV/7FhtsSZY=;
 b=wCmddWSGmvjMzNeQSTHxttH5vkBWOin40k20IFekT3SVKtwZROXuxeeIIe99gGqi9SKqqJ6zVTNOBEubx9IxIiR1/T5EQ/ENn6LKqUKOC74m2c9vg7njV3yu5e50uufVa6w9MDlMNafgYuSIFRk+RKzWCBEFTppdo3NfDITYJQY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 14:40:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:40:52 +0000
Date: Fri, 13 Dec 2024 09:40:49 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0447.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: ea51d1c2-4210-46ca-044f-08dd1b8424ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RXsBNvYCEdFWYUobehiFKSSVi4gMYhe9wcb8YNiLaziqKTxYnj6Z7Vhm5I+Y?=
 =?us-ascii?Q?obu4/wMkU67pWdFiUQ94yqTWaCMwA+5fifrzmbrhaM1O3pnOtpePSztv6TZ8?=
 =?us-ascii?Q?nbCqkGJKY6XqIGuJ08arVC7RRK+D01H02uD53dpiQk8TLF28P6LgdCaYpDnq?=
 =?us-ascii?Q?RANiuBj7kO+ebuRkvUW4BplagSL4gq4QW9Ya/WJ4L+JeRHc2ucVuvAba1zln?=
 =?us-ascii?Q?qtb7aEbhs3uxNQQnXGudYdXBGrdAxpvKnOi3M0Cs3256SgeWQmpg5FJ4j/2C?=
 =?us-ascii?Q?hzwXUHnwfuklTc3b+JuBOL/NzQ1145M/75mN6Bs/ZWg/DdC1Bqp1QdzlQnWB?=
 =?us-ascii?Q?WswX6arFirNl9JWU/zVThCOP0be0bxy1ulW017aZegULMo0M33O/1GQreRYR?=
 =?us-ascii?Q?2g/yU65HSZsCjKDrmfKKjI8vIuuIWKRrJg3Fb4O6m/E9YU4Zu+fFJXDMwI3k?=
 =?us-ascii?Q?Uw4NMdt/5dujbX9SD1idcz46DiPYZFTZS743ejwMlzxlsf2NIwqybXvXl+nv?=
 =?us-ascii?Q?rdbCMKy8pAYY8BCbzGHmUjI3vQ6pPQMu22lHyyrr9kW8dYwUhiRSWmFqq9os?=
 =?us-ascii?Q?uZWRQNKxB4C24jE+as5Yr420+clh6B1XGvG/gMiLpJdauVMIOA33gAMZKe6F?=
 =?us-ascii?Q?OgFM+7AQBEJK/ymGv9yuWKSlz9Wbnoms8/qX56Cp754jYB5G2Ep8Kvcp8FWy?=
 =?us-ascii?Q?rNNWthfRINkKvsgetIbZAIDA1eEBotkyJplUL/fYye78aYhJYyhoTCrKhRHN?=
 =?us-ascii?Q?0GV8j3n9bH+HFuhXCuPuH3mTToIcZ2y+0mM2rchsJ/5oB+kTDg4X/QC8B0Ba?=
 =?us-ascii?Q?sYPUplL9srU6ezuxOz6T1QdljOFW3i0ypN4HIgVRL+FF32AInXr8pp2amFqA?=
 =?us-ascii?Q?Q2cEvHBcUA0tLKtjXilgSHX2eA1Ko6ITj3F83fpfYNTUn13MGdWloJqkBBUz?=
 =?us-ascii?Q?u82zvv/llNrKjLQfZEy4aRcBsKKnyNjJIRvc0+/O47vV69YsFHc3iUFitMuM?=
 =?us-ascii?Q?2vuEHsXK8EvwL8eZgZL7DQwLiL+k91NXjRz5+6BHov5uNH5n7Fl0eQXS5LJW?=
 =?us-ascii?Q?viguDN7mXdbw3Ub6cqKjVBEGfsMK+lRd0AcWH1SJOYcZ10d9vDjQY3GlInSk?=
 =?us-ascii?Q?UMZngIwyj3QzTk8hsHG9/q+n5jIF8yHbaPs9gIPnL6U8e4UW4x1eoKUb3HA9?=
 =?us-ascii?Q?QA6dHAgMJ1legGcCLce9NO6FPas+Q+jDs9mo8K64BUZn1dbGqvhOhTwPa/zs?=
 =?us-ascii?Q?I3ru4iZC37/YrYDMMxwqnuAqPMDWZrbFR1BIZKcF4z69cPVMCMZ4lP05EQdu?=
 =?us-ascii?Q?aySMAage+8LcONJxvnMNtZ0Fbt/mjwEV94GJPq8ZdaXijdcDRHg5WtAxSlfq?=
 =?us-ascii?Q?KhZU2zsuI2SrF+2yhJwbY+1Mm/1AeUHYk0ukx/IJTxXvcltEaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7KR7gQumMuDCXkay2AzgI7LgSpNpo8XYrOAC2+hXAMmcjnB7nuPQClPO6PN?=
 =?us-ascii?Q?2dMGpW9Ks3tv3v/Bpo0bzk5hTzP0NfV/TwFfZAQaaSPaSoH1iety7UpUj5zJ?=
 =?us-ascii?Q?dwOtsm5RS9UVJlKdth9Wa69KXBD0xW88ouJiHw/zU5K10Ujcb+ybn+8RP0+g?=
 =?us-ascii?Q?PMOYkGKV7MrAESwO9FkYfbbvAET2uCTqa2NhuFl9o4n48OLn/JSKcT1f8iUg?=
 =?us-ascii?Q?Gr4Jp+zNrAHnLf0fEORmJwItq1hoj5zkHVJQ+GNGuCFD2wEICLyOYzu9odNr?=
 =?us-ascii?Q?TQ6En9ndFXr1Qvdgd248jz2Au6A2hYPOoCoBIUI0ZrNYd0C9yZ1kzoFzi+YR?=
 =?us-ascii?Q?rPQKOR9FWpQT6D2AxRi8N9vSueziq/oZk1r3sn/MMMXvC46fDNmhFnK4uu8K?=
 =?us-ascii?Q?HnfXKekYfG9Zy5a8PLr7/i9gHPEpyb46ipjC+vT2/4SCa5pAUE/mjpI++Wqr?=
 =?us-ascii?Q?6ZRFFt3c7Ksiq6+m4dTPt7geFbgJJ0AnjiWwJBED+mPQUzAyFvzRzb7204oP?=
 =?us-ascii?Q?C207sExGpoq3oO8rakVl9Ww9s08iI9rbcZ3/P0+4MCTKNux/S18E2mhOOLma?=
 =?us-ascii?Q?4iqBVyAT5WzjM/4isemqJHWee3KqRFbrlURxkKhEt+d9HLQ0YT/CKfnHZqoX?=
 =?us-ascii?Q?4Tjg032WY40EqQ0w9aXTCdIJJcxosGNlNa699UCPkWQuv5Fw59sfVU89FAg0?=
 =?us-ascii?Q?TrBoGWCxZlmK7O70dsbPo7dRUnRXGQ+qMpsQUGySZHYqHLsZLXTzzWf6yn4l?=
 =?us-ascii?Q?MbDTlkphJPa1aVhHzzypS1s4VK1OA8Pktmn7uui6kdEkF+G3svitKP1iSxn5?=
 =?us-ascii?Q?D52/2Wros8A+Xj+ekiqKzMbqJPzjMKq7xtr8zwQ9IIwI/JHgeSW/JPT9W/CA?=
 =?us-ascii?Q?PNvrHmKl4Jd5ESMkoSIZUj2oeR0DrBRAGXNB82y2DQXnYXf/+iUsZi9ES/cZ?=
 =?us-ascii?Q?rsLQt350d32ykXDhNjWncaEQoS6dsN0V87btjcVIdrLu/D7fo2fo69NBDjxx?=
 =?us-ascii?Q?AkCTAI6fqHEKwDcVdtZufXSaUn5vtVFSJMBFezifblqyzhj34dG0ARF4vHx3?=
 =?us-ascii?Q?oPmLbB+J1JQj82x7KEURN5RU8La0sGu2aSvKzpxTKF3XFnBt54lLfLbisNjB?=
 =?us-ascii?Q?oo9KLcD3LtwCCIuDmxbK0s1sgB950OK7mMJbGPjwhyO23lv2732XlkvUVCbE?=
 =?us-ascii?Q?I9rQs9sZSnryHo8JuaEp6zMoQ+ZZEnu/fQmc3NpAcYUfxFxYkNv9yNzTGUBx?=
 =?us-ascii?Q?pfBNeFYsd2q6pj0TmBzViYzrIO0fQVVamnFTuhgyjgN9ls+p1mtXCh7O3NCC?=
 =?us-ascii?Q?9uha7oiLuIPf9lLnjo4bRRInf3yoEcAVy250ewgFkC5ylkfB4oG+P6SE72V/?=
 =?us-ascii?Q?4sOyKiVsGJ7FFmhCTWq5iWnir9RScjoDS003tshlhUWC9rtpwP1Dv8kmSoQE?=
 =?us-ascii?Q?v70veDwcWCUH22XGTiPpFSV0GKUoBNTltdCpBBGI9SpEQ5w0NDeUBlIpORI0?=
 =?us-ascii?Q?xo+M0oS+8Besl1qxioJTOp/DQ+Apy9xbL8tQM0EXs6c3A0Mw8ClY7xr6hGwe?=
 =?us-ascii?Q?JeAaF0H4kKwxMPCaK4RzeO74LXs7RuuvJW95QMWZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X7X9VOT2OV0dEfagC1bm0VmvZZTwK/bPvHLEXJdY8yk0cyA7zpq5XhMSWIVkSjkscLqyRqGUgS6XMN97sJRqSINehcdaePMIvSWMPjmiLSGy1EA/NWyeqy5UsyWnqm9DK8/3Yycr6O96HIhwcbJyCe7XPFKYsqb4TD5tv9d76NmWsqAZ8hFN4OyLu5jolb2DUD3MgnU0YqzYpLVBnr2+jw2BByd/jCdRNkozYesAMsCSujogpvbR1GL6JeedUaXvYkipJXivw1uE/z3+WCsrmBdQHFyGhtZ9RuACdX2snMZ5SGV/VOvYGJXOdLvEGMHKfCW/eMsg4/xjsCI6+rLSU7QZJidGZrgcKtQDD3+7gHZkPrYqtzb07a7CPvFIWNRcEF4BBsvxVPclY0+8QEGZWDb+SA0n++Q2sxTRvOCe5gv3W6A5jbj+flhjOEzwXC3coOCymWtlgQn7tTG2bcQhWPda1tEJ1Ut3L7jnltW6uMmp59QdjjljzmrPgwG5hQbmei7mDSJdTCeQes9T11Tjvd4+HcINf+RuFXPe1IgCm68PrOZDs1sUdPlYAfVjWDgKMVzUQmg1Ra/dNn6lloM/CkjBUrh3P21t9aDIpGXZWg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51d1c2-4210-46ca-044f-08dd1b8424ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:40:52.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUtetU7XtLi1SA514UEWkvJg2yvhLtggA1Q409azjj2p0uvDvS7KN7vArS0JIstAuaPJT7l943GXd7/t+cZHmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130104
X-Proofpoint-ORIG-GUID: 3RkVrRhIwIes_KFVYkGWtv3fN-OaIrjv
X-Proofpoint-GUID: 3RkVrRhIwIes_KFVYkGWtv3fN-OaIrjv

* Christian Brauner <brauner@kernel.org> [241209 08:47]:
> Hey,
> 
> Ok, I wanted to give this another try as I'd really like to rely on the
> maple tree supporting ULONG_MAX when BITS_PER_LONG is 64 as it makes
> things a lot simpler overall.
> 
> As Willy didn't want additional users relying on an external lock I made
> it so that we don't have to and can just use the mtree lock.
> 
> However, I need an irq safe variant which is why I added support for
> this into the maple tree.
> 
> This is pullable from
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git work.pidfs.maple_tree


I've been meaning to respond to this thread.

I believe the flag is to tell the internal code what lock to use.  If
you look at mas_nomem(), there is a retry loop that will drop the lock
to allocate and retry the operation.  That function needs to support the
flag and use the correct lock/unlock.

The mas_lock()/mas_unlock() needs a mas_lock_irq()/mas_unlock_irq()
variant, which would be used in the correct context.

Does that make sense?

Thanks,
Liam

> 
> Thanks!
> Christian
> 
> ---
> Christian Brauner (2):
>       maple_tree: make MT_FLAGS_LOCK_IRQ do something
>       pidfs: use maple tree
> 
>  fs/pidfs.c                 | 52 +++++++++++++++++++++++++++-------------------
>  include/linux/maple_tree.h | 16 ++++++++++++--
>  kernel/pid.c               | 34 +++++++++++++++---------------
>  3 files changed, 62 insertions(+), 40 deletions(-)
> ---
> base-commit: 963c8e506c6d4769d04fcb64d4bf783e4ef6093e
> change-id: 20241206-work-pidfs-maple_tree-b322ff5399b7
> 

