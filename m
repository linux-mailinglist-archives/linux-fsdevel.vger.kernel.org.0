Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA24B5BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiBNVAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:00:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiBNVAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:00:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6275C04;
        Mon, 14 Feb 2022 13:00:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 696661F38A;
        Mon, 14 Feb 2022 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644872407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6U+ftnG6KNWkm/Wol/rAzogJeX4wqwhy3kiuuU7ykW8=;
        b=VpcYUzWg1CSI7dIxQNPrVpTsKuBbCTm630p+v2tIuAourNM8KsZowJNHAzNs7tGm3QPwem
        Jt+PiHE3dCtaDsqbN6TLyhEtHaUFrrHwYeCtiG/3LdVqzbA4F7M4Y/wBj08NXSYCdmpGrT
        t6Ewew/4jpannujU6mbrVn8UtU4k5+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644872407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6U+ftnG6KNWkm/Wol/rAzogJeX4wqwhy3kiuuU7ykW8=;
        b=Mj0moBbCtUw8Phxc0fGqFJ2YnbujgGC24HG0yrzAXQaxetkD+0rDFfzzyR1ogEQPV22T2r
        WFexxkxF4c8oZHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06C6D13A05;
        Mon, 14 Feb 2022 21:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2M8FOtbCCmJSeQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Feb 2022 21:00:06 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c13cadd7;
        Mon, 14 Feb 2022 21:00:20 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
References: <20220111191608.88762-1-jlayton@kernel.org>
        <87r185tjpi.fsf@brahms.olymp>
        <62e06980ebc36c91e368e4d8bfa340b5ff291369.camel@kernel.org>
Date:   Mon, 14 Feb 2022 21:00:20 +0000
In-Reply-To: <62e06980ebc36c91e368e4d8bfa340b5ff291369.camel@kernel.org> (Jeff
        Layton's message of "Mon, 14 Feb 2022 13:39:34 -0500")
Message-ID: <87mtittb8b.fsf@brahms.olymp>
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

> On Mon, 2022-02-14 at 17:57 +0000, Lu=C3=ADs Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>>=20
>> > This patchset represents a (mostly) complete rough draft of fscrypt
>> > support for cephfs. The context, filename and symlink support is more =
or
>> > less the same as the versions posted before, and comprise the first ha=
lf
>> > of the patches.
>> >=20
>> > The new bits here are the size handling changes and support for content
>> > encryption, in buffered, direct and synchronous codepaths. Much of this
>> > code is still very rough and needs a lot of cleanup work.
>> >=20
>> > fscrypt support relies on some MDS changes that are being tracked here:
>> >=20
>> >     https://github.com/ceph/ceph/pull/43588
>> >=20
>>=20
>> Please correct me if I'm wrong (and I've a feeling that I *will* be
>> wrong): we're still missing some mechanism that prevents clients that do
>> not support fscrypt from creating new files in an encryption directory,
>> right?  I'm pretty sure I've discussed this "somewhere" with "someone",
>> but I can't remember anything else.
>>=20
>> At this point, I can create an encrypted directory and, from a different
>> client (that doesn't support fscrypt), create a new non-encrypted file in
>> that directory.  The result isn't good, of course.
>>=20
>> I guess that a new feature bit can be used so that the MDS won't allow a=
ny
>> sort of operations (or, at least, write/create operations) on encrypted
>> dirs from clients that don't have this bit set.
>>=20
>> So, am I missing something or is this still on the TODO list?
>>=20
>> (I can try to have a look at it if this is still missing.)
>>=20
>> Cheers,
>
> It's still on the TODO list.
>
> Basically, I think we'll want to allow non-fscrypt-enabled clients to
> stat and readdir in an fscrypt-enabled directory tree, and unlink files
> and directories in it.
>
> They should have no need to do anything else. You can't run backups from
> such clients since you wouldn't have the real size or crypto context.

Yep, that makes sense.  And do you think that adding a new feature bit is
the best way to sort this out, or did you had other solution in mind?

I'll try to spend some time on this tomorrow.

Cheers,
--=20
Lu=C3=ADs
