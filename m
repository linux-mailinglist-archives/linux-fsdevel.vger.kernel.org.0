Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8799B679EDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjAXQiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAXQh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:37:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE54C6EE
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:37:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso2593350pjj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+Dlh2CSJr34p4VoH6TTQCOTVAnxybB784uCTFKkuqk=;
        b=qTI3UY08Kv09+ILMWkvgwtj1Qxjp1ej9Y76FSsTQddtsfB0O/4GDegV3vzL08Akd3H
         GnckwoK+lFqqw3gVKwcbH2kUrrE2fjyICflU4VQtvqI+DBitdCXedA8jLLvcRTPnro1o
         94IIi2fFPYEvKToOtV5PE1na7F4+U4ekVTNDTURlxqL6ZYxvFiyoagKOEixLuf9GdinM
         4xAaymYbwBxzgrIfvCkw9omHJUqzKaKAdfxvGltNftKsYVxy4T7OG5NBJaxlSIhDu0lk
         33l/uLsUc+LGfsjgCS7KtVG9PT5nMyF5s3KSXafGBH/4dkLWvwfJFxR9tQ6QsAISLqj2
         gx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Dlh2CSJr34p4VoH6TTQCOTVAnxybB784uCTFKkuqk=;
        b=sM1Vi1XMAj19sXMjQXqtC9eWKVmIxkDzIqb5mXZuhzBlyCsZI6HV8KzWm0aNUglgOT
         RR712XCd019lIFsepsYGjNRX88QjeI+XFv75wjamif7ej2kzwPfXfWSIjmtX3NjZb0dw
         J1H9PG+/bfObAKuiGmUNwZazfD/1VjkbpYkp+q3EZsLj36ceXDz1XrSQ4E/HYvgcuw0S
         BjBbKhje/ZnRR+4l5xQkho5Z9deWEQSZ4h0HFtlQV9VmWCo2mVgO16uNywFQpcx5TjrE
         1aVU7UD886Ox5XzpA/SYG9S65b4EfMa+lV+Yj0TWYt1ZMKa60ZLulXnwk+kWdYywiAss
         B0aQ==
X-Gm-Message-State: AFqh2koPaNe/GJKksL7XVJPhmpy++zbKL2Dmcc8F7uxUPzSf3Z2kE6gO
        F4ovPcYf7pwZWjSsToXksk9RAg==
X-Google-Smtp-Source: AMrXdXsqYWe6Fbks3vKe5IOKsnA6+Uz3yTmvwwGyPeU8dsm2UBBStmXnQw3r7XqlpBOZoCBSBYcRhg==
X-Received: by 2002:a17:902:b183:b0:18b:cea3:645 with SMTP id s3-20020a170902b18300b0018bcea30645mr7084359plr.0.1674578242993;
        Tue, 24 Jan 2023 08:37:22 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b00581013fcbe1sm1791902pfl.159.2023.01.24.08.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:37:22 -0800 (PST)
Message-ID: <579d6d81-4f24-16e4-ee56-11089eae0164@kernel.dk>
Date:   Tue, 24 Jan 2023 09:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in fuse_dev_poll
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+d3b704fabd7f02206294@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org
References: <000000000000bac7df05f260d220@google.com>
 <CAJfpegteWVfJ8CLATjhk7==iLmqyZT_ao8Hs2JaNKdbgceXZYw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJfpegteWVfJ8CLATjhk7==iLmqyZT_ao8Hs2JaNKdbgceXZYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 9:29 AM, Miklos Szeredi wrote:
> Hi Jens,
> 
> Forwarding, since it looks like io_uring is the culprit: vfs_poll() is
> called by io_poll_check_events() on an already released file.

We had a bad patch around that time, pretty sure that's what's
triggering this one too as it's not a recent kernel.

#syz invalid

-- 
Jens Axboe


