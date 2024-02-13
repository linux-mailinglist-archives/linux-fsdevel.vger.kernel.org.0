Return-Path: <linux-fsdevel+bounces-11358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931E853017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF641C2195D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD93F8F5;
	Tue, 13 Feb 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2WsDMIBX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QrwIy2M6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2WsDMIBX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QrwIy2M6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2F3D54D;
	Tue, 13 Feb 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825833; cv=none; b=aG3z2ebj3BskDN/Y27TvCX9J0HPUBPlAoLZzdCoSjnM2UJtb/6t+j7tnKO7HQcDxsHfHTTDdhCoAZa5ozQf8VSBnLE4uIbvMceENg6tXZidIWUMv9XYNEWyLwGCSYevlY6pQANzqeetWCXdOyxy0qCD2fcd1CII/bBMZ6GOiFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825833; c=relaxed/simple;
	bh=ZQGIvuDW2PzlvfVtNwW97RRS/KfxyRx7c3ZCYNtGKpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFq7EH0AsB00DgE54/tn+/dc6g/1pRQ095WA3iRETQEpD1pST2gNPT4rFIEOun68dly0fjTonJc9WWPz8PUArEQ/kKeMYlqwQXVKETSvOq8HQ5JQN8VNXjvGkdN8JpYv4nVTaaQgqf8iyMo12rFCgqTGQu/iIt89utK1ebVNpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2WsDMIBX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QrwIy2M6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2WsDMIBX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QrwIy2M6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2C511FCA1;
	Tue, 13 Feb 2024 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsfW3I5huasgV2mNQM+r3xHRCdlw2wFSt6VvbZswGG4=;
	b=2WsDMIBXvtsqH6KGQlwapWf5RNnSUZ+RFXAS0nUO1iipfNsaArd9QqoPyZeL+pa0uIedQr
	HYKDsvaE8cN3hnY1EEZBLn3hdC1AfpDzyge9j5H28BQ/vGLut47IAjpB8KANhTQOwcNqSU
	zv9i/qvbDZ00bVTfvGbAOtb4nH0Ufaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsfW3I5huasgV2mNQM+r3xHRCdlw2wFSt6VvbZswGG4=;
	b=QrwIy2M6Sc72TPCbyBsseK/Y2NdBUglwhDnlOFY13HwT18VPaSmDpBZWOSGtzrxWZ9jdma
	/WP/bWOqOZnJ7ABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsfW3I5huasgV2mNQM+r3xHRCdlw2wFSt6VvbZswGG4=;
	b=2WsDMIBXvtsqH6KGQlwapWf5RNnSUZ+RFXAS0nUO1iipfNsaArd9QqoPyZeL+pa0uIedQr
	HYKDsvaE8cN3hnY1EEZBLn3hdC1AfpDzyge9j5H28BQ/vGLut47IAjpB8KANhTQOwcNqSU
	zv9i/qvbDZ00bVTfvGbAOtb4nH0Ufaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsfW3I5huasgV2mNQM+r3xHRCdlw2wFSt6VvbZswGG4=;
	b=QrwIy2M6Sc72TPCbyBsseK/Y2NdBUglwhDnlOFY13HwT18VPaSmDpBZWOSGtzrxWZ9jdma
	/WP/bWOqOZnJ7ABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB6E1370C;
	Tue, 13 Feb 2024 12:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qRFQIqVay2X+AgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 12:03:49 +0000
Message-ID: <30d805b3-4ee4-45ad-b619-b25fd0c5bb78@suse.de>
Date: Tue, 13 Feb 2024 13:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2WsDMIBX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QrwIy2M6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.22)[96.30%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -5.72
X-Rspamd-Queue-Id: B2C511FCA1
X-Spam-Flag: NO

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Some filesystems want to be able to limit the maximum size of folios,
> and some want to be able to ensure that folios are at least a certain
> size.  Add mapping_set_folio_orders() to allow this level of control.
> The max folio order parameter is ignored and it is always set to
> MAX_PAGECACHE_ORDER.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   include/linux/pagemap.h | 92 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 73 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



