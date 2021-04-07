Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9113570A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbhDGPm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhDGPm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:42:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D367AC061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 08:42:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u9so21241993ljd.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk1tr8gnipD6uFCQutltHcbiRHj4dh2dyGytQA9wCWU=;
        b=eALrPYdSxG5ztUUc6HNLmohxDavZmiWNBJfKHWtxO2z25tbLT0s77VUc8jnKkT7fTG
         Jy77kKUVud/7YniQoUals7Kr1C7oq9aQSAzuWi/Wg4BChaO5rokhNH8FUyH4cBoqSXwt
         Og8djPFUGKELXZauXW7sX5lIy0mvXskCnW3BmQBwZr5Xy3+xnn1kCFzCspcZNg+15DIL
         N0TUbrS0DZ/SCy9hkCIFrwB6o8AsZzFPlj6AkxEbN0xSYGh7XXaKEGndh2XJJOTqfHrl
         5YYZEu6C8eKvN5UdN8CDz4w0tBd9Vi+mLclahiyl2yTQb3Jlf4yQH/AI8AjXwleRiWXP
         vLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk1tr8gnipD6uFCQutltHcbiRHj4dh2dyGytQA9wCWU=;
        b=cFarTdiVvdyM97FhZTrlYcp0khSdr0ootrK704JrfTPEd4+VnR5OgHm0R/FLl8I5gt
         FVK1ndpEArVY45Qvw5h9OLLWZdFVxGjnnmjwN17f0EHyttUS+/h5zx9iQqOzcaX//cUS
         JHq0+WAKAYAL9YDZk16yjShn4VjqqfYwg129+cKmNOgfuu8xeIxzO7BezQAgBZ/1S+gQ
         4vYq6Ij/pJzw5fAiSi+QrXh9hHDEwbSgRqREYACR26KqMhkvFazmE8ryZhxsTQS0DYwG
         7BsxhA1gbeCeKAu+g41SZIjN9iw04deie+QO8E05H0aLsSrpfK4w4Hl3HXoUB2wT3mtW
         SLwg==
X-Gm-Message-State: AOAM532/sKrUsCXTDA3ExtsSdcMMBDmwdppte4YkIakAHnbO8GLZImI6
        kHyrdxW0nhb1JufIrfvOm3wQlvv3wB2Gwl50I/ew4Q==
X-Google-Smtp-Source: ABdhPJyItEPMRdkdL43c6GKpBK8KvHU+D+sruSGo8iOAoXefA95/2e3w/6+Yu9MghbdpFLXPZb1TTFuchX6pCiMoocY=
X-Received: by 2002:a2e:85d9:: with SMTP id h25mr2522397ljj.81.1617810163862;
 Wed, 07 Apr 2021 08:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210405054848.GA1077931@in.ibm.com> <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
In-Reply-To: <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Apr 2021 08:42:31 -0700
Message-ID: <CALvZod79PDmPLYAXm=EQDrn8mQfE9aQL+Mgaai6zu=uqucbMAQ@mail.gmail.com>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
To:     Michal Hocko <mhocko@suse.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 7, 2021 at 4:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 05-04-21 11:18:48, Bharata B Rao wrote:
> > Hi,
> >
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
>
> Is this 10k cgroups a testing enviroment or does anybody really use that
> in production? I would be really curious to hear how that behaves when
> those containers are not idle. E.g. global memory reclaim iterating over
> 10k memcgs will likely be very visible. I do remember playing with
> similar setups few years back and the overhead was very high.
> --

I can tell about our environment. Couple of thousands of memcgs (~2k)
are very normal on our machines as machines can be running 100+ jobs
(and each job can manage their own sub-memcgs). However each job can
have a high number of mounts. There is no local disk and each package
of the job is remotely mounted (a bit more complicated).

We do have issues with global memory reclaim but mostly the proactive
reclaim makes the global reclaim a tail issue (and at tail it often
does create havoc).
