Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C46709AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjESPEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjESPEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:04:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17C132
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 08:04:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-561c1ae21e7so45790327b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684508660; x=1687100660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDD6929/PsmGdeBcOFBnrXj2UmWCz3zY8a5EUQcTCVg=;
        b=uk9LpPdT+v2YnySfZPHNvYFvP3XUZObHdokf+Lhsg8rrmlV/AHtuG53/0mNLuBdZgy
         Hlh7t9+alYP5vYECOdZn0X8J1vZJp1SkgoGQazEHdxv9yRmvzSuoGuftV5jBXPunUnPh
         D1kZTpNnxcW/q6J3E56ZtQPCEBGolXzO0uCzxehQLHRW+hvZl/FCYIJlaXKgj66OsMV1
         n4nG2YMwBgfStXO9hU+KOSt2o2LjjWSZFVILD/aSA1pslgcT/LLQ6lk0s9dwNuRcGEbU
         xoTD7zAwLmXQwxzFK6x/uiPxj7PqIfvGefbrWIPKQYGNmZOI2aX5lWG/sj+eNYITnJBu
         0v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508661; x=1687100661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDD6929/PsmGdeBcOFBnrXj2UmWCz3zY8a5EUQcTCVg=;
        b=RgnpWwwAirZuZalCazbnA7mNHsVJrumvNnsFaCcLZMwPLqwP/e+s/1xvJwd+oFAkPg
         EneH2VkLrVrsC31+H4FFnkJvdLNuT1EOUcHqW4FqsRSZkiU7MdQdnxtYfV+BsKbU5nFr
         /CNweUQNvm9FY0SIgQ0kmIR8VoIbj7whMiZrJV3LSqGNLKQEURQu5ylqv3/ag/xIOfuY
         CBPdJIwqfK3G4LG7BrB82ANr0GRSebPvCQ+ff+OdeFZ0gJR5nQKIUo5/x4YtdOSYFXbl
         yJIRGVunuMV1OcX92zMUbMZphbe1Nw/rqi7ktSfBvGOqB6+9Xm6/gMZCd/nAdIDlZILU
         7vuA==
X-Gm-Message-State: AC+VfDxrybIicYiGAIvmpCxPvaqPCS1A9vm/U/t87QTX+OU9S8H6uYBo
        JI5MbVFuH8JI+FeG/H0rYuTnEa/U/HJ5iIzdjxxYKA==
X-Google-Smtp-Source: ACHHUZ6hgP8/+eeHDFwygDimQd8NE4HBu+PZcJJxwPp6d7y9EoK810kGjbxXl/SD8C3mvZ+ZbsSYsPmkkMXGf2kVPHU=
X-Received: by 2002:a0d:f407:0:b0:559:ea89:7c2c with SMTP id
 d7-20020a0df407000000b00559ea897c2cmr1903416ywf.33.1684508660474; Fri, 19 May
 2023 08:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n> <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n> <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com>
In-Reply-To: <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 19 May 2023 08:04:09 -0700
Message-ID: <CACw3F50qvf13-fUx4XrL1jkhbo2mQ5sPV=E_i7_Gt2NaWXJfnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 1:38=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.05.23 22:38, Axel Rasmussen wrote:
> > On Thu, May 18, 2023 at 9:05=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> >>
> >> On Wed, May 17, 2023 at 05:43:53PM -0700, Jiaqi Yan wrote:
> >>> On Wed, May 17, 2023 at 3:29=E2=80=AFPM Axel Rasmussen <axelrasmussen=
@google.com> wrote:
> >>>>
> >>>> On Wed, May 17, 2023 at 3:20=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> >>>>>
> >>>>> On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> >>>>>> On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> >>>>>>> On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
> >>>>>>> <axelrasmussen@google.com> wrote:
> >>>>>>>>
> >>>>>>>> So the basic way to use this new feature is:
> >>>>>>>>
> >>>>>>>> - On the new host, the guest's memory is registered with userfau=
ltfd, in
> >>>>>>>>    either MISSING or MINOR mode (doesn't really matter for this =
purpose).
> >>>>>>>> - On any first access, we get a userfaultfd event. At this point=
 we can
