Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4A152538
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 04:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBEDVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 22:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBEDVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5hq0VwiFlaOmvZItK695F4+jnVwqiW3Dfxm1dkVkswA=; b=Zr4BtkV1s02JJJN3KPF9BhlNEc
        uAfsJMGbPNYPSTb/a677eux5ybug3BN5BqO20YL5bYnFfDd31oA2QXxAOSNQLsp3iblPe87QLoGaV
        DejyTmjUyDmp8nRsL+wYbk3IoJC3g5V48MgpZ1aGgIMBvIgAI07xn8ysSCA1Vvwe1eKZmeHi3R4W5
        UiEYmV5XgUNUdeVpsFfGEyyIWdS7fbuYmI3ALO5AuIwp29exe3kkFraNnkruSotbj0jc/7HCy9Gdn
        /AvwG6eFjJEGEW4qW902m9/PKxUSM0K56Z4thTdu9Ss7vkOmwCAdk3xmc3cUfkUeam+Qzehzmgc3u
        p5yJXc1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izBFW-0005CA-D9; Wed, 05 Feb 2020 03:21:10 +0000
Date:   Tue, 4 Feb 2020 19:21:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     Raul Rangel <rrangel@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
Message-ID: <20200205032110.GR8731@bombadil.infradead.org>
References: <20200204215014.257377-1-zwisler@google.com>
 <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
 <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:49:48PM -0700, Ross Zwisler wrote:
> On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org> wrote:
> > On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > > > --- a/include/uapi/linux/mount.h
> > > > +++ b/include/uapi/linux/mount.h
> > > > @@ -34,6 +34,7 @@
> > > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> > > >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> > > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > > Doesn't this conflict with MS_SUBMOUNT below?
> > > >
> > > >  /* These sb flags are internal to the kernel */
> > > >  #define MS_SUBMOUNT     (1<<26)
> >
> > Yep.  Thanks for the catch, v6 on it's way.
> 
> It actually looks like most of the flags which are internal to the
> kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSEC,
> MS_BORN and MS_ACTIVE).  Several are unused completely, and the rest
> are just part of the AA_MS_IGNORE_MASK which masks them off in the
> apparmor LSM, but I'm pretty sure they couldn't have been set anyway.
> 
> I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the rest in
> a second patch.
> 
> If someone thinks these flags are actually used by something and I'm
> just missing it, please let me know.

Afraid you did miss it ...

/*
 * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
 * represented in both.
 */
...
#define SB_SUBMOUNT     (1<<26)

It's not entirely clear to me why they need to be the same, but I haven't
been paying close attention to the separation of superblock and mount
flags, so someone else can probably explain the why of it.
