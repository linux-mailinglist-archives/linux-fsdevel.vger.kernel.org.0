Return-Path: <linux-fsdevel+bounces-77597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gy6J7H5lWlMXgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:41:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9A158613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E406E3004D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E8343D77;
	Wed, 18 Feb 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyGvQ/1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE15340A41
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436455; cv=none; b=i10Dv6XmolN6RkMRRB24i0avotLhjws77Y+B7+sau+xj7Br1XlXbsBCVqGCBaGWB+HjdO4e/Ec/cmOYbFOWasADQecBhxoJ+Ii6TM9E0CBmthSbgmZj21kTC1k5pWCE2pF5xuJsVipDO0Pa9dX1EENS/y9JAZeQwn5M/5802IVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436455; c=relaxed/simple;
	bh=oEGcWJ6uNixtn8g3bDM1JkvL6u4cUqsA7HGuS/QGEPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1RiOIAkQ0xYFjqNGEJpTt5fgV5J+K03IQKqoJca7AbnY14D2eQBi9ki8o/4ZQX1rm9b1zdTi/9Sdj/x+efeci26UB6lgu8GAKXoN2jdMeYT/V2pZCs4BdvwCDKnh0hJarGZ3zq4jzhnubM/4tX/JS92qaWmODCWbCUxCsgjZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyGvQ/1M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82491fbf02cso13740b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771436454; x=1772041254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWd8+ZQmkBQp+3rgZfgHdPB83evQicf7+tB0l6lsKxM=;
        b=WyGvQ/1MwiYNpiysZZbH5D/q5kUPL22LdLyaskDH8DBs+g5+gHRCKQhxXqh1EbT1aW
         asLPIThQjszRzzinr5IIrMgJNH43W7vBWo2S7UYyP9xcF5wsOicLy1lTyu0O7/jhK3tZ
         jA6dpmrM/zVNR74ne+dK7L064VmKYIuWcEOHpNptBDWFHDPlN2z1k0ppDy0Vvim/FmwS
         YWzyHN7eJqK7iZitmBevvvJ7d603Nkwn6RzVPJC7IPcetdyggr/84Ox38psVbCjWeDfc
         5naFs/uIQs+N0VMJf95m+N5N4ZFwCsd6cj2XHH7iNOL54DCbZmW2EE0nfBZQm83SgNxS
         ezDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771436454; x=1772041254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWd8+ZQmkBQp+3rgZfgHdPB83evQicf7+tB0l6lsKxM=;
        b=Cz3H8CzyuP+lgnF5PE4/beqNfkvK4mq/O7vAzov2WExVhtxEXHn1AMxrCHTPBlvkm7
         CdY58wrMuCQn7UtIC3vCnkGkX9EhtKwQM16oS0yaYUf4qIQaSw4g02Rfk33Vl4kyva/s
         DewsxzWDFdwQv7vnYukBaCSIbmY+L+gvMrGM0CBlI1uzWeBuXYnZsOYFNc+281g8BNFQ
         XSkVoMYYYFQ0lIJ5ylGScEvKdpI1LLHtVSY1pyOVloxOaWds3zJbQobJ69e7PYgOvKL5
         KlzkoIJ+Cc7k67mQgwFtbFpBz7LbYAKS6u3P92TWDxtuO+D5+8DrTMeM2OVUbblmvGGI
         9Kfg==
X-Gm-Message-State: AOJu0YywRz5PXM+dCC2aMplzxLqZ5Feb3sGsOQdT9HDPANnhpXaCMVvo
	YMTxi01nAyW5HamdCURD2aVWDi5lvbade2TGw12ay7iiFni7jI2IjUgy
X-Gm-Gg: AZuq6aIE75brbTgQuSHvrkZMsK+YTWxUdmHoPvo55fOLG2E+b1jQTt4JQtMsXwuRekm
	DvSSXwUf7DiOvGQEvbyoFmJ/moPzFVvHFRjQo73dzQ/By7zRLznHje8bnD/wVH613VJm8g7alhT
	aUhcc6yc2JBeQfRMK0e3dA+FvIAYYEU938NR0Nkk+FXzkrOvNyJfd6Czew7ISL/L6PasyCZ4cb0
	vHlAzhx1hNWz8Y4JvXCZ26sRtEgLAanXzTf6ghbEvGf/sBeQdkq6ic09LBKzD/P1rbZ3ZGju4Im
	SEhS4Upy3ixshQ3W2JOmgmCeBsgBgSPjhlFuosbCpab96cL8K9RQhRRtYJlXFdKN+5d+f9LJjZV
	FNeJGEWJFRkvz2d/Xsz7TZAUwSru7Orivr2XZMmqLXFqnOM8hSHBzZwd9Gmmg5Ee7cxkk1JpgMT
	XZobc8OrL4v+kpBsJfvZGJ5fwUXIJsPuc267OYJQ==
X-Received: by 2002:a05:6a00:3cc9:b0:824:b181:f492 with SMTP id d2e1a72fcca58-824d95f4ccamr14808764b3a.45.1771436453736;
        Wed, 18 Feb 2026 09:40:53 -0800 (PST)
