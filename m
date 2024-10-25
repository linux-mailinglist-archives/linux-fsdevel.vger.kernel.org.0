Return-Path: <linux-fsdevel+bounces-32919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D79B0C1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4CB1F223AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767802064E6;
	Fri, 25 Oct 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ownTWJ9L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VCK8/x2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ownTWJ9L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VCK8/x2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BD18C93B;
	Fri, 25 Oct 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878605; cv=none; b=gZ3626+HvGE4SUrlOeLhFHHfYcD1nE3CqKDPnWJYx5Wz7Bl6gF1T4qun/2AW+eE0MmyGvjhnsnYDwMNr+UJAMA2s02S+nFrlhV3hyzIFW07QUMLEGjc6MIdAFzI9WVeqPpgqk3/QFc3hGyRuO3R124cAOdsP7Axb4fxDoiNCdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878605; c=relaxed/simple;
	bh=/UyQccBEcmYiDYPQwQEHvIDess7h/iGMjHoGEEwd1Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWSOkVUnvH/3Vg6HBsXIVLJ/6Q3oYkPbJLinhjLZR3/Pg6J7c/GSz6Fu6ID/U8E2rdZz/fmagt9nzodwbhj2JwmxeLII4VkhbCE76UrYZ5ZBIDt3EHJH0pEHRiW+b6o+y0lJoBFkinIwSfwVYp4AzFS3pOvM50g4f63N6e+bx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ownTWJ9L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VCK8/x2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ownTWJ9L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VCK8/x2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7D01F7F9;
	Fri, 25 Oct 2024 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729878601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faWa8hUjhNnXYbB3wXK4vm2P4aNOrVk6VtNX9UfmEFk=;
	b=ownTWJ9Lf5ejQQeGvycmodvURhMx88ltENj8SXBaltoPWz5ulsWweH7l8zDR1HzTg8S9+7
	BnTvjo7UW2XcgI1WQ26txumnQv6mDwliAU6xz5sy6S55/sySF+7cVRe28itJ3VauFMkDn5
	icbdKT9T+SjjnkG9eNm9GGVnZx5TgpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729878601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faWa8hUjhNnXYbB3wXK4vm2P4aNOrVk6VtNX9UfmEFk=;
	b=0VCK8/x2s1IpBCmfQqktzy6zLz7X+8fonFoj20qID/JA+o1WoGI/PnKUYhJAWOILdrlKYu
	wu99lT5t354oU7Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729878601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faWa8hUjhNnXYbB3wXK4vm2P4aNOrVk6VtNX9UfmEFk=;
	b=ownTWJ9Lf5ejQQeGvycmodvURhMx88ltENj8SXBaltoPWz5ulsWweH7l8zDR1HzTg8S9+7
	BnTvjo7UW2XcgI1WQ26txumnQv6mDwliAU6xz5sy6S55/sySF+7cVRe28itJ3VauFMkDn5
	icbdKT9T+SjjnkG9eNm9GGVnZx5TgpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729878601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faWa8hUjhNnXYbB3wXK4vm2P4aNOrVk6VtNX9UfmEFk=;
	b=0VCK8/x2s1IpBCmfQqktzy6zLz7X+8fonFoj20qID/JA+o1WoGI/PnKUYhJAWOILdrlKYu
	wu99lT5t354oU7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51B2D132D3;
	Fri, 25 Oct 2024 17:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3LpvE0naG2deGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 17:50:01 +0000
Date: Fri, 25 Oct 2024 19:49:59 +0200
From: David Sterba <dsterba@suse.cz>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
	akpm@linux-foundation.org, Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	cgroups@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a
 folio
Message-ID: <20241025174959.GH31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240926140121.203821-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926140121.203821-1-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[30];
	R_RATELIMIT(0.00)[to_ip_from(RL56wjrisuox4ztiyaq54br4m8)];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,suse.com:email,samsung.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Most of the callers of wbc_account_cgroup_owner() are converting a folio
> to page before calling the function. wbc_account_cgroup_owner() is
> converting the page back to a folio to call mem_cgroup_css_from_folio().
> 
> Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> and convert all callers to pass a folio directly except f2fs.
> 
> Convert the page to folio for all the callers from f2fs as they were the
> only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
> already in the process of converting to folios, these call sites might
> also soon be calling wbc_account_cgroup_owner() with a folio directly in
> the future.
> 
> No functional changes. Only compile tested.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/extent_io.c                    | 7 +++----
>  fs/btrfs/inode.c                        | 2 +-

If you ever want to continue with the conversion then for the btrfs part

Acked-by: David Sterba <dsterba@suse.com>

