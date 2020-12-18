Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64C2DEC18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 00:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLRXpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 18:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgLRXpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 18:45:11 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EECC0617B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Dec 2020 15:44:31 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g1so3734264ilk.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Dec 2020 15:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OW5zqXszARx5ARpIBvRVoGQ/CkHN2uItCdMq8Tg890g=;
        b=bcw7D+xnwUXTI/BcWe5BhN83YPA2abncygL09MCJiMvIlEtjkwzXWZzHylYMf1Y5g2
         sKPb0vv2MahhgzYoj8XOAuJtVh5FP/pWJwQQTih5la/CSPbtAcFJwE3wwwfiE+Sn/ij3
         eN/x3OizpVD9CnijLMxFTpFFDiOCpkoeqimGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OW5zqXszARx5ARpIBvRVoGQ/CkHN2uItCdMq8Tg890g=;
        b=frKdrQxgnTJAd0Xc26vyyWUAZprxl1AQqODOexbz/EtwrWQcpw8LI38lxR/2r7cKyj
         kJ7idjaALa+7vZjMw5WgLtIrm0xOghkMoIsqdM7u3D9qYyfVLXmsN7B4H2KbYey2Ca3r
         T2oBD0GpvIXkhWEUgcR/RiFfIumwrPP/BgUuvZ1/Ga7/bW6n+l1wEF4ecNjt7m7+U0RR
         xuWWGZe+EZ02yjUHcsNL1YK05d46EKbROkJrum5y2JwzuEWBhqZKy2ycaEBLOkvo27ig
         zE+uUfz6b4rgbPwfakiLxiQRLIFW6UQa9cStLwc1Dcmq8qEYCGNUF0/7cNTp0fgFArZR
         Yp9w==
X-Gm-Message-State: AOAM530SAX7bLy3+DQw8l5AU1dYYGAv4EsaWpTrSp2ydujVF4CWVFmHg
        bMUjvG6jnHfl4JvfBA+wL6zz+w==
X-Google-Smtp-Source: ABdhPJyO0JXUteyTChU1tOxvFgCdLwQpfw5YF1SKVg96brDgwyRzw/zMscfLLRe7ITDydoFR/EeNWw==
X-Received: by 2002:a92:9ec7:: with SMTP id s68mr6713887ilk.171.1608335070679;
        Fri, 18 Dec 2020 15:44:30 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z13sm18406524iof.19.2020.12.18.15.44.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Dec 2020 15:44:30 -0800 (PST)
Date:   Fri, 18 Dec 2020 23:44:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Message-ID: <20201218234427.GA17343@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201217150037.468787-1-jlayton@kernel.org>
 <20201217203523.GB28177@ircssh-2.c.rugged-nimbus-611.internal>
 <9e38d400ed1e6bf4a3909f69238e3e5001d908fb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e38d400ed1e6bf4a3909f69238e3e5001d908fb.camel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:18:49PM -0500, Jeff Layton wrote:
