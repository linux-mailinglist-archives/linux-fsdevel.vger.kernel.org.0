Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA09A643A57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 01:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLFAhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 19:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLFAhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:37:00 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C622B3F
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id cg5so12692709qtb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne2kQ17Z3A3jdHPo12NzWN07bL28Bd+Tg02BrzT7QcM=;
        b=8B7MCsObOOvSR6mCIokEm9+fr1yaDvUvjD7xLGijdBTs3173zrpzOBCSMq7GbxNBOM
         jlA32HML4qaWiA3bC6/MPSgXaUVCfDcNO6Eh0Y0wkVZv0g1YdCxC7+6gaO3SEVPZoGb5
         HrrRV5vE7unUe9agoAJ8B1Pp8NbAhAYjBb9QhoDja4o0GsDM0tFW8pGusiEyqX4zxzkF
         CljQBwGY9gpwXG1kIXBI+qeSYEVIsVEySuVkFdkM0H9hKa0A4GvD1jan7GRU9WkJps92
         YP/pq8joOPnl2SuuUW4hLh9dHzTeG3C8HOQaTrrE/uf+/pB8p30p04rCt3j/O4H92pqq
         BKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ne2kQ17Z3A3jdHPo12NzWN07bL28Bd+Tg02BrzT7QcM=;
        b=KYciV/TUUMM/nkcqeRVXTaQVHRK2t4ZPkeRW2EXh8P2YZEb1fnoiNZSpFjYawbDSVP
         lh1ZQaL7auHT50zvBrPJROn88BeNHSQNORyHf0Rygt/7Uza/6yjVlR8ugG8eV1mphr0P
         ya96AyF2ACsIsEr2nLrPd6Ai778L+NKu1UZjaPWw96pdyxYypOSE5gRASwFWmfYTqI9S
         aTAnYkah1q1alihfdF5v7DmYhi2iqIPQ7BfaKksnY1Tg2vK4EFXeRqTUkSFdDoQ3UK3H
         WLamqB2jRW+cP0Zdu1OGUJz5J6byENSzAvyHowpn+3e7MgLv7Xsvk8ugOy7DQlfrdH/p
         kDJw==
X-Gm-Message-State: ANoB5pl7H7YAaFledVRW9iHvLU57uI9W5JOaUjn3xoWTAwfMqvtA40he
        +y6lBzDUa/I36YCXYot/w8UqaA==
X-Google-Smtp-Source: AA0mqf6Oos0yfJkVZaqeYo7679Myu1FELMEk7IoUBQqnjFE3jKyqOBdEBqH00X3hxXMU9cg1xpS1Kw==
X-Received: by 2002:ac8:4d4f:0:b0:3a6:1dea:8c1c with SMTP id x15-20020ac84d4f000000b003a61dea8c1cmr68663245qtv.157.1670286942302;
        Mon, 05 Dec 2022 16:35:42 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id 134-20020a37088c000000b006ec771d8f89sm327312qki.112.2022.12.05.16.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 16:35:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
Date:   Mon, 5 Dec 2022 16:35:36 -0800
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
 <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
To:     Aditya Garg <gargaditya08@live.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 2, 2022, at 11:56 PM, Aditya Garg <gargaditya08@live.com> =
wrote:
>=20
>=20
>> Also, what if we mounted
>> file system without specifying the UID/GID, then what UID/GID will be =
returned by
>> your logic?
>=20
> So this case is if I run =E2=80=9Csudo mount /dev/sda1 /mnt=E2=80=9D
>=20
> Here the driver will not do any spoofing, and the real owners of the =
files shall be displayed. Thus running =E2=80=9Cls -l=E2=80=9D on a =
mounted partition without specifying UID/GID, files written by macOS =
shall be shown as 99 as the owner, iPadOS as 501, and if any file was =
written on Linux, the user who wrote it will be the owner.
>=20
> If the user/group of any file was changed using chown, then the new =
user/group of the file will be displayed.

My question is much more simple.

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aeab83ed1..4d1077db8 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -192,11 +192,11 @@ static void hfsplus_get_perms(struct inode *inode,
	mode =3D be16_to_cpu(perms->mode);

	i_uid_write(inode, be32_to_cpu(perms->owner));
-	if (!i_uid_read(inode) && !mode)
+	if (test_bit(HFSPLUS_SB_UID, &sbi->flags))
		inode->i_uid =3D sbi->uid;

	i_gid_write(inode, be32_to_cpu(perms->group));
-	if (!i_gid_read(inode) && !mode)
+	if (test_bit(HFSPLUS_SB_GID, &sbi->flags))
		inode->i_gid =3D sbi->gid;

Before this change, logic called i_uid_read(inode) and checked mode.
Now, we check only HFSPLUS_SB_UID/HFSPLUS_SB_GID flags.
So, if we mount HFS+ volume by =E2=80=9Csudo mount /dev/sda1 /mnt=E2=80=9D=
, then
HFSPLUS_SB_UID and HFSPLUS_SB_GID flags will be unset.
And current logic will do nothing. Is it correct logic? Maybe, we need
to use sbi->uid/gid if flag(s)HFSPLUS_SB_UID/HFSPLUS_SB_GID are set.
And if not, then to use old logic. Am I correct here? Or am I still =
missing
something here?

Thanks,
Slava.


