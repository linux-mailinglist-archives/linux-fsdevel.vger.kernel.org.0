Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4743AFF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhJZK1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 06:27:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhJZK1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:27:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD5952195A;
        Tue, 26 Oct 2021 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635243887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+eIRKzH3SmEsZlFnQc8HV52kMGhR1HTYiW5mEjA988=;
        b=yEp0/YRULNKYJWtznx90xcD3YYi0wqCHvUDKBF4Qqb43L3/pD1KQ/crmld02JDcIwKfBT5
        J64DG06FSUvP5KGzW7Y7gtlpCT0UjtqGfMHIC2qihF5AebrULHSsDbq5e3mg3X9NU6aoy2
        EKDgej83W/WNEx/NILfiP6yrhqg3+pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635243887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+eIRKzH3SmEsZlFnQc8HV52kMGhR1HTYiW5mEjA988=;
        b=5K/mPP0PtdH0o9ZHWQyuZqR/cdoKpM1SSIulQHBheQ1sQZnzcLxT0sWZJijPF/z8iht8sn
        UFLNDURNDXxnVyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB85B13D43;
        Tue, 26 Oct 2021 10:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gynmKWzXd2GkEwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 10:24:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Uladzislau Rezki" <urezki@gmail.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <YXeraV5idipgWDB+@dhcp22.suse.cz>
References: <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>,
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>,
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>,
 <20211020192430.GA1861@pc638.lan>,
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>,
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>, <20211021104038.GA1932@pc638.lan>,
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>,
 <20211025094841.GA1945@pc638.lan>,
 <163520582122.16092.9250045450947778926@noble.neil.brown.name>,
 <YXeraV5idipgWDB+@dhcp22.suse.cz>
Date:   Tue, 26 Oct 2021 21:24:41 +1100
Message-id: <163524388152.8576.15706993879941541847@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> On Tue 26-10-21 10:50:21, Neil Brown wrote:
> > On Mon, 25 Oct 2021, Uladzislau Rezki wrote:
> > > On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
> > > > However I'm not 100% certain, and the behaviour might change in the
> > > > future.  So having one place (the definition of memalloc_retry_wait())
> > > > where we can change the sleeping behaviour if the alloc_page behavour
> > > > changes, would be ideal.  Maybe memalloc_retry_wait() could take a
> > > > gfpflags arg.
> > > > 
> > > At sleeping is required for __get_vm_area_node() because in case of lack
> > > of vmap space it will end up in tight loop without sleeping what is
> > > really bad.
> > > 
> > So vmalloc() has two failure modes.  alloc_page() failure and
> > __alloc_vmap_area() failure.  The caller cannot tell which...
> > 
> > Actually, they can.  If we pass __GFP_NOFAIL to vmalloc(), and it fails,
> > then it must have been __alloc_vmap_area() which failed.
> > What do we do in that case?
> > Can we add a waitq which gets a wakeup when __purge_vmap_area_lazy()
> > finishes?
> > If we use the spinlock from that waitq in place of free_vmap_area_lock,
> > then the wakeup would be nearly free if no-one was waiting, and worth
> > while if someone was waiting.
> 
> Is this really required to be part of the initial support?

No.... I was just thinking out-loud.

NeilBrown
