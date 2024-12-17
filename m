Return-Path: <linux-fsdevel+bounces-37621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10389F482D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7083F16E325
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BE1DF963;
	Tue, 17 Dec 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="adfv2bYg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GD2Dyo9f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AzUNS6zP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ccZdF42W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99A1DF732;
	Tue, 17 Dec 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429475; cv=none; b=VtFJiB8z9tvBp+UaJorPF/YdOPsbb0lFF2lT4inpOKXikorfcTIJswyz7HmxmDumEdeb03tlpqUQFRmsPmKJw0u0BQ2Znqbxc9pk9KxVqU0qhkXQtkCJL8IIyPbMKwy2vfxyuFOb+qod+Dj1bS+ON17hHxloeO3pkbtR79q8lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429475; c=relaxed/simple;
	bh=LpxZ4UPInk6aTpgyrPHEyTwRD3ML8aURDqATS7LEuA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odYJ7v1CRBMPbe5/5djk5Dg4k0vDJMAUrPHGQsuscPiX7I8HFjB9urgsWC0Y4rxtw1nGWQ2mzNXXbNdqxCIo9Zr1JREem2H2Y91Y2RRzhqppM8BjellYEBv1Mno9/flBJjCY71pEU22lceDPpdrtnN3nVXzs5OBMW+GAE0ypMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=adfv2bYg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GD2Dyo9f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AzUNS6zP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ccZdF42W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDD7921108;
	Tue, 17 Dec 2024 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uM4T4G//b3CY+6cR4t0X6w5gGNDi4M5P/XsQuf0Gtw=;
	b=adfv2bYgAxI++x6KrP6iNLQK1g9vVej6W/zBLqKcDelujnmZXM9n14zXPRK5zUOnypYug4
	VkIdfbKnNLMlwG3/p/f88O2mN/eS/Rmuk4hK5ST5peBKRJO8ivpIlM1zLFqTmZLcj8sGo4
	3rFs2T3HariCTlvDjSB+86XQSw1PiOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uM4T4G//b3CY+6cR4t0X6w5gGNDi4M5P/XsQuf0Gtw=;
	b=GD2Dyo9fcoxnmy0GRTYKcd2Mkunux/uaFTySljSYB6eEtEIsOPhWG02ghq/LlKh5IufxLu
	J5t2HDba9zPfOMBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AzUNS6zP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ccZdF42W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uM4T4G//b3CY+6cR4t0X6w5gGNDi4M5P/XsQuf0Gtw=;
	b=AzUNS6zP9SGxw/VczMjRVliXDXI4EUeBBsAZ2X1pHmMvYNT8zxdd1R35tMI+dO/fLKlpId
	kEpDG447XuV67zvV14cuOSVldIRQ+/euwIUfjXbEIuipVryOGhr94HUbQvYgCX3VopPh6m
	BMcqg1j3V2W83Wh0DwSs5+VAPzhefjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uM4T4G//b3CY+6cR4t0X6w5gGNDi4M5P/XsQuf0Gtw=;
	b=ccZdF42WboYoslRmkiKK78aFgf7jIpE6Pf3ZOQgidM+IxZydfQt8vNnNP3FGuvbDvn0mgM
	oh2GZUwzD3mcW/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 414DB13A3C;
	Tue, 17 Dec 2024 09:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pG8ZDR9LYWcSOQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 09:57:51 +0000
Message-ID: <c818ff29-c50a-4947-b5a0-fbe074671679@suse.de>
Date: Tue, 17 Dec 2024 10:57:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/11] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241214031050.1337920-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDD7921108
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/14/24 04:10, Luis Chamberlain wrote:
> We want to be able to work through all buffer heads on a folio
> for an async read, but in the future we want to support the option
> to stop before we've processed all linked buffer heads. To make
> code easier to read and follow adopt a for_each_bh(tmp, head) loop
> instead of using a do { ... } while () to make the code easier to
> read and later be expanded in subsequent patches.
> 
> This introduces no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

