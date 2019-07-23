Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2E721CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfGWVpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 17:45:18 -0400
Received: from namei.org ([65.99.196.166]:36738 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfGWVpR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:45:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6NLj7Ko017100;
        Tue, 23 Jul 2019 21:45:07 GMT
Date:   Wed, 24 Jul 2019 07:45:07 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
In-Reply-To: <20190708202124.GX17978@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.21.1907240744080.16974@namei.org>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk> <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk> <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp> <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com> <20190708180132.GU17978@ZenIV.linux.org.uk> <20190708202124.GX17978@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 8 Jul 2019, Al Viro wrote:

> On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:
> > On Mon, Jul 08, 2019 at 12:12:21PM -0500, Eric W. Biederman wrote:
> > 
> > > Al you do realize that the TOCTOU you are talking about comes the system
> > > call API.  TOMOYO can only be faulted for not playing in their own
> > > sandbox and not reaching out and fixing the vfs implementation details.
> 
> PS: the fact that mount(2) has been overloaded to hell and back (including
> MS_MOVE, which goes back to v2.5.0.5) predates the introduction of ->sb_mount()
> and LSM in general (2.5.27).  MS_BIND is 2.4.0-test9pre2.
> 
> In all the years since the introduction of ->sb_mount() I've seen zero
> questions from LSM folks regarding a sane place for those checks.  What I have
> seen was "we want it immediately upon the syscall entry, let the module
> figure out what to do" in reply to several times I tried to tell them "folks,
> it's called in a bad place; you want the checks applied to objects, not to
> raw string arguments".
> 
> As it is, we have easily bypassable checks on mount(2) (by way of ->sb_mount();
> there are other hooks also in the game for remounts and new mounts).

What are your recommendations for placing these checks?

-- 
James Morris
<jmorris@namei.org>

