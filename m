Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC95572506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 21:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiGLTHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiGLTHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:07:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAAFB8E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:51:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j22so15959199ejs.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsoVYbge3dl91JfzBd9hT52S48+b7ODf4TAVhqHvoZE=;
        b=dWrwKONpyguW41SO2t4ZmxJZ8hW3/A8U+OO8x3YGI/9AsSs3VL+jH6zb7chg4yvE3u
         b2OLPhFMHILE8C7z/RQsmO7Kh+CdGIZlIluTBGihpv+vrFHbEjD5IWnfo2K0o5pWbyON
         IFi2eW1wAoHeAAUZ1NO60i0dcuIiuxFDYlOxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsoVYbge3dl91JfzBd9hT52S48+b7ODf4TAVhqHvoZE=;
        b=33SaCHEkZj6XP0lvouKbgs2A9OKxJGv4jsM8WW0ByGObktKyx84/MctQCwCwK8ZP8o
         YJaLbvxV0VtUeBY6tscJHGVvTj7tjoD11jIvjMo0/bBrO4BmwM5MehBEVY6Meqyy2QOs
         bKROaLqw0WdEVVC0u9f2dy2IedwidNpj8CyXnt4z8HciVa/28D7UVNPbhFFd/60mjTSO
         KAGZYkGx5cILXkPkBkQXfnCDC0lR4mI3MnLeSzzAPaaT+F28VneDDCrAkgd2IkwQqkAL
         hUcvxJIRW6azvbk0Ty9hROB7etA6PoWKOvCf0roMHga0ECj+QL+x8BRUAGn+xy9vquRH
         iWwA==
X-Gm-Message-State: AJIora9ncAXJf0t5f/WBd3auDeTKoyAZ5L9R91d3i557Dg3gLRM128MZ
        5ouQMTgw4vwydB9iySlB9AipeaQG1ZJb+goa1Vw=
X-Google-Smtp-Source: AGRyM1ulWB7+3XQydc244tZ6t6D/YudSmnfHn2Yqfqw2ubtuW1CkMxuc/lOPrcf/WT4G9tuamY/Kfw==
X-Received: by 2002:a17:907:d05:b0:6f4:3729:8e36 with SMTP id gn5-20020a1709070d0500b006f437298e36mr25936910ejc.475.1657651884464;
        Tue, 12 Jul 2022 11:51:24 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709064a4600b0071cef8bafc3sm4138915ejv.1.2022.07.12.11.51.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:51:23 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h17so12481205wrx.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:51:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr22209985wrb.442.1657651882760; Tue, 12
 Jul 2022 11:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <Ys3A16T3hwe9M+T2@casper.infradead.org> <CAHk-=wgpuxOZp+hFdWxmqM5L7FZb2HU49pRYoCZOfvXSSXY6Tw@mail.gmail.com>
In-Reply-To: <CAHk-=wgpuxOZp+hFdWxmqM5L7FZb2HU49pRYoCZOfvXSSXY6Tw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 11:51:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3xGkMpbAxM7ec6BwgDz7aWn5H5s-dQUvKvZZe8HZs-Q@mail.gmail.com>
Message-ID: <CAHk-=wj3xGkMpbAxM7ec6BwgDz7aWn5H5s-dQUvKvZZe8HZs-Q@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Matthew Wilcox <willy@infradead.org>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:47 AM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I suspect it should just check for inode->i_blkbits alignment. I think
> that's what DIO does, and it seems like a sane minimum.

.. actually, looking closer, DIO also knows about and tries to deal
with blksize_bits() of the underlying device.

Which makes sense for IO patterns, because that's basically the
"physical alignment" (vs "logical alignment") part.

However, from a filesystem dedupe standpoint, I think the logical
alignment is what matters, so just i_blkbits seems to be the best
model.

            Linus
