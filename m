Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E85709E55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjESRiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjESRiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 13:38:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21660F2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:38:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f53c06babso275510666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684517897; x=1687109897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ucWVdofg5ar9Sy7957FpoXFp27vLdLXG53ARFC9CGo=;
        b=ednmVM8rJlHSxfzo9l6pu1Mem8mdgWjnKJHswoZ2OZGw7qtqP0Xq/0tpuGdr1uXHnn
         skHkC+vIxObBmeOB6fR0duwzSXz/tUoyVweBu6kZdWiDIcBm1knjqCc0lVqp3o/RzUrH
         7NrCPhwg1Zj9LHaLbbhs+f87dfOy5TBGItUDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517897; x=1687109897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ucWVdofg5ar9Sy7957FpoXFp27vLdLXG53ARFC9CGo=;
        b=KkeRdbYLMeFJefx3QcKrzPwrVyQ+uojsSwhNPopwiat1qhGmDgPJKPTm7jU78tV4KC
         KqnyHW+2a89+rSdS9TYTCWJDAQV+RHwHKB4PJbTSwBb4ZNMuQNGWHxF8T4ya5TYxfgMv
         sHLKipRlccas6oiqmVnv4Jdk+tcnLT+8/g9wIn9hlKCGbKbQMwdxOSKGjNJYykDhgFP9
         PiFDFExFJdwvatxBVUmcDUhyp/T+xB9+Yun31b/FOMbzF+iyND+17Lxl9coN2TSOiUJw
         f3zDhkLm0Vjq6cFtl34XdcBeplpE08G0UfCHVbKcSIdXKOJs40RTYAR4dFU73N3+p8Mq
         89OQ==
X-Gm-Message-State: AC+VfDzmxVfv7UuNV2HjM9bsyEOk2Qj4mhlDeXaUpv2X/9aEe14Y/7wh
        Kcdk8GfUCIz7c/5rrgF7G8eG7vxw5oS5uWurHCZVcUdR
X-Google-Smtp-Source: ACHHUZ7nN7SffgoWBds2s2mpER1GZQzLukQM0duK7lEUGrx5311E2chl5fXwBwnjtC457myvtOSWeg==
X-Received: by 2002:a17:907:25c2:b0:969:edf8:f73b with SMTP id ae2-20020a17090725c200b00969edf8f73bmr2233547ejc.60.1684517897500;
        Fri, 19 May 2023 10:38:17 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ck7-20020a170906c44700b0094e6a9c1d24sm2540096ejb.12.2023.05.19.10.38.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:38:17 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9659e9bbff5so648505466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:38:17 -0700 (PDT)
X-Received: by 2002:a17:906:db0d:b0:94f:1a23:2f1b with SMTP id
 xj13-20020a170906db0d00b0094f1a232f1bmr2341051ejb.24.1684517896563; Fri, 19
 May 2023 10:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
 <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com> <1845768.1684514823@warthog.procyon.org.uk>
In-Reply-To: <1845768.1684514823@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 10:37:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDq5_wLWrapzFiJ3ZNn6aGFWeMJpAj5q+4z-Ok8DD9dA@mail.gmail.com>
Message-ID: <CAHk-=wjDq5_wLWrapzFiJ3ZNn6aGFWeMJpAj5q+4z-Ok8DD9dA@mail.gmail.com>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 9:48=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> This is just an optimisation to cut down the amount of bufferage allocate=
d

So the thing is, it's actually very very wrong for some files.

Now, admittedly, those files have other issues too, and it's a design
mistake to begin with, but look at a number of files in /proc.

In particular, look at the regular files that have a size of '0'. It's
quite common indeed. Things like

    /proc/cpuinfo
    /proc/stat
    ...

you can find a ton of them with

    find /proc -type f -size 0

Is it horribly wrong and bad? Yes. I hate it. It means that some
really basic user space tools refuse to work on them, and the tools
are 100% right - this is a kernel misfeature. Trying to do things like

    less -S /proc/cpuinfo

may or may not work depending on your version of 'less', for example,
because it's entirely reasonable to do something like

    fd =3D open(..);
    if (!fstat(fd, &st))
         len =3D st.st_size;

and limit your reads to the size of the file - exactly like your patch does=
.

Except it fails horribly on those broken /proc files.

I hate it, and I blame myself for the above horror, but it's pretty
much unfixable. We could make them look like named pipes or something,
but that's really ugly and probably would break other things anyway.
And we simply don't know the size ahead of time.

Now, *most* things work, because they just do the whole "read until
EOF". In fact, my current version of 'less' has no problem at all
doing the above thing, and gives the "expected" output.

Also, honestly, I really don't think that it's necessarily a good idea
to splice /proc files, but we actually do have splice wired up to
these because people asked for it:

    fe33850ff798 ("proc: wire up generic_file_splice_read for iter ops")
    4bd6a7353ee1 ("sysctl: Convert to iter interfaces")

so I suspect those things do exist.

> I could just drop it and leave it to userspace for now as the filesystem/=
block
> layer will stop anyway if it hits the EOF.  Christoph would prefer that I=
 call
> direct_splice_read() from generic_file_splice_read() in all O_DIRECT case=
s, if
> that's fine with you.

I guess that's fine, and for O_DIRECT itself it might even make sense
to do the size test. That said, I doubt it matters: if you use
O_DIRECT on a small file, you only have yourself to blame for doing
something stupid.

And if it isn't a small file, then who cares about some small EOF-time
optimization? Nobody.

So I would suggest not doing that optimization at all, because as-is,
it's either pointless or actively broken.

That said, I would *not* hate some kind of special FMODE_SIZELIMIT
flag that allows filesystems to opt in to "limit reads to size".

We already have flags like that: FMODE_UNSIGNED_OFFSET and
'sb->s_maxbytes' are both basically variations on that same theme, and
having another flag to say "limit reads to i_size" wouldn't be wrong.

It's only wrong when it is done mindlessly with S_ISREG().

             Linus
