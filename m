Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56733F002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhCQMI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 08:08:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhCQMIY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615982903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzSShNBc+a8YeE9Atm1rFDpCfXSt5KJELlWzCgJ3hd8=;
        b=GAAR2fNv7ycSCNW1tT0QHZbrZLE2FXxmr44WsCufiP+c3d5rB0ODeb0DBCIgJ3m8GNK7Vo
        bKs4zX6qm8UjHUASqpC1g1dULhYe1dRCoLhu96z1xXCESHBTCN1QzaJ2sso2O+1xsqB63k
        ymNyrupM0xSCu+tnr2lhk9xuqvB1MAU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62407AC24;
        Wed, 17 Mar 2021 12:08:23 +0000 (UTC)
Date:   Wed, 17 Mar 2021 13:08:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103161205.B2181BDE38@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-03-21 12:08:02, Kees Cook wrote:
> On Tue, Mar 16, 2021 at 09:31:23AM +0100, Michal Hocko wrote:
[...]
> > Also this cannot really be done for configurations with a very limited
> > vmalloc space (32b for example). Those systems are more and more rare
> > but you shouldn't really allow userspace to deplete the vmalloc space.
>
> This sounds like two objections:
> - 32b has a small vmalloc space
> - userspace shouldn't allow depletion of vmalloc space
>
> I'd be happy to make this 64b only. For the latter, I would imagine
> there are other vmalloc-exposed-to-userspace cases, but yes, this would
> be much more direct. Is that a problem in practice?

vmalloc space shouldn't be a problem for 64b systems but I am not sure
how does vmalloc scale with many small allocations. There were some
changes by Uladzislau who might give us more insight (CCed).

> > I would be also curious to see how vmalloc scales with huge number of
> > single page allocations which would be easy to trigger with this patch.
>
> Right -- what the best way to measure this (and what would be "too
> much")?

Proc is used quite heavily for all sorts of monitoring so I would be
worried about a noticeable slow down.

Btw. I still have problems with the approach. seq_file is intended to
provide safe way to dump values to the userspace. Sacrificing
performance just because of some abuser seems like a wrong way to go as
Al pointed out earlier. Can we simply stop the abuse and disallow to
manipulate the buffer directly? I do realize this might be more tricky
for reasons mentioned in other emails but this is definitely worth
doing.

-- 
Michal Hocko
SUSE Labs
