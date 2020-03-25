Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731FE19200B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 05:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgCYEEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 00:04:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41842 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYEEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 00:04:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGxGp-002Aql-K1; Wed, 25 Mar 2020 04:03:59 +0000
Date:   Wed, 25 Mar 2020 04:03:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200325040359.GK23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:24:01PM -0400, Qian Cai wrote:

> > On Mar 24, 2020, at 10:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Tue, Mar 24, 2020 at 09:49:48PM -0400, Qian Cai wrote:
> > 
> >> It does not catch anything at all with the patch,
> > 
> > You mean, oops happens, but neither WARN_ON() is triggered?
> > Lovely...  Just to make sure: could you slap the same couple
> > of lines just before
> >                if (unlikely(!d_can_lookup(nd->path.dentry))) {
> > in link_path_walk(), just to check if I have misread the trace
> > you've got?
> > 
> > Does that (+ other two inserts) end up with
> > 	1) some of these WARN_ON() triggered when oops happens or
> > 	2) oops is happening, but neither WARN_ON() triggers or
> > 	3) oops not happening / becoming harder to hit?
> 
> Only the one just before
>  if (unlikely(!d_can_lookup(nd->path.dentry))) {
> In link_path_walk() will trigger.

> [  245.767202][ T5020] pathname = /var/run/nscd/socket

Lovely.  So
	* we really do get NULL nd->path.dentry there; I've not misread the
trace.
	* on the entry into link_path_walk() nd->path.dentry is non-NULL.
	* *ALL* components should've been LAST_NORM ones
	* not a single symlink in sight, unless the setup is rather unusual
	* possibly not even a single mountpoint along the way (depending
upon the userland used)

And in the same loop we have
                if (likely(type == LAST_NORM)) {
                        struct dentry *parent = nd->path.dentry;
                        nd->flags &= ~LOOKUP_JUMPED;
                        if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
                                struct qstr this = { { .hash_len = hash_len }, .name = name };
                                err = parent->d_op->d_hash(parent, &this);
                                if (err < 0)
                                        return err;
                                hash_len = this.hash_len;
                                name = this.name;
                        }
                }
upstream of that thing.  So NULL nd->path.dentry *there* would've oopsed.
IOW, what we are hitting is walk_component() with non-NULL nd->path.dentry
when we enter it, NULL being returned and nd->path.dentry becoming NULL
by the time we return from walk_component().

Could you post the results of
	stat / /var /var/run /var/run/nscd /var/run/nscd/socket
after the boot with working kernel?  Also, is that "hit on every boot" or
stochastic?  If it's the latter, I'd like to see the output of the same
thing on a successful boot of the same kernel, if possible...

Also, is the pathname always the same and if not, what other variants have
been observed?
