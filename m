Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB4549FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiFMUnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiFMUmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:42:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E113F25;
        Mon, 13 Jun 2022 12:43:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA43221AFC;
        Mon, 13 Jun 2022 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655149424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDlIv8k4YI9AeL8zTuC9Y9jHBJ5RQWlcpO0WYfw29GM=;
        b=QYlBWgzCJ6lCxWp3gQ2Z3SxBRp998NEKsWzmGenXDPEfVxBop57Ws1nlUFD0NTb9nj2J1U
        XFqvWHen/BxLTqci0hMrUCQAEuxeP+1O5zGCtE8sHpo8OzFa4m5PB0GRMkfkadYEfZOtJ4
        mcIcxneT88NF/XRo8y5WU9xxDHnnFz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655149424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDlIv8k4YI9AeL8zTuC9Y9jHBJ5RQWlcpO0WYfw29GM=;
        b=WxJzS6RsJwIE+51FIvF7osXGjc2WqiShjDo+rq6ZX5YPlk22LSRsagEVL8ljguIQVAH0D+
        IrM0Uph/jbzMNSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8279413443;
        Mon, 13 Jun 2022 19:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FbzTHnCTp2I1NAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 19:43:44 +0000
Date:   Mon, 13 Jun 2022 21:39:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] KASAN: use-after-free Read in
 copy_page_from_iter_atomic (2)
Message-ID: <20220613193912.GI20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, hch@lst.de,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
References: <0000000000003ce9d105e0db53c8@google.com>
 <00000000000085068105e112a117@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000085068105e112a117@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:10:19AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 4cd4aed63125ccd4efc35162627827491c2a7be7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri May 27 08:43:20 2022 +0000
> 
>     btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure

Josef also reported a crash and found a bug in the patch, now added as
fixup that'll be in for-next:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 89a319e65197..5eac9ffb7499 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2260,7 +2260,7 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
		__bio_add_page(&bio, p, PAGE_SIZE, start - page_offset(p));
		ret = btrfs_map_repair_bio(fs_info, &bio, mirror_num);
		bio_uninit(&bio);
-
+               start += PAGE_SIZE;
		if (ret)
			return ret;
	}
---
