Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611A621162
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 02:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfEQAis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 20:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfEQAir (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 20:38:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0962F2082E;
        Fri, 17 May 2019 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558053527;
        bh=h7x4s8lT+SFQAKT2oROUOwG99nmbA/iuhNAdlGK/1zk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pwJefM32rVyc17BV4NKTMNz9bAtRXF3fs8QXDQmfCoQ8dGWwvrJtKIhWefJVALK8E
         uExHbjAOgbiFZVFaM8n4hSxNXniqu1kMlprj5ffN87QHOgHX7iyfmP5RLT5V0AIfD4
         Pob5g1PWM6wWtC9518tZ1d/0IihjJAgMh1BsvFf4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190514221711.248228-3-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-3-brendanhiggins@google.com>
Subject: Re: [PATCH v4 02/18] kunit: test: add test resource management API
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
Date:   Thu, 16 May 2019 17:38:46 -0700
Message-Id: <20190517003847.0962F2082E@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-05-14 15:16:55)
> diff --git a/kunit/test.c b/kunit/test.c
> index 86f65ba2bcf92..a15e6f8c41582 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
[..]
> +
> +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> +{
> +       struct kunit_kmalloc_params params;
> +       struct kunit_resource *res;
> +
> +       params.size =3D size;
> +       params.gfp =3D gfp;
> +
> +       res =3D kunit_alloc_resource(test,
> +                                  kunit_kmalloc_init,
> +                                  kunit_kmalloc_free,
> +                                  &params);
> +
> +       if (res)
> +               return res->allocation;
> +       else
> +               return NULL;

Can be written as

	if (res)
		return ....
	return=20

and some static analysis tools prefer this.

> +}
> +
> +void kunit_cleanup(struct kunit *test)
> +{
> +       struct kunit_resource *resource, *resource_safe;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&test->lock, flags);

Ah ok, test->lock is protecting everything now? Does it need to be a
spinlock, or can it be a mutex?

> +       list_for_each_entry_safe(resource,
> +                                resource_safe,
> +                                &test->resources,
> +                                node) {
> +               kunit_free_resource(test, resource);
> +       }
> +       spin_unlock_irqrestore(&test->lock, flags);
> +}
> +
