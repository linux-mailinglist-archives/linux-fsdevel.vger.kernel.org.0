Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDDC5A344D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 06:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiH0EM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0EMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:12:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C84E1A86;
        Fri, 26 Aug 2022 21:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wadOyvrfdeTNJP7k+clc6E/o5sdU8g+XeH3gXjpuwdI=; b=efG7rexKymyWdZYiYWCBrdcw1J
        yGcHif/DBfNYpOUqiHcBKNP8zbfBF6D2eiiQmJpKeAn+MfKxWG8ZIKkZhkLoASBaJLqnIUK1soKnD
        ajKfqytf3msa9oOkMGXO2HkOu2QejMrgtGp3V/49Z5mRzoz99q+I6lc94M4IMxeajLL7T8dL796+M
        D8+BxnylZ/AxUrr4lQwHRN46+XL65vD35U8/iAhuGU0IRT6HkDeGkoLNz81tC/gyjuZcbOx14+Wb8
        m12wspQ3/wjhaa7vhGb+T3F6LXyGGV4cDIhQ0yiL5UJ5VhIoKkF3IW9V4+Sgw8ZuUrMCZYyMPTQGZ
        oeWgEM1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRnBd-008s4P-Vk;
        Sat, 27 Aug 2022 04:12:46 +0000
Date:   Sat, 27 Aug 2022 05:12:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] VFS: support concurrent renames.
Message-ID: <YwmZveDR7Igur0m0@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984375.25420.13018600986239729815.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166147984375.25420.13018600986239729815.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:
> Allow object can now be renamed from or to a directory in which a create
> or unlink is concurrently happening.
> 
> Two or more renames with the one directory can also be concurrent.
> s_vfs_rename_mutex still serialises lookups for cross-directory renames,
> but the renames themselves can proceed concurrently.

Wha...?  <checks>
Not true, fortunately - you *do* hold ->s_vfs_rename_mutex over the
rename itself.  If not for that, it would be utterly broken.
And I don't care for NFS server rejecting that - we are *NOT* taking
loop prevention logics into every filesystem.  It's highly non-local
and trying to handle it with your per-dentry flags is going to be
painful as hell, if at all possible.

> +	if (d1 < d2) {
> +		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT);
> +		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT2);
> +	} else {
> +		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT);
> +		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT2);
> +	}

Explain, please.  What's that ordering about?
