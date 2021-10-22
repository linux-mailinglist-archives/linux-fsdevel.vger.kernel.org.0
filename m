Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5860C4372D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 09:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJVHhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVHhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:37:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6EC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 00:34:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id k3so3326740ilu.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6UozaycRLdSNBX06iYfj5mv3VOkm7vRg+H7P6sdZJM=;
        b=HpdFp6jcV7xB0XOMaDhJn9i7NMtW+287A7p9wfzPvkl8SpSslwaiv5vu4t4/1+rC9u
         MpgkHyiAddaq1l4cQpifClweuqwaDoEeUhbXbUyFuVPTurXtRn2zpvuwmamECmfF8oSV
         XPnUIqhpradVg2cs0ShLiw+wpx2LPwn81RXKm35S7jMK5C1E4+DzDJrWWAo0Mc/lHoVD
         krwZOk3eca3I0U4UJtrg8PXmnRcZwyuWuYPM6/86ka5Y3zCc4chFWtOCuWJrPYd2Hg94
         9iJSU19Z6ntFEqc/uziiIThAXDdEvoPJOHSFU0f8sGdqsp9U7NUuhMGdeNoJIEQuBvui
         mGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6UozaycRLdSNBX06iYfj5mv3VOkm7vRg+H7P6sdZJM=;
        b=f4k0xwDpkjWBuDP/prA1MOg6Db+ztaJ9u5n8Byn39L+hMuXR9hHYlEjiaS3Kjte6qw
         cD/9DZfNkxpBVUnXD5q3QWuYJCf+T3V3GTDb66rbO2ul3KPTOC0Rjt+VyDJD87Wl0tVI
         G+XKs5Ri1Tj3OiPzTS6QlELZp40mSGzovmG0DjjKPPSobujy+6y0+EO6kwgocgemJtFN
         lHitxH33o8u1xqvdaRhbLBr3Ww3FtSm9MoRag9g/hACS6EKYIgGgoiDv1iuozmXuFkxp
         ahPKPnrmZ6iutnnOzYuD+lFyvdr1VoHxD2BQ9H/ZCKqq+x0hf+nSiUhjy/rk5uvsGph6
         aEbQ==
X-Gm-Message-State: AOAM533QRd9d7khOxdNAd7aolcaerfzqBZL+TO2JuPhCSSxgHg2si7us
        404yexYLMkinAa+gfLBbYMSXOVAGbt2ipNhgtvU=
X-Google-Smtp-Source: ABdhPJzR+jBN3QcSkSJzZWTcIKVexJ0kGBC4TT+iJUWDaogAEW8kd5R87UNA4hYFbLbCfYkLIIaMjKYe6ZfqE7CH6hw=
X-Received: by 2002:a92:cd82:: with SMTP id r2mr7238138ilb.198.1634888094082;
 Fri, 22 Oct 2021 00:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiJrEOHyHeY49dLMaJ4-8=RCGc+oawyWPrkuP28NRsT3Q@mail.gmail.com>
 <CAJfpegspE8e6aKd47uZtSYX8Y-1e1FWS0VL0DH2Skb9gQP5RJQ@mail.gmail.com>
In-Reply-To: <CAJfpegspE8e6aKd47uZtSYX8Y-1e1FWS0VL0DH2Skb9gQP5RJQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Oct 2021 10:34:42 +0300
Message-ID: <CAOQ4uxgxQkrYwofz78Sducss5wq21zSM+ak92F+k7mfXUo4=Hg@mail.gmail.com>
Subject: Re: [RFC] Optional FUSE flush-on-close
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 9:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Oct 2021 at 18:12, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Miklos,
> >
> > We have a use case where fuse_sync_writes() is disruptive
> > to the workload.
> >
> > Some applications, which are not under our control do
> > open(O_RDONLY);fstat();close() and are made to block waiting on writes
> > that they are not responsible for.
> >
> > Looking at other network filesystems, cifs and nfs only flush on close
> > for FMODE_WRITE files.
> > Some older SMB flavors (smb1, smb2) do also flush on RDONLY files.
> >
> > In particular, our FUSE filesystem does not even implement FLUSH
> > and it has writeback caching disabled, so the value of flush on close
> > is even more questionable.
> >
> > Would you be willing to consider a patch that makes flush-on-close
> > behavior optional for RDONLY files?
> > If so, should I make this option available only when filesystem
> > does not implement FLUSH or independent?
> > Should I make an option to completely disable flush-on-close
> > (i.e. like most disk filesystems)?
>
> Flushing dirty pages for writable files  is mandatory for the
> writeback cache case.  Otherwise you are correct, this could be
> disabled.
>
> How about FOPEN_NOFLUSH?
>

Sounds good to me.

BTW, regardless of $SUBJECT, I've learned that cifs_flush() behaves a bit
differently than nfs_file_flush().

cifs_flush() flushes the local caches, but does not issue a flush command to
the server while nfs_file_flush() also sends/waits for a commit
request to the server.

IIUC, nfs4_file_flush() behaves like nfs_file_flush() if the client
holds a write
delegation (i.e. like writeback caching) and like cifs_flush() without
write delegation.

I am guessing this is all intentional (?) but it makes me wonder because this
logic mixes cache coherency considerations with durability considerations.
IOW, I am not sure why nfs server will end up fsyncing the file on server
on nfs client close and smb server will not.

Thanks,
Amir.
