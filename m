Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDC4AFFF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 23:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiBIWOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 17:14:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiBIWOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C85C0F8699
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644444841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOTWBC0hOhE1ppC7pifFcqnv228X+SVXx6iZSOt6Bgk=;
        b=Rg4xtAXpLlqaL36gdqCH6MO/um88iO2noHOfHChkXIs0IppMWcLPfYB1ZWZ2MRzd8B5oSF
        +KPCvBcTSybx6cnNrFjCR60djSdV+1bK59AIf20joyevaE2uohBPAS4AhC/Qb5SiDw+GzM
        Sd6Bv5oHO39vUzzPqU6kr7lTgvgYmvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-ulG4GofINo6KDHgWQtL00A-1; Wed, 09 Feb 2022 17:13:58 -0500
X-MC-Unique: ulG4GofINo6KDHgWQtL00A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC95484E03F;
        Wed,  9 Feb 2022 22:13:56 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B4AF5DF37;
        Wed,  9 Feb 2022 22:13:54 +0000 (UTC)
Date:   Wed, 9 Feb 2022 17:13:52 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
Message-ID: <20220209221352.GG1708086@madcap2.tricolour.ca>
References: <cover.1621363275.git.rgb@redhat.com>
 <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com>
 <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
 <CAHC9VhRCBMtWWscTFWe4W_F_KNdfLys7e5Ged+N_xddD2tkuRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRCBMtWWscTFWe4W_F_KNdfLys7e5Ged+N_xddD2tkuRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-02-09 16:18, Paul Moore wrote:
> On Wed, Feb 9, 2022 at 10:57 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Feb 8, 2022 at 10:44 PM Jeff Mahoney <jeffm@suse.com> wrote:
> > >
> > > Hi Richard -
> > >
> > > On 5/19/21 16:00, Richard Guy Briggs wrote:
> > > > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > > > ("open: introduce openat2(2) syscall")
> > > >
> > > > Add the openat2(2) syscall to the audit syscall classifier.
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > > > ---
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index d775ea16505b..3f59ab209dfd 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -76,6 +76,7 @@
> > > >  #include <linux/fsnotify_backend.h>
> > > >  #include <uapi/linux/limits.h>
> > > >  #include <uapi/linux/netfilter/nf_tables.h>
> > > > +#include <uapi/linux/openat2.h>
> > > >
> > > >  #include "audit.h"
> > > >
> > > > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> > > >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> > > >       case AUDITSC_EXECVE:
> > > >               return mask & AUDIT_PERM_EXEC;
> > > > +     case AUDITSC_OPENAT2:
> > > > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> > > >       default:
> > > >               return 0;
> > > >       }
> > >
> > > ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.
> > >
> > > I'm getting oopses, like so:
> > > BUG: unable to handle page fault for address: 00007fff961bbe70
> >
> > Thanks Jeff.
> >
> > Yes, this is obviously the wrong thing to being doing; I remember
> > checking to make sure we placed the audit_openat2_how() hook after the
> > open_how was copied from userspace, but I missed the argv dereference
> > in the syscall exit path when reviewing the code.
> >
> > Richard, as we are already copying the open_how info into
> > audit_context::openat2 safely, the obvious fix is to convert
> > audit_match_perm() to use the previously copied value instead of argv.
> > If you can't submit a patch for this today please let me know.
> 
> I haven't heard anything from Richard so I put together a patch which
> should fix the problem (link below).  It's currently untested, but
> I've got a kernel building now with the patch ...

Well, the day wasn't over yet...  I've compiled and tested it.

> https://lore.kernel.org/linux-audit/164444111699.153511.15656610495968926251.stgit@olly/T/#u
> 
> -- 
> paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

