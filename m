Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA65BD7BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 00:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiISW5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiISW5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:57:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A7402D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 15:57:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABABF1F460;
        Mon, 19 Sep 2022 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663628228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qd3UtrQgtsnWkuX8PXPaAa6GoRKEcfbBXXHLviC71k=;
        b=IxcP1JWLC7dr+e6UCiQTpb936EZG375iAfvOscy0uNiF7/woMdBUADymM9k84c+YhX6Ww+
        MnrZM2wO1zDnVTXFTG0Dxb5KKHCYgx6yUnW/oHeIcYRZQMlAVfD5k9Bbv14uxqUroLr+2b
        7VspPwAhLYkJY5ORy5wuJZYWjyiUlxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663628228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qd3UtrQgtsnWkuX8PXPaAa6GoRKEcfbBXXHLviC71k=;
        b=bz6A+nr/dJOBl8GZo+NlGRB6ufhNd3c0BN+Q5o2vXlafXvYvGZ6UQk/wG5JVIyqv4ISzY1
        hbb31sD3zKraPvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A36213ABD;
        Mon, 19 Sep 2022 22:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BLa7C77zKGNFHAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 19 Sep 2022 22:57:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Miklos Szeredi" <mszeredi@redhat.com>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename race.
In-reply-to: <20220919082848.s7dwk4hwxxejwm7s@wittgenstein>
References: <20220221082002.508392-1-mszeredi@redhat.com>,
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>,
 <YyATCgxi9Ovi8mYv@ZenIV>,
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>,
 <YyEcqxthoso9SGI2@ZenIV>,
 <166330881189.15759.13499931397891560275@noble.neil.brown.name>,
 <CAOQ4uxgS5T=C6E=MeVXg0-kK7cdkXqbVCwnhmStb13yr4y0gxA@mail.gmail.com>,
 <20220919082848.s7dwk4hwxxejwm7s@wittgenstein>
Date:   Tue, 20 Sep 2022 08:56:42 +1000
Message-id: <166362820252.9160.14622721614019063947@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Sep 2022, Christian Brauner wrote:
> On Fri, Sep 16, 2022 at 05:32:45PM +0300, Amir Goldstein wrote:
> > On Fri, Sep 16, 2022 at 9:26 AM NeilBrown <neilb@suse.de> wrote:
> > >
> > >
> > > rename(2) is documented as
> > >
> > >        If newpath already exists, it will be atomically replaced, so
> > >        that there is no point at which another process attempting to
> > >        access newpath will find it missing.
> > >
> > > However link(2) from a given path can race with rename renaming to that
> > > path so that link gets -ENOENT because the path has already been unlink=
ed
> > > by rename, and creating a link to an unlinked file is not permitted.
> > >
> >=20
> > I have to ask. Is this a real problem or just a matter of respecting
> > the laws of this man page?
>=20
> I have to say that I have the same reaction. The commit message doesn't
> really explain where the current behavior becomes an issue and whether
> there are any users seeing issues with this. And the patch makes
> do_linkat() way more complex than it was before.
>=20

A bug is a bug .... and in this case it is an intriguing puzzle too.

Yes, the commit message could say a bit more about context.

The patch also isn't correct, so the complexity is not relevant in this
case.  Some complexity will likely been needed (I do have a really
simple patch that just retries the whole op, but I don't think that is
safe), and we do need to balance the complexity against the value.
Ideally we could end up making the code simpler ...  I'm not sure I can
manage that though :-)

Thanks,
NeilBrown
