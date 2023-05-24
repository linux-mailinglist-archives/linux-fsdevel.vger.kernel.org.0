Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27270EDE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjEXGes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjEXGer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:34:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02AA3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 23:34:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3094910b150so355758f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684910084; x=1687502084;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/LLIQYZF//KnWIxrnxjHsO7HAHk/TZv9WOtF2girZ0=;
        b=TyXVYKwdsJ08RVlenxhvRbteQntBVMXDn33HAUZKSNtnu4jlMbdqBDFGC8/kox6SCg
         Q2wf59WqJf6dN6vyX5rYTwGLWyyrtpaxa1dV/MHLmHt+TdK01fwwqvgqKI3XxPMr/T2y
         3nCFp5xn3OAYdPpgFX1tJ0X42W1uqJp7NCq5GhNHzO325D+ugqkvVP3HKLf4FZA4ARQJ
         lJiFC+vVgBGrnmK3pebpkXX9jPSyCQdUZoM1na7cwprldjncJRe1gfavkj2ZzIf2S4gY
         14XqiV+7Y7uMb1F11eEzrFIQ3ZqvmxlxZ/yNnGy4Vr4vetZWdktAsnW2I61EabbEKHAe
         +Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910084; x=1687502084;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/LLIQYZF//KnWIxrnxjHsO7HAHk/TZv9WOtF2girZ0=;
        b=ROsH2CK0KvClfsKg39//IJbCevV4RkKIHR/wOSjRJgFIbVmncFyfVqx9Y1YNaaUrrH
         Iiu+IcJxMaDVj0gbAr3cdCCZlnTaxpabH8KJZ7WqnIary8TpMRuXvD2f2cdy+2xC7fhN
         vl/mjQvuy+nvtkt8TFvMqQO1mwy0fH43hdl7S8OgThRKFYOq5T8vlQ44v8c2D1bR1tdq
         LcGfHhj3u+Nk6y1I5H9mHwBuOe5xLUuYLf5W6bsfecvF04sAspsClgIqqsv1uUlX9l00
         msNUTt86aPTVrlMK14VohwDg2mCBWOFmph1oEi/2mN8yR/ZdZa3iYOH761/mIwfwgGUn
         Arag==
X-Gm-Message-State: AC+VfDzL9tlwo04pStqQakfEwULSuuRPM0W7lk7KI8XkvLIiy8kq7dDE
        Z5diTQryxfwsh5sB+grK19vuCA==
X-Google-Smtp-Source: ACHHUZ6utmMW96DzWbi29tLMRshPrVsZRznemWDtUUaJmxtVmGdRMWl5btn+BwjR+co7H3yRJUJ+TA==
X-Received: by 2002:a05:6000:10c1:b0:309:5119:7259 with SMTP id b1-20020a05600010c100b0030951197259mr11174763wrx.20.1684910084378;
        Tue, 23 May 2023 23:34:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4001000000b003062ad45243sm13364236wrp.14.2023.05.23.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:34:41 -0700 (PDT)
Date:   Wed, 24 May 2023 09:34:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fanotify: support reporting non-decodeable file handles
Message-ID: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir Goldstein,

The patch 7ba39960c7f3: "fanotify: support reporting non-decodeable
file handles" from May 2, 2023, leads to the following Smatch static
checker warning:

	fs/notify/fanotify/fanotify.c:451 fanotify_encode_fh()
	warn: assigning signed to unsigned: 'fh->type = type' 's32min-(-1),1-254,256-s32max'

(unpublished garbage Smatch check).

fs/notify/fanotify/fanotify.c
    403 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
    404                               unsigned int fh_len, unsigned int *hash,
    405                               gfp_t gfp)
    406 {
    407         int dwords, type = 0;
    408         char *ext_buf = NULL;
    409         void *buf = fh->buf;
    410         int err;
    411 
    412         fh->type = FILEID_ROOT;
    413         fh->len = 0;
    414         fh->flags = 0;
    415 
    416         /*
    417          * Invalid FHs are used by FAN_FS_ERROR for errors not
    418          * linked to any inode. The f_handle won't be reported
    419          * back to userspace.
    420          */
    421         if (!inode)
    422                 goto out;
    423 
    424         /*
    425          * !gpf means preallocated variable size fh, but fh_len could
    426          * be zero in that case if encoding fh len failed.
    427          */
    428         err = -ENOENT;
    429         if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4) || fh_len > MAX_HANDLE_SZ)
    430                 goto out_err;
    431 
    432         /* No external buffer in a variable size allocated fh */
    433         if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
    434                 /* Treat failure to allocate fh as failure to encode fh */
    435                 err = -ENOMEM;
    436                 ext_buf = kmalloc(fh_len, gfp);
    437                 if (!ext_buf)
    438                         goto out_err;
    439 
    440                 *fanotify_fh_ext_buf_ptr(fh) = ext_buf;
    441                 buf = ext_buf;
    442                 fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
    443         }
    444 
    445         dwords = fh_len >> 2;
    446         type = exportfs_encode_fid(inode, buf, &dwords);
    447         err = -EINVAL;
    448         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)

exportfs_encode_fid() can return negative errors.  Do we need to check
if (!type etc?

    449                 goto out_err;
    450 
--> 451         fh->type = type;
    452         fh->len = fh_len;
    453 
    454 out:
    455         /*
    456          * Mix fh into event merge key.  Hash might be NULL in case of
    457          * unhashed FID events (i.e. FAN_FS_ERROR).
    458          */
    459         if (hash)
    460                 *hash ^= fanotify_hash_fh(fh);
    461 
    462         return FANOTIFY_FH_HDR_LEN + fh_len;
    463 
    464 out_err:
    465         pr_warn_ratelimited("fanotify: failed to encode fid (type=%d, len=%d, err=%i)\n",
    466                             type, fh_len, err);
    467         kfree(ext_buf);
    468         *fanotify_fh_ext_buf_ptr(fh) = NULL;
    469         /* Report the event without a file identifier on encode error */
    470         fh->type = FILEID_INVALID;
    471         fh->len = 0;
    472         return 0;
    473 }

regards,
dan carpenter
