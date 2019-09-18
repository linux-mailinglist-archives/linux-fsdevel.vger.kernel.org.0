Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF8B6728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfIRPcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 11:32:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfIRPcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:32:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1153B611BE; Wed, 18 Sep 2019 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568820771;
        bh=TNmAPCB7e2qEqf6X6jXwm3UGb2yqNQTB+ZXg9tdTpQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpcRnCZTCW6E4/7RqkverZwxbwC+kRsF1qSbrSw1RD+WyM+CbiBtNIOXl2/W5zXZF
         jmFKPyA79C0l+w6zXXmy4VzHZ9bpAPdsindefawaxQYadfzqWbUPAIfaOEcgBQemsK
         ihUXknr5Lw/NRp9zhrdnrciufcF6j4pMcYaQeA2g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11D456034D;
        Wed, 18 Sep 2019 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568820770;
        bh=TNmAPCB7e2qEqf6X6jXwm3UGb2yqNQTB+ZXg9tdTpQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EA/X6sJt/OwsZs68vHUGHAlVHrrFC1qbanywuabEu6rk/6VZRkIkegBN+AhImTk3z
         /Yl/GAiL6XrIQhn3wa9+BHtW39EGDE2MASsOjlzYtvQJLMhzmjXpbo74EY4rIUpPsl
         76sHfF/0JMocsmg6t9j8PrvYOfwA0AQ245+Pmt1c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11D456034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 18 Sep 2019 09:32:48 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: Prevent unintended underflow for the idr index
Message-ID: <20190918153248.GC25762@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1568756922-2829-1-git-send-email-jcrouse@codeaurora.org>
 <20190918115058.GB9880@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918115058.GB9880@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:50:58AM -0700, Matthew Wilcox wrote:
> On Tue, Sep 17, 2019 at 03:48:42PM -0600, Jordan Crouse wrote:
> > It is possible for unaware callers of several idr functions to accidentally
> > underflow the index by specifying a id that is less than the idr base.
> 
> Hi Jordan.  Thanks for the patch, but this seems like a distinction
> without a difference.
> 
> >  void *idr_remove(struct idr *idr, unsigned long id)
> >  {
> > +	if (id < idr->idr_base)
> > +		return NULL;
> > +
> >  	return radix_tree_delete_item(&idr->idr_rt, id - idr->idr_base, NULL);
> 
> If this underflows, we'll try to delete an index which doesn't exist,
> which will return NULL.
> 
> >  void *idr_find(const struct idr *idr, unsigned long id)
> >  {
> > +	if (id < idr->idr_base)
> > +		return NULL;
> > +
> >  	return radix_tree_lookup(&idr->idr_rt, id - idr->idr_base);
> 
> If this underflows, we'll look up an entry which doesn't exist, which
> will return NULL.
> 
> > @@ -302,6 +308,9 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
> >  	void __rcu **slot = NULL;
> >  	void *entry;
> >  
> > +	if (id < idr->idr_base)
> > +		return ERR_PTR(-ENOENT);
> > +
> >  	id -= idr->idr_base;
> >  
> >  	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);
> 
> ... just outside the context is this line:
>         if (!slot || radix_tree_tag_get(&idr->idr_rt, id, IDR_FREE))
>                 return ERR_PTR(-ENOENT);
> 
> Looking up an index which doesn't exist gets you a NULL slot, so you get
> -ENOENT anyway.
> 
> I did think about these possibilities when I was writing the code and
> convinced myself I didn't need them.  If you have an example of a case
> where I got thast wrong, I'd love to see it.
> 
> More generally, the IDR is deprecated; I'm trying to convert users to
> the XArray.  If you're adding a new user, can you use the XArray API
> instead?

Thanks for the explanation. I happened to walk by while code inspecting an
existing out-of-tree user and thought there might be a small hole to fill
but I agree it is unlikely that the underflow is likely to be a valid id.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
