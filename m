Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27377C28C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjHNVm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHNVmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:42:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B81127
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6878db91494so955465b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692049363; x=1692654163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HokS0Ay8nEZeEvLtY3kgB7gREbBGYmdmip7sM3/qZ0c=;
        b=DAW3jYLO1aY5rAnZUWMNaUhIlMAYySEnNnsvMYtTq5t95sWt6AjWe6SZvfmVQBrKCO
         lj7pVkR2nd/E7wkJih48ridFoM+1jwxuUUiNT6CnHzSPoOxAHE3LPshmBVtYOYxhTTJX
         fpCgCxpKMCSIQIZiEIEjz3vY31Bh947ZzkxA3AvloByrMVjq2e4ZnN4FpQrh8DMPHDOl
         pVI7TESmfl2fU/bHYSk9GaGEOtZiD+HB1MUPncHKgInbqu4CYn2FltI/nhVnVQupNVSI
         P/Do+TXuQuh29AplsZyk1a7Z+mEQ7+may2xa8RczSYiOWMD1sSSD+K72DeT/kj/e+HHU
         sl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692049363; x=1692654163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HokS0Ay8nEZeEvLtY3kgB7gREbBGYmdmip7sM3/qZ0c=;
        b=NAp+ZanLL+ITTfQnalrBL/JAOedAZcyvlKCplg8C6cddFi8BML1mCW705DQvEZjI2h
         8Xc/BwO1zCfCPn06upFBZ+XB3OW+NX0kXYTeNn0s2grlk/tccw3QqdeiZ8G71e1V5Wbw
         R/MZwYkdbGZqE1aOF7FKFv08Ez0O+YpEgu/9WSQcL2hlWUuddxPV8uru+8gSBABPDL1B
         tvpm0ugj9Or6/GpbIKfp7uvpOBuQa+v93hhuSt8keojRMbXSGGbmiygk727CM/jJQoql
         riiypcLtW/RyO0Dkn0pSUuh6QEXYLZSpEDn6TPOIh60Q0gHTUVOC7H1wJv+eqpISqnvF
         XzGQ==
X-Gm-Message-State: AOJu0YwtrxX6Ln3VB+GfQw8h1v/wO7WHM0+RYdIOdanCWRJdZwM0qJte
        PQvWxqOgQ6fVnic0WlVRdPA1lA==
X-Google-Smtp-Source: AGHT+IHLNdgUyk1B0TuKyBoCN80Q6dxGq7WvVUcgQizu9WGr9aTDFaNFJH7Mrfki8rSFWEdmPdfB7g==
X-Received: by 2002:a05:6a20:8f0b:b0:140:ca4c:740d with SMTP id b11-20020a056a208f0b00b00140ca4c740dmr17424290pzk.4.1692049363226;
        Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b0064aea45b040sm8322132pfi.168.2023.08.14.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:42:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
In-Reply-To: <20230813182636.2966159-1-kent.overstreet@linux.dev>
References: <20230813182636.2966159-1-kent.overstreet@linux.dev>
Subject: Re: [PATCH 0/3] bcachefs block layer prereqs
Message-Id: <169204936207.419413.14562602017463272186.b4-ty@kernel.dk>
Date:   Mon, 14 Aug 2023 15:42:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Sun, 13 Aug 2023 14:26:33 -0400, Kent Overstreet wrote:
> aiming for v6.6.
> 
> The "block: Don't block on s_umount from __invalidate_super()" patch has
> been dropped for now - but we may want this later as there's a real bug
> it addresses, and with the blockdev holder changes now landing I suspect
> other filesystems will be hitting the same issue as bcachefs.
> 
> [...]

Applied, thanks!

[1/3] block: Add some exports for bcachefs
      commit: 7ba3792718709d410be5d971732b9251cbda67b6
[2/3] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
      commit: 168145f617d57bf4e474901b7ffa869337a802e6
[3/3] block: Bring back zero_fill_bio_iter
      commit: 649f070e69739d22c57c22dbce0788b72cd93fac

Best regards,
-- 
Jens Axboe



