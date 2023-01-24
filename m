Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D1679FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 18:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjAXROn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 12:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjAXROk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:14:40 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4132FCF8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 09:14:35 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s4so13642156qtx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spY1Ga4Htt/e4/S3YR+lJ4bQ2N92evKYOkZEiqiKzXc=;
        b=OdfpXJDvwGfjoa/f0B3U31apaRVO+bHLetpe4JZQeT9jcGD15bvQ0ANB1i2v8cy/0e
         ZAvaAK8BR5efiy/dEM/Rdur3S8J8CNsF/ZTG/wknYZFmNOY0JTvlRw1ZWLbMnXAuDhB2
         gcfq49QV6SqUItxv2HJN+/3Z0MAIXynTjELL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spY1Ga4Htt/e4/S3YR+lJ4bQ2N92evKYOkZEiqiKzXc=;
        b=ZQGenW2xELkb+q3YIJ9o3O+EAEYsbb1JUPFuqBby9hNjWhd+5Vrp9Z0eKWNODPSpBc
         lMteMiX1/yFeXyh9uKckKK+5bUdRZQjmS+aGSFDF5blnFeUoRVRDhw9RL5hZjIVs7G0z
         oaSWQqnWHMV+PCFhT6OXihTbHIxK7htWXKCrJRFDXuhV5dszqUcykP4GzBRab7UNwlyX
         b1xQGbljxrkjlAvkciW/ckctY/Uq4pCwix86CTFsx8JY96fksOD1TENfQud8j2eFCh5H
         7gJd1KJT9550KSTWWlYsBtAsPnpY3Gf3imqk6m9nWDUDBSPs2cjvj/NVkQFEHlWy1jY0
         upeQ==
X-Gm-Message-State: AFqh2kpcFHKb705Hh9RJNoTDkTeMs1eRd9VxuAziqpeD5ndd6U8+q5ci
        /aSy0fkG33EoDNZ90WGp2eIlbS0tpuA1b+sw
X-Google-Smtp-Source: AMrXdXu0v0OAHPK7+KI/+Ps8FVC9hmbaN9BBJG4gG5t5KyXsmoHSIvpHbrEyRTJ41w4fwI/ymkCUIQ==
X-Received: by 2002:a05:622a:1a1b:b0:3b6:335a:828c with SMTP id f27-20020a05622a1a1b00b003b6335a828cmr54250090qtb.47.1674580474255;
        Tue, 24 Jan 2023 09:14:34 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id j13-20020ac8404d000000b003b644e8e3a3sm1606125qtl.23.2023.01.24.09.14.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:14:34 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id h10so12100569qvq.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 09:14:33 -0800 (PST)
X-Received: by 2002:a05:6214:5f82:b0:534:252f:b091 with SMTP id
 ls2-20020a0562145f8200b00534252fb091mr1278555qvb.130.1674580473657; Tue, 24
 Jan 2023 09:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com> <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 09:14:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
Message-ID: <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 9:00 AM Paul Moore <paul@paul-moore.com> wrote:
>
> My main concern is the duplication between the cred check and the cred
> override functions leading to a bug at some unknown point in the
> future.

Yeah, it might be good to try to have some common logic for this,
although it's kind of messy.

The access_override_creds() logic is fairly different from the "do I
need to create new creds" decision, since instead of *testing* whether
the fs[ug]id and [ug]id matches, it just sets the fs[ug]id to the
expected values.

So that part of the test doesn't really exist.

And the same is true of the !SECURE_NO_SETUID_FIXUP logic case - the
current access() override doesn't _test_ those variables for equality,
it just sets them.

So Mateusz' patch doesn't really duplicate any actual logic, it just
has similarities in that it checks "would that new cred that
access_override_creds() would create be the same as the old one".

So sharing code is hard, because the code is fundamentally not the same.

The new access_need_override_creds() function is right next to the
pre-existing access_override_creds() one, so at least they are close
to each other. That may be the best that can be done.

Maybe some of the "is it the root uid" logic could be shared, though.
Both cases do have this part in common:

        if (!issecure(SECURE_NO_SETUID_FIXUP)) {
                /* Clear the capabilities if we switch to a non-root user */
                kuid_t root_uid = make_kuid(override_cred->user_ns, 0);
                if (!uid_eq(override_cred->uid, root_uid))

and that is arguably the nastiest part of it all.

I don't think it's all that likely to change in the future, though
(except for possible changes due to user_ns re-orgs, but then changing
both would be very natural).

               Linus
