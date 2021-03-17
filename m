Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0033F13C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 14:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCQNer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 09:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhCQNeb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CD6E64F0F;
        Wed, 17 Mar 2021 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615988070;
        bh=b1Wmu6NacmvzAaIQccj3wl847kOp6Ke4u2YxFVDmYtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4TALWD8gi5n3EBzdhCVsCCc/3Y5Hzm92L0QoGpPCmhfOO1Ua8ox+uxczXUEj0CTJ
         MZU1uVkcQ/TtSm4h/KBe32KyGiBB9uN1zGk8P6QAPv0j/cw14mVkqR7Y4jpq2w5yZF
         H+rL1e6Pryimu5zbD1Nvh+/To4rj7xDq1VwyNpMU=
Date:   Wed, 17 Mar 2021 14:34:27 +0100
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
Message-ID: <YFIFY7mj65sStba1@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> Btw. I still have problems with the approach. seq_file is intended to
> provide safe way to dump values to the userspace. Sacrificing
> performance just because of some abuser seems like a wrong way to go as
> Al pointed out earlier. Can we simply stop the abuse and disallow to
> manipulate the buffer directly? I do realize this might be more tricky
> for reasons mentioned in other emails but this is definitely worth
> doing.

We have to provide a buffer to "write into" somehow, so what is the best
way to stop "abuse" like this?

Right now, we do have helper functions, sysfs_emit(), that know to stop
the overflow of the buffer size, but porting the whole kernel to them is
going to take a bunch of churn, for almost no real benefit except a
potential random driver that might be doing bad things here that we have
not noticed yet.

Other than that, suggestions are welcome!

thanks,

greg k-h
