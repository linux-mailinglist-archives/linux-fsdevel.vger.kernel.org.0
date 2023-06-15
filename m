Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1E731686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjFOL3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbjFOL3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:29:34 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128492695;
        Thu, 15 Jun 2023 04:29:33 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78a3e1ed1deso1398368241.1;
        Thu, 15 Jun 2023 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828572; x=1689420572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiF18iPDZLxLtPFcVNcoB1njlDGbflBRQ0CK3htap7k=;
        b=KCkTB9YkADZG6Lz5e2xM9sHyRba+Zf66esiL6Xg3RJz0vwUThtal0TVXux/O3mr5rK
         JZ6E5R9SAU7X7b8vYYF/B58AtJ14WYWho3wrFqURgBAiEGVIJEUMN8395/byNlBAmHnP
         Z8CjQkJ8OwDH68XXDXyGr0W6n/d5jDH0nX+I/4GbFe05ii45MhBhvU4c6jswS77o8gAW
         EWGVjEBJyK5MmO8STyFEdJgMQm/AhZ6YOpL9DGDwtBbl0cQw8fE+3NtzQp/Vz0IIHXOX
         hdID091wt/awES6+lvGz1Y5duJwLlw342uENUYzhVh1FP7fpRcS9U2Vf7n3a8Z0QU2WM
         gt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828572; x=1689420572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiF18iPDZLxLtPFcVNcoB1njlDGbflBRQ0CK3htap7k=;
        b=DN4q729BMeAt4PRPmUXzJfLXlNd+upibJZHlLdL/SbJ0yaRcX4Af1lhnJNGywodkOy
         DIR5kkdyiFB6JyJ5iKRtxG4yxSyJZvVsD6VWYSdLysrwVx+TOgWx+TZ2m6eyEccSJRBc
         CorOV49O8J3GIqR2Nv9pF8eT0z7pz7N/dwgofl2UFgvQSulZ/oJFnHSPTnDqU6mYbsLb
         Z9N8lMBZttPvyKCvAtm/h0eefVF27+MM/0PwR0JFwekklUy9v++E24H4VLB65QLaTsiE
         ob0yPSRuCIv17iDGMkPBjuk/Gi6qqjEYdtjJt/xDDjDozgmJR4AysyhigwPXrBbFL17q
         8OnQ==
X-Gm-Message-State: AC+VfDxgoIoExrZQdg2/UTh1e29noR4yysx6kwvMoNl9DHjE7K1ofnv1
        GdtOgRcku7gGyFrqYdc9UB4KYLt1m6xq844ofXQ=
X-Google-Smtp-Source: ACHHUZ483PmdGjNCtA1v+0zFW+fx/9JY6O+yiJdDf5MXdORVF/hBrFoJpZsJaL2NtwVhSYo5L072zN5ZV0CBddY8PU4=
X-Received: by 2002:a67:fbd1:0:b0:43f:52fe:e879 with SMTP id
 o17-20020a67fbd1000000b0043f52fee879mr2417812vsr.12.1686828572128; Thu, 15
 Jun 2023 04:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230614120917.2037482-1-amir73il@gmail.com> <20230615042655.GB4508@lst.de>
In-Reply-To: <20230615042655.GB4508@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Jun 2023 14:29:21 +0300
Message-ID: <CAOQ4uxit+m2Y90YXwG6eoHePb0UH=jvVjP7=by0AE4ychjfPHQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use helpers for opening kernel internal files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 7:26=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jun 14, 2023 at 03:09:17PM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use vfs_open_tmpfile() to open a tmpfile
> > without accounting for nr_files.
> >
> > Rename this helper to kernel_tmpfile_open() to better reflect this
> > helper is used for kernel internal users.
> >
> > cachefiles uses open_with_fake_path() without the need for a fake path
> > only to use the noaccount feature of open_with_fake_path().
> >
> > Fork open_with_fake_path() to kernel_file_open() which only does the
> > noaccount feature and use it in cachefiles.
>
> Please split this into two patches, one for the
> vfs_tmpfile_open rename, and one for the kernel_file_open helper.
>
> > +EXPORT_SYMBOL(kernel_file_open);
>
> EXPORT_SYMBOL_GPL, please.

Hmm. Technically, the renamed symbol {vfs,kernel}_tmpfile_open is a
new symbol so we can make it EXPORT_SYMBOL_GPL too.
The only users should be overlayfs and cachefiles.

I had already posted v5 without changing it, but if you think that is right=
,
I can ask Christian to change that on commit.

Thanks,
Amir.
