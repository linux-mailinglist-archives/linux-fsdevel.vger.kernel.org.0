Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9744709305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjESJ2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjESJ2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:28:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DFE43;
        Fri, 19 May 2023 02:28:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25332422531so480625a91.0;
        Fri, 19 May 2023 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684488514; x=1687080514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iCoUl/IFdkkhO1BGNaDLIKPoQD0jj1ABgxhFaKOhJk=;
        b=loUc8vEhhVFfDXEarx5E919gbR42pL0iuSot7WoVSy2nSxH7BZfZcxxGAQtd8y/3nC
         9FSm9jTPHWz6VK7XsmfXd8OaLD0GcFSTafAhNf/PQqTdAYhfT4DsukN/9hWgupFafWDm
         0b2dM+1uhzdvm5mu4GueSPFKDpTw2Zkio85arMLJ/iE5rdKmRwJi40WkYrseIMXoxmZY
         hRqlHat9ykXYRzgS3jjtKfizi0bpBFPHyfulL4LCpsdoNde9CdLeDkO0BkR5aRd8dVLK
         BxkdUwIoyO4CS7MJZ9x29k7JoKqfRsewd8H8eJ9ZDUXbnIRPJUXu3cldQ6vAimaW6IhF
         wS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684488514; x=1687080514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iCoUl/IFdkkhO1BGNaDLIKPoQD0jj1ABgxhFaKOhJk=;
        b=PXPKCaAFBvxhOxyfHAEM7d5hDm/Mp/BeEMrV+mb6CGbZZZ2WDG2l5zjTGOzNpB2BOq
         49ZK8eYnYAm1CZVoUP7s6EW517r0GB38X+Uf0oma16jL9bNRcV7FwCbRmNV3y2EWwxuZ
         WwutShECjk1VZTaiWVcoe6ku0mB5IzfyZFePW7W6erjEa1vumHwy3nE5kUM+gIbSmV12
         pTYzw14p1u0NMNJsjxqTbeCFLacjbAPedBLfvUskD+8WydMEgPTlsH6THf77nO8vhgZ5
         WHq2pti5JihXAP1mURntBvfWOQpXk3T6bm+5A2H0YyXoxQIOM6negUDDz8DVnq/iW6+n
         Z67g==
X-Gm-Message-State: AC+VfDzTTqnKccMsj18QFkeJtFV7QlpfaIGQnCI+TvZpV2ylWfUnTCiP
        FLJWW9e9HAMVTWJ797Whzso=
X-Google-Smtp-Source: ACHHUZ4yGQWKyAwGdVFSoNaqcQrWj2zsj1lKgDxVS9NEz4BMdC9+tw0xjBF23BSfZJDc2mkmWR3/CA==
X-Received: by 2002:a17:90a:6d47:b0:24e:3752:194f with SMTP id z65-20020a17090a6d4700b0024e3752194fmr5942592pjj.21.1684488514344;
        Fri, 19 May 2023 02:28:34 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-22.three.co.id. [116.206.28.22])
        by smtp.gmail.com with ESMTPSA id l64-20020a639143000000b0053491d92b65sm485424pge.84.2023.05.19.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 02:28:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D34DE10569D; Fri, 19 May 2023 16:28:27 +0700 (WIB)
Date:   Fri, 19 May 2023 16:28:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net, jake@lwn.net,
        hch@infradead.org, djwong@kernel.org, dchinner@redhat.com
Cc:     ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGdBO6bmbj3sLlzp@debian.me>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0VIesbtBcvOdTYu/"
Content-Disposition: inline
In-Reply-To: <20230518144037.3149361-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--0VIesbtBcvOdTYu/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:40:37AM -0700, Luis Chamberlain wrote:
> +..
> +        Mapping of heading styles within this document:
> +        Heading 1 uses "=3D=3D=3D=3D" above and below
> +        Heading 2 uses "=3D=3D=3D=3D"
> +        Heading 3 uses "----"
> +        Heading 4 uses "````"
> +        Heading 5 uses "^^^^"
> +        Heading 6 uses "~~~~"
> +        Heading 7 uses "...."

