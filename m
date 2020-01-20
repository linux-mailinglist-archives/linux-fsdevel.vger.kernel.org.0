Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26069142C96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATNyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 08:54:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34560 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATNyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:54:40 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so33746575iof.1;
        Mon, 20 Jan 2020 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9BomRl8cOqD5J6VizMdaO4qtRV2qD8Sxz+xVA/FCwY=;
        b=G/5kXvqRu1WxCz3g1HVe00s3Xff3vBvEvqpGz/eGT7WcOdxfQsr01Tnwu4vt9jApWy
         nuSgta0xztw4dSoRI2mZFEHqyW0y5wEsRaQhdKbbPmv1ilZuPg75Z9DE4ZVanolNYjzi
         Zcm9L7afSxsLPz+6ldqFYEaaNT1ioxglNJI6R/pIY6//qpaavBYlUOyZrtyvAkukg0Bo
         NVlO3lASc5pCd7mP2WWe80vY/l+wAwtoBrz8VnZnFNXKU8nE3XboNJce7rMhXYskE8dk
         xuaTwBUJQcqzQhSq3F0dtePOpn8bvY6DCDsjl8lAUK3myukdsMTYGePZp32rAhq4lZR+
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9BomRl8cOqD5J6VizMdaO4qtRV2qD8Sxz+xVA/FCwY=;
        b=XzKIbHPGQs+t8gsjFsClrM3Mv9CjJDjRk1sItNzrraMmJDhAPY7QPXekCIsgOQ2JXc
         Ftv9RhSCWTKUREQLvfNh1qhbH6IXmM5mXPb8uVUvujR+U7MQO37V2XuxLX+S2Qh7tAz1
         HP6GMnCY+YATeBAgwqHGgYpAAWVgqIW5Gi+6HtRWifYE8kustA89aaUVXIXsx1knFZ3q
         YEDx1+PbK9qAFTjcGf++8K4t5f35LFpQAMGk01cP/shBgQsDPdizES7V+xYKMFBZxnTG
         qXu+xj4iPh6bQqHO5XUWbZClzaI3ObGZMMpsyrB5UE1G08aloMfQVJcml28IjsOrYddA
         vfzw==
X-Gm-Message-State: APjAAAWcafn4X9wclCHgIir7qFkYhUra7DqJLLuw/ZLQY4QwlWn+inc2
        5oKqIBUrGEJ4rZyQ9L4rlk8C3yiPjcTOp0dRObE=
X-Google-Smtp-Source: APXvYqzJYVTTnME9AcE53rOwW95R5jUMm4G5XkLB9kyPpoSSXoCZtLZqNzywfWbx31CI1a8KPWD3R6NlSsDblYCZr8Q=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr43607002ioh.137.1579528479611;
 Mon, 20 Jan 2020 05:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20190829131034.10563-1-jack@suse.cz> <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
 <20200120120333.GG19861@quack2.suse.cz>
In-Reply-To: <20200120120333.GG19861@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Jan 2020 15:54:28 +0200
Message-ID: <CAOQ4uxhhsxaO61HwMvRGP=5duFsY6Nvv+vCutVZXWXWA2pu2KA@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
To:     Jan Kara <jack@suse.cz>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 2:03 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Fri 17-01-20 12:50:58, Amir Goldstein wrote:
> > On Thu, Aug 29, 2019 at 4:10 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello,
> > >
> > > this is a patch series that addresses a possible race between readahead and
> > > hole punching Amir has discovered [1]. The first patch makes madvise(2) to
> > > handle readahead requests through fadvise infrastructure, the third patch
> > > then adds necessary locking to XFS to protect against the race. Note that
> > > other filesystems need similar protections but e.g. in case of ext4 it isn't
> > > so simple without seriously regressing mixed rw workload performance so
> > > I'm pushing just xfs fix at this moment which is simple.
> > >
> >
> > Could you give a quick status update about the state of this issue for
> > ext4 and other fs. I remember some solutions were discussed.
>
> Shortly: I didn't get to this. I'm sorry :-|. I'll bump up a priority but I
> can't promise anything at the moment.
>
> > Perhaps this could be a good topic for a cross track session in LSF/MM?
>
> Maybe although this is one of the cases where it's easy to chat about
> possible solutions but somewhat tedious to write one so I'm not sure how
> productive that would be. BTW my discussion with Kent [1] is in fact very
> related to this problem (the interval lock he has is to stop exactly races
> like this).
>

Well, I was mostly interested to know if there is an agreement on the way to
solve the problem. If we need to discuss it to reach consensus than it might
be a good topic for LSF/MM. If you already know what needs to be done,
there is no need for a discussion.

> > Aren't the challenges posed by this race also relevant for RWF_UNCACHED?
>
> Do you have anything particular in mind? I don't see how RWF_UNCACHED would
> make this any better or worse than DIO / readahead...
>

Not better nor worse. I meant that RFW_UNCACHED is another case that
would suffer the same races.

Thanks,
Amir.
