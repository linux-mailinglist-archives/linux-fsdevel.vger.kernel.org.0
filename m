Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E76E553D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDQXdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDQXdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:33:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07105125;
        Mon, 17 Apr 2023 16:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8OJiS3t8nxtO8PHsTj4o1QlbdtV5jPv95Bce5dqt16N37y/qVMIdqFHIk9hOZAw2s85xB2m9st7lU93LYBdvf1P/tObAlnM9u6XUcXOp1rbOAhFKvP1z/JTp1MSPmv8/K1GcOrQd0QbUZaoHtb2aRJAzU4a31k2bv7KZnnnIBl9axWmie7ki5TBrNg1YGBzRSWEqtDRZ/m4G3PgtyZD2+nrwiRDzR4djjtaJB5jKGRBlOWvyJfvwgHYUAOtQMWoKrGTAvZsJRhe6XV3VXm7F/Re3UwcaFqmLw9FYC2DmXmU5kLMIDlnxzjXUbgaC84VIevlhv2rBMEhU73OGB3b7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDDM4S2zp0QWsvX0dFApkg5LcPehwraTYP/lE8k0b8Q=;
 b=KzXyKjGIkru84CFw3xGCafT3uL43V62d0vOS1aXupDk+jlUwehWszhq1p5ibNmqpAXn5q89DOOzmVqwYDL9mgbkFvrDkCUcuSd5bdGtp0vUHj5ONS5LJsP3uiPnIOGx+a3lAWkRc+zDeCsMSijoOGUv9gpatzy77jCKOKFo5YgsZksoBTKRf7nChUkdLdOqGJzJtCmwRSTiPxKAbftk/df7RwHWlhd6vDkzbF2SM7LUAlZUj/ddQpqawP5WXb7+S/ATNbtMUEfhGA1MHFdYcaZJWduLF5w/nKOTCMnGUL3iaQbU3jjwZUXOAQzXdJ22i48WgoAAnDjcDGbQYG6a2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDDM4S2zp0QWsvX0dFApkg5LcPehwraTYP/lE8k0b8Q=;
 b=gYnaC8zpfr2/GW3R00ZhjxgEt456WBj8xO9dJTqeg9GbOu4Uuw4Id232avu9sl5yM50Q0HuS+0hu80h17Fn+OpHnuu8o5IGdVqjSOR82yYtNHrNl0W4NbV3o9Ef1FoG0eb5Ms8eIF3YxZ1MhHGTZV4YzRTfoeIqBbkhZWIS6y0j4m8ADxcBkYgo99f37tuTRGd6qeyuxuYfl1hiLdiLQ+Mt0dKged04heYJdnXhXF+L9mcpfwjhoY9/GTwMMDiFV0effhqT5kTcj+vXbI/6h1v1RRdBkwAKLFz2PK6QF9wD7dZkp7dc4hLOGuc8rOVQs0O5zmpWTrpxTqCUF9Oz3Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 23:33:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 23:33:37 +0000
References: <20230414180043.1839745-1-surenb@google.com>
 <ZDmetaUdmlEz/W8Q@casper.infradead.org> <87sfczuxkc.fsf@nvidia.com>
 <CAJuCfpEV1OiM423bykYQTxDC1=bQAqhAwd5fiKYifsk=seP6yw@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page
 can be locked
