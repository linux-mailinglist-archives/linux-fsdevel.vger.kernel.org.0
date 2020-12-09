Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF52D3B22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 07:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgLIGEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 01:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgLIGEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:04:51 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF1C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 22:04:11 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so224655qtw.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 22:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcjmExBjtT7+7ElyensWFUdifiLprjWgTfo4sIg4HQE=;
        b=agQnj7Gb2gtVc1cIrG7dVR8+y1SxanEFbdYCRrRtV7C+K24ebgG1nsdhZ59T7gipio
         1rrRTYtvNa4OQ/qmNSoQD13A92lOsNTk+VdpURMsg0ivBaC4mbYdr5BZJtAOc5C5yzrW
         uGdba1qiUfE4saX7TWQKYuYAW8pbOnrFrB0oa0kq9bGWncwnn0dDUCF94yXAfptyd7tM
         T/XXt49XTseTv0Vv4POtJBMwUMkk9zHzqty1+xZ/PTCJZjrkRz+UDxiy47ujbHvi3yi8
         tSnruOUX8Hv5L0gpUSnSciqiWOu1+05e0gQ0hy/NcuxjWAwsTbSUnLpgpvqR8futgxUJ
         vzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcjmExBjtT7+7ElyensWFUdifiLprjWgTfo4sIg4HQE=;
        b=hsYdfFbNzDopP7XUmUjQ8p4UqevyrBIDWQLdMk+n7JCpVcajMXkqvNM5CR7wLItpzw
         YPIsFqZdGQsfWJgOwl5xDtgQCAoYQN21fiXyjOPjvUdiGA3CIpX0/BiMzILnClx++W2t
         x3T1gzhyij4rozbp97CxyQYiEevH6XtJa5lVEK+D3G42bCGYgDOJVOHtoHRhBzCs8mJ4
         B1eSaTzrnkC2hW0ROrXcKLDoYviQ6+qjDVZ1RA7Y+aoDxSt+qul6dfZQicRGlLClqoAB
         sGGqHPzsxf00HFC5Xp67gDzC/G87n2Ke2Yh3t0kyrqcY++raMBhZt8E8l0BamWPEBguc
         14aA==
X-Gm-Message-State: AOAM530R9N7fW9VxWdyZhxkgssO41vg5tT9lsHS0axMPiNXYr2w3QYsZ
        YVcD3sLyLnaAUibzHFoc24SdTPk+mBof5AuT+qsMUA==
X-Google-Smtp-Source: ABdhPJyB9vNBchtypc5KPsub1w9raoVQSQwzPvelJqUhx25QqIML9E1ZKQvJNTMgIav4XBq8y/fHWIkv+jtkQODkM9I=
X-Received: by 2002:ac8:4986:: with SMTP id f6mr1413480qtq.43.1607493849973;
 Tue, 08 Dec 2020 22:04:09 -0800 (PST)
MIME-Version: 1.0
References: <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org>
 <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org> <0000000000002a530d05b400349b@google.com>
 <928043.1607416561@warthog.procyon.org.uk> <1030308.1607468099@warthog.procyon.org.uk>
 <e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d@infradead.org>
