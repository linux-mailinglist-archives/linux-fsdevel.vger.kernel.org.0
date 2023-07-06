Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC179749650
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjGFHW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjGFHWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282451BDB;
        Thu,  6 Jul 2023 00:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE6A618A2;
        Thu,  6 Jul 2023 07:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E585FC433C8;
        Thu,  6 Jul 2023 07:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688628145;
        bh=mTqcntv6zliRak8f606XrB+nqmgw/ljWWCMvyQDtXvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAmbIVETUw0vOf692rxyFJfdGnrGpcWcxdSoW0r9DoulOPBGqrh62lAt6ICkg5mkG
         YJ0+2FzdZTOv0qewcd64QRKEaoCVCmzy0P15ObXBGToG2a8Lt1Eg3SO7GCaVtr4g1r
         WiEf11Zqz/nB5kgOx+G8FHCSDpN8MDeRhsbgxjksisbxDMYGCQU5Srm14lbeuVKLs/
         g2fv+8yYApJnVcBZK8AIG80F3SmOa7kz7AsNBGBxllGjfGTfFczSQWXPDI/y78+APW
         njQCKej9nbugXPCr/3tDJufqbHogE6sdalPYxyvK0xNhwMtvHCtmqL9Uf60/tbH/zO
         DKaXAwOtel/2g==
Date:   Thu, 6 Jul 2023 09:22:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Alexey Gladkov <legion@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <20230706-raffgierig-geeilt-7cea6d731194@brauner>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
 <20230704-anrollen-beenden-9187c7b1b570@brauner>
 <CAADnVQLAhDepRpbbi_EU6Ca3wnuBtSuAPO9mE6pGoxj8i9=caQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLAhDepRpbbi_EU6Ca3wnuBtSuAPO9mE6pGoxj8i9=caQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 06:10:32PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 4, 2023 at 6:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > > +/**
> > > > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > > > + * @mnt: the mount to check
> > > > + *
> > > > + * Return: true if mount is mapped, false if not.
> > > > + */
> > > > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > > > +{
> > > > +   return is_idmapped_mnt(mnt);
> > > > +}
> ...
> >
> > I don't want any of these helpers as kfuncs as they are peeking deeply
> > into implementation details that we reserve to change. Specifically in
> > the light of:
> >
> >     3. kfunc lifecycle expectations part b):
> >
> >     "Unlike with regular kernel symbols, this is expected behavior for BPF
> >      symbols, and out-of-tree BPF programs that use kfuncs should be considered
> >      relevant to discussions and decisions around modifying and removing those
> >      kfuncs. The BPF community will take an active role in participating in
> >      upstream discussions when necessary to ensure that the perspectives of such
> >      users are taken into account."
> >
> > That's too much stability for my taste for these helpers. The helpers
> > here exposed have been modified multiple times and once we wean off
> > idmapped mounts from user namespaces completely they will change again.
> > So I'm fine if they're traceable but not as kfuncs with any - even
> > minimal - stability guarantees.
> 
> Christian,
> That quote is taken out of context.
> In the first place the Documentation/bpf/kfuncs.rst says:
> "
> kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
> strict stability restrictions associated with kernel <-> user UAPIs. This means
> they can be thought of as similar to EXPORT_SYMBOL_GPL, and can therefore be
> modified or removed by a maintainer of the subsystem they're defined in when
> it's deemed necessary.
> "
> 
> bpf_get_file_vfs_ids is vfs related, so you guys decide when and how
> to add/remove them. It's ok that you don't want this particular one
> for whatever reason, but that reason shouldn't be 'stability guarantees'.
> There are really none. The kernel kfuncs can change at any time.
> There are plenty of examples in git log where we added and then
> tweaked/removed kfuncs.
> 
> The doc also says:
> "
> As described above, while sometimes a maintainer may find that a kfunc must be
> changed or removed immediately to accommodate some changes in their subsystem,
> "
> and git log of such cases proves the point.
> 
> The quote about out-of-tree bpf progs is necessary today, since
> very few bpf progs are in-tree, so when maintainers of a subsystem
> want to remove kfunc the program authors need something in the doc
> to point to and explain why and how they use the kfunc otherwise
> maintainers will just say 'go away. you're out-of-tree'.
> The users need their voice to be heard. Even if the result is the same.
> In other words the part you quoted is needed to make kfuncs usable.
> Otherwise 'kfunc is 100% unstable and maintainers can rename it
> every release just to make life of bpf prog writers harder'
> becomes a real possibility in the minds of bpf users.
> The kfunc doc makes it 100% clear that there are no stability guarantees.
> So please don't say 'minimal stability'.
> 
> In your other reply:
> 
> > we can look at the in-kernel users of is_idmapped_mnt(),
> > convert them and then kill this thing off if we wanted to.
> 
> you can absolutely do that even if is_idmapped_mnt() is exposed as a kfunc.
> You'll just delete it with zero notice if you like.
> Just like what you would do with a normal export_symbol.
> The doc is pretty clear about it and there are examples where we did
> such things.

I think I said it somewhere else: I'm not opposing your position on
kfruncs in a sense I understand that's kinda the model that you have to
push for. But you have to admit that this out-of-tree portion is very
hard to swallow if you've been hit by out of tree modules and their
complaints about removed EXPORT_SYMBOL*()s.

I'm still rather hesitant about this because I find it hard to figure
out how this will go down in practice. But, especially with the internal
idmapped mount api. This is a very hidden and abstracted away
implementation around an opaque type and I'm not yet ready to let
modules or bpf programs peek into it's implementation details. I hope
that's understandable.
