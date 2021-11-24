Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8754B45B288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhKXDUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:20:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbhKXDUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:20:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E32F2195A;
        Wed, 24 Nov 2021 03:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637723824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDPWm0p/mlhakN1e7xXVNW/moviPVK82GwF6kdGOEy0=;
        b=cZhmrdPKXdn+H/oudJqT/Oq1j2f75Hf43o5wUhZQpWL7W33LNbBHnGZbHFBb+ylJ35Ph4O
        mmln8qZQF1JySsR/L6TDKHGmwbOzU5szZ2iBYO/A+szLLJw7pVH8sEPMrAMklTRcjUJdFz
        WKQ0lxuSx/XGHpVIMVW4dwX1XtZzLRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637723824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDPWm0p/mlhakN1e7xXVNW/moviPVK82GwF6kdGOEy0=;
        b=YALzMeWScEmPJ5lOZdpgGHSa67p/G3HP9wdC2hxeW/q5VhiCJtnvkRSCDqv4PEBo6O+4qh
        lKCnrt1wMtZXy1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC5D913EB8;
        Wed, 24 Nov 2021 03:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z1hAJayunWGNRQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 24 Nov 2021 03:17:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki" <urezki@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
References: <20211122153233.9924-1-mhocko@kernel.org>,
 <20211122153233.9924-3-mhocko@kernel.org>, <YZ06nna7RirAI+vJ@pc638.lan>,
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
Date:   Wed, 24 Nov 2021 14:16:56 +1100
Message-id: <163772381628.1891.9102201563412921921@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Nov 2021, Andrew Morton wrote:
> 
> I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> sites were doing open-coded try-forever loops.  I thought "hey, they
> shouldn't be doing that in the first place, but let's at least
> centralize the concept to reduce code size, code duplication and so
> it's something we can now grep for".  But longer term, all GFP_NOFAIL
> sites should be reworked to no longer need to do the retry-forever
> thing.  In retrospect, this bright idea of mine seems to have added
> license for more sites to use retry-forever.  Sigh.

One of the costs of not having GFP_NOFAIL (or similar) is lots of
untested failure-path code.

When does an allocation that is allowed to retry and reclaim ever fail
anyway? I think the answer is "only when it has been killed by the oom
killer".  That of course cannot happen to kernel threads, so maybe
kernel threads should never need GFP_NOFAIL??

I'm not sure the above is 100%, but I do think that is the sort of
semantic that we want.  We want to know what kmalloc failure *means*.
We also need well defined and documented strategies to handle it.
mempools are one such strategy, but not always suitable.
preallocating can also be useful but can be clumsy to implement.  Maybe
we should support a process preallocating a bunch of pages which can
only be used by the process - and are auto-freed when the process
returns to user-space.  That might allow the "error paths" to be simple
and early, and subsequent allocations that were GFP_USEPREALLOC would be
safe.

i.e. we need a plan for how to rework all those no-fail call-sites.

NeilBrown
