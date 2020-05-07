Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FCB1C9855
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEGRvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGRvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 13:51:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341BC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 10:51:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so3353324pfn.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6nsicqHKSLR08n1R+IXV8HH61Ez1sWv3K0CdRq6A4rw=;
        b=RrVQQPSNEjwXxIpxHMpeXgb/6SFvXrlHUGtWgKRpooc/AMiY7CyxeneurgMVsZo8T4
         rLft7rAMLxvk81jduk4p1OvVy7Ds+6FdlCoFjF4obUTG7NUio/81dR/EkXL7urAWPtiF
         OM+VRspJQyc+7FPnIWrzi3cHthVRonjBAFiOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6nsicqHKSLR08n1R+IXV8HH61Ez1sWv3K0CdRq6A4rw=;
        b=Gx0CIP+wZDh2qy92q4xcSLhs5UMWI+EffFqkthhklmz3B8KkViyILSQR+CAduJmgc7
         K+zFynnvshV1xvE1epxcY1s6DYWq1oxiGuSIo61vZbHson2YNj8Y/VA406gF47Y1D/W0
         uMi3OgQ+bmKOBxZzsQItyzM83ddhDPE3Ejr9/bcTHaMP089bdwVeHDc63bqYvN6UQa9H
         5LTclS5P3gzX6POSQ6MH/8KyqEDzW3FS3/vq4ulzJxQC6n5j3uRoPAdjQmVo2IHUtbgg
         5WzbX6ozMrVyqqQ4gfDwcGSbt7WBTd7hkVtk9QivqE9zZgchL5DlPxb36DaDA+wmu28Y
         hOsQ==
X-Gm-Message-State: AGi0PuYL9ZRnb/L3qVqHpM/9Faz7KVwoLX+zVG/0tdtBZJT/8Lkf760d
        vvVzJmRbml/JtluBRYUpb/p+yw==
X-Google-Smtp-Source: APiQypJrg795r4p3dlKKs5p5tJSGEr5TXh4b/RDvjDLBZG4ZsffQBKKTjPJNE6l8z2s2P5ajyKYDOw==
X-Received: by 2002:aa7:9dc7:: with SMTP id g7mr15195629pfq.291.1588873894492;
        Thu, 07 May 2020 10:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g25sm5314837pfo.150.2020.05.07.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:51:33 -0700 (PDT)
Date:   Thu, 7 May 2020 10:51:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        hannes@cmpxchg.org, minchan@kernel.org, mhocko@kernel.org,
        ying.huang@intel.com, yang.shi@linux.alibaba.com,
        gustavo@embeddedor.com, ziqian.lzq@antfin.com,
        vdavydov.dev@gmail.com, jason.zeng@intel.com, kevin.tian@intel.com,
        zhiyuan.lv@intel.com, lei.l.li@intel.com, paul.c.lai@intel.com,
        ashok.raj@intel.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC 21/43] x86/KASLR: PKRAM: support physical kaslr
Message-ID: <202005071049.2D0939137D@keescook>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 05:41:47PM -0700, Anthony Yznaga wrote:
> Avoid regions of memory that contain preserved pages when computing
> slots used to select where to put the decompressed kernel.

This is changing the slot-walking code instead of updating
mem_avoid_overlap() -- that's where the check for a "reserved" memory
area should live.

For example, this is how both mem_avoid_memmap() and the setup_data
memory areas are handled.

Is there a reason mem_avoid_overlap() can't be used here?

-- 
Kees Cook
