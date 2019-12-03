Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBD1100AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLCO6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 09:58:40 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35844 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfLCO6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:58:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5B8608EE12C;
        Tue,  3 Dec 2019 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575385119;
        bh=8GsY9I2j5RnjcOT+y4MYYiuU4UBwE8BfLfDbXA8wbWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s7vor2yxcL+6Fx3KIsktfqh+K6yzCu606uFCvEZ0CqDTKdN7rUyr6AWbzDCXcQP2b
         dqC9rA9LQIyrMWS9fsVx9+DtdWzwjFDfzSFAnBcA0ZUUo5n7d3WxU01gDsl64T0SyY
         kJTuu5Fx20DIqwFUcuapv6Ek7/UmWf6BORKWv94M=
X-Amavis-Alert: BAD HEADER SECTION, Improper use of control character (char 0D
        hex): References: ...5tyCfqw@mail.gmail.com>     <1575382251.34[...]
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Wtkb539zmMZ; Tue,  3 Dec 2019 06:58:38 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B35B18EE0D2;
        Tue,  3 Dec 2019 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575385118;
        bh=8GsY9I2j5RnjcOT+y4MYYiuU4UBwE8BfLfDbXA8wbWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NO9N05EALOT9Dcaod95Uk90Lo95fPEQiaIeqRcM+0LTkN26z66F3Mnc91qedgefpc
         /EzNfD6svai/bmrXO6mnwATNsAvM059l6w+zFT3tAKDKdfDVy2EggyIu39kyJUOyCS
         kJX1U+PPPoV1EzI0XwpYZ7j+1JL5WZ1O0NA/EQRw=
Message-ID: <1575385116.3435.22.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 03 Dec 2019 06:58:36 -0800
In-Reply-To: <CAOQ4uxh8R_GG+LMScoeuY32rx3sOeMuEK5z+rx=KO8QwGEGyXA@mail.gmail.com>
References: <1575335637.24227.26.camel@HansenPartnership.com>
         <1575335700.24227.27.camel@HansenPartnership.com>
         <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
         <1575349974.31937.11.camel@HansenPartnership.com>
         <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
         <1575382251.3435.4.camel@HansenPartnership.com>
         <CAOQ4uxh8R_GG+LMScoeuY32rx3sOeMuEK5z+rx=KO8QwGEGyXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-03 at 16:33 +0200, Amir Goldstein wrote:
> On Tue, Dec 3, 2019 at 4:10 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > [splitting topics for ease of threading]
> > On Tue, 2019-12-03 at 08:55 +0200, Amir Goldstein wrote:
> > > On Tue, Dec 3, 2019 at 7:12 AM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> > > > > [cc: ebiederman]
> > 
> > [...]
> > > > > 2. Needs serious vetting by Eric (cc'ed)
> > > > > 3. A lot of people have been asking me for filtering of
> > > > > "dirent" fsnotify events (i.e. create/delete) by path, which
> > > > > is not available in those vfs functions, so if the concept of
> > > > > current-mnt flies, fsnotify is going to want to use it as
> > > > > well.
> > > > 
> > > > Just a caveat: current->mnt is used in this patch simply as a
> > > > tag, which means it doesn't need to be refcounted.  I think I
> > > > can prove that it is absolutely valid if the cred is shifted
> > > > because the reference is held by the code that shifted the
> > > > cred, but it's definitely not valid except for a tag comparison
> > > > outside of that.  Thus, if it is useful for fsnotify, more
> > > > thought will have to be given to refcounting it.
> > > > 
> > > 
> > > Yes. Is there anything preventing us from taking refcount on
> > > current->mnt?
> > 
> > We could, but what would it usefully mean?  It would just be the
> > last mnt that had its credentials shifted.  I think stashing a
> > refcounted mnt in the task structure is reasonably easy:  The creds
> > are refcounted, so you simply follow all the task mnt_cred logic I
> > added for releasing the ref in the correct places, so if you want
> > to do that, I can simply rename this tag to something less generic
> > ... unless you have some idea about using the last shift mnt?
> > 
> 
> Nevermind. Didn't want to derail the thread.

Don't worry, that's why I separated the issues.

> I am still not sure what the semantics of generic current->mnt should
> be.

OK, so that's easy: it's not designed in the current patch set ever to
be used as a mnt.  It's simply a tag to tell you if the cached shifted
credentials in mnt_cred are valid for reuse.  To the only use I put it
to is in change_userns_cred() where we look at the task cached
mnt+mnt_cred and if mnt matches the mnt change_user_ns_cred was called
for we know that if mnt_cred is not NULL then it's usable as the pre-
prepared credentials.

> operations like copy_file_range() with two path arguments can
> get confusing and handling nesting (e.g. overlayfs can be confusing
> as well).

So I think the concept of using the task struct to carry information
you don't want to thread all the way up and down the stack, like how
I've done for knowledge of the shift being in effect, is potentially a
useful one.  It is a bit of a hack though to work around the fact that
our API is missing stuff.

James

