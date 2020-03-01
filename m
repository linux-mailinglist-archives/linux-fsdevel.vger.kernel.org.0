Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A52174E93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAQqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 11:46:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55912 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAQqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:46:38 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8Rjf-0001QL-92; Sun, 01 Mar 2020 16:46:35 +0000
Date:   Sun, 1 Mar 2020 17:46:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, fweimer@redhat.com
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200301164634.ei4ayiipugp3bji4@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <20200229152656.gwu7wbqd32liwjye@yavin>
 <20200229155411.3xn7szvqso4uxwuy@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229155411.3xn7szvqso4uxwuy@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 02:54:11AM +1100, Aleksa Sarai wrote:
> On 2020-03-01, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2020-02-28, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > So we either end up adding new AT_* flags mirroring the new RESOLVE_*
> > > flags or we end up adding new RESOLVE_* flags mirroring parts of AT_*
> > > flags. And if that's a possibility I vote for RESOLVE_* flags going
> > > forward. The have better naming too imho.
> > 
> > I can see the argument for merging AT_ flags into RESOLVE_ flags (fewer
> > flag arguments for syscalls is usually a good thing) ... but I don't
> > really like it. There are a couple of problems right off the bat:
> > 
> >  * The prefix RESOLVE_ implies that the flag is specifically about path
> >    resolution. While you could argue that AT_EMPTY_PATH is at least
> >    *related* to path resolution, flags like AT_REMOVEDIR and
> >    AT_RECURSIVE aren't.
> > 
> >  * That point touches on something I see as a more fundamental problem
> >    in the AT_ flags -- they were intended to be generic flags for all of
> >    the ...at(2) syscalls. But then AT_ grew things like AT_STATX_ and
> >    AT_REMOVEDIR (both of which are necessary features to have for their
> >    respective syscalls, but now those flag bits are dead for other
> >    syscalls -- not to mention the whole AT_SYMLINK_{NO,}FOLLOW thing).
> > 
> >  * While the above might be seen as minor quibbles, the really big
> >    issue is that even the flags which are "similar" (AT_SYMLINK_NOFOLLOW
> >    and RESOLVE_NO_SYMLINKS) have different semantics (by design -- in my
> >    view, AT_SYMLINK_{NO,}FOLLOW / O_NOFOLLOW / lstat(2) has always had
> >    the wrong semantics if the intention was to be a way to safely avoid
> >    resolving symlinks).
> > 
> > But maybe I'm just overthinking what a merge of AT_ and RESOLVE_ would
> > look like -- would it on.
> 
> Eugh, dropped the rest of that sentence:
> 
> ... would it only be the few AT_ flags which are strictly related to
> path resolution (such as AT_EMPTY_PATH)? If so wouldn't that just mean
> we end up with two flag arguments for new syscalls?

That's a good question that we kinda ran into right once we
accepted the RESOLVE_* namespace implicitly? This smells like the same
problem we have in e.g. waitid() with WEXITED/WSTOPPED/WCONTINUED and
WNOHANG/WNOWAIT...I think one answer could be one flag argument,
different prefixes? i.e. RESOLVE_* and then e.g. simply REMOVE_DIR instead of
AT_REMOVEDIR. This way we don't duplicate the problem the AT_*
namespace had (e.g. AT_REMOVEDIR and AT_SYMLINK_NOFOLLOW being about two
separate things). Maybe that's crazy and doesn't really make things
better?

Christian
