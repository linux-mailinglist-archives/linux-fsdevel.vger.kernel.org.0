Return-Path: <linux-fsdevel+bounces-49453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8AABC7AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E77A373F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8420F08E;
	Mon, 19 May 2025 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NEIwsY2I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BZHcqpG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AEF69D2B;
	Mon, 19 May 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682353; cv=fail; b=LLJi0vLVjpsIZd6brWiV9gjE1qtovBv/8TgajKxlF0ozYyDkg9PMvOs+LTYIw4iWe8OrMaDIPARaZJUqPr1H/whHQjn2YP9FCCKXE/YikS+nh2ixEi2Di8UZmnw+IUXauxjyU9P2FXGxmrM5/BVnzwZhAKxOf+dPenbQh1niu0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682353; c=relaxed/simple;
	bh=gGMmnax90p51kjFd34zVgiUTc00c6+52JXymo2xPfNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJNmOKpfy4Gf985+rTrGOdtJMHpsfyuhB73xYFTNf0j5V9zcmSGo+LmIqHXzwHabvnN3vzQO1cCdykgutwu7YLDLXob/mt4kKgd5P9SgH5zsEjkRoDmFaHj/R3YbTItadaYf8xBpxR2Solx0avAFYmX94OwNZTRXibCuywbu9dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NEIwsY2I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BZHcqpG9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMpQt009118;
	Mon, 19 May 2025 19:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jmvHARzPktmkRMHfA8
	tSOt5IHGL3U8yXyhThH6z9a/w=; b=NEIwsY2I2A4PmascfyegarcjYBXXUCSaIQ
	m+Vmo8YzcpTxRofD06F8+vw49VatLV0DNEjjLDVyBNkyqhVVy71JfK+kbvPgODfB
	1fYqrhSTE7iUvDmd2Q1jJE4xeJuKE646KV8+uUi2EeI0m5GpcvnJZM41NU+T51JT
	FOrfv4sTf6rrHUZ3N2/88bRhQSkRdxTurCU+oqwcyiESidZ4uYFUvTrjvSSkv/8c
	yRCr7TrLMLhFJLtEVCL2c2BmU3vXqEUIf5yg18hFGyem3BaeG2Fee1G90e48Rtq4
	bv7PAsbPhIkoxlcNBhUh3cJbJ9mUOxzwaQQR8qKNSxiOmPB0KsuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vuru8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIxkNl002449;
	Mon, 19 May 2025 19:18:53 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6utmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G90ppTDvItnEH1X1nOPu6/pwiTzhPdiiQpGdKXSH0zckoGUdRpgN9XJ0P9+KGJCg3py9KU5uRTHctPFqKgU62NdIiGk/In1JuzUCFLjAjellXL/u/x0gKkat3EzaxBW18FcJlXRx50KOkfclwv91j+qeZeLfNyhQWZMiVG0l7M7VGAoEiNoDRi8xwtHP+od++YXXPcFJdmfrHjNIU2SbqcYO0PRYEU8fErjMZBsHGL9Xa5QwZq4nPje63KBwge6UZ94pCA+Y33YaPXpKBLPOwQLWwZDlgY+vvonhBm3LQyTDsX+5/P3BSn1cedSLLkAn33kRfNS8tAlQdG79Tc7Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmvHARzPktmkRMHfA8tSOt5IHGL3U8yXyhThH6z9a/w=;
 b=T3Xp+VH7HnQRIe+XlFvIp8EcBKEvopR2ofsZjePp+4K9TAr5CUi5bICxSDt2AiMxDSDNqAJ+qzqHhXDHcau82bOE96LuHvT266S/efBHuBapH2/rJ37HmdQZ570l5oLW8yPOubRpTkUmn1t/saD/snKrZEaJXos2Vj3rBUaWWlfq6VqmeBwyR3TbiQbs7kLVw1SesE3j8QmlIl9oxazawqLjeBdUdclDpM5QTGvTx5r6jgcu2wCVauRsAuvjwYv9nmdrcgzhRr4sL73o0r8eoBpSW8yJV86yD2PeKStNsS9mC4MaNN5RIuNrE3AH5IeS58lYewxwIKiW4/0mYPWpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmvHARzPktmkRMHfA8tSOt5IHGL3U8yXyhThH6z9a/w=;
 b=BZHcqpG9SplbQOr66/0/OOVNOVoEs3e24tRREbZziUw1V/9Pst16wVB8EIkS/zbkWTul09T1j2J7Peg5jFMrhNYa8Azr7HEWyYsEzmPG1YUx+lvCMrUlTRY9rvXg2IakUWtpTvlmbYDdJzh3G9Qyx3V2PdpFFs9LoE6VJAuvc2g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 19:18:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:18:51 +0000
