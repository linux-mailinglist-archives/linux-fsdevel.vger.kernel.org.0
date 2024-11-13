Return-Path: <linux-fsdevel+bounces-34611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1862C9C6C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA135B2A69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20781FAF07;
	Wed, 13 Nov 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OJN6SxWk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fn8G0Fq1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBYlI74Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5P7awEtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F31FAEEB;
	Wed, 13 Nov 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491726; cv=none; b=ss0IifMepQBf6ktPnYJUEqCUCtgsXU0k8Q85HNksfhaxuRNOK6HG36KBuu9LyILbsfqF2s7cYYJCnPrnWO5Net80f3uLqqdcWjpvnQg/f4spMRvAyxhTiIDMW7/lbQCsdlWGxa60iqOz0jcsjZ9y/a5AJ4B/8IXt7YvoKltRwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491726; c=relaxed/simple;
	bh=u75nlWdYoOAIfiX/SRtk4W69kwdJ0NHaif6vj+7/FCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwIhycEWflMhbsmLuoMY43oHeRXrBUGOqOI6PqtUAnOUFSRHqctBtoe68SQLGMy8JATyNeVwIPAhD4ba6ben/CHHmobKaHnKAgXvkr/t5fiMIFd4dZiE0Mfy/QfMCAg6TMk/272CoY4mlLALw1uTp/JCVnb8WjvsNA9YHIY189c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OJN6SxWk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fn8G0Fq1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBYlI74Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5P7awEtC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4F6D211D6;
	Wed, 13 Nov 2024 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad2+b1TP8cF2SDzj/dhwV3oe7kuZxvWjzs5XlhgBIHQ=;
	b=OJN6SxWkqyIRcig67iNGyPUwvgoiU/Eu46L6QYIX0JzU6FKDWnDSDHHl3S6WiOs2u3bjtg
	P3HGX8e1YA8atI4FXaNlki541dWJ5hTawIFtOKDUyeCwLuWbzcfAMgRytxLigONVnvzIIS
	5T00/1WV9FMPozDpWKr+Fu+5jwUGrRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad2+b1TP8cF2SDzj/dhwV3oe7kuZxvWjzs5XlhgBIHQ=;
	b=Fn8G0Fq1yiLFQ4RDLfp4pULXoTPAQv1cyhog2mJPEQRK6hxn+TD2ucnn7zijeb++S5OKev
	H34N2jEGQspW52CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad2+b1TP8cF2SDzj/dhwV3oe7kuZxvWjzs5XlhgBIHQ=;
	b=SBYlI74Z5Dw9c1yZfQ+bckfJxkwMimmAfSAWVqncgKTOhE07H9OPo+r2GeAJ33Tk0OVftY
	ajPpeHIVzKv8k34YEgqAD6kCfYZmHntTlTqgFwJjH60eOJfu/TIeLDdJGWEXIyWIqjcogu
	ZBvwZjyOGHKxNiHgDfjYeuv9101apNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad2+b1TP8cF2SDzj/dhwV3oe7kuZxvWjzs5XlhgBIHQ=;
	b=5P7awEtCCYEqiGBHsV4aOiEizMzmX0w/Yx2JbXNC+ZQvoH5QHfnELG+wybSKHJZpjOKuog
	EqE/e9mFqDILyPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DAAB13A6E;
	Wed, 13 Nov 2024 09:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5QwfIod3NGfBGAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:55:19 +0000
Message-ID: <2ed5bf13-4a22-4b07-9885-2dd9e053d854@suse.de>
Date: Wed, 13 Nov 2024 10:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/8] fs/buffer fs/mpage: remove large folio restriction
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-5-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241113094727.1497722-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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

On 11/13/24 10:47, Luis Chamberlain wrote:
> Now that buffer-heads has been converted over to support large folios
> we can remove the built-in VM_BUG_ON_FOLIO() checks which prevents
> their use.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 2 --
>   fs/mpage.c  | 3 ---
>   2 files changed, 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

