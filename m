Return-Path: <linux-fsdevel+bounces-26262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E4956B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0EC1C21DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16916B741;
	Mon, 19 Aug 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RXtoiguI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="We9J5E7k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RXtoiguI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="We9J5E7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F4171AA;
	Mon, 19 Aug 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071688; cv=none; b=Yl7tGl+RENOewZ/sz2aa++SSLWYOu9d7er8fhwI8UKWiymtR0NKjFJKrtEYofRmUiqpo5PD3kadUJlIhY8WeP5cXaM2Ci4bwTP1nP8yikoDLC1d1ZQZsABIgQsymvmfxGC4OmU1jJ/ayKbOOZplZboBg/QXMGAKSjkNXmDx7d2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071688; c=relaxed/simple;
	bh=HydNc9YeqS1n2tCRGnqjq33aIE7b/dj2IgGJsXVSX4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN1+Le4en7ZbwOpSJ9grnG1oayCqOgQ49WO/8B2PQ5ZsHjVkNzMFFsOYch7AwbgRqgnHlpTIy6fCmZPzGpSa4flBe/GnvQNFNGuLo/yRLdWXhPi1zzSIR8e3loHzjfuTXQX74xi6KDhP4X4fLlIY4gZCT4vY48QTTgz2oGrM5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RXtoiguI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=We9J5E7k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RXtoiguI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=We9J5E7k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89E6B2117A;
	Mon, 19 Aug 2024 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724071681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFCFhO6hZl457IRzJhBFYas41P7AtvK65yfv9OH7YqA=;
	b=RXtoiguI5s78ePFTXA+h+Cd5vs0DWIs8ilCGivIQ6fcrOKDB4WCbzpZPjKMcXKU/xsKw+I
	3lB+eNZyjkf8bXKONnKptjyDs39ZsxOehYjM8qhmy5zfiJtVXFdZ81nbPE9XJkfP4rcskM
	+0Zup79oCaOXMrNTQea/w1nEmOnS+S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724071681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFCFhO6hZl457IRzJhBFYas41P7AtvK65yfv9OH7YqA=;
	b=We9J5E7kt2BQCD3uo3xHiT0zA+7SUDRNmLi2TlbLRFrcSVvxrUaWe8yVHe/phG94FeOJ+u
	Z/Us8laZaGP0gjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724071681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFCFhO6hZl457IRzJhBFYas41P7AtvK65yfv9OH7YqA=;
	b=RXtoiguI5s78ePFTXA+h+Cd5vs0DWIs8ilCGivIQ6fcrOKDB4WCbzpZPjKMcXKU/xsKw+I
	3lB+eNZyjkf8bXKONnKptjyDs39ZsxOehYjM8qhmy5zfiJtVXFdZ81nbPE9XJkfP4rcskM
	+0Zup79oCaOXMrNTQea/w1nEmOnS+S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724071681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFCFhO6hZl457IRzJhBFYas41P7AtvK65yfv9OH7YqA=;
	b=We9J5E7kt2BQCD3uo3xHiT0zA+7SUDRNmLi2TlbLRFrcSVvxrUaWe8yVHe/phG94FeOJ+u
	Z/Us8laZaGP0gjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383AD1397F;
	Mon, 19 Aug 2024 12:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8SK7BQE/w2YcZwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 19 Aug 2024 12:48:01 +0000
Message-ID: <03ae65df-a369-436d-b31c-b3cec6ca3bc1@suse.de>
Date: Mon, 19 Aug 2024 14:48:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
To: David Howells <dhowells@redhat.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
 linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
 Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 john.g.garry@oracle.com, cl@os.amperecomputing.com, p.raghav@samsung.com,
 mcgrof@kernel.org, ryan.roberts@arm.com
