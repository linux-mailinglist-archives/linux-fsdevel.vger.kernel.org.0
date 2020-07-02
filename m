Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10913212C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGBSXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 14:23:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbgGBSXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593714197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4n2qeDClQPShAlOepg3+xUXJF0gLP+gI9YS4+e3wWo=;
        b=VG0uLCzP6klptJMASdTb5lg8eSxXbyaUJba0E6CJGKywZAKndPM8RGA9IP0cmkuHyKd6pB
        C4zeUClWlblpweh51WsXmV6ft3DFl+shr7kG7h1rWgY/PKrngvKAujP+YDajN0m/iT7QR1
        JTED7YB450EezijkMkP0HTw05yq0jqw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ZLvEFRAQPT20aEWJxNR8jw-1; Thu, 02 Jul 2020 14:23:15 -0400
X-MC-Unique: ZLvEFRAQPT20aEWJxNR8jw-1
Received: by mail-oo1-f72.google.com with SMTP id x19so5081936ooq.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 11:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4n2qeDClQPShAlOepg3+xUXJF0gLP+gI9YS4+e3wWo=;
        b=t46tOHgV3zsC5jeqv7EIRybR6g4c6XJU7GXyv3OhF+3sc2KgshOq7XKftglBIiHb2Q
         YmwCk0XeAWEYW+/y91jLCj+JBNN+LOJcGeuPXxFnvY+j6ldFTllBBP4SQ/i+mHg33nMK
         htIi6F3vZ7S/jwThaZCg/NZL9cSVwz3kitcLO1WZsocB35qnXLIDFtRqwRwUrlYHZ7sx
         DIkQBPHnAbs2ru/u5yUS7biR+fi+S9rnYikvT1x3AI1hwVF+zcgGVGl0iaKRlscXPegi
         OYOqoq+O14JHWdJNvPXssELZ7ay4FeGUruNhV0cqNwTR4hVwTDy3wVFh37EedHl9mVzz
         N/8w==
X-Gm-Message-State: AOAM531fnHAyrHagf7pdNIN2dlyd7kd1IxG0RaWXBbqAk4uQRMsflyYF
        m5D8Iz0cLJJVYn8B7phDgl45XBgxjCY70jrQvPv4RBsLXhT12HNZ233LATBjX9U6/zXJENOZaeL
        Ig/378uLUMbkhHNg1/Ck+YHiGKTq8a1yw+8yyXIRV7A==
X-Received: by 2002:a9d:5f92:: with SMTP id g18mr12102140oti.95.1593714194843;
        Thu, 02 Jul 2020 11:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvm7EcRvsfCto8/PgbdopuIxxPcMOqqa27XvyoeidGOQ9Dab1I7ij1VwHb4T6hC4Paewj6S+oUpsnH5rz8W5I=
X-Received: by 2002:a9d:5f92:: with SMTP id g18mr12102114oti.95.1593714194564;
 Thu, 02 Jul 2020 11:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
In-Reply-To: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 20:23:03 +0200
Message-ID: <CAHc6FU7ZWJb308yfMaskFeSwNxgxqn89pxT4F7Ud4HthhrC5CA@mail.gmail.com>
Subject: Re: [RFC 0/4] Fix gfs2 readahead deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Of this patch queue, either only the first patch or all four patches can
> > be applied to fix gfs2's current issues in 5.8.  Please let me know what
> > you think.
>
> I think the IOCB_NOIO flag looks fine (apart from the nit I pointed
> out), and we could do that.

Ok, that's a step forward.

> However, is the "revert and reinstate" looks odd. Is the reinstate so
> different from the original that it makes sense to do that way?
>
> Or was it done that way only to give the choice of just doing the revert?
>
> Because if so, I think I'd rather just see a "fix" rather than
> "revert+reinstate".

I only did the "revert and reinstate" so that the revert alone will
give us a working gfs2 in 5.8. If there's agreement to add the
IOCB_NOIO flag, then we can just fix gfs2 (basically
https://lore.kernel.org/linux-fsdevel/20200619093916.1081129-3-agruenba@redhat.com/
with IOCB_CACHED renamed to IOCB_NOIO).

Thanks,
Andreas

