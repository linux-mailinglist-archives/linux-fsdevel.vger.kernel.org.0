Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120A4ED7DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiCaKmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiCaKmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:42:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AAD1BBF41;
        Thu, 31 Mar 2022 03:40:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8F7721A96;
        Thu, 31 Mar 2022 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648723244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8owCFOGdBgMJU0Iqml5pU2HZkwo0/4bm7g2FKDqBZYo=;
        b=FeO2jFp6pCaMs3bkNgikpjP30Z9DTMJPsHGShbGCvJK1dcGGWZB1qM+cOYSygYW3ovk3dT
        WUAsr3l+rb7p6y0Hw5A5zaY0g4cqI06D3f5PTy/aeew3Q+4VemGJpC5hwDM0N06Pmf+zNa
        yaJyY0oXvLH2FydjzdXrov5ymGIoQEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648723244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8owCFOGdBgMJU0Iqml5pU2HZkwo0/4bm7g2FKDqBZYo=;
        b=GX+EjZHEekfsAik1nqrLFIq65Lc6VOU2ZScwWJv3rtRuyU00AmSjrWPp2hRg5Le271XpzJ
        g53AYG2k56STlHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31BC5133D4;
        Thu, 31 Mar 2022 10:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id arlGNyqFRWK2XwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 31 Mar 2022 10:40:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "David Disseldorp" <ddiss@suse.de>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS: filename_create(): fix incorrect intent.
In-reply-to: <20220331114949.02fae137@suse.de>
References: <164842900895.6096.10753358086437966517@noble.neil.brown.name>,
 <20220330101408.2bbb47ee@suse.de>,
 <164868118815.25542.13263176689793254608@noble.neil.brown.name>,
 <20220331114949.02fae137@suse.de>
Date:   Thu, 31 Mar 2022 21:40:39 +1100
Message-id: <164872323977.25542.8403385264176230518@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 31 Mar 2022, David Disseldorp wrote:
> On Thu, 31 Mar 2022 09:59:48 +1100, NeilBrown wrote:
>=20
> > On Wed, 30 Mar 2022, David Disseldorp wrote:
> > > Hi Neil,
> > >=20
> > > I gave this a spin and was wondering why xfstests wouldn't start with
> > > this change...
> > >=20
> > > On Mon, 28 Mar 2022 11:56:48 +1100, NeilBrown wrote:
> > > ... =20
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 3f1829b3ab5b..3ffb42e56a8e 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -3676,7 +3676,6 @@ static struct dentry *filename_create(int dfd, =
struct filename *name,
> > > >  	int type;
> > > >  	int err2;
> > > >  	int error;
> > > > -	bool is_dir =3D (lookup_flags & LOOKUP_DIRECTORY);
> > > > =20
> > > >  	/*
> > > >  	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
> > > > @@ -3698,9 +3697,11 @@ static struct dentry *filename_create(int dfd,=
 struct filename *name,
> > > >  	/* don't fail immediately if it's r/o, at least try to report other=
 errors */
> > > >  	err2 =3D mnt_want_write(path->mnt);
> > > >  	/*
> > > > -	 * Do the final lookup.
> > > > +	 * Do the final lookup.  Request 'create' only if there is no trail=
ing
> > > > +	 * '/', or if directory is requested.
> > > >  	 */
> > > > -	lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL;
> > > > +	if (!last.name[last.len] || (lookup_flags & LOOKUP_DIRECTORY))
> > > > +		lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL; =20
> > >=20
> > > This doesn't look right, as any LOOKUP_DIRECTORY flag gets dropped via
> > > the prior "lookup_flags &=3D LOOKUP_REVAL;". =20
> >=20
> > Arg.. thanks for testing - I clearly should have tested more broadly.
> >=20
> > I could leave the "is_dir" variable there I guess.
> > Or maybe the masking statement should be=20
> >     lookup_flags &=3D LOOKUP_REVAL | LOOKUP_DIRECTORY;
> > as that is a better match for the comment.
>=20
> Modifying "lookup_flags" results in changed filename_parentat() and
> __lookup_hash() parameters, which isn't an intended consequence IIUC. I
> think retaining "is_dir" would make sense.

I think retaining is_dir is ugly.
Given that LOOKUP_DIRECTORY is meaningful, why mask it off?

The only flag *ever* passed to filename_parentat() is LOOKUP_REVAL, so
maybe it would make sense to change the parameter to be called "reval"
to make the meaning more obvious.

The only other use of lookup_flags is to pass it to ->lookup().
I guess LOOKUP_DIRECTORY isn't really meaningful there .. though it does
say "this lookup is never for a non-directory"... might that be helpful?

Maybe I'll have another look in the morning.

Thanks,
NeilBrown
