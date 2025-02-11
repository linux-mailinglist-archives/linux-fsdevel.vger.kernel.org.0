Return-Path: <linux-fsdevel+bounces-41494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1FA2FFF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AB53A34C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A70175D50;
	Tue, 11 Feb 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Q9x+RLsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE3597B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236405; cv=none; b=Y6CTSfTVE8fG5pQxBfvhOVh+BbvYWsizbqf5uZSNsF/OtzC1ScLLcDYlAIiEy9bQFKex0gY3wiBZ718CRk4cScF/c5TkMjO8ZbmCLFErRAD64VFdsdQy4T3fQUUF+1fLn2UVu+GLMwaJSK5DJz7cEyU2ZxflmmJscmbS1rqVWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236405; c=relaxed/simple;
	bh=SmMcYPlIcOOEv2FK6hAGHvO595m3+nNe2QXoWqq2KqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+ZrWD8XXFnSAZ7DqvJvZFl2jKWzTlsNClkbCcxDTU5K5fbFXhGu86nyX7Wr/KWB3OahKx+I2vFR+wkdXKdruIE51KzrvSMhX14F2zcysspXe3KFNWThumNXZP+Cc9DD9Gn+C/PVEw9ZUVEQLdhJ+PeSkZZNvEZbgOr3J5EnS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Q9x+RLsU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9f5caa37cso8650553a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739236402; x=1739841202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KU7wbaLY8iqIzyNycRaeoE4nIz2QfexpAlnBD6/ff+Q=;
        b=Q9x+RLsUa2ftZSA7YLwS87+Aw2EPZRfpb9/6n2Jur4Tm3Tbv8d6M2VgTOzkhZjDiFv
         X2AsKM81v6B8Pzos86cIY/lJopPPiGIbUQwz3C7q0BBtVUx+6QrPbpzI9nIYMi3+ER1R
         VN4fOP2zuLrsgqIZrGLpqnNmhc1T06T+3Iofu1/eJNymZ64NozaLBp/L5L7+B37zw51N
         usMxH+HRzr4Zgj7o5UkF8vQwLZJY7wBFWlLewE5VNQNkHHMLp8KPOOvbYfi0KjdlFkKT
         N8X4slNbfcHQP++N7994WugGLaFvGckk2E897EsX8HjJ8XJzthWnLBFpx4bnfYa3CsW4
         f+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236402; x=1739841202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU7wbaLY8iqIzyNycRaeoE4nIz2QfexpAlnBD6/ff+Q=;
        b=buQO1j9SeDQwLS6QX1Sd1ICPQ7t7QqPRneHGqcAX4rVU4teaUZ5iCS6rPKN0GwO8Q1
         Btaj/iEoskcXoPxcbbsGxUOZ3Pkme5Xj+qqVblGSXNzhCDhDDN11lJtaV/mmxOL6eitV
         XQCAvuE5gJx2dMzqVrZxXaKu8tX5dnCqvm7iojFc94VK6CrxGS5mM2TPu2bj2yZfP7eU
         ldmZ9iDd2yNY8c4PfPK2yu/GYlPqLLBvhqC66EhALKHk9uVi8uGiuCAROn2+rB5gW+wx
         VdVt6C4v5CszD8BhN+FrwP8IPodKSkhEN3AxRxy8QA6ohsXy4HlR/3f4G0mloxUqVI1o
         amqA==
X-Forwarded-Encrypted: i=1; AJvYcCX8c49AV9tQoShLHC5el7pa3eahN+KSgoxPLj2Yf84pqHIAVpYnhrsndXoATaoUCdltprBv0S/JctRNSCoK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9c5RIq8M/H7vhWBc1QZAN5aaGNVesfmZPvoqvmCy8hM+OOjvj
	vM8QXEYgAAw1NJT65N6Dpcc36MpuNLM7YKof85aWnHQ4IGQ8gvtzWv8WWWlZxydSWpZk5snZMTb
	i
X-Gm-Gg: ASbGncsk0koFhuyBUNynE+GK4JQ6ym/m9HQoQmBes8DvbsX5/1DCS2+rhGIBdK2Cwr5
	030Z+s7W04G7QJ8FIPKApjhsDe2HMYMJGAF9d92XiFgJfANxZwswZYnQMHN8qAEt9oCdGjHclH6
	xvriJxpG7SWF6GLS0AxIDZAPZIWrDyWS9jgTkgwup3wxHTKaNOlX8WJKD1Pw1nLxO4BWA0ckhoy
	0umNw5rrkW88amF12N/+ntbmMZUNFx7cLgh34QSGgQtcrORw2ZWPumdNFdrIByx8BqOgDPQejjB
	JPFlUnoFQhtsiWA3MMSVR26tHtr/PRpShkQBK+DRFxrCENaV3nBG04k5tF7HTN/SCaI=
