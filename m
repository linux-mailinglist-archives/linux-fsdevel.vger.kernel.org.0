Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8777F940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbjHQOip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352086AbjHQOil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D982D78
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so10518774a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692283118; x=1692887918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=f0DQNOu2XllsKp9A83uUucKVByjF5khsYOV8Y0ek4Xwwpx1SxPDzzOUlX1hhpYtT0Q
         tm03gvimjn641e1zxTf3Bute5qUBdkUDwjAz74eEkos0PmytErGZ7oPOsV4tRtaDFgNt
         w+oPgfaZeB8R0O4GghoyquLvtEE/jLlyQJtMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283118; x=1692887918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=POyPz0EH6j7Kw+Ii7aqmoNEFt7VKIEG+OwFXqmpxLPFCxGumh85pT5nGu4vnZh/GsV
         PKyihflIiX1ESXG+6QtkRBsB1TRTdr2ZHQlfUJ9FXySxixpkb4WktMCagQ+AWTo8a8pC
         qjTDPgKB3IlNedloZiVhJYlhe+RuNPoe/dwweh+cHomoWLJhV8NVHbSlmJAmc8U+ZHRt
         weQ/PzT078K+NOrZM8CjnXOu9unzBqXLFTZVnYDHHbtFYomWIkLLa21ZuH3d4YjRznLe
         kvzqMvbdtk6HOacGRMsKhhqwEs9x9joztqKMgjvS07fUde1Br3eI3JwhwuPQEx8hugFR
         Mm+Q==
X-Gm-Message-State: AOJu0YxEtb9P2d9aiVYnWS4X0hSt/QYZZUcLj8Kzidm4dhAO8YjFbbuo
        25c830ujiNIosCaia2NMcx10r1XFIwt8o2wK+b16YiRh
X-Google-Smtp-Source: AGHT+IFC3RiDAeDJvddfqNmyj/lrms30W3RQyV70m4zvmOJP0RaWRBTfEK/P+0DY7T2cm6M2tMiPHQ==
X-Received: by 2002:a17:907:98cf:b0:99c:602b:6a67 with SMTP id kd15-20020a17090798cf00b0099c602b6a67mr4819896ejc.59.1692283117849;
        Thu, 17 Aug 2023 07:38:37 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id lj5-20020a170906f9c500b0098d2d219649sm10338536ejb.174.2023.08.17.07.38.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bf3f59905so1030663566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
X-Received: by 2002:a17:907:a067:b0:99c:570a:e23e with SMTP id
 ia7-20020a170907a06700b0099c570ae23emr5392064ejc.24.1692283115907; Thu, 17
 Aug 2023 07:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
In-Reply-To: <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:38:18 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Aug 2023 at 10:42, David Laight <David.Laight@aculab.com> wrote:
>
> Although I'm not sure the bit-fields really help.
> There are 8 bytes at the start of the structure, might as well
> use them :-)

Actually=C3=A7 I wrote the patch that way because it seems to improve code
generation.

The bitfields are generally all set together as just plain one-time
constants at initialization time, and gcc sees that it's a full byte
write. And the reason 'data_source' is not a bitfield is that it's not
a constant at iov_iter init time (it's an argument to all the init
functions), so having that one as a separate byte at init time is good
for code generation when you don't need to mask bits or anything like
that.

And once initialized, having things be dense and doing all the
compares with a bitwise 'and' instead of doing them as some value
compare again tends to generate good code.

Then being able to test multiple bits at the same time is just gravy
on top of that (ie that whole "remove user_backed, because it's easier
to just test the bit combination").

> OTOH the 'nofault' and 'copy_mc' flags could be put into much
> higher bits of a 32bit value.

Once you start doing that, you often get bigger constants in the code strea=
m.

I didn't do any *extensive* testing of the code generation, but the
stuff I looked at looked good.

               Linus
