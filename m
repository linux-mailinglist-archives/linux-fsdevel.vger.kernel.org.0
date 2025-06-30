Return-Path: <linux-fsdevel+bounces-53238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AABAED1F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD6188E949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69240849;
	Mon, 30 Jun 2025 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OM65qMuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE914F70;
	Mon, 30 Jun 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751242866; cv=fail; b=I/d8z+XraRi0ZPswEjjKLA7LoeJmmEHe6heV4TGF6DVUlc4oDaB+rrvbrCeSR2GOm3tCjb+LPn2tnfX6pvDO79sGQxgRR8X9P+TVDytlu5HEyTFWdaoczRlveZedMAIL5Z9mRASVZqGzdPCVV2cgyfST4/iZi8cX3x3j6calAO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751242866; c=relaxed/simple;
	bh=s2flp4e7yWpSlRVPycmojWnPGEt7wWElLzgmZ2V5wgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NA1qfAdsKEaE7b6pfOUGxGI5ln2kIk3XHJ4p0GHyH+0D0GlpxUiU4B5k1WHOFOq3OwqRfH5r4xHrZtk0SdqVT6Tl+xchukC/3b8jGPp+6rSJ9tweNSYukl08xRxjDz+S6XmYddkRp0NpCqUouPD0QgQN/FmpZoB/A8L3XWUK1OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OM65qMuW; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvAm5YoEJsoD1bzK5A5XqFbjwJsuIhWJ6pAn8vVRY29Uaxk3yFtyYdHz564TZ5J/LXksolBEh4olQjGskvU0AWkob0JYd5sXhieAtBONG27Vs715ZFVI1yXVHR8Afr2FMkp5JAWVz2XHtvjj7helq9O92ssFyfIi9yYrzsmpQR8zMvTljkvtm9LYhhW+mWlIlt//JXb12CEj2IXCfjF84hSboEZnkj6Z8+JVMQr4XAmbAUxdqVARuauhN+1td5I52jw9ANSxdGlbJn91pgiOWnVsTR/jHH1K0/pJcLbGYkW9p5nNiTuWnRAE2qyNY3H9XYbowG0Hu3C4PyB2OquPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzf2Lm4xKI5Xj9lliHf2BeYd23lYDG8nXeZ35AIoxwI=;
 b=uRx434UNfCgLp3wkt7q7OovWwcuHn0CzEQxcj23EwVa/WdthZ3RvsoGeFSOyQgiGF2hml6WlYewf2Js5ykNke9BwXzkH6HS49pVz5xADly2gWmbxnZSzyAWS3ofSYwFMyXwF3kf/vWPLfQXEeEtb8+tfSaxnVe+RPrYNPBwkuwn/zCllCJWV85mFrr05/NTomIggObLe0b19YMbxRFs/AUzc9rDpZU6F5cGdW8nnFQ+eOdfXsxrmxy1jlCORGANKoBr3nox+fC/k05rsVPzsgF0AGJZcvUED4QIfx630cz4in6alCq9LkKBlUxRTrPSzWX0PHJlkbq+D4YLzqkPH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzf2Lm4xKI5Xj9lliHf2BeYd23lYDG8nXeZ35AIoxwI=;
 b=OM65qMuWcXUZCczER84UG5j4bVvIHV9tIDYUxvwTrlPJXRWO8GVravn8X7NHCRRcwqAn4FNQapSYGuuZDZfs5XbSZ2oRK6ZUarpvPntKGKtHUePyknsfwfkWHeIkj9kfh6y2l2LC1unt2wcEQADPz07Vbmwivx0WbdDmLOas7Na14EWV6+kkEGJt8D5YwUZLkoKZVr2ZRAM5yoBDk9CJ4FHTlwTH6yabjE03+z5UF4AMCbE044ZE6OHbHhCFvlMwYgs4IVUsyjuyP0OtfxaBcfgjdQe3EvckgTGONm39iJexGsHsROf/yaKT+ZlLh2uA+26aafszQNN0sCCxTSuFcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.26; Mon, 30 Jun 2025 00:21:01 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 00:21:01 +0000
