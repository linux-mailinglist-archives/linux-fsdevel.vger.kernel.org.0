Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700376368BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiKWS1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiKWS06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:26:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9DB682A2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:26:56 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h7so12104706qvs.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/jG5QaYqTRKNFcJtqKGHj4SfbKFSJH0wslCbBk+0rc=;
        b=WtEZfFy9CjWS25vRvH8BUGmfQ5TppWVPJY29aYmVjK2t/Gqd80v173byCSBDvOcqZ5
         GS3iagkeA7ssVh/ddKEkJKHeWkCPYto/COdNwh44sfuBXjAau3yrVZ6HAJiXAaELgCMQ
         DakZoiuRSNhC/sDbjfyndFBio5BbqUEFc1b48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/jG5QaYqTRKNFcJtqKGHj4SfbKFSJH0wslCbBk+0rc=;
        b=hi3pWe6Np14f5v0PGz0NhBXA2AJvcg9rnoTvIrRAGvLsh8sWTwwkelH63Wk5+P4cKL
         wIPYnFLs2Ma8xmHKffgIDpCXBo9NyaKgq58UDsKapRKBSHz0wOVo5EJY8SROwIR2c2ZJ
         GhVj2FcJ3nxTnhiZrPxMlGd5rWnSagqPjgyhqVW1RJi3UtspgvYq9sU1im5WKNIiaAZb
         x53wZHi4yxW240Ycon7/7WU+iVHzqMuCgvWTwGwLyTseFEkF+8WXsdFCZYcA/f4ABh7p
         Nnjjgf0gJEJl8Ta50yAPsMb57sRupfSqPx6VikaVH8sEj3bbw3S4qHDKSO279cOr1CW0
         FAaw==
X-Gm-Message-State: ANoB5pn1zzjUYJlGxhx+YV08GhvCAgu46RXx/ZynH04zi0IOv7sRsXra
        zLRLIWHPiBwKw6PPFkkn95pyzZ2a/WcESQ==
X-Google-Smtp-Source: AA0mqf6jddwVI7oQ4X5k/pdU2kC/l5gwR4NlM2IMBCFbROHsI8d5EjGDZiXY7pGAzea6IsHIQfQxEg==
X-Received: by 2002:a05:6214:3b85:b0:4bc:18ec:59fe with SMTP id nf5-20020a0562143b8500b004bc18ec59femr27253288qvb.43.1669228015682;
        Wed, 23 Nov 2022 10:26:55 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a440e00b006a6ebde4799sm12926482qkp.90.2022.11.23.10.26.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 10:26:54 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h24so11772221qta.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:26:52 -0800 (PST)
X-Received: by 2002:ac8:41cd:0:b0:3a5:1ba7:717d with SMTP id
 o13-20020ac841cd000000b003a51ba7717dmr9188380qtm.678.1669228012067; Wed, 23
 Nov 2022 10:26:52 -0800 (PST)
MIME-Version: 1.0
References: <1459152.1669208550@warthog.procyon.org.uk>
In-Reply-To: <1459152.1669208550@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 10:26:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghJtq-952e_8jd=vtV68y_HsDJ8=e0=C3-AsU2WL-8YA@mail.gmail.com>
Message-ID: <CAHk-=wghJtq-952e_8jd=vtV68y_HsDJ8=e0=C3-AsU2WL-8YA@mail.gmail.com>
Subject: Re: [PATCH v3] mm, netfs, fscache: Stop read optimisation when folio
 removed from pagecache
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 5:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Is the attached patch too heavy to be applied this late in the merge cycle?
> Or would you prefer it to wait for the merge window?

This patch is much too much for this point in the release.

But I also think it's strange in another way, with that odd placement of

        mapping_clear_release_always(inode->i_mapping);

at inode eviction time. That just feels very random.

Similarly, that change to shrink_folio_list() looks strange, with the
nasty folio_needs_release() helper. It seems entirely pointless, with
the use then being

                if (folio_needs_release(folio)) {
                        if (!filemap_release_folio(folio, sc->gfp_mask))
                                goto activate_locked;

when everybody else is just using filemap_release_folio() and checking
its return value. I like how you changed other cases of

        if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
                return 0;

to just use "!filemap_release_folio()" directly, and that felt like a
cleanup, but the shrink_folio_list() changes look like a step
backwards.

And the change to mm/filemap.c is completely unacceptable in all
forms, and this added test

+       if ((!mapping || !mapping_release_always(mapping)) &&
+           !folio_test_private(folio) &&
+           !folio_test_private_2(folio))
+               return true;

will not be accepted even during the merge window. That code makes no
sense what-so-ever, and is in no way acceptable.

That code makes no sense what-so-ever. Why isn't it using
"folio_has_private()"? Why is it using it's own illegible version of
that that doesn't match any other case? Why is this done as an
open-coded - and *badly* so - version of !folio_needs_release() that
you for some reason made private to mm/vmscan.c?

So no, this patch is too ugly to apply as-is *ever*, much less during
the late rc series.

                 Linus
