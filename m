Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDC73FD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjF0OOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF0OOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:14:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE4FDD;
        Tue, 27 Jun 2023 07:14:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD2231F749;
        Tue, 27 Jun 2023 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687875276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCSIDFlsV7KmODzaiZem8xZzkRP6xFoZ9MafAjKiYxk=;
        b=ubCywpiJOeAE7N/8Gu2wpu08OioVwZWMCbdv4YGJUuMR8UxrZW2fMDn0BJKCEelFZQQSSS
        YLhU0UlzTZwd5K58nlewsOEE9TsSnSxQh2QNvnIIml8mnEOV6Ab+ypXWN6IwhvbhHnR4pO
        vZYm5QwFhKNjcokZjwh8vU80F3Q8LiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687875276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCSIDFlsV7KmODzaiZem8xZzkRP6xFoZ9MafAjKiYxk=;
        b=p517Evp6daAW8+2LHAgc9vs/sPyThOKso0/KoYHAsqykBHXK0Zxr5IlHDUd2iWx1Nw2Sye
        LGu6hU5IbU3T+ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87D0B13462;
        Tue, 27 Jun 2023 14:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /eBoIMzummSNBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 27 Jun 2023 14:14:36 +0000
Date:   Tue, 27 Jun 2023 16:08:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: port to new mount api
Message-ID: <20230627140809.GA16168@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
 <b9028f9d-d947-3813-9677-c49bd2b72d53@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9028f9d-d947-3813-9677-c49bd2b72d53@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:51:01AM +0000, Johannes Thumshirn wrote:
> On 26.06.23 16:19, Christian Brauner wrote:
> > This whole thing ends up being close to a rewrite in some places. I
> > haven't found a really elegant way to split this into smaller chunks.
> 
> You'll probably hate me for this, but you could split it up a bit by 
> first doing the move of the old mount code into params.c and then do the
> rewrite for the new mount API.

The patch needs more finer split than just that. Replacing the entire
mount code like that will introduce bugs that users will hit for sure.
We have some weird mount option combinations or constraints, and we
don't have a 100% testsuite coverage.

The switch to the new API needs to be done in one patch, that's obvious,
however all the code does not need to be in one patch. I suggest to
split generic preparatory changes, add basic framework for the new API,
then add the easy options, then by one the complicated ones, then do the
switch, then do the cleanup and removal of the old code. Yes it's more
work but if we have to debug anything in the future it'll be narrowed
down to a few short patches.

Previsous work (https://lore.kernel.org/linux-btrfs/20200812163654.17080-1-marcos@mpdesouza.com/)
has patches split but it's not following the suggestions.
