Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C273665B1DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjABMP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 07:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjABMPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:15:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6918C321;
        Mon,  2 Jan 2023 04:15:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16C32340CE;
        Mon,  2 Jan 2023 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672661749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p+1CYr35IMfZeXzMv9mW+b7Hyipf7RXjCQLefUwxuA=;
        b=Vdfb5kx7HXP1I4jfRVpYYRPbixX/OUrc798QzUyANCeCVUgrahv/iTI/auD/sNIdXdZSKb
        iI9TexVwDI77ARJL7kqzT3x7diyi2vgNz2rlIqnwPLKMMvZYqRyaCIEGL08IbqgzEk/L08
        dTV7Fs4vSHI6NTBRRthFFsD9cE38F7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672661749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p+1CYr35IMfZeXzMv9mW+b7Hyipf7RXjCQLefUwxuA=;
        b=1syY9TgPoXIKMrutE+opNx6jC7wdgkUilzJMOgw1RjxHqG/Pa1+Zaf2Sg595NbauTyu4SI
        CB/VK0K3JpeupHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05C39139C8;
        Mon,  2 Jan 2023 12:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b71oAfXKsmPSCgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:15:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BEB2BA073E; Mon,  2 Jan 2023 13:15:46 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:15:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/6] ocfs2: use filemap_fdatawrite_wbc instead of
 generic_writepages
Message-ID: <20230102121546.fqpy55koaavfazm3@quack3>
References: <20221229161031.391878-1-hch@lst.de>
 <20221229161031.391878-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229161031.391878-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-12-22 06:10:30, Christoph Hellwig wrote:
> filemap_fdatawrite_wbc is a fairly thing wrapper around do_writepages,
> and the big difference there is support for cgroup writeback, which
> is not supported by ocfs2, and the potential to use ->writepages instead
> of ->writepage, which ocfs2 does not currently implement but eventually
> should.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 59f612684c5178..25d8072ccfce46 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -852,7 +852,7 @@ static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  		.range_end = jinode->i_dirty_end,
>  	};
>  
> -	return generic_writepages(mapping, &wbc);
> +	return filemap_fdatawrite_wbc(mapping, &wbc);
>  }
>  
>  int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
