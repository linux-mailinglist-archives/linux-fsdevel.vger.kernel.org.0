Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449CE73A3C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFVO4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFVO4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:56:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500C10F2;
        Thu, 22 Jun 2023 07:56:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7993621CEF;
        Thu, 22 Jun 2023 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687445781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=463JTf1QkmLeBWrj4Qbob5X8NWFslFYEpzHrAlOzdyk=;
        b=g0vAGPlZCcGiGKj8X3AJTrzXGz3NnBax7m7Es//Wuka0V4kZagALqdoGEaOaKTo4UJxI0x
        Mx0oFBj7AOpMVdiP+KawJeBGx0aHQMNuQUQ9vnCl6Im9zdOCN5XE3x6GQWZ9npx8UyKF5o
        tNTxTB006wVjxOugIbSeK5xGGzuAgv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687445781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=463JTf1QkmLeBWrj4Qbob5X8NWFslFYEpzHrAlOzdyk=;
        b=z+FmDQxAXkp3YxZZXFtMZ/LrjyIsS9JKeD+izSYHkFJjFjx/Y/EnZn/ezg52QUiC1fiogK
        zFkxhSN4VtNFOCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 686E513905;
        Thu, 22 Jun 2023 14:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XWt1GRVhlGS7JQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Jun 2023 14:56:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E49F6A0754; Thu, 22 Jun 2023 16:56:20 +0200 (CEST)
Date:   Thu, 22 Jun 2023 16:56:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Message-ID: <20230622145620.hk3bdjxtlr64gtzl@quack3>
References: <20230616085608.42435-1-libaokun1@huawei.com>
 <20230616152824.ndpgvkegvvip2ahh@quack3>
 <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
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

On Mon 19-06-23 14:44:03, Baokun Li wrote:
> On 2023/6/16 23:28, Jan Kara wrote:
> > Now calling synchronize_srcu() directly from dquot_transfer() is too
> > expensive (and mostly unnecessary) so what I would rather suggest is to
> > create another dquot list (use dq_free list_head inside struct dquot for
> > it) and add dquot whose last reference should be dropped there. We'd then
> > queue work item which would call synchronize_srcu() and after that perform
> > the final cleanup of all the dquots on the list.
> > 
> > Now this also needs some modifications to dqget() and to quotaoff code to
> > handle various races with the new dqput() code so if you feel it is too
> > complex for your taste, I can implement this myself.
> > 
> > 								Honza
> I see what you mean, what we are doing here is very similar to
> drop_dquot_ref(),
> and if we have to modify it this way, I am happy to implement it.
> 
> But as you said, calling synchronize_srcu() is too expensive and it blocks
> almost all
> mark dirty processes, so we only call it now in performance insensitive
> scenarios
> like dquot_disable(). And how do we control how often synchronize_srcu() is
> called?
> Are there more than a certain number of dquots in releasing_dquots or are
> they
> executed at regular intervals? And it would introduce various new
> competitions.
> Is it worthwhile to do this for a corner scenario like this one?

So the way this is handled (e.g. in fsnotify subsystem) is that we just
queue work item when we drop the last reference to the protected structure.
The scheduling latency before the work item gets executed is enough to
batch synchronize_srcu() calls and once synchronize_srcu() finishes, we add
all items from the "staging list" to the free_dquots list.

> I think we can simply focus on the race between the DQ_ACTIVE_B flag and
> the DQ_MOD_B flag, which is the core problem, because the same quota
> should not have both flags. These two flags are protected by dq_list_lock
> and dquot->dq_lock respectively, so it makes sense to add a
> wait_on_dquot() to ensure the accuracy of DQ_ACTIVE_B.

But the fundamental problem is not only the race with DQ_MOD_B setting. The
dquot structure can be completely freed by the time
dquot_claim_space_nodirty() calls dquot_mark_dquot_dirty() on it. That's
why I think making __dquot_transfer() obey dquot_srcu rules is the right
solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
