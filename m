Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874D08AE67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 07:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfHMFDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 01:03:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfHMFDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:03:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so3711232pfz.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cO9jrOGgF5wujsFXMHtoYNXvgUhydDYlF08f1pq39E=;
        b=IJDEFp+tZg956HdkEB/yKpoKHOFoi1PcVpOx5zPUJll5AJ5C8M+CFwUO+F8F8Q/rit
         8HcowooFg6ntqkIFuj6R4k+GwmJgIitCqOV2QvGuxn7m9MQGXg9qvC85ytvNf5bcYus+
         EprLmHUXh9bThNArfUe3XOKZVbo/EBN6VgqZBcT95WmmKJTlRd528A9f6TQgIETjut1/
         wI8daRdYTmSq6wYQl4NTMhJ/qVqO63tEGOCbSOifsskf9GK6VMybLklO81hLBeB9tly/
         80uCE+R8Iy4Fzfqk20iE8S9pCq3TNIClCmZ4T12ccP5rxSYxtRJSh6xSaDrQfj2wM6vG
         UTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cO9jrOGgF5wujsFXMHtoYNXvgUhydDYlF08f1pq39E=;
        b=Vq02kRmGPCYlB5ldicL7VHLF7zDrKB1nnuJ3Kx/HkM/yyE1pLjlafuYbMQZ4WDC1B7
         Zq4w447+Nkwcm+hRfof/UWII+me19RgLGC1J5uvTVM8DkZLXuYHSxNqoXj8e1lGTtz6P
         ntlZHwnxh5xFEoEfoXS3gAcorm8NTUoIudxk7A4ljloXpD/OmuhbINTFW3dn4H94RlIo
         FlifuVE6jZn12Xf+ymMidGrX9QK0kS3ZLklIGlx61Nzw0krAWsfiDFLBG7FJY2+dYDUG
         as1/KG1pdNwoKTYVVCJO+qkegIBf0v1h9VC+McZD8ff9AxEBlxTovRQRF14Rhb/6EZ0R
         purQ==
X-Gm-Message-State: APjAAAVYxQTA5XRFxK8gN1PU2e7s8JMsIW2LITQISybnNlOWBvN96rjv
        n4tQJmfnwzySVc6m87+G3vCp6AG/gp+rL4d5B94CoA==
X-Google-Smtp-Source: APXvYqxe3Yuc1/IPYBDWpkhdxK9MrqBlpBCfUzv/UyMf8npsBcj76TlFOcJ9beMy4gx9z+/oMn0KOERMMEUsJXLW4tU=
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr9786090pfr.113.1565672590442;
 Mon, 12 Aug 2019 22:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com> <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com> <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com> <20190813045623.F3D9520842@mail.kernel.org>
In-Reply-To: <20190813045623.F3D9520842@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:02:59 -0700
Message-ID: <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 17:41:05)
> > On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > > > devres_destroy) and use kunit_kfree here?
> > > >
> > >
> > > Yes, or drop the API entirely? Does anything need this functionality?
> >
> > Drop the kunit_resource API? I would strongly prefer not to.
>
> No. I mean this API, string_stream_clear(). Does anything use it?

Oh, right. No.

However, now that I added the kunit_resource_destroy, I thought it
might be good to free the string_stream after I use it in each call to
kunit_assert->format(...) in which case I will be using this logic.

So I think the right thing to do is to expose string_stream_destroy so
kunit_do_assert can clean up when it's done, and then demote
string_stream_clear to static. Sound good?
