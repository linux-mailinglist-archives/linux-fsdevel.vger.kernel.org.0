Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718035B4F8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIKO7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKO7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:59:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE02DC2;
        Sun, 11 Sep 2022 07:59:35 -0700 (PDT)
Received: from letrec.thunk.org ([185.122.133.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28BExOjt020167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 10:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662908368; bh=hJPv6652ahb8MzC7fon360LOpHJzm2WnHUULBpAhCsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ThyXbfr1ATcEaJinbd0Uqg13ruenlZfVebuM/ldJZzA44E2aHRatcfrYgqFfu4vSv
         px5j5djDgx4wf6WevzLHpeqPret3cjWwhQmYwfvDKbF760CuzvQyFVKf51TR3TlAVr
         GzKvpQlgSF+xGl7b9m/QyK+oc9nXsmMPYrp6RraTRWNhBSOfhx54YOLGLNEskwdv3H
         ZlL5KLgdO/YnZtHdDxVRpyaHTh/F7XUN9fGrqsQD0ZjvaJ9/MD9FMvrBET76IYq+sG
         10UpHnWdXMRtoDP6yC93KXs3qItAHtc6N4FSu0UrMs7pV1V8cGKWeeThfJOg0JTDb0
         NLnpmE9QuQSXQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 64D338C0D1A; Sun, 11 Sep 2022 06:00:41 -0400 (EDT)
Date:   Sun, 11 Sep 2022 06:00:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Message-ID: <Yx2xyW5n0ECZX9bJ@mit.edu>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
 <YxsGIoFlKkpQdSDY@mit.edu>
 <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 08:59:41AM -0700, Casey Schaufler wrote:
> 
> Data General's UNIX system supported in excess of 330 capabilities.
> Linux is currently using 40. Linux has deviated substantially from
> the Withdrawn Draft, especially in the handling of effective capabilities.
> I believe that you could support POSIX capabilities or Linux capabilities,
> but an attempt to support both is impractical.

Yeah, good point, I had forgotten about how we (Linux) ended up
diverging from POSIX 1.e when we changed how effective capabilities
were calculated.

> Supporting any given UNIX implementation is possible, but once you
> get past the POSIX defined capabilities into the vendor specific
> ones interoperability ain't gonna happen.

And from an NFS perspective, if we had (for example) a Trusted Solaris
trying to emulate Linux binaries over NFS with capabilities masks, I
suspect trying to map Linux's Capabilities onto Trusted Solaris's
implementation of POSIX 1.e would be the least of Oracle's technical
challenges.  :-)

> > .. and this is why the C2 by '92 initiative was doomed to failure,
> > and why Posix.1e never completed the standardization process.  :-)
> 
> The POSIX.1e effort wasn't completed because vendors lost interest
> in the standards process and because they lost interest in the
> evaluated security process.

It was my sense was that the reason why they lost interested in the
evaluated security process was simply that the business case didn't
make any sense.  That is, the $$$ they might get from US Government
sales was probability not worth the opportunity cost of the engineers
tasked to work on Trusted {AIX,DG,HPUX,Solaris}.  Heck, I'm not sure
the revenue would balance out the _costs_, let alone the opportunity
costs...

> Granularity was always a bone of contention in the working group.
> What's sad is that granularity wasn't the driving force behind capabilities.
> The important point was to separate privilege from UID 0. In the end
> I think we'd have been better off with one capability, CAP_PRIVILEGED,
> defined in the specification and a note saying that beyond that you were
> on your own.

Well, hey, we almost have that already, sort of --- CAP_SYS_ADMIN ==
"root", for almost all intents and purposes.  :-)

						- Ted
