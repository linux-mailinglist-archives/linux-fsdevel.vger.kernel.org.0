Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7746EE1E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjDYMcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjDYMcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:32:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F6312CBA
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 05:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 806CE219CC;
        Tue, 25 Apr 2023 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682425962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWUaTY7zPvGDq1lV5PTAVmKwmRffgKuL2Z++9PCwg3c=;
        b=l6SZcYPuHVYq6KDxG9bII8FjIqBv8sn5/osem8A9zypcIRAmEfV/4KlTmZHU/f44UpM7CN
        PlnCnX9CAMriBfwS+6iXUp/Qo3DVtvUkwxi8qxEtlnwCRl3JlW3qBqmDaNbDPjItgNEZSd
        PJnqbhRFuSKEl4eeYqrx7szOi+NofsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682425962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWUaTY7zPvGDq1lV5PTAVmKwmRffgKuL2Z++9PCwg3c=;
        b=SnqD8o94EjcTbND7Bxd0UCqrQVVYlIYIEW1Ss5sFJwjVgKcr9iaFr8WYerGTf/M9H+jXBS
        TXHFRrI0vMR6NcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72E03138E3;
        Tue, 25 Apr 2023 12:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h6QKHGrIR2RBcQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Apr 2023 12:32:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1BE9A0729; Tue, 25 Apr 2023 14:32:41 +0200 (CEST)
Date:   Tue, 25 Apr 2023 14:32:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V3 2/6] shmem: make shmem_get_inode() return ERR_PTR
 instead of NULL
Message-ID: <20230425123241.4lrtqdtlhgri7o2p@quack3>
References: <20230420080359.2551150-3-cem@kernel.org>
 <20230425115400.2913497-1-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425115400.2913497-1-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-04-23 13:54:00, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Make shmem_get_inode() return ERR_PTR instead of NULL on error. This will be
> useful later when we introduce quota support.
> 
> There should be no functional change.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
