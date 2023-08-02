Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983FF76CE42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjHBNSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjHBNSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:18:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885301734
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 06:18:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso106074021fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690982314; x=1691587114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4ngiP759TO68xv6Fq1GQWjBkFg+xCwJi87C8H39aVk=;
        b=KrZmGqbWJXgcJaMsQ//BVWUE4xlL4s/9l7vaRHkvIuZo+v4jgfQaYk1i2btHlaaclf
         UdWmRQRPZaYUdUjzdVQwPd8731BCc5jZiANjxa9zB/ufC+7pfsY3R7rEW5muVkfoz/OL
         OL0wftc43f9HZtkUVUPH1XooXsB0ODT3O43IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982314; x=1691587114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4ngiP759TO68xv6Fq1GQWjBkFg+xCwJi87C8H39aVk=;
        b=NyDGThIAM8kD/IiFHmbod18OV5qm5+V9A+Cs++sJxIJ00cUOqqPk9Rzkck8TcbIGyq
         u5BwyqiXWAGGZm3ahElxV0ALgmbuerHbZzkx5n3SenOAYQF7LDgKqRocK612bfPz1NzX
         RQHojgaW5RzRSq6FA75TH7+/pEY+ljNZQGEYDd8aKegvZSy3bOR5BrbJMZ3vVxQkkO48
         QK3S0Y0bbou06Xrp50IBoCiWLndn3fw1fJl03d9c/QLKvdsq09nKAVtFz1EV5oBPtvz/
         2OHQGlix6GFnK3IAqXzZBUOav90ZYBAZS2GXeXv4jBRPIS7ot5o1G/WPZiKL6YfJkEHv
         Zqhg==
X-Gm-Message-State: ABy/qLYbwTyCwpbSD5xM4KG0h9PXk7+qyrrPO/rCPRJ9MrXfr+26jYtM
        hpjBELYZOTV+wqMvLnWqNOX398ybZZgfgyfCVxxs3YKMy8gd3yEvZL+U7w==
X-Google-Smtp-Source: APBJJlEGgs/v+xVASISfGxmO9GUbsVf+ts2VfWSidC2Y3DV82S/vrT3rvYP4D/UqN1SMpADj2IVr0hL6DrD9PMyKlfk=
X-Received: by 2002:a2e:9457:0:b0:2b9:ea87:7448 with SMTP id
 o23-20020a2e9457000000b002b9ea877448mr4680428ljh.49.1690982313720; Wed, 02
 Aug 2023 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org>
In-Reply-To: <87tttpk2kp.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 2 Aug 2023 15:18:22 +0200
Message-ID: <CAJfpegvbNKiRggOKysv1QyoG4xsZkrEt0LUuehV+SfN=ByQnig@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 13:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jul 27 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
> > On Wed, 26 Jul 2023 at 20:09, Nikolaus Rath <Nikolaus@rath.org> wrote:
> >>
> >> Hello,
> >>
> >> It seems to me that fuse_notify_delete
> >> (https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
> >> with ENOTEMPTY if there is a pending FORGET request for a directory
> >> entry within. Is that correct?
> >
> > It's bug if it does that.
> >
> > The code related to NOTIFY_DELETE in fuse_reverse_inval_entry() seems
> > historic.  It's supposed to be careful about mountpoints and
> > referenced dentries, but d_invalidate() should have already gotten all
> > that out of the way and left an unhashed dentry without any submounts
> > or children. The checks just seem redundant, but not harmful.
> >
> > If you are managing to trigger the ENOTEMPTY case, then something
> > strange is going on, and we need to investigate.
>
> I can trigger this reliable on kernel 6.1.0-10-amd64 (Debian stable)
> with this sequence of operations:
>
> $ mkdir test
> $ echo foo > test/bar
> $ Trigger removal of test/bar and then test within the filesystem (not
> through unlink()/rmdir() but out-of-band)

Issue is that "test/.__s3ql__ctrl__" is still positive.  I.e. the
directory is *really* not empty.

I thought that that's okay, and d_invalidate will recursively unhash
dentries, but that's not the case.   d_invalidate removes submounts
but only unhashes the root of the subtree, leaving the rest intact.

So the solution here is to invoke NOTIFY_DELETE on
"test/.__s3ql__ctrl__"  before doing it on "test" itself.

I don't think NOTIFY_DELETE was ever meant to be a recursive delete.
This is indicated by the simple_empty() check, which will fail if any
positive child dentries remain.

Thanks,
Miklos
