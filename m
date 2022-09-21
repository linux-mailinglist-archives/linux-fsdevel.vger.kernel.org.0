Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502795BF419
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiIUDHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 23:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIUDHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:07:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D77E019
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 20:07:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc7so10765636ejb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bxsHl+idQXVJGALDxyDHq0iSL+6z6j+cHeThkAkNKQ8=;
        b=m1D7I0MkiFE47bB9yoZMuI6vEy7m7FOyL2wFRui9ErWc5BQHCqpK9wUb0BPw7KvjMo
         K/ZLPYYAaX4XTdW0Sm0G2OXvGUdDa5rDYKLkurfOciMQIto+SemHNoaZoWkzP+T+KOO3
         KcAKPiy3Q4J9WbSFqJt4/0/2/CvVUtA+MSMYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bxsHl+idQXVJGALDxyDHq0iSL+6z6j+cHeThkAkNKQ8=;
        b=0TGjuW1ZWfb+gWXpqxn5JtQsFZi/W1KRw9GblVfOrqaZUkYbQvDRGNp+dYbUcgh+ru
         hFfO4s0z//1QG7HzWmpSGdZaFx9cguFjOpIcKpFt8sqa0zZgrHYTmkOAlydU1YpiubFT
         P++79wHUmyqOKCZjxY69zoDQnB8oUz1lHr/VqoppupNF3u62+inAn3fWzNViqmFWkGtw
         TYMNmh1sMwqRaA5r/2mZEbI7tQPePzTITHKMnd065L9hw1OF1qY5AM5N6aNO60AH3N9G
         Bq49dWM7+ua9MqFhVQIWWHUlW5MS6hPyWpw+cketU3AFBsZZ3g33eJQtN4UZYvLVOIDq
         iofA==
X-Gm-Message-State: ACrzQf008DHz/t/nezlvs+JlroJso27aWpo4ZUQ0ucRX9oCMTLNRYH9h
        09TVat42Ee3iXUknN1aA9jLj4gSl1UdgMCccQLhT0Q==
X-Google-Smtp-Source: AMsMyM6mgQJ8ACMtBbo7UvcMgnIWHqDf4YKzEfW30/iedg4MCthK2557GSrKdrioxAXZOX1l7PK8NmWITXWjDY/O9qc=
X-Received: by 2002:a17:907:97d1:b0:780:26c9:1499 with SMTP id
 js17-20020a17090797d100b0078026c91499mr18710114ejc.371.1663729628746; Tue, 20
 Sep 2022 20:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-8-mszeredi@redhat.com>
 <YyopS+KNN49oz2vB@ZenIV>
In-Reply-To: <YyopS+KNN49oz2vB@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 05:06:57 +0200
Message-ID: <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
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

On Tue, 20 Sept 2022 at 22:57, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:
>
> >       inode = child->d_inode;
>
> Better
>         inode = file_inode(file);
>
> so that child would be completely ignored after dput().
>
> > +     error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
> > +     if (error)
> >               goto out2;
> > -     dput(path.dentry);
> > -     path.dentry = child;
> > -     audit_inode(nd->name, child, 0);
> > +     audit_inode(nd->name, file->f_path.dentry, 0);
> >       /* Don't check for other permissions, the inode was just created */
> > -     error = may_open(mnt_userns, &path, 0, op->open_flag);
>
> Umm...  I'm not sure that losing it is the right thing - it might
> be argued that ->permission(..., MAY_OPEN) is to be ignored for
> tmpfile (and the only thing checking for MAY_OPEN is nfs, which is
> *not* going to grow tmpfile any time soon - certainly not with these
> calling conventions), but you are also dropping the call of
> security_inode_permission(inode, MAY_OPEN) and that's a change
> compared to what LSM crowd used to get...

Not losing it, just moving it into vfs_tmpfile().

Thanks,
Miklos
