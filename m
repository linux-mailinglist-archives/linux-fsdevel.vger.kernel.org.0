Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97803521D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbiEJO6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiEJO6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 10:58:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB82A76B4;
        Tue, 10 May 2022 07:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33131CE1F30;
        Tue, 10 May 2022 14:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82064C385C2;
        Tue, 10 May 2022 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652192379;
        bh=4obB5yZPo6qtD+4LbLaRZZjIPI7HGIIXta3dnnaLaA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJYOp3WJgQmgO//N8yYXAhgWomyLHhhikZ1zpaco+76CnmhwQ2xvz4LT0+nSITpvZ
         5ZBckNEnTZcrp3OiIKkg538FXEOuqVsJoFaEIG4yX1QqftrV1nEv5s//qnEcgnOBV7
         Xi+Hhc+7dBhwMKhWVMESKPBan0XlbG8NibNM2MAsnSOfzO3dD72z3E2/mCVvTwLSSM
         feq24xy/OFc4xbakrYzNLbeV1EuNcwqpyV6evlI9Nwv2lcCa/FqbDJvsyqehQYOp9e
         4ikYSS3PUdtH39aCqR0FWk3JIVSdwhophVEVBcX7DigC8UBChyCZwXC681AF+yMnhm
         je4agOQF7a5Gw==
Date:   Tue, 10 May 2022 16:19:32 +0200
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
Message-ID: <20220510141932.lth3bryefbl6ykny@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <20220510115316.acr6gl5ayqszada6@wittgenstein>
 <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 03:15:05PM +0200, Miklos Szeredi wrote:
> On Tue, 10 May 2022 at 13:53, Christian Brauner <brauner@kernel.org> wrote:
> 
> > > What exactly are the attributes that systemd requires?
> >
> > We keep a repo with ideas for (kernel) extensions - we should probably
> > publish that somewhere - but the list we used for a prototype roughly
> > contains:
> >
> > * mount flags MOUNT_ATTR_RDONLY etc.
> > * time flags MOUNT_ATTR_RELATIME etc. (could probably be combined with
> >   mount flags. We missed the opportunity to make them proper enums
> >   separate from other mount flags imho.)
> > * propagation "flags" (MS_SHARED)
> > * peer group
> > * mnt_id of the mount
> > * mnt_id of the mount's parent
> > * owning userns
> 
> Sounds good thus far.   And hey, we don't even need a new syscall:
> statx(2) could handle these fine.
> 
> > There's a bit more advanced stuff systemd would really want but which I
> > think is misplaced in a mountinfo system call including:
> > * list of primary and auxiliary block device major/minor
> 
> It's when you need to return variable size arrays or list of strings
> that the statx kind of interface falls down.
> 
> For that a hierarchical namespace is a much better choice, as it can
> represent arbitrary levels of arrays, while doing that with a
> specialized syscall is going to be cumbersome.
> 
> > I just have a really hard time understanding how this belongs into the
> > (f)getxattr() system call family and why it would be a big deal to just
> > make this a separate system call.
> 
> Fragmenting syntactically equivalent interfaces is bad, unifying them

Fwiw, turning this around: unifying semantically distinct interfaces
because of syntactical similarities is bad. Moving them into a
syntactically equivalent system call that expresses the difference in
semantics in its name is good.
