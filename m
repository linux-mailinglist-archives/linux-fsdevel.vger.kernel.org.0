Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250CF240AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgHJP7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHJP7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:59:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B52C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 08:59:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f10so5131459plj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MiKCqoXdUf/2WubtKvSf2rupw05n9LRpZ3rO8JCm+vc=;
        b=Af84A0BggrByw4vHDx1dAdV87MrXS0sOrpytPzbUyfA9s1aILwtNUcYsmyZUROIV71
         lJZf3nMP6tnNGLy3SCjtxZ7W1RfVaUYeh5gMQAgp9YNIT3WwoIgym4NliD2Cy7bUO4c4
         1M6FnSLgCdZJyddM79h45zkdQdI7FI9k4B3ksDHwFnMu1CseFl1XeDs005JiyPhB1Foe
         pW1Wc2A/u6mBHltbbS25UmKC9+1uhMq9I5AM6Is2tC7ya428Fw4P84zyu8UFXKmMTIdC
         x10AUTUg1cZPf8KB30OjlgjD0wUch+hApVJR1KTvufmqn0iirsDAY7HAEFLwRv171AKp
         N2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MiKCqoXdUf/2WubtKvSf2rupw05n9LRpZ3rO8JCm+vc=;
        b=SUW4f4HlsmfVVLNRc42EEefTrMdi9lELPPpEbLrx6r4sLWEpbxYx9lPqCvI0W4Jiak
         5ct/PV/k8QjvcnPGWH1nyDMFiQnIg9vGkQvQ36+L2f6WXrWTtrWQuOeGXEW71Ejx4Lip
         YixoZwrX3YrWgM8QCRDLztoATp+M34gpfD+zH/0MxP9Z7KGCRjMTp1WKlGmIhhDCeL/R
         T9U6JavGe1CtY7fn9D80JB7mMWSFZ0c004+dgz6fa7z9RwFlei6sSBWn1RtOlkUadii7
         6OAezCbNczKIdnnutW1NoaWzgBi9St5eswVrkbs2K62qcjJTVfkvgeXalZ0VWeKimyUj
         mA4g==
X-Gm-Message-State: AOAM5304bohdUBK+M8D8b50i8qr+STJuwfSpuU6579qb6gCOcJbgvHKc
        1chax0uP98C00lSEXy62dX9qaucqiXU=
X-Google-Smtp-Source: ABdhPJwrTgvyRGM682n5Xv3THn244Q2QL2ztJSEx/PjieoN6YI4PI10UkhvjCSh5OzaAPD+hptZgKA==
X-Received: by 2002:a17:902:6ac4:: with SMTP id i4mr18393118plt.146.1597075186146;
        Mon, 10 Aug 2020 08:59:46 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t13sm18720517pgm.32.2020.08.10.08.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 08:59:45 -0700 (PDT)
Subject: Re: possible deadlock in io_queue_linked_timeout
To:     syzbot <syzbot+d4586d3028284ff8a0be@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000d07f9605ac87ba9e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdc51bf8-0a66-0a48-aaa5-6c0afc81daa8@kernel.dk>
Date:   Mon, 10 Aug 2020 09:59:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000d07f9605ac87ba9e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/20 9:37 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    06a81c1c Merge tag 'arm64-fixes' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13fbac1c900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf68a13f867fd1b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4586d3028284ff8a0be
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362024e900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672fd34900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d4586d3028284ff8a0be@syzkaller.appspotmail.com

Looks like a dupe of: syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com

-- 
Jens Axboe

