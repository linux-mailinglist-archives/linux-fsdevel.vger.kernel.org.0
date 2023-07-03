Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D8746112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGCRBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGCRBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:01:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79EE58;
        Mon,  3 Jul 2023 10:01:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A906621ACE;
        Mon,  3 Jul 2023 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688403676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxxA5KPOlxZoqVBuLA7u+rs+PuFzIjExMLh3T2z3dig=;
        b=WwkmG+qaXYNQ/vu9q4F7pEj9wrt2bBvW6aP9mlVUwydMkr7hS3xU7fSguhVECWbugKFVwD
        nFfsMv+fh+VCYPr0mUXkIt6MUoHAY0tHWAVVhgoa1E0ZsN/9yuDPQzhSeKss/q3dJUw1Ta
        kHoy5ufRYv9txFxyUyUCkLRfw+3UDts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688403676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxxA5KPOlxZoqVBuLA7u+rs+PuFzIjExMLh3T2z3dig=;
        b=RCvYdmMDKz+U+kgLqNfhNNngHIe4nuoTf2Nywg7oLIDSHSzTvjaJ7eJOx50qEZOlN3bDcL
        q6LZq+rMlUQWdcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 995451358E;
        Mon,  3 Jul 2023 17:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tSFmJdz+omSOEQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Jul 2023 17:01:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DC8AA0722; Mon,  3 Jul 2023 19:01:16 +0200 (CEST)
Date:   Mon, 3 Jul 2023 19:01:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 0/5] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Message-ID: <20230703170116.xikrectpzdc5dmux@quack3>
References: <20230630110822.3881712-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630110822.3881712-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri 30-06-23 19:08:17, Baokun Li wrote:
> Hello Honza,
> 
> This is a solution that uses dquot_srcu to avoid race condition between
> dqput() and dquot_mark_dquot_dirty(). I performed a 12+h fault injection
> stress test (6 VMs, 4 test threads per VM) and have not found any problems.
> And I tested the performance based on the next branch (5c875096d590), this
> patch set didn't degrade performance, but rather had a ~5% improvement.
> 
> V1->V2:
> 	Modify the solution to use dquot_srcu.
> V2->V3:
> 	Merge some patches, optimize descriptions.
> 	Simplify solutions, and fix some spelling errors.
> 

Thanks! I've added the patches to my tree.

								Honza

> Baokun Li (5):
>   quota: factor out dquot_write_dquot()
>   quota: rename dquot_active() to inode_quota_active()
>   quota: add new helper dquot_active()
>   quota: fix dqput() to follow the guarantees dquot_srcu should provide
>   quota: simplify drop_dquot_ref()
> 
>  fs/quota/dquot.c | 244 ++++++++++++++++++++++++-----------------------
>  1 file changed, 125 insertions(+), 119 deletions(-)
> 
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
