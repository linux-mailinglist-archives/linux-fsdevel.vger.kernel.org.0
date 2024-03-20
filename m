Return-Path: <linux-fsdevel+bounces-14912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F15881685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0E91F2660A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1E6BB27;
	Wed, 20 Mar 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puN0of6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtK5pfCB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puN0of6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtK5pfCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651E6A8C0;
	Wed, 20 Mar 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955365; cv=none; b=gALy2rZeD2FtKPela7FsnkxUMzypS1VSibV3psmm2KsnSGHF2JUZVS8glbxCz7ceUBAOnWs+NtCDkFGnMjzY68kRB3wQbRryyAIsPlXBwx7xK0qe9kXWgwRDyelHbAGN8IzxvqsNKwMnnTT5e9stcOxycb7xrfoByHyAtHeVFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955365; c=relaxed/simple;
	bh=DxJg+RgyKlnBqSxnRERu5DEqGICa3qsb7JyTUi2s88o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRz10ZNI0SZyXKoZrRnGEbVzm8OFyjhuLjguQrAWRVFqEHQqXrNDAvOV2s0kESUhFSBBcD6oTiSt64qZErKAidRR/hTDFepckppjXWXup3iSAuiHnT49v5i9uR8Cm/cbLKv3mn7fauEKMrCf3JaeN6nfsdfgOaA2qUBm7b++PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puN0of6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtK5pfCB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puN0of6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtK5pfCB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BCCB34875;
	Wed, 20 Mar 2024 17:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710955361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuvmLSJGfAFUcRzkMmUxW9qRIUCVm3vOjIWb2YFRR4Y=;
	b=puN0of6fZNsYdGdaQb+O2UNBhGxZGe41YGTYx6LNl9cTaOkEUZyQhYQq5K0UoLbemQ9B8J
	XTrMub46H8kdFIFLs31iK/FEbDsIIVcSsnLDxG5TyGVUy85k/H4Y+5gn+hSrWTv4mBHkVR
	v/uURHYPn9NJmGfCvSAcfKTcMGnFtOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710955361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuvmLSJGfAFUcRzkMmUxW9qRIUCVm3vOjIWb2YFRR4Y=;
	b=RtK5pfCBrNdbWQdznWPb0bH3fXRJV1S0BeSoIuMbnSmvcZsHD356E9XKAnLW/tdw5sQVe3
	WLqhuiWwzyR1K8DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710955361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuvmLSJGfAFUcRzkMmUxW9qRIUCVm3vOjIWb2YFRR4Y=;
	b=puN0of6fZNsYdGdaQb+O2UNBhGxZGe41YGTYx6LNl9cTaOkEUZyQhYQq5K0UoLbemQ9B8J
	XTrMub46H8kdFIFLs31iK/FEbDsIIVcSsnLDxG5TyGVUy85k/H4Y+5gn+hSrWTv4mBHkVR
	v/uURHYPn9NJmGfCvSAcfKTcMGnFtOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710955361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuvmLSJGfAFUcRzkMmUxW9qRIUCVm3vOjIWb2YFRR4Y=;
	b=RtK5pfCBrNdbWQdznWPb0bH3fXRJV1S0BeSoIuMbnSmvcZsHD356E9XKAnLW/tdw5sQVe3
	WLqhuiWwzyR1K8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 314E2136CD;
	Wed, 20 Mar 2024 17:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ay0JDGEb+2VhegAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 17:22:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0E85A080F; Wed, 20 Mar 2024 18:22:40 +0100 (CET)
Date: Wed, 20 Mar 2024 18:22:40 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 0/6] Improve visibility of writeback
Message-ID: <20240320172240.7buswiv7zj2m5odg@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-1-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Wed 20-03-24 19:02:16, Kemeng Shi wrote:
> This series tries to improve visilibity of writeback. Patch 1 make
> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
> instead of only writeback info in root cgroup. Patch 2 add a new
> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
> info. Patch 4 add wb_monitor.py to monitor basic writeback info
> of running system, more info could be added on demand. Rest patches
> are some random cleanups. More details can be found in respective
> patches. Thanks!
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* all writeback info of bdi is successfully collected */
> # cat /sys/kernel/debug/bdi/252:16/stats:
> BdiWriteback:              448 kB
> BdiReclaimable:        1303904 kB
> BdiDirtyThresh:      189914124 kB
> DirtyThresh:         195337564 kB
> BackgroundThresh:     32516508 kB
> BdiDirtied:            3591392 kB
> BdiWritten:            2287488 kB
> BdiWriteBandwidth:      322248 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   2
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> /* per wb writeback info is collected */
> # cat /sys/kernel/debug/bdi/252:16/wb_stats:
> cat wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1
> WbCgIno:                 4284
> WbWriteback:              448 kB
> WbReclaimable:         818944 kB
> WbDirtyThresh:        3096524 kB
> WbDirtied:            2266880 kB
> WbWritten:            1447936 kB
> WbWriteBandwidth:      214036 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  1
> b_dirty_time:               0
> state:                      5
> WbCgIno:                 4325
> WbWriteback:              224 kB
> WbReclaimable:         819392 kB
> WbDirtyThresh:        2920088 kB
> WbDirtied:            2551808 kB
> WbWritten:            1732416 kB
> WbWriteBandwidth:      201832 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  1
> b_dirty_time:               0
> state:                      5
> 
> /* monitor writeback info */
> # ./wb_monitor.py 252:16 -c
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> 
> 
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> ...

So I'm wondering: Are you implementing this just because this looks
interesting or do you have a real need for the functionality? Why?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

