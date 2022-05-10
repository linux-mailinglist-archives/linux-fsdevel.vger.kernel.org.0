Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D416521EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiEJPh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbiEJPff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 11:35:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782C3B574;
        Tue, 10 May 2022 08:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACCA6B81D7C;
        Tue, 10 May 2022 15:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C68EC385C2;
        Tue, 10 May 2022 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652196657;
        bh=S6exA6OSyNi01JKIfIMf9AjDS/wnlwFSx2RTUuwC2CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNXs8Q6V+p1cDUy2KdDM13MJl3NoY5Qdq/BwxZegnMRh/5ZI29oP1SPUkaBoDIGCV
         TRre5hHPsOtIqmvWOicVnIVAb69UshJhuh5Hn99PJZSqYrNXj+PEsbz00L2u/60aiy
         j/FmlT3/v5f6i27tQ3nCUDKETS37dKvkAokYkmfCcvj0jeFCRHv+QYEjusHvlLhp89
         7ytt5cHhPBXg6wivc7CRGViEZUUDaQ/784NyBc5Bri20QayljHQ8hiEsos+SZktroI
         zT+IFRGAHv991qAJXSy2bRr4D8ys4ClAXT8buFbLgaUzPyTnlFf0byM0DdjSi8okVb
         W1diT2O5XTk/w==
Date:   Tue, 10 May 2022 17:30:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220510153050.cgbt3wezbvf2jfnb@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <20220510115316.acr6gl5ayqszada6@wittgenstein>
 <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
 <20220510141932.lth3bryefbl6ykny@wittgenstein>
 <CAJfpegt94fP-_eDAk=_C=24ahCtjQ4vhh8Xg+SrZbwPHs1waLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt94fP-_eDAk=_C=24ahCtjQ4vhh8Xg+SrZbwPHs1waLA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 04:41:35PM +0200, Miklos Szeredi wrote:
> On Tue, 10 May 2022 at 16:19, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Fwiw, turning this around: unifying semantically distinct interfaces
> > because of syntactical similarities is bad. Moving them into a
> > syntactically equivalent system call that expresses the difference in
> > semantics in its name is good.
> 
> You are ignoring the arguments against fragmentation.

No, I'm not ignoring it and really wasn't trying to. What I tried to say
by this, is that the inverse of the argument against fragmentation is
simply equally worth supporting. Meaning the argument against
fragmentation isn't stronger than the argument against aggressive
unification.

(Fwiw, I think that basing the argument on syntactical similarities is
problematic. Stretching this argument for a second, all multiplexers are
almost by necessity syntactically similar (e.g. ptrace() and seccomp())
but we don't use that as an argument to make them a single system call.)

> 
> You are also ignoring the fact that semantically the current xattr
> interface is already fragmented.   Grep for "strncmp(name, XATTR_" in
> fs/xattr.c.
> 
> We don't have getsecurityxattr(), getuserxattr(), gettrustedxattr()
> and getsystemxattr().  It would be crazy.   Adding getfsxattr()  would
> be equally crazy.  getxattr() pretty much describes the semantics of
> all of these things.

getxattr() describes the syntax of all of these things and barely that.
It describes the method of retrieval. And the method of retrieval is
super generic to the point where strings _or binary data_ can be
returned (e.g. POSIX ACLs or fscaps) depending on the xattr namespace.
But wight now, everything we currently get from getxattr() is attributes
associated with inodes.

So getsecurityxattr(), getuserxattr(), gettrustedxattr() etc. would
arguably be fragmentation because all of these things are associated
with inodes.

But now we're in the process of extending the *xattr() calls to operate
on mounts and filesystems so an additional getfsattr() (or another name)
is not fragmentation imho. And I definitely don't think this would
qualify as "crazy".
