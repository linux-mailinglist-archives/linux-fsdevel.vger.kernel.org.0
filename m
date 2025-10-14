Return-Path: <linux-fsdevel+bounces-64167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A5BDBA42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C656355BF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4D30DEAB;
	Tue, 14 Oct 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AfMX25/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF330CD8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480688; cv=none; b=RtT4odVwXpEYNNHDFgviFy/ppkHnRsscamlPOp6py0IweNXbk7P2gJUlLqprUu8v3BZgAcpt1TtE5qArkqhzlqtnR3UUYPlCkYn365+Rfe1hDgCKxxelhxYluCMUodBMUbV+UHHJ6fdr4uTvk+w+w0yRF45Xdd8wj6oCbbgPnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480688; c=relaxed/simple;
	bh=pKj7nF9FZa4CVDaaC2vI4eiSd7iIaOqkYyjB/cLYWWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzowQMAR7KNgT4SHhiL3Mv9XKPGUxH8kFuG6lPo06olmEJSEcuxak29eeUqu+jf563qk4lxGzLYKxaHjbQikKPaTOb8e2bj4ktC8otHkRuZBdVe8gr9M2T1bardxVVAtYkYmz3Ql3YqctJf7wiFkoP3IRkpjrZ2YbALHED8On8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AfMX25/0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b57bffc0248so274679a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760480686; x=1761085486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VU+E0coYgVNDVEMZPHxDysYf7EYOnkoJs7l4tPFgGSs=;
        b=AfMX25/0TQzmfcK/hscJ/q3U1LCZyIWKBrZlsvKyPAR8npiNzUhA7zKLKIpddTmQSv
         cppG1JWC8OFzVe3Io5LtQmNqohuwswlqTo7m/Zea0F39qHlI+yiFHn3tY3RCEHJoi73x
         jeFSNIJsxuGX5bo+T5a+5Ek00nt3obBxS9MPQZlzvNJkDrMtKwtqnIaWuSyRImJn+48+
         2KBopwAIZnehbvBHu8dDgovTpqKFMDAn5cRl8y+5yboBfI7cOPLF5oJYtxM4iIGdf1Zx
         afn47a2S3QStZ+wPAeWvTNTKWMZQVIaT9zy2jH185heb7Fsiiz0dNu/yrA/UKPwnAInh
         sfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480686; x=1761085486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU+E0coYgVNDVEMZPHxDysYf7EYOnkoJs7l4tPFgGSs=;
        b=Qbc1yzVItO4d5hNNNHR79exqfDU+HI+oLl/LvHzTCSugl7dGvS3aQQDwEFIXzfnHRT
         4b/V1ZU83BuqvX4TPoE0v2NRDzmEN/F3W9MxoPSbZJ0Vg5c3Hg7KSyG0MK7Qr1cEAzGU
         b3ndHkUJlMDvxIzpvmHUEFYoeONWnsP8bGNpZfQETeFL30Dh/ETcfWJTykrqKMCIfbCq
         XuUrqkyJeqgBq2UiBIj6VDW1vCqSVeuxGObMYKQyveIk0drTcildwtqDZoJbI5y0oKIH
         +r26sF50N4yAZWtSh5vAnm8sVMe98ugzAkZv6MBQMqQIjuXoqTcWokggwXjZ4ZVR0DSi
         BsCg==
X-Forwarded-Encrypted: i=1; AJvYcCUjEWGtVj8oG1xUbCfFtfplLSOoc08tuJDBBzzCo0LBQD8d+SSAf9xrc3tFiO5R1gaHZ47ZDcgg9OuApEMP@vger.kernel.org
X-Gm-Message-State: AOJu0YzosaGxmOjQMPCRYjIiGtCJfDugA8gLULNHMTdyi49hkFpYCEre
	gG1DkWkIzp8FDblH3XaGYcKX3riMkrlF/50BfyppAyeND865QzKz8pI6vRyvt5TI46E=
X-Gm-Gg: ASbGnctmolo769KT2sgP6ZMs9cLgKwOhJ+NFDpW6+d2L1UVgpabaL+6s5uLtThxf5yz
	gDEtYG/bcMuRZ8POHKvE7WaCZiKtEqNOQFagBsM7L6t1AlvEpp9AedFMGyvhqVdh/uNaH8QcKjd
	1jC6Zs+wyyhO5nDHYHZ1sjfTnUbM1Y0jknNl5yHguR97hpnwCGDIp5nR9oGUQPyF7CSrlPLfGXD
	NR+QwYEQ1kSxtejjSf5iFptEwNRBAbfW1uKrHV+hSuDDyCQqQhSkBqimqcBUjvf45Ci3WgOtq1v
	gkS/A312nVZ8mCVxOGgRMnDyMUw/Nzreru2E8vkQf6mDlTwrOAvhZZrKjJnXbNJNFRmWtNR8SFT
	LLT4xoRUVKUKnlRFoWZn8El75I8rV5tDXZ2uO1Pp7TLWjjxObkVaOJRuggvFyx8wjOvzQFLXHFL
	KQ0jbmAD6JvJmmBP6242z74mkL5qQ=
X-Google-Smtp-Source: AGHT+IEuiPLT+J2EGWyWH8Vlz1fhWHzXLhUTSRvMJ8Bb23RFgsXxsIuVuGY50FOYvF4QcobNAuFtTQ==
X-Received: by 2002:a17:903:2acb:b0:265:e815:fcdf with SMTP id d9443c01a7336-28ec9c9741bmr395484345ad.17.1760480685978;
        Tue, 14 Oct 2025 15:24:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b69c24043desm955564a12.3.2025.10.14.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:24:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8nRi-0000000Etua-2BV8;
	Wed, 15 Oct 2025 09:24:42 +1100
Date: Wed, 15 Oct 2025 09:24:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <aO7NqqB41VYCw4Bh@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
 <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>

On Fri, Oct 10, 2025 at 05:51:06PM +0200, Mateusz Guzik wrote:
> On Fri, Oct 10, 2025 at 4:44 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > > +static inline void inode_state_set_raw(struct inode *inode,
> > > +                                    enum inode_state_flags_enum flags)
> > > +{
> > > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > > +}
> >
> > I think this shouldn't really exist as it is dangerous to use and if we
> > deal with XFS, nobody will actually need this function.
> >
> 
> That's not strictly true, unless you mean code outside of fs/inode.c
> 
> First, something is still needed to clear out the state in
> inode_init_always_gfp().
> 
> Afterwards there are few spots which further modify it without the
> spinlock held (for example see insert_inode_locked4()).
> 
> My take on the situation is that the current I_NEW et al handling is
> crap and the inode hash api is also crap.

The inode hash implementation is crap, too. The historically poor
scalability characteristics of the VFS inode cache is the primary
reason we've never considered ever trying to port XFS to use it,
even if we ignore all the inode lifecycle issues that would have to
be solved first...

> For starters freshly allocated inodes should not be starting with 0,
> but with I_NEW.

Not all inodes are cached filesystem inodes. e.g. anonymous inodes
are initialised to inode->i_state = I_DIRTY.  pipe inodes also start
at I_DIRTY. socket inodes don't touch i_state at init, so they
essentially init i_state = 0....

IOWs, the initial inode state depends on what the inode is being
used for, and I_NEW is only relevant to inodes that are cached and
can be found before the filesystem has fully initialised the VFS
inode.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

