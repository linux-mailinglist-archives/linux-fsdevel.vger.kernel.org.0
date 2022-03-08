Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960294D26CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiCIBjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCIBjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89EA1C3342
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646789881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8fgJdSd4jTcxLbOrTQCZhthR47fpf/x6S9nK5SfbMc=;
        b=hF1giwJkv2t1b57WNnlLpu5Ad9dLTWuPebnKCIlzPqL9OcT/Tq8K4QItV7utg5UirZutGX
        vSWnXjZdkNrsGHmfGIJgqK16Iy+V6Em2rq1CFgh3CKQ06pjfoLqOVOxVuEjk4T4TU+rmar
        K58IVN3owsKF1lmK1jO+xjfFxaD6Zfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-hcmP_NqvOA6IVOwc-0YAyw-1; Tue, 08 Mar 2022 18:24:58 -0500
X-MC-Unique: hcmP_NqvOA6IVOwc-0YAyw-1
Received: by mail-wr1-f71.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so85459wrr.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 15:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8fgJdSd4jTcxLbOrTQCZhthR47fpf/x6S9nK5SfbMc=;
        b=hyRP95CFKIfhnxQSt3VlOF/kr+eZ/5Jo4Zp0n8QRlxbG1nZyXKdGmZGN0fn0NM42hk
         xFSj+GofVOE58G2sDKyIYax89SPueIz8GZsd91GaBBCaVNpa75h0tpeb9bW8PXoJ7Gr8
         cgF1zRX9YgF/z7lBLoHR9CJQScHv8WUDpxIK+3HHlUmKy7HpTteO47tmMJphoZGZD+17
         +BqIabOTf4GCiVtGf/uebqVQ4sG7JQ+7U+PnBtgsqdGEryOn3ucxwabVlu7cVzcG3fbI
         5AiItxup3P0TQLo4zZyL7u5TI34aDQL7eB8PHWEIXS0COydUx68Kbe6aoUI4EHgKZDyi
         OpMQ==
X-Gm-Message-State: AOAM531DcCq4JqFk9lcEpYMM5aS/zaV/aQ1VfscRl5mr/8PrncxtovUC
        gRMirnGBG+FEzIjmAmZu6X29Z4XHkf1zTtfU1x0PtSTsUZ6dOTyiTs5yAwhBmYVXMQFmI6h0FKA
        2FvkgB0zR/frC9OrraIHeoWNGvATvDMh9u2hnW7MrtQ==
X-Received: by 2002:a5d:5849:0:b0:1e3:1df9:1b1e with SMTP id i9-20020a5d5849000000b001e31df91b1emr14404409wrf.640.1646781896874;
        Tue, 08 Mar 2022 15:24:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNeW+VQoJ+JZHe58Un79Oa7EZWv0j4un3m858XpDFc2zPRghBXfevTp5t7ru/YSoSrtywRG5Q7JsT2HycIa/A=
X-Received: by 2002:a5d:5849:0:b0:1e3:1df9:1b1e with SMTP id
 i9-20020a5d5849000000b001e31df91b1emr14404393wrf.640.1646781896454; Tue, 08
 Mar 2022 15:24:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com> <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
In-Reply-To: <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 00:24:44 +0100
Message-ID: <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 8, 2022 at 11:27 AM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > So I think the fix for this all might be something like the attached
> > (TOTALLY UNTESTED)!
>
> Still entirely untested, but I wrote a commit message for it in the
> hopes that this actually works and Andreas can verify that it fixes
> the issue.
>
> Same exact patch, it's just now in my local experimental tree as a commit.

Seems to be working on s390x for this test case at least; the kind of
trace I'm getting is:

