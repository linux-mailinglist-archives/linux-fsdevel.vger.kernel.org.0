Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DB6C27B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCUCDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCUCDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:03:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744592F7A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 19:03:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32L23D4S017789
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 22:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679364195; bh=1++IKRnqZ+BH2bM0eGHWtNbecEk8GgRIA8+jEij3mzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jYHIUJj5Nxaj3F8dekW6ywk+SvD8er7agnGjI9VKHDxL0C3uFSGGUuEOlVGIfTOvE
         WY6BohWTcaw2OgL9PVRHJm+DbVfhrvf/Te1PQ6W04mgvgUu/1MYxGSEBA54rkG2YgY
         4OREog7fyMLtMLzv7GELovYZm1rZp/9pn4oEOatZWRvbaAJq600GLiT96DE4Wne0CB
         g+pMdMJw/RdypxImFlqNmYIp8BoR8hFSuy9psdAcKD56FdL+Q8abj9/98tFQncZRKk
         Mv/CRcEtDoR3/+TJbUrkots9gtDyunBWcuZF43Jd25Y0ML2fmp2rIftMQmscymcFwC
         v6KihMmhYzxNQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6D1AE15C4279; Mon, 20 Mar 2023 22:03:13 -0400 (EDT)
Date:   Mon, 20 Mar 2023 22:03:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
Message-ID: <20230321020313.GA108653@mit.edu>
References: <20230320205617.GA1434@sol.localdomain>
 <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
 <20230320225934.GB21979@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320225934.GB21979@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:59:34PM -0700, Eric Biggers wrote:
> 
> Yes, I agree that most of the WARN_ONs should be WARN_ON_ONCEs.  I think I've
> been assuming that WARN_ON is significantly more lightweight than WARN_ON_ONCE.
> But that doesn't seem to be the case, especially since commit 19d436268dde
> ("debug: Add _ONCE() logic to report_bug()").

Another option is WARN_RATELIMITED.

As an unrelated side-note, one of the things I've been working on in
some of the ext4 code paths when I've been moving BUG_ON's to
WARN_RATELIMITED is to think about what might be needed to debug a
problem, and sometimes it can be helpful to use a printf string to
provide more context than just a WARN_ON.

Cheers,

						- Ted
