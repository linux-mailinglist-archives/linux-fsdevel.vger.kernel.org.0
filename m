Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7474D363E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfJKAjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:39:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44664 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfJKAjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:39:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id q12so5719564lfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 17:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFT8cm8S0DEJCyLgBpASXj1oSQTtinFEh4s2GyLpCAk=;
        b=SUM+Ozmq/ACZrOTEwqmyCavmWazXGQLL83huZDzHGsYRooxZavBq96G3gSZB8aZEun
         4tNuU+9vatgFwhZ2C3CnGZuIm6rSCm9tF7Ri4hZuTLyRNG9wMsfSGbDW4ixy4pABeYx8
         RiZoc4KtGQBAZafsKpyIRkoagGDxiybFw91oHrLAIp2elU9Glh7hQMRnxYemxk3LXdAf
         83242C0BufY7yeIMuHD1/BJ/mBqjnb4LbON2RYZFDpSRI7c5hR+satKSZpXAtXUtZp2a
         IsbLva/X8n/wCo/lzhff7J2wgO0KRpDAcFyAp4oyWjPRYAF/2wcK+vpAQmg9N9Fs+doF
         90IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFT8cm8S0DEJCyLgBpASXj1oSQTtinFEh4s2GyLpCAk=;
        b=gUCixXIyDp56j1TjK/3kecoj49TZz5+VXpxhN5uU1VFBGyaXNjYB25IyJU7RscYVtm
         zAaBu0jvuNkhKYO0shppXOO3bwVdb2E0oQZ388hNy8QwFcppqEly8nbcAsF1x74cks7D
         Art8c2iiMPGMLlEPMH9KyauAsrh8OSslwe5fb7NYIw0gwpdEhomXe3shLyVa6bqq2s2p
         7TS9KXh1qKebcYGOQYusBdxrx5cDMOBWbOtN8rwRqYTDOKQClyJI58dFgyPf+/AZvR+q
         ER5OnXD2WNnbuGussMDcTmYvUUASnYi/goyM5koKiFNsyNNpw8/lwJTsC2TANFym5XEo
         RQWg==
X-Gm-Message-State: APjAAAVOtGvlyqB564GbgbTeyNKYCquQ+tPUR3P+xcA4p3yxTXQxYJ51
        IWY7D19gvDK51whjaNnEJdVx10NQRKqpw3xEZ1uT
X-Google-Smtp-Source: APXvYqy7lQItMV1AedUlABKN6Qqbi/t4grfJyN2rcTNd4EtP3vm905LTdxYK80Osnp73B/vBccWvg766BbHJwloILAc=
X-Received: by 2002:a19:520d:: with SMTP id m13mr7617840lfb.137.1570754349796;
 Thu, 10 Oct 2019 17:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <230e91cd3e50a3d8015daac135c24c4c58cf0a21.1568834524.git.rgb@redhat.com>
 <20190927125142.GA25764@hmswarspite.think-freely.org>
In-Reply-To: <20190927125142.GA25764@hmswarspite.think-freely.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:38:58 -0400
Message-ID: <CAHC9VhRbSUCB0OZorC4+y+5uJDR5uMXdRn2LOTYGu2gcFJSrcA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 06/21] audit: contid limit of 32k imposed to
 avoid DoS
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        Dan Walsh <dwalsh@redhat.com>, mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 8:52 AM Neil Horman <nhorman@tuxdriver.com> wrote:
> On Wed, Sep 18, 2019 at 09:22:23PM -0400, Richard Guy Briggs wrote:
> > Set an arbitrary limit on the number of audit container identifiers to
> > limit abuse.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c | 8 ++++++++
> >  kernel/audit.h | 4 ++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 53d13d638c63..329916534dd2 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c

...

> > @@ -2465,6 +2472,7 @@ int audit_set_contid(struct task_struct *task, u64 contid)
> >                               newcont->owner = current;
> >                               refcount_set(&newcont->refcount, 1);
> >                               list_add_rcu(&newcont->list, &audit_contid_hash[h]);
> > +                             audit_contid_count++;
> >                       } else {
> >                               rc = -ENOMEM;
> >                               goto conterror;
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 162de8366b32..543f1334ba47 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -219,6 +219,10 @@ static inline int audit_hash_contid(u64 contid)
> >       return (contid & (AUDIT_CONTID_BUCKETS-1));
> >  }
> >
> > +extern int audit_contid_count;
> > +
> > +#define AUDIT_CONTID_COUNT   1 << 16
> > +
>
> Just to ask the question, since it wasn't clear in the changelog, what
> abuse are you avoiding here?  Ostensibly you should be able to create as
> many container ids as you have space for, and the simple creation of
> container ids doesn't seem like the resource strain I would be concerned
> about here, given that an orchestrator can still create as many
> containers as the system will otherwise allow, which will consume
> significantly more ram/disk/etc.

I've got a similar question.  Up to this point in the patchset, there
is a potential issue of hash bucket chain lengths and traversing them
with a spinlock held, but it seems like we shouldn't be putting an
arbitrary limit on audit container IDs unless we have a good reason
for it.  If for some reason we do want to enforce a limit, it should
probably be a tunable value like a sysctl, or similar.

--
paul moore
www.paul-moore.com
