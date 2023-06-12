Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D708D72CB70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjFLQZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFLQZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:25:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B94199;
        Mon, 12 Jun 2023 09:25:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52BAF1FDAF;
        Mon, 12 Jun 2023 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686587146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miuQAZFWTY3Ad4nQ4xkfSxIoICpsBzfNaEZViZD0I9Q=;
        b=WQUGxxURQCi1Q2KvpEyilDzAitnFPElLGSIl/YddF2ls2KHaFcL+FeBTHRlh+kJ0YLcsEI
        XYPmiTb+khRol6JTwLE7XuP4/yjh6+RkRlyZ/9eUiqraPu7wSjsrGsukV773eX5Ytunb40
        N1lRLv59k1gPOrDaeXimL0V7YqQswxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686587146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miuQAZFWTY3Ad4nQ4xkfSxIoICpsBzfNaEZViZD0I9Q=;
        b=/fkakv8ZMsQGV55owMk6kn05+bwkvTqxL1rfSmzr06ZeWAX6Kn+i91QU9/JL97BTJtG3qz
        QrUHX3Zy81unJ6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 450AB1357F;
        Mon, 12 Jun 2023 16:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zn7tEApHh2TBVAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 16:25:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB889A0717; Mon, 12 Jun 2023 18:25:45 +0200 (CEST)
Date:   Mon, 12 Jun 2023 18:25:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230612162545.frpr3oqlqydsksle@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161614.10302-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-06-23 18:16:14, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add config option to disallow writing to mounted (exclusively
> open) block devices. Syzbot can use this option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this config option for hardening.
> 
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Please disregard this patch. I had uncommited fixups in my tree. I'll send
fixed version shortly. I'm sorry for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
