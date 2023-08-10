Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454C777FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHJSJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjHJSJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:09:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E986E4B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so2478197a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691690990; x=1692295790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdVO7LGdqPVywscLfXnXC7vbQR6Oxa8Ot+Ua+mHkMYE=;
        b=Ea7sNbAxq5l52YuA5/kkvqgTynB0iI2IpGjDlcwSF/cyvMuRZtTmChqyQ42aC5y+5L
         OsNhk0ed8ezMAkt0fJQdd6K5tooV+fMckUUl1X+dT88VSzioH0agUtlR/T8JFCUdFC12
         lp4osvVuqf7ZMo45ogvh5p1cNtT9YxtEj+w5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690990; x=1692295790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdVO7LGdqPVywscLfXnXC7vbQR6Oxa8Ot+Ua+mHkMYE=;
        b=Z/YvZnyJGYBfzZeWV3EAPzaxDxf6b9ttd5h5fsVozKEysNtHkZin6O0VjHfUiRPI7W
         SEIjU/IoWKLA4L19FSUnWm9jDQ5tzS9aYzkX6BEbf7A5yOaggf99JJy00r5swGBuA2SN
         LxEmeTt/f8L7mDyMQVoUZd8wV6W9jwwpbbcZk+AFJI9f1OsYCSlKr1czivGf4hjKj98U
         /zxPht5dTRjeVl5piDCC6vfFfcZXWAPagq9y8NAGDpOXB685tOWCIyPc+5ylrT103V/Z
         3vcaD4WV8r2zF3RiQC+/AaYP0P9TDmDfkRddSzbOINnd7BK1uDr+iJtLz3mKOWmGwA/n
         JQEw==
X-Gm-Message-State: AOJu0YyrWLLZ95xZM9fecio/q9aWis/t/6B4CYqZ0FvudTEfIyyUrBau
        qhs7t1Ut8HoDjuL59gWpgGHuwt4YYVRcyqDA908VHwZE
X-Google-Smtp-Source: AGHT+IFJO9WAQTUejzrxnfrKL5p8QfH+FoXRYKwHRN+CCKWWq2votshTeMILxUMR+xIwoxDOsoIqHA==
X-Received: by 2002:a05:6402:3508:b0:51e:4218:b91b with SMTP id b8-20020a056402350800b0051e4218b91bmr3574495edd.1.1691690990574;
        Thu, 10 Aug 2023 11:09:50 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7c1cb000000b005232ea6a330sm1077225edp.2.2023.08.10.11.09.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4818968a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
X-Received: by 2002:a05:6402:520a:b0:51e:5206:d69e with SMTP id
 s10-20020a056402520a00b0051e5206d69emr3555926edd.10.1691690989521; Thu, 10
 Aug 2023 11:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan> <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
 <20230810180244.cx3vouaqtisklttn@moria.home.lan>
In-Reply-To: <20230810180244.cx3vouaqtisklttn@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 11:09:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6R1z=6v+qJpe7qAZGNYZK1ZMs1+dhD7FahVywnMr1Uw@mail.gmail.com>
Message-ID: <CAHk-=wh6R1z=6v+qJpe7qAZGNYZK1ZMs1+dhD7FahVywnMr1Uw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
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

On Thu, 10 Aug 2023 at 11:02, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> When using sget() in the conventional way it's not possible for
> FMODE_EXCL to protect against concurrent opens scribbling over each
> other because we open the block device before checking if it's already
> mounted, and we expect that open to succeed.

So? Read-only operations. Don't write to anything until after you then
have verified your exclusive status.

If you think you need to be exclusive to other people opening the
device for other things, just stop expecting to control the whole
world.

                Linus
