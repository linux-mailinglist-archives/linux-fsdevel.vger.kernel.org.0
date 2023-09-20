Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A307A7593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjITIPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjITIPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:15:31 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A2C2;
        Wed, 20 Sep 2023 01:15:21 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a52db1e4bbso2435638241.3;
        Wed, 20 Sep 2023 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695197720; x=1695802520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJxfyTLNGZAN0qgRxWWT6/oteEKQT8o70eVgdNPEM/Q=;
        b=W3K/TtSTcbvKR+NvbcejazPc9kT8dK63WflJYDO+b4vA7ff2tb+wPc+mlanVsMtx4y
         cWd1rdr79v4ZqozAM4ryKxJYvJgznzK/C5XmD7OgTtly/vesk4Mq8MjeXpQUG2K69fAQ
         Fqa4V60XBOQ2/R7W6qsNtCx1mRG4q000I0Z7GcD9Q8iqFZ0bOnPUEy38j83TKNTbQwtQ
         nPBQOUO/O9NNS67uGIJggCeVYdt5DKhm66Cv262kUYKHwQ5hBJ8mHmS4nl5c78Yoox9Q
         IB777So51vxiXB/ivTL9uNPUeTidvII4VDgfxAwhU83/PHJXQRvnm+GrvVINZ5fagUge
         CWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197720; x=1695802520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJxfyTLNGZAN0qgRxWWT6/oteEKQT8o70eVgdNPEM/Q=;
        b=Th1D2vSgD9oMxV/EouNswTFhJYokt6R33n67SeHvebrLUJ450JDYBaLEW+PJwSDiUI
         TX9oxZ3NE4N4HSRhEX4Cn5YSBkPpQqeo0QrEu0Ia7ZTdx9eT7NBVCYxSHnuPa0XbRHm0
         yn5XfyESCDjpZJyU3Kdni4cpaYjrpBxEu8tw2l7rxIFk/O4FiPJTOyeCH7q+RdLPn4nL
         0Z3X/7uRqVkOhuCg72y5LCeT238F3ORAY1a+9ngfyJxeXeRfNhEWg6Nij100poP2Qa04
         hgRhUHY8GcokYOPDk7QR2TRmdPi/LN8Fn1Ei96rF51CFdrXtR7ELDkhJBAoI/W0dAgd4
         NIuw==
X-Gm-Message-State: AOJu0YxneeLsAJ34dLcEDelSU9sYavkuzWBd6YuVi6Yaype74LR4N7ih
        8kp2bkBCNnmawDTLWTAbigoAwKk22+qLT4w3WbE=
X-Google-Smtp-Source: AGHT+IEsfO4EAx787RgGydCMUNs6b7OZCMZLpCKdedAcjUM4XsQ/CD9NHXWZexv599YssdpWeGgAwMzr8a3yyUbhRVE=
X-Received: by 2002:a1f:6643:0:b0:48d:38fe:3133 with SMTP id
 a64-20020a1f6643000000b0048d38fe3133mr1913731vkc.16.1695197720435; Wed, 20
 Sep 2023 01:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-15-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-15-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 17:15:04 +0900
Message-ID: <CAKFNMo=uGWNL5pe7JK7-GBKR1L6tsxmtRH5+p4mPrri=CeJXUw@mail.gmail.com>
Subject: Re: [PATCH 14/26] nilfs2: Remove nilfs_page_get_nth_block
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:47=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> All users have now been converted to get_nth_block().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/page.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
> index 344d71942d36..d249ea1cefff 100644
> --- a/fs/nilfs2/page.h
> +++ b/fs/nilfs2/page.h
> @@ -52,10 +52,4 @@ unsigned long nilfs_find_uncommitted_extent(struct ino=
de *inode,
>  #define NILFS_PAGE_BUG(page, m, a...) \
>         do { nilfs_page_bug(page); BUG(); } while (0)
>
> -static inline struct buffer_head *
> -nilfs_page_get_nth_block(struct page *page, unsigned int count)
> -{
> -       return get_nth_bh(page_buffers(page), count);
> -}
> -
>  #endif /* _NILFS_PAGE_H */
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
