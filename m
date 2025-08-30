Return-Path: <linux-fsdevel+bounces-59712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223DB3CF45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 22:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D9E2040AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD62DF707;
	Sat, 30 Aug 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d4E5YqAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1313D51E
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586527; cv=none; b=bwKvfU4V9e8M2SOKQV3/bXigeV4WOlqHY3aXrlmvN/ZTSrvlUnjlxVoEIy3at2hC28HV/4vQMt/vVckOggzm5YfOgaDLQZycxABLvfsrPqB1CkZHLeVnKvztLCpg+rnNLXfD3T0ypW9thLmwxdbn2kr6bBGbDgyfdfme6kaE+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586527; c=relaxed/simple;
	bh=dAt0ChP6vXWT/rtz27MMFPN1EWBgxijOIP3nu53R3Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRWAFAuKkJ6jP/6T9W16yDVzNfL0G/HHKyiDpqnG6o9+6FRybKNOBTcPYuayNBacb0Lk8vN67c7YiMwhYH91fN6MNyrIFyCr+5CQURQmfsFO5uKnNHg2s2SJgxqDx1HnUKglT1GnfcqKkbj8kj+KVp+E3wSFDHCBN9b58T/LwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d4E5YqAk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jcc/yV0ERUtpX1uLTEJgHV1q62sEOHiSHSVwBC+hWtM=; b=d4E5YqAk6buwzfjQVt66zOYARd
	WdY0E9m968fWaneaxI/0NyyWMadcBTkfP7q2wJDRyCz4YUwrHIT6abiuWv5p2J9V3hCorBTBy+E4C
	XspvLGaFe1k8lq1vPk2wqXmoRPHAl+uDE0TE5ueBBxffwtKyW66eYGrbL+llvlnnYB4I4mCKXx4fe
	ndI0w7k/OkWbTY9ONL9pkQBfKU0ODvw8j8dCPfYiUfrboDO5mNX5WjSxtSovJ0XD3AjN4B3d5ly5y
	ocrN84y9uyjm0RU3zbS3+T6HLX9bvMnOYxBDhRF0Wcchd8crkiSncaECz7UHKu/2NU1L8Upxp32aJ
	hxToeIaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usSOf-000000004xl-0qKD;
	Sat, 30 Aug 2025 20:42:01 +0000
Date: Sat, 30 Aug 2025 21:42:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Siddhesh Poyarekar <siddhesh@gotplt.org>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] does # really need to be escaped in devnames?
Message-ID: <20250830204201.GG39973@ZenIV>
References: <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
 <20250829163717.GD39973@ZenIV>
 <20250830043624.GE39973@ZenIV>
 <20250830073325.GF39973@ZenIV>
 <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 30, 2025 at 12:40:32PM -0700, Linus Torvalds wrote:
> On Sat, 30 Aug 2025 at 00:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > So...  Siddhesh, could you clarify the claim about breaking getmntent(3)?
> > Does it or does it not happen on every system that has readonly AFS
> > volumes mounted?
> 
> Hmm. Looking at various source trees using Debian code search, at
> least dietlibc doesn't treat '#' specially at all.
> 
> And glibc seems to treat only a line that *starts* with a '#'
> (possibly preceded by space/tab combinations) as an empty line.
> 
> klibc checks for '#' at the beginning of the file (without any
> potential space skipping before)
> 
> Busybox seems to do the same "skip whitespace, then skip lines
> starting with '#'" that glibc does.
> 
> So I think the '#'-escaping logic is wrong.  We should only escape '#'
> marks at the beginning of a line (since we already escape spaces and
> tabs, the "preceded by whitespace" doesn't matter).
> 
> And that means that we shouldn't do it in 'mangle()' at all - because
> it's irrelevant for any field but the first.
> 
> And the first field in /proc/mounts is that 'r->mnt_devname' (or
> show_devname), and again, that should only trigger on the first
> character, not every character.

*nod*

Amusingly enough, glibc addmntent(3) does *not* consider # for an
octal escape.

BTW, another amuzing bogosity:

	seq_escape(m, "blah", "X") => "blah"
	seq_escape(m, "blah", "b") => "\142lah"
	seq_escape(m, "blah", "") => "\142\154\141\150"

IOW, about 10 years ago an empty string switched meaning from "escape nothing"
to "escape everything"...

