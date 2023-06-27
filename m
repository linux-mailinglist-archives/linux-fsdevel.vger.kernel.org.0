Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0873F67A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjF0IJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0IJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:09:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605411FC7;
        Tue, 27 Jun 2023 01:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0hbYdP0v+GkIzlKu4CM9GKb+Llp26FY+FygCdo9b0K4eTZeHKarLLiykT6gKJpTwCv7Gbn+3k2mWI/cAe72t7k0WXMcdDbCP6YuqPet1S/7YOUnz8jhCAGnz8THRrjma+kg41C5FO8oH6fnRdRnn2BwDXFICfhELKJBPNhDTnO8ENIAJ8Dx1YfFLh3/BZdsq1WgBaK7kuUiFRMU+KwmIP+kE7Zjzz2xZxp/diiNzTtok386XybW0YiVwVyQSTOHi1OzumhuCJuBU59dtoR9QeoA9HjkeuFuaU/LPhkGdXiOHaPhq2GbjTXbOB6VK+PhdfHUpkxkI+y+y8C9c8VR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krNxqMZWUScqOlvJGkDvwWJEIWEesoZBSR6RXTDcZLA=;
 b=nwOEKHdo2HMC1t33DeZjhZSLC7Xu8yr+WKhffGaBIjKKdp7Gj15RSQNS7d0VU+FWFrHn0AUEZEHCMNKkU9zxop56rTToAdzU0cI35ZbogF4OEc6E1i6SDjTLyUCc3McKLsaDPgAHYHdpMK9qDLKZPIBn5Oh8HcRHnJMHpxFu9QHvsIQ7nW+sDhR0szfnGZTxHoXBtuquqQCzNh2tdatky2RaBZ5lZto718Rr5rY4NsLN4g6w1dt1tA1oxc7bLTNhIcJ3Ic0g6xlstTIos/L55cCWhcJVj5BRUvM71JrE/peDaBIxLKsKT9E8O+6oJ0x9mf6a7zWTA1xyGIQsBnMltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krNxqMZWUScqOlvJGkDvwWJEIWEesoZBSR6RXTDcZLA=;
 b=Ip2zfLV94lyWkhssn1VMFDNEkl7NfPLG+L4EJBl99LObRIZreKRmf7AN9RJ6FxD9s5Y/88/e9kSsp08jHmVHuqRN/z5qoKJPAFSXBvZxhSrtG4/khvH2r3Faf6fBS0rOTcUeW8HreoLTAyC6mrW8wyJe+YdaN7QNMPLEVRa9ObOA4pJUjg6JX+a8KqfNEQirr4jEHQ3RZzNpJMWROXEpUryN0EGiPi5CWv6PJW8SLm+D+E233IPwzIFSybjajI6zpMuVDDtfMhSj9xYEoaWd+sveEqzNzhG+vQ5GtYWhLdEkLeBBA48Yu3PzZXzv2UyXMoc6PmRLntUUS+6LJxMCoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 08:09:13 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7%6]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 08:09:13 +0000
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-6-surenb@google.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/8] mm: make folio_lock_fault indicate the state of
 mmap_lock upon return
