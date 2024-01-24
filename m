Return-Path: <linux-fsdevel+bounces-8671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE883A05E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB928B7AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 04:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E88BE59;
	Wed, 24 Jan 2024 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+nx1Nab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A633E1;
	Wed, 24 Jan 2024 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069651; cv=none; b=KO5bBj3XThVX51WKYMoq10Z7ku/IsUSQgxxCqck9ntItZIHrX8PrKkW4lfXouFczJ92z56QFMrT3cChljY1y/z7c2CVDdDXsHw5oijA5hBt9RYpd/PJNo1hDxEB02YWbUs9vEsmjBr2W5GNhrJNd6amesuqAZsfJV1Bg9kcr1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069651; c=relaxed/simple;
	bh=QoR/oBY9TJPsZLOUNKl0k23X7kL36kihIlWDQFL+80U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxg92R+gx/NINZozt5/fD18EzOtJibp84ZresxGoxrUzm/I02fLOswEJXQ3KbPrUwVwPtf96lAVoyw4rCUHCNmftxggk313BYE1NJHumVpgVdC+W07HcptxM0zzY8XXNujS6+EP4TjwqO8HzOdZ0Y/4zrT5+80KorSMXe33rTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+nx1Nab; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2522347a12.2;
        Tue, 23 Jan 2024 20:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706069649; x=1706674449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q975eJqoIsjd0MeOPum3Loz5ekoepPOq8sMoBw2H72I=;
        b=Y+nx1NabQ936Ef5nAZv0NZEA2eMN69TURDPkTpPdb8j/xIu/kHF3XzuGITRbcznfhk
         s0by3Ms8CeVF6xzxJojj36yFdmEgCwHYrmE7Pnj9UxmdYGgpAQbNejNvuAsbh1XgAMuj
         F+oOuMb6Nhs8mqsPU8S5whnyVky63IoALS0TJ0PmEV5TxdWixREsNlPPogSSk5kT5icu
         y0QzxCQLCRH/b4F3Rk+lp5eymhx8zcI77TzTvuN0Nzy1nx7ifXJnahB+spvwyASXUky/
         Dn9VnYO8emdFXgZlO9v30tRv7yJQP5P6ItaYwyF9InJgbeQ0oWqaAedLEuTdxr6YfyZp
         eu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706069649; x=1706674449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q975eJqoIsjd0MeOPum3Loz5ekoepPOq8sMoBw2H72I=;
        b=i4UkvTmDpYuSSZsOkxPdxk1SPXnxYQjqXCLFulQ0hSkieMSN7eXzFgt8etWD3mlS7y
         jR92QBCv0sM5gpLaCsEDx2ueMRDXXYKuz6hrXZK3ZPDn3Cjn8qfsJeozH19XYzlO1xXO
         1FxI7+h6uR4JiDDNssEpyfudgR3y5WX2WZ5VdEMx4f5j+5eUvv4xcidF2RujFay9OlKq
         +8g4/fgnqaJ9wnY+dOJ0D8ufGqph+zYBlDFLElgz9ueytJVeRGzmZ+dnltav5NSvK0Gh
         Zuo2AK9wrcJKcPhYsY8eImI2rTqjhmvvRoNYeNqYj4x2mEaWwJacxZBNBOy4FbtCPws2
         j5lA==
X-Gm-Message-State: AOJu0YwGcK+i9XwqbqOh6qYpJqOZUK1eZTizF+vPYHJHK+gJ1CncOagw
	6GPuIVuacue5gzprbiJIYquAk0tyIkm47uUedU0Pw4dcfvE0ZcFJ6bSqALO7
X-Google-Smtp-Source: AGHT+IG30D8wIWKEwrCgXuypYR0PoQogBUaiS916DJjCrGOghrbNtqVrurvuyxX8iWc7HpXACwv59w==
X-Received: by 2002:a17:90b:244:b0:290:43f:62af with SMTP id fz4-20020a17090b024400b00290043f62afmr3683976pjb.1.1706069649408;
        Tue, 23 Jan 2024 20:14:09 -0800 (PST)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id sy14-20020a17090b2d0e00b0028c89122f8asm12592152pjb.6.2024.01.23.20.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 20:14:08 -0800 (PST)
Date: Wed, 24 Jan 2024 01:14:01 -0300
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 16/19] rust: fs: allow file systems backed by a block
 device
Message-ID: <ZbCOiSLZm0nXKLyB@wedsonaf-dev>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-17-wedsonaf@gmail.com>
 <gb4CNFpmDdn45YQDB8da-G8kJfYH4OT_dDpY1WpRzF5xui6NuiiZJQR0pxRHI0ECrrzQvrpHFEhEYcKXRDT2Tj44-0FU9avzwON2VPPo2pA=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gb4CNFpmDdn45YQDB8da-G8kJfYH4OT_dDpY1WpRzF5xui6NuiiZJQR0pxRHI0ECrrzQvrpHFEhEYcKXRDT2Tj44-0FU9avzwON2VPPo2pA=@proton.me>

