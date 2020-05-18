Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22631D7CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgERPVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgERPVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 11:21:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E7C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 08:21:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f23so4984917pgj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8eIa0Vhcalrg30hExhgbFyLNmHPU3sV6rgHITb5pZ5w=;
        b=htaIZ7s8kHdd9JhXfpJr62T+PbcWV0P9HH48JxCHos2qCOwdAffTSsVfouROZN6Mcx
         OsT1n9x1239rkbG6hdpojAEmxPN0Ini8eKc3MOs0rk/oWTZl1F9JjZbGrWGPiJf+w5zL
         YtiyZ9HL2YUsIAekksROIFa5+16FSNv2M8/J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8eIa0Vhcalrg30hExhgbFyLNmHPU3sV6rgHITb5pZ5w=;
        b=ma1Z21brnvLlN8t7Ag8dphpMJGxkF2G7qHhHIZYwaungv0G1OuHuFR54y1DdpCHMWs
         9WokkjySByxhJ0tDmElL8NpoAGvg8iFtOyJILc9TRYa1zECsy7MtbCojrfUz8PkWmni+
         eEnKzBNv7mqDfolysyqAUjfi90nMfUhoHspf0WJ1rI/0oecFpJ0KlIVWwojL4ft1M8Iw
         IWWO8NZupSH3kTbt9Oszpq1xQ4lpBYf1HE/gWR1SdbKR0c1Hz00f6AGTslZVkxtNpK84
         sXt6hoD1uY0kMnpPFO9CXdlMMj1QAR7NX6QO3tv7dfSrDUrxDEAXDBA4fvpCxWnKIU9q
         SdhA==
X-Gm-Message-State: AOAM5314XyJZpXJqbLisTeb8tGBqr2Lj/tvjyTEXox57xycV7DYf2Wkq
        DdtEAJMiKzDdfw1WsAoxwqGcFA==
X-Google-Smtp-Source: ABdhPJzV/8/H/dtCPYbOvT1/Nbv8m+JVx3a0WuH1CfwiIsZx/wce2vLAkKKd/khb6PmDQ5vsnT0fng==
X-Received: by 2002:a63:1415:: with SMTP id u21mr15114423pgl.366.1589815270596;
        Mon, 18 May 2020 08:21:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm6207978pgg.17.2020.05.18.08.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:21:09 -0700 (PDT)
Date:   Mon, 18 May 2020 08:21:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <202005180820.46CEF3C2@keescook>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589805462.5111.107.camel@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 08:37:42AM -0400, Mimi Zohar wrote:
> Hi Christoph,
> 
> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> > On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> > > On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > > > Can you also move kernel_read_* out of fs.h?  That header gets pulled
> > > > in just about everywhere and doesn't really need function not related
> > > > to the general fs interface.
> > > 
> > > Sure, where should I dump these?
> > 
> > Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> > of the file comment explaining the point of the interface, which I
> > still don't get :)
> 
> Instead of rolling your own method of having the kernel read a file,
> which requires call specific security hooks, this interface provides a
> single generic set of pre and post security hooks.  The
> kernel_read_file_id enumeration permits the security hook to
> differentiate between callers.
> 
> To comply with secure and trusted boot concepts, a file cannot be
> accessible to the caller until after it has been measured and/or the
> integrity (hash/signature) appraised.
> 
> In some cases, the file was previously read twice, first to measure
> and/or appraise the file and then read again into a buffer for
> use.  This interface reads the file into a buffer once, calls the
> generic post security hook, before providing the buffer to the caller.
>  (Note using firmware pre-allocated memory might be an issue.)
> 
> Partial reading firmware will result in needing to pre-read the entire
> file, most likely on the security pre hook.

Well described! :)

-- 
Kees Cook
