Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6B4EE8FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbiDAHVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiDAHVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:21:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC41E0D8;
        Fri,  1 Apr 2022 00:20:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w25so1863164edi.11;
        Fri, 01 Apr 2022 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ubG9Vku/N0fiy/2SLaUSFTnlDKcWy9tp5aypQ1g0yR0=;
        b=qeR+po4xuMTE7NT42VMHjZFG4pDnrmbTx3qLmihDu198PJkosJh+2LD7Gm2agZ/6/n
         Rh3REosbufMhaAtMz8tJ7FJD9RXIA6FjTXHFkvPf/Z6gNdOZGDbLGLUm6VBhWieFruzF
         0QICo8ryhdAlaxL4mVBgaFRru05eQXUNP56zdgCWX+jyFvcSR0SqPgu3hwF3OEsvOrfe
         w8DIfnGKoCj96ldnimavctFqxewc0rMfhOrGP6p7JHQD2kfKL3cyTRZF7nOcGy+O6+fX
         P96Ni3tAi0wo+RBJkZZ5UDX0J9fYCuJTnFTeUWhOulbpDpF/qiq+qgTNo11gwWz/ZnMS
         4vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ubG9Vku/N0fiy/2SLaUSFTnlDKcWy9tp5aypQ1g0yR0=;
        b=EXT9/EFYTXqQCXej9j49Zbx4EEHgRpDaLoWqaPeK3yt2KV1hs9RjNJ0hZtalsz4hYC
         Wt3he//cwI7Kp+S1ejCjZAkZaFzFbquQCpp5iwp+ejRJp1YlFGuikzrBNFnZg3ItXTAS
         hGHPr9MOt6NQ3qljauS1pNBqr9PV1BS6KMWO3ELYUYcBnwEyKvYIT79W4Kt9Ea6OHJUx
         MXcCnOsR1031BfEqHqasdaUqQRnyfmxclSjiVhxjjHeOgHKOKheTZVJxMdggu6x8+oQJ
         7IVRW8N3xi0nbJKLpqezab12XkyfP6irZxpLHpj/75GZSEF3/sX/RXMb6IgatpJcHc/7
         HL8Q==
X-Gm-Message-State: AOAM531qFMZkvBRIescTHStT2fEYtDhE7TcTgUjBrTkiiS+BkQ3PZt5I
        AOo/uxHJVPxy19AwghKPD3XEwUNkDfD2zKMO
X-Google-Smtp-Source: ABdhPJwtm0B3S+66CH914jkdPstqClG3Zij5v/glvefk14ehzJXJAgRaWtf3O5lM4sqoI8xhAsEyuA==
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id i20-20020a05640242d400b00412c26b0789mr19840232edc.232.1648797598835;
        Fri, 01 Apr 2022 00:19:58 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm782154edt.92.2022.04.01.00.19.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 00:19:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] fs/proc/kcore.c: remove check of list iterator against
 head past the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220331164843.b531fbf00d6e7afd6cdfe113@linux-foundation.org>
Date:   Fri, 1 Apr 2022 09:19:57 +0200
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A23914B0-BFD7-48D6-ADCF-42062E1D9887@gmail.com>
References: <20220331223700.902556-1-jakobkoschel@gmail.com>
 <20220331164843.b531fbf00d6e7afd6cdfe113@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 1. Apr 2022, at 01:48, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri,  1 Apr 2022 00:37:00 +0200 Jakob Koschel =
<jakobkoschel@gmail.com> wrote:
>=20
>> When list_for_each_entry() completes the iteration over the whole =
list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>=20
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member =3D=3D head, using the iterator variable after the loop =
should
>> be avoided.
>>=20
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element =
[1].
>>=20
>> ...
>>=20
>=20
> Speaking of limiting scope...

Fair point :-)

I see you have applied this already to the -mm tree. Shall I still move =
the iterator?
The hope is to remove the 'iter' variable altogether when there are no =
uses after
the loop anymore.

>=20
> --- =
a/fs/proc/kcore.c~fs-proc-kcorec-remove-check-of-list-iterator-against-hea=
d-past-the-loop-body-fix
> +++ a/fs/proc/kcore.c
> @@ -316,7 +316,6 @@ read_kcore(struct file *file, char __use
> 	size_t page_offline_frozen =3D 1;
> 	size_t phdrs_len, notes_len;
> 	struct kcore_list *m;
> -	struct kcore_list *iter;
> 	size_t tsz;
> 	int nphdr;
> 	unsigned long start;
> @@ -480,6 +479,8 @@ read_kcore(struct file *file, char __use
> 		 * the previous entry, search for a matching entry.
> 		 */
> 		if (!m || start < m->addr || start >=3D m->addr + =
m->size) {
> +			struct kcore_list *iter;
> +
> 			m =3D NULL;
> 			list_for_each_entry(iter, &kclist_head, list) {
> 				if (start >=3D iter->addr &&
> _
>=20

	Jakob=
