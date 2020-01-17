Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97212141479
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAQWw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 17:52:58 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37210 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729099AbgAQWw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:52:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4DCBB8EE2DB;
        Fri, 17 Jan 2020 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579301577;
        bh=Q7VL1pKI4g4VE6cEdgo6r0Zpe6ftIj8PtpTM3rqJu1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tzGwcf2I6jixPwG3Z4HWRk08o99Z0rvi/RX/Vvk7pGafDnaownIJJ2wbf+lr1d6xm
         /x54hjGl8EndVNU11LL3cQiGpoFLiOERKVjJLUOpDTC9fcO6bKd6NlY0bBiZ+wUpYK
         czFjjCtcF0SvfL7hAZ8FJTewp4RWZSpTal65ylk8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F2dMlBXkcM0N; Fri, 17 Jan 2020 14:52:56 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 30AFE8EE181;
        Fri, 17 Jan 2020 14:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579301576;
        bh=Q7VL1pKI4g4VE6cEdgo6r0Zpe6ftIj8PtpTM3rqJu1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eVYTn66fgPPeaBFmNF6KYEGrM+FdwjUf2MsHV9N9s/hZryV4AoJKbnOv33j7gZGxs
         PqePEjBcsnH63bpVFYgR+fXqckYKoEoaAanC+uvLZm3UmJ8A87DT8GRnEYgUSaunX6
         Xp8yr1gUcfN6XS7bucuEVi7oDceaYeHrL8Qkw3V0=
Message-ID: <1579301572.13499.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Date:   Fri, 17 Jan 2020 14:52:52 -0800
In-Reply-To: <20200117211940.GA22062@cisco>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
         <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
         <20200113034149.GA27228@mail.hallyn.com>
         <1579112360.3249.17.camel@HansenPartnership.com>
         <20200116064430.GA32763@mail.hallyn.com>
         <1579192173.3551.38.camel@HansenPartnership.com>
         <20200117154402.GA16882@mail.hallyn.com>
         <1579278342.3227.36.camel@HansenPartnership.com>
         <20200117211940.GA22062@cisco>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-01-17 at 13:19 -0800, Tycho Andersen wrote:
> On Fri, Jan 17, 2020 at 08:25:42AM -0800, James Bottomley wrote:
> > On Fri, 2020-01-17 at 09:44 -0600, Serge E. Hallyn wrote:
> > > On Thu, Jan 16, 2020 at 08:29:33AM -0800, James Bottomley wrote:
> > > I guess I figured we would have privileged task in the owning
> > > namespace (presumably init_user_ns) mark a bind mount as
> > > shiftable 
> > 
> > Yes, that's what I've got today in the prototype.  It mirrors the
> > original shiftfs mechanism.  However, I have also heard people say
> > they want a permanent mark, like an xattr for this.
> 
> Please, no. mount() failures are already hard to reason about, I
> would rather not add another temporary (or worse, permanent) non-
> obvious failure mode.

I'm not particularly bothered either way ... although using xattrs
always seems to end up biting us for nesting, so I wasn't wildly
enthusiastic about it.

> What if we make shifted bind mounts always readonly? That will force
> people to use an overlay (or something else) on top, but they
> probably want to do that anyway so they can avoid tainting the
> original container image with writes.

That really causes problems for the mutable (non-docker) container use
case which is pretty much the way I always use containers.  Who wants
to bother with overlayfs when their image is expected to mutate: it's
just a huge hassle.

> > > Oh - I consider the detail of whether we pass a userid or userns
> > > nsfd as more of an implementation detail which we can hash out
> > > after the more general shift-mount api is decided upon.  Anyway,
> > > passing nsfds just has a cool factor :)
> > 
> > Well, yes, won't aruge on the cool factor-ness.
> 
> It's not just the cool factor: if you're doing this, it's presumably
> because you want to use it with a container in a user namespace.
> Specifying the same parameters twice leaves room for error, causing
> CVEs and more work.

It depends.  For the offset, we agreed there's no extant user_ns, so
you have to create one specifically.  That leads to a more error prone
setup with no actual checking benefit.

For the shift_ns, it depends whether you want one mount point per
tenant, in which case the tenant user_ns might be a useful check, or
one mount point with an ACL in which case you just backshift along the
binding tenant user_ns.

James

