Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C147B207D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjI1PGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjI1PGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:06:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48431194;
        Thu, 28 Sep 2023 08:06:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6AED1F45A;
        Thu, 28 Sep 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695913601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvZ2+lVVGC6fG0+TRC9F7fERAgSpJyW4xAyt96q+Vxc=;
        b=ptCb4TYC9YIVqfS0D/JnTThCt0sxx34Ez/BPz+d/vIoTaGgsjrQt9CHdoYPmKnDl6Vmarh
        E4TWTAqwhEKcx3Mg9zxMQ/fkC/GEZFnUJc3gt0AwVkiRzV4Et26KMisDfjIUj0eEo9FEPq
        8rYjoRH1uiAzlHqCWAM6+cTZRR7IloI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695913601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvZ2+lVVGC6fG0+TRC9F7fERAgSpJyW4xAyt96q+Vxc=;
        b=eZXGn5WYGpuUYBxLrc2R6x3cywtFddiSOY5dU3T2qpkP9eTjacRpEkSU0VKcnupuj1aUVM
        g+4hX5BouSriSZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FC8E138E9;
        Thu, 28 Sep 2023 15:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ygAfFIGWFWUkIwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 28 Sep 2023 15:06:41 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 55947dc4;
        Thu, 28 Sep 2023 15:06:40 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible extra iput() in do_unlinkat()
In-Reply-To: <20230928134513.l2y3eknt2hfq3qgx@f> (Mateusz Guzik's message of
        "Thu, 28 Sep 2023 15:45:13 +0200")
References: <20230928131129.14961-1-lhenriques@suse.de>
        <20230928134513.l2y3eknt2hfq3qgx@f>
Date:   Thu, 28 Sep 2023 16:06:40 +0100
Message-ID: <878r8q1gn3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Thu, Sep 28, 2023 at 02:11:29PM +0100, Lu=C3=ADs Henriques wrote:
>> Because inode is being initialised before checking if dentry is negative,
>> and the ihold() is only done if the dentry is *not* negative, the cleanup
>> code may end-up doing an extra iput() on that inode.
>>=20
>> Fixes: b18825a7c8e3 ("VFS: Put a small type field into struct dentry::d_=
flags")
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>> Hi!
>>=20
>> I was going to also remove the 'if (inode)' before the 'iput(inode)',
>> because 'iput()' already checks for NULL anyway.  But since I probably
>> wouldn't have caught this bug if it wasn't for that 'if', I decided to
>> keep it there.  But I can send v2 with that change too if you prefer.
>>=20
>> Cheers,
>> --
>> Lu=C3=ADs
>>=20
>>  fs/namei.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>=20
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 567ee547492b..156a570d7831 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -4386,11 +4386,9 @@ int do_unlinkat(int dfd, struct filename *name)
>>  	if (!IS_ERR(dentry)) {
>>=20=20
>>  		/* Why not before? Because we want correct error value */
>> -		if (last.name[last.len])
>> +		if (last.name[last.len] || d_is_negative(dentry))
>>  			goto slashes;
>>  		inode =3D dentry->d_inode;
>> -		if (d_is_negative(dentry))
>> -			goto slashes;
>>  		ihold(inode);
>>  		error =3D security_path_unlink(&path, dentry);
>>  		if (error)
>
> I ran into this myself, but I'm pretty sure there is no bug here. The
> code is just incredibly misleading and it became this way from the
> sweeping change introducing d_is_negative. I could not be bothered to
> argue about patching it so I did not do anything. ;)
>
> AFAICS it is an invariant that d_is_negative passes iff d_inode is NULL.

Ah! yes, of course.  Makes sense.  Thanks for your review.

> Personally I support the patch, but commit message needs to stop
> claiming a bug.

OK, I'll rephrase the commit message for v2 so that it's clear it's not
really fixing anything, it just helps clarifying some misleading code
paths.  (Although, to be fair, the commit message doesn't really
explicitly call it a bug :-) ).

Cheers,
--=20
Lu=C3=ADs
