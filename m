Return-Path: <linux-fsdevel+bounces-24523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268F9401D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 01:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A335F1F222F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06218E778;
	Mon, 29 Jul 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CdEevN4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C341E49E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722297222; cv=none; b=UBRr101Ra2VeztMD/6BczIs45YGhsyDiR6HC11yh4QIiG33TB84ZJeAsN+VuxwA+lGvL09Ya1TJg05xJi5OraUgfAkLsm6LPBPlhQxJ1cA/lwZ5zraDpNE7nTRqSmYFCxdWW4QwBBjEF5AG8lzTr35YNEOFQA5YNr0xJ8rbYA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722297222; c=relaxed/simple;
	bh=FO64CXJBpdeHyI1u1nksCrN1W+9YELNs5AXbIuBBmZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKEUXTfqZ+3ImPMYnYiXPpOgKGiuyzK6/NddDaS0EX2vU3mRq7dLBsY3Ob0JzhiDnD3x7BCwCvUTwWCWhxc325ADKSAdTtx8+6NAkQqSgyfhEKahy+x8KVX6n+8emzmFackJ7tW7sJ/DncY5vLaHxualHgDe5h8sHt06wr78Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CdEevN4A; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a115c427f1so2333718a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722297220; x=1722902020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2vl+7JYwNVlWTCB6l5f96cXYrIgTKXnqm7r+XEcrTBc=;
        b=CdEevN4AiPeycGWQKGukjfmFRys9cG2wy3eItDb0Vx74zhHk461xhHfXoKh3SG81vJ
         yonkHxpqaRS+rPk4fNETcEPRmWpYaDsDKdHDjI1ezFxTOb+J1lA3kV27uTRPHrj7s/K2
         VdW2tD6zdEvYbBWMsqJswgI9AO/zxDC1vZqB2mmJ4i6ofb1M5g4CtIWPE2bid0ePsiDX
         NLCYGGMwANOOQIvRWeQmlwvMcKYmYmAfPvX8lONrQ6dilBraY9PWqXVWzdpkVtENcBAd
         1eK0c4aGbWNImpJQMmYEe++60/gcvnL2P0keSsTnLg9SGyisbzd5h/YCxLMjJNSQmVCk
         4lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722297220; x=1722902020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vl+7JYwNVlWTCB6l5f96cXYrIgTKXnqm7r+XEcrTBc=;
        b=fNLUKO+pj0sMAGAPwt0oQHmh70Tmt+jB0MrUTCAK8UK9ZPOOK2TmbUXiiJHuu+37Ph
         zsBoMxhHnJBZzPhu7pvfboEuUCfCyM27JqZpP/AD93KETGn9n9YQZ0e9IG6Hz/AdamZX
         +FrljtSExCQefyknCoDJgLuaquN7FKc6YemDRKbZo8tkWToG2E3ZpF0NrwsaZbt6xqC5
         YWaRFlaT6nKwzNcONnU6wROtwXAFb1lwTpKf+/4jXESJdWnmLCD1mM8Rw5jzFL5yGRYt
         v+V4AafYEOliW8uDaKSjg4sATeQghM0G178Z53WJih3YV2Kcn9h4CKQhYubqpoVhb42g
         Ce+g==
X-Forwarded-Encrypted: i=1; AJvYcCVk/QZS93f3AO3QDoDTZBZjq6Z1P0gxzFLjA+pBuG+O9coKkKgn4rTiWeIoYRie+fQp1xoTOoLNkplAqfmzVAJekJPRzDShRp+HahWSFw==
X-Gm-Message-State: AOJu0Yxe6FNmuXeg7QzpkXD+InKqNyozawIUjJ+kGN82PgjRaPELK1Ka
	gfgrcmu2PlGAlGhAR3RaXb0kKQbLaQZNqRloST05IBWR7Swkd6SLJpbJ9S4bWbs=
X-Google-Smtp-Source: AGHT+IFek5E8FBI9EUrMuMEVpgEGokTkSuRHy5EaJwKBGexs4ZTZg6KkP1jirnlQMuGRmlTU5nK3cA==
X-Received: by 2002:a05:6a20:2449:b0:1c4:8293:76d0 with SMTP id adf61e73a8af0-1c4a117f848mr7682880637.4.1722297219693;
        Mon, 29 Jul 2024 16:53:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73efdf2sm11161961a91.29.2024.07.29.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:53:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYaBM-00G6B8-1Y;
	Tue, 30 Jul 2024 09:53:36 +1000
Date: Tue, 30 Jul 2024 09:53:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, libc-alpha@sourceware.org,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <ZqgrgL3hmfcB6PHh@dread.disaster.area>
References: <20240729160951.GA30183@lst.de>
 <87a5i0krml.fsf@oldenburg.str.redhat.com>
 <20240729184430.GA1010@lst.de>
 <877cd4jajz.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cd4jajz.fsf@oldenburg.str.redhat.com>

On Mon, Jul 29, 2024 at 08:52:00PM +0200, Florian Weimer wrote:
> * Christoph Hellwig:
> 
> > On Mon, Jul 29, 2024 at 07:57:54PM +0200, Florian Weimer wrote:
> >> When does the kernel return EOPNOTSUPP these days?
> >
> > In common code whenever the file system does not implement the
> > fallocate file operation, and various file systems can also
> > return it from inside the method if the feature is not actually
> > supported for the particular file system or file it is called on.
> >
> >> Last time I looked at this I concluded that it does not make sense to
> >> push this write loop from glibc to the applications.  That's what would
> >> happen if we had a new version of posix_fallocate that didn't do those
> >> writes.  We also updated the manual:
> >
> > That assumes that the loop is the right thing to do for file systems not
> > supporting fallocate.  That's is generally the wrong thing to do, and
> > spectacularly wrong for file systems that write out of place.
> 
> In this case, the file system could return another error code besides
> EOPNOTSUPP.  There's a difference between “no one bothered to implement
> this” and “this can't be implemented correctly”, and it could be
> reflected in the error code.

Huh. EOPNOTSUPP. is explicitly stated as a valid "not implemented in
kernel or userspace" error return in the man page.

EOPNOTSUPP
      The  filesystem  containing the file referred to by fd does
      not support this operation.  This error code can be returned
      by C libraries that don't perform the emulation shown in
      NOTES, such as musl libc.

Hence libc-independent applications already have to handle
EOPNOTSUPP being returned by posix_fallocate() and implement their
own fallback if they really need it.

Having documented behaviour of "glibc does emulation so badly you
need to work around it" is really not a strong position from which
to advocate that the kernel needs to change behaviour....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

