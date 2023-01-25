Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83AD67B54B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAYPAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYPAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:00:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F555B2;
        Wed, 25 Jan 2023 07:00:20 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p185so16469949oif.2;
        Wed, 25 Jan 2023 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqEmM1BqnUHLQkbq1UQiAc0tOKUii6vXvFzmCvZzUI=;
        b=MDTs7X+zXow4jkHIKViHp60R/psRLu38Ty/FgLJm3BBZ1CzfK+i0euIccb8chauSLW
         SfXtjUjHIFz6heApmZqxXFZPrKFQ0Vm2jSOvwcZ+0GDpoECT57XZLCoI0NNTd8zfIs0d
         aD+FLcgFazvWyXHtjifR0pqUo7CwxWHPhoPb4/HIaa5Q32k080qnJaMl9re07fHliEv5
         TEmyFV+If3bNEE+zaDBfF2bENIVzGN7ORHSw+E82lGjEbceJNEME5m9Sk1F5DPSjepss
         H/vTMzuZXmeMJHdnmo/e8RowqWMZch0/pGM2Lyige/2YeV14Nncsu96cx4Rl1SMKgN58
         J8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNqEmM1BqnUHLQkbq1UQiAc0tOKUii6vXvFzmCvZzUI=;
        b=3ZZFzurvHxU+2SUpmj4QOrk5e/Pg9Sk+EsZxoSe5hs7tata9k9QgS0h4T9FCf6mA9P
         jR6w27giXWEt2Em4U9qJRGYneerw3tcvjFISN8Tl7pfECFAs2iMdXsLr2lvqQmlUkqoa
         lIuQR7hPJMh0BMco7Bqjkt27Db/hsG9Xuo9d5gQdTREeOdr5a7OVB3Jcm6mD8vs9HWH5
         a9YOfiYijkJRsskZyLLCoGJewQocdvP5RO3krz4JOnGekIl7+IKmbmKUJM/V0U3jyuVN
         MFP9Glmew1ySUQd/3u3EQ/3BH6CVZfVKPuxzwvPt6gyLeO+B6lqKZR2Up4qI1IT5T3Mo
         pZFQ==
X-Gm-Message-State: AFqh2koFr3y6osLyYMTFl2ObtwB1w4tHy32IiEzGCMS4JHOj5arlieCn
        ZU/M3Jg3Osnq9bWkRsMMFzmr70psgiiA+PlzM38445i9
X-Google-Smtp-Source: AMrXdXvAMG/UqKRnUDQDf3YdfLq065w1hSvPgthQ1NkBmOlFpMMtOVDPyuDRS0AsmX99ZiUF/5s5K8zSdwRCghhL2dM=
X-Received: by 2002:aca:2107:0:b0:365:64a:b3a1 with SMTP id
 7-20020aca2107000000b00365064ab3a1mr1270851oiz.81.1674658819855; Wed, 25 Jan
 2023 07:00:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Wed, 25 Jan 2023
 07:00:19 -0800 (PST)
In-Reply-To: <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com>
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com> <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 25 Jan 2023 16:00:19 +0100
Message-ID: <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23, Paul Moore <paul@paul-moore.com> wrote:
> Although I'm looking at this again and realized that only
> do_faccessat() calls access_override_creds(), so why not just fold the
> new access_need_override_creds() logic into access_override_creds()?
> Just have one function that takes the flag value, and returns an
> old_cred/NULL pointer (or pass old_cred to the function by reference
> and return an error code); that should still provide the performance
> win Mateusz is looking for while providing additional safety against
> out-of-sync changes.  I would guess the code would be smaller too.
>

It is unclear from the description if you are arguing for moving the new
func into access_override_creds almost as is just put prior to existing
code *or* mixing checks with assignments.

static bool *access_override_creds(struct cred **ptr)
        [snip]
        if (!uid_eq(cred->fsuid, cred->uid) ||
            !gid_eq(cred->fsgid, cred->gid))
                return false;
        /* remaining checks go here as well */
        [snip]

        override_cred = prepare_creds();
        if (!override_cred) {
                *ptr = NULL;
                return true;
        }

        override_cred->fsuid = override_cred->uid;
        override_cred->fsgid = override_cred->gid;
        [snip]

If this is what you had in mind, I note it retains all the duplication
except in one func body which I'm confident does not buy anything,
provided the warning comment is added.

At the same time the downside is that it uglifies error handling at the
callsite, so I would say a net loss.

Alternatively, if you want to somehow keep tests aroung assignments the
code gets super hairy.

But maybe you wanted something else?

As I noted in another email this already got more discussion than it
warrants.

Addition of the warning comment makes sense, but concerns after that
don't sound legitimate to me.

-- 
Mateusz Guzik <mjguzik gmail.com>
