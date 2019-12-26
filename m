Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209E712AD52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZPuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 10:50:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfLZPuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:50:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so23871799wrl.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+YxLCGodTg0pZLH/iyQhlCV+Idq1A1pe4ky0dTnDHU=;
        b=d53lPBKHHBng1voKPzjngOLFmAJJQh3c2d1sgQtlfgDFOYAOdd8y8l59DnO4hoKod/
         2rAI2hG0OnzCjgG7M6EA1jBJRd5B/rIKcNC5ghE7r/lA7qiQYtaMMDLSR2lNEjPql8W0
         umcWcHJtYpjVC8c59GVbVwkVb/TwdZeLEjRzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+YxLCGodTg0pZLH/iyQhlCV+Idq1A1pe4ky0dTnDHU=;
        b=EXRfXB1oDeq4hajqcnhZUVFtspSFW3IlHgnowK3giRzqVXCZKXekIbDZ+sN5BzUjlH
         wNILhlRtQf8I0PPttxPfvbGvV2MhWRJUWnvdJnTYAjawWa8P1YbCzkq6ibr6+RvBLtve
         xUlJnf2xNJGiBEoQgeA6DGThEdtEXlNrEk+rqLiHDCg+BSzDRfmU8G4zpNnSFqmBNJjZ
         AChKbWp/oVWw6W1/A5+uKw9mo8YoK1xMF3IegdHOnVLASNX1g2WL38LRBIwgYLwVDZsX
         u82Rn7K4SWe/KRpFYW0FuH42E2gsIan58OqHgUUcxsAUCnY66hh1Y9rhEp5D+7PV9Vg3
         wobQ==
X-Gm-Message-State: APjAAAWmNc3ndDTfPjDYTj4FMs20H6gwnmqsDmq8+FimcuIeCzUarfyA
        x48/BdOD3A2XsQc5B8y9zQ3pIRrBia0=
X-Google-Smtp-Source: APXvYqzchPQmPXlFgJXGNqs147QRCD5hSoOSZszH8wzmHTWm2VQDnSvjW2TEqMNsj0Hj52zjNmBBMg==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr45575737wrn.384.1577375408814;
        Thu, 26 Dec 2019 07:50:08 -0800 (PST)
Received: from localhost ([85.255.234.78])
        by smtp.gmail.com with ESMTPSA id u8sm8525746wmm.15.2019.12.26.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 07:50:08 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:50:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191226155007.GA416212@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191226154808.GA418948@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chris Down writes:
>diff --git a/fs/inode.c b/fs/inode.c
>index aff2b5831168..0df68367587b 100644
>--- a/fs/inode.c
>+++ b/fs/inode.c
>@@ -7,6 +7,7 @@
> #include <linux/fs.h>
> #include <linux/mm.h>
> #include <linux/backing-dev.h>
>+#include <linux/random.h>
> #include <linux/hash.h>
> #include <linux/swap.h>
> #include <linux/security.h>

Er, whoops. This was there for testing and somehow I missed it, I'll send v2 
without now.
