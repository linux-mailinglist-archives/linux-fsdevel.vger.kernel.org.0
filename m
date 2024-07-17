Return-Path: <linux-fsdevel+bounces-23818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E0F933C2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C2B1C22B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C17F50B;
	Wed, 17 Jul 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHHXrqW5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeMSvCSD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHHXrqW5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeMSvCSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A638385;
	Wed, 17 Jul 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215454; cv=none; b=LQeH4fQu1QiMovFhp6dmDlb5oZ3iYbQlUOq9bNI5XHvjhLZye/QMRw1dxrW5fS4iSqcaz8oUUt7pW3FcT7la9PwQ6f0/U+VxyaGxa2pWImjI8C5AMxvW15lsdkGr7gtOZBS3RV+bT88BRmOtVTU4avE6I6MRP3Th2J3d6+U6Qz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215454; c=relaxed/simple;
	bh=xCKJi7zK/yGpb2f0c5K5Ln+coARI2PImC2zsTC3wwSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpxxAzSoUpxb9R++Bx0qSqVRMenU6GOnSqOdhKK7WBeldzgMzyElkRy5LrY61i4bcNCEB2N9pydUxkGJdSP0sMzgz4/DiksG0kGq4lIXksgLB3JOHen3+MBUFnqutUA/x4bu1LB8VYeIbpzc/4h7F/muumIBs/HX8n5QgV6Po7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHHXrqW5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeMSvCSD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHHXrqW5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeMSvCSD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78055219DB;
	Wed, 17 Jul 2024 11:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPlXmgWWykiwYFaSI8TaQFNF/XILIXsfXxcyJiCt34A=;
	b=xHHXrqW5bIRudLPppzia+s31nSmZamC5ymFM+PaRsjxwdyx1VJBX5p8/pURD9S2QlaJ6Wz
	CidO86qEPm9wnBz6T598LscytA1ioT36iZ7eWgA1ngLtsXufWGVoV1SZsJkVzW/h91glSR
	fIR1Q7st9Z5i39BIFO6svmt8MVjbfdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPlXmgWWykiwYFaSI8TaQFNF/XILIXsfXxcyJiCt34A=;
	b=jeMSvCSDSmNWHb7lMjTSPMQUjiQ/RzIzyF/kChiOPKjH5cYlVIm2dh81c9x+9XkQcP4af3
	Vd0hwQieyZK94sBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xHHXrqW5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jeMSvCSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPlXmgWWykiwYFaSI8TaQFNF/XILIXsfXxcyJiCt34A=;
	b=xHHXrqW5bIRudLPppzia+s31nSmZamC5ymFM+PaRsjxwdyx1VJBX5p8/pURD9S2QlaJ6Wz
	CidO86qEPm9wnBz6T598LscytA1ioT36iZ7eWgA1ngLtsXufWGVoV1SZsJkVzW/h91glSR
	fIR1Q7st9Z5i39BIFO6svmt8MVjbfdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPlXmgWWykiwYFaSI8TaQFNF/XILIXsfXxcyJiCt34A=;
	b=jeMSvCSDSmNWHb7lMjTSPMQUjiQ/RzIzyF/kChiOPKjH5cYlVIm2dh81c9x+9XkQcP4af3
	Vd0hwQieyZK94sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58BF6136E5;
	Wed, 17 Jul 2024 11:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IU5QFdqpl2bjSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 11:24:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DB671A0987; Wed, 17 Jul 2024 13:24:09 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:24:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/9] fs: have setattr_copy handle multigrain
 timestamps appropriately
Message-ID: <20240717112409.i7qdiy35yxdyznng@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-4-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-4-48e5d34bd2ba@kernel.org>
X-Rspamd-Queue-Id: 78055219DB
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Mon 15-07-24 08:48:55, Jeff Layton wrote:
> The setattr codepath is still using coarse-grained timestamps, even on
> multigrain filesystems. To fix this, we need to fetch the timestamp for
> ctime updates later, at the point where the assignment occurs in
> setattr_copy.
> 
> On a multigrain inode, ignore the ia_ctime in the attrs, and always
> update the ctime to the current clock value. Update the atime and mtime
> with the same value (if needed) unless they are being set to other
> specific values, a'la utimes().
> 
> Note that we don't want to do this universally however, as some
> filesystems (e.g. most networked fs) want to do an explicit update
> elsewhere before updating the local inode.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

What is a bit bothering me is that it's now confusing that ATTR_MTIME_SET /
ATTR_ATIME_SET is handled in different place for mgtime and normal inodes
and I'm concerned this will bite us in the future. But not everybody is
using setattr_copy() and unifying the handling of timestamps seems like
quite some work...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

