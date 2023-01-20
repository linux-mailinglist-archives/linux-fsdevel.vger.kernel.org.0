Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99267561A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjATNrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 08:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:47:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985D6CCF2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 05:47:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j17so4145116wms.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZoavFe66tyAiBRUGwZi4jcB2rVI/ZD7C6oDYeY7Jqw=;
        b=UcnZkCm4z/B+tfRTmK6FNMddrXJ2cA34UoxfCKDugbqGQHmmpNXsweGY8Uhcy0pbpH
         K/scQo3b5KhBLXKLl6j/tlb9AQ9l0e5xiaoEMVCMMZ/AHKSOQcZ3Ke+0gIqhvjqwT5zr
         1Irt3bqOXCuPYQDlqSy0bHa7tkgIgxi1vCs7+JsR+AV6wcEztn6NJiPM7gkmGbpgk4gi
         2/oWzckDMX0l/UeSDLA/BG3N0Z2VTD5ongZpm3xNrlOE+eAAXBNtuuTsu2Et0hLtVqPi
         sXRZwvlS4OFR4oH/Zm1KRD09U2kGlMLU4hyg+Otb2MjzQNo3Zczu9VlLknY1j8JvH3FU
         cSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZoavFe66tyAiBRUGwZi4jcB2rVI/ZD7C6oDYeY7Jqw=;
        b=s44c/L4Noq0mUF93QHbAbRcZYHKWFRRegW6RUV0Bq7MCxT7rT54vFV/9r0gk3tpU7I
         uViq+Zjmx81N2jSAfm63U01UWAiMoomdbfSvAypZQsdHk/eA48IsYfnKgyHvg0ThtGh9
         K7e2LpXUt4rG8uROA3/0YL2jiEvaCSdw3A2zSaVm1Ck9kKBJXp4F8lQY05iFoeNMse1q
         iM+Sc6+nO1yT0WqLUy7etLlAPfzcVYCJhWoCP4v4nDbeg1ZFJ+LaGFFYQwIQFSM5l6Wo
         FhycYIhYpIQrxwNV7gKI/679PGIQO1WQBfyZBVJEqUkvJQUQ9o9KuewgaJDWgwypEt9Y
         UMcQ==
X-Gm-Message-State: AFqh2koHAFKoxodrgIxJ8s76DjKme4G2V4tet2wc0Q5kMF6MCfj/JLKC
        xzNUgqsTo+idDh/7PB+30dALZpUI+OGWAQ==
X-Google-Smtp-Source: AMrXdXs0jI18G/X91sXHoeJX6bcTHV2fAFy6inl9TfvkyylUy6rNkjj78xiYl8PPFWCOcwmNkZs7Ng==
X-Received: by 2002:a05:600c:4d98:b0:3d3:5c7d:a5f3 with SMTP id v24-20020a05600c4d9800b003d35c7da5f3mr22615698wmp.37.1674222428690;
        Fri, 20 Jan 2023 05:47:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm2510692wmq.29.2023.01.20.05.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:47:07 -0800 (PST)
Date:   Fri, 20 Jan 2023 16:47:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     dchinner@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] iomap: write iomap validity checks
Message-ID: <Y8qbWDfLGqUDnbsz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dave Chinner,

The patch d7b64041164c: "iomap: write iomap validity checks" from Nov
29, 2022, leads to the following Smatch static checker warning:

	fs/iomap/buffered-io.c:829 iomap_write_iter()
	error: uninitialized symbol 'folio'.

fs/iomap/buffered-io.c
    818                 if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
    819                         status = -EFAULT;
    820                         break;
    821                 }
    822 
    823                 status = iomap_write_begin(iter, pos, bytes, &folio);
                                                                     ^^^^^^^
The iomap_write_begin() function can succeed without initializing
*foliop.  It's next to the big comment.

    824                 if (unlikely(status))
    825                         break;
    826                 if (iter->iomap.flags & IOMAP_F_STALE)
    827                         break;
    828 
--> 829                 page = folio_file_page(folio, pos >> PAGE_SHIFT);
                                               ^^^^^

    830                 if (mapping_writably_mapped(mapping))
    831                         flush_dcache_page(page);
    832 
    833                 copied = copy_page_from_iter_atomic(page, offset, bytes, i);
    834 
    835                 status = iomap_write_end(iter, pos, bytes, copied, folio);
    836 
    837                 if (unlikely(copied != status))
    838                         iov_iter_revert(i, copied - status);
    839 

regards,
dan carpenter
