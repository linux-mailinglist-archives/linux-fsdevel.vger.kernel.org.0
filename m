Return-Path: <linux-fsdevel+bounces-32356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C69A42C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA61F22545
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1A720263D;
	Fri, 18 Oct 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlgKX6FO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dOPGwpqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A731FF60E;
	Fri, 18 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266225; cv=fail; b=TFR3O4xMcjQX0eRoagnur6I2QBKjCimKKxBibgSHZkJmyM34dKdoeJADoA634ucVv3eWu/w00qS2rOYDyg6SGTy4+JgaxQLr0BJye/XPmCyFRnCl2gHMhL/Bqjvc3qiv4066rzgiirp/Zl4oAT8vgTGZsYsGS4ZVvjsKxYGkLs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266225; c=relaxed/simple;
	bh=/ZmGG2ji8nmu7vsX1xwNxOyfqeQpKXUTqNNg8fBZWHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BGy69qQWoM/NdIV/VJpnuAJcSaStpz9BdG/82JI1ejpj+alY1f5/ssnxsYPdxlnsDclL1sAPkiLD5YqmPx7khCBfPMRzX0zrGXHRuEA9wip6QnFbzxRVnT3oCJRCIC0CHv8X1WFLbjcmlu8lNxPkkcRINXcK/2YZoyquMlHrFFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AlgKX6FO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dOPGwpqr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBgiF019364;
	Fri, 18 Oct 2024 15:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fiQiWYPqYDW6eFU39d
	rRWkrlGQ9fToajHbUUGfZJkWU=; b=AlgKX6FOSZkDYEFjph6QEwUgpAjQPplOCM
	6oW8GMDdLkgM2toh0rpttWYPanA7uslEkZlMa+NB+RcakBJZXdQFEBh7W31m1A/q
	h5QLL+uj+dyh5OUZ/b5GrLCMiMODvOWBW2ruylyR+36NRH+FTqMivQksZYJOGuGx
	gHQWZyrk5rsXs7+rN9t8P8B2SteLoPCB3DYJ7cX077GyILeSjMQZkoP2pGpyKHaI
	z5OW8R2szEGxcRMEfaSnxyoU4iRRvRmj6QwHZ5Pq+FwhOAXBlM33/061pmPpNKMu
	4FL8Idl/IlYphTw7662UBaADLyhBh/dOguIoEiumHaFGeiKDrWBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcrr5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:42:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEd2jr010433;
	Fri, 18 Oct 2024 15:42:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj3v5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8EjZf0A5R7o8vfMpLSevzmSTLNkrLdT8r2cqjU0pJm+1D4fKZzMaJdGAs9yvzjEaDXY+PkWczX9P4/aearrlbQ6cWCU5PIiSNSJhnfqIz6EQJTaEgtrI/4rj3c+CfCxJQ77cqZKClTxKYVNL8EN83qKtGM2ROk78+LAp1AN3V/+zPpHwOGt8VR+IvJERGLvuaJvWrcYnl3Z1v2DefxtfRr7GsetrdwRQ9c31jsbJrxb1fiMBpqYEKQccYwUM7Xqq1yFG5URNFTnYY0jsP2y7fvr7mDBfPbcMmIsFW0HyKbBGSPvNCiF7CixtKhsx205FpLDsOZ7l+vn3eok8lh6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiQiWYPqYDW6eFU39drRWkrlGQ9fToajHbUUGfZJkWU=;
 b=Vvzq048kQpmAZIxJOc0FBH4onV2ZhSUWebqeTfiBFjPKSKbxGu/LHDIOmsjtGlh/IJ/ZXsem8+tiw3LyCNvoiLlpf+/8xJ/S6eJ1ROYQ49pfOXP2xpXjiS3Scr3uyq0Vxy0Ko8m3V7Mg6PHPPJ1tD7lB/32/wnHKpj5Na01Bz3ziZQhfFLSLbh7JEMK8Z76PZUnWzSfdY2KAkAxpxi9m4W5HKcETI3p+8fBB2lmQ/UziHYYCq1Sr5ljiJ6YIHKCwvWVfioBC030+uJBww8tH8j0nVSaSuWIHAD7Gc//EVhkyYfwtg79xbvWSsWWMt9b7cdqHvZj70nr0FvE9/3pX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiQiWYPqYDW6eFU39drRWkrlGQ9fToajHbUUGfZJkWU=;
 b=dOPGwpqr0m//c5Wn+cg6GVMq4sz7LtFgVXj5oHI3cxp46GLSLvX7Uocp/3Nv01ms9U1d/0y+gxclMiJV24iqRWZO9k9VqYyZn606pCmxeLNedF+I2ml1H63Q1026WVagVdOMn+SyrElxFRnOWQNw3EQBGyw+ZgAx+RmtqvW+lCk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5640.namprd10.prod.outlook.com (2603:10b6:806:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 15:42:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:42:07 +0000
