Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E46F5888
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECNFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECNFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 09:05:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8DE7;
        Wed,  3 May 2023 06:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWOpIJ4m/hmTRedTogbo8HMrncO9MqzGOu81vObExBURSPR+2tJ0tVThSxplwHoJjI7VU87xzSiGaGkziHyZJ/05eVl2nXGWxphEq8rHxkrp30zBWAszlwadN9WTYvC2u5uZ9imKceVeth2VnpYPcWSfslYhWTBRvrrno/7tpSWYkZwoeAJ9FTQbr0ganQ/lBq4HD3sGMLbaxB1rcef+R7IsqKMJHQhjBcpXtRdWg4TV+rRUfuSM99IDXS7cziGYqfBuPt5zG4uRbhyjNnaTLs52GUDKhVCTClRrsauUVdv+JQqwVmiA0oSFzYnisCog+FAQ8pR5BbNvrCAkV6aw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErzDvGhsxoLkUE6ByjmBTexwyYug6sCWEKdMeDCVHjA=;
 b=bAeP7JGbKz+XRVVzlRJZYnvhgpdHA3Igcujt3el9SOkvqcl2Ye2EbJkfLn8tTD3dXtk1WjdsL7hPHPBu6zDOHmePtvJpp0vhnaiVYe1HTesptebYJgCZoNTgmHRxq3xm8OPs6ZeR15la4ID2xw8mXtJukfhT/53EkUIuGcg1rHu03rI0DQPWdMqkUWv15znP73rY1iIVUiHo90HR2P1ZWmSuLqxwYA1+KNkpxZUZBzKcm0trP2NUjx1J1O21cXu9xNp+URbnHH72lDXWCbWSCpqJ2azaUnGYlnCahvnycg3xQxjouVdb4CfC4RCatnLnsD1GLqz+1Kq6kOTRfeBZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErzDvGhsxoLkUE6ByjmBTexwyYug6sCWEKdMeDCVHjA=;
 b=qC1zQCqsAKT8RO3Cjg7i0WKYNNq6q+168yBD4UupM0+wbmGZo0C6eUhz72rggU1i58GOwvVEhyxRQ5ZddTZiaxpovhXv8pzRmTYZkfle/dlApgCRKzb5g18+cO+6dzOcdYzTME3wI6w+paMAVeamK1VFjvcqlD9kb5tmxOiNY1par/OTPOKtxGhe7WwYqItgfxAG/YTwRO5Dwl/B/tg/jfsqgX+pTnvJG9R8X7ebpsEkQlQl7Z2krSCsN95fximPNdJU6v1Yk89Dza2keCjXTlNOsgVsGuX5naJr4+WPzJPl2q1Cn29Pz+pn/az0rAzrcD9AIr+E388U2nGjUnwsUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 13:05:44 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 13:05:43 +0000
References: <20230501175025.36233-1-surenb@google.com>
 <20230501175025.36233-2-surenb@google.com> <875y9aj23u.fsf@nvidia.com>
 <CAJuCfpGprqXcjjUmN_Vx7Uqa8aPrSZAq9WLV0W9=sKNBUe3Cvg@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: drop VMA lock before waiting for migration
