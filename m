Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB92793287
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjIEX2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjIEX2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:28:14 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A939E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 16:28:07 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D11FE240028
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 01:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1693956485; bh=tFVPhBBWaN4G4tPkkecVkR72dlmFDkMrFM8fwsAtMZ8=;
        h=Mime-Version:Content-Transfer-Encoding:Date:Message-Id:Cc:Subject:
         From:To:From;
        b=c058gnytzEYpeZDYe4PGKWPHtC8Ss7YQo+OSm5riUXyX7T936oBtFmvbjZSYybr5v
         qTl9jRKu1sQyGnRqTvIYeGXsomDjdbQ9k6YvkL0iWNQBR5Zs7a05qR25t/SR5F+PGF
         VYhvxPgxtdpMGe+98djPImonFwLPEfLGMtMp8oFINTTmqHbRj9yvGvhmufXis6XALJ
         59ijHA0Xzv9nCEEFZswJ1c89BzwXvd8awj7HA8ww925yN1+04H2bP8KM03Q5xQTmPB
         dJgOa2A6aCyXSMCapEnEtaJaLU+gpbMpRaGKV6bcgGFlF6i8DNlp6vG7UmF0RD5blL
         PJH0DIxlpCtaA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RgMBD5hQJz6tx5;
        Wed,  6 Sep 2023 01:28:04 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 23:27:01 +0000
Message-Id: <CVBDFOQTOWJ4.2NWF9JNF4IUFL@posteo.de>
Cc:     "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@poochiereds.net>,
        "Christian Brauner" <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-man@vger.kernel.org>
Subject: Re: [PATCH] name_to_handle_at.2,fanotify_mark.2: Document the
 AT_HANDLE_FID flag
From:   "Tom Schwindl" <schwindl@posteo.de>
To:     "Amir Goldstein" <amir73il@gmail.com>,
        "Alejandro Colomar" <alx.manpages@gmail.com>
References: <20230903120433.2605027-1-amir73il@gmail.com>
In-Reply-To: <20230903120433.2605027-1-amir73il@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Sun Sep 3, 2023 at 2:04 PM CEST, Amir Goldstein wrote:
> A flag to indicate that the requested file_handle is not intended
> to be used for open_by_handle_at(2) and may be needed to identify
> filesystem objects reported in fanotify events.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Alejandro,
>
> This is a followup on AT_HANDLE_FID feature from v6.5.
>
> Thanks,
> Amir.
>
>  man2/fanotify_mark.2     | 11 +++++++++--
>  man2/open_by_handle_at.2 | 42 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> index 3f85deb23..8e885af69 100644
> --- a/man2/fanotify_mark.2
> +++ b/man2/fanotify_mark.2
> @@ -743,10 +743,17 @@ do not specify a directory.
>  .B EOPNOTSUPP
>  The object indicated by
>  .I pathname
> -is associated with a filesystem that does not support the encoding of fi=
le
> -handles.
> +is associated with a filesystem
> +that does not support the encoding of file handles.
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Calling
> +.BR name_to_handle_at (2)
> +with the flag
> +.BR AT_HANDLE_FID " (since Linux 6.5)"
> +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> +can be used as a test
> +to check if a filesystem supports reporting events with file handles.
>  .TP
>  .B EPERM
>  The operation is not permitted because the caller lacks a required capab=
ility.
> diff --git a/man2/open_by_handle_at.2 b/man2/open_by_handle_at.2
> index 4061faea9..4cfa21d9c 100644
> --- a/man2/open_by_handle_at.2
> +++ b/man2/open_by_handle_at.2
> @@ -109,17 +109,44 @@ structure as an opaque data type: the
>  .I handle_type
>  and
>  .I f_handle
> -fields are needed only by a subsequent call to
> +fields can be used in a subsequent call to
>  .BR open_by_handle_at ().
> +The caller can also use the opaque
> +.I file_handle
> +to compare the identity of filesystem objects
> +that were queried at different times and possibly
> +at different paths.
> +The
> +.BR fanotify (7)
> +subsystem can report events
> +with an information record containing a
> +.I file_handle
> +to identify the filesystem object.
>  .PP
>  The
>  .I flags
>  argument is a bit mask constructed by ORing together zero or more of
> -.B AT_EMPTY_PATH
> +.BR AT_HANDLE_FID ,
> +.BR AT_EMPTY_PATH ,
>  and
>  .BR AT_SYMLINK_FOLLOW ,
>  described below.
>  .PP
> +When
> +.I flags
> +contain the
> +.BR AT_HANDLE_FID " (since Linux 6.5)"
> +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> +flag, the caller indicates that the returned
> +.I file_handle
> +is needed to identify the filesystem object,
> +and not for opening the file later,
> +so it should be expected that a subsequent call to
> +.BR open_by_handle_at ()
> +with the returned
> +.I file_handle
> +may fail.
> +.PP
>  Together, the
>  .I pathname
>  and
> @@ -363,8 +390,14 @@ capability.
>  .B ESTALE
>  The specified
>  .I handle
> -is not valid.
> +is not valid for opening a file.
>  This error will occur if, for example, the file has been deleted.
> +This error can also occur if the
> +.I handle
> +was aquired using the

This should probably be s/aquired/acquired/

> +.B AT_HANDLE_FID
> +flag and the filesystem does not support
> +.BR open_by_handle_at ().
>  .SH VERSIONS
>  FreeBSD has a broadly similar pair of system calls in the form of
>  .BR getfh ()
> @@ -386,6 +419,9 @@ file handles, for example,
>  .IR /proc ,
>  .IR /sys ,
>  and various network filesystems.
> +Some filesystem support the translation of pathnames to

You should use the plural, filesystems, here.

> +file handles, but do not support using those file handles in
> +.BR open_by_handle_at ().
>  .PP
>  A file handle may become invalid ("stale") if a file is deleted,
>  or for other filesystem-specific reasons.