Date: Mon, 30 Jun 2025 10:20:56 +1000
From: Alistair Popple <apopple@nvidia.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Message-ID: <nr4e7unt2dtfav5y5ckmsrehu37xejqonarlulzcn6mnhnnvxl@o3ppo34wqyyj>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
 <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
 <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
 <87h5zyrdl9.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5zyrdl9.fsf@DESKTOP-5N7EMDA>
X-ClientProxiedBy: SY5P282CA0107.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c06805-c5da-4b9f-3e94-08ddb76bfe14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tGkB5pPBfDTSMowYXOo7iBFahDs+higauIN4ue5k3cYyRm9UFWp65JKhnpRE?=
 =?us-ascii?Q?OKdNz8vgLC5z302bxI4ARpp2kcu/MGaTJX9+SbZyiKk4+9f761RXLjJd0X19?=
 =?us-ascii?Q?ZtM9/lIi783i/iUupQgmcHrwotHsNM4a02mNRb7NOuCf9+3HCpPaqOzQPWUY?=
 =?us-ascii?Q?w3PgXeI/PsGW2ehxwRXwEkU2CBN7N1vUxSoAX7ZfvzgBIaJ42MtqBF1u88fr?=
 =?us-ascii?Q?pA5PzdvsWq13So/Z3pOFPLLs4VSu9jkXzZpJ559rbr+LA4szU5D9L61pmRHZ?=
 =?us-ascii?Q?1VqWJb2OA75RL2hDs4vFxe24yvVnducLPTZ74NN4DQ6FHUfvL6USycaR5Czk?=
 =?us-ascii?Q?p3AawJxuGCHk/Mver8xx0qqE5qjZ/dvCdffUAn7MUevpyOxsU/S+rJrfh5p0?=
 =?us-ascii?Q?Um63vA0Cz8m2BRj79AiaTOWaMcWBVdzmKyepvCc3nvFiAUUYg39t8eUikz61?=
 =?us-ascii?Q?E0uz3s5MyHZCKkvCbpvWzNyoo9bO2+2LZmcZL203ifLYUT6awwDTVrPnoxgD?=
 =?us-ascii?Q?TeQHTKmEfJL3pPhvtuBcCQxBNpSR6/Qtp2k1JJJWQ+K21PvZou7BXG4annxZ?=
 =?us-ascii?Q?MvCyJcjaROwwzbOkJfgDFVUItx4F7XFtXZTZ01dtfn2Vr1vhHhfOjYIXjDVE?=
 =?us-ascii?Q?M3OJ4I7ES/yss8NVYWuBTTwzTb5BaMfE+xjATp2AuCHLLuDH18LgaJw0o3K/?=
 =?us-ascii?Q?h52uo1SA3md4+ba4rxZP9lbwS5dhVdjaBA7DXF5FW/81K24D4W0lJfM5alVa?=
 =?us-ascii?Q?rdLMEsVDxx6wiQZ4ItCNxq6Ha3a5czWBH4CBug0MIkJbfsXHxcbqs2iDqUsC?=
 =?us-ascii?Q?vjkXyGVMlCeU+9R68Pof0oG7a6sqLmBuiEuhuabdqw4diY+XAtdT15xRjIh/?=
 =?us-ascii?Q?s9opncv/7zOZ+gqdU+s8I+9s0D55Gpg2gaS326BSdqXTfmOFQAf8/D3+7eL4?=
 =?us-ascii?Q?qBAQqobTZxvyYNQBDixE/jxJheARBpIJcb4TI7ZtRwPy6XkJ3/fzaZGcHmfe?=
 =?us-ascii?Q?KBRoMWbCKYcRuNhcCjZDzUy0z+VCi7pi4nOzpvBHIlfLOEtoFo54++DxjOww?=
 =?us-ascii?Q?XnXqj7JuLXdnekkNhlfnmVR3BmBMgu28aMml6Tnv8/pro2qB804tAwMXworx?=
 =?us-ascii?Q?fMBemLDcEaNGo6tH7VTNN7BfIf0lpl0k+I6okCLxX0aQcYVkij70NsNWOqsD?=
 =?us-ascii?Q?1rT/toRd8n7N0f5HHP2JFEk8GYeeH1kzY5YomP8ViYRZXOKgS+gVUP+k5plK?=
 =?us-ascii?Q?wzgD/+e/lnhzKBMqm+qPuxIzGyja2mFQCvchVK5ibaUpC2Dpz2wiWKSTd/Vf?=
 =?us-ascii?Q?AwkTHT3KZ8vK8XZ5QQeRla8QZiUPxLHjuH/mpcyfUdlr3nDh8gh5akc+/VBZ?=
 =?us-ascii?Q?hh6jVSG6YeOq2Nz1MZtJLqupyWI2M2zTVWhObWu5xva+2dnIvT1WdE/TyOic?=
 =?us-ascii?Q?jKy967Yf4JI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8CNU/Y0LspYozL5gXKXTv32TtZXzQiqKVxUkVPDSkbl6iaLOSEwjWOeTnSS?=
 =?us-ascii?Q?1jlxzenB66hqiTdcyqjX9ksXCYD8EV90Ton7Hz0sSsUaUwb6h/5Gtrn/t5XF?=
 =?us-ascii?Q?heXrz1l8kQqwkj0Q2h8EUitf2mVskI9SO31DxjUybeiRh8BM4U97E4DKozJm?=
 =?us-ascii?Q?fS5IxNC0OWFjUHWv9vwI8HZSVatJ5POu65cox9Xwx2pZaWRHdrSkLnacP4x3?=
 =?us-ascii?Q?KLIRZ/l7RvRVXS8QBCAGHogoKEpXFojcwN5pk2BYxmj4HkAmGJvtcMQIQlft?=
 =?us-ascii?Q?sHM8ykHX6Br+eztGQMvy7h2E8pTrOBGgW0ZGG/B7gEs1hogWHrZ/HRTQc33V?=
 =?us-ascii?Q?F2uOn0svjdkBmlTsTJwNUpBXUOXYLG1F0LPbrdxW3BwBaIP6z6+BEzba2PB5?=
 =?us-ascii?Q?ucn0pO97XO68OQMJ8BQ3wYFrz4SRAQNsjWfbtltB+9YZfvlTaibbhtypEYc3?=
 =?us-ascii?Q?RTOAHaToktBSJfKl64kWbt+TC5f1sxx4/CgYUFuMAAtyRdJpe9cCfQXMIBPS?=
 =?us-ascii?Q?6Xoe8Zo8Z6K2icFaGJE17r6TWlHXeRBCoUH1XIU+UPtrldZakQK/04GpDQCF?=
 =?us-ascii?Q?AvC2A9s5xxXDu2YxOS3ZGhnbP8qdgG6c0MwWb+SRpjQqeuNS3hqZHcHZESQE?=
 =?us-ascii?Q?8sdIP0+kd1UXhHNeDHPWKEs4E5sJFcLDmLlu7aogPdovGIXybXScdwGYihSO?=
 =?us-ascii?Q?oXtTN8Wz+AIwf3CeQsD4lR+1DpFKKoXn0940HxYdPlOG9Es9cf3IWHYAK2nK?=
 =?us-ascii?Q?jwLkvW87QwEW056QJymny5LRTAkZ9U9YoSRddEg0yS7cNQP9+brG7uK00Qgt?=
 =?us-ascii?Q?nnn3qugz2zQfXIDuTgUHddY+4ZefCSFpHAMZIu57jYvfUIVBiRYDfkP/E1Q3?=
 =?us-ascii?Q?DuyrMRM45cpgbvg5lnmE6ebtiYbRj5IC9iQil+P+SngHE/y0qHC8OBGRIRao?=
 =?us-ascii?Q?RCJ0OdLzbF9aTv8Lxdd++EjeYce9qLU7gs9L1nq6KNtQOl9RXR4jfx3sezmR?=
 =?us-ascii?Q?FRA+giuF7W3S2IZD0whk72p8WHJGP0Uzfg/YGXvP7adp21suyeH4aiI8SaCx?=
 =?us-ascii?Q?ZYs+NVvPSuENbaJbhC5YXzRdK1C+Z1MszOskacT5PwwR6uDe7Fxs/JqdN/IL?=
 =?us-ascii?Q?ulGL5sBvRhdJ5gJk1o1t4CM9BVAvaL4yhIWqMLwEOf2l6VjmM1gEotUJWi6K?=
 =?us-ascii?Q?RQZc+b1gx01GUiwPWTgZw4bUbtPxLBmgBA+i9t4P6HhGdOlmMdP8SwQ9BfZ1?=
 =?us-ascii?Q?2hokLXOEWs1Y5Po4n7wKYwNGWhMApK0cWC3zdihjmHpe/SnWGfw5ldjVWeLf?=
 =?us-ascii?Q?c1pAPmolrxzVbdJPOXWM9qad19dVBeLeC9Z66RYfHjSx9smtuQlBUHqlHYLL?=
 =?us-ascii?Q?tDLkXbSxo6qjHSETxyp3Uf1QB+Fw+k23M5YQVULyLHFnPz7CbqCnf63E6XI5?=
 =?us-ascii?Q?5Essq3OzCr666rsjW7jHxFXbDMABUXdUdBE7yUNfR/49T1VOC7c6VoKFJELU?=
 =?us-ascii?Q?+U3wHlkm4Ff35NYHtnTL88obsgVJRhBVAWKXQjJReEjG70SZiDK+18t0ACU9?=
 =?us-ascii?Q?6d/PsQraBpvPjMizXFIp9OsaGTh2w2PR+7HVo+GU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c06805-c5da-4b9f-3e94-08ddb76bfe14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 00:21:01.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9WRceA1If6mAdot4PJgEsXWAO9OckOkGq+mToyjOaIeT4CH1RFadYsK3i0GB8Y6SoriD5Z530Qvq84nBVx1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899

