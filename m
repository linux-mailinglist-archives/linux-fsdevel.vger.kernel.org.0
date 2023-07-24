Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F419275FE7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGXRum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGXRuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B864C19;
        Mon, 24 Jul 2023 10:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6434961360;
        Mon, 24 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD843C433C8;
        Mon, 24 Jul 2023 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690220794;
        bh=jy1HYFTjzSQArcOEX/GY5RMYACOnapkGSnMBIFuMSVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZyI90B0S9SoHJriLWGk76YncnZYcthpOlVsVabOcFAJLgSA/xo37jIca8IR/HBa1
         m+HvLMsjwiPjR+tp6nQiXQ8kGKVHa/JEELgkZCWxAJ+NZHNNbTGYzn3ARc/p3d49pM
         xDgeU8sY7cYA62OXouG2rEgCB12c020nsLhqbIy9t3OnhFIBkHMFJl8obnYVgoN8Eq
         RVPWPmy5A+AaU5qr09aqdqBhnM7zxGL5eMNTGw9Om2wp6YMuEYUSDB2ypEuYrqrm4r
         BbEEKXb7ZivJlJ0t59WJ9ejX80asVcOf5nwFIVgYBuJl+KWcDT6FHs5SDf3Si4bxs1
         F0r5SGCM7icFw==
Date:   Mon, 24 Jul 2023 19:46:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:34:31AM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This means pidfd_getfd() needs the same treatment as MSG_PEEK for sockets.
> 
> So the reason I think pidfd_getfd() is ok is that it has serialized
> with the source of the file descriptor and uses fget_task() ->
> __fget_files.
> 
> And that code is nasty and complicated, but it does get_file_rcu() to
> increment the file count, and then *after* that it still checks that
> yes, the file pointer is still there.
> 
> And that means that anybody who uses fget_task() will only ever get a
> ref to a file if that file still existed in the source, and you can
> never have a situation where a file comes back to life.
> 
> The reason MSG_PEEK is special is exactly because it can "resurrect" a
> file that was closed, and added to the unix SCM garbage collection
> list as "only has a ref in the SCM thing", so when we then make it
> live again, it needs that very very subtle thing.

Oh, eew.

> 
> So pidfd_getfd() is ok in this regard.
> 
> But it *is* an example of how subtle it is to just get a new ref to an
> existing file.
> 
> That whole
> 
>          if (atomic_read_acquire(&files->count) == 1) {
> 
> in __fget_light() is also worth being aware of. It isn't about the
> file count, but it is about "I have exclusive access to the file
> table". So you can *not* close a file, or open a file, for another
> process from outside. The only thread that is allowed to access or
> change the file table (including resizing it), is the thread itself.

Yeah, I'm well aware of that because an earlier version of the getdents
patchset would've run into exactly that problem because of async offload
on the file while the process that registered that async offload
would've been free to create another thread and issue additional
requests.

> 
> I really hope we don't have cases of that.

I don't think we do but it's something to keep in mind with async io
interfaces where the caller is free to create other threads after having
registered a request. Depending on how file references are done things
can get tricky easily.

I'm not complaining here but it is worth noting that additions to e.g.,
io_uring now have to reason through two reference counting mechanisms:
the regular system call rules and the fixed file io_uring rules. If
conditional locking is involved in one part it might have
effects/consequences in the other part as one can mix regular system
call requests and fixed file requests on the same struct file.
