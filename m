Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CB774447
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjHHSQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjHHSQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC1696AB
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:22:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso817026766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691515356; x=1692120156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZMo3VFIBuSc8s4BkuFzX7yAflC5N6hG1s52Y/WzRwg=;
        b=UaMABPPZiHqLzouKimb/ZPmNNqDQxzFo8V8zHoKNrMOymozptRfNO6xUSW4eVIsE3j
         U7C1PkB/raIL/7qMoZUSGosxPkbWkWB3DcZPkoK7k0BLPS+8AbcKK0A/eJsVvCt8x5As
         pas1FxEpu4ejw0GRUoBAGBL8rwUiWcQnwwf0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515356; x=1692120156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZMo3VFIBuSc8s4BkuFzX7yAflC5N6hG1s52Y/WzRwg=;
        b=IInMEPMBS+kuOYeqeSfgRQ0b5i3zI90zG6dl2Jfcm123naJvTJQX45fltIcmp3uQ6m
         tnu7F307k5KTqm3mBrBxAJkMGouh2TFIdOT51LJ9q8ZjzxQZF5a9oS27lDAr33JE/D2f
         7syIVEVcebZ0NYtSLSND50m9siNvXerQrt5kd8YJTt+FSB28C6xOr4p6G+MLH7iR+CgQ
         cMtzNpG742CUkHsqwCuJUlrYJACItBuDOnuvU/ei7wZ2fXUT7K68hei88etEN0NMLi/u
         RGtLz0rXRFUYMb2HbL2Hg4D/F73DoYS9KHXk7gmzelBOjUhGyhNCA4aMb2MG5H1LbUtA
         0GiQ==
X-Gm-Message-State: AOJu0YycXghmCDUsjOCy/z3eI1Dcnb0b5sCBtr2Ix18m2JEG0zNFccNZ
        gLno1b71MIV9dy9evkfnawL4As4gJzLfKXVmzz2mKo6r
X-Google-Smtp-Source: AGHT+IHgoOCPcyzbmfuyK+axZsWGqF6t53H5c8LiiMMeybs2g+6qNbmj+KqqzFwb+PH4pt0gs8+Wjg==
X-Received: by 2002:a17:907:2be9:b0:992:b3a3:81f4 with SMTP id gv41-20020a1709072be900b00992b3a381f4mr218531ejc.50.1691515356581;
        Tue, 08 Aug 2023 10:22:36 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709060f0e00b009937dbabbd5sm6901081eji.220.2023.08.08.10.22.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:22:35 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so3417983a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:22:35 -0700 (PDT)
X-Received: by 2002:a05:6402:1219:b0:523:17ad:c7d4 with SMTP id
 c25-20020a056402121900b0052317adc7d4mr368834edw.39.1691515354968; Tue, 08 Aug
 2023 10:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com> <20230808-jacken-feigen-46727b8d37ad@brauner>
In-Reply-To: <20230808-jacken-feigen-46727b8d37ad@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:22:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
Message-ID: <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Aug 2023 at 10:15, Christian Brauner <brauner@kernel.org> wrote:
>
> I think you're at least missing the removal of the PF_KTHREAD check

Yup.

>                 It'd be neat to leave that in so
> __fput_sync() doesn't get proliferated to non PF_KTHREAD without us
> noticing. So maybe we just need a tiny primitive.

Considering that over the decade we've had this, we've only grown two
cases of actually using it, I think we're fine.

Also, the name makes it fairly explicit what it's all about, so I
wouldn't worry.

              Linus
