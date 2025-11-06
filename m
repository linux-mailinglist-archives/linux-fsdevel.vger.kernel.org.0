Return-Path: <linux-fsdevel+bounces-67331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82DC3BF2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F25E620FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6834029C;
	Thu,  6 Nov 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MvO4mbIt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CZmKDd7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D118158874;
	Thu,  6 Nov 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441136; cv=fail; b=lAh+QWEgNfaxj+Fs6h3Q3/yPQznDmV+zZDtSNa5QyYnjPUAHraHgr+i81LkhcVXEQfl7Q+HI190vwBaWiS8SeI+7VGEtTN9dsq+WfuejHcex6cpzQdj5mTEP8W4iJoNvgCdkWxa2WPzYjJIY+nacpGSDgrqBBHu6QZcjTui9wp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441136; c=relaxed/simple;
	bh=anZm7N35xvJhuGo9k+syvrWe3Fi+eayCjZssHFnk9/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNdz1dhAE8NFe5RBJ9EpdRswjG6WEono20wi37vX8YvhJfw5zbHw1L9Grv05HUEcUep7N3E1rOEA+l5JAx1wt3xKxocqzdgwh8F95fNyJ1/sI9/JL5QuBTKlE98XmNaBHjqu4g+uIGhUTViSZXNyM7JTsJ1F5G/MVnbKq5VmlJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MvO4mbIt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CZmKDd7q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Bl30f002469;
	Thu, 6 Nov 2025 14:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PKRz3rp5rZSKzM6o9e
	5Sj+JmtYSreneGcfoHOipR7k8=; b=MvO4mbIteaHy0N5uu1giDhGzUCz6SyJFlJ
	HWdG2SQ8YqPQZFenOUAaRVlaUZcwN7jz57Rqf5JaubOSbo0Bfblg+bmOjxdtpp6X
	OmwIy4Wp25l9E0pQx5JnIPQ01jp2UcaiwM0HvSw0RJQDAMVk5/y60BrsJioL3W9j
	LTHolo3Nc7+ONBDlPYLf4FRaVG7Rn8BeKAiQ5n7wp/cAbwTs68N9btWKPI0nwXOe
	0m0cZ08k2NPBerqDRAwjx+TZydSUfKkVPMHmB8X53gE/KItUL7CUS6rYJRljxiNi
	/2oxxdvRwVcChK7gXmJGl0WdSeSGXS0J0mFohFblNBty4lovkP1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqwa764-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:58:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EXKPO010908;
	Thu, 6 Nov 2025 14:58:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncgqea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5fVzMuu2qMJivjePuvlwi14iUPv5guJzkZr7r74l0sn1+mt4iE0sPk8o74o1mx2UwXfHwufRIOtYrW0qvMizm3yqXv133Z//vnj2FXS/pL8SoM6tkzxZBj1+bw9KM/Nxi8bf0qYVWvyrBTtDHv0yZCczzz8vRnNGG1DFdvcQW9aM/0gXn9ob8GrHtslhvXGjr+EYPcZsbF7BlxXURLCPNJ8gxTXWc73IQ/tpErveFZAiM15UNqtwNnTfW3Qswfu16bGk6nD7ag3iDH7nHXdP7x+VY8smaQLf4Yg2VQsCbykXuUC78F7O4VH5LS3UBzncEztca0mJsKMloI9GgHWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKRz3rp5rZSKzM6o9e5Sj+JmtYSreneGcfoHOipR7k8=;
 b=hvwQbZ1pq49P9+NvNfZk9xmgeXVhEWZON9fagJjSEE4umrXU19GQJ5iCrokUhkB3jV5GadRmpC7N3ChYQ95f9KRsmNqa4YzvKPKmx+oXT/Vied1FUFiMrGYQZ2YFux2vqFKNV5igvZW+KmcHmL1JQHh4OkDIGZZVPYvtozNvY0x/pTMD33e2znwJO0bMT3SU5yyfGBbSJd6YxaAxTEkAHIMDMJ5IyG1uDG86ai35CzoaILIUzfS8YkdAFpA0LW3UQcC6IVsibfLVX1LGxOeNBt+M+DhGoKc/BaQMviFzrnYDZP2lYxpAgYCr4ueU/HeTyiYZs2C3JLyK/RKprHnJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKRz3rp5rZSKzM6o9e5Sj+JmtYSreneGcfoHOipR7k8=;
 b=CZmKDd7qMS+njqOZWaysdWqDrEikniluA9zzM9T0VpfL7g6EgwnFNTgO0nIgH4x4I9/5iAVVdQPxhAiVkPgIX5hklkzr2/MTLdii1Y68/QawbOg3vQr7BY4eOPT2tUG7i2T4BKUJFht3wdiFZ3KaxNxLEeAsLVUYQDHUUru1OqE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5920.namprd10.prod.outlook.com (2603:10b6:8:af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Thu, 6 Nov 2025 14:58:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 14:58:26 +0000
Date: Thu, 6 Nov 2025 14:58:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <a32e718c-e3fc-4f9f-9cb5-3df539664743@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
 <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: b2320b23-ff59-4723-65db-08de1d44f058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SnDi3ol3cK0Vb6OqmgWyV69dIEh7WvmVzLyxA5IdUt/E4NM/GJ/Hn1+7xoT7?=
 =?us-ascii?Q?dVaSKh+e0/urk0Hw9oOy6c5Jgo4TdLn4r75RCeC42Nq8FM6k9ssr+pBzqoFJ?=
 =?us-ascii?Q?Fbcv/WUnfaBqBfwzv2wK0h8KSVjUkJqO7cxI+ZZmoM/gfqKztfUxCzJJbo6w?=
 =?us-ascii?Q?xIcs5RMWDhVjoEH+cq1lTpKQfE3WZlp5Z2feV9oy8NAhVwV8xjdit90A4dx+?=
 =?us-ascii?Q?DUXjdhqsIEmkcLB4e5D/JqesmEyN0z1C0FIYy4/8cuwLw/Oj3u7uYkVmH49t?=
 =?us-ascii?Q?LVnV2SWSJS1XHl7/rt9BmIH0M/SfU4bcZrQscNSUr5Ygp6KhX4O+4eibK1x6?=
 =?us-ascii?Q?+kZ/AqnOlK/LDP9mjdJKTox9hNBUMw90KxQgn0K6TfC5Sc3em/36E8fU2NVT?=
 =?us-ascii?Q?8pS4oXEwcyfptzG3sO1FX9HlAU8QLp2zBC/iyJ78J5Qx2gzoktHZP3/FiSV6?=
 =?us-ascii?Q?fKLAj/GdXVHUveWSCeio2Dj44yOK5VznXKtUFr5FCxe9S0bayFbLR+18qMUs?=
 =?us-ascii?Q?A0PEF4xI/TS044nzGL1RlOkaF00SUDxSKGJzcoTrD/A+r7/RAiDJ2bkRXeHU?=
 =?us-ascii?Q?XOgbBMazuI+x6Q9M8uOahD9mwJFC3Gfh9zLqR+h63X5So0w9PCYSM69kHnuu?=
 =?us-ascii?Q?H2PsteDeUrbDBJL6POQek662dzoW4sb8qbx5LJQQeL0O81BufYgT9jFrAJpU?=
 =?us-ascii?Q?9/2wBVj9TTDXcYGSxPt9WrBfXfprXkjW59WR/w+j47nzdNjf8haEjBpBi5/D?=
 =?us-ascii?Q?o//qZMck/mZoTi7kZNJD/InCvM/+1ue1xelYkjkqMG+IgTWkANs758iv8Trn?=
 =?us-ascii?Q?bcmMpCMys/EOkCeHU8ssFScq1E7UQlWHtRpHYmFwDfoONfDL2I+ipjrWky1N?=
 =?us-ascii?Q?upcaov0dE+MckaFLKcQnqVFqxWbEs3eTdB9HP40lUhjGSHQeWTW6YbJDuFgY?=
 =?us-ascii?Q?8V3qNspTYaPmHJVgojjtF6qvJA1yg8CCYWtJW8xgMN8rQIvH1PkW9b17d5pH?=
 =?us-ascii?Q?/E4C3/H/yDRZgRIDyFS0vJF+WvmwB4Rvq4MmFlmiIoa851AOtK1UbxWAGjMo?=
 =?us-ascii?Q?/GX2vIOwBkLhSiCusIUxwIj+Wg5Hzf0ISJseSLdLSWaKecekinnKMzWUaoTE?=
 =?us-ascii?Q?OMqIR2sWS9MUxqtYtv7WiQWwgMHeTJdXMq5QKn9pRUQxsOSlebr4FK5NhCRu?=
 =?us-ascii?Q?MjulVv7P9qIwaCZrw8xFJOwLjrjc+BcCEE7R7i69Q/yrnDuS0rBjt7YDSeKl?=
 =?us-ascii?Q?3ksBd9qUXMcEZOznbZjHlIXS7stYVJ0LhqRUO6MWzNwRZoJWY82lwzgz/iHo?=
 =?us-ascii?Q?JFwgLfRaDPiOsnx6/eMwAxb1emfN7keoeQjTKts74+pMuCm4BOWtaH8p5khq?=
 =?us-ascii?Q?9ld0LqfumP4Mh6Y7U/f0jVLtxILPlJ6ZQtE1IWUpL8rMnBgjdf26eo/154h8?=
 =?us-ascii?Q?sObTjvkcboR2LRBsNfoFUzGEjehOhjeH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmCO23fP2BvlZx0RqP5yf/ELWMJGuFWVT+FHPfgyEJfaa2A/OWUhrDKwnxYh?=
 =?us-ascii?Q?eB63glurTrhfVr88MndoyFl1UbS1OZ9A/UoClsBZOcaornTwVedBJ1IET0Ww?=
 =?us-ascii?Q?0LfOTu+toeE8m0LcdSJLnFQLx7ictUV24NNKI7X9cvQPioSroUhjyUI/FZAr?=
 =?us-ascii?Q?/f0CsXtG7WTfyqOPzEb/F4iq1UugVN+HRfyIHNusv2Om0wbrrB9pIhw1Z8Jr?=
 =?us-ascii?Q?9bWKYsBh3zbXaafhywsM9vn8o0kzwzLLg4qQBRMzIkrdpQku1ULTAzJVshV+?=
 =?us-ascii?Q?3NlffS5qy5HFGOUk5mcM9t/Eat3AiRwc+kx5MTawYNZKsh4PWu3KGNUOFDcs?=
 =?us-ascii?Q?nMDSghN2oQDgbqHPT8WkWt0g7OIj2HBTfyhaw8MSqvIWTJY09rIXN8uagR4g?=
 =?us-ascii?Q?ppxH6B4X6bdxasrLbr0FcAmWjOK4ozuJwh+WCPhqtIiEIlUn+9XBJV7GUZ/r?=
 =?us-ascii?Q?fgbceI+J2MyNAMvMibKi8LmGK0c+2YYEtAkCb3o6EiTHLwunplAxdU95fGMb?=
 =?us-ascii?Q?2ropb4PDqC0rq/85Vg/KQNq+SRGFFRYHThZegqt5Ky9aHp9/L9FqhyanOaip?=
 =?us-ascii?Q?/z8e80DNTOvKsIVCkeXwuEWDnrcNgFWX5e7GsF5hK2zLfZbe16ZoOBoD5/OK?=
 =?us-ascii?Q?PYHelbG/mvMJ9TXgTXHjvAMLy4wPnEOE2LwLz0Y0REPMR4kNU0oI2ywNN0C5?=
 =?us-ascii?Q?k1EkFp3B5HLFDi1JfejQdpyJXLmX+HLmi2+zLWVfj/Dpb44R/Onlwxn9DhIG?=
 =?us-ascii?Q?iTbwhrEWdNEKAiQgoY991wrHupZAnXcCseOiIvr+u62a0vdIUKIxD+KvDYyh?=
 =?us-ascii?Q?MhPAoukq8B5fPuoBO7lUeZzXzTSFxAJnhqlX9yoBu5tZ9Tpu0V2sDUrWNWkk?=
 =?us-ascii?Q?wu9QF4VCoNDdAIhC7yShXSMBqoIB0ykWXxftQx50vkTue7icxklGcEb0bVn6?=
 =?us-ascii?Q?OWe09KGep/6c6YVEOpUspKskNFbxvkm8I38MJc7wFdaDG+oYhOFo2h9qrvaX?=
 =?us-ascii?Q?kzjpTWTz/A8HIMvuhijtMTtclDEbf5oXllIjG9pWJB5yIjs/Xy7glMLwoWZ3?=
 =?us-ascii?Q?8LfrlSRPAJB8Ai3mufV1SOlfdbyhZwPc/RexiGWVkzpvIzNCVf9qw22R1hmI?=
 =?us-ascii?Q?41npphN7TXssZve2P8D32dDSGqGHFN6miHwdYJt2sdG+dme27UkfNSpttAT+?=
 =?us-ascii?Q?eMEKk/rPFLaITlsM6+aUWU1ZPuVa48Spe62SALsP4rRQ1UpQ3VBbbhrRE/xV?=
 =?us-ascii?Q?Jz6srIvpEbnvMfYr3D+JQTBdsSUqR8ToDMwQT2EMnoLWJStiGSeL9yjDYyvy?=
 =?us-ascii?Q?SfKOtlIUFh60Y7TjpqD6WPQsFS2g7TTvrUGVeE4H6Q9ibY/nUgnBOHH//Vs/?=
 =?us-ascii?Q?JfVA6h3Un/G9ltB5f6juodjqI+NhGxbeFIxtkDJf4rC1JL8N9yBfDY9o/X3N?=
 =?us-ascii?Q?XSQYEcI/nlNXASpQMrsZ9/CzwABqeTTlepazdv4D0ukptE/8dGM2k4q9JqDG?=
 =?us-ascii?Q?nvYM4MLpl+/Fpj4MCH6yIH5BrcE//BdiOADb43mhQ9xb7QTlg/MpYfQl9gXZ?=
 =?us-ascii?Q?DmKf+OgVgMqWS6nZBe6Ksr+R+UpCOv9W/eaTliTNvMiPDBXYBYmfncnSqxle?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ycOML2qyhsun8oZeiptclrJRUx2mSZZx3RtRgA0RrvtZxTJ8PcTzqBLlmwR5wRhDCkF91E0SJZdwF5QKUugg43sJi32Lt5TKzBGbpTaqOchgIaSH6OaN5MBp+BDxUrOvP0TBN5oCcd/aueBeFaIBDVVg7kbb9GdyD6Z+murUwy6qqIUiuSRJi9rp01gk8RsjXWOcOyOL24XFqrcs5ZXqRM6X/zftHgKg8hBCVwV92BLCt7yAbHhFCq8dh8SoA4rVyUPmnEe/Rnbvty6dSqYKA3mr15NN2JTEwCLb5rVfOaKxQt5C7NjR0qU9eAnuGpPNBx4TcB3TltPr6u6oC4NYXpZuDLzA0nxTT8iZ9YPouKKRvVVbD2yA8OEGORCGp8HcdJ84nNsvZ/sq220Qgx5LeAO/PCnK2JX0akHcPw46YRjPX6xUYKvwORgOD+hAfQyTnIVttgNRf57cQshkcxq7JTwqGLUISOZ/8v3s91WvMVG+k+WeEVvBxDlJloFTvsjNh/YYhf9en2q0/g7NJTahWf1dvVNvX9nt7Xtm3ZDUb1TEghRRxcHn0+pVv0+QUpXhprJzbmGUB8/KgPSNMaksyf/Cir/6BldTcC9Ufo3qSFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2320b23-ff59-4723-65db-08de1d44f058
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:58:26.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBM5Yqg6XevtueD5zmyTMGGSVv7aQzoeOkXiVO/plRK5NcTu7PwcQjBTck+FdaorlSjzaoR0X23KPk/u/3R+Nm2HGqsgqwaPFZ5fADLDmws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=916
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060119
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690cb79a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aW0p9SmapDEG4HrRwxUA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: D5W5KRgNUkqoSg6OahrveQfJeZeXfMh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX8OxihnpxYsB4
 4EQ4qZc/n5zViKEy31h8XIG72KpVoO8/aITA/oTseHwByZqYjOVtQ1LLpV2ituRw5q5YV1XFuq0
 WM+G3D5/2frMalP3m8vVv/Vk7n2MnXkTQGiQN/+X/+fPsAIjH8NVqCgkqtCtMwZbO8mUDtIgace
 s7C7tdwdvM5DCYvGUHAv4NJcR5tQvxau7SOni/d5Rt3rvSGMeEbq+0DVemdzCWKl/aQ597X0URB
 9OKmEr+b7FmdYNyGNGDdue6wInwt+WmYVjsREG6bPqr/aeHQ2oibBsMLYR/9EJpQEVLbWlT5J88
 Pm4Q7bKV7QNoGl1YWsxIAym2mxGx30SOBKJCPHVyh4jXfdEUanlxKCva3wIbsVYiXxGBbFQ+7gh
 Quxfj5jsYTtAq9aYkgqXeLfwR+F3zg==
X-Proofpoint-GUID: D5W5KRgNUkqoSg6OahrveQfJeZeXfMh-

On Thu, Nov 06, 2025 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> > >  Note that there is no guarantee that every flag and associated mnemonic will
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 8a9894aefbca..a420dcf9ffbb 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> > >  		[ilog2(VM_MAYSHARE)]	= "ms",
> > >  		[ilog2(VM_GROWSDOWN)]	= "gd",
> > >  		[ilog2(VM_PFNMAP)]	= "pf",
> > > +		[ilog2(VM_MAYBE_GUARD)]	= "gu",
> > >  		[ilog2(VM_LOCKED)]	= "lo",
> > >  		[ilog2(VM_IO)]		= "io",
> > >  		[ilog2(VM_SEQ_READ)]	= "sr",
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 6e5ca5287e21..2a5516bff75a 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
> > >  extern unsigned int kobjsize(const void *objp);
> > >  #endif
> > >
> > > +#define VM_MAYBE_GUARD_BIT 11
> > > +
> > >  /*
> > >   * vm_flags in vm_area_struct, see mm_types.h.
> > >   * When changing, update also include/trace/events/mmflags.h
> > > @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
> > >  #define VM_UFFD_MISSING	0
> > >  #endif /* CONFIG_MMU */
> > >  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> > > +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
> >
> > Don't we also need an adjustment on the rust side for this BIT()? Like we
> > for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").
>
> That's a bit unhelpful if rust can't cope with extremely basic assignments like
> that and we just have to know to add helpers :/
>
> We do BIT() stuff for e.g. VM_HIGH_ARCH_n, VM_UFFD_MINOR_BIT,
> VM_ALLOW_ANY_UNCACHED_BIT, VM_DROPPABLE_BIT and VM_SEALED_BIT too and no such
> helpers there, So not sure if this is required?
>
> Alice - why is it these 'non-trivial' defines were fine but VM_MERGEABLE was
> problematic? That seems strange.
>
> I see [0], so let me build rust here and see if it moans, if it moans I'll add
> it.

I built with CONFIG_RUST=y and everything compiles ok so seems rust is fine with
it?

Strange that we need it for some things but not others though?

