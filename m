Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B4790AF0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjICFZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjICFZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 01:25:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46368CD7
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Sep 2023 22:25:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a7e68f4214so375388b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Sep 2023 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693718732; x=1694323532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+Eh2A53idbaKGC4D48PHUvqh0huBtkkZ1MnEHrGGnU=;
        b=k53OCDljq8CEDYEIqPT+yjaAypALkomF873o/7Oh7ZG1Lq0DI4C4Za0AFbp/WRJtpJ
         26GzAhVCthjzamlHtmR7idga8OPCnNZ6lOVrxpdlWNsq4MribsUXswf3Xpa5iKnxc9bv
         VGx1ZBqcI7ZHsITWTuDWEEeAHjHOf3XhJmVkyZrFoupcnwk0mD0thA/K5+UdsLP8bFzU
         RbYhj2a25NvI/GdmRr9hxxVrmZ/YHJN8QoKugg5PkttUN6bsotPJkGhVBzDNSctY2K1H
         2Mic0gS8GccvXsRUgUvoJmMq1o6yZZA1ltAt4ujnCErWue+k1pMvM6Nsde41ag8E/2rz
         0NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693718732; x=1694323532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+Eh2A53idbaKGC4D48PHUvqh0huBtkkZ1MnEHrGGnU=;
        b=Xyvr8cgG+mibo8vwbkg2M4lI13rwzzJShkAaNzrFRTUcDlIbiKoir76FOzcriMfaRb
         4D967ZZ9S3O9T+q0FyKeoNhEbiu6SxgwcY/ddeG7Iw1s/ZPpxmCjJZYQJXq5RJ4Xs/9N
         VSMiP9JcpalDCpIQ/2Z4SS/ZB0fT3AwF7QAaDv90NAETvyBFwjCA3xrfjPcjhNlGEVNF
         mpVkoAZ9v3Wt+i+V2Qy3RHfxPHCzE/P1CEZc/u1AHR3EMboxE1Ai7veanTUhLQIa2Ucp
         Ib8S+RlTALTvn1h6Pt4E7Lkj69x/g69nErsLeU6rwn9UZHqmT9waqTo8gTYaEM8vsUmf
         mvkw==
X-Gm-Message-State: AOJu0YwE+GqfoQr0uUSsZY1/8MxDFroaGQX6GXNOU7ZpQjvOwviK6UWZ
        FgXGpp3senNRmqBzz/LsWTUVg70nM5eUuUY+fgc=
X-Google-Smtp-Source: AGHT+IGNq/nmzcBfE8tNNcctP8MOqZWNtdKzxAcW4XkHpsLIVYvoFFHRLzprcuZfIYR0M4JgREsJXw==
X-Received: by 2002:a05:6808:138d:b0:3a7:82e8:8fd1 with SMTP id c13-20020a056808138d00b003a782e88fd1mr8799733oiw.20.1693718732506;
        Sat, 02 Sep 2023 22:25:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bbd1562e75sm5391337plg.55.2023.09.02.22.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 22:25:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qcfc0-00A8ep-2J;
        Sun, 03 Sep 2023 15:25:28 +1000
Date:   Sun, 3 Sep 2023 15:25:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <ZPQYyMBFmqrfqafL@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e6432a06046c96a5@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Been happening for months, apparently, yet for some reason it now
thinks a locking hang in __fdget_pos() is an XFS issue?

#syz set subsystems: fs

-- 
Dave Chinner
david@fromorbit.com
