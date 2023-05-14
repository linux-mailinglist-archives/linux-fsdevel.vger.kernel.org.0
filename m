Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D0701F88
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 22:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjENUkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjENUkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 16:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A52E5B
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684096784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chiG9B17KaDQNtNXqn0GHLZ1gAQxyO0beu2VdkhRIDA=;
        b=dV5HUMfSElj/h5P+mBpIpLqfqlLv82ZChkzUN1yx1gveLYyuTNbRfaG85heEEwi1rVK13C
        oxU14kZanBHzimO9tV3CbIHxZuhEdHX749aaVk9y+Rh/DbKCkCQV0XXW/sk/kVXGC9e/25
        /Cnt7XeuTzcrkufOvC2aDNL20lVV/3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-j2ZTVVGTOmqNpDbRDK8zlw-1; Sun, 14 May 2023 16:39:42 -0400
X-MC-Unique: j2ZTVVGTOmqNpDbRDK8zlw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42ceb4a4fso21256145e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 13:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684096781; x=1686688781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chiG9B17KaDQNtNXqn0GHLZ1gAQxyO0beu2VdkhRIDA=;
        b=k7ewTtLqk8jCnHSv1Y14vQNwP284r2mlOnDgCKRP8otvrr7tMQFznLCbCa5QPmBc7b
         ji17EY2zBDdPJ8EPhOasdybuwYYbctxyv6J2T/1FQ5zbhePl0U/uss8WM6vh5H5vMGIF
         oDV8wB42U8dWihLGwjEPUIlbTZExe1DTZhAxIXSTBDHQc4nOEDa9ErSIyjuZMIlZ3KDB
         pcnJjZjpARd4jeHnBoSEp5rScBE2g4rfCFCqb5JZEQv1slLQG/8g5tlliQ+x5pAwtluz
         DeDIgPO6oUOu9U4xKltbIm7pnuX05OjZwGJIJge6+XtMDowjN63YRVdIuNxNOcFyOphn
         qcNA==
X-Gm-Message-State: AC+VfDz9DFLU9En8ATeBwhyANKjsbKJsiZl9TSQZnElY2XDyO8DMpyY0
        c38G6anqz7zK6/k274zujeqE3RQYLnA1Sqo0/nqtxreqqKI8g+BGQZwD/HPjV2tdGHAvKHbohK+
        qVdMTIwP37v83G6OTfu0G3HVlVw==
X-Received: by 2002:adf:dd06:0:b0:306:368d:8a1c with SMTP id a6-20020adfdd06000000b00306368d8a1cmr21091448wrm.45.1684096781705;
        Sun, 14 May 2023 13:39:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nN09h+Mnu8pLXs6TXZixhNLbNU43uh6S3TNFEVms1rYMbEDlOVaa7UVK4S4Nr+3W/+Sl3pg==
X-Received: by 2002:adf:dd06:0:b0:306:368d:8a1c with SMTP id a6-20020adfdd06000000b00306368d8a1cmr21091439wrm.45.1684096781330;
        Sun, 14 May 2023 13:39:41 -0700 (PDT)
Received: from redhat.com ([2.52.146.3])
        by smtp.gmail.com with ESMTPSA id g14-20020adff3ce000000b00300aee6c9cesm30425379wrp.20.2023.05.14.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:39:40 -0700 (PDT)
Date:   Sun, 14 May 2023 16:39:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_setattr
Message-ID: <20230514163907-mutt-send-email-mst@kernel.org>
References: <000000000000a74de505f2349eb1@google.com>
 <000000000000a9377e05fbac4945@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9377e05fbac4945@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 12:24:32PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a3c06ae158dd6fa8336157c31d9234689d068d02
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:03 2021 +0000
> 
>     vdpa_sim_net: Add support for user supported devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e372c6280000
> start commit:   e922ba281a8d Add linux-next specific files for 20230512
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e372c6280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e372c6280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=17a4c2d44484b62f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cbb68193bdb95af4340a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172a21c6280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b67fc6280000
> 
> Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I don't see how this can be related, I don't think the test setup uses
vdpa sim at all.

-- 
MST

