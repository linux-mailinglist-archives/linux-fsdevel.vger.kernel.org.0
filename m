Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0A772DD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHGSZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHGSZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:25:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1AF1B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 11:25:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb91c20602so10145865ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691432701; x=1692037501;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pJjNXs4QCJ//eacbs196+Ii1BpskstaQNpYfpqnv34=;
        b=kqpgx8X5bLaxAqYEt2ijFW6BbvzevlhTzCZkihAiTGIL5Bt5jai7jEaWqvv1B7EO+b
         22+Upfg9ezalxH4MWmswPVIgAvpB6gqHr1UBWtXQh4GJ8lj7IPFOsFeQPxcUcl7CbGnN
         5PkVwiWNBnQz+7my0AmCfmTF1JIPazlgFI9k9clZhAK4nNqyE6tnB+js5OIBMeE1dWgH
         NCuxFlGYMHbG+08KJ2xmr/lVGyPUU7+nWAclpnykQk0yJkVkLCovZIuGYjCkfr1GRIjk
         nflf74Wc4lnMaNOwfcrJpx+48WwZyCFGXvFGPlWCUlq7uU28bzZrsbxRVCw/ODyKsKk7
         dFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432701; x=1692037501;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pJjNXs4QCJ//eacbs196+Ii1BpskstaQNpYfpqnv34=;
        b=gGoBbH0nG5OBVD44/RskdAU1H2cFrNDnUC0/zLt+IuVsrl9Qmb90/irzH83jnmN879
         zU/e0dZtICPyj3n0G/w8abkWhKvLIJa8YmmrcaKYB8JWJ+SWKH6ZeCDtO6J7EReE0Ygt
         am9/3N0Wlp8L7M6tcQuVLLhKFeqeUeTuN22E7mN20EoVWR75dYLc1EDQKtr6chiA5rTE
         q6QYG+bhxlg3EyNuc9PV+Jdmz4qNXJ1S3C2FXrxzag8YS3RCviDhebtW1UiA12ml85Fs
         piiOtGPWLJtYfQL9BL+C3fl5A/1oaPL76EEG3R3e0787vKMqNbSLTcapO5Lv0ibCdCIX
         vFSQ==
X-Gm-Message-State: ABy/qLYs9+4QpnUKJv8PiILtyPQ3Xtc1Ougas/4c7aanSdfMty4MatLT
        EhYlD+FqOjs3y2F5N0l7Xl+JKA==
X-Google-Smtp-Source: APBJJlFURYryyRLRBjK4Cyr916nSBSaubf5aUgZlsfvmwJhugTUqlPYOfhCnpbjWJ4qrDtXrk7/lgg==
X-Received: by 2002:a17:902:d503:b0:1bb:83ec:832 with SMTP id b3-20020a170902d50300b001bb83ec0832mr33892430plg.2.1691432700593;
        Mon, 07 Aug 2023 11:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([12.221.160.50])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902b28300b001b66a71a4a0sm7240722plr.32.2023.08.07.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:24:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20230807-resolve_cached-o_tmpfile-v3-1-e49323e1ef6f@cyphar.com>
References: <20230807-resolve_cached-o_tmpfile-v3-1-e49323e1ef6f@cyphar.com>
Subject: Re: [PATCH v3] io_uring: correct check for O_TMPFILE
Message-Id: <169143269944.27533.6390760474967259170.b4-ty@kernel.dk>
Date:   Mon, 07 Aug 2023 12:24:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 07 Aug 2023 12:24:15 +1000, Aleksa Sarai wrote:
> O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
> check for whether RESOLVE_CACHED can be used would incorrectly think
> that O_DIRECTORY could not be used with RESOLVE_CACHED.
> 
> 

Applied, thanks!

[1/1] io_uring: correct check for O_TMPFILE
      (no commit info)

Best regards,
-- 
Jens Axboe



