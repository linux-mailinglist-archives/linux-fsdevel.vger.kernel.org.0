Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578CE563464
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiGANcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGANcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:32:25 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4715D13CCF;
        Fri,  1 Jul 2022 06:32:25 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id j15so1176597vkp.5;
        Fri, 01 Jul 2022 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFqJC295NG9DNAfERioYUUvqiAV1pWyYlgz/QjSDQU8=;
        b=PQK01Ji/kk6/8H1ZDgZ7s1ztDtcLjY9uQak0G+AUwbR9vtK0xDh5tTJ8V38rhIus4H
         eqxR+oeqNdXb1i1zMEwheXUB1/VCc0CBYC/1zH0Vb5EpIwtCvjyW4jTOAe/7bdROH//q
         xBkqXY5Om9c31eZCa1OgnBtkbz6yboG6CxmPeNLEDL/bkdhzEOYjMQVowWaahnHEOhH9
         Gt/oYOR8R/z5xPiXbOX7Zpdt1KIDM1pz8m1IKH9cUGZdn35AFf/gj/LdT2VWalNsaLhg
         Pr3RSEv7v187/esbGZj+jSE9z/lXey7iXDAPXSkKbwa4DXkkE0lWUYBaLhDa9khD9y75
         KZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFqJC295NG9DNAfERioYUUvqiAV1pWyYlgz/QjSDQU8=;
        b=QhYnsv4C7kOFvCRQY8Q0B3GdiOBTuCcfxTpmcvS03+ttV+ikb5Tv2rCuRY8cKMpqaD
         mFRImA5NDvb4JMp8qGtQAHAR3mf8J0J+1yiol9iVh3VvrNsgBUlqk3HvQyt8W5uRZGeb
         VmFsSr9Tmxboq01lrzq1A5Vw922Ctxs8/lsMd+mm5xEAFRF3wgXt8icPEuPNvlAmRsLj
         dDRn8h2uZ9yl0jhya8UdS1vY3EPesLlsK9W9EuVOlvfhYB8m/JvRB/ghHZ9feCzhXbms
         5OJU3b+Tv2wdh2nNQoJY8rmW6cKD/qJog/u+3jmfQp9wDlR6xB/B+chDQRtulVVTeQlr
         Xj3Q==
X-Gm-Message-State: AJIora8nFjNOQWmOLUvv5OYaxCT9Maifu5dk3LSGHv6P4r6qYzSrldcf
        Kui/PqgEgGtGaAFo4XFgGl3Hs+XHRGVN8+qB6ZU=
X-Google-Smtp-Source: AGRyM1vA8JfOapTXjwZdTCJLat+wtZaAGo30VMPzzgbXVK6Dd1I1awLjf9YbxnPDsMJ8Uh0nP1NktkO0zs5vQJQIB3Q=
X-Received: by 2002:a05:6122:e10:b0:370:e49b:d1dd with SMTP id
 bk16-20020a0561220e1000b00370e49bd1ddmr533274vkb.25.1656682342823; Fri, 01
 Jul 2022 06:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220629144210.2983229-1-amir73il@gmail.com> <20220629144210.2983229-2-amir73il@gmail.com>
 <20220701124751.fccem5ce47prgmrh@quack3.lan>
In-Reply-To: <20220701124751.fccem5ce47prgmrh@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 1 Jul 2022 16:32:11 +0300
Message-ID: <CAOQ4uxjXZKoyJopBZAtaLKpBphjT4X7Wjgn=1gFu=S-qmpRKhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fanotify: prepare for setting event flags in
 ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 1, 2022 at 3:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-06-22 17:42:08, Amir Goldstein wrote:
> > @@ -529,6 +529,7 @@ struct fsnotify_mark {
> >       /* fanotify mark flags */
> >  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY       0x0100
> >  #define FSNOTIFY_MARK_FLAG_NO_IREF           0x0200
> > +#define FSNOTIFY_MARK_FLAG_IGNORE_FLAGS              0x0400
> >       unsigned int flags;             /* flags [mark->lock] */
> >  };
>
> The whole series looks good to me so I'll test it and queue it up. Just I
> find the name FSNOTIFY_MARK_FLAG_IGNORE_FLAGS somewhat confusing because I
> had to think whether it means "mark should ignore flags" or whether it
> means "ignore mark has flags". So I'll rename this flag to
> FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS on commit.

Excellent.
Thanks!

Amir.
