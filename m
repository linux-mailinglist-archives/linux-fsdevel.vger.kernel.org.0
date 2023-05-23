Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995270D460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjEWGzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjEWGzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:55:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38008132;
        Mon, 22 May 2023 23:55:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so287944a12.1;
        Mon, 22 May 2023 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684824935; x=1687416935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AxJRMSjFiU7MHcgUIRL+XqTRWQxV3GgrxAc+FVBvwiU=;
        b=IhTXUhy9MlNkQnisTrIUcOFqQNGgdSx+hBVH/YuFy8d/mzYynBDeW8bJa7xiGKNQhU
         6v1dpAsGZuN0zMeAS0wK1xrfdQhwHYbHCr4hySk0N+rLpM9tD0NIxQ1ZGiEs23OOmtLs
         oLXiq54+DpPHKmBCkOK6SGHg1/JAEv5KCkrBmaKwfzjaJeZf7JsgV+qDQdmsDBPXVsom
         PnJJQs5aL00sDbVlTobrrbayqpE6VGtZr3rkPM43R3Mz+xZZ4nzEvRjFf2Y7IrCEemq9
         WQoeNwUGzWl6nRtYdDxlHy6SlddoN93nLs8dEcQM9Z8XTED6390NNktIWJOVoPbj4tFI
         smdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684824935; x=1687416935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxJRMSjFiU7MHcgUIRL+XqTRWQxV3GgrxAc+FVBvwiU=;
        b=YRXyRvoV8uvkiJxLoQJYAkHXN5BeKirijP3oZ8hJPYp91jCA8oEODUTbx7La/7GKNR
         epg0mpRVFKGcZWJ0KaAEG8p5VA/OeLzYyOcBIJA4Wp3+N5DTpV8XPtgLrEXchlkistpS
         7w46vDb8BTe0u0F5wIlAdnImMA1OmlPI/L3u8X7VkdnJuQ61oAKuThBXhc/xlfolF6s5
         Eim95sbAhLFQzSuYnqG5mJjsOXKArbK19GBUQxS2448zkAl+NDeU3QQ71ISmgc/f2bdJ
         MvodHRN/6oI4UFHQtvIDsDRL1tjMl+Olxlpwac/lzL0uzAeWdgtmby0L33OogPs45X6+
         7gKg==
X-Gm-Message-State: AC+VfDz1DrytRAYR+PD5ifCUGtVdzR3wYrX5Lb+DsLX9lzbLdBm6puQi
        /a/54w6k4k/vfEaAFA56hUo=
X-Google-Smtp-Source: ACHHUZ6kdntI+DtUsqVpdBz8wswQttnsDSe0y5zvGoz02fIFOAtzEqDBj9qWrObRCBAW04+R2ukM1A==
X-Received: by 2002:a17:902:d506:b0:1ae:4a37:d5af with SMTP id b6-20020a170902d50600b001ae4a37d5afmr14773631plg.0.1684824935505;
        Mon, 22 May 2023 23:55:35 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170902850600b001a183ade911sm5954864plb.56.2023.05.22.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 23:55:35 -0700 (PDT)
Date:   Tue, 23 May 2023 06:55:33 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza, aloktiagi@gmail.com
Subject: Re: [RFC v5 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <ZGxjZXHvvJcCafxT@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230429054955.1957024-1-aloktiagi@gmail.com>
 <20230520-pseudologie-beharren-5c5c440c204e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230520-pseudologie-beharren-5c5c440c204e@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 03:03:48PM +0200, Christian Brauner wrote:
> On Sat, Apr 29, 2023 at 05:49:54AM +0000, aloktiagi wrote:
> > Introduce a mechanism to replace a file linked in the epoll interface with a new
> > file.
> > 
> > eventpoll_replace() finds all instances of the file to be replaced and replaces
> > them with the new file and the interested events.
> > 
> > Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> > ---
> > Changes in v5:
> >   - address review comments and move the call to replace old file in each
> >     subsystem (epoll, io_uring, etc.) outside the fdtable helpers like
> >     replace_fd().
> > 
> > Changes in v4:
> >   - address review comment to remove the redundant eventpoll_replace() function.
> >   - removed an extra empty line introduced in include/linux/file.h
> > 
> > Changes in v3:
> >   - address review comment and iterate over the file table while holding the
> >     spin_lock(&files->file_lock).
> >   - address review comment and call filp_close() outside the
> >     spin_lock(&files->file_lock).
> > ---
> >  fs/eventpoll.c            | 65 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/eventpoll.h |  8 +++++
> >  2 files changed, 73 insertions(+)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 64659b110973..be9d192b223d 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -935,6 +935,71 @@ void eventpoll_release_file(struct file *file)
> >  	mutex_unlock(&epmutex);
> >  }
> >  
> > +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> > +			struct file *tfile, int fd, int full_check);
> > +
> > +/*
> > + * This is called from eventpoll_replace() to replace a linked file in the epoll
> > + * interface with a new file received from another process. This is useful in
> > + * cases where a process is trying to install a new file for an existing one
> > + * that is linked in the epoll interface
> > + */
> > +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)
> > +{
> > +	int fd;
> > +	int error = 0;
> > +	struct eventpoll *ep;
> > +	struct epitem *epi;
> > +	struct hlist_node *next;
> > +	struct epoll_event event;
> > +	struct hlist_head *to_remove = toreplace->f_ep;
> > +
> > +	if (!file_can_poll(file))
> > +		return 0;
> > +
> > +	mutex_lock(&epmutex);
> 
> Sorry, I missed that you send a new version somehow.
> 
> So, I think I mentioned this last time: The locking has changed to
> reduce contention on the global mutex. Both epmutex and ep_remove() are
> gone. So this doesn't even compile anymore...
> 
>   CC      fs/eventpoll.o
> ../fs/eventpoll.c: In function ‘eventpoll_replace_file’:
> ../fs/eventpoll.c:998:21: error: ‘epmutex’ undeclared (first use in this function); did you mean ‘mutex’?
>   998 |         mutex_lock(&epmutex);
>       |                     ^~~~~~~
>       |                     mutex
> ../fs/eventpoll.c:998:21: note: each undeclared identifier is reported only once for each function it appears in
> ../fs/eventpoll.c:1034:17: error: implicit declaration of function ‘ep_remove’; did you mean ‘idr_remove’? [-Werror=implicit-function-declaration]
>  1034 |                 ep_remove(ep, epi);
>       |                 ^~~~~~~~~
>       |                 idr_remove
> 
> on current mainline. So please send a new version for this.

Apologies, I didn't realize the change had been merged. Will send out a new version.
