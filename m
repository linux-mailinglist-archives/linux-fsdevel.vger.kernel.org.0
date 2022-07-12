Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F8C572452
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiGLS7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiGLS7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:59:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A56EFFAC
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:47:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ez10so15886090ejc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LVjdrSUdgk/Z2+i3RfaN6zaqfkfb+1hmed5xjtIGBA=;
        b=g4UJ3r+vpSDEu+NNwedTLvqKIT0WwUTEWgK5epIQCZB95SegmvkA55nIGH7wDEDQHO
         iAdYbPcTUABKD/Gq1iTXvxlB6+Ux31BNb7XvinqK0F1C6ckPDJGhY5jsqf1JrFOGJ6fl
         ro4qlYUOaPNZNSWmbH2TBFYvkD1GqSrzGlK5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LVjdrSUdgk/Z2+i3RfaN6zaqfkfb+1hmed5xjtIGBA=;
        b=dto9tPhRXWJZLwgzg3ncs5qUAxcvAy7wIXXkdyJ06rOYx7bVU8p8bCF6J/wRyrkM31
         R4oNguBwGfYL1PB9w8BCZAMWDTa2thAd49EHR9lnu2rCFHpRkxmxNqm7S3qQlEyxNBQl
         7HgIyY85FNIVtUEGT/qpBk9bzRFXV94VRN/ALnI9W62cI3kZBdlJXbnMmWllHgPUBi9T
         N5k+jIgLDNYo8CrbfkYmCKKAAIhUXWZGyVYKoTXgNM0wCPJ0qRmrTPGagE8/LZtkbtpK
         rWa8OFdHDkX3H83xrKNjbnJlOLWD0pItUxobnkZbuQ7dyaAXPGgyYP0v/UmCdx/L3Bky
         SqIg==
X-Gm-Message-State: AJIora8t/k2V3MTeuyesiL49xFVHBvUBmcMI/TfX1WhNx9LpYzBdVqgw
        xDerGWh8zWfu87hotR03HCGql4FzPQxPCgHWAJw=
X-Google-Smtp-Source: AGRyM1tV4R+tts0GssWnaF73g8dq0Iy30XulibSWPX7ibOGtGa4412mZeR+RSKBTAeiG/s3hm3+KtA==
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id zd7-20020a17090698c700b0072b20fe807dmr25989287ejb.75.1657651675740;
        Tue, 12 Jul 2022 11:47:55 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00726298147b1sm4023260ejg.161.2022.07.12.11.47.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:47:53 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id v16so12388963wrd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:47:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr9814336wry.97.1657651673239; Tue, 12 Jul
 2022 11:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com> <Ys3A16T3hwe9M+T2@casper.infradead.org>
In-Reply-To: <Ys3A16T3hwe9M+T2@casper.infradead.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 11:47:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpuxOZp+hFdWxmqM5L7FZb2HU49pRYoCZOfvXSSXY6Tw@mail.gmail.com>
Message-ID: <CAHk-=wgpuxOZp+hFdWxmqM5L7FZb2HU49pRYoCZOfvXSSXY6Tw@mail.gmail.com>
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

On Tue, Jul 12, 2022 at 11:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I'm going to leave discussing the permissions aspect to the experts in
> that realm, but from a practical point of view, why do we allow the dedupe
> ioctl to investigate arbitrary byte ranges?  If you're going to dedupe,
> it has to be block aligned (both start and length).

I agree, although I think that's a separate issue.

I suspect it should just check for inode->i_blkbits alignment. I think
that's what DIO does, and it seems like a sane minimum.

            Linus
