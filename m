Return-Path: <linux-fsdevel+bounces-30268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4E988AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F712837FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813431C2445;
	Fri, 27 Sep 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tf9nekx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469D1C2423;
	Fri, 27 Sep 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465899; cv=none; b=Xogfm9LVjFIm77r9wnCaPYKbIVZ63ySXX1dWzDxqVNl85EoC7WZfs6wnI9z05onE5nf737bu85gNLOvKQ5P9rB7y63yNUiwVN7OZtP9/opXdxEtTbUjFOihwbWOPqKDoGNSEsPfegopskTxK7RzLxZrhZ6oO797XUIB17irh6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465899; c=relaxed/simple;
	bh=CxQBOMsATly929QQSMQ/jP51+X4IBzG9suHWt186Pdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTZ1jYJATqxk7pie4L1dk3rF/bjUNB12hKVfQC9KquOSpTNovsvRxxAIibS07JjUlhMnABrQVUdA8tK9G7bCLLjdfwKn8o5zi8NqixLy+7shi2efHmZYdyd+shFd8bxvMbo3xQbAiIgArF45d+Hu55tcdv0fudmBfFhVIcfWHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tf9nekx0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NXSCHIRP+95oD988ODIFXfHC/wOJhCYIutUrPYPipXM=; b=tf9nekx02vfwZyhH3wzXalGviV
	kjIZNSNqdCDEkCXsnjP0uSNXUJysMgmta+wTyvrip5va/5/UOBfmZQCUCxJpGrBKNv+dtoH3M6P+6
	kH1+sKT1ZvODlxoSHSgxujBWxi5Ez2wf1/B8ZZIfni5lVQpf2tbGRxniADjo4YoEInD2QQ1C7p0hv
	wc4lxU/U7C9wih75+exLEWu3fDwMZokClccmU683lE8oNZjlIBSi0UsdznwXFK8nSUK76j20FjK5H
	oT3bZOIDBTE2yDTqLZPwF1KpqNksK72kfTB57sqpeImo79wney1JdkYZ1UdO5djXFA+NnL3FBO649
	3WMN2YIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1suGn3-0000000G3O9-2vXk;
	Fri, 27 Sep 2024 19:38:09 +0000
Date: Fri, 27 Sep 2024 20:38:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
Message-ID: <20240927193809.GV3550746@ZenIV>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
 <20240926220821.GP3550746@ZenIV>
 <20240926224733.GQ3550746@ZenIV>
 <CAH5fLgick=nmDFd1w5zLSw9tVXMe-u2vk3sBbG-HZsPEUtYLVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgick=nmDFd1w5zLSw9tVXMe-u2vk3sBbG-HZsPEUtYLVw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 27, 2024 at 08:56:50AM +0200, Alice Ryhl wrote:

> Okay, interesting. I did not know about all of these llseek helpers.
> I'm definitely happy to make the Rust API force users to do the right
> thing if we can.
> 
> It sounds like we basically have a few different seeking behaviors
> that the driver can choose between, and we want to force the user to
> use one of them?

Depends...  Basically, SEEK_HOLE/SEEK_DATA is seriously fs-specific
(unsurprisingly), and pretty much everything wants the usual relation
between SEEK_SET and SEEK_CUR (<SEEK_CUR,n> is the same as <SEEK_SET,
current position + n>).  SEEK_END availability varies - the simplest
variant is <SEEK_END, n> == <SEEK_SET, size + n>, but there are
cases that genuinely have nothing resembling end-relative seek
(e.g. anything seq_file-related).

It's not so much available instances as available helpers; details of
semantics may seriously vary by the driver.

Note that once upon a time ->f_pos had been exposed to ->read() et.al.;
caused recurring bugs, until we switched to "sample ->f_pos before calling
->read(), pass the reference to local copy into the method, then put
what's the method left behind in there back into ->f_pos".

Something similar might be a good idea for ->llseek().  Locking is
an unpleasant problem, unfortunately.  lseek() is not a terribly hot
codepath, but read() and write() are.  For a while we used to do exclusion
on per-struct file basis for _all_ read/write/lseek; see 797964253d35
"file: reinstate f_pos locking optimization for regular files" for the
point where it eroded.

FWIW, I suspect that unconditionally taking ->f_pos_mutex for llseek(2)
would solve most of the problems - for one thing, with guaranteed
per-struct-file serialization of vfs_llseek() we could handle SEEK_CUR
right there, so that ->llseek() instances would never see it; for another,
we just might be able to pull the same 'pass a reference to local variable
and let it be handled there' trick for ->llseek().  That would require
an audit of locking in the instances, though...

