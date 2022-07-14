Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C925F57570B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiGNVg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 17:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiGNVg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:36:26 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DA13F06
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 14:36:23 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bec750eedso4064223fac.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6Y4PJn4e4OHfXaqqzt6DxiZwXN++QJEYWcqrk5YCAk=;
        b=Wf2PaExtCvQQhSD6GzFj9p3mnGi6MmdHeptNTa6pcjWaTSqRXDcdGKGNRxhnnIcXwn
         nT1Y4dfvj44AJdbrnfyQ8/aUL2h82xCTc6e9U0OVHMheoCdQAEt2CaVkUA0ArCG/gH+R
         sZdOnagpL9XtefeYbEPpTBmprfVJ6jCSo1BPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6Y4PJn4e4OHfXaqqzt6DxiZwXN++QJEYWcqrk5YCAk=;
        b=tZOeFfoJTD5NBg+W6yOFJMM2Iyqv+maUzIt3JIvM8gzjfSASpZxU/b2KQHdJXZEyiP
         j3cBJ2FM6d5IsfT3pWub/3y/QiwhGkj4QtkaXnbEhPa9oL8qoohcNJTznD6B4k0A0io4
         3i14RZaml4ucrkwKL9D2qw1YFsn3vBNfWvri33Ppp7NUfv1zuV6eDrtyBIJOUEf1zG9v
         q8eRW9Y8ffVYWZH5inqztJivQgh2qVBqDofA7yqIKES7ZPUmJ27rlwfrHrItdEe1nIBi
         JzdQp3ZGYwNpKLzfDHTz9UXjlM0xn3Slv956/J+N16Wfg8JLtLX5qhCr7ODZIoldAama
         NsJQ==
X-Gm-Message-State: AJIora8OQlnJt/AI3zkrZl8NDS+uiR8tB7TUfFkCgr0rJGeQDca+MkCR
        nahYrX/2HYkSGPPrLwscDM8ztnI+Q2tTWw==
X-Google-Smtp-Source: AGRyM1t4Myc5kFjsvPLRN34EdAntuLawCu4x0RTBiHDikYjVawkz58ozSAKImIJQhn742UNLxKdUHQ==
X-Received: by 2002:a05:6870:51c6:b0:10c:2b7c:a542 with SMTP id b6-20020a05687051c600b0010c2b7ca542mr8348378oaj.19.1657834582793;
        Thu, 14 Jul 2022 14:36:22 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:1f77:47fa:4ce9:ddce])
        by smtp.gmail.com with ESMTPSA id e18-20020a4ae0d2000000b00432ac97ad09sm1123189oot.26.2022.07.14.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:36:22 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:36:21 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] acl: move idmapped mount fixup into
 vfs_{g,s}etxattr()
Message-ID: <YtCMVQIm0cU1wnYU@do-x1extreme>
References: <20220708090134.385160-1-brauner@kernel.org>
 <20220708090134.385160-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708090134.385160-2-brauner@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:01:32AM +0200, Christian Brauner wrote:
> This cycle we added support for mounting overlayfs on top of idmapped mounts.
> Recently I've started looking into potential corner cases when trying to add
> additional tests and I noticed that reporting for POSIX ACLs is currently wrong
> when using idmapped layers with overlayfs mounted on top of it.

<snip detailed explanation>

Beyond the issues described here, it also looks like the vfs_*() calls
are been inconsistent wrt idmapped mounts. With acls it takes/returns
unmapped ids, but other interfaces like vfs_getattr() return mapped ids.
So it makes sense to make vfs_{get,set}xattr() behave likewise.

I have one small suggestion below, but I think this looks good.

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> +static inline bool is_posix_acl_xattr(const char *name)
> +{
> +	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> +	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
> +}
> +

There are locations still open-coding this check -- setxattr_convert()
and do_getxattr(). Maybe consider adding a follow-on patch to convert
those too.

Seth
