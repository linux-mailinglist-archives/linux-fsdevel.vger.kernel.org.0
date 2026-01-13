Return-Path: <linux-fsdevel+bounces-73514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55046D1B62C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6239301D5B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D3329E7E;
	Tue, 13 Jan 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zAHXw+yz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ut5XmWOq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zAHXw+yz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ut5XmWOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6B2EDD45
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339494; cv=none; b=McXz+A+4BL7894HePvV7HiUCYZS2caM1erD9HmcnTZJLPI8IzKpixb1jP8WA1jnJlcPDACPT8lL74IYhyVEXyuLoZhYrVaS++IrSpazL9N58v6s7dw/SpGVeUGoe+20bqE/riL1RFP2I+Tu9FCEUVU5E/6lqyrbxuuh2PYjCeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339494; c=relaxed/simple;
	bh=uVM8E5K8SyMkz2Vb23Vk0V2k2g0gG9sRz7WbONugAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo3I+XL3q+La3afmvpjgF/XklnZxmuF/Ci3gpaRHbbI/W/OYCJk69rbxjc0+dgCh4c2ShMhYMMj+v1FRT9HnvdLcHNptwfCqvzNxojWKmJyOBeswST4BlE13ZPKOpu6D1C/2VPHsLUf5Ba2D6HQqy0DpyjG1nOI6vCOT8UZ5GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zAHXw+yz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ut5XmWOq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zAHXw+yz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ut5XmWOq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38386336B1;
	Tue, 13 Jan 2026 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768339491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aBeaCgwapimJJ5j24O6e37UmEpMn7TZLbjKK2UNpCXU=;
	b=zAHXw+yzxki8EaRv8pIoV8pqvGM1amJDuwoeGhAQqIGW/92iLVY1FpbKSAFGri8MgHFSJc
	BYOOj/idfwS7UzwzzKf2aIhlCPLJSxYs/Nb2eOzUlQh96AW0Q2Y5Gb5RNzZzowCwn5DlmT
	rQZnJwwe02JphO5C4o/63XO5FuIU80M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768339491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aBeaCgwapimJJ5j24O6e37UmEpMn7TZLbjKK2UNpCXU=;
	b=ut5XmWOqQSZhtqlFc5+WKaoB/bYR9KaQBlJ6IzBEZTGzCCP62w7rJoeFFQ5hV/4TzWSwhL
	MPzlSpC1XPBSgDCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768339491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aBeaCgwapimJJ5j24O6e37UmEpMn7TZLbjKK2UNpCXU=;
	b=zAHXw+yzxki8EaRv8pIoV8pqvGM1amJDuwoeGhAQqIGW/92iLVY1FpbKSAFGri8MgHFSJc
	BYOOj/idfwS7UzwzzKf2aIhlCPLJSxYs/Nb2eOzUlQh96AW0Q2Y5Gb5RNzZzowCwn5DlmT
	rQZnJwwe02JphO5C4o/63XO5FuIU80M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768339491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aBeaCgwapimJJ5j24O6e37UmEpMn7TZLbjKK2UNpCXU=;
	b=ut5XmWOqQSZhtqlFc5+WKaoB/bYR9KaQBlJ6IzBEZTGzCCP62w7rJoeFFQ5hV/4TzWSwhL
	MPzlSpC1XPBSgDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DABF3EA63;
	Tue, 13 Jan 2026 21:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +D8RByO4ZmkpYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Jan 2026 21:24:51 +0000
Date: Tue, 13 Jan 2026 22:24:49 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
Message-ID: <20260113212449.GA26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768307858.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768307858.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Jan 13, 2026 at 12:39:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs has copies of two unexported functions from fs/namei.c
> used in the snapshot/subvolume creation and deletion. This patchset
> exports those functions and makes btrfs use them, to avoid duplication
> and the burden of keeping the copies up to date.
> 
> V2: Updated changelog of patch 4/4 to mention the btrfs copy misses a
>     call to audit_inode_child().
> 
> Link to V1: https://lore.kernel.org/linux-btrfs/cover.1767801889.git.fdmanana@suse.com/
> 
> Filipe Manana (4):
>   fs: export may_delete() as may_delete_dentry()
>   fs: export may_create() as may_create_dentry()
>   btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
>   btrfs: use may_create_dentry() in btrfs_mksubvol()

Reviewed-by: David Sterba <dsterba@suse.com>

