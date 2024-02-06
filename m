Return-Path: <linux-fsdevel+bounces-10409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A184ABB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C4E1F25752
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E531440C;
	Tue,  6 Feb 2024 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yumLhjsQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYx/F1CC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yumLhjsQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYx/F1CC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01010F4;
	Tue,  6 Feb 2024 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183604; cv=none; b=iF1HidprYGfAfaXDGBsaENICVO7a2+SjyxSwZny+1L7i7llKfjJ5K/JnNQGP/5qyOM5ilIrBZLj8aQZwLUB7nU82ChQXwoWLIS9Q+J7eA38PqcxEvRRscCvelr37XOr/SGBtXXTmOwU7xwZZFickGek3QwXGhunBsbJnKBLx4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183604; c=relaxed/simple;
	bh=NUhCdytWIdemudVvZdAo75J4H9K6/U8s01PbY/tbFn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx+dQ4ZF4mi/gBqMihBUPMDHfkI8Y2Gr0kMAIbLK9Hxy6UpOqwdHoaIHunPvqKtO740G8YIVN+/PS9QeJ8tbhodYFybYlVymodh0rgBL0A6r/9w53Kb8TJ+7EhJrluUZV9lEdFNiwOvtq3g4yAHIs4OKmU5RojZylLtfyATtk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yumLhjsQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYx/F1CC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yumLhjsQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYx/F1CC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 936CB1F383;
	Tue,  6 Feb 2024 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707183600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzTCSdyEgtc+IhXSe9CfexCQ9Mam0Tb3TrmRo3hIREE=;
	b=yumLhjsQdmx7zhc1Io3nWwsKM+5OnDCd1zMb5rD64iWlyyj4tNONPZqgVw/rXRt/b17dXO
	vNPQpfHBo1lMjfG+5s8xml/NwDGlX2s/yYOTDsvktLaJspFlJgjVlzT2cnuaxZiDrJ+1de
	X4EYvl1McK/vZOHFgH4iTwlD7ep9xd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707183600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzTCSdyEgtc+IhXSe9CfexCQ9Mam0Tb3TrmRo3hIREE=;
	b=AYx/F1CCr0KwKBZxmKBCFdSbCN18Gm56B92WYOuPi0WPwHm19cQ5g4RXca31Z1EweMjlLf
	Lx46bqWKcS9st8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707183600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzTCSdyEgtc+IhXSe9CfexCQ9Mam0Tb3TrmRo3hIREE=;
	b=yumLhjsQdmx7zhc1Io3nWwsKM+5OnDCd1zMb5rD64iWlyyj4tNONPZqgVw/rXRt/b17dXO
	vNPQpfHBo1lMjfG+5s8xml/NwDGlX2s/yYOTDsvktLaJspFlJgjVlzT2cnuaxZiDrJ+1de
	X4EYvl1McK/vZOHFgH4iTwlD7ep9xd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707183600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzTCSdyEgtc+IhXSe9CfexCQ9Mam0Tb3TrmRo3hIREE=;
	b=AYx/F1CCr0KwKBZxmKBCFdSbCN18Gm56B92WYOuPi0WPwHm19cQ5g4RXca31Z1EweMjlLf
	Lx46bqWKcS9st8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 713C2132DD;
	Tue,  6 Feb 2024 01:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ao2G/CNwWVICwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 01:40:00 +0000
Date: Tue, 6 Feb 2024 02:39:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <20240206013931.GK355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
 <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yumLhjsQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="AYx/F1CC"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.11 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.40)[90.89%]
X-Spam-Score: -4.11
X-Rspamd-Queue-Id: 936CB1F383
X-Spam-Flag: NO

On Mon, Feb 05, 2024 at 05:43:37PM -0500, Kent Overstreet wrote:
> On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
> > On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> > > @@ -231,6 +235,7 @@ struct fsxattr {
> > >  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> > >  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> > >  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> > > +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
> > 
> > 0x94 is btrfs, don't add things to their "name" space.
> 
> Can we please document this somewhere!?
> 
> What, dare I ask, is the "namespace" I should be using?

Grep for _IOCTL_MAGIC in include/uapi:

uapi/linux/aspeed-lpc-ctrl.h:#define __ASPEED_LPC_CTRL_IOCTL_MAGIC 0xb2
uapi/linux/aspeed-p2a-ctrl.h:#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
uapi/linux/bt-bmc.h:#define __BT_BMC_IOCTL_MAGIC        0xb1
uapi/linux/btrfs.h:#define BTRFS_IOCTL_MAGIC 0x94
uapi/linux/f2fs.h:#define F2FS_IOCTL_MAGIC              0xf5
uapi/linux/ipmi_bmc.h:#define __IPMI_BMC_IOCTL_MAGIC        0xB1
uapi/linux/pfrut.h:#define PFRUT_IOCTL_MAGIC 0xEE
uapi/rdma/rdma_user_ioctl.h:#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
uapi/rdma/rdma_user_ioctl_cmds.h:#define RDMA_IOCTL_MAGIC       0x1b

The label ioctls inherited the 0x94 namespace for backward
compatibility but as already said, it's the private namespace of btrfs.

