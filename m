Return-Path: <linux-fsdevel+bounces-36651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDB9E7515
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38721885257
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD220D502;
	Fri,  6 Dec 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVf+mGRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC420ADF4;
	Fri,  6 Dec 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501039; cv=none; b=tnew1L7Xw3ppet6DavPlCMeGfaHE/ilESuNMmdR+1Qpf5XEtOYD2izqFc7e4tjjT6rdEvelXsAXpLGSw7gThwWLgxEgCfqTmDCIeMwgW0DHMp9wkizfwKI36oU3ZWtmXU1gT9u2S5oAkAkHXwwg3FtcVynL0A+jWLCqlDYnKW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501039; c=relaxed/simple;
	bh=UG2UKElcjm9d3HsCT8yEW/31IE10z+gYKQlOtpvIGHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEX2daJQWCJGl9noctPz0ecWF88kOYkv6rLOVmC6rjpJ9sc9zkWTNRIq7Bdiio73VaA5KfqTHTH0bnC6t8fNqcPRZ8CeT5v/sbF3KRHTgkJ8jpVvABjoo8Vk2b6Lw9Zj5EAq0+eFj3cqLbxDFbX3/pfou4rZv4eAO5yAEq8AKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVf+mGRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83BCC4CED1;
	Fri,  6 Dec 2024 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501039;
	bh=UG2UKElcjm9d3HsCT8yEW/31IE10z+gYKQlOtpvIGHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVf+mGRhk3GhVwFN597wpKit79+IO2l3x00MCPrE0H4dYaKvjMUan2DLZL1WecmSS
	 COwF3F6wstBEwX5EDLro21MLuiMTAEIZ/ZCqxEECZJ8Y3z6kDkLvN/P2utxFrK7Cbs
	 sZiqV619rhglwId2Li9iXuG8VBbLLiZoOZ8pc6ICMTqEeVR8JEGgvOsiUXJZB+jdsr
	 qTaQlbPQPwiXUfcqqj9dqKhTXOgrr9vybsWt4wmIKXdhzYWULri3Tc/rD7S//FwPs1
	 CCbMjksnYN7G61R1nljRQ8DxBEr3jgkW0Z7BGtkWi4yOsFl1hNeHK/Dhul5FE0tnUo
	 SvhdA5y9zPqlw==
Date: Fri, 6 Dec 2024 08:03:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <20241206160358.GC7820@frogsfrogsfrogs>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>

On Thu, Dec 05, 2024 at 12:57:28PM +0100, Amir Goldstein wrote:
> On Thu, Dec 5, 2024 at 1:38 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Dec 01, 2024 at 02:12:24PM +0100, Christian Brauner wrote:
> > > Hey,
> > >
> > > Some filesystems like kernfs and pidfs support file handles as a
> > > convenience to enable the use of name_to_handle_at(2) and
> > > open_by_handle_at(2) but don't want to and cannot be reliably exported.
> > > Add a flag that allows them to mark their export operations accordingly
> > > and make NFS check for its presence.
> > >
> > > @Amir, I'll reorder the patches such that this series comes prior to the
> > > pidfs file handle series. Doing it that way will mean that there's never
> > > a state where pidfs supports file handles while also being exportable.
> > > It's probably not a big deal but it's definitely cleaner. It also means
> > > the last patch in this series to mark pidfs as non-exportable can be
> > > dropped. Instead pidfs export operations will be marked as
> > > non-exportable in the patch that they are added in.
> >
> > Can you please invert the polarity?  Marking something as not supporting
> > is always awkward.  Clearly marking it as supporting something (and
> > writing down in detail what is required for that) is much better, even
> > it might cause a little more churn initially.
> >
> 
> Churn would be a bit annoying, but I guess it makes sense.
> I agree with Christian that it should be done as cleanup to allow for
> easier backport.
> 
> Please suggest a name for this opt-in flag.
> EXPORT_OP_NFS_EXPORT???

That's probably too specific to NFS--

AFAICT the goal here is to prevent exporting {pid,kern}fs file handles
to other nodes, correct?  Because we don't want to allow a process on
another computer to mess around with processes on the local computer?

How about:

/* file handles can be used by a process on another node */
#define EXPORT_OP_ALLOW_REMOTE_NODES	(...)

--D

> Thanks,
> Amir.
> 

