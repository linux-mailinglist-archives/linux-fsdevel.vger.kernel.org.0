Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08BC4F8FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 09:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiDHHgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDHHgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCAF517F3CC
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649403279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pZtNdOfzSSjYErKFbduDDmGmm5jb8VIKf0crmx7H+8=;
        b=OEgbx31KJq0ZIHom98zu2AHUvZ/1hHJvYacuHG4SKAY8Vr+jGgebITMrl4OR+M/nP7krtE
        o5/Tg5k9I6ZsedYoTuMRGGq48HvWcfWtOO+RHlIeSwIdDIYeIXeb90OxUIT5hTBYjq4KV+
        N7h52h52bdvS7pMtZOIxAP5GEcHIpQk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-abvq77jDNqCDHeCdTpgmiw-1; Fri, 08 Apr 2022 03:34:38 -0400
X-MC-Unique: abvq77jDNqCDHeCdTpgmiw-1
Received: by mail-pj1-f70.google.com with SMTP id l2-20020a17090ad10200b001ca56de815aso5125166pju.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2pZtNdOfzSSjYErKFbduDDmGmm5jb8VIKf0crmx7H+8=;
        b=LFKNi0I/REj84zQmU5CDa/LxV1o8++QBGJaGkbqq0ySbs5UlHRRr3vKIME3WygpjCJ
         THv9Ix8UJW4GuolGjEJf43oE9GeN/qkvHX4mT5Dqi+G4AUI1SA4xAEfDJKKlDCawSvms
         wRspIhRQO00KmzhS2db8eyWg3WiPzxDr7RhR/gLHWPq+b48gW2zh1tQtny0taYu4KEVy
         4VrptGjNu7SxhlaqRI/RbPwx8+pPcoJ0Z/hkS6Wli8wDn4zofapfQG8AcWKKJ4sR0tMw
         wjNzvHmF3fjd9YaYw4EGrDijoYouQJJV8F3D27aNTYKTZvvUZ9HwEr0zwsXxUIEGr4nZ
         EzZQ==
X-Gm-Message-State: AOAM5339pn82vAz/N8HI4WeHtZN8pbsjHlZdPeVPqocjJ2PXnT/DUilC
        3BuUCVDNJTGHY/SqI5G7CWMeMxsJ+hxdYTUPJ43T//lHyPwxWA4V6exVN6p4xnPKKWbsoqUs0gm
        1tzlENRxrcsP0MGtP/mq6lsSavg==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr20149864pjb.136.1649403277220;
        Fri, 08 Apr 2022 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjiixitDhfCBnxdHYNFpXmS1gcb7RjPFPV53J4awpX4yEvqxdF4QJ1y3nbomuazGOuHBqaVg==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr20149838pjb.136.1649403276887;
        Fri, 08 Apr 2022 00:34:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm21121644pgc.80.2022.04.08.00.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:34:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:34:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Message-ID: <20220408073431.zhsx73p5rygzuj2g@zlang-mailbox>
Mail-Followup-To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407134350.yka57n27iqq5pujx@wittgenstein>
 <624FC123.6060603@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624FC123.6060603@fujitsu.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:58:27AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/7 21:43, Christian Brauner wrote:
> > On Thu, Apr 07, 2022 at 08:09:35PM +0800, Yang Xu wrote:
> >> Since we can create temp file by using O_TMPFILE flag and filesystem driver also
> >> has this api, we should also check this operation whether strip S_ISGID.
> >>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >
> > This is a great addition, thanks!
> > Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> Thanks for your review.
> 
> @Darrick @Eryu @Zorro
> just a kindly question, not a push
> xfstests has not update for 3 weeks and Eryu will take off maintainer.
> 
> Zorro lang has apply for this job. So when does xfstest can work well?

Hi Yang,

Sorry for the delay, I'm still waiting for the job handover, I have no
permission to push to kernel.org now. The transfer might need a few days/week,
Eryu is busy on other things :) He might merge the current patches on queue
when he get free time, then we can start the handover step by step.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu

