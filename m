Return-Path: <linux-fsdevel+bounces-13930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD226875915
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE49D1C22516
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1D413AA24;
	Thu,  7 Mar 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OR9spURO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3E13A89C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845820; cv=none; b=On7YUNkKzBuG0muNwaMEVCX+m3TUOiNRdk7Vwd8ZRUpY7c6D5H1GdlDESDN+Fjba2LTnYRXoGWO75s1RHAzvFUtQi0EKGb/45cMiVga9BtuX4+O3GUF89NsSU1XOfryF8r3JkpCySRztx2zGr4gnsAd1b8VQqc27lZ82BeKvqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845820; c=relaxed/simple;
	bh=BGA7lF5cXXmw4xUXa4YbHzQ38PdKonIw0r0ruSP0778=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyuit8F6ZKBbd/4Rv7I5LiA5Njq5ZyejYuIg0tVr/GTx98wlAYKMTlv/yisOo2vMEp25TcGgi0c+8JvCsdXTbzwQb7jLe/5fsK7NGehM2gKXG4KmquYeLlVw20VICRzcfIPfMbyx3akanOIJuEhehtloRGXMz181tFTb7qJt9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OR9spURO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8AC433C7;
	Thu,  7 Mar 2024 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709845819;
	bh=BGA7lF5cXXmw4xUXa4YbHzQ38PdKonIw0r0ruSP0778=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR9spURO9KHyUosWZCVfxvzl9GaP0Z5lRF5jw11ssaCyau2dGWixGk8TrzBXRInRt
	 yDNZJjI7ELpk3UWHpc0I4KvIhQwTVuXxpiujM/6Wn05B+0E2QiIThdrzxqx+QMWdgj
	 x2EHSUXfPh36dA4aubrWAPxPV5vITcZ+Q7AqLoww=
Date: Thu, 7 Mar 2024 21:10:17 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Bill O'Donnell <billodo@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
Message-ID: <2024030755-trapeze-yelling-7240@gregkh>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>

On Tue, Mar 05, 2024 at 05:08:39PM -0600, Eric Sandeen wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Convert the debugfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> [sandeen: forward port to modern kernel, fix remounting]
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  fs/debugfs/inode.c | 198 +++++++++++++++++++++------------------------
>  1 file changed, 93 insertions(+), 105 deletions(-)

If the vfs maintainers are ok with the conversion, it's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