On Sun, Jun 29, 2025 at 07:28:50PM +0800, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > On 18.06.25 20:48, Zi Yan wrote:
> >> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
> >> 
> >>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
> >>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> >>>>
> >>>>> ... and start moving back to per-page things that will absolutely not be
> >>>>> folio things in the future. Add documentation and a comment that the
> >>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
> >>>>>
> >>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
> >>>>> it gracefully (relevant with further changes), and convert a
> >>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
> >>>>
> >>>> The reason is that there is no upstream code, which use movable_ops for
> >>>> folios? Is there any fundamental reason preventing movable_ops from
> >>>> being used on folios?
> >>>
> >>> folios either belong to a filesystem or they are anonymous memory, and
> >>> so either the filesystem knows how to migrate them (through its a_ops)
> >>> or the migration code knows how to handle anon folios directly.
> >
> > Right, migration of folios will be handled by migration core.
> >
> >> for device private pages, to support migrating >0 order anon or fs
> >> folios
> >> to device, how should we represent them for devices? if you think folio is
> >> only for anon and fs.
> >
> > I assume they are proper folios, so yes. Just like they are handled
> > today (-> folios)

Yes, they should be proper folios.

> > I was asking a related question at LSF/MM in Alistair's session: are
> > we sure these things will be folios even before they are assigned to a
> > filesystem? I recall the answer was "yes".
> >
> > So we don't (and will not) support movable_ops for folios.
> 
> Is it possible to use some device specific callbacks (DMA?) to copy
> from/to the device private folios (or pages) to/from the normal
> file/anon folios in the future?

I guess we could put such callbacks on the folio->pgmap, but I'm not sure why
we would want to. Currently all migration to/from device private (or coherent)
folios is managed by the device, which is one of the features of ZONE_DEVICE.
Did you have some particular reason/idea for why we might want to do this?

> ---
> Best Regards,
> Huang, Ying

