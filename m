Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46BF1AF5B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDRWwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDRWwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:52:03 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8C021974
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587250322;
        bh=OdSB0/i/HhAIXdUjqTjOVTINhs9KyubHqUL6Q6phR/M=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IlWFVE65HA/doXz9OTex+yPiWKzw64sosilDB6m6uwM3lPS0Es39jrp7p+Y2a6oSA
         WQ3T5cAogJ+VClx3xj2zcNh1a7N5wLvnvJcLohRXmI2E5BuZv7wbE1gfl3F4cGG8Rq
         BJNq0giQuem/yPb646nAY9P0jKbkLEbgrsmj9qjM=
Received: by mail-ot1-f45.google.com with SMTP id z25so1284608otq.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:52:02 -0700 (PDT)
X-Gm-Message-State: AGi0PuZIXEqYyWU8XdODSi2mqaPa1Ntn7TrpIiheGy3lFfTtXoGbkvxf
        gJGNWevxmq0Lcd1bMyfPi8sinHSOujapZe1Qn/0=
X-Google-Smtp-Source: APiQypLSO3t0lD4kyYNCLyelg8ObN69ZvPe2772YuIn3OfrY6dG/Go9XkEXPNkkogmqCrmeH0MH3Zv0Wi2+7nO3IRc8=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr4351448ote.120.1587250322115;
 Sat, 18 Apr 2020 15:52:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5744:0:0:0:0:0 with HTTP; Sat, 18 Apr 2020 15:52:01
 -0700 (PDT)
In-Reply-To: <380a03f3-b7da-8b54-6350-c0a81bf7a58f@sandeen.net>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net> <381e5327-618b-13ab-ebe5-175f99abf7db@sandeen.net>
 <CAKYAXd8f_4nodeTf8OHQvXCwzDSfGciw9FSd42dygeYK7A+5qw@mail.gmail.com>
 <9d3c760c-9b1d-b8e7-a24b-2d6f11975cf7@sandeen.net> <380a03f3-b7da-8b54-6350-c0a81bf7a58f@sandeen.net>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 19 Apr 2020 07:52:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-9Bah6p9GhMmTxnUDZoQ9aPbL65HYPemnZk6zQBf0w9Q@mail.gmail.com>
Message-ID: <CAKYAXd-9Bah6p9GhMmTxnUDZoQ9aPbL65HYPemnZk6zQBf0w9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] exfat: truncate atimes to 2s granularity
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-04-19 1:40 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
> On 4/18/20 11:04 AM, Eric Sandeen wrote:
>> since access_time has no corresponding 10msIncrement field, my
>> understanding was that it could only have a 2s granularity.
>
> Maybe your concern is whether the other _time fields should also be
> truncated to 2s even though they have the _ms field?  I don't think so; the
> s_time_gran already limits in-core timestamp resolution to 10ms, which will
> be properly translated when the inode is written to disk.
>
> atime has a different granularity though, so s_time_gran doens't help and
> we
> must manually change it to 2s whenever we call something like
> current_time(), which
> only enforces the 10ms granularity.
>
> So for cases like this:
>
>  	generic_fillattr(inode, stat);
> +	exfat_truncate_atime(&stat->atime);
>
> or this:
>
>  	inode->i_mtime = inode->i_atime = inode->i_ctime =
>  		EXFAT_I(inode)->i_crtime = current_time(inode);
> +	exfat_truncate_atime(&inode->i_atime);
>
> I think it's clearly the right thing to do; anything finer than 2s will be
> thrown
> away when the vfs inode atime is translated to the disk format, so we should
> never
> hold finer granularity in the in-memory vfs inode.
>
> However, in exfat_get_entry_time() maybe all we need to do is set
> ts->tv_nsec to 0;
> that might be clearer.
Right.
Thanks!
>
> -Eric
>
