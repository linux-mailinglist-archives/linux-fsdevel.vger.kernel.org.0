Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D39B4EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfIQNRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 09:17:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44758 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIQNRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:17:40 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so7381464iog.11;
        Tue, 17 Sep 2019 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jl0HYi/wSybOikBVzFsvD7tD+oFHCUuqw+qUrn2WMwI=;
        b=jDuZ+02TICPZFr93IFgRPFO9FRoS7D1srTuINYcAWSSa6AylQVCvRk4ofdIJwxgzcF
         2dL5IxXJ934mfRi9TMcrLRIVY4Dc1eRnrEL3nzPEskTjskcFgUKc0AZZBY/v45zxswGd
         FLQ3AKzR3meQqY+Qjby3AWUR8uClRwA8Ps4xciE2Qvh9FU0LRU1skyL8dy0V1T6dB03M
         gMwSf9jORmQ/xWF9ThzH3mKzwcZSOw4CX37BHeP5O3OyfQ/8OOvKLb+U3iW1Sb4/5cq7
         zfWCTG48rIC1fggtMYu4zsS33t7si18KEjKYTj85fyoQXSQBE1VMleNXRJawIZx0iObS
         PrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jl0HYi/wSybOikBVzFsvD7tD+oFHCUuqw+qUrn2WMwI=;
        b=YI4gX3FiiNuMmmn5Q/Pvv67rlvNISIMvL1DKpwjvHEhF/EMuqgTEHa6P5fj96mI9bc
         /cpHA64R0nEO4XhntzMpv3uIEh0hLUiWrGkvWsMmuLAdZvUEJlW3ukzC/GsG8/WJcdw/
         VWqHsiXUdrn6YEVjJiX4EIdaP6eQ1bvkJ5gVzKxODDWYqjLww+yka+33qqjFJruj7Pm3
         hZKpHvgnsf9OEpbV67ZxW6vdm4jkvGLHfy4WyXmNoTZLczcIN0BiiJrHmWMwUcZlHq3J
         xawyeVFWm4M29MkTBlo1gjU4+AHvsbZbYn7feHBTqLAsEsEb38MQ23iky9i2VJlFIyrY
         6crw==
X-Gm-Message-State: APjAAAX6RQPaHmsR3C8qE93Xt6EI2dOAu97pXNsjx5w4fhhiev7lv0Rp
        1g6gwHKqKHMqUwN+xG22wR1zhr7W4B67y/tSan4=
X-Google-Smtp-Source: APXvYqyMH+XWckXQN9LtfWzHROcgWFxQ4magzkelq68Ejdb8+xSy6hCaDyMp5JKC2oJTPLab0VoLHvbUO+5y4CQSOKc=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr3389799iom.245.1568726256781;
 Tue, 17 Sep 2019 06:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190829161155.GA5360@magnolia> <20190830210603.GB5340@magnolia> <20190905034244.GL5340@magnolia>
In-Reply-To: <20190905034244.GL5340@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 17 Sep 2019 15:17:22 +0200
Message-ID: <CAHpGcM+iYfqniKugC-enWnx+S3KT=8-YtY9RRcr4bVhG8GtkOA@mail.gmail.com>
Subject: Re: [PATCH v2] splice: only read in as much information as there is
 pipe buffer space
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Do., 5. Sept. 2019 um 05:42 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Fri, Aug 30, 2019 at 02:06:03PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> >
> > Andreas Gr=C3=BCnbacher reports that on the two filesystems that suppor=
t
> > iomap directio, it's possible for splice() to return -EAGAIN (instead o=
f
> > a short splice) if the pipe being written to has less space available i=
n
> > its pipe buffers than the length supplied by the calling process.
> >
> > Months ago we fixed splice_direct_to_actor to clamp the length of the
> > read request to the size of the splice pipe.  Do the same to do_splice.
> >
> > Fixes: 17614445576b6 ("splice: don't read more than available pipe spac=
e")
> > Reported-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> > v2: tidy up the other call site per Andreas' request
>
> Ping?  Anyone want to add a RVB to this?

You can add the following:

Reviewed-by: Andreas Gr=C3=BCnbacher <agruenba@redhat.com>
Tested-by: Andreas Gr=C3=BCnbacher <agruenba@redhat.com>

And could you please update the email address in the reported-by tag as wel=
l?

Is this going to go in via the xfs tree?

Thanks,
Andreas
