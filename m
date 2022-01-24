Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2D49AA99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 05:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3408501AbiAYDmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 22:42:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34370 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446100AbiAXVGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:06:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C9592113D;
        Mon, 24 Jan 2022 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643058400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfraP3cKwJmMtP30lWjzLJdmL2hZ6cElHw/0YTj4oOo=;
        b=rWqZLIv+3v+DLIDwvdk769j49PdKC25yGeqwLnjD1sku+u/0SNsawU7aCTTMpGDkVe6gy/
        mauke740eLAPvJItfmYrWhCyIk9kr1NAee4djfRqfBn0GD9qwctrECPdrOcR/1SU3lsYPe
        rZdi7OjifrRWQ5kKxCtBwC+HKQ/Ti2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643058400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfraP3cKwJmMtP30lWjzLJdmL2hZ6cElHw/0YTj4oOo=;
        b=3mIQCl6QzPrG05KFYhh1ArbsGq0Z+7Q1c5dEwvVO/ZhJfiJjp48e8/xZfHg5e4RWBUu+60
        5UWCRwOdQTfnM4Bw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F3541A3B85;
        Mon, 24 Jan 2022 21:06:39 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AD513A05D7; Mon, 24 Jan 2022 22:06:36 +0100 (CET)
Date:   Mon, 24 Jan 2022 22:06:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Message-ID: <20220124210636.7nfx2qcsc66jvuki@quack3.lan>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
 <cde9acbb-ba1f-16ba-40a8-a5b4fdf2d2dc@nvidia.com>
 <20220124121903.fono7exjgqi22ify@quack3.lan>
 <bdc63efb-5f5f-73ee-5785-ea28c576c52a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc63efb-5f5f-73ee-5785-ea28c576c52a@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-01-22 11:34:25, John Hubbard wrote:
> On 1/24/22 04:19, Jan Kara wrote:
> > > address for each ZERO_PAGE() (unless I'm totally wrong here) and
> > > using this check you can distinguish between ZERO_PAGE() and
> > > non ZERO_PAGE() on the bio list in bio_release_pages().
> > 
> > Well, that is another option but it seems a bit ugly and also on some
> > architectures (e.g. s390 AFAICS) there can be multiple zero pages (due to
> > coloring) so the test for zero page is not completely trivial (probably we
> > would have to grow some is_zero_page() checking function implemented
> > separately for each arch).
> 
> Good point. And adding an is_zero_page() function would also make some
> of these invocations correct across all architectures:
> 
>     is_zero_pfn(page_to_pfn(page))
> 
> ...so it would also be a fix or at least an upgrade.

As I'm checking the is_zero_pfn() implementation, it should be working as it
should for all architectures. I just forgot we already have a function for
this.

> I had also wondered why there is no is_zero_page() wrapper function for
> the above invocation. Maybe because there are only four call sites and
> no one saw it as worthwhile yet.

Yeah, perhaps.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
