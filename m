Return-Path: <linux-fsdevel+bounces-71619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D4CCA55C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980943026AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BB30BF67;
	Thu, 18 Dec 2025 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9zORFD2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Crr/fe4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F224466D;
	Thu, 18 Dec 2025 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035710; cv=fail; b=K73DlZwwxbTjbk61bmYhS1X7gPNa8Dyp5wyBpSaZ4lcgj3ywP8QI5AUOjRhyvJXm3scLc+7bgeHLqf3yCYNu5hOCVoh3scCzO5BgjFI8ijPMXCzrQ4NdVNbY93p2wf0b3KhMeBe55HxmivJi95tg1Kcbf6F6LH7ekQz6vFa5hw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035710; c=relaxed/simple;
	bh=CZK+eqKYSokGK7hQCdf5CWnCfDtYKisWe1I4VxmFZRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jcWFtxdTUTh913G63nSqifscAUI8PlcRO4Pm4jcxCWHDv8gwEcTZG2v0EdflVdWdAhZq7wooF/QccCypyGXHvxv8z7IWsLgSuktas0hRDWOhteRmYT9sqKjZ6/g4P9g5fZVDCuRQBiGzR1n7Um47z8oeBFoZwPZdqa6+IYTD7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9zORFD2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Crr/fe4M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1gpfV412467;
	Thu, 18 Dec 2025 05:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cMlhR45QeBoQbuO/vA
	15+h0KMVa2pxs0X4cI7g93v+g=; b=V9zORFD2BWLNPLQHV7td1ZcrThyDaFBUGV
	4PqQ8BQORz30s2DYPrtM425yrZwA/i9VsYTo0sTLowfEx0LSCtAGD2lOYaJO+epy
	Xisvw9fRvQcaimSO3gPsaugU2h/wC5JsSFJuCw6qhbd9XhGxu0mw/7JdpRtZ7A6y
	+UxDb8lXmhXIn4cdgnJOY+uRWKI0ilA4daLjIzc34fvlJtTe/FS7u5P0rKxpTMAU
	pEAcyLzyNON7nKqjhkFrlcvsUiJiUPTnmLKYYl+0VVS04UOCJSztIupSaF6QN0Ga
	pvxrOJA9gcVDaW8Rg+Y83OACxFsdNnpdK5qmJ6bBjB72JQFrp2zA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015y7bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 05:26:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI3hPVI022456;
	Thu, 18 Dec 2025 05:26:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xknfjet-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 05:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvZXCPCu9vsJnJHkwZtY9RO9LoQ97plw6IMTQyryL2YfrZ7PYD/wAzKZRhqmhJTCUeBY9lHCOnWGc2XcjfMJR+gaWo/bk+SyuT7F2lg0kFU6nITSNeAFx+cAzzbh2fLqAQZfwRDJZgtJlknbGSCZ2adOX233N/IWoknVwJ9jnJKXB9f6dHZiGbB3gexaqCdVh6iwuXhulxT3wx2g5hpJcpairxVGXGurSo5kTz3s/J/HTtLL5uNXbUIRC9GWBp6sYumj3ViARgVbrB1zgG957XPOvxTAojcQgQetyq1Z6Hl60zXN14wtjlDrdZqofHVu3axfJTo9P1cG/A07BcJTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMlhR45QeBoQbuO/vA15+h0KMVa2pxs0X4cI7g93v+g=;
 b=JMC937Y/auE8z0ETrdgRE2uOebjANwRStsjssuCeeDedNEKHciY4Mj3bLKAHBVHS2i525grjw8OPWdx4I4S8jxJ/vwWMHl5jMdlfrccfn1me7oSIlD7hR/1gXkawtxghpL7laCgE7H6kPKRErhMOrghR5C/Icgb7MllVl/Nb8rVipogGLtL+DsHcHLfDMm8KBlteJ/MZ9AfZJXt50rZJgh5wMQjMCG3mxF43kw7LCMbRHrPvCPrdbzv8LtBkF1jWuuF1+jwW1XwP6eF39VTIj1zE4avbACh1wWf8fWYF+heTM7cJTfTgUmaTB0+MciptQHszrCDE8luzLpMh6/xF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMlhR45QeBoQbuO/vA15+h0KMVa2pxs0X4cI7g93v+g=;
 b=Crr/fe4MJLj320jtGxHHJrBvIc5ShWiTIrQBhzFhqjRphmWsd6iVxlyFXhfZy7Hj824FcZ2f+9yDEOc2MOBYtHBXDK7OaFN6gtLAalXp6EfHXCtXe59nwYE7UwqmvNtP0nTaetE78GGhEKP3LRjs6PsGxH/VAszUSuZYSWRNvVQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 05:26:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 05:26:37 +0000