References: <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3402933.1724068015@warthog.procyon.org.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3402933.1724068015@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 8/19/24 13:46, David Howells wrote:
> Hi Pankaj,
> 
> I can reproduce the problem with:
> 
> xfs_io -t -f -c "pwrite -S 0x58 0 40" -c "fsync" -c "truncate 4" -c "truncate 4096" /xfstest.test/wubble; od -x /xfstest.test/wubble
> 
> borrowed from generic/393.  I've distilled it down to the attached C program.
> 
> Turning on tracing and adding a bit more, I can see the problem happening.
> Here's an excerpt of the tracing (I've added some non-upstream tracepoints).
> Firstly, you can see the second pwrite at fpos 0, 40 bytes (ie. 0x28):
> 
>   pankaj-5833: netfs_write_iter: WRITE-ITER i=9e s=0 l=28 f=0
>   pankaj-5833: netfs_folio: pfn=116fec i=0009e ix=00000-00001 mod-streamw
> 
> Then first ftruncate() is called to reduce the file size to 4:
> 
>   pankaj-5833: netfs_truncate: ni=9e isz=2028 rsz=2028 zp=4000 to=4
>   pankaj-5833: netfs_inval_folio: pfn=116fec i=0009e ix=00000-00001 o=4 l=1ffc d=78787878
>   pankaj-5833: netfs_folio: pfn=116fec i=0009e ix=00000-00001 inval-part
>   pankaj-5833: netfs_set_size: ni=9e resize-file isz=4 rsz=4 zp=4
> 
> You can see the invalidate_folio call, with the offset at 0x4 an the length as
> 0x1ffc.  The data at the beginning of the page is 0x78787878.  This looks
> correct.
> 
> Then second ftruncate() is called to increase the file size to 4096
> (ie. 0x1000):
> 
>   pankaj-5833: netfs_truncate: ni=9e isz=4 rsz=4 zp=4 to=1000
>   pankaj-5833: netfs_inval_folio: pfn=116fec i=0009e ix=00000-00001 o=1000 l=1000 d=78787878
>   pankaj-5833: netfs_folio: pfn=116fec i=0009e ix=00000-00001 inval-part
>   pankaj-5833: netfs_set_size: ni=9e resize-file isz=1000 rsz=1000 zp=4
> 
> And here's the problem: in the invalidate_folio() call, the offset is 0x1000
> and the length is 0x1000 (o= and l=).  But that's the wrong half of the folio!
> I'm guessing that the caller thereafter clears the other half of the folio -
> the bit that should be kept.
> 
> David
> ---
> /* Distillation of the generic/393 xfstest */
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <fcntl.h>
> 
> #define ERR(x, y) do { if ((long)(x) == -1) { perror(y); exit(1); } } while(0)
> 
> static const char xxx[40] = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
> static const char yyy[40] = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy";
> static const char dropfile[] = "/proc/sys/vm/drop_caches";
> static const char droptype[] = "3";
> static const char file[] = "/xfstest.test/wubble";
> 
> int main(int argc, char *argv[])
> {
>          int fd, drop;
> 
> 	/* Fill in the second 8K block of the file... */
>          fd = open(file, O_CREAT|O_TRUNC|O_WRONLY, 0666);
>          ERR(fd, "open");
>          ERR(ftruncate(fd, 0), "pre-trunc $file");
>          ERR(pwrite(fd, yyy, sizeof(yyy), 0x2000), "write-2000");
>          ERR(close(fd), "close");
> 
> 	/* ... and drop the pagecache so that we get a streaming
> 	 * write, attaching some private data to the folio.
> 	 */
>          drop = open(dropfile, O_WRONLY);
>          ERR(drop, dropfile);
>          ERR(write(drop, droptype, sizeof(droptype) - 1), "write-drop");
>          ERR(close(drop), "close-drop");
> 
>          fd = open(file, O_WRONLY, 0666);
>          ERR(fd, "reopen");
> 	/* Make a streaming write on the first 8K block (needs O_WRONLY). */
>          ERR(pwrite(fd, xxx, sizeof(xxx), 0), "write-0");
> 	/* Now use truncate to shrink and reexpand. */
>          ERR(ftruncate(fd, 4), "trunc-4");
>          ERR(ftruncate(fd, 4096), "trunc-4096");
>          ERR(close(fd), "close-2");
>          exit(0);
> }
> 

Wouldn't the second truncate end up with a 4k file, and not an 8k?
IE the resulting file will be:
After step 1: 8k
After step 2: 4
After step 3: 4k

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


