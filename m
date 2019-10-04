Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6716CC5D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 00:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfJDW1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 18:27:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbfJDW1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so4523087pgv.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGtC9Y61I0fWewzKpxnAs5yLawr9FrkTbXzFkx6uKAk=;
        b=YeeGuXR/EbMstIHwMR+WBpofOCJlBn7xcT75NgBfyAZoiHg/V1PWHpO2epGkRD81Ai
         4RW+gTAEC4WD2yQ2SDrd5K9D7fdDNSPo3UNYUZZ8Zf+ibkFAmTJbDVSYEarDpJ5oPg1j
         dg3dC2LmBlg/HcrMgqb9PfzfTOzDXYHOa+/PYROjQTT8qZENzhrzuulgnZ3jTVdd9CoS
         6vHXpukys6F6ZvGyvO/MC52uvNRRW1RrRmLnirND7BrQ4tM7+hSt8ILrukDjy2Zkorp5
         a2EePtRfrlsKmCyDjJa9T4B+oNHxvnazyX654xQc9H1YU9WC6Z9K9EsF5+8bMHzSZibS
         tMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGtC9Y61I0fWewzKpxnAs5yLawr9FrkTbXzFkx6uKAk=;
        b=LzmjQH5856F+/90VxoIdn76F55B8iF8INYVEH+X2RUjBFMjExLqEHaaVgPE0PWyJSv
         zwwAUWtJZ67T3vDyHWIsN0sA6iCR53+1SaUoGp0cFiW/ed21P//Hhp554beIHQHbP6/E
         tbLha9cjfQbgiAR6zaRY7vSEvJnrGzwM2UCdHXqOlFdQQt+PYWdluuvt6nmM9go8x4cl
         kJcjxBATe0huIMmQE6pi9HiKYVYtnSCzlzkQDnRGv1HafO8s3AGw3WV+X5YFUrdQlZ+c
         E7B43C7Gc11+hBdc1iFVFz3hdSsILViuVs0u9YiXTHhU7Q8OBKPKf5qlDabUqgzpo57y
         gPdw==
X-Gm-Message-State: APjAAAWMY5Yo+0rwv+e2Ikm81F+qgy5JruIc7EwPXCDQ+cXPahetv0sr
        Vl2zKQhLF8AGVheDFGLskfJk3w==
X-Google-Smtp-Source: APXvYqz9/Um6buAfhCtRCPjLYgne6gcH8Y83qWem0TWomrvMdMPDQueWyrF35KAweIvctX7qICTVOw==
X-Received: by 2002:a65:638a:: with SMTP id h10mr8380897pgv.106.1570228039982;
        Fri, 04 Oct 2019 15:27:19 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id w7sm5066788pjn.1.2019.10.04.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 15:27:19 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:27:14 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20191004222714.GA107737@google.com>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
> On 10/4/19 3:42 PM, Linus Torvalds wrote:
> > On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > 
> > > This question is primarily directed at Shuah and Linus....
> > > 
> > > What's the current status of the kunit series now that Brendan has
> > > moved it out of the top-level kunit directory as Linus has requested?
> > 
> 
> The move happened smack in the middle of merge window and landed in
> linux-next towards the end of the merge window.
> 
> > We seemed to decide to just wait for 5.5, but there is nothing that
> > looks to block that. And I encouraged Shuah to find more kunit cases
> > for when it _does_ get merged.
> > 
> 
> Right. I communicated that to Brendan that we could work on adding more
> kunit based tests which would help get more mileage on the kunit.
> 
> > So if the kunit branch is stable, and people want to start using it
> > for their unit tests, then I think that would be a good idea, and then
> > during the 5.5 merge window we'll not just get the infrastructure,
> > we'll get a few more users too and not just examples.

I was planning on holding off on accepting more tests/changes until
KUnit is in torvalds/master. As much as I would like to go around
promoting it, I don't really want to promote too much complexity in a
non-upstream branch before getting it upstream because I don't want to
risk adding something that might cause it to get rejected again.

To be clear, I can understand from your perspective why getting more
tests/usage before accepting it is a good thing. The more people that
play around with it, the more likely that someone will find an issue
with it, and more likely that what is accepted into torvalds/master is
of high quality.

However, if I encourage arbitrary tests/improvements into my KUnit
branch, it further diverges away from torvalds/master, and is more
likely that there will be a merge conflict or issue that is not related
to the core KUnit changes that will cause the whole thing to be
rejected again in v5.5.

I don't know. I guess we could maybe address that situation by splitting
up the pull request into features and tests when we go to send it in,
but that seems to invite a lot of unnecessary complexity. I actually
already had some other tests/changes ready to send for review, but was
holding off until the initial set of patches mad it in.

Looking forward to hearing other people's thoughts.
