Return-Path: <linux-fsdevel+bounces-79572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIOiMW82qml+NQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 03:05:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBBE21A763
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 03:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295F9304BCE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14E32548B;
	Fri,  6 Mar 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihLWS+Iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954130DEB2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762710; cv=none; b=FJq7ue7JS/QCpnvxF5i5glEmUWsmnWecCsjSCWnMQpEWQHB/wJIyOnQaZkCK6FK4m0Y01A1xks9CbslR6/7A7UucxEAcHxS7dJaKmtdUp5IS532OjO0sMqqc/3gAYOqSDLeTnBbyEkY3M3SxqqTqvmo5gTJT5TJOcPT1gG4jdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762710; c=relaxed/simple;
	bh=ZolZG20xlR9hrqrydDArlydwOBb0Hn40AqcbjCpEHMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i//Kl47DMFh6Cw6XIjzOxuAUeR/0vXBJ6iD2TEDiOhgOibBreX9DhR7BMhl+xNr3Zbi1dyL/1XPl9yQvtYl/tcB7kEcHNcFIFiK3TwlL90s7L6i7oe/4wGj6r20SUlCQ6tnhdm4gp+6JlSKivU2Q/gu4QMFgxwPvwiOug7EBunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihLWS+Iz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598cab697eso3078759a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 18:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772762709; x=1773367509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6hWoJU5NFg6LYKfkwpfVqwiXWe8S4He0GFrCPJwzgU=;
        b=ihLWS+IzPrj1U7wuqA5J4pD1nn4TFhJbBBNnRU96OsATCevjQLpTq1byNq/s1+OUda
         dxnLK5deShRvU9LukIOyMWpCJwRL/R4pAyGfxCDqYS6znNagDNshvJBE9ZTaH3UWPFS1
         /A37Fps2hEz8Hg8VLJKd7cxOShHTbf6xBWCNjt9s4JX7Wy0fFQuls6OmpCd1oye2lgJZ
         FvAE+/5VPuUyocPru/Fruu/LUy2BCIE2OfJYNwCpY8EBuHLYdvuJ3JfXEFgeceH45GQB
         5poGkwHbOyQqyB0hpUts9CaKXSu3Q7XeRRxa2A7d0babud2Op99sI+94oktJDRzflRq5
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762709; x=1773367509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6hWoJU5NFg6LYKfkwpfVqwiXWe8S4He0GFrCPJwzgU=;
        b=o9JWAbsRzfze8rO43aTV3dtujKkSL2Hyy7ee3qp2z0f8VI9c3q7TKrJ+QTUBumefqK
         yD+7N2bsBJPnFAgDHS0mv6o97/iylmMqutidIrFmZZB5U6OuHcPSA8tieeQ6wXkEyjxr
         eu/xa3Xnvudw8gFA5vETbSfm8uXzRbyj7buTbh2q1XufdLRaLBFATNGm1XvS5S+7fyqY
         I0FxKXHXmavSJ/aNtwvomq1BX6N+e7RKPfqNDEP2Bse1ujBPy0FpqcQTA4IlyP6MLGHG
         3ljqPUJHI6sPSDfhMjqEzyL3jXQ8fh26wIOHoHf6GKtbCUIYZkGCTUkazGaUFT9Cw4FY
         /fSw==
X-Forwarded-Encrypted: i=1; AJvYcCWqks2WK+pHumqZD6Dxu7grT/tUDrx6uvIFZeiorQGsgXCrCea8pkCrUDqzVVFmwbN4a7a/iVQVIJE+bIf4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9mO1uxUc5sSdfZZaR0unpY0cm/ETdEc1WMKvQb9gyxFOXujI
	gKxYEOiXJm38hbPvLA33o8oVPQCbcG5FBYNVFpWkWWIzpWUjIHRrg5C8
X-Gm-Gg: ATEYQzyj23RVzS4f2uEYNUB31DV7z82j3A6ua9cPFdKl7YmCbpCaUYUxPgAQVqHisyp
	ZjFUNs2/escWszjTbEkeMtaLFxW7AcdBhAxO6V1zfoU+d4X5Nwci3MCkUioyzwQ23mg3mkGkUlA
	07IF+3pLZeM1ujm/XAIBATz/P8f8n+TQJYVs/PcsPe9NBSqbRIrYY722/yJ9/02B3LcqWUChKqe
	TiEgXvQHFyR7qI25dg8NAbF40xKjIDGjmExBKWaWFCAsSn5+Fef6R/g/rrkC44NiiiVuJFnFrWj
	+1HlGyImwT3WHN307x5s6qd4g7oJ240HNZhZdR1BGPeFLdAxroVEHwJra+NBXEpYddlrdkkvEOu
	cWk/l6d3oEHJ+JjYxulsyeVrl/eyCVPdFxBZ8Y5FQ6eBOIH3zIe2L8SlpNtPEhdKvsEvTNHQaD6
	92wxR2aCoNuDxHjg==
X-Received: by 2002:a17:90b:3e86:b0:359:83a3:584d with SMTP id 98e67ed59e1d1-359b1ba5209mr3908844a91.6.1772762708740;
        Thu, 05 Mar 2026 18:05:08 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c003bd46sm22440a91.4.2026.03.05.18.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:05:08 -0800 (PST)
