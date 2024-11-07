Return-Path: <linux-fsdevel+bounces-33900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFD9C04E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159672860E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688820EA57;
	Thu,  7 Nov 2024 11:51:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B720B1E7;
	Thu,  7 Nov 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980285; cv=none; b=ZhR3uRgNVCBq4V8XQamP1VwSz2jg9D6UzZGv83YNwIvAUfskjrJHhBCDx5f2TCcYRJVWViNxHOYepCz+/VggbFqGDvoEdONPL4HVYOkWG4IjMOTJduphkmW297xvkFcIrCjRoUDd4tj+/OLIRCZd9MjZVVLj5Cuei2v0kQV4EtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980285; c=relaxed/simple;
	bh=0AtubCeFukFj7oJ5lpiZaEPaElzTFMpovpQKmNfwuE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyOFgO5tmaAJ8NVz7d4bPUK9LatxXeY4nP4wsoxhj9pSgGkcZe8VBt+q1zb/3kWMpzJ1/BJGvUK1ypiljpkvLjhwqDP91lCK8LjY3TrKlm8BEc0stU7Z6I6rrBQq1W+Jt5UNJ7M0uj8J1HDp0MwYwBmuHBCEZZEL52YyUYUg5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 681D248F39;
	Thu,  7 Nov 2024 12:51:15 +0100 (CET)
Message-ID: <fac697e2-22aa-40e5-942a-a6e40efee0b2@proxmox.com>
Date: Thu, 7 Nov 2024 12:51:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before
 netfs_clear_unread() tail clean
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, stable@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241027114315.730407-1-c.ebner@proxmox.com>
 <2024110644-audible-canine-30ca@gregkh>
 <7e364258-e643-4656-9233-f89f1c4b1a66@proxmox.com>
 <2024110625-blot-uncooked-48f9@gregkh>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <2024110625-blot-uncooked-48f9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 09:35, Greg KH wrote:
> On Wed, Nov 06, 2024 at 09:26:46AM +0100, Christian Ebner wrote:
> 
> Please try testing the original fixes and providing them as a patch
> series and send them for us to review.
> 
> thanks,
> 
> greg k-h

Hi Greg,

as mentioned, the original series does not apply on stable-6.11.y and 
securely and correctly back-porting this is out of scope for us, given 
resource and time constraints.

The main intend was to contribute back a patch which is also 
back-portable to older kernels. This seems unfeasible with the huge 
original patch series. The submitted patch has successfully been tested 
on our side and fixes the issue for affected customers which were 
willing to test the patch.

Thanks for your time.

Best regards,
Christian Ebner






