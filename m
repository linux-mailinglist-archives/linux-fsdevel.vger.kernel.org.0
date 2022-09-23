Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE15E7F21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiIWP6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiIWP6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660614C076
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a41so826866edf.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DzpGNY6qRpjvL6rdAdxNnBtFSX5iFVFNjOYVjQX2mgU=;
        b=K+d5LWQ+mcpwMdjkKl38wLHWsgtW/pfgGpFdWPQyS6gQw2ay+rGO9pJyBsVaLApAQX
         moPiPW6mPKkmUdD9Y/laPZfk1imjCkXBh6AGj4o7EQBdGTm3kLkpYKmrMCVHD4DVeVCU
         qyJzE4XAdR0iWiBjrtv5dxvA3Q0VJdV88cxog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DzpGNY6qRpjvL6rdAdxNnBtFSX5iFVFNjOYVjQX2mgU=;
        b=kkMC5t7hG9fcx++uA+wkN8+kkpq3o5lIvfjOay08z98IY9ZY01jldNgP6g3fuahrV9
         1O5PVCplNlCJk6PLO8qgOzjNrHarvEuILdU5ycyYYu4On9VjcRFw2roBRSdiQBVukOPa
         MmEtAs3ISghr1/WLfj/Z26n4nS71MAI3FI9BRAuedvxSHNsjtanb2dxMUROWQspnHwIG
         oFDw2MqMLfs1L9YOyhHXHwziNltOXyOr5N4/kJC+SX3pfaxHt0lMbtcWD4YSDpoocN2+
         25VsjvMt0Tkn/qljLVWjrU74tU2kQUuqBgj3sACgESfWbhnk7a5l1w+7j1XmjbBPpXp8
         WXDw==
X-Gm-Message-State: ACrzQf0mE8HztoAcnDcKSh4c/3Wusowu/51DrWGx28hMTReqjABeUggk
        G7t6f7qa/yocDohMLC4ZjS5/UI6lK0pe7ifWHS5oh3EI9lw=
X-Google-Smtp-Source: AMsMyM4AfYGL+uZVCifeXudVUOpUqiNvccD2kXCTHEo86/tx34f/XJVjf6vxdpHJSPWfvhDH2qW9u5IDgV2eo8kSX0g=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr9214209edb.133.1663948635811; Fri, 23
 Sep 2022 08:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-24-brauner@kernel.org>
 <CAJfpegs092_0VkmfnyRP54_fJrssQbDxsh2Q754GLq34LZb0LQ@mail.gmail.com> <20220923154742.iplvc4nj5y6gaci4@wittgenstein>
In-Reply-To: <20220923154742.iplvc4nj5y6gaci4@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 23 Sep 2022 17:57:04 +0200
Message-ID: <CAJfpegt1YJzyE=UYF=DNW-qd08zLRgG7vpbm32m0rWEbWjLNOw@mail.gmail.com>
Subject: Re: [PATCH 23/29] ovl: use posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Sept 2022 at 17:47, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 23, 2022 at 05:38:34PM +0200, Miklos Szeredi wrote:

> It's basically just like when you copy a file betweed idmapped mounts:
>
> mount -o X-mount.idmap=<mapping1> --bind /source /source-idmapped
> mount -o X-mount.idmap=<mapping2> --bind /target /target-idmapped
>
> cp /source-idmapped/file1 /target-idmapped
>
> where you need to take the source and target idmappings into account.
>
> So basically like what ovl_set_attr() is doing just for acls. But I

But then before this patch the copy-up behavior was incorrect, right?

In that case this needs to be advertised as a bug fix, rather than a cleanup.

Thanks,
Miklos
