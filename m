Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4D7B5198
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjJBLoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJBLoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:44:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6ADD;
        Mon,  2 Oct 2023 04:44:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B99121857;
        Mon,  2 Oct 2023 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696247073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXWjSSlBJVOPDSwrXfZvR2ahtqs14JRak4I9NOcI2z0=;
        b=J4nEfWtlwwNaf7q2YgGB3wsF6Gqf7Fp1p+d9Mfb5dlPTt6lEOaGjrDsX5aXlWjjFBig5mb
        MKuabzJkgp3rRJ8714Z9cncgp7XjO9Xhz+4csilJv3TCCrrVEcoOso2WiZOBaAyOpzf/pd
        Z1W19SxSdVXwPchr22ERqFuVDA7ksGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696247073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXWjSSlBJVOPDSwrXfZvR2ahtqs14JRak4I9NOcI2z0=;
        b=GL722/WQMErreoDca0yEAJDS7/jK3cCmBxFh/3t0vwkUrz3Gs9DlLkyyV2VkBqbMFM9KR1
        aidUyE+VmqjrnqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DC5313456;
        Mon,  2 Oct 2023 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pzRzCiGtGmU5DgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 11:44:33 +0000
Date:   Mon, 2 Oct 2023 13:37:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/29] btrfs: move btrfs_xattr_handlers to .rodata
Message-ID: <20231002113752.GL13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-6-wedsonaf@gmail.com>
 <20231002112858.GK13697@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002112858.GK13697@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:28:58PM +0200, David Sterba wrote:
> On Sat, Sep 30, 2023 at 02:00:09AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This makes it harder for accidental or malicious changes to
> > btrfs_xattr_handlers at runtime.
> > 
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: linux-btrfs@vger.kernel.org
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> With slightly updated changelog added to misc-next, thanks.

Removed again. I did not notice first that this is part of a larger
series, please also CC the [PATCH 0/N] patch.

There's a warning:

fs/btrfs/super.c: In function ‘btrfs_fill_super’:
fs/btrfs/super.c:1107:21: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
 1107 |         sb->s_xattr = btrfs_xattr_handlers;
      |                     ^

but the patch changing the type is present in the series.

Please update the changelog of btrfs patch with:

    Add const specifier also to the pointed array members of
    btrfs_xattr_handlers.  This moves the whole structure to the .rodata
    section which makes it harder for accidental or malicious changes to
    btrfs_xattr_handlers at runtime.

or use it for others patches too.
