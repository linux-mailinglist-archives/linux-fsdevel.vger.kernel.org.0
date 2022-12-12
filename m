Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1F649E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLLLgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiLLLfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:35:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAEADEC3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 03:33:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02F701FEBD;
        Mon, 12 Dec 2022 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670844790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZYmdwkK1w0PeE5ptwfUe6FakZTF7Yz4y8nYAppV1AI=;
        b=S+A7YkFxWPJ6lLAQCT0hDvVHZudhl6ayUKTUiCv7zez4VSTs1J+6UpCk6gHw6cGQWzvGu4
        JqjySd6gOEVDtV4MEt65O4XQ8Zryij8K6vbGCguAoraq7Y0r+CqEUGZEKKOO5feKf5dbkg
        8PwpxCuNfmNqJF6M4ttRj+XYGjnJc70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670844790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZYmdwkK1w0PeE5ptwfUe6FakZTF7Yz4y8nYAppV1AI=;
        b=rQ33K+wQv9qrKC7p/ZEpZA3lrl7v3ALplhUzQG19j2ZMBKOr/Ch+7YDZr190KQM/ryc2G1
        j/bXxgwWK2JYg3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA5CE13456;
        Mon, 12 Dec 2022 11:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y6ytOHURl2P2YgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Dec 2022 11:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 79BD0A0728; Mon, 12 Dec 2022 12:33:09 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:33:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Writeback fix
Message-ID: <20221212113309.xzrcxdmwewfx3zd5@quack3>
References: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
 <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 10-12-22 09:44:16, Linus Torvalds wrote:
> On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Just a single writeback fix from Jan, for sanity checking adding freed
> > inodes to lists.
> 
> That's what the commit message says too, but that's not what the patch
> actually *does*.
> 
> It also does that unexplained
> 
> +       if (inode->i_state & I_FREEING) {
> +               list_del_init(&inode->i_io_list);
> +               wb_io_lists_depopulated(wb);
> +               return;
> +       }
> 
> that is new.

Yeah, I should have explained that. Now added to commit description and
also to a comment before the if. I'll send new version to Jens.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
