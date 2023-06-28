Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF97408E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjF1D0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 23:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjF1D0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:26:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD72D60;
        Tue, 27 Jun 2023 20:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaZFWRym9DVx/0vv82QrzvK2wFz31id1lMdY7JufVAMo4QerL177ZTRRQ3Plgz7c8Tg/HWkZdJwJdkZ5856SO5c7voI/jXFziJiSm4psmYSpU1EVgSnPUovao61dSer0wJpqfKnsParnRWw3HXakktkTMTDsjnDhsapSFuLI/fEJFb5UUcdHzHNWVMirjcVAtiSJdWfTgPE6yrrZ6wUPVHXziB80atIl7/7sHifFvJnpXT7r9SKEHUIji+nBraf9/Nb0iLoRVHssU3pf03GKxFCcWEUcvtcoRqza6JizG+uvTLYasagaht4rvWi4pIN50RbeJ0xZqmsOicPAyPGJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7db+HzzhwdkCf38utzIdO61cCwJ0LX8/BIIPFHez3U=;
 b=OE4CH5AyNOIc8dqgINdYSz+FMtnu5EgBf1GFcwAWiw02mbip15E9HXruOQu4NEF2MPI9/YqRvGPx3pDY5+Sq+3nHUZkj/b2UgzBzkatfFVZkjelDjGRudHUpjXaGKNg1hBD+/w3H5Ul7q09QgGYkIP8m3yaa322ZJ8riUySySSy12f0U3frtJxTMNezn3cKezUaJcmK80NNm5br33DP2sIMw6Gpxc1pGfqNLrMI9frOZShjyDeLInwZQkBJj1wg/k36XPGbEPUsWR4Wa5RTNo6O7Rp35dzk3H+N6xRwj4fr4hz8u6lydVZNXbEWqDlyhubPgkKoH6XSWyuLfbu3f2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7db+HzzhwdkCf38utzIdO61cCwJ0LX8/BIIPFHez3U=;
 b=cgSPjvf5iOOJqb3191q7otjVNE0DuV6NPWvTZphIHqm/KU6YzPXQ4qtKHTqXH+Bv2KCUVsE6UIkwGBs6k4yiIDBIfplSZzGjEMKErQQvNqH2mIrdYYuzmJdMxUtJpWdua90Dk0mzGl0IajvxmB1fMWcWCrVKVTrFxez2G4/pfsIx8mhBC0TRuBBFyRps3pZYdU9cXV7M3I+7qhdtYmgb1t5ShKZlakDhk8ftMJoyifSQPr1Wy8ELH5X5d1m5neM5gUZ9m3YAJ0dJOne3is4pGKL2meXPnBgljAF726J2rZ+QRTn9zw4ryOLF4MTuU8B1G2FO80n+XKOQij1/resR8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 03:26:02 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7%6]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 03:26:02 +0000
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-8-surenb@google.com> <ZJsFFzKG3W7UPCeo@x1n>
 <CAJuCfpFC05vCwAONO7YxG=LhqteyYmOy1Nprg2NyjQ6hKaHgOA@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
        willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, ying.huang@intel.com,
        david@redhat.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
