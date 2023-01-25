Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAF67ADCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjAYJ2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjAYJ2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:28:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6781448F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:28:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6112E1F8C4;
        Wed, 25 Jan 2023 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674638929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bejCFh3QKFZKUswjnm0+G4XnZFktAxanJNd7xkHDSuk=;
        b=obxbtqv7SFs9i70EqtyLI36RQ92yN6fl8uR9nPJu4mLSONCGKFl8rJtFkHNuq30GCRUmhj
        77dbutNw8TwMRHo9y3IJmhlBm3NUgylxhjgycFg7DwJ4+8k0cyYpJ6+pnp2Kcnhg2dEnZB
        3fj4tIYMFJGw8FDbKzXgbKRwxNtUWXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674638929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bejCFh3QKFZKUswjnm0+G4XnZFktAxanJNd7xkHDSuk=;
        b=b/E/SfRv1h+J7eFu/UlP91f0HJXt8j6630dfkHivMNb4HgbtqDTlCYhZt4O3EhktIqhcaZ
        skeU3QqYf9XXudDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52EF51358F;
        Wed, 25 Jan 2023 09:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A2o7FFH20GPxGgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:28:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB29CA06B5; Wed, 25 Jan 2023 10:28:48 +0100 (CET)
Date:   Wed, 25 Jan 2023 10:28:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] udf: Convert in-ICB files to use udf_writepages()
Message-ID: <20230125092848.dhb7iodmqokha5hv@quack3>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-2-jack@suse.cz>
 <Y8/cNRNSazn58MXL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/cNRNSazn58MXL@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-01-23 05:25:09, Christoph Hellwig wrote:
> As a pure mechanical move this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

> But some comments:
> 
> > +	struct inode *inode = page->mapping->host;
> > +	char *kaddr;
> > +	struct udf_inode_info *iinfo = UDF_I(inode);
> > +
> > +	BUG_ON(!PageLocked(page));
> > +
> > +	kaddr = kmap_atomic(page);
> > +	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
> > +	SetPageUptodate(page);
> > +	kunmap_atomic(kaddr);
> > +	unlock_page(page);
> 
> This really should be using memcpy_to_page.  And the SetPageUptodate
> here in ->writepages loos a little odd as well.

Good points. Added a cleanup patch for this. And then one more to get rid
of the last remaining kmap_atomic() use in UDF (BTW that would benefit from
memcpy_to_page_page() helper as well).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
