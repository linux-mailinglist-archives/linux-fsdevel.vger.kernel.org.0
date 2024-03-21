Return-Path: <linux-fsdevel+bounces-15023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C788604C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 19:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5124A286E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E502F224D7;
	Thu, 21 Mar 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSTXFzpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyrZiQTK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSTXFzpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyrZiQTK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833311332AD;
	Thu, 21 Mar 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044428; cv=none; b=VXuR9U4HVodBJEenByiiYAmq6UT+vwYpkWm+Mc1oeFYJBYwZ70N8K9qAMKeFBw19akDpsOwEGAPUrfrTteV9l4odp4vK0fdIlmqeKjZOLnflpDHYyjM7KveM00/ICddpO1IYGGt7mjVXGZQDnIly6bu4B/a6nha9/Fp57LZEDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044428; c=relaxed/simple;
	bh=FwyV5G5T8xNWHin0iIxpU0FjYvWou7GfBsp3wgr/t4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmim6XYy+fyUDDINfrTCjq2yPLHWkJ7Gy+YEt83sjLBZvDn1OewMgCj51vOVXZmcBoTc+tL+etVHEuljBEypdsTAtKIlfEV0yWnZuS8luR+k98D7+A5jg+fyIcnLLtpouJsdC4QZeItq108LanRTGEKtoY6+y+Anxp84KtHS0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSTXFzpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyrZiQTK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSTXFzpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyrZiQTK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5EA35D2A6;
	Thu, 21 Mar 2024 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711044424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Er0BQY9yyhShKISjQxXgJJ4fPACRuENnuK7t6pwKzT4=;
	b=qSTXFzpHwuoVCvOZ3GNS+UgUHoMukzlTJ1tfGZc9Jr7tJURCmH13hi3dn0E7x5zdcIphWo
	qE0h5rGLe4h4RhuHex8TtU2gAEUO3Wa444zNqNphBj4BbfFOpbQYGSna8jPdk4+pzaKzR7
	O0Bny7FMVslcvK0cQBh18/xXp7z+ffU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711044424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Er0BQY9yyhShKISjQxXgJJ4fPACRuENnuK7t6pwKzT4=;
	b=jyrZiQTKOf1qUFHF6itTgEhgh9ek+6yvFInS0FE2apXbvmFgIRXstV9T5cToIhWeLvF5YV
	m7lzsrlNrV0o78AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711044424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Er0BQY9yyhShKISjQxXgJJ4fPACRuENnuK7t6pwKzT4=;
	b=qSTXFzpHwuoVCvOZ3GNS+UgUHoMukzlTJ1tfGZc9Jr7tJURCmH13hi3dn0E7x5zdcIphWo
	qE0h5rGLe4h4RhuHex8TtU2gAEUO3Wa444zNqNphBj4BbfFOpbQYGSna8jPdk4+pzaKzR7
	O0Bny7FMVslcvK0cQBh18/xXp7z+ffU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711044424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Er0BQY9yyhShKISjQxXgJJ4fPACRuENnuK7t6pwKzT4=;
	b=jyrZiQTKOf1qUFHF6itTgEhgh9ek+6yvFInS0FE2apXbvmFgIRXstV9T5cToIhWeLvF5YV
	m7lzsrlNrV0o78AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B7D5138A1;
	Thu, 21 Mar 2024 18:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rgb8JUh3/GXaOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 18:07:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 422C6A0806; Thu, 21 Mar 2024 19:07:04 +0100 (CET)
Date: Thu, 21 Mar 2024 19:07:04 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, tj@kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 0/6] Improve visibility of writeback
Message-ID: <20240321180704.lqmtdmd5tzsbuyyu@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320172240.7buswiv7zj2m5odg@quack3>
 <44e3b910-8b52-5583-f8a9-37105bf5e5b6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e3b910-8b52-5583-f8a9-37105bf5e5b6@huaweicloud.com>