Everyone can distinguished those heading levels without telling them.

> +
> +        Sections are manually numbered because apparently that's what ev=
eryone
> +        does in the kernel.

I don't see any section numbering here (forget to add one?).

> +.. contents:: Table of Contents
> +   :local:

I see the toctree before actual doc title. Maybe move down toctree below
it?

> +You can call into **iomap** for reading, ie, dealing with the filesystem=
s's
> +``struct file_operations``:
> +
> + * ``struct file_operations.read_iter()``: note that depending on the ty=
pe of read your filesystem
> +   might use ``iomap_dio_rw()`` for direct IO, generic_file_read_iter() =
for buffered IO and

Try to be consistent on inlining code keywords (identifiers, function names=
, etc).

> +Testing Direct IO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Other than fstests you can use LTP's dio, however this tests is limited =
as it does not test stale
> +data.
> +
> +{{{
> +./runltp -f dio -d /mnt1/scratch/tmp/
> +}}}

Use literal code block for above shell snippet:

---- >8 ----
diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystem=
s/iomap.rst
index 51be574b5fe32a..6918a4cc5e3b9b 100644
--- a/Documentation/filesystems/iomap.rst
+++ b/Documentation/filesystems/iomap.rst
@@ -213,9 +213,9 @@ Testing Direct IO
 Other than fstests you can use LTP's dio, however this tests is limited as=
 it does not test stale
 data.
=20
-{{{
-./runltp -f dio -d /mnt1/scratch/tmp/
-}}}
+::
+
+    ./runltp -f dio -d /mnt1/scratch/tmp/
=20
 Known issues and future improvements
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  *  `Presentation on iomap evolution`<https://docs.google.com/presentat=
ion/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySY=
EbgJA/pub?start=3Dtrue&loop=3Dfalse&delayms=3D3000&slide=3Did.g189cfd05063_=
0_185>`
> +  * `LWN review on deprecating buffer-heads <https://lwn.net/Articles/93=
0173/>`

I don't see clickable hyperlinks on above external references, so I have to
fix them up:

---- >8 ----
diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystem=
s/iomap.rst
index 75716d4e2f4537..51be574b5fe32a 100644
--- a/Documentation/filesystems/iomap.rst
+++ b/Documentation/filesystems/iomap.rst
@@ -230,5 +230,5 @@ We try to document known issues that folks should be aw=
are of with **iomap** her
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-  *  `Presentation on iomap evolution`<https://docs.google.com/presentatio=
n/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEb=
gJA/pub?start=3Dtrue&loop=3Dfalse&delayms=3D3000&slide=3Did.g189cfd05063_0_=
185>`
-  * `LWN review on deprecating buffer-heads <https://lwn.net/Articles/9301=
73/>`
+  *  `Presentation on iomap evolution <https://docs.google.com/presentatio=
n/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEb=
gJA/pub?start=3Dtrue&loop=3Dfalse&delayms=3D3000&slide=3Did.g189cfd05063_0_=
185>`_
+  * `LWN review on deprecating buffer-heads <https://lwn.net/Articles/9301=
73/>`_
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cfb724a4c65280..af5e6c0e84923f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -25,7 +25,7 @@
  *
  * Block mapping provides a mapping between data cached in memory and the =
location on persistent
  * storage where that data lives. `LWN has an great review of the old buff=
er-heads block-mapping and
- * why they are inefficient <https://lwn.net/Articles/930173/>`, since the=
 inception of Linux.
+ * why they are inefficient <https://lwn.net/Articles/930173/>`_, since th=
e inception of Linux.
  * Since **buffer-heads** work on a 512-byte block based paradigm, it crea=
tes an overhead for modern
  * storage media which no longer necessarily works only on 512-blocks. iom=
