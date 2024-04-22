Return-Path: <linux-fsdevel+bounces-17396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9C8ACFB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E7F284726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00348152DEF;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGcniPEm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rC6KMbxs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEB1474B9;
	Mon, 22 Apr 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796859; cv=fail; b=ZO/fcR01U+yaw2xkSgCCdCw4yFPY/DdYBoUmWsmJ9pKdmAouj2BJEtg1oegIjiTh8NMAHw7sF/x0Gz6WnGurrxmmCTZ8Mo5d/jPYIOmOAeRBwGSqzDGuzJf7W/0n9F1d0yFf7/IjIs8TuQPBtRw4ocr6lAJxNXqQNttHQROQk0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796859; c=relaxed/simple;
	bh=NeC6oIlwZkd5qeu+j1ngCwlzznJXASClxnEcLCnOJbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+GCltkjTnkU9ZvGwduSXUq3IOqQlNch8nhx5jMSafOGlp1FZji4wxX7WvRV3GpkZt1RUVsItHj7TxJc5IRifb8bMng1bzz4ZMqQDMwfoCUsSCkZ2wffkRghbtGIwFtH04OCjtQzbdMmdaEWJFoaVP2rYj3M60pllpvKfc+/vb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eGcniPEm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rC6KMbxs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDZCX0020753;
	Mon, 22 Apr 2024 14:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xNFprL13lOZTXnDP0AM2Aa+pOjBkZj67b+iK0XfxumQ=;
 b=eGcniPEm9F1GRA09F+qEEz6CrLftwf5P4u4IWsj1CShtF65nQZ94YFwYi0hI0b2LOQez
 h170v8yTd7fqim3ME2kyxrlOWotD3Q24R1apQ0Zw4GGiavyicqCUQkVuyoXAtnaru2QE
 RXKF2lh1RsGrFf+DhlRzl0TykkpfOO7VPeIO0X1cg6T39Egas/bozBZ6BAgD7fGkLJVw
 dQeuUHctUYvX2aNrBan96OfBjwkRHblDO0bvyUaDGNtFysaJdqilshqIOt6Xd9q+O7Lo
 eNWLxKpmvGPi/p0hxI2kuMFkIB1dz2k0Pg89BFp+gtQ8nQBpmdMY0jvJ71jMmpSBaheL Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md2vs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtjFv006759;
	Mon, 22 Apr 2024 14:40:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455qkvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkOThC+I/vMPhlC6N13fA7KG/8V3cvXGpyI7WUf+oXa/9GdRIHsRON1w9Cd/q1em9onAdobeYPTuaIFEhCfgmvjyLHYGXUAimVV4euMVI87OnRwm1xeP7t4TWjm2pQZvHG3y2gHwaYPhJclT0ytKy3u1KsRiikXovnGjBRVlUiADrMsoH+KIoXHIklNpuSvcSfKA+ht5foVsWaFxwLqwBhxJImiX92z9Owy9EQ3IQsSm2K3pi38dPtZrVohkAeMh0tRvXTJ892yFYymxOzUFwAtmjRzyLvm1t/vtqOrF8psI8EfhI3uAiIPCV5pOZEvLB0bl6fPxbRShZuQ5vlK6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNFprL13lOZTXnDP0AM2Aa+pOjBkZj67b+iK0XfxumQ=;
 b=A/fMe0zu6dRvZ56bwPwdULw9pvDg4cCehSbCoMpRbZ1ZQYn9CIHIkzSTvCeV30VB96SrHecntFZh372RQoaAK42gQVv9oNQ1vismb1o2e70SzeUm4KCFAoepTkccHqLuElRSI9esloQ8YOyqGQldc2NnnJ9v/3E7M75anx19IGa++xW2Mec78yHXTj8gHyxRnuAhpOW0q6WbWSifRht5F9a+B6CIsayZTDOz5vWvvgTRkrIRiRLzx0iDQQFmt6d3l3HdwYUtuzTcq9M2Fy1GBUwn/gXQ35Cv6mJECOUITLyGJeXDu0GisJ3kRXrLhdXuJozJHCTLIqwlsWLrIE001Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNFprL13lOZTXnDP0AM2Aa+pOjBkZj67b+iK0XfxumQ=;
 b=rC6KMbxsEm9LuwWulUJIJR5MtSJjAr4KwROHOV/YFC9j7yqV0HqxMHij3UQXSYOtl1YK72sPdLx6w/QLeStXsmizg4IycyOVae2LuaIZLr2JTBWhZEaAnwsR2PKJQdB4ANLQJk21pG1hh9EnOqjQI7/pXCIpQEPfziUkd5wVvPQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 1/7] fs: Rename STATX{_ATTR}_WRITE_ATOMIC -> STATX{_ATTR}_WRITE_ATOMIC_DIO
