Return-Path: <linux-fsdevel+bounces-67320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2EC3BB76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F7864FFC9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36D341663;
	Thu,  6 Nov 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ph0WaXuQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PLgSiM1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CF26FDA9;
	Thu,  6 Nov 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438730; cv=fail; b=SXCqcRnoif6ZJPha+F4/2r6hccDGh84vOFLf24bfucKcDblMIkqfk+72xqvbIKi2Chq4aq2cEJgJdkT12SLIDy02iHBFnER2Kn5D5i7k480Em4rxpzVYgVxC94Zd6qJXwmz9yBmI/Dc3EWO6WABxBpyYeSnPr3M/Na/nPHiDtFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438730; c=relaxed/simple;
	bh=7CBo6rRHsorcpW8XxaNY5RD7yLYPbv7sn8va8CxpI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oguIsfdLpIzFfInyX3zSDHfTjUVRfhVcC5j1nY3uI+H7Hqn2jp/eCms/gul+G/iBbRhwzmaWr3GEDVuoM1o7i8IYxtl4dgilcf4WTSyJkkkWx4j2WU/5RbWpGmjWhuOht8FkHk6vyJ44FA7qF8qfSyBF0HLSxYO1XMZfVNXenqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ph0WaXuQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PLgSiM1D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BacIA030519;
	Thu, 6 Nov 2025 14:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3i+PqoQfy/rlGoBoZ9
	LsnhxNgHZf07YEBS6d+bRUYJ0=; b=ph0WaXuQqxl/zoAaOVMSkr+xKiKy70nGzh
	NtqdnnEiwVfOird6uy7cpq4sHwxuQqdP32ROh41VhoWcC//yEqvjIN1+H9gyYlRV
	pNI/OzQOXhFNEMABMJCBPw+BQIV/NTZo9nxasgikcIImZsxMBfe4mMz9UpGZ7vgE
	sbZx8QdopfTKHGYGqWy8Nsw0k1xI/9tEgAPehiTLAdcjBUMlQb5NbopN9q5nMW8w
	gahXAg135dC8t6AIQ/L4Mn/HbW+VnvOs7eKEq47xU4d7MsuF6uF09qCRKR2AYVYQ
	gH/yew+MUA5gb3Fmog8O4ttHY6Lu73gropgrs6iu5zSwS6SpAf5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a89q42aku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CXcH3039444;
	Thu, 6 Nov 2025 14:18:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc70s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw7M0dBWp0vV2KEszTOfzR46E2vWoYoTb/tmRnfB1TWZZNE1vSVkeBjZOUd/3TtmipcIXXrYHbS89kN4aYR+rCuZiNBhXIbmT/zkuCfGJsvJMw//a3cAx/2nz7eY1EZ0Uwe5dkQoky2xrg+NWbSMPIjZNyatFOF1w2UsI99c5160hUJswqbWjKAzTQ+eiMF3q3G+WiXeZxveASupXFGhllNAdRuflNl1MB66Op2V1W+rJzV2HsYHIdZ4LtpS806Vp/84cqJyRaak6b+83YaMgv+IgKeFFIKfvg/dVceuB6QpbVlrk9HO0b+7DInzsrWboY1+0nZ8xHmCqSPr071FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i+PqoQfy/rlGoBoZ9LsnhxNgHZf07YEBS6d+bRUYJ0=;
 b=SD6pvbbTAyCVZ7rA6X0wpInzgviGcmGHi2D7k/+Hk1QrXZURk4dBtjeTrf3gULzVKG9j0nmRrRFKBeeANHEAE7NKsbYEoLZpz3O5ZAYkGNl8y1IKrj/D+woTDCJBfyFZQY2anWQsR7VE9CAUaKVHLps51u86XdHQ/z4AREvMjf+cyc7Ec2wxsB2GAOv0qq6XxI2zLBP/wISrk61NbeMGnhoBuMznbmk2lH2Itskcfp5AQJaEC+AB60dt797ZFMfUZhER9JobTzTPOhHF4GII/xD8caOOXKYirUFHHqGVETEna6/rYKwRwEODoi271uXxkV58yK3u+O1huI10mOzYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i+PqoQfy/rlGoBoZ9LsnhxNgHZf07YEBS6d+bRUYJ0=;
 b=PLgSiM1DCbhYZ8ojxnw6lgdxspGl2/hmRLKdNW5kjj92I6WGEIrEG5LY9QVeKmTzLGJiKJh19Zks0MpbVZza7WofSdM3WiyNpMxLSL87x4b5AVaFF+YYr0WpSQCMBuwiro9gNbDF6PNYdQ7jXNzX0HOrESeiv18O9ZXwR/VPksY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6455.namprd10.prod.outlook.com (2603:10b6:510:22d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 14:18:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 14:18:15 +0000
Date: Thu, 6 Nov 2025 14:18:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 3/5] mm: implement sticky, copy on fork VMA flags
Message-ID: <402256c9-8cfe-4943-9b3f-40f21c17292e@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
 <3d423848-2b55-4797-bdab-a9b42a373a45@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d423848-2b55-4797-bdab-a9b42a373a45@suse.cz>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a22554-9d56-44dc-eab7-08de1d3f53b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQ/YITsnrKcef9gs7xGUit1p3N0lbE2u+SqC8By6pqyVBhgYlh7YIRjRIoQc?=
 =?us-ascii?Q?MVSuZrjcvPDTnWOGreG6RYOLXMlZ3zuXguxZfge4NR81Cqe+5fslrB+YKbhZ?=
 =?us-ascii?Q?CWtaTrzqj9ihgvOt8jAcx3Qs3KoiQFnK+I9irx9vSbbfdA5aMRGUma7xFZkP?=
 =?us-ascii?Q?OwBFk4VkJ8dyZ2U7q7+z50htSQMtz22RDRzcZ9Hvk6aOTIh0dsaPCLDDs8x2?=
 =?us-ascii?Q?c3iyfTr1QE92KEl52B6IlrOzJcPqgxAGg1+uRHDsdw9ePz43l4YdSyvEInF7?=
 =?us-ascii?Q?T8hHzUdXRmSkmroaGTXcz/TCL5cziBW5PA/Icl4sV5DpANGRdPG2sb7R7TI+?=
 =?us-ascii?Q?b4HKk4g4At+c+fy6awiVUqn3XZtPicClBj0F0gRyCrhjXHixck2hR79JK+hX?=
 =?us-ascii?Q?ZBMXRtnkWleGPh1Ab/6cYT7lUbUxorl4bFoyaQD+2QD6rZD9XVShUL37OY1F?=
 =?us-ascii?Q?5Tye2qm9U4f/u1RN5m2YbJBDarPWNDMM6VFVJ/2vjGg3xNqKDRMV1btQHekS?=
 =?us-ascii?Q?CTHdCT0KFlCwa51q02EO944CAuZsmZb0sBLhmS4JuTe38PbyUFLSmc5TRRzZ?=
 =?us-ascii?Q?CV/0jFefGDwguDLHl1KODVGpZWfEeGg0Q8e+S2K53ciW5RUuAzn74uc2iK1Q?=
 =?us-ascii?Q?5fCWMjVq8RiXc7e/g7ECJwn5dpDGAW5SZMpBFJQEzs+yym8UP6+OTFPs+Gdn?=
 =?us-ascii?Q?teivdfvEjFBuPIAmR9rSSBEQZCs2duKTj+4HlSVVJv7PScX+KqAtzc9vppFR?=
 =?us-ascii?Q?ZWtS2Veruk3mDr5BIys6qd6uZaSff2v7FBYPD+KSyejBIOfyrvmkaDmPWmE0?=
 =?us-ascii?Q?gBSIiqSmtyN/xXezgZ1QDWs8GtMUwn35KiozpsZioNFq4yem89QOlK7cuIqt?=
 =?us-ascii?Q?FT5lDGYaC3PHIZcrJ1LjHdohHBSjYDQ2zd3WGINUeSM2SE7uhbIrM3UMyOdi?=
 =?us-ascii?Q?Vqf7vXXJHBAnDwvMcJXkXJxkYgg8YgSourfuLIFBVueP35vwFys8IS2fXiU1?=
 =?us-ascii?Q?W9/ELaYWS5/fhF67NjqiQrOCV+uOazE9mUTpyHd2UvXlpoj8dm/BsYlxwkl3?=
 =?us-ascii?Q?PO0bRxVoLmSdDFI64Xi9aYSu5MUeiWIqeeDM+KMv/LKq1/xv+jBQEG6tOl1Y?=
 =?us-ascii?Q?k+G4J/8Ppb32C8WVpujk0G/V5rXnVORGgIJ0EXEtz7nG1HiPWSwRz3ofUCy9?=
 =?us-ascii?Q?R1rN8FaZQdCfFQXtiQ3Mdo6NDLce50u4zXhn2TyJ8FGvxoEiDS1ulaOEU92O?=
 =?us-ascii?Q?yUM0gZ2aClet/N+GcTzhBmPlrzIgPZf0Iw1PHaJKBRBM1/dpuhtPJEJ5/wak?=
 =?us-ascii?Q?IyCqMY7+Q7/juFPp1/PP1Py0m1hwm1KIHzS5H07BBlUWrl6JlJxyEEj4acTE?=
 =?us-ascii?Q?1GFZiMamdeHszaM1sc24Ze+ja3XevcjvDpNBeScCuCdLFDqmzr+LxShez+i7?=
 =?us-ascii?Q?E8Qj6qAXq9aITfuZWwW9UzwZKIJGHRa8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djhyOrUfNxxmS0U92bmXIOLVbPSbA28bFDgW+Kibpsr+ptrHRhZZe38mQOPg?=
 =?us-ascii?Q?/fSELzrHDciLHSBJByp/99fIFU3fZkYeLrF7wqtGpn8jQ+rTNWE/ZtgKXRO+?=
 =?us-ascii?Q?zNaQVxrxoVH0/A9HN852y6EzyMdb2mHGa2pyycoQuPEKM4IxRIijayPJNehf?=
 =?us-ascii?Q?2QzR15G2iKmf73FWql+QRPqOzuEGuD8wzDuUSjBAh3aESVoIS+EgmXvL721A?=
 =?us-ascii?Q?+dgEUl+TUBcT6CjtDG+cF1iixDqE381XtzlYome7WLhQfn3YIIxaCiU6zqMf?=
 =?us-ascii?Q?+yFkSU4Qd70Lqs02hVzzDIJgEmiCbQ2eRsDTaHG22rHLDrkJWIoezRbg5/Mb?=
 =?us-ascii?Q?+B5lEs75Q2N/Xpt7QFD3STpnqcmmAQgP3uKiBySAEiIXvx4Rojdj+Lm2tdRw?=
 =?us-ascii?Q?2jOn00k/0YzGCTsvXG8bf8ykp61LzYE5y4apD3msnUufIisuLk2Q1UM+cUjA?=
 =?us-ascii?Q?4UuHNat39eKjTaF3HXIVaFGxYGfut/qXGODGB05vOZkxvLK2tXTNB4J2Gl4n?=
 =?us-ascii?Q?dLEQ07e7wqC0+xbVCbhzivDnRPa82utN2eC8v/QwLuUCSjigEa0eMRi3oU/0?=
 =?us-ascii?Q?5AqlZV+ubLVgXunFmqmqlsoDYLNP9jgr+Xtj8J/puBC50V9ZuIEYHB+PhDR7?=
 =?us-ascii?Q?NxtZja2vzOQvnH3NXN5PzUvVIjfABMol6D3YQMGW5tNntpvMOWwOa6gH6cl5?=
 =?us-ascii?Q?hFso3tBIlclxVcSO97SOAWHivCjwTf7GtUMRPRyS2jJSqEpMe16fdpB8bIwE?=
 =?us-ascii?Q?QWFyIojejBdXN7gpesGaruZZFMz/RvSJtJZQvVJQxcMmwCgxfsA8MG1eY/ZN?=
 =?us-ascii?Q?ZocA5xCRVpjHU+Hz/Nub4Zit7HA7ysKiFIaTIC5ctFbjsZ6wBVia19ZVTa42?=
 =?us-ascii?Q?FK7ryWLDh+P7MJ19bS8XcbNOAgjkfrnMYIycmpAXt24XanMIA6fTJp0Fo3VI?=
 =?us-ascii?Q?YtY8tz1PmGtwvgIWpBN1Dl6f2QoHymbIeKXlMdZ7c41NmZiaW4SpcSUW+qwM?=
 =?us-ascii?Q?oL7EFHW9fJJBo3MXOgmZUZGTJd8sTV7zYT0gTuOnx615Un6uMUvtcym7cI3+?=
 =?us-ascii?Q?gB8DbiDBGyIH6rJ6YEoWj/UgkFvkqNOVUztd4M5jYiQHsfZC0bVrukXzhQXC?=
 =?us-ascii?Q?B1T/Iz/pgu0OXZrgWjVU7XilHZ5MIJp5TA5RO27pD2elwKD5doIKnG3nKHCj?=
 =?us-ascii?Q?XAqR/s7s2/Cy2dCk5NuEkzFhKEeDqaSAElutPYUsCnc1yqE1HQFwwXNs1zJ1?=
 =?us-ascii?Q?U3H9A/lq9pxMntOa1JBosKkeitBBqh2NsJjOOvQyMXKHmXRQpQdOxdM0k5Ka?=
 =?us-ascii?Q?MpdcNEWkFilQxJNh6qjDWRQiwxYFHUxW3D7K5klNkkxLRKQDrTl2dKG2NbyI?=
 =?us-ascii?Q?9y2B5Sri1T4zXgov7yXldYR4Ltw55Ok0v7B3lfyxst88Msmj0pWQJZX4Eb7B?=
 =?us-ascii?Q?uAT7lut3RzTHi1oq6oHe0LAV7IH1xZxFJtXjjCUPw0/0Cq1D2ObSLe/irBvw?=
 =?us-ascii?Q?l4sWAVun8VgczX7GyusMDEnGAiEdfzyIsdpXqi6+B4IpYoc3fnNC4Rw/YQTC?=
 =?us-ascii?Q?/OS3YlBklA6QCGhoy948LHdZ+IxKymaApUJeCoeZfmOazNYpV/q4RRmkO8F3?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFhKUaT+In0EzIlV/4nF58wqxWZ26F4fkCoEJWHQfHgyIP3vnYFEFZF5yTUGLx4ytobgwp9cFCvYhTKTzmgGk0TbFb2t+OZRV+RcpkqjIf4OBV8GoWzBn51OEvRNr6t6ptNLQvnuwrcwI53/Z2/AFAuYYJd79jl6jsgXwkTOUoFr3x6UM3PEIn2rJ6GvumZGt++GpSuN0nLCiQzdnhZa1Oq3wgL1TE+FUtxjoh0tSKoFcfy8HJ1+wtwoaWCmIuf4KA6aRTBxovHC9JdR1RhRBH+GhH9vPmOCBjsTm8qVLsEjM/WmQfTfGAD1zJbiTG0JvAVfMqJgvm+Pct7Bu1K/qk0u5neDW0XZAbO6mRGp08rVCgXq0Gg44t6tNjMJxCkGv06DfMCO4XeGxyYUrxw+4gDaifs0cP5VXRCH3h8jdJ7+QmCM3vpKS3lXPrnq/Oq8HZoMR0XEH6Icm6IhLuISRE2IFWjG/DG4sBJZuV1h7yA8H1pFt/fPMxA2Z1ZXw7x4dvhVRVMkZZc/FySp+LT8+S3YgJU4h+Yi8M0Lrjo/npISs7ZkgZEeDxer8SCWlt90tia2bfy/e0NG2DefJ3LzQcPaAJSfcFfoFgW/TiGhcAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a22554-9d56-44dc-eab7-08de1d3f53b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:18:15.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJPJ0dkmvScIfaYhLcyWWNK8xD+TcrvuiaHX8+1ndltlTq5lPlVYpyZhJtqcQy6yS00k35XAUaTmCk3IUVtEWujxps2rDWUKmd9Ivs+cXpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMyBTYWx0ZWRfXyI/r7f+EBFe6
 S2w4L0c3XYxwRcgJ6xL03rdjwhUgi/F6goICM2u8Huvl5dhzth4csNKo4t+j1jSFq9mYcteZeDA
 MyOX15HUh24XmD7CHdL86ei6hO5wn/Ro2nN72jNonIkTxnAv/w7jeYLj/gtjfL4BAfHXBZhPOvS
 Sr0VPlrbT86r578KGNJtvAxFwK+nK/48Xl84pfSgXLzzRa98fYehYeuh6tSbFd3J5buF2bz8xm1
 B9TwUESITaUUR2J+4IImOlEOkARscVy9upBxBZ+ojq1TSw32EXSCQayClZNDwgUURgpp6vLFZGq
 q98xVaSfKtXj5uzB4n2RWHHMusRmYURwqD1lOVjGe4e/2L8SpbW5F+86rvCExAipQOTWtviBfGu
 RVhrwtDxHNrHnAYrLb+cJsLZy1bvbA==
