Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE1765B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjG0SkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0Sj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:39:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE82D5D;
        Thu, 27 Jul 2023 11:39:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8394821A6C;
        Thu, 27 Jul 2023 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690483197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=;
        b=pY7xJfduW/6AevRW1gpBnw2+o/lalqgiGdpIpgb8a36fV0VPJQbFJpeKD/+iHajpAxFQoZ
        WxDrI+mh2W7AghNhOiiYqd00cY2hnkBeuUtKKh3EqFU4K2blkRL6eM/DJRuF30KmLelK8Z
        cAJ69xSHsw1KGSoZ/V3fdghqT55UXFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690483197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=;
        b=ZLBm2/R+T5G/C7PnCLDJwK+SOfa4pb3gmcixk2m0cqwJVAMWXz9y7botWgDEYF2IHH2wph
        Qjor1waHfaUejSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D579138E5;
        Thu, 27 Jul 2023 18:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N016Cf25wmTfCQAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 27 Jul 2023 18:39:57 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, ebiggers@kernel.org,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
        <20230727181339.GH30264@mit.edu>
Date:   Thu, 27 Jul 2023 14:39:55 -0400
In-Reply-To: <20230727181339.GH30264@mit.edu> (Theodore Ts'o's message of
        "Thu, 27 Jul 2023 14:13:39 -0400")
Message-ID: <87cz0d2o78.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Jul 27, 2023 at 01:28:36PM -0400, Gabriel Krisman Bertazi wrote:
>> This is the v4 of the negative dentry support on case-insensitive
>> directories.  It doesn't have any functional changes from v1. It applies
>> Eric's comments to bring the flags check closet together, improve the
>> documentation and improve comments in the code.  I also relooked at the
>> locks to ensure the inode read lock is indeed enough in the lookup_slow
>> path.
>
> Al, Christian, any thoughts or preferences for how we should handle
> this patch series?  I'm willing to take it through the ext4 tree, but
> since it has vfs, ext4, and f2fs changes (and the bulk of the changes
> are in the vfs), perhaps it should go through the vfs tree?
>
> Also, Christian, I notice one of the five VFS patches in the series
> has your Reviewed-by tag, but not the others?  Is that because you
> haven't had a chance to make a final determination on those patches,
> or you have outstanding comments still to be addressed?

Hi Ted,

Thanks for helping push it forward!

I'm not sure if I missed Christian's tag in a previous iteration. I
looked through my archive and didn't find it. Unless I'm mistaken, I
don't think I have any r-b from him here yet.

-- 
Gabriel Krisman Bertazi
