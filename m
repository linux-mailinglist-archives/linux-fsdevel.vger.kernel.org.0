Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610A7753A2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjGNLwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNLwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449830C5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689335477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHYKpItuEcJuo5Jv3chYxiDW/iXWwzUQH5pKsFYaAmw=;
        b=L8wnRMNZifC1c53LgoWHxnbCJh1MMmoT0syjf1FsvnXsxjlyVtmlqIh/o2AmLISRskG2ig
        LvYiJg0dqg45ABDf6DLB5ardQJLKq2giywjEwmiZk/ktsxt+VNeb3GnunjUtKZUsf51YAG
        ihmaNLzejGUL8AhfUSYv0sIdN8Mk3rQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ZVSxKzBONdWznKRWiSPYkQ-1; Fri, 14 Jul 2023 07:51:16 -0400
X-MC-Unique: ZVSxKzBONdWznKRWiSPYkQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7948241cd38so200226241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 04:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689335476; x=1691927476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHYKpItuEcJuo5Jv3chYxiDW/iXWwzUQH5pKsFYaAmw=;
        b=LQm2le59Q/nMQmQ6EYTiJtguZ6WF/9zJjK5WJGkQ00h2MZ03+rxEgAvxPvsocszoxC
         ofdFeRH0MRbWKsIUObqk/O/f1o06t+oCrOmtNxwMUhz8JdpECeqbYOgAQ2jy5gp7Hr6O
         3PqIjSiNitpjrsEcqDGrSVH8t0wdvKvRcGgmyxphAZNlP9DNLIPEBEufS16lR/ofBYn0
         bS/BcJe1TKWIIK3oGwUw6Cx4T7SAnuHC8/by/7LLsdwIDWhTjWnu2vNvz/zOmNB7Y+8r
         hztwvwjh+3QH8G8ZpBcT4xKqj4cUVY7SRvOaq1XO9m9RN49IRWnUQGaVZAvzHymf0Dam
         /ZPQ==
X-Gm-Message-State: ABy/qLYPcJlh3krMMR2BeY1lbghRSP0ootuv540DbH0YHJC8/uUqUlLN
        TyjodZyfpA3U6YMivvtqW6nwCWBrS8SW/zelZy5DCCDNYaGKsDTdLmhhix+sOuva9jXK2x4O3Ce
        fGnyrYqSznbSH3Ir33nd3kj+n36c4UG/MUfhhKzBgUQ==
X-Received: by 2002:a05:6102:356d:b0:443:6a86:7cdb with SMTP id bh13-20020a056102356d00b004436a867cdbmr2336840vsb.26.1689335475691;
        Fri, 14 Jul 2023 04:51:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjAug34qhiq9imIKX0hj5b4gr40mdR/NGOFzRruEDaaBApIulRCMsngeXKHA4c6mKq6RlNDiK1p89T/CJQsZ8=
X-Received: by 2002:a05:6102:356d:b0:443:6a86:7cdb with SMTP id
 bh13-20020a056102356d00b004436a867cdbmr2336824vsb.26.1689335475401; Fri, 14
 Jul 2023 04:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <202307132107.2ce4ea2f-oliver.sang@intel.com> <20230713150923.GA28246@lst.de>
 <ZLAZn_SBmoIFG5F5@yuki>
In-Reply-To: <ZLAZn_SBmoIFG5F5@yuki>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Fri, 14 Jul 2023 13:50:58 +0200
Message-ID: <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
Subject: Re: [LTP] [linus:master] [iomap] 219580eea1: ltp.writev07.fail
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Chao Yu <chao@kernel.org>, oe-lkp@lists.linux.dev,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ltp@lists.linux.it, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 5:38=E2=80=AFPM Cyril Hrubis <chrubis@suse.cz> wrot=
e:
>
> Hi!
> > I can't reproduce this on current mainline.  Is this a robust failure
> > or flapping test?  Especiall as the FAIL conditions look rather
> > unrelated.

It's consistently reproducible for me on xfs with HEAD at:
eb26cbb1a754 ("Merge tag 'platform-drivers-x86-v6.5-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")

>
> Actually the test is spot on, the difference is that previously the
> error was returned form the iomap_file_buffered_write() only if we
> failed with the first buffer from the iov, now we always return the
> error and we do not advance the offset.
>
> The change that broke it:
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f4..550525a525c4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -864,16 +864,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struc=
t iov_iter *i,
>                 .len            =3D iov_iter_count(i),
>                 .flags          =3D IOMAP_WRITE,
>         };
> -       int ret;
> +       ssize_t ret;
>
>         if (iocb->ki_flags & IOCB_NOWAIT)
>                 iter.flags |=3D IOMAP_NOWAIT;
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
>                 iter.processed =3D iomap_write_iter(&iter, i);
> -       if (iter.pos =3D=3D iocb->ki_pos)
> +
> +       if (unlikely(ret < 0))
>                 return ret;
> -       return iter.pos - iocb->ki_pos;
> +       ret =3D iter.pos - iocb->ki_pos;
> +       iocb->ki_pos +=3D ret;
> +       return ret;
>  }
>
> I suppose that we shoudl fix is with something as:
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index adb92cdb24b0..bfb39f7bc303 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -872,11 +872,12 @@ iomap_file_buffered_write(struct kiocb *iocb, struc=
t iov_iter *i,
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
>                 iter.processed =3D iomap_write_iter(&iter, i);
>
> +       iocb->ki_pos +=3D iter.pos - iocb->ki_pos;
> +
>         if (unlikely(ret < 0))
>                 return ret;
> -       ret =3D iter.pos - iocb->ki_pos;
> -       iocb->ki_pos +=3D ret;
> -       return ret;
> +
> +       return iter.pos - iocb->ki_pos;

Replacing "ret" with "iter.pos - iocb->ki_pos" here doesn't look
equivalent to original,
because you already updated "iocb->ki_pos" few lines above.

Wouldn't it be enough to bring the old condition back?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b0..7cc9f7274883 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -872,7 +872,7 @@ iomap_file_buffered_write(struct kiocb *iocb,
struct iov_iter *i,
        while ((ret =3D iomap_iter(&iter, ops)) > 0)
                iter.processed =3D iomap_write_iter(&iter, i);

-       if (unlikely(ret < 0))
+       if (unlikely(iter.pos =3D=3D iocb->ki_pos))
                return ret;
        ret =3D iter.pos - iocb->ki_pos;
        iocb->ki_pos +=3D ret;

(with hunk above applied)
# ./writev07
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
writev07.c:50: TINFO: starting test with initial file offset: 0
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 64 as expected
writev07.c:50: TINFO: starting test with initial file offset: 65
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 129 as expected
writev07.c:50: TINFO: starting test with initial file offset: 4096
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 4160 as expected
writev07.c:50: TINFO: starting test with initial file offset: 4097
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 4161 as expected




>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