X-Spam-Score: 4.30
X-Spamd-Result: default: False [4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu 21-03-24 16:12:52, Kemeng Shi wrote:
> on 3/21/2024 1:22 AM, Jan Kara wrote:
> > On Wed 20-03-24 19:02:16, Kemeng Shi wrote:
> >> This series tries to improve visilibity of writeback. Patch 1 make
> >> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
> >> instead of only writeback info in root cgroup. Patch 2 add a new
> >> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
> >> info. Patch 4 add wb_monitor.py to monitor basic writeback info
> >> of running system, more info could be added on demand. Rest patches
> >> are some random cleanups. More details can be found in respective
> >> patches. Thanks!
> >>
> >> Following domain hierarchy is tested:
> >>                 global domain (320G)
> >>                 /                 \
> >>         cgroup domain1(10G)     cgroup domain2(10G)
> >>                 |                 |
> >> bdi            wb1               wb2
> >>
> >> /* all writeback info of bdi is successfully collected */
> >> # cat /sys/kernel/debug/bdi/252:16/stats:
> >> BdiWriteback:              448 kB
> >> BdiReclaimable:        1303904 kB
> >> BdiDirtyThresh:      189914124 kB
> >> DirtyThresh:         195337564 kB
> >> BackgroundThresh:     32516508 kB
> >> BdiDirtied:            3591392 kB
> >> BdiWritten:            2287488 kB
> >> BdiWriteBandwidth:      322248 kBps
> >> b_dirty:                     0
> >> b_io:                        0
> >> b_more_io:                   2
> >> b_dirty_time:                0
> >> bdi_list:                    1
> >> state:                       1
> >>
> >> /* per wb writeback info is collected */
> >> # cat /sys/kernel/debug/bdi/252:16/wb_stats:
> >> cat wb_stats
> >> WbCgIno:                    1
> >> WbWriteback:                0 kB
> >> WbReclaimable:              0 kB
> >> WbDirtyThresh:              0 kB
> >> WbDirtied:                  0 kB
> >> WbWritten:                  0 kB
> >> WbWriteBandwidth:      102400 kBps
> >> b_dirty:                    0
> >> b_io:                       0
> >> b_more_io:                  0
> >> b_dirty_time:               0
> >> state:                      1
> >> WbCgIno:                 4284
> >> WbWriteback:              448 kB
> >> WbReclaimable:         818944 kB
> >> WbDirtyThresh:        3096524 kB
> >> WbDirtied:            2266880 kB
> >> WbWritten:            1447936 kB
> >> WbWriteBandwidth:      214036 kBps
> >> b_dirty:                    0
> >> b_io:                       0
> >> b_more_io:                  1
> >> b_dirty_time:               0
> >> state:                      5
> >> WbCgIno:                 4325
> >> WbWriteback:              224 kB
> >> WbReclaimable:         819392 kB
> >> WbDirtyThresh:        2920088 kB
> >> WbDirtied:            2551808 kB
> >> WbWritten:            1732416 kB
> >> WbWriteBandwidth:      201832 kBps
> >> b_dirty:                    0
> >> b_io:                       0
> >> b_more_io:                  1
> >> b_dirty_time:               0
> >> state:                      5
> >>
> >> /* monitor writeback info */
> >> # ./wb_monitor.py 252:16 -c
> >>                   writeback  reclaimable   dirtied   written    avg_bw
> >> 252:16_1                  0            0         0         0    102400
> >> 252:16_4284             672       820064   9230368   8410304    685612
> >> 252:16_4325             896       819840  10491264   9671648    652348
> >> 252:16                 1568      1639904  19721632  18081952   1440360
> >>
> >>
> >>                   writeback  reclaimable   dirtied   written    avg_bw
> >> 252:16_1                  0            0         0         0    102400
> >> 252:16_4284             672       820064   9230368   8410304    685612
> >> 252:16_4325             896       819840  10491264   9671648    652348
> >> 252:16                 1568      1639904  19721632  18081952   1440360
> >> ...
> > 
> > So I'm wondering: Are you implementing this just because this looks
> > interesting or do you have a real need for the functionality? Why?
> Hi Jan, I added debug files to test change in [1] which changes the way how
> dirty background threshold of wb is calculated. Without debug files, we could
> only monitor writeback to imply that threshold is corrected.
> In current patchset, debug info has not included dirty background threshold yet,
> I will add it when discution of calculation of dirty background threshold in [1]
> is done.
> The wb_monitor.py is suggested by Tejun in [2] to improve visibility of writeback.
> The script is more convenient than trace to monitor writeback behavior of the running
> system.

Thanks for the pointer. OK, I agree this is useful so let's have a look
into the code :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