Date:   Tue, 18 Apr 2023 09:33:48 +1000
In-reply-to: <CAJuCfpEV1OiM423bykYQTxDC1=bQAqhAwd5fiKYifsk=seP6yw@mail.gmail.com>
Message-ID: <877cuaulrm.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b9e7e2-6328-4606-520d-08db3f9c2aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mljGGyUi5FJFakg4ffHa5uSmCZ1hWe0jGx5IMOAF5m+YfPIPjTkION7OrpY8+6x6/hWhJXpBpiloef7KbBbx26kXesGRTXFh4tG5o03kG0PJhf4/NGESRpKvi7anJWxCd+hL76Ko2oTrbpl4Gei8Vwmz81aezv5tqWQLXAF3uibJfaF2SSyytkUWUw5RN4Q4pSk12x2nHmegQV4YNrldn2Tj6seqhqGAz0sjPiYcyv/qzkU5gbceQ59JnP7DrYeM+agN58vZEMKatfnwpv/EyIbr5gugZk3tXa0Nf8DGk3STOz48GnqJ/zAt7ZIs7sOBms98XLPFKUire4iFRCqg7qSU3sTC29nEfboxzmBuriWxhNpU23jNyQW9/RdzweEpqt2aZ8EgpwDW95I6+RzFxm1NTlhpMsl2+jGT8DTbY6y5mnC52/34Uj85SaazIp3SXhvgHGyv3QvwESRGLV+ywZnZEL0oul18fDKnuW54VGyuKN1sDPNpAbs+IhwYhZ+P5PW4tFNKthxfsdbImwL7Ql0r+JRa7MRno9wF9NW/yLwRwZWbpBfKPW1vlAHOw5Hn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(53546011)(26005)(6506007)(6512007)(186003)(66899021)(83380400001)(2616005)(6486002)(5660300002)(478600001)(38100700002)(41300700001)(6666004)(316002)(8676002)(8936002)(86362001)(66946007)(4326008)(36756003)(66556008)(6916009)(2906002)(66476007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdsT2oxeU9XakNRLytSc2EvNk5iWWdxbDZIbHUyVlRWVlp4M0NrdktWV2NT?=
 =?utf-8?B?a01qQklUaTNJNmswODVXd2UvbCsvSzFjdmc4cW9COHNxMjdVSmh1TURwRGFW?=
 =?utf-8?B?dHBraFI3TUxRZmczV2xlTFo0UFVoU3ZrNmpEdG4rakpQVTF3TUVHeDJRYWlI?=
 =?utf-8?B?MWFSVWs0OGpkU09oN1YyRHdUbVpWUzVnVEdoNDlTOC9YdktlRmJvTy9pdjY3?=
 =?utf-8?B?MlNSeHU3WE85Z1RXQjk3eE1MQzdjbC83eUlmVktIS3lIWFduYXlzR3BOQmRo?=
 =?utf-8?B?NGRaZGJsZFVXMm1WTVdrQ3doZ05WWk14THdQU1BaQURBa0orbEdQMUZuY1M4?=
 =?utf-8?B?YVlLUExzZDF5c05JNzBJT1lmaHRlV0pyaXBaZFpHVk0rUklJc005RE1xbko2?=
 =?utf-8?B?WDc4WnB6eS9Vd25CaXYwdERzdW0zbFJ4UU9NUk5mM3ZHMlZGRThmTmVLZ2hF?=
 =?utf-8?B?aGtpV0h6LzRZMGN4NWdFd1VYOWxOcXdoS3JwdHdMazlIZVFVUTRJQTkxcm44?=
 =?utf-8?B?N3ZxRnM5U1hyWmJvNStVaC9XM2o3NllWVEZ0b1MvZGZwTm40VGNocG5UYlhs?=
 =?utf-8?B?b1NyUk9lSWpZQWlzd053bWIxMW9lL09HTno4bUs4V3dSUXFTM1VBLzVZM0ZO?=
 =?utf-8?B?RXprSUtZVllEU2dmQ1JaNXNnRkdzUjI5LzFSSzc0VmVkMGJIUWJKdExvQkdi?=
 =?utf-8?B?QjJPbHl3ckEzNWcrRDlGVlkvS3VZTnRHTGhHRUFHcy9LRWhsQlBpMzBMRmd6?=
 =?utf-8?B?VUxtZTJMUW96MGNHdGdkMExoa1VWbTdIakhFZTBlMjdRbWJpOHZXMVQ0SURL?=
 =?utf-8?B?clVzaHUzVC9tWmVUOVFPTE9EcWVMTzhudHRvc2hlL2pSOXRPd0tiM0ZYb2la?=
 =?utf-8?B?ZXlLdWQvdzE2WmNKZFpDTXlZQ1lWR2Vqc2hBaGgxaWNCMFZTZTJTaUZOQ3Nk?=
 =?utf-8?B?RmpFNFNrSDMrdU5vWUxlbUY2M1pmK1pOTnNmTWwwbnU1RTZDTFdDVzZWcS9n?=
 =?utf-8?B?RjRMWG10MmdxLzVBWEkzTmlXWWh2YVNvdVdNcHpzWXBjWDBBVS9TN2FxUEVq?=
 =?utf-8?B?dmVBUTUxUjl5S1lndVdpQkRuK20xem02SUJmZDhCbk1ZbzdBK3dEcnVxWHM1?=
 =?utf-8?B?aHR1ZERSRXdCNlQrNEhiRnk3Ti9ScE5GMzAyMnZ0ak1aaFpuVWthdWxEalhp?=
 =?utf-8?B?d2d1d1crQmhCOEZxU0pBdHI2a29rMW9JdlN4eDlwNzI5bUVEUXhsMUtNenJV?=
 =?utf-8?B?UEQvT29zZ0N4aVZTK2FsVUFoN2MzQ3ozVlRZN1lDMUlmYWJNV1FibFE4K3U5?=
 =?utf-8?B?bk02QXVhRlFQajA5RnpnTmVaeUVHRk5qZG14My9iSDJmekJVWituK3gwZmc4?=
 =?utf-8?B?T3hDaGtUSldyeXJYcEZ6ZllWRlFxQzBzTGx3TTUvVWJIOUNJa3VZdFVaZ3Np?=
 =?utf-8?B?VTZOSUVQQUpzSHZ4TitoZVM5VFQ4SHFuZ0d4R1IrSjdHMlRwMENPOUlnM0RV?=
 =?utf-8?B?bEV5UUxXeGZMS1k3aHFOQkEzSERGL1pqOEE4ZmJ0SFIvc0V3L1l5R1FicnZK?=
 =?utf-8?B?b3daSzcvbS8yY0xvV3c4d0dWWEVvWnd3enVWQnhraG0xZzBmY1RWNWJNcFZN?=
 =?utf-8?B?eDJweHlUUDR2MnprSUNQNlJEaFNlUUdNVDhQTmwveGQ4a3o3MWNXa1pNcHFp?=
 =?utf-8?B?OVpSeDJBZGpCeUordWtyQXp5NDZ5R09ROXpGaVJOL3VZRlcxL0xJS3hQUWsw?=
 =?utf-8?B?MWpWYlJYN0NXUFFuUWhRVWhZMlFVM202dGtEazUvdndNVFlGcEl2NjkxeWRT?=
 =?utf-8?B?OWJETnhzL2NHd0VLeG1lRDVpMnFhZnhxSEJFSEIzNlpxK0M1T1J1OS9Lb3py?=
 =?utf-8?B?MDVhWk9JL1hBN0RPbEl4SEJqaFJzMFI5ejNLZzFGZmxaMWdHYUljMHg0WVRM?=
 =?utf-8?B?RUExMGhHOUw0Y1grS0hnNU4wSWlsWjExcVU3WGpjM1FDVHVaZkVURmEwWXpT?=
 =?utf-8?B?cS85SnUybkZyU2J0K1lXaWVHSkU5UGRiMkJ0a2JHcjNNTUNxYkV3bVcxRWN2?=
 =?utf-8?B?THFDSVNIYytZanh0UVdFQTJUVWdsK0hHUmVZdnhWSzJtL1ZYWi9zRkVmVk40?=
 =?utf-8?Q?YqQOYLo1lwcSQritb8Rb/QOtg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b9e7e2-6328-4606-520d-08db3f9c2aeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:33:37.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EznMFPNqnyBI0Eu+b+CI8IPWa81OE07pnVBVoNqLIXeL+W6nWv2c70b2pBxX2l5tac4lkiJqFsyrU0F/2hffuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Suren Baghdasaryan <surenb@google.com> writes:

> On Sun, Apr 16, 2023 at 6:06=E2=80=AFPM Alistair Popple <apopple@nvidia.c=
om> wrote:
>>
>>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>> > On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
>> >> When page fault is handled under VMA lock protection, all swap page
>> >> faults are retried with mmap_lock because folio_lock_or_retry
>> >> implementation has to drop and reacquire mmap_lock if folio could
>> >> not be immediately locked.
>> >> Instead of retrying all swapped page faults, retry only when folio
>> >> locking fails.
>> >
>> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> >
>> > Let's just review what can now be handled under the VMA lock instead o=
f
>> > the mmap_lock, in case somebody knows better than me that it's not saf=
e.
>> >
>> >  - We can call migration_entry_wait().  This will wait for PG_locked t=
o
>> >    become clear (in migration_entry_wait_on_locked()).  As previously
>> >    discussed offline, I think this is safe to do while holding the VMA
>> >    locked.
>>
>> Do we even need to be holding the VMA locked while in
>> migration_entry_wait()? My understanding is we're just waiting for
>> PG_locked to be cleared so we can return with a reasonable chance the
>> migration entry is gone. If for example it has been unmapped or
>> protections downgraded we will simply refault.
>
> If we drop VMA lock before migration_entry_wait() then we would need
> to lock_vma_under_rcu again after the wait. In which case it might be
> simpler to retry the fault with some special return code to indicate
> that VMA lock is not held anymore and we want to retry without taking
> mmap_lock. I think it's similar to the last options Matthew suggested
> earlier. In which case we can reuse the same retry mechanism for both
> cases, here and in __folio_lock_or_retry.

Good point. Agree there is no reason to re-take the VMA lock after the
wait, although in this case we shouldn't need to retry the fault
(ie. return VM_FAULT_RETRY). Just skip calling vma_end_read() on the way
out to userspace.

>>
>> >  - We can call remove_device_exclusive_entry().  That calls
>> >    folio_lock_or_retry(), which will fail if it can't get the VMA lock=
.
>>
>> Looks ok to me.
>>
>> >  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody familia=
r
>> >    with Nouveau and amdkfd could comment on how safe this is?
>>
>> Currently this won't work because drives assume mmap_lock is held during
>> pgmap->ops->migrate_to_ram(). Primarily this is because
>> migrate_vma_setup()/migrate_vma_pages() is used to handle the fault and
>> that asserts mmap_lock is taken in walk_page_range() and also
>> migrate_vma_insert_page().
>>
>> So I don't think we can call that case without mmap_lock.
>>
>> At a glance it seems it should be relatively easy to move to using
>> lock_vma_under_rcu(). Drivers will need updating as well though because
>> migrate_vma_setup() is called outside of fault handling paths so drivers
>> will currently take mmap_lock rather than vma lock when looking up the
>> vma. See for example nouveau_svmm_bind().
>
> Thanks for the pointers, Alistair! It does look like we need to be
> more careful with the migrate_to_ram() path. For now I can fallback to
> retrying with mmap_lock for this case, like with do with all cases
> today. Afterwards this path can be made ready for working under VMA
> lock and we can remove that retry. Does that sound good?

Sounds good to me. Fixing that shouldn't be too difficult but will need
changes to at least Nouveau and amdkfd (and hmm-tests obviously). Happy
to look at doing that if/when this change makes it in. Thanks.

>>
>> >  - I believe we can't call handle_pte_marker() because we exclude UFFD
>> >    VMAs earlier.
>> >  - We can call swap_readpage() if we allocate a new folio.  I haven't
>> >    traced through all this code to tell if it's OK.
>> >
>> > So ... I believe this is all OK, but we're definitely now willing to
>> > wait for I/O from the swap device while holding the VMA lock when we
>> > weren't before.  And maybe we should make a bigger deal of it in the
>> > changelog.
>> >
>> > And maybe we shouldn't just be failing the folio_lock_or_retry(),
>> > maybe we should be waiting for the folio lock with the VMA locked.
>>

