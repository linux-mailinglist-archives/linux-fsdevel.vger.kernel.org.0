Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E977B5179
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjJBLfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:35:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2DBF;
        Mon,  2 Oct 2023 04:35:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 145BA1F460;
        Mon,  2 Oct 2023 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696246540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ltmYzRXSXlU8gSXohvfQI4hIoo+0yDGOjKekJCMcZo=;
        b=xDUQuM2qNeq085ebVw5QSP/Gabzh2CWtV2WuFqW2jTzKAzzQQaX71USbhunLNnWjhJEDCJ
        4SrsHhYkJnN8uvErW7k1YsesrntTU5BOLe071UfRd/BBmwDhvWVnaeS7arInhT+Vp9vBNx
        gHbT7gMZxSb1B/qWQhDuoY2OzTc5ISw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696246540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ltmYzRXSXlU8gSXohvfQI4hIoo+0yDGOjKekJCMcZo=;
        b=Pbxxerle8m3Y9QH4qWT80H0tmCBuSGC8JsVijHOI8EuWn/rIkPa3onFp7YhYefIFwPheTl
        tg95inoxzmcS1EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC9E313456;
        Mon,  2 Oct 2023 11:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u4dQKQurGmV+CQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 11:35:39 +0000
Date:   Mon, 2 Oct 2023 13:28:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/29] btrfs: move btrfs_xattr_handlers to .rodata
Message-ID: <20231002112858.GK13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-6-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-6-wedsonaf@gmail.com>
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

On Sat, Sep 30, 2023 at 02:00:09AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> btrfs_xattr_handlers at runtime.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

With slightly updated changelog added to misc-next, thanks.
