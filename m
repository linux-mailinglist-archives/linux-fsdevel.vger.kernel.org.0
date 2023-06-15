Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D713731ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjFOOLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFOOLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:11:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CB211D
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:10:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FEAefq030470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686838243; bh=9pSm1ManOQffzB0kpaxN0w9oUbTOPeRqN/iObBv56ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AWAi4IJwC40ZQyRpUwKYTf0GA1agdhlIX8iGkovoPj9EbefxlLEcAf8x6dAHsFDWz
         RXGEoxao+oXhYubdLeBznBJv8N7y6Tp3rqy8P8mvz508ha4CYl6m08BxchPqx4VF2X
         fcx4Cj2mrWJ5kstKL49QG9F1aYk7vF0DVsHcAVXqn302YUb0SSUGdl97Iaoy6IsdXc
         yPzP63ikQgsGj12pJ4+/VUD5TV766utYOb8mFW0KPB6XssMTQ/QiZD6PCrQtVhiYBh
         UlLS8wB0+c6rWYYFWXlQwNDqyob8Ns8FRbQyVE7Pw94VQu/S92S2w8GbMtIJw75k4f
         HTnQrl/ZmVvVw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AA92D15C00B0; Thu, 15 Jun 2023 10:10:40 -0400 (EDT)
Date:   Thu, 15 Jun 2023 10:10:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <20230615141040.GG51259@mit.edu>
References: <20230615113848.8439-1-jack@suse.cz>
 <20230615-zarte-locher-075323828cd1@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-zarte-locher-075323828cd1@brauner>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:53:53PM +0200, Christian Brauner wrote:
> 
> So looking at the ext4 code this can only happen when you clear
> SB_RDONLY in ->reconfigure() too early (and the mount isn't
> MNT_READONLY). Afaict, this was fixed in:
> 
> a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
> 
> by clearing SB_RDONLY late, right before returning from ->reconfigure()
> when everything's ready. So your change is not about fixing that bug in
> [1] it's about making the vfs give the guarantee that an fs is free to
> clear SB_RDONLY because any ro<->rw transitions are protected via
> s_readonly_remount. Correct? It seems ok to me just making sure.

Unfortunately we had to revert that commit because that broke
r/o->r/w writes when quota was enabled.  The problem is we need a way
of enabling file system writes for internal purposes (e.g., because
quota needs to set up quota inodes) but *not* allow userspace file
system writes to occur until we are fully done with the remount process.

See the discussion here:

	https://lore.kernel.org/all/20230608044056.GA1418535@mit.edu/

The problem with the current state of the tree is commit dea9d8f7643f
("ext4: only check dquot_initialize_needed() when debugging") has
caught real bugs in the past where the caller of
ext4_xattr_block_set() failed to call dquot_initialize(inode).  In
addition, shutting up the warning doesn't fix the problem that while
we hit this race where we have started remounting r/w, quota hasn't
been initialized, quota tracking will get silently dropped, leading to
the quota usage tracking no longer reflecting reality.

Jan's patch will fix this problem.

Cheers,

						- Ted
