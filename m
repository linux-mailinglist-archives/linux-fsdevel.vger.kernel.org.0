Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6342543A879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhJYXwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 19:52:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49202 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhJYXwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:52:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42BA11F770;
        Mon, 25 Oct 2021 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635205827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJHXZbi24TJIP9vr7waWGzuy6gde4hlefZz+RK4iT4g=;
        b=QvziNNgB6DAnCN8N64t5ZaTCaLDfH+ssRBUsc6QxmtfQDUZGGC3xa1tol41sETg84sfl44
        cx40ZZl5Nc7Y8+rttb364KQ9Daj0ByLJr3pXf1AqHuCc6SZKn60I9XSMCN4UxVynFt8MIV
        Sqn2aLDtcDgVQf615shiu3KYIH4/hEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635205827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJHXZbi24TJIP9vr7waWGzuy6gde4hlefZz+RK4iT4g=;
        b=KakUYe7ecaoyJllSZbfMkAV414oqnxqvSRzgbHkdrUGlEo1FiAGtctnJUIICBmUb9m3KYx
        s/Q2ggYtv7lh2+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5944713CBD;
        Mon, 25 Oct 2021 23:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LrO2BcBCd2EbVQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Oct 2021 23:50:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Uladzislau Rezki" <urezki@gmail.com>
Cc:     "Michal Hocko" <mhocko@suse.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211025094841.GA1945@pc638.lan>
References: <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>,
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>,
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>,
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>,
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>,
 <20211020192430.GA1861@pc638.lan>,
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>,
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>, <20211021104038.GA1932@pc638.lan>,
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>,
 <20211025094841.GA1945@pc638.lan>
Date:   Tue, 26 Oct 2021 10:50:21 +1100
Message-id: <163520582122.16092.9250045450947778926@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Oct 2021, Uladzislau Rezki wrote:
> On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
> > However I'm not 100% certain, and the behaviour might change in the
> > future.  So having one place (the definition of memalloc_retry_wait())
> > where we can change the sleeping behaviour if the alloc_page behavour
> > changes, would be ideal.  Maybe memalloc_retry_wait() could take a
> > gfpflags arg.
> > 
> At sleeping is required for __get_vm_area_node() because in case of lack
> of vmap space it will end up in tight loop without sleeping what is
> really bad.
> 
So vmalloc() has two failure modes.  alloc_page() failure and
__alloc_vmap_area() failure.  The caller cannot tell which...

Actually, they can.  If we pass __GFP_NOFAIL to vmalloc(), and it fails,
then it must have been __alloc_vmap_area() which failed.
What do we do in that case?
Can we add a waitq which gets a wakeup when __purge_vmap_area_lazy()
finishes?
If we use the spinlock from that waitq in place of free_vmap_area_lock,
then the wakeup would be nearly free if no-one was waiting, and worth
while if someone was waiting.

Thanks,
NeilBrown
