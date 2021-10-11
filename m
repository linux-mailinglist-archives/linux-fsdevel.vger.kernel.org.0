Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB34298BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 23:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhJKVTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhJKVTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:19:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848EC061570;
        Mon, 11 Oct 2021 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oHJKmsHD7penyk6OD1+g+sCSq0p6pDMGXXRqG5EFM2c=; b=h/sv7zpH5SRitkNKfrncMjc6+J
        LyoGPSyYNuJrXTemLutd74V6qekrmUKV0oY7yjjYyyQGJhekRcD4ptrgU/BKG8NpcfVwPfvBXrj2f
        BCuTVhE5zRs7TPR1VThprQ1Sn0D2E35Yv4+AQuGeNQY2fvKe5EGLAQIfqsSHQ3SUysdkE4oY+6ma6
        T/UY8u7j8hhNSY8lxlp48NwGVgU4RsLJJYNiX90cuLkPZE3yqFBUuRv8kNwtzGkVEiz8ffozZ2yCw
        UEqaT6pj2inuyQJnopCZC+YfY8YA5kK2kroSQdm6AkajSrfiGm78OJDH0/h+KIwo0ZzXWMX5hFBRL
        6y26P6rA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma2fK-00Ajc8-3G; Mon, 11 Oct 2021 21:16:58 +0000
Date:   Mon, 11 Oct 2021 14:16:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/12] kernel/module: add documentation for
 try_module_get()
Message-ID: <YWSpyrhK4PA6MFro@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-7-mcgrof@kernel.org>
 <202110051252.790B3F2F0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051252.790B3F2F0@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:58:47PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:37:59AM -0700, Luis Chamberlain wrote:
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index c9f1200b2312..22eacd5e1e85 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -609,10 +609,40 @@ void symbol_put_addr(void *addr);
> >     to handle the error case (which only happens with rmmod --wait). */
> >  extern void __module_get(struct module *module);
> >  
> > -/* This is the Right Way to get a module: if it fails, it's being removed,
> > - * so pretend it's not there. */
> > +/**
> > + * try_module_get() - yields to module removal and bumps refcnt otherwise
> 
> I find this hard to parse. How about:
> 	"Take module refcount unless module is being removed"

Sure.

> > + * @module: the module we should check for
> > + *
> > + * This can be used to try to bump the reference count of a module, so to
> > + * prevent module removal. The reference count of a module is not allowed
> > + * to be incremented if the module is already being removed.
> 
> This I understand.
> 
> > + *
> > + * Care must be taken to ensure the module cannot be removed during the call to
> > + * try_module_get(). This can be done by having another entity other than the
> > + * module itself increment the module reference count, or through some other
> > + * means which guarantees the module could not be removed during an operation.
> > + * An example of this later case is using try_module_get() in a sysfs file
> > + * which the module created. The sysfs store / read file operations are
> > + * gauranteed to exist through the use of kernfs's active reference (see
> > + * kernfs_active()). If a sysfs file operation is being run, the module which
> > + * created it must still exist as the module is in charge of removing the same
> > + * sysfs file being read. Also, a sysfs / kernfs file removal cannot happen
> > + * unless the same file is not active.
> 
> I can't understand this paragraph at all. "Care must be taken ..."? Why?

Because the routine try_module_get() assumes the struct module pointer
is valid for the entire call. That can only be true if at least one
reference is held prior to this call.

> Shouldn't callers of try_module_get() be satisfied with the results?

Yes but only with the above care addressed.

> I don't follow the example at all. It seems to just say "sysfs store/read
> functions don't need try_module_get() because whatever opened the sysfs
> file is already keeping the module referenced." ?

That is exactly what I intended to clarify with that example, yes, a
reference is held but this is done implicitly. *If* a kernfs op is
active module removal waits for that active reference to go down. So
while a kernfs file is being used it is simply not possible for the
module to disappear underneath us. And the reason is that the module
that created the sysfs file must obviously destroy that same sysfs file.
But since kernfs ensures that sysfs file cannot be removed if a sysfs
file is being used, this implicitly holds a module reference.

Let me know if y ou can think of a better way to phrase this.

> > + *
> > + * One of the real values to try_module_get() is the module_is_live() check
> > + * which ensures this the caller of try_module_get() can yield to userspace
> > + * module removal requests and fail whatever it was about to process.
> 
> Please document the return value explicitly.

Sure thing.

  Luis
