Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB187427F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2OJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:09:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA27D1B1;
        Thu, 29 Jun 2023 07:09:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A69BB1F8AF;
        Thu, 29 Jun 2023 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688047762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71RZpLoOR8WYSh7imeQpwmDDhV+BCqDsCV9ISGQsCK8=;
        b=bOzAat0NSo7RDK5B8cqq0vhPaf0FH7qw+zwCC6CiHe85TxXZnp2GjF4deTGUHSbtiBj7KT
        hPAxL+k6qQUXWv6R3wkYSqvVByhhoWWoitIRg+rW36nxGuS1uxQ+HRjjXXIB2BzosnINLu
        HYQ8kG/7lgiKV2f1WGfkeK5AKLKsp98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688047762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71RZpLoOR8WYSh7imeQpwmDDhV+BCqDsCV9ISGQsCK8=;
        b=8PYcx+XcIW466le2pRQYKLH8oKk8vPZ2U7BVCLyhZUBlulCyZsforuBWV4b2fIVyiihntb
        j7roBo0AWsAkgpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9440513905;
        Thu, 29 Jun 2023 14:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7lsjJJKQnWRUDgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 14:09:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18201A0722; Thu, 29 Jun 2023 16:09:22 +0200 (CEST)
Date:   Thu, 29 Jun 2023 16:09:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 6/7] quota: simplify drop_dquot_ref()
Message-ID: <20230629140922.dp74owntkbm5avop@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-7-libaokun1@huawei.com>
 <20230629110813.kfaja4bdomilmns6@quack3>
 <d00a224e-1991-ce90-d458-45390a20f8dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d00a224e-1991-ce90-d458-45390a20f8dc@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-06-23 20:13:05, Baokun Li wrote:
> On 2023/6/29 19:08, Jan Kara wrote:
> > On Wed 28-06-23 21:21:54, Baokun Li wrote:
> > > Now when dqput() drops the last reference count, it will call
> > > synchronize_srcu(&dquot_srcu) in quota_release_workfn() to ensure that
> > > no other user will use the dquot after the last reference count is dropped,
> > > so we don't need to call synchronize_srcu(&dquot_srcu) in drop_dquot_ref()
> > > and remove the corresponding logic directly to simplify the code.
> > Nice simplification!  It is also important that dqput() now cannot sleep
> > which was another reason for the logic with tofree_head in
> > remove_inode_dquot_ref().
> 
> I don't understand this sentence very well, so I would appreciate it
> 
> if you could explain it in detail. 🤔

OK, let me phrase it in a "changelog" way :):

remove_inode_dquot_ref() currently does not release the last dquot
reference but instead adds the dquot to tofree_head list. This is because
dqput() can sleep while dropping of the last dquot reference (writing back
the dquot and calling ->release_dquot()) and that must not happen under
dq_list_lock. Now that dqput() queues the final dquot cleanup into a
workqueue, remove_inode_dquot_ref() can call dqput() unconditionally
and we can significantly simplify it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