Received: from [192.168.0.120] ([49.207.232.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94009sm17494261b3a.52.2026.02.18.09.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 09:40:53 -0800 (PST)
Message-ID: <1994c53d-4c4d-4b86-b66c-f8cb84ff7cf5@gmail.com>
Date: Wed, 18 Feb 2026 23:10:49 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] xfs: only flush when COW fork blocks overlap data
 fork holes
Content-Language: en-US
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-5-bfoster@redhat.com>
 <37206076c486da01efe90b95f5dc61049cb2d141.camel@gmail.com>
 <aZXc0vyT2zVcRXCp@bfoster>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aZXc0vyT2zVcRXCp@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77597-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA9A158613
X-Rspamd-Action: no action


On 2/18/26 21:07, Brian Foster wrote:
> On Tue, Feb 17, 2026 at 08:36:50PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2026-01-29 at 10:50 -0500, Brian Foster wrote:
>>> The zero range hole mapping flush case has been lifted from iomap
>>> into XFS. Now that we have more mapping context available from the
>>> ->iomap_begin() handler, we can isolate the flush further to when we
>>> know a hole is fronted by COW blocks.
>>>
>>> Rather than purely rely on pagecache dirty state, explicitly check
>>> for the case where a range is a hole in both forks. Otherwise trim
>>> to the range where there does happen to be overlap and use that for
>>> the pagecache writeback check. This might prevent some spurious
>>> zeroing, but more importantly makes it easier to remove the flush
>>> entirely.
>>>
>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>> ---
>>>   fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++------
>>>   1 file changed, 30 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>>> index 0edab7af4a10..0e82b4ec8264 100644
>>> --- a/fs/xfs/xfs_iomap.c
>>> +++ b/fs/xfs/xfs_iomap.c
>>> @@ -1760,10 +1760,12 @@ xfs_buffered_write_iomap_begin(
>>>   {
>>>   	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
>>>   						     iomap);
>>> +	struct address_space	*mapping = inode->i_mapping;
>>>   	struct xfs_inode	*ip = XFS_I(inode);
>>>   	struct xfs_mount	*mp = ip->i_mount;
>>>   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>>   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>>> +	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
>>>   	struct xfs_bmbt_irec	imap, cmap;
>>>   	struct xfs_iext_cursor	icur, ccur;
>>>   	xfs_fsblock_t		prealloc_blocks = 0;
>>> @@ -1831,6 +1833,8 @@ xfs_buffered_write_iomap_begin(
>>>   		}
>>>   		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
>>>   				&ccur, &cmap);
>>> +		if (!cow_eof)
>>> +			cow_fsb = cmap.br_startoff;
>>>   	}
>>>   
>>>   	/* We never need to allocate blocks for unsharing a hole. */
>>> @@ -1845,17 +1849,37 @@ xfs_buffered_write_iomap_begin(
>>>   	 * writeback to remap pending blocks and restart the lookup.
>>>   	 */
>>>   	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
>>> -		if (filemap_range_needs_writeback(inode->i_mapping, offset,
>>> -						  offset + count - 1)) {
>>> +		loff_t start, end;
>> Nit: Tab between data type and identifier?
>>
> Sure.
>
>>> +
>>> +		imap.br_blockcount = imap.br_startoff - offset_fsb;
>>> +		imap.br_startoff = offset_fsb;
>>> +		imap.br_startblock = HOLESTARTBLOCK;
>>> +		imap.br_state = XFS_EXT_NORM;
>>> +
>>> +		if (cow_fsb == NULLFILEOFF) {
>>> +			goto found_imap;
>>> +		} else if (cow_fsb > offset_fsb) {
>>> +			xfs_trim_extent(&imap, offset_fsb,
>>> +					cow_fsb - offset_fsb);
>>> +			goto found_imap;
>>> +		}
>>> +
>>> +		/* COW fork blocks overlap the hole */
>>> +		xfs_trim_extent(&imap, offset_fsb,
>>> +			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
>>> +		start = XFS_FSB_TO_B(mp, imap.br_startoff);
>>> +		end = XFS_FSB_TO_B(mp,
>>> +				   imap.br_startoff + imap.br_blockcount) - 1;
>> So, we are including the bytes in the block number (imap.br_startoff + imap.br_blockcount - 1)th,
>> right? That is why a -1 after XFS_FSB_TO_B()?
> Not sure I follow what you mean by the "bytes in the block number"
> phrasing..? Anyways, the XFS_FSB_TO_B() here should return the starting
> byte offset of the first block beyond the range (exclusive). The -1
> changes that to the last byte offset of the range we're interested in
> (inclusive), which I believe is what the filemap api wants..

Yeah, that answers my question. Thank you.

--NR

>
> Brian
>
>> --NR
>>> +		if (filemap_range_needs_writeback(mapping, start, end)) {
>>>   			xfs_iunlock(ip, lockmode);
>>> -			error = filemap_write_and_wait_range(inode->i_mapping,
>>> -						offset, offset + count - 1);
>>> +			error = filemap_write_and_wait_range(mapping, start,
>>> +							     end);
>>>   			if (error)
>>>   				return error;
>>>   			goto restart;
>>>   		}
>>> -		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
>>> -		goto out_unlock;
>>> +
>>> +		goto found_imap;
>>>   	}
>>>   
>>>   	/*

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


