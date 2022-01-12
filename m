Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2D48BF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 08:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351322AbiALH6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 02:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiALH6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:58:10 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ADCC06173F;
        Tue, 11 Jan 2022 23:58:10 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d3so1544233ilr.10;
        Tue, 11 Jan 2022 23:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVQHC0GxTkVqAfD+KHCO6cWHLTOb4XHRFU2PnvbvOvM=;
        b=d5xRdIanQ2tq7k14loEE90bkerVEyih10QULvUdYkZrIJRS6CBKA3PsAg/i90aPeS6
         v2tR9OBFWTjrK9SodH+labYJD4Oib5tDw+GL2xDq6/ZRRS7kC4yaC1CU6nwVyouOTmot
         1ImFEuol8PxFJYlprhPPgpKGNy+iH15DJcqAhi6vpzRv1MQqOQYkpz+ObjBGsfV4TJ8G
         7Kgdo5f8r9A/xVkkQ/tgzzpAC+/Xyh7JqiEzPY5IL2MGJzKS91VCI6xdE/Irug1baLCE
         WMbfZ4oGcINBVPvEgnUndJUQsUAtysVnxbQQid1KXbg3LjOKuDr8pK0VkqWGkjwYFZvX
         6qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVQHC0GxTkVqAfD+KHCO6cWHLTOb4XHRFU2PnvbvOvM=;
        b=ypDN2pviiJY2jAVZXsS2qULf6ePUQ81AGtlMmp8cFPFsSbVAsKAwE959YV/umXg6t+
         1WLkWbVzUwBs3fFeOnWbzPFcOjIAHL/KOVpoLfLp2VnC0g9RGOITB/+6OaDKXRdW9ema
         6VTl0Pgs4zTuA6ykZOI287cxkuFug+flalyw1kcsSlyRG99lQoe5LnM3uVmZ6/EmC2Vx
         LmYMzFBLsisg/Wd+ZAjpu+g44FNKedUH0XnvuAzBRCLLMBG8JKJ2t2HuE9r6KGLxkFc9
         ZBo7410Q1eB+HEwkmZ/djM/mErZBX1Rbqi/gUEFhziPTHna4vYqoaCegSHZ64PpTM1eD
         n0+A==
X-Gm-Message-State: AOAM531varrTt4WXNu2LW30Ua3CeFYNrbs1XzalprVwQS80rX5VsWByg
        s3t1/wsog/IrXsNVmKAkWMWxPHWAKNvMIb3eySY=
X-Google-Smtp-Source: ABdhPJxj9W6HbPxWl7TmaDWpcZBQYEtjUpLThUvKEIVgKtoBq96Xsi2ow12ffnF5FTKzaa3lubY4jIyqZphvUBcd/Xk=
X-Received: by 2002:a05:6e02:b21:: with SMTP id e1mr4511683ilu.254.1641974289495;
 Tue, 11 Jan 2022 23:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20220111074309.GA12918@kili> <Yd1ETmx/HCigOrzl@infradead.org>
In-Reply-To: <Yd1ETmx/HCigOrzl@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 12 Jan 2022 09:57:58 +0200
Message-ID: <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
To:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        lance.shelton@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ntfs3@lists.linux.dev,
        Steve French <sfrench@samba.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 4:10 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 11, 2022 at 10:43:09AM +0300, Dan Carpenter wrote:
> > Hello Richard Sharpe,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch bc66f6805766: "NFS: Support statx_get and statx_set ioctls"
> > from Dec 27, 2021, leads to the following Smatch complaint:
>
> Yikes, how did that crap get merged?

Did it? The bots are scanning through patches on ML:

https://lore.kernel.org/linux-nfs/20211227190504.309612-1-trondmy@kernel.org/

> Why the f**k does a remote file system need to duplicate stat?
> This kind of stuff needs a proper discussion on linux-fsdevel.

+ntfs3 +linux-cifs +linux-api

The proposal of statx_get() is very peculiar.
statx() was especially designed to be extended and accommodate
a diversity of filesystem attributes.

Moreover, NFSv4 is not the only fs that supports those extra attributes.
ntfs3 supports set/get of dos attrib bits via xattr SYSTEM_NTFS_ATTRIB.
cifs support set/get of CIFS_XATTR_ATTRIB and CIFS_XATTR_CREATETIME.

Not only that, but Linux now has ksmbd which actually emulates
those attributes on the server side (like samba) by storing a samba
formatted blob in user.DOSATTRIB xattr.
It should have a way to get/set them on filesystems that support them
natively.

The whole thing shouts for standardization.

Samba should be able to get/set the extra attributes by statx() and
ksmbd should be able to get them from the filesystem by vfs_getattr().

WRT statx_set(), standardization is also in order, both for userspace
API and for vfs API to be used by ksmbd and nfsd v4.

The new-ish vfs API fileattr_get/set() comes to mind when considering
a method to set the dos attrib bits.
Heck, FS_NODUMP_FL is the same as FILE_ATTRIBUTE_ARCHIVE.
That will also make it easy for filesystems that support the fileattr flags
to add support for FS_SYSTEM_FL, FS_HIDDEN_FL.

There is a use case for that. It can be inferred from samba config options
"map hidden/system/archive" that are used to avoid the cost of getxattr
per file during a "readdirplus" query. I recently quantified this cost on a
standard file server and it was very high.

Which leaves us with an API to set the 'time backup' attribute, which
is a "mutable creation time" [*].
cifs supports setting it via setxattr and I guess ntfs3 could use an
API to set it as well.

One natural interface that comes to mind is:

struct timespec times[3] = {/* atime, mtime, crtime */}
utimensat(dirfd, path, times, AT_UTIMES_ARCHIVE);

and add ia_crtime with ATTR_CRTIME to struct iattr.

Trond,

Do you agree to rework your patches in this direction?
Perhaps as the first stage, just use statx() and ioctls to set the
attributes to give enough time for bikeshedding the set APIs
and follow up with the generic set API patches later?

Thanks,
Amir.

[*] I find it convenient to use the statx() terminology of "btime"
to refer to the immutable birth time provided by some filesystems
and to use "crtime" for the mutable creation time for archiving,
so that at some point, some filesystems may provide both of
these times independently.
