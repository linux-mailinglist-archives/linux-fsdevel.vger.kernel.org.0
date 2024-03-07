Return-Path: <linux-fsdevel+bounces-13846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA2874AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74A4285177
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F64839F5;
	Thu,  7 Mar 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fJmc6qZb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SglerI6A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fJmc6qZb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SglerI6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73874204B;
	Thu,  7 Mar 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803457; cv=none; b=DIXSKHIxDcIUzTdP9GicLLCX59tA9hVxJN1W3mBfDm912EKuiY5lnCKfuwNLzO8XIOXAJSI2si4cBDFWbR10CgN4aknWSMxmZLRi363yVXORe51rWqolvosuRxwSEIrf6vZ58Kv80Fb/qWKgsWeE80Ahe4hzugeHcr6HzZmCEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803457; c=relaxed/simple;
	bh=yW37Kc1UpA3hbeae5CgQgM4MmchTV80N94rODYfGi60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmJhz+o4c9d9OecHZwCYq5C5xFPfy6iPU6LcDVJWUwoa/XsJO0wfFdOmHTAJ6t5l43C6cnHIcRAhqTl+j2v3b9aphBR8CRMzwVzYOcLF/vr8Dbaklg7Lg9UUqQP8tWixGfbqy6z4bzMwXtGQyNSMBABhifXMYsAWsBnuIHv522I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fJmc6qZb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SglerI6A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fJmc6qZb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SglerI6A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD4F1FF95;
	Thu,  7 Mar 2024 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709803389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYee3vvx8iNxYyDDjv7WZtOBNxQUBAc3szMxS6nwQ9w=;
	b=fJmc6qZbKhklZy8K+ek4ydHM/kvaXtxblM6a1IH2V3A5uz+U2sBwoZyFhyNqQtKpPRBqOz
	6jxd7q/V0k0kNwGg21YU/fvQWOWKtAkJ7RfFm2+9avAOn8zm+HX+Zw8484n4h8EKXA5OVa
	XlHJzTHNnv7CmC23zzTmh3XyhCG0hwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709803389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYee3vvx8iNxYyDDjv7WZtOBNxQUBAc3szMxS6nwQ9w=;
	b=SglerI6AhdKMNbyWGjOwfVpTztRjjFADkrkGOXWksAdyDqD8KFLoN58/JH2ATOPCZFHIJC
	rKDHpAYhV6uM8gBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709803389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYee3vvx8iNxYyDDjv7WZtOBNxQUBAc3szMxS6nwQ9w=;
	b=fJmc6qZbKhklZy8K+ek4ydHM/kvaXtxblM6a1IH2V3A5uz+U2sBwoZyFhyNqQtKpPRBqOz
	6jxd7q/V0k0kNwGg21YU/fvQWOWKtAkJ7RfFm2+9avAOn8zm+HX+Zw8484n4h8EKXA5OVa
	XlHJzTHNnv7CmC23zzTmh3XyhCG0hwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709803389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYee3vvx8iNxYyDDjv7WZtOBNxQUBAc3szMxS6nwQ9w=;
	b=SglerI6AhdKMNbyWGjOwfVpTztRjjFADkrkGOXWksAdyDqD8KFLoN58/JH2ATOPCZFHIJC
	rKDHpAYhV6uM8gBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D73F132A4;
	Thu,  7 Mar 2024 09:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id roWrDn2H6WWkGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 09:23:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9212A0803; Thu,  7 Mar 2024 10:23:08 +0100 (CET)
Date: Thu, 7 Mar 2024 10:23:08 +0100
From: Jan Kara <jack@suse.cz>
To: "Yin, Fengwei" <fengwei.yin@intel.com>
Cc: Yujie Liu <yujie.liu@intel.com>, Jan Kara <jack@suse.cz>,
	Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Message-ID: <20240307092308.u54fjngivmx23ty3@quack3>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3>
 <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee823ca-7100-4289-8670-95047463c09d@intel.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fJmc6qZb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SglerI6A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 4DD4F1FF95
X-Spam-Flag: NO

On Mon 04-03-24 13:35:10, Yin, Fengwei wrote:
> Hi Jan,
> 
> On 3/4/2024 12:59 PM, Yujie Liu wrote:
> >  From the perf profile, we can see that the contention of folio lru lock
> > becomes more intense. We also did a simple one-file "dd" test. Looks
> > like it is more likely that low-order folios are allocated after commit
> > ab4443fe3c (Fengwei will help provide the data soon). Therefore, the
> > average folio size decreases while the total folio amount increases,
> > which leads to touching lru lock more often.
> 
> I did following testing:
>   With a xfs image in tmpfs + mount it to /mnt and create 12G test file
>   (sparse-file), use one process to read it on a Ice Lake machine with
>   256G system memory. So we could make sure we are doing a sequential
>   file read with no page reclaim triggered.
> 
>   At the same time, profiling the distribution of order parameter of
>   filemap_alloc_folio() call to understand how the large folio order
>   for page cache is generated.
> 
> Here is what we got:
> 
> - Commit f0b7a0d1d46625db:
> $ dd bs=4k if=/mnt/sparse-file of=/dev/null
> 3145728+0 records in
> 3145728+0 records out
> 12884901888 bytes (13 GB, 12 GiB) copied, 2.52208 s, 5.01 GB/s
> 
> filemap_alloc_folio
>      page order    : count     distribution
>         0          : 57       |                                        |
>         1          : 0        |                                        |
>         2          : 20       |                                        |
>         3          : 2        |                                        |
>         4          : 4        |                                        |
>         5          : 98300    |****************************************|
> 
> - Commit ab4443fe3ca6:
> $ dd bs=4k if=/mnt/sparse-file of=/dev/null
> 3145728+0 records in
> 3145728+0 records out
> 12884901888 bytes (13 GB, 12 GiB) copied, 2.51469 s, 5.1 GB/s
> 
> filemap_alloc_folio
>      page order    : count     distribution
>         0          : 21       |                                        |
>         1          : 0        |                                        |
>         2          : 196615   |****************************************|
>         3          : 98303    |*******************                     |
>         4          : 98303    |*******************                     |
> 
> 
> Even the file read throughput is almost same. But the distribution of
> order looks like a regression with ab4443fe3ca6 (more smaller order
> page cache is generated than parent commit). Thanks.

Thanks for testing! This is an interesting result and certainly unexpected
for me. The readahead code allocates naturally aligned pages so based on
the distribution of allocations it seems that before commit ab4443fe3ca6
readahead window was at least 32 pages (128KB) aligned and so we allocated
order 5 pages. After the commit, the readahead window somehow ended up only
aligned to 20 modulo 32. To follow natural alignment and fill 128KB
readahead window we allocated order 2 page (got us to offset 24 modulo 32),
then order 3 page (got us to offset 0 modulo 32), order 4 page (larger
would not fit in 128KB readahead window now), and order 2 page to finish
filling the readahead window.

Now I'm not 100% sure why the readahead window alignment changed with
different rounding when placing readahead mark - probably that's some
artifact when readahead window is tiny in the beginning before we scale it
up (I'll verify by tracing whether everything ends up looking correctly
with the current code). So I don't expect this is a problem in ab4443fe3ca6
as such but it exposes the issue that readahead page insertion code should
perhaps strive to achieve better readahead window alignment with logical
file offset even at the cost of occasionally performing somewhat shorter
readahead. I'll look into this once I dig out of the huge heap of email
after vacation...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

