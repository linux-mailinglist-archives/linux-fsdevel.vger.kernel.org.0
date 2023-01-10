Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE726642AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjAJOBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 09:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjAJOBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:01:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52D50F45
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 06:01:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fc4so28799543ejc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JzWWQcM/6ZK4mUtbCni76L3BUamHwnWcBEc3Z4yzaR4=;
        b=FRC8bnT9PhVBffyy+z3WKt8/ww4XpWjC51YJaRZcWnyLJV70pKvDQ70pXmVsMbQsc7
         micYKmt8Mgvu8oMdjrRIdn22wIQB++QjS8ve3LGme/DJdnP2cUyIcUrUAK7Yclp1REQx
         DDPe4TGYRtu62URScyXs1TAXdzjZAfrQOOKdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzWWQcM/6ZK4mUtbCni76L3BUamHwnWcBEc3Z4yzaR4=;
        b=4UB8UYy5NiJGLDFotKr00rmdTGypeMp7Y8fkyf442DKQ9UgFU7vF0UYg1qfkYE/Ox+
         pz4KtOObFGdr9RtJpVZAcdSC5wYE3cNG8hWbMH4wmwURgznKUjWJaa04XZdT41s7iPHv
         PFT4iCT4OIKwKweSCUZiR0xUAbc8u9NTpTQU/V59Q7ABAr9lOhGrypcGJeSEsYzQy4ap
         AiENmLTq5ds1EZKYQwAuJ5jPOT6Aa9KVRk/IUem1JUM66iKQ3eZNuEQrCywCru7RU2mH
         PuE/TlYbv4G5pPBd9L/PzlJlQJow6VhE35qgaeMMMFyd6ANzN/hJhUhkrWGvXrdfh3CQ
         uSUg==
X-Gm-Message-State: AFqh2koDtgEyb+Jxk83OmnKsw5cj4VcPsoOyrajgHlRz5pVk3EYYpya9
        C/HM2k/33b3l01/JnSk/1/C89EyllSBq32w8ejMKaw==
X-Google-Smtp-Source: AMrXdXvdCffT3vJCQc33/qFXRcG/AZF0bQwtBbIiDx0jNGAiZTGM6+sW92UGW3kfjGmzU+rVtbfHlb/BV3WCzZHRNX8=
X-Received: by 2002:a17:907:a50b:b0:84d:114d:b9b with SMTP id
 vr11-20020a170907a50b00b0084d114d0b9bmr1140926ejc.356.1673359292762; Tue, 10
 Jan 2023 06:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20230110104501.11722-1-jlayton@kernel.org>
In-Reply-To: <20230110104501.11722-1-jlayton@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Jan 2023 15:01:21 +0100
Message-ID: <CAJfpegsgufA-+KAShjCfAuyFaKmAGKVCto=fCYOMbPhu33MeVg@mail.gmail.com>
Subject: Re: [PATCH] fs: remove locks_inode
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Jan 2023 at 11:45, Jeff Layton <jlayton@kernel.org> wrote:
>
> locks_inode was turned into a wrapper around file_inode in de2a4a501e71
> (Partially revert "locks: fix file locking on overlayfs"). Finish
> replacing locks_inode invocations everywhere with file_inode.
>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Makes sense.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
