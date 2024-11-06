Return-Path: <linux-fsdevel+bounces-33724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C89BE125
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3142837E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6401D88B1;
	Wed,  6 Nov 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJjN9v3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CE1D5171;
	Wed,  6 Nov 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882175; cv=none; b=Ig+NP6l3LYfXQsa2tLzN7R0Ykfx7t92dZvOrGlRn5tOay1NdmXy+oE0G0tK0FBEmIFpS8YwTC0g6zmAJR8nUWrQwFnKdc8s1bdR4KuGqbI/7p/GYTaoflSiM8v3rWmHYVDjtKVERmEVBsiDGuw2o/fsl+B0AscSGY9Sr397l5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882175; c=relaxed/simple;
	bh=4lWAHklcm14vPuh3Q9+OKVUs+RH3n6zDXgavv2ivdck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLqZcNDwj24j+ShPikTt6IIuggZ2D9E/V1knBEek4uW7VaYPIubyg6C59a3qGGiSm2bA79FDaM0C8RH37emua1EbDLwf7svER5qHLZPxoxSmBkKczuIENQDutuja5ohIEifa3v4YhGEyniSH6aav0u0zJ/vcqm8iuWgVH/4E5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJjN9v3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199BAC4CED0;
	Wed,  6 Nov 2024 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730882173;
	bh=4lWAHklcm14vPuh3Q9+OKVUs+RH3n6zDXgavv2ivdck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJjN9v3rVc4ENn4RYJBUjgoOCXtqvP850TvOAoB/SzkW0mEHaOLMWsCkHdLYOf24P
	 pSrTGIk7WnEXDrwJ7CY7Uv8hHLkJnBE48ChZedL0PFecpO/c4unHGTkp8vIzZ7Kf2D
	 0ca7KP3jMz9jfC7g4DUjNTsONxlfLvHvilgWAvQk=
Date: Wed, 6 Nov 2024 09:35:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Ebner <c.ebner@proxmox.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, stable@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before
 netfs_clear_unread() tail clean
Message-ID: <2024110625-blot-uncooked-48f9@gregkh>
References: <20241027114315.730407-1-c.ebner@proxmox.com>
 <2024110644-audible-canine-30ca@gregkh>
 <7e364258-e643-4656-9233-f89f1c4b1a66@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e364258-e643-4656-9233-f89f1c4b1a66@proxmox.com>

On Wed, Nov 06, 2024 at 09:26:46AM +0100, Christian Ebner wrote:
> On 11/6/24 06:59, Greg KH wrote:
> > We would much rather take the original series of commits, what exactly
> > are they here?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hello Greg,
> thank you for your reply.
> 
> AFAIK the relevant patches for this series are commits 80887f31..ee4cdf7b,
> although the last patch containing the fix does not apply cleanly on the
> current 6.11.y branch.
> 
> Please note, I am not very familiar with the code so unsure if all of the
> patches in the series are required for the fix. Maybe David Howells as
> author of the series can provide some more insights?
> 
> The patch series introducing the fix is
> https://lore.kernel.org/all/20240814203850.2240469-1-dhowells@redhat.com/
> 
> Please let me know how to proceed, thanks!

Please try testing the original fixes and providing them as a patch
series and send them for us to review.

thanks,

greg k-h

