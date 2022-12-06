Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C26644C17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLFS5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiLFS5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:57:03 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CC36C54
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 10:57:02 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l15so14481029qtv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU0gQfsK0E6aJJop8DI/xus0uNp8ZM/+6s5+M9zf97w=;
        b=tLlaf1dwu3SlkhotUHfUNlmo1t5xLPhK1VlQAdE2WqRVHAjLdo8MJQOg54c/Xuc1EA
         pBfezwSIBtT0KawNQ08im1uUvnO0e4+9bs+ecmiIjyBQuSZFmg1eiqBgUKiytUzD18UG
         Enygyhv4lYnO/bnPdIrM9ZGCKYwie5aI0iLWj+q+bVu0qZGFnJXSG4y8giyLo3RjGQBv
         l3JDzbQdzmDuSGI4e62Ll+wAqcyLp1lK4Sp/z5umf7aI8BCMn28IFhh7qcf+d6wNL8NV
         zQtCwc7RDRyoU4or6QLm43/P5+14an6HT8LCbA5gLVmeqtuIeHJ+CiXJvUnzFzt5mY9M
         hEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU0gQfsK0E6aJJop8DI/xus0uNp8ZM/+6s5+M9zf97w=;
        b=HsdZlelYgmBviIsuT9TZvx10Mh0II6XVjPgr501U/z41NEKmVHJHkELUeLG2iVMmvb
         qVWiZEh1uFv94Rq8kt+Nv3l3ongcD1PGZRPn53rbDTL7bKXJK+azlUlGeNICSP3VM67D
         yhCyv8ykUIL4xyUJagyyKiak6KQ+rtKO51PR8PwYh6a69onoExuapuUelPiM4PNJZ2i4
         SSkhst2/PzNJlsM/Hze9IxGK8QswHDEkFDC0k8A+uOcWzehKmw4b7xLmmdoj3zMyApym
         UWcxgF0Hx5NwCj/RnsoVyupUd7vlW8qcq74JO06cTwspNvkVwOK1dK7LiZtfpo7xCWqI
         ik1A==
X-Gm-Message-State: ANoB5pksS3/e00U9Nroz6a0APNYCBL/nCNgXe0nE+vDYU7h8x+y1ysxr
        7q4BuUgJPbQQDelReqZJTRGiaQ==
X-Google-Smtp-Source: AA0mqf6+0WFzBfU/nS9ufSMFsf8Peoj0mB3cp5wEGDMDuJRE9ST+S62aY8WlXtjOdMDcAAKod4E35w==
X-Received: by 2002:ac8:66d4:0:b0:3a5:3388:4093 with SMTP id m20-20020ac866d4000000b003a533884093mr81388299qtp.262.1670353021544;
        Tue, 06 Dec 2022 10:57:01 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87112000000b0039853b7b771sm12222875qto.80.2022.12.06.10.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 10:57:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CD80923F-4422-416B-AAC1-A676D37C564F@live.com>
Date:   Tue, 6 Dec 2022 10:56:56 -0800
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
Message-Id: <20EA622D-12B9-49B6-8564-C8EE2A2329D2@dubeyko.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
 <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
 <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
 <FBF299DB-E235-4BD3-82BD-5A54EE9E26DA@live.com>
 <CD80923F-4422-416B-AAC1-A676D37C564F@live.com>
To:     Aditya Garg <gargaditya08@live.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 6, 2022, at 12:49 AM, Aditya Garg <gargaditya08@live.com> =
wrote:
>=20
>>=20
>> Well initially I when I tried to investigate what=E2=80=99s wrong, =
and found that the old logic was the culprit, I did some logging to see =
what exactly was wrong. The log patch is here btw :- =
https://github.com/AdityaGarg8/linux/commit/f668fb012f595d83053020b88b9439=
c295b4dc21
>>=20
>> So I saw that the old logic was always false, no matter whether I =
mounted with uid or not.
>>=20
>> I tried to see what makes this true, but couldn't succeed. So, I =
thought of a simpler approach and changed the logic itself.
>>=20
>> To be honest, I dunno what is the old logic for. Maybe instead of =
completely removing the old logic, I could use an OR?
>>=20
>> If you think its more logical, I can make this change :-
>>=20
>> -	if (!i_gid_read(inode) && !mode)
>> +	if ((test_bit(HFSPLUS_SB_UID, &sbi->flags)) || =
(!i_uid_read(inode) && !mode))
>>=20
>> Thanks
>> Aditya
>>=20
>>=20
>=20
> I continuation with this message, I also think the bits should be set =
only if (!uid_valid(sbi->uid) is false, else the bits may be set even if =
UID is invalid? So, do you think the change given below should be good =
for this?
>=20
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 047e05c57..c94a58762 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -140,6 +140,8 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 			if (!uid_valid(sbi->uid)) {
> 				pr_err("invalid uid specified\n");
> 				return 0;
> +			} else {
> +				set_bit(HFSPLUS_SB_UID, &sbi->flags);
> 			}
> 			break;
> 		case opt_gid:
> @@ -151,6 +153,8 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 			if (!gid_valid(sbi->gid)) {
> 				pr_err("invalid gid specified\n");
> 				return 0;
> +			} else {
> +				set_bit(HFSPLUS_SB_GID, &sbi->flags);
> 			}
> 			break;
> 		case opt_part:

Looks reasonably well. I believe it=E2=80=99s better fix.

Thanks,
Slava.


