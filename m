Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A1207449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgFXNTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgFXNTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:19:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B0C061573;
        Wed, 24 Jun 2020 06:19:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l17so1707360qki.9;
        Wed, 24 Jun 2020 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9PH2bXbKT4/vlzv/t3aa9HSoEpEteRDNZADkykIJbk=;
        b=J+rDM/27ebpHPpHj7FAYq7/0qxGqNAbak5b5IF/bxyZLq7iNX2lhgeqXdBt2b/AmBU
         Xn96KI5GI6lLirjXlQKZ61zDEXxXRgGX7xw6utBMFxaNYcfRgN6qy+YTiAF24QBLn1Oy
         2KonAUUiFT3Temc1ZAykdeGlx+cscnEEbiCoA/POjRoINkkP5f5ZzxVLSjv2EzuhOtH4
         qZgK62n5YSMNnmfBTG1GkejeSpd7v88TAYiSQULdg3F3NMijoLcRiFPikv0Gj9Rx9rqr
         W7KWcCyiJhphbawLZo3m8ZceCHYDQqgjaXKE21KAQROnIDi5g/RCHFke+yAl9CaSrU2y
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=x9PH2bXbKT4/vlzv/t3aa9HSoEpEteRDNZADkykIJbk=;
        b=l2qG0PicTU6kxIvvM/c528YL/vkVWFwqW7B88YU3GAZFOygwsFuiMVeJ+j1UbtCttt
         PYt+i+5Jvx4J/VySc/Roy7LEpRXuRcIV9J2L+xGLBsGZS1KHtFvfLddb649S0OTV9f7t
         x6fb/8E0fXcMDaQFE/2gYXqmNalhM61yPyj6CBD/d7mRqWWuoJYXMYu7wpc1TuMYkmQ1
         LKBxKq2ImYu5kI0abFqhkGpadW0N/0yTbPu8haH4FxezkvOVDgq437OlKdbthOyQ24/s
         yRjZ2b4OVdF9hy5rUykmBw5uKW1a2yHKFRXinA9q5/RhhkAEVPoxX5BDFVDieKR7QWdn
         m2/A==
X-Gm-Message-State: AOAM530O0DD5RB+2/Wo/nf7yastyFsHT0wojRJpOYlybE6O8eYKET3zB
        69Ijt5EUgl15GRZzgVJIM1s=
X-Google-Smtp-Source: ABdhPJwgfDfzL4KN09swypIuIKZfgsqYZMxaPOwShr4D1CtwLzc6yPm7uRLlj8lP8jvmUBf2E8jJkg==
X-Received: by 2002:a37:649:: with SMTP id 70mr11096963qkg.306.1593004750118;
        Wed, 24 Jun 2020 06:19:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:95ca])
        by smtp.gmail.com with ESMTPSA id u7sm3207827qku.119.2020.06.24.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 06:19:09 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:19:08 -0400
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
Message-ID: <20200624131908.GE13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
 <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
 <20200623231348.GD13061@mtj.duckdns.org>
 <a3e9414e-4740-3013-947d-e1839a20227c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e9414e-4740-3013-947d-e1839a20227c@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Rick.

On Wed, Jun 24, 2020 at 02:04:15AM -0700, Rick Lindsley wrote:
> In contrast, the provided patch fixes the observed problem with no ripple
> effect to other subsystems or utilities.
> 
> Greg had suggested
>     Treat the system as a whole please, don't go for a short-term
>     fix that we all know is not solving the real problem here.
> 
> Your solution affects multiple subsystems; this one affects one.  Which is
> the whole system approach in terms of risk?  You mentioned you support 30k
> scsi disks but only because they are slow so the inefficiencies of kernfs
> don't show.  That doesn't bother you?

I suggest putting honest thoughts into finding a long term solution instead
of these rhetorical retorts. If you really can't see how ill-suited the
current use of interface and proposed solution is, I'm not sure how better
to communicate them to you.

Thanks.

-- 
tejun
