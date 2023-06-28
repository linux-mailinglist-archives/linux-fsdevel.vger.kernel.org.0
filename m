Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286DB740CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjF1J1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjF1JKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:10:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74C482185A;
        Wed, 28 Jun 2023 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687943444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1waEYIxLL8AbYuL0wstgmIEKNw9jlwtFL4a/t+JvGQ=;
        b=hayA+KhDuNYXEyswHzkGwOL2lhBRMmyRk+LcUgh0Q32eHNRZIxP6ck3rM00MQVWtyrFsc7
        ZVJ+rDturDkE4X9g1SVUDTPET1+5Kps545NkSgrMCD43J9W1vsieWiwaZospIHmqk8mWFG
        4Mdp/eIp2kzvTjOLstxTJt0fM23YWn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687943444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1waEYIxLL8AbYuL0wstgmIEKNw9jlwtFL4a/t+JvGQ=;
        b=SUnqEokIdXZ9WjUuqjaF638pO3hMZYvR/dHxJIBy7/uzTkTrZj1TBi5QIXh0KE/LVXY17s
        qRR0HpgsxcFnPcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 687D7138E8;
        Wed, 28 Jun 2023 09:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ulp7GRT5m2QEcAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 09:10:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E991BA0707; Wed, 28 Jun 2023 11:10:43 +0200 (CEST)
Date:   Wed, 28 Jun 2023 11:10:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/12] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <20230628091043.lokcx4tdbwxisk7a@quack3>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-10-willy@infradead.org>
 <ZJpoCy7oWtqy2FoW@infradead.org>
 <ZJsAxVRZSEvdmlfB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsAxVRZSEvdmlfB@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-06-23 16:31:17, Matthew Wilcox wrote:
> > > +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> > > +			folio_unlock(folio);
> > > +			error = 0;
> > 
> > Note there really shouldn't be any need for this in outside of the
> > legacy >writepage case.  But it might make sense to delay the removal
> > until after ->writepage is gone to avoid bugs in conversions.
> 
> ext4_journalled_writepage_callback() still returns
> AOP_WRITEPAGE_ACTIVATE, and that's used by a direct call to
> write_cache_pages().

Yeah. For record ext4_journalled_writepage_callback() is a bit of an abuse
of writeback code by ext4 data=journal path but it seemed like a lesser
evil than duplicating write_cache_pages() code. Essentially we need to
iterate all dirty folios and call page_mkclean() on them (to stop folio
modifications through mmap while transaction commit code is writing these
pages to the journal). If we exported from page writeback code enough
helpers for dirty page iteration, we could get rid of
ext4_journalled_writepage_callback() and its AOP_WRITEPAGE_ACTIVATE usage
as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
