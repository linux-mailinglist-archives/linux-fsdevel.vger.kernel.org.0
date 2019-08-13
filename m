Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B187D8BF52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHMRHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 13:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHMRHO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:07:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89CA20679;
        Tue, 13 Aug 2019 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565716032;
        bh=fgW6Va1LDRwdq/a+4YEJkeWaGkuqaoxvU1J721UrWZU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=treWSrq2kr/VcJofxmrL4w25Mma1xe0c8v1GBc5/aXPXBX/Qh1u42KfGgRAMZ0E7B
         JnDwwQ837FHdqo8RQtK1lGQzBKI6OSJ9LmUHBI9Mkjtg2i718ItycmKZiAhZvxCmXX
         sM2LnPO88BoqSh26Dp8VQGdXD9L0EbFEm7nrZp44=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g44Es4emKyQSxUkqckGJ02_o3sAcDLwUCW8ZFGX14j5=xg@mail.gmail.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-13-brendanhiggins@google.com> <20190813043140.67FF320644@mail.kernel.org> <CAFd5g44Es4emKyQSxUkqckGJ02_o3sAcDLwUCW8ZFGX14j5=xg@mail.gmail.com>
Subject: Re: [PATCH v12 12/18] kunit: test: add tests for KUnit managed resources
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Avinash Kondareddy <akndr41@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 10:07:12 -0700
Message-Id: <20190813170712.C89CA20679@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-13 00:57:33)
> On Mon, Aug 12, 2019 at 9:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > BTW, maybe kunit allocation APIs should
> > fail the test if they fail to allocate in general. Unless we're unit
> > testing failure to allocate problems.
>=20
> Yeah, I thought about that. I wasn't sure how people would feel about
> it, and I thought it would be a pain to tease out all the issues
> arising from aborting in different contexts when someone might not
> expect it.
>=20
> I am thinking later we can have kunit_kmalloc_or_abort variants? And
> then we can punt this issue to a later time?
>=20

Sure. Sounds good.