ap is flexible
  * providing block ranges in *bytes*. iomap, with the support of folios, p=
rovides a modern

> -/*
> - * Flags reported by the file system from iomap_begin:
> +/**
> + * DOC:  Flags reported by the file system from iomap_begin
>   *
> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and n=
eed
> - * zeroing for areas that no data is copied to.
> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated an=
d need
> + *	zeroing for areas that no data is copied to.
>   *
> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to =
access
> - * written data and requires fdatasync to commit them to persistent stor=
age.
> - * This needs to take into account metadata changes that *may* be made a=
t IO
> - * completion, such as file size updates from direct IO.
> + * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed =
to access
> + *	written data and requires fdatasync to commit them to persistent stor=
age.
> + *	This needs to take into account metadata changes that *may* be made a=
t IO
> + *	completion, such as file size updates from direct IO.
>   *
> - * IOMAP_F_SHARED indicates that the blocks are shared, and will need to=
 be
> - * unshared as part a write.
> + * * IOMAP_F_SHARED: indicates that the blocks are shared, and will need=
 to be
> + *	unshared as part a write.
>   *
> - * IOMAP_F_MERGED indicates that the iomap contains the merge of multipl=
e block
> - * mappings.
> + * * IOMAP_F_MERGED: indicates that the iomap contains the merge of mult=
iple block
> + *	mappings.
>   *
> - * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
> - * buffer heads for this mapping.
> + * * IOMAP_F_BUFFER_HEAD: indicates that the file system requires the us=
e of
> + *	buffer heads for this mapping.
>   *
> - * IOMAP_F_XATTR indicates that the iomap is for an extended attribute e=
xtent
> - * rather than a file data extent.
> + * * IOMAP_F_XATTR: indicates that the iomap is for an extended attribut=
e extent
> + *	rather than a file data extent.
>   */

Why don't use kernel-doc comments to describe flags?

> +/**
> + * struct iomap_folio_ops - buffered writes folio folio reference count =
helpers
> + *
> + * A filesystem can optionally set folio_ops in a &struct iomap mapping =
it returns to
> + * override the default get_folio and put_folio for each folio written t=
o.  This only applies
> + * to buffered writes as unbuffered writes will not typically have folio=
s associated with them.
> + *
> + * @get_folio: iomap defaults to iomap_get_folio() (which calls __filema=
p_get_folio()) if the
> + * 	filesystem did not provide a get folio op.
> + *
> + * @put_folio: when get_folio succeeds, put_folio will always be called =
to do any cleanup work
> + * 	necessary. put_folio is responsible for unlocking and putting @folio.
> + *
> + * @iomap_valid: check that the cached iomap still maps correctly to the=
 filesystem's internal
> + * 	extent map. FS internal extent maps can change while iomap is iterat=
ing a cached iomap, so
> + * 	this hook allows iomap to detect that the iomap needs to be refreshe=
d during a long running
> + * 	write operation.
> + *
> + *	The filesystem can store internal state (e.g. a sequence number) in i=
omap->validity_cookie
> + *	when the iomap is first mapped to be able to detect changes between m=
apping time and whenever
> + *	.iomap_valid() is called.
> + *
> + *	This is called with the folio over the specified file position held l=
ocked by the iomap code.
> + *	This is useful for filesystems that have dynamic mappings (e.g. anyth=
ing other than zonefs).
> + *	An example reason as to why this is necessary is writeback doesn't ta=
ke the vfs locks.

Nice, this one has kernel-doc.

Thanks for review.

--=20
An old man doll... just what I always wanted! - Clara

--0VIesbtBcvOdTYu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGdBMwAKCRD2uYlJVVFO
o1CXAP4vvkxOjGSlp8K00eEDRusLv2denEMjLs23Xbw90+5pDAD/bmwirKa+eh7v
rg3OvhuhDCRffQ0bVvdaGsuCzGqeBwQ=
=6I7s
-----END PGP SIGNATURE-----

--0VIesbtBcvOdTYu/--
