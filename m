Return-Path: <linux-fsdevel+bounces-57-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDA7C52E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769112828D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600761F160;
	Wed, 11 Oct 2023 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P93Y+I3j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLds2aSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A01078D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:07:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07191;
	Wed, 11 Oct 2023 05:07:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 188F321860;
	Wed, 11 Oct 2023 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697026017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULWC15oexVFAzs0lRcAcAF0IvOr+w9GqABbuWoIc/Yg=;
	b=P93Y+I3jvub3oHkwH/c1R/KMW/S6/KfvMrZH3pAYZCdKewGtpg9u/a80DI7uZrktX4dHNl
	Y7Vp057m/REZQdTl//uTh+JQg5DqrB4d3JvxuITbMRN+hytAzWUo2oYn8dNfqwIV6AvJ5V
	ov63y0wUM+M2GLeYr5DVRNsdL4HnE+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697026017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULWC15oexVFAzs0lRcAcAF0IvOr+w9GqABbuWoIc/Yg=;
	b=FLds2aSoOcZyIorbLDPOi9qbQP5BlAZxrWVsuKFI0gLaV5yAB64MylJ7VZgv4eEFqjrAoQ
	4MkrzgM8XU07vsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9BBB134F5;
	Wed, 11 Oct 2023 12:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rW9JNOCPJmUgHgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 12:06:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06012A05BC; Wed, 11 Oct 2023 14:06:56 +0200 (CEST)
Date: Wed, 11 Oct 2023 14:06:55 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jan Kara <jack@suse.cz>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Christian Brauner <brauner@kernel.org>,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011120655.ndb7bfasptjym3wl@quack3>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.40
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 FREEMAIL_CC(0.00)[suse.cz,redhat.com,gmail.com,kernel.org,suse.com,vger.kernel.org,lists.sourceforge.net,fujitsu.com]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 12:51:12, Max Kellermann wrote:
> On Wed, Oct 11, 2023 at 12:05 PM Jan Kara <jack@suse.cz> wrote:
> > So I've checked some more and the kernel doc comments before
> > mode_strip_umask() and vfs_prepare_mode() make it pretty obvious - all
> > paths creating new inodes must be calling vfs_prepare_mode(). As a result
> > mode_strip_umask() which handles umask stripping for filesystems not
> > supporting posix ACLs. For filesystems that do support ACLs,
> > posix_acl_create() must be call and that handles umask stripping. So your
> > fix should not be needed. CCed some relevant people for confirmation.
> 
> Thanks, Jan. Do you think the documentation is obvious enough, or
> shall I look around and try to improve the documentation? I'm not a FS
> expert, so it may be just my fault that it confused me.... I just
> analyzed the O_TMPFILE vulnerability four years ago (because it was
> reported to me as the maintainer of a userspace software).
> 
> Apart from my doubts that this API contract is too error prone, I'm
> not quite sure if all filesystems really implement it properly.
> 
> For example, overlayfs unconditionally sets SB_POSIXACL, even if the
> kernel has no ACL support. Would this ignore the umask? I'm not sure,
> overlayfs is a special beast.
> Then there's orangefs which allows setting the "acl" mount option (and
> thus SB_POSIXACL) even if the kernel has no ACL support. Same for gfs2
> and maybe cifs, maybe more, I didn't check them all.

Indeed, *that* looks like a bug. Good spotting! I'd say posix_acl_create()
defined in include/linux/posix_acl.h for the !CONFIG_FS_POSIX_ACL case
should be stripping mode using umask. Care to send a patch for this?

> The "mainstream" filesystems like ext4 seem to be implemented
> properly, though this is still too fragile for my taste... ext4 has
> the SB_POSIXACL code even if there's no kernel ACL support, but it is
> not reachable because EXT4_MOUNT_POSIX_ACL cannot be set from
> userspace in that case. The code looks suspicious, but is okay in the
> end - still not my taste.
> 
> I see so much redundant code regarding the "acl" mount option in all
> filesystems. I believe the API should be designed in a way that it is
> safe-by-default, and shouldn't need very careful considerations in
> each and every filesystem, or else all filesystems repeat the same
> mistakes until the last one gets fixed.

So I definitely agree that we should handle as many things as possible in
VFS without relying on filesystems to get it right. Thus I agree VFS should
do the right thing even if the filesystem sets SB_POSIXACl when
!CONFIG_FS_POSIX_ACL.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

