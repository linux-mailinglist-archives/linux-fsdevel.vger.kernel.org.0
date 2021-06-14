Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6A3A6851
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhFNNsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhFNNsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:48:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F105C061574;
        Mon, 14 Jun 2021 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LPqO+dW9BvhRSiVFc/Fk8YBZ3qqyoUl/xcHNa5bqxIA=; b=ImI6filROaKDnSBRvSEYetlKZC
        bUUve2305RRRYwBrlH0tw9ftOWT8FmQUSHf9mf8n5I+s49juLH6ZrQAmlz0K8jCljA4Hg+SmhuL5I
        cgalD/SPq0FDfOWOdBn02y6GhjHbNcINlb6NzQg8hEcLD3yMktcnozf9e0mbXJLuw6X5C6ym7ihqX
        zudiyoa5YIiiFKgk+5EHwFm2zmNbzwhD0cuER74D56tNGlF9aqC18EmLY25OBNMdQq9JwVyifr37Q
        P2KwkvZi2uGU+t5tMmB0rDZfYUsoqDF1o1c85uWoiBytEY4GESkLD3SfWmMAkcA2vec4keH55QaLA
        +REc/jsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsmuh-005TjH-T1; Mon, 14 Jun 2021 13:46:13 +0000
Date:   Mon, 14 Jun 2021 14:46:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, jlayton@kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YMddm2P0vD+4edBu@casper.infradead.org>
References: <YMdZbsvBNYBtZDC2@casper.infradead.org>
 <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
 <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
 <466590.1623677832@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466590.1623677832@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:37:12PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > >  (1) If the page is not up to date, then we should just return 0
> > >      (ie. indicating a zero-length copy).  The loop in
> > >      generic_perform_write() will go around again, possibly breaking up the
> > >      iterator into discrete chunks.
> > 
> > Does this actually work?  What about the situation where you're reading
> > the last page of a file and thus (almost) always reading fewer bytes
> > than a PAGE_SIZE?
> 
> Al Viro made such a change for Ceph - and we're writing, not reading.

I'd feel better if you said "xfstests doesn't show any new problems"
than arguing to authority.

I know the operation which triggers this path is a call to write(),
but if, say, the file is 32 bytes long, not in cache, and you write
bytes 32-63, the client must READ bytes 0-31 from the server, which
is less than a full page.

