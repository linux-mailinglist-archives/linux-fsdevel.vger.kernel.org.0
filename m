Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE26945E09B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhKYSqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 13:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbhKYSoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:44:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962CC061574;
        Thu, 25 Nov 2021 10:41:10 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so29107393edq.7;
        Thu, 25 Nov 2021 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3HNHQJs9VO9dwH2imKVpk6pR3g3APLMwVhhcaVGZJE=;
        b=AX6SYLCD39N2tvi+roABiLEBy99L3Vxjy2VpktHabMReAWWnGZUGcwpvCYt9idiLs8
         zIU5cMTHCEuLIKnHQU7nkoeSEBzTagm5cKVIg/TgrmZcne+U7sZTWBP7Koooo0aOBK0x
         gLjb/WLnXSqdwr54zCwZMdzgb2GBd+wy+TN7R9NUWzLlnxiBQmMxx185G9KMKIwgwPTd
         mDCo/Cf9nk7PM/jtqIPLAx/DMMHSaLZCJCSqBLIqwoZvIJ1rTIAS0A76B36gIh0E0K4F
         vMBVCQSVbqRfVlnR+SU8Tnqu/Ct5CKdZejehEtPzFODaTT3ljsH8ZdjSRDVKd7tOnzua
         mBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3HNHQJs9VO9dwH2imKVpk6pR3g3APLMwVhhcaVGZJE=;
        b=D6vr9kvurWV+T/2T5dcqWcY5KmX5dJH2CKV5d//nIqvomhwF+LXl81Y+a9S0CF1vjP
         6e+Ov6gaA3bwuKhXPOtgcuAAmxg0lWV+XW/Ja7xlVIFicltRAIQPE3AzDQkCRhFkcGUm
         3YsbN8bq2TFNL7w0bkoM60YpSbxCc6Qf1UlKKg7B3PAUcipF20s7CYhqefa0temMtCwr
         C1/Rlo9vRBbSFPMVNQ9jecbcU99L5jRe2wezqkqwigtq5XtT0GZ3forT7l6u/0rss8KR
         9th65YfWpkBoJNDuESEnp5l3l7jaBnlnJx2aG/t3+1cjl5a/RgT6pgMV6pTp8fu8n6Am
         Icaw==
X-Gm-Message-State: AOAM531XwjlQnT0zzTnj3y5abGI6AruGyJhdClDs7fmJVkr2ik9P19CC
        TH5a1xx2OA5+D4S+gdWAvFcrMqltV84QLNBiD/I=
X-Google-Smtp-Source: ABdhPJwP95vvRwx+GtKAfAGksIwk8Yd1ja0yU6ELjjKtBdxfx+lX3bFz3FljaoM+5xkl1Qlf/Z2U9SgKbWG1wIRqyIg=
X-Received: by 2002:a17:906:cb82:: with SMTP id mf2mr34063843ejb.266.1637865668439;
 Thu, 25 Nov 2021 10:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20211122153233.9924-1-mhocko@kernel.org> <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan> <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ37IJq3+DrVhAcD@dhcp22.suse.cz> <YZ6iojllRBAAk8LW@pc638.lan> <YZ9N2I05NfureFuG@dhcp22.suse.cz>
In-Reply-To: <YZ9N2I05NfureFuG@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 25 Nov 2021 19:40:56 +0100
Message-ID: <CA+KHdyW6kS7dB95BOiNo5y5anfygB2OnJ0sOcw545s2_V1rfYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 9:48 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-11-21 21:37:54, Uladzislau Rezki wrote:
> > On Wed, Nov 24, 2021 at 09:43:12AM +0100, Michal Hocko wrote:
> > > On Tue 23-11-21 17:02:38, Andrew Morton wrote:
> > > > On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > >
> > > > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > > > cannot fail and they do not fit into a single page.
> > > >
> > > > Perhaps we should tell xfs "no, do it internally".  Because this is a
> > > > rather nasty-looking thing - do we want to encourage other callsites to
> > > > start using it?
> > >
> > > This is what xfs is likely going to do if we do not provide the
> > > functionality. I just do not see why that would be a better outcome
> > > though. My longterm experience tells me that whenever we ignore
> > > requirements by other subsystems then those requirements materialize in
> > > some form in the end. In many cases done either suboptimaly or outright
> > > wrong. This might be not the case for xfs as the quality of
> > > implementation is high there but this is not the case in general.
> > >
> > > Even if people start using vmalloc(GFP_NOFAIL) out of lazyness or for
> > > any other stupid reason then what? Is that something we should worry
> > > about? Retrying within the allocator doesn't make the things worse. In
> > > fact it is just easier to find such abusers by grep which would be more
> > > elaborate with custom retry loops.
> > >
> > > [...]
> > > > > > +             if (nofail) {
> > > > > > +                     schedule_timeout_uninterruptible(1);
> > > > > > +                     goto again;
> > > > > > +             }
> > > >
> > > > The idea behind congestion_wait() is to prevent us from having to
> > > > hard-wire delays like this.  congestion_wait(1) would sleep for up to
> > > > one millisecond, but will return earlier if reclaim events happened
> > > > which make it likely that the caller can now proceed with the
> > > > allocation event, successfully.
> > > >
> > > > However it turns out that congestion_wait() was quietly broken at the
> > > > block level some time ago.  We could perhaps resurrect the concept at
> > > > another level - say by releasing congestion_wait() callers if an amount
> > > > of memory newly becomes allocatable.  This obviously asks for inclusion
> > > > of zone/node/etc info from the congestion_wait() caller.  But that's
> > > > just an optimization - if the newly-available memory isn't useful to
> > > > the congestion_wait() caller, they just fail the allocation attempts
> > > > and wait again.
> > >
> > > vmalloc has two potential failure modes. Depleted memory and vmalloc
> > > space. So there are two different events to wait for. I do agree that
> > > schedule_timeout_uninterruptible is both ugly and very simple but do we
> > > really need a much more sophisticated solution at this stage?
> > >
> > I would say there is at least one more. It is about when users set their
> > own range(start:end) where to allocate. In that scenario we might never
> > return to a user, because there might not be any free vmap space on
> > specified range.
> >
> > To address this, we can allow __GFP_NOFAIL only for entire vmalloc
> > address space, i.e. within VMALLOC_START:VMALLOC_END.
>
> How should we do that?
>
<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..664935bee2a2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3029,6 +3029,13 @@ void *__vmalloc_node_range(unsigned long size,
unsigned long align,
                return NULL;
        }

+       if (gfp_mask & __GFP_NOFAIL) {
+               if (start != VMALLOC_START || end != VMALLOC_END) {
+                       gfp_mask &= ~__GFP_NOFAIL;
+                       WARN_ONCE(1, "__GFP_NOFAIL is allowed only for
entire vmalloc space.");
+               }
+       }
+
        if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
                unsigned long size_per_node;
<snip>

Or just allow __GFP_NOFAIL flag usage only for a high level API, it is
__vmalloc() one where
gfp can be passed. Because it uses whole vmalloc address space, thus
we do not need to
check the range and other parameters like align, etc. This variant is
preferable.

But the problem is that there are internal functions which are
publicly available for kernel users like
__vmalloc_node_range(). In that case we can add a big comment like:
__GFP_NOFAIL flag can be
used __only__ with high level API, i.e. __vmalloc() one.

Any thoughts?

-- 
Uladzislau Rezki
