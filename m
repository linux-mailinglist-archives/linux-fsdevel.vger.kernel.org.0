Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEDD2F2C30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbhALKFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390390AbhALKFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:05:38 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A47FC061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 02:04:58 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id d6so458454vkb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rS4sdXVHr4l3vGRPMuRvaL1eabkA37lCE2nh9ri+8DA=;
        b=f6Llr2Ei6o9IxbS05Jb89UXoWPqSI2kibVhcgOSycNIT9BHPBbZWtGxXn+WN4i5WCB
         AJOaz8a1xnVBZLXTssdcpIgtFblHkyYiljyiuxZ638ZbcdCEUWce4loVsjZ0tXWMhxu6
         AmEclYLBi87TEBoqp95L0D4aYhWwzlVJWZkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rS4sdXVHr4l3vGRPMuRvaL1eabkA37lCE2nh9ri+8DA=;
        b=WbpfsO2GcWLQlLC8oLrziSwWNbsU3ejEImt/6GoXafDZacduCBSGUi3dRkfN922oWe
         lvWTL9n+04yOmfp4FuvZ3a/rgldPcp+a505cdpu7hTQQx2nB3q4FvJwoq/V9Tqv+JLD1
         1V6akzyAmkjkt01/S30XNAa/75qnOz0GEnQ5cECNoPY4sGnsLjejY6DOFY/f7cXY5yO+
         gtIcj3OsY/YPS9RQ/Zt5D1gdiCFwCkZ4WHaKjsmVliSWJLcrLiAyRd471lWjJlfgs4xx
         4J1xNa/OopCWBUt+oFhxASGusyMkeX4Z3K/zej8BDUuZBpSlEWf3y0Gj+lTTd4wkYMZF
         nsDQ==
X-Gm-Message-State: AOAM531Yd/cQXeBwkIBAjpPlXx4nNLoV7NbaQhPtNjyFzpfFo5HgbTTx
        ix2UWXZ5VYpTiIalThyp6o5vCtFG9YxC9+CRjb5Raw==
X-Google-Smtp-Source: ABdhPJztDdZxYIknYtDyA4L4qWH3qQH8eT1tvdwztKucGwlw6fqzlmexa8qFWsTe/ripf7WrljQs6a1FAY+W8sF9/m0=
X-Received: by 2002:ac5:c284:: with SMTP id h4mr3303695vkk.14.1610445897639;
 Tue, 12 Jan 2021 02:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-2-mszeredi@redhat.com>
 <87czyoimqz.fsf@x220.int.ebiederm.org> <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
 <874kjnm2p2.fsf@x220.int.ebiederm.org> <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
In-Reply-To: <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Jan 2021 11:04:46 +0100
Message-ID: <CAJfpegutxHPuEnUxapcwcwiEiND8Swdi7CSOMaU06qV9=uUdXA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:43 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> The following semantics would make a ton more sense, since getting a
> v2 would indicate that rootid is unknown:
>
> - if cap is v2 convert to v3 with zero rootid
> - after this, check if rootid needs to be translated, if not return v3
> - if yes, try to translate to current ns, if succeeds return translated v3
> - if not mappable, return v2
>
> Hmm?

Actually, it would make even more sense to simply skip unconvertible
caps and return -ENODATA.  In fact that's what I thought would happen
until I looked at the -EOPNOTSUPP fallback code in vfs_getxattr().

Serge, do you remember what was the reason for the unconverted fallback?

Thanks,
Miklos
