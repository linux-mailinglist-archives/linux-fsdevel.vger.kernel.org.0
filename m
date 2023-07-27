Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE14765D63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjG0UbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 16:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjG0UbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F132736
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690489831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuxACaLiBeZZ2plyxBG2ZphRqj/+K7EVaUkCF5E72Uk=;
        b=GVE/vknR2HUBcooIq56+fIVCIjeFAoVA8uU/VSqjvGdI+gIeidhOwXUqFd55Vn+kADCJdg
        JoHaDFl5lKCMmgWjgHH/5daPLuSuPpt3VPfENo6lgecFWP+HzAgTLjTugQif0F7pCxr6j9
        OjBewLBPNPKVwdsCkxR2gvZyzbmS6Lc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-xI9rBz_WOTmU3S04TNTJ7Q-1; Thu, 27 Jul 2023 16:30:28 -0400
X-MC-Unique: xI9rBz_WOTmU3S04TNTJ7Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cc3a44aedso3417716d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 13:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690489828; x=1691094628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuxACaLiBeZZ2plyxBG2ZphRqj/+K7EVaUkCF5E72Uk=;
        b=WE8/ibcSsSRJiFXytc9D1vVym5MUtGj7yqlIQT0GxvCJyMZxczTzmZyru9Qt79ig48
         557x2M0iUci8kKAm51bXt/tKyhZyuLKduL7HbeWnsk8bu9dVvH0nv/2ez+DdVkjnccmF
         sKrOqBJgz4/FGPo8K7NKhPK/GyxuO478N63Ip0UQ6p7hKHoywKHc+lGwbUpYH8L/1LAZ
         UtlmiJGrnbjpMnCnFnRVzAw7SQm4ljLkBqdErRD618+Yncr8x5uQxbw9L54TbyfQUv9z
         mR+JwW7uHF7rcub+6GfzeLeDpiWC3j/EY8Jh3jmV620a5HkQZ9XHyJGUuQa462YqeMxJ
         B4Yg==
X-Gm-Message-State: ABy/qLarM33rbfW6wuMUcBN411K445HOhl8ndopk5QGIPL7U1duu54GW
        4hmysc/HI95uAy928iJwn3QrZZW3bQW7GsOOox1/mrDUX7JnI0yMw7jSdYMUFZsPEsL3/XGgTZF
        /t6Mhb5xxAxbgjNpXbfkRWdhrQQ==
X-Received: by 2002:a05:6214:5199:b0:621:65de:f60c with SMTP id kl25-20020a056214519900b0062165def60cmr528117qvb.3.1690489828023;
        Thu, 27 Jul 2023 13:30:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwAq1H9Am2PHeCbRrVcdzYzTz5Q+S34HkYrd4o7DwHgFLizyaB4rVJvw/NpwLKHXexx5kqig==
X-Received: by 2002:a05:6214:5199:b0:621:65de:f60c with SMTP id kl25-20020a056214519900b0062165def60cmr528101qvb.3.1690489827673;
        Thu, 27 Jul 2023 13:30:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h13-20020a0cab0d000000b00635eeb8a4fcsm668775qvb.114.2023.07.27.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:30:27 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:30:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
Message-ID: <ZMLT4aL9V61Bl5TG@x1n>
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n>
 <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
 <ZMKJjDaqZ7FW0jfe@x1n>
 <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
 <ZMK+jSDgOmJKySTr@x1n>
 <30e58727-0a6a-4461-e9b1-f64d6eea026c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30e58727-0a6a-4461-e9b1-f64d6eea026c@redhat.com>
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

On Thu, Jul 27, 2023 at 09:17:45PM +0200, David Hildenbrand wrote:
> On 27.07.23 20:59, Peter Xu wrote:
> > On Thu, Jul 27, 2023 at 07:27:02PM +0200, David Hildenbrand wrote:
> > > > > 
> > > > > This was wrong from the very start. If we're not in GUP, we shouldn't call
> > > > > GUP functions.
> > > > 
> > > > My understanding is !GET && !PIN is also called gup.. otherwise we don't
> > > > need GET and it can just be always implied.
> > > 
> > > That's not the point. The point is that _arbitrary_ code shouldn't call into
> > > GUP internal helper functions, where they bypass, for example, any sanity
> > > checks.
> > 
> > What's the sanity checks that you're referring to?
> > 
> 
> For example in follow_page()
> 
> if (vma_is_secretmem(vma))
> 	return NULL;
> 
> if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
> 	return NULL;
> 
> 
> Maybe you can elaborate why you think we should *not* be using
> vm_normal_page_pmd() and instead some arbitrary GUP internal helper? I don't
> get it.

Because the old code was written like that?

You're proposing to change it here.  Again, I'm fine with the change, but
please don't ask me to justify why the original code is fine.. because I
simply don't see anything majorly wrong with either, it's the change that
needs justification, not keeping it as-is (since Kirill wrote it in 2014).

