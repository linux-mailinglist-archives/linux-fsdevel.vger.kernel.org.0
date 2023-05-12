Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB2700195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjELHhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbjELHhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 03:37:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348F9EC1;
        Fri, 12 May 2023 00:37:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B15232026A;
        Fri, 12 May 2023 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683877021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3l2RcZ5OiQDlOAZwVC4wZDp7xE/KP28JMr7T0JUjHIA=;
        b=xzqi8jnuIyijNa3h3Plecfa5lXXF/5hJh89LbsnedU/pSZeIgI0SEkD7EYwfLZv325vFEn
        2mPoHGIj2uebGwWGnpLQvR6pYsqcDKys9HMg4CoP9RrvQbKJboEXY8Lz8hVPLoh9Mxf4z5
        cmeQHbPuTS+vwgn9LkqPkRuEe/f2ebM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683877021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3l2RcZ5OiQDlOAZwVC4wZDp7xE/KP28JMr7T0JUjHIA=;
        b=NtkLUxu2q7fOZ72b/4eRcRYWyKuW9U/jX1XOU79nKwwGAlClPStBTA2UwWxyRRGs9kOjxL
        gyunVyN4heX0joCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 253CA13499;
        Fri, 12 May 2023 07:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7gy2B53sXWTvCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 12 May 2023 07:37:01 +0000
Date:   Fri, 12 May 2023 09:31:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] filesystems: start removal of the kthread freezer
Message-ID: <20230512073100.GC32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508011927.4036707-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011927.4036707-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 06:19:24PM -0700, Luis Chamberlain wrote:
> Here's 3 filesystems converted over to remove the kthread freezer.
> 
> Luis Chamberlain (3):
>   ext4: replace kthread freezing with auto fs freezing
>   btrfs: replace kthread freezing with auto fs freezing
>   xfs: replace kthread freezing with auto fs freezing

All patches add FS_AUTOFREEZE but I don't see it defined anywhere, it's
not in linux-next either. Also please drop the SMPL code from the
changelog, it's not necessary for such targeted change (unlike for a
tree-wide one).
