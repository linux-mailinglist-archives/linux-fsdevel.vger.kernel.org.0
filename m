Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9585C0095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIUPA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIUPAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:00:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F098B2F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:58:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so14179883ejb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YShq11wGG8l0OcD3R3znQllLfh2eKkfCZ/IrLw7xbv8=;
        b=dBE7ke9ng1hx9mEU6ZuXEA7KjrSt4P6cH1Ku7EJrmXGAdrPKWBprHlYE/47+DRBgEI
         /JF8NeyVMSD4F3iGmPcC7ZtNbKCF00zUuvNXdCjyVeNgI8XwARYOnuzABThJz+EuBKVO
         xa+812KQVrDhCY9bO8xvdVohK6KZPXoRgdTAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YShq11wGG8l0OcD3R3znQllLfh2eKkfCZ/IrLw7xbv8=;
        b=7LLqUN7scG2EKG3RkUPlm/xp73aMz3blZSlS8w1TMGfYAOK8j3aJhomecdgYPhFJ03
         76iO57HDz1L2Htu5+ipiEAMhsRl/skJB+exTozo5sDUnejUstkS95+B5tL536FOfJJNv
         p+nDUFgnEsvjodZoOBWvBSKTTcYt1Bh/1Afa1cRODT78f3NrTO98oiSLINOcLylM6VsK
         u5X+8g11mxHjzPj69NqOfGg5GVF/p3KqtNwncJOC9xfuvin5hNIMK6Hf4jL3Giy2mCWU
         RgyGVhGAmAQ18d6o3w++PRaPl7CrbROhLXluQ/WdfVCbVhfO0bHHy4uhTDfHBlxvogXb
         TT1Q==
X-Gm-Message-State: ACrzQf03ORxw2TpsMKx4M9bv/cDsrF4N/TRWKbgYAFPHTUR0PC69uXmD
        rU9LclKkcIMEo9EwjVzRsZVwJcGNMuqvPE5t7s8Wgg==
X-Google-Smtp-Source: AMsMyM4VAUr3YFFz3ywzC0WSRIpvyVwjrFuyiDk0n0hjLjQxc4Dd3Lb1xcF4z9751JyP9V3e7O2N+wJsEFD6rXGLyeI=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr7284002ejc.255.1663772329442; Wed, 21
 Sep 2022 07:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-9-mszeredi@redhat.com>
 <20220921090820.woijqimkphaf3qll@wittgenstein>
In-Reply-To: <20220921090820.woijqimkphaf3qll@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 16:58:38 +0200
Message-ID: <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Sept 2022 at 11:08, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 09:36:31PM +0200, Miklos Szeredi wrote:
> > This is in preparation for adding tmpfile support to fuse, which requires
> > that the tmpfile creation and opening are done as a single operation.
> >
> > Replace the 'struct dentry *' argument of i_op->tmpfile with
> > 'struct file *'.
> >
> > Call finish_open_simple() as the last thing in ->tmpfile() instances (may
> > be omitted in the error case).
> >
> > Change d_tmpfile() argument to 'struct file *' as well to make callers more
> > readable.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
>
> Seems fine to me. Fwiw, it feels like all the file->f_path.dentry derefs
> could be wrapped in a helper similar to file_inode(). I know we have
> file_dentry() but that calls d_real() so not sure if that'll be correct
> for all updated callers,

I don't think file_dentry() should be used for this.

file_dentry() is basically a hack for overlayfs's "fake path" thing.
It should only be used where strictly necessary.  At one point it
would be good to look again at cleaning this mess up.

Thanks,
Miklos
