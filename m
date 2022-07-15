Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69724576363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGOOHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGOOHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:07:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538A7DD8
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jul 2022 07:07:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so6426964edb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jul 2022 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tG8UwfM9XgsU2gpK8iZAI5QuO4Taq8sY6XWqWuLovpU=;
        b=M3X5Tr7FPZHC+7bkRn7RRykQVi/wfaS3ybPSNR/xzd4iJZkrgXYUWFxjI5HWMhxv0M
         9BOv9pkEYqlbio5/KLX6bt/3ju9AEDpu2LsiZi3WrH5mHJVk/gCyouJ67m2pt6ZPEPt6
         VxGKJlEFF6Hsk/vkwoPwefkk0ZgwGzZzL7tME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG8UwfM9XgsU2gpK8iZAI5QuO4Taq8sY6XWqWuLovpU=;
        b=z3UH+FkmYOIf4VRFNQHbbrzyHBuibDTOd1l/A9Og1C5SM+QYUftvl1RO6xqhdJIQf4
         2Zc4KCEDjGPS1KKIHfghNAg3WsIMLaIS4VxOTyPCe2dCMFYSnPw0RjxKXgA29ETQ4DXd
         ndd2aheDVV4kwFcKjcmefzIE9BhLgb+BWKzXCGRlrZCwrVHIgtuN5Baoqbm8Hnb5PR2d
         yn6+MliJGjYWjdrZcS5eaoneEKwNRJcMMntfrHKfSsfg90zWZJW5YZ6KM240L6pZ0HBF
         g5LHsntWMw9LB7s4XjV82B6JWAWn58vHtaTHfdCe7qHVzGrbqKmSnhFKDkXpuBMiDK/H
         iI+w==
X-Gm-Message-State: AJIora/R22ttsl9xCdPgZtyrHEVj8sXFdwjKicOkefIloLgQElX4yaii
        Ab/AKLakmoYgh1dh7omXBD/0h6U6th7FF22iYfVAhw==
X-Google-Smtp-Source: AGRyM1uq6Rh6Te7IY61z9eJaeA+04DZZ9mK0UQyF/K217FYesaE7A0mHMwzT6A9TAcC215uqb5P++5cm8U64EFQ5NIs=
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id
 y13-20020a056402270d00b0043ad1e8460bmr18857128edd.40.1657894022967; Fri, 15
 Jul 2022 07:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220715075343.2730026-1-williamsukatube@163.com>
In-Reply-To: <20220715075343.2730026-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 Jul 2022 16:06:52 +0200
Message-ID: <CAJfpegs4jRd=FrgDaLxcnbCKWCU=PrsdEzat58j0xB2XdTatZg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix a potential memory leak for kstrdup()
To:     williamsukatube@163.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Jul 2022 at 09:54, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> kfree() is missing on an error path to free the memory allocated by
> kstrdup():
>
>   sb->s_subtype = kstrdup(parent_sb->s_subtype, GFP_KERNEL);
>
> So it is better to free it via kfree(sb->s_subtype).

Not needed.  s_subtype will be freed in __put_super().

Thanks,
Miklos