Date:   Wed, 28 Jun 2023 13:22:04 +1000
In-reply-to: <CAJuCfpFC05vCwAONO7YxG=LhqteyYmOy1Nprg2NyjQ6hKaHgOA@mail.gmail.com>
Message-ID: <87sfac1d4t.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY5P282CA0124.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 410f915d-0a5a-4f45-c3ba-08db778765f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mofGvBYzSO6M7CHdPD6vuO0TUEtOrEci9ksYJk55Q13LscPilgMtnjPGk6HbhT1V9QfHrqBDZ+llghTgMY9pR4eXXbGmvdpcF31eimZiQMjmaV9wVBVmWmqIR6vGpjg3YNkzKGyG1AaPFju/7SwbL0JSYAU6uO4/U9uazqC1mnbIfKwb5p8TpDKXNgUstN4+93ETksesyUar7iUrNggIOhqjJtBAfBPT3sM6MgSS2rpBiASU8fmBdtLIEiVytRDOWJgHK01F45J09+0fzXlN5Scwx6NpVFu9OaDuMwAgcSB+pSLX8bJEErRMIT3AYha5VOP2olfra1EFSYdueODhQoW9Lx3naeaHWBTaPe3w9djrzXI+iAojP1T76YnLrE64DxlGZy0L8iS3HNCC7+aTAVIbOn5LxX3lhmPCmnxUa79M/K0RM1o7u3rVsFhhEFaOwmEJH4ZNcGER+9um8DfeUWbqZQCpJmD9WisKhTSN/XhmTK0SVDcMBW19zYfs2x9iwoB7THd2lkLYle06BWBkdtAOhCQJfePF7pBHJieigz2Xa/GQO0PYZF+ujVAGt2Za
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(6512007)(26005)(7416002)(7406005)(86362001)(41300700001)(6916009)(4326008)(66556008)(66946007)(316002)(66476007)(8936002)(38100700002)(8676002)(5660300002)(6506007)(53546011)(6486002)(9686003)(186003)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNUWmxBdm9KNUdDTWRrN2hZbTlMOWQ5M3RuTnV5TkppNnM2dW1pcHJkbXpC?=
 =?utf-8?B?SEh2U3FjVktFUmRqMlMzZkVJSWY5QXJmZEQwYVh4VlFzZGxML2h5Q2VyeW5v?=
 =?utf-8?B?aTBXcncxZUlvaG96R2hHckZCWTdtYmU3SW1Uc3ZvbmpZOG1hUys5bGhhRjhQ?=
 =?utf-8?B?YXFOZGRXdm9UTi9DUTRHYXF0M2N3Tjg1TldibHBPd3lKUDhSb0phc2JMMjly?=
 =?utf-8?B?K0swL0RNNitUNjExOGs1bGtQd01iWXFIN1grS3BuT3g0L0lBbHcwK3lXeEpp?=
 =?utf-8?B?S1RmMHNkTzBwZWlIalJESjgwcGtsbGY3ZFdibVNsa3lCeXdEYzlmRFI3cFBB?=
 =?utf-8?B?Qit3N211Y3pkdWJUUDlMS21lWWllZm1aZlVwWnlzM2R3UUc2bENRcDJDaEc2?=
 =?utf-8?B?OE1CcDI2emhoa0ozWE1hUFdYZXc3SDRndmxqMVNNRTdkdzFxUUpmYmRUemxY?=
 =?utf-8?B?WGpua3Z5Wnd2OVhIZDQvVmZiY1I4MGZnQW9OUzFvTjRFTkJBdGlEdHkwd3hF?=
 =?utf-8?B?ZmpYbWxFVGNQa09CSlprN1JZUEIyK2dVaVQvUkZSTkhrODAzcGhzTUROQXI0?=
 =?utf-8?B?aUZnU2xUNmhudjV3QlhyWThzQTY5WFh2Mk43REU2Y2IrVGJ0OW8xU2V3TmNN?=
 =?utf-8?B?YXFaVmxBQUMveUlFS3ZqcFQwK2tUc204WXNIWkRvdWxYais1am8xaVpwOWZE?=
 =?utf-8?B?YUpPWGp4MkdncFRuZk1SbXRaWTZzbWJQS2tobTNxa3RQcFpJT0JqUGhnUVdo?=
 =?utf-8?B?TERFRXhKL0prUEtVUnJPZkphemRhSXdOcE5SK0VqcXNrNVdhWm52VzI1OUtJ?=
 =?utf-8?B?aG9taHpjclRlK0lrSU9tUjlBa2tudldtcW9TcHdnNWZRSHlZUGpHb0l0cGxz?=
 =?utf-8?B?bGF4b203aURRR0JYUjM1QUkxT0srRGZyRTh6azAvVjEzYm9VbkdHZDZ5ZEpu?=
 =?utf-8?B?dnVYYTRFcW1aQ3d6Q1FMRENMNDJacmxwVG1SSmFXR0NYdThkczk4dm5BY2JN?=
 =?utf-8?B?WGtOMkdvT1Q5RHB0dTRhUGowL3FuMU1vTjgwZ3FaM3VHVzQ4TFhjNzRjTVhJ?=
 =?utf-8?B?dSszUldFbVN2U3lBUGdHZ2lPT2p2UTZWRC9WemVNQmVta3ZKYmEyS1hFZWdt?=
 =?utf-8?B?VytKN0JzMnZ6N3ZZNVFFSnZ1RWpVYm0wNWZaTnk0SGZtUVlPbFNPZE9oSVor?=
 =?utf-8?B?TzlLdFBCKzlUZG9yVnpnUUZ6L0ZTbFlpQi95UDZRaEdrUDlsK0JIcDJYZVJ2?=
 =?utf-8?B?ZGx0TVZKcmdqSG9PRllheXlIclhYaDdPbGtaY2xhS2MwS3E0Zjl1SWRUSDY2?=
 =?utf-8?B?dmFHYmpuakNHZFRNekNZVlBoQ3RlUlhiZFZsUHFya2c4dGo1MHpSUmZZc3Bq?=
 =?utf-8?B?ZU41R0o5L2hCMVkwcngxZUFrSmsvb3lLcVNWZ0x0MUg4OEEyd1FvN2dYajBD?=
 =?utf-8?B?K3hreUxLYkY4Y2ovMWpWLzZKaDdOZFZSN0xocWl5TTF6VjZJN3hidGhIcWVO?=
 =?utf-8?B?c1A4aE81cEhVOEFLNzN4RzdERFprZGhPMFBlZ3RDVmlTQ1V6RjN3QW5GQkRi?=
 =?utf-8?B?SUVEMTFNTm4vdkhJcDl4YUFtOUc2aW8wZGpqMEFnemxhUDZLWjBkMFRhbTFL?=
 =?utf-8?B?ODIramxyeHlvY2NtQUl2RENjVDFrVlB6NW1CS1NvYWhDUUM1ckloUjRUNWV3?=
 =?utf-8?B?cmhSZVhUQTVMMmZISVlETjBod3JKaFRlM0FNMFZQd2JTdWdlTTVUcTJ6OTl2?=
 =?utf-8?B?eU9hTk5aVnNRMXNiM2RPeTBHYzhvblA5TXp1VVgvdFJuZWpOc1JZRXJ4anBO?=
 =?utf-8?B?TG5sWWdBUGxlWUdUemFpZG9FUjQrNVBjVXhKTng5U3J4N3k2OXBwczdUR0xN?=
 =?utf-8?B?eWNGSy9kdkxLNkFHVWUxWG90cks3aVZlR2x2QVRESDZYVitFVXpZbHprOVpa?=
 =?utf-8?B?Z21SbVlibUVOaDVHdUZoNE95YjROWm5DbXhwUW40aFZCTXEyYXIxcW96L2x3?=
 =?utf-8?B?TUtiVDRtWHNWZmdCOVFRdW9OeFdHaEFkb05rSzRuWG92T1ZTdUpheE4wbmQ4?=
 =?utf-8?B?amVITFBBSnlsUzFSTW5tSi9IY2hmQktyM1ZJK3pMbXBzdmZjZG9DbDF5N1Fi?=
 =?utf-8?Q?tkK43f2CRZP/7iOn+Pa3rcriA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410f915d-0a5a-4f45-c3ba-08db778765f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 03:26:01.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvOqrxqYCQcR3JTvAgekChKnz33ITeTnQ9rvE7WbLj5q9dJsWNI9zMRyFy43GCubH7OVelavL3Hj4rR4D2WjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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

