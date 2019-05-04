Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6813956
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEDKmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 06:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEDKmz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 06:42:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EC9206DF;
        Sat,  4 May 2019 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556966574;
        bh=2wZMR8kL7s1krXCBVQ2gHWVCoJe2nAbegB0hEA5FL6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2qAYqK93MmeEO5EtmmbYxkKej3oQNG4Xe6XPJD6vrQPt38T1svHdBKrBvdMiYWgD
         AZ7qWDqABTJ6olUjiTR2iLAVWnkx5H2eC/KCt6WPfdYa51NsGiNAAeStPcWNLEDQJV
         lDwxJTqazCCtkTaH5ybwPNJUh0FxQBUrP7ZHlU+A=
Date:   Sat, 4 May 2019 12:42:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
Message-ID: <20190504104251.GB1478@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
 <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
 <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 04:14:49PM -0700, Brendan Higgins wrote:
> In any case, it sounds like you and Greg are in agreement on the core
> libraries generating the output in TAP13, so I won't argue that point
> further.

Great!

> ## Analysis of using TAP13
> 
> One of my earlier concerns was that TAP13 is a bit over constrained
> for what I would like to output from the KUnit core. It only allows
> data to be output as either:
>  - test number
>  - ok/not ok with single line description
>  - directive
>  - diagnostics
>  - YAML block
> 
> The test number must become before a set of ok/not ok lines, and does
> not contain any additional information. One annoying thing about this
> is it doesn't provide any kind of nesting or grouping.

It should handle nesting just fine, I think we do that already today.

> There is one ok/not ok line per test and it may have a short
> description of the test immediately after 'ok' or 'not ok'; this is
> problematic because it wants the first thing you say about a test to
> be after you know whether it passes or not.

Take a look at the output of our current tests, I think you might find
it to be a bit more flexible than you think.

Also, this isn't our standard, we picked it because we needed a standard
that the tools of today already understand.  It might have issues and
other problems, but we are not in the business of writing test output
parsing tools, and we don't want to force everyone out there to write
custom parsers.  We want them to be able to use the tools they already
have so they can test the kernel, and to do so as easily as possible.

thanks,

greg k-h
