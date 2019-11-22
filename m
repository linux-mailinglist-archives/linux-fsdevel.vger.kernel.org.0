Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFB10743D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVOti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 09:49:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44588 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVOtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:49:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so4663880lfa.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk3Xp9XDcJZJv6VkHVhLVg5CXbqI1WOmPTup8QlYQ68=;
        b=eRlW+SqL/mOmMXhdJHBTtxZsobKc16zRhyql3CFTSR7CPFHVEOCStfDF3clHisNpMq
         JSjO3PEe0acbExXCd2OSVVevgLpDZfeyJLuwjjewfVOEfaEMaj3aWJhKWtgkcAblGVk0
         p+m2Xy7Oh4r/0Ux5vxcCsMX5CaTZSLpH63gi561LqP33xVpo6OGX+LjYU4hmq2wwWK9J
         GPu0DmoetMCrq7cG42zAfnOLYopUF+rrhRyBnLEpIZ9SM2D9Vi/RwUKfi8BD4jnBj43P
         hffIl+GT9TrXJjmevE6f1WKIejC3nCSa6ibVr42xI6OKmG9yo/1qrEmLGz/A16kI+8VP
         Vi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk3Xp9XDcJZJv6VkHVhLVg5CXbqI1WOmPTup8QlYQ68=;
        b=CHZNgH8gy2knyliUf2AwglgYESxnUVdalT/Ct2i0E/lpsoxNG0L7OZzzmOT/HDGEmb
         mlFe1MSly4kOs2nOwzYv9JHcAtXAIOvcSWJ0LbV/T9kckcO1OXybgEYpZYYvQcPTNyW8
         ES7Q5M1tfD8fl7VBiUyu8rodw7YcT2ydgHTbuOFy+ldDjFaS8JKIa+UwD+viWgdZn0WA
         CvMpH/xvCnVzAmQwI1GLsgBysroAgxcAqsMHfP6L1VId/tmJZoYOiHuM/MCSPcNhv5DI
         58bvKWhlTsR/n3xsGWX7buRs08+CuNAgcLOmF6BEyw3ow2dUm1HpJWcvyCdi2EMK018J
         So4A==
X-Gm-Message-State: APjAAAW0IiV00Co4AOn4CK0E3bPKZ2LZAMWMAM3LJ2yoiGiVGlPaPaES
        CQdYttRjAwbRtrctVlr97JsbwNeCSjZYUufG7qjU
X-Google-Smtp-Source: APXvYqwVmlcHH4QooB5Mqu4fC/eYdQZnl0cmoxgW2Xv32I+RGXv3qL8CeSrHMILzNFjensl712UwHgW60fTOulvG/XQ=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr6297196lfh.64.1574434172631;
 Fri, 22 Nov 2019 06:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20191121145245.8637-1-sds@tycho.nsa.gov> <20191121145245.8637-2-sds@tycho.nsa.gov>
 <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
 <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com> <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
In-Reply-To: <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Nov 2019 09:49:21 -0500
Message-ID: <CAHC9VhRiRdWfqP8sp8YKRdc4D9r9u1QYP5o2sRh7QwvgCRYYbg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 8:37 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/21/19 7:30 PM, Paul Moore wrote:
> > On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> >>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
> >>> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> >>> Previously, we only returned -ECHILD if generating an audit record with
> >>> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> >>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
> >>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
> >>> that dump_common_audit_data() calls d_find_alias() and collects the
> >>> dname from the result if any.
> >>> Other cases that might require similar treatment in the future are
> >>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
> >>> a path or file is called under RCU-walk.
> >>>
> >>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> >>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>> ---
> >>>   security/selinux/avc.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> >>> index 74c43ebe34bb..f1fa1072230c 100644
> >>> --- a/security/selinux/avc.c
> >>> +++ b/security/selinux/avc.c
> >>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
> >>>           * during retry. However this is logically just as if the operation
> >>>           * happened a little later.
> >>>           */
> >>> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
> >>> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
> >>> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
> >>>              (flags & MAY_NOT_BLOCK))
> >>>                  return -ECHILD;
> >
> > With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
> > in dump_common_audit_data() which could block, which is bad, that I
> > understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
> > on why that is bad?  It makes a few audit_log*() calls and one call to
> > d_backing_inode() which is non-blocking and trivial.
> >
> > What am I missing?
>
> For those who haven't, you may wish to also read the earlier thread here
> that led to this one:
> https://lore.kernel.org/selinux/20191119184057.14961-1-will@kernel.org/T/#t
>
> AFAIK, neither the LSM_AUDIT_DATA_INODE nor the LSM_AUDIT_DATA_DENTRY
> case truly block (d_find_alias does not block AFAICT, nor should
> audit_log* as long as we use audit_log_start with GFP_ATOMIC or
> GFP_NOWAIT).

Yes, the audit_log*() functions should be safe, if not I would
consider that a bug; I thought d_find_alias() might block, but it's
very likely I'm wrong in that regard.

> My impression from the comment in slow_avc_audit() is that
> the issue is not really about blocking but rather about the inability to
> safely dereference the dentry->d_name during RCU walk, which is
> something that can occur under LSM_AUDIT_DATA_INODE or _DENTRY (or _PATH
> or _FILE, but neither of the latter two are currently used from the two
> hooks that are called during RCU walk, inode_permission and
> inode_follow_link).  Originally _PATH, _DENTRY, and _INODE were all
> under a single _FS type and the original test in slow_avc_audit() was
> against LSM_AUDIT_DATA_FS before the split.

Thanks, I think that is the part I was missing.  I was focused too
much on the VFS stuff that I didn't pay enough attention to
slow_avc_audit().

If that is the case, the comment and code in dentry_cmp() would seem
to indicate that it would be safe to fetch the dentry name string as
long as we use READ_ONCE().  The length field in the qstr might be
off, but the audit_log_untrustedstring() function doesn't use the
qstr's length information.  I suppose if we don't mind the extra
spinlock we could use take_dentry_name_snapshot(); that should be safe
and we are already in the "slow" path.  I didn't check the _PATH or
_FILE cases.

Once again, let me know if I'm missing something.

As an aside, if we somehow can guarantee (e.g. via a name_snapshot)
that qstr length information is valid, we might want to consider
moving from audit_log_unstrustedstring() to
audit_log_n_untrustedstring() to save us a call to strlen().

> >> Added the LSM list as I'm beginning to wonder if we should push this
> >> logic down into common_lsm_audit(), this problem around blocking
> >> shouldn't be SELinux specific.
>
> That would require passing down the MAY_NOT_BLOCK flag or a rcu bool to
> common_lsm_audit() just so that it could immediately return if that is
> set and a->type is _INODE or _DENTRY (or _PATH or _FILE).  And the
> individual security module still needs to have its own handling of
> MAY_NOT_BLOCK/rcu for its own processing, so it won't free the security
> module authors from thinking about it.

Looking at the current SELinux code, all we do is bail out early with
-ECHILD.  If we didn't have that check it looks like the only impact
would be some extra assignments into a struct living on the stack and
a call into common_lsm_audit().  That doesn't seem terrible for a slow
path, especially if it pushes this code into a LSM common function.

> >> For the LSM folks just joining, the full patchset can be found here:
> >> * https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t

-- 
paul moore
www.paul-moore.com