> On Thu, 2020-12-17 at 20:35 +0000, Sargun Dhillon wrote:
> > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > own purposes, without preventing a later opener from potentially seeing
> > > the error.
> > > 
> > > The original reason for the ERRSEQ_SEEN flag was to make it so that we
> > > didn't need to increment the counter if nothing had observed the latest
> > > value and the error was the same. Eventually, a regression was reported
> > > in the errseq_t conversion, and we fixed that by using the ERRSEQ_SEEN
> > > flag to also mean that the error had been reported to userland at least
> > > once somewhere.
> > > 
> > > Those are two different states, however. If we instead take a second
> > > flag bit from the counter, we can track these two things separately, and
> > > accomodate the overlayfs volatile mount use-case.
> > > 
> > > Rename the ERRSEQ_SEEN flag to ERRSEQ_OBSERVED and use that to indicate
> > > that the counter must be incremented the next time an error is set.
> > > Also, add a new ERRSEQ_REPORTED flag that indicates whether the current
> > > error was returned to userland (and thus doesn't need to be reported on
> > > newly open file descriptions).
> > > 
> > > Test only for the OBSERVED bit when deciding whether to increment the
> > > counter and only for the REPORTED bit when deciding what to return in
> > > errseq_sample.
> > > 
> > > Add a new errseq_peek function to allow for the overlayfs use-case.
> > > This just grabs the latest counter and sets the OBSERVED bit, leaving the
> > > REPORTED bit untouched.
> > > 
> > > errseq_check_and_advance must now handle a single special case where
> > > it races against a "peek" of an as of yet unseen value. The do/while
> > > loop looks scary, but shouldn't loop more than once.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  Documentation/core-api/errseq.rst |  22 +++--
> > >  include/linux/errseq.h            |   1 +
> > >  lib/errseq.c                      | 139 ++++++++++++++++++++++--------
> > >  3 files changed, 118 insertions(+), 44 deletions(-)
> > > 
> > > v3: rename SEEN/MUSTINC flags to REPORTED/OBSERVED
> > > 
> > > Hopefully the new flag names will make this a bit more clear. We could
> > > also rename some of the functions if that helps too. We could consider
> > > moving from errseq_sample/_check_and_advance to
> > > errseq_observe/errseq_report?  I'm not sure that helps anything though.
> > > 
> > > I know that Vivek and Sargun are working on syncfs() for overlayfs, so
> > > we probably don't want to merge this until that work is ready. I think
> > 
> > I disagree. I think that this work can land ahead of that, given that I think 
> > this is probably backportable to v5.10 without much risk, with the addition of 
> > your RFC v2 Overlay patch. I think the work proper long-term repair Vivek is 
> > embarking upon seems like it may be far more invasive.
> > 
> > > the errseq_peek call will need to be part of their solution for volatile
> > > mounts, however, so I'm fine with merging this via the overlayfs tree,
> > > once that work is complete.
> > > 
> > > diff --git a/Documentation/core-api/errseq.rst b/Documentation/core-api/errseq.rst
> > > index ff332e272405..ce46ddcc1487 100644
> > > --- a/Documentation/core-api/errseq.rst
> > > +++ b/Documentation/core-api/errseq.rst
> > > @@ -18,18 +18,22 @@ these functions can be called from any context.
> > >  Note that there is a risk of collisions if new errors are being recorded
> > >  frequently, since we have so few bits to use as a counter.
> > >  
> > > 
> > > 
> > > 
> > > -To mitigate this, the bit between the error value and counter is used as
> > > -a flag to tell whether the value has been sampled since a new value was
> > > -recorded.  That allows us to avoid bumping the counter if no one has
> > > -sampled it since the last time an error was recorded.
> > > +To mitigate this, the bits between the error value and counter are used
> > > +as flags to tell whether the value has been sampled since a new value
> > > +was recorded, and whether the latest error has been seen by userland.
> > > +That allows us to avoid bumping the counter if no one has sampled it
> > > +since the last time an error was recorded, and also ensures that any
> > > +recorded error will be seen at least once.
> > >  
> > > 
> > > 
> > > 
> > >  Thus we end up with a value that looks something like this:
> > >  
> > > 
> > > 
> > > 
> > > -+--------------------------------------+----+------------------------+
> > > -| 31..13                               | 12 | 11..0                  |
> > > -+--------------------------------------+----+------------------------+
> > > -| counter                              | SF | errno                  |
> > > -+--------------------------------------+----+------------------------+
> > > ++---------------------------------+----+----+------------------------+
> > > +| 31..14                          | 13 | 12 | 11..0                  |
> > > ++---------------------------------+----+----+------------------------+
> > > +| counter                         | OF | RF | errno                  |
> > > ++---------------------------------+----+----+------------------------+
> > > +OF = ERRSEQ_OBSERVED flag
> > > +RF = ERRSEQ_REPORTED flag
> > >  
> > > 
> > > 
> > > 
> > >  The general idea is for "watchers" to sample an errseq_t value and keep
> > >  it as a running cursor.  That value can later be used to tell whether
> > > diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> > > index fc2777770768..7e3634269c95 100644
> > > --- a/include/linux/errseq.h
> > > +++ b/include/linux/errseq.h
> > > @@ -9,6 +9,7 @@ typedef u32	errseq_t;
> > >  
> > > 
> > > 
> > > 
> > >  errseq_t errseq_set(errseq_t *eseq, int err);
> > >  errseq_t errseq_sample(errseq_t *eseq);
> > > +errseq_t errseq_peek(errseq_t *eseq);
> > >  int errseq_check(errseq_t *eseq, errseq_t since);
> > >  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
> > >  #endif
> > > diff --git a/lib/errseq.c b/lib/errseq.c
> > > index 81f9e33aa7e7..8fd6be134dcc 100644
> > > --- a/lib/errseq.c
> > > +++ b/lib/errseq.c
> > > @@ -21,10 +21,14 @@
> > >   * Note that there is a risk of collisions if new errors are being recorded
> > >   * frequently, since we have so few bits to use as a counter.
> > >   *
> > > - * To mitigate this, one bit is used as a flag to tell whether the value has
> > > - * been sampled since a new value was recorded. That allows us to avoid bumping
> > > - * the counter if no one has sampled it since the last time an error was
> > > - * recorded.
> > > + * To mitigate this, one bit is used as a flag to tell whether the value has been
> > > + * observed in some fashion. That allows us to avoid bumping the counter if no
> > > + * one has sampled it since the last time an error was recorded.
> > > + *
> > > + * A second flag bit is used to indicate whether the latest error that has been
> > > + * recorded has been reported to userland. If the REPORTED bit is not set when the
> > > + * file is opened, then we ensure that the opener will see the error by setting
> > > + * its sample to 0.
> > 
> > Since there are only a few places that report to userland (as far as I can tell, 
> > a bit of usage in ceph), does it make sense to maintain this specific flag that
> > indicates it's reported to userspace? Instead can userspace keep a snapshot
> > of the last errseq it reported (say on the superblock), and use that to drive
> > reports to userspace?
> > 
> > It's a 32-bit sacrifice per SB though, but it means we can get rid of 
> > errseq_check_and_advance and potentially remove any need for locking and just
> > rely on cmpxchg.
> 
> I think it makes sense. You are essentially adding a new class of
> "samplers" that use the error for their own purposes and won't be
> reporting it to userland via normal channels (syncfs, etc.). A single
> bit to indicate whether it has only been observed by such samplers is
> not a huge sacrifice.
> 
> I worry too about race conditions when tracking this information across
> multiple words. You'll either need to use some locking to manage that,
> or get clever with memory barriers. Keeping everything in one word makes
> things a lot simpler.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

I'll wait for Amir or Miklos to chime in, but I'm happy with this, and it solves 
my problems.

Do you want to respin this patch with the overlayfs patch as well, so
we can cherry-pick to stable, and then focus on how we want to deal
with this problem in the future?
