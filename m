Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB46AC4CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCFP1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 10:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCFP1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:27:11 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090340CB;
        Mon,  6 Mar 2023 07:27:10 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id j2so9210391wrh.9;
        Mon, 06 Mar 2023 07:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjzbTdN7CLD76LwUYgSQFGlrkv+uCLMJlqFIMmRORpA=;
        b=2EUxB7rhuYb6ii74TXs9YxpCJfySTXuBhpC00xi2g2Tl/LKcr0u9Gh6OjOA8oldIWm
         Lw703w6B1qzrGyPBhPf8iBBgv1HVPnMh9jfcg3j0t3OUzrKpwzLv1dqjaisbRwHAYGSW
         wYNLJ4gQQcUb4/vmh7WEEIcloNRTZsKn+wBCQOnSApgMEs2UHBk0eWUKqtz8OXuZGKuA
         BzvEFRHctI0x1VBvTC81BQkLNFM+tdLdQiJ6zp2kSI/3aGe8368MDS740BPhLgQ12qXj
         0FpHtsTrpwiDjoTE3C6nL7fusulh7SN/6ulOjc7FvCvckC1B9086DLwqq7hFqptf6eOQ
         WrcA==
X-Gm-Message-State: AO0yUKWGBHuyX1P1LV1bgoz7eY99SoIykUcj0mjyVRYY4DrF42RVupL4
        0loLf8b2rTaDprlKZq3BqsQ=
X-Google-Smtp-Source: AK7set8sLVDUwT8GQGScn0gVSp+FOGcmG6WKTOjmYMNL/6orgxuEwPFL/9jsyQwuVKKF6cXajJRglg==
X-Received: by 2002:adf:eb4b:0:b0:2c6:e744:cf71 with SMTP id u11-20020adfeb4b000000b002c6e744cf71mr6185222wrn.52.1678116429360;
        Mon, 06 Mar 2023 07:27:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r1-20020a056000014100b002c5534db60bsm10414947wrx.71.2023.03.06.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:27:08 -0800 (PST)
Date:   Mon, 6 Mar 2023 15:27:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, minyard@acm.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, song@kernel.org, robinmholt@gmail.com,
        steve.wahl@hpe.com, mike.travis@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        xen-devel@lists.xenproject.org, j.granados@samsung.com,
        zhangpeng362@huawei.com, tangmeng@uniontech.com,
        willy@infradead.org, nixiaoming@huawei.com, sujiaxun@uniontech.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] hv: simplify sysctl registration
Message-ID: <ZAYGR4DFQrjZVpC5@liuwe-devbox-debian-v2>
References: <20230302204612.782387-1-mcgrof@kernel.org>
 <20230302204612.782387-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302204612.782387-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:46:08PM -0800, Luis Chamberlain wrote:
> register_sysctl_table() is a deprecated compatibility wrapper.
> register_sysctl() can do the directory creation for you so just use
> that.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
