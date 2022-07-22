Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921257E7B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiGVT42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVT40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:56:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354259C27B;
        Fri, 22 Jul 2022 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZosF4/sMc0ihmX47ZtSXWJLh9VlS4bzSsfv/BETdwF4=; b=VNhO9L3HEMflnvHx6vsxrwdWR6
        BeMsUX5k5thgO5ceMSltwRfdDNQWHw+slUvZMJF45URjzjQ5t5orJLjccfNNLVm9hE6NWLyla9sVK
        DUETIYMZSceOB1HrGZsftTEV9OHhGsKOmWu0qWiWOc4qTm3K06uxzC6at2pm0mP2SkjWzylGhaAsy
        lTnNeEdIEnfgUc/7nAoeqnAJheKRqrETrRi3SGS3sD8zs/fgcO8TZyt+Y02zuUpLUN4kTq7qSapud
        zBOQYKE9BXo6z6MRWlVu9REjeS7eiA1KnbqJzHReMVKXPbAYgtT63wFw/+jZThS9GF06guioAuLmt
        YLCk674g==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEykt-009cUn-Fz; Fri, 22 Jul 2022 19:56:11 +0000
Message-ID: <d0c9c894-bfff-e3ee-c1be-84b7690a7a86@infradead.org>
Date:   Fri, 22 Jul 2022 12:56:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] Documentation/filesystems/proc.rst: document procfs
 inode timestamps
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com,
        corbet@lwn.net, keescook@chromium.org, yzaikin@google.com
Cc:     songmuchun@bytedance.com, zhangyuchen.lcr@bytedance.com,
        dhowells@redhat.com, deepa.kernel@gmail.com, hch@lst.de,
        linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220722162934.1888835-1-mcgrof@kernel.org>
 <20220722162934.1888835-3-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220722162934.1888835-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 7/22/22 09:29, Luis Chamberlain wrote:
> The timestamps for procfs files are not well understood and can
> confuse users and developers [0] in particular for the timestamp
> for the start time or a process. Clarify what they mean and that
> they are a reflection of the ephemeral nature of the filesystem
> inodes.
> 
> The procfs inodes are created when you first read them and then
> stuffed in the page cache. If the page cache and indodes are
> reclaimed they can be removed, and re-created with a new timestamp
> after read again. Document this little bit of tribal knowledge.
> 
> [0] https://lkml.kernel.org/r/20220721081617.36103-1-zhangyuchen.lcr@bytedance.com
> Reported-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Documentation/filesystems/proc.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 9fd5249f1a5f..9defe9af683a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -59,6 +59,15 @@ The proc  file  system acts as an interface to internal data structures in the
>  kernel. It  can  be  used to obtain information about the system and to change
>  certain kernel parameters at runtime (sysctl).
>  
> +The proc files are dynamic in nature and allow for developers to make the

Awkward. How about:

   The proc files are dynamic and allow for the content to be changed each time
   a file is read.

> +content to be changed each time a file is read. The proc files and directories

                                                   The proc files and directory

> +inodes are created when someone first reads a respective proc file or directory,
> +as such the timestamps of the proc files reflect this time. As with other
> +filesystems, these proc inodes can be removed through reclaim under memory
> +pressure and so the timestamps of the proc files can change if the proc files
> +are destroyed and re-created (echo 3 > /proc/sys/vm/drop_caches forces and
> +illustrate the reclaim of inodes and page cache).
> +
>  First, we'll  take  a  look  at the read-only parts of /proc. In Chapter 2, we
>  show you how you can use /proc/sys to change settings.

Thanks.
-- 
~Randy
