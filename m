Return-Path: <linux-fsdevel+bounces-51454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647AAD7076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F364A1886460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DEA221739;
	Thu, 12 Jun 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7wHX6gx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AA2F4322;
	Thu, 12 Jun 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731494; cv=none; b=DrgnrRqCxMmptPvEPEG/fWf8Kifhx3CoRAAKWn1GoWPNoPy9gfnr+r/R5eX/jNnoePtVbbTZv6egDwZR08ePr4/jkdchb3JbPpaKCQr8xX7A3fyraQFcDG3meLPXIEddJm6Pjk2uFAjhd7RI5IBAMF+SGSL1lMxJ0yhSgQf9404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731494; c=relaxed/simple;
	bh=plOimjf1Hornox4olvLgJ3RBchkKjUgxZh9h3lWIBkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnc+jN3cvdtWk3NLebcc/ZpaiOIEByggQW9B+4OqaUxp7CnmoKGekP7yTwxw18DvttnYnlq0RgM5kSY6OdUTA0bp4yBaSDeofO4svuTP3jRWJMyvfPlN3lH80lcnWVDU340YRvYLMUyBN8zjLzh8JmIEomJTz4qowllAYgZ42ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7wHX6gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AF6C4CEEA;
	Thu, 12 Jun 2025 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731493;
	bh=plOimjf1Hornox4olvLgJ3RBchkKjUgxZh9h3lWIBkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7wHX6gxBmrU2wVsFjdyFIS3aQp5X1snRh9Mmvs9UQs24DxYXjh4+w2zD0C+IzxV6
	 KDHsCn1xEmU9LVqAjZDT/06LgNn9uS6XHzyO8O+VWC1movfClioKVy2A4q9zqkuR3A
	 IZeWpvA8+FjveKr+MsPa+LNnCzolLDhJVT46+v8Am+FUohlXKgIbbMuGVw0NY3qEzF
	 b5ppPTucCtnsjdYAyKcZISOXRUlVPIGm6GDtu3K9+r9GTCaKcdVThiDqroxFnHsQHF
	 4jPcXwQdvVZCQbdY9X0Gw5U34gin+DUTkDAFkBU9HHL1XJsGW2n5eyT4iB+HyK8xS+
	 qCtpkkiKZpD2w==
Date: Thu, 12 Jun 2025 14:31:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Song Liu <song@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, NeilBrown <neil@brown.name>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <20250612-erraten-bepacken-42675dfcfa82@brauner>
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net>
 <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
 <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
 <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
 <zlpjk36aplguzvc2feyu4j5levmbxlzwvrn3bo5jpsc5vjztm2@io27pkd44pow>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zlpjk36aplguzvc2feyu4j5levmbxlzwvrn3bo5jpsc5vjztm2@io27pkd44pow>

On Thu, Jun 12, 2025 at 11:49:08AM +0200, Jan Kara wrote:
> On Thu 12-06-25 11:01:16, Jan Kara wrote:
> > On Wed 11-06-25 11:08:30, Song Liu wrote:
> > > On Wed, Jun 11, 2025 at 10:50 AM Tingmao Wang <m@maowtm.org> wrote:
> > > [...]
> > > > > I think we will need some callback mechanism for this. Something like:
> > > > >
> > > > > for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rcu) {
> > > > >    if (!try_rcu)
> > > > >       goto ref_walk;
> > > > >
> > > > >    __read_seqcount_begin();
> > > > >     /* rcu walk parents, from starting_path until root */
> > > > >    walk_rcu(starting_path, root, path) {
> > > > >     callback_fn(path, cb_data);
> > > > >   }
> > > > >   if (!read_seqcount_retry())
> > > > >     return xxx;  /* successful rcu walk */
> > > > >
> > > > > ref_walk:
> > > > >   /* ref walk parents, from starting_path until root */
> > > > >    walk(starting_path, root, path) {
> > > > >     callback_fn(path, cb_data);
> > > > >   }
> > > > >   return xxx;
> > > > > }
> > > > >
> > > > > Personally, I don't like this version very much, because the callback
> > > > > mechanism is not very flexible, and it is tricky to use it in BPF LSM.
> > > >
> > > > Aside from the "exposing mount seqcounts" problem, what do you think about
> > > > the parent_iterator approach I suggested earlier?  I feel that it is
> > > > better than such a callback - more flexible, and also fits in right with
> > > > the BPF API you already designed (i.e. with a callback you might then have
> > > > to allow BPF to pass a callback?).  There are some specifics that I can
> > > > improve - Mickaël suggested some in our discussion:
> > > >
> > > > - Letting the caller take rcu_read_lock outside rather than doing it in
> > > > path_walk_parent_start
> > > >
> > > > - Instead of always requiring a struct parent_iterator, allow passing in
> > > > NULL for the iterator to path_walk_parent to do a reference walk without
> > > > needing to call path_walk_parent_start - this way might be simpler and
> > > > path_walk_parent_start/end can just be for rcu case.
> > > >
> > > > but what do you think about the overall shape of it?
> > > 
> > > Personally, I don't have strong objections to this design. But VFS
> > > folks may have other concerns with it.
> > 
> > From what I've read above I'm not sure about details of the proposal but I
> > don't think mixing of RCU & non-RCU walk in a single function / iterator is
> > a good idea. IMHO the code would be quite messy. After all we have
> > follow_dotdot_rcu() and follow_dotdot() as separate functions for a reason.
> > Also given this series went through several iterations and we don't yet
> > have an acceptable / correct solution suggests getting even the standard
> > walk correct is hard enough. RCU walk is going to be only worse. So I'd
> > suggest to get the standard walk finished and agreed on first and
> > investigate feasibility of RCU variant later.
> 
> OK, I've now read some of Tingmaon's and Christian's replies which I've
> missed previously so I guess I now better understand why you complicate
> things with RCU walking but still I'm of the opinion that we should start
> with getting the standard walk working. IMHO pulling in RCU walk into the
> iterator will bring it to a completely new complexity level...

I would not want it in the first place. But I have a deep seated
aversion to exposing two different variants. Especially if the second
variant wants or needs access to internal details such as mount or
dentry sequence counts. I'm not at all in favor of that.