On Sat, Oct 21, 2023 at 01:39:20PM +0000, Benno Lossin wrote:
> On 18.10.23 14:25, Wedson Almeida Filho wrote:
> > +    /// Reads a block from the block device.
> > +    #[cfg(CONFIG_BUFFER_HEAD)]
> > +    pub fn bread(&self, block: u64) -> Result<ARef<buffer::Head>> {
> > +        // Fail requests for non-blockdev file systems. This is a compile-time check.
> > +        match T::SUPER_TYPE {
> > +            Super::BlockDev => {}
> > +            _ => return Err(EIO),
> > +        }
> 
> Would it make sense to use `build_error` instead of returning an error
> here?

Yes, I changed these to `build_errors` in v2.

> Also, do you think that separating this into a trait, `BlockDevFS` would
> make sense?

We actually have several types; we happen to only support two cases now, but will add more over time.

> > +
> > +        // SAFETY: This function is only valid after the `NeedsInit` typestate, so the block size
> > +        // is known and the superblock can be used to read blocks.
> 
> Stale SAFETY comment, there are not typestates in this patch?

Fixed in v2.

> 
> > +        let ptr =
> > +            ptr::NonNull::new(unsafe { bindings::sb_bread(self.0.get(), block) }).ok_or(EIO)?;
> > +        // SAFETY: `sb_bread` returns a referenced buffer head. Ownership of the increment is
> > +        // passed to the `ARef` instance.
> > +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> > +    }
> > +
> > +    /// Reads `size` bytes starting from `offset` bytes.
> > +    ///
> > +    /// Returns an iterator that returns slices based on blocks.
> > +    #[cfg(CONFIG_BUFFER_HEAD)]
> > +    pub fn read(
> > +        &self,
> > +        offset: u64,
> > +        size: u64,
> > +    ) -> Result<impl Iterator<Item = Result<buffer::View>> + '_> {
> > +        struct BlockIter<'a, T: FileSystem + ?Sized> {
> > +            sb: &'a SuperBlock<T>,
> > +            next_offset: u64,
> > +            end: u64,
> > +        }
> > +        impl<'a, T: FileSystem + ?Sized> Iterator for BlockIter<'a, T> {
> > +            type Item = Result<buffer::View>;
> > +
> > +            fn next(&mut self) -> Option<Self::Item> {
> > +                if self.next_offset >= self.end {
> > +                    return None;
> > +                }
> > +
> > +                // SAFETY: The superblock is valid and has had its block size initialised.
> > +                let block_size = unsafe { (*self.sb.0.get()).s_blocksize };
> > +                let bh = match self.sb.bread(self.next_offset / block_size) {
> > +                    Ok(bh) => bh,
> > +                    Err(e) => return Some(Err(e)),
> > +                };
> > +                let boffset = self.next_offset & (block_size - 1);
> > +                let bsize = core::cmp::min(self.end - self.next_offset, block_size - boffset);
> > +                self.next_offset += bsize;
> > +                Some(Ok(buffer::View::new(bh, boffset as usize, bsize as usize)))
> > +            }
> > +        }
> > +        Ok(BlockIter {
> > +            sb: self,
> > +            next_offset: offset,
> > +            end: offset.checked_add(size).ok_or(ERANGE)?,
> > +        })
> > +    }
> >   }
> > 
> >   /// Required superblock parameters.
> > @@ -511,6 +591,70 @@ pub struct SuperParams<T: ForeignOwnable + Send + Sync> {
> >   #[repr(transparent)]
> >   pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block, PhantomData<T>);
> > 
> > +impl<T: FileSystem + ?Sized> NewSuperBlock<T> {
> > +    /// Reads sectors.
> > +    ///
> > +    /// `count` must be such that the total size doesn't exceed a page.
> > +    pub fn sread(&self, sector: u64, count: usize, folio: &mut UniqueFolio) -> Result {
> > +        // Fail requests for non-blockdev file systems. This is a compile-time check.
> > +        match T::SUPER_TYPE {
> > +            // The superblock is valid and given that it's a blockdev superblock it must have a
> > +            // valid `s_bdev`.
> > +            Super::BlockDev => {}
> > +            _ => return Err(EIO),
> > +        }
> > +
> > +        crate::build_assert!(count * (bindings::SECTOR_SIZE as usize) <= bindings::PAGE_SIZE);
> 
> Maybe add an error message that explains why this is not ok?
> 
> > +
> > +        // Read the sectors.
> > +        let mut bio = bindings::bio::default();
> > +        let bvec = Opaque::<bindings::bio_vec>::uninit();
> > +
> > +        // SAFETY: `bio` and `bvec` are allocated on the stack, they're both valid.
> > +        unsafe {
> > +            bindings::bio_init(
> > +                &mut bio,
> > +                self.0.s_bdev,
> > +                bvec.get(),
> > +                1,
> > +                bindings::req_op_REQ_OP_READ,
> > +            )
> > +        };
> > +
> > +        // SAFETY: `bio` was just initialised with `bio_init` above, so it's safe to call
> > +        // `bio_uninit` on the way out.
> > +        let mut bio =
> > +            ScopeGuard::new_with_data(bio, |mut b| unsafe { bindings::bio_uninit(&mut b) });
> > +
> > +        // SAFETY: We have one free `bvec` (initialsied above). We also know that size won't exceed
> > +        // a page size (build_assert above).
> 
> I think you should move the `build_assert` above this line.

Sure, moved in v2.

Thanks,
-Wedson

