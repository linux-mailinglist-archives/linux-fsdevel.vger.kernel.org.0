Return-Path: <linux-fsdevel+bounces-27078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8095E682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105451C20B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832138837;
	Mon, 26 Aug 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gjy1tGF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpS8tevD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gjy1tGF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpS8tevD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE02CA7;
	Mon, 26 Aug 2024 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637444; cv=none; b=sBcymzx56LWccZPTQNjPDDahRV8vBueDs0igGtCrx8PWe3dXH7If+4PMY+NOodKWIkom0Pmw2KjKaOQfyladC05NL8fodQ9x6G5gbXlGfFtxhG3qVlcQX1nIHwT7xQo47b0B7xyKejkbUpf6m0u8PBqerW4CelQQrX0dJz06Umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637444; c=relaxed/simple;
	bh=+uZGYTIzdyjvGkzdg4XcPKb++T/sNw46MiD7frBGYWk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZfWlQDsi9LDxLevckDm2janJ26sY2fAfQ4Td8z6MbmwTUPI0qUTPyVI2SI/PqsfPvBmh8vRx48Z4S6U6+yVOLB8mmIoVT9uh7fFB5u1o8XwhPi4t1xDZ3VqZWdqNzQuQCh1pLhigOtxxZgpvNg+KUepyLxagC3gDRUR0EryIlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gjy1tGF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpS8tevD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gjy1tGF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpS8tevD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 276F51F804;
	Mon, 26 Aug 2024 01:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724637440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McvlStlGL007bYjCK1CxwRJziQoG8gf+ThSs/qbv9hE=;
	b=Gjy1tGF/GZwqUfl1PZ5dY1yEaaeom7s5g3A7BCKDb6AG8KelvdCt9We6LATtL7FVMnA/93
	Ecjg4mFn4gRSqkelaI9JwoajyifTFmpuv9VZ2k4G0oJoZSqf9evpw8NJR5ex9Prp+0cLuW
	nTQRmL2bsCKPa3G7VJxALxIDd6JWHxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724637440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McvlStlGL007bYjCK1CxwRJziQoG8gf+ThSs/qbv9hE=;
	b=ZpS8tevDSXT1QCFXa2Sr7E/hQBHahTXp/xjM5tx2oixsPzlY9J6YpJ/wC0YeG9aqiy+wpR
	BZHH1XZsZvfwfgDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Gjy1tGF/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZpS8tevD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724637440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McvlStlGL007bYjCK1CxwRJziQoG8gf+ThSs/qbv9hE=;
	b=Gjy1tGF/GZwqUfl1PZ5dY1yEaaeom7s5g3A7BCKDb6AG8KelvdCt9We6LATtL7FVMnA/93
	Ecjg4mFn4gRSqkelaI9JwoajyifTFmpuv9VZ2k4G0oJoZSqf9evpw8NJR5ex9Prp+0cLuW
	nTQRmL2bsCKPa3G7VJxALxIDd6JWHxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724637440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McvlStlGL007bYjCK1CxwRJziQoG8gf+ThSs/qbv9hE=;
	b=ZpS8tevDSXT1QCFXa2Sr7E/hQBHahTXp/xjM5tx2oixsPzlY9J6YpJ/wC0YeG9aqiy+wpR
	BZHH1XZsZvfwfgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D63139DE;
	Mon, 26 Aug 2024 01:57:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w2SsGv3gy2aCcQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 01:57:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
In-reply-to: <20240823181423.20458-20-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>,
 <20240823181423.20458-20-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 11:56:59 +1000
Message-id: <172463741946.6062.16725179742232522344@noble.neil.brown.name>
X-Rspamd-Queue-Id: 276F51F804
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 24 Aug 2024, Mike Snitzer wrote:
> +
> +6. Why is having the client perform a server-side file OPEN, without
> +   using RPC, beneficial?  Is the benefit pNFS specific?
> +
> +   Avoiding the use of XDR and RPC for file opens is beneficial to
> +   performance regardless of whether pNFS is used. However adding a
> +   requirement to go over the wire to do an open and/or close ends up
> +   negating any benefit of avoiding the wire for doing the I/O itself
> +   when we’re dealing with small files. There is no benefit to replacing
> +   the READ or WRITE with a new open and/or close operation that still
> +   needs to go over the wire.

I don't think the above is correct.
The current code still does a normal NFSv4 OPEN or NFSv3 GETATTR when
then client opens a file.  Only the READ/WRITE/COMMIT operations are
avoided.

While I'm not advocating for an over-the-wire request to map a
filehandle to a struct nfsd_file*, I don't think you can convincingly
argue against it without concrete performance measurements.

NeilBrown

