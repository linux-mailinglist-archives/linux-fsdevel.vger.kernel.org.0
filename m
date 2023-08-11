Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D716779125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjHKN6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHKN6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:58:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2BEA
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 06:58:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63d10da0f26so13600636d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691762311; x=1692367111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOzDCd04VE0SULfz9lrhi4705BMAE/fYR5J/4qqrUV0=;
        b=cawaK5Dp6mIWutTITZ4bH4giSOQALDe36gSCfFbV5uiC/RHKJZp5HzGDkOrEWlLKSl
         47FJHJJzARLEFPuhrTquTWztAtcgaetrdOtVMCpGGKDb8ZDOM3TcW+/B4jbqCWZgpIBL
         7FgVwbAl4g2q+Yppa4fdCLiL5hOZyH9umaOc4Zv9u7DsfBCQEusJSHhmHwC9ktII82P1
         YDprV1R9yEHGWV9R9C166iUiKVa7qyTMf/q1R+5/Z6uzw06c3rLstWTlGCmg4dUurxo1
         +hKBeGi9BMuCbni1Yvc5RfzpHF+8embJvUf+R8j/PCzCh8OPE+DiyYc3UYNuMFKzz8P6
         fXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762311; x=1692367111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOzDCd04VE0SULfz9lrhi4705BMAE/fYR5J/4qqrUV0=;
        b=g7aTkKtRKTqUk8tJRYiU/0BsSXTNrsRanhw3FSD55nc93C+S16w3WCPF/eA5wpgTJf
         tlYXEeNzd2gRYlg+3jQ2Q/N9dYsRdB5OMBHMOl4LQYcpFSdzbxZy34pzITZgy7VADvC+
         nCeKbACHJ70pY7eksPtNUJSntyyAsXC7ambNk/tGsVKGg11WxJiku1no5cDfIsdlovDq
         XUcPctlr+difiW4CKzxFjBHZVAiv6wCJMKpesFjT/UbRlNJhwdMF+jDCz/yMqWMJ88v8
         FtPScIKfn3/GhmJmM1dU8ETjqA/wP3Qd1xgtgRnv+tVrw1H0kUKZBo5YI1+eFsudm6Al
         6Dbw==
X-Gm-Message-State: AOJu0YxMvykiO1Ak2c5eJo3/WSFRmN/J5A9Yl6tkbX0Y/J7fxk8d3wQb
        iitmUzAwFJSLhexZuPzyHqJiUg==
X-Google-Smtp-Source: AGHT+IGVzn498qbFNettmingI72J3rVK4joYT9qIyHhVAUq+7mWAeEKyf6BHcV179iCeBXifA9QbpQ==
X-Received: by 2002:a0c:e14c:0:b0:63d:f8d:102f with SMTP id c12-20020a0ce14c000000b0063d0f8d102fmr1711178qvl.18.1691762311058;
        Fri, 11 Aug 2023 06:58:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y22-20020a37e316000000b00767dcf6f4adsm1191525qki.51.2023.08.11.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:58:29 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:58:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove get_super
Message-ID: <20230811135828.GA2724906@perftesting>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series against the VFS vfs.super branch finishes off the work to remove
> get_super and move (almost) all upcalls to use the holder ops.
> 
> The first part is the missing btrfs bits so that all file systems use the
> super_block as holder.
> 
> The second part is various block driver cleanups so that we use proper
> interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> 
> The last part than replaces __invalidate_device and fsync_bdev with upcalls
> to the file system through the holder ops, and finally removes get_super.
> 
> It leaves user_get_super and get_active_super around.  The former is not
> used for upcalls in the traditional sense, but for legacy UAPI that for
> some weird reason take a dev_t argument (ustat) or a block device path
> (quotactl).  get_active_super is only used for calling into the file system
> on freeze and should get a similar treatment, but given that Darrick has
> changes to that code queued up already this will be handled in the next
> merge window.
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/misc.git remove-get_super
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-get_super
> 

I rebased this onto misc-next and put in a PR to get it running through the GH
CI, you can follow it here

https://github.com/btrfs/linux/actions/runs/5833422266

In the meantime I'll start reviewing the patches.  Thanks,

Josef
