Return-Path: <linux-fsdevel+bounces-79562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LJ0M84mqmkPMAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:58:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62321A131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E6D306C531
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BB29AB1D;
	Fri,  6 Mar 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHMKvdiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F58460
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758675; cv=none; b=dXkjZ6ZMuAP9mI/Q8TlW7fq+1+Loteau4jugq6TnPb3F4Hhtlf1DhdkoYg4skdoVKa8dXPEEayR0bLXK9oskNiLUobJ4jJ3EYdP+0SA5GoylqM3RMohtAYTUOho2lTO3iOuX5n4jQGZqPNMwjBuxzov6wmzdWlgYq4O6RqQ5xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758675; c=relaxed/simple;
	bh=H/noKFijjQAfvZCSx1FwetyN0avY2FIuEC59BiOhtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQTKxY9OHrNCgSataKbFSr7ZzTL7UkPaaQgcqo6NkM5lCRn0vwwANUmhU27bQtqsiXuaRwCfZ0eMD4KPZZqmx/zkWyldClLbZAHyCkOtrDByrkQOj2DsiIWGTKZUY5XZ+M6nOruYu3QMWHoy2obB05B0VgRPm+d8vHWSDsD2Oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHMKvdiJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824a829f9bbso4189678b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772758674; x=1773363474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyEJhbPGTj4iMvGkLm4FmHRGU2FBZ4orT9yHK/RJcWo=;
        b=kHMKvdiJbrfr86M3ZzdXUhPdzm4JN9O5LwqNLRLFrJWnzLD3zKVYUozEUTCCcsmVkH
         qNq/Iew70LnKX1iRBkM9eMIOCmQfNmx49LXhv+5GO005AaZZbhRFqKA/G+ceilAceAyS
         kpP5Xml04f+3LdRH15ZtFhgH1xrZN+zjyFOXvBHj9vq/U3Xnhgx4W2V7zWO0YQ1U7PWG
         D/TwaBbuWpS7z61uQn4spLCOV/0AZL0oIpwQCjebjF9Eg4xGzhU+ZqbknfJyZ3UtuODO
         kzNBvA3E/SZPeYd30f/oh5IjmZDuzPEWC0c/UD/eTww8/SwivY95tAMUtB+Zd6xyAPni
         BgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758674; x=1773363474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyEJhbPGTj4iMvGkLm4FmHRGU2FBZ4orT9yHK/RJcWo=;
        b=bV/eltoMNEQJsxac1Bx1h3QJ7cTfoRWrJq3jbAK593PWRWGk5I7l8V6wqkolJXYmaK
         FjATdnl/DCFhpuAyegn9cdbnIjeuvmZQ91urqN/FR/XdQKHfgf0HoFxAsQ4SPw1OkkD4
         fZxsug/g3KxIVatmqA5gZ7a7rJxsllbUK9prQ+6gA4ZFiKh0rWH7To7n5VT17NLHhlzy
         UIoNePNNF6bLjaRqerVVGGVrrLcgpgG0DqStCQO7H3ZNPmPOKl5Sq7TL980pPEqssR7k
         TLyevftS19yREx4NCsBbgNcQxylNRp8zPtrt535GiKO7u0rDiXoYLviOou1NEUAcHHWn
         3f5w==
X-Forwarded-Encrypted: i=1; AJvYcCUYZfIVWY20ju5KAdeJsPQJwvhiTu4rbaAdN11fJD3jd2AgSQJNJw0M9x+FGCUgtuiDCyMIVSjc9JMvft+w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Sxx2750O85uxYNuXtU+kef926/N4n4yL1Baas1GiWrdEo0Aw
	5IWUpApKrcY8XtngP9OFkLb0qkWBpk3apDabirGLNrVJURGUOl4vlBxG
X-Gm-Gg: ATEYQzwzn9pPcEIqSj9zyI6tjX3DkRrBTGBIFipTFVBCSIiilAvLoLR//Qmz6i3bpqx
	B0bz5UPCLJGyMXfmrfIItm8P9+zWp+l8x9WCjw4f7uaFK9CgSdaMRCb9eRiXTwwS4QwQ87l3FhH
	HK+8wMyAb6ZgT57SRFnrlom2yAovx/itqfK4ttCCcGAS7+ogK4jMZ8ZGLRWHn1Ni0daKtC+T+Wn
	5GV3CWb+2loNkNj+xbAz/lb9rK8Z3zMg8vbC6GuydSRzi3xbp0tqygf1+EfCeSVjUp85dScj0qA
	WmHwSCb4lHheEiEz9IVT9ePZzdbaOpzv4Hh0Kf3DiD9Vbej833Es8Q4aDemXzTuvNZXNNVnv9Yg
	FX5Fi+45kP5pHA7P5UivYigBjtWL1fgXszdyYJD5Z1JJpcebA5KzOK+0fcu3lW8Dk2NL9cpXCJ/
	t6zqRz50Ljffptdg==