X-Google-Smtp-Source: AGHT+IF1Z3e+O30aeZjrAbE2ylR2ddkFt/SQeAFQG892cO0ScdagUjGfXoC90W+wUwOfDkw2XVaaaw==
X-Received: by 2002:a17:90b:3b8b:b0:2f5:63a:44f8 with SMTP id 98e67ed59e1d1-2faa08f523emr2516907a91.8.1739236402291;
        Mon, 10 Feb 2025 17:13:22 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d551sm84589785ad.110.2025.02.10.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 17:13:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thepy-0000000HGZ0-3bTH;
	Tue, 11 Feb 2025 12:13:18 +1100
Date: Tue, 11 Feb 2025 12:13:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z6qkLjSj1K047yPt@dread.disaster.area>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>

On Mon, Feb 10, 2025 at 06:28:28PM +0100, Jan Kara wrote:
> On Tue 04-02-25 06:06:42, Christoph Hellwig wrote:
> > On Tue, Feb 04, 2025 at 01:50:08PM +1100, Dave Chinner wrote:
> > > I doubt that will create enough concurrency for a typical small
> > > server or desktop machine that only has a single NUMA node but has a
> > > couple of fast nvme SSDs in it.
> > > 
> > > > 2) Fixed number of writeback contexts, say min(10, numcpu).
> > > > 3) NUMCPU/N number of writeback contexts.
> > > 
> > > These don't take into account the concurrency available from
> > > the underlying filesystem or storage.
> > > 
> > > That's the point I was making - CPU count has -zero- relationship to
> > > the concurrency the filesystem and/or storage provide the system. It
> > > is fundamentally incorrect to base decisions about IO concurrency on
> > > the number of CPU cores in the system.
> > 
> > Yes.  But as mention in my initial reply there is a use case for more
> > WB threads than fs writeback contexts, which is when the writeback
> > threads do CPU intensive work like compression.  Being able to do that
> > from normal writeback threads vs forking out out to fs level threads
> > would really simply the btrfs code a lot.  Not really interesting for
> > XFS right now of course.
> > 
> > Or in other words: fs / device geometry really should be the main
> > driver, but if a file systems supports compression (or really expensive
> > data checksums) being able to scale up the numbes of threads per
> > context might still make sense.  But that's really the advanced part,
> > we'll need to get the fs geometry aligned to work first.
> 
> As I'm reading the thread it sounds to me the writeback subsystem should
> provide an API for the filesystem to configure number of writeback
> contexts which would be kind of similar to what we currently do for cgroup
> aware writeback?

Yes, that's pretty much what I've been trying to say.

> Currently we create writeback context per cgroup so now
> additionally we'll have some property like "inode writeback locality" that
> will also influence what inode->i_wb gets set to and hence where
> mark_inode_dirty() files inodes etc.

Well, that's currently selected by __inode_attach_wb() based on
whether there is a memcg attached to the folio/task being dirtied or
not. If there isn't a cgroup based writeback task, then it uses the
bdi->wb as the wb context.

In my mind, what you are describing above sounds like we would be
heading down the same road list_lru started down back in 2012 to
support NUMA scalability for LRU based memory reclaim.

i.e. we originally had a single global LRU list for important
caches. This didn't scale up, so I introduced the list_lru construct
to abstract the physical layout of the LRU from the objects being
stored on it and the reclaim infrastructure walking it. That gave us
per-NUMA-node LRUs and NUMA-aware shrinkers for memory reclaim. The
fundamental concept was that we abstract away the sharding of the
object tracking into per-physical-node structures via generic
infrastructure (i.e. list_lru).

Then memcgs needed memory reclaim, and so they were added as extra
lists with a different indexing mechanism to the list-lru contexts.
These weren't per-node lists because there could be thousands of
them. Hence it was just a single "global" list per memcg, and so it
didn't scale on large machines.

This wasn't seen as a problem initially, but a few years later
applications using memcgs wanted to scale properly on large NUMA
systems. So now we have each memcg tracking the physical per-node
memory usage for reclaim purposes (i.e.  combinatorial explosion of
memcg vs per-node lists).

Hence suggesting "physically sharded lists for global objects,
single per-cgroup lists for cgroup-owned objects" sounds like
exactly the same problem space progression is about to play out with
writeback contexts.

i.e. we shared the global writeback context into a set of physically
sharded lists for scalability and perofrmance reasons, but leave
cgroups with the old single threaded list constructs. Then someone
says "my cgroup based workload doesn't perform the same as a global
workload" and we're off to solve the problem list_lru solves again.

So....

Should we be looking towards using a subset of the existing list_lru
functionality for writeback contexts here? i.e. create a list_lru
object with N-way scalability, allow the fs to provide an
inode-number-to-list mapping function, and use the list_lru
interfaces to abstract away everything physical and cgroup related
for tracking dirty inodes?

Then selecting inodes for writeback becomes a list_lru_walk()
variant depending on what needs to be written back (e.g. physical
node, memcg, both, everything that is dirty everywhere, etc).

> Then additionally you'd like to have possibility to have more processes
> operate on one struct wb_writeback (again configurable by filesystem?) to
> handle cases of cpu intensive writeback submission more efficiently.

Yeah, that is a separate problem...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

