Return-Path: <linux-fsdevel+bounces-8816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4983B38A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA41C2243A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5B1350F2;
	Wed, 24 Jan 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VuZsngvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725A131E54
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130331; cv=none; b=hEHuH/PXd5pztK3kTW8O9ir1/aYxvPNOKVeU8xbHDpDj7gJYYJBlb5UdUwAu6Z3FoUc4nbA5RcC9+Zb5JXSEUTdDEqIapBa7qiQ8qFXGrKjypGg+1etq6PeWyMxjqRtb+al1tpvntpz4jIr4Hb6HOBMrFtuXPctrqhPz3WOYGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130331; c=relaxed/simple;
	bh=CqHDkE6+XVoWSD911Ft2n1rMVst9VMZ5FQItmdMVtS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLHZkTISr1Ldr9OYi72R5KR8rMOY/IWrCe7e844ufmqmuRYuu4bwH7xOzEwVUuclfasd4s1k5usdLtt1U9Ur41YytH9zPxZ5/jYO5uzsCHMVBNtAU307sFOr9xGZF/pCqqnnq7Fb9Td6pSyaCMZ7IeqKpDWCS6chuHjWnXZa73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=VuZsngvs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddc162d8d5so533189b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706130329; x=1706735129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptJlTVl647MMtTLol47CvCItY0BIqU2yVeAWOYXYthk=;
        b=VuZsngvsFuno2ppday51GI1scIYutLz+lWADbuk7UZL+cUBOMSQ+lfH80TTpGgZjhG
         nifq3fHpDb+vlpqDtSD9ssFb2J7ixhInin3PskNQ5pV4CFK6YjmhoVYgYd2QlHEJXJFR
         9jN7QA45SWbYERu0YpFKdzgJehP/iJzTACsXW9pRjpsahgTNfKx2yKG4mzXaCBYv9s96
         puaQ1AVGo0fmf3XFo+WFDsHR5/2j2+DM9R/UeXTkO9cKLTh6YDRaIOekExct58EwUSOf
         ieMS+0AiWozXmkizHsg3k2/bqTaJceJRKa0MZxtgCmCNIUdlXYjqfm6QBinr1KTAPIyC
         mBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130329; x=1706735129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptJlTVl647MMtTLol47CvCItY0BIqU2yVeAWOYXYthk=;
        b=mqJNi1cfnMPNziYZfZowDUMd6yREHv4kmNG062auztPh36CzBFKtsmOyhLfR9jhL6c
         Mv5+I1M1fk8fx0pHGN9Blnrq8fIIKWjo2ydFvyv7BPZnDUOeMCuW1cxDhFAmpSzaaTsz
         KKCtVHY5HQvuWcz2TrcfX8nmK29VM7duOhMlt+oKclv7lOOaxl5Rr8WniVl8ad+sPSm1
         a6QjHDhTi5JuOmMVeHNL3dQbz0FtmkEpf1Qijij+EXdcBB/YCMCrjrvwza/k4/YxrzEl
         tSf1CFFLd+IASPP28gteVuhW2yanNh6VefLH+xdWfQ2Ik9IgLDmUgQcvnS6X3mJBZ9iT
         3Rnw==
X-Gm-Message-State: AOJu0YypGbwVTJpqXAmCQKk0AkuHbcUc5cANkFESU905PjyT5dXz0v1t
	MhJIKSZbNGgGOLmp8e/aUzxiNm3UoOR4sMQh7cSv5/6B8ZsUz1j8JXX/n8K8fDc=
X-Google-Smtp-Source: AGHT+IFL6Lcx2hfEUvb5yhEl8FR5RXwsrvV8h0iI+rebut3qAbCs5xPiJwUofv4hn/6gZhkDiXzqEA==
X-Received: by 2002:a62:5e45:0:b0:6dd:c0a3:d6c8 with SMTP id s66-20020a625e45000000b006ddc0a3d6c8mr108176pfb.17.1706130329047;
        Wed, 24 Jan 2024 13:05:29 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id n1-20020a056a000d4100b006ddc7af02c1sm57764pfv.9.2024.01.24.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:05:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rSkR3-00Eoh6-15;
	Thu, 25 Jan 2024 08:05:25 +1100
Date: Thu, 25 Jan 2024 08:05:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZbF7lfiH4QAg3X8T@dread.disaster.area>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZbCap4F41vKC1PcE@casper.infradead.org>
 <ZbCetzTxkq8o7O52@casper.infradead.org>
 <CANeycqpk14H34NYiF5z-+Oi7G9JV00vVeqvyGYjaZunXAbqEWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqpk14H34NYiF5z-+Oi7G9JV00vVeqvyGYjaZunXAbqEWg@mail.gmail.com>

On Wed, Jan 24, 2024 at 03:26:03PM -0300, Wedson Almeida Filho wrote:
> On Wed, 24 Jan 2024 at 02:23, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 24, 2024 at 05:05:43AM +0000, Matthew Wilcox wrote:
> > > On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > > > +config TARFS_FS
> > > > +   tristate "TAR file system support"
> > > > +   depends on RUST && BLOCK
> > > > +   select BUFFER_HEAD
> > >
> > > I didn't spot anywhere in this that actually uses buffer_heads.  Why
> > > did you add this select?
> >
> > Oh, never mind.  I found bread().
> >
> > I'm not thrilled that you're adding buffer_head wrappers.  We're trying
> > to move away from buffer_heads.  Any chance you could use the page cache
> > directly to read your superblock?
> 
> I used it because I saw it in ext4 and assumed that it was the
> recommended way of doing it. I'm fine to remove it.
> 
> So what is the recommended way? Which file systems are using it (so I
> can do something similar)?

e.g. btrfs_read_dev_one_super(). Essentially, if your superblock is
at block zero in the block device:

	struct address_space *mapping = bdev->bd_inode->i_mapping;

	......

	page = read_cache_page_gfp(mapping, 0, GFP_NOFS);
        if (IS_ERR(page))
                return ERR_CAST(page);

        super = page_address(page);

And now you have a pointer to your in memory buffer containing the
on-disk superblock. If the sueprblock is not at block zero, then
replace the '0' passed to read_cache_page_gfp() with whatever page
cache index the superblock can be found at....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

