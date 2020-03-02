Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90CE175D41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCBOeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 09:34:09 -0500
Received: from mail.hallyn.com ([178.63.66.53]:46164 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgCBOeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:34:08 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 5E334B1A; Mon,  2 Mar 2020 08:34:05 -0600 (CST)
Date:   Mon, 2 Mar 2020 08:34:05 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        mpawlowski@fb.com
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
Message-ID: <20200302143405.GA25432@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <2b0fe94b-036a-919e-219b-cc1ba0641781@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0fe94b-036a-919e-219b-cc1ba0641781@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:33:04PM -0500, Josef Bacik wrote:
> On 2/18/20 9:33 AM, Christian Brauner wrote:
> > Hey everyone,
> > 
> > This is v3 after (off- and online) discussions with Jann the following
> > changes were made:
> > - To handle nested user namespaces cleanly, efficiently, and with full
> >    backwards compatibility for non fsid-mapping aware workloads we only
> >    allow writing fsid mappings as long as the corresponding id mapping
> >    type has not been written.
> > - Split the patch which adds the internal ability in
> >    kernel/user_namespace to verify and write fsid mappings into tree
> >    patches:
> >    1. [PATCH v3 04/25] fsuidgid: add fsid mapping helpers
> >       patch to implement core helpers for fsid translations (i.e.
> >       make_kfs*id(), from_kfs*id{_munged}(), kfs*id_to_k*id(),
> >       k*id_to_kfs*id()
> >    2. [PATCH v3 05/25] user_namespace: refactor map_write()
> >       patch to refactor map_write() in order to prepare for actual fsid
> >       mappings changes in the following patch. (This should make it
> >       easier to review.)
> >    3. [PATCH v3 06/25] user_namespace: make map_write() support fsid mappings
> >       patch to implement actual fsid mappings support in mape_write()
> > - Let the keyctl infrastructure only operate on kfsid which are always
> >    mapped/looked up in the id mappings similar to what we do for
> >    filesystems that have the same superblock visible in multiple user
> >    namespaces.
> > 
> > This version also comes with minimal tests which I intend to expand in
> > the future.
> > 
> >  From pings and off-list questions and discussions at Google Container
> > Security Summit there seems to be quite a lot of interest in this
> > patchset with use-cases ranging from layer sharing for app containers
> > and k8s, as well as data sharing between containers with different id
> > mappings. I haven't Cced all people because I don't have all the email
> > adresses at hand but I've at least added Phil now. :)
> > 
> I put this into a kernel for our container guys to mess with in order to
> validate it would actually be useful for real world uses.  I've cc'ed the
> guy who did all of the work in case you have specific questions.
> 
> Good news is the interface is acceptable, albeit apparently the whole user
> ns interface sucks in general.  But you haven't made it worse, so success!

Well I very much disagree here :)  With the first part!  But I do
understand the shortcomings.  Anyway,

I still hope we get to talk about this in person, but IMO this is the
right approach (this being - thinking about how to make the uid mappings
more flexible without making them too complicated to be safe to use),
but a bit too static in terms of target.  There are at least two ways
that I could see usefully generalizing it

From a user space pov, the following goal is indespensible (for my use
cases):  that the fsuid be selectable based on fs, mountpoint, or file
context (as in selinux).

From a userns pov, one way to look at it is this:  when task t1 signals
task t2, it's not only t1's namespace that's considered when filling in
the sender uid, but also t2's.  Likewise, when writing a file, we should
consider both t1's fsuid+userns, and the file's, mount's, or filesystem's
userns.

From that POV, your patch is a step in the right direction and could be
taken as is (modulo any tmpfs fix Josef needs :)  From there I would
propose adding a 'userns=<uidnsfd>' bind mount option, so we could create
an empty userns with the desired mapping (subject to permissions granted
by subuids), get an fd to the uidns, and say

	mount --bind -o uidns=5 /shared /containers/c1/mnt/shared

So now when I write a file /etc/hosts as container fsuid 0, it'll be
subject to the container rootfs mount's uid mapping, presumably
100000.  When I write /mnt/shared/hello, it'll be subject to the mount's
uid mapping, which might be 1000.

-serge
