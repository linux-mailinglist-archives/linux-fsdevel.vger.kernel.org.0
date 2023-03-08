Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A953D6B1557
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCHWj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 17:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCHWjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:39:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC36B5A95
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 14:39:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so71747003edb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678315160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHOh6/Mv9MfzuVql9i7aCQo+w921G9eVyn2ZtvpMeA=;
        b=fdEPzPBCKffdLvVkxSjsN1aY4KdyDTNq+3n7GcoHBBYwPeVsX3w1PYMKXlwC6aKStC
         CSyIyeB+SRfqCvivdFLJKaccR/snvuGcdRWH06jHeWuFXWswI8bqzJONTczGsJLkxSyr
         4QTYW54ZHvRgps6yD8Ftf+1cnTIwEtsxiI1zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgHOh6/Mv9MfzuVql9i7aCQo+w921G9eVyn2ZtvpMeA=;
        b=SyTsxz0tSvTrEnmpY54aqtr4Yhl40iv/WNS7EbfsghxlxlHS9sYPH6uAsEyMZyfl4Z
         tBDwd7yx1uKEHDui1G4MlptyO9Dc4V0FZdkZJx5wp6sNSbp5RLoLwc/BjszTvpSazFJD
         h/C87GPRrP7Utn/SOG9Lz82mTS2+1p2cZcBdkQeS4cgf/WYKfWDyRI1/+c7TnAhJD5sc
         DjyRhyRtRElaQz8GaRb1BRni7wSUGaQYHSyqFWWKJlY7+aKJGoYu+oaVuQdG8Bu5YT8g
         wiqN9pH8bC3UvAo7NE97qcAsR6K7Q6Xp6c3W8LcKgvgT+cLLlHf4b4OQLtbQrBbkYSJn
         FSfw==
X-Gm-Message-State: AO0yUKUrgqtOy8bd7BT3qjaW93FCPAbMNpIRZKVijUXWYM3zJlbz4k08
        JNb+ZZyLB8hIZLutdfhOetwVFisvEqKkup92ERgRLg==
X-Google-Smtp-Source: AK7set+yAbk9HULr2YrCI60Ke4ZBalGEHp4PZEx8sj2yt4cFtSc3TSb35okZ8wr/vdEZb3cLWJqdig==
X-Received: by 2002:a17:907:9719:b0:895:ef96:9d9b with SMTP id jg25-20020a170907971900b00895ef969d9bmr22164322ejc.30.1678315159830;
        Wed, 08 Mar 2023 14:39:19 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id qn23-20020a170907211700b008d173604d72sm8138366ejb.174.2023.03.08.14.39.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:39:18 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id g3so71993168eda.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 14:39:18 -0800 (PST)
X-Received: by 2002:a50:8750:0:b0:4c2:ed2:1196 with SMTP id
 16-20020a508750000000b004c20ed21196mr10973452edv.5.1678315158081; Wed, 08 Mar
 2023 14:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
In-Reply-To: <20230308165251.2078898-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Mar 2023 14:39:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
Message-ID: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 8, 2023 at 8:53=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> The new filemap_splice_read() has an implicit expectation via
> filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
> fully populate the pagecache of the file it is reading from[1], potential=
ly
> leading to a jump to NULL if this doesn't exist.  shmem, however, (and by
> extension, tmpfs, ramfs and rootfs), doesn't have ->read_folio(),

This patch is the only one in your series that I went "Ugh, that's
really ugly" for.

Do we really want to basically duplicate all of filemap_splice_read()?

I get the feeling that the zeropage case just isn't so important that
we'd need to duplicate filemap_splice_read() just for that, and I
think that the code should either

 (a) just make a silly "read_folio()" for shmfs that just clears the page.

     Ugly but maybe simple and not horrid?

or

 (b) teach filemap_splice_read() that a NULL 'read_folio' function
means "use the zero page"

     That might not be splice() itself, but maybe in
filemap_get_pages() or something.

or

 (c) go even further, and teach read_folio() in general about file
holes, and allow *any* filesystem to read zeroes that way in general
without creating a folio for it.

in a perfect world, if done well I think shmem_file_read_iter() should
go away, and it could use generic_file_read_iter too.

I dunno. Maybe shm really is *so* special that this is the right way
to do things, but I did react quite negatively to this patch. So not a
complete NAK, but definitely a "do we _really_ have to do this?"

                       Linus
