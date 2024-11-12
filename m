Return-Path: <linux-fsdevel+bounces-34444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61599C58A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B22C281D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908613A879;
	Tue, 12 Nov 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUpaAdhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E2136358;
	Tue, 12 Nov 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417012; cv=none; b=W0zdvPus1DMl19H/2bNruZJ6EOdm9yLisLyXU23k/E7Q+zso3ndFdM+AlSrSL320XmCD9NH937joz0TVgQ0wlsK7DWgeDNRI7iGRm2D3Dklt+eBv/fegosfdf1YF1Wj+yLegeaUagE4sbpHRS6RShOAaFJRhViI6P0KZehHxKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417012; c=relaxed/simple;
	bh=qU0TfofrryohZdFsp3G9A99dm0hCLhReQcTj+BrTMNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwhAlj+MLOVh6zEx+SdUJntAL2Kc8qlESBKWzcwEOTSHy/V0LSCN5lec05EjpMChzlMMEcrpDWzdkMc02PncO7m50hCgMz+nkHs7S7Jx3XP3CSPDzfYQ8GXWAgAE6tNpS12pHy/HV5uM/lo1pWb3Ipifj2He+kqEzsnpJp2f4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUpaAdhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B2C4CECD;
	Tue, 12 Nov 2024 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417011;
	bh=qU0TfofrryohZdFsp3G9A99dm0hCLhReQcTj+BrTMNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUpaAdhXZIEdKLTyrptCwezuUBm8tqnAv/4DtsXI+W3+UBpyMpIg8hPZCGwA3ciSk
	 ZfWa03QQo2chyMy9ru5DUZ+1m7g5blckLc1M/bA2yjWzMhoH722i8DMDLPgnIArqN2
	 vdaVP2mpFjVYGmmfuoa+w9RdrSIcpU/iMazuv7EhHdAt4PWUF7iYn1b974qGR3Hqoq
	 EGB6DTmK/TWH/8vhDINQTtPY7KPzjkA6fXmoSOX3FiBB7hLar6hFBOogWD/AHezgjH
	 4EjbkXQX3gHyU4atpYB/5+UOpS3Ivr+s2j2XuNk+WrVa/ax8lnV8xIXX4s4sJgm7eA
	 Mo8AXtNDO3fGw==
Date: Tue, 12 Nov 2024 14:10:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Message-ID: <20241112-banknoten-ehebett-211d59cb101e@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101135452.19359-1-erin.shepherd@e43.eu>

On Fri, Nov 01, 2024 at 01:54:48PM +0000, Erin Shepherd wrote:
> Since the introduction of pidfs, we have had 64-bit process identifiers 
> that will not be reused for the entire uptime of the system. This greatly 
> facilitates process tracking in userspace.
> 
> There are two limitations at present:
> 
>  * These identifiers are currently only exposed to processes on 64-bit 
>    systems. On 32-bit systems, inode space is also limited to 32 bits and 
>    therefore is subject to the same reuse issues.
>  * There is no way to go from one of these unique identifiers to a pid or 
>    pidfd.
> 
> Patch 1 & 2 in this stack implements fh_export for pidfs. This means 
> userspace  can retrieve a unique process identifier even on 32-bit systems 
> via name_to_handle_at.
> 
> Patch 3 & 4 in this stack implement fh_to_dentry for pidfs. This means 
> userspace can convert back from a file handle to the corresponding pidfd. 
> To support us going from a file handle to a pidfd, we have to store a pid 
> inside the file handle. To ensure file handles are invariant and can move 
> between pid namespaces, we stash a pid from the initial namespace inside 
> the file handle.
> 
> I'm not quite sure if stashing an initial-namespace pid inside the file 
> handle is the right approach here; if not, I think that patch 1 & 2 are 
> useful on their own.

Sorry for the delayed reply (I'm recovering from a lengthy illness.).

I like the idea in general. I think this is really useful. A few of my
thoughts but I need input from Amir and Jeff:

* In the last patch of the series you already implement decoding of
  pidfd file handles by adding a .fh_to_dentry export_operations method.

  There are a few things to consider because of how open_by_handle_at()
  works.

  - open_by_handle_at() needs to be restricted so it only creates pidfds
    from pidfs file handles that resolve to a struct pid that is
    reachable in the caller's pid namespace. In other words, it should
    mirror pidfd_open().

    Put another way, open_by_handle_at() must not be usable to open
    arbitrary pids to prevent a container from constructing a pidfd file
    handle for a process that lives outside it's pid namespace
    hierarchy.

    With this restriction in place open_by_handle_at() can be available
    to let unprivileged processes open pidfd file handles.

    Related to that, I don't think we need to make open_by_handle_at()
    open arbitrary pidfd file handles via CAP_DAC_READ_SEARCH. Simply
    because any process in the initial pid namespace can open any other
    process via pidfd_open() anyway because pid namespaces are
    hierarchical.

    IOW, CAP_DAC_READ_SEARCH must not override the restriction that the
    provided pidfs file handle must be reachable from the caller's pid
    namespace.

  - open_by_handle_at() uses may_decode_fh() to determine whether it's
    possible to decode a file handle as an unprivileged user. The
    current checks don't make sense for pidfs. Conceptually, I think
    there don't need to place any restrictions based on global
    CAP_DAC_READ_SEARCH, owning user namespace of the superblock or
    mount on pidfs file handles.

    The only restriction that matters is that the requested pidfs file
    handle is reachable from the caller's pid namespace.

  - A pidfd always has exactly a single inode and a single dentry.
    There's no aliases.

  - Generally, in my naive opinion, I think that decoding pidfs file
    handles should be a lot simpler than decoding regular path based
    file handles. Because there should be no need to verify any
    ancestors, or reconnect paths. Pidfs also doesn't have directory
    inodes, only regular inodes. In other words, any dentry is
    acceptable.

    Essentially, the only thing we need is for exportfs_decode_fh_raw()
    to verify that the provided pidfs file handle is resolvable in the
    caller's pid namespace. If so we're done. The challenge is how to
    nicely plumb this into the code without it sticking out like a sore
    thumb.

  - Pidfs should not be exportable via NFS. It doesn't make sense.

