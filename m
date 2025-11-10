Return-Path: <linux-fsdevel+bounces-67729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69BC48603
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5613A751B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1772D8782;
	Mon, 10 Nov 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cf8gprpE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lVye0yZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB872D8362;
	Mon, 10 Nov 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796133; cv=fail; b=DgXgtwLXjzyjDe06OePAhSN+YHkWMQaXOku9oB+Wi6lJnI5vI0gfpi8viGDRjoe8qKju49Pz6cAMLPjEMpShPEpB6Z0lFXPVeefKW6BhodU2agu2VSnBIy4zC5hEcZNnkHd+oFVBvy3xnyxaql3Jq4BAZgRfjtP77lWNjY3b0eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796133; c=relaxed/simple;
	bh=dcIMeHfOi+NmaDjmDFdlK7RFRTYloIljaVo/eKadZgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UqZq3KNA0WdNzUTGC9BLkqjgTieUY2gpNpSlbQScZIMCV5GaFZVWrusimSNl0odqLhPnzShYLXOaCMR4kHdWQrocVgmrpgsEXoaWuOy+QR+vQE1T0wRwJMrv6lTAwtFeY3d6n6PPpRmX+oyFF9QXPBO4LqbGW2ir4K6KFZQBZXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cf8gprpE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lVye0yZv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHKQq7032420;
	Mon, 10 Nov 2025 17:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JrtdXx6/1wno+2gkrk
	RU4ta3j83QhbodkWj/iyI36fM=; b=cf8gprpE4Em1Bc2nVpI4tGA2YgUiNVLVDD
	Bo9K+t0LpcBPb94M7vnfrV9eH7ruXPGeQIijvKE49b43dFxqjjzDDXYog1lA0pZq
	vLG8YYsKnFXYYaiXWep4X/e54VYXZ8evB+yLkMjBBPYqwpUUG0tMbXLO4u4mgVm7
	iYVztIKwcHsSqPy1ny1g2uX0S86Xsg5rn4hd3IBNRUgn/KLMvTYnY3jmjnfHyAHC
	94q/oKHgjyOleBnRzuxsVWEp0JhVIaGwgrE1KY2HMY4tH2Pb+UP4+kREE07bXu81
	uv88Hye9/EoZusm/U+9TAN0oVJJGiQZOefIlaPlFfli6J8QWQ5fw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abks7g4v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:34:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAG8pX2007618;
	Mon, 10 Nov 2025 17:34:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8yd4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOrq6VZQ8fVOAWn8Crxxr6rT8ZUdSWrdkpV/vRn7JUG0n//D5j4+hP7FN0IWlYSgzTIgeZ9Ic/Ri8sQEkOogwJJo4f1E7+UmsJjPSgtcha/50DM+s5SV5wvwCMKxtV7pCfRN5ITTk06DjWutQzjY33V2I0Yn1eTrvQtA9T0JfwYk0xVbGwxcnMo0zLUrknwR/Rl/R47wxbCu2WyAlKMS2z8l1eVsmwKrQ2oWAdvijNepcWEzlCHrY2OWu/mN637mAfdBd6EIYFUseWisygsNRAXN8vldxwQRLzay+U3DKXgMeUmGVpW9gPq52907stQCV8NP4bEnoUNzMxCyXkA97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrtdXx6/1wno+2gkrkRU4ta3j83QhbodkWj/iyI36fM=;
 b=NW918Bvn+yPiGfAOawvrI/vQs8bB0NS/lDeFcDGaL5tBAYbRiFvapFbsdHGDPnztr1OVmO7oQ5i0LJfjZjjATzf8ZLUndNNVc1cjVAB4lsiiI/DL1U0CPGgkd+2ku+GL6Ntb7i2kGx+MLscTRzYFZc0129U2CaQ0cY277/qh34aQylLLGT+Z+cgkPNuqO0LCF+GxFHLdvHDpq5LwLx9AjVQiZYb2yh8M/Z6o4dQjjyrcbbvIqsSInIjwEbQ87C/9W6FtF1G+eIEaYSCHFQ3EVfqPglk6L2K3Mz/QRy3DU0uM2+WmXkqw7KWYkhyPkaPbJmQk44HV04E9X4Nad56jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrtdXx6/1wno+2gkrkRU4ta3j83QhbodkWj/iyI36fM=;
 b=lVye0yZvrYIwYBU4+PhQKbUmuIdRICDD+sfi4/1VjjTZ2I1io+i0spqgedcfBEZG2WD7CSkFB8Hb2BlX+OHyZTc4cy5hIKy4bktGsrnC0vX78nsmREvdOTmXr/crxYyQYRc35tZAaxfktOVXZCpa9pTCCGTl56UbckZ6nJNaBPE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4474.namprd10.prod.outlook.com (2603:10b6:806:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:34:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:34:48 +0000
Date: Mon, 10 Nov 2025 17:34:46 +0000
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
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 2/8] mm: add atomic VMA flags and set VM_MAYBE_GUARD
 as such
