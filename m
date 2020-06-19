Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3D20113D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbgFSPis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405031AbgFSPih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:38:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB11C06174E;
        Fri, 19 Jun 2020 08:38:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c185so9310260qke.7;
        Fri, 19 Jun 2020 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDsiCr50KHpvcCpO0nUudPI1dP66NxE/zmDA74OV+SQ=;
        b=W2kw6LlHwZt19yql7h4ub2wb8X0IY0e+1i5N4AL4XUjcJvVeVp3YsvEAVfGIgM4lZ6
         UHwZvje1K2zuJ6grTj9+kJmE4QPj9xfa6thkJEEjipTQzC5E80gdAY9/vap9znOfauSs
         W8YyuYpxuh5TuUlohv7P4RC5+nF9dw7mCLg8VSj7pBvWxVD+C9tJFbqdqOUeAFeWxszN
         a5P6UKE7d7WUwrxSqrzEC32ei1M6kitWCQs52yWgGgwi6ZO4TE+6tBVNySQIA4tslO5C
         otPlsDK/47Mo7ZPWV/mj5aw4mpfyj6ibUYhZ18NRNH0wUQmRa8mEpl6pGL23RAuXAuyE
         Bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xDsiCr50KHpvcCpO0nUudPI1dP66NxE/zmDA74OV+SQ=;
        b=MbA5IexONyUMfXFTyQW9J429xMgKxhrTQVxn0OE/4dDq6P82BrUwXH7Wbe654ZLESp
         900v0nq4znQwWy/jZHRnCfYijv0v8mi4zX8shja0nTfsqjBHvGvoh32HOfy1W1/3z35C
         cVE59bDBygVp8OScC8VI1/IwQNxf5hIV9IwFbxUZmn1wyD4yUyS7AOUQEUjPSfW1zJhh
         7zqq2wylAxk8k+F/UD27gRu3WY4CDYInUabtACYdsznM+rWeKjRraP6a4kxVOuGlwxPr
         z70B6BFkkrXxbEvTKyTAlielGElbOFrxMGJnENKkB6/a+OmbVDHwMIw/zzelkE6ZV7qY
         vn1g==
X-Gm-Message-State: AOAM533gU1xQj2J0GPPIOL8tn6GzaUZ4So/MuAdTgfaHYrMrCUV3cwK+
        g/759/0Lk97ifw8tXBk6TDc=
X-Google-Smtp-Source: ABdhPJwTaHYw+/QMBJOOvL1dRABq9I9lwQlVbVLTvWAVyCxF+jAlFuH4heIR+Y3rCx8ivtN1SaNSYQ==
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr3822901qkm.283.1592581115643;
        Fri, 19 Jun 2020 08:38:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:736f])
        by smtp.gmail.com with ESMTPSA id h19sm6874625qkj.109.2020.06.19.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:38:34 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:38:33 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200619153833.GA5749@mtj.thefacebook.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Ian.

On Wed, Jun 17, 2020 at 03:37:43PM +0800, Ian Kent wrote:
> The series here tries to reduce the locking needed during path walks
> based on the assumption that there are many path walks with a fairly
> large portion of those for non-existent paths, as described above.
> 
> That was done by adding kernfs negative dentry caching (non-existent
> paths) to avoid continual alloc/free cycle of dentries and a read/write
> semaphore introduced to increase kernfs concurrency during path walks.
> 
> With these changes we still need kernel parameters of udev.children-max=2048
> and systemd.default_timeout_start_sec=300 for the fastest boot times of
> under 5 minutes.

I don't have strong objections to the series but the rationales don't seem
particularly strong. It's solving a suspected problem but only half way. It
isn't clear whether this can be the long term solution for the problem
machine and whether it will benefit anyone else in a meaningful way either.

I think Greg already asked this but how are the 100,000+ memory objects
used? Is that justified in the first place?

Thanks.

-- 
tejun
