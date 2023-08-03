Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35ED76F028
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHCQ5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjHCQ5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:57:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674C4227;
        Thu,  3 Aug 2023 09:56:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 412A72190C;
        Thu,  3 Aug 2023 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691081775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jmGqv5VrNNN6mYDaT468r0ysSqZdLXbTiuCY1iyBvU=;
        b=TxLd0HeM/26VTzN2RSiMjSK4UA3aEVWxf4yVMDutyM05qIwSgDCqDgsa4pgtOeWDs8bpE7
        9EQ/OYgGQZ9VHx8Z8vLkWVfbp9OSxthffiYgt4wEM0On5oXqPGKEaaO7IW4faSykVkUTPT
        846xrgWZ0KteXI9VCUKtPOuQyi8VRy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691081775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jmGqv5VrNNN6mYDaT468r0ysSqZdLXbTiuCY1iyBvU=;
        b=pcPBq4k4ZIU5vU52Pylta0bS+0mjQ8UQdrzUfpsvtxc3eFTqdyVquXgDMV3ksWRn7STD08
        pVxc2SYgy1TUyMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 090E01333C;
        Thu,  3 Aug 2023 16:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xScbOC7cy2SpVwAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 03 Aug 2023 16:56:14 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
        <20230727172843.20542-4-krisman@suse.de>
        <20230729045156.GD4171@sol.localdomain>
Date:   Thu, 03 Aug 2023 12:56:13 -0400
In-Reply-To: <20230729045156.GD4171@sol.localdomain> (Eric Biggers's message
        of "Fri, 28 Jul 2023 21:51:56 -0700")
Message-ID: <87bkfo12vm.fsf@suse.de>
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

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
>> dentry->d_name is only checked by the case-insensitive d_revalidate hook
>> in the LOOKUP_CREATE/LOOKUP_RENAME_TARGET case since, for these cases,
>> d_revalidate is always called with the parent inode read-locked, and
>> therefore the name cannot change from under us.
>
> "at least read-locked"?  Or do you actually mean write-locked?

No. I mean read-locked, as in holding the read-part of the inode lock.
This is the case for lookup_slow, which is safe, despite the d_add_ci
case we discussed in the previous iteration.  I'll reword to say "at
least read-locked and mention it is the case in lookup_slow".

>> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
>> +					  const struct qstr *name,
>> +					  unsigned int flags)
>
> No need for inline here.

sorry, I missed the inline from your previuos review.  Will fix it up
for this one.


>
> - Eric

-- 
Gabriel Krisman Bertazi
