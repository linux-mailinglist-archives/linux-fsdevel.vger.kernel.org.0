Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E270AAD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjETUHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjETUHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 16:07:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D066F3
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 13:07:14 -0700 (PDT)
Received: from letrec.thunk.org (c-73-212-78-46.hsd1.md.comcast.net [73.212.78.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34KK6h9L017611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 16:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684613205; bh=d4GHGt4vYMFvs3jkg7DBg6Pktwf0wLIFTWEyVlbyh6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bSxm+APQm0ILm85T7iInIDuACDa6Onf1Plq7WIVY+jo6mWSl+uwEn5CPVmE3+Ujn9
         +LJLw5a99SsGL04O6sIAKTKF84WlrCZu1nu/eLuRPiUWTNnC5uVRbBjDCAZ2NDN6AO
         MT2AA9PGjzPidrxMKLjYIFgB+Ubar2k3RQKyqAMa33B6XWYANpGlhZTjiHPLwxOAdl
         vpwdmKpeQd4RYKxopMzcuJadzRmDSXUPRBL996vidBNrdS1zJWFYcVVEGpMgEMZhhO
         LRKWDRj/BR+N8dy8m+caGJPLy1TEkpCd2DeLBtsUoj3ykUUSnVUctcgRoAr7I9msA/
         9bqTcJGqHVuVg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 3D6EC8C0459; Sat, 20 May 2023 16:06:43 -0400 (EDT)
Date:   Sat, 20 May 2023 16:06:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <ZGkoU6Wfcst6scNk@mit.edu>
References: <20230518114742.128950-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518114742.128950-3-jlayton@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 07:47:35AM -0400, Jeff Layton wrote:
> Use the 31st bit of the ctime tv_nsec field to indicate that something
> has queried the inode for the i_mtime or i_ctime. When this flag is set,
> on the next timestamp update, the kernel can fetch a fine-grained
> timestamp instead of the usual coarse-grained one.

TIL....  that atomic_long_fetch_or() and atomic_long_fetch_andnot()
exist.  :-)

When I went looking for documentation about why they do or this
particular usage pattern found in the patch, I didn't find any --- at
least, certainly not in the Documentation in the kernel sources.  The
closest that I fond was this LWN article written by Neil Brown from
2016:

	https://lwn.net/Articles/698315/

... and this only covered the use atomic_fetch_or(); I wasn't able to
find anything discussing atomic_fetch_andnot().

It looks like Peter Zijlstra added some bare-bones documentation in
2017, in commit: 706eeb3e9c6f ("Documentation/locking/atomic: Add
documents for new atomic_t APIs") so we do have Documentation that
these functions *exist*, but there is nothing explaining what they do,
or how they can be used (e.g., in this rather clever way to set and
clear a flag in the high bits of the nsec field).

I know that it's best to report missing documentation in the form of a
patch, but I fear I don't have the time or the expertise to really do
this topic justice, so I'd just thought I'd just note this lack for
now, and maybe in my copious spare time I'll try to get at least
something that will no doubt contain errors, but might inspire some
folks to correct the text.  (Or maybe on someone on linux-doc will
feel inspired and get there ahead of me.  :-)

					- Ted
