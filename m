Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083D1512DBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbiD1IKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiD1IK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984E5C87B;
        Thu, 28 Apr 2022 01:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55A261F64;
        Thu, 28 Apr 2022 08:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79133C385A9;
        Thu, 28 Apr 2022 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651133234;
        bh=GLBy3cCOaaEcXZE1TXIk4VuMBE17BZY8JjWrsHY6bHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJhmMUw4B4ufrbaKVvXkpQmaEg1CfwUWhOqXhPyRqbPQzdORxPVi0L/uLzotT98Br
         IuFA2K616DmH73gc5jGSC5H58yI7oo6NEYawUUexVXGRAYIB50N2BIfVmUSSsdpOdM
         oUsYt0bXXr5Vl9yQV7xGMCQFFX8eqGOrcrvfr+DH1KyGyqJUXQxs32kPg1Co2afIW7
         xsEtLY2hjrryy7qDiEKwzOElybzIsux2FUqPAipLTYqYGhfMEHG5ZR7vEy8MiY1kNU
         Tz7W77ts8qDa892jxFOXmk4jvB5oHlBRmY3SOgHnigDuDJmYTCwQs+TqSFD3rPeaNL
         QDDKWf8vCXvqg==
Date:   Thu, 28 Apr 2022 10:07:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Message-ID: <20220428080708.y76yhqwczwwmdvi4@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650971490-4532-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426103846.tzz66f2qxcxykws3@wittgenstein>
 <CAOQ4uxhRMp4tM9nP+0yPHJyzPs6B2vtX6z51tBHWxE6V+UZREw@mail.gmail.com>
 <CAJfpegu5uJiHgHmLcuSJ6+cQfOPB2aOBovHr4W5j_LU+reJsCw@mail.gmail.com>
 <20220426145349.zxmahoq2app2lhip@wittgenstein>
 <20220427092201.wvsdjbnc7b4dttaw@wittgenstein>
 <Ymob0U33QNeJEeFs@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ymob0U33QNeJEeFs@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:45:05AM +0000, Al Viro wrote:
> On Wed, Apr 27, 2022 at 11:22:01AM +0200, Christian Brauner wrote:
> 
> > +static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
> > +				       const struct inode *dir, umode_t mode,
> > +				       umode_t mask_perms, umode_t type)
> > +{
> > +	/*
> > +	 * S_ISGID stripping depends on the mode of the new file so make sure
> > +	 * that the caller gives us this information and splat if we miss it.
> > +	 */
> > +	WARN_ON_ONCE((mode & S_IFMT) == 0);
> 
> <blink>
> 
> First of all, what happens if you call mknod("/tmp/blah", 0, 0)?  And the only
> thing about type bits we care about is "is it a directory" - the sensitive
> stuff is in the low 12 bits...  What is that check about?

Do note that this is just an untested rough sketch to illustrate how to
move it into vfs_*() helpers.

