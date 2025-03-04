Return-Path: <linux-fsdevel+bounces-43183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B68A4F027
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50D13A4D15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7D2780EA;
	Tue,  4 Mar 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="s43pCyaA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34927780E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126995; cv=none; b=jwfl5PuivNXYFRuoGBU/TmA9ZnhNvpwVD92gWYSRI1MBQSy2SZvxvqNXwpkleTKcBRa0yhQKaUhWTytEaQ5dCf3C9qxTVB1wlOlVm+9GYgcsImK+W6XQvUS5EQphe/axz683E99h4njlZ7Q4rmVrt6CAb5Q1ahkJ7RiJwmFMhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126995; c=relaxed/simple;
	bh=tZwkAU5J7a6ekr4JRcopTM52ViBfDDbN2otzSXRnCS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzYjKGIABjWb+hmYQGiyrFufiO7Z1aNhKd+grYYgQn+EPmlV9laeZ/Kii7YDVVO5Mvu77Kxk+P+nfabKk/5DXUiO3fH6P7CJiO0+rmo1SaeuC4HdNCU4LgaveicrYGbx9r9ubrH8BVsowe6L+G4xdVJWEOC3hCAmmczCnQs/oDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=s43pCyaA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22398e09e39so56719615ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741126993; x=1741731793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UM4blpkHGvatz0v36aXHIO7geMzpTe4YVhpklJcvjgA=;
        b=s43pCyaAcCAawZHztMKv3M7hq7AZLjR4YFp/3JfPemDKYnOFo5I2++6ao0xo9TgQGZ
         vSu1FY2h7oMYHVWwQBbCnFgPNdgD5PEKLo82M0PLsNW36K7grIIv1EyTRrW3l0CCnOC0
         zGStQiXG0+JhHOgKLzqxxEi82IHnIYtked41iVVrevoHkLazuv98crKO7cvlB/H5dcee
         cFrUc4Y0peygTyyLsZ6TaIOfqXeUJdcZQs/FTFcbxSJEPt3hEInFFKxsWdmh9yinucFe
         ZfjSwjCwhqH6swN6VJy8YTF3EAdnsCZyBdZxU/iHppsCga9ufmhFrYp1aKc3howZP/Dw
         Lh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126993; x=1741731793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM4blpkHGvatz0v36aXHIO7geMzpTe4YVhpklJcvjgA=;
        b=XdXUdVbc3rQpMBFLCb8RUs9gzh4IEsE0OTh2Ap2PnudJOvQ2WnHRFoqKpw+69ysjzc
         c83CLAlKUiCjiBpiVJfqgpWj6/f6gCqTZMrJlocRt2bk8bhmTEjUA4Wl7WWaZ+cp2CJm
         BX7Hi/mb3dBKJGQGoRbungUqzTSJxgw+CIKLjS2KYLdSe5cdu/9obtLb7YGAGJXLt/Ik
         /P07a5tFtGEmfqPGAZT/icCsDF5FXKjxtUJ4R88lt4MpdHvci8YxCreCLkWFINBymtWI
         7VKj6dBx9o/AkQ+IE0TfnXczQqh7q08eC/1V/MnBD934+0+XyPRThakDKtvgZ+UoMftW
         p/Kw==
X-Gm-Message-State: AOJu0Yx9+zHsI7Yc93tMQKYF8aC8smILCE0Ur9IuRZ4WEi2M5shdtQ3O
	Byee0+oBUzzr+CIkI3pRS1t+El5YjOWaukOdFV48Cr/smgvIj1czuAI/hV/O7Zw=
X-Gm-Gg: ASbGncs3hrNbVl20edS3YaXsHH1yv0A7m4LETeqwJVpXaMDcRLzjDe/wtApGWbh1N35
	U6Kvme7N+g2sdwF7uM44ko+Gsy7OvmhY5tiH01K8++JznZBpvaKYwEZ3u9/OpDxOtM2NKGuZCjL
	khRgMySd5yN9+i1dyEm/3cq/KXI/DicZpB+SzZ/v2yWfhkwvVMEACMtnIJRstqd1NzE3kcjt0KC
	l1w8F+35f2aebau4diIOpnpzdnscBMbSMGO95HnLhJaJEp2ZhdZJXyn+lGSjB2jOW9iEUBmGQcM
	bFoZTngDGqblY6MJ90dzaNAX/1YsaHcIFcDaBs9ZwGK4LazSnI4xqLGiSTWMM3+XFAfikCl7ScX
	HYcw5X71Zxg==
