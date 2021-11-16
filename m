Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882AA45356C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 16:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhKPPPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 10:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbhKPPOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:14:49 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E46C061210
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 07:10:09 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so33177058otg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h8Omxm4xqc6jwoRuPqU9qRmRmi/pNMQ+rX4CNoWq/EM=;
        b=Qp840mvjSc9WNEz9L8FDt4ySM5YLVFCuwXozOQA4eZFRaO7uYHM2A51LjrZrXirrL/
         rmuFnmthTgHbKDmT1c+MRZXrA/N666JhftascLOxjTvnsh14RTPxk6Tc/+bczvPARpn+
         S918xdL9SO6xlH6gOr4eNePt5vPg84wjg3K4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h8Omxm4xqc6jwoRuPqU9qRmRmi/pNMQ+rX4CNoWq/EM=;
        b=4gC1YlHBDNScLu1J47u5siFhipFAHry7lXZzqUBFPL/kL4aq1TUEyjgqc+em4yM1GT
         mMXonwCekkoz7vnHmeG98MyFeol17SrwCkDFEDN3rPmBzwMdU/zB+QbH9MlT0CgBvV30
         SUCW5Vwk+eQ9qY3LJa6kpzS7sxvXgcvumgmD6PYA1D5YjKChigVQGfSfdplGReYyjlMW
         91+8uSiJiBkfKd/9HPJ4jtUsfYZ1ERF7VvkTGkj9h/rHeL4Y7kbYP75D/mS8Si0hU8Ii
         tiVwwksCWM3FoEXzOZBDoc1FffQByi/7Z5KS2ivV8ix9ykVk+73nmWrt/LmsvTJ7l+jV
         6/+A==
X-Gm-Message-State: AOAM530eAfmvANlBnWeQ4LlMO5GhoHraIQVANxwm6gzCFD4OjgEIyLCU
        LRQ+Yj+K+nA7Vy/9OGgEZzvFjDJvzDgXLA==
X-Google-Smtp-Source: ABdhPJxIUiLid61k9x1Lrguy5Vo32EsPV8M/2G8+fpiur+VFrqdkUhJmNEopFpRHU7w22AtWPAVQrg==
X-Received: by 2002:a05:6830:2681:: with SMTP id l1mr6816771otu.378.1637075408807;
        Tue, 16 Nov 2021 07:10:08 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:bbdd:cf7a:d087:403])
        by smtp.gmail.com with ESMTPSA id u28sm3720721oth.52.2021.11.16.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:10:08 -0800 (PST)
Date:   Tue, 16 Nov 2021 09:10:06 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@digitalocean.com>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: handle circular mappings correctly
Message-ID: <YZPJziiW0TcrszKJ@do-x1extreme>
References: <20211109145713.1868404-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109145713.1868404-1-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 03:57:12PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> When calling setattr_prepare() to determine the validity of the attributes the
> ia_{g,u}id fields contain the value that will be written to inode->i_{g,u}id.
> When the {g,u}id attribute of the file isn't altered and the caller's fs{g,u}id
> matches the current {g,u}id attribute the attribute change is allowed.
> 
> The value in ia_{g,u}id does already account for idmapped mounts and will have
> taken the relevant idmapping into account. So in order to verify that the
> {g,u}id attribute isn't changed we simple need to compare the ia_{g,u}id value
> against the inode's i_{g,u}id value.
> 
> This only has any meaning for idmapped mounts as idmapping helpers are
> idempotent without them. And for idmapped mounts this really only has a meaning
> when circular idmappings are used, i.e. mappings where e.g. id 1000 is mapped
> to id 1001 and id 1001 is mapped to id 1000. Such ciruclar mappings can e.g. be
> useful when sharing the same home directory between multiple users at the same
> time.
> 
> As an example consider a directory with two files: /source/file1 owned by
> {g,u}id 1000 and /source/file2 owned by {g,u}id 1001. Assume we create an
> idmapped mount at /target with an idmapping that maps files owned by {g,u}id
> 1000 to being owned by {g,u}id 1001 and files owned by {g,u}id 1001 to being
> owned by {g,u}id 1000. In effect, the idmapped mount at /target switches the
> ownership of /source/file1 and source/file2, i.e. /target/file1 will be owned
> by {g,u}id 1001 and /target/file2 will be owned by {g,u}id 1000.
> 
> This means that a user with fs{g,u}id 1000 must be allowed to setattr
> /target/file2 from {g,u}id 1000 to {g,u}id 1000. Similar, a user with fs{g,u}id
> 1001 must be allowed to setattr /target/file1 from {g,u}id 1001 to {g,u}id
> 1001. Conversely, a user with fs{g,u}id 1000 must fail to setattr /target/file1
> from {g,u}id 1001 to {g,u}id 1000. And a user with fs{g,u}id 1001 must fail to
> setattr /target/file2 from {g,u}id 1000 to {g,u}id 1000. Both cases must fail
> with EPERM for non-capable callers.
> 
> Before this patch we could end up denying legitimate attribute changes and
> allowing invalid attribute changes when circular mappings are used. To even get
> into this situation the caller must've been privileged both to create that
> mapping and to create that idmapped mount.
> 
> This hasn't been seen in the wild anywhere but came up when expanding the
> testsuite during work on a series of hardening patches. All idmapped fstests
> pass without any regressions and we add new tests to verify the behavior of
> circular mappings.
> 
> Fixes: 2f221d6f7b88 ("attr: handle idmapped mounts")
> Cc: Seth Forshee <seth.forshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: stable@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

This looks right to me.

Acked-by: Seth Forshee <sforshee@digitalocean.com>
