Return-Path: <linux-fsdevel+bounces-22677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B207B91AFD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D0B282F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215D19ADB6;
	Thu, 27 Jun 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxlhkAcm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tKKPD92Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200B4D8D1;
	Thu, 27 Jun 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517595; cv=fail; b=ef3tn8BUXKNCm2ornviYRQChy7lNQ+Anx0ArNdRF8x6WMqaHnT70NSRYwQ8rfZD6EY1FlO47RcxHUWc9N7MUp+QZ99VPpFS2ju4V9WBvPvX79BmPu02VDU1wlydZBVlYlxTk0vFTjfsz76bWXoP3Z0gKo5bnIqmOocrYGqzHxRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517595; c=relaxed/simple;
	bh=yoj+6s9iF4NsdBFPLNTk6ST2K8cSrlSdofuV2JOoYos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g9nwt8C0IdPY4z0Qyw7ojEAxo6gLsepZ8pluWLtSzpFvtdHctXA5ibwfi0WBEufUsk8sHYrg4yq322wa66MIP4aTTm3yifi/rhn6CwHBog6cvVDkEWPSiBKQTksNJMIOiIcZi34tU1AlAf2T2/TUJmFdUct2Yas6TvcycX0Ufzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxlhkAcm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tKKPD92Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtcFe012293;
	Thu, 27 Jun 2024 19:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FzSXeVtTlGu8SMj
	lOM8/uCB8UpFVTxHASl8MDGr4F4w=; b=lxlhkAcmKthD3U3WA4ycFCfxEtzcN76
	ODUtVqRteSiR8dLFjT5GcaH2AJtgwBbBnFM+iYOwc2dKI15jdPZpZmtAF0juupgV
	qNwIjscaLrmbayt2yoK7MWpXTQuRgvcFnpDXntRYg5U/6s2iQmpCRfjsPkvdhpuk
	RWKVqbl77ea9jmNEx/x4/3mWfZDJBZPkDD/WOh5d3nOwuVs4zAvGGotVRmlGj7MD
	SWHWpvRVMTf+ozOGKCP0fVd+4JBo5djAG+lSp0h+WqWPwB9GYNoe1uLYu0avyRRf
	bvxrS5nTOBQbT+jSXOQBEo4DA0DTtn2TzaATRy+xmxqJqF3Ccf6Jr7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t6xft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 19:46:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RJaK8Q010741;
	Thu, 27 Jun 2024 19:46:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2hcur8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 19:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx3twSEmGfW82PVS9bWC5XSwQzIk4ryQ/pAxV2qdBZ9PbQ9b+Y8fNssYsK+HRKKSvXoMyWNOD2T98ex8Q5XtShxqxzcXIEE26NtNHFrNBZH6YGVzekD7mQlrmvXUvjhmKDHk26aDA12FPliNZ4ZryS9THfOmfp41YUEiZTQVTce1/rmNwk0LrR+VBiEZXB9YixflAjYs/nOZuXD0dBZgbwxcGreBn/VLUzjVkWf2sBVR7fBxuZcjc6A4nnv93xx8lNUsbuNE6mpaXg3B7J9zqh8ewVqDUcvjPHMTHIkZXnWfpj3gHOMBjP0BYTPydtDaxLrG3xQ9jiGdOq56Xmj1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzSXeVtTlGu8SMjlOM8/uCB8UpFVTxHASl8MDGr4F4w=;
 b=DFDepDTurTRUyihDzGon9GY1YBZtR9dj7tdNafX7VU7ujtSCvys179Z1K2M7Qpaf5aiRZ6+r8AqsenDXcRadPW/YiElo75pp+x5Z9GGkT61xPieLa68wL88kdFczqn50ETNTv0s1HnqtjQbmcftpO/QJNEHVlsqFPupgOqy3GlrDRraDqIj/YlKgHwcYiBajrbpBPXYyts626J+kE2K523wwxqb9k1Q96+qmzEDH0X9TlVRuhEF8SsbTAAbfrbVIflzMNrIa1cTGaXI/CrYO177b2K7jbhaiV1/mnUB/74c5t7QTL60BovO02Vzg0FO8asZZ01JiWk/SnVKNdLvwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzSXeVtTlGu8SMjlOM8/uCB8UpFVTxHASl8MDGr4F4w=;
 b=tKKPD92YnypcdODoDvcsYFLpBvLRn1+1CFkSBfFGJBYvd5rsdRhYpGiAqbknIbZFJOIkHTX+NRRFHWq2eU24Cbco4W07eKoENESeqw+2mO/rEsZpFC5IAEfzAHjRXbk34eeRlYGrDTi1tDrvIBchtpt7vAARSNEfcIk8N5tDF1c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 19:46:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 19:46:11 +0000
