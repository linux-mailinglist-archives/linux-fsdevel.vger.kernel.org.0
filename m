Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EFD127DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfECGly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 02:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfECGlx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 02:41:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC3D2075E;
        Fri,  3 May 2019 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556865712;
        bh=qAxjj5uiF5zEnzRbrg8NBWm/r/MITYyDqVpA7K94d04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/xHj6l6GTULrzqty/QE9n+V3E7brgc1EE3YPacTpehUKVBEwYEB8Kjpj6eaNywET
         vOVTIu5pClz9D1ixUfyq2wi+fG23/JAt0fEXA4iWbz4fYGFM70dWGs3kIuIpiDPLE5
         z1ZErmGEyIuJkJ4kZlIVEyXnanSfyuAg225XdKNg=
Date:   Fri, 3 May 2019 08:41:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
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
Message-ID: <20190503064149.GB20723@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 04:45:29PM -0700, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 5/2/19 11:07 AM, Brendan Higgins wrote:
> > > On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> > >>> From: Felix Guo <felixguoxiuping@gmail.com>
> > >>>
> > >>> The ultimate goal is to create minimal isolated test binaries; in the
> > >>> meantime we are using UML to provide the infrastructure to run tests, so
> > >>> define an abstract way to configure and run tests that allow us to
> > >>> change the context in which tests are built without affecting the user.
> > >>> This also makes pretty and dynamic error reporting, and a lot of other
> > >>> nice features easier.
> > >>>
> > >>> kunit_config.py:
> > >>>   - parse .config and Kconfig files.
> > >>>
> > >>> kunit_kernel.py: provides helper functions to:
> > >>>   - configure the kernel using kunitconfig.
> > >>>   - build the kernel with the appropriate configuration.
> > >>>   - provide function to invoke the kernel and stream the output back.
> > >>>
> > >>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >>
> > >> Ah, here's probably my answer to my previous logging format question,
> > >> right?  What's the chance that these wrappers output stuff in a standard
> > >> format that test-framework-tools can already parse?  :)
> 
> To be clear, the test-framework-tools format we are talking about is
> TAP13[1], correct?

Yes.

> My understanding is that is what kselftest is being converted to use.

Yes, and I think it's almost done.  The core of kselftest provides
functions that all tests can use to log messages in the correct format.

The core of kunit should also log the messages in this format as well,
and not rely on the helper scripts as Frank points out, not everyone
will use/want them.  Might as well make it easy for everyone to always
do the right thing and not force it to always be added in later.

thanks,

greg k-h