Date: Mon, 19 May 2025 20:18:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <8a558ed8-0db0-4350-adb2-f2baa9d4c2bd@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
 <e2910260-8deb-44ce-b6c9-376b4917ecea@redhat.com>
 <fed73be7-6f34-48b9-a9c9-2fe5ad46f5ba@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed73be7-6f34-48b9-a9c9-2fe5ad46f5ba@lucifer.local>
X-ClientProxiedBy: LNXP265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b479fac-ce74-4787-991d-08dd9709fcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ret5uvFgQ7xDqxTC9+GlCFAS4exyyRA8jcK59uMSqQYYERu/IUcgyttUBdyV?=
 =?us-ascii?Q?wrD0NRQPNaK3s0DvVnA+KalYWWLkOfcwm5le527qZEyWPpPHU0BejGi/lDX7?=
 =?us-ascii?Q?o5IbWD6TtG7qh8C8eWoDm6z+lxdhRlkxBpeC20qGzfPNc+50mc/3lzwLPYQw?=
 =?us-ascii?Q?zQCDbTa/wzGPi5GYxAFGRlCi8OgHRrKPCjaNybNwaLpy18jPA4yRAU9nXH5I?=
 =?us-ascii?Q?3c8uUDWZY2qNVlL6w6roC+Op02Y4tDtMgy8NDQ+J4QgqSqWYN1dTPZoOaO9U?=
 =?us-ascii?Q?UuK/8m2SDTZzGh1wudAM7r6FB0UR1E4wllKTPXR2NCfs+765MnZrg27Hknbi?=
 =?us-ascii?Q?g5GCtRDwXIKaR8A2k8cSPYEOWJXylYrlhUwrGKc++aHa5rh+VPcBxDOINCeT?=
 =?us-ascii?Q?ofpiMiViqoymCYArpG7wkjoZ/Tk+r0tIBK8jrd5WnHs7lQ+CdPIa1DGyn9f2?=
 =?us-ascii?Q?jA0IqRzgAha4GA7SkZt3Kw1tQ3+FRrsTc7klTj/vpfFgf4InF5m4AxmYs8dU?=
 =?us-ascii?Q?lJNOK9nhuxZyH7ea1hqEhX6Gn61tYs2x7aRFC8FfOZiUpNC6/QtNe+oZUfDc?=
 =?us-ascii?Q?8CcfmH3tnDCisnv6n3fv1ahhVyt8EduI4HeIYRZ/kcSzQGLie4J3sq8Gzf0G?=
 =?us-ascii?Q?z53M6r1+T0WHHZ+5Ntdr3ojWe7EfNO+THa2BTr6hOVNKImej68xKOzst8X+I?=
 =?us-ascii?Q?YNwpl5HvKWeZCqUGDvnyEByBxtqszldcxxD3HiWzjeuvb9nDUb6eZmC08Ite?=
 =?us-ascii?Q?9lp+V5nBQ+J8wbwh1aVukl0fUXgkxQz8OiA1cwBQUoAaIESJYD2snWKXEy5I?=
 =?us-ascii?Q?PyLwYAXYnBCISvRuMoRsHvvRKF7qSoxD+/lAsduA1Fby3qObwWv8OtcStjlR?=
 =?us-ascii?Q?VAecLSgkYPE0M3Ye89GxyJwaLYaitNlJsNf96Cj5M7XOb/XsJ+iWJ0q1GtgA?=
 =?us-ascii?Q?u+9jY/+UAn1ZVyvFShtm9GFvO91ZK3yqXPjnzrL+0FKQLfs8PTcgvsgPQOef?=
 =?us-ascii?Q?mQprjuJTjuTQqZbvyU/dJlCx7TDbTz2kvRaj1v70FGnn1BNUnZRnvxxZp9Pc?=
 =?us-ascii?Q?kcyFeLtvoXuCP0fL8cMUxABOXDvuwLLPDdZc0raZvDHNivA/Aw4mDM5FKcif?=
 =?us-ascii?Q?Y1vOXZyu3Kl7+5S4iAHsOvkThHPs2atS1J2mILQXBLQrr3rATxBIbZ/qIPSd?=
 =?us-ascii?Q?zo/c0QjCJOa7cHE5OthkKiVoGaIVn+Q5Wmksi2LAHzkcxV0Yx5MPN/GHDA2Q?=
 =?us-ascii?Q?N3oL1n8tprCIVbmoxyM2WiT6tv5L4zdXIZp+Ey4C9yPY332+nQJ3st/GuICh?=
 =?us-ascii?Q?NTMKWsw9YSCWFXLzCkh5wzQkft1YYwWaLzDtYrdPE3noXokFTdw9zul2MsgV?=
 =?us-ascii?Q?ULxegMNSviw0vJFyV5MjNCeDBTlaDGcbPxOnyKn/WEt5ERzTqMNm5xTH0PRF?=
 =?us-ascii?Q?z8GVAEIrzHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lmmYWDCW1tACZol5DY8Gw/p5b0RCVZXOqJVGl+DBP44jCHqzvZJIZn1t1mR?=
 =?us-ascii?Q?ntB2GInOmNJkratLSJ5cOM/NIwCzMcMrmUeMv8aLJllhazNEX7UrBYGL4oMw?=
 =?us-ascii?Q?NsGBEjlJh/pBzDUu+ms9CyM9vZz7BdDQmFGIOq11ewS/qkjyF2dnpNiSYS4y?=
 =?us-ascii?Q?PUnVosBsrPmIciFHCY5O3JHgE5cy/nM/T1LTf16JTgg3isNvjo/da2JUkTyf?=
 =?us-ascii?Q?ApkD6rUUnfap3e8YKBWn7+3h0rtg3criM+/Ftmrrr1I5eQdP3/cReJ/5MNpS?=
 =?us-ascii?Q?/V/8clPGQJ38aRnyrpoM+QF/6hRY/4gXSmOHKI5G7Xr6eIMFhsAchlEJXXSl?=
 =?us-ascii?Q?uUoa1R9ByobDwS8zaJZRXrvPKscZ6YwMBG9LRbMcSp3EZuSSOATNLnf4NhFE?=
 =?us-ascii?Q?dw11xkryVF4iaQ87EPd+mS7RjCobAgvWMpvGcgVyOXbtLaWLOFwdIm5T7l3m?=
 =?us-ascii?Q?GBUT5k5slpIJt+qr2iqtJQvfJYMoLbX/Q77b3fJkr5kKh4ZrH55q0CikN0cY?=
 =?us-ascii?Q?pDw9n3A63vzgvDARWd1IJMidsD6Vqdzwbi3W2G+xsMyl8zzXV8aZsfpx8lm1?=
 =?us-ascii?Q?X0TrMvecp7ChWy/Z/it5fGhalyOjlw1qc/8l867j1bomPE5iLPQTrIwlLEHA?=
 =?us-ascii?Q?e2E533yiMNCg/GASM2aRochAvZ/ihmaDORcw2HLSIuO5Zv7kP+NUqOtpHrwf?=
 =?us-ascii?Q?bzugRUkx+wkrF0oN6hASGbOXDijEkx33rWMoLPES1hdGOEWa5Y1C+A2Y7hFc?=
 =?us-ascii?Q?UD+ay6OujEMwh9coP6148cvX8hLT2piqtSa3YOnNzhJdCwomaPYsfDpzeuAo?=
 =?us-ascii?Q?CxvBAejsfNisKJNQ+303KWvI92rwGR5jlFk8Ars7pobZ46mzDwskS/ZSNk6H?=
 =?us-ascii?Q?JCYLhFVmF/Hb/z+TTDapsFsucvBWF1GgyphoGh21ASpz2kWp6PFB5JaXcL1B?=
 =?us-ascii?Q?m0PvoVcbvNdlV9vX9TGuLOtjmspce1rZMg2v+MFwxhwblJsRfMzbFneBwyjY?=
 =?us-ascii?Q?HRNpjQUI22ytowSyPF7bvXtjBFifIqosdRI9+M6GKX9NVLj0ltbLI5C0T40l?=
 =?us-ascii?Q?uSbWJVk8RDL8l2qRWI8v409cP1ZzeZt6BWlfHxxRh7klEgyHUVVmOSqLLzPS?=
 =?us-ascii?Q?/PAztIB1M7J89o7lKmAeAc/y3MuPfZGQ0y2wRr7TCvn8DGAA8VYgPX5Hjc2+?=
 =?us-ascii?Q?MgkSP7ZX8lPCUarkJ9oFSQGRi0Re0IUJ0FplZYWGFY7X76pfP2aagk8CIJcH?=
 =?us-ascii?Q?ewYSLFwCwoLsp/h9kmBunpo5TncaG1R7YK9we/1AiN300gGHZZx2/c0s2BJY?=
 =?us-ascii?Q?HDaaQMyNCaPSHxd89kBSpGJl6QoPTveYPHjnDOS1uFoA7PLg68V/L/ZcOfvj?=
 =?us-ascii?Q?ktIqqR6AG3AYVOyIN0hpF5dn77LI+J8yLXFD5YJfiEkzDJic4bDGRS4AP9Cu?=
 =?us-ascii?Q?yMOOCxuuyZgEbg08HePgt635btJrM1YES0n+Zd5I/y9oVVYOD5H7xt0/xMwH?=
 =?us-ascii?Q?oW6DVOdtJ18RY8wK7PSOdD72piUdxMZieh2QQXjFHUriMTy00rrHZ7isvZ4o?=
 =?us-ascii?Q?8tKrSOs7OxW8O1j5+1SmxjB1PILscI6nTQb3Q0d7hbeyxY73SR+QeVGV6bMk?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q80fF/aPCn7hDpHQjMRAteDvAZ7Xyr2X0maAhkxndrJTd6NYoI0nU5pq5qjYku57KZ8KMKErMEvNImZUedt3CLMlI62zEwOeTeSUvTcd1xLrlLPrgyoFj6qVcWRrDyzlOMsKwKpIzhkK/fWxsaT0X3vnVblrzG9P8rRZ1cmhzQwIo7lGJDH9FMvynYYS9B0VFswrf4xEXkORJNWI+PrLcuSJvFLadG2F2Q3IHnE6TnIgrxHNjIG67ZHD0a1jNDajFDqC5ah26XD6/5MaxytY/MCdZuZAhTn4O4T8q6n0nC9yH/q5Vy5qo+Hribk0CHqNs4wtpLPwT99UjyKwmEyW11W06LQ7ALqk8J92iuSh8zL2wFa2G54vXHwGeqe7wQ0mKsslyMMMzADnqotqyGk5vQ8Y7206/FWxdRiq4j8HVOM1R9w462fA+e4CU4+FILSu5UrVia9cPIMgcGOQ9jI5/UhdoVPCCf5JSEisfq6ppxad27wjhMxcF/juDUGVh2WTR/NT4s3Boz/2mgzzhx6frv9pWZmEnfNVbrd9YEsIvEFiCGUDojg3ZImIBTQOf/p5Q4ps7BmOzeBlE7ol669iMoJ1GmKIHSNq/taA/1ZPQ4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b479fac-ce74-4787-991d-08dd9709fcfc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:18:51.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylsquxEALdvGVAUpIv7p3wwU8PGd0MqXM80tgYIO/SfMeeml3alVMZymDEJu34hpWAVwgM8V8z+pFS9BDfnCx21IkHhQ5To7IE9AAgvo+lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190180
