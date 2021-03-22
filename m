Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416BE343C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVIvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:51:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36793 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVIvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:51:06 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOGH1-0003vE-GR; Mon, 22 Mar 2021 08:50:55 +0000
Date:   Mon, 22 Mar 2021 09:50:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fs: document mapping helpers
Message-ID: <20210322085054.dicpuv2oub3lyzaf@wittgenstein>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com>
 <20210320122623.599086-2-christian.brauner@ubuntu.com>
 <20210322073546.GH1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322073546.GH1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:35:46AM +0000, Matthew Wilcox wrote:
> On Sat, Mar 20, 2021 at 01:26:21PM +0100, Christian Brauner wrote:
> > +/**
> > + * kuid_into_mnt - map a kuid down into a mnt_userns
> > + * @mnt_userns: user namespace of the relevant mount
> > + * @kuid: kuid to be mapped
> > + *
> > + * Return @kuid mapped according to @mnt_userns.
> > + * If @kuid has no mapping INVALID_UID is returned.
> > + */
> 
> If you could just put the ':' after 'Return', htmldoc would put this into
> a nice section for you.

I'll fix that up in my tree. Thanks!

> 
> I also like to include a Context: section which lists whether the
> function takes locks / requires locks to be held / can be called in
> hard or soft interrupt context / may sleep / requires refcounts be held /
> ...  Generally, what do you expect from your callers, and what your callers
> can expect from you.

Thanks for the hint about "Context:". The functions don't take any
locks, they don't require locks to be held and they don't sleep and
don't manipulate refcounts (The lifetime of @mnt_userns is tied to the
respective mnt it's from. It can't be altered anymore once a non-initial
@mnt_userns has been attached to the mnt so it can't go away behind the
caller's back.). Internally only smp_rmb and smp_wmb are used and so
they should be fine to call from soft and hard irq.
Because of that it seemed not explicitly mentioning all that is more
correct then describing all of that. I always thought "Context:"
sections are "Here's things to keep in mind." less then "Here's how it
behaves in all those contexts.", i.e. point out pitfalls, not describe
regular behavior. I might be wrong though or it's a matter of
preference.

(Should we also aim for all other fs.h helpers to have similar comments?)

Christian
