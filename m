Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16827790B3C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 10:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjICIeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjICIeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:34:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB853189;
        Sun,  3 Sep 2023 01:34:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf1f632b8so75709766b.1;
        Sun, 03 Sep 2023 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693730041; x=1694334841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRudmkh8iHtCDXikKDGZnGkARDgSd/PV3cdSFjM4RgY=;
        b=IPaxhmJx6JDAqesHN8IWaxBT+gqfr+/s9B9eexQNynGJN1jRAWoUNFEDwl/bQtFpFm
         xpszhwjo/9EoT+uzZ3s3hVsVhkA64+w1pRNauFZZb+eiGkCN84kpCk6VyHAfK5w8WxIG
         NZKzmzJyYgOfS9Uhnf8zBJHzq3lxcBFSzYm/IoKUgRH56aXF5vbtIEjQMskEnVZcGUML
         gi8Lbb9gaz+rH7NGHBhr48pc/6Ry356bHmR+VOD761LoK0llmiq24UwMVyRw3alnyLt7
         WiCqWsbjrzqYIVG740JJB+I7p0H+LI8N2iHnVBLDKUSBEB8ZMPzay+HOpLemQkiHqp5d
         f+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693730041; x=1694334841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRudmkh8iHtCDXikKDGZnGkARDgSd/PV3cdSFjM4RgY=;
        b=llmyBYbKibTh+tFvvY0AhPPVkiMeOYrKogXxf6l72MRnR4zJMx0IVBuVta/A72+g0o
         UFKrDkWouAj5HuiH2DCdZdle05vvBB2F4Evcwx7JVWmxPOy6ueIXjZfeyQABUAFRlIJp
         uwrZMUe/01Hcvurhj+TASQ/N5kbVwYxH0bNcuDucjSrC35A00KeMITjo3hB5xcEpWlnu
         yBnubXjd6J/9nKJkbPUjy1C+mhgf5CxEQEcsCAg/RzHqXhReuTvZZJIrvkzUbNANPT87
         z7xWN28WXPHCTlJ0ilCrEfOqLf5BsoiEEQAXiL8N4hV3C8C9ymXX3pgO0z1uB7J8yFlZ
         EE/A==
X-Gm-Message-State: AOJu0YzxBEbVKN3xPz8mlPc5VDmr5pPL4nJ6u3sIaTh0a+ch+V3Fy9qb
        e5aSp4ySLrW02Nusp7oIwB8=
X-Google-Smtp-Source: AGHT+IFtmzLedMqLCZW5vLdu7ViMHcVf42AWHB002lZzxWPjY7i8+/989qug0MXV+5wiJ8JBGayUjw==
X-Received: by 2002:a17:906:3147:b0:9a5:b876:b1e3 with SMTP id e7-20020a170906314700b009a5b876b1e3mr5300019eje.20.1693730041163;
        Sun, 03 Sep 2023 01:34:01 -0700 (PDT)
Received: from f (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709064ec200b0099bc8db97bcsm4509918ejv.131.2023.09.03.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 01:34:00 -0700 (PDT)
Date:   Sun, 3 Sep 2023 10:33:57 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230903083357.75mq5l43gakuc2z7@f>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPQYyMBFmqrfqafL@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
> On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> 
> Been happening for months, apparently, yet for some reason it now
> thinks a locking hang in __fdget_pos() is an XFS issue?
> 
> #syz set subsystems: fs
> 

The report does not have info necessary to figure this out -- no
backtrace for whichever thread which holds f_pos_lock. I clicked on a
bunch of other reports and it is the same story.

Can the kernel be configured to dump backtraces from *all* threads?

If there is no feature like that I can hack it up.
