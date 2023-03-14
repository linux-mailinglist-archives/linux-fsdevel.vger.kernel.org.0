Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67D6B9F60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCNTKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCNTKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:10:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826DF448F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so35109520edb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678821003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=GRHeB8b0ZqvMXqmDU3Di/QQOhVl45XnW1aY7Sj0r0bsLJjWrGoKUGGauvJ4d4nQZik
         no2JpzfWUobh0ag15UvuvbtS+vbFv08S5lQZaWR+Svxjgb2VQ7b9L56pM4+32Kr+Q54P
         dwJe6ok1YbGu9WNh93po0re1k8LPW0/LHn9uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=VRw7KAXIRIrcBSMSYqPNoWZPGQ1vl6nO2OruuB01+Kd9en3faZC0P8g/DsbLv30YwS
         zK8Sp4VrLPNyoDCfO/dzdvArQKiSSiuS9+Sp1HRrdq25is/nkNrITgDpFtCdB5+EZjIA
         c4Ap8+QmagveR3lajIyq7XUc79Dz2f2i9NqgvzSeSztP0VXjqIOUB0h9GlAVtqkuWQnA
         FuKyzZfB/+0UUbAt6pmnwqbs5pOM9toGcbUtEEms5MbKYPwyqeih2LiJ3xL9k9aiEtU6
         Hsx2NxG+mso/bYrO+yyk1r1JQD8a+U0aprvV9kAvw9+V1neCcZQo5EpNpwccu5HPcw/L
         8LUA==
X-Gm-Message-State: AO0yUKV2h3Bh0IajUPHFbSVsohLnVDstfRQxzixhTLGcERbaC7BKTBl7
        8y6Ko6oNu1a94RpEGIDfK0WNKE3nXm+d0drhdkSiPg==
X-Google-Smtp-Source: AK7set/Ug06ZacHYQkW9jL+O4oa5ortm39gBDsEn3DZRFyAZgrWVpeprsnDn4YnxxOm0Fx1ylkbooA==
X-Received: by 2002:aa7:d6c3:0:b0:4fd:14d5:bb4b with SMTP id x3-20020aa7d6c3000000b004fd14d5bb4bmr140462edr.23.1678821002906;
        Tue, 14 Mar 2023 12:10:02 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id c37-20020a509fa8000000b004fb17f10326sm1465449edf.10.2023.03.14.12.10.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:10:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id x3so66203708edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:00 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr1869330ejb.15.1678821000656; Tue, 14
 Mar 2023 12:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk> <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
In-Reply-To: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe we can do /dev/null some day and actually have a common case for th=
ose.

/dev/zero, I mean. We already do splice to /dev/null (and splicing
from /dev/null isn't interesting ;)

            Linus
