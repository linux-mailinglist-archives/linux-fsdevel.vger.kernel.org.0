Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467D743B007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhJZKdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 06:33:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJZKdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:33:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FF9E2195D;
        Tue, 26 Oct 2021 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635244258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDeyQBV9DEd0tXGdD1qku14+9u4jb7PKJUH26QFG8DU=;
        b=cIfY3dnXPMscVImWyijSTbuMwtr/YCMjZw0IyDyoG4QR3wYLXRq5JGSTJKBTs8ufoBoxcB
        LN0NXPQWvcRfRQ1hrwSmo6WhIySYM5H9L6KR6pfjBPqiB2u1rWKYJp0WIR/6bqrYqwjuE7
        nEmMDPZV2Nu2pRT7xGdDgJv297WGA70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635244258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDeyQBV9DEd0tXGdD1qku14+9u4jb7PKJUH26QFG8DU=;
        b=3lUTKYQ6NxuOyMBjALvs/LScH2rgJneMYKzuxLMCCut4B0rZkFlz+yckRlHbfgJ2+hNwzo
        YJNaMcVClDDJPmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A6AB13D43;
        Tue, 26 Oct 2021 10:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zbQ2Ft/Yd2GRFgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 10:30:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     linux-mm@kvack.org, "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <YXeoJbzICpNsEEBr@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>,
 <20211025150223.13621-3-mhocko@kernel.org>,
 <163520277623.16092.15759069160856953654@noble.neil.brown.name>,
 <YXeoJbzICpNsEEBr@dhcp22.suse.cz>
Date:   Tue, 26 Oct 2021 21:30:52 +1100
Message-id: <163524425265.8576.7853645770508739439@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> On Tue 26-10-21 09:59:36, Neil Brown wrote:
> > On Tue, 26 Oct 2021, Michal Hocko wrote:
> [...]
> > > @@ -3032,6 +3036,10 @@ void *__vmalloc_node_range(unsigned long size, u=
nsigned long align,
> > >  		warn_alloc(gfp_mask, NULL,
> > >  			"vmalloc error: size %lu, vm_struct allocation failed",
> > >  			real_size);
> > > +		if (gfp_mask & __GFP_NOFAIL) {
> > > +			schedule_timeout_uninterruptible(1);
> > > +			goto again;
> > > +		}
> >=20
> > Shouldn't the retry happen *before* the warning?
>=20
> I've done it after to catch the "depleted or fragmented" vmalloc space.
> This is not related to the memory available and therefore it won't be
> handled by the oom killer. The error message shouldn't imply the vmalloc
> allocation failure IMHO but I am open to suggestions.

The word "failed" does seem to imply what you don't want it to imply...

I guess it is reasonable to have this warning, but maybe add " -- retrying"
if __GFP_NOFAIL.

Thanks,
NeilBrown
