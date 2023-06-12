Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6583472B81D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjFLGeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjFLGeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:34:09 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C019B7;
        Sun, 11 Jun 2023 23:29:08 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43b315e9024so935405137.2;
        Sun, 11 Jun 2023 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686551331; x=1689143331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euWXaE16F/ugXUu2AMUYqNLZJYAVWQN5GTNPdv6gWGc=;
        b=hdrvreR3hj3GLhn/ltW6PDGaxlXrGXPokfn8710KKG3uWPZlswzLpw7a6pF7hVNrXF
         Br2As/6Szm4hK0ARKrMplFQlvP0EeuuiTjtdVbdnPAM8WR+AnY0tmi1n2mxy7tEa3+J/
         IK//Lx6M0Uozg5HuODNjf2194R33ivf+s5V8VqLEKRDPSSj0U6VdCZCMQWgs0NVP+S6a
         Pnc/JdH6lW7eQo9mts/V05L4nLMwO026lieATDFrH2and6Q5zemw/PXHYE0+zT+FuKmS
         s5hS9SMf/4xTuHgO0HzEISJlS7wdYxHA4HqjbPS0K+L1yndpF9FMETtr4541o7L3VaZl
         nsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551331; x=1689143331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euWXaE16F/ugXUu2AMUYqNLZJYAVWQN5GTNPdv6gWGc=;
        b=MfDvhRKR+tSnDmv/KPMsbxtwD5ec1uj0S/woA78lDLUGLvt7A01NebyaDBhDhmuS74
         bxYbxEMygJ1tTz8TrZRGoj9MBv0PmjqzVEQxs6j0bnSssGq3rGt7je1+fN+qTiWNmQxE
         dLtjrrzhim8bmF1w0Lfq19Nrm0x64i54og6LV8aSwz2EBynJi9X6m+yqG8YxzJGbPsjN
         uKF4s5SHW6BmDZQYHbdA6WpZ/8lRHyuilv9dwlDnEmx9GB4TVeYjx3m8d8w0t2IEBwuR
         1EwGUrMs1+Un2DFVl9hO7PlsqM0PIU17qW3Vz+d9faMritGJkJh8Ge4xynIq/pLQbKZd
         io8g==
X-Gm-Message-State: AC+VfDx93WhCLHUH6wDjXlIvdjEs3fyYrE2yZ852zMberKY5oqLd9S68
        mmZNFYqeATJYcDJfqALCsIlDbpeysdAaGbTNeMw=
X-Google-Smtp-Source: ACHHUZ4pAAxHXnucW983HrU5rBUAk9CQd/Vt3QT3607XLv5TJ1gwDnE3t9W2M8iRjZJleCzVYQXttl78ah/rkL+ZYDY=
X-Received: by 2002:a67:fd75:0:b0:43b:240f:b92e with SMTP id
 h21-20020a67fd75000000b0043b240fb92emr2803174vsa.18.1686551331374; Sun, 11
 Jun 2023 23:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <20230611132732.1502040-3-amir73il@gmail.com>
 <ZIagx5ObeBDeXmni@infradead.org>
In-Reply-To: <ZIagx5ObeBDeXmni@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:28:40 +0300
Message-ID: <CAOQ4uxjm4nXc4cHFCnk69RC2yshBmFBxMTuVxH3QQRm_6LRcSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: introduce f_real_path() helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 7:36=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 04:27:31PM +0300, Amir Goldstein wrote:
> > Overlayfs knows the real path of underlying dentries.  Add an optional
> > struct vfsmount out argument to ->d_real(), so callers could compose th=
e
> > real path.
> >
> > Add a helper f_real_path() that uses this new interface to return the
> > real path of f_inode, for overlayfs internal files whose f_path if a
> > "fake" overlayfs path and f_inode is the underlying real inode.
>
> I really don't like this ->d_real nagic.  Most callers of it
> really can't ever be on overlayfs.

Which callers are you referring to?

> So I'd suggest we do an audit
> of the callers of file_dentry and drop all the pointless ones
> first, and improve the documentation on when to use it.

Well, v3 is trying to reduce ->d_real() magic and the step
after introducing the alternative path container is to convert
file_dentry() to use the stored real_path instead of ->d_real().

But I agree that the documentation about this black magic is
missing. Will try to improve that with the move to the "fake"
file container.

Thanks,
Amir.
