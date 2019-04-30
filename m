Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0121AFD79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3QIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:08:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UeaqpmVaWKRnTEkoOf4sPrumE1te9gNrirP9M29Vlnk=; b=acL+HmzgOS/RDc0H5BSxtqC0q
        7gQfOtw3uFwOz6N46aQM0TJonu85B90GlYiN5pr5toMYK9O0bIpM3TbnAjek2YYsoWAEJLo7JHNzD
        /Bk5/W0kzHDvw2lJJYaYdpXr1rkmAzx1ML+IwNOdURsxa9KaGwGLPbqbzk1gfyLuFgmbZjVVHRrzI
        JFSZ9A5cC/Pkx5etFko/ldRUnoKF1tE/XvmTulOgc0Q5GOv+7OUaVKSk9FWF1CBoiwUWmzGiWg54O
        34sh7ewcz2tR6Ou6d8gYRSyCXASvJBBEAcJA+2uL6YBS+kx4d4+jdHihNPaJTxoD9AJ1zGMSAXBFZ
        AEyBiECcg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLVIj-0004M2-F5; Tue, 30 Apr 2019 16:08:13 +0000
Date:   Tue, 30 Apr 2019 09:08:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matteo Croce <mcroce@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
Message-ID: <20190430160813.GI13796@bombadil.infradead.org>
References: <20190429222613.13345-1-mcroce@redhat.com>
 <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
 <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 08:42:42AM -0700, Kees Cook wrote:
> On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
> > On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > Add a const int array containing the most commonly used values,
> > > some macros to refer more easily to the correct array member,
> > > and use them instead of creating a local one for every object file.
> > >
> >
> > Ok it seems that this simply can't be done, because there are at least
> > two points where extra1,2 are set to a non const struct:
> > in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> > while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> > and a struct net.
> 
> Why can't these be converted to const also? I don't see the pointer
> changing anywhere. They're created in one place and never changed.

That's not true; I thought the same thing, but you need to see how
they're used in the functions they're called.

proc_do_defense_mode(struct ctl_table *table, int write,
        struct netns_ipvs *ipvs = table->extra2;
                        update_defense_level(ipvs);
static void update_defense_level(struct netns_ipvs *ipvs)
        spin_lock(&ipvs->dropentry_lock);