swpd free buff cache read_fault read_fault_race read_lock_stolen min_flt maj_flt
0 2249156 6352 783924 0 0 0 1142 157566
0 2076308 5896 961680 0 0 0 1 52702
0 1938824 5896 1186184 0 0 0 506 56708
0 1719640 5896 1404268 0 0 0 0 54604
0 1454772 5896 1590780 0 0 0 741 45044
0 1213924 5896 1828048 0 0 0 0 60716
0 995300 5896 2046172 0 0 0 0 54408
0 843140 5896 2264756 0 0 0 622 54412
0 630328 5896 2478980 0 0 0 0 53578
0 446096 5896 2675508 0 0 0 569 48286
0 315156 5896 2806336 0 0 0 0 33396
0 169068 5896 2954052 0 0 0 0 36151
0 33980 5064 3095736 0 0 0 681 49776
0 136596 1068 3012612 0 0 0 0 48800
0 51128 1068 2887180 0 0 0 48605 49288
0 42276 1068 2895960 0 0 0 1 49776
0 45496 944 2890752 0 0 0 35 49288
0 38592 944 2896364 3 0 0 124 44817
0 37100 944 2976368 46 0 0 25412 27301
0 37204 928 2981564 0 0 0 0 62316
0 52384 928 2965820 0 0 0 0 30020
0 32296 928 2830228 0 0 0 61824 49281
0 36208 928 2831920 0 0 0 0 49599
0 37424 928 2830176 0 0 0 0 48800
0 35676 928 2830256 0 0 0 104 46282
0 140932 928 2987628 0 0 0 628 47871
0 32128 928 3095628 0 0 0 0 49086
0 40900 920 2752240 0 0 0 79824 131220
0 67380 920 2723188 0 0 0 39 61666
0 42560 884 2747124 0 0 0 4 27266
0 43296 880 3036340 16 0 0 6557 79270
0 160616 832 3043056 0 0 0 379 44515
0 36892 688 2864892 0 0 0 49524 59299
0 38004 688 2866088 0 0 0 0 57308
0 39732 568 2860468 0 0 0 49 51105
0 37364 568 2861224 0 0 0 0 0
0 35432 568 2863220 0 0 0 0 0
0 38996 568 2859308 0 0 0 0 0
0 40808 568 2857044 0 0 0 0 0
0 35360 568 2865076 1 0 0 4 0
0 31592 564 2861216 123 0 0 50577 29984
0 32816 564 2857012 0 0 0 0 130047
0 39588 564 2785968 0 0 0 66022 50499
0 37752 564 2788028 0 0 0 0 53397
0 35576 460 2789696 0 0 0 0 52803
0 35944 460 2790020 0 0 0 13 37240
0 38280 460 2787336 0 0 0 0 0
0 38588 460 2786444 0 0 0 0 0
0 36940 460 2785644 0 0 0 0 0
0 39560 460 2784648 0 0 0 0 0
0 115032 452 2777568 4 0 0 16 0
0 44772 452 2808116 0 0 0 71280 139232
0 35828 452 2812368 0 0 0 0 57886
0 33420 452 2815904 0 0 0 0 56762
0 222932 452 2901480 0 0 0 1761 51125
0 34988 452 3085360 0 0 0 0 55638
0 32716 336 3049448 0 0 0 6398 54202
0 38572 336 3050040 0 0 0 0 54172
0 250724 336 3052404 0 0 0 422 37779
0 39204 264 2754388 0 0 0 78287 55056
0 39564 264 2752932 0 0 0 0 52712
0 38108 232 2752660 0 0 0 38 53350
0 32448 196 2753920 0 0 0 2 29024
0 36536 196 2754172 0 0 0 0 0
0 36116 196 2749096 0 0 0 0 0
0 35968 196 2754416 0 0 0 0 0
0 33744 196 2756908 24 0 0 96 0
0 33428 196 2870904 16 0 0 48271 123984
0 124932 196 2916896 0 0 0 14925 47427
0 44764 196 2993408 0 0 0 0 57057
0 46396 196 2990544 0 0 0 0 49864
0 39224 196 2996332 0 0 0 0 3124
0 34524 196 2844232 0 0 0 49321 6308
0 34088 92 2794136 0 0 0 14846 62955
0 38680 92 2792752 0 0 0 0 48056
0 36756 92 2793916 0 0 0 36 48994
0 37336 92 2791996 0 0 0 4 18127
0 38844 92 2760304 26 0 0 61323 48345
0 42584 92 2755980 0 0 0 0 53772
0 39436 92 2758252 0 0 0 804 51220
0 33408 88 2764016 0 0 0 339 32307
0 38228 88 2759052 0 0 0 0 0
0 36816 88 2760776 0 0 0 0 0
0 38624 88 2759628 0 0 0 0 0
0 38912 88 2752788 234 0 0 936 0
0 35640 88 3070384 394 0 0 2193 108219
0 38816 88 2716016 0 0 0 83715 55072
0 37084 88 2716076 0 0 0 0 50703
0 49256 88 2703460 0 0 0 0 51268
0 38256 72 2714892 0 0 0 0 38361
0 43468 72 2709640 0 0 0 0 0
0 38448 72 2715140 0 0 0 0 0
0 40536 72 2713412 0 0 0 0 0
0 36060 72 2711732 4 0 0 16 0
0 35804 72 2697600 65 0 0 88429 76050
0 42100 72 2687776 0 0 0 0 78018
0 44532 72 2682776 0 0 0 37 47051
0 57652 72 2911680 0 0 0 27636 60021
0 38196 72 2930916 0 0 0 0 39256
0 304060 72 2926132 0 0 0 6 41287
0 42524 72 3067232 0 0 0 446 58607
0 36244 72 3071536 0 0 0 0 45878
0 41052 72 2815772 0 0 0 59290 53910
0 38264 72 2816620 0 0 0 0 20666
0 39772 72 2815696 0 0 0 0 23975
0 37016 72 2817520 0 0 0 0 46818
0 39172 72 2889840 0 0 0 41578 47448
0 36440 72 2890160 0 0 0 1 48756
0 35028 72 2888492 0 0 0 0 49428
0 54364 72 2975816 0 0 0 14981 48084
0 36580 72 2992292 0 0 0 0 37284
0 35852 72 2992000 0 0 0 0 48168
0 36280 72 2833252 9 0 0 53762 48677
0 38916 72 2827892 0 0 0 0 48467
0 36996 72 2829432 0 0 0 0 48347
0 42524 68 2822216 0 0 0 0 32250
0 37060 68 2827612 0 0 0 0 0
0 38080 68 2827556 0 0 0 0 0
0 41660 68 2822936 0 0 0 0 0
0 32384 68 2824372 0 0 0 0 0
0 37468 68 2754364 58 0 0 70218 117793
0 36568 68 2756192 0 0 0 56 53470
0 125052 68 2906412 0 0 0 8070 49300
0 38468 68 2990660 0 0 0 0 49776
0 41180 68 3012140 0 0 0 684 49776
0 38044 68 3012908 0 0 0 1 50752
0 38924 68 2774392 0 0 0 56420 44877
0 36824 68 2777720 0 0 0 0 800
0 39172 68 2775236 0 0 0 0 1568
0 39748 68 2774740 0 0 0 0 960
0 35768 68 2778264 0 0 0 0 1920
0 40568 68 2773900 0 0 0 0 1696
0 41616 68 2773096 0 0 0 0 3712
0 42688 68 2772320 0 0 0 0 5408
0 39736 68 2774648 0 0 0 0 5152

This shows bursts of successful fault-ins in gfs2_file_read_iter
(read_fault). The pauses in between might be caused by the storage;
I'm not sure.

I'd still let the caller of fault_in_safe_writeable() decide how much
memory to fault in; the tight cap in fault_in_safe_writeable() doesn't
seem useful.

Also, you want to put in an extra L here:
> Signed-off-by: linus Torvalds <torvalds@linux-foundation.org>

Thanks,
Andreas

