Return-Path: <linux-fsdevel+bounces-21472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AD904654
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156F71F236E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C6154C08;
	Tue, 11 Jun 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hLoIQ1Z0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101A150991
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142213; cv=none; b=ns6+k0Ex9JPB9+dXVrPYlyooouW5XXAwDCAXFAm4ICnQDbXgenVAwd+ZC7SUxCaGWHghKiZnN4mbwlimFY8aXvKpIauIhoo15z4Wt7PEQI+YahgaegnY15lp2CO9vfvs8eG3PJ9GiAb8wRG+AP9A8T0Or12YulI3rCHX1pCzgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142213; c=relaxed/simple;
	bh=tKNeb6MNeTb6ee8NKd9t3VFI6dIDLg/h2mK+QErnQdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5RTg8NjDLqzdd9RQ35hFPIckicEU3H3dyhqoAbQ/X5PeT1wFXzJbQciE9wU29jOKXA/VMJp06C1Cj0YSVekpyT3YIfS5GU4Gf2Sqh0+st9tF10lEMzcm3ifZJsqT82wCOe52g5gjdOHj+ve6DtiiZZ6rcXDt8BQkGyGLwTz+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hLoIQ1Z0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f65a3abd01so13649255ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718142208; x=1718747008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ztr+9QM8MemVkqb7WSlTcd/bIoHdITmojB66zbPzo7s=;
        b=hLoIQ1Z03IizaxdC0cDUub0rQqvXFdK+55wJyQQtLIFbjsqasIwp4CzEvt6ElT9AeX
         jbmkjm1f2jKQKLVcMxNpyicCWfy8k8NPGTlwQdZEcx1NSUXLVgh9JW5rve1xIS8Hgb7W
         ghKZxWnypSU7CXRePPfSgxF7N85XS/Jss8GzDxy8ST0yEL7rrH3OEkq76IjvWEvos77L
         +yFDozkmPtOAnjlg2DRRYoek+6NvhlvxmJWslO7nVFeltxlJgTFg3trVuWP6r9r6yK0i
         bnVLYNswPsGZ8rGdPpQyiZLinOZZkuAj5gCgE/1e+uEQoBsJpZL9R3mHi0T1gbbNnDQa
         sfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142208; x=1718747008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztr+9QM8MemVkqb7WSlTcd/bIoHdITmojB66zbPzo7s=;
        b=mv8KrJ+IICfNZWLSDfiPMXum6M+78YeL7i+UM+Bto+oD0uwZkC/G/BNvexfOgh33wH
         TH0+jBKtwUSp/l4cH9ogx683meXo+rbnE8hs5A5xTpre7eKVd5yJkaFg3YcwYG+OVMFx
         X2t4T0Lckx4CzMAxv5XvWWFddVrafQOEosyoHawuz/Mn2hcg5jTHUNfLXhHD761iXhvI
         RZ1uyWTUwhIbgWAE2eKUwM29tAjUAkr4Bi1QZYz6sMpwnlO1NyxfwMqKvszG0Ta1ixdw
         IbbdKUL1vPacvpV0CXFKXlg2IBQFjxU6TmAEBX16eX+TgtsPHWthRRQ41aENgRXxnwJb
         0f4w==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZV3tTOMGoHYBBjPpzYMbXe3zYbNnxYeGC2vzYRsOpdVaV3WHToQgSvdN5iPx8PB63blUnwWDMZOo/6gRNOL0XdWtB11SBm3tlNuQyg==
X-Gm-Message-State: AOJu0Yyd4DHO7PzB/8oonA4CRFKrtiS8G6fTNaqyA3AUmUSh5Ad0hIRW
	udIkIAx/DbhMfP9662j7Vh95YnbROY5tK5YJ51CulWpPlio5xqqtIX1TIzBZmys=