Message-ID: <ae1708d9-4c68-4f57-b444-9d3b114e901c@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
 <945fbe45-1ee7-4108-b01a-a8d2b0bb9cfe@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945fbe45-1ee7-4108-b01a-a8d2b0bb9cfe@suse.cz>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 868ff4bf-9570-4e64-cc52-08de207f7287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vw+IUfep4zyAU7J5pBlEqFFp/UUASQdAQfrArtNTC1Ra2v/FY0sTrRS1yXzB?=
 =?us-ascii?Q?DA0U/rJVgSAFonoWnb7QUvfAWcRi6r5+atUTkaEM8jcEWf/lbXmC40sdIJWF?=
 =?us-ascii?Q?59nJV39aC+9MQqvgkETINCB3RIbgIXWsaUeoLSJlJbUAkajs0CctW86jLhg5?=
 =?us-ascii?Q?qGuqIAE5WoOfUthA6BV+2ysZSj4DbllMzj+YXtmI0dJheze70Jo8WKTgUbJ6?=
 =?us-ascii?Q?5gjsfrqyW8ouIFQfj32Om18xYXuVi974c3JMEIId6OTw7AbPNBKTp++ua3T6?=
 =?us-ascii?Q?tDEN/g6Pf1cY5041nb7dw+rcbXrMUc6JjilIhXi78J3FYF3b0QSFVvU9kJv/?=
 =?us-ascii?Q?bQMdEnx/1gdwDSTsW2NkzK36mogmozFKIAXTzS2roFKFo5wdL0ckxgf/RY1J?=
 =?us-ascii?Q?4JqULtCKNGku5R6Agx6jGedZU7poKbISnkE3qFFXGMTqmzEwnh6K64+i9kxQ?=
 =?us-ascii?Q?oklu+E+8MNq68+78yt3RHzhBh+UK73HSGeFvrR5t3ZP091N6VwEtDzK14h3h?=
 =?us-ascii?Q?Tk1ClElY/wqIDvwPFMst3ii7x6C9C+fEzwyA/db3uFKj64/MVxXhKmXWdam0?=
 =?us-ascii?Q?JcsRUCDN5Pobg3bEGT6lnlFXFcvbAx7EDlgLVTQZjQJ293tLYWyhUZiIdhrr?=
 =?us-ascii?Q?0ZZRhsqOuAyA2Hw6bjuCJt4UkqENjLqlJvnGMdUVwITz7fZlkjLjHiDtV8ur?=
 =?us-ascii?Q?Ve0Zh95ETajtn0bJ/RmaN5rgmMjUreWjmL7f0zlIXjeYiqTXj7G+47mTUPpf?=
 =?us-ascii?Q?QhqREevc8rIyf6E44l11yX77LM/V44o+t1NmYf+evL4/xjamS7PTl+F+URqx?=
 =?us-ascii?Q?eChWpCWoOGwxFj12g2Eq3eHcLWVvHJMiWqTwt5CM0g1mT0FcLiEjCW0XwFwB?=
 =?us-ascii?Q?KTEVR3V3f57QdvFNU+5MphyF1s3FHhwe0ExisTqwh1Q2EAnGbTQx5j8kbbCu?=
 =?us-ascii?Q?f0Hk5oOHMgFn5G8YR9xcX9LTOPnkG7NIY3ZL48JG0mJ+RQm3xREfHItgB4eA?=
 =?us-ascii?Q?P2NVf3LLxXfQppdorOkofZrp3DsS+Qim+GalP33DjKRFCP/isoCcRtrcxM6c?=
 =?us-ascii?Q?cfgDMqWiNeEMAeFpAFfwOcj4aB+iDeM/ENeaLToRA6wOSmhiWEmU2DCsO+O8?=
 =?us-ascii?Q?izYmGbequJ04yhECPQbaaEPgyY+GB2U/bwH8cwwp8JqnCSsx2/DhJF75ovw1?=
 =?us-ascii?Q?0UJdEiWVJH4NvEh8wZBZKSpW/KQh7jkF+4CIsDSw2D9susFFjCKNg/QmhY7I?=
 =?us-ascii?Q?uh+qsZvEyAmtJ4I4flYgCRz0p+/xb2STVuuQN16A6+RRQGvx9zAlRfagbrza?=
 =?us-ascii?Q?9fNY9QKQZmbET1Gx/CwPdxw+hJZJ0U8Abx0rQ1mm9A7ynuwumEqC8upkxcW9?=
 =?us-ascii?Q?ULsn46PxC+Q0rU41kDFjBejOl08PwUWFD7s8ggP1zcRAVObBlRXu2l3cHNqh?=
 =?us-ascii?Q?3fufqPdOAP/snf4PFQT4SI9PelYhInkO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UX5utoXDA81q37E0uUcyzB6oc0P8p4OykzCS5C1Pto20H3rct5bnZlYmQ916?=
 =?us-ascii?Q?+KJkb/CjupW9aM4w3e8wHnNfNxz/dElNEvvjDHF596gUnVoDj6te/8CisDhc?=
 =?us-ascii?Q?CjVVoXZtAJA1glzm3h/3jnR2Q3V07geYzMxHk/skT/KdJC5jOcNWTbDW/TTF?=
 =?us-ascii?Q?670MFuHulP3NTnOrpI3YBtMh299v9xWnIQz/I6bqQoc0gPfe7v0/J5+QSg84?=
 =?us-ascii?Q?GEP4tAn6mYgSrfKFm8Ecv35iKzQw0Kx6nmyzBFEBsa7vSIObvpN/Dc0oy80a?=
 =?us-ascii?Q?OG88KeMdfmpLAUA65aaTtRuONlwvEjOCblEB+FAcB77iROZsjUpLwmGwI/6e?=
 =?us-ascii?Q?7cG2CqMraKBqTXNMQ99wI0c5yT7cTHwHmB6RkLXr8u9+4kaBgPY8XTH+ZBDH?=
 =?us-ascii?Q?uHo/tWyrEF1wiOP9QAnc9y51jkp347Hi5Vw45gPILwSSUoCZO1pfIzaa8U7I?=
 =?us-ascii?Q?O3XZ+HRCZL3v6zE0gP6hbXxSXk33/d+7uJog69d/TdY2j/hsF1WIInsfV0yw?=
 =?us-ascii?Q?6cZkJt2g39TtwxxVcSF35Wgd7vul1FtmWfvNgd9aX3g11dNPmUNNqmu+uxYm?=
 =?us-ascii?Q?0JGJNSK9WfC81HxMjYCvkrzLS0/boG6OYHb8P73qhRu0blDHMqeywI3ot45p?=
 =?us-ascii?Q?dEE16+jU7ZoRjV0RJhOrN+jlxsEq64VnMXO6h5MV0MPcN8WsJOaiYMc3vhIS?=
 =?us-ascii?Q?+IcwEK9NMaN1lAgZIUxZjSRgaI7Pw08z5obsuoVsufCFqQ8QcPSOTeZctIFs?=
 =?us-ascii?Q?ssvT1vCtP9CsV/YF8ZXFe0Ji0Sk7h4tiFE9lk3CXi20uuv4ktVLOw7G8QnRR?=
 =?us-ascii?Q?mtbIW4wPkTv0m36nz7bwipTLaTU97nTjZhViolnhq60BEAbNNMhzbffwg/3J?=
 =?us-ascii?Q?H1sX53JAwGMhZ6ZlQQbfa61lgmGviQNDzZkKEh9zY0ikQFYa5EhJaS7MyjMp?=
 =?us-ascii?Q?51DR94PHZudg0y0pMgm5Ho1NoxkOy4UCIOteS2+NRBSSwtoNcTzuFx02HboA?=
 =?us-ascii?Q?V/lu1F5MhwuM+7iCnQ9FKWe1E0DRRX2piNuxsHMdEyhxzB/FzVUqDo/h4tgl?=
 =?us-ascii?Q?Rsig7satnrt2YTCthGVEQ7wdx+bvb2MRG+h+E4H1yEx+iaTOqavfAjRJH0Qt?=
 =?us-ascii?Q?S5EUDwxl4VcMcI8tFD36E5wdvH+axXkMBwhV928Ei7febFw/SHVkIJPFs5wH?=
 =?us-ascii?Q?olJ00EV7h4aGpCHeuBcLhuZfuW1mbDZSRRkZfFoKm01JJxMqvG8YvwR0pC3D?=
 =?us-ascii?Q?rEyHzUxDqS4Qck+YkA9SSRwSXkMci99rZ+3RFjYjl0IuBHrWGDgIE+yvExfJ?=
 =?us-ascii?Q?tLZMxpGe8AI9sM6EhDG8OqtbjBYsuFvJSNwu+DK+G+t+4XPe+J/QMk5BvaoR?=
 =?us-ascii?Q?xzC/BEQpRbi5sZNORpaACPRRWsqdgpBEHhRDEqXMnaKoqIo4Ku3w7QOpeUVX?=
 =?us-ascii?Q?wF3+j39dn5K5AEFfaBeomczP2BmjaNYWJwobqyHXTlar5rhbwRIRKG7gKyMi?=
 =?us-ascii?Q?1FG9Tbb21VZXs7+CQxYMXVxg32jOPEZFPkqFP7sIVIkufCwdNrjTFH8VpWWU?=
 =?us-ascii?Q?YfAaGLz3k74HUs95qiie2g2gndJAMD8JJV+Aeq22xgattNAAEdJnxXyENncM?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	86gPTj7JWHCfCtK3C0wCRoAuuHXbwvNQFVM1+HOu19Okg91DjGmpBCtsBXFhzwNT8sX7MrZ75PN3Jm59ps5jIMbeGG3XbTQkVhliVLapUzTB3G6LC4UAUZOECDP65zgMahsWKNfaiBDD9MvLD7FXRyrdTs+zJu46r8zGGBBnkXEBQBP+08/HZ/AIGw+I7mVhJX1yUMTP94cTYmGu+62vXMB5hViwt+QgiRjNJhKHPBWpXY7iLGvvIrOaeQqXMJpntYsAtprD4UKNLHfFT2lYw6YbES715710DQLP5o8/q4NuncA1Ze3Diurbx3CXKAEdv9saJSoftWebahTmVUrlwPETblylOVYsFOov0tyddeeBj8eTPSju8N8Qu0LizRkkUZ7oTmVQ2p0WhWM2kNx3Q8Io7kugqh62U8msInmqMJRHPDYCxKVL7zfVhE2Xk5lSJY7HbR/N9kVK/X7RTF9Cm2Ie4kIiHCb/nlS3HdCYEG3CfKIsPgl6kjHqwNwrt+ubrRqJH8t9OrNiACBiRWfoZh74xrFb3jIzy/VIg+19N2MQJ6lRJoiypvz1JBgzTBaYGRdzxnjmYAq9tY8W7lN03breuR6HDiL11ypzpUVw5P4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868ff4bf-9570-4e64-cc52-08de207f7287
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:34:48.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXL3lQ66ygYH0C5P+n6smzTQdCLNAdxAYv5vohGL6LOyLbTIC0uiB2zQxWPTWESvUreUXPo9qjgPITb4TzG1WGW05C3WmbvqOTWzlYbie+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=945 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100149
X-Proofpoint-GUID: qtiXKSGnjnFiGVl7g7h0v-cD8Cy9AAaE
X-Authority-Analysis: v=2.4 cv=L7cQguT8 c=1 sm=1 tr=0 ts=6912223e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=CDf0Uh2iYi78AkWnwqEA:9 a=CjuIK1q_8ugA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MSBTYWx0ZWRfX8N5j6HuFtp/F
 MstzyM2ee/nr9Q8i631Ubzrt1U7lphKu5Gk/PMR2NVwx62Gxpvt2eDm8u55iDMQrklqiTAmyrj1
 0ZOb/RCl3xVBcdRQ7CM5pkxIKAdopWa5DlE6PxvAf+ZszEx/dZV9MrO+/hs9o+hOgeolExqZtmS
 3EqTpYr80fWz4YQ7FCGZ1UBYpI9D+p2t8TVBoP+0oUgrCMZhzgtlWyuwTIy9BwEA6oioTitSYpg
 ybZvM4Yt1r+cBplPG6ePjhfXGUK8wuQVMET5biTZ1jvp/3dC44nF6tphVZR6s/vcG7r3db1JuRk
 bTVMUDAbEMf6emXWx0HZPYbWleJw4/MeVF+Grv8SMKQ8K7pgosZC7tUgHhxMijCwRjLTDxGTCAL
 ZkxSidHjJ8ugQW4/X3wDYn+ASq4RVQ==
