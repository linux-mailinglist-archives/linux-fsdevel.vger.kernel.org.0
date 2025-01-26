Return-Path: <linux-fsdevel+bounces-40130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CEA1CD45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA61659E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895F15CD4A;
	Sun, 26 Jan 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJnGomj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524411362;
	Sun, 26 Jan 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737910926; cv=none; b=Cqv4FREG3WspEy8n8W7PwQUTh9o3piHKHN5M4Ujyvi7gF79tDT1G1kz3kz2v5ndx5NlhhXFp8G7uc7UWijwFxXMFpT5QKC6qjm08Z7Ra3K+P/LuWImZxlvAAAfZnS4Pa7tPGzFCPFPC199OQsbZfIu+9+WmIj5WRxjfLdEF9xi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737910926; c=relaxed/simple;
	bh=ZfTIEdo/GDcTTUsfu0TwkPTwoBEFIuVClj4wvr4WiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df6JHnRzoSWbf8nf2kGetYBDiuALQG90nmvweM8I56aTeUVnpB+LKAXrSkKxgaiLEXdGuZ7qxTJ4/qLDjvchtTEwEKBpkultq8DgBH5xsUV7kjF1o64vtAk5hRNQCaihkE4NiED6O/QmOgxFnx1wt2g3Pg02lvZz+hN7CoQpkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJnGomj2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aab925654d9so709916866b.2;
        Sun, 26 Jan 2025 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737910922; x=1738515722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7bP1gov9MypcrkYQfyqMdYDtspg+jDQx5E3Kd9vCBQ=;
        b=RJnGomj2pGYmxOV8nqVgtL6JIvjWA8shp/46sitgsdtUBi6DyDYqZWXonzwIpODvtX
         aGDvOzBF3BIhY2Uh0wExXHetfFq4ikavhJzMQWT+V5YFWVAsozLeElA3KC3eH6YE71CJ
         blscgzaGZaHzR1vJzdsMUuriuFZPvaN51nTnd2xsac4GPZaX7WwRHplCPsdtOMHnssAb
         HuaMHxv1sUhtVaJwX43BG+ioRSCZryvPN85HTJKjCC1erOn7cQ9LU0VCUfbMZws2Zmw3
         X8Jfs2Zxr4ugYH3UvVrOycM/uB/06vSKfFCXbBJiI3CCX+WnDOmF+1uDZNwElVN9uMmt
         hdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737910922; x=1738515722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7bP1gov9MypcrkYQfyqMdYDtspg+jDQx5E3Kd9vCBQ=;
        b=PU3QrPM20tBTeB2p4gKvTXh4Ri6lTk0shg2K5Kcn2uKlOMwDTBx+E2C7zLW8VtUWAu
         ffa7Lyy93E+jLMmYGEWgPBwpi7EN6hMC13pR27yJH2QJ6m+T4+8AbemgWwSIyG6IpmGV
         maf0553KLwIRPzYaIbN+sbmxYDkjt02JnJznEP4BS7Dvkgqjbs/dCI9noa/jqs0HsL51
         cBrNivzIZLkPBpeGceN/pr81QYbmAjktW/V8DFIX2oHHgJRFss/FSAckGBNlmHYCBaoo
         jxfMnMcSRxMTL0dk89XZ8STVkDWcsST7aswNDNhPuvB7bvdjJGM8DREwvInIpEiUv6Ot
         4oSg==
X-Forwarded-Encrypted: i=1; AJvYcCVSbDFKzsybRwTpH99mc+INhm6xt2ANIQ0OwD8Z666gp9jXx+jq5iZcmil15JAgKjMPEWmlHcMQ1qXQ0Doz@vger.kernel.org, AJvYcCXBoRgl5owAMsbMqkhb8DiLKJEcvR9Gdz63IN3dyxZP+LaUUapC8R0gFcD0JWaheIGWtRjh3NStmEoSBudZ@vger.kernel.org
X-Gm-Message-State: AOJu0YynhO861B5EmLEtfK4RDIheaKKKQW2BSu6nZ3n1uDvYF4X5rNua
	4xDR/1IWZ1d/uqz8yKdxNtWeqN9PY0OADGZn402/z99lBZ+29w+O
