Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267E91FABC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFPJB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPJB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:01:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04CDC03E97C
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:01:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x25so6723223edr.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXqJ+RQf+2HxRMU1JHbm735Et9Rb/a777XiyMXnrkuA=;
        b=bxLzhhZKjFFEansW2CGWHfG43cgQwpbnzVH6qLEiCQ6gnKC8IHUTIhAz5n77Wm/Pml
         vWSTFMw+eyqstHjZVU9rHtwv+RLIFJZ0lHZc4ybESxoAFssGZ2LqrEPRKi83kpCIP8FU
         MXSgw6fwsQP4d6rGNtDVWkB2gncPjCUybm6Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXqJ+RQf+2HxRMU1JHbm735Et9Rb/a777XiyMXnrkuA=;
        b=eK2Mu9ryBLaJmtCClegJfa4LIFXg8k5TQwwAbZs1jMreiEoj0XAu+LI5RQA1qtnOG6
         gAsmLe2/YY677ugLPoMMu+dEuRQeYC78a2ewcKWgb1wJvgitN0f9IjiSYl3yUr4cltcF
         8HQwPuZijQLYFwEH/vc4QCaw4xA1qn8ZJKg7PgxCMRJE0W4luuTWVZBnU7/cxm6qyzAv
         gTNud4nObed0xzDAr294T7Qg/K++blAubZXNJgJ+REekA3ZTpqITxVDDJ3MXQFrv+9RV
         oE8dgeDoYhi9+hdy5xg1mrTllM6SCFz437rnhC2B77DZ4w1JxkIngVt+gLeG/ExUM0AF
         tTZQ==
X-Gm-Message-State: AOAM5321QzGa2EvCcopwYpyoRSbDJ/ceVp5Axznu0WHApFabs3kbmRw/
        D6ThuzbOaZ15ZZg++4XmrfMaouXzSSM+RoC97dOLZg==
X-Google-Smtp-Source: ABdhPJxNZWipYKKlR5OtEfpmzoc47S3PROSEQ+F2abrhpsMM+Wm0j4MqqdQ3IOWc1jhXe+AWNF/jZwF6otlN3W9Mtwg=
X-Received: by 2002:aa7:d9d3:: with SMTP id v19mr1550941eds.364.1592298084726;
 Tue, 16 Jun 2020 02:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
 <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com> <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
 <80f869aa-810d-ef6c-8888-b46cee135907@oracle.com>
In-Reply-To: <80f869aa-810d-ef6c-8888-b46cee135907@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Jun 2020 11:01:13 +0200
Message-ID: <CAJfpeguTnVOTq4u_E=wDPcJ7vJE_jsAOi_ztm0Pt=X1qtC8ObA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 1:45 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 6/15/20 12:53 AM, Miklos Szeredi wrote:
> > On Sat, Jun 13, 2020 at 9:12 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 6/12/20 11:53 PM, Amir Goldstein wrote:
> >>>
> >>> The simplest thing for you to do in order to shush syzbot is what procfs does:
> >>>         /*
> >>>          * procfs isn't actually a stacking filesystem; however, there is
> >>>          * too much magic going on inside it to permit stacking things on
> >>>          * top of it
> >>>          */
> >>>         s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> >>>
> >>> Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
> >>> are some out of tree implementations as well (shiftfs).
> >>> So you may only take that option if you do not care about the combination
> >>> of hugetlbfs with any of the above.
> >>>
> >>> overlayfs support of mmap is not as good as one might hope.
> >>> overlayfs.rst says:
> >>> "If a file residing on a lower layer is opened for read-only and then
> >>>  memory mapped with MAP_SHARED, then subsequent changes to
> >>>  the file are not reflected in the memory mapping."
> >>>
> >>> So if I were you, I wouldn't go trying to fix overlayfs-huguetlb interop...
> >>
> >> Thanks again,
> >>
> >> I'll look at something as simple as s_stack_depth.
> >
> > Agree.
>
> Apologies again for in the incorrect information about writing to lower
> filesystem.
>
> Stacking ecryptfs on hugetlbfs does not work either.  Here is what happens
> when trying to create a new file.
>
> [ 1188.863425] ecryptfs_write_metadata_to_contents: Error attempting to write header information to lower file; rc = [-22]
> [ 1188.865469] ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-22]
> [ 1188.867022] Error writing headers; rc = [-22]
>
> I like Amir's idea of just setting s_stack_depth in hugetlbfs to prevent
> stacking.
>
> From 0fbed66b37c18919ea7edd47b113c97644f49362 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 15 Jun 2020 14:37:52 -0700
> Subject: [PATCH] hugetlbfs: prevent filesystem stacking of hugetlbfs
>
> syzbot found issues with having hugetlbfs on a union/overlay as reported
> in [1].  Due to the limitations (no write) and special functionality of
> hugetlbfs, it does not work well in filesystem stacking.  There are no
> know use cases for hugetlbfs stacking.  Rather than making modifications
> to get hugetlbfs working in such environments, simply prevent stacking.
>
> [1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/
>
> Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