> >>>>>>>>    communicate with the old host to find out if the page was poi=
soned.
> >>>>>>>> - If so, we can respond with a UFFDIO_SIGBUS - this places a swa=
p marker
> >>>>>>>>    so any future accesses will SIGBUS. Because the pte is now "p=
resent",
> >>>>>>>>    future accesses won't generate more userfaultfd events, they'=
ll just
> >>>>>>>>    SIGBUS directly.
> >>>>>>>
> >>>>>>> I want to clarify the SIGBUS mechanism here when KVM is involved,
> >>>>>>> keeping in mind that we need to be able to inject an MCE into the
> >>>>>>> guest for this to be useful.
> >>>>>>>
> >>>>>>> 1. vCPU gets an EPT violation --> KVM attempts GUP.
> >>>>>>> 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS=
.
> >>>>>>> 3. KVM finds that GUP failed and returns -EFAULT.
> >>>>>>>
> >>>>>>> This is different than if GUP found poison, in which case KVM wil=
l
> >>>>>>> actually queue up a SIGBUS *containing the address of the fault*,=
 and
> >>>>>>> userspace can use it to inject an appropriate MCE into the guest.=
 With
> >>>>>>> UFFDIO_SIGBUS, we are missing the address!
> >>>>>>>
> >>>>>>> I see three options:
> >>>>>>> 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I thin=
k
> >>>>>>> this is pointless.
> >>>>>>> 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have=
 a
> >>>>>>> UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SI=
GBUS
> >>>>>>> instead of VM_FAULT_RETRY. We will keep getting userfaults on rep=
eated
> >>>>>>> accesses, just like how we get repeated signals for real poison.
> >>>>>>> 3. Use this in conjunction with the additional KVM EFAULT info th=
at
> >>>>>>> Anish proposed (the first part of [1]).
> >>>>>>>
> >>>>>>> I think option 3 is fine. :)
> >>>>>>
> >>>>>> Or... option 4) just to use either MADV_HWPOISON or hwpoison-injec=
t? :)
> >>>>>
> >>>>> I just remember Axel mentioned this in the commit message, and just=
 in case
> >>>>> this is why option 4) was ruled out:
> >>>>>
> >>>>>          They expect that once poisoned, pages can never become
> >>>>>          "un-poisoned". So, when we live migrate the VM, we need to=
 preserve