X-Proofpoint-ORIG-GUID: xEm8AU5MtEE42HbaflreMfi-OmDQubcD
X-Proofpoint-GUID: xEm8AU5MtEE42HbaflreMfi-OmDQubcD
X-Authority-Analysis: v=2.4 cv=PcPyRyhd c=1 sm=1 tr=0 ts=690cae34 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=zXn8fi02h-s5hj0GWDIA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Thu, Nov 06, 2025 at 02:46:38PM +0100, Vlastimil Babka wrote:
> On 11/6/25 11:46, Lorenzo Stoakes wrote:
> > It's useful to be able to force a VMA to be copied on fork outside of the
> > parameters specified by vma_needs_copy(), which otherwise only copies page
> > tables if:
> >
> > * The destination VMA has VM_UFFD_WP set
> > * The mapping is a PFN or mixed map
> > * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
> >
> > Setting this flag implies that the page tables mapping the VMA are such
> > that simply re-faulting the VMA will not re-establish them in identical
> > form.
> >
> > We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> > behaviour, which currently is only VM_MAYBE_GUARD.
> >
> > Any VMA flags which require this behaviour are inherently 'sticky', that
> > is, should we merge two VMAs together, this implies that the newly merged
> > VMA maps a range that requires page table copying on fork.
> >
> > In order to implement this we must both introduce the concept of a 'sticky'
> > VMA flag and adjust the VMA merge logic accordingly, and also have VMA
> > merge still successfully succeed should one VMA have the flag set and
> > another not.
> >
> > Note that we update the VMA expand logic to handle new VMA merging, as this
> > function is the one ultimately called by all instances of merging of new
> > VMAs.
> >
> > This patch implements this, establishing VM_STICKY to contain all such
> > flags and VM_IGNORE_MERGE for those flags which should be ignored when
> > comparing adjacent VMA's flags for the purposes of merging.
> >
> > As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> > already had this behaviour, alongside VM_STICKY as sticky flags by
> > implication must not disallow merge.
> >
> > As a result of this change, VMAs with guard ranges will now not have their
> > merge behaviour impacted by doing so and can be freely merged with other
> > VMAs without VM_MAYBE_GUARD set.
> >
> > We also update the VMA userland tests to account for the changes.
> >
> > Note that VM_MAYBE_GUARD being set atomically remains correct as
> > vma_needs_copy() is invoked with the mmap and VMA write locks held,
> > excluding any race with madvise_guard_install().
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h               | 32 ++++++++++++++++++++++++++++++++
> >  mm/memory.c                      |  3 +--
> >  mm/vma.c                         | 22 ++++++++++++----------
> >  tools/testing/vma/vma_internal.h | 32 ++++++++++++++++++++++++++++++++
> >  4 files changed, 77 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 2ea65c646212..4d80eaf4ef3b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -527,6 +527,38 @@ extern unsigned int kobjsize(const void *objp);
> >  #endif
> >  #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
> >
> > +/* Flags which should result in page tables being copied on fork. */
> > +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> > +
> > +/*
> > + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> > + * possesses it but the other does not, the merged VMA should nonetheless have
> > + * applied to it:
> > + *
> > + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> > + *                   metadata which should be unconditionally propagated upon
> > + *                   fork. When merging two VMAs, we encapsulate this range in
> > + *                   the merged VMA, so the flag should be 'sticky' as a result.
> > + */
> > +#define VM_STICKY VM_COPY_ON_FORK
>
> TBH I don't see why there should be always an implication that copying on
> fork implies stickiness in merging. Yeah, VM_MAYBE_GUARD is both, but in
> general, is there any underlying property that makes this a rule?

