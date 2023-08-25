Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1869787D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 04:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjHYCGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 22:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjHYCFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:05:54 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4361BDF
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 19:05:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bd04558784so353999a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 19:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692929147; x=1693533947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tV/xhMrG27pnQQdfeNDXAs9vebCS+5kkS2KT1sSOa80=;
        b=KH+lMhzI7jZ8rYptdhcbSfZQ8+HBsGRJd77yQHDq+BXrhGxqXTWKXOH3kGZYuze8qe
         kfvFFx5SyWefbAqyqUbeBn4VDBIuPTMnTciUaWuBxik1CZwCXnLbghczQs+n/YOMn5Sa
         2mto9NZOBxN5C8qUM1C3b4o8qeN/WKzVjdG+Ez9ViVkD2OhfZfZ0iiejDsSBwxwMtAbj
         P9VBABTUkDMnw+ZFBjEkHdNoqW2AOlIBc8bFXuyakMoVN2RIxbYplmnGe6i+PmeEPwcn
         6KjSkifdhykk/A1XmBBLQzc49QwW+jMEeeEv+1Oj5YCTj9FgUWmTPTpA3DqV2PwZBSLe
         OdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692929147; x=1693533947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV/xhMrG27pnQQdfeNDXAs9vebCS+5kkS2KT1sSOa80=;
        b=bML8a7AS2Vr4eyVS8D82Ve35HgnZGC2FTJU1XcKjgleAXav4G0aXh26paYpi0AVdeL
         LyZyYYdOGMJA+ohjVS8hG/fEw41iCU+cwb/8FhrIPTE+ggi9jcIvNwAkn6XmeMltCsAi
         TmuQViLAbE407RF8vA94POQAVVLihnp9eJUTp9+8yuZv8ALokTxvzekizqaakvUs028h
         8fBLJWufjqXrTWNbI14g0Q0ax4rG9MyckQs1EWXqPw+wiRFezPjfHgfPfkfvhpnYTWHA
         s1zqS6Gy0cSravbfkR4AuJBgmER3F7NX4++9obgF7N/1OKOYiwQ27CQ2+XZAAJjbpYQ6
         lnwA==
X-Gm-Message-State: AOJu0YwYXLC+MN6njZP01Q7KqCjPKfF92tXQxDu8+wuMFoLKnVTYW2ac
        rDDxwBUGNAPDC8nNvrC1VyI5IGfLYD8=
X-Google-Smtp-Source: AGHT+IFwVVg6YiTFk8zpBOPVx1N8fV+8AvVZxuYh+26ryVBhH9WMkI0PDKDJBRCuMeaUJ5VlITHA5w==
X-Received: by 2002:a05:6870:5620:b0:1bb:583a:db4a with SMTP id m32-20020a056870562000b001bb583adb4amr1678722oao.44.1692929147043;
        Thu, 24 Aug 2023 19:05:47 -0700 (PDT)
Received: from rajgad ([2601:204:df00:9cd0:5aa8:2901:89a5:c04b])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090ace0600b00267ee71f463sm3461672pju.0.2023.08.24.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:05:46 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:05:45 -0700
From:   Atul Raut <rauji.raut@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com
Subject: Re: pagevec: Fix array-index-out-of-bounds error
Message-ID: <20230825020545.bfpxs6uq4qdvrv5x@rajgad>
References: <20230825001720.19101-1-rauji.raut@gmail.com>
 <ZOgKTO612u1Fn7PB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sve3wn3ghdf5u6b7"
Content-Disposition: inline
In-Reply-To: <ZOgKTO612u1Fn7PB@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sve3wn3ghdf5u6b7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Matthew,

Thank you for your reply, agree with you its seems wrong fix,
will take a look at it.

-Atul=20

On Fri, Aug 25, 2023 at 02:56:28AM +0100, Matthew Wilcox wrote:
>On Thu, Aug 24, 2023 at 05:17:21PM -0700, Atul Raut wrote:
>>  ntfs_evict_inode+0x20/0x48 fs/ntfs3/inode.c:1790
>
>No.  This is your clue.  ntfs corrupts memory.  You can't take bug
>reports involving ntfs seriously.  Ignore everything tagged with ntfs.
>
>> In folio_batch_add, which contains folios rather
>> than fixed-size pages, there is a chance that the
>> array index will fall outside of bounds.
>> Before adding folios, examine the available space to fix.
>
>This is definitely the wrong fix.
>
>>  static inline unsigned folio_batch_add(struct folio_batch *fbatch,
>>  		struct folio *folio)
>>  {
>> -	fbatch->folios[fbatch->nr++] =3D folio;
>> +	if (folio_batch_space(fbatch))
>> +		fbatch->folios[fbatch->nr++] =3D folio;
>
>Did you look at what folio_batch_space() actually does?
>
>static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
>{
>        return PAGEVEC_SIZE - fbatch->nr;
>}
>
>So if fbatch->nr is 255, what will it return?  How will
>folio_batch_add() behave?
>
>The right way to fix this problem is to find the data corrupter in NTFS.
>You can't "fix" it anywhere else.

--sve3wn3ghdf5u6b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEk+Uz5/8aTg0U2TbgUdAfNFxksqcFAmToDHUACgkQUdAfNFxk
sqdPngv+NCUU657tLXSWvPgVhINaEPNau3DK7gKbAEj67weSHu/YUAavgo04fDrg
nD6ND6gskKrHaOF8uxzaybB49a5d4E4Mp5JTQCJ8D/3771GijyX+PgauDZBAtPsF
r0PJOc9Gh//OFIQmtxp9COzxL219LBnJysQ7lBxwYJ3/oiO4yvvNwgeIEv1U+L29
MLoKrFiMc7CGp5NmzPAGc5Fl+OuKF96NgkDW/8ZUvkLp80fkOg+egdqwTFLRJ9Ok
lqYQrqAQngQhQS3siWFjUR7UNcsOsq6Aj+22MPTAc5VijUFEVW3+0u8npE7g3uoo
+4J/Ip9WZzNvpIetdwrWgSbi61dGezJv5AfxC5zXwQXz3jtC9Hu3ip8f+Xune9pD
It7225RCOz4A5R/jjWSSpBlmvOUB/+T7BD3PLa3Hpa5x/cb+x2gs/bAGc+7bTsi2
pIwRqG9I4vHbXSY2eJDUXFeaTBDnLMEgur6nmr5TWNtUt7Cw/4qcPtrfpyMmtsfc
BlipfPA/
=Bi8j
-----END PGP SIGNATURE-----

--sve3wn3ghdf5u6b7--
