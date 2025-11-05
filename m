Return-Path: <linux-fsdevel+bounces-67074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E56C348D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4E3A970F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7582DC773;
	Wed,  5 Nov 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kk4KHprh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IXKiak5O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="euIPH0f5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZKyAO6Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51E2DAFD6
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332422; cv=none; b=XcO7ksz1t+q5AILdreCEz3dKD90Y7nK7nhRgh3LXV6QkPAtw3IgndlwBeANZqVgJr822JnFI59SQqFgevETN5yV3wFvedVQiJ+9cwRSs15h1BNCrW15zqSx64uZMxtsuDCqRc0GCKi5qRb5qSb4wGaq71ZxWSPCmd83IWD+0UY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332422; c=relaxed/simple;
	bh=k73kyroI14QlY+Ry14xJZyeTcrEMGVMf46hCxNg4HqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXGx0Fukr8BulpODtfuL2BInw3A4N+iXoW3uxhAq3X327VVQ+UCpfmf2HQHii5ewPpbWU91hDz6CzQYJUf9se5sUCVbmUK/stsBN6EbgocF5b/5FUjenU+C6KZqGwMykdJSrwuBUMNTmz1LYeuFUk2pW3/CVXYv9JAEZlwcZ//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kk4KHprh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IXKiak5O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=euIPH0f5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZKyAO6Xj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E41F02116C;
	Wed,  5 Nov 2025 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762332419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9dQBE0EcfsLO//r4BKJJsXu3FlACWq2NYnD5EknmFU=;
	b=kk4KHprhck1/zn51q1Nx39TLpbhJSAmN+LxDrTkrVM/YwuYV7vxJbsCOFL7XdJ5jOtc99p
	WZ9LMSS724hC5llKisRsii/KGGCc5qCmdMyCjwqBPQvGO5tTosXjUbhWI+ydof9DC8ew4j
	nhBK/K9s5K53zio57QVlCvCZAoAUmjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762332419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9dQBE0EcfsLO//r4BKJJsXu3FlACWq2NYnD5EknmFU=;
	b=IXKiak5O3Z3v/zAQt/Ra/LWCdd7r3JgMRSLz2E4ZdpAozipAnmMMp5cwapcv5sug/zMN/o
	gtENhGWL82Z7C6AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762332418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9dQBE0EcfsLO//r4BKJJsXu3FlACWq2NYnD5EknmFU=;
	b=euIPH0f53TpCLjfWxQbTZ/9gh2D4vculj7q1qw2tHzrxTBBed+t8pN2cAhsW3EpPdMqccj
	DJfW2Y+7n2fA7Ylg76Dz6jJ1sunlM3DO0OqAoZQgAx0evy2aFpYX5a51/rd0XRM4joaXL5
	s2G/SV2bQzevcRMgity8RIylPTrr1Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762332418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9dQBE0EcfsLO//r4BKJJsXu3FlACWq2NYnD5EknmFU=;
	b=ZKyAO6XjgDyXJgXv+ssrCj5nybblEulOC2A6DXH93qCa2uP1bmb+rvTHZFo8yXEd4V848d
	bhVnkz+yWuA1xDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6BD5132DD;
	Wed,  5 Nov 2025 08:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UlxlNAIPC2lAcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 08:46:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E5FCA28C2; Wed,  5 Nov 2025 09:46:58 +0100 (CET)
Date: Wed, 5 Nov 2025 09:46:58 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 11/25] ext4: support large block size in
 ext4_mb_load_buddy_gfp()
Message-ID: <sesj43tzk243dgm7vmk2cvqy66gh57dd65yhebxf6pkmliblfr@6adx5sry5eog>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-12-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251025032221.2905818-12-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:07, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_mb_load_buddy_gfp() uses blocks_per_page to calculate the
> folio index and offset. However, when blocksize is larger than PAGE_SIZE,
> blocks_per_page becomes zero, leading to a potential division-by-zero bug.
> 
> To support BS > PS, use bytes to compute folio index and offset within
> folio to get rid of blocks_per_page.
> 
> Also, if buddy and bitmap land in the same folio, we get that folio’s ref
> instead of looking it up again before updating the buddy.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

