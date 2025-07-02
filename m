Return-Path: <linux-fsdevel+bounces-53607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32663AF0F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1D87A49F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28D23E355;
	Wed,  2 Jul 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jR1Fw4mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IxdwN+SZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C181F7569;
	Wed,  2 Jul 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447313; cv=fail; b=sq0e9Eti+Bk0TKTvAvwOSc7f+WAtIqU5F8XgDZ0753/exzAxNsURXNl6dgRSIIfW0RKIFZUr32xWMpxr1unIHN6w3mincqxenNuz3HFFJ9V7UvLwbv0+dszZI+Nt+CWPtbB2TjkPhdVyDwUNt6tyleMSLV3VU9Su21G0LleVaqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447313; c=relaxed/simple;
	bh=i7T2yjgO8zksmEN6R7lmmV2XfwnkPXuBE8u1iKv59+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ioQ3HUs9206S6S7lWrbHO+wYP/fZGX6KNqXCEQu3aeo/GiYvV29xjHX0a3Xz+OO+rv3XYcTlT7QnMxeEVMocClM41cOOxQDt8THKU9ZJYZSTf58jMVpJaI1JsYWnanxQYXO9QU4illRKZXfDagTBIcIEbKBfjqNU0x+NxnokxE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jR1Fw4mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IxdwN+SZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MaSX026038;
	Wed, 2 Jul 2025 09:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i7T2yjgO8zksmEN6R7
	lmmV2XfwnkPXuBE8u1iKv59+w=; b=jR1Fw4mbf58uEt8lR5Yy/op7m9Faf49cLl
	BnLUmBW5TRyGunywTGTe/eh/xTGM73nRYDoFOI3Z1HfIdHJqNOVDsADsUvD2LC/N
	C2qMUgD1mP/cIcpNg4lrIp/wLzRAIlFMyz6DQWGKxMQMWxzE7hbCDHRCTeLgCq8x
	uUiJDydxkLlADm9Wcb0csl8xJrj23sGqzto+utJUmTtUhQJYI3+AuOE77kW01OmI
	r8t2MfzFnqBKqiG6g/n6LYi0bx5Oa3aoL1I1eWvFhk83mzeFmLsbkGdYJHpB1iw3
	Bgm+gbmBVgU26j6G85z3+Fka7h0FWWdP6nNB2fprUrkOFVCAF0Og==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7wrwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:07:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5628UG25033801;
	Wed, 2 Jul 2025 09:07:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uaxupg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU/AabHgshKmSymaM6VoTc7Tvk8ONIFfCHiAGhhbZFnBps1KC7gnFX1ToKMq1OtHgmqztr+Wp+///tROoCUuT+dUxbh1ZnIFr5SQssJ0HfxQhLIjgN8X5KrimDRaF1a6UPTppU3NU82ZXiKKI+41WRtvn45BpOW9bzt5+NtvwQ31k7Dz9iJ0ApOrnZxgE3Ew3CXa+gg9onqRZKIg2Zbb6wPUh6cc7EGMc3cHpzsEpkpIHLcN0CKIOkvZv0bkdpRK9WadBRVdNAFmxta+XPvVBL9vJMUZ0rXYcHDWxPe7ZVMgPiEmhCenNoXLHBcJUwLyxsDShdgLOVxNqMeruwVUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7T2yjgO8zksmEN6R7lmmV2XfwnkPXuBE8u1iKv59+w=;
 b=f2MJ0XpZtQCZb4Md3xjSRz3Xx6YcnIqPlHN1wQ8nMuki1MBXNSS23+yOiAVviG9k5YFlB/ZnJ/U1P1gse6kifZoFH5zJlUOiMMa3fH8qts4rfxLUqzbFoi+SkXRBGpOiVQCLI7xYvgYAcLxLHcdkFKdd3S5iYk1FZe+QzxM2uH6aIFRyQF8MrUi/Ozy6E2QbwGKnR92fSFZjpEW0kyUJkDpleDfvkk3zPlECa0tzhS8P0gLnjkYYnWPn84dW1xVzggGy3fdctGiV9rC0t4DOS+/iZPAhbdEvUak7/NQhP8BmsrjGqht+antABPiES1UUNa/17lft+4ALMLgAgSIPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7T2yjgO8zksmEN6R7lmmV2XfwnkPXuBE8u1iKv59+w=;
 b=IxdwN+SZ/x6y+ewPJq5MOy/9DTvO8EKS7MA/N2ahg6TS0fXHnK/YZgrq+xyieCdP4LJnRtR5zkFVPfxy0z8CfemDRkda80nc6sxWiJVnL06sm6mlW3uIreM6K05QaBe+5eAsn6OJSEhQU1GisYm2R0cvTV/5FTPWE3rpIrIVbtE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4204.namprd10.prod.outlook.com (2603:10b6:5:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 09:07:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 09:07:00 +0000
Date: Wed, 2 Jul 2025 10:06:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to
 PAGE_MAPPING_ANON_KSM
Message-ID: <11ca2f64-7b7d-4706-ba9a-90b70ca0e8af@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-23-david@redhat.com>
 <5357d4d9-d817-4351-9927-bcd03794964c@lucifer.local>
 <48e9a5de-3131-4e36-8a21-5f77669116a9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e9a5de-3131-4e36-8a21-5f77669116a9@redhat.com>
X-ClientProxiedBy: LO4P123CA0412.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: d192657c-1dad-4ceb-41b9-08ddb947cdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2wkkUq5hOfBkDWpdGfgxOr/RhEDZrktFDqVSyZJ8o4Vd/5XqQuFY/kJqW8t?=
 =?us-ascii?Q?DTX9Ja7kAplxBLwn3TAn9VaFys1MzG7Hmj2X6YclRRcLYImBJfX5V46CscxJ?=
 =?us-ascii?Q?RdE3S2DpJfrsqHBWzzn9tOoay2s2kSiEe2baKt/3esupWOnrglWcRE34DNM9?=
 =?us-ascii?Q?/oLdEDENNba/vWy2LrR+EIie3FU+5uvgjb+EGNzBo/IwhyjlJy8aT0/shXBn?=
 =?us-ascii?Q?d1l6QtOwhDrtmIiOCXFen/nDlOOj+EYaWTg3ejJTLvYMRZX7o/XGAsbpa22I?=
 =?us-ascii?Q?bdH5kLf4bZ8gK8uI5gLlykhZpjs+lwfvKHXyMgy1+o5veuMLA/BiNtEJLHr6?=
 =?us-ascii?Q?NOiLQUGRHWV0/NnX0PKgmZdgbUowAn3ObibHnNLBe29rO302KIKSYKYAk564?=
 =?us-ascii?Q?0u530Wun9Ykqcq+B6sEnRnKn5NNT63ROjRF7yKEQnO45dUK/kQvSAaknfzFy?=
 =?us-ascii?Q?menkgut7R6WtsL70tnF9dIBKRUxku4/+zd8D4S61PpUdkAgsDGJpVCZw4zcw?=
 =?us-ascii?Q?K8QVtsrcsSlDaus+/p/c2VGiWn6VHJ5FgnZgop2uBK6KE9kCOjRXVv7y96uG?=
 =?us-ascii?Q?CEXBFd7lHcfKU2saDosH06qwaTS7W+HXxlFu96FscYsniXSlOcVuL1s03s9X?=
 =?us-ascii?Q?fIu+Kq6pSa+WrQFdVACsp474EVLXdTPREVGE8KKDRuO+hjfk/O7PTAgWOtUE?=
 =?us-ascii?Q?n4/mL6iEPspgnzx4kGEMMmBUWTuqswObxqLUSv0rMjcyZ3cAu64Xnze8iyBP?=
 =?us-ascii?Q?eKURC5ICgBssJppRhoYOUcf/0pJUUywePyAdIHg3rXEeyU9Fvdn5zj5zieiA?=
 =?us-ascii?Q?gOhc2ntdfrey3dDL5/7757QOMDXYvCk7meNS2Si9ucT6WfsMVjE7nx23iHSR?=
 =?us-ascii?Q?+UvDjAodOSHads8nyWo6Ns78OmnbwDY/8GJATZKc5RnfaNGl+6faQU/gtSm+?=
 =?us-ascii?Q?XG4fDQ+zASnWgZQSOLBmRahLQHBDc3dTymItHXQAAKj7jDOo/jzqV3HObnF6?=
 =?us-ascii?Q?ybI2TjmA5VW1tJ0CssKzDUSyG/iTqDFomC0fzzp4SoXsx9msUMAmdlYHhwIU?=
 =?us-ascii?Q?WOgIobHZt98I4zwnL2y3UTCkf774CHq+Ons6ENEgD22Ga79JbR5/o8zR0BN9?=
 =?us-ascii?Q?74UedHiPfhu1nCNuoNjZ67+D2UhrXzxtwi1NZUR8zjcYY1SfiNYCjkcf4tYh?=
 =?us-ascii?Q?bITXJmXgT1Hg3086ZjOZGaG+tUrAWq4HnU/Aax3F6+fXWRPPuDyDVMun6lI+?=
 =?us-ascii?Q?qfYMYkNeWDldMMSf6GVoQbnnTwvCRKJoMiYfUlHjmNSMdkLxJpaJ/jJZfo6x?=
 =?us-ascii?Q?xDTDHG1Yal83K3q6yfBgtFTT2XL3cLp4W0CMT3VvF1VSLIFHEGQh6YvFGAi9?=
 =?us-ascii?Q?7PbusSSQhxmAYuAckwdAOjeClw5f7I+lU8moNM9xp3/qeJcS7L0C0e879QyT?=
 =?us-ascii?Q?k5grRhmgRLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+ZGxnwjFK2nSwdtVKveLt6Nv2wHu5/HzD1jVmmtLVZm831xtipURHtW4bkq?=
 =?us-ascii?Q?XSvV2HgKEXVO52y1933EAwTN90VdyuWg5UTzP/G3lue/uMVPhp277NifJECy?=
 =?us-ascii?Q?cBjFhiqOmbokiNlufVhbCQZ4KjE4VpujtzaBQxRL5G3VwCzFMYG4kbTPV2Rb?=
 =?us-ascii?Q?59despPwX+r4f8KI65NWyS5L0mJt0siqshW6rqIGkG8DIuq6sWyjdnSg4hZ9?=
 =?us-ascii?Q?7cHjQwZEFLUjGF49NOyESJjqkNel43gSdKrxaCNA2r7wAwco+/wfV5HeYcj0?=
 =?us-ascii?Q?qB+jMYdNYomG7TA5ercGzepP6F8VcIdYwxapdIzU1xIwx4RXqpkt2o88yK8f?=
 =?us-ascii?Q?qHGbrahr/iix+yk0HDmgTRM8/FDoORS4fkh9AgEY2tfQ99nY18YkguYdm/0n?=
 =?us-ascii?Q?OaHoGKXB2euplWdUXPQMiFeiQaENUFPJ5srjYSakR2ISr+5BPh4parcNe98z?=
 =?us-ascii?Q?EOi7C2NV2KI+l7/HsZJ+P6iQLiZEIowVndHl3GHUuhjFgPiIRvFEO+QZXbD9?=
 =?us-ascii?Q?5OOlScdllzZqunlNxrMFXDETBmflQyk3gGV7DgEGbhqXjuwOQ8GR6gRaEF1N?=
 =?us-ascii?Q?D4XlC+pPSURz/jBw5NcdQDIfzXm/qD7IXqFE6LmQlNT4Eap2BC4OZLQFLPdK?=
 =?us-ascii?Q?vosDv/3o9x2C+VdwhmYU58NfSNwQE2FHnwSPPJtiHPxnNXHUAOo+BkxjFIMg?=
 =?us-ascii?Q?mFBOhcVzAxkn8xM11GZAaQ+VLDQhjz+zRUzRTnDswu535hPeICBxx11K2Y54?=
 =?us-ascii?Q?Er9DxtxakcZP1I7WVWPcO9X0C961fsfRX5iaRqr13LIYQFWVtspL63qnG7H8?=
 =?us-ascii?Q?ztDgiE0aszALT+7z78y0j5sZOEwIKtZrubHNERcRJAApxgmaktRqX+dz377I?=
 =?us-ascii?Q?0s0vSAVghbz1JbRin9NB8sM3D+R3t+tCGBemYpxlQpOwWfZ8/NyxnRihk7SC?=
 =?us-ascii?Q?EZahyjWIbgq4i6CsWYco+aKXS6gipJlig8nvlmAdKiqIQg0klrhpe4R/MCyM?=
 =?us-ascii?Q?M05TAq26lcOuzIeva7zS0KwRxbFu0k4zt2kPbyMPT62t4LE/KMQ2KTtPAFsU?=
 =?us-ascii?Q?x6eIbzEciTUxVoenIgOnEoXQm3h6OEmBx2SnVm9Y89XrHwInT40yQD/5vh19?=
 =?us-ascii?Q?tB182My5geLyd73SEA1Vj7pbPjL3B7PYQ6NHoV+gH3YgnL99IdM7aqt9Hbdw?=
 =?us-ascii?Q?hmxyVLjSx3fYoyfapEWN4igCACTAALCmQz8eC263mvUFiAwqKYXOJafqQMKI?=
 =?us-ascii?Q?4D3XbcquV3/vHdpr1EhHjTlSO/swK4ThX9rr0uyJ3KPJbNQ8sMTZ8QOfQu1P?=
 =?us-ascii?Q?aUTzcy08Fht4z027IJhuqUa1LQHs0hHPuVSUuLQoozKOHgpWWZAaK3EcSvZQ?=
 =?us-ascii?Q?rC0dqZQaGRsIjWUtQOzaHSr5vNAopdVrAdNgCDItQ0Pc40MyZ6cpaf9FlMWr?=
 =?us-ascii?Q?P+r+R8LDkgat7nVd8gGyrgNKuYCF1ECRjoGFs2DFYNyrAV2wZwqxaErceiU1?=
 =?us-ascii?Q?Wgh1T9/2fUVbro5uks5iC01Llq1Z1jjve9jnaRVNNaJSSTuezjC5ZLHAKTXB?=
 =?us-ascii?Q?ptMLeX7eYQmJBlCEMWrs9ynJukV4tEvgtv0WsHRoc47A52yOgpz//dRO/08P?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SgDtgrXeMQqIMcfMuM4q8Nek8Zd2m0+p1cVljPnXg4Dv+4VNusYcML2PirRUCiz7xPvb4tzhAM5QC82+Rn4nb1xfR+Y8L4DczgPZ87v9L8AmOTsnztT/I7C+qZjHIWAFd18PR+cfqTkY5zt0qe8tDYIowYDL6/laxcVQiKC0i43HB5lRXxc3E18n8qz9Ey1ygr/KzzK6UhF1wNtq2nVpTjETEsszGVCnc8/qvUNJXUtjg5Nlg0JlX/EtNTFj428/cJXywt470Rtq5AmZ6an6UYm4EtcIPcFXg4i1gm1jQ3jgP2cNSwILE8OD+0x9KS/ruQdM/gpc0z5mBbD0PjncpEEZi7g5DAlpYWme9y9HtCj/4cBxTXSO8DxQzvueGG2PMh/PHAV6QMiSK7RnjdV8rvi2M+A4JOkUo5CL25yP8eDIyaFMv7fIUu7ePz8iL7Am2tHDE2UhPXtNjSIT5xYD3/pw15+YKp29ybWHEbwFZ5+OpvGBNFn80fSzS0Ppm8vS7r2zRumHZgZHETDcdGKBQdNY6D7DoBvYI6/kZp3vjyqBVQCA/BL9rfMSU+wFpGyifiplyP2VI4PXVBvIjXc0DDQfi0Rt6oz9EIyXlFPWtP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d192657c-1dad-4ceb-41b9-08ddb947cdf5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:07:00.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKGR6HbojdmSXoc90s2BuPT+P9WJW2333ElO/5RCHuT0dXY0sa+FS1LWKDcvY0kG/jlljRyGY0DcEVkE2Bz3o6aMFwv1qGTEHWbkcZz36ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MiBTYWx0ZWRfX0JdFxSs1s78A khJFhqV/8GDjjfHGHao3FEbrcXyaJrvQSivcO6hxwEJ/o/ScrYrAEnCYpuyAQfsGWQDPHk6Rvtb GTt1s8tmywdGBjThkURUlvuAgUIOxkzwAY1/IV0e6I0k0wuiNHUZB9Nzp+tO0uTyNgnDhCeMjjk
 CRkFGUPJRnCr1C726PhBA9dPHoxTc8XHd0cdjXJDSs3x0zukxuOAaeY7VasktgHTEQhVWvGWp4d 3bs1zdXVqANtPxGWBYxzb1nt9gfB1YItwbzUigVyDZ/lf8m4UrvMz33X2s/trsRM7tI7dtGoh+C s6eZvh3sGTE7sN7PwZ59A+Q3PfcCV547OuW57b6lTldb8YRgeQYLAahhPyIV0mBYkIG3md2aqea
 SKpTME9x6ECX2rihqbOhhmNPL2n4Yx634fdPQHp65/eOuhTQefUx4GU9gpdDj8vW0pI6VckQ
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6864f6b9 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=t4HjgU3YqRTIp5Dt6lEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: m5wNv2zSNb7AL6LKsS9QoTMj2VKY358u
X-Proofpoint-GUID: m5wNv2zSNb7AL6LKsS9QoTMj2VKY358u

On Tue, Jul 01, 2025 at 09:31:56PM +0200, David Hildenbrand wrote:
> On 01.07.25 14:54, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 03:00:03PM +0200, David Hildenbrand wrote:
> > > KSM is the only remaining user, let's rename the flag. While at it,
> > > adjust to remaining page -> folio in the doc.
> >
> > Hm I wonder if we could just ideally have this be a separate flag rather than a
> > bitwise combination, however I bet there's code that does somehow rely on this.
>
> Well, KSM folios are anon folios, so that must hold.

Right, of course, though they're sort of 'special' anon folios...

>
> Of course, now you could make folio_test_anon() test both bits, and have KSM
> folios only set a PAGE_MAPPING_KSM bit.
>
> That should be possible on top of this change, but not sure if that's really
> what we want. After all, KSM folios are special ANON folios.

Yeah probably best to keep to enforce that KSM == anon.

>
> >
> > I know for sure there's code that has to do a folio_test_ksm() on something
> > folio_test_anon()'d because the latter isn't sufficient.
> > > But this is one for the future I guess :)
>
> Yes :)
>
> >
> > Nice: re change to folio, that is a nice cleanup based on fact you've now made
> > the per-page mapping op stuff not be part of this.
> >
> > >
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > LGTM, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!
>
>
> --
> Cheers,
>
> David / dhildenb
>

