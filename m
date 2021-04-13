Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA1035E1D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhDMOq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDMOq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:46:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B3C061574;
        Tue, 13 Apr 2021 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dUP0mmYc5PS53JTmGtYQ/UoruFkNut8DqFGyPA4/gAQ=; b=HJgxHZ/JL///I5K5iiFNwZboW8
        4em50NAFunOC0gXIhElilt+ak46BHJjXM3OXhm27crqL1OOWiNxoxtMRNQaRtZnia7/V0+46DU52v
        2yWmjbd5YfcUwnfnyiwUBfClz3ptH96NUqzW53PmMRx7CR/LXiGfDEeeSwoLSqG/tpAeMvesqQXgL
        I2HYrOFXT8ergZI1nTtVDp1I5ZopAXyNh8ixU29VSOeQ/apuzui2m+GQ9fWtTL1WrbZ/UErQpXOuP
        ngolUfu/4pKaoCITCCJJns/JEgxAFYz/qFuDBtfr5KvYKjZSdy/OricpfYEVf7UnoJg/RPCWdD6GB
        zxo7+t4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWKHm-005s4L-Vd; Tue, 13 Apr 2021 14:45:19 +0000
Date:   Tue, 13 Apr 2021 15:45:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/18] vfs: add fileattr ops
Message-ID: <20210413144502.GP2531743@casper.infradead.org>
References: <20210325193755.294925-1-mszeredi@redhat.com>
 <20210325193755.294925-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325193755.294925-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:37:38PM +0100, Miklos Szeredi wrote:
> @@ -107,6 +110,8 @@ fiemap:		no
>  update_time:	no
>  atomic_open:	shared (exclusive if O_CREAT is set in open flags)
>  tmpfile:	no
> +fileattr_get:	no or exclusive
> +fileattr_set:	exclusive
>  ============	=============================================

This introduces a warning to `make htmldocs`:

/home/willy/kernel/folio/Documentation/filesystems/locking.rst:113: WARNING: Malformed table.
Text in column margin in table line 24.

You need to add an extra '=' to the first batch of '=' (on all three lines of
the table).  Like this:

@@ -87,9 +87,9 @@ prototypes::
 locking rules:
        all may block
 
-============   =============================================
+=============  =============================================
 ops            i_rwsem(inode)
-============   =============================================
+=============  =============================================
 lookup:                shared
 create:                exclusive
 link:          exclusive (both)
@@ -112,7 +112,7 @@ atomic_open:        shared (exclusive if O_CREAT is set in open flags)
 tmpfile:       no
 fileattr_get:  no or exclusive
 fileattr_set:  exclusive
-============   =============================================
+=============  =============================================

(whitespace damaged)

