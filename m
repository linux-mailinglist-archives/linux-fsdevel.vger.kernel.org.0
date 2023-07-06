Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB974A0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGFP0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjGFP0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:26:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A81BD3;
        Thu,  6 Jul 2023 08:26:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so12581291fa.1;
        Thu, 06 Jul 2023 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657190; x=1691249190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtfE8VfL9/Ahx6GTmCZcc9TQkFw8X5Q1Xxl7Qq4Ume8=;
        b=LTBnJxGZbM5tJrSwF7zMiCvZrBbFIXzGc2+8VjuqKB3TGKuwP1XsiInHM0fNIBD92N
         gzzSYp/oYWe9FOvaUgP8y0jNwkn5E65nddSeN68DYLA/PsT5q9jw8vgSwMRIJI+xeT4L
         PNcFD4TssHnjH7SNR3ZZ8jnh2AWRfFgHXooYsrdv9EjVY+hGdVureO9CzMYfOlaurB5H
         dxfy8Dtn4WZiNrSfO01h6J4HA7roCuKz+GKc6ZxID5BB/JSWD6emzEpuyuBEKPVX171B
         J1RPmTkas8vbpZvLa98wPqtXW0utJh43fDFqm2F4MIItA+fcVJUDW3qno/JFF/vlzCCq
         lfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657190; x=1691249190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtfE8VfL9/Ahx6GTmCZcc9TQkFw8X5Q1Xxl7Qq4Ume8=;
        b=BswOXBngYgdPfjuO63Z33MuEHUKqxnAvEoM6MNUMAzW2DoTUyT/PX0RH58esVtOiE9
         C8Bl5Yx5bWX5hgIF2/t1dtXzYwaKusBTQDqvyh1WidsvKXXIl+r9IpKVSgNWOG5w+wpH
         JybzaYzeaLj/p6+Cv9t8K+HQCY6S0tl4clYPdMX2rS8E9sKkwK4oSYC0oxxxHEZSi/2y
         9O6khKwb7SgG0Wvf/f41RGF9iu4cyegnOqMeXVmtugiyDCDTNZmk6MOViX8KqRkD8oaP
         DJDuekJmn4exFFU+86CCcpN2Hc1Oi4z/hnTeL/54pwpKsbEM84w3RfGbj8pqH4merE23
         HUsg==
X-Gm-Message-State: ABy/qLbb3vB5ffm1NRREODtwexuyGR8vUe9utSiPFtpA76rlhad23omA
        zVcxah/hhuiG3R4zAMx8iYEWeFqxrxeFwuqp+7k=
X-Google-Smtp-Source: APBJJlER+BCDcEUIg4OEmVyyaxgXpw8ib6IqQC2iYtZrUdQ6V/tVqpTRHHCYrROAGxJOx288TdEB4hk8NhZdlX4q6OI=
X-Received: by 2002:a2e:9c95:0:b0:2b6:c16a:db06 with SMTP id
 x21-20020a2e9c95000000b002b6c16adb06mr1741654lji.39.1688657189389; Thu, 06
 Jul 2023 08:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230705185755.579053-1-jlayton@kernel.org> <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-6-jlayton@kernel.org>
In-Reply-To: <20230705190309.579783-6-jlayton@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 6 Jul 2023 10:26:18 -0500
Message-ID: <CAH2r5msVjOVx8FnV6kCErMtkUpfTdPUMHXug3V=9PaA4MevkgA@mail.gmail.com>
Subject: Re: [PATCH v2 06/92] cifs: update the ctime on a partial page write
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Steve French <stfrench@microsoft.com>

On Wed, Jul 5, 2023 at 2:04=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> POSIX says:
>
>     "Upon successful completion, where nbyte is greater than 0, write()
>      shall mark for update the last data modification and last file statu=
s
>      change timestamps of the file..."
>
> Add the missing ctime update.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/smb/client/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 879bc8e6555c..0a5fe8d5314b 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page,=
 unsigned from, unsigned to)
>                                            write_data, to - from, &offset=
);
>                 cifsFileInfo_put(open_file);
>                 /* Does mm or vfs already set times? */
> -               inode->i_atime =3D inode->i_mtime =3D current_time(inode)=
;
> +               inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D =
current_time(inode);
>                 if ((bytes_written > 0) && (offset))
>                         rc =3D 0;
>                 else if (bytes_written < 0)
> --
> 2.41.0
>


--=20
Thanks,

Steve
