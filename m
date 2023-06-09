Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987F72A07A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFIQqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjFIQpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDB3A88
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686329095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lP5O6Y+WWlbHJraaUNqLEu0298uTs2XTBNqgvHhDjHo=;
        b=WmnsYHgIj+AQ7N2tl8AxknWxPnsx7Ug1QbzYl7HCfimX5uzMwyc5GeYnOh7HD9KBtDxna8
        9sGQz6ZPWVOSa4EIqCdQjShfs3kSCuKqLoaS9Z7saFfuriy6LT9dyLcUkyoRKgWw83Hg7p
        vc251aVbIkrBYHiHFZ9yrqwNtjfZXd8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-647zBKdPM2CKVJIn88HCLA-1; Fri, 09 Jun 2023 12:44:53 -0400
X-MC-Unique: 647zBKdPM2CKVJIn88HCLA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b1bd4fcc22so6744885ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 09:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329093; x=1688921093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP5O6Y+WWlbHJraaUNqLEu0298uTs2XTBNqgvHhDjHo=;
        b=l/YdT2cLDKsCy+OEWZDGd/fgwinWIM+8rkZZRClFL2iPwOqqmHHRgwMBZFVlRIZJxp
         le6lxa3u/ZHevhVAbDQ4Wjdet+MXWHexOT5+5/4ZzLu6DQZPsWYdItg2cLsQNKBbW1rW
         RwFxzqDcTgXBIQEpPE21HFC8zQ9rNG65QHaK6gk7wHbpBFh2AGfXcOoE5Usoi2j91pRY
         eiwZiL14H2CwAMLOaDmI85C/N4vk7enV10IBJF7n0kethJAf7Dn5wQRjJeXLMe5ph/JA
         2XiiljX5oZb8KBaOhmZg5fimJoiLZcRFyUVcWH2AUf/LmS8cfgr4Gr7Z0K7l+cltC0fI
         mq7w==
X-Gm-Message-State: AC+VfDyhjQU2S7TF8LC6VHRpcd34y6yKhrb2s2tm0tqBL1zSNbCp6mCa
        WqSNCF8vzR70pzwWleBaRrSa+wtjuItBcLFcyTi92dFlNaEp/UOmrPDfkf8eUrnUEYUFxeRManQ
        jF1/jUgcFVVCN3FvkMoqmX6kS12BK8sCmk3d8JlStzw==
X-Received: by 2002:a17:902:b905:b0:1af:e63f:5bb1 with SMTP id bf5-20020a170902b90500b001afe63f5bb1mr1282664plb.7.1686329092975;
        Fri, 09 Jun 2023 09:44:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zDVq695OK7McLR4vzNBftl0R3SL21TRjXzZOuBBU36wjdeP/MVpNAkO6JcixIuhfY6AAHiytBnKwzWzUI7o8=
X-Received: by 2002:a17:902:b905:b0:1af:e63f:5bb1 with SMTP id
 bf5-20020a170902b90500b001afe63f5bb1mr1282622plb.7.1686329092671; Fri, 09 Jun
 2023 09:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230609125023.399942-1-jlayton@kernel.org> <20230609125023.399942-8-jlayton@kernel.org>
In-Reply-To: <20230609125023.399942-8-jlayton@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 9 Jun 2023 18:44:41 +0200
Message-ID: <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is updated
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff,

On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/gfs2/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 1ed17226d9ed..6d283e071b90 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *ip, l=
off_t loc,
>                 size =3D loc + sizeof(struct gfs2_quota);
>                 if (size > inode->i_size)
>                         i_size_write(inode, size);
> -               inode->i_mtime =3D inode->i_atime =3D current_time(inode)=
;
> +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D =
current_time(inode);

I don't think we need to worry about the ctime of the quota inode as
that inode is internal to the filesystem only.

>                 mark_inode_dirty(inode);
>                 set_bit(QDF_REFRESH, &qd->qd_flags);
>         }
> --
> 2.40.1
>

Thanks,
Andreas

