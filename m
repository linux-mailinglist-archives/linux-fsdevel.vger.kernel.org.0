Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3D8ADBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 06:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHMEbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 00:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfHMEbl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:31:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FF320644;
        Tue, 13 Aug 2019 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565670700;
        bh=bXySyH7oG8Qg7BF2tUIzY88o3nkMldgjGwGFcu7lqBI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cn3hL1Bsuw/xu0q8nUGW5OVqNSM02gmqOxEj7OYVccBR3pVdlHQHfyV+9j4VK5VQ9
         bBjRpi5awUcmcj/bU/NSzkg2lan5bKfaGdNGIkUpT77VE6EbkoCuI/ScUG0KINzgI5
         ShJHcDr5aLfptCDpi5hT68kjow7hDCVTkDHNnS8o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-13-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-13-brendanhiggins@google.com>
Subject: Re: [PATCH v12 12/18] kunit: test: add tests for KUnit managed resources
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
        wfg@linux.intel.com, Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 21:31:39 -0700
Message-Id: <20190813043140.67FF320644@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:15)
> +
> +static int kunit_resource_test_init(struct kunit *test)
> +{
> +       struct kunit_test_resource_context *ctx =3D
> +                       kzalloc(sizeof(*ctx), GFP_KERNEL);
> +
> +       if (!ctx)
> +               return -ENOMEM;

Should this use the test assertion logic to make sure that it's not
failing allocations during init? BTW, maybe kunit allocation APIs should
fail the test if they fail to allocate in general. Unless we're unit
testing failure to allocate problems.

> +
> +       test->priv =3D ctx;
> +
> +       kunit_init_test(&ctx->test, "test_test_context");
> +
> +       return 0;
