Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0918D43E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfFMPri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:47:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731750AbfFMJ1m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AD9430A6986;
        Thu, 13 Jun 2019 09:27:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8457E600C0;
        Thu, 13 Jun 2019 09:27:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
References: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com> <20190612225431.p753mzqynxpsazb7@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression for MS_MOVE on kernel v5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9382.1560418050.1@warthog.procyon.org.uk>
Date:   Thu, 13 Jun 2019 10:27:30 +0100
Message-ID: <9383.1560418050@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 09:27:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Adding Eric to the cc list since he implemented MNT_LOCKED]

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The commit changes the internal logic to lock mounts when propagating
> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> > to fail at:
> 
> You mean 'do_move_mount()'.
> 
> > if (old->mnt.mnt_flags & MNT_LOCKED)
> >         goto out;
> >
> > If that's indeed the case we should either revert this commit (reverts
> > cleanly, just tested it) or find a fix.
> 
> Hmm.. I'm not entirely sure of the logic here, and just looking at
> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
> cross-userns copies") doesn't make me go "Ahh" either.
> 
> Al? My gut feel is that we need to just revert, since this was in 5.1
> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
> don't be silly, this is easily fixed with this one-liner".
