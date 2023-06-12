Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9772D34C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjFLV3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjFLV3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9198
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686605332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjqAmeFI8U8irr4gRZ+wZ0R5OBkpx1S1PK7ovSI7e9c=;
        b=d33493zn6YkKSBOCH/xd5aaPCPjIMvEOOK3/UKoL51arBYj4kfNhDDYPN+L6Xj+uSU/95T
        vqH1Vz0BHXlQXn7FneVdgCWmx0E6rBDFUmZxLqYnkFJcLEi/4YGzmw3Sx0XbIZWj9nzP3+
        p5vuGwcMdcoiPpquOXuWqyXOvHwB4Ok=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-MJ0hiNw4PMCBoxdx8aou1g-1; Mon, 12 Jun 2023 17:28:50 -0400
X-MC-Unique: MJ0hiNw4PMCBoxdx8aou1g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b3d800f62aso7578755ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686605329; x=1689197329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjqAmeFI8U8irr4gRZ+wZ0R5OBkpx1S1PK7ovSI7e9c=;
        b=jmuI2zjF/cvaRUQS1manA6w8KJYDP4qOHZkHkdcSmmM3jG5ochBE27U/9y6egO65sf
         jNveo6g0aqcU78Gchv+d5v27wBtID4dVACN2A8KFOKZ7V2Lw4mYEWYP1d5s9juK9JvHC
         uPis/FJimfySJLbnbWmtDmzTn6Cl4ZtBtuvsCKsplRAnT4K3CcQqdfiCbaUIwJdK0OkO
         m6mwkDtFrWQk8RoSf7fYJCDTxp/gGO3mMVgi1EvFdyXEzr1DWJMAZ7eELJLS4f5Sntt+
         +49FcXt7juOFIRvpL/kwVG76Tl54ax4AtypiFdFfk+gJIzFX9T+rCG/5hlTObCA7ZR7p
         MfyA==
X-Gm-Message-State: AC+VfDxbmyBXDACKe7cwS+c8fuxTuGi5zPMptQQN0rFm4UrCa9W6skCC
        1p1ZGYLdjQoQJQR6GKO3c9Zjrvj1rdeBjItsEVCHVx7QO7H0KMwufKXp0L074j0QSalmlr1WGSk
        Lw9OD8ownriWuu5Q1tLT7mdDLtwPIhqzE+zX/SVCkbQ==
X-Received: by 2002:a17:902:b416:b0:1b2:2c0c:d400 with SMTP id x22-20020a170902b41600b001b22c0cd400mr6641328plr.52.1686605329719;
        Mon, 12 Jun 2023 14:28:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rWzPzPD8nivIyYZaFs3EDuZHFThUOOKiZrJjfcGJD7CvzNHfJKoudwnZjpNK1ynO/WTOxAvv5S9o+kZQa2p0=
X-Received: by 2002:a17:902:b416:b0:1b2:2c0c:d400 with SMTP id
 x22-20020a170902b41600b001b22c0cd400mr6641315plr.52.1686605329287; Mon, 12
 Jun 2023 14:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210141.730128-1-willy@infradead.org>
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 12 Jun 2023 23:28:37 +0200
Message-ID: <CAHc6FU5qEBSP7MTOmZcH-_Sgrq-iiVhYVLmw087nkaNDhumAig@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] gfs2/buffer folio changes for 6.5
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:02=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> This kind of started off as a gfs2 patch series, then became entwined
> with buffer heads once I realised that gfs2 was the only remaining
> caller of __block_write_full_page().  For those not in the gfs2 world,
> the big point of this series is that block_write_full_page() should now
> handle large folios correctly.

This is great, thank you. For the gfs2 bits:

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> Andrew, if you want, I'll drop it into the pagecache tree, or you
> can just take it.
>
> v3:
>  - Fix a patch title
>  - Fix some checks against i_size to be >=3D instead of >
>  - Call folio_mark_dirty() instead of folio_set_dirty()
>
> Matthew Wilcox (Oracle) (14):
>   gfs2: Use a folio inside gfs2_jdata_writepage()
>   gfs2: Pass a folio to __gfs2_jdata_write_folio()
>   gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
>   buffer: Convert __block_write_full_page() to
>     __block_write_full_folio()
>   gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
>   buffer: Make block_write_full_page() handle large folios correctly
>   buffer: Convert block_page_mkwrite() to use a folio
>   buffer: Convert __block_commit_write() to take a folio
>   buffer: Convert page_zero_new_buffers() to folio_zero_new_buffers()
>   buffer: Convert grow_dev_page() to use a folio
>   buffer: Convert init_page_buffers() to folio_init_buffers()
>   buffer: Convert link_dev_buffers to take a folio
>   buffer: Use a folio in __find_get_block_slow()
>   buffer: Convert block_truncate_page() to use a folio
>
>  fs/buffer.c                 | 257 ++++++++++++++++++------------------
>  fs/ext4/inode.c             |   4 +-
>  fs/gfs2/aops.c              |  69 +++++-----
>  fs/gfs2/aops.h              |   2 +-
>  fs/ntfs/aops.c              |   2 +-
>  fs/reiserfs/inode.c         |   9 +-
>  include/linux/buffer_head.h |   4 +-
>  7 files changed, 172 insertions(+), 175 deletions(-)
>
> --
> 2.39.2
>

