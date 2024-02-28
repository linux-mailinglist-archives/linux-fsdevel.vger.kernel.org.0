Return-Path: <linux-fsdevel+bounces-13048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A086A938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3891C211E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298625567;
	Wed, 28 Feb 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La9rm1+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC29442C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106541; cv=none; b=jqKOE/AHBQ3NaQInIE89EmdUzbfQTcAZwc8qpt49UAA8vKahFgC/nLHDEHdJmWAcEgdreKcLKLBUjOedf0jZ+nQb9jMD2FlBC5Xd1vRm6k3oatMdwMhE8S/u38+GLPWFTT/toQegxJxB4Cpi3faeFsD9g4i9HDa//nfx1NERVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106541; c=relaxed/simple;
	bh=gBOMkWAlc3iPURHBvRAcCLLQVJz7DCIAd8c31DcYh/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJLiZ8BCx9vF9uIilZVUlmHk1y5vZ/jiWSmXL9inNhz/8m9z21W5UKW3y3sHhOuRjcWyRVTVHbVZzGiWvasxJVxr0CONsa1uzDda/cGkt4sWYcoRn0APTSowMn2Ft5qjeKJW39cAYRvtEZGFQlCwLGV2q4ZhknydykgZs43+sqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La9rm1+i; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e5e16559cso34003671cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709106539; x=1709711339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBOMkWAlc3iPURHBvRAcCLLQVJz7DCIAd8c31DcYh/s=;
        b=La9rm1+iehS+B7K1AUewum7raHrzTv+j/1gGWanbNp3cjtrFgmkwefKOVxKyiKse4g
         ruU28j4Jp3JsnuEUYgUmbdfh51k0mhNgI240RcVXGeLSaf7IU63F3isJN4xBVMSVaQoD
         aX78taxa5kOY2fU4NkgnKDkW8CVOaBndvkvnr4wP/7KCCM0dRdWevxS51jpSEJ6+H9bH
         kwbTnQ9fRJkogk18mM4xD66aXvYbGAi2sUle31PQr4YxIJPW4bv5TM7AmcQrlPzfKmHf
         S34c7X82YwzQphUvNmuu46pEBcefh4BCr2EjOMmlSHBgM2VEcEfow2vP5lwl3zgd+o9d
         wDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106539; x=1709711339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBOMkWAlc3iPURHBvRAcCLLQVJz7DCIAd8c31DcYh/s=;
        b=xUF0hOPeyixZAcAW6A4pCVpDdibA1hfBxGpGcjcXDplqc9uREtatoURe2ThrqIA9ii
         3s+rig94X9qLzt28D5id7qqSFJM3IK6OlbksqpfXPIMtIO8BxHA+xa+SQJ4shL5EugDt
         G3VyO4qhB190Xj3LxQeCk7qSGn8AwUSL/qXKf8cnfwCHtx6Dn9qhENc5v3/PrX4WOn53
         V4npWxBBD1vUkDNkQNKI1mSsvPas76TVh8pWzQJkVnwQ75W1dgVadigGHuTPfztSFZfn
         Aa69zXXD/Cg/UqmEYNTvQByludTXox4TO4xgZaTWOW4pEEAUJCoQGuDKx7pW8lD79tn3
         rPTw==
X-Forwarded-Encrypted: i=1; AJvYcCU+x7rA9k/Z6+Eg5n3MT3cyjH0zxk7Jp/soqevjyYQ0YKOuMerauZ8iIdCERw8LaZMgjGwSFZkD8i+mMHL6jO4XhsXo/WkwWQIipIOW+Q==
X-Gm-Message-State: AOJu0YzIszWiwoouO2zGH9T6DcaptXlQ6xgPl3WUzlfmGUt4MHiHKjp1
	OrxZ/dFbgnBe/1FaRLq0ULgS+Qm8S+UO5STgp9vChoLikYWh+qGdQ0ddLyyO/deKx89X7HOD0XK
	evGDpfSZAaplVQb+mwQ3ZNWlqfKs=
