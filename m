Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7F11BD99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 21:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKUDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 15:03:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34272 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfLKUDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:03:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id m6so25514242ljc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 12:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARg/+L4b2QIR/B9zIQc3US5T+eVRe9Cf50TlETDyNaM=;
        b=al6iELdaRQuI0zpwDdTfK6nolqCFFm3GeyTbURFnuQx3l3Gazb6Tek0ArH9y2SX5mj
         ifsQj5G0solgyBXOD8mZItnFHBffKhpIKNK26Ergh9hSZEoHOJWUgHwG+n3+CPziqfcP
         XZM+UMagtUrNJXK+iqlOjo+Rihu5Abb63zLsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARg/+L4b2QIR/B9zIQc3US5T+eVRe9Cf50TlETDyNaM=;
        b=LKIk5gDzNMvMR+yeBTc35E36jgivk1amyGBY811CQO4E1ESvupCJqGLiwcBBB3hcM+
         R4kgolOxk+ORcQJLJVmryMO8ABsOxPTBzow8ykXIhxk1dZyAyUUM6zpWygHaDD8P8jcH
         XgsALlq4gm+DmVz+mOUB3Tm5eTUcF01u/Qv7HEU8IQe6RheLOyvF0C4F42gbNLuMhFEn
         mGpCdPZHuwGZl8pfg8KqCs4fkGgJ/PV0dxpV4rYPB+f6gWSTAUUqJkEUCZYH1BJc8R5B
         4uumNXDdB6AuLX8L/w24BNLtvp95ChJqsowt7oArjrjiPPPBtbw/VhzAd2Uq/t5FJHeQ
         4GOg==
X-Gm-Message-State: APjAAAXkZX2RHiw9kq7LmELeQRAk8Bh7B9KsLjF4bMWUf9hSfrFf5IbE
        6tXdZizDgBAR2WeUG/jg9IjDA5T5k6Q=
X-Google-Smtp-Source: APXvYqzWHPVSs3bkUupPfS3WOJ+NYz6rep6x+nVeKym3JOpcVZo9QyxtZQHsb9vz+bJlIkOyWyQ5eg==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr3443755ljm.218.1576094624940;
        Wed, 11 Dec 2019 12:03:44 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n13sm1688090lji.91.2019.12.11.12.03.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:03:43 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 9so17665090lfq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 12:03:43 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3498008lfo.134.1576094623187;
 Wed, 11 Dec 2019 12:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
In-Reply-To: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 12:03:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
Message-ID: <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:34 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I can't tell a difference in the results, there's no discernable
> difference between NOT calling mark_page_accessed() or calling it.
> Behavior seems about the same, in terms of pre and post page cache full,
> and kswapd still churns a lot once the page cache is filled up.

Yeah, that sounds like a bug. I'm sure the RWF_UNCACHED flag fixes it
when you do the IO that way, but it seems to be a bug relardless.

Does /proc/meminfo have everything inactive for file data (ie the
"Active(file)" line is basically zero?).

Maybe pages got activated other ways (eg a problem with the workingset
code)? You said "See patch below", but there wasn't any.

That said, it's also entirely possible that even with everything in
the inactive list, we might try to shrink other things first for
whatever odd reason..

The fact that you see that xas_create() so prominently would imply
perhaps add_to_swap_cache(), which certainly implies that the page
shrinking isn't hitting the file pages...

               Linus