Date: Thu, 27 Jun 2024 15:46:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 4/7] mm: move internal core VMA manipulation
 functions to own file
Message-ID: <zimu7rfc7gf2pdsc4ic3ch3ype7i3dcmh3owj3uigohag36gv7@f4ouk7j7cdim>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <04764090208b57e72b47e327a1e833e782ec5a8d.1719481836.git.lstoakes@gmail.com>
 <zl77uxswmlroyr7cidqh6da7dfsudedhozpssthnsz6fzs7zvp@dyehji7cysoh>
 <919071f2-0e2b-47d7-afee-1dfedc8aaca4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919071f2-0e2b-47d7-afee-1dfedc8aaca4@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YQBPR0101CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5201a2-ae58-4aa3-d9f8-08dc96e1cc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lh7qP8Z2izrRvBbx3K2VQwal6nrA29LM3nO4i+Nu7otTZG+Z+sooxRAemekx?=
 =?us-ascii?Q?RbtqdHEFWow8Efq0K67WegX8Xg3+RS9QKqqviKTTtdXyk5MIbjiN9AJvL51z?=
 =?us-ascii?Q?1sy7aKX1BHIMUBVcAHH28LwP/D5E0WLSikxJKTpqbTBM/Wd3D4P3xImo0m1Q?=
 =?us-ascii?Q?ddBxfZw8RM6gQNZVGk1PLmrCY8tCfXB4UESyCpGE37jON//st0HaF4ihe+di?=
 =?us-ascii?Q?v2Rm1c4suZDgf1z+LxUsHgqqsv3wkOwpifso9sIEywcWIhENnOnFg11uDinj?=
 =?us-ascii?Q?DXO1KKAy05LEvg5RiqX7VOhQx2ZqSbYJnJUZjzyMhVd1KYXLCjWZvRDXA1jS?=
 =?us-ascii?Q?36SDO/NIfk/FI9eiKi1P7iqUD9QC/9rUszUG9GmKV2oDtAv9EjHCLlZmLuUH?=
 =?us-ascii?Q?RxWZZYGa/eqErj93WvfiYHrlcPiX727hkgqWUl5OB20mlJpnnXCvO3vClcXU?=
 =?us-ascii?Q?kFhMSWA2mPO3vVbia1It698AvWIqCOVZDfRAcAWBBZ3dsnXd9f8uGtWfDhD2?=
 =?us-ascii?Q?+mWqBGQZLcbwC6M9Q82m1+YdaEXh5Euot2dDUO/gASieJgeooaziqWgJSjpA?=
 =?us-ascii?Q?u1YQLJa5wK0dEO0ujK5PaBIZFUjLp7Q9Oi9R7Md9tumLvV08tbf/RCsxJL6f?=
 =?us-ascii?Q?1n3AVeFRFtFrx8dKedBWNhF1XxjKdDOYeK+dfKU2EobAAYJLGV09zNXiLzmo?=
 =?us-ascii?Q?MmpUmsFAHUTstCXc9DkcExyeYZuTJ4RX5/U/zkKwQ+JVZ9UI5PZVIA/Az5lb?=
 =?us-ascii?Q?Xtrz35EHoHq3yOon5nN1K9e6nmAja581/6ma8Y4+JkD8HhjUS2VZIadBOznJ?=
 =?us-ascii?Q?zyXfoTwE+8FreEBHM9gDpq5GiCfQphUJMviyT3g1GkFClUoKd+dVTg+NlknC?=
 =?us-ascii?Q?L6dZ9Q0Rw2ShwnULX5gqssZr9lTIewHvDORAjC3jNyIfaP0ojTZXpxGKiDyL?=
 =?us-ascii?Q?XwQ00dMj01kRP3wLoN4rwa64IPZZBcOX04EBSJXK4uoGv1fXQ5FVgTEhM07K?=
 =?us-ascii?Q?IU4Etp90Vme9A9jJjVJtjwuvmqevnpRE/3EL1sU7SKro525yX/SQrg8YUMl1?=
 =?us-ascii?Q?Xcgo5MGH6RXD07bM5rwLlJIFlLptqZ+Aukdng5RWcqeAzZMq5AekPzOL3CUr?=
 =?us-ascii?Q?WnZsc7tFVcOi0I97QCcYYkbVgGL7s/l5xHg4SxJa2P1+mRG7xfK40JoGYwXx?=
 =?us-ascii?Q?IIsusysnqqubPgJj3Qjzd8MYS1Y7k7bKd5RIWlxvxVgs2wGeIS/Qa6GX0rjm?=
 =?us-ascii?Q?SJ0pvjfZ4RVYPTI7tvDMDtLfrIjwf5d3fA3WxFWgI8meoClivq06ABqnhJhL?=
 =?us-ascii?Q?+WoQgyvOrIHunQVkv/zor5Fsa2TXdIDPaUxUhV8CLkNPHQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?maLnlh9tywgaryhXRCiBP5zM2bBvtu2DArZqfV+wZ4Nc2T0JsWSjrLSMCBHK?=
 =?us-ascii?Q?eAn+NvY/yAZqsEKjVdusk0iMtcOIEk096mwC3/vUdWHW8NN6FKVBUwznVvZY?=
 =?us-ascii?Q?M8U6pbqfCp08KIpyGdYiAU4l0T5KmHywP5xSHnGjhoj5Jh2eLP8h8Xr7ntUg?=
 =?us-ascii?Q?eBB4X0lmoVByIfi1IJfLg6lMXRJo5a4pQKECCBCw5vNa0K/Su+XoDllRlGEK?=
 =?us-ascii?Q?BQG1CvXjCWT/RAVp38w5gio/yXJ04RAoS/1qHiz9I/UVxT/v29FCkIYkMZT5?=
 =?us-ascii?Q?4gQYBwlzaw0tQYOI6FQc9vZmJHM/LcI4z8uJLNPbvPNURA5MsvXNbHPLK7sw?=
 =?us-ascii?Q?mAIMKIQxM2Rc/DqWzjcDGdMf31p2DkehK8FTjE0UTSlqrHfzo6Unyqg6GZKp?=
 =?us-ascii?Q?C7U1o0i9enm1ZMxa+de4Fhzr+GYmyuNxhBn2sJuodPoBXyWnvv8n9lDbvZu2?=
 =?us-ascii?Q?iOYHtI8s9rJfCapM4qT0ENUOdafCqlymWAXXGkWJKzyxV6+WEO6K5sYFqtP2?=
 =?us-ascii?Q?d45A1p+y1SGmQBVkbREQT/N3Ws3N11NVt6w94Mh7Px6sgKTbUcqkskMgpy3O?=
 =?us-ascii?Q?UzljTx1UaQnD5/iUc7sT94wlWXh6MTchmDMedixqPSS41C6YhH+GuePlAr5v?=
 =?us-ascii?Q?tyx2R6IuwKW78o/EFNyvv+FxsXpjaXWa230a3qOUTKUFCRxspwnHhx8vUY6u?=
 =?us-ascii?Q?/dl+q9fuPoXwWWppouDx/5Jv+q9cMzXXyuRxlYYJHV/FhHT6bC4vqosRErWh?=
 =?us-ascii?Q?XFvLSOBD5vFH7stdsyz3/aaJ8sG+CnsFdqpPnHICbX4Y6naQurhZRxdUkH4T?=
 =?us-ascii?Q?ogwHafrcR6mMRygFgpjSzYQxpzjJQGjgK/G4k+zpqYupP0fmpNZlnkr3jp/U?=
 =?us-ascii?Q?YDpCY6K0tNJ9vNyU2jokjmsAedZfsnIAnlDVHSTHi6U9/OrplCoScNzhlqBh?=
 =?us-ascii?Q?nWBA5W/y7LCbNZLp2mggxsFl4Vakmgx6l1xDqRqtA5c9U5gvnXCJH/14q6Um?=
 =?us-ascii?Q?ySsaCRw0O9XmclPyM81TATk6kEjY+C3i8gcykiXnsJkokBffVtiFjLAVNeUU?=
 =?us-ascii?Q?HcJ5whJBb1Id6UMLzNI5XQW7yrwfFIsQ6G1FblnJRb17deY3qsnffg66XbcH?=
 =?us-ascii?Q?INergnfsfxFUTYsiZhxIHxwvN1XRFTDM5SlZWosrxRoeoo0O834SjJARSeUW?=
 =?us-ascii?Q?SCJue0jCQYB8E6yvKpGHcac5fBkFsxsXBqH973thquYr7afRh8Ym6HtyqqhX?=
 =?us-ascii?Q?2eieUCyy0ZPBna+nbMGL3cYs7QWInMtGja5OFEwAfvS0wp3P+K2ABoJ/5aFc?=
 =?us-ascii?Q?D4XkMRRFIBIp+wiIyXZ/VvFmeMBg0++ovZOtJt56hseWp2gptQvkMsIbHJO4?=
 =?us-ascii?Q?FWGh8VqfPg78A7deswDH1tyAfvWw2DE909ZSDOfLMaIc7Pm/GK4PK4TeqsTY?=
 =?us-ascii?Q?sRMFKUwm16NPiNRCn1HC4RP321r/i4QMC6HYinezAI/wBvX+hbCQohkfAVJE?=
 =?us-ascii?Q?zocE2n3oN7DE4apyb+NFa1DrgDxCgm6iMGVxyESXXF+nSD6Xrfj8u14MM2uY?=
 =?us-ascii?Q?+2qwLOYHYpMCr/a5DsI2KMFGrlyMTEOWiy1gg8k0+KIGA/i9Zu9SnKu7DF+n?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y86MRESF9Mp+JvE6L9GYPwQvqLZK3Qn87FfbGfHjJHesurou9/7iOVrG8XkOg3A5OZ5U1D5DmVVuWv/SgeAo8pOrQti8q26Jr3YGOLfKLwFE5DKe9U2g2XZ8V7NFmWZr7edF8DQ+Mw53ZHLxW7w06HjYRwatQLGGCZ2FKNwYFCdbSmIagLPH/kgrxPyQcU+h7MPatha9cFQrKWo17YTEOp4yMnES7eNlJBo5Oq5IpMtqxzqv+aURc77JPkQMhQoY8gxwgehWhUWvTA1KT3uUITBnQzpWNrD/xMyTtGDeTNrgsSDLq5pZKepK/BuHH6Gx6FuO2GMh133N3FoYvJXviNsqrHLZDyRTQ1xEa5OdQjdQO2SFGJLkCh9/sSraAsQELWLMRAPjGWwlen0tL/k2jndFIhp/jrTv8fGtXA91BT0ZcgDEKR85ni2s2asT2ctOwC9k4wt7zVrCZ8tKlZFmaNPyVr3cN0OXzDA/D9rhCVr9kNdTBakg7ZEO674j2JAbr+mdUaNi+vfOo+WtDMMWWiVDkAOdkamQG4rz3n3JfRQf8Cu4znKLqAof3jodtWPPaP0mlEg/yNB/5ZmMWRO0AaQ6ObbK0gkceDAx8QEOvDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5201a2-ae58-4aa3-d9f8-08dc96e1cc40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:46:11.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olmX2TpU3e+cQ1ipX1RFbLNKAQnAJeH4Hxs0GJZXDJv9dBNPREZO4J1ZRkbBLCdAt9Qv/CTXwmrig4BJTUoqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=909 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270146
