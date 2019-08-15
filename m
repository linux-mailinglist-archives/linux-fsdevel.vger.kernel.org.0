Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128D78F060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfHOQVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:21:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37514 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfHOQVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:21:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id t14so2742091lji.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
        b=GiMGu61r0de7kE+jxFqk2ISTMZec3MCIu0HBqAiSXGeSP8AeU/RC1ZhX/syTNiFag1
         vef2zaQMkRgI5yQRnEcUQA2HqnQz4O2DAMgPqxYorQxLdg6N07Qt35SI/EEKkX7h+ocx
         AGxQCZHY70aVP3rFrb29kL6nHWXMwFLTwSK+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
        b=BKdLqJ/PkUgWB+8Nw6+SEQpXkoLGSZ5spg6giKkE/uBiVa0wNDVoIuaZ2k05JOO2RN
         SzJoRIjxflAsBfXtAQKBwNkLkL0FrC38+aL/V2pD921qL4IwEJ4P0WJf+0N61BUxAtPG
         X6grqgbVlhWYoXv/hu6KABeMAXLMJ9IaNC/gU0NP3d8r78wlxYySOVVND3TPvSivaEE2
         4OnEGV7Z98bMFHarweNbTlfHzbN4vNMpMlO1Q/B+uPOQNQiY+HaAJlvtunVMDQhREfeU
         uIbm42eZS2eskZzRevqeZNxaLAHlO5aTehNXSdvT027g7ezzvrO4tMEipieUW5dQFno5
         ebbQ==
X-Gm-Message-State: APjAAAUfaOxFbc/vtE0YW8Ukv61yJGLBM8/cG3YxVnjJhkUebigVAyYB
        8wdRHEhkGlqbs1thC/bMzbB3vJkmbeM=
X-Google-Smtp-Source: APXvYqz2fCPtsXs6kpR5WBLddsk6RRceSOI2/pf009PGYHmGDM5ZwAvlyDas9ykKmcGobgqGHNyYTw==
X-Received: by 2002:a2e:805a:: with SMTP id p26mr1628577ljg.235.1565886065030;
        Thu, 15 Aug 2019 09:21:05 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g12sm519856lfc.96.2019.08.15.09.21.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:21:04 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id l14so2747838lje.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 09:21:04 -0700 (PDT)
X-Received: by 2002:a2e:7018:: with SMTP id l24mr3046966ljc.165.1565885615360;
 Thu, 15 Aug 2019 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com> <20190815044155.88483-8-gaoxiang25@huawei.com>
In-Reply-To: <20190815044155.88483-8-gaoxiang25@huawei.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 09:13:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Subject: Re: [PATCH v8 07/24] erofs: add directory operations
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 9:42 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> +
> +static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
> +       [EROFS_FT_UNKNOWN]      = DT_UNKNOWN,
> +       [EROFS_FT_REG_FILE]     = DT_REG,
> +       [EROFS_FT_DIR]          = DT_DIR,
> +       [EROFS_FT_CHRDEV]       = DT_CHR,
> +       [EROFS_FT_BLKDEV]       = DT_BLK,
> +       [EROFS_FT_FIFO]         = DT_FIFO,
> +       [EROFS_FT_SOCK]         = DT_SOCK,
> +       [EROFS_FT_SYMLINK]      = DT_LNK,
> +};

Hmm.

The EROFS_FT_XYZ values seem to match the normal FT_XYZ values, and
we've lately tried to just have filesystems use the standard ones
instead of having a (pointless) duplicate conversion between the two.

And then you can use the common "fs_ftype_to_dtype()" to convert from
FT_XYZ to DT_XYZ.

Maybe I'm missing something, and the EROFS_FT_x list actually differs
from the normal FT_x list some way, but it would be good to not
introduce another case of this in normal filesystems, just as we've
been getting rid of them.

See for example commit e10892189428 ("ext2: use common file type conversion").

               Linus