Date: Mon, 22 Apr 2024 14:39:17 +0000
Message-Id: <20240422143923.3927601-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7088e1-f7e3-4096-f35e-08dc62da1fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6YOMl31mRJY4UCzc2E0wYQU42up3jRn1Fhj7zN/P3pd+OkwNduaOSe9Cu4+U?=
 =?us-ascii?Q?AglGWhC0f7aIBEjAzfmC9/qhmrsSu187am+rlVPWVMu085Qqhs3W7d/KXsL/?=
 =?us-ascii?Q?rMSDjTbh+fQENup9oImAkB2MxaH9oMhSgKswd4bmQLVPBR9JnXyHMzev7xxM?=
 =?us-ascii?Q?z2+8O9KPJ9RnMEgPWgXcWuTpEjW9QlozR1mZcnUntErTaun55fC0GFHlDjT7?=
 =?us-ascii?Q?Rs0ZO59n9Rfq1FsRP3AW9Yaj10jIsrX9HxjTAoWfIFv9O+Iz8u/jeNuSOP/i?=
 =?us-ascii?Q?4HVsCutMcAY27G/0p7cAfsxTf7hher3Yy+nIYpw8bDQdUCpFLHnw1tUm1R3G?=
 =?us-ascii?Q?uo14cL7IvJMmjfne3073J82ERoi8FFHvI+t0MCb3EeE/WgCIAWAeLA2pmO0a?=
 =?us-ascii?Q?uK2/MRkyBvHStNhN11U7dBHes7TUr9hbXp+9EYooNawIYjFlIP7wR0n9IJ+W?=
 =?us-ascii?Q?Pqpza4TXDEJYzwyVJGqzTwDDQIN2XOb20vGodODZjUfHAyZCgyJEL60t0nBU?=
 =?us-ascii?Q?EzJJZPdMFoHaMp90jkobQuy8XuY9GKXKeP0W23TZo2I+CajegbO3a2/VPtpB?=
 =?us-ascii?Q?cY9PalDaROcTYmOXlvL+O+lSAAGxqakU0AHlX4mcuxdCyaBkq1L2TTY770+D?=
 =?us-ascii?Q?ccAvDJKx1mdr7lGn5dCIbbOKrWpo/zQxGwJZB+bIKdL8ftLUVqC9it+qIjk/?=
 =?us-ascii?Q?+dYpSuqv4LD3uFgs3mWAWASI0aNWhf0zjOHP2sa+Xm4/kJJ2PMqRcQHC9FVb?=
 =?us-ascii?Q?QZVuTT/elrtjaxlFFUx8sWgbV/UkaNAJbdUse5OQv9IGZS+WzBWvqGWtg3nz?=
 =?us-ascii?Q?M463T5pONgVNEmKpbHMLYhJXV2uMrLnoDjPqNecBSY0/UetSG4Ea2kuZoh12?=
 =?us-ascii?Q?gxgw7AM/AIAnoUrtlmyeGIMy58mdrx1IA85niwfl8Q9yQR7w1eFADcwU3kjF?=
 =?us-ascii?Q?oS2zXOBPGQztSxYhn72J4sgJzVt5osbDLa/AiCTG+pXyLOXoWCBnHAZ7wDgv?=
 =?us-ascii?Q?W+GnNYUzrwKj3kcJo4u/Rz0gi0+jmoU1zulwaymeLmRntGXRarvx/ukehXyW?=
 =?us-ascii?Q?uJiRSk7cHouq/1wQUI0bjZWoG8U7FwRtNxFIwZ9VIbLI9yL48qAorcY2q6Mv?=
 =?us-ascii?Q?X798IGwlgo8/Ic73kZOhDL+GdeCa9HhRbr0tLgbbEUYcac8r2o69tfPCJmbI?=
 =?us-ascii?Q?UltifmdStMRF9Zukpxx7iGU497VlTPxrri6BBDb9ErD17Riv/qlO/710Zpu/?=
 =?us-ascii?Q?mXE6cv+gp8dIuddLwDn6qFD5M+Na/z9MkJJOn080wBg0dp0jxGxUpgdo+XFq?=
 =?us-ascii?Q?lKz6BVBfdoxUqszSDpazLbtc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?shYMtFj6+4OpV/TeoMKTQCkwxeobY9+nMYs8HhCtMpU7DkKEKqg5SqTx5ASX?=
 =?us-ascii?Q?c+8bbq6qobHbFmPrQdKRr3D7eiznXubcAIeUX7W99rb/ZENbwlXJteLImawk?=
 =?us-ascii?Q?wtnt1XDFr0n1HdwvNOj+WIrLjw6xyKMeq/khgkNp4gbdTj+EC/5t9bc4XS1A?=
 =?us-ascii?Q?yBIaPWxLH7wdCPskXX21uRaBalRD9rVFfKvd8oUpGhuTXpfJX6mARo8wpynI?=
 =?us-ascii?Q?VuGjgqlR5iLZVKmSk2fN8ksNFvqP/z5ilz6corBpAtl11jbAktIn8VFqYDrj?=
 =?us-ascii?Q?UelqbP4K9UvH9EWuMknQpfEVCsezrDOm/cZE9XrNMHJneLz7RbjzzweTNz8h?=
 =?us-ascii?Q?feh3gHAoBRwCaCSQy5UbvYxPzq2Ot3y2shIrpyWvOSvEQm3xLO41Y8Fwe7FX?=
 =?us-ascii?Q?WkMc3dOZJWO93sTVCOXCnUEf0YQtQTfxopWvSjXPzg780wiUwY0MLzJCyT5F?=
 =?us-ascii?Q?Z5Ql6X7xpm8S4TmgZsGLO0LiP5To7/X10NVecRCgayJEtyRdmGkIsMWmBVU4?=
 =?us-ascii?Q?3eAgbyG+FFAwTvqGCkOvg87hmFbaHPjOFSQGva7WPeNNYCW/yNBV+o8GKj1H?=
 =?us-ascii?Q?d/AwG6ci0hUGc5F8RZeDcOfgQ5dPKxwR8wF5Bs6BqY0CjDpTIze7s14Jwlyc?=
 =?us-ascii?Q?jPWyO3uXJ8eL0xUhKKOE0rRahyWhA4mV77bfpheBhjSo+U6k/unY2+uwM4Fr?=
 =?us-ascii?Q?jlv/6EmJo/erNat0L1ulWY0/CGoXhKck+X6TnFKe68ev2r+GK2U90fHfKxEy?=
 =?us-ascii?Q?2mVFPo+WoOwAnq1+vWDqD+D+iGwMHrGwrWbsPIHMSy6keJRVcGrK73dMGMug?=
 =?us-ascii?Q?iTwfn0QQ7syZG6HiPtYPBUKGCPOHvbnjeeY5qvk6QzGUNIoe7fNEt2wUfKLa?=
 =?us-ascii?Q?OMlFPAeHPVptN4TjsEu73UjRcDQIM3CGI7Dm1W6tKn4vChiKplHPHuEOtfW0?=
 =?us-ascii?Q?RnQTTd15WMKpKTk/2rvuqP9HbSpvrYo5pgC7qqPkXhf300hzRLZt94fFrLcg?=
 =?us-ascii?Q?Cwa3jRpvwiWXJVnmUJDwYMyVBp6j1tZDuuBK40qIPDz0Q6GDduWnpMMyhW4V?=
 =?us-ascii?Q?OiwYlLnye3Eg9wMIO2iZKQl5A01ovvet3od1OJAblK5WZ6dnrvwYez3p52Vm?=
 =?us-ascii?Q?7M1xBUDVhX44WaYgNKfLO+pzGnT3NbrQ8tupIqxZNnQq72CBGF5uFvZTcJW5?=
 =?us-ascii?Q?8lmUsCpIqvLfMzO/7MVeddTrmQXtJcGc6OkjFKtCkxt6VpXlhM03tAZr220Q?=
 =?us-ascii?Q?KWUl3gtIk1zWb3P1Km7vbz0Z7bdnxjp5afIabWmdfL3Y2uh3StuiM8IBEnaO?=
 =?us-ascii?Q?it70pyw+t6KcB52GvJtX25LjCqlES8WgT/JIxsepGeDGxTdSsWS76GfI2c2w?=
 =?us-ascii?Q?WkNxYSzGl/oovFi3opH3kpGEmxmHITetbOaYqlE/3eZm3ru113IjS6Nzj3dV?=
 =?us-ascii?Q?wRRoT0M+NluAPKrdsob1dCquD2in/pjYVGSkDGi7++Rr/IXTh2lmsYAuV3Y6?=
 =?us-ascii?Q?gqvS6e/SlV7o/Rz+SoVWhDRPQnOZ7GQtC6DV6XUr32LV8VqV3nkV5AQQ/KkD?=
 =?us-ascii?Q?IOEIjSEhw/9Oqnr2Y5UN/vLQn3/6JXcFZIoNGIXSWWyOZo90UWzFbiMtt0g5?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zx7YiUrxZFtjSVzxqlpeZRFhZ7cVreul/vReJrtTkdzAnO4Wu0fjClywCgWRxpIzpAyBxhR7H9nvdNNqq3RdhjGq/Ag1auiboFYYgIWd8yfhWhR+PfE+JsKGlRgf8vDGmzP43bJAh0o34lvo/Y7CE9Us+G/PFM15LdGkX7Cy25wa8Ye5I/AwufNRP89ok3GXd+PXoGB9YyH100CMbS/3lKwoeccGed6fKcCKsFyt0mJnAWH779S/pLfOgG4bI7v0ZfxhbMj1jQOfYajeEBbyKz4Od9GcwY8UfgViVdf+8PfoUZRU8h4LILdixvE7RTwFIpaqbeAPfMp5WZ4iXVhZmKxYRl2tkSLxSfiLirJhyKZdySmzY5dnxWMTto4jI+CiLOK/VmKc0ddwpgsC4/LEfL0pZBxVFeRfZ9NGH7dx8r02ZYLzJ7/DaN0tY74Htt6LEArf4oLlo432RU9oWe0MVpp3STFHLofUBmlxcmy0U9HUqjTc+YU4CqCYcH75POKk2eOdtPQWxZYYaDHQ1jPmtoaTRPf2vnXMq55X9I+MegguWLAsEXRuCsLqArAWA0mPsRr4+aZd3nSZWMHwedpcos7Kgqkn5OMvHqV3C9WMzlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7088e1-f7e3-4096-f35e-08dc62da1fd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:15.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8T4Hfjs5VO+8fewgVNbjtji2KSYRs2cpwZ89XTTa+WEo/gWBLz/N5gxjEXN+6gqrEkmrO7pp89JGCc6UgGAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: Wsa-kJHzDeyLUWYA7S6uCHAvcxph-GEN