X-Proofpoint-GUID: K1DYgKBQHzLe76HZu0-8gpOiQvo5-gNy
X-Proofpoint-ORIG-GUID: K1DYgKBQHzLe76HZu0-8gpOiQvo5-gNy

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 15:41]:
> On Thu, Jun 27, 2024 at 01:56:12PM -0400, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > > This patch introduces vma.c and moves internal core VMA manipulation
> > > functions to this file from mmap.c.
> > >
> > > This allows us to isolate VMA functionality in a single place such that we
> > > can create userspace testing code that invokes this functionality in an
> > > environment where we can implement simple unit tests of core functionality.
> > >
> > > This patch ensures that core VMA functionality is explicitly marked as such
> > > by its presence in mm/vma.h.
> > >
> > > It also places the header includes required by vma.c in vma_internal.h,
> > > which is simply imported by vma.c. This makes the VMA functionality
> > > testable, as userland testing code can simply stub out functionality
> > > as required.
> >
> > My initial thought on vma_internal.h would be to contain the number of
> > 'helper' functions and internal structures while mm/vma.h would have the
> > interface.
> 
> This is what I've done though?
> 

Yes, for the most part.  I was just surprised to see all the #includes
move.  It makes sense though as it saves a huge number of stubs/#define
of header guards.

...

Thanks,
Liam

