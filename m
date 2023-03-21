Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63516C3A54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 20:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCUTWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCUTWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:22:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19754D631
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 12:22:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so64004597edo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679426533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=AD6aPA9u70fXHrmlk16ASDhb6ySx+aypTn68plHV/Ab7KbrZsb7apePctdz/CJYGxU
         8gluqq5WjF4FL6f9Mm9aA1Jith5btLXPWg4zGhzWcIO4f0UtuEPTdIrfciEQc/MapFAj
         bfWs8fVAQNw1soGzo2v+ZqPQEW1YSvfyiejdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=GpU7xu60sQIgHCgOU2Q/sB+1P/1qs9WC0eQ4qsuYVi2goF+cAW4JRXef6zeyTEhXKR
         CdzlYywedUvVa76CJxaCUUUX2vLcyB3sOUHezseSe0ddkFYzig48ksooWOwIk3W+z0wB
         aZlH7J5Bk2Dy4c4ZbZWZSTiBrDXl+/rOiAD616J0XcsKZroANkLFEvR+VAIztNNt2leZ
         TV5cgBr8j7+V3m4w51X/lM5Ge7Xvpw3QUT2JNVrlF1ATg30mum10lFcVtaYg4WyqX5Qm
         pqhfC1o2AuMN4NFi7C02jY6MnwRIpPQI1IemdQ+9C0OE034Vrb/WsNuowFEKCFNrO2xF
         AV+w==
X-Gm-Message-State: AO0yUKWLf32fqIQ85z+GPCdpXFAGKaUXkJqgZzWY3GFp9drhT80YAzc7
        3p1h2jSXyKnvhdr7vqS09eazf8y2dt7JJSWdAGnS9cyn
X-Google-Smtp-Source: AK7set/14SxSaqH3L07FACogclJ6FL3oAJA1PwmG28DSYkOOK/Cci5nIvlDvUCvjJVn0UI7BfpMk/A==
X-Received: by 2002:aa7:ce09:0:b0:4ad:1e35:771f with SMTP id d9-20020aa7ce09000000b004ad1e35771fmr4907603edv.35.1679426532961;
        Tue, 21 Mar 2023 12:22:12 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906845200b009222eec8097sm6153505ejy.75.2023.03.21.12.22.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:22:11 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id b20so30983963edd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 12:22:11 -0700 (PDT)
X-Received: by 2002:a50:9e6f:0:b0:4fb:482b:f93d with SMTP id
 z102-20020a509e6f000000b004fb482bf93dmr2321260ede.2.1679426530851; Tue, 21
 Mar 2023 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk> <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
 <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
In-Reply-To: <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 12:21:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 21, 2023 at 12:16=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> I haven't seen the patch yet as it hasn't been pushed,

Well, it went out a couple of minutes before your email, so it's out now.

> It may make sense to add some debug check for
> PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
> matter, as that is generally not workable without doing something to
> handle it explicitly.

Yeah, I guess we could have some generic check for that. I'm not sure
where it would be. Scheduler?

               Linus