X-Proofpoint-ORIG-GUID: DZ1J5zfqfyNsMATU5CGTKmtMGoMswYkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE4MCBTYWx0ZWRfX22F3cOcs/hEy 5QBYde94MGs2y4RSFU+h2PVJmJViGFop8XZgjV7lvP/aDvFTygUztiz9dk/5XztmNnbRG2rqUM6 pIgRLT0/AFfB625FVYQqSL4IT6qPLCFwz+Uiazmzj+DT95u+pYfSoFF5LmZZNjxPahc0kJLJfI3
 WErzn0KqEXu1u1MmrRpSpFiSSdkZahqSbWNMwA0XhCXELot18+YXDt6ta3XQv3kv3x6ZCzwf+Et 26skvFyxLOWlynHsy+5tD82QBRCS9Ob8giJ7uz5DqL+ZCfIVNXY8ZpIvnOlt3U68DvvM+YAG2rF BnFMdroCTVGNlQgM3Z7Wvfo4kQBbiGuHt3XijHLoQLpislbavXSJONUEIpZwB15QwkjqZoDWrLr
 T+7hpMC5EDC8x3pAtZdeTr9OILvPOdhPMQTyzXZnfkc3LZWc8u42BNe84WBo3z8HqbnwXs50
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682b841e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=z7dr7OSEcSqzgttVD60A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DZ1J5zfqfyNsMATU5CGTKmtMGoMswYkw

