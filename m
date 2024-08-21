Return-Path: <linux-fsdevel+bounces-26416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1165959195
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB47B225C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD43C0B;
	Wed, 21 Aug 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jrCFzvrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBEYHE1f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jrCFzvrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBEYHE1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317023B1;
	Wed, 21 Aug 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198740; cv=none; b=YOenqamJmZ0Z6A1Pkk5vKYdYmOFoj/qBEhUtLTdyMPj6vl7zAMwS15Zm1zThMeMf6V2TAz9XicYNTKjn+W0UtSRaAYtlae8MPmhRp/RLxWrnwISjgyMKrgj/u8cg7pGOMYO3IQiIzki6llF9KVaRqmMA1Irw4nkiszlcwMhhIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198740; c=relaxed/simple;
	bh=uMj6ilPU4IS9n9I3FJHnVf8YY6z8euaidiqO36JH1kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttc4GzxXxTDxQmmRwnvw/XJKJaX0sc3o8oK409fLAy75fJUSyBYUV0jHxQZB/M8zcdZaisAL0GgBIy7zS7hMfhBJJ+uI5VVDsKKywfdlYMsKZpkgVQEM4ELCKD6aKJW3f5W5fLA6SoDIxdwLCU/j/b9V/izO1ePPnEXIOYSqKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jrCFzvrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBEYHE1f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jrCFzvrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBEYHE1f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4281C21D9B;
	Wed, 21 Aug 2024 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724198736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DSyb15YajHd7ugd6BrHeusKTDbiGzqcFawlOtru2t4=;
	b=jrCFzvrlmUrK+uoDa/MhKr1sgWpyOVnXwsuEq2rWgSL9sPByPtv5uPUquRuBkwKzGcxWDe
	dDsMBsclBVg3aQt7Fg0CSVDDejDNwvzbgUsU9Cbo4AJUmbLfuhBhZ4PME6xWT/SWIrugmy
	3D+VRDhVL9JNxJyNaxK6ANAo1snIDcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724198736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DSyb15YajHd7ugd6BrHeusKTDbiGzqcFawlOtru2t4=;
	b=XBEYHE1fCVQVD3khsxIeiOAdcTfdXJWb934y+4GHlIHgGL4tvsXpcLIlgUOpvF5j4FV40D
	gHeZOP5zZB8ma5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724198736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DSyb15YajHd7ugd6BrHeusKTDbiGzqcFawlOtru2t4=;
	b=jrCFzvrlmUrK+uoDa/MhKr1sgWpyOVnXwsuEq2rWgSL9sPByPtv5uPUquRuBkwKzGcxWDe
	dDsMBsclBVg3aQt7Fg0CSVDDejDNwvzbgUsU9Cbo4AJUmbLfuhBhZ4PME6xWT/SWIrugmy
	3D+VRDhVL9JNxJyNaxK6ANAo1snIDcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724198736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DSyb15YajHd7ugd6BrHeusKTDbiGzqcFawlOtru2t4=;
	b=XBEYHE1fCVQVD3khsxIeiOAdcTfdXJWb934y+4GHlIHgGL4tvsXpcLIlgUOpvF5j4FV40D
	gHeZOP5zZB8ma5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22B8313A20;
	Wed, 21 Aug 2024 00:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /TE2CFAvxWbfPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Aug 2024 00:05:36 +0000
Date: Wed, 21 Aug 2024 02:05:25 +0200
From: David Sterba <dsterba@suse.cz>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Message-ID: <20240821000525.GM25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820161329.1293718-1-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Tue, Aug 20, 2024 at 06:13:29PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Change voidw -> void.

Tips for more typo fixes in the same file: fileystem, constaints,
specifc

