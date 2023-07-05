Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A06748B84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 20:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGESSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 14:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjGESSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E71FCD
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688581028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzsylmtcmFNsmgGBg8Pm9OUDSeIGp5f091Q7tc9LleI=;
        b=YFQOyAQ2JT+/Xfo5orFii3QgGHORMAdb5A0C6znAJFlt1BiHYzwhdstnz/pdNSC9KQ9EuF
        EgKCFqNDz94XZAiEck+9xE0EhsXLbBbTif1+kE9mXt1Ej97eD+y1Q6+AXVYZz8FJ/YwVyj
        hRhgREeygpP3tJtIXAsh6cmWRpaihdg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-NoLdV9dVNmWsbgtfatKZrw-1; Wed, 05 Jul 2023 14:17:07 -0400
X-MC-Unique: NoLdV9dVNmWsbgtfatKZrw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so15370916d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 11:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581024; x=1689185824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzsylmtcmFNsmgGBg8Pm9OUDSeIGp5f091Q7tc9LleI=;
        b=i31mQDvcm9UQeDIhHgGHMJOVOqaSRWJgGOwiSUgBmb7sPGkpDYM4SI5qjrUnPrIo4f
         ZsYFEDi7f6ak4KcZnIq2bAgkFArjBXvatoTf2Q9rw4ZwLI92YfvHngZB3M9I/mlMfZ/a
         kE8x1e8g/8LT2rgwPUSwssoQiHKSAPsBkzZfwteAUHjwjbSoIAIxLd7w5j4qZ3kIRMsQ
         C9SDGxSsPb3xhuh5VuQ2lM85djrEShi27FOci6qLY+9xoFlvCWSxuK+WgzL+Bss77SjU
         fbHOEO7pk1MvUZ92KkU/y3fSrzE0JfshKtP76biDmOfnxPifDTGPaPPjiA8yO8cXywLN
         jPFg==
X-Gm-Message-State: ABy/qLahY5kN75Ru6GI18Leu/y3ZY8Q6w4OghRxthZ+CeeFIop09eYTN
        bV+XDy67H8TxCJs4ctm3/yTV96nUybwbdyVk+mJayJ1NalgSpPesrhdTow5qvzT880ru+RHmppW
        AplZEv/cEttmB3G/2ydZ27//Ztw==
X-Received: by 2002:a0c:ea2b:0:b0:635:dfe1:c1f2 with SMTP id t11-20020a0cea2b000000b00635dfe1c1f2mr17717917qvp.0.1688581024472;
        Wed, 05 Jul 2023 11:17:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEl96/J1yNKCHluvfZQOMJkmNFqvRJ5M9uxuly3x1gZ1FBowCv3rY84RzXq6qWZEIAdEnHPdg==
X-Received: by 2002:a0c:ea2b:0:b0:635:dfe1:c1f2 with SMTP id t11-20020a0cea2b000000b00635dfe1c1f2mr17717904qvp.0.1688581024161;
        Wed, 05 Jul 2023 11:17:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4444f000000b0062439f05b87sm13920874qvt.45.2023.07.05.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:17:03 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:17:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/6] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
Message-ID: <ZKWznk3+Ry96kZ1w@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-4-axelrasmussen@google.com>
 <ZKSJNB3BbCiPxcdD@x1n>
 <CAJHvVcjfrOU5PoSoh4n1O0tmr-2bsPzinHDW5OwhCh=egk=-uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcjfrOU5PoSoh4n1O0tmr-2bsPzinHDW5OwhCh=egk=-uQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:50:34AM -0700, Axel Rasmussen wrote:
