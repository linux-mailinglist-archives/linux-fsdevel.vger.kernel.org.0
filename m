Return-Path: <linux-fsdevel+bounces-76935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EhrACxrjGm+nQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:42:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D72123EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267463020A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0436921B;
	Wed, 11 Feb 2026 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ro0OcSrB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Rdam4TP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ro0OcSrB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Rdam4TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F12F2910
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810145; cv=none; b=aLtiNM0rF5HVIIjFfZJ50Gkqb30Gi324H5QLCNSxsBxKoSwoup3AHmB0Ows9JJ06iRXGYomW+gyI81swxGOTBXfuyHLxmsb2ioi2edIu5UgSvtVtjXLBCNQVE/79tq9gN76SluC0Nyl6nY86OeneN7qN5Hq7unXD3jR7DgdfrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810145; c=relaxed/simple;
	bh=L0so1uOFDNGD482yWenadqerI6IZHkqDJewtDrl/2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0vh3uqgh91PNtQn/8Bwe3fphaWhs03AycmTTKAEqXGcSE9Q/ts4KhcdT1GnezWgRsLvloZdkzctAekUvRFwfgMfuUl827x5ryHM2IbOr9/bwMoOn6K+LStMFyn0kJBhmumLbRZ5UKUkFXo5AF/HDOGjFNGa5Gg/n5jSz56t9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ro0OcSrB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Rdam4TP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ro0OcSrB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Rdam4TP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54AC35BCC6;
	Wed, 11 Feb 2026 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770810142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whGHsLyR1V0bnctfpBa4WypfCURKChRUFhxhMzqVUL4=;
	b=ro0OcSrB1QmcolsQwdRa3vJobNvQuS7uB4N/u/CetpU0KvytYH1Ih2RQDAaujpGpl6vgXr
	Ow8vJ+YUUJ4+ceRFH5nJyEhS9zuEDuDrzia3zv9/6wLmFmNZbGE+BGB63kYBDPte2aPd5g
	x7xpcNTH99g3PY0my2dE8XtjJp5+2xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770810142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whGHsLyR1V0bnctfpBa4WypfCURKChRUFhxhMzqVUL4=;
	b=5Rdam4TPtcwZkyJwWOgHepLwYcKPybF9uqiyR6iH1kN/Uq1v6XkSIOX8GnGJV9+n86ckEA
	dtypcxmvhmusxjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770810142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whGHsLyR1V0bnctfpBa4WypfCURKChRUFhxhMzqVUL4=;
	b=ro0OcSrB1QmcolsQwdRa3vJobNvQuS7uB4N/u/CetpU0KvytYH1Ih2RQDAaujpGpl6vgXr
	Ow8vJ+YUUJ4+ceRFH5nJyEhS9zuEDuDrzia3zv9/6wLmFmNZbGE+BGB63kYBDPte2aPd5g
	x7xpcNTH99g3PY0my2dE8XtjJp5+2xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770810142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whGHsLyR1V0bnctfpBa4WypfCURKChRUFhxhMzqVUL4=;
	b=5Rdam4TPtcwZkyJwWOgHepLwYcKPybF9uqiyR6iH1kN/Uq1v6XkSIOX8GnGJV9+n86ckEA
	dtypcxmvhmusxjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E7073EA62;
	Wed, 11 Feb 2026 11:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hpk3Dx5rjGmzGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Feb 2026 11:42:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC852A0A4C; Wed, 11 Feb 2026 12:42:06 +0100 (CET)
Date: Wed, 11 Feb 2026 12:42:06 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yizhang089@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org, 
	djwong@kernel.org, libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com, 
	Zhang Yi <yi.zhang@huaweicloud.com>
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <3dv6rb4223ngpj2duqm5smvmlpwhbvgyiksfkzmyfxhchejgon@eoo2kitdbdpq>
References: <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
 <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
 <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
 <d8b84bb5-8fb4-48fe-9ccb-7a0b724eb4b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b84bb5-8fb4-48fe-9ccb-7a0b724eb4b9@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76935-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[suse.cz:server fail,sea.lore.kernel.org:server fail,suse.com:server fail];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com,huaweicloud.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50D72123EDD
X-Rspamd-Action: no action

On Wed 11-02-26 00:11:51, Zhang Yi wrote:
> On 2/10/2026 10:07 PM, Jan Kara wrote:
> > On Tue 10-02-26 20:02:51, Zhang Yi wrote:
> > > On 2/9/2026 4:28 PM, Zhang Yi wrote:
> > > > On 2/6/2026 11:35 PM, Jan Kara wrote:
> > > > > On Fri 06-02-26 19:09:53, Zhang Yi wrote:
> > > > > > On 2/5/2026 11:05 PM, Jan Kara wrote:
> > > > > > > So how about the following:
> > > > > > 
> > > > > > Let me see, please correct me if my understanding is wrong, ana there are
> > > > > > also some points I don't get.
> > > > > > 
> > > > > > > We expand our io_end processing with the
> > > > > > > ability to journal i_disksize updates after page writeback completes. Then
> > > 
> > > While I was extending the end_io path of buffered_head to support updating
> > > i_disksize, I found another problem that requires discussion.
> > > 
> > > Supporting updates to i_disksize in end_io requires starting a handle, which
> > > conflicts with the data=ordered mode because folios written back through the
> > > journal process cannot initiate any handles; otherwise, this may lead to a
> > > deadlock. This limitation does not affect the iomap path, as it does not use
> > > the data=ordered mode at all.  However, in the buffered_head path, online
> > > defragmentation (if this change works, it should be the last user) still uses
> > > the data=ordered mode.
> > 
> > Right and my intention was to use reserved handle for the i_disksize update
> > similarly as we currently use reserved handle for unwritten extent
> > conversion after page writeback is done.
> 
> IIUC, reserved handle only works for ext4_jbd2_inode_add_wait(). It doesn't
> work for ext4_jbd2_inode_add_write() because writebacks triggered by the
> journaling process cannot initiate any handles, including reserved handles.

Yes, we cannot start any new handles (reserved or not) from writeback
happening from jbd2 thread. I didn't think about that case so good catch.
So we can either do this once we have delay map and get rid of data=ordered
mode altogether or, as you write below, we have to submit the tail folios
proactively during truncate up / append write - but I don't like this
option too much because workloads appending to file by small chunks (say a
few bytes) will get a large performance hit from this.

> So, I guess you're suggesting that within mext_move_extent(), we should
> proactively submit the blocks after swapping, and then call
> ext4_jbd2_inode_add_wait() to replace the existing
> ext4_jbd2_inode_add_write(). Is that correct?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