X-Received: by 2002:a05:6a00:2d19:b0:81f:9f14:ecc8 with SMTP id d2e1a72fcca58-829a2e11182mr225838b3a.27.1772758673940;
        Thu, 05 Mar 2026 16:57:53 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8298cf9bf14sm2584932b3a.48.2026.03.05.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:57:53 -0800 (PST)
Date: Fri, 6 Mar 2026 09:57:51 +0900
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
Message-ID: <aaomj9LgbfSem-aF@hyunchul-PC02>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
 <aajObSSRGVXG3sI_@hyunchul-PC02>
 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
X-Rspamd-Queue-Id: 3A62321A131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79562-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proofpoint.com:url]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:21:19PM +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-03-05 at 10:52 +0900, Hyunchul Lee wrote:
> > > > 
> > > > Sorry it's generic/285, not generic/268.
> > > > in generic/285, there is a test that creates a hole exceeding the block
> > > > size and appends small data to the file. hfsplus fails because it fills
> > > > the block device and returns ENOSPC. However if it returns EFBIG
> > > > instead, the test is skipped.
> > > > 
> > > > For writes like xfs_io -c "pwrite 8t 512", should fops->write_iter
> > > > returns ENOSPC, or would it be better to return EFBIG?
> > > > > 
> > > 
> > > Current hfsplus_file_extend() implementation doesn't support holes. I assume you
> > > mean this code [1]:
> > > 
> > >         len = hip->clump_blocks;
> > >         start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
> > >         if (start >= sbi->total_blocks) {
> > >                 start = hfsplus_block_allocate(sb, goal, 0, &len);
> > >                 if (start >= goal) {
> > >                         res = -ENOSPC;
> > >                         goto out;
> > >                 }
> > >         }
> > > 
> > > Am I correct?
> > > 
> > Yes,
> > 
> > hfsplus_write_begin()
> >   cont_write_begin()
> >     cont_expand_zero()
> > 
> > 1) xfs_io -c "pwrite 8t 512"
> > 2) hfsplus_begin_write() is called with offset 2^43 and length 512
> > 3) cont_expand_zero() allocates and zeroes out one block repeatedly
> > for the range
> > 0 to 2^43 - 1. To achieve this, hfsplus_write_begin() is called repeatedly.
> > 4) hfsplus_write_begin() allocates one block through hfsplus_get_block() =>
> > hfsplus_file_extend()
> 
> I think we can consider these directions:
> 
> (1) Currently, HFS+ code doesn't support holes. So, it means that
> hfsplus_write_begin() can check pos variable and i_size_read(inode). If pos is
> bigger than i_size_read(inode), then hfsplus_file_extend() will reject such
> request. So, we can return error code (probably, -EFBIG) for this case without
> calling hfsplus_file_extend(). But, from another point of view, maybe,
> hfsplus_file_extend() could be one place for this check. Does it make sense?
> 
> (2) I think that hfsplus_file_extend() could treat hole or absence of free
> blocks like -ENOSPC. Probably, we can change the error code from -ENOSPC to -
> EFBIG in hfsplus_write_begin(). What do you think?
> 
Even if holes are not supported, shouldn't the following writes be
supported?

xfs_io -f -c "pwrite 4k 512" <file-path>

If so, since we need to support cases where pos > i_size_read(inode),
wouldn't the condition "pos - i_size_read(inode) > free space" be better?
Also instead of checking every time in hfsplus_write_begin() or
hfsplus_file_extend(), how about implementing the check in the
file_operations->write_iter callback function, and returing EFBIG?

> > 
> > > Do you mean that calling logic expects -EFBIG? Potentially, if we tries to
> > > extend the file, then -EFBIG could be more appropriate. But it needs to check
> > > the whole call trace.
> > 
> > generic/285 creates a hole by pwrite at offset 2^43 + @ and handle the
> > error as follow:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_kdave_xfstests_blob_master_src_seek-5Fsanity-5Ftest.c-23L271&d=DwIFaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=84S8DZyqlgcJA0uzXVPYD-cvdonhvyi5kMWaklKdNjD8otp-dvtHXuL2O2CridFV&s=6jI_AQCduo5Tim8ioI5V8Xy50jguCLUTx1CSFEF__D0&e= 
> > 
> > if (errno == EFBIG) {
> >   fprintf(stdout, "Test skipped as fs doesn't support so large files.\n");
> >   ret = 0
> > 
> 
> I believe we need follow to system call documentation but not what some
> particular script expects to see. :) But -EFBIG sounds like reasonable error
> code.
> 

I agree.

> Thanks,
> Slava.
> 
> > 

-- 
Thanks,
Hyunchul

