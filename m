Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9282E5F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE2UQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:16:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44717 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfE2UQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:16:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so522661pgp.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=byH71jcEnWiZocWjFrPDlTMOE7pd8EPRHoYGyukaY04=;
        b=bwKrSUcAFY5li8JHROxevBRkVdZvfftmbN2jvX4D8l/n4Q/b0ePv+zprqpG2KluSLn
         rSYJBFUhtygfnfgM4xMNPYR/Vp/NGpVKFovwEIHmtk8emThGP6iRNZH+rg7exn2dW3QV
         qTeu7YoFimL+W4CSITeRLNxas0G8YpYTWwbHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byH71jcEnWiZocWjFrPDlTMOE7pd8EPRHoYGyukaY04=;
        b=ivFnJyfNBBoiAk9JEhVysLwOe26fDQzYZA9S0FaDc+x4WQGGSbmYEp2JqDVUBljc9O
         YS1xuA4V2UPD43BSM330Gx113rDtHdpD23lOQSSA6vnAHfGJwcV4tTzxvH5hYoB5cBaG
         QpqUHKSnUd5ny4Dfksn04FnpC4jh6GeQusBnttPW504NzuYsQ71G/WY7rnhYykkurSbW
         4MKGWdRmRZ7ZiASj9hatfXhe7P8/MdeelAQoxGvdNWWWwyj4/Yiq2hQ/cmXeoQ0Nx9jb
         EtLfr+O4j0ECLM5TkPnn0IgcY/eOd4ytp0cCH3FSz5Inxl8V+fXzzQ4gDLGxbjlei2PT
         eGbQ==
X-Gm-Message-State: APjAAAW7YXKUQWlI/GQ4knra5Hd0X92H43mmLfBn72ui+2yB3iqqLNzG
        e+QLchiNOoRABrw5nXlZYk35pw==
X-Google-Smtp-Source: APXvYqwOtLbXvQF12v2iQzcTzlTPHXYwr/VbPiH/+9zX0lzSfnaAmA5ZoEnSGfNESsFHQ7AnnjhQoA==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr139393871pgk.225.1559160971649;
        Wed, 29 May 2019 13:16:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm227693pgm.22.2019.05.29.13.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:16:10 -0700 (PDT)
Date:   Wed, 29 May 2019 13:16:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/14] Provide generic top-down mmap layout functions
Message-ID: <201905291313.1E6BD2DFB@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-1-alex@ghiti.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:32AM -0400, Alexandre Ghiti wrote:
> This series introduces generic functions to make top-down mmap layout
> easily accessible to architectures, in particular riscv which was
> the initial goal of this series.
> The generic implementation was taken from arm64 and used successively
> by arm, mips and finally riscv.

As I've mentioned before, I think this is really great. Making this
common has long been on my TODO list. Thank you for the work! (I've sent
separate review emails for individual patches where my ack wasn't
already present...)

>   - There is no common API to determine if a process is 32b, so I came up with
>     !IS_ENABLED(CONFIG_64BIT) || is_compat_task() in [PATCH v4 12/14].

Do we need a common helper for this idiom? (Note that I don't think it's
worth blocking the series for this.)

-Kees

-- 
Kees Cook
