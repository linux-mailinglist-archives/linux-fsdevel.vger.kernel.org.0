Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE05430F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiFHNDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiFHNDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:03:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96763EA
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:03:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3BAD81F90F;
        Wed,  8 Jun 2022 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654693389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZodhsDL+iz2tv1KduZfa/eKDJwTJW4ZVDBhtgMQV48=;
        b=Ha6nsQW/kqMBq1+qPrJgZ0c+AGNp8sx7SaMv0yZc2b+pCkaUDqcyRgYfeBQAfmxifgXOcY
        DqLsZZ+A4NczYukDyaTwzVv+P5p+hOVRiA2l9lYPV4P6xb0AHVr0gcJWmWLLLmxNb8GNzu
        XknDmZXk8EkTu+G2YOGsVkLWKIdNp7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654693389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZodhsDL+iz2tv1KduZfa/eKDJwTJW4ZVDBhtgMQV48=;
        b=bFQ80IJYIxqlKUNjrw06CwkdzIitYfF1sDB5UIKUffCYO85EuByXfv9KHL7EMUq+m4JQL1
        I0eBwdFT0DL7LMDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F5CE2C141;
        Wed,  8 Jun 2022 13:03:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCBC4A06E2; Wed,  8 Jun 2022 15:03:08 +0200 (CEST)
Date:   Wed, 8 Jun 2022 15:03:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Gal Rosen <gal.rosen@cybereason.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Failed on reading from FANOTIFY file descriptor
Message-ID: <20220608130308.azz3kolubtkomxxj@quack3.lan>
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
 <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
 <CAJ-MHhBkKycGJnMVwt+KuFnzz=8sDzyuHWTxvHVJnJ55mKLiPQ@mail.gmail.com>
 <20220608115738.gcnviw7ldunw6vb5@quack3.lan>
 <CAOQ4uxif8aoYBqLZp30Sf6Ad5MKWh+sYBZJ7kT3yRtabnNYJ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxif8aoYBqLZp30Sf6Ad5MKWh+sYBZJ7kT3yRtabnNYJ9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 15:14:12, Amir Goldstein wrote:
> On Wed, Jun 8, 2022 at 2:57 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > On Wed 08-06-22 14:33:47, Gal Rosen wrote:
> > > One more question, if I do get into a situation in which I reach the limit
> > > of the number of open files per my process, can I continue ? Can I continue
> > > in my while loop and after a couple of microseconds for example can try to
> > > re-read ?
> > > If I get the error of EMFILE, it could be that some of the events
> > > successfully read and are already in my user buffer, but I still get return
> > > value of -1 on the read, does all the successful events are still in the
> > > kernel queue and will be still there for the next read ?
> >
> > So if you get the EMFILE error, it means that we were not able to open file
> > descriptor for the first event you are trying to read. If the same error
> > happens for the second or later event copied into user provided buffer, we
> > return length corresponding to the succesfully formatted events. Sadly, the
> > event for which we failed to open file will be silently dropped in that case
> > :-|. Amir, I guess we should at least report the event without the fd in
> > that case. What do you think?
> 
> Yes, that is unfortunate.
> We could return an event without fd.
> We could return the error in event->fd but I don't like it.
> We could store the error in the group and return success for
> whatever events have been read so far, then on the next read
> we just return the error immediately and clear the group error state.
> 
> That will keep existing UAPI semantics intact.

Yes, what you suggest looks like a clean way out of this situation. BTW
-EFAULT handling is strange as well (that seems to come from inotify
times). If we get -EFAULT during copying event, we'll just report it and
ignore whatever we have already copied to userspace. But I guess in this
case it is at least consistent with the behavior of standard read(2) and if
you hit -EFAULT, you are doing something seriously wrong and lost events
are the least of your worries (although for fanotify it means we have just
leaked the file descriptors for already copied events and with permission
events that's going to be deadly for the system). Ugh.

> BTW, in the category of possible errors from reading event there are
> also ENXIO ENODEV when a process tries to open a device file
> with nothing behind it, which is very easy to reproduce.

Yes.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
