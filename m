Return-Path: <linux-fsdevel+bounces-24970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC19475AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFA1F21735
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934C148FE3;
	Mon,  5 Aug 2024 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APKpYw24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE143C65;
	Mon,  5 Aug 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841411; cv=none; b=ULYnI2JxE8zZDYvktzZ6A7o1q8RsgtelNJs11rq7wqJXKClEOjiJZ0JXHI3iYS6cQfolrn0TLqWnrE7LKvL1pWL/q7MtvsXIh2kk2kCSsMj+j8HC1XjXd9cFeOyvl6fsZ7WiA6SmjwTV0Jdxa1Br8pGJepyygwbRiCwzE1N06R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841411; c=relaxed/simple;
	bh=em2dolYwo2yRhPj5MXAay46dNSGUTi8YztcvYCsfNb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCuSlnRK+Eu7meNPV/vYbj0pVbQ6kRLI5+qeSYsOS+9REtVSNABJl67N9y6Ebz7bjcWYVo0kTFXWVLXsP10dJ3Etqt86moLSj+RKa1PDc1cvZ4aidHPeGDwLpyMuCtHK9k9Vbv+YCAcjni1nlPIC1hU0OvCu77naz8nzLG1OZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APKpYw24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36860C32782;
	Mon,  5 Aug 2024 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722841410;
	bh=em2dolYwo2yRhPj5MXAay46dNSGUTi8YztcvYCsfNb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APKpYw24VYJUrc3UTPBTUXuXl8qDtLP0r9PP0rXvJMQIYZ1Wm/aVUkiPEKJ/teiyx
	 Ny55SO1VnSepmJXLmiEEq+qjFYf2RAo95jg/o742OLHz+xAVyNvpj8UwIdoMxyd3X+
	 QOcppOi8qoq3qp8XhVRpn8XsdHYrr5QLOgEtZfb/PYj7UL98tgfb2qen5B+aPmXgO8
	 7c3B83UNtDO5vZdrCs2UbjHo8ltHVoEtK8yzfzjOddBdYXOIs+8UbOjR2FtA6wdfoN
	 J58vpk0UXt+lr7wXPHfT9YmkAlc35WMUD8RxOq4l4ETqyU9OqxwnKjojUZnp8mIYJD
	 7LQs+aJsXhCvQ==
Date: Mon, 5 Aug 2024 09:03:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Lizhi Xu <lizhi.xu@windriver.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	squashfs-devel@lists.sourceforge.net, syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Message-ID: <20240805-abringen-kurzarbeit-6b8aea5e30b4@brauner>
References: <20240803040729.1677477-1-lizhi.xu@windriver.com>
 <20240803074349.3599957-1-lizhi.xu@windriver.com>
 <ee839d00-fd42-4b69-951d-8571140c077b@squashfs.org.uk>
 <20240804212034.GE5334@ZenIV>
 <023b6204-ad41-42e8-ad24-6d704ef3cd6c@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <023b6204-ad41-42e8-ad24-6d704ef3cd6c@squashfs.org.uk>

On Sun, Aug 04, 2024 at 11:31:51PM GMT, Phillip Lougher wrote:
> On 04/08/2024 22:20, Al Viro wrote:
> > On Sun, Aug 04, 2024 at 10:16:05PM +0100, Phillip Lougher wrote:
> > 
> > > NACK. I see no reason to introduce an intermediate variable here.
> > > 
> > > Please do what Al Viro suggested.
> > 
> > Alternatively, just check ->i_size after assignment.  loff_t is
> > always a 64bit signed; le32_to_cpu() returns 32bit unsigned.
> > Conversion from u32 to s64 is always going to yield a non-negative
> > result; comparison with PAGE_SIZE is all you need there.
> 
> I'm happy with that as well.

Fwiw, I think a good way to end this v7+ patch streak is to just tweak
the last version when applying.

