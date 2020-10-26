Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC10299CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 01:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437441AbgJ0ACQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 20:02:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411078AbgJZX4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:56:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id o7so6975632pgv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqqvkA3oKUwkO5eXRPOBy8lXyQg0CiUtokie2wwagwI=;
        b=ZWDgA8+yUlKx2dZgiyZDe66Bv6aQYo4o4sBrgULvsJ7L1mqryuSoN/tRsTLtRNf5gl
         QA5GzgrsJ4IIXk6KefYiWNloPp5dTgRya5PAi5H2X1Ck5liCNMZ9plZFbXAFJkRhGENX
         zRADl3Fzwzqt5UTeMExAEl9+J6C00UJYGVeM9r+kQpMj10I4tNzbDp+KUhpG26z8ohQ5
         u9LGW1VxEtuEY5uYo6W0qmYrYYX9WPLdyfh3K/l7hHXtbXds+UPAtJe/6QdzpKUrKNEa
         IHnev7OPcOoKpcEMuZBXfSj3e5H/bPp0SHxbMGuGbkkGN2ORlWbNlGQCKJOUg6Ub1kcx
         WOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqqvkA3oKUwkO5eXRPOBy8lXyQg0CiUtokie2wwagwI=;
        b=Tq1prFm8zTET9bYING982FrPF1eLHrqWLckIVkyiw024lNqq0eVxZLqP+RK0+oLKAX
         kr9/sRrC7keporYIrmFc5DFIVKw2+LkOReSbkOO537rwvryfo3jfMUjf58wXkcCXu1PN
         IfUkB+/h+l+SpYYpXL+C8qAPn1EsdYZb3F24JPvF6U+alrGNEoEcjbOqztVi+KDwYBzW
         lpyAeSBq5oTX1Sc/qULbswNG5juyIEjtej9S6Hz276GsmBqnlOGaF24GzGLmPi3WXdRg
         +CJEGjN2DNCfJrwjO52C/ZGWz2vN04AwtbM4BeTDOmQotJNt0Cvmap6a5x0Jf4OK31Vq
         1W4Q==
X-Gm-Message-State: AOAM530VyQd2HX1btw3nm+/fmfmiyCwIjpEPC6JLKg0HhdPjs7M7cUV0
        O+Pq1noZRyOmxB9PF8A2z9hoyw==
X-Google-Smtp-Source: ABdhPJzXWytxnG400Dp//klgHvFRu6jftuSrTTs7sW7oWyETnW8LM2mlLlQ2a53Jfzf5mLG9B/rX/w==
X-Received: by 2002:a63:5f42:: with SMTP id t63mr569296pgb.0.1603756574857;
        Mon, 26 Oct 2020 16:56:14 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s38sm3637009pgm.62.2020.10.26.16.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 16:56:14 -0700 (PDT)
Subject: Re: [REGRESSION] mm: process_vm_readv testcase no longer works after
 compat_prcoess_vm_readv removed
To:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Robert O'Callahan <robert@ocallahan.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70d5569e-4ad6-988a-e047-5d12d298684c@kernel.dk>
Date:   Mon, 26 Oct 2020 17:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/20 4:55 PM, Kyle Huey wrote:
> A test program from the rr[0] test suite, vm_readv_writev[1], no
> longer works on 5.10-rc1 when compiled as a 32 bit binary and executed
> on a 64 bit kernel. The first process_vm_readv call (on line 35) now
> fails with EFAULT. I have bisected this to
> c3973b401ef2b0b8005f8074a10e96e3ea093823.
> 
> It should be fairly straightforward to extract the test case from our
> repository into a standalone program.

Can you check with this applied?

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index fd12da80b6f2..05676722d9cd 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
 		return rc;
 	if (!iov_iter_count(&iter))
 		goto free_iov_l;
-	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
+	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
+				in_compat_syscall());
 	if (IS_ERR(iov_r)) {
 		rc = PTR_ERR(iov_r);
 		goto free_iov_l;

-- 
Jens Axboe