Well.. I feel like this becomes less helpful to discuss. let's try to move
on.

> 
> > > 
> > > > 
> > > > The other proof is try_grab_page() doesn't fail hard on !GET && !PIN.  So I
> > > > don't know whether that's "wrong" to be used..
> > > > 
> > > 
> > > To me, that is arbitrary code using a GUP internal helper and, therefore,
> > > wrong.
> > > 
> > > > Back to the topic: I'd say either of the patches look good to solve the
> > > > problem.  If p2pdma pages are mapped as PFNMAP/MIXEDMAP (?), I guess
> > > > vm_normal_page_pmd() proposed here will also work on it, so nothing I see
> > > > wrong on 2nd one yet.
> > > > 
> > > > It looks nicer indeed to not have FOLL_FORCE here, but it also makes me
> > > > just wonder whether we should document NUMA behavior for FOLL_* somewhere,
> > > > because we have an implication right now on !FOLL_FORCE over NUMA, which is
> > > > not obvious to me..
> > > 
> > > Yes, we probably should. For get_use_pages() and friends that behavior was
> > > always like that and it makes sense: usually it represent application
> > > behavior.
> > > 
> > > > 
> > > > And to look more over that aspect, see follow_page(): previously we can
> > > > follow a page for protnone (as it never applies FOLL_NUMA) but now it won't
> > > > (it never applies FOLL_FORCE, either, so it seems "accidentally" implies
> > > > FOLL_NUMA now).  Not sure whether it's intended, though..
> > > 
> > > That was certainly an oversight, thanks for spotting that. That patch was
> > > not supposed to change semantics:
> > > 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 76d222ccc3ff..ac926e19ff72 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -851,6 +851,13 @@ struct page *follow_page(struct vm_area_struct *vma,
> > > unsigned long address,
> > >          if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
> > >                  return NULL;
> > > 
> > > +       /*
> > > +        * In contrast to get_user_pages() and friends, we don't want to
> > > +        * fail if the PTE is PROT_NONE: see gup_can_follow_protnone().
> > > +        */
> > > +       if (!(foll_flags & FOLL_WRITE))
> > > +               foll_flags |= FOLL_FORCE;
> > > +
> > >          page = follow_page_mask(vma, address, foll_flags, &ctx);
> > >          if (ctx.pgmap)
> > >                  put_dev_pagemap(ctx.pgmap);
> > 
> > This seems to be slightly against your other solution though for smaps,
> > where we want to avoid abusing FOLL_FORCE.. isn't it..
> 
> This is GUP internal, not some arbitrary code, so to me a *completely*
> different discussion.
> 
> > 
> > Why read only?  That'll always attach FOLL_FORCE to all follow page call
> > sites indeed for now, but just curious - logically "I want to fetch the
> > page even if protnone" is orthogonal to do with write permission here to
> > me.
> 
> Historical these were not the semantics, so I won't change them.
> 
> FOLL_FORCE | FOLL_WRITE always had a special taste to it (COW ...).
> 
> > 
> > I still worry about further abuse of FOLL_FORCE, I believe you also worry
> > that so you proposed the other way for the smaps issue.
> > 
> > Do you think we can just revive FOLL_NUMA?  That'll be very clear to me
> > from that aspect that we do still have valid use cases for it.
> 
> FOLL_NUMA naming was nowadays wrong to begin with (not to mention, confusing
> a we learned). There are other reasons why we have PROT_NONE -- mprotect(),
> for example.

It doesn't really violate with the name, IMHO - protnone can be either numa
hint or PROT_NONE for real. As long as we return NULL for a FOLL_NUMA
request we're achieving the goal we want - we guarantee a NUMA balancing to
trigger with when FOLL_NUMA provided.  It doesn't need to guarantee
anything else, afaiu.  The final check relies in vma_is_accessible() in the
fault paths anyway.  So I don't blame the old name that much.

> 
> We could have a flag that goes the other way around: FOLL_IGNORE_PROTNONE
> ... which surprisingly then ends up being exactly what FOLL_FORCE means
> without FOLL_WRITE, and what this patch does.
> 
> Does that make sense to you?
> 
> 
> > 
> > The very least is if with above we should really document FOLL_FORCE - we
> > should mention NUMA effects.  But that's ... really confusing. Thinking
> > about that I personally prefer a revival of FOLL_NUMA, then smaps issue all
> > go away.
> 
> smaps needs to be changed in any case IMHO. And I'm absolutely not in favor
> of revicing FOLL_NUMA.

As stated above, to me FOLL_NUMA is all fine and clear.  If you think
having a flag back for protnone is worthwhile no matter as-is (FOLL_NUMA)
or with reverted meaning, then that sounds all fine to me. Maybe the old
name at least makes old developers know what's that.

I don't have a strong opinion on names though; mostly never had.

Thanks,

-- 
Peter Xu

