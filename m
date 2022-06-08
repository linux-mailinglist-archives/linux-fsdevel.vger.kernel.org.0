Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876A75430C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiFHMuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiFHMut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:50:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61F22DF8A
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 05:50:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5B601F90E;
        Wed,  8 Jun 2022 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654692645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKh1Gu9fh8FWZCR16pOERdlUu8ff9X/QTjTKWgok3pM=;
        b=z8s+rupABbgk0yVpjW6TA/q6gKPZbfOpScdCfKF0E8G6tuTOWs5Aqbj0V/htZ9rAOWSQxy
        hRC6ZrboibOI4emAC/xTv7UaslV+ONvUEtLCfPazo3otbSN03XSiF9aDzwZwHGJCyWUoLY
        hpp7lD8HTBXOSMTNi/Phj9hPnDBDadY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654692645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKh1Gu9fh8FWZCR16pOERdlUu8ff9X/QTjTKWgok3pM=;
        b=uXwhXBjksGyIb38dcsVYXRbnbfJPVQFHi2ukgouMmd9PTKxDPFqZXiKBdO4mrVgV9FI4Vf
        2ns9xc7wGovQ3ICw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B14C92C141;
        Wed,  8 Jun 2022 12:50:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A722A06E2; Wed,  8 Jun 2022 14:50:40 +0200 (CEST)
Date:   Wed, 8 Jun 2022 14:50:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gal Rosen <gal.rosen@cybereason.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Failed on reading from FANOTIFY file descriptor
Message-ID: <20220608125039.jpeufb2pl7xacs4t@quack3.lan>
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
 <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
 <CAJ-MHhBkKycGJnMVwt+KuFnzz=8sDzyuHWTxvHVJnJ55mKLiPQ@mail.gmail.com>
 <20220608115738.gcnviw7ldunw6vb5@quack3.lan>
 <CAJ-MHhD4HZq3G8AoPVGGc6+AEPR7G0UXkT0m=6AeeEMq3CjPDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-MHhD4HZq3G8AoPVGGc6+AEPR7G0UXkT0m=6AeeEMq3CjPDw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gal!

On Wed 08-06-22 15:41:45, Gal Rosen wrote:
> Thanks for the answer, just to make sure that I understand, if I see the
> EMFILE error then it was on the first event and no event was copied to the
> user buffer.
> If it happened on the second or later events then the user will not see the
> error, and will get length corresponding to the successfully formatted
> events.
> In both cases the events after the failure event will be saved in the
> kernel queue, and I can try to read them at the next read ?

Yes.

> I want to understand if such a case is recoverable, because today at any
> FANOTIFY error we use a methodology of safe-mode, in which we shutdown the
> FANOTIFY, kill our service and come up again.
> We do it because in the past we had some cases in which we did not write a
> response on some file events and it stuck the whole system.

So if you read permission event and do not write reply, it can indeed stall
the whole system. But in case fanotify subsystem fails to create an event
(such as in the EMFILE error case), we do properly clean up the failed event
and the operation generating the event gets automatic "denied" response.

> We do it for safety because we thought that there might be some file events
> that we did not respond in a case of error, but if you are saying that all
> events after the error event are still in the kernel queue and we do not
> need to respond on them, then I guess we can continue run without
> restarting our service.

Yes, you should be able to continue without restarting.

								Honza

> On Wed, Jun 8, 2022 at 2:57 PM Jan Kara <jack@suse.cz> wrote:
> 
> > Hello,
> >
> > On Wed 08-06-22 14:33:47, Gal Rosen wrote:
> > > One more question, if I do get into a situation in which I reach the
> > limit
> > > of the number of open files per my process, can I continue ? Can I
> > continue
> > > in my while loop and after a couple of microseconds for example can try
> > to
> > > re-read ?
> > > If I get the error of EMFILE, it could be that some of the events
> > > successfully read and are already in my user buffer, but I still get
> > return
> > > value of -1 on the read, does all the successful events are still in the
> > > kernel queue and will be still there for the next read ?
> >
> > So if you get the EMFILE error, it means that we were not able to open file
> > descriptor for the first event you are trying to read. If the same error
> > happens for the second or later event copied into user provided buffer, we
> > return length corresponding to the succesfully formatted events. Sadly, the
> > event for which we failed to open file will be silently dropped in that
> > case
> > :-|. Amir, I guess we should at least report the event without the fd in
> > that case. What do you think?
> >
> >                                                                 Honza
> >
> > > On Wed, Jun 8, 2022 at 2:01 PM Gal Rosen <gal.rosen@cybereason.com>
> > wrote:
> > >
> > > > Hi Amir,
> > > >
> > > > What do you mean by bumping the CAP_SYS_ADMIN limit ?
> > > > You mean to increase the max open file for my process that watches the
> > > > FANOTIFY fd ?
> > > > May I instead decrease the read buffer size ?
> > > > My read buffer is 4096 * 6, the fanotify_event_metadata structure size
> > is
> > > > 24 bytes, so it can hold 1024 file events at one read.
> > > > My process Max open files soft limit is 1024, so why do I get this
> > error ?
> > > > Ohh, maybe because after reading the events I put them in a queue and
> > > > continue for the next read, so if file events still have not been
> > released
> > > > by my application, then the next read can exceed 1024 files opened.
> > > >
> > > > Yes ,we use permission events. We watch on FAN_OPEN_PERM |
> > FAN_CLOSE_WRITE.
> > > > We also want to support the oldest kernels.
> > > >
> > > > BTW: What do you mean by "assuming that your process has
> > CAP_SYS_ADMIN" ?
> > > >
> > > > Regarding the EPERM, how do we continue to investigate it ?
> > > >
> > > > Thanks,
> > > > Gal.
> > > >
> > > > בתאריך יום ד׳, 8 ביוני 2022, 12:00, מאת Amir Goldstein ‏<
> > > > amir73il@gmail.com>:
> > > >
> > > >> On Wed, Jun 8, 2022 at 11:31 AM Gal Rosen <gal.rosen@cybereason.com>
> > > >> wrote:
> > > >> >
> > > >> > Hi Jack,
> > > >> >
> > > >> > Can you provide details on the reason I sometimes get read errors on
> > > >> events that I get from FANOTIFY ?
> > > >> > My user space program watches on all mount points in the system and
> > > >> sometimes when in parallel I run full scan with another application
> > on all
> > > >> my files in the endpoint, I get a read error when trying to read from
> > the
> > > >> FANOTIFY fd on a new event.
> > > >> > The errno is sometimes EPERM (Operation not permitted) and sometimes
> > > >> EMFILE (Too many open files).
> > > >> >
> > > >>
> > > >> Hi Gal,
> > > >>
> > > >> EPERM is a bit surprising assuming that your process has
> > CAP_SYS_ADMIN,
> > > >> so needs investigating, but EMFILE is quite obvious.
> > > >> Every event read needs to open a fd to place in event->fd.
> > > >> If you exceed your configured limit, this error is expected.
> > > >> You can bump the limit as CAP_SYS_ADMIN if that helps.
> > > >>
> > > >> > The last time I saw these errors, it was on RHEL 8.5, kernel
> > > >> 4.18.0-348.23.1.el8_5.x86_64.
> > > >>
> > > >> Does your application even use permission events?
> > > >> If it doesn't then watching with a newer kernel (>5.1) and
> > FAN_ERPORT_FID
> > > >> is going to be more efficient in resources and you wont need to worry
> > > >> about open files limits.
> > > >>
> > > >> Thanks,
> > > >> Amir.
> > > >>
> > > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
