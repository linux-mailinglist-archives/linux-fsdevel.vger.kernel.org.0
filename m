Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA96C7785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCXFwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXFwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:52:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944ADBE8;
        Thu, 23 Mar 2023 22:52:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-503e7129074so27623a12.0;
        Thu, 23 Mar 2023 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679637136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+nHbDgNlg7sUA7QNCABsdxPp+66d6lY+QYGpnTvvxM=;
        b=VVgsI1XFwPwPlRwCBkQ4XjJ+m0Jr+l72bCNWn37y+KnHSOJ7jNlT0R23sHTpW7rAg7
         pv2aqJlwqxpZYQQ7ZKx0J4fabCfIKv56fQci30ctgHLn611s/nFiQ5R1aZPh7XO/nGp6
         mvTuTkkIud+zB6ovsQDyLcnwF2h+1IUIrVdSY/bRERI85meLaIDtn7H5JvVxp2iKNJ91
         +Mu33S33l0dut25SWAcjmmXaNmc332xdWfhB7AWo9YpIpcjFW1zfR0YMwda7jNr+/Y14
         JxcsIRApSTxLcLB7k8HeCEkkgty5tNAyE0HflC4ccjmULycabhAhqaJQvJxWDrC39Ra6
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679637136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+nHbDgNlg7sUA7QNCABsdxPp+66d6lY+QYGpnTvvxM=;
        b=YxRSi0XDcUFTObEFPtrI9CH5j9Vl2prr0jrt/rK2GXVv438eeYN8pgRbWYfM8MwhXo
         z8aoHQ1jEBKYkrPQWNUNyfG1LsjY7HMSi3TUbM8USTUC+xmHuA3cqzSD4AKwe52q6ELH
         6+EOGzhj3a+VzfpnxSIoC5E05kBJb+N9vVQBfGDMfBJM+PMvX7p6RfxcI2fyJTM+UFs3
         DPhPg9FjU7nJ3LUb0RZJUD8//u/4Gigfv3xL2xPvlsJZ+fA0cidZktbpQqo18dcv6IyP
         qQgZ9yKwL+5BEKiQzLQQpGW1khPoscbVmAjqWhuSrNQfy6M2l3wz84na2gayq9wViy9F
         nwsA==
X-Gm-Message-State: AAQBX9e2hCodXcJwBhPMzZNj3uXcgc4wVUMMUAZDDr2ZZty1VIwSBGBa
        abMs+ppM+FuV/2olsevzYls=
X-Google-Smtp-Source: AKy350bJWDDt2Wx1+ASWOKGns7EfAcXGLPWekO6vBSULWggp1cam7EXIFpU2cE9vi6fJUDh7SC7JFQ==
X-Received: by 2002:a05:6a00:1894:b0:626:62f:38d8 with SMTP id x20-20020a056a00189400b00626062f38d8mr298838pfh.3.1679637135750;
        Thu, 23 Mar 2023 22:52:15 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm13311953pfk.143.2023.03.23.22.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:52:15 -0700 (PDT)
Date:   Fri, 24 Mar 2023 05:52:13 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v3 1/3] file: Introduce iterate_fd_locked
Message-ID: <ZB06jUBVUdZaYo6J@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
 <ZB0zMolmWJ5nEDmh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB0zMolmWJ5nEDmh@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:20:50AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 24, 2023 at 05:15:24AM +0000, aloktiagi wrote:
> > Callers holding the files->file_lock lock can call iterate_fd_locked instead of
> > iterate_fd
> 
> You no longer call iterate_fd_locked() in patch 3/3, so this patch can
> be dropped?

yes looks like we won't need this patch and can be dropped. Thank you.

