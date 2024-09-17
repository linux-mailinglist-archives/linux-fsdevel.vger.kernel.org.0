Return-Path: <linux-fsdevel+bounces-29571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01197AE0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C292817EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965615C14F;
	Tue, 17 Sep 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MI41e0iU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F9208D0;
	Tue, 17 Sep 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565864; cv=fail; b=aiYdiBJ58WX9Pg4bsOy/LcR33idMyCgtjHk5HSkbeRb4LLUXIDsmObAZArABxFcDh6FXORC81FuZCCcg4lbuRBcsvhHP8PQNC/1UiMdkghcKT0TGwTuH+2nkQuDHoMJHy0QheKP3g/6JaR97iezKvy1KJDfmsRK3knYNI7OAUIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565864; c=relaxed/simple;
	bh=xe8ZfWvK5UT3xcA9GeXsKwHqXxCbwmGB8hDhX+Lp52U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6tQZKH0dAHvV03Kdo1YLeJVYcUn3HxT4QufHa60zsuAatTACA00o1C1MjYvUfD74BuUsStsRA1WVdjlp7Zb9Jry4xRWxcA8yHzr9CLISI71adxhaRxw9rJ8fyenSwiaZXkgncyQ1Fs5UpCQOcNnl1hOlZE8aK4G3y6gJiMZO3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MI41e0iU; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48H0YVIU006343;
	Tue, 17 Sep 2024 02:37:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=1OcqsV7HzmegGjlwGFFyDKbDgVzlbiD0+Uy1L5OHN/I=; b=
	MI41e0iUekxq9ldyrZy6OZSh2u6B+90JjNlGMIK9WLEpJQWZfUJyKNA+GYrZdoBP
	dqm1R6ffwa0b8LtWfRjvxEqXERd4BYOs8DdCh1iFM69FEU6k1V4y0EIVSxJU7mXQ
	BDcLY4DHKARfNgkq/qxKTYxCU8eHO/Olhxe2aIcgNPx3p/coIFovOneDio0ccB8L
	XTTdmewLkDftm13NSI6iY0VTDCFM9DwhYP3Y1n9h4FNYMj8SFZnXeULJy4RRC9h3
	bYCepbkFmfKu2usD9FXovsm9qG9cdIrZKv41OtNnA0JgzsiyFR4fFm4fiPyFd/WS
	v1t1/CgUmdCb28Hacdn0iQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by m0089730.ppops.net (PPS) with ESMTPS id 41n604pbby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 02:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKsvHo3z0fUUyhAVUTKWjdN2GkIu3Z2ORwRJ0v/gSvD7PGS/jo+PXxgJ9YglLHb20AyadIX2VvI3AeqLLpTxcaD6zhiCNkcfH0f/dms+/HLXqw5E1/kClsow7kMMQkcFpWtpVnHMNQ/xXFpAwNJ0XgeTEGVUgejBKBhoyIuTuZI+zI+USWcYO6l+07h+5m9390fGH/Hcy0GACD0y+cp7zpNp3gKVV9yjNhHJD38nLYWab7wetRk3bEpZyreeyPJEIVift3u4WNTw05za1VhWZb0T+Bxc7sivl0WNPw04RzfqC4DFwHQrIMoy7EzYDYTMY/1PW+31G94mEXGKEcV6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OcqsV7HzmegGjlwGFFyDKbDgVzlbiD0+Uy1L5OHN/I=;
 b=BA6k4tC3zB+ThXV0TbLfCgPs3g+t9HEFkTcgmJR0lQ5aIUZZuaN3lN/6FF9ZNkbW5sutAq1rbqpKw8lHPybTSUNVk+fLWuL5Ks9lCqY6IrkK7tlO0Jvr8+dtqwNXmM6aPRXrtSkbskkt26x3DwO1cd5kaRtzOgyhldPWi/0TMS1mE1J8s4VuBuWF8X0pYm0eQIaV6MH/5+yjjUS5323QwAxeh8ChgEjOTk8W6ltKEAJ96iCevGUGMm+sq6EICbRc4a1TxrVPbQEjzhmWr2b5G4vuDyMT9TpgDZqZ9tfUA1vtzejSnYtQNIT6yU9qMTKc+ZZwvCIzO95hyE48tkRtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB4058.namprd15.prod.outlook.com (2603:10b6:303:4c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 09:37:02 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 09:37:02 +0000
Message-ID: <effc0ec7-cf9d-44dc-aee5-563942242522@meta.com>
Date: Tue, 17 Sep 2024 11:36:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <ZulMlPFKiiRe3iFd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d0d3f6-d83b-4d67-425c-08dcd6fc4920
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkRaRThKdjFEN2RXV2xrMTh0OVJZOW5xTGFyTVhMZWw1djlWV2NKOVBPZUZw?=
 =?utf-8?B?dGxSZURDK2NKTjc0L0szUi9tbHJ1WVJmSjh0SFBJRzMxNVhMMlRJenhQeTJa?=
 =?utf-8?B?QVJ2Z2F3SGhjZTJNR28rWUlReXpFMjJ6am9GbmpESmVwaFFvNEx0d05YVDll?=
 =?utf-8?B?bDVELzcvZjAwWGZxcVIvODRwRENsMDlJUXNuVTBoQTQ5WmpuVEU3dHVkc1FU?=
 =?utf-8?B?eVJXNmpBekh3WVRIalUyeVkyS1FBSHpvMzV4dTZxcWpDelRuaUdXV3JMMDJr?=
 =?utf-8?B?NldjdzJOL0tVb010WTRVb1VBZ0xEWDdkSEwvVjltK0lyTk5XR1FodjZ3d2o1?=
 =?utf-8?B?LzVZSlY2VFlzWUU0cHk5c0I0TnM5N1YxOUc3YzBOU1JVSXB0QktneWZWTVB1?=
 =?utf-8?B?L1VyaHFmb0VEeTN6TE44QkY3K0Ewa3E4MEY3UDAxbHB0QlVRRTdSY1ZoN3pv?=
 =?utf-8?B?SGFCZWI1NVJOSFp3Yk1TMUsySGw4OCtVSDVvbldQQjV1M0NvMWdIK2lwbnA4?=
 =?utf-8?B?MWlMMGZmYVJJSnN6WFd2a3ArRUswbm44aW53blpnbHk1WWh5c29kNk1xVTk0?=
 =?utf-8?B?em5wd2tMQ1JkOUFwMGE4NURCM1hRUUVlQ3dkSXJmVHpGb0pQd1ZwUkZCV2Nt?=
 =?utf-8?B?MUQwTkpnU1h4bGpGQkVHQmpCSWFEL2VGcG02NlZOVG8vOTBxVXRsSWhSUG5J?=
 =?utf-8?B?R1lpSVFxOGErMnNrbGE5d3ltaVk3b3dEYS9na09vdE5vQ2Jyc1ZZR0tMSkRU?=
 =?utf-8?B?U3dLQnJtZmtYV2d2cTFOTHJJMGVmTXZVb21UOVdNdDNBQUhyNEtrczY5UVo0?=
 =?utf-8?B?M2hLSXBLL2MyTmZ0SmwxMlBScVMzUnlEUFd1U216Yjk2dkRTMkRXQm5xUUhO?=
 =?utf-8?B?VS9OZDhkN1Q2WWRBbVVEZU56cHpuUU9BZUd4K3d5dmptYWo5UTNUMVRZdlBn?=
 =?utf-8?B?YjRod3lPelNKRUhXMlYwWU16bjErMTk3aUJ0VVp2QlZLR0ZTZWVvUi9hTTlZ?=
 =?utf-8?B?MDBLaGlZZ3VHRjZHeUx3T1gvVFRqNnI0Zm5vTFZxY3lqeFVUOGo0SFZZMU1m?=
 =?utf-8?B?cG52dVViRFVxUzgrQzhKbkpUaXIyYjQ2cWtFK2dqUmVDOWxsd2VwZm1neFJ4?=
 =?utf-8?B?Z2Vacjl5WGcvWVdjZ0tGN25KWng5WCtjSlBDZERLWUhzOEpQYURiTyt0NTYy?=
 =?utf-8?B?VklCOXBGLzN3K0tDUi9ZSExWTkx0QVE1ZkNIdjV5bGI2SU5wNHg5bU96WVRZ?=
 =?utf-8?B?MTlLY2pNSzBmQ2ZGeXdIbFkxYzNFUXdYZkg1VEJQWkNaQVpVK01PeVpScGFZ?=
 =?utf-8?B?dmNmWXEyTU1JQjI5MHJQcGRyVThBR0FFOUh5VXBBbjQrd0lCUXhYa2FCaS9U?=
 =?utf-8?B?ZkcwYWEvMDB5T3lxbUR2OEExYzRFbXNrQXZSVmp5ZGhBSHFHS1N4eVFzdTBC?=
 =?utf-8?B?cTd6TzRMVnVMRWlFYnBwYUVFZDlwZHhzTE84YnpzblM2MVVMZjJXUDYybmxh?=
 =?utf-8?B?SWxrMkhDS09lY2psR3A5Mzh5VEt6WVNnckw5MGhNb3Y5TWFXU1JmUDU4UHNa?=
 =?utf-8?B?MU5IcGVDMDc3MmtNTHB3UjUvTHE5bjJxZUZzVWtwUCsrRUlCWktLeElvZ0px?=
 =?utf-8?B?NUIwNzJ5TFNKKyt6ekE3emlDVUZlUDUyaFdmUXNXSlhaMUJQTDNXdXpWL3BT?=
 =?utf-8?B?SzVlTG1sTHNYRjkzTnhEbFlFdGZVSnRwQXFaWjNXNTJrcGNKTDBINXNPUENy?=
 =?utf-8?B?YWNiVFc4NXRSMjZrZjFRMUNvQytEQnhrbGViWWk1SHBqNEg2VXBlWUovNDVV?=
 =?utf-8?B?VDhlODQrcXJ0YUJ3SHNzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmVQUmVXblFzbWJhUmFzV1R6RDRMaFlYTkdMN0YyQ2xpeXZMczByRjZvYit0?=
 =?utf-8?B?QVNCSUMwMHRtMlhkWHRMUmExTzRWZkJTbndIUm1rRktmaWdBM3pnSzdRTUZY?=
 =?utf-8?B?bCtTLzcvMzNPdmp4YzU2RkpVU0dVanpORzdwMVFmLzRzN2lLTVFiWVRmclpC?=
 =?utf-8?B?d3FjK1FISGtiVk92NTMvRlUrOTdydVlIOVVZWVdRdUhlNjlsdjFXVHphYUFV?=
 =?utf-8?B?cmJkQTFWcE8xN0NISGlLZ1ZkTWR4Q3BlbkJ2RXdUcHZpSXFPWHBvK3RSUnBp?=
 =?utf-8?B?Y1RQNVViVlhlaGRvajV4TFlnWHpWSW16QzhZUmVyTDVZemdWSWU5M1FDa2Rx?=
 =?utf-8?B?ZUQ2SVM2YnZISE9zSlRkQ2Npc2cwSTdBTjlMMUl2YjhTSlNQK0t5U0ZTUDJw?=
 =?utf-8?B?U2FVUDQwc2N2TXRMQytWN1gvK29NSUh0WDhLdk1leHUxNUdKckVSSDd3WVVR?=
 =?utf-8?B?STUwZ04yVUJDTUVSb3JCL2xqc0RZcHJ2R3lraWlwN21CS3oyOTdyZkVFb3Fl?=
 =?utf-8?B?NWtJemlkRVVtOE1mZDlrZXhqSFVzaFJhUU9FZzJxTWJENHd3MmVOTHdKMUZG?=
 =?utf-8?B?cDBUaS80WTBPUkYxTHpBakFaci9XekxMWXdRckdsTGVCcUJuTlF2ZW9BM2E4?=
 =?utf-8?B?TUtSU05lS3hCbzZjRytGTlVzZURFNkROYllUNnhsVWpJUllUZXlDWFlFcGNr?=
 =?utf-8?B?SkJJdzlNaUpWVHpjelJ5MDRMYlNmY1YvZXdzbitOZExVaHIyS1ppV0RDbWlu?=
 =?utf-8?B?cFlDYWxYTHJ3QVlib3NZc212ZG5Kb1pSUmsrRGh0dXY3Ump1dHE5RUo0MGVY?=
 =?utf-8?B?LzB2bTkzTkkwSy9PVFNtL2tXM2FFYmZkM0xFT29jYk9YY2xHS3BBM29VVkMw?=
 =?utf-8?B?ZUpVbUVGSVE1MVlxcXNrTFFMSmpNZS9ldWt4S2JOS1lBaFEyU09tZGxsWkVr?=
 =?utf-8?B?dmxlQnRheFh1SnhXQzZ1SlhKKzVMbVVqL1VxRHhiYVBJV3pOOExjN2JCT2xU?=
 =?utf-8?B?MFBRQ2o4ckNzaGFyOTdLRWhIMjludm9VUDFiRDZ5NDJWZ29aRUlVMWtOVVpl?=
 =?utf-8?B?Uk9kaHdOeUxTV3BsYkY3VUlMbHpxSjVhaDFndHBnUnVaQlM0aE5GeFhIcDhp?=
 =?utf-8?B?ajFjSVQraHlvSnhGZUhqVklFRTRaaGUyVXNKdU04OG1paTFqVURjazloVk5D?=
 =?utf-8?B?aHVQek4zeFhLRnpJdHU4VktQNFVnUWZTSVR4WDFMMTdJWWdQbDU2aDFqdWhh?=
 =?utf-8?B?WFpGMzJsQk84a0FzTDlrQ1N5UzQyd0NFVlR3MGowemFRUSt5UHR3SzBkOFFB?=
 =?utf-8?B?QnFRUDFzcVVhcEVLekNwU3RLVDF3U2Ftd3BrWWpEbFNIZ0UzeGg1Snh0N2ZY?=
 =?utf-8?B?MkY1UGN5Nk50Ny93ZitGRnFtUkRxSkRIaGVhUE1ENm5RaFpCZngyVjlBWUxQ?=
 =?utf-8?B?TUtEWFdHenY4ZThEdHhCL0ZJMitVdkh2bUh6TlU1bUFCUlN1eWM5UUdzODB6?=
 =?utf-8?B?ZU5IVEx4dkpCeGdxdnY5YUFpMy9uV3pzM2ZsNW42VkZrOFlHb1NGVGV1UHRT?=
 =?utf-8?B?V1lkMkRacXRvMm1LRjJJYWlOaVBVeHJmMTZBbXNveXRadmE0WXEvdnlDNFB4?=
 =?utf-8?B?THFkVDJaa0VBSmhoLzJOOEZVZVE4K3hqNENWcFlTUS9keGRxWkxyQVhLam0y?=
 =?utf-8?B?OVZ2azMwbFpXSk9Rb2hTN3M2aEVpOEhOWlVZbzRMYWpnNkl6bGNIMTVVQ1Bu?=
 =?utf-8?B?TXdtYTd0eUFUeHE0OU1mODlaQVNheEt6emQvYTN2dEFadm9lM0JTV1dYUzJt?=
 =?utf-8?B?QXdCQWgxb1loaDZqTk43MFpNenJOMkp2WTBNdzhEbi9sbVMzYlR3MzZROTVj?=
 =?utf-8?B?UE5FZ3h6SDd6ODhidTJycmp1d0YydlNzMWU0K1A3cE05aVVmK2FMeEFpMnFF?=
 =?utf-8?B?RHVzdG5od01SUUgwNzJBeHluQmhqZ1R3TjlBYzVLLzhQUE9BWnNhMC9rbis1?=
 =?utf-8?B?aFFLcXlhZVpJUFBHUCtLd2N0MjZhaUpPMUIvL3ZMYk5rS215alBKQlZDK29E?=
 =?utf-8?B?TG9qelh3N3NuU3lpQkNHK3ZYcWNzNmRHcGVRK3pLTWJ6ekhCSHhjVFVRaXdX?=
 =?utf-8?Q?kbU8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d0d3f6-d83b-4d67-425c-08dcd6fc4920
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 09:37:02.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoiEDTnZJwcgPlv2zFFBLILFTblgzxdrfZkElv7Kr1N3KZajSdVEITi4tNJz8kLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4058
X-Proofpoint-ORIG-GUID: 7fYjQRwPZkDb8CsWitAYeZh8_RlM2IAg
X-Proofpoint-GUID: 7fYjQRwPZkDb8CsWitAYeZh8_RlM2IAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01

On 9/17/24 5:32 AM, Matthew Wilcox wrote:
> On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
>> I've got a bunch of assertions around incorrect folio->mapping and I'm
>> trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
>> on those, and our systems do run pretty short on ram, so it feels right
>> at least.  We'll see.
> 
> I've been running with some variant of this patch the whole way across
> the Atlantic, and not hit any problems.  But maybe with the right
> workload ...?
> 
> There are two things being tested here.  One is whether we have a
> cross-linked node (ie a node that's in two trees at the same time).
> The other is whether the slab allocator is giving us a node that already
> contains non-NULL entries.
> 
> If you could throw this on top of your kernel, we might stand a chance
> of catching the problem sooner.  If it is one of these problems and not
> something weirder.
> 

I was able to corrupt the xarray one time, hitting a crash during
unmount.  It wasn't the xfs filesystem I was actually hammering so I
guess that tells us something, but it was after ~3 hours of stress runs,
so not really useful.

I'll try with your patch as well.

-chris