> On Tue, Jun 27, 2023 at 8:49=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
>>
>> On Mon, Jun 26, 2023 at 09:23:20PM -0700, Suren Baghdasaryan wrote:
>> > migration_entry_wait does not need VMA lock, therefore it can be
>> > dropped before waiting.
>>
>> Hmm, I'm not sure..
>>
>> Note that we're still dereferencing *vmf->pmd when waiting, while *pmd i=
s
>> on the page table and IIUC only be guaranteed if the vma is still there.
>> If without both mmap / vma lock I don't see what makes sure the pgtable =
is
>> always there.  E.g. IIUC a race can happen where unmap() runs right afte=
r
>> vma_end_read() below but before pmdp_get_lockless() (inside
>> migration_entry_wait()), then pmdp_get_lockless() can read some random
>> things if the pgtable is freed.
>
> That sounds correct. I thought ptl would keep pmd stable but there is
> time between vma_end_read() and spin_lock(ptl) when it can be freed
> from under us. I think it would work if we do vma_end_read() after
> spin_lock(ptl) but that requires code refactoring. I'll probably drop
> this optimization from the patchset for now to keep things simple and
> will get back to it later.

Oh thanks Peter that's a good point. It could be made to work, but agree
it's probably not worth the code refactoring at this point so I'm ok if
the optimisation is dropped for now.

>>
>> >
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > ---
>> >  mm/memory.c | 14 ++++++++++++--
>> >  1 file changed, 12 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index 5caaa4c66ea2..bdf46fdc58d6 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
>> >       if (unlikely(non_swap_entry(entry))) {
>> >               if (is_migration_entry(entry)) {
>> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
>> > -                                          vmf->address);
>> > +                     /* Save mm in case VMA lock is dropped */
>> > +                     struct mm_struct *mm =3D vma->vm_mm;
>> > +
>> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
>> > +                             /*
>> > +                              * No need to hold VMA lock for migratio=
n.
>> > +                              * WARNING: vma can't be used after this=
!
>> > +                              */
>> > +                             vma_end_read(vma);
>> > +                             ret |=3D VM_FAULT_COMPLETED;
>> > +                     }
>> > +                     migration_entry_wait(mm, vmf->pmd, vmf->address)=
;
>> >               } else if (is_device_exclusive_entry(entry)) {
>> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
>> >                       ret =3D remove_device_exclusive_entry(vmf);
>> > --
>> > 2.41.0.178.g377b9f9a00-goog
>> >
>>
>> --
>> Peter Xu
>>

