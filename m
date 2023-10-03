Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67607B71EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbjJCTmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjJCTmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:42:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF693;
        Tue,  3 Oct 2023 12:42:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so2212534a12.1;
        Tue, 03 Oct 2023 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696362131; x=1696966931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVoeTQ7nfzj/p7mI8QZRjAnFgYIqe4vJYchWx54r9ts=;
        b=HSDQ8JdjGK98YgsIiDXCR1sZ5I94MQGDVV7zL6bidbGbCZ73u2yYvYiVBzQI1ZkEJR
         NhQUKzkArF+Jsk0ERiEu0Th8HJgb0eqmqOPsXA9XODVGYABrHcrFtYLpHdR3qn5xkwL5
         Q9KiPXhNrj2fW/wEpyKYczZdUxARY+f5XODyyUasJnxctEpWb9RPBKAnSrfHrQCib/px
         CU0Q//02QKo6K9yg5eAwgjvIFY73eQBil0p+kjl+PgHCzvmUdSE8iImEHa7nqHHBaCZn
         qTNfXrOSHYftQORNfp3O5QcI0AHFkFMUmD2JhJF7Mh1k66O1FQK2LJYAztIHilIIcQGk
         nydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362131; x=1696966931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVoeTQ7nfzj/p7mI8QZRjAnFgYIqe4vJYchWx54r9ts=;
        b=N4XCq2l1mk+tK56zAgWkM/14VUrqZLciTO078vMysMdCXTcCZsk251GZ7H3HAcQLSw
         SE4R7Mk7Wbb3MD3VVE2PEz52x5a62Fh4BwpItD6/nPGWBNlaSY7NgSlWtcx05oV3vPRg
         vgV9nnwHiqJsuLwN8L6894BuoBOBqn0AQYk06wUbYLba48xDnZDE8Y/zmZeZq7NAXHz9
         1ICpZb7VoTIOOagL9smVXcuwGTh40OKuGjimD6NJu/boOSLe3aOftE7mKPIdv1k9+Wx3
         twjUsFNl+r7Dxe7bV3zmFAOA5bbwsqk1hP6pg8dq9lO/zgZZ/D5+fKgpNj1hAE4dHWyA
         Yh6g==
X-Gm-Message-State: AOJu0YyQE4MdoU3sTHgfbeklB8LDW1NrxePkN+rBH8YAHfgBA7dSgxt2
        dR8MRvRaanWXjWYG7GeNBCA=
X-Google-Smtp-Source: AGHT+IFmVpFJtAe8wrqGeSqBx/FJnm27xhJcJ1o1jU/TpZdzaFdgbHTGKS6n14/UAD6039MU31DSXw==
X-Received: by 2002:aa7:dcd5:0:b0:524:547b:59eb with SMTP id w21-20020aa7dcd5000000b00524547b59ebmr127695edu.15.1696362130479;
        Tue, 03 Oct 2023 12:42:10 -0700 (PDT)
Received: from ?IPV6:2003:c5:8703:581b:e3c:8ca8:1005:8d8e? (p200300c58703581b0e3c8ca810058d8e.dip0.t-ipconnect.de. [2003:c5:8703:581b:e3c:8ca8:1005:8d8e])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7da06000000b005346bebc2a5sm1298487eds.86.2023.10.03.12.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:42:10 -0700 (PDT)
Message-ID: <77b6e2c7-254d-cf38-4b0e-6b81e8999db2@gmail.com>
Date:   Tue, 3 Oct 2023 21:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/13] fs: Restore support for F_GET_FILE_RW_HINT and
 F_SET_FILE_RW_HINT
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-3-bvanassche@acm.org>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230920191442.3701673-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.09.23 9:14 PM, Bart Van Assche wrote:
> Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT by
> reverting commit 7b12e49669c9 ("fs: remove fs.f_write_hint").
>
> Cc: Christoph Hellwig<hch@lst.de>
> Cc: Dave Chinner<dchinner@redhat.com>
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>

Reviewed-by: Bean Huo <beanhuo@micron.com>

