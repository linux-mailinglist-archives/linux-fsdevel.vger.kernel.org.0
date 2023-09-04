Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0CD791226
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbjIDH3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbjIDH3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:29:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC611A;
        Mon,  4 Sep 2023 00:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C369FB80DB6;
        Mon,  4 Sep 2023 07:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C28C433C8;
        Mon,  4 Sep 2023 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812562;
        bh=x31Nmxsvwnf9cm5nZ8qyMX1uiVUXha813H5LnskzPW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxLvWAJRPfxBtldsU5bPkb5pf9NDOgQFbEL65qIrVd8TRyXG2w6DGcKnKDFYAeCPQ
         e0Kw76aa/ZBExuqCXJr0YyiN1mUB03q5Yg30xZ3QsXwDmMT+tO4f7ZLj915Z1XSRqg
         oVQaPWepG14MPOHdJovS8kQ1Quu0y4K2Gu0qkZy5G0fDb1jwEbPzNx2/flFUiq0vFJ
         uItE/Yy97/6OCKh5+vQkks3DXtrr4mNSkFpkmdgWrjGH3EK/bYOJU2pC+sadyHD41N
         lLIRll6ZIECoAovno2XiTjuxQsfnY65J3td8wnhfWDmeHV0NsnTvj9phNCVZleSDqH
         pHedHG72aa3Pg==
Date:   Mon, 4 Sep 2023 09:29:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
Message-ID: <20230904-meistens-umeinander-3366194553a1@brauner>
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com>
 <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
 <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
 <202309011133.10D66D0785@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202309011133.10D66D0785@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 11:34:32AM -0700, Kees Cook wrote:
> On Fri, Sep 01, 2023 at 04:50:53PM +0200, Michał Cłapiński wrote:
> > On Fri, Sep 1, 2023 at 2:56 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> > > > Add a way to check if an fd points to the memfd's original open fd
> > > > (the one created by memfd_create).
> > > > Useful because only the original open fd can be both writable and
> > > > executable.
> > > >
> > > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > > ---
> > > >  fs/fcntl.c                 | 3 +++
> > > >  include/uapi/linux/fcntl.h | 9 +++++++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index e871009f6c88..301527e07a4d 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> > > >       case F_SET_RW_HINT:
> > > >               err = fcntl_rw_hint(filp, cmd, arg);
> > > >               break;
> > > > +     case F_CHECK_ORIGINAL_MEMFD:
> > > > +             err = !(filp->f_mode & FMODE_WRITER);
> > > > +             break;
> > >
> > > Honestly, make this an ioctl on memfds. This is so specific that it
> > > really doesn't belong into fcntl().
> > 
> > I've never touched ioctls but if I'm correct, I can't just add it to
> > memfd. I would have to add it to the underlying fs, so hugetlbfs and
> > shmem (which I think can be defined as ramfs so also there). File
> > sealing fcntl is already memfd specific. Are you sure ioctl will be a
> > better idea?

fcntl() should be generic. Frankly, the sealing stuff should've gone
into an ioctl as well and only upgraded to a fcntl() once multiple fd
types support it.

> 
> Does this check "mean" anything for other files? Because if it's
> generically useful (and got renamed) it maybe would be right for
> fcntl...

For regular files it just means that the file has gotten write access to
the underlying fs and we use this flag to release the necessary
refcounts/protections once the file is closed.

If this check has any meaning beyond that than it only has meaning for
memfd. I'm also not sure why this checks FMODE_WRITER and not
FMODE_WRITE as FMODE_WRITER is almost an entirely internal thing that
only very specific codepaths need to know about.
