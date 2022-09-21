Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554CC5E53FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIUTwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUTwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:52:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AA98E988
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jr+vdnR63/qL3CIhK6TlCBWVUm2LV2xKUhkrLggM+w=; b=D5ShjQt1TZkG9V/9bXYIo5nod8
        ug5PkOiutl6QN8aMVAxH/JyXTbjyjHYxB58tA67Kv3sxGjGqBqEInTAUxWXusF3fohz8f1cZvlKAX
        Jyl1IPhrslJb5yMZzJUwzXcpIW1p+WSveTZx+9o7la5QN8bqEheWhTWmN1fCBmPqkyE6sJpsQMSmS
        9tt3AFOfKh1zTqAm+z2PYpyKIGSNjgafwaKdPT92G/61Z4rNuTwoDEGaH3smZxSH4fBZyuubf184J
        ZnR7asDboNEOaB+N/dsPtGPiftloVONvc+C4F7NUB4GzPLMRdDYzVBbWtybNYQE4b9kbMRuq5YsXy
        91CuaAdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ob5lm-002Acl-0Q;
        Wed, 21 Sep 2022 19:52:30 +0000
Date:   Wed, 21 Sep 2022 20:52:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
Message-ID: <Yytrfp9VnumXZDGU@ZenIV>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-9-mszeredi@redhat.com>
 <20220921090820.woijqimkphaf3qll@wittgenstein>
 <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
 <20220921150750.grruzm3copwproyu@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921150750.grruzm3copwproyu@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:07:50PM +0200, Christian Brauner wrote:

> > I don't think file_dentry() should be used for this.
> > 
> > file_dentry() is basically a hack for overlayfs's "fake path" thing.
> > It should only be used where strictly necessary.  At one point it
> > would be good to look again at cleaning this mess up.
> 
> Yeah, that's what I was getting at. The file_dentry() helper would
> ideally just be as simple as file_inode() and then we'd have
> file_dentry_real() for the stacking filesystem scenarios.

	I would rather minimize the number of places where we access
file->f_path.dentry in the first place.  Any of those is asking for
confusion and overlayfs-triggered bugs.

	A helper for that would invite bugs where it gets used in
places of file_dentry() and vice versa; sure, the same bugs are
possible for open-coded variants (and we had such bugs), but I would
rather have fewer places doing that to start with (don't get me
started on the debugfs design.  Please.)
