Return-Path: <linux-fsdevel+bounces-762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D733C7CFD0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC90B21348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733C2FE09;
	Thu, 19 Oct 2023 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtKaJo3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7AlKnQYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B12FE07
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:40:38 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551118A;
	Thu, 19 Oct 2023 07:40:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45432210EA;
	Thu, 19 Oct 2023 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697726427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yWQ++yj3meNsM51OVma38ZOF7XpIW69AOySyO8IM0Y=;
	b=vtKaJo3fU0v4xPgYDe3J7ys1BQREGEf71+ieyhVmED1/RjuNNKtJulS7OGBBisg5hLbKwy
	ZA0lthUkbKlF65yIKXvYhAqD/0M49B1onOR1kCl/q+smWRojv6bwQI9NykPnt0qt+Abxgl
	n1NhmednkL6THWFZsZHk4sG9dhtqIcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697726427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yWQ++yj3meNsM51OVma38ZOF7XpIW69AOySyO8IM0Y=;
	b=7AlKnQYeH7OHkMWPmlNWOw67HQ58182uZcd10gyz9w1+M4PK6XdoD2EETLu+2QhbSFd6n4
	OP0rnqgXXDVJQVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31C541357F;
	Thu, 19 Oct 2023 14:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id t6wbDNs/MWV8CQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 14:40:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F12CA06B0; Thu, 19 Oct 2023 16:40:26 +0200 (CEST)
Date: Thu, 19 Oct 2023 16:40:26 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Steve French <sfrench@samba.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
Message-ID: <20231019144026.2qypsldg5hlca5zc@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-4-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.77
X-Spamd-Result: default: False [-2.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.67)[82.91%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,kernel.org,oracle.com,vger.kernel.org,suse.com,gmail.com,mit.edu,dilger.ca,mail.parknet.co.jp,infradead.org,nod.at,tuxera.com,paragon-software.com,samba.org,squashfs.org.uk,mail.ru]

On Wed 18-10-23 12:59:58, Amir Goldstein wrote:
> export_operations ->encode_fh() no longer has a default implementation to
> encode FILEID_INO32_GEN* file handles.
> 
> Rename the default helper for encoding FILEID_INO32_GEN* file handles to
> generic_encode_ino32_fh() and convert the filesystems that used the
> default implementation to use the generic helper explicitly.
> 
> This is a step towards allowing filesystems to encode non-decodeable file
> handles for fanotify without having to implement any export_operations.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one typo cleanup. Also I agree we need a "nop" variant of
generic_encode_ino32_fh() or move this to fs/libfs.c like e.g.
generic_fh_to_dentry().

> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 4d05b9862451..197ef78a5014 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when the devices are closed:
>  As this is a VFS level change it has no practical consequences for filesystems
>  other than that all of them must use one of the provided kill_litter_super(),
>  kill_anon_super(), or kill_block_super() helpers.
> +
> +---
> +
> +**mandatory**
> +
> +export_operations ->encode_fh() no longer has a default implementation to
> +encode FILEID_INO32_GEN* file handles.
> +Fillesystems that used the default implementation may use the generic helper
   ^^^ Filesystems

> +generic_encode_ino32_fh() explicitly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

