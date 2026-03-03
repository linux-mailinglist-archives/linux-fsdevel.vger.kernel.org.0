Return-Path: <linux-fsdevel+bounces-79123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ4DN7abpmnfRgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 09:28:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C482D1EAC75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 09:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78CA03017A99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD337702F;
	Tue,  3 Mar 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auuNx0TI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE48319858
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526512; cv=none; b=PxufQyBsFFkE1GjO528qluma86sAop+kgayHaY/l12HEF/sSgTqwj6nJruu37L8+ZpyE+TvQmDhsV4mgzIcwCMRO04rK/NXV85LnmfPNFMBpz4SnnVVit3c9uEMW9g2+ebFbgg4JUuFsZ8WWFT5QS3ncEMilc1ddW/iclaLeO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526512; c=relaxed/simple;
	bh=Aj5EdWjVF2jxAv9z+0TobEuciQMJWsagsW0+QMnh1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU83CwAXusB5/UHrEXTTY1HXzPvq0/mrloQ/Q5mDBP+oUZdaXQYU41k7i7BL+cYE/tCna4oJs6EVO1NUc7pUrQUjuydRC+xs90bxHOgXf3ooMyDv5iIvrCLL5qs1cCrdUQeBft9EvARj90+EfUe/A19zhabXFTrk85QsPNKxozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auuNx0TI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65f812e0d93so8395990a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 00:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772526510; x=1773131310; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvQ9ogjqY7GpWZR0jhfLALG/vdl5wh/KcgbqbjmLgoM=;
        b=auuNx0TITUBFiDejhfcWAgaKfZGi66w9epcPluFifmQQVMHeAbWmAbxxpkd00+voNs
         VaLtWNSYtcrnH1IfNzIocbnswtPjEnfpYwfmd1gqQ9s8eMB7uuISwzOjt9fotju89BYB
         /h0GTQR6udvguK8EEgTsIZtJPn35KqpS+Vfm0Hhh7gsKpTcggxfebbDMl/EnL9M+m+xA
         4G0eAdK05eb0D/9BZdnub7EdoCnrSVgfuVVe7xGi9/z2mxcjz+2stb0un8I4hcUoVGxw
         bLf/Br2IUi7heuQHX3Pfk3TBLK3EsG5LzoS4pki/7ia0j0qT52QWIdTYGgaJ1bqX/+0+
         HETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526510; x=1773131310;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvQ9ogjqY7GpWZR0jhfLALG/vdl5wh/KcgbqbjmLgoM=;
        b=qkaBjpZGXv4I2JPbYxPGhpeVpWeBAXP6G13LiZQeQUOqfhIr+hztvLvoR6T6OfoaN6
         tQNOa7kftuUa/BYT+eV5pRjqZ1/m3O7eaaTUGXUCP9AkoLWxbapHPGYbtiNYuKQvW63S
         V+r8mxgj7Xwk4KQDJvRRcJj2kYbnNDjmOE85NZtx1m/phOecaYwCO+a3QDu6iyWwFkeU
         OeUOVeNb5nD+Q/NGWSDURRDElivLp3N/YN5uZg+eflTzLgSVkt08eDdVzY0I5udjK3wT
         /X+hnY+E1/o6MCBs5N7DlZ9wAuXwlHtnPTVbor+Ot08fQqoCl65FP6I5dIEE1dobfxR2
         Inog==
X-Forwarded-Encrypted: i=1; AJvYcCUP/tDc4eVj7479vftj9M3yoJhKdQp/gnHFpPRPRsSei3DZ4k8tqthMyPNxUR1NSBKIvmAw8sNSSkfUBZiD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0beoF4Lkzhf8SpX+/oYJPhiWc8eoJuUNAEZBvWKMzAl21Ctci
	sMfFFozeGcvUswCWJOyFqWvNS7HdBrH1x/8dkmmaB2kjwXhjNBt168A8