On Mon, May 19, 2025 at 08:14:17PM +0100, Lorenzo Stoakes wrote:
> On Mon, May 19, 2025 at 08:59:32PM +0200, David Hildenbrand wrote:
> > > >
> > > > I am not 100% sure why we bail out on special mappings: all we have to do is
> > > > reliably identify anon pages, and we should be able to do that.
> > >
> > > But they map e.g. kernel memory (at least for VM_PFNMAP, purely and by
> > > implication really VM_IO), it wouldn't make sense for KSM to be asked to
> > > try to merge these right?
> > >
> > > And of course no underlying struct page to pin, no reference counting
> > > either, so I think you'd end up in trouble potentially here wouldn't you?
> > > And how would the CoW work?
> >
> > KSM only operates on anonymous pages. It cannot de-duplicate anything else.
> > (therefore, only MAP_PRIVATE applies)
>
> Yes I had this realisation see my reply to your reply :)
>
> I mean is MAP_PRIVATE of a VM_PFNMAP really that common?...
>
> >
> > Anything else (no struct page, not a CoW anon folio in such a mapping) is
> > skipped.
> >
> > Take a look at scan_get_next_rmap_item() where we do
> >
> > folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> > if (folio) {
> > 	if (!folio_is_zone_device(folio) &&
> > 	    folio_test_anon(folio)) {
> > 		folio_get(folio);
> > 		tmp_page = fw.page;
> > 	}
> > 	folio_walk_end(&fw, vma)
> > }
> >
> >
> > Before I changed that code, we were using GUP. And GUP just always refuses
> > VM_IO|VM_PFNMAP because it cannot handle it properly.
>
> OK so it boils down to doing KSM _on the already CoW'd_ MAP_PRIVATE mapping?
>
> But hang on, how do we discover this? vm_normal_page() will screw this up right?
> As VM_SPECIAL will be set...
>
> OK now I'm not sure I understand how MAP_PRIVATE-mapped VM_PFNMAP mappings work
> :)))

