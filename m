Return-Path: <linux-fsdevel+bounces-8672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F983A066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96983282A10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2E0BE5A;
	Wed, 24 Jan 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGUA0G3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DF33E1;
	Wed, 24 Jan 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070305; cv=none; b=DbQtHLJor5huo6/TIYGHF1Ryddhs93R/Q2YELop1N1XnqwsHkT9YzoFJvggS10wvMwRWe0wSyqMfIF/zLf3nwVqG60WmqOAnRizAjtYHtrXEEr6BDBVzgS6W7wQDGt0bQcccculb/1EBNFy1FFZvPSMOpWl2PumpKHnaoo0FxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070305; c=relaxed/simple;
	bh=QCMVoCLxA/Lm8qZPAhSY8piZFum0pyXozn/NuiB6Ahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg3Ci1Z5Ce6mYBJBlKxGKkniJGea97qSjaUnLEg/oxjr5LYPCAF8CWrY330+WCy/G/uR9JDyWrtAnwxGVlGX9VBX+iB6pkS6Ir/GYFib/SD5cQP0PFVqJ6JtrBmdOQz+oe9c8Q7WrufnOWlwPhtoXKvZGxnqIECPmKDA5JIe9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGUA0G3A; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dddb927d02so2934006a34.2;
        Tue, 23 Jan 2024 20:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706070303; x=1706675103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TktUQ1WDjUNF+7IXvODpyK86wTDQZDZ7vIWXwY2sPM=;
        b=XGUA0G3AI5CHdvzZaTlDlVc3LVT9EENyBMsO+LW979F/lrALE+UuVkxuiUZz7sL2hR
         55W61JHXcZPAljlS+dXz+xcP5rBswtzz99p1tHx0O9p3UoTrOjqN4/nmVsITFnRGwLyN
         yFt6qlvJKCHGdzn52QYKmwXghimMBPf871Wei8UBoLrTsMyVfhKPnjJ+wYaF3dBL3Cxp
         25r7PA/pWbgwIut2TTR5ZaYNUVbYQpBEEvjNGmCJ0fQZbIPoJ5l9cOBhQypCH4mlWUGO
         rO5j0Y08S7h6a6VTTfFN1EouUxzQguHjwnHJ2nUPSo0bLGioBt1PLLAPlIC7Hw5+RB9H
         plaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070303; x=1706675103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TktUQ1WDjUNF+7IXvODpyK86wTDQZDZ7vIWXwY2sPM=;
        b=UhhRZpOxkuUkfbnCpXghFbdlRy8Juh0QHTBmoNkavFFiMWXImDe48GafqWPkEcEwvo
         pC1mVuIa2NWpML37wPKw/tXm5z5TAo6M4gyEFng9CvMbrVJA+nBblNZtmJxe1O2GEvuS
         FkUQ+f/6OqCJN1WNLibp/Nl3+FPzWRYLQw9wyKYFVgfYFeLWqqHiVxujhjmE5Ie7Ak6Y
         /5qVuHLVjFW0/LA6iLNPU4vus90ve9kCe6OIjCs5/20ktRAOs0Hx3+BYAFxpKpppuuCl
         N84jPhyC9YNDA9hLfj6ZRp5yhAFfSFsc/+pfL3V7xjxUORIp4Kj6ulWPEBgPol+boMJ7
         rEUw==
X-Gm-Message-State: AOJu0YwT02AvCRjbYNn3fV3BOspNriXvSlZjyhHA4L5kJDIl051Az3N+
	IAo3t5J+Rt/CSmRNDKD1XL7Rr+RW2w09FTbFfvdbTQy0M9yybr8k
X-Google-Smtp-Source: AGHT+IG9rdSUPCH6Da9JmzsEs/So9DA5hMY8Iovq2hfk95duzIUf6cbQ5fAIHzAPEwqPV0A4P7th6w==
X-Received: by 2002:a9d:6c57:0:b0:6dd:dd9f:39a7 with SMTP id g23-20020a9d6c57000000b006dddd9f39a7mr1167076otq.39.1706070302963;
        Tue, 23 Jan 2024 20:25:02 -0800 (PST)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b006dd7b08b336sm2305833pfr.20.2024.01.23.20.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 20:25:02 -0800 (PST)
Date: Wed, 24 Jan 2024 01:24:55 -0300
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 12/19] rust: fs: introduce `FileSystem::statfs`
Message-ID: <ZbCRF/OkpqESeQpC@wedsonaf-dev>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-13-wedsonaf@gmail.com>
 <20240104053315.GE3964019@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104053315.GE3964019@frogsfrogsfrogs>

On Wed, Jan 03, 2024 at 09:33:15PM -0800, Darrick J. Wong wrote:
> On Wed, Oct 18, 2023 at 09:25:11AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > +/// File system stats.
> > +///
> > +/// A subset of C's `kstatfs`.
> > +pub struct Stat {
> > +    /// Magic number of the file system.
> > +    pub magic: u32,
> > +
> > +    /// The maximum length of a file name.
> > +    pub namelen: i64,
> 
> Yikes, I hope I never see an 8EB filename.  The C side doesn't handle
> names longer than 255 bytes.

kstatfs::f_namelen is defined as a long in C.

> 
> > +
> > +    /// Block size.
> > +    pub bsize: i64,
> 
> Or an 8EB block size.  SMR notwithstanding, I think this could be u32.
> 
> Why are these values signed?  Nobody has a -1k block filesystem.

I agree, but they're signed in C, I'm just mimicking that. See kstatfs::f_bsize
for this particular case, it's also a long.

> 
> > +    /// Number of files in the file system.
> > +    pub files: u64,
> > +
> > +    /// Number of blocks in the file system.
> > +    pub blocks: u64,
> >  }
> >  
> > +    unsafe extern "C" fn statfs_callback(
> > +        dentry: *mut bindings::dentry,
> > +        buf: *mut bindings::kstatfs,
> > +    ) -> core::ffi::c_int {
> > +        from_result(|| {
> > +            // SAFETY: The C API guarantees that `dentry` is valid for read. `d_sb` is
> > +            // immutable, so it's safe to read it. The superblock is guaranteed to be valid dor
> > +            // the duration of the call.
> > +            let sb = unsafe { &*(*dentry).d_sb.cast::<SuperBlock<T>>() };
> > +            let s = T::statfs(sb)?;
> > +
> > +            // SAFETY: The C API guarantees that `buf` is valid for read and write.
> > +            let buf = unsafe { &mut *buf };
> > +            buf.f_type = s.magic.into();
> > +            buf.f_namelen = s.namelen;
> > +            buf.f_bsize = s.bsize;
> > +            buf.f_files = s.files;
> > +            buf.f_blocks = s.blocks;
> > +            buf.f_bfree = 0;
> > +            buf.f_bavail = 0;
> > +            buf.f_ffree = 0;
> 
> Why is it necessary to fill out the C structure with zeroes?
> statfs_by_dentry zeroes the buffer contents before calling ->statfs.

I didn't know they were zeroed before calling statfs. Removed this from v2.

Thanks,
-Wedson

