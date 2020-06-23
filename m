Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B70D206821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 01:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgFWXNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgFWXNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:13:52 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA030C061573;
        Tue, 23 Jun 2020 16:13:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so175865qkg.5;
        Tue, 23 Jun 2020 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+1p2mclyR0lfU/92KynyV/hto6Q//eZlxOYZJAVpWo=;
        b=geuFFUr3+h96lNJq2jfjxCNm4/1+y5e+iBsysgZ1OalJqcN0IFyEMJIfCzvlPRq3bw
         6+vHXO/pbyrw37z3DsErSTr0GaUttxeVS3xpzAIwqrvzOia2l+UxdmbKiOcq5UwroWp7
         WKP+wPYO1DvLHUICBB5IA4TN37zdoqjKnq2gMn8Fsdj7som+7PAixMSxD+Br1NuU3Ej5
         p/BBY0TCVj8oZsRhC1xAa1sL1ONggi++YOBwviHIRApMANsneQaThAjVCn5RDMGo7+Qf
         6b1GlKrrbkm7EWZM2rmx4PhqOKUFRUF85xRFxy+VjmlB9Oxz2RhDBT0gnDVe/palJxHo
         OnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7+1p2mclyR0lfU/92KynyV/hto6Q//eZlxOYZJAVpWo=;
        b=nObfUFFSNQyTpUZ+C9UU7Fa4kSe9sOBccEr6ckff5/t9q3TuPAGdBb6L5DfxqpBO50
         TsjyST/ewIaOaaYvcPK7zdbcMD57EbmpUgTZ0Tf1nooY4ZVYkBnEpmjvDonAIJItxLLD
         Ee44v5nzFvyHun+UiK6fEZxWCulXFvhl8LhCB2AZISG3P/1cR5iEC4U+5GOzNFAaLucf
         JOW7CQtl3I81s2+PAHwROWmkODgltXIruhk5j7Beo2Y/6jLILgqN28cPkTQ6SOnBE7lS
         G0yDnpQMQ55E+6XWBkWqn5ETXAKOUnN352HpwZkyJIVWhjQwXFN7DiCjMFERg75Fq70L
         fkVQ==
X-Gm-Message-State: AOAM533fLgxoFggN3H7NmHEDOl3TAXbFf1vL0mGbrseyMTE/o3KNjrKr
        tKFr2/rhXTVBB78oUhu59As=
X-Google-Smtp-Source: ABdhPJxJewiReujBdDg+I1QnTrOCMNrukNot2OLRnDJkFJlhcqD5N7RvZVyB/MRf1AzoKDFQqJEaoA==
X-Received: by 2002:a37:a08:: with SMTP id 8mr23082871qkk.388.1592954030804;
        Tue, 23 Jun 2020 16:13:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:896d])
        by smtp.gmail.com with ESMTPSA id t36sm2036714qtj.58.2020.06.23.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:13:49 -0700 (PDT)
Date:   Tue, 23 Jun 2020 19:13:48 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200623231348.GD13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
 <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Rick.

On Mon, Jun 22, 2020 at 02:22:34PM -0700, Rick Lindsley wrote:
> > I don't know. The above highlights the absurdity of the approach itself to
> > me. You seem to be aware of it too in writing: 250,000 "devices".
> 
> Just because it is absurd doesn't mean it wasn't built that way :)
> 
> I agree, and I'm trying to influence the next hardware design. However,

I'm not saying that the hardware should not segment things into however many
pieces that it wants / needs to. That part is fine.

> what's already out there is memory units that must be accessed in 256MB
> blocks. If you want to remove/add a GB, that's really 4 blocks of memory
> you're manipulating, to the hardware. Those blocks have to be registered
> and recognized by the kernel for that to work.

The problem is fitting that into an interface which wholly doesn't fit that
particular requirement. It's not that difficult to imagine different ways to
represent however many memory slots, right? It'd take work to make sure that
integrates well with whatever tooling or use cases but once done this
particular problem will be resolved permanently and the whole thing will
look a lot less silly. Wouldn't that be better?

Thanks.

-- 
tejun
