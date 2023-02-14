Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B468696434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjBNNGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBNNGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:06:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A1274A0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:06:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gn39so1554430ejc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UO1S8iW9/QAKVzEJhMRyzNECLihlHvjUObjxxMYI9O0=;
        b=EHFPpiUbwjhpMXxUIF7LhqG6rIpi+UqGSBGeWDQmMdq/H/4cSj5dy+pWLbjn+5Q2PE
         3Uu+8cgbrs8l1cedRkQIXA0oImCzK2Kua9ZjbNyB6hSMdCLJ6XuLOzwN/NXwmPLQ9Z/N
         VnyvAkJeiLtHgPm9ccQpnGJhDezr7ST2P6LuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO1S8iW9/QAKVzEJhMRyzNECLihlHvjUObjxxMYI9O0=;
        b=vjUqL4EQftOzuMV9x52aCsnJlpJKFQG7D9m81MdURqnTS48dzTzYSivjU0w0SjOuCf
         2q/FyUj6YSwqbD+KGOgAqBm2bsZIUlqd0EaiuA1HaM7SmK0xKphWKmqeKOD0hVSovXcN
         R0SYL7Zsy6Ex5WdeN1dheVl3tqWF/xTxmS/8kWfjT+9bO2y2uKueaMPVG+u3X+etFyTe
         RNJ3UIqzS5olUHk83lw8Yn99bBE+EkQp7etOZFtu/kCuyCvo0WlJlDLEiztET8RJV171
         yJuYjE/qZnrJLdP6jmq9AV+sqERs2IamOGRP2QEJK80R9zeY/yiMf0IEIVF0lJee+Dw0
         XW1g==
X-Gm-Message-State: AO0yUKX/uCHUGnEpqKlj6gn1E67NkaeFRhIHBLKYBzW0Ru5pSc0mEGWf
        3+zd0RVhJ39KC2Gr0KcV4+3ckLGBKTpjXTPxvDSGyA==
X-Google-Smtp-Source: AK7set+I/XMXzZKvwt68Wb9MWG1DTRZ//RvsjWH1cHJPqXhfYhA6+T3VMQPi9934Peu7job2YIQNxIo0BpMeuOgtl80=
X-Received: by 2002:a17:907:1ddc:b0:878:790b:b7fd with SMTP id
 og28-20020a1709071ddc00b00878790bb7fdmr1259822ejc.14.1676379960856; Tue, 14
 Feb 2023 05:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20230214083710.2547248-1-dhowells@redhat.com> <20230214083710.2547248-6-dhowells@redhat.com>
In-Reply-To: <20230214083710.2547248-6-dhowells@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Feb 2023 14:05:49 +0100
Message-ID: <CAJfpegvjTL7X6KRZnFR6=reme63GiaACBZQ4RicvJ6B+-nLVKw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] shmem, overlayfs, coda, tty, proc, kernfs, random:
 Fix splice-read
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
        Hugh Dickins <hughd@google.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Feb 2023 at 09:38, David Howells <dhowells@redhat.com> wrote:
>
> The new filemap_splice_read() has an implicit expectation via
> filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
> fully populate the pagecache of the file it is reading from[1], potentially
> leading to a jump to NULL if this doesn't exist.
>
> A filesystem or driver shouldn't suffer from this if:
>
>   - It doesn't set ->splice_read()
>   - It implements ->read_folio()
>   - It implements its own ->splice_read()
>
> Note that some filesystems set generic_file_splice_read() and
> generic_file_read_iter() but don't set ->read_folio().  g_f_read_iter()
> will fall back to filemap_read_iter() which looks like it should suffer
> from the same issue.
>
> Certain drivers, can just use direct_splice_read() rather than
> generic_file_splice_read() as that creates an output buffer and then just
> calls their ->read_iter() function:
>
>   - random & urandom
>   - tty
>   - kernfs
>   - proc
>   - proc_namespace
>
> Stacked filesystems just need to pass the operation down a layer:
>
>   - coda
>   - overlayfs
>
> And finally, there's shmem (used in tmpfs, ramfs, rootfs).  This needs its
> own splice-read implementation, based on filemap_splice_read(), but able to
> paste in zero_page when there's a page missing.
>
> Fixes: d9722a475711 ("splice: Do splice read from a buffered file without using ITER_PIPE")

The fixed commit is not upstream.  In fact it seems to be on the same
branch as this one. Please reorder the patches so that a Fixes tag is
not needed.

Thanks,
Miklos
