Return-Path: <linux-fsdevel+bounces-103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A207C5A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E951C20EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1939934;
	Wed, 11 Oct 2023 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kr/n4ozJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vFckiP0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F70A41
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:26:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F78F;
	Wed, 11 Oct 2023 10:26:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41B8B1F88E;
	Wed, 11 Oct 2023 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697045167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfP83Apuioc6QwrQ9hjnsK+t+FQBcuvjUeVK6xfxlsI=;
	b=kr/n4ozJKeSRcTxUWkUDER9ANl5ysmCMwwn5jTIuXq6Nu6vMj5OGtVTIryyeXynEv0QmeO
	Zhy+dX2NbiLj0xRMv3bNuTJxiIJCI00Tiw9klfnKBnexnxlLzGEBQtIuhmfuMsb7Thyr4o
	/FFuqr7fTzjwGe4evj+VqWiwjBiUb1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697045167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfP83Apuioc6QwrQ9hjnsK+t+FQBcuvjUeVK6xfxlsI=;
	b=vFckiP0JXcsJIYzBmUMHSKggcqEdsHzRu7vUKBWvlkifhsnhO+PiVl4DK8F327TFpVj4hK
	kaJA6pmCJtZVKrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D9E9138EF;
	Wed, 11 Oct 2023 17:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hsYaC6/aJmWpSAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 17:26:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0F75A06B0; Wed, 11 Oct 2023 19:26:06 +0200 (CEST)
Date: Wed, 11 Oct 2023 19:26:06 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Max Kellermann <max.kellermann@ionos.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011172606.mztqyvclq6hq2qa2@quack3>
References: <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011170042.GA267994@mit.edu>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 13:00:42, Theodore Ts'o wrote:
> On Wed, Oct 11, 2023 at 05:27:37PM +0200, Christian Brauner wrote:
> > Aside from that, the problem had been that filesystems like nfs v4
> > intentionally raised SB_POSIXACL to prevent umask stripping in the VFS.
> > IOW, for them SB_POSIXACL was equivalent to "don't apply any umask".
> > 
> > And afaict nfs v4 has it's own thing going on how and where umasks are
> > applied. However, since we now have the following commit in vfs.misc:
> > 
> >     fs: add a new SB_I_NOUMASK flag
> 
> To summarize, just to make sure I understand where we're going.  Since
> normally (excepting unusual cases like NFS), it's fine to strip the
> umask bits twice (once in the VFS, and once in the file system, for
> those file systems that are doing it), once we have SB_I_NOUMASK and
> NFS starts using it, then the VFS can just unconditionally strip the
> umask bits, and then we can gradually clean up the file system umask
> handling (which would then be harmlessly duplicative).
> 
> Did I get this right?

I don't think this is accurate. posix_acl_create() needs unmasked 'mode'
because instead of using current_umask() for masking it wants to use
whatever is stored in the ACLs as an umask.

So I still think we need to keep umask handling in both posix_acl_create()
and vfs_prepare_mode(). But filesystem's only obligation would be to call
posix_acl_create() if the inode is IS_POSIXACL. No more caring about when
to apply umask and when not based on config or mount options.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

