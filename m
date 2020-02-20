Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E873E165FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBTO01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:26:27 -0500
Received: from mail.hallyn.com ([178.63.66.53]:59536 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgBTO01 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:26:27 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id B0D613F5; Thu, 20 Feb 2020 08:26:24 -0600 (CST)
Date:   Thu, 20 Feb 2020 08:26:24 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 09/25] fs: add is_userns_visible() helper
Message-ID: <20200220142624.GA5249@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-10-christian.brauner@ubuntu.com>
 <20200219024233.GA19334@mail.hallyn.com>
 <20200219120604.vqudwaeppebvisco@wittgenstein>
 <CALCETrW-XPkBMs30vk+Aiv+jA5i7TjHOYCgz0Ud6d0geaYte=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW-XPkBMs30vk+Aiv+jA5i7TjHOYCgz0Ud6d0geaYte=g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:18:51AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 19, 2020 at 4:06 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Tue, Feb 18, 2020 at 08:42:33PM -0600, Serge Hallyn wrote:
> > > On Tue, Feb 18, 2020 at 03:33:55PM +0100, Christian Brauner wrote:
> > > > Introduce a helper which makes it possible to detect fileystems whose
> > > > superblock is visible in multiple user namespace. This currently only
> > > > means proc and sys. Such filesystems usually have special semantics so their
> > > > behavior will not be changed with the introduction of fsid mappings.
> > >
> > > Hi,
> > >
> > > I'm afraid I've got a bit of a hangup about the terminology here.  I
> > > *think* what you mean is that SB_I_USERNS_VISIBLE is an fs whose uids are
> > > always translated per the id mappings, not fsid mappings.  But when I see
> >
> > Correct!
> >
> > > the name it seems to imply that !SB_I_USERNS_VISIBLE filesystems can't
> > > be seen by other namespaces at all.
> > >
> > > Am I right in my first interpretation?  If so, can we talk about the
> > > naming?
> >
> > Yep, your first interpretation is right. What about: wants_idmaps()
> 
> Maybe fsidmap_exempt()?

Yeah, and maybe SB_USERNS_FSID_EXEMPT ?

> I still haven't convinced myself that any of the above is actually
> correct behavior, especially when people do things like creating
> setuid binaries.

The only place that would be a problem is if the child userns has an
fsidmapping from X to 0 in the parent userns, right?  Yeah I'm sure
many people would ignore all advice to the contrary and do this anyway,
but I would try hard to suggest that people use an intermediary userns
for storing filesystems for the "docker share" case.  So the host fsid
range would start at say 200000.  So a setuid binary would just be
setuid-200000.
