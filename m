Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3D5E8877
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiIXFCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 01:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiIXFCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:02:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB7E3690
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 22:02:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z13so4377796ejp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 22:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lnK9ND6W9VWlRV4K17f6V2rxDL8KPokQcYAEQ4YrGUI=;
        b=kdqhTuPdJFFYU+BjnkvAJ0miNXg1BVtxKoL/2wgyYDsMBrTfpnCTAIuF6FiATx7WMo
         8MD8CP9DbGcAcfGXIqxps5uRgn5jNVNEjPqhWFu87NFZTCM3ZqrqEHXJGyZqzXht+HbQ
         D2IQ+DnKOrp/KsmX3PL/IoDFMToWqr1d9k2a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lnK9ND6W9VWlRV4K17f6V2rxDL8KPokQcYAEQ4YrGUI=;
        b=VDPdN0MXZGmYy/BmJ9i117ANUBQXnmqsoRGuZRSzDBRUiIDm6XtbUXCcxbrc3nD0KX
         AM6lCU0QfUdmY/9qOLsiHaF1DYznnfHQbqWRMw3MW1sRjhhugQOIzHUtGTFnWzKeMJdv
         HboFpBd1TIkYjXoFi+wxwC1hJhS0SoZ5jDIciNIsHuzB97WFF91DoOOGV89z76OdEUwl
         CHJUZNDXds+KRXGtVqEpSChmBTV9VL0BrnlLDhvot+lmCxGcJ/007Gud88/HxmotvIQQ
         WcqRtibwDGyt3x0BpzOQ+swlCqzSmYQgg5oMNoNjz72YPWhfxl0XxgiET45L5CJTwcBT
         4ECA==
X-Gm-Message-State: ACrzQf0+rp9YDqYwE/24PXhqjpkJ/zRphwLjn5vzGGc6i43P99aFkSoA
        0tW8L6UJfx0UXBfUVYd6kcIXB5pfRnga1pYj5kFkVw==
X-Google-Smtp-Source: AMsMyM6VhAab3ZNJ9bRncL8zsyH307G7Rn/ooPCJn8naVImRtTEG8eD2AmcUY1t7OK9VWtf/E5XQrKIK8//cF5zkV30=
X-Received: by 2002:a17:906:4783:b0:780:5be5:c81b with SMTP id
 cw3-20020a170906478300b007805be5c81bmr10039218ejc.76.1663995750525; Fri, 23
 Sep 2022 22:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220922084442.2401223-1-mszeredi@redhat.com> <20220922084442.2401223-5-mszeredi@redhat.com>
 <YyyLyY3TUG6IaU3Y@ZenIV> <CAJfpegsEi8VSZOXJDbFatvHsKMjuXPCm42GApRG_s1EZobdCAg@mail.gmail.com>
 <Yy6OASz8zZIpBRNk@ZenIV>
In-Reply-To: <Yy6OASz8zZIpBRNk@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 24 Sep 2022 07:02:19 +0200
Message-ID: <CAJfpegv39g--QB=ks9oFRajbCveO+q0nwH3caZz1_Sw4TLiNww@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] cachefiles: only pass inode to
 *mark_inode_inuse() helpers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 24 Sept 2022 at 06:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Sep 23, 2022 at 05:42:01PM +0200, Miklos Szeredi wrote:
> > On Thu, 22 Sept 2022 at 18:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > > I would rather leave unobfuscating that to a separate patch,
> > > if not a separate series, but since you are touching
> > > cachefiles_unmark_inode_in_use() anyway, might as well
> > > get rid of if (inode) in there - it's equivalent to if (true).
> >
> > Okay, pushed updated version (also with
> > cachefiles_do_unmark_inode_in_use() un-open-coding) to:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile-v5
>
> OK...  I can live with that.  Could you
> replace
>         cachefiles_do_unmark_inode_in_use(object, file_inode(file));
> with
>         cachefiles_do_unmark_inode_in_use(object, inode);
> in there and repush?  Or I could do cherry-pick and fix it up...

Done.  Head is now:

7d37539037c2 ("fuse: implement ->tmpfile()")

Thanks,
Miklos