X-Proofpoint-ORIG-GUID: qtiXKSGnjnFiGVl7g7h0v-cD8Cy9AAaE

On Mon, Nov 10, 2025 at 04:51:27PM +0100, Vlastimil Babka wrote:
> On 11/7/25 17:11, Lorenzo Stoakes wrote:
> > This patch adds the ability to atomically set VMA flags with only the mmap
> > read/VMA read lock held.
> >
> > As this could be hugely problematic for VMA flags in general given that all
> > other accesses are non-atomic and serialised by the mmap/VMA locks, we
> > implement this with a strict allow-list - that is, only designated flags
> > are allowed to do this.
> >
> > We make VM_MAYBE_GUARD one of these flags.
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 2a5516bff75a..699566c21ff7 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -518,6 +518,9 @@ extern unsigned int kobjsize(const void *objp);
> >  /* This mask represents all the VMA flag bits used by mlock */
> >  #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
> >
> > +/* These flags can be updated atomically via VMA/mmap read lock. */
> > +#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
> > +
> >  /* Arch-specific flags to clear when updating VM flags on protection change */
> >  #ifndef VM_ARCH_CLEAR
> >  # define VM_ARCH_CLEAR	VM_NONE
> > @@ -860,6 +863,45 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
> >  	__vm_flags_mod(vma, set, clear);
> >  }
> >
> > +static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
> > +				       int bit)
> > +{
> > +	const vm_flags_t mask = BIT(bit);
> > +
> > +	/* Only specific flags are permitted */
> > +	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
> > + * valid flags are allowed to do this.
> > + */
> > +static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
> > +{
> > +	/* mmap read lock/VMA read lock must be held. */
> > +	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> > +		vma_assert_locked(vma);
> > +
> > +	if (__vma_flag_atomic_valid(vma, bit))
> > +		set_bit(bit, &vma->__vm_flags);
> > +}
> > +
> > +/*
> > + * Test for VMA flag atomically. Requires no locks. Only specific valid flags
> > + * are allowed to do this.
> > + *
> > + * This is necessarily racey, so callers must ensure that serialisation is
> > + * achieved through some other means, or that races are permissible.
> > + */
> > +static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
> > +{
> > +	if (__vma_flag_atomic_valid(vma, bit))
> > +		return test_bit(bit, &vma->__vm_flags);
> > +}
>
> Hm clang is unhappy here.
>
> ./include/linux/mm.h:932:1: error: non-void function does not return a value in all control paths [-Werror,-Wreturn-type]
>   932 | }
>       | ^
> 1 error generated.

Yeah fun that gcc doesn't highlight this, god knows why not.

I thought I had fixed this (I remember it coming up in testing) but clearly I
fixed at the wrong commit.

>
> I don't have CONFIG_WERROR enabled though, so not sure why it's not just a
> warning, as the function is unused until patch 5/8 which adds a "return
> false" here. So it's just a potential bisection annoyance with clang.
>
> Andrew could you move that hunk from to this patch? Thanks.

I don't think this is the right solution.

Let's just add a return false. Will send a fix-patch.

>
> > +
> >  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> >  {
> >  	vma->vm_ops = NULL;
>

Cheers, Lorenzo

