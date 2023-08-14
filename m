Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67CE77C0AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjHNTWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjHNTVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:21:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947049C;
        Mon, 14 Aug 2023 12:21:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 577F51F383;
        Mon, 14 Aug 2023 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692040900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jzzn8+qqnOw38PmfYxXIcDGGTpBS4WuGqRA3fqMPuAU=;
        b=MKHUgKneApSsGx0nG2tQW9u3CoizNz6iCXpRUgpujLMqlj3o3YIMw7ihFbf8kj9/VxnKu2
        jYcgftdqx+kNpj/7m3465M71joDn93Q9SfKbNcOlIULi1qwS5SvdUS/YwYMLRPAeuJpFux
        qx8QpErb77ns7yYEs0ptjJPTl86AmEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692040900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jzzn8+qqnOw38PmfYxXIcDGGTpBS4WuGqRA3fqMPuAU=;
        b=yn6rrKXwoA1JZLMto/hqDFljlhbOB2NKuypOrzq6rhmtQUhss8WNzU1FWhv6zTFVL0JK5T
        vsIZrkPqr8nvo8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CD85138EE;
        Mon, 14 Aug 2023 19:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wjyQNsN+2mSMewAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 19:21:39 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 06/10] libfs: Validate negative dentries in
 case-insensitive directories
In-Reply-To: <20230814184214.GB1171@sol.localdomain> (Eric Biggers's message
        of "Mon, 14 Aug 2023 11:42:14 -0700")
Organization: SUSE
References: <20230812004146.30980-1-krisman@suse.de>
        <20230812004146.30980-7-krisman@suse.de>
        <20230812024145.GD971@sol.localdomain> <87a5ut7k62.fsf@suse.de>
        <20230814184214.GB1171@sol.localdomain>
Date:   Mon, 14 Aug 2023 15:21:33 -0400
Message-ID: <87fs4l5t1e.fsf@suse.de>
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

> On Mon, Aug 14, 2023 at 10:50:13AM -0400, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > On Fri, Aug 11, 2023 at 08:41:42PM -0400, Gabriel Krisman Bertazi wrote:
>> >> +	/*
>> >> +	 * Filesystems will call into d_revalidate without setting
>> >> +	 * LOOKUP_ flags even for file creation (see lookup_one*
>> >> +	 * variants).  Reject negative dentries in this case, since we
>> >> +	 * can't know for sure it won't be used for creation.
>> >> +	 */
>> >> +	if (!flags)
>> >> +		return 0;
>> >> +
>> >> +	/*
>> >> +	 * If the lookup is for creation, then a negative dentry can
>> >> +	 * only be reused if it's a case-sensitive match, not just a
>> >> +	 * case-insensitive one.  This is needed to make the new file be
>> >> +	 * created with the name the user specified, preserving case.
>> >> +	 */
>> >> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
>> >> +		/*
>> >> +		 * ->d_name won't change from under us in the creation
>> >> +		 * path only, since d_revalidate during creation and
>> >> +		 * renames is always called with the parent inode
>> >> +		 * locked.  It isn't the case for all lookup callpaths,
>> >> +		 * so ->d_name must not be touched outside
>> >> +		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
>> >> +		 */
>> >> +		if (dentry->d_name.len != name->len ||
>> >> +		    memcmp(dentry->d_name.name, name->name, name->len))
>> >> +			return 0;
>> >> +	}
>> >
>> > This is still really confusing to me.  Can you consider the below?  The code is
>> > the same except for the reordering, but the explanation is reworked to be much
>> > clearer (IMO).  Anything I am misunderstanding?
>> >
>> > 	/*
>> > 	 * If the lookup is for creation, then a negative dentry can only be
>> > 	 * reused if it's a case-sensitive match, not just a case-insensitive
>> > 	 * one.  This is needed to make the new file be created with the name
>> > 	 * the user specified, preserving case.
>> > 	 *
>> > 	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
>> > 	 * cases, ->d_name is stable and can be compared to 'name' without
>> > 	 * taking ->d_lock because the caller holds dir->i_rwsem for write.
>> > 	 * (This is because the directory lock blocks the dentry from being
>> > 	 * concurrently instantiated, and negative dentries are never moved.)
>> > 	 *
>> > 	 * All other creations actually use flags==0.  These come from the edge
>> > 	 * case of filesystems calling functions like lookup_one() that do a
>> > 	 * lookup without setting the lookup flags at all.  Such lookups might
>> > 	 * or might not be for creation, and if not don't guarantee stable
>> > 	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
>> > 	 */
>> > 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
>> > 		if (dentry->d_name.len != name->len ||
>> > 		    memcmp(dentry->d_name.name, name->name, name->len))
>> > 			return 0;
>> > 	}
>> > 	if (!flags)
>> > 		return 0;
>> 
>> I don't see it as particularly better or less confusing than the
>> original. but I also don't mind taking it into the next iteration.
>> 
>
> Your commit message is still much longer and covers some quite different details
> which seem irrelevant to me.  So if you don't see my explanation as being much
> different, I think we're still not on the same page.  I hope that I'm not
> misunderstanding anything, in which I believe that what I wrote above is a good
> explanation and your commit message should be substantially simplified.
> Remember, longer != better.  Keep things as simple as possible.

I think we are on the same page regarding the code.  I was under the
impression your suggestion was regarding the *code comment* you proposed
to replace, and not the commit message.  I don't see your code comment
to be much different than the original.

The commit message has information accumulated on previous discussions,
including the conclusions from the locking discussion Viro requested.
I'll reword it too for the next iteration to see if I can make it more
concise.

Thx

-- 
Gabriel Krisman Bertazi
