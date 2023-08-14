Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88E77BC51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjHNPEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjHNPDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:03:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C618F;
        Mon, 14 Aug 2023 08:03:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 619152189D;
        Mon, 14 Aug 2023 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692025431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikjBFN0Ka0bI757B2lq4/0p/MfhZslYWurHfE0DdwD8=;
        b=MpYoaQnS+SFuOKQ7652w6g2RWyh5yDEplZ81k9aqvAJDkZhDc3os45n/TeqR40F8RVMgLI
        eWaFiuMRddskL9tqr7YMoBsR8wBp7mpswDwKhjNn62pcPNsD9KR9TzaYgZYV0OXELJ2EFP
        ceA6osOg/ooSVVSsS4MmGzMlAJJo3Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692025431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikjBFN0Ka0bI757B2lq4/0p/MfhZslYWurHfE0DdwD8=;
        b=6yX3Wz+/qiLF41yBjPsUdVlWjvvhqL3oZhYAH875G3cnL9WLwLhjpdvCO8OUr0bLp/QHyH
        E3IWOV9Xld4Y9QBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18BC3138EE;
        Mon, 14 Aug 2023 15:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 39ceOlZC2mSVDAAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 15:03:50 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 05/10] fs: Add DCACHE_CASEFOLDED_NAME flag
In-Reply-To: <20230812021700.GC971@sol.localdomain> (Eric Biggers's message of
        "Fri, 11 Aug 2023 19:17:00 -0700")
Organization: SUSE
References: <20230812004146.30980-1-krisman@suse.de>
        <20230812004146.30980-6-krisman@suse.de>
        <20230812021700.GC971@sol.localdomain>
Date:   Mon, 14 Aug 2023 11:03:49 -0400
Message-ID: <871qg57jje.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Aug 11, 2023 at 08:41:41PM -0400, Gabriel Krisman Bertazi wrote:
>> +void d_set_casefolded_name(struct dentry *dentry)
>> +{
>> +	spin_lock(&dentry->d_lock);
>> +	dentry->d_flags |= DCACHE_CASEFOLDED_NAME;
>> +	spin_unlock(&dentry->d_lock);
>> +}
>> +EXPORT_SYMBOL(d_set_casefold_lookup);
>
> s/d_set_casefold_lookup/d_set_casefolded_name/

My apologies for this error again.  It sucks there is no compile-time
warning for EXPORT_SYMBOL, but I should have caught it in the past two
iterations.  Will fix.

-- 
Gabriel Krisman Bertazi
