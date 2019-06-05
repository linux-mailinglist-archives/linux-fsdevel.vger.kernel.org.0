Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1399364AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFET2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 15:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfFET2q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:28:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF99206BB;
        Wed,  5 Jun 2019 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559762925;
        bh=da4vdqyz2Yme7cA4V1MHlD7iuvel2OX6wiT4hesZ8Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnCNWFWZc6WFQpPgq8oWAUJhMFZQWWwmZwy5J37GOO0asHCDGGNyy2OZaScErfCAd
         +Kpnw5dKlic3ZZPGfuxQ6El1DlNkO5k3ONonLuBknkpHtA+P3W4J7CYNSqJB2Gch3z
         DBBQPGMWJnTImFLSHJRIibNQIF4Q9Wobgc/MPfow=
Date:   Wed, 5 Jun 2019 21:28:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications
 [ver #2]
Message-ID: <20190605192842.GA9590@kroah.com>
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
 <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
 <15CBE0B8-2797-433B-B9D7-B059FD1B9266@amacapital.net>
 <5dae2a59-1b91-7b35-7578-481d03c677bc@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dae2a59-1b91-7b35-7578-481d03c677bc@tycho.nsa.gov>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:25:33PM -0400, Stephen Smalley wrote:
> On 6/5/19 1:47 PM, Andy Lutomirski wrote:
> > 
> > > On Jun 5, 2019, at 10:01 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > 
> > > > On 6/5/2019 9:04 AM, Andy Lutomirski wrote:
> > > > > On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > > On 6/5/2019 1:41 AM, David Howells wrote:
> > > > > > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > > 
> > > > > > > I will try to explain the problem once again. If process A
> > > > > > > sends a signal (writes information) to process B the kernel
> > > > > > > checks that either process A has the same UID as process B
> > > > > > > or that process A has privilege to override that policy.
> > > > > > > Process B is passive in this access control decision, while
> > > > > > > process A is active. In the event delivery case, process A
> > > > > > > does something (e.g. modifies a keyring) that generates an
> > > > > > > event, which is then sent to process B's event buffer.
> > > > > > I think this might be the core sticking point here.  It looks like two
> > > > > > different situations:
> > > > > > 
> > > > > > (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
> > > > > > 
> > > > > > (2) A implicitly and unknowingly sends event to B as a side effect of some
> > > > > >      other action (eg. B has a watch for the event A did).
> > > > > > 
> > > > > > The LSM treats them as the same: that is B must have MAC authorisation to send
> > > > > > a message to A.
> > > > > YES!
> > > > > 
> > > > > Threat is about what you can do, not what you intend to do.
> > > > > 
> > > > > And it would be really great if you put some thought into what
> > > > > a rational model would be for UID based controls, too.
> > > > > 
> > > > > > But there are problems with not sending the event:
> > > > > > 
> > > > > > (1) B's internal state is then corrupt (or, at least, unknowingly invalid).
> > > > > Then B is a badly written program.
> > > > Either I'm misunderstanding you or I strongly disagree.
> > > 
> > > A program needs to be aware of the conditions under
> > > which it gets event, *including the possibility that
> > > it may not get an event that it's not allowed*. Do you
> > > regularly write programs that go into corrupt states
> > > if an open() fails? Or where read() returns less than
> > > the amount of data you ask for?
> > 
> > I do not regularly write programs that handle read() omitting data in the middle of a TCP stream.  I also don’t write programs that wait for processes to die and need to handle the case where a child is dead, waitid() can see it, but SIGCHLD wasn’t sent because “security”.
> > 
> > > 
> > > >   If B has
> > > > authority to detect a certain action, and A has authority to perform
> > > > that action, then refusing to notify B because B is somehow missing
> > > > some special authorization to be notified by A is nuts.
> > > 
> > > You are hand-waving the notion of authority. You are assuming
> > > that if A can read X and B can read X that A can write B.
> > 
> > No, read it again please. I’m assuming that if A can *write* X and B can read X then A can send information to B.
> 
> I guess the questions here are:
> 
> 1) How do we handle recursive notification support, since we can't check
> that B can read everything below a given directory easily?  Perhaps we can
> argue that if I have watch permission to / then that implies visibility to
> everything below it but that is rather broad.

How do you handle fanotify today which I think can do this?

thanks,

greg k-h
