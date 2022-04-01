Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3D4EEB2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiDAKXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiDAKX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:23:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4E265E83;
        Fri,  1 Apr 2022 03:21:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6920210FC;
        Fri,  1 Apr 2022 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648808498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6j7ZT7bkdYajKU5r/6ynVxot5UlHjezND8fQiZAuQX4=;
        b=n63J6SOmkMp2ybc5+vCCoZ7ULGL1fw0/l35XLhKkZD+yvaagLReEDD3Oo3Ays2ia2y74Bg
        oQoIlya0g1F+srz24kXyTrt+1w7K5cKEnQBl5hjLqf7Gf3A9rF+FNpTyWRruM66+eBkX39
        xOp2lSg0LRwCc3tPsDVxaXJnivxeNw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648808498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6j7ZT7bkdYajKU5r/6ynVxot5UlHjezND8fQiZAuQX4=;
        b=nr0EAPO1rnGUOpZhLibt4u/d9+7P+Xlap6lXtOPZuVEw1ud1Bs6hNsraienxxmFihRYwgD
        NvlG8CcINkucmbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63825132C1;
        Fri,  1 Apr 2022 10:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PlpdFTLSRmLAdQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 01 Apr 2022 10:21:38 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c1ab856d;
        Fri, 1 Apr 2022 10:22:00 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/54] ceph: support legacy v1 encryption policy
 keysetup
References: <20220331153130.41287-1-jlayton@kernel.org>
        <20220331153130.41287-8-jlayton@kernel.org>
        <YkYMDRTcGC6sJO8l@gmail.com>
Date:   Fri, 01 Apr 2022 11:22:00 +0100
In-Reply-To: <YkYMDRTcGC6sJO8l@gmail.com> (Eric Biggers's message of "Thu, 31
        Mar 2022 20:16:13 +0000")
Message-ID: <87tubdp0hj.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Thu, Mar 31, 2022 at 11:30:43AM -0400, Jeff Layton wrote:
>> From: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>=20
>> fstests make use of legacy keysetup where the key description uses a
>> filesystem-specific prefix.  Add this ceph-specific prefix to the
>> fscrypt_operations data structure.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  fs/ceph/crypto.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index a513ff373b13..d1a6595a810f 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -65,6 +65,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
>>  }
>>=20=20
>>  static struct fscrypt_operations ceph_fscrypt_ops =3D {
>> +	.key_prefix		=3D "ceph:",
>>  	.get_context		=3D ceph_crypt_get_context,
>>  	.set_context		=3D ceph_crypt_set_context,
>>  	.empty_dir		=3D ceph_crypt_empty_dir,
>> --=20
>> 2.35.1
>>=20
>
> As I mentioned before
> (https://lore.kernel.org/r/20200908042925.GI68127@sol.localdomain), I don=
't
> think you should do this, given that the filesystem-specific key descript=
ion
> prefixes are deprecated.  In fact, they're sort of doubly deprecated, sin=
ce
> first they were superseded by "fscrypt:", and then "login" keys were
> superseded by FS_IOC_ADD_ENCRYPTION_KEY.
>
> How about updating fstests to use "fscrypt:" instead of "$FSTYP:" if $FST=
YP is
> not ext4 or f2fs?
>
> Or maybe fstests should just use "fscrypt:" unconditionally, given that t=
his has
> been supported by ext4 and f2fs since 4.8, and 4.9 is now the oldest supp=
orted
> LTS kernel.

OK, makes sense.  Thanks for the suggestion.  I'll follow-up with an
fstests patch to do what you suggest (use $FSTYP only for those 2
filesystems).

Cheers,
--=20
Lu=C3=ADs
