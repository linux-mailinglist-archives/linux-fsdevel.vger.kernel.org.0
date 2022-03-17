Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68E4DCED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 20:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiCQT2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiCQT2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:28:13 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34467215478
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 12:26:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bx44so2062471ljb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kld44BtN3rNiFeHs8eqamOSFXSi6G0Opd+8/ljmh7IE=;
        b=aKUrlosQ/9HfOXQQwNdHeJfbdj6COyNpFJt+90/nk3eG+hm/7ahcfqx8JRd6Enx5Zd
         qbllDAtGaAxjsCoL0umx6EmEc9sKvG1fp+yQBmtND7UETKMwdzRSahFjsF1ERXx++3Qt
         87+Ue7rFm3KGaX8La/yPJQpzPxff/HSYVrV20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kld44BtN3rNiFeHs8eqamOSFXSi6G0Opd+8/ljmh7IE=;
        b=48NFfi5HV7YYa2qrUiICyXLbygL8Tt+sx4kqudFfPL+kPfnUNpq/MTDRNw1nhCKIJG
         OT8zPFRsfeJJiraO9flRveGmrxAGKvB6Jsz0d3fl3kBsa2FVZ3MSn1s+Y6tQgT+7S/HV
         OE/Yys3yFaxhcWwLfLfq5GeeLM4QxJZ5UuuALK4n7nTft6+60v7XcXaKjzCiMPqPeqxC
         qvRJ4w9KQt2c1ikdRXm8Ge9xVvZ9K1cmqvq/L/kST3zijggWGk0vRIzW6ApvtvN9jauN
         tZ+VYRsRZHw+C3cy3V+qqwdDsVqYI2BpDIcG60l3KNB5mIOjUKBIrz1Hi96vZvlkpm3L
         7OHg==
X-Gm-Message-State: AOAM531Pl1U0zLq15lb4Uutg7Gw4bdz8BR7XpaLZ6EWWJY7cqP/kSWVx
        xS3DErqoZyz8KojtRIoXpaHnk6w9fm4YKDXstBQ=
X-Google-Smtp-Source: ABdhPJxHKSs1uFDtJMt09P/Ymp5Sqbgq2ZPrvZAQw6NBOKEBCmj0HbPT3Yx0CGwU+xMQ5mMaknYO0w==
X-Received: by 2002:a2e:3019:0:b0:249:63ec:e397 with SMTP id w25-20020a2e3019000000b0024963ece397mr2544825ljw.332.1647545212289;
        Thu, 17 Mar 2022 12:26:52 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a11-20020a194f4b000000b004482e94a3b1sm516749lfk.19.2022.03.17.12.26.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 12:26:51 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b28so10698228lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 12:26:51 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr3766610lfs.27.1647545211431; Thu, 17
 Mar 2022 12:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com> <YjNN5SzHELGig+U4@casper.infradead.org>
In-Reply-To: <YjNN5SzHELGig+U4@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 12:26:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
Message-ID: <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 8:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> So how about we do something like this:
>
>  - Make folio_start_writeback() and set_page_writeback() return void,
>    fixing up AFS and NFS.
>  - Add a folio_wait_start_writeback() to use in the VFS
>  - Remove the calls to set_page_writeback() in the filesystems

That sounds lovely, but it does worry me a bit. Not just the odd
'keepwrite' thing, but also the whole ordering between the folio bit
and the tagging bits. Does the ordering possibly matter?

That whole "xyz_writeback_keepwrite()" thing seems odd. It's used in
only one place (the folio version isn't used at all):

  ext4_writepage():

     ext4_walk_page_buffers() fails:
                redirty_page_for_writepage(wbc, page);
                keep_towrite = true;
      ext4_bio_write_page().

which just looks odd. Why does it even try to continue to do the
writepage when the page buffer thing has failed?

In the regular write path (ie ext4_write_begin()), a
ext4_walk_page_buffers() failure is fatal or causes a retry). Why is
ext4_writepage() any different? Particularly since it wants to keep
the page dirty, then trying to do the writeback just seems wrong.

So this code is all a bit odd, I suspect there are decades of "people
continued to do what they historically did" changes, and it is all
worrisome.

Your cleanup sounds like the right thing, but I also think that
getting rid of that 'keepwrite' thing would also be the right thing.
And it all worries me.

            Linus
