Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C4333F4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhCQPyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 11:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232185AbhCQPxm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:53:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAAD264F6E;
        Wed, 17 Mar 2021 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615993007;
        bh=gDQD75TMDCBqwGcS8/6DWiM6ZUznIP9nwwkyyF+j8Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOygU8AGnawuGblKbYnL84HONQ4oOWp27ZbL+v/iwlI+fVmNe/sneHFNCpdp02Vt7
         yNkau1/uydbSwxRVEj950IpuMoX6LPbdLK+sgqHolhjCUEwIONczarsdFyimlllvQr
         ZLKe0Olm2ALbYRhoaL4WN++JvYdgGlofrUvwI88U=
Date:   Wed, 17 Mar 2021 15:56:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFIYrMVTC42boZ/Z@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> On Wed 17-03-21 14:34:27, Greg KH wrote:
> > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > Btw. I still have problems with the approach. seq_file is intended to
> > > provide safe way to dump values to the userspace. Sacrificing
> > > performance just because of some abuser seems like a wrong way to go as
> > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > manipulate the buffer directly? I do realize this might be more tricky
> > > for reasons mentioned in other emails but this is definitely worth
> > > doing.
> > 
> > We have to provide a buffer to "write into" somehow, so what is the best
> > way to stop "abuse" like this?
> 
> What is wrong about using seq_* interface directly?

Right now every show() callback of sysfs would have to be changed :(

> > Right now, we do have helper functions, sysfs_emit(), that know to stop
> > the overflow of the buffer size, but porting the whole kernel to them is
> > going to take a bunch of churn, for almost no real benefit except a
> > potential random driver that might be doing bad things here that we have
> > not noticed yet.
> 
> I am not familiar with sysfs, I just got lost in all the indirection but
> replacing buffer by the seq_file and operate on that should be possible,
> no?

sysfs files should be very simple and easy, and have a single value
being written to userspace.  I guess seq_printf() does handle the issue
of "big buffers", but there should not be a big buffer here to worry
about in the first place (yes, there was a bug where a driver took
unchecked data and sent it to userspace overflowing the buffer which
started this whole thread...)

I guess Kees wants to change all show functions to use the seq_ api,
which now makes a bit more sense, but still seems like a huge overkill.
But I now understand the idea here, the buffer management is handled by
the core kernel and overflows are impossible.

A "simpler" fix is to keep the api the same today, and just "force"
everyone to use sysfs_emit() which does the length checking
automatically.

I don't know, it all depends on how much effort we want to put into the
"drivers can not do stupid things because we prevent them from it"
type of work here...

thanks,

greg k-h
