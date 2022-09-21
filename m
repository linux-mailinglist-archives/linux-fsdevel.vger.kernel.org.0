Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA95C00CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUPJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIUPJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0195D0D7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9CA6254B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 15:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5E0C433D6;
        Wed, 21 Sep 2022 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772988;
        bh=eLwpdKG8MaImnU4wNhEdr7TjENNbSPKEj5zH/2tgEf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORlaQ7+ZV+MBKAX4EFQD+NmpvzXLkNUq4aNtBGWPJsrGUVZpk7spMZOqKe7/TUMgo
         U1oXOPW3ULzppQESzuE+sB7fUAgDO4Ltj+b1JkugGhMik6WM5lvSz5oib7PZJR33Pp
         pAY2cl9hfLLe0e4YtPuYgiJOSaXqHhVgG89DmySf/sjGPT80UOA6nUsl/y8o9+81Qw
         qw4b3mayuTjQgPpkIyHrSslrjoQLcLCyoZIYZZXP+gi80xn9RVmrnUBDPhqRUrt0g4
         2oWDHiSGWcCzXUFdOyBQd5S5p1KCvxUHYC5FK+jNVqvkQ45nhDICyJA13SkychhmcX
         X4xvCMVG+NDvA==
Date:   Wed, 21 Sep 2022 17:09:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Message-ID: <20220921150942.l3g5k55l6j5k7yn2@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-8-mszeredi@redhat.com>
 <20220921090306.ryhcrowcuzehv7uw@wittgenstein>
 <CAJfpegsEbwQhgZbXTsAzcMTcwVvA_U4r+JEDLcYSAezC6hYq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsEbwQhgZbXTsAzcMTcwVvA_U4r+JEDLcYSAezC6hYq5g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:56:01PM +0200, Miklos Szeredi wrote:
> On Wed, 21 Sept 2022 at 11:03, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:
> 
> 
> > > +/* Helper for the simple case when original dentry is used */
> > > +static inline int finish_open_simple(struct file *file, int error)
> >
> > It would be nice if the new helpers would would be called
> > vfs_finish_open()/vfs_finish_open_simple() and vfs_tmpfile_open() to
> > stick with our vfs_* prefix convention.
> >
> > It is extremely helpful when looking/grepping for helpers and the
> > consistency we have gained there in recent years is pretty good.
> 
> Agreed.  However only finish_open_simple() is the new one, and naming
> it vfs_finish_open_simple() makes it inconsistent with
> finish_open_simple().    I'd just leave this renaming to a separate
> patchset and discussion, as it's hard enough to make progress with the
> current one without expanding its scope.

Ok, the finish_open* thing can be left for later. But vfs_tmpfile_open()
should be doable for this patchset already.