Why do you copy on fork? It's because the page tables contain data that won't be
reconstructed on fault.

If that is the case, that applies to any VMA which is merged, and also - since
you can't be sure precisely which page tables contain the data we need to
propagate - on split too.

This is why copy on fork implies sticky IMO.

I can update the commit message to make this clear if this makes sense?

>
> > +/*
> > + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> > + * of these flags and the other not does not preclude a merge.
> > + *
> > + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> > + *                dirty bit -- the caller should mark merged VMA as dirty. If
> > + *                dirty bit won't be excluded from comparison, we increase
> > + *                pressure on the memory system forcing the kernel to generate
> > + *                new VMAs when old one could be extended instead.

Note that I'm literally just moving the comment from is_mergeable_vma():

-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.

(OK I see you realised that below :P)

>
> So I wonder if VM_SOFTDIRTY should be actually also sticky and not just
> VM_IGNORE_MERGE. The way I understand the flag suggests it should.
> Right now AFAICS its rather undefined if the result of vma merge has the
> flag - depending on which of the two VMA's stays and which is removed by the
> merge. "the caller should mark merged VMA as dirty" in the comment you're
> moving here seems not really happening or I'm missing it. __mmap_complete()

No it's not happening, but I can't be blamed for existing incorrect comments :)

> and do_brk_flags() do it, so any new areas are marked, but on pure merge of
> two vma's due to e.g. mprotect() this is really nondetermintic? AFAICT the
> sticky flag behavior would work perfectly for VM_SOFTDIRTY.

Maybe we inavertantly changed this somehow or maybe it was just wrong, but we're
not doing this on merge in general afaict.

I think you're right that we should make this sticky, but I'd rather deal with
that in a follow-up series/patch as this is out of scope here.

Equally so I'd rather fix the comment in a follow up too for the same reason.

>
> > + *
> > + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> > + *                which should propagate to all VMAs, but the other does not,
> > + *                the merge should still proceed with the merge logic applying
> > + *                sticky flags to the final VMA.
> > + */
> > +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> > +
> >  /*
> >   * mapping from the currently active vm_flags protection bits (the
> >   * low four bits) to a page protection mask..
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 334732ab6733..7582a88f5332 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1480,8 +1480,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >  	if (src_vma->anon_vma)
> >  		return true;
> >
> > -	/* Guard regions have momdified page tables that require copying. */
> > -	if (src_vma->vm_flags & VM_MAYBE_GUARD)
> > +	if (src_vma->vm_flags & VM_COPY_ON_FORK)
> >  		return true;
> >
> >  	/*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 0c5e391fe2e2..6cb082bc5e29 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
> >
> >  	if (!mpol_equal(vmg->policy, vma_policy(vma)))
> >  		return false;
> > -	/*
> > -	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> > -	 * match the flags but dirty bit -- the caller should mark
> > -	 * merged VMA as dirty. If dirty bit won't be excluded from
> > -	 * comparison, we increase pressure on the memory system forcing
> > -	 * the kernel to generate new VMAs when old one could be
> > -	 * extended instead.
> > -	 */
> > -	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
> > +	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
> >  		return false;
> >  	if (vma->vm_file != vmg->file)
> >  		return false;
> > @@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
> >  static __must_check struct vm_area_struct *vma_merge_existing_range(
> >  		struct vma_merge_struct *vmg)
> >  {
> > +	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
> >  	struct vm_area_struct *middle = vmg->middle;
> >  	struct vm_area_struct *prev = vmg->prev;
> >  	struct vm_area_struct *next;
> > @@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
> >  	if (merge_right) {
> >  		vma_start_write(next);
> >  		vmg->target = next;
> > +		sticky_flags |= (next->vm_flags & VM_STICKY);
> >  	}
> >
> >  	if (merge_left) {
> >  		vma_start_write(prev);
> >  		vmg->target = prev;
> > +		sticky_flags |= (prev->vm_flags & VM_STICKY);
> >  	}
> >
> >  	if (merge_both) {
> > @@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
> >  	if (err || commit_merge(vmg))
> >  		goto abort;
> >
> > +	vm_flags_set(vmg->target, sticky_flags);
> >  	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> >  	vmg->state = VMA_MERGE_SUCCESS;
> >  	return vmg->target;
> > @@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	bool remove_next = false;
> >  	struct vm_area_struct *target = vmg->target;
> >  	struct vm_area_struct *next = vmg->next;
> > +	vm_flags_t sticky_flags;
> > +
> > +	sticky_flags = vmg->vm_flags & VM_STICKY;
> > +	sticky_flags |= target->vm_flags & VM_STICKY;
> >
> >  	VM_WARN_ON_VMG(!target, vmg);
> >
> > @@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	if (next && (target != next) && (vmg->end == next->vm_end)) {
> >  		int ret;
> >
> > +		sticky_flags |= next->vm_flags & VM_STICKY;
> >  		remove_next = true;
> >  		/* This should already have been checked by this point. */
> >  		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
> > @@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	if (commit_merge(vmg))
> >  		goto nomem;
> >
> > +	vm_flags_set(target, sticky_flags);
> >  	return 0;
> >
> >  nomem:
> > @@ -1902,7 +1904,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
> >  	return a->vm_end == b->vm_start &&
> >  		mpol_equal(vma_policy(a), vma_policy(b)) &&
> >  		a->vm_file == b->vm_file &&
> > -		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
> > +		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
> >  		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
> >  }
> >
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index ddf58a5e1add..984307a64ee9 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -119,6 +119,38 @@ extern unsigned long dac_mmap_min_addr;
> >  #define VM_SEALED	VM_NONE
> >  #endif
> >
> > +/* Flags which should result in page tables being copied on fork. */
> > +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> > +
> > +/*
> > + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> > + * possesses it but the other does not, the merged VMA should nonetheless have
> > + * applied to it:
> > + *
> > + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> > + *                   metadata which should be unconditionally propagated upon
> > + *                   fork. When merging two VMAs, we encapsulate this range in
> > + *                   the merged VMA, so the flag should be 'sticky' as a result.
> > + */
> > +#define VM_STICKY VM_COPY_ON_FORK
> > +
> > +/*
> > + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> > + * of these flags and the other not does not preclude a merge.
> > + *
> > + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> > + *                dirty bit -- the caller should mark merged VMA as dirty. If
> > + *                dirty bit won't be excluded from comparison, we increase
> > + *                pressure on the memory system forcing the kernel to generate
> > + *                new VMAs when old one could be extended instead.
> > + *
> > + *    VM_STICKY - If one VMA has flags which must be 'sticky', that is ones
> > + *                which should propagate to all VMAs, but the other does not,
> > + *                the merge should still proceed with the merge logic applying
> > + *                sticky flags to the final VMA.
> > + */
> > +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> > +
> >  #define FIRST_USER_ADDRESS	0UL
> >  #define USER_PGTABLES_CEILING	0UL
> >
>

