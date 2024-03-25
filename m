Return-Path: <linux-fsdevel+bounces-15202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3388A49D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD451F3E0EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1E1BD5E6;
	Mon, 25 Mar 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S0lgxu4c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RFTMdQgN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S0lgxu4c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RFTMdQgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32B149DEE;
	Mon, 25 Mar 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363240; cv=none; b=Xhy2ldc8n7+S81KhdtvUZZ98c4iOFCLn8xJa/GlSZgkeP2gZYCk4WzR0GPai5KF4flk6MjeYjQUlmjkmtt6g/uNQRkqCs8nIjZHC3dHPiPKWHneFG4i2MUZqpvOy5nGnJTgHENW1ovXftUBFOphm3Rv70U3oesSXfoCmgliFIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363240; c=relaxed/simple;
	bh=W8GxAoJGXY5SGLSBdnJRkkuCU2xk0JbHxLXZhmq4xXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQElNhU+vrICz5oPGppkDciCoGk63eBMD4WxqUjQsTUvd0ltoVLbkQuzTTnrfwR0fxxGv+2W+oAq+XeNDHb1FOlKLV0bVPNzLiMy+T8I5eZ/wMCsjwjM/7Xy2wKs6YSVdRQuv1Wa0HbXFEVP5/64/rkat4d0cnBh/QJYMBn/t+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S0lgxu4c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RFTMdQgN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S0lgxu4c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RFTMdQgN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B93F43502A;
	Mon, 25 Mar 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711363235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy5fSmakUMcfeZtN1p/1t9m66485LFGTKTn4dhyLyJk=;
	b=S0lgxu4ca3eSl8VJSfqKfxRGcxUsvAsTs2bntNRnPyZ2SBom2heRBfrAyCPn7z3w/MU2OA
	835d0CwCGd7xlueEx1UUgaWd6/UJytpW32AYUooci7xsNW1iTRR2Yav6IWKO8+NcWKzZGy
	fwCl5dpePCLOKWNqu0/KVCIeE2n8tRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711363235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy5fSmakUMcfeZtN1p/1t9m66485LFGTKTn4dhyLyJk=;
	b=RFTMdQgNOEYQCMy0f0+C3/nLccYI34IQP+9hJEd7nsm07u/Om3MU3rfJsXQzP8gSSAQC+A
	5Pq5acBcZiJ1n1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711363235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy5fSmakUMcfeZtN1p/1t9m66485LFGTKTn4dhyLyJk=;
	b=S0lgxu4ca3eSl8VJSfqKfxRGcxUsvAsTs2bntNRnPyZ2SBom2heRBfrAyCPn7z3w/MU2OA
	835d0CwCGd7xlueEx1UUgaWd6/UJytpW32AYUooci7xsNW1iTRR2Yav6IWKO8+NcWKzZGy
	fwCl5dpePCLOKWNqu0/KVCIeE2n8tRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711363235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy5fSmakUMcfeZtN1p/1t9m66485LFGTKTn4dhyLyJk=;
	b=RFTMdQgNOEYQCMy0f0+C3/nLccYI34IQP+9hJEd7nsm07u/Om3MU3rfJsXQzP8gSSAQC+A
	5Pq5acBcZiJ1n1DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86D1113A71;
	Mon, 25 Mar 2024 10:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YIBQDqFUAWbZdwAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 25 Mar 2024 10:40:33 +0000
Date: Mon, 25 Mar 2024 21:40:19 +1100
From: David Disseldorp <ddiss@suse.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] Over-the-wire data compression
Message-ID: <20240325214019.652d5531@echidna>
In-Reply-To: <vvwzjchwqlgmwrsaphak7zvwoecqjavq7zdwds2zvjuqj65dev@xbv77wuvvjyl>
References: <rnx34bfst5gyomkwooq2pvkxsjw5mrx5vxszhz7m4hy54yuma5@huwvwzgvrrru>
	<20240315122231.ktyx3ebd5mulo5or@quack3>
	<20240318215955.47e408bf@echidna>
	<vvwzjchwqlgmwrsaphak7zvwoecqjavq7zdwds2zvjuqj65dev@xbv77wuvvjyl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.02
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.21%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S0lgxu4c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RFTMdQgN
X-Rspamd-Queue-Id: B93F43502A

Hi Enzo,

On Fri, 22 Mar 2024 18:23:54 -0300, Enzo Matsumiya wrote:

> Which brought me to the 'how to detect uncompressible data' subject;
> practical test at hand: when writing this 289MiB ISO file to an SMB
> share with compression enabled, only 7 out of 69 WRITE requests
> (~10%) are compressed.
> 
> (this is not the problem since SMB2 compression is supposed to be
> done on a best-effort basis)
> 
> So, best effort... for 90% of this particular ISO file, cifs.ko "compressed"
> those requests, reached an output with size >= to input size, discarded it
> all, and sent the original uncompressed request instead => lots of CPU
> cycles wasted.  Would be nice to not try to compress such data right of
> the bat, or at least with minimal parsing, instead.

Sounds like storing some compressible vs non-compressible write metrics
alongside a compression-capable SMB2 FILEID would allow for a simple
attempt-compression-on-next-write prediction mechanism. However, you'd
be forced to re-learn compressibility with each reconnect or store it.
FILE_ATTRIBUTE_COMPRESSED might also be available as a (user-provided)
hint.

