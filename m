Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9231D9F06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgESSRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 14:17:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4BC08C5C0;
        Tue, 19 May 2020 11:17:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so460024wrn.6;
        Tue, 19 May 2020 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9i8fE9UcQoMjC7gZk0f5UIj2Ufp+6XHlfmp4ao/4O3I=;
        b=M0B7KgpZsBQt4E5X8OxXyD2yTNZWolR2/f+H8u41fyIpqXTQ/IBkg+PIk5pQaf9vVM
         B7FvAhfWR1Ys+m0PgvW4bYZdhRkSN72vW+NPWuFXNjOut7tyAU1zAhCgo0t/tzzyScxo
         7v428tVbz9c1onq0wHUsVOODP7mwAeG57d5EcWSgVjstv5AnNaRYDSg+IpUshqa4jCi0
         ZY2uUsdYSopy9gG2dy9+JsJkNabpMVOrmLEYO8GpjMhHzvTmmQ5E1cffTvmnVK3bJfol
         dRf+5Rb+dfJpS7ZkbpmYXVwTnfBgs42KLrH5bAIpl7PIt9yglAJbH2e4ykXBWz8d9oL3
         neqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9i8fE9UcQoMjC7gZk0f5UIj2Ufp+6XHlfmp4ao/4O3I=;
        b=mFW6msmY4FYrToxgnLx8a5szJiSSh2psvYSGOO4BXmOi/k1Zwl6+TeSuLPTuD518Ac
         oXJrC8+woD3ilShbWN84gpxt6NgHiSeybgCpqe283sm7vQEGxIURAoJfMCtgTfynBhfK
         7yTnZknBpBQ0kjIssBmAPu7JSM6xfcpb7jShdB+Zi6XOUj6VpId67gXGZhI8145WQeMM
         WRAhEj8RlURPIOW7lsC6btbGq33bfs+os/CS4IOd6qrfGl3CUi3B+/Dbc8ll5XJnSpjR
         XgzDEit32QEeeGfk6E1cl6LJQ7tS77KhIqrUJA48QzJCKSLC0esg3MFy8OuO8fPJ6o33
         Jzyg==
X-Gm-Message-State: AOAM530W7GTnNqbAEIJm/vMGRn3QWhybP5ifeYRAq80Xx6PFkHbBMHh6
        KxSGui0euEg7A0Rsa/IWnS4=
X-Google-Smtp-Source: ABdhPJyxXQek9kmfiklyRswq34puGT0/qkq70Y1A0X+1ql8Y7CIbt8KUIclIUmKsIVrJHd1bSQywiA==
X-Received: by 2002:adf:b301:: with SMTP id j1mr148805wrd.221.1589912236198;
        Tue, 19 May 2020 11:17:16 -0700 (PDT)
Received: from dumbo ([185.220.101.209])
        by smtp.gmail.com with ESMTPSA id d4sm250548wre.22.2020.05.19.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:17:15 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jb6ni-0004ND-0s; Tue, 19 May 2020 20:17:14 +0200
Date:   Tue, 19 May 2020 20:17:13 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] hibernate: restrict writes to the snapshot device
Message-ID: <20200519181713.GB1963@dumbo>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200507080456.069724962@linux.com>
 <20200507080650.439636033@linux.com>
 <CAJZ5v0jnfeAQ4JDz+BTZp8P98h6emTizGWLYNL_QtbQ=3Nw03Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jnfeAQ4JDz+BTZp8P98h6emTizGWLYNL_QtbQ=3Nw03Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 05:59:15PM +0200, Rafael J. Wysocki wrote:
> It would be better to paste the patch instead of attaching it.

Done with v2.

> Anyway, note that the snapshot special device is not the target block
> device for saving the image, so it would be good to avoid that
> confusion in the naming.

I realize that it was a bit hazy in my head as well. It should be fixed
in v2.

> 
> I.e. I would rename is_hibernate_snapshot_dev() to something like
> is_hibernate_image_dev() or is_hibernate_resume_dev() (for consistency
> with the resume= kernel command line parameter name).

Done as well.

> Thanks!

Thank you!

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
