Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE981A39EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDISpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDISpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ec6By6jM0nky0YxXbeoKWCzhryIxU+J3YpWKlp335aQ=; b=cNRMpuq4XmR+MbdzNLGNIl5Gw5
        26AilBeNESBtw+JDm947/5Lj0TQHojVAPWq/B+ddggAlOMRUuGGCP3JTTQEVFInTdkxT4FHdWr9QE
        oCWqk0BHGsqBi7eYts23l7DsFWha/FWA5EFi8haC9KoSkbrhUB9Asc0qmqQ7XCmW2u8pvCbMicgp+
        gKtG7P9sQ7+iZPrsWfQKpmcsI9HGa0ng1h4H3s7hH14HC5pFvgfRjlS72KCt2cpBsQrhP2sq96VE9
        HbKVpLYFfcKNAvoeZyLXIALHFQekrE28/g8mnSscwZYspc0Drual1CRqBh3plP9XUw2CkH/eRTwA3
        LxDNOHpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMcAq-0008FP-9i; Thu, 09 Apr 2020 18:45:12 +0000
Date:   Thu, 9 Apr 2020 11:45:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v2] proc/mounts: add cursor
Message-ID: <20200409184512.GX21484@bombadil.infradead.org>
References: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:16:19PM +0200, Miklos Szeredi wrote:
> Solve this by adding a cursor entry for each open instance.  Taking the
> global namespace_sem for write seems excessive, since we are only dealing
> with a per-namespace list.  Instead add a per-namespace spinlock and use
> that together with namespace_sem taken for read to protect against
> concurrent modification of the mount list.  This may reduce parallelism of

It occurs to me that this is another place where something like Kent's
SIX locks would fit the bill.  To recap, that was a mutex with Shared,
Intent-to-upgrade and eXclusive states.  eXclusive and Shared are like
write and read states in our rwsem.  The Intent state would allow other
Shared users to start, but no more Intent users.  You'd have to upgrade
to eXclusive state to actually modify the list, so you might have to
wait for Shared users to finish the section.  Might not work out well
in practice for this user, but thought it was worth mentioning.
