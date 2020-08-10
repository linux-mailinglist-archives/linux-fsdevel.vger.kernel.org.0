Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7175B24036E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgHJI31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgHJI30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:29:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6AC061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 01:29:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t10so4132748ejs.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CquD0s9C4x3ETpaALuSLXwVqkmCKd258dwzlSXP4DNs=;
        b=S2DnfquUHkVrQ3lZVZC1emkh4OCaAvpJvC5YFe8+WX6NKsOIK7gbvBx/6LZgrhozk7
         CFbSDsCdO1bYMfX6mAIinY2M5dta1plFEJhbQJA6IDjdZX4QYOF8Qga7R0zegK/Swnxn
         GUzWkJocv9oeIfkHDemI3ud7ojPTlett6S974=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CquD0s9C4x3ETpaALuSLXwVqkmCKd258dwzlSXP4DNs=;
        b=WDCdRdRbIiK2PLp2B5oJtH0pIG+9hZPbEdC4UDejgv7LgHJxeuwRxkx4te9xKsUXkl
         Wleow/iXRSVK/T3SXCnBuuRYw642vCp69rgg+IpvG1iNJipG9We+jSAkZVVv1KSkMdF/
         dlA7JP+66XmoSvi6iBO3cUJNQH+Hi2ab7uCRg+Gn8F8O1hotNfn0uNgFQk0KKK2q2fZs
         lLc4slsbG4NG9f0Ge0X1xmJJnMFuR+fLACGEq5TVO6xdHx99a+JPxkTZ7VrbWy7nkI6d
         XyKnJK7eKzWsGpCjCiZNwB6lVGXSLM4o/5yTSXw/3bnEMio7dgcW0lU71rGn3F0lbtQ4
         TN9Q==
X-Gm-Message-State: AOAM530M8xa20afpTd2Rd3c6pHoP1MkX470HeKAvZAP6jf3t/3lj9T6Z
        EHcgVli1bSVg80XQcfCwbhDTZjntA5n64iJwz51ZVg==
X-Google-Smtp-Source: ABdhPJymxmF62V4mFPjLD8Xyf4/ROO4rV4ulcke6lD5k+WZ/kAVNiICIkc9A/+ioZXl6Ut5lq3cwFfePgaktSdDGdPE=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr5960567ejw.443.1597048164614;
 Mon, 10 Aug 2020 01:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200807195526.426056-1-vgoyal@redhat.com> <20200807195526.426056-19-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-19-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Aug 2020 10:29:13 +0200
Message-ID: <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] fuse: Release file in process context
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> fuse_file_put(sync) can be called with sync=true/false. If sync=true,
> it waits for release request response and then calls iput() in the
> caller's context. If sync=false, it does not wait for release request
> response, frees the fuse_file struct immediately and req->end function
> does the iput().
>
> iput() can be a problem with DAX if called in req->end context. If this
> is last reference to inode (VFS has let go its reference already), then
> iput() will clean DAX mappings as well and send REMOVEMAPPING requests
> and wait for completion. (All the the worker thread context which is
> processing fuse replies from daemon on the host).
>
> That means it blocks worker thread and it stops processing further
> replies and system deadlocks.

Is this reasoning specific to DAX?  Seems to me this is a virtio-fs
specific issue.

Thanks,
Miklos
