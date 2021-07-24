Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAA3D4A61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 23:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGXVRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 17:17:04 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52430 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXVRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:17:04 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7PeC-003gMt-NK; Sat, 24 Jul 2021 21:57:28 +0000
Date:   Sat, 24 Jul 2021 21:57:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable
 helper
Message-ID: <YPyMyPCpZKGlfAGk@zeniv-ca.linux.org.uk>
References: <20210724193449.361667-1-agruenba@redhat.com>
 <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
 <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
 <CAHc6FU5nGRn1_oc-8rSOCPfkasWknH1Wb3FeeQYP29zb_5fFGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5nGRn1_oc-8rSOCPfkasWknH1Wb3FeeQYP29zb_5fFGQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:38:20PM +0200, Andreas Gruenbacher wrote:

> Hmm, how could we have sub-page failure areas when this is about if
> and how pages are mapped? If we return the number of bytes that are
> accessible, then users will know if they got nothing, something, or
> everything, and they can act accordingly.

What I'm saying is that in situation when you have cacheline-sized
poisoned areas, there's no way to get an accurate count of readable
area other than try and copy it out.

What's more, "something" is essentially useless information - the
pages might get unmapped right as your function returns; the caller
still needs to deal with partial copies.  And that's a slow path
by definition, so informing them of a partial fault-in is not
going to be useful.

As far as callers are concerned, it's "nothing suitable in the
beginning of the area" vs. "something might be accessible".
