Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB422D6C26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 01:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390526AbgLJXqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394463AbgLJXp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:45:59 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCDAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:45:19 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id n20so1707938ooq.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=CpA6gxKkHV08hJECSbbBwUFG46PBv1T6665ufiVVTc4=;
        b=QQSvBiZnpJvWQUgf6zIz4KYO0MkAeosE304pZ3yR/dpj/IpD4AnjKWGvt4Spf0zlWY
         e17ixx0vVAJ3c78ZVuBhL+qrGw/IXL5/B8vlcOIS14VqVUxj16mKN/sIBftFl7SdtVkK
         IeEO4Tmyzx/ZQVBqU7emz3Z+JnX6AHZ9kqdQdtroUSElUppcC4lxvzd4NZZld+IgGW7W
         i98abelo+JQ8C9EJqVA2Zb5ZAMb81KE1Od+vla1JAyNz/Ndhi5eqqPXPtfUwPfbMCrH9
         rjDTqo9H8+YRW6PFm4A+pF/1r6B8veTEofV22oFVc4efY59vTJQHTowlmxQJCVgs5dOU
         /W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=CpA6gxKkHV08hJECSbbBwUFG46PBv1T6665ufiVVTc4=;
        b=Hr/qisjL2WJh5U28KiTTM7mbq1dTsMzOWEOeVgl/PguqIngnYW6U4kEaP0m9YNtEAz
         s5i8dowQlMXDEUBH+yfz5vU4RfXIFksPy8/8u8rtqzgnuQmmhyfoQ6grnf9e20l2/aUZ
         BLfX3p/h/Z5clSUy5VMJLEqK3KVGD3zzAsG2Xij7XW6mDa1pKNDypAbcCfNRHixc3Tdl
         hOjOBZIbHyaHHGOb53nGaeu4yBAvTdnzgj6uGd9aLBjmHH9ZPAe9HlElkpJm/AMx0sdZ
         NHY2/2gzc96sym17uIoAALzeg/+bEvyBEbf2AH/PDbmpP8oScaagZWXXpJucJjh8h9Xc
         NK0A==
X-Gm-Message-State: AOAM533GgKVSfYqiQEVEsvnep9uMXuU4vcyBgWZRG7joceKcpUEX8OI3
        Vo+2SON5O3pTxiyteKFWdazLgw==
X-Google-Smtp-Source: ABdhPJwlPRRqLENGqR3DgtLwPuZKphMCcYTYi1x8TOvPghQemLsu2xmQNOpOKhtRMjNtVLUNKPVDGQ==
X-Received: by 2002:a05:6820:41:: with SMTP id v1mr7903689oob.41.1607643918252;
        Thu, 10 Dec 2020 15:45:18 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h20sm1431541otj.57.2020.12.10.15.45.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Dec 2020 15:45:17 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:44:57 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: linux-next fsnotify mod breaks tail -f
Message-ID: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan, Amir,

There's something wrong with linux-next commit ca7fbf0d29ab
("fsnotify: fix events reported to watching parent and child").

If I revert that commit, no problem;
but here's a one-line script "tailed":

for i in 1 2 3 4 5; do date; sleep 1; done &

Then if I run that (same result doing ./tailed after chmod a+x):

sh tailed >log; tail -f log

the "tail -f log" behaves in one of three ways:

1) On a console, before graphical screen, no problem,
   it shows the five lines coming from "date" as you would expect.
2) From xterm or another tty, shows just the first line from date,
   but after I wait and Ctrl-C out, "cat log" shows all five lines.
3) From xterm or another tty, doesn't even show that first line.

The before/after graphical screen thing seems particularly weird:
I expect you'll end up with a simpler explanation for what's
causing that difference.

tailed and log are on ext4, if that's relevant;
ah, I just tried on tmpfs, and saw no problem there.

CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y

Hugh
