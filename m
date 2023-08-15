Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250C77C698
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 06:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjHOEFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHOEDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:03:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E21FFE
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 20:59:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37F3xD8x030093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 23:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692071955; bh=hQVHu1e68/W/Zp/E5V+JbF6iz8mNZvWi1CMyPSC8un8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=JGdFKfBtj/0FPkQ8fcQZkAoAmznTuYUafjbPPhPDtOwSaZhM/HVt7g3lKwWp6k299
         n53lV0FP35STcKQeOvowRopQwwcvFXuw9xFJgEvWKM8KkiB8ITg/r1RQmBiykwI1at
         rPswgebxZC6iUzx3za8Ug/1kfEHs437bisVD2p8Sn0qXs/83TVt7h4vaNvrNmrjqf5
         rRfudXDaBeZi9jyt+7G1YzHZge/dhnmMX/1pR/MEBXqdv9/gZ+1NRVVAMTGUxG6+Nx
         mD25jQmABx8YqJxtozabdjRRuRPpX7y06IJ6h4BGaIETIow1K6ZzsPGGY84yvtcZi+
         Makzq02cG2kPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 221D515C0292; Mon, 14 Aug 2023 23:59:13 -0400 (EDT)
Date:   Mon, 14 Aug 2023 23:59:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230815035913.GF2247938@mit.edu>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
 <ZNhJSlaLEExcoIiT@casper.infradead.org>
 <20230813043022.GA3545@sol.localdomain>
 <20230814113852.GD2247938@mit.edu>
 <20230814172244.GA1171@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814172244.GA1171@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:22:44AM -0700, Eric Biggers wrote:
> 
> Keep in mind, the syzkaller team isn't asking for these pointless "fixes"
> either.  They'd very much prefer 1 fix to 1000 fixes.  I think some confusion
> might be arising from the very different types of problems that syzkaller finds.
> Sometimes 1 syzkaller report == 1 bug == 1 high-priority "must fix" bug == 1
> vulnerability == 1 fix needed.  But in general syzkaller is just letting kernel
> developers know about a problem, and it is up to them to decide what to do about
> it.  In this case there is one underlying issue that needs to be fixed, and the
> individual syzkaller reports that result from that issue are not important.

... except that the Syzkaller folks have created slide decks talking
about "Linux kernel security disaster", blaming the entire community,
where they quote the number unresolved syzkaller reports, without the
kind of nuance that you are referring to.

There is also not a great way of categorizing syzkaller reports as
"requires maliciously fuzzed file system image", or "writing to
mounted file system" --- either manually, or (ideally) automatically,
since the syzbot test generators knows what they are doing.

And finally, the reality is even if someone where to fix the "one
underlying issue", the reality is that it will be ten years or so
before said fixed can be rolled out, since it requires changes in
userspace utilities, as well as rolled out kernels, and enterprise
distros are around for a decade; even community distros need to be
supported for at least 3-5 years.

Finally, it's not just "one underlying issue"; there are also
"maliciously fuzzed file systems", and working around those syzbot
reports can be quite painful, especially the ones that lead to lockdep
deadlock reports.  Many of these are spurious, caused by an inode
being used in two contexts, that can only happen in a badly corrupted
file system, and for which we've already signalled that the file
system is corrupted, so if you panic on error, it wouldn't deadlock.
(And if you deadlock, it's not _that_ much worse than panicing on a
maliciously fuzzed file system.)  And all of these bugs get counted,
one for each lockdep report variation (so there can be 3-4 per root
cause) as a "security bug" in the "Linux kernel security disaster"
statistics.

I might not mind the hyperbole if said slide decks asked for more
headcount.  But instead, they blame the "Linux upstream community" for
not fixing bugs, or treating the bugs seriously.   Sigh....

  	    	    	       	      	       - Ted
