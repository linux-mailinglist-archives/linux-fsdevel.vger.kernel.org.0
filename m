Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D930013E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 12:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAVLLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 06:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbhAVLHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:07:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE40AC061788
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 03:06:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so4686911wry.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gedglrbx9q6b8ayqlT6Zdi3perRe4tSg9LO4why35tI=;
        b=UdfjlErGXEiKdZ1DUD/oqU/KTTdzQ35kaLmaXb2Aput23plO1PG2n8wz00QGwRxbfm
         v+e+CGIxZ9exmstKTQD+ThBW0YBP9qh0FqVTYGhd5U9E49K/o8GAAGtpTtVTc/CsYdjm
         73QmE5wjKeT2rMyoHenk/Iw3RBWSGTFhDpvTF6j1MOKgdsVQZrb2KNKoLG69Ja8p6q1Y
         UuIve0YX00bAA1rkqqTZiUudX/LK/jKvSEYaD1RjA6isiunEv1SZf+21J7oICn5L92zX
         jxrJIbkKkVTiqeC97JYCVfrpDDJM2S/T0+sUdO3QhCgYjNz/+tbqfd8/eHyO1YZ+x9Dm
         Laug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gedglrbx9q6b8ayqlT6Zdi3perRe4tSg9LO4why35tI=;
        b=J4S2+aPzppd4utPe4f1zp8+RXcSzkcmFmMajNi52B3REmNB1uk5YT4Cz9ui7eySiST
         kAqWiYiir/mkzBtvqU08YKEudRVnSfE0/dJaMjAt+1cY4NX/MrWb7ukHxxDLhtIUBPSr
         wiI5NtQrv0gvw1zPD6GEhNnFaZMI7V7Psr1TyqgCQ0WisEu7iU9JkYYJ4TCqeXJ//CcQ
         gTTakjC+f3HnQoSWr4ztH7isI8etO7Ec7Iw3hQAHLsU3a/KIelNsSh5gOeqR8QO4RmJm
         n+H4dyYwwWw7h3p1rfQB241b1Cn6yr05zFxtFEddXkgy1QaGqodqHfvReEaddkIc63QQ
         veOg==
X-Gm-Message-State: AOAM530kFceaj85li6Hb4j4/IedW9gAd1g8/vTLwiryx8G+dlatyonPX
        2EiWLJDu4hWbe6AHjcBbzsLzaQ==
X-Google-Smtp-Source: ABdhPJyXE/UFJeBIlU8F7vIHiNwittliF+yPDJJW7gWfRl3kINUwHVEsZZLRpopfQ+mjLlPa83xAGA==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr3958812wrr.306.1611313587592;
        Fri, 22 Jan 2021 03:06:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:8ce4:12a9:3261:aa54])
        by smtp.gmail.com with ESMTPSA id z15sm11346881wrt.8.2021.01.22.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 03:06:27 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:06:25 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     balsini@android.com, akailash@google.com, amir73il@gmail.com,
        axboe@kernel.dk, bergwolf@gmail.com, duostefano93@gmail.com,
        dvander@google.com, fuse-devel@lists.sourceforge.net,
        gscrivan@redhat.com, jannh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, miklos@szeredi.hu, palmer@dabbelt.com,
        paullawrence@google.com, trapexit@spawn.link, zezeozue@google.com
Subject: Re: [PATCH RESEND V11 0/7] fuse: Add support for passthrough
 read/write
Message-ID: <YAqxsWpH54moi+t6@google.com>
References: <20210118192748.584213-1-balsini@android.com>
 <20210119110654.11817-1-wu-yan@tcl.com>
 <YAbRz83CV2TyU3wT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAbRz83CV2TyU3wT@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:34:23PM +0000, Alessio Balsini wrote:
> On Tue, Jan 19, 2021 at 07:06:54PM +0800, Rokudo Yan wrote:
> > on Mon, Jan 18, 2021 at 5:27 PM Alessio Balsini <balsini@android.com> wrote:
> > >
> > > This is the 11th version of the series, rebased on top of v5.11-rc4.
> > > Please find the changelog at the bottom of this cover letter.
> > > 
> > > Add support for file system passthrough read/write of files when enabled
> > > in userspace through the option FUSE_PASSTHROUGH.
> > [...]
> > 
> > 
> > Hi Allesio,
> > 
> > Could you please add support for passthrough mmap too ?
> > If the fuse file opened with passthrough actived, and then map (shared) to (another) process
> > address space using mmap interface. As access the file with mmap will pass the vfs cache of fuse,
> > but access the file with read/write will bypass the vfs cache of fuse, this may cause inconsistency.
> > eg. the reader read the fuse file with mmap() and the writer modify the file with write(), the reader
> > may not see the modification immediately since the writer bypass the vfs cache of fuse.
> > Actually we have already meet an issue caused by the inconsistency after applying fuse passthrough
> > scheme to our product.
> > 
> > Thanks,
> > yanwu.
> 
> Hi yanwu,
> 
> Thank you for your interest in this change.
> 
> FUSE passthrough for mmap is an extension that is already in my TODO
> list, together with passthrough for directories.
> For now I would prefer to keep this series minimal to make the review
> process leaner and simpler.
> I will start working on extending this series with new features and
> addressing more corner cases as soon as these changes get merged, what
> do you think?
> 
> Thanks,
> Alessio

Hi yanwu,

Sorry if I overlooked this issue. I added memory-mapping to my tests and
could reproduce/verify this wrong behavior you mentioned.

I created this WIP (history may change) branch that has the missing mmap
implementation:

  https://github.com/balsini/linux/commits/fuse-passthrough-v12-develop-v5.11-rc4

I did some mmap testing in the last days with this extra mmap
implementation and couldn't find any issues, everything seems to be
working as expected with the extra mmap patch. Can you please confirm
this is fixed on your end too?
I'm also going to revert in this branch the stacking policy changes to
how they were in V10 as suggested by Amir if there are no concerns with
that.
I'm waiting for some extra tests to complete and, if no issue is
detected, I'll post the V12 series super soon.

Thanks,
Alessio

