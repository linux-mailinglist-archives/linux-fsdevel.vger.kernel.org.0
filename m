Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964BA5B118B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIHAom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiIHAoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:44:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071EE3F;
        Wed,  7 Sep 2022 17:44:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8257620A26;
        Thu,  8 Sep 2022 00:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662597873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vd0IdToeuUhRReKl6MOxK3dVsUzX7GC8yI72U+Yuyyg=;
        b=0KaLBy+0bjMkKcidZXtSXkpNimV7ISQ+XlWwMNBE6gcZM5nmitzoRdN0v3/bJJHyEG5PT9
        TiGmRzrcLK7qWPEu+uK/WGXJFqP/pp0gVY6PlF2wKmN0xJqlm3mMLDMSuW2nOb08ynPn/K
        h4C0Sz8gOZzfPI9hVhlXTdODJkmdaeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662597873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vd0IdToeuUhRReKl6MOxK3dVsUzX7GC8yI72U+Yuyyg=;
        b=yD/+9aK7KGPC6XXdWQ70geS3V0xmDA1X2y1FJPqRLaqKTpS89v4Lc6eXf+WU+e1Xa06kxl
        DFsNH7TEUuTyxsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A261339E;
        Thu,  8 Sep 2022 00:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGonHuk6GWMzCgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 00:44:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <20220907135153.qvgibskeuz427abw@quack3>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>
Date:   Thu, 08 Sep 2022 10:44:22 +1000
Message-id: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 07 Sep 2022, Jan Kara wrote:
> On Wed 07-09-22 09:12:34, Jeff Layton wrote:
> > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with res=
pect to the
> > > > > > +other changes in the inode. On a write, for instance, the i_vers=
ion it usually
> > > > > > +incremented before the data is copied into the pagecache. Theref=
ore it is
> > > > > > +possible to see a new i_version value while a read still shows t=
he old data.
> > > > >=20
> > > > > Doesn't that make the value useless?
> > > > >=20
> > > >=20
> > > > No, I don't think so. It's only really useful for comparing to an old=
er
> > > > sample anyway. If you do "statx; read; statx" and the value hasn't
> > > > changed, then you know that things are stable.=20
> > >=20
> > > I don't see how that helps.  It's still possible to get:
> > >=20
> > > 		reader		writer
> > > 		------		------
> > > 				i_version++
> > > 		statx
> > > 		read
> > > 		statx
> > > 				update page cache
> > >=20
> > > right?
> > >=20
> >=20
> > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > that case, maybe this is useless then other than for testing purposes
> > and userland NFS servers.
> >=20
> > Would it be better to not consume a statx field with this if so? What
> > could we use as an alternate interface? ioctl? Some sort of global
> > virtual xattr? It does need to be something per-inode.
>=20
> I was thinking how hard would it be to increment i_version after updating
> data but it will be rather hairy. In particular because of stuff like
> IOCB_NOWAIT support which needs to bail if i_version update is needed. So
> yeah, I don't think there's an easy way how to provide useful i_version for
> general purpose use.
>=20

Why cannot IOCB_NOWAIT update i_version?  Do we not want to wait on the
cmp_xchg loop in inode_maybe_inc_iversion(), or do we not want to
trigger an inode update?

The first seems unlikely, but the second seems unreasonable.  We already
acknowledge that after a crash iversion might go backwards and/or miss
changes.

Thanks,
NeilBrown
