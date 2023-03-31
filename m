Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1C6D2406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjCaPbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCaPbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:31:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60EB1D2E7;
        Fri, 31 Mar 2023 08:31:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D86C219C6;
        Fri, 31 Mar 2023 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680276676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mjlb0/eHfvgS2ZXDdMn4kdD62mILFu+OjmdPhxiyTJU=;
        b=RRIGNMGk6XvNTiArrMsl+QcESXBJGs9NjtsuoiZC2LuAzOVV+RQqa5rh5aA2pqiT9wuhHO
        /eKtlv46Iov/okzaFBNkqjlowo5qfqoDb9FZno0NVJvTNrYSSSLZ1loy7H463xuedzRcya
        7/VqOltMaqAYn2YSeO3ic/w2iYOmYhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680276676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mjlb0/eHfvgS2ZXDdMn4kdD62mILFu+OjmdPhxiyTJU=;
        b=AYJWCk4OYFBa7u8prX6m7h4FVCbcEypLc/iV6GW7AjiptLQSdX4is1shSP8Hshubtx8riE
        0Sfpm5wwLn8grHCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC8B133B6;
        Fri, 31 Mar 2023 15:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4LwCJMP8JmQMDAAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 31 Mar 2023 15:31:15 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel@collabora.com, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 3/7] libfs: Validate negative dentries in
 case-insensitive directories
References: <20220622194603.102655-1-krisman@collabora.com>
        <20220622194603.102655-4-krisman@collabora.com>
        <20230326044627.GD3390869@ZenIV>
Date:   Fri, 31 Mar 2023 12:31:13 -0300
In-Reply-To: <20230326044627.GD3390869@ZenIV> (Al Viro's message of "Sun, 26
        Mar 2023 05:46:27 +0100")
Message-ID: <874jq10wfy.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Jun 22, 2022 at 03:45:59PM -0400, Gabriel Krisman Bertazi wrote:
>
>> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
>> +					  const struct qstr *name,
>> +					  unsigned int flags)
>> +{
>> +	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
>> +
>> +	if (d_is_negative(dentry)) {
>> +		const struct dentry *parent = READ_ONCE(dentry->d_parent);
>> +		const struct inode *dir = READ_ONCE(parent->d_inode);
>> +
>> +		if (dir && needs_casefold(dir)) {
>> +			if (!d_is_casefold_lookup(dentry))
>> +				return 0;
>
> 	In which conditions does that happen?

Hi Al,

This can happen right after a case-sensitive directory is converted to
case-insensitive. A previous case-sensitive lookup could have left a
negative dentry in the dcache that we need to reject, because it doesn't
have the same assurance of absence of all-variation of names as a
negative dentry created during a case-insensitive lookup.

>> +			if (is_creation &&
>> +			    (dentry->d_name.len != name->len ||
>> +			     memcmp(dentry->d_name.name, name->name, name->len)))
>> +				return 0;
>> +		}
>> +	}
>> +	return 1;
>> +}
>
> 	Analysis of stability of ->d_name, please.  It's *probably* safe, but
> the details are subtle and IMO should be accompanied by several asserts.
> E.g. "we never get LOOKUP_CREATE in op->intent without O_CREAT in op->open_flag
> for such and such reasons, and we verify that in such and such place"...
>
> 	A part of that would be "the call in lookup_dcache() can only get there
> with non-zero flags when coming from __lookup_hash(), and that has parent locked,
> stabilizing the name; the same goes for the call in __lookup_slow(), with the
> only call chain with possibly non-zero flags is through lookup_slow(), where we
> have the parent locked".  However, lookup_fast() and lookup_open() have the
> flags come from nd->flags, and LOOKUP_CREATE can be found there in several areas.
> I _think_ we are guaranteed the parent locked in all such call chains, but that
> is definitely worth at least a comment.

Thanks for the example of the analysis what you are looking for here.
That will help me quite a bit.  I wrote this code a while ago and I
don't recall the exact details.  I will go through the code again and
send a new version with the detailed analysis.

-- 
Gabriel Krisman Bertazi
