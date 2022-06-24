Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D857655A049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFXRhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiFXRhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64D926362F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656092226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TqUnppsLw+ptEFOWt96xqRoxkSJ1xKv0wtk/TcEKVps=;
        b=BFVrBJQ8bT/BPBVGa4c75qhAS4AJy4MEv76CafLHiIWRngrNDiatuvtwp/WTrPDg+91+Lj
        ZcTB0EspBYkmdIzRQB5FtUt00NhNDrZ6Z57EqemqGtHHaJPxBlg3Fyz/2Kti7aYdIwXMF4
        e/Cw8aoo1MZEhdUZqNZ8EjusYGuFJEs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-NlKausoxPTGBlsCfhDCECA-1; Fri, 24 Jun 2022 13:37:01 -0400
X-MC-Unique: NlKausoxPTGBlsCfhDCECA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B88F729AB442;
        Fri, 24 Jun 2022 17:37:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0226A492C3B;
        Fri, 24 Jun 2022 17:36:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B7C8E2209F9; Fri, 24 Jun 2022 13:36:59 -0400 (EDT)
Date:   Fri, 24 Jun 2022 13:36:59 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <YrX2O4Yv8elsQkF9@redhat.com>
References: <YrShFXRLtRt6T/j+@risky>
 <YrThSLvG8JSLHG4j@redhat.com>
 <YrT6Hdqp36HLK9PJ@netflix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrT6Hdqp36HLK9PJ@netflix>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:41:17PM -0600, Tycho Andersen wrote:
> On Thu, Jun 23, 2022 at 05:55:20PM -0400, Vivek Goyal wrote:
> > So in this case single process is client as well as server. IOW, one
> > thread is fuse server servicing fuse requests and other thread is fuse
> > client accessing fuse filesystem?
> 
> Yes. Probably an abuse of the API and something people Should Not Do,
> but as you say the kernel still shouldn't lock up like this.
> 
> > > since the thread has a copy of
> > > the fd table with an fd pointing to the same fuse device, the reference
> > > count isn't decremented to zero in fuse_dev_release(), and the task hangs
> > > forever.
> > 
> > So why did fuse server thread stop responding to fuse messages. Why
> > did it not complete flush.
> 
> In this particular case I think it's because the application crashed
> for unrelated reasons and tried to exit the pidns, hitting this
> problem.
> 
> > BTW, unkillable wait happens on ly fc->no_interrupt = 1. And this seems
> > to be set only if server probably some previous interrupt request
> > returned -ENOSYS.
> > 
> > fuse_dev_do_write() {
> >                 else if (oh.error == -ENOSYS)
> >                         fc->no_interrupt = 1;
> > }
> > 
> > So a simple workaround might be for server to implement support for
> > interrupting requests.
> 
> Yes, but that is the libfuse default IIUC.

Looking at libfuse code. I understand low level API interface and for
that looks like generic code itself will take care of this (without
needing support from filesystem).

libfuse/lib/fuse_lowlevel.c

do_interrupt().

> 
> > Having said that, this does sounds like a problem and probably should
> > be fixed at kernel level.
> > 
> > > 
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 0e537e580dc1..c604dfcaec26 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -297,7 +297,6 @@ void fuse_request_end(struct fuse_req *req)
> > >  		spin_unlock(&fiq->lock);
> > >  	}
> > >  	WARN_ON(test_bit(FR_PENDING, &req->flags));
> > > -	WARN_ON(test_bit(FR_SENT, &req->flags));
> > >  	if (test_bit(FR_BACKGROUND, &req->flags)) {
> > >  		spin_lock(&fc->bg_lock);
> > >  		clear_bit(FR_BACKGROUND, &req->flags);
> > > @@ -381,30 +380,33 @@ static void request_wait_answer(struct fuse_req *req)
> > >  			queue_interrupt(req);
> > >  	}
> > >  
> > > -	if (!test_bit(FR_FORCE, &req->flags)) {
> > > -		/* Only fatal signals may interrupt this */
> > > -		err = wait_event_killable(req->waitq,
> > > -					test_bit(FR_FINISHED, &req->flags));
> > > -		if (!err)
> > > -			return;
> > > +	/* Only fatal signals may interrupt this */
> > > +	err = wait_event_killable(req->waitq,
> > > +				test_bit(FR_FINISHED, &req->flags));
> > 
> > Trying to do a fatal signal killable wait sounds reasonable. But I am
> > not sure about the history.
> > 
> > - Why FORCE requests can't do killable wait.
> > - Why flush needs to have FORCE flag set.
> 
> args->force implies a few other things besides this killable wait in
> fuse_simple_request(), most notably:
> 
> req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
> 
> and
> 
> __set_bit(FR_WAITING, &req->flags);

FR_WAITING stuff is common between both type of requests. We set it
in fuse_get_req() as well which is called for non-force requests.

So there seem to be only two key difference. 

- We allocate request with flag __GFP_NOFAIL for force. So don't
  want memory allocation to fail.

- And this special casing of non-killable wait. 

Miklos probably will have more thoughts on this. 

Thanks
Vivek

> 
> seems like it probably can be invoked from some non-user/atomic
> context somehow?
> 
> > > +	if (!err)
> > > +		return;
> > >  
> > > -		spin_lock(&fiq->lock);
> > > -		/* Request is not yet in userspace, bail out */
> > > -		if (test_bit(FR_PENDING, &req->flags)) {
> > > -			list_del(&req->list);
> > > -			spin_unlock(&fiq->lock);
> > > -			__fuse_put_request(req);
> > > -			req->out.h.error = -EINTR;
> > > -			return;
> > > -		}
> > > +	spin_lock(&fiq->lock);
> > > +	/* Request is not yet in userspace, bail out */
> > > +	if (test_bit(FR_PENDING, &req->flags)) {
> > > +		list_del(&req->list);
> > >  		spin_unlock(&fiq->lock);
> > > +		__fuse_put_request(req);
> > > +		req->out.h.error = -EINTR;
> > > +		return;
> > >  	}
> > > +	spin_unlock(&fiq->lock);
> > >  
> > >  	/*
> > > -	 * Either request is already in userspace, or it was forced.
> > > -	 * Wait it out.
> > > +	 * Womp womp. We sent a request to userspace and now we're getting
> > > +	 * killed.
> > >  	 */
> > > -	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> > > +	set_bit(FR_INTERRUPTED, &req->flags);
> > > +	/* matches barrier in fuse_dev_do_read() */
> > > +	smp_mb__after_atomic();
> > > +	/* request *must* be FR_SENT here, because we ignored FR_PENDING before */
> > > +	WARN_ON(!test_bit(FR_SENT, &req->flags));
> > > +	queue_interrupt(req);
> > >  }
> > >  
> > >  static void __fuse_request_send(struct fuse_req *req)
> > > 
> > > avaialble as a full patch here:
> > > https://github.com/tych0/linux/commit/81b9ff4c8c1af24f6544945da808dbf69a1293f7
> > > 
> > > but now things are even weirder. Tasks are stuck at the killable wait, but with
> > > a SIGKILL pending for the thread group.
> > 
> > That's strange. No idea what's going on.
> 
> Thanks for taking a look. This is where it falls apart for me. In
> principle the patch seems simple, but this sleeping behavior is beyond
> my understanding.
> 
> Tycho
> 

