Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE35A63E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiH3MvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiH3MvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:51:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDE58B5C
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d15so6111641ilf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YbnjnJSKUzttr6D096kiqwnhNCPc0sQLZuf3vwJ8WRg=;
        b=NBZZYC7sH9TwbUU5cec8DopFhDZMl5UTYvKNfKLnZwQnFM16MBeE/GkUeNtDD5RjkR
         vVZxb5FPHHbP1hdz5NBi689+2U9ffjKWByjK6C1iEwUYCQW/qv0v8W8RyIOw92hrqjP9
         xxGEAIfxfARtVwRv54lu27cZuFZQd1rTTcipU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YbnjnJSKUzttr6D096kiqwnhNCPc0sQLZuf3vwJ8WRg=;
        b=nqMS8gwVRi0CEa4bYMlYvKw5YyQNVvqXLw0Vi5GijxWwHtBUvJ9un75FegtC0AzRZX
         vukxkJfTJcuvHQzANS5tVemBUYpbxaL8LV2SY97uv7FNOOpSk3IBD9Yv2lwcUdqdvzRh
         tun637xmuGM3qGZVBFskWNkoi++4i/WEFLNEciIKsVCrUFtDShzZ6atRi65i0eSdV1VU
         UcO+NxywjvF8552nMFIOp99kVifRp0bEgv70LeN90my5W6L64qYUvhEzuuZF9IHWUufl
         GzYXdkkpwwFOIb1Vk0ms/d+vvbmUZTarQ6nteEvFVA2bCsMHRg154EPcr3wcW1E/Oyii
         M+Lg==
X-Gm-Message-State: ACgBeo13MGeHry1PSxwW8byK86lN50biIzMoz5BdNhvosmwITSBmJ72J
        L/pxNHkY0a/bYicfVymfXFa+bNEGIRRVTw==
X-Google-Smtp-Source: AA6agR44lkPmssgaYUNZaAHJHGfg5pCC5NJtF7FUMeItV7bTvB3aZ7p6Zp5n16pFMnNRKJSvwQYpxA==
X-Received: by 2002:a05:6e02:1bc8:b0:2e9:8401:477a with SMTP id x8-20020a056e021bc800b002e98401477amr12094789ilv.265.1661863866016;
        Tue, 30 Aug 2022 05:51:06 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id q67-20020a6b2a46000000b006883f9641bbsm6283305ioq.19.2022.08.30.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:51:05 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:51:04 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] ntfs3: rework xattr handlers and switch to POSIX ACL
 VFS helpers
Message-ID: <Yw4HuFwtYdQB5CZN@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-2-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:40PM +0200, Christian Brauner wrote:
> The xattr code in ntfs3 is currently a bit confused. For example, it
> defines a POSIX ACL i_op->set_acl() method but instead of relying on the
> generic POSIX ACL VFS helpers it defines its own set of xattr helpers
> with the consequence that i_op->set_acl() is currently dead code.
> 
> Switch ntfs3 to rely on the VFS POSIX ACL xattr handlers. Also remove
> i_op->{g,s}et_acl() methods from symlink inode operations. Symlinks
> don't support xattrs.
> 
> This is a preliminary change for the following patches which move
> handling idmapped mounts directly in posix_acl_xattr_set().
> 
> This survives POSIX ACL xfstests.
> 
> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>>
