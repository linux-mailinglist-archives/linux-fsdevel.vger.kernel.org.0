Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04312F6AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 20:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbhANTUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 14:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbhANTUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:20:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC11C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 11:20:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id by1so3471849ejc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+3wq4HbMGsLz02vnWPc8X5CuisGBMzZ/msi7tDk0Cc=;
        b=Ejbyg26r3zoTbu/HIHrzEVIxt0cl9UJH08qjWjRc4XBuXSllW0qFGwSgwywiQSHZ5h
         4FqOy/ydMWnI2HrlO3dPBZzKUWBcuXLLYfKhjfx4G/JSQu6KnrB9yvIRHtvqQhrnjO/c
         Q+cDqa+FFwSB4Eapu1DD9AULDfdGLuLIg0ATKqDmOexsgyURGhcv6NK2mRFf12vKuJph
         x8O4v2ppPTGX6SU9HQZzVUnBlyCfXtV8uwWxYZvxiU6zNNLdCeFHp7wozNPnagosvioG
         CQaoSdekTAcqmzV0K2+4VQlY9nPupEwMvmVQCaAn6rpwZh/DzWZerH0ozYd3GIZDEUkm
         ijsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+3wq4HbMGsLz02vnWPc8X5CuisGBMzZ/msi7tDk0Cc=;
        b=t30nimLE9Gwe1kQ04CpX0cpbu4MhX7uelmFuHduANZ/reAvr83SAnRcbfVWk00chIJ
         ne+ibqfAYSDIFsf8DMe9JaF0WgDWmZgFUcevvChTUqVtvqn+cMABGjxKxT0RP4TaTPFD
         /CJonEL5lUGrCPpZLHF8pzY8M/2v4jKoMdJV1W3ZJRVZNxIsXTwntf7msv/ejWBJleMx
         rwIX25pgWa95qdJAl5O8REF3am4tzR49Vsto53GYR/c33dESy7BYvfATx3b4mGhjzqlV
         w2LhRZYt0n9NAg8oOPuNzxDAXcteDqdik4W5rLbuEI3s5ZgV3JXhpjU3cBmI4RYXGwpr
         WCBA==
X-Gm-Message-State: AOAM533wZcllU/xItm13ke9k2veEKB3uWnxab5E2sdOP+/ZtJYQxYsHL
        DyOhI+QQTVxmUx9EVrtjRspKpQ==
X-Google-Smtp-Source: ABdhPJzXhBB1ut7DH9GReY20YbQG7Em14PrgFXHUGeE5Nso5Glp1BpkZPapbWQqyPTktnpONnoHkIQ==
X-Received: by 2002:a17:906:f0d7:: with SMTP id dk23mr2565969ejb.131.1610652013255;
        Thu, 14 Jan 2021 11:20:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
        by smtp.gmail.com with ESMTPSA id j23sm2348324ejs.112.2021.01.14.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:20:12 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:20:07 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, posk@google.com,
        kyurtsever@google.com, ckennelly@google.com, pjt@google.com
Subject: Re: [PATCH] fs/proc: Expose RSEQ configuration
Message-ID: <YACZZ+wqRJutiEiy@google.com>
References: <20210113174127.2500051-1-figiel@google.com>
 <20210113213230.GA488607@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113213230.GA488607@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:32:30AM +0300, Alexey Dobriyan wrote:
> On Wed, Jan 13, 2021 at 06:41:27PM +0100, Piotr Figiel wrote:
> > For userspace checkpoint and restore (C/R) some way of getting process
> > state containing RSEQ configuration is needed.
> > +	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);
> %llx is too much on 32-bit. "%tx %x" is better (or even %08x)

Hi, many thanks for the suggestion. I applied this on v2,
https://lore.kernel.org/linux-fsdevel/20210114185445.996-1-figiel@google.com
I had to cast it via uintptr_t to cast-away the user address space
without warnings. Could you please take a look?

Best regards, Piotr.
