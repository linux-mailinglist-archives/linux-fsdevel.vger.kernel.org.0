Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4275A80E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGTHno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGTHnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F02D4A;
        Thu, 20 Jul 2023 00:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA3E618F6;
        Thu, 20 Jul 2023 07:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FBDC433C8;
        Thu, 20 Jul 2023 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689839000;
        bh=wkKDK2+s1pOg2JvqCSmY6SM9Z1YuLDwx2K3C/NKe7xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eizBjjVGnO2vg1Tt2xjCxt2izjubXLk5XoIzez+G7NV6q1Pov2b3Jowbwu6LF+wXa
         DNbJBORvYQCs0/CSWTrRQCmYn6FsD3maICWoXOwort8kKP5IwPbtFXh0cPUvhaD40s
         ExnEkERouBZ6IjvHtIe0E+mUHUFZGymwvdhnJCHYdompFyjMBUL9wWaF6UroxpCZqR
         Dcf1rsRIHmOSHhnxJooVrw450EAg1dAqIDazslQUWsPdBfInFNqjaoEzFkfSmavNZK
         WkRV1J2XALtQTXEZC0xXWSOWH7LG+fDbExR5IFjiJMxBKUO/yvbkRuAfAebaoIjELj
         0C2zvsGLMPibA==
Date:   Thu, 20 Jul 2023 00:43:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230720074318.GA56170@sol.localdomain>
References: <20230719221918.8937-1-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719221918.8937-1-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, one more thing...

On Wed, Jul 19, 2023 at 06:19:11PM -0400, Gabriel Krisman Bertazi wrote:
> 
> Another problem exists when turning a negative dentry to positive.  If
> the negative dentry has a different case than what is currently being
> used for lookup, the dentry cannot be reused without changing its name,
> in order to guarantee filename-preserving semantics to userspace.  We
> need to either change the name or invalidate the dentry. This issue is
> currently avoided in mainline, since the negative dentry mechanism is
> disabled.

Are you sure this problem even needs to be solved?

It actually isn't specific to negative dentries.  If you have a file "foo"
that's not in the dcache, and you open it (or look it up in any other way) as
"FOO", then the positive dentry that gets created is named "FOO".

As a result, the name that shows up in /proc/$pid/fd/ for anyone who has the
file open is "FOO", not the true name "foo".  This is true even for processes
that open it as "foo", as long as the dentry remains in the dcache.

No negative dentries involved at all!

Is your thinking that you just don't want to increase the number of ways in
which this behavior can occur?

Or, it looks like the positive dentry case is solvable using d_add_ci().
So maybe you are planning to do that?  It's not clear to me.

- Eric
