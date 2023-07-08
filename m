Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC774BA71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 02:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjGHAHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjGHAHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:07:31 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC5128
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 17:07:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso40237841fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688774848; x=1691366848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KE9Cw62WlLN5tGDQEG2KXlZYlpSw2T4lzA0FCYw64H0=;
        b=OSrn/4aJz295SutPCY58T8kNFD0ZeiUDY+OYH7DijkWBlnGIEEYDVTjrphYujv8L/C
         VpkbQYYFwXBapBTh3WJMOhE3gk8gm8Z45MHfx3iujKO35IBU3OkCH9kHst4F9nJGuHs3
         waDSW/izGakNypnv3ecOWKb+nLA3Loxu0nsnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774848; x=1691366848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KE9Cw62WlLN5tGDQEG2KXlZYlpSw2T4lzA0FCYw64H0=;
        b=MjtXa0XNGV+IBWr6FUbbPHjTcpE68QR9wrp4weZsY7g+qoXu7UMX6l50bPbOEDI2Qm
         xa75AswK+7zARgArlalOvXN0K6dR3o3y6h7gr7dkpQmnMJOo+F4ozMSrejwwfcaNBrTJ
         AZccGT0qF4s6cGjCoIUpbVHXB3heXUOMjJ6p/KIp85IUsbQsTCuQl7qPudHkGJLiUgYL
         9FtBeUjBFHXewFVgQ2ibJ3ADseZKkHNDc2iY0xxSZPWJLmYP4S3JL97bpbstdTaB4Vfj
         PVExwti5jpKIBNDEGXYtAbOzyJgYGPvbV+MVb9z3DVy2DThcvLFm2fm1ZuRsFf4QTncM
         KdUA==
X-Gm-Message-State: ABy/qLbh7tUF22ZrMg0lsQ+U/eqqdeZQlJqnGA7EqbP0Rdkaa6tpgz6P
        s3dnkTpJdZv5CvbjUqQPdivkbl0d7rH6tsXIkyaVXimg
X-Google-Smtp-Source: APBJJlF0iV8arZKjcRnh/OqkQN6id/ifXGf+P2zufzX5+E61gHQWc/gHz8HyRGmRA0Sl/6T9rekq0w==
X-Received: by 2002:a19:5e55:0:b0:4fb:78a0:dd34 with SMTP id z21-20020a195e55000000b004fb78a0dd34mr4613980lfi.42.1688774847602;
        Fri, 07 Jul 2023 17:07:27 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id l4-20020ac25544000000b004fbb6dd7ad1sm849009lfk.288.2023.07.07.17.07.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:07:27 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so40036281fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 17:07:27 -0700 (PDT)
X-Received: by 2002:a2e:880a:0:b0:2b6:cc93:4ecb with SMTP id
 x10-20020a2e880a000000b002b6cc934ecbmr5251360ljh.43.1688774846751; Fri, 07
 Jul 2023 17:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com> <ZKinHejv+xBq+gti@casper.infradead.org>
In-Reply-To: <ZKinHejv+xBq+gti@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jul 2023 17:07:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
Message-ID: <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Jul 2023 at 17:00, Matthew Wilcox <willy@infradead.org> wrote:
>
> Do we really want interruptible here rather than killable?

Yes, we actually do need to be just regular interruptible,

This is a bog-standard "IO to/from pipe" situation, which is interruptible.

> That is, do we want SIGWINCH or SIGALRM to result in a short read?

Now, that's a different issue, and is actually handled by the signal
layer: a signal that is ignored (where "ignored" includes the case of
"default handler") will be dropped early, exactly because we don't
want to interrupt things like tty or pipe reads when you resize the
window.

Of course, if you actually *catch* SIGWINCH, then you will get that
short read on a window change.

           Linus
