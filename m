Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0DF5E7641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIWIxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWIxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:53:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59351126B47;
        Fri, 23 Sep 2022 01:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F51BB825D5;
        Fri, 23 Sep 2022 08:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E77C433C1;
        Fri, 23 Sep 2022 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663923182;
        bh=6UkifW9opBuMiDyAjvnxiHu2FKrBLty2CaTZoLX1Qf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuMMxSihZdLFcnHxLfHUb1BkuwfWdTeggmnBd3ei4gKudohhYIFgUKLJumYoKoCti
         x62wROUR3srA6pEupaT2QuwXqAMyTDOCbvPrRyhK331ablFW6VjJjjL9Lgeo16Xkbn
         kcP6mqIfuGDyX/GE0SuxV7ZFBUQlgR8Hv3voEXFGe0eTwnSBLo0f7i1UbDxI3wxOye
         KWS90gaEv/h5cv+t8dSHarFtQegDs0wGdSTLIyJ+jhLiT5ojCi3QmlVq6NVq8a+W5N
         Jgy2EIk59xsdbPHu3tTY35yY0RMk9AYXnL3e4rJBaG332J12GTsVh2GB9/0mn853lw
         W1fO3xgL+uqag==
Date:   Fri, 23 Sep 2022 10:52:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Message-ID: <20220923085256.2ic6ivf4iuacu5sg@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
 <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
 <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
 <20220922215731.GA28876@mail.hallyn.com>
 <CAHC9VhSBwavTLcgkgJ-AYwH9wzECi3B7BtwdKOx5FJ3n7M+WYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSBwavTLcgkgJ-AYwH9wzECi3B7BtwdKOx5FJ3n7M+WYg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:13:44PM -0400, Paul Moore wrote:
> On Thu, Sep 22, 2022 at 5:57 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Thu, Sep 22, 2022 at 03:07:44PM -0400, Paul Moore wrote:
> > > On Thu, Sep 22, 2022 at 2:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> > > > > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > >> Could we please see the entire patch set on the LSM list?
> > > > > While I don't think that's necessarily wrong, I would like to point
> > > > > out that the gitweb interface actually does make it fairly easy to
> > > > > just see the whole patch-set.
> > > > >
> > > > > IOW, that
> > > > >
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> > > > >
> > > > > that Christian pointed to is not a horrible way to see it all. Go to
> > > > > the top-most commit, and it's easy to follow the parent links.
> > > >
> > > > I understand that the web interface is fine for browsing the changes.
> > > > It isn't helpful for making comments on the changes. The discussion
> > > > on specific patches (e.g. selinux) may have impact on other parts of
> > > > the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
> > > > can be a real problem if the higher level mailing list (the LSM list
> > > > in this case) isn't included.
> > >
> > > This is probably one of those few cases where Casey and I are in
> > > perfect agreement.  I'd much rather see the patches hit my inbox than
> > > have to go hunting for them and then awkwardly replying to them (and
> > > yes, I know there are ways to do that, I just personally find it
> > > annoying).  I figure we are all deluged with email on a daily basis
> > > and have developed mechanisms to deal with that in a sane way, what is
> > > 29 more patches on the pile?
> >
> > Even better than the web interface, is find the message-id in any of the
> > emails you did get, and run
> >
> > b4 mbox 20220922151728.1557914-1-brauner@kernel.org
> >
> > In general I'd agree with sending the whole set to the lsm list, but
> > then one needs to start knowing which lists do and don't want the whole
> > set...  b4 mbox and lei are now how I read all kernel related lists.
> 
> In my opinion, sending the entire patchset to the relevant lists
> should be the default for all the reasons mentioned above.  All the
> other methods are fine, and I don't want to stop anyone from using
> their favorite tool, but *requiring* the use of a separate tool to
> properly review and comment on patches gets us away from the
> email-is-universal argument.  Yes, all the other tools mentioned are
> still based in a world of email, but if you are not emailing the
> relevant stakeholders directly (or indirectly via a list), you are
> placing another hurdle in front of the reviewers by requiring them to
> leave their email client based workflow and jump over to lore, b4,
> etc. to review the patchset.
> 
> The lore.kernel.org instance is wonderful, full stop, and the b4 tool
> is equally wonderful, full stop, but they are tools intended to assist
> and optimize; they should not replace the practice of sending patches,
> with the full context, to the relevant parties.

I'm happy to send all of v2 to the security mailing list.

But for v1 could you compromise and just use b4?

b4 mbox 20220922151728.1557914-1-brauner@kernel.org

This would mean you could provide reviews for v1 and we don't need to
fragment the v1 discussion because of a resend to include a mailing list.
