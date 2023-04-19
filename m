Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1D6E79E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjDSMpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjDSMpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:45:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1512C449D
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 05:45:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b875d0027so1060784b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681908340; x=1684500340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWkATxwUI54Wjf29X1y6InilmbSwGYCaupz7wL2xoYA=;
        b=V/Zcy6Qn3ntP2MHoNED004N6bQmV9wF3ftWYZh6tBptsdhl634WOoMOrhxWZa09I0E
         BhbUDuv3/vLqZQ3/fuC0QJi4YYd6uwouwggm+7jdkzU9qjrzbrWNa2UORInkpFcnVCHg
         xIqXThcvzQMSqo6MOmPMDbyGP2XRWEalPvVi47srhbKaPo3iKAIPhFnkLhPeO9q8LvFb
         CdDM9FLOXiV0XIhZiQOKkbwjfp3Ycbb6kxNdOikLX/rI2yPmTfRO0OBIbLaFAI1ybmvr
         x1JzceTadJIKEShma9KMfX8wo/OeN/RW3l74s5Wl3nxYqBfCwilA6DnJG9f4VeyL0Vzo
         Mx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908340; x=1684500340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWkATxwUI54Wjf29X1y6InilmbSwGYCaupz7wL2xoYA=;
        b=lXQQY/dp1gZDi7HfUnIn5XUVpZvECBYiKoKUzU0JRiKXE695boEl105dMEDdInDizY
         SYHpeBB+AzPcW6wlLonmNJYqlshL9dgNOk9YB2TREm2XEZAYQrefQ5/QIqJr3JuzU0YY
         6rXlllEbDP+Dph6Itsu2aaHI4E1bOrof9WpGjnCM3oB0zeTR3AiuFUP+LkHuppiEAq0S
         Axc1j6BbvLWBkpbNYJPpw3eE1nBV86BwgzPZz/aSfW+/OkungeN7jcAqE8fIrTDrW25y
         BikzBjcokmkaphxUCJeSrgSTqjq2GPiOsePH2BNETIF4rUuZKo4B8+ESw0Y6AwEMA8Sm
         i0bA==
X-Gm-Message-State: AAQBX9d2zJdv9HG5Cng2b4/7EnqCG2letnBTzeTTmWN9eZ/pnBHn3jSq
        Gn6n4Mt4ojZSST+K8vza3UaN1Q==
X-Google-Smtp-Source: AKy350YZ068gLQ817k+Ij6jge/IubKk6mC1ANeALBOZN7osif6ym1dK+BGMD9/8chbAcO3bPTjBUtQ==
X-Received: by 2002:a05:6a20:3c92:b0:f1:1ab5:5076 with SMTP id b18-20020a056a203c9200b000f11ab55076mr3391077pzj.2.1681908340445;
        Wed, 19 Apr 2023 05:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b0063b79bae907sm7731602pfd.122.2023.04.19.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:45:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     Ayush Jain <ayush.jain3@amd.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1770755.1681894451@warthog.procyon.org.uk>
References: <1770755.1681894451@warthog.procyon.org.uk>
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
Message-Id: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk>
Date:   Wed, 19 Apr 2023 06:45:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 19 Apr 2023 09:54:11 +0100, David Howells wrote:
> Fix the new filemap_splice_read() function to get i_size from
> in->f_mapping->host, not in->f_inode so that it works with block devices
> too (in->f_inode points to the device file, which is typically zero size).
> 
> 

Applied, thanks!

[1/1] splice: Fix filemap of a blockdev
      commit: 5a9515a407d1aec1dd76c24fe99d9981730b74fb

Best regards,
-- 
Jens Axboe