Date: Fri, 18 Oct 2024 16:42:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ebpqwerty472123@gmail.com, paul@paul-moore.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org,
        syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] mm: Split locks in remap_file_pages()
Message-ID: <fa8cad07-c6d5-42aa-b58b-27ddbf86c1c5@lucifer.local>
References: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fe87f9-5542-4f1b-36cb-08dcef8b6c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkF2Wf1WjOJQ1gq2a+e5AzPJO7ifD+BUYx44P72fYUP25/M07I0Mmqcf0yz4?=
 =?us-ascii?Q?8Srp8BWLjoYeCY7lJ8JRljZur+v04i+VAdcTs1exFVrgHWH6Y6a8T2kXJJQ6?=
 =?us-ascii?Q?1fYOBL3NR9/v0VNFX4neoDqdrNVpXuRm31bzdZt+2K2VfZ2g+rCzgORHwSWt?=
 =?us-ascii?Q?VEGMQp30qiKOD4+0KqjDv4ukkGzb9nzLKKUVAh1eyu3ppsvDndqjwld8NnCO?=
 =?us-ascii?Q?S3XqOLYK791CXUSb0LYQ+gDtkuW9vvbO8kguLySAzHLmdW7q/vZZHdNvAh7l?=
 =?us-ascii?Q?R0Kv8B7a8vaCp/51F2BU5XjPyS8OsqfJCpvAiOUZq1GK0ph8p96s9BSEAVhW?=
 =?us-ascii?Q?QyUwBDX+1AVAIdi22AN+W+L3tJsbwHjEn/FzQXLenisR5d32WSWc3j7aKzN1?=
 =?us-ascii?Q?V/BMIYa5uOLInoMYWszxK5B+1srh98Am1jdIQ1f6i9OY/XV0hn32g8ct6KCz?=
 =?us-ascii?Q?BgK7qt/+FCm7WX76bLClYkdvR2PVKgAnBAQPB+LCfuMlkhAVzbXdtmXQXJZW?=
 =?us-ascii?Q?pzVJRJm3SwUrfEWuGeMTuGCyDeqmRJz0ZipDxPYI7X5KLfN96r2LnuMfj64z?=
 =?us-ascii?Q?heHwTKY+Q+U6XjXQAcp96/zXlBQA33WlMGVwDHzDbi/pln4dCl4H+IJygjcq?=
 =?us-ascii?Q?WRWGV3JNpw+KqLGJyHHh0gjkHfArneHt4zQfyUH6UGOiYlFjbhWuXhMssiK9?=
 =?us-ascii?Q?bASpmYoM+fLa5cG8XHHawKozZJEVrw8zzN7bknKMIx47Cm8QFOsEQexQ9I0a?=
 =?us-ascii?Q?VbYqKhrYiut6toibKYjfXkmEa9YtbaVmgh+kCENvkBrzc3rhUIR57HAeU/hN?=
 =?us-ascii?Q?wLb7VA7Vh7rcCzK/k1anSCD8L3XpE98WH/S9a2m7k/RybaqZ0NPSge98chJg?=
 =?us-ascii?Q?EeELo0TEFbMAlhon5iKheEp9XvgxMoeQc8qT05Stjuw3tRwR1YYvlQSXDh+h?=
 =?us-ascii?Q?YFd57Ar/Y+Gb53+fi6Ol3oGW8MPDMztAQnt9ssYw4VkKQRIWOAZkn5/phY18?=
 =?us-ascii?Q?yJw1MHsJ8dJPeN0jbJOI5MMuM9LikJCYXecf4FEONXcHrzTSGHTvVkWYbn1H?=
 =?us-ascii?Q?lgaybgvLEhJAmpyIxCGPegdI6raHTRIaTgIc14sgZIHpHyZpLnLA02CJPZz7?=
 =?us-ascii?Q?DwJnkf2UYQIZ70RgdU+nq3CrTd8i3+jXXmZZJ+5UQ2pE1Kl2yjNvP/vGRiSf?=
 =?us-ascii?Q?avrzR2PGjzh/syNUVtAZmxhBmJYEFepHxZ+EXeob0DZKUbCgFyrzfO7W75nu?=
 =?us-ascii?Q?/peId4oAmi7uUI3ObQSj+TCS3mX2ZCbI/WettwPkyEGpM8EKbcweC3jWvtLM?=
 =?us-ascii?Q?NGAgGYndKWO9jGStSDk57/9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZmLBso1H7/vdOHrJ2aiynRhri4Afz/68nIN4b8ZvSrcAZLKus7vNTNM/rOT?=
 =?us-ascii?Q?ES0X7OJZR0ObDxlXaZhVNcZgeEJPo3otZ0ktnBtIRLwxuk2PmPPt6jESR/Sf?=
 =?us-ascii?Q?3W4/NxdvnruiFf2xbBLBaQGzshqQN3I0vIEtAXzgF279P07TOEkPm3TSaE8h?=
 =?us-ascii?Q?y2SlrU3FjMw0/TBIeHkbzZ/hkUOR5segXtMtKuB7JhWSJ/Nt7VFztxuoSFBV?=
 =?us-ascii?Q?nm07R9Ve330cAWJ2SlT8fcnJoYj+8uhA1Ry3LNKdiAC346ch2yP7srnjSt5P?=
 =?us-ascii?Q?u/SWzrHoy/EpfW8pBiydiHz1STo1dCO6JUJAYKkDc5wq5LxN5q4jT6wbpNyI?=
 =?us-ascii?Q?TIS+X1bZohtIvN/CU/CaNjGAmmGRnUNbIdbORrjAH8OPM8Hv+3HiUrTl8wsB?=
 =?us-ascii?Q?HX6dh1TX4fzqG6T6hNTAxlDX94DDygSmbww6oeVgbp5c/exBN3OC+dvoGTw/?=
 =?us-ascii?Q?KFpyiOdze1m6z1mbLHjOIDgWxt0vZzQPFWeYCtEPWALWk7Quk0NObya8Lgig?=
 =?us-ascii?Q?4lJIvnbeGK+GDsrUiuDPyExG0N5xAQJZ6vZQcBUubPEBPMtoOlZwDZmMV8QE?=
 =?us-ascii?Q?IXPXddrb49bxkR+w0OzUnWkHpLozCw55dVOkpr5FROCBbP/74QQqzys3UcrU?=
 =?us-ascii?Q?kQT1uvJLo0CpU8FbdNFHy+dAa4vEzDS2AXweZA3zgDz+iWnatPGFoB9oaUBM?=
 =?us-ascii?Q?gIV6JGNc+1pIusOLLKIk+jWe5oJKt454l6BR6F+CrgXzaKX8g5RNC3UyaeJC?=
 =?us-ascii?Q?nmgBaZpCaN/6C00zqii9gc3j+1yHbQaR9fzDEvne6JS1+MTzjs8VKj5yfxmq?=
 =?us-ascii?Q?gO8vC2ZO6Kli9znSH/hhaUrh8RAeZrj24GMYYYL/1XA1GqsHr/8bjNw2ZF7R?=
 =?us-ascii?Q?IM3siRIcNVDpEw5o1n06mZWDrr/8IIfqVFqyzf4L+75e03xmuIKykJ1/X5nN?=
 =?us-ascii?Q?v62RuWnWU133GYgnh0QS4WJdCT1XpiediqXRZPq+k4wDjKFC1aTmQNVUa+h1?=
 =?us-ascii?Q?kHAY49huJMok8o4udKCcKf+Q4udU5H/WbtZGtectY8YYiQ1xFh8QipTT4RUp?=
 =?us-ascii?Q?5N5xiphDBnQCGPShUyyvAzucPYUAHMPifPGAWQHQSK6lNIo0wvsmKMLgHhAq?=
 =?us-ascii?Q?ggcdKw/4sFw1c9nRqwyf+1Lmo7A3pKQpieDKXKfFdtJ0L5sNksU9C1EBRm6M?=
 =?us-ascii?Q?sLiJ+Orn0sbgoWu5vl3ogZfUkr4poOw97LTgfI6CxsCuSmAhfvo0FfFoURlZ?=
 =?us-ascii?Q?u0r0t1cTesctQAHuULq4KNZzqEKjHW2huaqaL1kqeH1zMg0HZYnFm2YUvHUb?=
 =?us-ascii?Q?FyTOTp/ga4YY5PQFhagBQK67SAtYKCbdlIfixUEX79qjprbU2ns0ZWI+/e1M?=
 =?us-ascii?Q?ylOEXczGqWAjp9jToolC7I6QoIivWeL9ph0+QhBw7E3IPh4zN+oMES7HEjuk?=
 =?us-ascii?Q?Sjh/kT/rlnWtBYpRLkvMnSYvKWNNN/0V/ceeMoS2cePl9ylEYmn65R5qqh4J?=
 =?us-ascii?Q?7a9ioUw82zQwl+4z/JnmmhAFEojSVILXwi300BI8QWtQ+YNCHUF13saBRp1C?=
 =?us-ascii?Q?tUFfvKb94Q+1c4H9hNxxeLy37/R0kHJPYvnzqe1ZUTG5QIQBOU83tbZD5X3P?=
 =?us-ascii?Q?e1ih0fRD4Ayx2PNt33wNE0wnW2HT4QIn52AdIIQL5vZqgVxpYn4MKSa6rfMD?=
 =?us-ascii?Q?UUdSgQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AwXVBx5XUewhsLw1WWX4w0+i4GIEb0f5wuNFLLa2YRzUqv2plmdbDu2Yx1Qc04XxseWIFiBXs1LDEqzLScBR2N5E/B5C4ZOrI6Xb8w6JL2nwyJlTJjJCh6ANdUvC1c/UI87DG8Xc9+X22Y3xM4oAGuqjc7kAuVAvWlRyetTrKhwee8vk2H5UHgQz5HFoA/tQ+bSkunTRIToKSUej9BxlyVbQtmULAGHMV/VDxFYJ55tQQzSRVQnuoxHDQxVv7i7anSNo4ygnqaF2l5HmFmEHigqPoKHTOJpPqFt41nj1OCuEPkyx7iZBQ4l168JwjofekQfKMoeETlD5xaIZUJY8HnvAUBzDpNmWUGrt7zCTlX9I9GnzcoiqeSnF9vj57JoC5J8sizF4/gOTdNuj/97fLBBbquTK8QNLihdHNotyVHXYxqRv7AunroLf986hEdk4R04eza73IBuwPUK5u9S2R6YREBeSRFXnqmLKvFKTI8efV0lyXCkByucBqBmiMKLHbYY9lMbTjfhcJgYDPgyyzBAaEBoVssqE1HrLdKk1pfiQ2eAMyE3Jk26+4s+wKCBlgYxRQuHn50JYzdTyMQX4M0iZVfmbEJMojBDlPHXjZZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fe87f9-5542-4f1b-36cb-08dcef8b6c4d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:42:07.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogWusKmvQxfa350aYkjvge4FsRguZT/3CLTTG02fEtpUCVEZd3C4BDSczZe/XzDKVhd1Y0q2aFP+X7qcdywUjgw8OcAUqvJ+1unBCPUQw9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180100
