Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98747744A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjHHSZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjHHSZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:25:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09444A0;
        Tue,  8 Aug 2023 10:38:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28F4A21B5C;
        Tue,  8 Aug 2023 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691516336;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJGWpdkmia/LuTTM0Xz5ivl01K1PmwEVyDfvAEoT+VU=;
        b=MG8INEyolhXkJ9W5ZzW3tah+nKzTF2fRd6Sf3ihcLFhtcV/wjIxN2xqzgetPSrzjoYGzdd
        9y6uCCbiV0m1HMnXVqpVnKscByzXtGy9VKF358nieiODQ2e2AYSiLw5MWbUupkvv4ol6RC
        fxj1oUrwereMLVxoSj+ubnJbza/c8rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691516336;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJGWpdkmia/LuTTM0Xz5ivl01K1PmwEVyDfvAEoT+VU=;
        b=qVOqBKQozXqdRTfamewnqpj9Xxwoz4bASv6vqV5xLJUQlU2wEhTUFvHMHB2HGSF+6yPubg
        TvL92b7RGPS5ngDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1F3E139D1;
        Tue,  8 Aug 2023 17:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SilENq990mQhEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 08 Aug 2023 17:38:55 +0000
Date:   Tue, 8 Aug 2023 19:38:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 btrfs_open_devices
Message-ID: <ZNJ9rkM6ZZvlxC3h@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
References: <0000000000007921d606025b6ad6@google.com>
 <000000000000094846060260e710@google.com>
 <20230808-zentimeter-kappen-5da1e70c5535@brauner>
 <20230808160141.GA15875@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808160141.GA15875@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:01:41PM +0200, Christoph Hellwig wrote:
> Yes, probably.  The lifetimes looked fishy to me to start with, but
> this might have made things worse.

The locking rules for device structures are not following any commonly
found patterns so it's easy to break it. We've spent a lot of time
chasing races reported by syzbot, so please hold on with this patch
before a final merge. Keeping it in for-next for testing is OK.