Date: Thu, 18 Dec 2025 14:26:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
        Linux Media <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
        Linux Virtualization <virtualization@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Network Bridge <bridge@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthew Brost <matthew.brost@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Stanner <phasta@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Cruise Hung <Cruise.Hung@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>,
        Dominik Kaszewski <dominik.kaszewski@amd.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Max Kellermann <max.kellermann@ionos.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Vitaly Wool <vitaly.wool@konsulko.se>,
        Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>,
        Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
        Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Mao Zhu <zhumao001@208suo.com>, Shaomin Deng <dengshaomin@cdjrlc.com>,
        Charles Han <hanchunchao@inspur.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
        George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 02/14] mm: Describe @flags parameter in
 memalloc_flags_save()
Message-ID: <aUOQehpfZsgGrb36@hyeyoo>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-3-bagasdotme@gmail.com>
X-ClientProxiedBy: SL2P216CA0119.KORP216.PROD.OUTLOOK.COM (2603:1096:101::16)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 977d5c1c-3cb8-441a-71df-08de3df60433
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mtwrq6WwqPy4zabYRSQ3a25VDb7Cn6p80yheWxo05/7HNCHfsm179rJR/JBx?=
 =?us-ascii?Q?5arnCEYIGJRxIMmvKCAmWUpHP4NI7qkNx0ug+WIwLEIS1K5fKCoI1rQIFL64?=
 =?us-ascii?Q?3plBUA5Cgd0i6XNZfvP0CvVXjVX0NQetFcXq+Ego2lWOXtux0u1N4DroMbyN?=
 =?us-ascii?Q?oA3UoOMtW9CghlndOydcYjLVhn6nFgUtC3mHX3HzmWkYtjIltuHeAdUuMjFH?=
 =?us-ascii?Q?1EURgj0wPWQAKJzjhxdCizXAyKBqQVjjyEbNrQ7cMiucSQV3F2zIwClp6gty?=
 =?us-ascii?Q?UOujJRXEPNlau13De/MFQW9Xa/rYvEt2DAZAN1dDkCE39uTKnmaG0stDlUh/?=
 =?us-ascii?Q?D1f6neE8dYjQ7lNUWQGeyWcaGk0e+NrYHGViUK7ZbhxFw84/gWcNE7vMBAnH?=
 =?us-ascii?Q?Nb579HosuovsB94hlNm52eVqjJYr2HrmmlcqsKeblW/XyAwEcCV7cIX73teN?=
 =?us-ascii?Q?d7S7/NaQlncsmt7RcAZ1AkZefCKc7puJqroQj9hC/BcqD3QQAJQ2F5yj/2HV?=
 =?us-ascii?Q?PMhtS8vfWQgnUHMC3U+PWhsEjZANc/oFy40mNIaUDqC9AGpRuzycA44EQSKZ?=
 =?us-ascii?Q?0i7wXbpYkWu8dxuO9ilWCOB/anWtqcEQ6GW3E1Ofq1uu/5tEgePAIk3sFfj2?=
 =?us-ascii?Q?8vnoqywPUmo2GUbv96NLTKqlRqcVjRIzvT6bOkZ2l9rbezjPfPUOI+rPwWV+?=
 =?us-ascii?Q?f2IbPCYtVUIgHpF/KZ0lqUyHQp6AVQ7ZtAOpu7MBUuj0jrcnYyoUJJlcmdNK?=
 =?us-ascii?Q?TuyKR2T0VA6TIiSo0xzwlGBNzExRv+tLUVHnpdBpgPxJpbM/wIGOOTqeLEqh?=
 =?us-ascii?Q?a0GgN+2rE1Ggj2OA+hB6YjGPYO3W2K53WRumLyAMr2C09btRwae1m/soFQt7?=
 =?us-ascii?Q?uRQslTabqKK/STOOcJ3ZB0f8F279jRPuI4pGdSOO+2P5ACCqYfu4UTQmfRfG?=
 =?us-ascii?Q?f73mu4jQ/0PPN1iOSp0WXSIQcEPotWI0aO43opa87ITm83CE6MxjH73tmRkl?=
 =?us-ascii?Q?Kp2CxX/u2Gp1P3pYdk1IMjivPETdYo4Xz3GJpa74EW+bZQAXkc13HvHN7z0C?=
 =?us-ascii?Q?qBVjiZv66/kB256W8/HaaT02LFr/4PNYM5/N7QNjx2CXZdcg5fMIw1P2vb+b?=
 =?us-ascii?Q?boYU5ijgMj5f5JCi+nU7qN1hnfDLHyitVhLrnfpJjE5H5Amm34ybnZyxPL1m?=
 =?us-ascii?Q?c+X96FjPeXJlQCzNQIKs3ULwrPyJa+q70+zaJ+LO6YDM4EUFCO+BT7qrU5Wb?=
 =?us-ascii?Q?KRPFQ+zNO2v5UH/95lZb0RF/mnDJnMfyvYHPBMC2plSbNFr7y1ZIZsJ9FfTM?=
 =?us-ascii?Q?ULwUjvx8in76g038AIrey2VMpfHD+1lsO8K7h+2pF5foNtdOii3ENPjKmnxW?=
 =?us-ascii?Q?e/5RtN/GBlN2mBmLQn8GIda1XnYHXcm3FuhxuAj5dgZYYvNEWHfwatZvnGDe?=
 =?us-ascii?Q?Y9RAeHBZXeNeoc0UISujjGZ5ay3uEph+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ANhtgV9ZS8R6UE3Np9rAs+NOrA8zYaFw8Eo5JKhPRLn3GdqCpXCzAQG19ORM?=
 =?us-ascii?Q?3XHo4HiYeuDRjurjZqqPk5MjOarwqxS5tvCpmZaHtYs+hX7mgE1b4t88N6D/?=
 =?us-ascii?Q?jj3m70BNCLpjClohKdDWnLV+STaGYxp/obxLy0g+mC7zaQZrdrfI1Zm7Esfg?=
 =?us-ascii?Q?gsSc+lGgRx/oHlxDECEmprfamK8h9ddN0qy67poyYevN7+5uhORcf/D2QJdk?=
 =?us-ascii?Q?6lmzX/BjBIQet1+pXRB9Km1HsaNwNIbtJD5lOUnlgMdYqm5k2Y+F+bg+USzo?=
 =?us-ascii?Q?UV0jhJHDuwGO4tesFUrvvjP8uRy6XOL6U9Blw5Y8vpsqTi0FAu9vAv9W5hKi?=
 =?us-ascii?Q?42KKn7xbJbp/URxLkKtxkdaVxP4DOeWSJ606snEnWTEX1FIZax9ELucDiBcY?=
 =?us-ascii?Q?KADN9zrJyDoYCG48UGhtGHn/23kgPD9jUiNbFcT9L5DsOFuAlVkzieZDDZeN?=
 =?us-ascii?Q?xHZ7N+O5wZMQjdEJF/662NIq4bYXucmkTKAQ4tiLXUVKHy1J+lTNOhD+/8Sz?=
 =?us-ascii?Q?B8tmvwWLC6K+TPAZmdnGXVXAH+UKQoy3LiCOwnUWd7NBsbfOu8HdTxZJclZd?=
 =?us-ascii?Q?NcV/1FEa0oYTDzr5XwM2dNku1g2w2Ss/BSgVSiSAUPxkjBycBT29Ed1HnQjC?=
 =?us-ascii?Q?j7JUgVoxmYZrsHjUWbsFBIC9nmJCpn72hYuqrHhpTQ+4GZIxSRVP8iDUjZLC?=
 =?us-ascii?Q?KwZ2jZOZAhQKXh15cN4eLci/Ha1JHxP5Kv0LCzxcXlXnZvi/ebtB9PzpWBZp?=
 =?us-ascii?Q?OZvz3D+BVMYyWKIaiCPMkaZ+v8+VwzmfqOiDe+lMU4Ho8z7AYz7WCFYqq6/i?=
 =?us-ascii?Q?ezqoiTVTQWwhD9YdwJB3pEww6T8WA+81gkwbLDHsiR0zd7XJQfdyUPbxeKzC?=
 =?us-ascii?Q?AJ8qeCLJ5NIEhZHECuRByU+O/kWFDnhsiI6YhmnlJpr6knu7waeo0ZxHnznd?=
 =?us-ascii?Q?IfpEp0ROjQPNjEPVazlubMs2SJp4dGyocS0VljABnCrdU5AocuKgQ0BEYctm?=
 =?us-ascii?Q?ZaOMQngQuHKAxktGqcNgAV5Umq0L+JgxgHQdtLQm54gJlz5GnXYF1bcwKUkg?=
 =?us-ascii?Q?H+1yQ2hawCphWsdR7NJW6FMMnmhy8ueVQh1R/RZ/D3mFOUPW9fYjVDUpPzbH?=
 =?us-ascii?Q?fFnr1hW6whjOcLPJXeil72NWrmxNxbx/DioWQoexs70r4ugiDr7WjLz4Lgj1?=
 =?us-ascii?Q?loP20BGVojfTmAkcius/9FjxH4JpsrUKDhOVh+YTtaEqn3K+66vWrJ5ECQ6Y?=
 =?us-ascii?Q?7qrRwcfA7bl0DvcC927nujtxJEqoiMa2Fkb9bbSFD6ppWDhPxL/VEPqtmQq3?=
 =?us-ascii?Q?tScb/AK3eQbKm5rfPT9TygWWy8A/fYYcz9M3L8UvbqrRwrfyMrKQaC8mOIBc?=
 =?us-ascii?Q?YPaMlFECr5azApmdEaEyuVEZ/u70SaLtu4fWNocdPg5NsRJLUdMBys9BDwYu?=
 =?us-ascii?Q?SMyxgX/2vpKp7/IXtjVrwo9V12K4QhmtkRv4ZYke4tOMZ3WE8hpyNlKhlHpu?=
 =?us-ascii?Q?0phtAzQHIQNVFLw8ZRBXmHpDkJ0EpRt5/ZLM5+YcHoqHN71EWROjWOiVzgbU?=
 =?us-ascii?Q?McJX9xXlbAqWzYBgi+DG7HcrlrW+JhXPhZnMR5Y5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xkh5YRXzxBuiiqAMbJlqNQVfRPyNKZx03QP1ukKdSZX7aiF39+sRgEE9crLwcinFu/BrkW2ShMUBCAorcpJrq+ds36CrpMYLCCOKfbgklEQlsGl2+oNC0rrlsO/PbLp4DZy89Ou9Vmia6IMDn6GJQo3/9wn7Ckntx2SMbo3SHLAb8BZ1Uj+Wo2/1mBqX4gZdyM5g0mCfFFbTqvUxtXQRrdB+uC3y/dGxCO7mU57BmWeCRLAO03F6FKYosrY3Y/a3MMQykAMU6oqiOSQw0r8N65gT/gThUBTvmBZeVXpuf7YfyUhwhStTc5cVGGH5mLsES3UYs04F2PpNKS+Ekn4hEtyHCd2IyaQwvUpoxePYnJCeQsZPKIYwk0/U+6rFhg0Fyn2olU/q8EPxTeTIBzbyzr0hSSUwFPNB91WxnOi760+IvGJjChc1pOx0t1En6TEleRDxdvw34Yp47jdH3xh6aK/Fburb4WSJXYD1KMXAAx92ZqfL160pq0Sp1EgyRDd/SjKNxxUz9s5g4pl2YyoUbMYJB0NhxLPakprN+MWXJXGL9pPWoVp8KjKy9cgvipiz7wLuGjbWpPvjiJzO6MVbZz4IxhWVfmPvi9vfl26Op0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977d5c1c-3cb8-441a-71df-08de3df60433
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 05:26:37.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rzdVCYi6u7LDxqLMEnt2Nqex6N3+UcaXUlhRJTUKh/6GfCm/zYz29/aA7/5ifhIEjkTk4ONNkcm+9xjOpKhIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512180042
X-Proofpoint-GUID: BsTvM-f7QqL7auGcK7EFSmM8iqDzKyGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0MiBTYWx0ZWRfXxCNFXNXUPXWt
 Xory2CPVxZ6QUYTd9K7aFXVRW/frcaWXw8XaWC5E1rvYM2K7tlKLOBcFJCRHsZt5H1KXjplfVPf
 XB9shodHj/DByCh6VNo/JGeFulc3F+EH20zHP2wtwnE976cnz/y/yCLApPyqCvEW5o4reD+gHjY
 I1VUR8szKghn/3AFIJend4ltmMLoFl2ZekOhEpiXaQ3tISMS1TfOb2UCw1VFwL+QDfe3ZFMDOMA
 twqoH5hNIBJTweWxl2VTbQB73otdcWvV9+y3nuS01EjtE/u8DhTDdtpELZ+Vvxc5T/DT9McSwXu
 ENo1GFYBgdGzK5AgC4HupxHcxEWGGBZ9v9hK10s1EHYxOHMWxiFIRTOmYogvfgdYtrR523eT4MD
 v0p/6YKtGF6h7c2eRxfYyI1FBm9Vc+Mw4IPtr4lY2vO9TgWLYTM=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69439093 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Z-cONpKXGyXygPhPFqMA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: BsTvM-f7QqL7auGcK7EFSmM8iqDzKyGz

On Mon, Dec 15, 2025 at 06:38:50PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./include/linux/sched/mm.h:332 function parameter 'flags' not described in 'memalloc_flags_save'
> 
> Describe @flags to fix it.
> 
> Fixes: 3f6d5e6a468d02 ("mm: introduce memalloc_flags_{save,restore}")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

