Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC073AEB5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUOf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFUOf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:35:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0AC061574;
        Mon, 21 Jun 2021 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NUL0uaOl6BkuzDA85W5PvpTXkrxDHe90LX6oMMLZWA4=; b=ZvD/1038jZdKlZxctK6IFj8j4F
        qyW7/zfnfg/ZojoUwIhQTqiAI5MI8ZwK0tKJ2qtkMXjUz1HeLq8s0EHzNjH87yYnc+ytbse2FjME2
        JHcF0FRL80YW74Us6pmAr4Nw5c5pJUy9n3lydIzQ1UdfAN0RohIahrj08sy3SXYyK/w3v2nHEZC87
        otkeEBIcDjzaQdGxcHnpDjCrLkO8WnNfs4VFBAQaR9LrC8qOyQKXbp5AEC7+4Jo/5ioiK5motN3yu
        HMk9xbW6lwB/HsuJk5F2jcUcPidM0iMBeX3m7smS0Fe1pL52esYmstkoEf88Kzo9orPSnEHZTjqCP
        e9BMG7LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKyj-00DBPp-0L; Mon, 21 Jun 2021 14:32:56 +0000
Date:   Mon, 21 Jun 2021 15:32:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] afs: Handle len being extending over page end in
 write_begin/write_end
Message-ID: <YNCjDGXGfewvl8E0@casper.infradead.org>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
 <162391824293.1173366.15452474691364794223.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162391824293.1173366.15452474691364794223.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:24:02AM +0100, David Howells wrote:
> With transparent huge pages, in the future, write_begin() and write_end()
> may be passed a length parameter that, in combination with the offset into
> the page, exceeds the length of that page.  This allows
> grab_cache_page_write_begin() to better choose the size of THP to allocate.

While this is all true, it's really not necessary at this point in time.
That change will come with a conversion of these functions to work with
folios and basically every line you change here will change again.

