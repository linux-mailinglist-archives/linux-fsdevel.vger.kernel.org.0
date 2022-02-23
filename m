Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8668A4C0F64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiBWJmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiBWJmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:42:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9FE5F8C3;
        Wed, 23 Feb 2022 01:41:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D034321119;
        Wed, 23 Feb 2022 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4T8otD0XWKVmSpTAecWXeZLJR8A/nhbkHc94k0QMj8=;
        b=bn2YuvbJT5YblJ3bub9dCD7O6mtXZaakOye8U/E0Tncj2q8HFjox6ojmWfz1zpIqRuSsM5
        hMef9zM63OLJUuY5Wm3RFxhY5LQioRxwRxnYqf6eT9xX5KbMM5wRe0nBV96lMJFB2z/WRm
        j66CCEXUPUhtdgYSGVLu1rjW1c7d1no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4T8otD0XWKVmSpTAecWXeZLJR8A/nhbkHc94k0QMj8=;
        b=ltOiU9x3rTUpgPgur63uy4wU/JgbP9AntyjzlHWNz7ltKqNKjCdkrQTQddGvzCZVNXsNIb
        X5Q9iv4FRbIVQpAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C19C6A3B84;
        Wed, 23 Feb 2022 09:41:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 805B4A0605; Wed, 23 Feb 2022 10:41:49 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:41:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/9] ext4: Do not call FC trace event if FS does not
 support FC
Message-ID: <20220223094149.h5lj2dwq3sd5b3tp@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <a62c8d1c0d8a01e2b1e3afc9c2b012c04c54b137.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62c8d1c0d8a01e2b1e3afc9c2b012c04c54b137.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:12, Ritesh Harjani wrote:
> This just puts trace_ext4_fc_commit_start(sb) & ktime_get()
> for measuring FC commit time, after the check of whether sb
> supports JOURNAL_FAST_COMMIT or not.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index bf70879bb4fe..7fb1eceef30c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1167,13 +1167,13 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
>  	ktime_t start_time, commit_time;
>  
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> +		return jbd2_complete_transaction(journal, commit_tid);
> +
>  	trace_ext4_fc_commit_start(sb);
>  
>  	start_time = ktime_get();
>  
> -	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> -		return jbd2_complete_transaction(journal, commit_tid);
> -
>  restart_fc:
>  	ret = jbd2_fc_begin_commit(journal, commit_tid);
>  	if (ret == -EALREADY) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
