Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E1472030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 05:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhLME7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 23:59:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhLME7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:59:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DFB01F3B0;
        Mon, 13 Dec 2021 04:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639371578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2gChwyl/DClB5L/ZT8aeA5y8mUKecKjBiO/0QKY6kA=;
        b=EjXT775p7Ib4onLWPFpQRGtiEyslALZ9bZI7hc8yXChzHyJHZ9EjymDPHRmWnb3wI3EY1s
        vo9vutxlhmeMBMdUMMeEjbGVJWUQL5hb9PSTaFMoKMbuijj8cVdgI1cBNUzMjvcavizEkv
        dgBUeJhGUr9ykPpecP8Sbrk2A5kwuig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639371578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2gChwyl/DClB5L/ZT8aeA5y8mUKecKjBiO/0QKY6kA=;
        b=hqsL0TIql1g+XAQIVqyCnbaG2whzR8D/uS62k89KHb57moD27i3si5uDxcmNGIU2IL6eAM
        U8UcCBivlGAfW0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 282D613AAF;
        Mon, 13 Dec 2021 04:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N0DzNDXTtmGJSQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 04:59:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Jan Kara" <jack@suse.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Remove inode_congested()
In-reply-to: <YbbKjjFzIzSBJWCn@casper.infradead.org>
References: <163936868317.23860.5037433897004720387.stgit@noble.brown>,
 <163936886725.23860.2403757518009677424.stgit@noble.brown>,
 <YbbKjjFzIzSBJWCn@casper.infradead.org>
Date:   Mon, 13 Dec 2021 15:59:30 +1100
Message-id: <163937157093.22433.10907067066589299028@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Dec 2021, Matthew Wilcox wrote:
> On Mon, Dec 13, 2021 at 03:14:27PM +1100, NeilBrown wrote:
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fb9584641ac7..540aa0ea67ff 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -989,17 +989,6 @@ static inline int is_page_cache_freeable(struct page=
 *page)
> >  	return page_count(page) - page_has_private(page) =3D=3D 1 + page_cache_=
pins;
> >  }
> > =20
> > -static int may_write_to_inode(struct inode *inode)
> > -{
> > -	if (current->flags & PF_SWAPWRITE)
> > -		return 1;
> > -	if (!inode_write_congested(inode))
> > -		return 1;
> > -	if (inode_to_bdi(inode) =3D=3D current->backing_dev_info)
> > -		return 1;
> > -	return 0;
> > -}
>=20
> Why is it safe to get rid of the PF_SWAPWRITE and current->backing_dev_info
> checks?

Ask George Bool.
If inode_write_congested() returns False, then may_write_to_inode() will
always return True.

NeilBrown


>=20
> > @@ -1158,8 +1147,6 @@ static pageout_t pageout(struct page *page, struct =
address_space *mapping)
> >  	}
> >  	if (mapping->a_ops->writepage =3D=3D NULL)
> >  		return PAGE_ACTIVATE;
> > -	if (!may_write_to_inode(mapping->host))
> > -		return PAGE_KEEP;
> > =20
> >  	if (clear_page_dirty_for_io(page)) {
> >  		int res;
>=20
>=20
