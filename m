Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17F52207B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347024AbiEJQDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbiEJQBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 12:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B358B3CA52;
        Tue, 10 May 2022 08:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4284961673;
        Tue, 10 May 2022 15:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F4C385A6;
        Tue, 10 May 2022 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652198019;
        bh=9pgUcC73MMhE3nPFiSsB/Zp0JFryDLtpwGsW8VKXMIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7AzoJ/Wk3+3/R2dR6hL3nO2cRTFVkpejdusu1cWWqVxNKpzc9Vy/meXirezGrwZi
         J0ZEbm2n4fxpjjgMY/pmT/vd2Mfu9pcKIxWKj95uWzWf40AodLu8S0c6nIM19gJ0Tw
         kSXcRleqg5eBZ5f/7ks7y1nufYS4P6+8qpjb9XOe0fmD6kocBMMPPBx+gDCifjtF1z
         2Zp/8QdJFjY+q9EAns9A3uZUD9ZctwxPKJN+UbTg8PKs6esQzU2pPpusSbNwm8Am3L
         tgGo6JPSNRMoETWilBHweh5lLCuzXFJFNFzTyG3qS4ZYm5/zyhCRYffXVvbjjgP0Br
         uc7+JMwnO6kow==
Date:   Tue, 10 May 2022 17:53:32 +0200
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
Message-ID: <20220510155332.3zm5nycl7nmuxgdx@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <20220510115316.acr6gl5ayqszada6@wittgenstein>
 <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
 <20220510141932.lth3bryefbl6ykny@wittgenstein>
 <CAJfpegt94fP-_eDAk=_C=24ahCtjQ4vhh8Xg+SrZbwPHs1waLA@mail.gmail.com>
 <20220510153050.cgbt3wezbvf2jfnb@wittgenstein>
 <CAJfpegu8d2VQ+WjfmUJ6g7YBPJsYUABt0jG5ByVh-dMt_waV8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu8d2VQ+WjfmUJ6g7YBPJsYUABt0jG5ByVh-dMt_waV8A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 05:47:13PM +0200, Miklos Szeredi wrote:
> On Tue, 10 May 2022 at 17:30, Christian Brauner <brauner@kernel.org> wrote:
> 
> > But now we're in the process of extending the *xattr() calls to operate
> > on mounts and filesystems so an additional getfsattr() (or another name)
> > is not fragmentation imho. And I definitely don't think this would
> > qualify as "crazy".
> 
> In that spirit st_dev does not belong in struct stat, because that is
> the property of the block device, not the inode.
> 
> But I feel we are going round in circles, lets please not get hung up
> on this issue.  Linus will have the final word on which variant (if
> either) is going to go in.

Well yes, I'm obviously not going to be d*ck about it and go around
NAKing it just because I didn't get my favorite name but I at least
want to register my strong opposition to the current "unification"
approach loud and clear. :)
