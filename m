Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79777BC03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHNOul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjHNOuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:50:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041A10E3;
        Mon, 14 Aug 2023 07:50:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 556941FD60;
        Mon, 14 Aug 2023 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692024615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6QIsNcUwY8iaBQqkPm5CJUyjIlEcOaJL8XUAsTGurs=;
        b=d0ip1fpopDbZZIpEG2n3ugzEJDCgNjtoWycFPUrAgciZqLVQXjz5vH9T/jrLsIVIpoCg0w
        D4JrQl8IX/TT6mKO6w11eu6jZgcP39M/xI2ZdgkATpnKJEFFwNIdLqmRn+Yu61RA5PBVsA
        qSWnEpZ4P+rDioQqbjMVhBdJBGy1Pso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692024615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6QIsNcUwY8iaBQqkPm5CJUyjIlEcOaJL8XUAsTGurs=;
        b=EMCLmF8DPJ4gucLOmtGbdPWovgTA592tSqk9udFjlxy6BE/iRLBkhKYf01o3XmDnF04e8h
        qOFz+0n8e9NifWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01810138EE;
        Mon, 14 Aug 2023 14:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AG+pMCY/2mT+BQAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 14:50:14 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 06/10] libfs: Validate negative dentries in
 case-insensitive directories
In-Reply-To: <20230812024145.GD971@sol.localdomain> (Eric Biggers's message of
        "Fri, 11 Aug 2023 19:41:45 -0700")
Organization: SUSE
References: <20230812004146.30980-1-krisman@suse.de>
        <20230812004146.30980-7-krisman@suse.de>
        <20230812024145.GD971@sol.localdomain>
Date:   Mon, 14 Aug 2023 10:50:13 -0400
Message-ID: <87a5ut7k62.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Aug 11, 2023 at 08:41:42PM -0400, Gabriel Krisman Bertazi wrote:
>> +	/*
>> +	 * Filesystems will call into d_revalidate without setting
>> +	 * LOOKUP_ flags even for file creation (see lookup_one*
>> +	 * variants).  Reject negative dentries in this case, since we
>> +	 * can't know for sure it won't be used for creation.
>> +	 */
>> +	if (!flags)
>> +		return 0;
>> +
>> +	/*
>> +	 * If the lookup is for creation, then a negative dentry can
>> +	 * only be reused if it's a case-sensitive match, not just a
>> +	 * case-insensitive one.  This is needed to make the new file be
>> +	 * created with the name the user specified, preserving case.
>> +	 */
>> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
>> +		/*
>> +		 * ->d_name won't change from under us in the creation
>> +		 * path only, since d_revalidate during creation and
>> +		 * renames is always called with the parent inode
>> +		 * locked.  It isn't the case for all lookup callpaths,
>> +		 * so ->d_name must not be touched outside
>> +		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
>> +		 */
>> +		if (dentry->d_name.len != name->len ||
>> +		    memcmp(dentry->d_name.name, name->name, name->len))
>> +			return 0;
>> +	}
>
> This is still really confusing to me.  Can you consider the below?  The code is
> the same except for the reordering, but the explanation is reworked to be much
> clearer (IMO).  Anything I am misunderstanding?
>
> 	/*
> 	 * If the lookup is for creation, then a negative dentry can only be
> 	 * reused if it's a case-sensitive match, not just a case-insensitive
> 	 * one.  This is needed to make the new file be created with the name
> 	 * the user specified, preserving case.
> 	 *
> 	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
> 	 * cases, ->d_name is stable and can be compared to 'name' without
> 	 * taking ->d_lock because the caller holds dir->i_rwsem for write.
> 	 * (This is because the directory lock blocks the dentry from being
> 	 * concurrently instantiated, and negative dentries are never moved.)
> 	 *
> 	 * All other creations actually use flags==0.  These come from the edge
> 	 * case of filesystems calling functions like lookup_one() that do a
> 	 * lookup without setting the lookup flags at all.  Such lookups might
> 	 * or might not be for creation, and if not don't guarantee stable
> 	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
> 	 */
> 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> 		if (dentry->d_name.len != name->len ||
> 		    memcmp(dentry->d_name.name, name->name, name->len))
> 			return 0;
> 	}
> 	if (!flags)
> 		return 0;

I don't see it as particularly better or less confusing than the
original. but I also don't mind taking it into the next iteration.

-- 
Gabriel Krisman Bertazi
