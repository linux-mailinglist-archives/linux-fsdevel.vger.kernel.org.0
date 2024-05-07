Return-Path: <linux-fsdevel+bounces-18876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18548BDC90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB52281D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B013C3F0;
	Tue,  7 May 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwcYuXFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AE13BAE9;
	Tue,  7 May 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067769; cv=none; b=VQM3/uMnEcN1k8bymCBresYpX7slGKLr2JZmrM5xouRLDt8TgpiGBn601UIm2u1ZmMubUwEh5AEyFdC7j2uj1eLT1yhviv9JCIdL/MpAAqZR5jknhcqsGVJ8zRw+jZimd4CxIS3kQew1SpR35mMwBm++Fnb3LL0R4Sa9u10psM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067769; c=relaxed/simple;
	bh=mi3mXWnBFgpXPxlG257vqa4x77kAtsjGzS+btNQZe28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaaRfdyJBfddeHBhyeLXAsLWI7N+bI/JJHXzdftJ1kA3LfiRiES1CJQIOdX+UCCNDClsL/bGFYyJWMYYgPHKidWQViUKTXS6rnIdnT43ezOeG0inc1VJo4WdmYjyR58ktrbHoda5LjrpV7aA8IQPhhTIN0FYunIow5FwttEcQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwcYuXFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF88C2BBFC;
	Tue,  7 May 2024 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715067769;
	bh=mi3mXWnBFgpXPxlG257vqa4x77kAtsjGzS+btNQZe28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwcYuXFS1rY4n6mNBVtmRT1XBNZmpqVk6pq/YRV3g3QbnOM+waK0fNUpKwhFMp+Z2
	 PYG9wZGheNahTisSY1g61QlJCRDIleNcVsmFhZzM11mmByNjORLiboHISsjU6ZIivQ
	 8bLkMNw/q9BwtsjCZS7Ye46qhfjzlevAaGhSpDcrJAQhhb4NkT/fngVYcK0esR3D9o
	 2e/x9FDCPhfzSDwOZusWXq9OBjyvQY3ssjrRF7J5LNMUxC/ypcgPva6uqn203wMT3j
	 09kyzgrYaM9smHVBcWqiraGg6H9L147uFKvtwqicegDRWd5W0svdf3JajjdVUncd5R
	 1P8x8QqJ934PA==
Date: Tue, 7 May 2024 09:42:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240507-verpennen-defekt-b6f2c9a46916@brauner>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>

> With my kernel hat on, maybe I agree.  But with my *user* hat on, I
> think I pretty strongly disagree.  Look, idmapis lousy for
> unprivileged use:
> 
> $ install -m 0700 -d test_directory
> $ echo 'hi there' >test_directory/file
> $ podman run -it --rm
> --mount=type=bind,src=test_directory,dst=/tmp,idmap [debian-slim]

$ podman run -it --rm --mount=type=bind,src=test_directory,dst=/tmp,idmap [debian-slim]

as an unprivileged user doesn't use idmapped mounts at all. So I'm not
sure what this is showing. I suppose you're talking about idmaps in
general.

> # cat /tmp/file
> hi there
> 
> <-- Hey, look, this kind of works!
> 
> # setpriv --reuid=1 ls /tmp
> ls: cannot open directory '/tmp': Permission denied
> 
> <-- Gee, thanks, Linux!
> 
> 
> Obviously this is a made up example.  But it's quite analogous to a
> real example.  Suppose I want to make a directory that will contain
> some MySQL data.  I don't want to share this directory with anyone
> else, so I set its mode to 0700.  Then I want to fire up an
> unprivileged MySQL container, so I build or download it, and then I
> run it and bind my directory to /var/lib/mysql and I run it.  I don't
> need to think about UIDs or anything because it's 2024 and containers
> just work.  Okay, I need to setenforce 0 because I'm on Fedora and
> SELinux makes absolutely no sense in a container world, but I can live
> with that.
> 
> Except that it doesn't work!  Because unless I want to manually futz
> with the idmaps to get mysql to have access to the directory inside
> the container, only *root* gets to get in.  But I bet that even
> futzing with the idmap doesn't work, because software like mysql often
> expects that root *and* a user can access data.  And some software
> even does privilege separation and uses more than one UID.

If the directory is 700 and it's owned by say root:root on the host and
you want to share that with arbitrary container users then this isn't
something you can do today (ignoring group permissions and ACLs for the
sake of your argument) even on the host so that's not a limitation of
userns or idmapped mounts. That means many to one mappings of uids/gids.

> So I want a way to give *an entire container* access to a directory.
> Classic UNIX DAC is just *wrong* for this use case.  Maybe idmaps
> could learn a way to squash multiple ids down to one.  Or maybe

Many idmappings to one is in principle possible and I've noted that idea
down as a possible extension at
https://github.com/uapi-group/kernel-features quite a while (2 years?) ago.

> I haven't looked at the idmap implementation nearly enough to have any
> opinion as to whether squashing UID is practical or whether there's

It's doable. The interesting bit to me was that if we want to allow
writes we'd need a way to determine what the uid/gid would be to write
down. Imho, that's not super difficult to solve though. The most obvious
one is that userspace can just determine it when creating the idmapped
mount.

