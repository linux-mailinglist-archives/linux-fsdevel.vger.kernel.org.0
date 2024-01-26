Return-Path: <linux-fsdevel+bounces-9126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80CA83E58A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6052820AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7145962;
	Fri, 26 Jan 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="C+Y8g7yQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DE4595B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308367; cv=none; b=cX9LvsEqgaGvLK0HhiXlmDKh1n66DHpe+aSkgOiTBgM8ZzdZXXOCRQI4gAmQwUb1GaSmuz2VEmo6jZL2pHaVHZ/Ys7pgQDXYKskiid9/IdlAwCgOSnYwgNpK7bsvJcQ5JOd9MCiOVyHzzjwy8ql0ocOf/mqZ+2FusH5gesqvkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308367; c=relaxed/simple;
	bh=J+5WKFLHVsBlfVSIRyDQJYUBBjJs+P0L4nu6kT8g0Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU2izV891U0Xpeyz6yybf0lq4LuoeWPvx0IceDS5NLBdxu/hi5R104TWkcRzaqkj0oPuW7YbaDk3CjMC2qhydumkx/1f57gOCfjMVDLhO7RQAZ72g34R69i3KWxx0aF0BDt0FmY9NuBt/sfH+mNf/3Kh3usaFBlCilyEfkNyDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=C+Y8g7yQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1036260b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706308365; x=1706913165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvqwarObUMhsnRd5Sm84iSEstGk+2La44YqED30Zd/E=;
        b=C+Y8g7yQBegfG7axjZpj1NZN6Zhs7GG7HThvR+AT+7c6zoeZlo8N2HgWMXE9s777M6
         pboh5A8iENfg0xfXaewk1Poy4jAzDfcKXUfDi2RcSdUiJ5MBXB3YEaJIUVmZIhZcaUXi
         +dyPotJLC/pX73pgYtSvHDk5q5cPIQPs+LdBItfM1Q5poVPus27cPEeI8fMmUahX8HfC
         66y9BxiiBvuCyoX4cbYzoUYGHDrC/gDNmCtVLO+5m0HjiQdKG9YaJrLV2ZGDh6uao+LA
         VseCoBmv0sP4otsDQ6HjbZmbIQo8wWU488uPIPcNUmPYSe8dcD8iz9HxZ0eyORHskP5j
         CJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308365; x=1706913165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvqwarObUMhsnRd5Sm84iSEstGk+2La44YqED30Zd/E=;
        b=lOx7HzKeBGcAXBWk3SsJcrz7fOsdbc0zvr4VEAGETn1CvSbeen5+5iLBnaKHvLCeDY
         XFZJ8MDvDrguWLpuxOOeSK1G5xdfh/rR8VoyATWkBNjhPcaoi8ROwjNMn6i/D95BX4Oz
         5uoz+RnUxs4SGTrDH/23w+rYgKK+CbvKe4icKImh+9kzvX4G+pghjril/g4Ew2EmN1gI
         GFpsgbqsdZM/XNCTrrXyvrXK+yHfijwWze+MlfpupQAA6BwggNipWwTfesNTdlfMxDvX
         9bwxvC6Lc72VC6fMzYayH8Af7XJWqr1tcr/hmlMdZS8aVJbbB7dMsq8namfUUscFJhDP
         smCQ==
X-Gm-Message-State: AOJu0Ywpy50HXM7jeQYK2/aIAeUF6X1WqQvk5AVt6UAi5/f5yV4FIWWk
	pxa50XCyWBbcTF/IFzKm8LWAMR3vgugP/Hh9DkuIyM0aZG4+WI7gd8/xYxpHYvc=
X-Google-Smtp-Source: AGHT+IFlIE6if6g2GLm5tw9ukXugS4BZazLCF7htiTG5M0wZvp3eSX9ywUYv/cS0vDZdekyq9yIyxQ==
X-Received: by 2002:a05:6a00:6807:b0:6db:a1f9:a7b0 with SMTP id hq7-20020a056a00680700b006dba1f9a7b0mr481480pfb.21.1706308365453;
        Fri, 26 Jan 2024 14:32:45 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b006ddb1286b74sm1583794pfa.105.2024.01.26.14.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:32:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rTUkc-00FjEm-15;
	Sat, 27 Jan 2024 09:32:42 +1100
Date: Sat, 27 Jan 2024 09:32:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbQzChVQ+y+nfLQ2@dread.disaster.area>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
 <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
 <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>
 <ZbMe4CbbONCzfP7p@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbMe4CbbONCzfP7p@casper.infradead.org>

On Fri, Jan 26, 2024 at 02:54:24AM +0000, Matthew Wilcox wrote:
> On Fri, Jan 26, 2024 at 12:22:32PM +1100, Dave Chinner wrote:
> > On Thu, Jan 25, 2024 at 07:19:45PM +0900, Namjae Jeon wrote:
> > > We need to consider the case that mmap against files with different
> > > valid size and size created from Windows. So it needed to zero out in mmap.
> > 
> > That's a different case - that's a "read from a hole" case, not a
> > "extending truncate" case. i.e. the range from 'valid size' to EOF
> > is a range where no data has been written and so contains zeros.
> > It is equivalent to either a hole in the file (no backing store) or
> > an unwritten range (backing store instantiated but marked as
> > containing no valid data).
> > 
> > When we consider this range as "reading from a hole/unwritten
> > range", it should become obvious the correct way to handle this case
> > is the same as every other filesystem that supports holes and/or
> > unwritten extents: the page cache page gets zeroed in the
> > readahead/readpage paths when it maps to a hole/unwritten range in
> > the file.
> > 
> > There's no special locking needed if it is done this way, and
> > there's no need for special hooks anywhere to zero data beyond valid
> > size because it is already guaranteed to be zeroed in memory if the
> > range is cached in the page cache.....
> 
> but the problem is that Microsoft half-arsed their support for holes.
> See my other mail in this thread.

Why does that matter?  It's exactly the same problem with any other
filesytsem that doesn't support sparse files.

All I said is that IO operations beyond the "valid size" should
be treated like a operating in a hole - I pass no judgement on the
filesystem design, implementation or level of sparse file support
it has. ALl it needs to do is treat the "not valid" size range as if
it was a hole or unwritten, regardless of whether the file is sparse
or not....

> truncate the file up to 4TB
> write a byte at offset 3TB
> 
> ... now we have to stream 3TB of zeroes through the page cache so that
> we can write the byte at 3TB.

This behaviour cannot be avoided on filesystems without sparse file
support - the hit of writing zeroes has to be taken somewhere. We
can handle this in truncate(), the write() path or in ->page_mkwrite
*if* the zeroing condition is hit.  There's no need to do it at
mmap() time if that range of the file is not actually written to by
the application...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