Date:   Tue, 27 Jun 2023 18:06:33 +1000
In-reply-to: <20230627042321.1763765-6-surenb@google.com>
Message-ID: <871qhx2uot.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0023.ausprd01.prod.outlook.com (2603:10c6:10::35)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: d316d7c0-796b-4f1c-259f-08db76e5cb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2rJmoFEgxBZw4GsMawlxUwcDapwQKI8XPJI4KCQM4o8SUQRi9Q/E7i7vJPe+xaMNXI7sWjXoWkn0giXTcSLg5q2r0OJALDilsQnP+Imhs+vM/peluHEem1YJIRQhH33tGAKymYEtrM0utciol5duEgoCRIizQBu1uu2i7XhahNTV9JI49Br1az+NTVdvQCryumiseQI8eB0QCvKIQnwttKB5sUULIsOvzqZsiZl2JFohn1e76kBGlzT6idr1GWh1iz0SsfYpaj6Fra99bAAI2JH07j/fSo6O7virYuCwwBpA5fsSI3CDF0qjp6I6LIWa3tw7Al59vXXsvoGyl1ufNmMAnYZ7HMz3Dy/C0IoUYGRzlEb5eghBgMIbY4YH6GUV4rd82xjiV9jToc8RNNwPfFih55XN4WYMTkijkrbG3/urGyFb6CER0u09cZ6ZKh5edRzRVKI+6U5eAxG5F4GtfmUuxXSloswcis8AkfIP4rpnP9HlVaz/Zp7wgqvyfFmuZlX8PQGMEj68fsWkFBv41BW4cE309cn9WGb0Ux6sEwjucwS2E7BTyWye/qerRUR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7406005)(7416002)(5660300002)(66946007)(66556008)(4326008)(66476007)(6916009)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(9686003)(6506007)(6512007)(26005)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amkPa9wlJGLT+0BP7zd+uEK8CK7r5YFAPuJwgGGaSbe9lwXoI5i4Lr4H9eav?=
 =?us-ascii?Q?5hcBrhkYSYB0+FB5PhIzVZcaOADnGhWCzlhpftBewpfQDNlNtQ04t9thTsex?=
 =?us-ascii?Q?na0E8n2zi/MD8yLQkAuPQ4piL+h5PgAvfy1Swd99G3ZZwlvAwjFxccch+GJH?=
 =?us-ascii?Q?/FuupgxnnYX2bVrMGB8YcGOrNA/iGj1s2zHJZC6WgKhdc70SXFbZDvI4WDmk?=
 =?us-ascii?Q?AOgX8lpcEg0rvvxl/VvBwxa2t3hESa9/POHY/gDXsrcho+454+iP3RZkYhzo?=
 =?us-ascii?Q?lQwd20VOcDXM/ZCednqKc9aQ3AOkITVLHvVryHioBTKa7Fmowld6jokIwaCm?=
 =?us-ascii?Q?EBIi72+CKa8bewF/xshSuuVjB2oL0sJ50fSSD7Wa+Uq8fWULYrdq8AjPFHH8?=
 =?us-ascii?Q?wUCi2JyF31gOdrwxCYTc21EXO/Paji0Th/0fyy2QPrgep2PD7INKm/OXAhvL?=
 =?us-ascii?Q?J98tf9H1BLTVSdW4utBaiUjushvkpgpwXQCTrEGN5b8XdI1zTWTLMmPRhVbH?=
 =?us-ascii?Q?/eX/GJiKwUfp+V23BlElAxSMfEITQBm9pNTWGAFnwBuivIqLKY1kSrXRBZxA?=
 =?us-ascii?Q?kKva8dwRwOzUP8FufjqmSZw6gBWN65AvEE1dZ02SFKP1u4Q8kuD5nAx2rXf1?=
 =?us-ascii?Q?snGrHWvRTmarmsuKx+8lxJw1499WAC1yLEHInN3vlgIs7Cl+H9We0DYSmKVD?=
 =?us-ascii?Q?FZQ0TtSWgfZuwOYiOt4XbZ+MGIH+uiqpn43kbLrTcfFEHMo4Hk4njvh6Lw/6?=
 =?us-ascii?Q?mdL/gR4w9Z7xf1pbV2fHS8DOADnfMZBSYQViPtHRUt0TudZ9R6FrApQ4Qspg?=
 =?us-ascii?Q?MGcg7k58W0fK4EMuZk1IgfhWN8UHvMesZL4047O3bduidVNU88At+40RtyA6?=
 =?us-ascii?Q?ua4zN9M0f/3bz7raLuZBUiC4em+iLmx4lQMcRnUkjkK9Uw7wS4dtsqnr+Uw6?=
 =?us-ascii?Q?3dMzIXh4QPt2v8EZR0fiIe8wOYIpcD2O/YGZUOm4Ok6f/Y16GdFQ8nAgzeHh?=
 =?us-ascii?Q?6nzm6p+9dwbT18FRpyV5ID/e4q2nMh28Ik1gbxG8C4KhmwY5HXq/M8aQbzAd?=
 =?us-ascii?Q?V5Ga3MOTY0rGLvhEbGDqB2l1PuMKNMF2xfOBCdJLNu+8mHTagfjbN4kvCxXp?=
 =?us-ascii?Q?3O/LknHK4TT9zvpqryDvToqnMijsFUjejRW8QGNfzkr9Sjwmr0YMtuXPLEv+?=
 =?us-ascii?Q?Cuzw3q/8G++5mfvYwBq85gW6Wnt1GQTKJw0rZs+6L9pwWwi0Dg+WMslrKsRS?=
 =?us-ascii?Q?jT5zvcm2NryQRkirT+KvCtwa1R03ekkK2KL3NiOFylsJz9Y8ra28uUFZQyUI?=
 =?us-ascii?Q?lDn6xiLxeXKY+pmQzZbKAGrNvp6rWYO0+vxjPQ19NbNuOJgi+nbSFa+i6oUc?=
 =?us-ascii?Q?072QszZhMTRWqf343IHXiFsfalaKoGC18dxj6WvNoohH6oboV9b0bjxTF0Iy?=
 =?us-ascii?Q?+jMSiRF9MjP/6Myy9XNY31hM0MIursHbPHi5QYDqvsURTiLUS5qTS5cF70Mb?=
 =?us-ascii?Q?RpftGNnqAGKkdCSTkZauqbEl0ggUo1YocrvrtOxeZl6yhgei8x9eOeN4jH2U?=
 =?us-ascii?Q?wW8+qLaMVqD7cpUokoLDOPMtl9/+Y0KzzRefF0Qu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d316d7c0-796b-4f1c-259f-08db76e5cb1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:09:13.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozBv00MJyNbJ+vWoOlRTqq3/+1qTayMNSIBP2dofaTMhGFAc597rylhFEl92p1HACLR8ydQBCdOX0Eu6mGGtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Suren Baghdasaryan <surenb@google.com> writes:

> folio_lock_fault might drop mmap_lock before returning and to extend it
> to work with per-VMA locks, the callers will need to know whether the
> lock was dropped or is still held. Introduce new fault_flag to indicate
> whether the lock got dropped and store it inside vm_fault flags.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_types.h | 1 +
>  mm/filemap.c             | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 79765e3dd8f3..6f0dbef7aa1f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1169,6 +1169,7 @@ enum fault_flag {
>  	FAULT_FLAG_UNSHARE =		1 << 10,
>  	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
>  	FAULT_FLAG_VMA_LOCK =		1 << 12,
> +	FAULT_FLAG_LOCK_DROPPED =	1 << 13,

Minor nit but this should also be added to the enum documentation
comment above this.

>  };
>  
>  typedef unsigned int __bitwise zap_flags_t;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 87b335a93530..8ad06d69895b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1723,6 +1723,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
>  			return VM_FAULT_RETRY;
>  
>  		mmap_read_unlock(mm);
> +		vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
>  		if (vmf->flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
> @@ -1735,6 +1736,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
>  			mmap_read_unlock(mm);
> +			vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
>  			return VM_FAULT_RETRY;
>  		}
>  	} else {