Date:   Wed, 03 May 2023 23:03:20 +1000
In-reply-to: <CAJuCfpGprqXcjjUmN_Vx7Uqa8aPrSZAq9WLV0W9=sKNBUe3Cvg@mail.gmail.com>
Message-ID: <87lei5zhsr.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cc5718-12db-4678-5b09-08db4bd71a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyrvuP9uRkUpiZOdeUNloQ9huaxwiUtbsM66iKkacdYG9/ZfwvaKbANFOxxUI4nig4s8FC64EkPKg461iK/UYR5gJcR+ow/9pXymnipSWFPtaKJO7cPykU+IX8xbryaktNbt0bfyB68JbHBxcq71AA7p2u8GpZjrSH4j5RkCPLZE5qTBv+3A6rEUIcfzVUB2tUgHOEtEwwMG0n5tFTRkrlLCBuP6Vap7g37z5T+JkpA6r3d3kmicIsPUdeOtJlUa8q4ntQ1VATzxDLQNdxQHbcs45eCMvn0wfO1A6wM+hplLxpumheBbYte/56ELIgWQLqIn4nfUCDTACstyt53Zp8KzCg12DXTvPu34xj4mBwFsMzgZcCGlX3lBKsWPmK+XUuXM2pN6rMhp6klejRQojzl3k1zSACY/yGljnKVLtFhGSet1m2gaW8Rn9CaXiDHCXmIplnP58xBhaF9f1yV6zth5jCMFaLO3ih3bK+wOTTXHGPD7zWh3m4DYO+Ec9Xdcvkcojpc30tYUxJqccLeIKkgsv9hxoMTFo9x4tRU8lSm7fctnG39Gf09BQw22Z8SQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(6506007)(2616005)(6512007)(478600001)(6486002)(83380400001)(26005)(6666004)(66556008)(66476007)(316002)(6916009)(66946007)(4326008)(53546011)(186003)(41300700001)(7416002)(66899021)(8676002)(8936002)(5660300002)(2906002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGlsWEpjNXNwSnhXOGU5S1RSMDhrUjJDMFhURWlXbklxUDdNdzV0cElQUy9O?=
 =?utf-8?B?SHdiNnZYWXRtbmxZU1hDQWsvTGhVVUFZS2EwQ08yakU2aWJ3bWczdDR1MFR2?=
 =?utf-8?B?VTRLTThFYk5OSW9idktDcWp2REhrak9ET3FLTUJ6K1oycDBLTGFiMGlDUjVS?=
 =?utf-8?B?T3FZQUlGSDBJVExBTmdEMEVLdVVnVEd5SS9Sc2dEWHRFeGhTcW5QVGVGVkVE?=
 =?utf-8?B?cGxUcktWZFFHVG5Rb2F6RFhrRWg3NGVMZ2M2WkRxdXFzUzcvZHhoc0dVMzVa?=
 =?utf-8?B?eE50dktUS0dnTHg4cnFEQzk0bFdURDV6Z1g2NkczUFVEV3VFZnkxbU5vbDNP?=
 =?utf-8?B?cm9qc0J4SGhkVVZpUFNlSXlFTG56NVZTeEtWL1J1VnNGZ2xUWjF6OGdUUTFS?=
 =?utf-8?B?ck1EeTQxcS94eVU2YlJlaHIwUEZVZ21zcUdTU0J0YkJ4ZkhaVGEwTVMwT2Vo?=
 =?utf-8?B?eE1KLytzSkR0eFBEWEN2WEtmc2s0anhNTGcrQ0Q4MStmZ29VakVFR3VEUGRO?=
 =?utf-8?B?U0VPbVIwb3hNcWg3L0huL2FyZXF2Q0lmcWJzL3FoaDlFZXhjOTlBQjZPTld5?=
 =?utf-8?B?Z3JjZHYyblRibSt0c0EydVVkdnBubzFpb0FtMVE1SGY3RHFVbTVwY1RNK0VK?=
 =?utf-8?B?VDRoY0Z5TEpRSlgyTjltb2RZVFk0YkoyN3JYMmtWaFVDenFsMnpIa1FGN2lm?=
 =?utf-8?B?S3dLRlZYcFFPWlpvbGt3bC82RWpsblZUamhZamhSQkhucFdENDA4TnJQZUdC?=
 =?utf-8?B?T1ZDQ1JmYytIOHNEbjFOUDFtWlVsemdBSkV2c3ROVEZkNGg5N1J1dGpEKytO?=
 =?utf-8?B?bFZ3ZnNqNzJWTjZLTFBOSE5vVWhmMHZqVEV5RGl5UmlWMHdPVXVNdzg1TFMv?=
 =?utf-8?B?ZDlHVWpoQUNyOUFLelhMeDZwbHZEeFhxWGsvL1BySXRLV3psQ0VxWTlEbyta?=
 =?utf-8?B?clBYY25ZQk5WelZxNGVtbDJGV0RNQTFxSWNjN0F1ZFlnaC9ZREI5MU9wN0lY?=
 =?utf-8?B?NTVjOTFCdk0yZ09abXRRMWhyTUluL1dLdWs1M3J3SVZQbFVsRHNGT2U2ODJ4?=
 =?utf-8?B?MHhZMk1GQjlOTTcxb0liaFJ5OGFLUmFUZXZxQ2VQeEhnb08rakVTVHpDYTdn?=
 =?utf-8?B?b1daSWw5Q1hBZTUzUmNHL212TGExaWp3aGk2bVR4YXo2MlBvZmw5aGxaZEJv?=
 =?utf-8?B?RGZKc0FUbGlXSmxJK08rUHE5eGl2RWRYa25BaFAyeUo1aVFEVXYybmFRSHNB?=
 =?utf-8?B?dnlzL2VFWVNkckovK0xzYTJzaGFIeTZFTVhOZmY1elhzZGlESW1rTDg0ZGdZ?=
 =?utf-8?B?c3N3ZUhCckVZZ0RkRlZkTkdrSzcrU3Y4N0JHWk9mTGpnaUt6emtBajlrdXZK?=
 =?utf-8?B?Skc4QlZnMk1xQ0tLcHMxRENIZHdYZkpHUmVXWlF5WTBxTm1pTFRrOGY2cmo2?=
 =?utf-8?B?NUtxNS82eTh2dTlJYm1Gclp3Rk1MNUZFMFVJYzZJN0hnQndRRWxkVkdpWkJo?=
 =?utf-8?B?emRtOHVXWE9XTVZ2UmNlSGVHZHNQMTJvWHYxMDVKMTFuR0NvYkJQWEhKSzdW?=
 =?utf-8?B?YXhsQkk3RU5yRkJOOFAvOElwZ29nZWhTbEV2UWMyb0g0R3hXd0dmNjFhelBh?=
 =?utf-8?B?WExxazByMzk4d01BdHNpZ3N0UndUTWxvdzlmOWZTdDRnTzZaZnN6OWdlbmlv?=
 =?utf-8?B?N1hwcmIvUmZWc2NEK3lzV0ZJMkNqWFBRcFBWTDJNNE9yUmNxSjJIdE1lbUFO?=
 =?utf-8?B?Um96QlE5dDV5RlBvblVoU3dMUTZSSklKbjNCdzdEc3AxaHlMVHJ6RXRaYURj?=
 =?utf-8?B?UitCV2FJMXJmMlRpNzRKWlh4Q0MxcDVPVE94bGNNY0RJNkRBenlTSm44ZXlW?=
 =?utf-8?B?cEVYWHNjYzlJMEtmZUpKUi83ell5YlRDUGFmb252NDdFWlNxOE5mWndjM0dm?=
 =?utf-8?B?c3FCaDk3TEJFR2dycDZQZ1FmWmh0SE8wdkg0UGdnbHFGM1R4cUpMaWg2Y3c0?=
 =?utf-8?B?bUd6QngwRUdCUU56bDhpOGF5TEpMNGdrS1pRTklNRjFsd0xBMG5ydmZ6QXhH?=
 =?utf-8?B?NWJHZnNyeXNKSXljcnhsNzY1ZFBackh6VGZxTUo5QVJ3cElIQ0NZM29HdEJE?=
 =?utf-8?Q?Ullo3HZcKtBI7QeJdhbHbbFr/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc5718-12db-4678-5b09-08db4bd71a4f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:05:43.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL0Mnuy9XvMZDDwLNwsF1F/BYbwxHBvuE3zxHVLLgWP5jq920KPqO1c/nYJCph71KO4KJOYPhUQV+6OzNP3Dig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

> On Tue, May 2, 2023 at 6:26=E2=80=AFAM 'Alistair Popple' via kernel-team
> <kernel-team@android.com> wrote:
>>
>>
>> Suren Baghdasaryan <surenb@google.com> writes:
>>
>> [...]
>>
>> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> > index 306a3d1a0fa6..b3b57c6da0e1 100644
>> > --- a/include/linux/mm_types.h
>> > +++ b/include/linux/mm_types.h
>> > @@ -1030,6 +1030,7 @@ typedef __bitwise unsigned int vm_fault_t;
>> >   *                           fsync() to complete (for synchronous pag=
e faults
>> >   *                           in DAX)
>> >   * @VM_FAULT_COMPLETED:              ->fault completed, meanwhile mma=
p lock released
>> > + * @VM_FAULT_VMA_UNLOCKED:   VMA lock was released
>>
>> A note here saying vmf->vma should no longer be accessed would be nice.
>
> Good idea. Will add in the next version. Thanks!
>
>>
>> >   * @VM_FAULT_HINDEX_MASK:    mask HINDEX value
>> >   *
>> >   */
>> > @@ -1047,6 +1048,7 @@ enum vm_fault_reason {
>> >       VM_FAULT_DONE_COW       =3D (__force vm_fault_t)0x001000,
>> >       VM_FAULT_NEEDDSYNC      =3D (__force vm_fault_t)0x002000,
>> >       VM_FAULT_COMPLETED      =3D (__force vm_fault_t)0x004000,
>> > +     VM_FAULT_VMA_UNLOCKED   =3D (__force vm_fault_t)0x008000,
>> >       VM_FAULT_HINDEX_MASK    =3D (__force vm_fault_t)0x0f0000,
>> >  };
>> >
>> > @@ -1070,7 +1072,9 @@ enum vm_fault_reason {
>> >       { VM_FAULT_RETRY,               "RETRY" },      \
>> >       { VM_FAULT_FALLBACK,            "FALLBACK" },   \
>> >       { VM_FAULT_DONE_COW,            "DONE_COW" },   \
>> > -     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
>> > +     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
>> > +     { VM_FAULT_COMPLETED,           "COMPLETED" },  \
>>
>> VM_FAULT_COMPLETED isn't used in this patch, guessing that's snuck in
>> from one of the other patches in the series?
>
> I noticed that an entry for VM_FAULT_COMPLETED was missing and wanted
> to fix that... Should I drop that?

Oh ok. It would certainly be good to add but really it should be it's
own patch.

>>
>> > +     { VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
>> >
>> >  struct vm_special_mapping {
>> >       const char *name;       /* The name, e.g. "[vdso]". */
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index 41f45819a923..8222acf74fd3 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -3714,8 +3714,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
>> >       if (unlikely(non_swap_entry(entry))) {
>> >               if (is_migration_entry(entry)) {
>> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
>> > -                                          vmf->address);
>> > +                     /* Save mm in case VMA lock is dropped */
>> > +                     struct mm_struct *mm =3D vma->vm_mm;
>> > +
>> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
>> > +                             /* No need to hold VMA lock for migratio=
n */
>> > +                             vma_end_read(vma);
>> > +                             /* CAUTION! VMA can't be used after this=
 */
>> > +                             ret |=3D VM_FAULT_VMA_UNLOCKED;
>> > +                     }
>> > +                     migration_entry_wait(mm, vmf->pmd, vmf->address)=
;
>> >               } else if (is_device_exclusive_entry(entry)) {
>> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
>> >                       ret =3D remove_device_exclusive_entry(vmf);
>>
>> --
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to kernel-team+unsubscribe@android.com.
>>

