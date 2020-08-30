Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714F256AEE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgH3AeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 20:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgH3AeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:34:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A4C061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 17:34:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o13so2313678pgf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wRsdXQOoZs4yYt+Nf5Gy2Ldf3swM1iC++OefVgYyX0s=;
        b=v39DJi1E/yraMAnVunh60K3sIDnBghmBrGk8y6BbCaeJer1nZdesStPc7IKrUDiMix
         jOrokI7kcjuCKdDtgEE8A7AvLmw41vgtFIrZKBKluFy5EW7RspscQT488RbRqnBCRTVN
         2eiNPQPUfffhonzWylRKNdFxE59QCYAu5u52Rs8ThvDRJmbEtkOhC33MrHWf64QMKuNf
         aLeeZYFzo9mzzFe1Kf1Hc2q7Dsy6EW+1eRc7mdH21fWk20yaa22q2tvqw5I1C2cN7Orc
         dTgXqxnggcZ2hgrovkX7cPw+Hz3Gm0PlbaK/AfG8SGV+OfCM5u2Do1GG7gIjwHzwyXEL
         DpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRsdXQOoZs4yYt+Nf5Gy2Ldf3swM1iC++OefVgYyX0s=;
        b=EIp4J3oZHWi489ZifAGOHRM4DqJYtgFll7O6j+EBJi3sKfyboIERBj6tZz2Ul1aWgY
         V6hqelhi4HGLFkopRklV1pAOqXTtLtCa2ObENi3O/nLJk26jpAxdAOvnh+tWs0yr/x12
         NAKJ4+t2wtynOfR9o7bqQN6SnHArkEhkqhWUUFlTA5ETGD1B/83+6QFZhQvE1V73mRbz
         adO66TpUr482rHXFogMvEOGIe571+m/GsNR7LvBCxw+du9LjldwtoL7rYt7FdgVOOahd
         dB12+1G6MahG4BKHnx+F+V3Q9CnWSLxyvgU5KSb1McJFz57HlusK0DGEhLp+iEvWrM4a
         oZyg==
X-Gm-Message-State: AOAM530wE1M8dkhq02QkXuTqFpVcj5DoslnDhby4oAMibY2Efg1p9Q4s
        SIdhOKzvtjiZ6lgZqR94FToFJw==
X-Google-Smtp-Source: ABdhPJy5HsE91zNZgLLhC/SB0NnDxFkJRhtbqIjkRErPweW605gkmrMve/CveVLIfKZ2hdp3MwZu4A==
X-Received: by 2002:a63:62c7:: with SMTP id w190mr3917110pgb.25.1598747654101;
        Sat, 29 Aug 2020 17:34:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d8sm3460750pgt.19.2020.08.29.17.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 17:34:13 -0700 (PDT)
Subject: Re: possible deadlock in __lock_task_sighand
To:     syzbot <syzbot+6e8f5b555cce8fac0423@syzkaller.appspotmail.com>,
        christian@brauner.io, ebiederm@xmission.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000001bdf9705ae0d151b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d104d06a-393e-0d47-ef6d-2f1010c9c2b3@kernel.dk>
Date:   Sat, 29 Aug 2020 18:34:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000001bdf9705ae0d151b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is already fixed, and it went upstream yesterday.

#syz fix: io_uring: don't recurse on tsk->sighand->siglock with signalfd

-- 
Jens Axboe

