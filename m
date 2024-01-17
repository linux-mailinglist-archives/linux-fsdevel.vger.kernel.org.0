Return-Path: <linux-fsdevel+bounces-8142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273D830187
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4B287AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF213ADD;
	Wed, 17 Jan 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MeR0I8L3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQiBjgLr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MeR0I8L3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQiBjgLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0C134A9;
	Wed, 17 Jan 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481454; cv=none; b=rL52YSfKVvMKSMQfWBuYH/dgKezzhWF17xBBWi11nGvLlsDBLhDor12zK/VZp4rRz1MX2wWraR64PcnPwN31YkBHdsVOHzZbRW29+e9ipQjSWcIdTNW4isNH1gXVXIIeF+lb0L7sVCGTRzgLIxT5xsMUbrrzEVFl33GanDz7kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481454; c=relaxed/simple;
	bh=qPpLgCGyyBF78ayhA7eg356GDeU8synRG/Xshtt101Y=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Flag:X-Spam-Score; b=qsYHip+WkDpTKHl9jF9gPckVLlEoY5RSnDqSTENnGqrw+/I4jreu4Ne5WlYg1iIlMCURntg+LONnYwsDAIwdMtcIeLxN5Qmq0byLRRjePrhEjpKwAZ4+Om7XUF9PGBEuZRwhW8Zn++dcl6X3O8zqQ8cX1DK9f/EOp0shiyNnumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MeR0I8L3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQiBjgLr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MeR0I8L3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQiBjgLr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFF331FBEE;
	Wed, 17 Jan 2024 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705481450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=MeR0I8L32aw3vSqrEuwLfOX6oLR9JHRoYQSMNhZIXf50HRs/9oswWprxhtgQpVPBfMd5rv
	qKpHQY1jbs0t3DHrR+yvrNJDPhLccGVfHCQAcGC/1818Mude2ZRhMQwaMWEPctZ1e4IaXr
	tRRKswhYHx19eTtwMe+Db3hsmSmp3ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705481450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=uQiBjgLrobahFM+YXVRzjbTJf36JIYqsekl7lc1F8YV45fgzOJsAPqEoULZ2B0KSE5evMi
	Xr+vCPBKEDWmlFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705481450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=MeR0I8L32aw3vSqrEuwLfOX6oLR9JHRoYQSMNhZIXf50HRs/9oswWprxhtgQpVPBfMd5rv
	qKpHQY1jbs0t3DHrR+yvrNJDPhLccGVfHCQAcGC/1818Mude2ZRhMQwaMWEPctZ1e4IaXr
	tRRKswhYHx19eTtwMe+Db3hsmSmp3ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705481450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=uQiBjgLrobahFM+YXVRzjbTJf36JIYqsekl7lc1F8YV45fgzOJsAPqEoULZ2B0KSE5evMi
	Xr+vCPBKEDWmlFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C527013751;
	Wed, 17 Jan 2024 08:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jVWyLuqUp2UFDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Jan 2024 08:50:50 +0000
Date: Wed, 17 Jan 2024 09:50:50 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, Dan Williams <dan.j.williams@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.33 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.07%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.33

On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> For storage track, I would like to propose a session dedicated to
> blktests. It is a great opportunity for the storage developers to gather
> and have a discussion about:-
> 
> 1. Current status of the blktests framework.
> 2. Any new/missing features that we want to add in the blktests.
> 3. Any new kernel features that could be used to make testing easier?
> 4. DM/MD Testcases.
> 5. Potentially adding VM support in the blktests.

I am interested in such a session.

> Required attendees :-
> 
> Shinichiro Kawasaki
> Damien Le Moal
> Daniel Wanger
> Hannes Reinecke

If I get an invite I'll be there.

Thanks,
Daniel

