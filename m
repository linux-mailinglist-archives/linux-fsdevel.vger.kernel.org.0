Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10D4C6078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiB1A4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 19:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiB1A4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:56:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317F6E4CA;
        Sun, 27 Feb 2022 16:56:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44DA8218CE;
        Mon, 28 Feb 2022 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646009767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BMX+ZTu71y6pW6n3w8F+LKPlpMD1xGyNzpWEriNEMU=;
        b=1oVF7UvWyYQbKC/xLf9MsPR8L3YFujQtqWjDHI94j3Y6llbbBEk2LfEWhVw1RKXMvC0qBD
        AkIvIvUtlcpZCbTCf0+sxGGDUkQ+B9NLXEnYiMmkxnLDvm4StN1h694Ps83kJCvBCZAZj8
        EqUfKBdZeCUe1bXwMeZou2fTb0WkjDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646009767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BMX+ZTu71y6pW6n3w8F+LKPlpMD1xGyNzpWEriNEMU=;
        b=ZqAexWszEd97yVO/gMY1fUsKeCbC0z3zIfR0iYIdzKVOYZJIVYUn/GzIx+edrJvq14rJuV
        x5NUKrQjCITcUmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 852F2139BD;
        Mon, 28 Feb 2022 00:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LCeyD6QdHGLqPAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 28 Feb 2022 00:56:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Andreas Dilger" <adilger@dilger.ca>,
        "Dave Chinner" <david@fromorbit.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
In-reply-to: <20220224233848.GC8269@magnolia>
References: <164568221518.25116.18139840533197037520@noble.neil.brown.name>,
 <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca>,
 <20220224233848.GC8269@magnolia>
Date:   Mon, 28 Feb 2022 11:55:47 +1100
Message-id: <164600974741.15631.8678502963654197325@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Feb 2022, Darrick J. Wong wrote:
> On Thu, Feb 24, 2022 at 09:31:28AM -0700, Andreas Dilger wrote:
> > On Feb 23, 2022, at 22:57, NeilBrown <neilb@suse.de> wrote:
> > >=20
> > > for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; d=
one ) & done
>=20
> I think you want something faster here, like ln to hardlink an existing
> file into the directory.
>=20

And probably written in C too..

=20
> (I am also not a fan of "PAR_UPDATE", since 'par' is already an English
> word that doesn't mean 'parallel'.)

:-)
We already have DCACHE_PAR_LOOKUP for parallel lookups in a directory
(though it is really a lock bit and I think should be named as soch).
So it made sense to use DCACHE_PAR_UPDATE for parallel updates.
And then S_PAR_UPDATE for the inode flag to enable this seemed logical.

But I agree that these names are sub-par :-)

NeilBrown
