Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCCA69EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfGOWEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 18:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfGOWEI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:04:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0030420665;
        Mon, 15 Jul 2019 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563228247;
        bh=lzmzGxC84ycn5YPcgrlTTZCsaQHNzr70lnAMErLcD6E=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=yjILvyTeOyRdWTjel54BWNGgZ1ntKYib3gQKxCNMZGijJY1OIFiN5Q/Cq5W/Sq65r
         OjyZGX9OeeT3oFA8a4sDcYrXowZlMFMynYaGOGbEAJsQkEWD3FqBmHRAOOmQwn1vSW
         sbrWnUD7cVteQcJnCcGYDIxrhTqiEX8IEogTyyrs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org> <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 03/18] kunit: test: add string_stream a std::stream like string builder
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
User-Agent: alot/0.8.1
Date:   Mon, 15 Jul 2019 15:04:06 -0700
Message-Id: <20190715220407.0030420665@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-15 14:11:50)
> On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > I also wonder if it would be better to just have a big slop buffer of a
> > 4K page or something so that we almost never have to allocate anything
> > with a string_stream and we can just rely on a reader consuming data
> > while writers are writing. That might work out better, but I don't quite
> > understand the use case for the string stream.
>=20
> That makes sense, but might that also waste memory since we will
> almost never need that much memory?

Why do we care? These are unit tests. Having allocations in here makes
things more complicated, whereas it would be simpler to have a pointer
and a spinlock operating on a chunk of memory that gets flushed out
periodically.

