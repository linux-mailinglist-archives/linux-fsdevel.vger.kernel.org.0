Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C473E1A334E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDILip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 07:38:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42361 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:38:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id cw6so12841076edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDFEGslBD2CxDXP/31ok4EcaioopU/wGTKx0HGUfC98=;
        b=Sg31AXnrxkYOola/mFN96w5074hMe7NRF8svfS3HJ0uOKeyjiDhW6YbY14PyPfvNOL
         pgB6S1XyX+YYHWqOFHjQyR6m4ANrY8ynwqSf5gLPOwjRyevITN+BlPkAjzmVvuybBr+c
         sWY9fxDaIaHDlraOKryM2a8tWNUZMXlbhYl7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDFEGslBD2CxDXP/31ok4EcaioopU/wGTKx0HGUfC98=;
        b=bJ+CQUhZEr6/U/jqhsSuoYthsjir9MdhUQPcWGJTekLssLSz/08IIeIgytU9+loS1j
         nyoFXbMD5ZSKCN9q0lkBn3nuPsMgLLGMju489nPUHk1raiRGY3WVwM2nZXKwjrafE/7w
         FWxV6Qx11wK1idjiuauBzAnzOHRolFrNkDrx6XnnuCwKMaR3rb1GzEXZRMHpdP2YiICo
         GPMXLQijn8mubbJZpEKU9DfJe2bsjy4y1xG2zlIQ5Re1kpac49O3kkyMhvwbBPMSL/0B
         OQQZfeV6bvp1LlpTRsvlE5t0o0Et2BhW2rKQxDo327hL1Wlbr2ntJRBwz+EU4qAxPMrg
         54SA==
X-Gm-Message-State: AGi0PualGYEJwylluZbrrLqSv6RRehDWop6EO61CV1XA4PATPkleKfhD
        JjC5U82RrpyMYlHQfaTQo12jrc3QhG0DN9jeAFXbsw==
X-Google-Smtp-Source: APiQypJmTsEKASAG4SiA5XzPDFSzNYxwfwGB4aaYapOEehOuSCUBZddPmAvEKUEFKRwnK0JvN7WxsQEteAPFYWLtLLw=
X-Received: by 2002:a17:906:53cb:: with SMTP id p11mr10685816ejo.145.1586432323451;
 Thu, 09 Apr 2020 04:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200409091858.GE28467@miu.piliscsaba.redhat.com> <20200409111348.GR21484@bombadil.infradead.org>
In-Reply-To: <20200409111348.GR21484@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Apr 2020 13:38:32 +0200
Message-ID: <CAJfpegt3ExRJ17sQ7=B70b+KCVAuzQq203_WCKysN+GTf62srg@mail.gmail.com>
Subject: Re: [PATCH] proc/mounts: add cursor
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 1:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 09, 2020 at 11:18:58AM +0200, Miklos Szeredi wrote:
> > @@ -1249,31 +1277,48 @@ struct vfsmount *mnt_clone_internal(cons
> >  static void *m_start(struct seq_file *m, loff_t *pos)
> >  {
> >       struct proc_mounts *p = m->private;
> > +     struct mount *mnt;
> >
> >       down_read(&namespace_sem);
> > -     if (p->cached_event == p->ns->event) {
> > -             void *v = p->cached_mount;
> > -             if (*pos == p->cached_index)
> > -                     return v;
> > -             if (*pos == p->cached_index + 1) {
> > -                     v = seq_list_next(v, &p->ns->list, &p->cached_index);
> > -                     return p->cached_mount = v;
> > +     lock_ns_list(p->ns);
> > +     if (!*pos) {
> > +             list_move(&p->cursor.mnt_list, &p->ns->list);
> > +             p->cursor_pos = 0;
> > +     } else if (p->cursor_pos != *pos) {
> > +             /* Non-zero seek.  Could probably just return -ESPIPE... */
>
> Umm, that's not how calling seek() on a seqfile works.  I don't think
> you can hit this case.  Follow seq_lseek() as it calls traverse().

Ah, okay, f_pos is always a byte offset.   That's wonderful, I can get
rid of that wart.

Thanks,
Miklos