X-Proofpoint-GUID: YJ7whrTwB4mtCcsjRmb7Fb0MAEKHLbKs
X-Proofpoint-ORIG-GUID: YJ7whrTwB4mtCcsjRmb7Fb0MAEKHLbKs

On Fri, Oct 18, 2024 at 04:47:10PM +0200, Roberto Sassu wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect().
>
> However, that commit called security_mmap_file() inside the mmap_lock lock,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock and retrieves the VMA
> and the file associated, and calculate the 'prot' and 'flags' variable; the
> second takes a write lock on mmap_lock, checks that the VMA flags and the
> VMA file descriptor are the same as the ones obtained in the first critical
> region (otherwise the system call fails), and calls do_mmap().
>
> In between, after releasing the read lock and taking the write lock, call
> security_mmap_file(), and solve the lock inversion issue.

Great description!

>
> Cc: stable@vger.kernel.org
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
> Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com> (Calculate prot and flags earlier)
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Other than some nits below:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I think you're definitely good to un-RFC here.

> ---
>  mm/mmap.c | 62 ++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..762944427e03 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	unsigned long populate = 0;
>  	unsigned long ret = -EINVAL;
>  	struct file *file;
> +	vm_flags_t vm_flags;
>
>  	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
>  		     current->comm, current->pid);
> @@ -1656,12 +1657,53 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
>
> -	if (mmap_write_lock_killable(mm))
> +	if (mmap_read_lock_killable(mm))
> +		return -EINTR;

