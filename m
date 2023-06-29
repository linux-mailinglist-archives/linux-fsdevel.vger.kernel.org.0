Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115DF742400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF2K36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjF2K3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:29:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356831BC5;
        Thu, 29 Jun 2023 03:29:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E3BE51F8D6;
        Thu, 29 Jun 2023 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688034592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swPhgok8h+We1v8ana5CyUTV4+yhMIa2K+wyb19NXmA=;
        b=joZ1/Pzqt4UJB9cXNCtyfEAzszNASSowxOumz50ZKGzNi3Crojvuerh5hzFxgfFHk0sd3n
        x228fCPA+nprWXeCZ8DdMuDyb/Rh4Zls0l/O24SE9YQybPN2JQqF1I5u8VYd4mGRilCeak
        iwUaua3w4I4lGjfLoByEeY6Fb1lNN34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688034592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swPhgok8h+We1v8ana5CyUTV4+yhMIa2K+wyb19NXmA=;
        b=3Bk+8WfuBc4X47g7x6m+VhsrpbQvAOmD6M8Y1G+KGYXFNOzTogYwyniYXHUbOeSo10cuwu
        Wi8rJUE0e2vniOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D588F139FF;
        Thu, 29 Jun 2023 10:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aVMeNCBdnWQ+HQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 10:29:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C2CFA0722; Thu, 29 Jun 2023 12:29:52 +0200 (CEST)
Date:   Thu, 29 Jun 2023 12:29:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 2/7] quota: add new global dquot list releasing_dquots
Message-ID: <20230629102952.ifn3qdoh632ybsb5@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132155.1560425-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 21:21:50, Baokun Li wrote:
> Add a new global dquot list that obeys the following rules:
> 
>  1). A dquot is added to this list when its last reference count is about
>      to be dropped.
>  2). The reference count of the dquot in the list is greater than or equal
>      to 1 ( due to possible race with dqget()).
>  3). When a dquot is removed from this list, a reference count is always
>      subtracted, and if the reference count is then 0, the dquot is added
>      to the free_dquots list.
> 
> This list is used to safely perform the final cleanup before releasing
> the last reference count, to avoid various contention issues caused by
> performing cleanup directly in dqput(), and to avoid the performance impact
> caused by calling synchronize_srcu(&dquot_srcu) directly in dqput(). Here
> it is just defining the list and implementing the corresponding operation
> function, which we will use later.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I think you can merge this patch with patch 5. It is not like separating
this bit helps in review or anything...

> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 108ba9f1e420..a8b43b5b5623 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -226,12 +226,21 @@ static void put_quota_format(struct quota_format_type *fmt)
>  /*
>   * Dquot List Management:
>   * The quota code uses four lists for dquot management: the inuse_list,
                          ^^^ five now :)

> - * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
> - * structure may be on some of those lists, depending on its current state.
> + * releasing_dquots, free_dquots, dqi_dirty_list, and dquot_hash[] array.
> + * A single dquot structure may be on some of those lists, depending on
> + * its current state.
>   *
>   * All dquots are placed to the end of inuse_list when first created, and this
>   * list is used for invalidate operation, which must look at every dquot.
>   *
> + * When the last reference of a dquot will be dropped, the dquot will be
> + * added to releasing_dquots. We'd then queue work item which would call
> + * synchronize_srcu() and after that perform the final cleanup of all the
> + * dquots on the list. Both releasing_dquots and free_dquots use the
> + * dq_free list_head in the dquot struct. when a dquot is removed from
					     ^^^ Capital W please

> + * releasing_dquots, a reference count is always subtracted, and if
> + * dq_count == 0 at that point, the dquot will be added to the free_dquots.
> + *

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
