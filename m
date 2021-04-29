Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9476736E61D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhD2HiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhD2HiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:38:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA6C06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 00:36:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so46527095pgj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQXKcQ9KcEZqY03xe0NgMF80WSAnACAs/9znMR5Uqyw=;
        b=aGXvvaOFqxy4Rj/1ZHgdlRJtm5OBg5ahGhRpOj9aHbZ1/kBEUrjY3PSkjmURS4mp20
         LQ+vZgoUxB7VzIFAG2mU0wb82c+b/4IIyOSrV8z3aJX1V1NXTog2CMSzVx04EEtKSK1s
         D4lmtR+4aa8ToPfQwLe9o1I8gPBgpGmqF3UVpBCLtofWcWlJiGX4KuWIoKwxpE4IFoyo
         s7UbdGouSGYwFPxM3k7TVuNKKfL83sDEllNh4iwSQtMOHNXVp39yLEKEU6OBSlbnV44S
         wINVdIPBq5uVR17YISOCAiVkrZF/zH+dpRS89TNawRlUuNcIPiSjTj3g3Ybx3TvaTLZP
         olsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQXKcQ9KcEZqY03xe0NgMF80WSAnACAs/9znMR5Uqyw=;
        b=MXiHRpXk1V8D+qQGSBZmWqBD+TmbeGCEys2U7KNAkSudTO+dq4YY1cJnhLHCrs5QBX
         snLw5aaUFBsUMfKUwVDNCL3uXEuYWtMmslephzhnTofmut1ne3MP+k2dhpiz1m/8NRvM
         nXTll0N/1ztdHysLY11r+w49KnsIbcpj00k6H65tgtzWdlWofjcfJl2i5JxscApcryWm
         T7NizyBlDlqo8mpX2j6QGq+qN3dm4UpOKKPlbDsAjOPjWOr+x7KwmI1a36UiqCup7tEY
         c26zP6AX7rMM54BMpGp763AKkIKYPX1oi3Fr4A/1NLxH94E8Sc7kKq7lQXrEZWkzo7x+
         PIzQ==
X-Gm-Message-State: AOAM533liuNmuMvG0KuPFF1d1JWsuPw1wA0J90mkn9o9xSCWl+/REfBc
        qS8WUdcDOYLe99MKGsa7zTB3qU86im3w1ISdWziFvA==
X-Google-Smtp-Source: ABdhPJxK8Ut6EhdxMn+dWGfAOpoSc8Vw82gx7w5X49AGlOWuPYpJ67QuP20aVAHVVftvDalnzaadpa8ZQ7HXilV/0L0=
X-Received: by 2002:a63:1665:: with SMTP id 37mr31262717pgw.31.1619681810202;
 Thu, 29 Apr 2021 00:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210428094949.43579-8-songmuchun@bytedance.com> <20210429064751.GA2216380@infradead.org>
In-Reply-To: <20210429064751.GA2216380@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Apr 2021 15:36:13 +0800
Message-ID: <CAMZfGtVu7jVSD8DKze5dNoECN1RKnq4mdfT7ym3Ln1QStKSXJQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 7/9] ida: introduce ida_max() to return the
 maximum allocated ID
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 28, 2021 at 05:49:47PM +0800, Muchun Song wrote:
> > Introduce ida_max() to return the maximum allocated ID. This will be
> > used by memory cgroup in the later patch.
>
> Please also add a lower-level xa_max as this funcationalty would also
> come in handy at the xarray level in a few places.

Good suggestion. This way is also efficient. Thanks.
