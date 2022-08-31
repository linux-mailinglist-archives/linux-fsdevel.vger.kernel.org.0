Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986F55A7D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHaMUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiHaMUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:20:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA60C25280
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:20:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kk26so27943513ejc.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YzG/ub7v5MJTpdWDIaEQi2AXlyTWZlqWQjSj82qt80Q=;
        b=NojXTEeXWNClqr7cgksTNUZePRYwHf22ZWc8y2pBaoa1jWLyQKW+lPc9SPI17G0qJV
         JTuLqyhV9uslQUOPq/GpmnFvHXx7VbZj8oybER1Y5aXKU3aGJjG6VzNsSvLlskYifc4a
         UqP0sVp8ViSIJ0xy0rMSh+i9qIx41NF91FMLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YzG/ub7v5MJTpdWDIaEQi2AXlyTWZlqWQjSj82qt80Q=;
        b=7KkEuF/d3EspP9HcqsTFeBKfrcyj6s/qizp+aKNGx+2qsFSk+s4MnxITQoI05+kw55
         /XRBnxF/RA1inUVXVTFSvc+hxkDfib0h3DxbqBhav5OpHnIfkzf1wACo1w6tEAJ8J7w0
         EZhx01A5fY7aOatp68aV2KNycKM65O7JEO0HaYlF/aPZCgBftZcVAcYhTKv0x9AU5ECo
         gEUewepSZ3hA6ekT1cNf3nBnPMKylCzCt8nsp+pSQDgbWV3h5/vOgadkTMOl/u0uYRFf
         9uyzUhQpXgwtneu5bfwcKx4GueeXkE06LnY8DuyIbmhwRCAGTu5fFGC0kAFRv/j9ZWlW
         3stQ==
X-Gm-Message-State: ACgBeo2htpBPd6ITwSOVwpmp+nOSMKJXmdtslKIplYUWwPRmOx1gzxYF
        4gCZvnXfJj3yS19r3nL7qPRppzfG9i5ODMD//KQ4Aw==
X-Google-Smtp-Source: AA6agR4M8CGIr1RjWn6LO6XZPU8IB4amsAGK7Pac8sCSW8wIE82GAxB6MtFC/e3xKf7gfls/96Dofg9zwxpVwQfBZtQ=
X-Received: by 2002:a17:907:9484:b0:73c:37bb:c4d7 with SMTP id
 dm4-20020a170907948400b0073c37bbc4d7mr20791895ejc.748.1661948399220; Wed, 31
 Aug 2022 05:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com>
In-Reply-To: <20220831025704.240962-1-yulilin@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 Aug 2022 14:19:48 +0200
Message-ID: <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Yu-Li Lin <yulilin@google.com>
Cc:     chirantan@chromium.org, dgreid@chromium.org,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        suleiman@chromium.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ref: https://lwn.net/Articles/896153/

On Wed, 31 Aug 2022 at 04:57, Yu-Li Lin <yulilin@google.com> wrote:
>
> On Fri, Nov 13, 2020 at 2:54:46PM +0100, Miklos Szeredi wrote:
> >
> > On Fri, Nov 13, 2020 at 1:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Fri, Nov 13, 2020 at 11:52:09AM +0100, Miklos Szeredi wrote:
> > >
> > > > It's the wrong interface, and we'll have to live with it forever if we
> > > > go this route.
> > > >
> > > > Better get the interface right and *then* think about the
> > > > implementation.  I don't think adding ->atomic_tmpfile() would be that
> > > > of a big deal, and likely other distributed fs would start using it in
> > > > the future.
> > >
> > > Let me think about it; I'm very unhappy with the amount of surgery it has
> > > taken to somewhat sanitize the results of ->atomic_open() introduction, so
> > > I'd prefer to do it reasonably clean or not at all.
> >
> > The minimal VFS change for fuse to be able to do tmpfile with one
> > request would be to pass open_flags to ->tmpfile().  That way the
> > private data for the open file would need to be temporarily stored in
> > the inode and ->open() would just pick it up from there without
> > sending another request.  Not the cleanest, but I really don't care as
> > long as the public interface is the right one.
> >
> > Thanks,
> > Miklos
>
> Resurrecting this old thread. Is there a conclusion on the addition of atomic_tmpfil() or vfs changes?
>
> Thanks,
> Yu-Li Lin
