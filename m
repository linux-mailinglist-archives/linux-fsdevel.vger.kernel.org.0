Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E032D6AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfJNUk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 16:40:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbfJNUk5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:40:57 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03473CFD4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2019 20:40:57 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id d15so8175784otc.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SvMDPZOcKULNOK9bYvjjcU3cyL7Xy65q4lsrYxQ1w4=;
        b=Q9AzaNaBqQgkJsxZ/EpUvNcPbu+grXq7B+C8bEItRZiqYWQLaWjddPLV/KRm0yHu1L
         XjGM88y903tEYk5qab6+hFqqCr3twfNLn63WARGEyOK5WWLvfvoa13sZi6NA5A3mt/Zn
         tAq5b9GjfRuaWeCHhWcHvmxQfAgDDS7dE6Pd7N3mZhiC6XDTTl3OKOc2kcJj4UFsY3Yg
         d0v5+N78pMCXjrZw7qvjYdqU7UKXm+xKYcGvuvHaotftolF1Oj6iSBJusVmiyYKrEYWt
         7q1/zwrBLp3x96QhgbzraYxq6qwIhXZLpljSMWAxa8McFHPrckkP2oP2+ibJc+9SJK0o
         iA3w==
X-Gm-Message-State: APjAAAVQZMvAtud9bKvIzt8gDbD3drJY8gwastyiNM2ZifMJgPTZttqZ
        BzEDGMxykla43qe4OWBMnbZyBXgTh0MYl9w7au0towjjL3GydN/b24D/CVEM08RMOF8S10ThFif
        knVSZ88k69rfQxcyMW0bP/jHRav56x+Uy+u0nF9ESDA==
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr11555571otp.297.1571085656360;
        Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwS11yxA6JO2sXstwZ6AIazd1XnFwJycqEmuSjW8pnyFgmwB4IaS3Xbgj0YhLyyim/T+w7nl1W3FcG41CJtWfs=
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr11555559otp.297.1571085656130;
 Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ac6a360592eb26c1@google.com> <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
 <20190919211013.GN5340@magnolia>
In-Reply-To: <20190919211013.GN5340@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 14 Oct 2019 22:40:44 +0200
Message-ID: <CAHc6FU7drv7r7yu4BzTGKycnKi_wUDGsvND6XyhDLq7B=HCM8g@mail.gmail.com>
Subject: Re: INFO: task hung in pipe_write (2)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On Thu, Sep 19, 2019 at 11:10 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Thu, Sep 19, 2019 at 10:55:44PM +0200, Rasmus Villemoes wrote:
> > On 19/09/2019 19.19, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    288b9117 Add linux-next specific files for 20190918
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000
> > >
> > > The bug was bisected to:
> > >
> > > commit cfb864757d8690631aadf1c4b80022c18ae865b3
> > > Author: Darrick J. Wong <darrick.wong@oracle.com>
> > > Date:   Tue Sep 17 16:05:22 2019 +0000
> > >
> > >     splice: only read in as much information as there is pipe buffer space
> >
> > The middle hunk (the one before splice_pipe_to_pipe()) accesses
> > opipe->{buffers, nrbufs}, but opipe is not locked at that point. So
> > maybe we end up passing len==0, which seems (once there's room in opipe)
> > it would put a zero-length pipe_buffer in opipe - and that probably
> > violates an invariant somewhere.
> >
> > But does the splice_pipe_to_pipe() case even need that extra logic?
> > Doesn't it handle short writes correctly already?
>
> Yep.  I missed the part where splice_pipe_to_pipe is already perfectly
> capable of detecting insufficient space in opipe and kicking opipe's
> readers to clear out the buffer.  So that hunk isn't needed, and now I'm
> wondering how in the other clause we return 0 from wait_for_space yet
> still don't have buffer space...
>
> Oh well, back to the drawing board.  Good catch, though now it's become
> painfully clear that xfstests lacks rigorous testing of splice()...

have you had any luck figuring out how to fix this? We're still
suffering from the regression I've reported a while ago (*).

If not, I wonder if reverting commit 8f67b5adc030 would make sense for now.

* https://lore.kernel.org/linux-fsdevel/CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com/T/#u

Thanks,
Andreas
