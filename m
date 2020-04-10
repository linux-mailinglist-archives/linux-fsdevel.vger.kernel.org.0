Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAF1A422F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 07:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgDJFHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 01:07:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44922 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJFHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:07:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id cb27so1029087edb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3c+OkrkFNoNM1WHcs/UAN4Bfzm7APEU1TdjkrlEepQ=;
        b=b6DXijXzWNCDwqDiBdcSfRPfQz7OrVpDv5omGFISOL+5LLLJV5mPhUbpsXBx0OHB4h
         v56EP0Jtx8USlgs5YTSUbBiJexwvO7bleqQACjTMAy2Z0V2eK/DTkVRCFfL6CezOTE+5
         RabeHqjwHtmFeD4dRkKXyhzR5JhMmdRO0xlgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3c+OkrkFNoNM1WHcs/UAN4Bfzm7APEU1TdjkrlEepQ=;
        b=TJ0Z7jMTjo4Ng+q9Qtyjwkhkr1dg6JbdO4QIeDTVzRVFhcpDP3ikKzrEokyEqKW7Hy
         RfMUCDuBWVmei6TVcKBx/qnQZdnN89q5hmMWyhEk38XKum8vcsm3bvUoLpFsYDEL611o
         xNr7MPrm31rFWCwSOnUZO8VGO46ej9bi2cLLKy51M38tqYTuL3bGNY6XsVVh5gh6GeN1
         jE9jnfpFj98oq69YL1EHuFGhsh0R6dVlX5eWaEkahTigawlS5ZkUATXzXpkBrsCQr+zY
         3OcUfFsdJIXPgtIUCPSmlbAP29+yaHPcaEH0yN6Wwfh/fHVu9BvhAZaIX62pIgCHhg/A
         hGsQ==
X-Gm-Message-State: AGi0PubqP2Cgge+aZNyn7oygb3DzSU8nJQw6ZrYEW3cbKyODZYHgnIME
        GC5dAqba0OduSw0GneGAUr+5xB4/QE/ydHy6WIn3OA==
X-Google-Smtp-Source: APiQypJ4a9YLp85SOfLaSY0/hnQapxHK7RqwfNv1Uwjkdi33El6fvV8P177eIwDclZwS/rYBEPulDDUqc9QYtoPoPYI=
X-Received: by 2002:a17:906:340a:: with SMTP id c10mr2359291ejb.218.1586495232501;
 Thu, 09 Apr 2020 22:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212214.GG28467@miu.piliscsaba.redhat.com> <20200410011119.GH23230@ZenIV.linux.org.uk>
In-Reply-To: <20200410011119.GH23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Apr 2020 07:07:01 +0200
Message-ID: <CAJfpeguON59p+CmHSvLfwO7Nn5fiBLgvvQUKfOvTvcf4geoiSQ@mail.gmail.com>
Subject: Re: [PATCH v3] proc/mounts: add cursor
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 3:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Apr 09, 2020 at 11:22:14PM +0200, Miklos Szeredi wrote:
>
> > @@ -1249,42 +1277,50 @@ struct vfsmount *mnt_clone_internal(cons
> >  static void *m_start(struct seq_file *m, loff_t *pos)
> >  {
> >       struct proc_mounts *p = m->private;
> > +     struct mount *mnt = NULL;
> >
> >       down_read(&namespace_sem);
> > -     if (p->cached_event == p->ns->event) {
> > -             void *v = p->cached_mount;
> > -             if (*pos == p->cached_index)
> > -                     return v;
> > -             if (*pos == p->cached_index + 1) {
> > -                     v = seq_list_next(v, &p->ns->list, &p->cached_index);
> > -                     return p->cached_mount = v;
> > -             }
> > -     }
> > +     lock_ns_list(p->ns);
> > +     if (!*pos)
> > +             list_move(&p->cursor.mnt_list, &p->ns->list);
> > +     if (!list_empty(&p->cursor.mnt_list))
> > +             mnt = mnt_skip_cursors(p->ns, &p->cursor);
> > +     unlock_ns_list(p->ns);
>
> Huh?  What's that if (!list_empty()) about?  The case where we have reached
> the end of list, then did a read() with an lseek() in between?

Yes.  Also no need to move the cursor in m_start(), since we are going
to do it anyway in m_stop().

Posted v4.

Thanks,
Miklos
