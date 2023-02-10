Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F2692846
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjBJU12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 15:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjBJU10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:27:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AB7EC0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:27:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qb15so16759377ejc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZamuEXhcVKZ56iZ3/bDfyhF3ja60Eault4YAmV7SNAQ=;
        b=TsQKwX+1pP22FCPs56/vCyqzRlBYKeuKP+V+HcYEmqly8S8QflkfYnflBEP5lT6H5b
         F5OqDGoPLeri/hXpHRWaa+8lQPdUE2328dZc2DlNg611cY7QRaeODNzYeLtGw62oGpye
         2d9QF4GSiwH6uplYVACzSv0yvdtDNJX7mh9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZamuEXhcVKZ56iZ3/bDfyhF3ja60Eault4YAmV7SNAQ=;
        b=BC4RRW1zr2HeMxw4dP3wVXmh/VarmhnhTUt4iBHuNben+hi8H0szyAz0LsTx6ypqtL
         9nEHNhnLs7JVe2kf85BJp+HtoCdNc0yGNHx1XARdxqMy+M4gUpz0kUM9zceYogWumJAO
         EXbrST4f4/RO5lYVTQJ+wAFNmvHkaRlVlohGP0HDgeAv3OIA76em94JrjaOLF0LJetYU
         ck1bgc9k6bUacfyM7jaJA3xGceR2nxWbkWtbKw2ghBTQhL1O86OZn+KRGuJSDR5ICliY
         qA/kN0CLpGZnhTZzx2ZGuEXeNKt04MzStVdMtD624k3ytg0Qym+xc0VliYAN9T308Q7g
         WUPw==
X-Gm-Message-State: AO0yUKX2O/G0TeouWcd5YMLBhaGS+TR5OuBec8LTii4Joz4uy8lzuErD
        LiukiO28fXhCtfMdRY1Chx2qiCH31ZnGhaHNWLw=
X-Google-Smtp-Source: AK7set8tdzk8J6i6vWO/YsAS1AC6xvKpaufQ23oXB0r9+EgWLK7JBBH4hUtzIOPInQOR/yi1UvyJBA==
X-Received: by 2002:a17:907:724e:b0:8af:2fa1:5ae5 with SMTP id ds14-20020a170907724e00b008af2fa15ae5mr10576340ejc.53.1676060839375;
        Fri, 10 Feb 2023 12:27:19 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id la2-20020a170906ad8200b008888f4120d4sm2811527ejb.129.2023.02.10.12.27.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:27:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id hx15so18773740ejc.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:27:18 -0800 (PST)
X-Received: by 2002:a17:906:9381:b0:878:8061:e114 with SMTP id
 l1-20020a170906938100b008788061e114mr1469478ejx.0.1676060838145; Fri, 10 Feb
 2023 12:27:18 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com> <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
In-Reply-To: <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:27:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
Message-ID: <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Fri, Feb 10, 2023 at 11:56 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> i think this is almost exactly what Jeremy and Stefan are asking for
> re: notification when the system is done with a zero-copy send:

Yeah, right now it's all just "incremented page counts", I think.

Even the pipe code itself doesn't know about writes that have already
been done, but that are pending elsewhere.

You'd have to ask the target file descriptor itself about "how much do
you have pending" or something.

           Linus
