Return-Path: <linux-fsdevel+bounces-24631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F66941F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D8FB265C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411D18A6CB;
	Tue, 30 Jul 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ubl+phUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4433999
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363052; cv=none; b=nQNhwKgffJlkJq6b1qjhp/EFA6KWCLAu88VvqvKuz+ydhvpShdrbpAQfeH60cQKekI3SMhXO8MSAw1DwEI/elzITkO7mgepKOKdOwy3LRaqdqRRmpJ9aEx5Syw44KexwebYNkqV+AeBzsE+25NJWTkItUVgC8EGvCYGbEsszvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363052; c=relaxed/simple;
	bh=R7HXHeARkJZLu1n9m6i+aQ6t8cK+7+QDbMplqYysbAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCp+dcAamW7vOcEWCr3NEv88o1KDio6UGfB4hbXKM8KTyRY+5rgEDlHefiuc8wtHfHo5B/XzhSi6njWTApYuXwlxqGUbcavs+FrVa5ryrQnSJIU88CX8rTpyQUJq0EfwvbXqoG4AfOfe57TYljlt0qWib0P+b2AeG7Zg3Ap0EUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ubl+phUT; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b9d344d66so1134665276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722363050; x=1722967850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9o6cSJgeVzVBGxM1Ep/S7jNPZRAqryfn4LilieWElU=;
        b=ubl+phUTkqxDRDG+acNUCQAcV6sJBPCBHcxQ8TU8xxIAyX0jP6aqB+jay3E0qi0hH2
         PQnqoy1S94iszIe1ePZnlXtb72LltJYqJdiwJxP4mFWM9Hyzbwh0FBX7AxECLEiHGkkw
         YZZa6Bk77wgHiZ7us3LKudKfOt6kX79Jn5L7j2secPPkuDkzplNxsIOvKyUsHzCLpTeS
         YAgHGwaveIrUFQiz6Gkrv1k9UkurL7NQLGVRu2KGcLbo92zISjyuwH3AEgI/QW3Z+6Qc
         7scjGDa/akYpnXl9stgu6JwHz2HwZycIAz2t5J54ZOEEeC5d07AwvqOrGc1U0dx8o3SN
         Mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363050; x=1722967850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9o6cSJgeVzVBGxM1Ep/S7jNPZRAqryfn4LilieWElU=;
        b=Oq1h0jxuEgepwZwIv5FqtUewfk4EFVD2I45451Ep1+PzFbkdRCMcn7eUGYlJFBVHPu
         KDhDPhKdJESymr94CNUFm/aJfDmOywIlinm8o8gqLXkWBQDbgCfcKP7ARqrAAq1ZpCZN
         5Ik1uGq5mikPuLmpeyLb9LxUoch6k6YZd29UWEWAtWqGxXl0DsAZw7WtiK5/di2wWUW7
         OTCkAl+lE5kD0u9RqgPs7aoJfgCZaNd1AaSb7pNfJuhmKYGtWW+CkQ4jtyG+v/jHW2eE
         fYtHcppZSJb3f8INNhwyd45tFGa3MHbdt0St3QZOdrfm21A8TFLLS/i84ZZWGcpKxyfA
         cGjw==
X-Gm-Message-State: AOJu0YySjvsaP3Sa+/JFyZ/dC0zRPQgi3Cx8uAIhG+/pxHDS/4+0OG3r
	aoIwiAzKmReBeHfVWCPZpAckty4lONEy5EGvhRnNfm2kS7WxiPGajST85aIIrRQ=
X-Google-Smtp-Source: AGHT+IEx4/sGYwAMI+nHnuuApvqajMO1imet2/q8q3OGHUddKLLYmpc8scv0mlcTiyAXwWo71neSOQ==
X-Received: by 2002:a05:6902:1449:b0:e03:4253:2d77 with SMTP id 3f1490d57ef6-e0b5428956emr14347947276.0.1722363049892;
        Tue, 30 Jul 2024 11:10:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1af98sm2397566276.9.2024.07.30.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:10:49 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:10:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org,
	brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 03/39] struct fd: representation change
Message-ID: <20240730181048.GA3830393@perftesting>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-3-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-3-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:49AM -0400, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	The absolute majority of instances comes from fdget() and its
> relatives; the underlying primitives actually return a struct file
> reference and a couple of flags encoded into an unsigned long - the lower
> two bits of file address are always zero, so we can stash the flags
> into those.  On the way out we use __to_fd() to unpack that unsigned
> long into struct fd.
> 
> 	Let's use that representation for struct fd itself - make it
> a structure with a single unsigned long member (.word), with the value
> equal either to (unsigned long)p | flags, p being an address of some
> struct file instance, or to 0 for an empty fd.
> 
> 	Note that we never used a struct fd instance with NULL ->file
> and non-zero ->flags; the emptiness had been checked as (!f.file) and
> we expected e.g. fdput(empty) to be a no-op.  With new representation
> we can use (!f.word) for emptiness check; that is enough for compiler
> to figure out that (f.word & FDPUT_FPUT) will be false and that fdput(f)
> will be a no-op in such case.
> 
> 	For now the new predicate (fd_empty(f)) has no users; all the
> existing checks have form (!fd_file(f)).  We will convert to fd_empty()
> use later; here we only define it (and tell the compiler that it's
> unlikely to return true).
> 
> 	This commit only deals with representation change; there will
> be followups.

I'm still trawling through all of this code and trying to grok it, but one thing
I kept wondering was wtf would we do this ->word trick in the first place?  It
seemed needlessly complicated and I don't love having structs with inprecise
members.

But then buried deep in your cover letter you have this

"""
It's not that hard to deal with - the real primitives behind fdget()
et.al. are returning an unsigned long value, unpacked by (inlined)
__to_fd() into the current struct file * + int.  Linus suggested that
keeping that unsigned long around with the extractions done by inlined
accessors should generate a sane code and that turns out to be the case.
Turning struct fd into a struct-wrapped unsinged long, with
	fd_empty(f) => unlikely(f.word == 0)
	fd_file(f) => (struct file *)(f.word & ~3)
	fdput(f) => if (f.word & 1) fput(fd_file(f))
ends up with compiler doing the right thing.  The cost is the patch
footprint, of course - we need to switch f.file to fd_file(f) all over
the tree, and it's not doable with simple search and replace; there are
false positives, etc.  Might become a PITA at merge time; however,
actual update of that from 6.10-rc1 to 6.11-rc1 had brought surprisingly
few conflicts.
"""

Which makes a whole lot of sense.  The member name doesn't matter much since
we're now using helpers everywhere, but for an idiot like me having something
like this

struct fd {
	unsigned long __file_ptr;
};

would make it so that you don't have random people deciding they can access
fd->file, and it helps make it more clear what exactly the point of this thing
is.

That being said I think renaming it really isn't the important part, I think
including something like the bit you wrote above in the commit message would
help when somebody is trying to figure out why this more obtuse strategy is used
rather than just having struct file *__file with the low bit masking stuff
tacked on the side.

I'm still working through all the patches, but in general the doc made sense,
and the patches thusfar are easy enough to follow.  Thanks,

Josef

