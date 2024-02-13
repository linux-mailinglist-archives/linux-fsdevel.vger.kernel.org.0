Return-Path: <linux-fsdevel+bounces-11374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1BA8533F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B9D285727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC265F871;
	Tue, 13 Feb 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TsmF6EuW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4IzAiNJu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TsmF6EuW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4IzAiNJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838055F55E;
	Tue, 13 Feb 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836316; cv=none; b=LEUAcdCK4ujZCCf/SlLawQtgc6b+1qWEsJIjbRw5vkSUq+dJJhUFXlpGbrjX0A91zvA/CGyAsN3MXeTqACz+Mjd+MV74CP+2vdTuajxdIJ8UuXlVxRn4uizu0Z9PR6+s02wNmR6/jnKFwoLYCeCH9e3L3MxEvFclVRv/AP+Zpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836316; c=relaxed/simple;
	bh=n+9HwZfX+sU+0Q/HJpA//NT6ZKbLNYj5VpalvoNb0KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw+UEQ04QsMulruR85OjN9YxJYaZ+rAmbrL9SxlK3oXkMl1mMdASRnIsG2dYRgnnxpv3+1uRfluLgROiIauF5Pkyjd1JwN2WO7vGFrliwI1UpK6/Xr8qlg5onBQmaeEpmnH1J2CiO3TiUjBs86Mt/+7NmC3AIFvjLux6SMv4n2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TsmF6EuW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4IzAiNJu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TsmF6EuW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4IzAiNJu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA9FE1FCDB;
	Tue, 13 Feb 2024 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSAPi76ZfKEBUK44Kk9m2ondarSlgg03teP4kt0h9ts=;
	b=TsmF6EuW1/ZrDEQnj5xa/n18uHulfwkLO6rU++JFQbmWcTs8JRISjd0e0DYJCt93M8Q3Lq
	9xnDoEfMbslmTO8DqClxTOLoIkxUBw2BOdrCOKwqSEu3Y414rDadOzOFwAoj+Ikh4kV//E
	YuKVrwmP6GcFw3WmUC0+jb1CcBYwqWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSAPi76ZfKEBUK44Kk9m2ondarSlgg03teP4kt0h9ts=;
	b=4IzAiNJu0NaYcOYhd5h+T7ewe3kM8czpxtzkUT374zxrHQPrVhKL+RoLYylPryY2l0GzID
	Od3wT3xopUGMH0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSAPi76ZfKEBUK44Kk9m2ondarSlgg03teP4kt0h9ts=;
	b=TsmF6EuW1/ZrDEQnj5xa/n18uHulfwkLO6rU++JFQbmWcTs8JRISjd0e0DYJCt93M8Q3Lq
	9xnDoEfMbslmTO8DqClxTOLoIkxUBw2BOdrCOKwqSEu3Y414rDadOzOFwAoj+Ikh4kV//E
	YuKVrwmP6GcFw3WmUC0+jb1CcBYwqWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSAPi76ZfKEBUK44Kk9m2ondarSlgg03teP4kt0h9ts=;
	b=4IzAiNJu0NaYcOYhd5h+T7ewe3kM8czpxtzkUT374zxrHQPrVhKL+RoLYylPryY2l0GzID
	Od3wT3xopUGMH0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8587C13404;
	Tue, 13 Feb 2024 14:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id le0RIJiDy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 14:58:32 +0000
Message-ID: <617c710c-6b61-46cf-b507-4c16c9d8e9e4@suse.de>
Date: Tue, 13 Feb 2024 15:58:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/14] filemap: use mapping_min_order while allocating
 folios
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-4-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.87
X-Spamd-Result: default: False [-1.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.58)[81.42%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> As we bring the notion of mapping_min_order, make sure these functions
> allocate at least folio of mapping_min_order as we need to guarantee it
> in the page cache.
> 
> Add some additional VM_BUG_ON() in page_cache_delete[batch] and
> __filemap_add_folio to catch errors where we delete or add folios that
> has order less than min_order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/filemap.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


