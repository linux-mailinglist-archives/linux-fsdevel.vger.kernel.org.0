Return-Path: <linux-fsdevel+bounces-66514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BECBC21B7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6493B89DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF62F6932;
	Thu, 30 Oct 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqRwg+3r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fg4y3tdZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqRwg+3r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fg4y3tdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3936C23D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848103; cv=none; b=ekgVS+aqZ7QkZXtSO3kvT5bDfpFV4kja5zE6QakQoTSyij8gWm05IY2V45g75irigemOCORwlBASad1aqN3E3rOEUu0CMpzu4yHckLvqGgIIbTSvvkDzrSLDByndBIn7yl91ZuIhPN7YAzQRO4VGn5PRv3kDjAyWX7Q81Uv2S2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848103; c=relaxed/simple;
	bh=4WNi/gumptqXp7BgD5BSeU+jDC7CK1rcvfA50JVdHmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTtLNoqVNEAWgIEdIeWgtMSw2MHS9Gy5KSpV5hi4Sb15N+bo55eu8Ze2SbnA4ytJGLu0c5hsfExX+KjelA0w+onUMvj0TyVak26v7LHM0iAi47s5+TcvazYSQr0+aQiahAqOLr9uXP9susS00GrZQ8422Hba4oPrU8KZIYp7l/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqRwg+3r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fg4y3tdZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqRwg+3r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fg4y3tdZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FA773377A;
	Thu, 30 Oct 2025 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CFnjtwUmb//xGgCGMULfuHur2sJTAkS3oGzkdVsxKs=;
	b=BqRwg+3rsMJ2p51V3FMD8iddnvVlx3s1YKPJ2eG3JvZjRSfL606kLC/wZiHMctaJ8fiklN
	0nQtkmNgbQi3JRZIOKAVTOXP9041saVUN7aWjeAJ3+Q9cnst+HJmuZ++nmCgpZ+eGyuGMW
	6nm2bGGzAf/d/ypdD3hd5cQle9cPybI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CFnjtwUmb//xGgCGMULfuHur2sJTAkS3oGzkdVsxKs=;
	b=Fg4y3tdZn5DbUo+77o+WKA6WNG5kXq3iKhHqA5Ac1wtJXto+H2EVkX5Ka7cnj+663xaE8b
	RAk0JMBJrtf3n5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CFnjtwUmb//xGgCGMULfuHur2sJTAkS3oGzkdVsxKs=;
	b=BqRwg+3rsMJ2p51V3FMD8iddnvVlx3s1YKPJ2eG3JvZjRSfL606kLC/wZiHMctaJ8fiklN
	0nQtkmNgbQi3JRZIOKAVTOXP9041saVUN7aWjeAJ3+Q9cnst+HJmuZ++nmCgpZ+eGyuGMW
	6nm2bGGzAf/d/ypdD3hd5cQle9cPybI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CFnjtwUmb//xGgCGMULfuHur2sJTAkS3oGzkdVsxKs=;
	b=Fg4y3tdZn5DbUo+77o+WKA6WNG5kXq3iKhHqA5Ac1wtJXto+H2EVkX5Ka7cnj+663xaE8b
	RAk0JMBJrtf3n5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 669D21396A;
	Thu, 30 Oct 2025 18:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id infcGCSrA2llfwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 Oct 2025 18:15:00 +0000
Date: Thu, 30 Oct 2025 19:14:59 +0100
From: David Sterba <dsterba@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/10] btrfs: Use folio_next_pos()
Message-ID: <20251030181459.GB13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-3-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Oct 24, 2025 at 06:08:10PM +0100, Matthew Wilcox (Oracle) wrote:
> btrfs defined its own variant of folio_next_pos() called folio_end().
> This is an ambiguous name as 'end' might be exclusive or inclusive.
> Switch to the new folio_next_pos().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: David Sterba <dsterba@suse.com>

Acked-by: David Sterba <dsterba@suse.com>