X-Google-Smtp-Source: AGHT+IGvn3hRL2cRCYqeM4rBr6ppmr8RuKk7IYJC9u1AAiBrdhfPJHqt5n6A9FZI/QI7kTPuHQ9c52gPb640FxnKQdI=
X-Received: by 2002:ac8:5c4a:0:b0:42e:b140:405a with SMTP id
 j10-20020ac85c4a000000b0042eb140405amr295977qtj.26.1709106538899; Tue, 27 Feb
 2024 23:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area> <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <Zd5lORiOCUsARPWq@dread.disaster.area>
In-Reply-To: <Zd5lORiOCUsARPWq@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 09:48:46 +0200
Message-ID: <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Measuring limits and enhancing
 buffered IO
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, Matthew Wilcox <willy@infradead.org>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-mm <linux-mm@kvack.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:42=E2=80=AFAM Dave Chinner via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> On Tue, Feb 27, 2024 at 05:21:20PM -0500, Kent Overstreet wrote:
> > On Wed, Feb 28, 2024 at 09:13:05AM +1100, Dave Chinner wrote:
> > > On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> > > > AFAIK every filesystem allows concurrent direct writes, not just xf=
s,
> > > > it's _buffered_ writes that we care about here.
> > >
> > > We could do concurrent buffered writes in XFS - we would just use
> > > the same locking strategy as direct IO and fall back on folio locks
> > > for copy-in exclusion like ext4 does.
> >
> > ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> > just like everyone else.
>
> Uhuh. ext4 does allow concurrent DIO writes. It's just much more
> constrained than XFS. See ext4_dio_write_checks().
>
> > > The real question is how much of userspace will that break, because
> > > of implicit assumptions that the kernel has always serialised
> > > buffered writes?
> >
> > What would break?
>
> Good question. If you don't know the answer, then you've got the
> same problem as I have. i.e. we don't know if concurrent
> applications that use buffered IO extensively (eg. postgres) assume
> data coherency because of the implicit serialisation occurring
> during buffered IO writes?
>
> > > > If we do a short write because of a page fault (despite previously
> > > > faulting in the userspace buffer), there is no way to completely pr=
event
> > > > torn writes an atomicity breakage; we could at least try a trylock =
on
> > > > the inode lock, I didn't do that here.
> > >
> > > As soon as we go for concurrent writes, we give up on any concept of
> > > atomicity of buffered writes (esp. w.r.t reads), so this really
> > > doesn't matter at all.
> >
> > We've already given up buffered write vs. read atomicity, have for a
> > long time - buffered read path takes no locks.
>
> We still have explicit buffered read() vs buffered write() atomicity
> in XFS via buffered reads taking the inode lock shared (see
> xfs_file_buffered_read()) because that's what POSIX says we should
> have.
>
> Essentially, we need to explicitly give POSIX the big finger and
> state that there are no atomicity guarantees given for write() calls
> of any size, nor are there any guarantees for data coherency for
> any overlapping concurrent buffered IO operations.
>

I have disabled read vs. write atomicity (out-of-tree) to make xfs behave
as the other fs ever since Jan has added the invalidate_lock and I believe
that Meta kernel has done that way before.

> Those are things we haven't completely given up yet w.r.t. buffered
> IO, and enabling concurrent buffered writes will expose to users.
> So we need to have explicit policies for this and document them
> clearly in all the places that application developers might look
> for behavioural hints.

That's doable - I can try to do that.
What is your take regarding opt-in/opt-out of legacy behavior?
At the time, I have proposed POSIX_FADV_TORN_RW API [1]
to opt-out of the legacy POSIX behavior, but I guess that an xfs mount
option would make more sense for consistent and clear semantics across
the fs - it is easier if all buffered IO to inode behaved the same way.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUP=
nNdtiqV2Q9woqA@mail.gmail.com/

