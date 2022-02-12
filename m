Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971C04B319F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 01:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354309AbiBLACO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 19:02:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiBLACN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:02:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6BD6C;
        Fri, 11 Feb 2022 16:02:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id eg42so18672434edb.7;
        Fri, 11 Feb 2022 16:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iF2f0XruZIARgUCyX1U2QPFCT1wqAIfn4C7VPW5cedE=;
        b=E1OC6PzUXj6YDqImYhhQ+36WQF1RffySieRfuha6Wmp5xzOJg6uwZa1XUrzjqDK3Zw
         eCAgyvSjSfehOxyq4NtVHsojj55l6mL6bsZzjANizfWmi8TqJhDJV/Abif7c4tr4wERG
         2BeUGCpJ9DJdMNft/AqjT8TZyVfEd7DWSlnTCGyl/01cfuGF0QGDdbQllnsIVkhkKmKw
         vcdRiUQXATKp7+8HQJllK/43T27H3FgQ0ARVqtAD88Etm+rMcqAoOTM/OjtQJi2GRIOf
         VwezrMPKBVNNAEXeOg8JpqcACcmH3CThHzqHaxFZwbsLObYdCzOAbvWtMp8b5UYX+fnm
         O+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iF2f0XruZIARgUCyX1U2QPFCT1wqAIfn4C7VPW5cedE=;
        b=AXR3me9LFEgbZAhKqYHC7mxC+lG8RJ/51MlTmS1fHluq6DmFKH0URmI4qMc/CIIc1N
         giyX4uyPBbEgCSwMzARZ1nXUtL6UOnFOsb5EYdL3Cw25SBYDKbtDl8lGv7ofAjBTqzJ7
         UDdCj5Tq/Mjy5ZekIvgtl0sYh5x4B2jFzUMB4cZDmgKsuXc2fthQUmfV8foYqFb/Lo3R
         ++TDewp1RBXr1jcC4Y4+ipxD2y++yZquMMlzD363GBIASbYY5/qdmiLBt0bHkml/tvnG
         N6k7lt9bjqZGf+hMSusvbx51+cmm9Hj5w12WEYSrsOp32CmlB2qTcOrB9J/dGKdb6XX8
         bQvw==
X-Gm-Message-State: AOAM53136d7FsLtSCZwKiNZpuAgOEvyjNLtMVyQMH3x19upBPnzrRc34
        AWTe6v1NxeExtltwKHcq7lah69ZZHuBlBogK2fA=
X-Google-Smtp-Source: ABdhPJz2v4mSNsOxWhvTeHK+NOGSRMEI3xsBmgOc+ctDZ7l7mneyTWm3B4nxteOCHtche1PAZzgrntTs4stjCHfAZZo=
X-Received: by 2002:a05:6402:23a9:: with SMTP id j41mr4346749eda.179.1644624128237;
 Fri, 11 Feb 2022 16:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20211130201652.2218636d@mail.inbox.lv> <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com> <f6a335b7-9cd8-eb02-69b3-bdf15ebf69fa@valdikss.org.ru>
In-Reply-To: <f6a335b7-9cd8-eb02-69b3-bdf15ebf69fa@valdikss.org.ru>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 12 Feb 2022 13:01:54 +1300
Message-ID: <CAGsJ_4zeNCTTTOG3BnbMYzg+bcNKtbjYQTOqCzBv4Jr2k_a4oA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, oleksandr@natalenko.name,
        kernel@xanmod.org, aros@gmx.com, hakavlad@gmail.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:19 PM ValdikSS <iam@valdikss.org.ru> wrote:
>
> On 13.12.2021 11:38, Barry Song wrote:
> > On Tue, Dec 7, 2021 at 5:47 AM ValdikSS <iam@valdikss.org.ru> wrote:
> >>
> >> This patchset is surprisingly effective and very useful for low-end PC
> >> with slow HDD, single-board ARM boards with slow storage, cheap Androi=
d
> >> smartphones with limited amount of memory. It almost completely preven=
ts
> >> thrashing condition and aids in fast OOM killer invocation.
> >>
> >
> > Can you please post your hardware information like what is the cpu, how=
 much
> > memory you have and also post your sysctl knobs, like how do you set
> > vm.anon_min_kbytes,  vm.clean_low_kbytes and vm.clean_min_kbytes?
>
> I have a typical office computer of year 2007:
>
> * Motherboard: Gigabyte GA-945GCM-S2L (early LGA775 socket, GMA950
> integrated graphics, September 2007)
> * 2 core 64 bit CPU: Intel=C2=AE Core=E2=84=A22 Duo E4600 (2 cores, 2.4 G=
Hz, late 2007)
> * 2 GB of RAM (DDR2 667 MHz, single module)
> * Very old and slow 160 GB Hard Disk: Samsung HD161HJ (SATA II, June 2007=
):
> * No discrete graphics card
>
> I used vm.clean_low_kbytes=3D384000 (384 MB) to keep most of file cache i=
n
> memory, because the HDD is slow and every data re-read leads to
> uncomfortable freezes and slow work.
>
> More information, including the video, is here:
> https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/

thanks!

>
> >
> >> The similar file-locking patch is used in ChromeOS for nearly 10 years
> >> but not on stock Linux or Android. It would be very beneficial for
> >> lower-performance Android phones, SBCs, old PCs and other devices.
> >>
> >
> > Can you post the link of the similar file-locking patch?
>
> Here's a patch: https://lkml.org/lkml/2010/10/28/289
> Here's more in-depth description: https://lkml.org/lkml/2010/11/1/20

thanks, seems to be quite similar with this patch.

>
> Please also note that another Google developer, Yu Zhao, has also made a
> modern version of this (ChromiumOS) patch called MGLRU, the goal of
> which is quite similar to le9 (the patch we're discussing here), but
> with "more brains":
> https://lore.kernel.org/lkml/20220104202247.2903702-1-yuzhao@google.com/T=
/#m8fd2a29bc557d27d1000f837f65b6c930eef9dff
>
> Please take a moment and read the information in the link above. Yu Zhao
> develops this patch for almost two years and knows the issue better than
> me, a casual user.
>

Thanks for all the information you provided. I think I have noticed MGLRU
for a while. Curiously, does MGLRU also resolve your problem of using
"a typical office computer of year 2007" ?

>
> >
> >> With this patch, combined with zram, I'm able to run the following
> >> software on an old office PC from 2007 with __only 2GB of RAM__
> >> simultaneously:
> >>
> >>    * Firefox with 37 active tabs (all data in RAM, no tab unloading)
> >>    * Discord
> >>    * Skype
> >>    * LibreOffice with the document opened
> >>    * Two PDF files (14 and 47 megabytes in size)
> >>
> >> And the PC doesn't crawl like a snail, even with 2+ GB in zram!
> >> Without the patch, this PC is barely usable.
> >> Please watch the video:
> >> https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/
> >>
> >
> > The video was captured before using this patch? what video says
> > "the result of the test computer after the configuration", what does
> > "the configuration" mean?
>
> The video was captured after the patch. Before the patch, it's basically
> not possible to use Firefox only with 20+ tabs because the PC enters
> thrashing condition and reacts so slow that even mouse cursor freezes
> frequently. The PC is absolutely unusable for any decent work without
> the patch, regardless of swappiness, vm.min_free_kbytes or any other
> tunables.
>
> The configuration is this patch with vm.clean_low_kbytes=3D384000 and 150=
%
> zram. More information is provided on the website.

thanks!

>
> >
> > Thanks
> > Barry

Thanks
Barry
