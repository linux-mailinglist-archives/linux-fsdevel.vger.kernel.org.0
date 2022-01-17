Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC8490A08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiAQOLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:11:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41964 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQOLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:11:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E72D6123C;
        Mon, 17 Jan 2022 14:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D15C36AE7;
        Mon, 17 Jan 2022 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642428698;
        bh=HoOILvkdf4H0e24pigB+sdyo7uxDcs/7jN5xyGkmBzc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GHwVvXDU1drse2bqii6h/38dWWbkgGz9utxWMq+afRnOXySGgk8lEbAOge73XyuNT
         NZtPd+PBPRKY6g4A9rF5AB/0TSkr7mMsoNH0WKMSk9x1J7GoWTEF3JHmYY65AoATGb
         Jdkc8ulK7upmIyNRURLnZHwhIrb4clPbYh4BA11I4LhQLZJsgha/kF+QTF3ND+Z+/v
         rQwfZR2aCoA808K9gN2bSV2Ln3uEGYox5ez3mkM53LnTBHBs5IsUJKaHsZ7oVyaKyb
         wckRKQ8/KwPQeZlkebjdIhUO3ZVxhlUJWyACCRRX2NHBoeeb4m00x9XKvaOkr71i85
         bqNrya4+Zme+Q==
Message-ID: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org>
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 09:11:36 -0500
In-Reply-To: <YeVzZZLcsX5Krcjh@casper.infradead.org>
References: <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
         <YeVzZZLcsX5Krcjh@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-17 at 13:47 +0000, Matthew Wilcox wrote:
> On Mon, Jan 17, 2022 at 12:44:33PM +0000, David Howells wrote:
> > +	if (ceph_caps_issued(ci) & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) {
> > +		folio = filemap_get_folio(inode->i_mapping, 0);
> > +		if (folio) {
> > +			if (folio_test_uptodate(folio)) {
> >  				from_pagecache = true;
> > -				lock_page(page);
> > +				folio_lock(folio);
> >  			} else {
> > -				put_page(page);
> > -				page = NULL;
> > +				folio_put(folio);
> > +				folio = NULL;
> 
> This all falls very much under "doing it the hard way", and quite
> possibly under the "actively buggy with races" category.
> 
> read_mapping_folio() does what you want, as long as you pass 'filp'
> as your 'void *data'.  I should fix that type ...
> 

That would be nicer, I think. If you do that though, then patch #3
probably needs to come first in the series...
-- 
Jeff Layton <jlayton@kernel.org>
