Return-Path: <linux-fsdevel+bounces-40708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84FA26F04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0DF3A1E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5A2080E1;
	Tue,  4 Feb 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBtgUd0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BC1547C5;
	Tue,  4 Feb 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663658; cv=none; b=QHf8NT5YRjchjbVzf76Me7ToXc5/U5BMgtOKpD8miXpVK3wX3Y94mfpybbxZD2fOEUB35t5Tj43q4MaRRl4DbP79uHG1HeA8xNydl7gYi9NsCfRJSd19czJDoX7O+lzH8vHL/KbUJ+tVjsPSlhEHLEa4Q2jvL/U+apeUU4aNkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663658; c=relaxed/simple;
	bh=X6YYsQzMBZlfPhE2lzhckYnWMCNyVdl8+F/ZdpE5GkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQCK2/uOX24PDhZmZNiH+9Xd+YIaCk8I3pzsw9GQ1iUS2UtLQpoNNZPL9lQ9PrKM50yY3QqDgepSj7kumyIVpBxNAKpZGS6l9u5y4zFzc9p2/Ju7sTzYegoCcCn8kVxUytgYVbwps7ICHJPbG8PyH477c9uDjE5qo1WvJvIYxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBtgUd0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0253EC4CEDF;
	Tue,  4 Feb 2025 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738663657;
	bh=X6YYsQzMBZlfPhE2lzhckYnWMCNyVdl8+F/ZdpE5GkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBtgUd0K4rexLyqU4eQnjG8JQ5Rl3gShCEN19Ms7NacPzu67XrKkcrwGYNPRoben9
	 BOhzWv21DKI+I8AVFgaxjBUY+PbBJAjK46efbe+TL4zBQP3U894oIFQSwaJg5xfQyj
	 Vneg3MOnUGyfjsburl4YsUwtOUc2iDdAtPzlzWK4A1Fmtymaol1zUhxvhozuKjBKj2
	 l+Krqa3yDpxTccWskcY4cVOGwki8tZ1OQzwgvklcqP5OjpQWp/Bk5Ue8aRCC2Ccw3M
	 Prhdpvvdmt0sEldEfu5hZJiBC4vzEmlfDpc3o+wPnSD+uVjQj8bGF+Sw5dSpXTVprR
	 8wDVnM/gumeDw==
Date: Tue, 4 Feb 2025 11:07:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Message-ID: <20250204-gepachtet-mehrmalig-debca5265df8@brauner>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
 <20250131-durften-weitblick-075d05e8f616@brauner>
 <CAHC9VhTSt-UoGOZvez8WPLxv4s6UQqJgDb5M4hWeTUeJY2oz3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTSt-UoGOZvez8WPLxv4s6UQqJgDb5M4hWeTUeJY2oz3w@mail.gmail.com>

On Fri, Jan 31, 2025 at 09:39:31AM -0500, Paul Moore wrote:
> On Fri, Jan 31, 2025 at 7:09 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Thu, Jan 30, 2025 at 04:05:53PM -0500, Paul Moore wrote:
> > >
> > > Now back to the merge into the VFS tree ... I was very surprised to
> > > open this patchset and see that Christian had merged v5 after less
> > > than 24 hours (at least according to the email timestamps that I see)
> > > and without an explicit ACK for the SELinux changes.  I've mentioned
> > > this to you before Christian, please do not merge any SELinux, LSM
> > > framework, or audit related patches without an explicit ACK.  I
> >
> > Things go into the tree for testing when the VFS side is ready for
> > testing. We're at v5 and the patchset has gone through four iterations
> > over multiple months. It will go into linux-next and fs-next now for as
> > much expsure as possible.
> >
> > I'm not sure what the confusion between merging things into a tree and
> > sending things upstream is. I have explained this to you before. The
> > application message is also pretty clear about that.
> 
> I'm not sure what the confusion is around my explicit request that you
> refrain from merging anything that touches the LSM framework, SELinux,
> or the audit subsystem without an explicit ACK.  I have explained this
> to you before.
> 
> For the record, your application/merge email makes no statement about
> only sending patches to Linus that have been ACK'd by all relevant
> parties.  The only statement I can see in your email that remotely
> relates to ACKs is this:
> 
>   "It's encouraged to provide Acked-bys and Reviewed-bys
>    even though the patch has now been applied. If possible
>    patch trailers will be updated."
> 
> ... which once again makes no claims about holding back changes that
> have not been properly ACK'd.

If seems you're having difficulties understanding that included patches
are subject to be updated from this content. You might want to remember
that this is similar for the various mm trees where this isn't even
mentioned. In other words this isn't a novel concept.

Anyway, VFS patch series will continue to appear in testing trees when
they are ready from the VFS side.

Going forward it might be best to add the required LSM integration via
the LSM subsystem.

