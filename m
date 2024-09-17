Return-Path: <linux-fsdevel+bounces-29590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82297B237
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF29B2801A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B24176FA0;
	Tue, 17 Sep 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LIEcz345";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RiWOcCBX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQ/O/ih5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6+0hwlKl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002917A918
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587475; cv=none; b=L542I15V13wDt1XxFJBdto24qkfev7frSTuA38A9jAGOODUW4VwKVwnrUDegxUD6D1FJOUUsGvIKcohiAELonmYYy0GqY6XIMOEwb9S7avj9Biekd2iYnQ8Cz+zdposv77X6VfA7FTX4GvzWBR0WjD76eZKkKJXFxpo40cGrU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587475; c=relaxed/simple;
	bh=/Wt+Zb1Q33jz9OtxdwH9u7BKQ21nAxiGnX0QlhwLn3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr3OAlST55Zvi72UQMGQPCav1HKahB+tZRhEXG0eyV3oxKGO5ftPLhUqL1Tu55mvPP2gLQWWwGJYs/PGLvLoeOn0xe1PhG+O/DYPr755aocWeumHL2AnqHx2jKYDrsKdHvwaystsmFMkVHZCr8RCOCBbAWvssyh6NoLUbD3V8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LIEcz345; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RiWOcCBX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQ/O/ih5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6+0hwlKl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5420200E5;
	Tue, 17 Sep 2024 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726587472;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az81aQ+Wc3XH66sLzBugx1wSZZpOk6C6529og4oi6QM=;
	b=LIEcz345v3L3TA/m9nZmC/SjW0HPgfbmyhzZ2G/RJWCMlO/CIpWI844KFvf00suHu3vV7e
	yzDVY1DMeM/C7EJRjgMjvivu5T6QsFjyEVcTzk1zraEF8WH+H2imAYRwO7htroga2whhOk
	eK4PCf5m4aWxFw1NEHU/+3jFSedLkl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726587472;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az81aQ+Wc3XH66sLzBugx1wSZZpOk6C6529og4oi6QM=;
	b=RiWOcCBXbuUhJsEW3HCop2jgDm/cOIcwQrl7bYJ0FcPQ8VVp6AascMnj2imeIfWJXsooVE
	IR2ID0HYCCqo1kDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726587471;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az81aQ+Wc3XH66sLzBugx1wSZZpOk6C6529og4oi6QM=;
	b=HQ/O/ih5SH4wtL94pNo4gHpBURZfPvsjQP8pG9Nw962A7/4jQ7ARsdcso8JTd81VKb/fIa
	uGqNDrgOoP8cERIF1IH+JJ3Snv3cNDsmzNwef6GbHut1FKUyHiHINLM4ODvnRVt7qB9t8c
	JW0gTDiB7SEmSoPFB2qybL4ssrczDfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726587471;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az81aQ+Wc3XH66sLzBugx1wSZZpOk6C6529og4oi6QM=;
	b=6+0hwlKl/i9BMVmJbPyXUtZYJZiplCBK8zHyoq2Y4rvehAYtqnvLhe7VCiSkwqbJbsiju9
	Bm2d8a3kUEeZAFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA533139CE;
	Tue, 17 Sep 2024 15:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7wsMU+i6WbJVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 15:37:51 +0000
Date: Tue, 17 Sep 2024 17:37:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/5 V2] affs: convert affs to use the new mount api
Message-ID: <20240917153746.GB2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-3-sandeen@redhat.com>
 <a1c72d1a-8389-45cb-9aa6-638bfa1ebc23@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c72d1a-8389-45cb-9aa6-638bfa1ebc23@sandeen.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Sep 17, 2024 at 09:53:09AM -0500, Eric Sandeen wrote:
> Convert the affs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> 
> V2: Remove extra braces and stray whitespace (oops)

Reviewed-by: David Sterba <dsterba@suse.com>

