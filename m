Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D511377B7B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjHNLjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjHNLje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:39:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BADA18E
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:39:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37EBcql3029730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 07:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692013134; bh=CBdD/c9taZbfk8ckRsVUg5HdMT2PJm8oFdBr6g19unI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=omyRU0yyyUqJ/4DlttOwQYA6FIp1uOxkueF1h5sT+nLom9qPG2OXpn2ZLOwPsKIO8
         9JTzlwTdXCiZWrC+qrCxE9IyQV9tk7OqmTKDLaPogX6eFWR3luHTlH98IV8Q6j8Aiz
         JdtWUQaz6bJyDLForrT9VYSlgko5gpmf2SseYOdHf7eV69lpic7il7xLJx4OI8w6KK
         02EKaPaTCfOS8oughn8MH8+CeYhqSCLow5/jrtNhMH3x6usoMHKcjqo3D/8gAWmw58
         N25e/WZaYsrmw/ojBYaqctRyOrfhi8Ude+iRuCVD6XWhEabUcBj6qqpQb5Q24VxyYq
         iBnKnnnfpzemg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0F2C915C0292; Mon, 14 Aug 2023 07:38:52 -0400 (EDT)
Date:   Mon, 14 Aug 2023 07:38:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230814113852.GD2247938@mit.edu>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
 <ZNhJSlaLEExcoIiT@casper.infradead.org>
 <20230813043022.GA3545@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813043022.GA3545@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:30:22PM -0700, Eric Biggers wrote:
> Well, one thing that the kernel community can do to make things better is
> identify when a large number of bug reports are caused by a single issue
> ("userspace can write to mounted block devices"), and do something about that
> underlying issue (https://lore.kernel.org/r/20230704122727.17096-1-jack@suse.cz)
> instead of trying to "fix" large numbers of individual "bugs".  We can have 1000
> bugs or 1 bug, it is actually our choice in this case.

That's assuming the syzbot folks are willing to enable the config in
Jan's patch.  The syzbot folks refused to enable it, unless the config
was gated on CONFIG_INSECURE, which I object to, because that's
presuming a threat model that we have not all agreed is valid.

Or rather, if it *is* valid some community members (or cough, cough,
**companies**) need to step up and supply patches.  As the saying
goes, "patches gratefully accepted".  It is *not* the maintainer's
responsibility to grant every single person whining about a feature
request, or even a bug fix.

       	       	       	       		   	  - Ted
