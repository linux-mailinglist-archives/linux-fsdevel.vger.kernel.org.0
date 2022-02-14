Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39E4B460D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 10:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiBNJ3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 04:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbiBNJ3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:29:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8688860D86;
        Mon, 14 Feb 2022 01:28:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47004210EC;
        Mon, 14 Feb 2022 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644830938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBbMTJpDDz6GztWt9SqUB6s+Tj4ZYVeiGMOr+s1OTiU=;
        b=TPAQECjW0ExXqWvYAL4ncBpDYqUIZiexi/Nj8+oWCNvRU6T6boKETd3NSu4dMJGE8aiVHY
        zHAbhLt/cOZgLnbYwd1EZlsCfbLj+AKoaTrZ+W3gsZr5qa2me75Px2DJY9VUJ0Q5zqCv2Z
        C/WdsEP2YVlWaiy3HwGt0T0+9iUIJYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644830938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBbMTJpDDz6GztWt9SqUB6s+Tj4ZYVeiGMOr+s1OTiU=;
        b=D45fv3Hxio7NMM/nNvrWmMP69/jCBsBV1ZkRzmPk63j7lGEYt69gIS21rSwuZUgeeN1Udi
        2kXLtrcN295YRQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDDD313A3C;
        Mon, 14 Feb 2022 09:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b6hiK9kgCmLUIwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Feb 2022 09:28:57 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 212194ac;
        Mon, 14 Feb 2022 09:29:11 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 10/48] ceph: implement -o test_dummy_encryption
 mount option
References: <20220111191608.88762-1-jlayton@kernel.org>
        <20220111191608.88762-11-jlayton@kernel.org>
        <87h795v7fn.fsf@brahms.olymp>
        <f959ba0ab5916b5954fdf96eca49e0a85f581b61.camel@kernel.org>
Date:   Mon, 14 Feb 2022 09:29:11 +0000
In-Reply-To: <f959ba0ab5916b5954fdf96eca49e0a85f581b61.camel@kernel.org> (Jeff
        Layton's message of "Fri, 11 Feb 2022 09:52:34 -0500")
Message-ID: <87a6et94pk.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Fri, 2022-02-11 at 13:50 +0000, Lu=C3=ADs Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>>=20
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/ceph/crypto.c | 53 ++++++++++++++++++++++++++++++++
>> >  fs/ceph/crypto.h | 26 ++++++++++++++++
>> >  fs/ceph/inode.c  | 10 ++++--
>> >  fs/ceph/super.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
>> >  fs/ceph/super.h  | 12 +++++++-
>> >  fs/ceph/xattr.c  |  3 ++
>> >  6 files changed, 177 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> > index a513ff373b13..017f31eacb74 100644
>> > --- a/fs/ceph/crypto.c
>> > +++ b/fs/ceph/crypto.c
>> > @@ -4,6 +4,7 @@
>> >  #include <linux/fscrypt.h>
>> >=20=20
>> >  #include "super.h"
>> > +#include "mds_client.h"
>> >  #include "crypto.h"
>> >=20=20
>> >  static int ceph_crypt_get_context(struct inode *inode, void *ctx, siz=
e_t len)
>> > @@ -64,9 +65,20 @@ static bool ceph_crypt_empty_dir(struct inode *inod=
e)
>> >  	return ci->i_rsubdirs + ci->i_rfiles =3D=3D 1;
>> >  }
>> >=20=20
>> > +void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
>> > +{
>> > +	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
>> > +}
>> > +
>> > +static const union fscrypt_policy *ceph_get_dummy_policy(struct super=
_block *sb)
>> > +{
>> > +	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
>> > +}
>> > +
>> >  static struct fscrypt_operations ceph_fscrypt_ops =3D {
>> >  	.get_context		=3D ceph_crypt_get_context,
>> >  	.set_context		=3D ceph_crypt_set_context,
>> > +	.get_dummy_policy	=3D ceph_get_dummy_policy,
>> >  	.empty_dir		=3D ceph_crypt_empty_dir,
>> >  };
>> >=20=20
>> > @@ -74,3 +86,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
>> >  {
>> >  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
>> >  }
>> > +
>> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *ino=
de,
>> > +				 struct ceph_acl_sec_ctx *as)
>> > +{
>> > +	int ret, ctxsize;
>> > +	bool encrypted =3D false;
>> > +	struct ceph_inode_info *ci =3D ceph_inode(inode);
>> > +
>> > +	ret =3D fscrypt_prepare_new_inode(dir, inode, &encrypted);
>> > +	if (ret)
>> > +		return ret;
>> > +	if (!encrypted)
>> > +		return 0;
>> > +
>> > +	as->fscrypt_auth =3D kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
>> > +	if (!as->fscrypt_auth)
>> > +		return -ENOMEM;
>> > +
>>=20
>> Isn't this memory allocation leaking bellow in the error paths?
>>=20
>> (Yeah, I'm finally (but slowly) catching up with this series... my memory
>> is blurry and there are a lot of things I forgot...)
>>=20
>> Cheers,
>
> No. If an error bubbles back up here, we'll eventually call
> ceph_release_acl_sec_ctx on the thing, and it'll be kfreed then.

Right, the callers are expected to ensure that ceph_release_acl_sec_ctx()
is invoked, of course.  Sorry for the noise :-/

Cheers,
--=20
Lu=C3=ADs
