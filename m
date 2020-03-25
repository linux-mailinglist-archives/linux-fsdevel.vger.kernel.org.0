Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58942192B65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCYOnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 10:43:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36885 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:43:14 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so2473007iod.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYoi0GgKGrZ5Iy05aE5oc1zP5UUaQTjapju/izAR4hI=;
        b=YUccMzib2IwajwEuyLBHygiEi2x+yWevlxfsequqpaIt/Mza/TxUmFkitS3U4FkfKx
         P1XwXxBJ8Cx5HEmhYoBLdWFHhmr6xou5YR2utppkELKcqyaDd4EOavtJNBW3boLnPkzx
         WgZmdQ9YRsyheNZWEZrba/miSYKYdDAaziYyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYoi0GgKGrZ5Iy05aE5oc1zP5UUaQTjapju/izAR4hI=;
        b=SxqDtSyNBVgTVQnFyJ8GgVrCOfFCJ5VJ3RCl+bhnqB6HQp2DXOi84/pYbhLZ3XuVHD
         5XgCneEAwV08PV3Ok0nG3msmgpI1EUMk82g47dlwJxFtTIh2VxwpUQvnpHCBO88aeAoe
         nVwn8AaoOk03ijCUybjKaeSqWtJ8PjL71dWvgUq57AAGareVRfiYKKWJ1TwLtJZoWAUv
         CodzsoYhxM+F2uxvH+ih40+w6gVFO5CNk26fLCFCsr1nrSfYrAwDv4xqJ54hQaR7MXXn
         rjRcOrsjuQ39/QWCvqaROiuGA87wnJHhuqigPriJ5d41pKsHTcAWNe7C1PwgbnbENVLX
         yv9A==
X-Gm-Message-State: ANhLgQ35D60IQe4M+hW9pk9cDvZbhTUu6sW2s6NtfHUK+cZW5zcnHYQX
        4UJKFieCy2oDGqkg1WU7Y60b8UfDpXNOfcbwI0DxmA==
X-Google-Smtp-Source: ADFU+vsgMMqodCZqPGFNfCT+HdNRTtLLlUdy5AMnDcVBoatxWj+vZY48emoAVNd+HvHliFjTkg/kdF6pmkOGcZxuC6s=
X-Received: by 2002:a6b:3a07:: with SMTP id h7mr3235359ioa.191.1585147393572;
 Wed, 25 Mar 2020 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org> <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com> <20200325120254.GA22483@bombadil.infradead.org>
In-Reply-To: <20200325120254.GA22483@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Mar 2020 15:43:02 +0100
Message-ID: <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 1:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 25, 2020 at 10:42:56AM +0100, Miklos Szeredi wrote:
> > > +       while ((page = readahead_page(rac))) {
> > > +               if (fuse_readpages_fill(&data, page) != 0)
> >
> > Shouldn't this unlock + put page on error?
>
> We're certainly inconsistent between the two error exits from
> fuse_readpages_fill().  But I think we can simplify the whole thing
> ... how does this look to you?

Nice, overall.

>
> -       while ((page = readahead_page(rac))) {
> -               if (fuse_readpages_fill(&data, page) != 0)
> +               nr_pages = min(readahead_count(rac), fc->max_pages);

Missing fc->max_read clamp.

> +               ia = fuse_io_alloc(NULL, nr_pages);
> +               if (!ia)
>                         return;
> +               ap = &ia->ap;
> +               __readahead_batch(rac, ap->pages, nr_pages);

nr_pages = __readahead_batch(...)?

This will give consecutive pages, right?

Thanks,
Miklos
