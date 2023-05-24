Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2870EDE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbjEXGgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbjEXGgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:36:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A8186;
        Tue, 23 May 2023 23:36:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64f48625615so159869b3a.0;
        Tue, 23 May 2023 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910182; x=1687502182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHgNqGqqIkHwA9lYkNOxSmpbrbeMPTMOyESRzOFlp6I=;
        b=gmIzBb85GG7YeS2xJIoDYM2rOjQeDBsbUlzAu852j8uJJ3kC8sYnlFpcwwbFVr+rtd
         uP3FBlJmCYLt27c2RsZSsRlFbNI7aXR7O0Oy/0mwDeI6X9xdd/9hfaorVvsoovow1KRk
         FoefWW9Y6mxGKf9u0QBLT1Wh5bSRy7VD9i5Ss2asafvemK3LOcWeeBOCJxvhewuSDGl4
         7M3AjVam+CkCaDqKwV40ZeuLzndkUxNy553WULj1xMpsAmzCCYs4ftisKBNVPz9nu58O
         2x4idKJDg8WPnEfamRjZo0TAYMzlwj7tQk4hDz9HD6qOi8pl096u6Xl/U4ZxRD7FzjMT
         m7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910182; x=1687502182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHgNqGqqIkHwA9lYkNOxSmpbrbeMPTMOyESRzOFlp6I=;
        b=SMhEk72Px0sqm40fS6bcva+uYhMb0hcaAxykQreF5NWbT9D0IT5fPgEkIADZa9pKux
         5hhl6/Fl+Gw1HrbvC41zsjUCnU750ZDf2MXEN98INQNmTBEMmoep2YqyFoE/2DmQw+cm
         xjxksiDoG2OhLRMjFhod5s8Wa84I4k02rrBIBRiQxdmloWN0Jrp9qB4Wh8hw9bXrCwsq
         2iAMUqOSzIhTfPWjtf7kB/gRN3gPQWLnRMvwMR4Eju6cFWhYI41P7oEu9kJWDwagbOIw
         XPCw7NjYhfjd/21yp21qfdkF7/600EUZJ8TDJg3wUczm8o7lYUgElC0udXFfcQMFxeyA
         lVag==
X-Gm-Message-State: AC+VfDyfP1/Gvucerk0OyfJjYm2X8Bqou0VRXhfi++Aqayyo2Bdw35fT
        N+RmhxskfSlHeo94BSjEJNs=
X-Google-Smtp-Source: ACHHUZ76nyXMuQeVcvhTbuGtZ+2GSOokpfQtBgTwjVnBEClA7VBm74nQipn1gKLG3yVQUWHX9tpzJg==
X-Received: by 2002:a05:6a20:3d95:b0:105:66d3:854d with SMTP id s21-20020a056a203d9500b0010566d3854dmr14260913pzi.6.1684910181909;
        Tue, 23 May 2023 23:36:21 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b00640ddad2e0dsm6745260pfo.47.2023.05.23.23.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:36:21 -0700 (PDT)
Date:   Wed, 24 May 2023 06:36:19 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v6 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <ZG2wY9hNFHvQMzrO@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230523065802.2253926-1-aloktiagi@gmail.com>
 <20230523-unleserlich-impfen-e193df4b4b30@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-unleserlich-impfen-e193df4b4b30@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:32:06PM +0200, Christian Brauner wrote:
> On Tue, May 23, 2023 at 06:58:01AM +0000, aloktiagi wrote:
> > Introduce a mechanism to replace a file linked in the epoll interface with a new
> > file.
> > 
> > eventpoll_replace() finds all instances of the file to be replaced and replaces
> > them with the new file and the interested events.
> > 
> > Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> > ---
> > Changes in v6:
> >   - incorporate latest changes that get rid of the global epmutex lock.
> > 
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
> >  fs/eventpoll.c            | 76 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/eventpoll.h |  8 +++++
> >  2 files changed, 84 insertions(+)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 980483455cc0..9c7bffa8401b 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -973,6 +973,82 @@ void eventpoll_release_file(struct file *file)
> >  	spin_unlock(&file->f_lock);
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
> > +	struct file *to_remove = toreplace;
> > +	struct epoll_event event;
> > +	struct hlist_node *next;
> > +	struct eventpoll *ep;
> > +	struct epitem *epi;
> > +	int error = 0;
> > +	bool dispose;
> > +	int fd;
> > +
> > +	if (!file_can_poll(file))
> > +		return 0;
> > +
> > +	spin_lock(&toreplace->f_lock);
> > +	if (unlikely(!toreplace->f_ep)) {
> > +		spin_unlock(&toreplace->f_lock);
> > +		return 0;
> > +	}
> > +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> > +		ep = epi->ep;
> > +		mutex_lock(&ep->mtx);
> 
> Afaict, you're under a spinlock and you're acquiring a mutex. The
> spinlock can't sleep (on non-rt kernels at least) but the mutex can.
> 

thank you. I'll address this in another way in the next patch series. Please
let me know of your opinion on how it can be achieved differently.

> > +		fd = epi->ffd.fd;
> > +		if (fd != tfd) {
> > +			mutex_unlock(&ep->mtx);
> > +			continue;
> > +		}
> > +		event = epi->event;
> > +		error = ep_insert(ep, &event, file, fd, 1);
> > +		mutex_unlock(&ep->mtx);
> > +		if (error != 0) {
> > +			break;
> > +		}
> 
> nit: we don't do { } around single lines.

will fix this in the next series.
