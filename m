Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656075E614D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIVLjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIVLjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:39:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF11E21ED;
        Thu, 22 Sep 2022 04:39:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3347A21A2D;
        Thu, 22 Sep 2022 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663846743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooXBSsSJjkQdEsr6lqePFfsaUH3/uClBOCCzUPkChWE=;
        b=U8ohY/h08dQUTbWk2o7LhTEsgaDZ0nhDjB+BLdDuzE46aNNXOgoizcWM5ugz6RcgDzg2Nd
        auA1vJMHZcaYM2dwWpzj2QwUWabAa/xFmYUpf0YT9Y22JWRfCvHlfdoEiVCGUJYzyIQ2VV
        73FEQ5jdMvRjUfSVKK0wap3J3oAbH6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663846743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooXBSsSJjkQdEsr6lqePFfsaUH3/uClBOCCzUPkChWE=;
        b=3PK2qkOMu8xnpDUis+YJBLftHAW/6N8fac2lpzLQOk1zaD6bdFCGKip7t08ts0kTF2S/dR
        hF6rzqzG0MGXWCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2145513AA5;
        Thu, 22 Sep 2022 11:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MngZCFdJLGO1PwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Sep 2022 11:39:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 793DBA0684; Thu, 22 Sep 2022 13:39:02 +0200 (CEST)
Date:   Thu, 22 Sep 2022 13:39:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, tytso@mit.edu,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 1/3] quota: Check next/prev free block number after
 reading from quota file
Message-ID: <20220922113902.rhoxfgdzcvdzo3wc@quack3>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
 <20220820110514.881373-2-chengzhihao1@huawei.com>
 <20220921133715.7tesk3qylombwmyk@quack3>
 <41578612-d582-79ea-bb8e-89fa19d4406e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41578612-d582-79ea-bb8e-89fa19d4406e@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 16:13:59, Zhihao Cheng wrote:
> 在 2022/9/21 21:37, Jan Kara 写道:
> > > --- a/fs/quota/quota_tree.c
> > > +++ b/fs/quota/quota_tree.c
> > > @@ -71,6 +71,35 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
> > >   	return ret;
> > >   }
> > > +static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
> > > +{
> > > +	if (val >= max_val) {
> > > +		quota_error(sb, "Getting block too big (%u >= %u)",
> > > +			    val, max_val);
> > > +		return -EUCLEAN;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > I'd already provide min_val and the string for the message here as well (as
> > you do in patch 2). It is less churn in the next patch and free blocks
> > checking actually needs that as well. See below.
> > 
> > > +
> > > +static int check_free_block(struct qtree_mem_dqinfo *info,
> > > +			    struct qt_disk_dqdbheader *dh)
> > > +{
> > > +	int err = 0;
> > > +	uint nextblk, prevblk;
> > > +
> > > +	nextblk = le32_to_cpu(dh->dqdh_next_free);
> > > +	err = do_check_range(info->dqi_sb, nextblk, info->dqi_blocks);
> > > +	if (err)
> > > +		return err;
> > > +	prevblk = le32_to_cpu(dh->dqdh_prev_free);
> > > +	err = do_check_range(info->dqi_sb, prevblk, info->dqi_blocks);
> > > +	if (err)
> > > +		return err;
> > 
> > The free block should actually be > QT_TREEOFF so I'd add the check to
> > do_check_range().
> 
> 'dh->dqdh_next_free' may be updated when quota entry removed,
> 'dh->dqdh_next_free' can be used for next new quota entris.
> Before sending v2, I found 'dh->dqdh_next_free' and 'dh->dqdh_prev_free' can
> easily be zero in newly allocated blocks when continually creating files
> onwed by different users:
> find_free_dqentry
>   get_free_dqblk
>     write_blk(info, info->dqi_blocks, buf)  // zero'd qt_disk_dqdbheader
>     blk = info->dqi_blocks++   // allocate new one block
>   info->dqi_free_entry = blk   // will be used for new quota entries
> 
> find_free_dqentry
>   if (info->dqi_free_entry)
>     blk = info->dqi_free_entry
>     read_blk(info, blk, buf)   // dh->dqdh_next_free = dh->dqdh_prev_free =
> 0
> 
> I think it's normal when 'dh->dqdh_next_free' or 'dh->dqdh_prev_free' equals
> to 0.

Good point! 0 means "not present". So any block number (either in free list
or pointed from the quota tree) should be either 0 or > QT_TREEOFF.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
