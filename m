Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2219D7670F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjG1PtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjG1PtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:49:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9CE0;
        Fri, 28 Jul 2023 08:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EB981F8A3;
        Fri, 28 Jul 2023 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690559342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WraNl6n1+7jI6xXHbPsuy6St/2gdjjWwknimz9pA0c4=;
        b=NOjZQExpGN1h+BnjL4x/+zDY7xA/osu0t+Eb/ODtkzqlxS/WNF212zks42/FQL97++dGXy
        X7VSMRJQi5ZEJVgf2DrPMSWQ7HHP8DedqN0WL8SzC0yqB+VnwCC/VxcOlLNjKVKBlJye81
        5gMZeYJknfsnejRgrb25EMm/2XSeBWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690559342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WraNl6n1+7jI6xXHbPsuy6St/2gdjjWwknimz9pA0c4=;
        b=OytHCysNU0rLyHfQ/8nppZIFxwhUdNsbC4LiV4pWZDlBg0cs96Gh0PM+XI5/WsTYo82F7m
        2oZWSNEh6AiRh8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28FA9133F7;
        Fri, 28 Jul 2023 15:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MeSBBG7jw2SRTQAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 28 Jul 2023 15:49:02 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, ebiggers@kernel.org,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 1/7] fs: Expose name under lookup to d_revalidate hook
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
        <20230727172843.20542-2-krisman@suse.de>
        <20230728-unrentabel-volumen-1500701f2524@brauner>
Date:   Fri, 28 Jul 2023 11:49:00 -0400
In-Reply-To: <20230728-unrentabel-volumen-1500701f2524@brauner> (Christian
        Brauner's message of "Fri, 28 Jul 2023 16:00:10 +0200")
Message-ID: <87mszg11g3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

>> -static inline int d_revalidate(struct dentry *dentry, unsigned int flag=
s)
>> +static inline int d_revalidate(struct dentry *dentry,
>> +			       const struct qstr *name,
>> +			       unsigned int flags)
>>  {
>> -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
>> +
>> +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE)) {
>> +		if (dentry->d_op->d_revalidate_name)
>> +			return dentry->d_op->d_revalidate_name(dentry, name, flags);
>>  		return dentry->d_op->d_revalidate(dentry, flags);
>
> This whole sequence got me thinking.
>

...

> ubuntu@imp1-vm:~$ sudo mount -t ecryptfs /mnt/test/casefold-dir /opt
> ubuntu@imp1-vm:/opt$ findmnt | grep opt
> =E2=94=94=E2=94=80/opt  /mnt/test/casefold-dir ecryptfs rw,relatime,ecryp=
tfs_sig=3D8567ee2ae5880f2d,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D16,ec=
ryptfs_unlink_sigs

That's interesting.  I was aware of overlayfs and wanted to eventually
get it to work together with casefold, but never considered an ecryptfs com=
bo.

> So it doesn't even seem to care if the underlying filesytem uses a
> custom dentry hash function which seems problematic (So unrelated to
> this change someone should likely explain why that doesn't matter.).
>
> Afaict with your series this will be even more broken because ecryptfs
> and overlayfs call ->d_revalidate() directly.
>
> So this suggests that really you want to extend ->d_revalidate() and we
> should at least similar to overlayfs make ecryptfs reject being mounted
> on casefolding directories and refuse lookup requests for casefolding
> directories.
>
> Ideally we'd explicitly reject by having such fses detect casefolding
> unless it's really enough to reject based on DCACHE_OP_HASH.

Thanks for finding this issue. I'll follow up with merging d_revalidate
and d_revalidate_name and adding a patch to explicitly reject
combinations of ecryptfs/overlayfs with casefolding filesystems, and
safeguard the lookup.

--=20
Gabriel Krisman Bertazi
