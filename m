Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA251CD57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 02:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387405AbiEFAG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387524AbiEFAGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 20:06:18 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946666FA1;
        Thu,  5 May 2022 17:01:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ke5so4317074qvb.5;
        Thu, 05 May 2022 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuHdbS0xWKHmv6J1u5d3rVQ4QxnLhs8Sn7FHmkEtewk=;
        b=Pr2SsDM6VQo3fJLxPMqbyGDLZbtVZgtiXd0+o5ekU8f7JLpY5LwRFnTQsrtqIrxqbH
         6Y9UHjMLz9FUBhLDCIRZmPyLb0gU391/Ld0Z6HOFDGtjDz7TIJbqNO6ZlgBFqGVCkmkp
         2QiHhpHNBoczmw8RBFMtBvCTFWAflOtAk6kwLe7EvuMtZpYwqupDIKIHqD8sVVb1Zqve
         us86t/7Ejqg2iCyeHYR+rhF2si5TK6uF3lBtpUdKrQ45hIkxs1R9fr1N4bfA227spK8N
         3Knn7IN8DdUsfGXtkPEwdK/rrQRxRb6rOMAuZ5N6VFDGTUF3D7G7GCRPFsyheBOBVMLE
         i2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuHdbS0xWKHmv6J1u5d3rVQ4QxnLhs8Sn7FHmkEtewk=;
        b=5vDarfA8JPd9AuS8sGnzfoQ7CADI2Zi/Blq1WyOpURaJNYQ80Y/wjnNzmvHm4Ny6+j
         xNKG4dMU1oK6HZ7cJicE5nqx8p+hiTUkQUFzgVYQ3R36JxNAd2n88NS08XSV4vGCNoD/
         htGU6w4EQBFNuOPxO4K5T3VF9fVla7cgQirPcVGplsMfjFPm6aZ8Me7BoIjisb+Mfh5a
         47qTvREPI+Am105kd0n6VBChop+P+ODchMxJgSpYGycuemm92Q4SRh5HUaIc/b6h3usK
         0u7qdOzvA2SUwcDV4arfa8fu5E6Rg7MOKyne9u6DvuRL5s3tMxU60HooDNOGtzTR79bX
         XruQ==
X-Gm-Message-State: AOAM531MBGv5bRXBtY2U4pUJRZYANPNMqIDNL1z47p9215lHks0z5gZg
        c/FAucHbQU2mhbZubCPZF0vrFi1ISu/xstj4YXk=
X-Google-Smtp-Source: ABdhPJwpMdt/KfyK/x4AVKoVhsS6iD7B3iwfmlFE4qs7nyyrC3w5UkNhXHm5T4e0BK3HVvB26Wo15XjFmS9ni+1vqCk=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr460845qvb.74.1651795269661; Thu, 05 May
 2022 17:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <YnOmG2DvSpvvOEOQ@google.com> <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan> <YnRhVgu6JKNinarh@google.com>
In-Reply-To: <YnRhVgu6JKNinarh@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 May 2022 03:00:58 +0300
Message-ID: <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
Subject: Re: Fanotify API - Tracking File Movement
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

> > > HOWEVER! look at the way we implemented reporting of FAN_RENAME
> > > (i.e. match_mask). We report_new location only if watching sb or watching
> > > new dir. We did that for a reason because watcher may not have permissions
> > > to read new dir. We could revisit this decision for a privileged group, but will
> > > need to go back reading all the discussions we had about this point to see
> > > if there were other reasons(?).
> >
> > Yeah, this is a good point. We are able to safely report the new parent
> > only if the watching process is able to prove it is able to watch it.
> > Adding even more special cases there would be ugly and error prone I'm
> > afraid. We could certainly make this available only to priviledged
> > notification groups but still it is one more odd corner case and the
> > usecase does not seem to be that big.
>
> Sorry, I'm confused about the conclusion we've drawn here. Are we hard
> up against not extending FAN_RENAME for the sole reason that the
> implementation might be ugly and error prone?
>
> Can we not expose this case exclusively to privileged notification
> groups/watchers? This case seems far simpler than what has already
> been implemented in the FAN_RENAME series, that is as you mentioned,
> trying to safely report the new parent only if the watching process is
> able to prove it is able to watch it. If anything, I would've expected
> the privileged case to be implemented prior to attempting to cover
> whether the super block or target directory is being watched.

To be fair, that is what the "added complexity" for the privileged use
case looks like:

                        /* Report both old and new parent+name if sb watching */
                        report_old = report_new =
+                               !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) ||
                                match_mask & (1U << FSNOTIFY_ITER_TYPE_SB);
                        report_old |=
                                match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE);

There is a bit more complexity to replace FSNOTIFY_ITER_TYPE_INODE2
with FSNOTIFY_ITER_TYPE_DIR1 and FSNOTIFY_ITER_TYPE_DIR1.

But I understand why Jan is hesitant about increasing the cases for
already highly
specialized code.

My only argument in favor of this case is that had we though about it before
merging FAN_RENAME we would have probably included it.(?)

>
> > So maybe watching on sb for FAN_RENAME and just quickly filtering
> > based on child FID would be better solution than fiddling with new
> > event for files?
>
> Ah, I really wanted to stay away from watching the super block for all
> FAN_RENAME events. I feel like userspace wearing the pain for such
> cases is suboptimal, as this is something that can effectively be done
> in-kernel.
>

I'm not opposing. Letting Jan make the call.

Thanks,
Amir.