X-Google-Smtp-Source: AGHT+IHpXfykZajcIbgTQCOL6S6ISZl1PeAnm3QtICMvl4q+8HWuMbUvuYC2pVYbZxyagZnIstHHhQ==
X-Received: by 2002:a17:903:32ce:b0:216:48f4:4f1a with SMTP id d9443c01a7336-223f1c950bdmr13963085ad.16.1741126993220;
        Tue, 04 Mar 2025 14:23:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm99780245ad.126.2025.03.04.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:23:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpafO-00000008v98-0u9I;
	Wed, 05 Mar 2025 09:23:10 +1100
Date: Wed, 5 Mar 2025 09:23:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <Z8d9ToyiD9Pin70G@dread.disaster.area>
References: <20250303170029.GA3964340@perftesting>
 <Z8a0IeCpX8ypKfTy@dread.disaster.area>
 <20250304150257.GB4043425@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304150257.GB4043425@perftesting>

On Tue, Mar 04, 2025 at 10:02:57AM -0500, Josef Bacik wrote:
> On Tue, Mar 04, 2025 at 07:04:49PM +1100, Dave Chinner wrote:
> > On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> > > CONCLUSION
> > > 
> > > I'd love some feedback on my potential problems and solutions, as well as any
> > > other problems people may see.  If we can get some discussion beforehand I can
> > > finish up these patches and get some testing in before LSFMMBPF and we can have
> > > a proper in-person discussion about the realities of the patchset.  Thanks,
> > 
> > I think there's several overlapping issues here:
> > 
> > 1. everything that stores state on/in the VFS inode needs to take a
> >    reference to the inode.
> > 2. Hacks like "walk the superblock inode list to visit every cached
> >    inode without holding references to them" need to go away
> > 3. inode eviction needs to be reworked to allow decoupled processing
> >    of the inode once all VFS references go away.
> > 4. The inode LRU (i.e. unreferenced inode caching) needs to go away
> > 
> > Anything else I missed? :)
> 
> Nope that's all what I've got on my list.  I want to run my plan for decoupling
> the inode eviction by you before I send my patches out to see if you have a
> better idea.  I know XFS has all this delaying stuff, but a lot of file systems
> don't have that infrastructure, and I don't want to go around adding it to
> everybody, so I still want to have a VFS hook way to do the final truncate.  The
> question is where to put it, and will it at the very least not mess you guys up,
> or in the best case be useful.

What I've been looking at locally if for the iput_final() processing
to be done asynchronously rather than in iput() context.

i.e. once the refcount goes to zero, we do all the cleanup stuff we
can do without blocking, then punt it to an async context to finish
the cleanup.

The problems I've had with this are entirely from the "inodes with
refcount of zero are still visible and accessed by the VFS code",
and I hadn't got to solving that problem. The sb list iter work I
posted a while back (and need to finish off) was the first step I'd
made in that direction.

> We're agreed on the active/passive refcount, so the active refcount will be the
> arbiter of when we can do the final truncate.  My current patchset adds a new
> ->final_unlink() method to the inode_operations, and if it's set we call it when
> the active refcount goes to 0.  Obviously a passive refcount is still held on
> the inode while this operation is occurring.

Yes, I think this allows async processing of the inode after the
active refcount reaches zero and iput_final() is called. The async
processing retains a passive reference all the way through until the
inode is completely destroyed and then freed.

> I just want to spell it out, because some of what you've indicated is you want
> the file system to control when the final unlink happens, even outside of the
> VFS.

What I really want is for all iput_final/evict handling that may
need to block to be punted to an async processing context. That's
what we already do with XFS, and what I'd really like for the VFS to
natively support. i.e. passive reference counts allow decoupling of
inode eviction work from the task context that drops the last active
reference.

We need to do this to allow the nasty mm LRU hacks to be turned into
active reference counts because those hacks require iput() to be
safe to call from any context...

> I'm not sure if you intend to say that it happens without a struct inode,
> or you just mean that we'll delay it for whenever the file system wants to do
> it, and we'll be holding the struct inode for that entire time.

Yes, XFS holds the struct inode via the struct xfs_inode
wrapped around the outside of it. i.e. the VFS inode lifecycle is a
subset of the XFS inode lifecycle. 

i.e. I would expect that a filesystem with such a VFs vs FS
lifecycle setup to maintain a passive struct inode reference count
for it's own inode wrapper structure. This means the object will
remain valid for as long as the filesystem needs it's inode wrapper
structure to live.

The filesystem would add the passive reference at inode allocation.
This passive reference then gets removed when the filesystem is done
tearing down it's internal inode structure and at that point the
whole object can be freed.

Also, we already do a -lot- of work behind the scenes without inode
references in the internal XFS code (e.g. inode writeback does
lockless, cache coherent unreferenced lookups of inodes). Converting
these internal lookups to use passive references would greatly
simplify the internal lookup vs reclaim interactions that we
currently have to handle....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

