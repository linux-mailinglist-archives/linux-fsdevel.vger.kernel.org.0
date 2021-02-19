Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29A31F457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBSEME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhBSEL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:11:59 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1854BC061756;
        Thu, 18 Feb 2021 20:11:19 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCx8D-00FgLa-9x; Fri, 19 Feb 2021 04:11:05 +0000
Date:   Fri, 19 Feb 2021 04:11:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: export kern_path_locked
Message-ID: <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org>
 <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org>
 <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:00:34PM +0000, Al Viro wrote:

> Sigh...  OK, so we want something like
> 	user_path_create()
> 	vfs_mknod()
> 	created = true
> 	grab bindlock
> 	....
> 	drop bindlock
> 	if failed && created
> 		vfs_unlink()
> 	done_path_create()	
> in unix_bind()...  That would push ->bindlock all way down in the hierarchy,
> so that should be deadlock-free, but it looks like that'll be fucking ugly ;-/
> 
> Let me try and play with that a bit, maybe it can be massaged to something
> relatively sane...

OK...  Completely untested series follows.  Preliminary massage in first
6 patches, then actual "add cleanup on failure", then minor followup
cleanup.
      af_unix: take address assignment/hash insertion into a new helper
      unix_bind(): allocate addr earlier
      unix_bind(): separate BSD and abstract cases
      unix_bind(): take BSD and abstract address cases into new helpers
      fold unix_mknod() into unix_bind_bsd()
      unix_bind_bsd(): move done_path_create() call after dealing with ->bindlock
      unix_bind_bsd(): unlink if we fail after successful mknod
      __unix_find_socket_byname(): don't pass hash and type separately

Branch is in git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #misc.af_unix,
individual patches in followups
