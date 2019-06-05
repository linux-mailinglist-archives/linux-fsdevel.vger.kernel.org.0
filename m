Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A273354B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFEATn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 20:19:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33013 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFEATm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:19:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id v29so10193984ljv.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2019 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdmJ9l6dKN/M8KJKaReWlFRx3EElIyLoR59kmGQ0ajY=;
        b=mWp51IFY9ldz1n3pj1fKrjbn8ZSGPWgwyelkcW6/s7v+y0e0DR/V8GR1ZxM1BsBeAX
         mqVaa/tfXDd/6MEO1OGM22zX0t4jPSi2d71oCngZuhbWkZxio6+sFzeQvWqDrIYIpJuw
         nH2s7y3MrUSzM3dAVIORTn4j8f2hTE4FKXFXiB6vbyOyWM+8sm7qnuJAdZe0dYu2FmQB
         G/4Hd50+HcTF52V70z6ii5Z+BoWQp+0M49tLLSAs+EJ/ROKxeK9GHDSjTGCoNxZTB406
         eMV8PQsiA3EH2MFRRpS50GYwQWxdJ7xN9x1Gd1qekPsZCFSmXsLb0mvz92xMWF6zHTLn
         it2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdmJ9l6dKN/M8KJKaReWlFRx3EElIyLoR59kmGQ0ajY=;
        b=KjbpBqe1TRqDREnzDXv1MYj7OS6FhzKPe7nBUUruFx9cmZwPQtUZhogyYEzGsogEby
         ob1glmJ8sIlCu1aS21w8lX4NdvWbFwGZTUFg4+sjDOXdxBW+y96V3AFan8c8A3p5Bmow
         oQD5scbRdGQXT1JyOt4hr+q8OHAs8zrPHZrBL0Y2953k4qOGr8xN+yJC9oNP8vS0Z9Te
         4VQGmitxwy9+5MJQR+QN+/2JRU8SxyRQSwKJxQto8Iv0S43a/nd1E3L5j4OX3PF6NqMb
         9MjOtkNwTKGTi1rWseqt1MukmUQEwYcyGr/vmnR9R5ajxqA5rjkKGFN9/pz+Hptv6fEA
         v7qw==
X-Gm-Message-State: APjAAAXEy/SbGv18asfp2mVgS9ChaTTH92/V9ww7W3CKkdUSO+BbMw3z
        q1Xs/MoEsg5sEA8MZ6x+SS1bcQN6ngCzwDFpTW92PQ==
X-Google-Smtp-Source: APXvYqz12ZqA7QhRnSs7NCGRounbiJim0N2d6mvCnGBaDXvxAiRpIwE1RpZWUzCT4YdYhAmjp6wliW9IQj3YJNSuaRI=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr3500ljk.120.1559693980056;
 Tue, 04 Jun 2019 17:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-4-brendanhiggins@google.com> <20190517174300.7949F20848@mail.kernel.org>
In-Reply-To: <20190517174300.7949F20848@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Jun 2019 17:19:28 -0700
Message-ID: <CAFd5g45WrARi7eXsVKyq2eJH5j+wSrCCaHHSHrMptG7+MnNiTg@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] kunit: test: add string_stream a std::stream
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

On Fri, May 17, 2019 at 10:43 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:16:56)
> > A number of test features need to do pretty complicated string printing
> > where it may not be possible to rely on a single preallocated string
> > with parameters.
> >
> > So provide a library for constructing the string as you go similar to
> > C++'s std::string.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Is there any reason why we can't use the seqfile API for this? These
> both share a similar goal, formatting strings into a buffer to be read
> later. Maybe some new APIs would be needed to extract the buffer
> differently, but I hope we could share the code.

I can see why you are asking. It seems as though they are trying to do
*similar* things, and it seems possible that we might be able to
extract some common functionality out of seq_file that could replace
this; however, it looks like it would be require a significant
refactoring of seq_file to separate out the file system specific bits
from the more general stringbuilder functionality.

In my opinion, a refactoring like this makes no sense in this
patchset; it probably belongs in its own patchset (preferably as a
follow on). I also am not sure if the FS people would appreciate
indirection that serves them no benefit, but I can ask if you like.

> If it can't be used, can you please add the reasoning to the commit text
> here?

Will do.

Thanks!
