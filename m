Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D851679B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjAXOHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjAXOHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:07:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89535BB
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:07:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz11so39383053ejc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6SS0IpNHJeZVKjSk1E9ak0IQ8TGXFPhVFNKMArL1I8=;
        b=O7OgK8NGHkjYdYJmnUlShdLQzrL92Jy+2CdxrBEzt23hSN/bzXb+NyKQ9J2jY81Lw0
         BRscU/71mCfsRbR25n3o2bVYjSkPn4DwdxyKXTTg7rG4R/oD3UJiLLSStw6ANGfdRkHH
         7rWvXq2Y9DVtNUhsM7+levkEQA44gpxVKjD4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6SS0IpNHJeZVKjSk1E9ak0IQ8TGXFPhVFNKMArL1I8=;
        b=8COmordhnODE0o1Et/FHU/sZc81UOE6iLAPFIEh7X0rCNAyjOkR8XzScm2jybB6Ufv
         Cu5xrodRehpbJUw9xQBcYnL+IeaJHR1nKUGNJNLOPh/fm9Nhmv78nUSN3NwDCqjnvuq4
         HHRG7CYEXk3eizCobLmurfLgga1KqS3hUiODEP1xlRddnnsMmC1vsdB8UkcE8zX+LPyY
         /ml8vIyUu3kl9iEzs5qbjip1keO0EGvH4QhX8IUVXOM43+X9gkm+JKom83lPYEjbZKpD
         2bhJLrEjLu4LdmqaZdE57XiPgKN5Z1ObwPnGvnEbETxfhYGT2bzyGzMjXCkxCPEQsYy1
         1O2g==
X-Gm-Message-State: AO0yUKUoqpuAqa4NgPkXXXqYnM1coKF0r5b83QOrflc6dVnEYWNnaajz
        YTDSJX0H2kcbngLKB4xpLgg7WjIj/asVO0CaYkO/+A==
X-Google-Smtp-Source: AMrXdXvROlh/T4z441SQqCwofWWRXckW8+pLuv/hE7TanH2ronNdXAFGlj7HiewmHjQOsV5O/mNvzsNhfHphlmMCFzA=
X-Received: by 2002:a17:906:4e0c:b0:877:e51a:5f0a with SMTP id
 z12-20020a1709064e0c00b00877e51a5f0amr446921eju.186.1674569249482; Tue, 24
 Jan 2023 06:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org>
In-Reply-To: <20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Jan 2023 15:07:18 +0100
Message-ID: <CAJfpegsNZ1F1hhEaBH2Lw20CsqYm-nEFEUAH0k46_ua=5Gp2zw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fixes after adapting to new posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 20 Jan 2023 at 12:55, Christian Brauner <brauner@kernel.org> wrote:
>
> This cycle we ported all filesystems to the new posix acl api. While
> looking at further simplifications in this area to remove the last
> remnants of the generic dummy posix acl handlers we realized that we
> regressed fuse daemons that don't set FUSE_POSIX_ACL but still make use
> of posix acls.
>
> With the change to a dedicated posix acl api interacting with posix acls
> doesn't go through the old xattr codepaths anymore and instead only
> relies the get acl and set acl inode operations.
>
> Before this change fuse daemons that don't set FUSE_POSIX_ACL were able
> to get and set posix acl albeit with two caveats. First, that posix acls
> aren't cached. And second, that they aren't used for permission checking
> in the vfs.
>
> We regressed that use-case as we currently refuse to retrieve any posix
> acls if they aren't enabled via FUSE_POSIX_ACL. So older fuse daemons
> would see a change in behavior.

This originates from commit e45b2546e23c ("fuse: Ensure posix acls are
translated outside of init_user_ns") which, disables set/get acl in
the problematic case instead of translating them.

Not sure if there's a real use case or it's completely theoretical.
Does anyone know?

>
> We can restore the old behavior in multiple ways. We could change the
> new posix acl api and look for a dedicated xattr handler and if we find
> one prefer that over the dedicated posix acl api. That would break the
> consistency of the new posix acl api so we would very much prefer not to
> do that.
>
> We could introduce a new ACL_*_CACHE sentinel that would instruct the
> vfs permission checking codepath to not call into the filesystem and
> ignore acls.
>
> But a more straightforward fix for v6.2 is to do the same thing that
> Overlayfs does and give fuse a separate get acl method for permission
> checking. Overlayfs uses this to express different needs for vfs
> permission lookup and acl based retrieval via the regular system call
> path as well. Let fuse do the same for now. This way fuse can continue
> to refuse to retrieve posix acls for daemons that don't set
> FUSE_POSXI_ACL for permission checking while allowing a fuse server to
> retrieve it via the usual system calls.
>
> In the future, we could extend the get acl inode operation to not just
> pass a simple boolean to indicate rcu lookup but instead make it a flag
> argument. Then in addition to passing the information that this is an
> rcu lookup to the filesystem we could also introduce a flag that tells
> the filesystem that this is a request from the vfs to use these acls for
> permission checking. Then fuse could refuse the get acl request for
> permission checking when the daemon doesn't have FUSE_POSIX_ACL set in
> the same get acl method. This would also help Overlayfs and allow us to
> remove the second method for it as well.
>
> But since that change is more invasive as we need to update the get acl
> inode operation for multiple filesystems we should not do this as a fix
> for v6.2. Instead we will do this for the v6.3 merge window.
>
> Fwiw, since posix acls are now always correctly translated in the new
> posix acl api we could also allow them to be used for daemons without
> FUSE_POSIX_ACL that are not mounted on the host. But this is behavioral
> change and again if dones should be done for v6.3. For now, let's just
> restore the original behavior.

Agreed.

>
> A nice side-effect of this change is that for fuse daemons with and
> without FUSE_POSIX_ACL the same code is used for posix acls in a
> backwards compatible way. This also means we can remove the legacy xattr
> handlers completely. We've also added comments to explain the expected
> behavior for daemons without FUSE_POSIX_ACL into the code.
>
> Fixes: 318e66856dde ("xattr: use posix acl api")
> Signed-off-by: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>


> If you're fine with this approach then could you please route this to
> Linus during v6.2 still? If you prefer I do it I'm happy to as well.

I don't think I have anything pending for v6.2 in fuse, but if you
don't either I can handle the routing.

Thanks,
Miklos
