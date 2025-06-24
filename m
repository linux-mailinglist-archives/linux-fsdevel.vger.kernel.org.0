Return-Path: <linux-fsdevel+bounces-52780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E4AE684F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E33163CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594712D131D;
	Tue, 24 Jun 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw+YOyXD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqcqrrGo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGbJ/diV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQVCPeFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E728468E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774542; cv=none; b=f1Z+bRTFtvxaKFiZdL9ayBaYNr4+Rxx9FuqQqDKMnHqPd8bNJRUldVbgDy2IQzLtGD0i4QOcvMSS0A9VtcXz6p7xjXyJJ64+MqnQuXhbg74L/3P0gq+ivtW5aSD3rn0petKQoAk605G2et/5M46jkNyEeb7ocmndrhJEuEKysig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774542; c=relaxed/simple;
	bh=2Nu9HAWxpF/eyUgE9UWYYNCVDg9Ux1COtHr6h6IMrZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx6spqwKhj1Pu0ZqNDWY6mxnnG2zxPH0AF1IegV8ANmyUzKE6lFcPM9s27LBTc9bnYUx5YV6DtOW4rnkG/7zu3h1UiEdilpwmo/AUVKoF4cOh0zOb0yIWj6Rom7AahSohvzMCkw9wneNnHiox1wh1YZxrYv675b+/3sGlxpqCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aw+YOyXD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqcqrrGo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGbJ/diV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQVCPeFc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24D601F455;
	Tue, 24 Jun 2025 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750774539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FyltukVHRK6asImG9DlCa6G1w7yiSL2OH6R7FM1c2V0=;
	b=Aw+YOyXDO4/r1ttxQJos87UMEzK4pDEdYTVD5W1iHvC3FgM/0sArsdQaT/sDGZkPvuzd0r
	RBU40jYjQf6T2WvxzKtOMnP3ai0H/5iwyC0mWdslvl1vY76LreLcHV7ZRY0nub4EezYuZ8
	ZNxApMH/kuy9ON8ecMAQS6nl+JA6pBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750774539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FyltukVHRK6asImG9DlCa6G1w7yiSL2OH6R7FM1c2V0=;
	b=AqcqrrGoxZBZOqodwOdDJvu+maiX4tlfZek+GP5pCCDEXbwWU1akrqnyXdn2x8HmQ9brTD
	NyTnhYnvDegiavDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qGbJ/diV";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qQVCPeFc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750774538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FyltukVHRK6asImG9DlCa6G1w7yiSL2OH6R7FM1c2V0=;
	b=qGbJ/diVcKOt8k7jB61CY5rvO8FG9bDsnRtowdy/PVNdJsvIzhqxkBzy0PGII0y+sjRP+E
	WFvpNYHUHXHYUGQVwpLm5wOsX6EkjQM2QvpmqxQryUMXvzIbLa5iXkI39g1d9YMrFEA7tY
	AJB3eWIP81u4PxfLxFBjeWTMKm5u5Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750774538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FyltukVHRK6asImG9DlCa6G1w7yiSL2OH6R7FM1c2V0=;
	b=qQVCPeFc/BHw9EPnR9Gv5DpGCainpbBes5WDY0NLELUPob7Wt9+s3bUZHeI4HLriihguvV
	wSSKH9oFTUOodvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A6213A24;
	Tue, 24 Jun 2025 14:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gTv+BQqzWmjqeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 14:15:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97779A0A03; Tue, 24 Jun 2025 16:15:37 +0200 (CEST)
Date: Tue, 24 Jun 2025 16:15:37 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@kernel.org
Subject: Re: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at()
 purely based on file handle
Message-ID: <z4gavwmwinr6me7ufmwk7y6vi7jfwwbv5bksrk4v4saochb3va@zxchg3jqz2x4>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-teestube-noten-cbe0aa9542e1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-teestube-noten-cbe0aa9542e1@brauner>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 24D601F455
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 24-06-25 12:59:26, Christian Brauner wrote:
> > For pidfs this means a file handle can function as full replacement for
> > storing a pid in a file. Instead a file handle can be stored and
> > reopened purely based on the file handle.
> 
> One thing I want to comment on generally. I know we document that a file
> handle is an opaque thing and userspace shouldn't rely on the layout or
> format (Propably so that we're free to redefine it.).
> 
> Realistically though that's just not what's happening. I've linked Amir
> to that code already a few times but I'm doing it here for all of you
> again:
> 
> [1]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/cgroup-util.c#L62-L77
> 
>      Specifically:
>      
>      /* The structure to pass to name_to_handle_at() on cgroupfs2 */
>      typedef union {
>              struct file_handle file_handle;
>              uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
>      } cg_file_handle;
>      
>      #define CG_FILE_HANDLE_INIT                                     \
>              (cg_file_handle) {                                      \
>                      .file_handle.handle_bytes = sizeof(uint64_t),   \
>                      .file_handle.handle_type = FILEID_KERNFS,       \
>              }
>      
>      #define CG_FILE_HANDLE_CGROUPID(fh) (*CAST_ALIGN_PTR(uint64_t, (fh).file_handle.f_handle))
>      
>      cg_file_handle fh = CG_FILE_HANDLE_INIT;
>      CG_FILE_HANDLE_CGROUPID(fh) = id;
>      
>      return RET_NERRNO(open_by_handle_at(cgroupfs_fd, &fh.file_handle, O_DIRECTORY|O_CLOEXEC));
> 
> Another example where the layout is assumed to be uapi/uabi is:
> 
> [2]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/pidfd-util.c#L232-L259
> 
>      int pidfd_get_inode_id_impl(int fd, uint64_t *ret) {
>      <snip>
>                      union {
>                              struct file_handle file_handle;
>                              uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
>                      } fh = {
>                              .file_handle.handle_bytes = sizeof(uint64_t),
>                              .file_handle.handle_type = FILEID_KERNFS,
>                      };
>                      int mnt_id;
>      
>                      r = RET_NERRNO(name_to_handle_at(fd, "", &fh.file_handle, &mnt_id, AT_EMPTY_PATH));
>                      if (r >= 0) {
>                              if (ret)
>                                      *ret = *CAST_ALIGN_PTR(uint64_t, fh.file_handle.f_handle);
>                              return 0;
>                      }

Thanks for sharing. Sigh... Personal note for the future: If something
should be opaque blob for userspace, don't forget to encrypt the data
before handing it over to userspace. :-P

> In (1) you can see that the layout is assumed to be uabi by
> reconstructing the handle. In (2) you can see that the layout is assumed
> to be uabi by extrating the inode number.
> 
> So both points mean that the "don't rely on it"-ship has already sailed.
> If we get regressions reports for this (and we surely would) because we
> changed it we're bound by the no-regression rule.

Yep, FILEID_KERNFS is pretty much set in stone. OTOH I don't expect these
kinds of hacks to be very widespread (I guess I'm naive ;) so if we really
need to change it we could talk to systemd folks.

> So, for pidfs I'm very tempted to explicitly give the guarantee that
> systemd just assumes currently.
> 
> The reason is that it will allow userspace to just store the 64-bit
> pidfs inode number in a file or wherever they want and then reconstruct
> the file handle without ever having to involve name_to_handle_at(). That
> means you can just read the pid file and see the inode number you're
> dealing with and not some binary gunk.

Well, you could just fprintf() the fhandle into the pid file if you don't
like binary gunk. Those numbers would be telling about as much as the pidfs
inode number tells you, don't they? I mean I'm still not at the point where
I would *encourage* userspace to decode what's supposed to be opaque blob
;). But maybe I'll get used to that idea...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

