Return-Path: <linux-fsdevel+bounces-37623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D79F4857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE11883FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D341E260D;
	Tue, 17 Dec 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lLZcw4g+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lvwLUIFP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lLZcw4g+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lvwLUIFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484391DFE00;
	Tue, 17 Dec 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429867; cv=none; b=go9x45rT4E1qtli7R+W6zP1CFr4TTP89EfziWxpiklogalmmMdz7Ke7mQQaPtROJLRvyla8/0XPotmWjsjd6P7EEBu3qCpbb8yQZmuHz77U4LiCXrex2RFeXeK2lau/bwnINKpEQZC3SHyH19mhYSW1CGUP1xlAZmAnOHC7i4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429867; c=relaxed/simple;
	bh=9fxFQ79TMxT1lABHfYBHF318n7gZkAuL1qaucXC6LJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7IoB8uRMYPCQsYSSBEB0wYtPFZtKoj8TKwV/HWCqCFWurs35gSBoASHp+qCyh3sdFxjoJoTXojb0KdZO9nhdE/7vd8n/krsWi0BN1wEKSGLSj2/fKh1yrgPLlmmFLnOhnFTPJb8NftjghBUvC265T/zHdbLxlYIPX82BrWDzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lLZcw4g+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lvwLUIFP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lLZcw4g+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lvwLUIFP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BEEC210FB;
	Tue, 17 Dec 2024 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FwxI0QcWk1TmSdI8dNaWT58oxrCJPcJLAMkxNz5Hfk=;
	b=lLZcw4g+qCgMDXasHsjgX5zk3SiRddwX7PxK6aumGrBsEy5mh6FdL67wMgFsO1ZA4exGHj
	KoihxWrcP3ViFLJyo/dkxA1eZfAfUxyawzWVFNxF2zd3tZ6IShDRjtQxlFdBqdP+ocxB6f
	19mPY7dk435V6RM3O9vRzHSFbVXcqI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FwxI0QcWk1TmSdI8dNaWT58oxrCJPcJLAMkxNz5Hfk=;
	b=lvwLUIFPUZcWmI+c5Rzb89qWjvmYXQjbLdMH64KuBwIWnEXu+efg/rURtkP6RWIOoVOED/
	bFcS1dB0yxZ7iECA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FwxI0QcWk1TmSdI8dNaWT58oxrCJPcJLAMkxNz5Hfk=;
	b=lLZcw4g+qCgMDXasHsjgX5zk3SiRddwX7PxK6aumGrBsEy5mh6FdL67wMgFsO1ZA4exGHj
	KoihxWrcP3ViFLJyo/dkxA1eZfAfUxyawzWVFNxF2zd3tZ6IShDRjtQxlFdBqdP+ocxB6f
	19mPY7dk435V6RM3O9vRzHSFbVXcqI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FwxI0QcWk1TmSdI8dNaWT58oxrCJPcJLAMkxNz5Hfk=;
	b=lvwLUIFPUZcWmI+c5Rzb89qWjvmYXQjbLdMH64KuBwIWnEXu+efg/rURtkP6RWIOoVOED/
	bFcS1dB0yxZ7iECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7D3313A3C;
	Tue, 17 Dec 2024 10:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MbntLqdMYWdMOwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 10:04:23 +0000
Message-ID: <89b3e0fd-6ff8-4427-b895-a7c63f70723c@suse.de>
Date: Tue, 17 Dec 2024 11:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/11] fs/buffer: reduce stack usage on bh_read_iter()
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-5-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241214031050.1337920-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 12/14/24 04:10, Luis Chamberlain wrote:
> Now that we can read asynchronously buffer heads from a folio in
> chunks,  we can chop up bh_read_iter() with a smaller array size.
> Use an array of 8 to avoid stack growth warnings on systems with
> huge base page sizes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

