Return-Path: <linux-fsdevel+bounces-36750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610729E8DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1642813B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233421570C;
	Mon,  9 Dec 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kL9sinh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD93136357;
	Mon,  9 Dec 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733785; cv=none; b=LsUZMz/XiK6a9L3kFRVzXZCk7hXHUrHdDFZ69+Mt9ZK+XxaLQ30l/U+Jwwom0f/S/ccazN1ck8JNo2iT0SlqMIAc18u8sw6FtuWuMZtiPvKp3DfSgg9rutEbpZbaL6DvF5Q+UveJxqiHLbvyf+ATD0Sk6S6K4nYLj8tFHTdUT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733785; c=relaxed/simple;
	bh=4lBOq7HXuJ/WXxQxu/ueRPMfWtOxi6ulUevwugOb+JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLv9g7ZP8RKj5otYAY7oy7Jk5amWmlq0crEcwKQcPv5OZjCb5UzQxdBvQpH+PrKuFc70eZm16tfTqyYKPzG1JMGg/dXp3CyVnDfMhGQf2MgHwkNSctVks4Gee5x7GFex5c1SKdbgCSP0PKfyk2p1PCDCuCz+/FMkk+tk613lcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kL9sinh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D66C4CED1;
	Mon,  9 Dec 2024 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733733784;
	bh=4lBOq7HXuJ/WXxQxu/ueRPMfWtOxi6ulUevwugOb+JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL9sinh1v5KFCcuEM9FaFn9+o7zcl6/7u0CGxWX60Lf3V8ofbJQAo01UEN5cESo/i
	 qY6SgOOFQFOsiS8ohovW/AXdQ776UkzheQXgwdT7DD1EWzLcSekF71nfPOgK3lGk55
	 NjIjoXpOCjUz6Rk8h4Wqzs9tky18fXiVOEIQLBb4=
Date: Mon, 9 Dec 2024 09:43:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Additional miscdevice fops parameters
Message-ID: <2024120936-tarnish-chafe-bd25@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>

On Mon, Dec 09, 2024 at 07:27:45AM +0000, Alice Ryhl wrote:
> This could not land with the base miscdevice abstractions due to the
> dependency on File.

So these should go through my char/misc branch now, right?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

No need to sign off on patch 0/X :)

thanks,

greg k-h