X-Gm-Gg: ATEYQzzq+KbPts1tsLDkf4SJndQwNi+c1jXXqgCzCoahHu+hXGTayh1kGcfygdM/ybT
	0CjlPJJoNO6XiwzEgp422Tse7TX6ee10aN3hvZ+/2xWngsYy0PnvdPL8DKJtqOn3fLuW05C71dI
	s+dxnz4h3OMEgWvGqY1mlLML9WVwnxMBrjERipp1ORaXRnMgzqlt8xpoYM3z7G4Tfgu62KnavnF
	0+TYEnC4h5Cxdiu+owqxyzV10IobgREWXchpd3oX+x4byKRAly2MbioyAZxrZvvmkmLO5lgruq6
	URXkcQziuT+kTFYvQJYWEtjcxkycjo+FYnqvRdhd5kFkuUsQn7c6T9VOK3oiYgbWiWIn732rf19
	I/QzXg+kjqRWwr7YPDpwt5AcfWXpAMsanBF25+Pr9hdwdkCRB7CoEpFdgecazkj0UJQmEzYSKzj
	8qqLdTzS3WDIBC8ogA9iGjqg==
X-Received: by 2002:a17:907:9492:b0:b93:94b9:26fe with SMTP id a640c23a62f3a-b9394b98ceamr771288166b.52.1772526509327;
        Tue, 03 Mar 2026 00:28:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac70b01sm559271466b.23.2026.03.03.00.28.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2026 00:28:28 -0800 (PST)
Date: Tue, 3 Mar 2026 08:28:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Bas van Dijk <bas@dfinity.org>, Eero Kelly <eero.kelly@dfinity.org>,
	Andrew Battat <andrew.battat@dfinity.org>,
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: fix a folio_split() race condition
 with folio_try_get()
Message-ID: <20260303082828.x2gypytceqn6pb6x@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260302203159.3208341-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302203159.3208341-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: C482D1EAC75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dfinity.org:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-79123-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:31:59PM -0500, Zi Yan wrote:
>During a pagecache folio split, the values in the related xarray should not
>be changed from the original folio at xarray split time until all
>after-split folios are well formed and stored in the xarray. Current use
>of xas_try_split() in __split_unmapped_folio() lets some after-split folios
>show up at wrong indices in the xarray. When these misplaced after-split
>folios are unfrozen, before correct folios are stored via __xa_store(), and
>grabbed by folio_try_get(), they are returned to userspace at wrong file
>indices, causing data corruption. More detailed explanation is at the
>bottom.
>
>The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
>It
>1. creates a memfd,
>2. forks,
>3. in the child process, maps the file with large folios (via shmem code
>   path) and reads the mapped file continuously with 16 threads,
>4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
>   large folio.
>
>Data corruption can be observed without the fix. Basically, data from a
>wrong page->index is returned.
>
>Fix it by using the original folio in xas_try_split() calls, so that
>folio_try_get() can get the right after-split folios after the original
>folio is unfrozen.
>
>Uniform split, split_huge_page*(), is not affected, since it uses
>xas_split_alloc() and xas_split() only once and stores the original folio
>in the xarray. Change xas_split() used in uniform split branch to use
>the original folio to avoid confusion.
>
>Fixes below points to the commit introduces the code, but folio_split() is
>used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
>truncate operation").
>
>More details:
>
>For example, a folio f is split non-uniformly into f, f2, f3, f4 like
>below:
>+----------------+---------+----+----+
>|       f        |    f2   | f3 | f4 |
>+----------------+---------+----+----+
>but the xarray would look like below after __split_unmapped_folio() is
>done:
>+----------------+---------+----+----+
>|       f        |    f2   | f3 | f3 |
>+----------------+---------+----+----+
>

Thanks for the detailed explanation, I finally realized it behaves like this.

>After __split_unmapped_folio(), the code changes the xarray and unfreezes
>after-split folios:
>
>1. unfreezes f2, __xa_store(f2)
>2. unfreezes f3, __xa_store(f3)
>3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
>4. unfreezes f.
>
>Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
>xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
>f3 is wrongly returned to user.
>
>After the fix, the xarray looks like below after __split_unmapped_folio():
>+----------------+---------+----+----+
>|       f        |    f    | f  | f  |
>+----------------+---------+----+----+
>so that the race window no longer exists.

Since we unfreeze f at last.

>
>Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reported-by: Bas van Dijk <bas@dfinity.org>
>Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
>Tested-by: Lance Yang <lance.yang@linux.dev>
>Cc: <stable@vger.kernel.org>

So thanks for the fix.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

