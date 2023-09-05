Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA48792D44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjIESQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjIESPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:15:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BEC4696;
        Tue,  5 Sep 2023 11:11:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 405471FF7A;
        Tue,  5 Sep 2023 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693937380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Guowg8vrYkUQOfyc0xSN81IhQOFpl7OhahsW/wptQCE=;
        b=IiNfsufpioek9C18fiFaMlHL/fCK6+H8LNRg9D1FPOUeJTlmx4/roW1fvNmW7Hwo9moDzG
        xiKjP/AbLJPqr3HSVBv6xwrAyfn+18u9HVl65Itu+wZRy/fZfxkjdhx7nEmYXrhwTQGQj+
        9FACn5M7NF8wBfMEP/+lYff+GN0GKPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693937380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Guowg8vrYkUQOfyc0xSN81IhQOFpl7OhahsW/wptQCE=;
        b=KTe2i8F19kFNoaOQIw2Hwbob6gAXh4Fj9gqGASbfYtgXNSyudoIsyE9MZR9+l/EYVkLbHx
        6EihoN7GQoAMJrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEF2113499;
        Tue,  5 Sep 2023 18:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FXQeOeNu92RRTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 18:09:39 +0000
Date:   Tue, 5 Sep 2023 20:02:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/2] Use exclusive lock for file_remove_privs
Message-ID: <20230905180259.GG14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831112431.2998368-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831112431.2998368-1-bschubert@ddn.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:24:29PM +0200, Bernd Schubert wrote:
> While adding shared direct IO write locks to fuse Miklos noticed
> that file_remove_privs() needs an exclusive lock. I then
> noticed that btrfs actually has the same issue as I had in my patch,
> it was calling into that function with a shared lock.
> This series adds a new exported function file_needs_remove_privs(),
> which used by the follow up btrfs patch and will be used by the
> DIO code path in fuse as well. If that function returns any mask
> the shared lock needs to be dropped and replaced by the exclusive
> variant.
> 
> Note: Compilation tested only.

The fix makes sense, there should be no noticeable performance impact,
basically the same check is done in the newly exported helper for the
IS_NOSEC bit.  I can give it a test locally for the default case, I'm
not sure if we have specific tests for the security layers in fstests.

Regarding merge, I can take the two patches via btrfs tree or can wait
until the export is present in Linus' tree in case FUSE needs it
independently.