I'm kinda verbose generally, but I'd love a comment like:

	/*
	 * Look up VMA under read lock first so we can perform the security
	 * without holding locks (which can be problematic). We reacquire a
	 * write lock later and check nothing changed underneath us.
	 */

> +
> +	vma = vma_lookup(mm, start);
> +
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
> +	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> +	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> +
> +	flags &= MAP_NONBLOCK;
> +	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> +	if (vma->vm_flags & VM_LOCKED)
> +		flags |= MAP_LOCKED;
> +
> +	/* Save vm_flags used to calculate prot and flags, and recheck later. */
> +	vm_flags = vma->vm_flags;
> +	file = get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +

Maybe worth adding a comment to explain why you're doing this without the
lock so somebody looking at this later can understand the dance?

> +	ret = security_mmap_file(file, prot, flags);
> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
> +	ret = -EINVAL;
> +

Again, being verbose, I'd put something here like:

	/* OK security check passed, take write lock + let it rip */

> +	if (mmap_write_lock_killable(mm)) {
> +		fput(file);
>  		return -EINTR;
> +	}
>
>  	vma = vma_lookup(mm, start);
>
> -	if (!vma || !(vma->vm_flags & VM_SHARED))
> +	if (!vma)
> +		goto out;
> +

I'd also add something like:

	/* Make sure things didn't change under us. */

> +	if (vma->vm_flags != vm_flags)
> +		goto out;
> +

And drop this newline to group them together (super nitty I know, sorry!)

> +	if (vma->vm_file != file)
>  		goto out;
>
>  	if (start + size > vma->vm_end) {
> @@ -1689,25 +1731,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  			goto out;
>  	}
>
> -	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
> -	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> -	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> -
> -	flags &= MAP_NONBLOCK;
> -	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED)
> -		flags |= MAP_LOCKED;
> -
> -	file = get_file(vma->vm_file);
> -	ret = security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
> -	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> +	fput(file);
>  	if (populate)
>  		mm_populate(ret, populate);
>  	if (!IS_ERR_VALUE(ret))
> --
> 2.34.1
>

These are just nits, this looks good to me!