In-Reply-To: <e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Dec 2020 07:03:58 +0100
Message-ID: <CACT4Y+bbh=5SLG_ruq1QKd3xKaC-NzJo842KP7cmXFcRRrmOig@mail.gmail.com>
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/8/20 2:54 PM, David Howells wrote:
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >>> Now the backtrace only shows what the state was when the string was allocated;
> >>> it doesn't show what happened to it after that, so another possibility is that
> >>> the filesystem being mounted nicked what vfs_parse_fs_param() had rightfully
> >>> stolen, transferring fc->source somewhere else and then failed to release it -
> >>> most likely on mount failure (ie. it's an error handling bug in the
> >>> filesystem).
> >>>
> >>> Do we know what filesystem it was?
> >>
> >> Yes, it's call AFS (or kAFS).
> >
> > Hmmm...  afs parses the string in afs_parse_source() without modifying it,
> > then moves the pointer to fc->source (parallelling vfs_parse_fs_param()) and
> > doesn't touch it again.  fc->source should be cleaned up by do_new_mount()
> > calling put_fs_context() at the end of the function.
> >
> > As far as I can tell with the attached print-insertion patch, it works, called
> > by the following commands, some of which are correct and some which aren't:
> >
> > # mount -t afs none /xfstest.test/ -o dyn
> > # umount /xfstest.test
> > # mount -t afs "" /xfstest.test/ -o foo
> > mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
> > # umount /xfstest.test
> > umount: /xfstest.test: not mounted.
> > # mount -t afs %xfstest.test20 /xfstest.test/ -o foo
> > mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
> > # umount /xfstest.test
> > umount: /xfstest.test: not mounted.
> > # mount -t afs %xfstest.test20 /xfstest.test/
> > # umount /xfstest.test
> >
> > Do you know if the mount was successful and what the mount parameters were?
>
> Here's the syzbot reproducer:
> https://syzkaller.appspot.com/x/repro.c?x=129ca3d6500000
>
> The "interesting" mount params are:
>         source=%^]$[+%](${:\017k[)-:,source=%^]$[+.](%{:\017\200[)-:,\000
>
> There is no other AFS activity: nothing mounted, no cells known (or
> whatever that is), etc.
>
> I don't recall if the mount was successful and I can't test it just now.
> My laptop is mucked up.
>
>
> Be aware that this report could just be a false positive: it waits
> for 5 seconds then looks for a memleak. AFAIK, it's possible that the "leaked"
> memory is still in valid use and will be freed some day.

FWIW KMEMLEAK scans memory for pointers. If it claims a memory leak,
it means the heap object is not referenced anywhere anymore. There are
no live pointers to it to call kfree or anything else.
Some false positives are theoretically possible, but so I don't
remember any, all reported ones were true leaks:
https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-gce-leak



> > David
> > ---
> > diff --git a/fs/afs/super.c b/fs/afs/super.c
> > index 6c5900df6aa5..4c44ec0196c9 100644
> > --- a/fs/afs/super.c
> > +++ b/fs/afs/super.c
> > @@ -299,7 +299,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
> >               ctx->cell = cell;
> >       }
> >
> > -     _debug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
> > +     kdebug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
> >              ctx->cell->name, ctx->cell,
> >              ctx->volnamesz, ctx->volnamesz, ctx->volname,
> >              suffix ?: "-", ctx->type, ctx->force ? " FORCE" : "");
> > @@ -318,6 +318,8 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >       struct afs_fs_context *ctx = fc->fs_private;
> >       int opt;
> >
> > +     kenter("%s,%p '%s'", param->key, param->string, param->string);
> > +
> >       opt = fs_parse(fc, afs_fs_parameters, param, &result);
> >       if (opt < 0)
> >               return opt;
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 2834d1afa6e8..f530a33876ce 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -450,6 +450,8 @@ void put_fs_context(struct fs_context *fc)
> >       put_user_ns(fc->user_ns);
> >       put_cred(fc->cred);
> >       put_fc_log(fc);
> > +     if (strcmp(fc->fs_type->name, "afs") == 0)
> > +             printk("PUT %p '%s'\n", fc->source, fc->source);
> >       put_filesystem(fc->fs_type);
> >       kfree(fc->source);
> >       kfree(fc);
> > @@ -671,6 +673,8 @@ void vfs_clean_context(struct fs_context *fc)
> >       fc->s_fs_info = NULL;
> >       fc->sb_flags = 0;
> >       security_free_mnt_opts(&fc->security);
> > +     if (strcmp(fc->fs_type->name, "afs") == 0)
> > +             printk("CLEAN %p '%s'\n", fc->source, fc->source);
> >       kfree(fc->source);
> >       fc->source = NULL;
> >
> >
>
> I'll check more after my test machine is working again.
>
> thanks.
> --
> ~Randy
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d%40infradead.org.
