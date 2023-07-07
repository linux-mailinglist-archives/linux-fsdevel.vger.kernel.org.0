Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FEF74B086
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGGMQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 08:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGMQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8E1BEE
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688732151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhpDqg8pI0zX12ElS90vQT8QQV6E3FjtxWt9F4QgwcU=;
        b=PSEl7yWW0g9KegAQ8cdyMvZHxxVFckOETksGXh1P2F54DjEhb5Vme0/ZTVhEQJJ/C5T6+W
        qoo/q9rrgU1DV3xDwX1blSHMANGKpcAuzHWww91PI8bpba0k7nw4pWLeV92KeIKn26Rnyx
        rvP6TchdxcOEbrsT8bR6ZxY6bj/XS6M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-d0v8xx1pPjaqagMaQI2OoQ-1; Fri, 07 Jul 2023 08:15:48 -0400
X-MC-Unique: d0v8xx1pPjaqagMaQI2OoQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-57a3620f8c0so19041337b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 05:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732148; x=1691324148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhpDqg8pI0zX12ElS90vQT8QQV6E3FjtxWt9F4QgwcU=;
        b=SKEWT/DFDuL3YW5MyeGljfGy6lsuV/Pn+PKXEBgrXFa595bKGn6sqPKUEeeWNXG80i
         2swJ7DAnt5h79ZCyew3XPJqpEyOMIO8OE1+EgAIMMQgU35ayYUoimrgd2qFC1pBNDedk
         JLtj1xFoDss9WnrFABIgNXTiC2PnnFYVpHV1ZfGwR39b2Sb/qAb0OfTJbQNEpiu9+6bE
         0gnjgxAUT1wFHyVtEIpLUh8M6I7W82ZcikAeokcMqOHxkCW7hKgPMPzSAImyzCuaSkUF
         V6X3hmHcrONGbqHGuZmPrcySJA/2/N3STUsB0osU+VwC4/qKk5X1txI+z+vTRc3bxOO0
         opvA==
X-Gm-Message-State: ABy/qLZD1kVr73yJ5zaXEest/1k0kTljw+cKCooQ2O66ElKc8P1VrxRh
        AIJKQA8ohFSLLYAL6bS8HDPGVB7yu1tDzKne2dDxwmkAGIp4hiAwaa8JrFlr0o0Hlk0K0PWXV56
        EPvp03KBKsDgNHs++/upqQYJHWQ==
X-Received: by 2002:a0d:f543:0:b0:570:81f1:7b49 with SMTP id e64-20020a0df543000000b0057081f17b49mr4993715ywf.6.1688732148084;
        Fri, 07 Jul 2023 05:15:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGBjLT+ie9QBkdDcFC6xSFGukVNoSHS7y0OfnI702mFH10yhnLmSvv9I4IBTSn5ORv7zoj+ig==
X-Received: by 2002:a0d:f543:0:b0:570:81f1:7b49 with SMTP id e64-20020a0df543000000b0057081f17b49mr4993707ywf.6.1688732147833;
        Fri, 07 Jul 2023 05:15:47 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b00400c5f5e713sm1648278qtp.97.2023.07.07.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:15:47 -0700 (PDT)
Date:   Fri, 7 Jul 2023 08:18:28 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Josef Bacik <josef@toxicpanda.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZKgClE9AnmLZpXTM@bfoster>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 01:38:19PM -0400, Kent Overstreet wrote:
> On Thu, Jul 06, 2023 at 12:40:55PM -0400, Josef Bacik wrote:
...
> > I am really, really wanting you to succeed here Kent.  If the general consensus
> > is you need to have some idiot review fs/bcachefs I will happily carve out some
> > time and dig in.
> 
> That would be much appreciated - I'll owe you some beers next time I see
> you. But before jumping in, let's see if we can get people who have
> already worked with the code to say something.
> 

I've been poking at bcachefs for several months or so now. I'm happy to
chime in on my practical experience thus far, though I'm still not
totally clear what folks are looking for on this front, in terms of
actual review. I agree with Josef's sentiment that a thorough code
review of the entire fs is not really practical. I've not done that and
don't plan to in the short term.

As it is, I have been able to dig into various areas of the code, learn
some of the basic principles, diagnose/fix issues and get some of those
fixes merged without too much trouble. IMO, the code is fairly well
organized at a high level, reasonably well documented and
debuggable/supportable. That isn't to say some of those things couldn't
be improved (and I expect they will be), but these are more time and
resource constraints than anything and so I don't see any major red
flags in that regard. Some of my bigger personal gripes would be a lot
of macro code generation stuff makes it a bit harder (but not
impossible) for a novice to come up to speed, and similarly a bit more
introductory/feature level documentation would be useful to help
navigate areas of code without having to rely on Kent as much. The
documentation that is available is still pretty good for gaining a high
level understanding of the fs data structures, though I agree that more
content on things like on-disk format would be really nice.

Functionality wise I think it's inevitable that there will be some
growing pains as user and developer base grows. For that reason I think
having some kind of experimental status for a period of time is probably
the right approach. Most of the issues I've dug into personally have
been corner case type things, but experience shows that these are the
sorts of things that eventually arise with more users. We've also
briefly discussed things like whether bcachefs could take more advantage
of some of the test coverage that btrfs already has in fstests, since
the feature sets should largely overlap. That is TBD, but is something
else that might be a good step towards further proving out reliability.

Related to that, something I'm not sure I've seen described anywhere is
the functional/production status of the filesystem itself (not
necessarily the development status of the various features). For
example, is the filesystem used in production at any level? If so, what
kinds of deployments, workloads and use cases do you know about? How
long have they been in use, etc.? I realize we may not have knowledge or
permission to share details, but any general info about usage in the
wild would be interesting.

The development process is fairly ad hoc, so I suspect that is something
that would have to evolve if this lands upstream. Kent, did you have
thoughts/plans around that? I don't mind contributing reviews where I
can, but that means patches would be posted somewhere for feedback, etc.
I suppose that has potential to slow things down, but also gives people
a chance to see what's happening, review or ask questions, etc., which
is another good way to learn or simply keep up with things.

All in all I pretty much agree with Josef wrt to the merge request. ISTM
the main issues right now are the external dependencies and
development/community situation (i.e. bus factor). As above, I plan to
continue contributions at least in terms of fixes and whatnot so long as
$employer continues to allow me to dedicate at least some time to it and
the community is functional ;), but it's not clear to me if that is
sufficient to address the concerns here. WRT the dependencies, I agree
it makes sense to be deliberate and for anything that is contentious,
either just drop it or lift it into bcachefs for now to avoid the need
to debate on these various fronts in the first place (and simplify the
pull request as much as possible).

With those issues addressed, perhaps it would be helpful if other
interested fs maintainers/devs could chime in with any thoughts on what
they'd want to see in order to ack (but not necessarily "review") a new
filesystem pull request..? I don't have the context of the off list
thread, but from this thread ISTM that perhaps Josef and Darrick are
close to being "soft" acks provided the external dependencies are worked
out. Christoph sent a nak based on maintainer status. Kent, you can add
me as a reviewer if 1. you think that will help and 2. if you plan to
commit to some sort of more formalized development process that will
facilitate review..? I don't know if that means an ack from Christoph,
but perhaps it addresses the nak. I don't really expect anybody to
review the entire codebase, but obviously it's available for anybody who
might want to dig into certain areas in more detail..

Brian

