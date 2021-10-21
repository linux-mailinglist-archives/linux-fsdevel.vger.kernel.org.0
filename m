Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00FA435F62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhJUKm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:42:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E4C06161C;
        Thu, 21 Oct 2021 03:40:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l5so1084095lja.13;
        Thu, 21 Oct 2021 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pOBAuVN6JNFOHIGH5sbYmAMZ0cNNUYNZfaKPm0hr+Wc=;
        b=d0/P+9UObVdNOed4aqrRly7PMFuynMX/yDkBFl9UO778+dfFMEv0/YhoHpSEkYX4f1
         HkZSwD77X/OLzHxqpK2eAxNf7v53XaUM6E+V5aGJsp96QIkvNUd21/yhZgtbP3AgQ4Mp
         Yqt9TRQ2MqlTm5cvYJYCLghY/wBR/ajWSW0XDLgkYjrZCJ9h7QCQcaR/Xx32tvCjA1NR
         mjQN6AKh/nZXNvFCgG+viQon8U0Q8+/GinC+68Tfdr1ZHEyYdHIOqBflxLN21e4QUb/c
         kkyckhhfEpvCk4peR94ktXHNtuelWDTUZzljyt9iL4z6J7/jBbhahxj+/NMBo9v8NC03
         3exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pOBAuVN6JNFOHIGH5sbYmAMZ0cNNUYNZfaKPm0hr+Wc=;
        b=jk0x9Sa+WwQJgOBBxfuA1sr/wMXLwdhQA3KPCFxSkz8Cd3iuNyEdR6jEqlPU2nMH32
         jkL4w5OT837ioQPUi2CKmk/NtMM5aLmYb+i1Sbjsr7kYbCBl78Hk6luu5sQeKc2PlA3k
         H1HNC5uQmg7PY2tRUkb7Asd6xISjQzvSSFzWWyOqv9hC4mmR+JcNLj6aBQfLTjTMD5Qd
         GrlIBPOvxq2lZgFVxNB1d+QPXSOPszqOuCCexsRq9VF6aSqYDE9+5MYT0ku1Fmvv0l3W
         feRwxmgbFi78sYZaYiRsr0ydsac0yFHQ3//jkTGgfM56sc+JxNL+Sm05B+pZUHri1NA/
         CXeQ==
X-Gm-Message-State: AOAM531BpaRqCrPXWjg5ivHhtN+9TfGIaWD/irzfNfpev1c8f+Ytst2l
        dUQofHiG4KuXtC4bikNMDBCRHcw68BDm9Bo8
X-Google-Smtp-Source: ABdhPJweUAYI/2N+dywQaYjXJ2+lEJoHS1HHsj3N2gjN6fnfyTEbDXWNIR1wpjo2PCCKpwVlKRgNnQ==
X-Received: by 2002:a05:651c:1201:: with SMTP id i1mr5005242lja.207.1634812841011;
        Thu, 21 Oct 2021 03:40:41 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 195sm506199ljf.13.2021.10.21.03.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:40:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 21 Oct 2021 12:40:38 +0200
To:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>
Cc:     NeilBrown <neilb@suse.de>, Uladzislau Rezki <urezki@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211021104038.GA1932@pc638.lan>
References: <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu 21-10-21 21:13:35, Neil Brown wrote:
> > On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > > On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> > > > >
> > > > > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > > > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > [...]
> > > > > > > As I've said I am OK with either of the two. Do you or anybody have any
> > > > > > > preference? Without any explicit event to wake up for neither of the two
> > > > > > > is more than just an optimistic retry.
> > > > > > >
> > > > > > From power perspective it is better to have a delay, so i tend to say
> > > > > > that delay is better.
> > > > >
> > > > > I am a terrible random number generator. Can you give me a number
> > > > > please?
> > > > >
> > > > Well, we can start from one jiffy so it is one timer tick: schedule_timeout(1)
> > > > 
> > > A small nit, it is better to replace it by the simple msleep() call: msleep(jiffies_to_msecs(1));
> > 
> > I disagree.  I think schedule_timeout_uninterruptible(1) is the best
> > wait to sleep for 1 ticl
> > 
> > msleep() contains
> >   timeout = msecs_to_jiffies(msecs) + 1;
> > and both jiffies_to_msecs and msecs_to_jiffies might round up too.
> > So you will sleep for at least twice as long as you asked for, possible
> > more.
> 
> That was my thinking as well. Not to mention jiffies_to_msecs just to do
> msecs_to_jiffies right after which seems like a pointless wasting of
> cpu cycle. But maybe I was missing some other reasons why msleep would
> be superior.
>

To me the msleep is just more simpler from semantic point of view, i.e.
it is as straight forward as it can be. In case of interruptable/uninteraptable
sleep it can be more confusing for people.

When it comes to rounding and possibility to sleep more than 1 tick, it
really does not matter here, we do not need to guarantee exact sleeping
time.

Therefore i proposed to switch to the msleep().

--
Vlad Rezki
