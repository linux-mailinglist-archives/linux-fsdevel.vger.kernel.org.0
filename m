Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD375B5AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGTRfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGTRfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:35:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7ECC;
        Thu, 20 Jul 2023 10:35:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1D7920505;
        Thu, 20 Jul 2023 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689874538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bx1yg3Jg+5Ltd8iqCFWRF8VuzeM7HV3z2vdytiQt5Yk=;
        b=PngWjs3AoBtc3UEXbsy4RXLMM+WwOXtOaETHMIKlObHITJNGj7FJZ4hPCKD54JDAk2nJAl
        pyA292JTp9N3ZP9LM60TZTYUWN5nLNFtfQnof0FRIZoLnjFItINkAuqulTEQVY9W8y/7TP
        Zjuj5PDDl3oZ08U1lzw77D6gIfjSvkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689874538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bx1yg3Jg+5Ltd8iqCFWRF8VuzeM7HV3z2vdytiQt5Yk=;
        b=xDCGVMAH4W5xpkJ3rw9cFHAVYgMRGr7QKLXhNDzAp/DC3RLxIESyxmyLvuLH96tj0bygov
        FqHF7Y/pNcuJo2Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6C48133DD;
        Thu, 20 Jul 2023 17:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bnjlImpwuWSLVQAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 20 Jul 2023 17:35:38 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Organization: SUSE
References: <20230719221918.8937-1-krisman@suse.de>
        <20230720074318.GA56170@sol.localdomain>
Date:   Thu, 20 Jul 2023 13:35:37 -0400
In-Reply-To: <20230720074318.GA56170@sol.localdomain> (Eric Biggers's message
        of "Thu, 20 Jul 2023 00:43:18 -0700")
Message-ID: <87y1ja4hau.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

>> Another problem exists when turning a negative dentry to positive.  If
>> the negative dentry has a different case than what is currently being
>> used for lookup, the dentry cannot be reused without changing its name,
>> in order to guarantee filename-preserving semantics to userspace.  We
>> need to either change the name or invalidate the dentry. This issue is
>> currently avoided in mainline, since the negative dentry mechanism is
>> disabled.
>
> Are you sure this problem even needs to be solved?

Yes, because we promise name-preserving semantics.  If we don't do it,
the name on the disk might be different than what was asked for, and tools
that rely on it (they exist) will break.  During initial testing, I've
had tools breaking with case-insensitive ext4 because they created a
file, did getdents and wanted to see exactly the name they used.

> It actually isn't specific to negative dentries.  If you have a file "foo"
> that's not in the dcache, and you open it (or look it up in any other way) as
> "FOO", then the positive dentry that gets created is named "FOO".
>
> As a result, the name that shows up in /proc/$pid/fd/ for anyone who has the
> file open is "FOO", not the true name "foo".  This is true even for processes
> that open it as "foo", as long as the dentry remains in the dcache.
>
> No negative dentries involved at all!

I totally agree it is goes beyond negative dentries, but this case is
particularly important because it is the only one (that I know of) where
the incorrect case might actually be written to the disk.  other cases,
like /proc/<pid>/fd/ can just display a different case to userspace,
which is confusing.  Still, the disk has the right version, exactly as
originally created.

I see the current /proc/$pid/fd/ semantics as a bug. In fact, I have/had
a bug report for bwrap/flatkpak breaking because it was mounting
something and immediately checking /proc/mounts to confirm it worked.  A
former team member tried fixing it a while ago, but we didn't follow up,
and I don't really love the way they did it.  I need to look into that.

> Or, it looks like the positive dentry case is solvable using d_add_ci().
> So maybe you are planning to do that?  It's not clear to me.

I want to use d_add_ci for the future, yes. It is not hard, but not
trivial, because there is an infinite recursion if d_add_ci uses
->d_compare() when doing the lookup for a duplicate.  We sent a patch to
fix d_add_ci a while ago, but it was rejected.  I need to revisit.

-- 
Gabriel Krisman Bertazi
