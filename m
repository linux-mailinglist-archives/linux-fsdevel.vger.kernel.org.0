Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7642C471ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 00:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhLLXfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 18:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLLXfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:35:32 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A2C06173F;
        Sun, 12 Dec 2021 15:35:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p13so13447979pfw.2;
        Sun, 12 Dec 2021 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vul1OGbjqBROCNkeOAsbkteBYUXUUsTZZv/sSf95TQs=;
        b=IY9xXNmoIlQPgefKKfU89Vk+s3rwK4ZnNF20PSf4TKmA3jgzBJKVbuRSeWhQQ7WdmT
         bf2ti/O5Lyw6rItRLYcCuDznUhGE3WQ2uElZhMF0rZEEkN/HT9e7vKaElV10OKrBVnyX
         FuBQkXBfXTU+qigolDluuxN55LuTm5W1rG2PCPyzy6MumpFeDXPoouMOeKd+6ggxOZsY
         YtWAnmZBaIprJ6sI5e5+WcxnsmErfePq2xCEzkqMmYD6dfxiTBT62RR2YqiPCJngryes
         70qVY+SVZ/ByWZzA/SLQszX6r9qkUVvqfjF8JOQFTrLC8vq93kIiZrqRvplFH1KxfvVA
         safQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vul1OGbjqBROCNkeOAsbkteBYUXUUsTZZv/sSf95TQs=;
        b=lKQEbvZN69gng6IpshhSw93e47yayLKDPaF/UQvr7uDMxWJAuDckiNdVvIy4GRAgPO
         xGu146A3K0w4BAe77RR6CtDufpBGNXu9Zl7kVeZF7zxExEGupOWlQNvhWfFQryz/jmkc
         is0QR9iDlNtVtaBIJcD2WKkCfHPfXdKbIPVfqzrT0cmnqcY3LesSOgtDBBCzHKaq4Cpp
         JMQaSFtjfBUsjwo8nnAkPCTWSYdmXEYMNjOWUbtmYG8n5NW+RVH49/WPRYFZHRGCgZ8O
         t2lUv+tf5Mi0m7zaefXU09EPfHKHGjSFSImvMfSNryPBJ/lx9tU11Xp6f7NMwj9fuMuE
         /5OQ==
X-Gm-Message-State: AOAM531ysgKuWUd9nWFrE0NZkuDbWuqMLvU81mxFyQcEJW0fkk5LjwAk
        vFSLsJIbelxPpMAcay+zc/s=
X-Google-Smtp-Source: ABdhPJxC3x7xtLN5DOMm6sXuyN+uKuUo+yEF+4+E+Tn+FT3R8GCQP3mi1y9CgGbN5YCUEItH16/zBA==
X-Received: by 2002:a63:42c4:: with SMTP id p187mr49825420pga.585.1639352131821;
        Sun, 12 Dec 2021 15:35:31 -0800 (PST)
Received: from gmail.com ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.gmail.com with ESMTPSA id w19sm8443122pga.80.2021.12.12.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 15:35:31 -0800 (PST)
Date:   Mon, 13 Dec 2021 08:35:26 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] [PATCH v4 0/2] fs/binfmt_elf: Fix AT_PHDR for
 unusual ELF files
Message-ID: <20211212233526.ikyszt7jy4gzmita@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-4-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212232414.1402199-4-akirakawata1@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:24:13AM +0900, Akira Kawata wrote:
>  These patches fix a bug in AT_PHDR calculation. 
>  
>  We cannot calculate AT_PHDR as the sum of load_addr and exec->e_phoff.
>  This is because exec->e_phoff is the offset of PHDRs in the file and the
>  address of PHDRs in the memory may differ from it. These patches fix the
>  bug by calculating the address of program headers from PT_LOADs
>  directly.
>  
>  Sorry for my latency.
>  
>  Changes in v4
>  - Reflecting comments from Lukas, add a refactoring commit.
>  
>  Changes in v3:
>  - Fix a reported bug from kernel test robot.
>  
>  Changes in v2:
>  - Remove unused load_addr from create_elf_tables.
>  - Improve the commit message.
> 
> Akira Kawata (2):
>   fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
>   fs/binfmt_elf: Refactor load_elf_binary function
> 
>  fs/binfmt_elf.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 4eee8d0b64ecc3231040fa68ba750317ffca5c52
> -- 
> 2.34.1
> 

I am sorry for sending duplicated emails by mistake.
Please ignore the later ones.

Akira
