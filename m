Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5829231729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 03:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgG2BUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 21:20:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45221 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgG2BUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:20:43 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so22806868iof.12;
        Tue, 28 Jul 2020 18:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eDz3jy7eZdANBgDM2Qg5Gfk+gkOF0GMv74gm4dMaCys=;
        b=DYxIhqM5r1lwQWn/oKu/GHM+beVzgKZcX8IUieyrIqTKyQf4ZOLZF0X9eHy+30/6D+
         V5b5rXdLxfMYaU4E3ti4rorDvefFn6zX42GgcLZ3rAcKm2OFY0awRai/XHS+t5d/dUB1
         K1SFjls1NDqpB5XdQUSdLlvEnRu+PQJXBMQ1NPnNCoRI9Xh1d+FvO7mQA8t4UT2zwrEL
         drWnuKc++9l6s1Hzst8AQyxUWRixeEJU6Enyw5z/RKXELH9cr0wsHcUQsrkPRg9WIQuN
         1IkMVebhRCBuQP4qRMlyAsEzoTcT+18PwgsAFa4tpT0tmpxvnOdMburq/NaIZnzYSJ4C
         0jpg==
X-Gm-Message-State: AOAM5324jdTQZPILmDKynnE9jmhuvKnUWBG1DUFEWfVmGedA9ZnINrFT
        1Uk6KXrimev8xL3AReTsvC0=
X-Google-Smtp-Source: ABdhPJxQtP3AbY1ZiLPwFZVneF2AYjP1sXAlks44gZ2Tff0nKrDE4/qcRVa12Or+ht+YuKGf2C1h3A==
X-Received: by 2002:a05:6602:24d5:: with SMTP id h21mr28941626ioe.108.1595985641893;
        Tue, 28 Jul 2020 18:20:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x185sm230006iof.41.2020.07.28.18.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:20:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F384D40945; Wed, 29 Jul 2020 01:20:39 +0000 (UTC)
Date:   Wed, 29 Jul 2020 01:20:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
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
Message-ID: <20200729012039.GN4332@42.do-not-panic.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <202005180820.46CEF3C2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005180820.46CEF3C2@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 08:21:08AM -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 08:37:42AM -0400, Mimi Zohar wrote:
> > Hi Christoph,
> > 
> > On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> > > On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> > > > On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > > > > Can you also move kernel_read_* out of fs.h?  That header gets pulled
> > > > > in just about everywhere and doesn't really need function not related
> > > > > to the general fs interface.
> > > > 
> > > > Sure, where should I dump these?
> > > 
> > > Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> > > of the file comment explaining the point of the interface, which I
> > > still don't get :)
> > 
> > Instead of rolling your own method of having the kernel read a file,
> > which requires call specific security hooks, this interface provides a
> > single generic set of pre and post security hooks.  The
> > kernel_read_file_id enumeration permits the security hook to
> > differentiate between callers.
> > 
> > To comply with secure and trusted boot concepts, a file cannot be
> > accessible to the caller until after it has been measured and/or the
> > integrity (hash/signature) appraised.
> > 
> > In some cases, the file was previously read twice, first to measure
> > and/or appraise the file and then read again into a buffer for
> > use.  This interface reads the file into a buffer once, calls the
> > generic post security hook, before providing the buffer to the caller.
> >  (Note using firmware pre-allocated memory might be an issue.)
> > 
> > Partial reading firmware will result in needing to pre-read the entire
> > file, most likely on the security pre hook.
> 
> Well described! :)

Since you're moving all this stuff, it woudl be good if you can add this
as part of new kdoc as well.

  Luis
