Return-Path: <linux-fsdevel+bounces-34144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE09C30ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D781C20A9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 05:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20614A092;
	Sun, 10 Nov 2024 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3Iom15d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B54323D;
	Sun, 10 Nov 2024 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731215351; cv=none; b=r9fHOWUe/PM88QhEYGgkZwAuVKkln1QEwPrgZSP7uDcVv4z4cEs1QOgepBDbOUG5w7P4S37kPZxv7lStLmU/2/rP9vZ9TPhT1oy8MHqH0ofXqCTwrbC2vFdepQ4Gf87a9aC0wNn0gujVZYTx7cknWsMw5EZhQVt6Yoqm/sbZIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731215351; c=relaxed/simple;
	bh=k5u10GCFt8NE83qY1EHHB7fYCBerlFuScuCvt7K9X30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKkor/hqjwHiLgDls+rtTETlRVkAUPYQu8Yu+fOirVfs3t/CqFkqVhdFC7foy49+uTiZIddpxzsgzlkam3MfdwPuj6D2KxrdZcxrGwJPF6vHuh3BTl9BrcipfKbvo10hM9qYCQ7rd9Ybj75RCy3anqq+o14Y31pay2zuS5cQX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3Iom15d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF42C4CECD;
	Sun, 10 Nov 2024 05:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731215350;
	bh=k5u10GCFt8NE83qY1EHHB7fYCBerlFuScuCvt7K9X30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3Iom15dejENVld0ztiul6iV0n17uTEtJPWr/Xvv0gIO42bsJT0H/+KbF4Z8Mpwsw
	 uYwUcj0LM+oc3i02Yk7Hb/QVQrKWyo6inr5yX/ZhOUZ1+YlnDM0y6b+SX5t9xHyiZo
	 xdif+pwP9Uo3emzAW4C1duv40gpYWY7bm3u7SO5g=
Date: Sun, 10 Nov 2024 06:08:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Ebner <c.ebner@proxmox.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, stable@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before
 netfs_clear_unread() tail clean
Message-ID: <2024111053-expectant-moodiness-6118@gregkh>
References: <20241027114315.730407-1-c.ebner@proxmox.com>
 <2024110644-audible-canine-30ca@gregkh>
 <7e364258-e643-4656-9233-f89f1c4b1a66@proxmox.com>
 <2024110625-blot-uncooked-48f9@gregkh>
 <fac697e2-22aa-40e5-942a-a6e40efee0b2@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac697e2-22aa-40e5-942a-a6e40efee0b2@proxmox.com>

On Thu, Nov 07, 2024 at 12:51:14PM +0100, Christian Ebner wrote:
> On 11/6/24 09:35, Greg KH wrote:
> > On Wed, Nov 06, 2024 at 09:26:46AM +0100, Christian Ebner wrote:
> > 
> > Please try testing the original fixes and providing them as a patch
> > series and send them for us to review.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> as mentioned, the original series does not apply on stable-6.11.y and
> securely and correctly back-porting this is out of scope for us, given
> resource and time constraints.

Please note that taking one-off backports to stable trees, increases our
workload over time and almost always is not the correct thing to do as
it diverges code streams.  So while this seems simpler "up front", from
a maintaince point of view, is almost always the wrong thing.

> The main intend was to contribute back a patch which is also back-portable
> to older kernels. This seems unfeasible with the huge original patch series.
> The submitted patch has successfully been tested on our side and fixes the
> issue for affected customers which were willing to test the patch.

That's great, but we really would want the original commits here, OR
approval from the relevant maintainers that "yes, this is really the
only way this can be done for stable trees".

thanks,

greg k-h

