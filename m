Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867E6F7C2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 07:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjEEFDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 01:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjEEFDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 01:03:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6996914E5F;
        Thu,  4 May 2023 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683263022; x=1714799022;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=S4vyJou19RgYmzT65fd6fS70YFP8NSQ5x98Uj9rNLoc=;
  b=hPAiZ+9fxNHHXunjanNV+jW5SONHRIMZ5LCkIP9yOM7TkR+2fhgfLUYY
   WOUTaQFeEk+Yr/y5x18eL7S7D+J5tPYrCN9qQU36dTrRDIC8AjB5qcEKQ
   GVXvgC4KiKFsC36aOFfBVj5bSn5sFBjjxLna2kVM3qE8kLcJwOoEFXyjC
   /qHeTpi+8a4G6f90BhtrGZzt7Y8hqvDW9vN1gfGePTq1fqTiuARr1j1Ng
   3gKlgeCyXlIwb/0sguF0w7Qlt7UrrvoAYYRoGmDYYqaXVCoTFLhX4CSRb
   5BnHoFpvvyjr+/raEKCIs8+2DX4eA7oNm/L0Y09DARtW+TPwoiBznvxW0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="338315031"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="338315031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 22:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841521484"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841521484"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 22:03:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page
 is uncontended
In-Reply-To: <CAJD7tkadk9=-PT1daXQyA=X_qz60XOEciXOkXWwPqxYJOaWRXQ@mail.gmail.com>
        (Yosry Ahmed's message of "Wed, 3 May 2023 13:57:17 -0700")
References: <20230501175025.36233-1-surenb@google.com>
        <ZFBvOh8r5WbTVyA8@casper.infradead.org>
        <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
        <ZFCB+G9KSNE+J9cZ@casper.infradead.org>
        <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
        <ZFEmN6G7WRy59Mum@casper.infradead.org>
        <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
        <ZFGPLXIis6tl1QWX@casper.infradead.org>
        <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
        <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com>
        <CAJuCfpE9dVK01c-aNT_uwTC=m8RSdEiXsoe6XBR48GjL=ezsmg@mail.gmail.com>
        <CAJD7tkadk9=-PT1daXQyA=X_qz60XOEciXOkXWwPqxYJOaWRXQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 05 May 2023 13:02:27 +0800
Message-ID: <87wn1nbcbg.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Wed, May 3, 2023 at 12:57=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
>>
>> On Wed, May 3, 2023 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
>> >
>> > On Tue, May 2, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
>> > >
>> > > On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
>> > > >
>> > > > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
>> > > > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@inf=
radead.org> wrote:
>> > > > > >
>> > > > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan w=
rote:
>> > > > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy=
@infradead.org> wrote:
>> > > > > > > >
>> > > > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasary=
an wrote:
>> > > > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <w=
illy@infradead.org> wrote:
>> > > > > > > > > >
>> > > > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghda=
saryan wrote:
>> > > > > > > > > > > +++ b/mm/memory.c
>> > > > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struc=
t vm_fault *vmf)
>> > > > > > > > > > >       if (!pte_unmap_same(vmf))
>> > > > > > > > > > >               goto out;
>> > > > > > > > > > >
>> > > > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
>> > > > > > > > > > > -             ret =3D VM_FAULT_RETRY;
>> > > > > > > > > > > -             goto out;
>> > > > > > > > > > > -     }
>> > > > > > > > > > > -
>> > > > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
>> > > > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
>> > > > > > > > > > >               if (is_migration_entry(entry)) {
>> > > > > > > > > >
>> > > > > > > > > > You're missing the necessary fallback in the (!folio) =
case.
>> > > > > > > > > > swap_readpage() is synchronous and will sleep.
>> > > > > > > > >
>> > > > > > > > > True, but is it unsafe to do that under VMA lock and has=
 to be done
>> > > > > > > > > under mmap_lock?
>> > > > > > > >
>> > > > > > > > ... you were the one arguing that we didn't want to wait f=
or I/O with
>> > > > > > > > the VMA lock held?
>> > > > > > >
>> > > > > > > Well, that discussion was about waiting in folio_lock_or_ret=
ry() with
>> > > > > > > the lock being held. I argued against it because currently w=
e drop
>> > > > > > > mmap_lock lock before waiting, so if we don't drop VMA lock =
we would
>> > > > > > > be changing the current behavior which might introduce new
>> > > > > > > regressions. In the case of swap_readpage and swapin_readahe=
ad we
>> > > > > > > already wait with mmap_lock held, so waiting with VMA lock h=
eld does
>> > > > > > > not introduce new problems (unless there is a need to hold m=
map_lock).
>> > > > > > >
>> > > > > > > That said, you are absolutely correct that this situation ca=
n be
>> > > > > > > improved by dropping the lock in these cases too. I just did=
n't want
>> > > > > > > to attack everything at once. I believe after we agree on th=
e approach
>> > > > > > > implemented in https://lore.kernel.org/all/20230501175025.36=
233-3-surenb@google.com
>> > > > > > > for dropping the VMA lock before waiting, these cases can be=
 added
>> > > > > > > easier. Does that make sense?
>> > > > > >
>> > > > > > OK, I looked at this path some more, and I think we're fine.  =
This
>> > > > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set =
for
>> > > > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
>> > > > > > (both btt and pmem).  So the answer is that we don't sleep in =
this
>> > > > > > path, and there's no need to drop the lock.
>> > > > >
>> > > > > Yes but swapin_readahead does sleep, so I'll have to handle that=
 case
>> > > > > too after this.
>> > > >
>> > > > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O any=
where
>> > > > in swapin_readahead()?  It all looks like async I/O to me.
>> > >
>> > > Hmm. I thought that we have synchronous I/O in the following paths:
>> > >     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
>> > >     swapin_readahead()->swap_vma_readahead()->swap_readpage()
>> > > but just noticed that in both cases swap_readpage() is called with t=
he
>> > > synchronous parameter being false. So you are probably right here...
>> >
>> > In both swap_cluster_readahead() and swap_vma_readahead() it looks
>> > like if the readahead window is 1 (aka we are not reading ahead), then
>> > we jump to directly calling read_swap_cache_async() passing do_poll =3D
>> > true, which means we may end up calling swap_readpage() passing
>> > synchronous =3D true.
>> >
>> > I am not familiar with readahead heuristics, so I am not sure how
>> > common this is, but it's something to think about.
>>
>> Uh, you are correct. If this branch is common, we could use the same
>> "drop the lock and retry" pattern inside read_swap_cache_async(). That
>> would be quite easy to implement.
>> Thanks for checking on it!
>
>
> I am honestly not sure how common this is.
>
> +Ying who might have a better idea.

Checked the code and related history.  It seems that we can just pass
"synchronous =3D false" to swap_readpage() in read_swap_cache_async().
"synchronous =3D true" was introduced in commit 23955622ff8d ("swap: add
block io poll in swapin path") to reduce swap read latency for block
devices that can be polled.  But in commit 9650b453a3d4 ("block: ignore
RWF_HIPRI hint for sync dio"), the polling is deleted.  So, we don't
need to pass "synchronous =3D true" to swap_readpage() during
swapin_readahead(), because we will wait the IO to complete in
folio_lock_or_retry().

Best Regards,
Huang, Ying

>>
>>
>> >
>> > > Does that mean swapin_readahead() might return a page which does not
>> > > have its content swapped-in yet?
>> > >
