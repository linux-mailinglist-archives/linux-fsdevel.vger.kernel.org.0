Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2773E037
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFZNKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZNKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:10:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E699B9;
        Mon, 26 Jun 2023 06:10:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A4031F8AB;
        Mon, 26 Jun 2023 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687785002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6JfJgn7WigU75C2F7rQV1RIBlnMRsvyrWJCIdw/dCA=;
        b=eys9iBcHZeEhwoM+4xJcArAsNTJEoZ4F5/JuvySgzA6lig0YQ2tKBwmhJgJeGuTKW0ojic
        uU6ctK6n8OkxZ1BPLsNhpVVwGfa3dN5NOYQdiORfGNJsaHjXve08g9PgKOjHS89z+XuLtS
        G20EEJ5kA0P7k0HkW1y/WVHUf7dDKB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687785002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6JfJgn7WigU75C2F7rQV1RIBlnMRsvyrWJCIdw/dCA=;
        b=VXWH/ebYmCkoxq1Jrdwc3zdPADBQ/c6B+J2fQ2Otd4ECu7PfiGlen3urUdNidZRR7g2tvt
        zOaSHX36FGPHZwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D9F613483;
        Mon, 26 Jun 2023 13:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hTf9JSmOmWQaXgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 13:10:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 472B1A0754; Mon, 26 Jun 2023 15:09:57 +0200 (CEST)
Date:   Mon, 26 Jun 2023 15:09:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Message-ID: <20230626130957.kvfli23djxc2opkq@quack3>
References: <20230616085608.42435-1-libaokun1@huawei.com>
 <20230616152824.ndpgvkegvvip2ahh@quack3>
 <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
 <20230622145620.hk3bdjxtlr64gtzl@quack3>
 <b73894fc-0c7a-0503-25ad-ab5a9dfbd852@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73894fc-0c7a-0503-25ad-ab5a9dfbd852@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sun 25-06-23 15:56:10, Baokun Li wrote:
> > > I think we can simply focus on the race between the DQ_ACTIVE_B flag and
> > > the DQ_MOD_B flag, which is the core problem, because the same quota
> > > should not have both flags. These two flags are protected by dq_list_lock
> > > and dquot->dq_lock respectively, so it makes sense to add a
> > > wait_on_dquot() to ensure the accuracy of DQ_ACTIVE_B.
> > But the fundamental problem is not only the race with DQ_MOD_B setting. The
> > dquot structure can be completely freed by the time
> > dquot_claim_space_nodirty() calls dquot_mark_dquot_dirty() on it. That's
> > why I think making __dquot_transfer() obey dquot_srcu rules is the right
> > solution.
> Yes, now I also think that making __dquot_transfer() obey dquot_srcu
> rules is a better solution. But with inode->i_lock protection, why would
> the dquot structure be completely freed?

Well, when dquot_claim_space_nodirty() calls mark_all_dquot_dirty() it does
not hold any locks (only dquot_srcu). So nothing prevents dquot_transfer()
to go, swap dquot structure pointers and drop dquot references and after
that mark_all_dquot_dirty() can use a stale pointer to call
mark_dquot_dirty() on already freed memory.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