Date: Fri, 6 Mar 2026 11:05:05 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aao2Ua94b16am-BE@hyunchul-PC02>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
 <aajObSSRGVXG3sI_@hyunchul-PC02>
 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
 <aaomj9LgbfSem-aF@hyunchul-PC02>
 <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
X-Rspamd-Queue-Id: 4CBBE21A763
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79572-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:23:16AM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-06 at 09:57 +0900, Hyunchul Lee wrote:
> > On Thu, Mar 05, 2026 at 11:21:19PM +0000, Viacheslav Dubeyko wrote:
> > > On Thu, 2026-03-05 at 10:52 +0900, Hyunchul Lee wrote:
> > > > > > 
> > > > > > Sorry it's generic/285, not generic/268.
> > > > > > in generic/285, there is a test that creates a hole exceeding the block
> > > > > > size and appends small data to the file. hfsplus fails because it fills
> > > > > > the block device and returns ENOSPC. However if it returns EFBIG
> > > > > > instead, the test is skipped.
> > > > > > 
> > > > > > For writes like xfs_io -c "pwrite 8t 512", should fops->write_iter
> > > > > > returns ENOSPC, or would it be better to return EFBIG?
> > > > > > > 
> > > > > 
> > > > > Current hfsplus_file_extend() implementation doesn't support holes. I assume you
> > > > > mean this code [1]:
> > > > > 
> > > > >         len = hip->clump_blocks;
> > > > >         start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
> > > > >         if (start >= sbi->total_blocks) {
> > > > >                 start = hfsplus_block_allocate(sb, goal, 0, &len);
> > > > >                 if (start >= goal) {
> > > > >                         res = -ENOSPC;
> > > > >                         goto out;
> > > > >                 }
> > > > >         }
> > > > > 
> > > > > Am I correct?
> > > > > 
> > > > Yes,
> > > > 
> > > > hfsplus_write_begin()
> > > >   cont_write_begin()
> > > >     cont_expand_zero()
> > > > 
> > > > 1) xfs_io -c "pwrite 8t 512"
> > > > 2) hfsplus_begin_write() is called with offset 2^43 and length 512
> > > > 3) cont_expand_zero() allocates and zeroes out one block repeatedly
> > > > for the range
> > > > 0 to 2^43 - 1. To achieve this, hfsplus_write_begin() is called repeatedly.
> > > > 4) hfsplus_write_begin() allocates one block through hfsplus_get_block() =>
> > > > hfsplus_file_extend()
> > > 
> > > I think we can consider these directions:
> > > 
> > > (1) Currently, HFS+ code doesn't support holes. So, it means that
> > > hfsplus_write_begin() can check pos variable and i_size_read(inode). If pos is
> > > bigger than i_size_read(inode), then hfsplus_file_extend() will reject such
> > > request. So, we can return error code (probably, -EFBIG) for this case without
> > > calling hfsplus_file_extend(). But, from another point of view, maybe,
> > > hfsplus_file_extend() could be one place for this check. Does it make sense?
> > > 
> > > (2) I think that hfsplus_file_extend() could treat hole or absence of free
> > > blocks like -ENOSPC. Probably, we can change the error code from -ENOSPC to -
> > > EFBIG in hfsplus_write_begin(). What do you think?
> > > 
> > Even if holes are not supported, shouldn't the following writes be
> > supported?
> > 
> > xfs_io -f -c "pwrite 4k 512" <file-path>
> > 
> > If so, since we need to support cases where pos > i_size_read(inode),
> 
> The pos > i_size_read(inode) means that you create the hole. Because,

That's correct. However I believe that not supporting writes like the
one mentioned above is a significant limitation. Filesystems that don't
support sparse files, such as exFAT, allocate blocks and fill them with
zeros.

> oppositely, when HFS+ logic tries to allocate new block, then it expects to have
> pos == i_size_read(inode). And we need to take into account this code [1]:
> 
> 	if (iblock >= hip->fs_blocks) {
> 		if (!create)
> 			return 0;
> 		if (iblock > hip->fs_blocks) <-- This is the rejection of hole
> 			return -EIO;
> 		if (ablock >= hip->alloc_blocks) {
> 			res = hfsplus_file_extend(inode, false);
> 			if (res)
> 				return res;
> 		}
> 	}
> 
> The generic_write_end() changes the inode size: i_size_write(inode, pos +
> copied).

I think that it's not problem.

hfsplus_write_begin()
  cont_write_begin()
    cont_expand_zero()

cont_expand_zero() calls hfsplus_get_block() to allocate blocks between
i_size_read(inode) and pos, if pos > i_size_read(inode).

> 
> > wouldn't the condition "pos - i_size_read(inode) > free space" be better?
> > Also instead of checking every time in hfsplus_write_begin() or
> > hfsplus_file_extend(), how about implementing the check in the
> > file_operations->write_iter callback function, and returing EFBIG?
> 
> Which callback do you mean here? I am not sure that it's good idea.
> 

Here is a simple code snippet.

 static const struct file_operations hfsplus_file_operations = {
...
-       .write_iter     = generic_file_write_iter,
+       .write_iter     = hfsplus_file_write_iter,
...

+ssize_t hfsplus_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
...
+       // check iocb->ki_pos is beyond i_size
+
+       ret = generic_file_write_iter(iocb, iter);

> Thanks,
> Slava.
> 
> > 
> > > > 
> > > > 
> 
> [1] https://elixir.bootlin.com/linux/v6.19/source/fs/hfsplus/extents.c#L239

-- 
Thanks,
Hyunchul

