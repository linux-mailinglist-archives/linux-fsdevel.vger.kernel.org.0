Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFA46F9BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 05:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLJEHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 23:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhLJEHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:07:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F46C061746;
        Thu,  9 Dec 2021 20:03:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d9so12938771wrw.4;
        Thu, 09 Dec 2021 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CX8RPFqWxmhuiVbKNQ4FRnbHGl327frRd5MQyfbYU5o=;
        b=gF15qU7H86VsfHkH5dvEwXaU6pwrAQRoAM9ACkVgTztIk+3Oe5hgQezjI9qPSCBoq5
         mv0Mto9epFcD2qmvVeN6sf7Ll0r7BPct95e1WYHjQZJO7bsym6lV1hDMEKHMNa3OUK8y
         SybSqJpT59V707aaxpOdyF9bGosVVdyNokx6JmorOkiS1pkpzk1BaRjKD7d6E7j5+RIO
         Tk9x69xmOlFi0VKbmewJ4t/2Map/AzA72kGXvuVRVh2EulwhYO7+MFV7Og/HhBa8u7Mm
         1pC8vgPDeO3NBbl/ri1/0Lf5LR8frp4nf3fluKl27ALp3SPrgP8Y8uCmjr6rLmbv6HpK
         AWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=CX8RPFqWxmhuiVbKNQ4FRnbHGl327frRd5MQyfbYU5o=;
        b=QQBFOLHFHwQKFMZHQlV1JWsxXm9wlUCVHjrajQaMrsEDRJdTKlP2XQN4sJhUNkGHaZ
         MUkS9UgMCHEw8Ns5tB0YuDnlLoe6pEywGJewphQJHJoWkUJEJVgyvdO1ZU8cWfLreNbZ
         jlnuvvcvIOX2OyOGyCTDRf52xa/LQ80Aeqmm7d6vf1YeZm13EcKCa5ZQKuIs4X4G6asN
         KbPSV5ltzmli7HKcIXvqA8VnTW8P7eHagVxkW1PVPg8pl5zxeBJ5OAceFM9Jottgj3gj
         SBaK/ngxVKRzaQStP3iPSBbKF7Mnr/fA2i3DHOBjO7/UDrb9jSG9+oaVHwT6KyabxdR0
         RPvg==
X-Gm-Message-State: AOAM532lePwXegwWPAiYm3NRydypeuCyseEDLcFh+JIROHAbZrqd2z50
        NQA5KI9yRPr6chnfZS9gw4DAyqbZMd0=
X-Google-Smtp-Source: ABdhPJzNWBRz8n5l9oVvAMN8CaCdXKNp96mYCPWqVksi4l0aMDnqVZBSY6WLQj1QAyepGPFSj8X/tw==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr10649331wrj.575.1639109011215;
        Thu, 09 Dec 2021 20:03:31 -0800 (PST)
Received: from [10.184.0.6] ([85.203.46.180])
        by smtp.gmail.com with ESMTPSA id f3sm1302374wrm.96.2021.12.09.20.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 20:03:30 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: possible ABBA deadlocks in do_thaw_all_callback() and
 freeze_bdev()
To:     viro@zeniv.linux.org.uk, andrea@suse.de, axboe@kernel.dk,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Message-ID: <bcc39dfd-3734-bb82-b327-8445aedef605@gmail.com>
Date:   Fri, 10 Dec 2021 12:03:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

My static analysis tool reports several possible ABBA deadlocks in Linux 
5.10:

do_thaw_all_callback()
   down_write(&sb->s_umount); --> Line 1028 (Lock A)
   emergency_thaw_bdev()
     thaw_bdev()
       mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 602 (Lock B)

freeze_bdev()
   mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 556 (Lock B)
   freeze_super()
     down_write(&sb->s_umount); --> Line 1716 (Lock A)
     down_write(&sb->s_umount); --> Line 1738 (Lock A)
   deactivate_super()
     down_write(&s->s_umount); --> Line 365 (Lock A)

When do_thaw_all_callback() and freeze_bdev() are concurrently executed, 
the deadlocks can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if them are real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai

