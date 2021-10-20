Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AD4351ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJTRve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhJTRvZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:51:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 083B46128B;
        Wed, 20 Oct 2021 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634752150;
        bh=UY7whghJ0CF+27cck+zPo8YHzcjinvyXjF/op8BsEto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzW4GeyNS55sRWhnvPUiGcJuCKOtmL1+3Fs7GwIUyKZ1XEBZMiEtemmrwggcZrq1F
         o64alCGTeqAnnRBz2y3Emp++LUAf4k3xdQ/7i45jbng+qaCjnOCyCy+rwG4Nmnb3Pl
         fu3moUeh15d70HbM/1u/ab3BLII+F+Bkx4SnFx4g=
Date:   Wed, 20 Oct 2021 19:49:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
Message-ID: <YXBWk8Zzi7yIyTi/@kroah.com>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
 <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:35:27AM -0600, Jens Axboe wrote:
> On 10/20/21 11:30 AM, Christoph Hellwig wrote:
> > On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:
> >> It's not used for anything, and we're wasting time passing in zeroes
> >> where we could just ignore it instead. Update all ki_complete users in
> >> the kernel to drop that last argument.
> >>
> >> The exception is the USB gadget code, which passes in non-zero. But
> >> since nobody every looks at ret2, it's still pointless.
> > 
> > Yes, the USB gadget passes non-zero, and aio passes that on to
> > userspace.  So this is an ABI change.  Does it actually matter?
> > I don't know, but you could CC the relevant maintainers and list
> > to try to figure that out.
> 
> True, guess it does go out to userspace. Greg, is anyone using
> it on the userspace side?

I really do not know (adding linux-usb@vger)  My interactions with the
gadget code have not been through the aio api, thankfully :)

Odds are it's fine, I think that something had to be passed in there so
that was chosen?  If the aio code didn't do anything with it, I can't
see where the gadget code gets it back at anywhere, but I might be
looking in the wrong place.

Anyone else here know?

thanks,

greg k-h