> On Tue, Jul 4, 2023 at 2:03 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jun 29, 2023 at 01:50:38PM -0700, Axel Rasmussen wrote:
> > > Previously, we had "one fault handler to rule them all", which used
> > > several branches to deal with all of the scenarios required by all of
> > > the various tests.
> > >
> > > In upcoming patches, I plan to add a new test, which has its own
> > > slightly different fault handling logic. Instead of continuing to add
> > > cruft to the existing fault handler, let's allow tests to define custom
> > > ones, separate from other tests.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-common.c |  5 ++++-
> > >  tools/testing/selftests/mm/uffd-common.h |  3 +++
> > >  tools/testing/selftests/mm/uffd-stress.c | 12 +++++++-----
> > >  3 files changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> > > index ba20d7504022..02b89860e193 100644
> > > --- a/tools/testing/selftests/mm/uffd-common.c
> > > +++ b/tools/testing/selftests/mm/uffd-common.c
> > > @@ -499,6 +499,9 @@ void *uffd_poll_thread(void *arg)
> > >       int ret;
> > >       char tmp_chr;
> > >
> > > +     if (!args->handle_fault)
> > > +             args->handle_fault = uffd_handle_page_fault;
> > > +
> > >       pollfd[0].fd = uffd;
> > >       pollfd[0].events = POLLIN;
> > >       pollfd[1].fd = pipefd[cpu*2];
> > > @@ -527,7 +530,7 @@ void *uffd_poll_thread(void *arg)
> > >                       err("unexpected msg event %u\n", msg.event);
> > >                       break;
> > >               case UFFD_EVENT_PAGEFAULT:
> > > -                     uffd_handle_page_fault(&msg, args);
> > > +                     args->handle_fault(&msg, args);
> > >                       break;
> > >               case UFFD_EVENT_FORK:
> > >                       close(uffd);
> > > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> > > index 197f5262fe0d..7c4fa964c3b0 100644
> > > --- a/tools/testing/selftests/mm/uffd-common.h
> > > +++ b/tools/testing/selftests/mm/uffd-common.h
> > > @@ -77,6 +77,9 @@ struct uffd_args {
> > >       unsigned long missing_faults;
> > >       unsigned long wp_faults;
> > >       unsigned long minor_faults;
> > > +
> > > +     /* A custom fault handler; defaults to uffd_handle_page_fault. */
> > > +     void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args);
> > >  };
> > >
> > >  struct uffd_test_ops {
> > > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > > index 995ff13e74c7..50b1224d72c7 100644
> > > --- a/tools/testing/selftests/mm/uffd-stress.c
> > > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > > @@ -189,10 +189,8 @@ static int stress(struct uffd_args *args)
> > >                                  locking_thread, (void *)cpu))
> > >                       return 1;
> > >               if (bounces & BOUNCE_POLL) {
> > > -                     if (pthread_create(&uffd_threads[cpu], &attr,
> > > -                                        uffd_poll_thread,
> > > -                                        (void *)&args[cpu]))
> > > -                             return 1;
> > > +                     if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
> > > +                             err("uffd_poll_thread create");
> >
> > irrelevant change?
> 
> Right, I'll revert this. In an earlier version I had a more
> substantial change here, and just didn't fully revert it.
> 
> >
> > >               } else {
> > >                       if (pthread_create(&uffd_threads[cpu], &attr,
> > >                                          uffd_read_thread,
> > > @@ -247,9 +245,13 @@ static int userfaultfd_stress(void)
> > >  {
> > >       void *area;
> > >       unsigned long nr;
> > > -     struct uffd_args args[nr_cpus];
> > > +     struct uffd_args *args;
> > >       uint64_t mem_size = nr_pages * page_size;
> > >
> > > +     args = calloc(nr_cpus, sizeof(struct uffd_args));
> > > +     if (!args)
> > > +             err("allocating args array failed");
> > > +
> >
> > It's leaked?
> >
> > Isn't "args[] = { 0 }" already working?
> 
> That works, but GCC can warn in this case (-Wmissing-braces) depending
> on the definition of struct uffd_args. I liked switching to calloc
> because it avoids any possibility of that even as we add/remove things
> to struct uffd_args in the future.

But afaict we also have other places using the static way, I hope we can
still keep them the same.

> 
> Since it's a selftest and this function is only called exactly once,
> it didn't seem worth the code making certain we free it, instead just
> leaving it to be cleaned up when the process exits.

I'm also fine if you like to allocate it, but in that case please free it
even if used only once - we're already at it, no good reason to explicitly
leak it.  Let's just assume if userfaultfd_stress() can succeed it can be
called 100000.. times without leaking anything.

Thanks,

-- 
Peter Xu

