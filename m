Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293981F7E15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLUea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLUe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:34:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95747C03E96F;
        Fri, 12 Jun 2020 13:34:29 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h3so9960486ilh.13;
        Fri, 12 Jun 2020 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8mTmYznmJPhravJo3PSaU34NH8z9IvbBcuHBmZXOGo=;
        b=nrHlq+bwoQ/ZjAWfHatx49FQEGaqg7lazcinxpFcX3WjpB54X107qOzpWp/rxY4Msn
         B3/d11nyVrfydX5/qlIuCTm5EBbd5b8Wj6ZtvEMabQB+geJEwubPZ+JW70wPN2i1DSsZ
         KDuQ+ofl9ntbeup8C35pmhKvk65+Vpie0I5p+XD3W7AcX8NecFbvxPvzz/rimQIZ0Dz5
         8HcrhVTWZTZhw9Z+KTlUVfsjFdSfAD1VIgFkQ3vgPKX55PeokHBE2FBbMgzZUJpuUJdt
         DqaN1g8oXiKYyJ5yYkDp+TyUIv9AmXzBNOWDqZjWwVjt/eZE5nfkZSI/6mR7qnqSZEas
         NLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8mTmYznmJPhravJo3PSaU34NH8z9IvbBcuHBmZXOGo=;
        b=qiFBATadYI52MWXSkAJJNzcPRrgMi5im9YvZSoBvf9kT8nqgDr+IRtb2Zka7D/Q2W0
         qcHj1pChggeg4bA1bIzMB53ZBo5ZBZkCGdk6qs69Koj1SOwZKKyddYYXUuaQtZQkuUeb
         iuEUsG2axUV3/2qns+abfiO5niDxDPEDTQlRY2JfqGTjTyHSnFRs8Do+a5A2Lh1jt92s
         dftUHOvK74jsidj9Mr9xanEIPwKUkwf07G8xNKfGGc05THbgyFLrkZHZ1Iavibu7TMZk
         84x28tw06bKHCNXAG6C4XRPakYPqp9BmQyblTxZDM+DndG7M4zTKffhZs7WoKUKGn50i
         M+tg==
X-Gm-Message-State: AOAM531U7exE0h1xybZ+t7DZz2OSWbB7Fh+NF4Hjlzv9vBCIDQQfcN4u
        WAqRdxKhgoXgLA6PidSWr3K550acimYpLOlMd9CwJ7Kl
X-Google-Smtp-Source: ABdhPJyu94HXBYyAjaK/MHC2Kx7C+sW3KiadWnWD74+pdT90gNCtnPjG2LNHcNGNwqWZkLiQsluBjg0xAuvxLvPGFtY=
X-Received: by 2002:a92:c60b:: with SMTP id p11mr15397911ilm.137.1591994067592;
 Fri, 12 Jun 2020 13:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200612092603.GB3183@techsingularity.net> <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
 <20200612131854.GD3183@techsingularity.net> <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Jun 2020 23:34:16 +0300
Message-ID: <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > So maybe it would be better to list all users of alloc_file_pseudo()
> > > and say that they all should be opted out of fsnotify, without mentioning
> > > "internal mount"?
> > >
> >
> > The users are DMA buffers, CXL, aio, anon inodes, hugetlbfs, anonymous
> > pipes, shmem and sockets although not all of them necessary end up using
> > a VFS operation that triggers fsnotify.  Either way, I don't think it
> > makes sense (or even possible) to watch any of those with fanotify so
> > setting the flag seems reasonable.
> >
>
> I also think this seems reasonable, but the more accurate reason IMO
> is found in the comment for d_alloc_pseudo():
> "allocate a dentry (for lookup-less filesystems)..."
>
> > I updated the changelog and maybe this is clearer.
>
> I still find the use of "internal mount" terminology too vague.
> "lookup-less filesystems" would have been more accurate,

Only it is not really accurate for shmfs anf hugetlbfs, which are
not lookup-less, they just hand out un-lookable inodes.

> because as you correctly point out, the user API to set a watch
> requires that the marked object is looked up in the filesystem.
>
> There are also some kernel internal users that set watches
> like audit and nfsd, but I think they are also only interested in
> inodes that have a path at the time that the mark is setup.
>

FWIW I verified that watches can be set on anonymous pipes
via /proc/XX/fd, so if we are going to apply this patch, I think it
should be accompanied with a complimentary patch that forbids
setting up a mark on these sort of inodes. If someone out there
is doing this, at least they would get a loud message that something
has changed instead of silently dropping fsnotify events.

So now the question is how do we identify/classify "these sort of
inodes"? If they are no common well defining characteristics, we
may need to blacklist pipes sockets and anon inodes explicitly
with S_NONOTIFY.

Thanks,
Amir.
