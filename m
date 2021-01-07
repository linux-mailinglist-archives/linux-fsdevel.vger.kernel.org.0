Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747972ED5AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 18:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbhAGRaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 12:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbhAGRav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:30:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF43C0612F6;
        Thu,  7 Jan 2021 09:30:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g24so8481456edw.9;
        Thu, 07 Jan 2021 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axN4GaDeR+MEVgZRaEXZ0ZXIu1myM+jajV0ll7329Nc=;
        b=SdXQ5erLN+VPMwfnwaeY1r+OMQL6P7Q4W0zpfnGUfxiS1mifK8NmOQb7MdNFSETRxb
         mdDsYA79HeJMVjUPNKiTQv84ococrgAwemyevpeeiEKjMR6S+2fjXnVCfZpfx3FAp7f0
         IZMn9m0haK8J/vmnXabBW12BPzu+NTQzipQHITG1TJ8INpNrhRtiUMrFTcfzID0m+SS1
         Ks7gD89pqGVhbFPQtPJ8PwPvtm00jSZPQXGeipKKIkZ/O1vFM5bHBpsa5SaMLE2s98Zf
         QJbtOLMWP3Rl//GqySLYG38tYqyIpnDxDLsC8q2b7b2mrPFuTkjeKmR+cYT+XescK8R+
         UZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axN4GaDeR+MEVgZRaEXZ0ZXIu1myM+jajV0ll7329Nc=;
        b=F6NAMo8Z9lNMYZAktfRMgM4Fu64LUJUQlWtyEbSos2ftnJN9GgEqDQq9zJlqvxAv03
         TYlxfBDz/JnssdnltnWeIhhDQ9HlPegkaFI0G1Eg9B5X1mm7ZOqRaQemHQ65IWB0qerh
         ZMSophjpKL2X9P54/LA3ErNyqji+DWWGVsB+snpKCzNLVdSsdai8vL2mkKBLgb7XG8y2
         kuOpfDuLzT4wNHAZ1rngW4kD+zEnFjUQZaXFPGKDIcR0bAccvzY6N5tqDFN43KMh0PpO
         BglY5IkBk63ZmaQsIWPRibSUMD/6rmCh+RVDeRDGd+IL0YBG4IokmTJ1XIX454a+IPPJ
         /ESQ==
X-Gm-Message-State: AOAM531HDq06hW70uhHCHPB/EuU1d8AzrhEGlb/O+WqUp2PLHzH4sts/
        CZrQLkOHcbre6zYnYRpSSDWnUfjGG2vHFlPztVsx4RMOETBkOw==
X-Google-Smtp-Source: ABdhPJygpCklThqcXVk9N8gboz9hlyQL1rXmDc4Xa/4U+ytfmNsb/qt+nLY7mzm1lkA3K2vV65dW67esM3tOLGMyP70=
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr2430738edb.151.1610040609737;
 Thu, 07 Jan 2021 09:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-3-shy828301@gmail.com>
 <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
In-Reply-To: <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Jan 2021 09:29:55 -0800
Message-ID: <CAHbLzkrQ4zL6qw5OvXXQhSQBLG3B3ncpwrNVWuormRWvcmTa7w@mail.gmail.com>
Subject: Re: [v3 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 4:14 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jan 05, 2021 at 02:58:08PM -0800, Yang Shi wrote:
> > The shrinker map management is not really memcg specific, it's just allocation
>
> In the current form it doesn't look so, especially because each name
> has a memcg_ prefix and each function takes a memcg argument.

That statement from commit log might be ambiguous and confusing. "Not
really memcg specific" doesn't mean it has nothing to do with memcg.
It is the intersection between memcg and shrinker. So, I don't think
of why it can't take a memcg argument. There are plenty of functions
from vmscan.c that take memcg as argument.

The direct reason for this consolidation is actually the following
patch which uses shrinker_rwsem to protect shrinker_maps allocation.
With this code consolidation we could keep the use of shrinker_rwsem
in one single file. And it also makes some sense to have shrinker
related code in vmscan.c, just like lruvec.

>
> It begs for some refactorings (Kirill suggested some) and renamings.

I apologize that I can't remember what specific suggestions from
Kirill you mean. Removing the "memcg_" prefix makes some sense to me,
we don't have "memcg_" prefix for lruvec either.

>
> Thanks!
