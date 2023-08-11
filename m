Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112B77874B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHKGJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKGJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:09:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4932D48
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:09:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso1312228276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691734150; x=1692338950;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmbe2iolL38ne6oXD89ZJcmHJrDy7EKGAYoy/3yqI9Y=;
        b=D2/9saRKBkqou2m7vAz5/K3aTtWxicVLPCyIdIP/64PjE+N12JcIfbrRW5swezazs5
         kd6yj1gX3CTcaDR1TbtXVAE3BjPH+yP5h7b0ufEbh1o2UR/Int2dwoykEstOyXlYzF7R
         HD4f0Qy/mudsxXd0R9vaKIr7zO2S2/CI2HgY8GvYIKZnS8h917oNQjlnGD/qztkBbTPm
         ZMTVAvUJH8576b2gPQTaPcljfXTM85V6glQFpyk0NWaZ9gxVfXVbui+lWgOpy/etYxYN
         sBPBQ5MYYM2/QvBgUJmDeSpwznZV6veEn/QqXCyyOExty6x8nwXdJWQm/3k7KzzvmahJ
         E4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734150; x=1692338950;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmbe2iolL38ne6oXD89ZJcmHJrDy7EKGAYoy/3yqI9Y=;
        b=jPL9XbiiXGwu5gEB5rucJwZtEWi29l7N82Ajb7zAZrZqS6LB+Ng69ZKJAcKat4jaRN
         brUxcTndTaZOGh6NOIOT1z9YgkRgbKD6HFCVVz9pdOzF4Ll1GYat+VAywWVzobiRWcOc
         rtxwLbz1tZI9cXzefrVHtaE30FrhPmFtSLDw3rZzKLAe5GqJC65UAGCj1hCCQIrzX3aN
         GH112yszFsxTv1yjWb5eXzlgxhx6I2T0P9OhwvXg7iGDPBTx5kYG3oM0nTGkk+QGNRCt
         7kUogMzTCpzboCSZNhlmPmXE489BiBjF1tSyaSe/0cuGtHfSX8rfc7kAFvXpGPxuE47K
         4pRg==
X-Gm-Message-State: AOJu0Yx2Ht2EJn+95liwPa34A4ZB5Ij+byZv5AEAQlBliV5nldqFhqGZ
        Aisup9u8pxVwJcvES0FKNy0AmQ==
X-Google-Smtp-Source: AGHT+IGLhHAsHnZEVdMJ2JYB9n0OKJavQnnkSlA2e4KkjI40YFBzR+jcjnzEfrUa1byEEQq/WlgYOg==
X-Received: by 2002:a25:2d04:0:b0:d4b:64ac:a4f7 with SMTP id t4-20020a252d04000000b00d4b64aca4f7mr780601ybt.62.1691734149984;
        Thu, 10 Aug 2023 23:09:09 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s3-20020a25b943000000b00cad44e2417esm726509ybm.64.2023.08.10.23.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:09:09 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:08:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
In-Reply-To: <ZNOXfanlsgTrAsny@infradead.org>
Message-ID: <194ba8d1-767d-a153-419-7f124ab6d36c@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <7c12819-9b94-d56-ff88-35623aa34180@google.com> <ZNOXfanlsgTrAsny@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023, Christoph Hellwig wrote:

> Please do not add a new ->direct_IO method.  I'm currently working hard
> on removing it, just set FMODE_CAN_ODIRECT and handle the fallback in
> your read_iter/write_iter methods.

Thanks for the input, I'd missed that FMODE_CAN_ODIRECT development.
I can see why you would surely prefer not to have a .direct_IO added.

But whether that's right for tmpfs at this time, I'll let you and all
decide: I've tried and tested the v2 patch now, and will send it out
shortly; but it has to add a shmem_file_write_iter(), where shmem was
doing fine with generic_file_write_iter() + direct_IO() stub before.

So my own feeling is that the v1 patch with shmem_direct_IO() was better,
duplicating less code; but whatever, you can all decide between them.

> 
> But if we just start claiming direct I/O support for file systems that
> don't actually support it, I'm starting to seriously wonder why we
> bother with the flag at all and don't just allow O_DIRECT opens
> to always succeed..

Yes, I've wondered that way too, but don't have a strong opinion on it.

Hugh
