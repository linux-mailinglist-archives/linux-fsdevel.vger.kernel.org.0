Return-Path: <linux-fsdevel+bounces-22758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F291BBCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7975B284501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463F15383C;
	Fri, 28 Jun 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUYTxA9y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUVxshvX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bLi52LFr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Whc/fUS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381B4D58A;
	Fri, 28 Jun 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567922; cv=none; b=gAiAZBhsimlPCEgg1suliFLbcwvC71mTzzHWZHHPX9C7z1QDhliY26v0RM/IEcN5ZItbUQZH9jNYvN/dmkmdeWuqoi8NToxapJeNAeIZxDnZ4yaKfv9ZyavFVgcJOX33rGVmI5Hl2cJR/370aiq69oa94egm0FhThqRypiYZxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567922; c=relaxed/simple;
	bh=251VEXUxoQ/OtBMK4PuhzNQr1HTbdjDTwS29xU+GHnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObKRNnzKBlGFM8RN7wdwLA3dmmwD+7fJPT8F3ydKzpGrEusfZUlfFGVtejqKkS/wgxFCi2+XF1wo64tEKnlIXvlcOALNv7qxJhwCoi7aMOURZE2B1MVv4+i9fovrHItd2Ag6wNfzUco9W74EeFRrc66dd/fIMlRWxOdVSbAL26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUYTxA9y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUVxshvX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bLi52LFr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Whc/fUS9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9FB221BC9;
	Fri, 28 Jun 2024 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719567919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f26nbjFyLnlYInHIRR6KDvb4r0aSsw8ifojWvt5uZhw=;
	b=KUYTxA9yfgjQxbwI4K8stUvHGu1vsAYhUXpwJkG+ELqu86igcdg1sbLNvlKfLZUnKA3WlH
	RZino+8fbK2+MJfZIKhW+wF30EYWKgf46/Ra2eq+CS95dvpBo8KvAlX2AfNtqwyWxnQkNK
	4yRCyob67BtYLBu14RxYJwgLcEqZiZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719567919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f26nbjFyLnlYInHIRR6KDvb4r0aSsw8ifojWvt5uZhw=;
	b=WUVxshvXtPCGrq4IGUx4Lk1be12on57Evx2IiNVmvE84OeO4SG4zztw3ZylHAkBR1WRNoC
	Fc2qm8RbXgb7MXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719567917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f26nbjFyLnlYInHIRR6KDvb4r0aSsw8ifojWvt5uZhw=;
	b=bLi52LFrNYz4r7H3P+mEUw86IXx8vzgnG+3QyHg99jKg9DF7ujgYInC2P+225v7/iifv06
	nU6JAj8A7nfotAxn7yt17IQRrpbMDN0/a+8Z+X25K59tSV1tXWOhAmvNlcFaSXSciGuZ5q
	T2A5GpG2qx+b7csuthBsE2tgcDs2vII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719567917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f26nbjFyLnlYInHIRR6KDvb4r0aSsw8ifojWvt5uZhw=;
	b=Whc/fUS9d3BhyO19okPfQdzkp0dnWCR3SjDCYNy5EIAMr+QN2/FQkXW0U2SXZZvifZxt6y
	FImH8Q/bIhkMHyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC5B113A9A;
	Fri, 28 Jun 2024 09:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T2rFNS2GfmarOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 09:45:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ED29A088E; Fri, 28 Jun 2024 11:45:17 +0200 (CEST)
Date: Fri, 28 Jun 2024 11:45:17 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-mm@kvack.org, Jan Kara <jack@suse.cz>, ntfs3@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Hans Caniullan <hcaniull@redhat.com>
Subject: Re: [PATCH 01/14] fs_parse: add uid & gid option option parsing
 helpers
Message-ID: <20240628094517.ifs4bp73nlggsnxz@quack3>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sandeen.net:email,imap1.dmz-prg2.suse.org:helo]

On Thu 27-06-24 19:26:24, Eric Sandeen wrote:
> Multiple filesystems take uid and gid as options, and the code to
> create the ID from an integer and validate it is standard boilerplate
> that can be moved into common helper functions, so do that for
> consistency and less cut&paste.
> 
> This also helps avoid the buggy pattern noted by Seth Jenkins at
> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> because uid/gid parsing will fail before any assignment in most
> filesystems.
> 
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>

I like the idea since this seems like a nobrainer but is actually
surprisingly subtle...

> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index a4d6ca0b8971..24727ec34e5a 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_fd);
>  
> +int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
> +		    struct fs_parameter *param, struct fs_parse_result *result)
> +{
> +	kuid_t uid;
> +
> +	if (fs_param_is_u32(log, p, param, result) != 0)
> +		return fs_param_bad_value(log, param);
> +
> +	uid = make_kuid(current_user_ns(), result->uint_32);

But here is the problem: Filesystems mountable in user namespaces need to use
fc->user_ns for resolving uids / gids (e.g. like fuse_parse_param()).
Having helpers that work for some filesystems and are subtly broken for
others is worse than no helpers... Or am I missing something?

And the problem with fc->user_ns is that currently __fs_parse() does not
get fs_context as an argument... So that will need some larger work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

