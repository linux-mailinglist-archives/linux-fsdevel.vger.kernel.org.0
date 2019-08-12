Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA158AAD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 00:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHLWzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 18:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfHLWzV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:55:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A67C206A2;
        Mon, 12 Aug 2019 22:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565650520;
        bh=bzSVxn1O+XeeWY+2gZI6RE/G7J9stvLsMgc7wXKMLBY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2fFWNBju/NoA9EEEg6SgrC0ymxSRFlWH+/sXXpWVTbVoBuKIvJiA7w1IyG/Q5cfgN
         gw3v0MRCJ48hdqHfIdIAFVkbP+9VeXqYGvbIjFkrUu6xwlZcEnR9KMfu3l/b+H0uED
         iKs6Gza2xwnDfKRu3oYIOckfg2RYjnmKmEyi2wfI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-4-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-4-brendanhiggins@google.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream like string builder
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 15:55:19 -0700
Message-Id: <20190812225520.5A67C206A2@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:06)
> +void string_stream_clear(struct string_stream *stream)
> +{
> +       struct string_stream_fragment *frag_container, *frag_container_sa=
fe;
> +
> +       spin_lock(&stream->lock);
> +       list_for_each_entry_safe(frag_container,
> +                                frag_container_safe,
> +                                &stream->fragments,
> +                                node) {
> +               list_del(&frag_container->node);

Shouldn't we free the allocation here? Otherwise, if some test is going
to add, add, clear, add, it's going to leak until the test is over?

> +       }
> +       stream->length =3D 0;
> +       spin_unlock(&stream->lock);
> +}
> +
