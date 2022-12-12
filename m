Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D70649751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 01:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiLLAOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 19:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLLAOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:14:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4BCE3F;
        Sun, 11 Dec 2022 16:14:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w15so10469560wrl.9;
        Sun, 11 Dec 2022 16:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZNwRSZP5neiNWnbupMyKTJhLQAAXokLk6mXrXmu368=;
        b=qMGs0kQ9OSHMO2fhdWkWP9l8r/1yCg8pdTwPiHuDSpSY77BP63bXUuWFzYtFJeqVIJ
         BMl+2REa9Q/TeHLa5tFS9Lkz3oCXRmQwVHO6RgOXPMXznlway4WOniAWqLNOiWGpATRN
         qnYXSaY+Gb6+CWwwKIfaLwzzuKk5MgL/78Jr9eXbs1sOITUz9EqgXtLaevAAQQUtyjZz
         DTNsOYIYI7Sl7MFas8WA+JW5UTRzZub6zL8woGeGpggkF8f8qwiGjrjvimWgrlcm08py
         kIlv2V91pRPJPgznn5gu5SDdSZIynFZBNy3YFUu2HiNP1JshAwf+ytrEQlaJaGi8Eo5z
         C4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZNwRSZP5neiNWnbupMyKTJhLQAAXokLk6mXrXmu368=;
        b=zXBXuywGqkTgYA4RtsBb+kE7Si7vlYY2FS6t52jFE3SXmztQXUvslJ6IBOVkqNfblq
         maUlzrf4cODMNoIkKCFVqJpzaP5540lQ8PFAqsjuv3ExEK683a1BGOLMpzHuW9mpGMX5
         JPJlwy+AK0TNzcKj33+xPI98wYZz/S5iaNSRU/rwnp5ENnOtLCOZhPG++VTEBAbZSqqM
         LxXnfIrpxSP6PLyaeP3j929Yfl0sBGpnurHvt7bGwvYGFsYKHRQ9lj8+pVhN+vySkbQR
         jVUHltc77Q4GPQXEWx/qwgEP6E8kCMwrSDDOQCe83WCp5bO7iNYlO1p6eFNv4F5uUfrQ
         0qpA==
X-Gm-Message-State: ANoB5pnYXkyvoeWeWSoTExYzK6lmwvJQmATp4APWk4In99u1AaSM4iIF
        2gLU4ku8S3tv6n5PlF/tOdLbwkDdDlw=
X-Google-Smtp-Source: AA0mqf7uj/+NKNOefT8NP++hC3L8FljN8vywiRZUmgfFgKQ8nZ6ZBA4rrpCFgvguCSzb+idmGAE8Bw==
X-Received: by 2002:a5d:6a0c:0:b0:242:4bbe:2d20 with SMTP id m12-20020a5d6a0c000000b002424bbe2d20mr8085645wru.42.1670804086279;
        Sun, 11 Dec 2022 16:14:46 -0800 (PST)
Received: from suse.localnet (host-95-247-100-134.retail.telecomitalia.it. [95.247.100.134])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b00241c6729c2bsm7321964wrs.26.2022.12.11.16.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:14:45 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 12 Dec 2022 01:14:44 +0100
Message-ID: <4792154.31r3eYUQgx@suse>
In-Reply-To: <Y5ZcMPzPG9h6C9eh@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-4-fmdefrancesco@gmail.com> <Y5ZcMPzPG9h6C9eh@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On domenica 11 dicembre 2022 23:39:44 CET Al Viro wrote:
> On Sun, Dec 11, 2022 at 10:31:11PM +0100, Fabio M. De Francesco wrote:
> > +/*
> > + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> > + * rules documented in kmap_local_page()/kunmap_local().
> > + *
> > + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> > + * and must be treated accordingly for nesting purposes.
> > + */
> > 
> >  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page
> >  **page) {
> > 
> > +	char *kaddr;
> > +
> > 
> >  	struct address_space *mapping = dir->i_mapping;
> >  	*page = read_mapping_page(mapping, n, NULL);
> >  	if (!IS_ERR(*page)) {
> > 
> > -		kmap(*page);
> > +		kmap_local_page(*page);
> > 
> >  		if (unlikely(!PageChecked(*page))) {
> > 
> > -			if (!ufs_check_page(*page))
> > +			if (!ufs_check_page(*page, kaddr))
> 
> 	Er...  Building the patched tree is occasionally useful.
>
I don't know why gcc didn't catch this (gcc version 12.2.1 20221020 [revision 
0aaef83351473e8f4eb774f8f999bbe87a4866d7] (SUSE Linux)):

setarch i686
make ARCH=i386 O=../build-linux-x86_32-debug/ -j12
make[1]: Entering directory '/usr/src/git/kernels/build-linux-x86_32-debug'
  GEN     Makefile
  DESCEND bpf/resolve_btfids
  CALL    /usr/src/git/kernels/linux/scripts/checksyscalls.sh
  CC [M]  fs/ufs/dir.o
  LD [M]  fs/ufs/ufs.o
  MODPOST Module.symvers
Kernel: arch/x86/boot/bzImage is ready  (#3)
  LD [M]  fs/ufs/ufs.ko
  BTF [M] fs/ufs/ufs.ko
make[1]: Leaving directory '/usr/src/git/kernels/build-linux-x86_32-debug'

> Here kaddr is obviously uninitialized and compiler would've
> probably caught that.
>
I'd better use option W=1 next time.
>
> 	And return value of kmap_local_page() is lost, which
> is related to the previous issue ;-)
> 
> >  				goto fail;
> >  		
> >  		}
> >  	
> >  	}
> > 
> > -	return page;
> > +	return *page;
> 
> Hell, no.  Callers expect the pointer to the first byte of
> your page.  What it should return is kaddr.
>
I'm sorry that I entirely missed this :-(
> 
> > @@ -388,7 +406,8 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > *inode)> 
> >  	mark_inode_dirty(dir);
> >  	/* OFFSET_CACHE */
> >  
> >  out_put:
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, kaddr);
> > +	return 0;
> > 
> >  out_unlock:
> >  	unlock_page(page);
> >  	goto out_put;
> 
> That can't be right.  Places like
>         if (err)
> 		goto out_unlock;
> do not expect err to be lost.  You end up returning 0 now.  Something 
strange
> happened here (in the previous commit, perhaps?)
>
I don't yet know. Maybe that it is related to a copy-paste error or something 
like that...

As said, I'll send next version ASAP.

Again thanks for your kind help,

Fabio



