Return-Path: <linux-fsdevel+bounces-184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D279C7C7086
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA54282B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B542421C;
	Thu, 12 Oct 2023 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L7p0c+y7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7vo2vVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1E6123
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:42:49 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58284B8;
	Thu, 12 Oct 2023 07:42:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C368C21899;
	Thu, 12 Oct 2023 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697121766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBONdLWW5ZhlXA0fL/GHc+x8uvWg1IlMsTSWZwrIWBs=;
	b=L7p0c+y7daLg5keyxjWIlcF6crevrCD1/mrmKxY+espRtapFQlZJ6mTfJKxliPbfsiC0Zk
	jH6pS6Kya3P7cQ+ucjJcXhM/TrfxhfNZo1VUbkA8AZx016pIfYuoKmqIUhirA4VJOirkDq
	0EgKNKSWvRGF3RsAFFC8TYZcTaMPkDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697121766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBONdLWW5ZhlXA0fL/GHc+x8uvWg1IlMsTSWZwrIWBs=;
	b=J7vo2vVBn3fUELiY4SRqm5W1alKUsAA71+aDqjN4NwgWqJelWk9OSdwSnY1rIMN3gPe5Qv
	1ExJHgq3GaibDOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF9A0139F9;
	Thu, 12 Oct 2023 14:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Sw/OKuYFKGXVHQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 14:42:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E53FA06B0; Thu, 12 Oct 2023 16:42:46 +0200 (CEST)
Date: Thu, 12 Oct 2023 16:42:46 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231012144246.h3mklfe52gwacrr6@quack3>
References: <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu>
 <20231011172606.mztqyvclq6hq2qa2@quack3>
 <20231012142918.GB255452@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012142918.GB255452@mit.edu>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FREEMAIL_CC(0.00)[suse.cz,kernel.org,ionos.com,redhat.com,gmail.com,suse.com,vger.kernel.org,lists.sourceforge.net,fujitsu.com]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu 12-10-23 10:29:18, Theodore Ts'o wrote:
> On Wed, Oct 11, 2023 at 07:26:06PM +0200, Jan Kara wrote:
> > I don't think this is accurate. posix_acl_create() needs unmasked 'mode'
> > because instead of using current_umask() for masking it wants to use
> > whatever is stored in the ACLs as an umask.
> > 
> > So I still think we need to keep umask handling in both posix_acl_create()
> > and vfs_prepare_mode(). But filesystem's only obligation would be to call
> > posix_acl_create() if the inode is IS_POSIXACL. No more caring about when
> > to apply umask and when not based on config or mount options.
> 
> Ah, right, thanks for the clarification.  I *think* the following
> patch in the ext4 dev branch (not yet in Linus's tree, but it should
> be in linux-next) should be harmless, though, right?  And once we get
> the changes in vfs_prepare_mode() we can revert in ext4 --- or do
> folks I think I should just drop it from the ext4 dev branch now?

It definitely does no harm. As you say, you can revert it once the VFS
changes land if you want.

								Honza

> commit 484fd6c1de13b336806a967908a927cc0356e312
> Author: Max Kellermann <max.kellermann@ionos.com>
> Date:   Tue Sep 19 10:18:23 2023 +0200
> 
>     ext4: apply umask if ACL support is disabled
>     
>     The function ext4_init_acl() calls posix_acl_create() which is
>     responsible for applying the umask.  But without
>     CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
>     and nobody applies the umask.
>     
>     This fixes a bug which causes the umask to be ignored with O_TMPFILE
>     on ext4:
>     
>      https://github.com/MusicPlayerDaemon/MPD/issues/558
>      https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
>      https://bugzilla.kernel.org/show_bug.cgi?id=203625
>     
>     Reviewed-by: "J. Bruce Fields" <bfields@redhat.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>     Link: https://lore.kernel.org/r/20230919081824.1096619-1-max.kellermann@ionos.com
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> index 0c5a79c3b5d4..ef4c19e5f570 100644
> --- a/fs/ext4/acl.h
> +++ b/fs/ext4/acl.h
> @@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
>  static inline int
>  ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
>  {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	   ext4 ACL support is disabled at compile time, we need to do
> +	   it here, because posix_acl_create() will never be called */
> +	inode->i_mode &= ~current_umask();
> +
>  	return 0;
>  }
>  #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