> >>>>>          the poisoned status of these pages.
> >>>>>
> >>>>> Just to supplement on this point: we do have unpoison (echoing to
> >>>>> "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
> >>>
> >>> If I read unpoison_memory() correctly, once there is a real hardware
> >>> memory corruption (hw_memory_failure will be set), unpoison will stop
> >>> working and return EOPNOTSUPP.
> >>>
> >>> I know some cloud providers evacuating VMs once a single memory error
> >>> happens, so not supporting unpoison is probably not a big deal for
> >>> them. BUT others do keep VM running until more errors show up later,
> >>> which could be long after the 1st error.
> >>
> >> We're talking about postcopy migrating a VM has poisoned page on src,
> >> rather than on dst host, am I right?  IOW, the dest hwpoison should be
> >> fake.

Yes, for this we are on the same page. The scenario I want to describe is..=
.

> >>
> >> If so, then I would assume that's the case where all the pages on the =
dest
> >> host is still all good (so hw_memory_failure not yet set, or I doubt t=
he

...target VM can get hw error anytime: before precopy (if cloud
provider is not carefully monitoring the machine health), during
precopy from src to target, during src blackout, during postcopy,
after migration done, and keep running on host. Both MADV_HWPOISON[1]
and hwpoison-inject[2] are subject to hw_memory_failure, so they just
seems unreliable to me: if target is in memory error trouble before or
in early phase of migration, we lose the unpoison feature in kernel.

[1] https://github.com/torvalds/linux/blob/2d1bcbc6cd703e64caf8df314e3669b4=
786e008a/mm/madvise.c#L1130
[2] https://github.com/torvalds/linux/blob/2d1bcbc6cd703e64caf8df314e3669b4=
786e008a/mm/hwpoison-inject.c#L51

> >> judgement of being a migration target after all)?
> >>
> >> The other thing is even if dest host has hw poisoned page, I'm not sur=
e
> >> whether hw_memory_failure is the only way to solve this.
> >>
> >> I saw that this is something got worked on before from Zhenwei, David =
used
> >> to have some reasoning on why it was suggested like using a global kno=
b:
> >>
> >> https://lore.kernel.org/all/d7927214-e433-c26d-7a9c-a291ced81887@redha=
t.com/
> >>
> >> Two major issues here afaics:
> >>
> >>    - Zhenwei's approach only considered x86 hwpoison - it relies on kp=
te
> >>      having !present in entries but that's x86 specific rather than ge=
neric
> >>      to memory_failure.c.
> >>
> >>    - It is _assumed_ that hwpoison injection is for debugging only.
> >>
> >> I'm not sure whether you can fix 1) by some other ways, e.g., what if =
the
> >> host just remember all the hardware poisoned pfns (or remember
> >> soft-poisoned ones, but then here we need to be careful on removing th=
em
> >> from the list when it's hwpoisoned for real)?  It sounds like there's
> >> opportunity on providing a generic solution rather than relying on
> >> !pte_present().
> >>
> >> For 2) IMHO that's not a big issue, you can declare it'll be used in !=
debug
> >> but production systems so as to boost the feature importance with a re=
al
> >> use case.
> >>
> >> So far I'd say it'll be great to leverage what it's already there in l=
inux
> >> and make it as generic as possible. The only issue is probably
> >> CAP_ADMIN... not sure whether we can have some way to provide !ADMIN
> >> somehow, or you can simply work around this issue.

I don't think CAP_ADMIN is something we can work around: a VMM must be
a good citizen to avoid introducing any vulnerability to the host or
guest.

On the other hand, "Userfaults allow the implementation of on-demand
paging from userland and more generally they allow userland to take
control of various memory page faults, something otherwise only the
kernel code could do." [3]. I am not familiar with the UFFD internals,
but our use case seems to match what UFFD wants to provide: without
affecting the whole world, give a specific userspace (without
CAP_ADMIN) the ability to handle page faults (indirectly emulate a
HWPOISON page (in my mind I treat it as SetHWPOISON(page) +
TestHWPOISON(page) operation in kernel's PF code)). So is it fair to
say what Axel provided here is "provide !ADMIN somehow"?

[3]https://docs.kernel.org/admin-guide/mm/userfaultfd.html

> >
> > As you mention below I think the key distinction is the scope - I
> > think MADV_HWPOISON affects the whole system, including other
> > processes.
> >
> > For our purposes, we really just want to "poison" this particular
> > virtual address (the HVA, from the VM's perspective), not even other
> > mappings of the same shared memory. I think that behavior is different
> > from MADV_HWPOISON, at least.
>
> MADV_HWPOISON really is the wrong interface to use. See "man madvise".
>
> We don't want to allow arbitrary users to hwpoison+offline absolutely
> healthy physical memory, which is what MADV_HWPOISON is all about.
>
> As you say, we want to turn an unpopulated (!present) virtual address to
> mimic like we had a MCE on a page that would have been previously mapped
> here: install a hwpoison marker without actually poisoning any present
> page. In fact, we'd even want to fail if there *is* something mapped.
>
> Sure, one could teach MADV_HWPOISON to allow unprivileged users to do
> that for !present PTE entries, and fail for unprivileged users if there
> is a present PTE entry. I'm not sure if that's the cleanest approach,
> though, and a new MADV as suggested in this thread would eventually be
> cleaner.
>
> --
> Thanks,
>
> David / dhildenb
>
