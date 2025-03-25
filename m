Return-Path: <linux-fsdevel+bounces-45030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD8CA7041A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B06A7A49E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E125A356;
	Tue, 25 Mar 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WELSnYRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F642030A;
	Tue, 25 Mar 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913977; cv=none; b=cpHXaGGYSbMkUVe2Wm92oTQifiHx7AD2xbd4TsHJL0iR6t2zFXnQ81ifeweBnayuCcFKe9t9j221LuU4WXvw0BGRqRcyeDSkyVF/mV0awC/K1n3K71+oyZGvN00MhnbQwXgRt+Akv1mrBxHz07DQYR1qU9Q0ld/017ulzTIi1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913977; c=relaxed/simple;
	bh=wzCN6+YZqXyWVEA16BSIhXtpjsTUuJmBEovGj0SMI+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=artSLQA2pMLuySm6T9tw5Plt4mgU7IJSMWJiZrIuiX/+JCdBrayVe66UZFd2wHBtDmek9nhl1vALDneZ7o9f0+EQvsl8PPXxLyrlBhdRJ63qPsdUQwtCM8fzIx89N76AK0PPqDtMN2UxRXumHVaflNoIz2RA8F+ugAPNSbDE8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WELSnYRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA95C4CEE4;
	Tue, 25 Mar 2025 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913977;
	bh=wzCN6+YZqXyWVEA16BSIhXtpjsTUuJmBEovGj0SMI+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WELSnYRZeXnEsFvTMPRYAVf5j9FbHPVwByWnB+TQ24az7/mKlbden0JE61ezfx4Qz
	 vGSp1xiA8xKoCl+uSrzfWnUdmE7PUfKM3oZCxtWdEOdUol4WdzsTwRQ3uDFL1vL2Yh
	 XeBecTb9nAYO+B0SVj4RyFqLYvtNHk7KvALAhG68RYYZPWdbQ7AyB5ftAuzC+NFgsY
	 9LhE9O8gChFG/II/8R5nMzO5GO2j8CyUP2kojp7IkMZIoH0plHeUSHReq0YRHCns4j
	 eJnRBAk79BL9bk+sjgYSvq+XxI4kslGUXwXm8VzwXevxiHop4u2OTuMmWsOUXz9Rqy
	 R7TjCuY3wwIdQ==
Date: Tue, 25 Mar 2025 15:46:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250325-stilbruch-deeskalation-f212bb2499de@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
 <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
 <20250325100936.GC29185@redhat.com>
 <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
 <20250325132136.GB7904@redhat.com>
 <20250325-bretter-anfahren-39ee9eedf048@brauner>
 <CAGudoHFGcTergsO2Pg_v9J4aj94dWnCn_KrE1wpGd+x=g8_f1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFGcTergsO2Pg_v9J4aj94dWnCn_KrE1wpGd+x=g8_f1Q@mail.gmail.com>

On Tue, Mar 25, 2025 at 03:15:06PM +0100, Mateusz Guzik wrote:
> On Tue, Mar 25, 2025 at 2:30 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Mar 25, 2025 at 02:21:36PM +0100, Oleg Nesterov wrote:
> > > On 03/25, Mateusz Guzik wrote:
> > > >
> > > > On Tue, Mar 25, 2025 at 11:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > On 03/24, Mateusz Guzik wrote:
> > > > > >
> > > > > > On Mon, Mar 24, 2025 at 7:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > > >
> > > > > > > So to me it would be better to have the trivial fix for stable,
> > > > > > > exactly because it is trivially backportable. Then cleanup/simplify
> > > > > > > this logic on top of it.
> > > > > >
> > > > > > So I got myself a crap testcase with a CLONE_FS'ed task which can
> > > > > > execve and sanity-checked that suid is indeed not honored as expected.
> > > > >
> > > > > So you mean my patch can't fix the problem?
> > > >
> > > > No, I think the patch works.
> > > >
> > > > I am saying the current scheme is avoidably hard to reason about.
> > >
> > > Ah, OK, thanks. Then I still think it makes more sense to do the
> > > cleanups you propose on top of this fix.
> >
> > I agree. We should go with Oleg's fix that in the old scheme and use
> > that. And then @Mateusz your cleanup should please go on top!
> 
> Ok, in that case I'm gonna ship when I'm gonna ship(tm), maybe later this week.

Ok, I've taken the patch as I've got a first round of fixes to send
already.