X-Proofpoint-GUID: Wsa-kJHzDeyLUWYA7S6uCHAvcxph-GEN

Rename STATX_WRITE_ATOMIC -> STATX_WRITE_ATOMIC_DIO and
STATX_ATTR_WRITE_ATOMIC -> STATX_ATTR_WRITE_ATOMIC_DIO, to make it clear
that they are only relevant to direct IO.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              |  6 +++---
 fs/stat.c                 | 10 +++++-----
 fs/xfs/xfs_iops.c         |  2 +-
 include/uapi/linux/stat.h |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3dd9f3c8838..e2a9951bd2e9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1182,14 +1182,14 @@ void sync_bdevs(bool wait)
 }
 
 /*
- * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC_DIO} for block devices.
  */
 void bdev_statx(struct inode *backing_inode, struct kstat *stat,
 		u32 request_mask)
 {
 	struct block_device *bdev;
 
-	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
+	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC_DIO)))
 		return;
 
 	/*
@@ -1208,7 +1208,7 @@ void bdev_statx(struct inode *backing_inode, struct kstat *stat,
 		stat->result_mask |= STATX_DIOALIGN;
 	}
 
-	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
+	if (request_mask & STATX_WRITE_ATOMIC_DIO && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue = bdev->bd_queue;
 
 		generic_fill_statx_atomic_writes(stat,
diff --git a/fs/stat.c b/fs/stat.c
index 0e296925a56b..0c0c4c22c563 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -95,18 +95,18 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
  *
- * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
- * atomic write unit_min and unit_max values.
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC_DIO flags in the kstat structure
+ * from atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
 				      unsigned int unit_max)
 {
 	/* Confirm that the request type is known */
-	stat->result_mask |= STATX_WRITE_ATOMIC;
+	stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
 
 	/* Confirm that the file attribute type is known */
-	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
 
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
@@ -115,7 +115,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 		stat->atomic_write_segments_max = 1;
 
 		/* Confirm atomic writes are actually supported */
-		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
 	}
 }
 EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2de0a9c4e6e0..37076176db67 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -650,7 +650,7 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
-		if (request_mask & STATX_WRITE_ATOMIC) {
+		if (request_mask & STATX_WRITE_ATOMIC_DIO) {
 			unsigned int unit_min, unit_max;
 
 			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 319ef4afb89e..05f9720d4030 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -160,7 +160,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
-#define STATX_WRITE_ATOMIC	0x00008000U	/* Want/got atomic_write_* fields */
+#define STATX_WRITE_ATOMIC_DIO	0x00008000U	/* Want/got atomic_write_* fields for dio */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -196,7 +196,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports atomic write dio operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1


