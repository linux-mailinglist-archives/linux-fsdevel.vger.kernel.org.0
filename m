Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9813F3F69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhHVNHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:07:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600EEC061575;
        Sun, 22 Aug 2021 06:06:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e3so5379838qth.9;
        Sun, 22 Aug 2021 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AO2vYzEIpFA2ngEOqBjFt3qA4tM8xVi9sIC0rKjgW5Q=;
        b=t0//sk3C3QSgrB53iNaKT0G4fhoVzKZPu41TosVInwpCL6mohmREGf07eugKZcFbGB
         4ZUCZHxxokwRcWwpAUy8ic9z10/NbVY/Mfz7kul9QAJZdUBA33faZ7POO12etqta6upD
         /3Va4EdRGRcyzT1ACFNV4o+oG4LTTKHfBmzfUpJihIXF6WaRJXGRdqjW85xv9VbIDMgA
         8icU8OXDDjs/gl3MtxH2oB+LleFcx7giGy6OqtsjHwWLmudgHNkahE6lTINM1vvSIrv7
         yv4lg8SxggHQP+Vy47yK9IRiwA2v1HDzkhpZN91QRkSsOD28KdzwolER1lyRWiUlenn8
         BOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AO2vYzEIpFA2ngEOqBjFt3qA4tM8xVi9sIC0rKjgW5Q=;
        b=tP7xsHWv46XI3JnSbxayKp6LzoXMei5cUcySw03lLGtS+A5L9/aLrXTQVKdpQ/MkQL
         ZQrIb6d5TLKVDmbFpP+QfUwQrFqu3i/d76T+HSc3NFJAKdno5ZDobPc/uS0YMJM+RQzg
         ADkYrKXzLe0R0kU5Vty9NXmA4z4Vutr4gBPvEZuXUaOS49nv/ROPy/wAhTZK+Edu+WTK
         z3oAg/zlCsxgG+Vr9Ek5GpzeZujQiNBnEbkXQyO7TlahSqRrsnmgKf1Dre84yvvbd4u/
         rwwe+FBq7EZ1oPH4J8A88pchwOFTTpaGEuR6E0eAqu3pU7y2kiNKUV/oYR6az6tr4FQt
         DXKQ==
X-Gm-Message-State: AOAM533KFh/fbQeVKW2wFkliTRCxGFm0tJBIk5ANn9/CgTnVeIP3Rk0f
        ulWA7TGeiszurP51odYF9RlsH0JZYA8=
X-Google-Smtp-Source: ABdhPJzk/N5szMfprGt82NQeXKqANfdEg2AenBVGEUqhGfhztQaAo+D4SJb/rWfbD+Z2uUUMsiAjSw==
X-Received: by 2002:ac8:53d8:: with SMTP id c24mr25483905qtq.280.1629637594434;
        Sun, 22 Aug 2021 06:06:34 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l67sm6298675qkd.110.2021.08.22.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:06:33 -0700 (PDT)
Date:   Sun, 22 Aug 2021 06:06:30 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     christian.brauner@ubuntu.com, jamorris@linux.microsoft.com,
        gladkov.alexey@gmail.com, yang.yang29@zte.com.cn, tj@kernel.org,
        paul.gortmaker@windriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: prevent mount proc on same mountpoint in one pid
 namespace
Message-ID: <20210822130630.GA39585@www>
References: <20210821083105.30336-1-yang.yang29@zte.com.cn>
 <YSEJSKgwNKqGupt/@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSEJSKgwNKqGupt/@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 21, 2021 at 02:10:16PM +0000, Al Viro wrote:
> On Sat, Aug 21, 2021 at 01:31:05AM -0700, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Patch "proc: allow to mount many instances of proc in one pid namespace"
> > aims to mount many instances of proc on different mountpoint, see
> > tools/testing/selftests/proc/proc-multiple-procfs.c.
> > 
> > But there is a side-effects, user can mount many instances of proc on
> > the same mountpoint in one pid namespace, which is not allowed before.
> > This duplicate mount makes no sense but wastes memory and CPU, and user
> > may be confused why kernel allows it.
> > 
> > The logic of this patch is: when try to mount proc on /mnt, check if
> > there is a proc instance mount on /mnt in the same pid namespace. If
> > answer is yes, return -EBUSY.
> > 
> > Since this check can't be done in proc_get_tree(), which call
> > get_tree_nodev() and will create new super_block unconditionally.
> > And other nodev fs may faces the same case, so add a new hook in
> > fs_context_operations.
> 
> NAK.  As attack prevention it's worthless (you can just bind-mount
> a tmpfs directory between them).  Besides, filesystem does *not*
> get to decide where it would be mounted.  Especially since it couldn't
> rely upon that, anyway, what with mount --bind possible *after* it had
> been initially mounted.

Thanks for your relpy! No doubt anymore.
