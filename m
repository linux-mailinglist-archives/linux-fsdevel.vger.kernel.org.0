Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DF68F60E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 18:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBHRt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 12:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBHRtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5B51C61
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675878489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73qlzVdSesuYbBADd5jb1f0GQcPgrypQQspoUXs7DGs=;
        b=QfP2Z2xEeRz9nSxP7KKXcjKv1CLp3/+6NA00aoex+MHGUBk3M+xx6TrB5vzTxO3hDECS4n
        rFJMWUU7S6X0d0nufEA17RGkx8vXaY85D3G6z6hIsbqGOLMd7NjfXMiqzpuaCIm1uXYqO7
        V5uFgBEjF8ExO5eulXfXDD5Q+/fTPzA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-RM1Y4A_mMIqvMs_dCdVlNQ-1; Wed, 08 Feb 2023 12:37:19 -0500
X-MC-Unique: RM1Y4A_mMIqvMs_dCdVlNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A09A31C29D40;
        Wed,  8 Feb 2023 17:37:18 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE21418EC2;
        Wed,  8 Feb 2023 17:37:16 +0000 (UTC)
Date:   Wed, 8 Feb 2023 12:37:14 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back
 additional audit info
Message-ID: <Y+PdyieoFNcNQgmQ@madcap2.tricolour.ca>
References: <cover.1675373475.git.rgb@redhat.com>
 <20230208120816.2qhck3sb7u67vsib@quack3>
 <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com>
 <5912195.lOV4Wx5bFT@x2>
 <CAHC9VhQnajhwOiW-0GvgnkPJ=QOTuLaYt2WBbm8vJoyEDso=2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQnajhwOiW-0GvgnkPJ=QOTuLaYt2WBbm8vJoyEDso=2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-02-08 11:24, Paul Moore wrote:
> On Wed, Feb 8, 2023 at 10:27 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Wednesday, February 8, 2023 10:03:24 AM EST Paul Moore wrote:
> > > On Wed, Feb 8, 2023 at 7:08 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 07-02-23 09:54:11, Paul Moore wrote:
> > > > > On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > > > > > The Fanotify API can be used for access control by requesting
> > > > > > > permission
> > > > > > > event notification. The user space tooling that uses it may have a
> > > > > > > complicated policy that inherently contains additional context for
> > > > > > > the
> > > > > > > decision. If this information were available in the audit trail,
> > > > > > > policy
> > > > > > > writers can close the loop on debugging policy. Also, if this
> > > > > > > additional
> > > > > > > information were available, it would enable the creation of tools
> > > > > > > that
> > > > > > > can suggest changes to the policy similar to how audit2allow can
> > > > > > > help
> > > > > > > refine labeled security.
> > > > > > >
> > > > > > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > > > > > define additional information which are appended after the response
> > > > > > > structure returned from user space on a permission event.  The
> > > > > > > appended
> > > > > > > information is organized with headers containing a type and size
> > > > > > > that
> > > > > > > can be delegated to interested subsystems.  One new information
> > > > > > > type is
> > > > > > > defined to audit the triggering rule number.
> > > > > > >
> > > > > > > A newer kernel will work with an older userspace and an older
> > > > > > > kernel
> > > > > > > will behave as expected and reject a newer userspace, leaving it up
> > > > > > > to
> > > > > > > the newer userspace to test appropriately and adapt as necessary.
> > > > > > > This
> > > > > > > is done by providing a a fully-formed FAN_INFO extension but
> > > > > > > setting the
> > > > > > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no
> > > > > > > audit
> > > > > > > record, whereas on an older kernel it will fail.
> > > > > > >
> > > > > > > The audit function was updated to log the additional information in
> > > > > > > the
> > > > > > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > > > > >
> > > > > > > format:
> > > > > > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1
> > > > > > >   fan_info=3137 subj_trust=3 obj_trust=5 type=FANOTIFY
> > > > > > >   msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0
> > > > > > >   subj_trust=2 obj_trust=2> > >
> > > > > > Thanks! I've applied this series to my tree.
> > > > >
> > > > > While I think this version of the patchset is fine, for future
> > > > > reference it would have been nice if you had waited for my ACK on
> > > > > patch 3/3; while Steve maintains his userspace tools, I'm the one
> > > > > responsible for maintaining the Linux Kernel's audit subsystem.
> > > >
> > > > Aha, I'm sorry for that. I had the impression that on the last version of
> > > > the series you've said you don't see anything for which the series should
> > > > be respun so once Steve's objections where addressed and you were silent
> > > > for a few days, I thought you consider the thing settled... My bad.
> > >
> > > That's understandable, especially given inconsistencies across
> > > subsystems.  If it helps, if I'm going to ACK something I make it
> > > explicit with a proper 'Acked-by: ...' line in my reply; if I say
> > > something looks good but there is no explicit ACK, there is usually
> > > something outstanding that needs to be resolved, e.g. questions,
> > > additional testing, etc.
> > >
> > > In this particular case I posed some questions in that thread and
> > > never saw a reply with any answers, hence the lack of an ACK.  While I
> > > think the patches were reasonable, I withheld my ACK until the
> > > questions were answered ... which they never were from what I can
> > > tell, we just saw a new patchset with changes.
> > >
> > > /me shrugs
> >
> > Paul,
> >
> > I reread the thread. You only had a request to change if/else to a switch
> > construct only if there was a respin for the 3F. You otherwise said get
> > Steve's input and the 3F borders on being overly clever. Both were addressed.
> > If you had other questions that needed answers on, please restate them to
> > expedite approval of this set of patches. As far as I can tell, all comments
> > are addressed.
> 
> Steve,
> 
> It might be helpful to reread my reply below:
> 
> https://lore.kernel.org/linux-audit/CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com/
> 
> You'll see that I made a comment in that email about not following
> Richard's explanation about "encoding the zero" (the patch was
> encoding a "?" to the best I could tell).  I was hoping for some
> clarification from Richard on his comments, and I never saw anything
> in my inbox.  I just checked the archives on lore and I don't see
> anything there either.

Well, it could have been any of:
	?
	"?"
	3F
	30
	0

I can't answer that.  My preference is for 3F but good arguments can be
made for any of these.  I defer to Steve since it is his tools and
customers that have to deal with it.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

