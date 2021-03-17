Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1933F457
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhCQPtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 11:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhCQPsn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2665664F79;
        Wed, 17 Mar 2021 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615995540;
        bh=dRMFBcsJPQLbRf+F2GnTT8HZD6K7smJG9tJcKpHlzZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0Pslo20SOFOFOQGgLFdw1xmTRR4RzT8vop+FZzT9vNbxyc/rAgf1TQVNQu36NzYB
         l0+hhrzC1MptmAlnbN8PSoFi47FzX2hlsMiADDGRDOOgwuUS6rNVwru4IkoQrRm2as
         zNSkF6Vv4gidWLNSHqIgMpXVuIgVWaHddYT6Q2F0=
Date:   Wed, 17 Mar 2021 16:38:57 +0100
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
Message-ID: <YFIikaNixD57o3pk@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
 <YFIYrMVTC42boZ/Z@kroah.com>
 <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:20:52PM +0100, Michal Hocko wrote:
> On Wed 17-03-21 15:56:44, Greg KH wrote:
> > On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> > > On Wed 17-03-21 14:34:27, Greg KH wrote:
> > > > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > > > Btw. I still have problems with the approach. seq_file is intended to
> > > > > provide safe way to dump values to the userspace. Sacrificing
> > > > > performance just because of some abuser seems like a wrong way to go as
> > > > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > > > manipulate the buffer directly? I do realize this might be more tricky
> > > > > for reasons mentioned in other emails but this is definitely worth
> > > > > doing.
> > > > 
> > > > We have to provide a buffer to "write into" somehow, so what is the best
> > > > way to stop "abuse" like this?
> > > 
> > > What is wrong about using seq_* interface directly?
> > 
> > Right now every show() callback of sysfs would have to be changed :(
> 
> Is this really the case? Would it be too ugly to have an intermediate
> buffer and then seq_puts it into the seq file inside sysfs_kf_seq_show.

Oh, good idea.

> Sure one copy more than necessary but it this shouldn't be a hot path or
> even visible on small strings. So that might be worth destroying an
> inherently dangerous seq API (seq_get_buf).

I'm all for that, let me see if I can carve out some time tomorrow to
try this out.

But, you don't get rid of the "ability" to have a driver write more than
a PAGE_SIZE into the buffer passed to it.  I guess I could be paranoid
and do some internal checks (allocate a bunch of memory and check for
overflow by hand), if this is something to really be concerned about...

thanks,

greg k-h