Oh wait hang on...

So here, MAP_PRIVATE, CoW'd would clear pte_special() presumably:

	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
		if (likely(!pte_special(pte)))
			goto check_pfn;

...

And in non-PTE special flag case:

...
			if (!is_cow_mapping(vma->vm_flags))
				return NULL;
...

And of course, this will be a CoW mapping...

So actually we should be fine. Got it.

>
> >
> > > >
> > > > So, assuming we could remove the VM_PFNMAP | VM_IO | VM_DONTEXPAND |
> > > > VM_MIXEDMAP constraint from vma_ksm_compatible(), could we simplify?
> > >
> > > Well I question removing this constraint for above reasons.
> > >
> > > At any rate, even if we _could_ this feels like a bigger change that we
> > > should come later.
> >
> > "bigger" -- it might just be removing these 4 flags from the check ;)
> >
> > I'll dig a bit more.
>
> Right, but doing so would be out of scope here don't you think?
>
> I'd rather not delay fixing this bug on this basis ideally, esp. as easy to
> adjust later.
>
> I suggest we put this in as-is (or close to it anyway) and then if we remove the
> flags we can change this...
>
> As I said in other reply, .mmap() means the driver can do literally anything
> they want (which is _hateful_), so we'd really want to have some confidence they
> didn't do something so crazy, unless we were happy to just let that possibly
> explode.
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