X-Google-Smtp-Source: AGHT+IHDQ4oQoqDpkhxCqSAL5XBWT95fcvMXTg1YL+KxJAxLhBxcAFRK9oVidT84+tTBeNJkgEp4vg==
X-Received: by 2002:a17:902:c94d:b0:1f7:11dd:6d89 with SMTP id d9443c01a7336-1f83b76c5a9mr1351325ad.68.1718142207471;
        Tue, 11 Jun 2024 14:43:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d71a81f1sm87058795ad.98.2024.06.11.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:43:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sH9H1-00CcNh-1z;
	Wed, 12 Jun 2024 07:43:23 +1000
Date: Wed, 12 Jun 2024 07:43:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <ZmjE+y9nw/+1CnJB@dread.disaster.area>
References: <20240611101633.507101-1-mjguzik@gmail.com>
 <20240611101633.507101-2-mjguzik@gmail.com>
 <20240611105011.ofuqtmtdjddskbrt@quack3>
 <2aoxtcshqzrrqfvjs2xger5omq2fjkfifhkdjzvscrtybisca7@eoisrrcki2vw>
 <20240611-zwirn-zielbereich-9457b18177de@brauner>
 <CAGudoHHFh1d3AWcGQ-dm=DbwR8o-+a6+pcsvQbW-F_=qxbD0LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHFh1d3AWcGQ-dm=DbwR8o-+a6+pcsvQbW-F_=qxbD0LA@mail.gmail.com>

On Tue, Jun 11, 2024 at 03:13:45PM +0200, Mateusz Guzik wrote:
> On Tue, Jun 11, 2024 at 3:04 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 11, 2024 at 01:40:37PM +0200, Mateusz Guzik wrote:
> > > On Tue, Jun 11, 2024 at 12:50:11PM +0200, Jan Kara wrote:
> > > > On Tue 11-06-24 12:16:31, Mateusz Guzik wrote:
> > > > > +/**
> > > > > + * ilookup5 - search for an inode in the inode cache
> > > >       ^^^ ilookup5_rcu
> > > >
> > >
> > > fixed in my branch
> > >
> > > > > + * @sb:          super block of file system to search
> > > > > + * @hashval:     hash value (usually inode number) to search for
> > > > > + * @test:        callback used for comparisons between inodes
> > > > > + * @data:        opaque data pointer to pass to @test
> > > > > + *
> > > > > + * This is equivalent to ilookup5, except the @test callback must
> > > > > + * tolerate the inode not being stable, including being mid-teardown.
> > > > > + */
> > > > ...
> > > > > +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
> > > > > +         int (*test)(struct inode *, void *), void *data);
> > > >
> > > > I'd prefer wrapping the above so that it fits into 80 columns.
> > > >
> > >
> > > the last comma is precisely at 80, but i can wrap it if you insist
> > >
> > > > Otherwise feel free to add:
> > > >
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > >
> > >
> > > thanks
> > >
> > > I'm going to wait for more feedback, tweak the commit message to stress
> > > that this goes from 2 hash lock acquires to 1, maybe fix some typos and
> > > submit a v4.
> > >
> > > past that if people want something faster they are welcome to implement
> > > or carry it over the finish line themselves.
> >
> > I'm generally fine with this but I would think that we shouldn't add all
> > these helpers without any users. I'm not trying to make this a chicken
> > and egg problem though. Let's get the blessing from Josef to convert
> > btrfs to that *_rcu variant and then we can add that helper. Additional
> > helpers can follow as needed? @Jan, thoughts?
> 
> That's basically v1 of the patch (modulo other changes like EXPORT_SYMBOL_GPL).
> 
> It only has iget5_locked_rcu for btrfs and ilookup5_rcu for bcachefs,
> which has since turned out to not use it.
> 
> Jan wanted iget5_locked_rcu to follow the iget5_locked in style, hence
> I ended up with 3 helpers instead of 1.

We don't need any extra APIs if you just convert the inode cache to
using hash-bl rather than just converting lookups to RCU. Everyone
automatically gets the all extra scalability improvements and no new
interfaces are needed at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

