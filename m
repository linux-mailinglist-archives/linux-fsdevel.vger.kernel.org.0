Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11656A8857
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCBSLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBSLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:11:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761C3C796;
        Thu,  2 Mar 2023 10:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=ibBYQQeIiiGAZn1jkw/8iD8zchDBJYmzitBNnNfffKU=; b=qkWBA+Mclu35E811ntqp6YmvCO
        RR3OMkAPCgUeQg56ODLX8MF35b4I8H5SdZNbSHP3xaHNT9p9kDXjqLJ87VyIZ3syAes93tpzxnZuw
        7m6LlO7gEJnZM0zXv/Fj/ZdP6PDduhMav6oUkwsaY1PwIbINSFKRkghbzfQ3ba8tvVWddZkvvuxpy
        UAzvmw7DC4JcR3jlrZBu9t0jzhrz0S/XpZDL0naDS+PrnfZYDGLP2JiAEhYqf8BfYHlK4f14D4FfX
        ynn207lh1XX3e7Kx4EXmvvdu8jVehz6ILL5pFVAn9ygBykT79sUTd7G3OFLNwu7ySOMKv+C9/MLgW
        BsgZ0Xtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXnOV-00DMyn-2L;
        Thu, 02 Mar 2023 18:11:07 +0000
Date:   Thu, 2 Mar 2023 18:11:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZADmuzDEr6yznutq@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:30:25AM +0100, Christian Brauner wrote:
> On Mon, Feb 27, 2023 at 04:44:06PM -0800, Linus Torvalds wrote:
> > On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > Turns out for typical consumers the resulting creds would be identical
> > > and this can be checked upfront, avoiding the hard work.
> > 
> > I've applied this v3 of the two patches.
> > 
> > Normally it would go through Al, but he's clearly been under the
> > weather and is drowning in email. Besides, I'm comfortable with this
> > particular set of patches anyway as I was involved in the previous
> > round of access() overhead avoidance with the whole RCU grace period
> > thing.
> > 
> > So I think we're all better off having Al look at any iov_iter issues.
> > 
> > Anybody holler if there are issues,
> 
> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> it I'm happy to pick up more stuff like this. I've done it before and
> have worked in this area so I'm happy to help with some of the load.

TBH, I've missed that series; patches look sane, so consider them
belatedly ACKed.

And I've no problem with sharing the load - you have been doing that with
idmapping stuff anyway.  As far as I'm concerned, I generally trust your
taste; it doesn't matter that I won't disagree with specific decisions,
of course, but...
