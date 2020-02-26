Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE78616FAA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBZJWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:22:38 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:40518 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:22:38 -0500
Received: by mail-io1-f48.google.com with SMTP id x1so2553720iop.7;
        Wed, 26 Feb 2020 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV7FGZpFqM3MXMRpDIfQuZeYXOQ0Cm1sB7r0IOS6lMw=;
        b=ICPhGHr7tJmDzDBkCqyFZ5ucRR+vGT8BRVZ+bPsX2Fnd4trg/jrsJ/9iRN6BHvgE9F
         VaIB9RZTo0yZf95ykQ+Eyk8//usLHs4Lwagd7GFHXW+9TM46lmVoMdAXVpST4Nzn34GX
         ykO8dwGAj/62eS77sZaK4Srdorlzg+yCQjE9Zrg2HsnkGnULOAFCSS2NwGd/9dfANpu9
         24EjtOzkX9lNGe8cBFum3AJ0dWXgZAYfTYXYyhb3EDaLZkZHamaXTDGfIJHL3nF6E/4S
         2ePKrfEZRvZZLqA/l3ZmCH29TJDmV2aofXuhhTot/s4oJvV2TOeqFqx/VZ9yGmrCrPb5
         KTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV7FGZpFqM3MXMRpDIfQuZeYXOQ0Cm1sB7r0IOS6lMw=;
        b=TG1AoIFmyPdwDi8Wsh69YxgtwxAS5um2EpfX5gDo968IiuoGKRhy+QsHgijYFARZrt
         VsOh1MHM9ShyNYTFwBhlgeV8n2LG/XsPu+WrsULB9t1p9s3kYTkR4J4B9JH6OJFog4lW
         GiKUx9xLyy1rGemdXeMZXNRz5VHjNn8buDuVmQrOyF7OCL1jTiCyvBz/W5456QBz8olK
         T8U66PoT7CVuYMmWK6s+gJizxOHnzD4F2chY9H2Mn+LjGjCP2PcAh45D9pTJ2fNc6Zdb
         yqKmZVANWoiDegdASwCEiZPlIQ4ANWtZw4xHJnBZJcsLiJBEyNDzU92H6izcrdPt3l90
         J+WQ==
X-Gm-Message-State: APjAAAXKfKnnZUAMoPH5NAuGoxp063gdfxZJLtibAREK8KupV0yfWbl+
        wrN50ma56q9n31RHQ5LjlcD3wBDDMreLPOki2eM2/lV2
X-Google-Smtp-Source: APXvYqw0sD4ErZ4gv5YKtxhRLMl66m8Y/T3l3446JfpEtvmwI6jm6LXWXnEG8XHui07nTxCndkxDZUEQU7H5+6BOPXM=
X-Received: by 2002:a5d:9c88:: with SMTP id p8mr3424343iop.9.1582708957178;
 Wed, 26 Feb 2020 01:22:37 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt0=WRC2SgG6UZmZ32PbjZrcK4N_sZ9=WcSEar1utTmCw@mail.gmail.com>
In-Reply-To: <CAH2r5mt0=WRC2SgG6UZmZ32PbjZrcK4N_sZ9=WcSEar1utTmCw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Feb 2020 11:22:26 +0200
Message-ID: <CAOQ4uxgUuR__Epnt4tfDuZ4-qiRQxt9mVY5ukBCC2z59YNdDHw@mail.gmail.com>
Subject: Re: [PATCH][CIFS] Use FS_RENAME_DOES_D_MOVE to minimize races in rename
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 8:37 AM Steve French <smfrench@gmail.com> wrote:
>

What sort of rename races? Is that a real/reproducible problem?

> Should be safer to do the dentry move immediately after the rename
> rather than later.
>

Looking at what "later" means, you moved d_move() before
cifs_put_tlink(tlink);
and
shrink_dcache_parent(new_dentry);
detach_mounts(new_dentry);

I suppose cifs_put_tlink() is not the issue.

It makes me wonder about shrink_dcache_parent()/detach_mounts() -
they happen for some fs before d_move() and for some fs after d_move()

I think it kind of makes sense to have them moved after dentry is
unhashed anyway? (that is after d_move()).

Thanks,
Amir.
