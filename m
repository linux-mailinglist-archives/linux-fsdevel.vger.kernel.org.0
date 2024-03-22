Return-Path: <linux-fsdevel+bounces-15128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F288746D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E21283427
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FEA7FBC2;
	Fri, 22 Mar 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CwCxXsr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="diahKUCp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CwCxXsr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="diahKUCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E253361;
	Fri, 22 Mar 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711142654; cv=none; b=JIMtMtsX6WspQQU/JJr82WZ/yZE0fd2bIf0jc1zdyMaUXBUM5k50du3K3OcGq0F9OR8OlVe8tNeHXevgYV/AjR5itRC6Gs6IK5bwwggb4emhtS6QpFuZWCSyD26ou65WpY7OKo7AlFWO0JHbboTpOsX9lAgTLiu740VchC1jjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711142654; c=relaxed/simple;
	bh=svZLIF9IPDRJYqbxji62ysRA098GzVPv/gg4mN30tOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH66UM5sXgA5GuMpeIYo7LzIenffOKVDRq1tjkZ/o6QulFjtChUr0Y1d9cfmaN01ekqnXNN4CSUaeK4atsCV1oMO7szxpWj/ZcgJ55NRJ2iPPSiFmFvWF/YgSL/RnUIfPGDdT+2cUjbu5BOlNxtQmF8GPGXiqG9NdM4SLXluhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CwCxXsr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=diahKUCp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CwCxXsr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=diahKUCp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 125435BD01;
	Fri, 22 Mar 2024 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711142649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTiBoCCpgcJDrCWIm/y2+RUNah4H94FoOE1Xfb7BT/0=;
	b=CwCxXsr1U4WYPyx0HSjjWrIbYLfgj8wc+ITOAPX0i9CghdmDJtCuzEwFNCKe+puhq1J0yF
	QIzobejC2nz4Xw/Rgv88u3b9L2SS2/9gyLCtbr6UXP6JmdA2dmq9w04NxQYW10i+CLIR3d
	RQHARTUoZtLCisc/JT0K5zqgLvVJwJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711142649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTiBoCCpgcJDrCWIm/y2+RUNah4H94FoOE1Xfb7BT/0=;
	b=diahKUCpSDSSlVrghuVWwDZy7EhJg7+YbHFGbryXiUDft15wMazZZI38iFNwdEXGFxYdQZ
	dHOC/EGu91FIhqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711142649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTiBoCCpgcJDrCWIm/y2+RUNah4H94FoOE1Xfb7BT/0=;
	b=CwCxXsr1U4WYPyx0HSjjWrIbYLfgj8wc+ITOAPX0i9CghdmDJtCuzEwFNCKe+puhq1J0yF
	QIzobejC2nz4Xw/Rgv88u3b9L2SS2/9gyLCtbr6UXP6JmdA2dmq9w04NxQYW10i+CLIR3d
	RQHARTUoZtLCisc/JT0K5zqgLvVJwJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711142649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTiBoCCpgcJDrCWIm/y2+RUNah4H94FoOE1Xfb7BT/0=;
	b=diahKUCpSDSSlVrghuVWwDZy7EhJg7+YbHFGbryXiUDft15wMazZZI38iFNwdEXGFxYdQZ
	dHOC/EGu91FIhqAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8229F138E8;
	Fri, 22 Mar 2024 21:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5I5wEvj2/WU+PgAAn2gu4w
	(envelope-from <ematsumiya@suse.de>); Fri, 22 Mar 2024 21:24:08 +0000
Date: Fri, 22 Mar 2024 18:23:54 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Disseldorp <ddiss@suse.de>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] Over-the-wire data compression
Message-ID: <vvwzjchwqlgmwrsaphak7zvwoecqjavq7zdwds2zvjuqj65dev@xbv77wuvvjyl>
References: <rnx34bfst5gyomkwooq2pvkxsjw5mrx5vxszhz7m4hy54yuma5@huwvwzgvrrru>
 <20240315122231.ktyx3ebd5mulo5or@quack3>
 <20240318215955.47e408bf@echidna>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240318215955.47e408bf@echidna>
X-Spam-Score: -6.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
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
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CwCxXsr1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=diahKUCp
X-Rspamd-Queue-Id: 125435BD01

Hi Dave,

On 03/18, David Disseldorp wrote:
>Hi Enzo,
>
>...
>> On Thu 14-03-24 15:14:49, Enzo Matsumiya wrote:
>> > Hello,
>> >
>> > Having implemented data compression for SMB2 messages in cifs.ko, I'd
>> > like to attend LSF/MM to discuss:
>> >
>> > - implementation decisions, both in the protocol level and in the
>> >   compression algorithms; e.g. performance improvements, what could,
>> >   if possible/wanted, turn into a lib/ module, etc
>> >
>> > - compression algorithms in general; talk about algorithms to determine
>> >   if/how compressible a blob of data is
>> >     * several such algorithms already exist and are used by on-disk
>> >       compression tools, but for over-the-wire compression maybe the
>> >       fastest one with good (not great nor best) predictability
>> >       could work?
>
>Ideally there could be some overlap between on-disk and over-the-wire
>compression algorithm support. That could allow optimally aligned /
>sized IOs to avoid unnecessary compression / decompression cycles on an
>SMB server / client if the underlying filesystem supports encoded I/O
>via e.g. BTRFS_IOC_ENCODED_READ/WRITE.

That's exactly the kind of discussion I'd be interested in when I
mentioned 'modules/subsystems with such overlapping
requirements/desire', and not only from the feature/integration
perspective, but the performance part is something I really wanted to
get right (good) from the beginning.

Which brought me to the 'how to detect uncompressible data' subject;
practical test at hand: when writing this 289MiB ISO file to an SMB
share with compression enabled, only 7 out of 69 WRITE requests
(~10%) are compressed.

(this is not the problem since SMB2 compression is supposed to be
done on a best-effort basis)

So, best effort... for 90% of this particular ISO file, cifs.ko "compressed"
those requests, reached an output with size >= to input size, discarded it
all, and sent the original uncompressed request instead => lots of CPU
cycles wasted.  Would be nice to not try to compress such data right of
the bat, or at least with minimal parsing, instead.

>IIUC, we currently have:
>SMB: LZ77, LZ77+Huffman (DEFLATE?), LZNT1, LZ4
>Btrfs: zlib/DEFLATE, LZO, Zstd
>Bcachefs: zlib/DEFLATE, LZ4, Zstd. Currently no encoded I/O support.

The algorithms required by SMB2 looks generic from an initial POV,
but due to some minor, but very important, implementation details,
I couldn't make a Windows Server decompress a DEFLATE'd buffer,
for example.  So I'm not really sure how such integration with other
subsystems would play out.

LZ4 might change this, but I haven't implemented it yet (btw thanks for
pointing me to its support in newest MS-SMB2 :)).


Cheers,

Enzo