X-Gm-Gg: ASbGncvGELtSpWgpLKUPeK/PMmX6kAa0ZUU34ueOqh191jrGM3PwhPE6IQk8c/bX+Mu
	rHeFO9Do0SWGqNBwSf0dYqca3sl00yGmIBSYRvIGGJIRkiNdMXwqM+yZxyFpzNK/Zepf8KGJp7/
	6TMe4zjM2qQPzzLDQVDl6pNz8wucO7FMbUZYRIiDYlrD53rpank1rRUsyAKn5SGToHF1HcnZ7Ho
	t/1ibJJVke1ruim9zrTKaCH0mPKGx8eBlHquq5tJQWSVBGUAKcpMAbcf2iEaoKNtFulEV4en+EB
	jCEAd9VAD8RB9JlxCQ==
X-Google-Smtp-Source: AGHT+IHYNUV9dO02PoFjUeYuJa4/4oyj+kfBFKuBhgMVAXTilvXUj354QdZTD2+fsztuaLuVAjrZrA==
X-Received: by 2002:a17:907:3f12:b0:aae:83c6:c679 with SMTP id a640c23a62f3a-ab38b3226a2mr3516649766b.32.1737910922285;
        Sun, 26 Jan 2025 09:02:02 -0800 (PST)
Received: from f (cst-prg-86-17.cust.vodafone.cz. [46.135.86.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12d5bsm446087766b.36.2025.01.26.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 09:02:01 -0800 (PST)
Date: Sun, 26 Jan 2025 18:01:55 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
Message-ID: <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
References: <20151007154303.GC24678@thunk.org>
 <1444363269-25956-1-git-send-email-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1444363269-25956-1-git-send-email-tytso@mit.edu>

On Fri, Oct 09, 2015 at 12:01:09AM -0400, Theodore Ts'o wrote:
> If there is a error while copying data from userspace into the page
> cache during a write(2) system call, in data=journal mode, in
> ext4_journalled_write_end() were using page_zero_new_buffers() from
> fs/buffer.c.  Unfortunately, this sets the buffer dirty flag, which is
> no good if journalling is enabled.  This is a long-standing bug that
> goes back for years and years in ext3, but a combination of (a)
> data=journal not being very common, (b) in many case it only results
> in a warning message. and (c) only very rarely causes the kernel hang,
> means that we only really noticed this as a problem when commit
> 998ef75ddb caused this failure to happen frequently enough to cause
> generic/208 to fail when run in data=journal mode.
> 
> The fix is to have our own version of this function that doesn't call
> mark_dirty_buffer(), since we will end up calling
> ext4_handle_dirty_metadata() on the buffer head(s) in questions very
> shortly afterwards in ext4_journalled_write_end().
> 
> Thanks to Dave Hansen and Linus Torvalds for helping to identify the
> root cause of the problem.
> 

Hello there, a blast from the past.

I see this has landed in b90197b655185a11640cce3a0a0bc5d8291b8ad2

I came here from looking at a pwrite vs will-it-scale and noticing that
pre-faulting eats CPU (over 5% on my Sapphire Rapids) due to SMAP trips.

It used to be that pre-faulting was avoided specifically for that
reason, but it got temporarily reverted due to bugs in ext4, to quote
Linus (see 00a3d660cbac05af34cca149cb80fb611e916935):

>    The commit itself does not appear to be buggy per se, but it is exposing
>    a bug in ext4 (and Ted thinks ext3 too, but we solved that by getting
>    rid of it).  It's too late in the release cycle to really worry about
>    this, even if Dave Hansen has a patch that may actually fix the
>    underlying ext4 problem.  We can (and should) revisit this for the next
>    release.

Given your patch landing I take it this is expected to be fixed now?

Sounds like nobody bothered to revert the revert. Not the end of the
world, but it is few % left on the table for (hopefully) no reason. ofc
testing will be needed, but that's what -next is for

thanks,

