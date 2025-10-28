Return-Path: <linux-fsdevel+bounces-65962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B100FC173A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948A73A8ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9136A5E9;
	Tue, 28 Oct 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W30sudym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3A355053
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691681; cv=none; b=YiJ5I7g1X3gN5GFoVKtWsxLwpdNlXQgEtDKMcT9/CeyB9pPiorohYM0ye5vlMyHLIXp5bnypT4oaYr7iTAO4IYMOZrVOK6Yvj+UOThJDp4H5o7vSb7rTPXARxirmw0eKOZEyLna8PWL6U6foyqYhOxunV/iQGgZN8bulHd/jRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691681; c=relaxed/simple;
	bh=1/WE+xbvc6Dal5pEAP6nQ5I9Rm9+W8PbrmOyYOyQAU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atxropIvzBYSL7KQMfHxxdyU68DdsbMm1Z4TipcDpP9xSn+230nB8aaUT/2NE9FImj6Yfj6aCYX4N1wirRbZPL0k5CNkUruGchMBpF8Z3v9HQOG8tfS7gHITHDGLrxjbkrmXBHFU9SY85iZ/x68G7i9lMtlyrhbN/XCPEqhp2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W30sudym; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290da96b37fso49465ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761691680; x=1762296480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=W30sudymZZrp4ynjftUHozOz2HuSQFvA/SRpYciZNEHK9RVgbZgYBBZ8W1sK0FSLz3
         GOUTFmW2eBvBklT+YTI0bBWHn+t+3xdwwtZc7j7ORSbELnpUw+uq88Vi1ywFkF+0FrZo
         5WBb/LecWkBKHxMB///Xs+yY6b8a0zx0ORcbhLkaxXB0sao9IE1fnM/EFUwfWcfB8Uwd
         tqTtCTb/h77fdJ+X5DzOw/ZqpIz87V5aPE0ameONgc0T7bP6XxUI3KYVgIQ0IAvt7gv0
         Lt7GJBAtjtB8vI1nvrLUswp7Rm+ey1+6VmxdG+g1AICdR/8x18p5ixQpdcCRYZMlYkZ+
         vtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691680; x=1762296480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=mcMvGUwZqi6YCB7p4HWLrU1wQiV5EJA+4jxrMQUNnDJwuUQUrayL6sIs0gjIe6TzRm
         yBRVFXg4gx1Ww8b0ewOKhTzlBlDQXfJUxLvAIdJ8HA3jyPjgKQNLv8zKHwx8l+07AtlF
         dDzgVl1urHmEm0vU7DB+6IdVSFHZM+YD5Y2bPOUNA8uqp8vayAeJBzpItdD3PmC1EsC8
         60FGqO90/Q63K5UWT0uy/LMcn4UqenlQWtLlEYDvj77stXX6Qaoi4bOU/8SwL8gMJydK
         DCmLfAazKAtaSbc1Ep6OuI4yy8yqnoa2QuEw7AAZj6DWXxO1C3fiwwFDzGvcDE4G7JL4
         9/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXieiAeyf/a79S+8W0oaDyvpINscg+/BfIwZvCsjHFMsDf4MFydRW2PcmWsIqeh/XinErYMUN4gHdxUhteA@vger.kernel.org
X-Gm-Message-State: AOJu0YymctVukAdPx5F9B2Ih0ZtYpsHUaYS8CorSw1SUnp2ij//4hPQ+
	oLvLRvMj8KRgK/9nGCBWUG1GAEfDmR0VjnsabkTrY4jJTKxmHxf3weJu94OE54+2vA==
X-Gm-Gg: ASbGncuQ2xTOx11tEQQVIMKjW6ROpCedZyGhKrc50il2weLi3KI5CChfeu44AbADkr3
	RaVqa+xm3uf/7tLqxwo7PZ19c3ob06pb3klxE/n0DEQCGqKuGmFYiTYKzdkzGnvZZ38Vg9QAfhZ
	cuYKQHVZnrLLthjSV3eoswgOgF6ZpqRzJKgJocTfDk98lIVIor/xTBhtMm3EZFZyLxUrd/zcT9G
	p/sOfPixmxiYMdLwSVMwbF6ASNPjX4rlGKWQMXtHeh2CTm5p/YKITUml6iZiiGf1wEm7m2T5xiA
	MZRc9p3+dzKGvnYyUGCAl1THdxEtx7ZKq5cMut0kbspXk7wWwn5Yv6aWcEOBsPAxbFxaMl95IVw
	kWuZE5QwWmAEpHgtKhwC562PTVpcmKjWcgAUfstUHi2b65W7Y9FkHLWmscsY3UTxf1liWYz0V6a
	ntSMbejnzSuwKLHvq4zEeqh/Wg+tTq/LBYzWYugCWji45d20CC7Bglc/glIA3WBzr3mvZnmXGEk
	J6R94j9N4WntnOSvBF8Dftz0u9uE8LK5dM=
X-Google-Smtp-Source: AGHT+IGVgm4/IjLLQT0cmQiv9nPeepYGw4HODw55Q9JYgkuJimkY420lDMBroEQm+to1DoESC9iCmA==
X-Received: by 2002:a17:902:f693:b0:291:6488:5af5 with SMTP id d9443c01a7336-294dffb2cecmr1077105ad.1.1761691679356;
        Tue, 28 Oct 2025 15:47:59 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4287bsm131385965ad.80.2025.10.28.15.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:47:58 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:47:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aQFIGaA5M4kDrTlw@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block
> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

Cc: Eric Biggers <ebiggers@google.com>

Ok, I did a bit more digging. I'm using f2fs but the problem in this
case is the blk_crypto layer. The OP_READ request goes through
submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
crypto context then it checks for bio_crypt_check_alignment().

This is where the LTP tests fails the alignment. However, the propagated
error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
get translates to EIO due to blk_status_to_errno().

I've verified this restores the original behavior matching the LTP test,
so I'll write up a patch and send it a bit later.

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 1336cbf5e3bd..a417843e7e4a 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 

