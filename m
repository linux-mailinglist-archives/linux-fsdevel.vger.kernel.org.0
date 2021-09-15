Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40240BF4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 07:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhIOF1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 01:27:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhIOF1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:27:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0169420160;
        Wed, 15 Sep 2021 05:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631683547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rpIEUD5so8R8lo0Kya+cAjrjZjxenoFRV8Funr8FNM=;
        b=HTkyFs6MSrLXg0WBmwRpij6M/0GLyo+CxIVFJ6D35QRqYTjLRHmjsKpG6s5Zzl2evdpfYr
        68nSBxVD+NMBGCugWu5SX5T+DonUBOalYurNLVbK1LDv96kXAGvXKmO+OH10e3fusaGBBl
        3cL/i9CpPhzR3L4AhN/PzHB28ontTC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631683547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rpIEUD5so8R8lo0Kya+cAjrjZjxenoFRV8Funr8FNM=;
        b=p5hccMX/1F9hQZbpKyU9G4EyM6UQTSNuOyG/CFWbr3Ir97QT7dTE0v3+g1uze/1KReNTqY
        bQHsvo598OY4T+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B76013C12;
        Wed, 15 Sep 2021 05:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YA0zEteDQWHtYAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 15 Sep 2021 05:25:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
In-reply-to: <YUE+L19JyjqWh+Md@mit.edu>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838437.13293.14244628630141187199.stgit@noble.brown>,
 <YUE+L19JyjqWh+Md@mit.edu>
Date:   Wed, 15 Sep 2021 15:25:40 +1000
Message-id: <163168354018.3992.580533638417199797@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Sep 2021, Theodore Ts'o wrote:
> On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> >=20
> > Of particular interest is the ext4_journal_start family of calls which
> > can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> > as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> > a high bit, so it is safe in practice.
>=20
> I'm really not fond of this type blurring.  What I'd suggeset doing
> instead is adding a "gfp_t gfp_mask" parameter to the
> __ext4_journal_start_sb().  With the exception of one call site in
> fs/ext4/ialloc.c, most of the callers of __ext4_journal_start_sb() are
> via #define helper macros or inline funcions.  So it would just
> require adding a GFP_NOFS as an extra parameter to the various macros
> and inline functions which call __ext4_journal_start_sb() in
> ext4_jbd2.h.
>=20
> The function ext4_journal_start_with_revoke() is called exactly once
> so we could just bury the __GFP_NOFAIL in the definition of that
> macros, e.g.:
>=20
> #define ext4_journal_start_with_revoke(inode, type, blocks, revoke_creds) \
> 	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
> 			     GFP_NOFS | __GFP_NOFAIL, (revoke_creds))
>=20
> but it's probably better to do something like this:
>=20
> #define ext4_journal_start_with_revoke(gfp_mask, inode, type, blocks, revok=
e_creds) \
> 	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
> 			     gfp_mask, (revoke_creds))
>=20
> So it's explicit in the C function ext4_ext_remove_space() in
> fs/ext4/extents.c that we are explicitly requesting the __GFP_NOFAIL
> behavior.
>=20
> Does that make sense?

Mostly.
Adding gfp_mask to __ext4_journal_start_sb() make perfect sense.
There doesn't seem much point adding one to __ext4_journal_start(),
we can have ext4_journal_start_with_revoke() call
__ext4_journal_start_sb() directly.
But I cannot see what it doesn't already do that.
i.e. why have the inline __ext4_journal_start() at all?
Is it OK if I don't use that for ext4_journal_start_with_revoke()?

Thanks,
NeilBrown
