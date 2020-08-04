Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0931323BB11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgHDNVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHDNTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:19:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D543C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 06:19:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so42374341ejj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tiNv5DVcOXdEPntNp/BHigQ6vn1IdXaRNNTHtn8xqU=;
        b=KEhgw4sBlsPCdz3kxw6pOlJHSKiC7Xhrls74Blf9MLTBsZBCWCUz06ysPssFA9U19y
         Yr1EAIthn/gCTRdcIfAYF+6wn1SeTRE1WGDZQperfGWrs4+nANZWMbHukGdUWX4kW5Ms
         t0R69K52Mm+kNPbIdl2Wftun28JL8wpQIioC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tiNv5DVcOXdEPntNp/BHigQ6vn1IdXaRNNTHtn8xqU=;
        b=KS7HnfSnzQgaoWhCHUTwArtr1mo+LprtMSJGA3lSL3+jvd43qR0n7GJHdTdgdbQkY6
         AVuoUCsBJapeGS/qYP3rU0vEzKFDt2KEI1XKwVZswqheA5znfEmR6sOvvamPID1SY7AW
         3Hel2laIqx4bBP0rNdHF7Beb2lvfTAs+LDQzATAZGTPNc1QMedEGuFQavI163KIYQBs1
         e6txaqn/7B5NCeBW7s8z6Lkj78r13nuje81/qnvAZ6WI3VciyYLmQ6oCxfTUkYhHJHCj
         SMhiNTIc7mCUuZnyPwwcoVau6yhs6sHppLnnHhYTzplM3lk/jER1ZeiYUoKlavLtSFS0
         7CEQ==
X-Gm-Message-State: AOAM532Kqc03UGLqUIo8HugVnyZ7Ioxx2G+Yptn/iq9OdYRMi/3sFLQn
        pF1m4/VFkKWWQbLFpooHiUaSNFmYCNZ+eHN8Qi3lFA==
X-Google-Smtp-Source: ABdhPJyoWlMhvjqTJH7OiyxKhB5EGgaKJVZv6f4IRwD539FbIC9dkAFHWgaT/ph3af6QlUQF5Jf2SpagpjgID6l9h+k=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr3966025ejb.511.1596547156596;
 Tue, 04 Aug 2020 06:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <1293241.1595501326@warthog.procyon.org.uk> <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
 <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
In-Reply-To: <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 15:19:05 +0200
Message-ID: <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:39 PM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2020-08-03 at 11:29 +0200, Miklos Szeredi wrote:
> > On Thu, Jul 23, 2020 at 12:48 PM David Howells <dhowells@redhat.com>
> > wrote:
> >
> > > > >                 __u32   topology_changes;
> > > > >                 __u32   attr_changes;
> > > > >                 __u32   aux_topology_changes;
> > > >
> > > > Being 32bit this introduces wraparound effects.  Is that really
> > > > worth it?
> > >
> > > You'd have to make 2 billion changes without whoever's monitoring
> > > getting a
> > > chance to update their counters.  But maybe it's not worth it
> > > putting them
> > > here.  If you'd prefer, I can make the counters all 64-bit and just
> > > retrieve
> > > them with fsinfo().
> >
> > Yes, I think that would be preferable.
>
> I think this is the source of the recommendation for removing the
> change counters from the notification message, correct?
>
> While it looks like I may not need those counters for systemd message
> buffer overflow handling myself I think removing them from the
> notification message isn't a sensible thing to do.
>
> If you need to detect missing messages, perhaps due to message buffer
> overflow, then you need change counters that are relevant to the
> notification message itself. That's so the next time you get a message
> for that object you can be sure that change counter comparisons you
> you make relate to object notifications you have processed.

I don't quite get it.  Change notification is just that: a
notification.   You need to know what object that notification relates
to, to be able to retrieve the up to date attributes of said object.

What happens if you get a change counter N in the notification
message, then get a change counter N + 1 in the attribute retrieval?
You know that another change happened, and you haven't yet processed
the notification yet.  So when the notification with N + 1 comes in,
you can optimize away the attribute retrieve.

Nice optimization, but it's optimizing a race condition, and I don't
think that's warranted.  I don't see any other use for the change
counter in the notification message.


> Yes, I know it isn't quite that simple, but tallying up what you have
> processed in the current batch of messages (or in multiple batches of
> messages if more than one read has been possible) to perform the check
> is a user space responsibility. And it simply can't be done if the
> counters consistency is in question which it would be if you need to
> perform another system call to get it.
>
> It's way more useful to have these in the notification than obtainable
> via fsinfo() IMHO.

What is it useful for?

If the notification itself would contain the list of updated
attributes and their new values, then yes, this would make sense.  If
the notification just tells us that the object was modified, but not
the modifications themselves, then I don't see how the change counter
in itself could add any information (other than optimizing the race
condition above).

Thanks,
Miklos

Thanks,



>
> >
> > > > >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true
> > > > > indicates that
> > > > >         the notifcation was generated by an event (eg. SETATTR)
> > > > > that was
> > > > >         applied recursively.  The notification is only
> > > > > generated for the
> > > > >         object that initially triggered it.
> > > >
> > > > Unused in this patchset.  Please don't add things to the API
> > > > which are not
> > > > used.
> > >
> > > Christian Brauner has patches for mount_setattr() that will need to
> > > use this.
> >
> > Fine, then that patch can add the flag.
> >
> > Thanks,
> > Miklos
>
