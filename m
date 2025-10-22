Return-Path: <linux-fsdevel+bounces-65056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5ABFA3BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11783B3BA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8BF2D8DB8;
	Wed, 22 Oct 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfEISTSp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+uxAEozI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c98A6kAs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NW/WnAUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC423D7F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114677; cv=none; b=Nc3sSZ87nYqUtF74IAHCCfR8Ad8+rgCzXFeKl3NmmrZnvNx3OU8s43zax2F2i+u/ePIqOm5NXAAE4wM2R8YO1l2+J/BRGyi/6dVlvcxfB41Kk0+z4WpDZiEpBaqG1y7jaO29wkZ1nwlfW7K6s03jfdcFcCD1WUtIRbOTg/zwBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114677; c=relaxed/simple;
	bh=TLfoUXoCL77yTs/JzVPOgpTaaY/RAoKiE3+KP7OJk4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPPxGKXXKqlHmIHy+6J4BNG4rxIuvCwOug+IPyg9SHPc7w3hqudNHMos8d1uNsw1s6lddvs5Z8GlmAyVb8IeNkh+7Syh1Y2AzAOHyshEuBKJ6C8ZPqDEAYiaH6EKvKsou2VZmCsfMLQ7Do0a+P8n8NkQUrhwsntGQh1Lu08bHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfEISTSp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+uxAEozI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c98A6kAs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NW/WnAUW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02E7C1F449;
	Wed, 22 Oct 2025 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761114670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtIUa+RiK10YmXKIYhygEd5F0AIbsac/XqT2ms8i91c=;
	b=YfEISTSp8XlFjgGhpA+uD7XcT/1nQOpjc/FKl3NJM3wjZ32Qm9fOO6jU5AV6QHGycE6zyr
	eDYnzK8sPckMop1TpZfed0XL1NFtAFdNj7qyTE6PjWiqbIHQ0Qp2g5ykIsStSqAaTAXnqo
	MxNAaXeK2Jz9Fs4wALPJbPHSCxBPETI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761114670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtIUa+RiK10YmXKIYhygEd5F0AIbsac/XqT2ms8i91c=;
	b=+uxAEozIk04zTKm1UljJrwJvZsCKk1XIcOe8BnttYzkH4Zv8Q6YjXyALyOc+Rji2CGyBFW
	V2bzhG9Iqia/9LCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761114666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtIUa+RiK10YmXKIYhygEd5F0AIbsac/XqT2ms8i91c=;
	b=c98A6kAszbGqrSQmaNVkQXUgMmKCW7SQLRrP5qlzymQza5RYvVTHuPgXCs+aX9eahdcmxD
	+UoSbB4HPrWKayamWi7bdtsMF7CkL4Cuc85JgufUddMGRHd2XYo0E7UP8jlqMgEF635VAJ
	FtgH3XDsMILuPujznsPnEkhzZ8OZK+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761114666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtIUa+RiK10YmXKIYhygEd5F0AIbsac/XqT2ms8i91c=;
	b=NW/WnAUWAwGS7KU7Z1F9omF+65CTmAINsuryiOfPtQX5nzGqMJ4Bw6kfsVoziPbA0FXRfA
	Y8TtmVaKyx2LVfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C906013A29;
	Wed, 22 Oct 2025 06:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M+/fMCl6+GgsXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 06:31:05 +0000
Date: Wed, 22 Oct 2025 08:30:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <20251022063056.GR13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,infradead.org,lst.de,mit.edu,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> The feature comparison summary
> ==============================
> 
> Feature                               ntfsplus   ntfs3
> ===================================   ========   ===========
> Write support                         Yes        Yes
> iomap support                         Yes        No
> No buffer head                        Yes        No
> Public utilities(mkfs, fsck, etc.)    Yes        No
> xfstests passed                       287        218
> Idmapped mount                        Yes        No
> Delayed allocation                    Yes        No
> Bonnie++                              Pass       Fail
> Journaling                            Planned    Inoperative
> ===================================   ========   ===========

Having two implementations of the same is problematic but I think what
votes for ntfs+ is that it's using the current internal interfaces like
iomap and no buffer heads. I'm not familiar with recent ntfs3
development but it would be good to know if the API conversions are
planned at all.

There are many filesystems using the old interfaces and I think most of
them will stay like that. The config options BUFFER_HEAD and FS_IOMAP
make the distinction what people care about most. In case of ntfs it's
clearly for interoperability.

As a user I'd be interested in feature parity with ntfs3, eg. I don't
see the label ioctls supported but it's a minor thing. Ideally there's
one full featured implementation but I take it that it may not be
feasible to update ntfs3 so it's equivalent to ntfs+. As this is not a
native linux filesystem swapping the implementation can be fairly
transparent, depending only on the config options. The drawback is
losing the history of fixed bugs that may show up again.

We could do the same as when ntfs3 appeared, but back then it had
arguably better position as it brought full write support. Right now I
understand it more of as maintenance problem.

