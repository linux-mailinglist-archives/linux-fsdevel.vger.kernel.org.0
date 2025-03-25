Return-Path: <linux-fsdevel+bounces-45012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B102A70245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45292175A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212325BAC6;
	Tue, 25 Mar 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz9sujFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1E25A2D1;
	Tue, 25 Mar 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909451; cv=none; b=gb+m2zupO2EDOBTn4L9bVlfzT5ofJ54X3ZvYYoxTPkWLA6OVhAvlmOM2SbBc2kQqkFHDFXyd/fJ+2Yjss7c13DrklFmDlX8Ghqvi70cRzR9FXe4wR0a+WSDU573i1W4I61oTBLReMskaEvBgWPLQBxQS9pfKodHPuwFptXUCKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909451; c=relaxed/simple;
	bh=AFz+xR3cxeybdFAR0wl1Pa8igU585gpjH4/Of2Jdma8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb/flzBNBabH7hmg/phdQWc7NQR6YBx6Rrt+j3tqfFHV441igoCGglMrROBDabSJ8BV8bZtFB39ypF32Hok+TvEPGOeFpfgnjXhaE8hyYgmlC+ZdzhrDEOTkW0KPTPbwZBaNdBmr93c3XlF+FeVFh3KfaW0ZC+ZXA2QVZ6hmfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz9sujFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5527C4CEE4;
	Tue, 25 Mar 2025 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909450;
	bh=AFz+xR3cxeybdFAR0wl1Pa8igU585gpjH4/Of2Jdma8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nz9sujFM3jGlX1cHt1JguczqA9ISu3qQOHeNcNTi0xtlHx3RtUm8YOKu+XOdXSJYD
	 p6EVnBJ3EdnHncBhfmMt9LJMgvNLuku6QMo79r8+amEoMRiqXpXBS6mgSIoWwNxbFP
	 hmbg+j0B5rDfafyIFtDp8pWDMx7U9BEODq8Ql+KV/XkNapaHROK2GS/mteMQ/+o26p
	 BthSbV2ScCG5HtKovdxiRSkTtYQ+U3/hZ0n/zTMLqAlbXrjq1Pwj9bxrcicKOiXpYg
	 mMSfuXBDJoUoBj9zQPHGbNEOmnbhQi4muH9u9dxgy5932q46Mm3N0W652+cJWdsVhL
	 J27Sgbv+cdCqA==
Date: Tue, 25 Mar 2025 14:30:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, 
	kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250325-bretter-anfahren-39ee9eedf048@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
 <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
 <20250325100936.GC29185@redhat.com>
 <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
 <20250325132136.GB7904@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325132136.GB7904@redhat.com>

On Tue, Mar 25, 2025 at 02:21:36PM +0100, Oleg Nesterov wrote:
> On 03/25, Mateusz Guzik wrote:
> >
> > On Tue, Mar 25, 2025 at 11:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 03/24, Mateusz Guzik wrote:
> > > >
> > > > On Mon, Mar 24, 2025 at 7:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > So to me it would be better to have the trivial fix for stable,
> > > > > exactly because it is trivially backportable. Then cleanup/simplify
> > > > > this logic on top of it.
> > > >
> > > > So I got myself a crap testcase with a CLONE_FS'ed task which can
> > > > execve and sanity-checked that suid is indeed not honored as expected.
> > >
> > > So you mean my patch can't fix the problem?
> >
> > No, I think the patch works.
> >
> > I am saying the current scheme is avoidably hard to reason about.
> 
> Ah, OK, thanks. Then I still think it makes more sense to do the
> cleanups you propose on top of this fix.

I agree. We should go with Oleg's fix that in the old scheme and use
that. And then @Mateusz your cleanup should please go on top!

