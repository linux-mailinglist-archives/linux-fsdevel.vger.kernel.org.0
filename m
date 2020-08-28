Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C1255732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgH1JLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 05:11:33 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52113 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgH1JL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=TDjLhUMi2f57nIRf5nnT9ajtcLeHRqoCM4ISNW9naMs=; b=TFGghUCwnn9J3fRNyyGbFtuXQt
        +yCRqhHZjz67Kzda68uYpMXnNrlJrh03uHFri0le6SMRisECT/pmMEkXhVqSAOLCv9w6+C+otcWN2
        4N/3i0XtP6dCEEbToaHmJncub1YYgU2s4+4UXERijbsPcxGDApPZyurs2rqMzVfTgSqEdSut5JHXm
        mng98ToRK7OniYY+XMS1ChoiY5VnGONOeBvWV3Me1+aXNtAxnmqM8lm24hmjyCKtHH1UkdNzdwZZN
        lG8HhcvtlpK46P5RQ3EgG592uzhwapKKC2ux5xngg/+cqNfuyFxLkLJ6BAN/ptN4/kt/i9LbwilyM
        gLwubpig==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Fri, 28 Aug 2020 11:11:15 +0200
Message-ID: <11755866.l6z0jNX47O@silver>
In-Reply-To: <20200827162935.GC2837@work-vm>
References: <20200824222924.GF199705@mit.edu> <20200827144452.GA1236603@ZenIV.linux.org.uk> <20200827162935.GC2837@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Donnerstag, 27. August 2020 16:44:52 CEST Al Viro wrote:
> > No matter which delimiter you'd choose, something will break. It is just
> > about how much will it break und how likely it'll be in practice, not if.
> ... which means NAK.  We don't break userland without very good reasons and
> support for anyone's pet feature is not one of those.  It's as simple as
> that.
> 
> > If you are concerned about not breaking anything: keep forks disabled.
> 
> s/disabled/out of tree/
> 
> One general note: the arguments along the lines of "don't enable that,
> then" are either ignorant or actively dishonest; it really doesn't work
> that way, as we'd learnt quite a few times by now.  There's no such
> thing as "optional feature" - *any* feature, no matter how useless,
> might end up a dependency (no matter how needless) of something that
> would force distros to enable it.  We'd been down that road too many
> times to keep pretending that it doesn't happen.

Well, it could be an option per mounted fs, but I know -> NAK.

On Donnerstag, 27. August 2020 18:29:35 CEST Dr. David Alan Gilbert wrote:
> * Al Viro (viro@zeniv.linux.org.uk) wrote:
> > On Thu, Aug 27, 2020 at 04:23:24PM +0200, Christian Schoenebeck wrote:
> > > Be invited for making better suggestions. But one thing please: don't
> > > start
> > > getting offending.
> > > 
> > > No matter which delimiter you'd choose, something will break. It is just
> > > about how much will it break und how likely it'll be in practice, not
> > > if.> 
> > ... which means NAK.  We don't break userland without very good reasons
> > and
> > support for anyone's pet feature is not one of those.  It's as simple as
> > that.
> 
> I'm curious how much people expect to use these forks from existing
> programs - do people expect to be able to do something and edit a fork
> using their favorite editor or cat/grep/etc them?

Built-in path resolution would be nice, but it won't be a show stopper for 
such common utils if not. For instance on Solaris there is:

runat <filename> <cmd> ...

which works something like fchdir(); execv(); you loose some flexibility, but 
in practice still OK.

> I say that because if they do, then having a special syscall to open
> the fork wont fly; and while I agree that any form of suffix is a lost
> cause, I wonder what else is possible (although if it wasn't for the
> internal difficulties, I do have a soft spot for things that look like
> both files and directories showing the forks; but I realise I'm weird
> there).

It seems to be both a file & dir feature on all systems that have that 
concept. So people would expect it for dirs on Linux as well.

Best regards,
Christian Schoenebeck


