Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A26242F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLTXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:23:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEDFC061383;
        Wed, 12 Aug 2020 12:23:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so2904933otr.1;
        Wed, 12 Aug 2020 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3Cr4pfPW/YIMfrMO6Kop+sRalHz9diw410o8LHQ/e4=;
        b=IJJWjqChkDN7AxslJValrnXD0Nk6xe9QloctxKFdCrofiMt2mIufNNb/1MGHukP5eh
         fC9RA8ZfP1m6vDPBsR40Z7rozTQcN2nC8dh/Xu7C8PEKOaKPXw+w6PErZPBGJ7eb0Olt
         0D1VJFkiVcpAt+trbAx3RRm2pHS+qVI7e7LZ8VJSNut9qQgMq87KMAWkCF5FbFaaH9Xz
         0j/hS9NfpgbW9uX12feHv1PSpgaGQGJKNzxn8kdqYHd4VC1/XPl/KpBeztLdAvKEam4K
         +TiAkPKlEt9fcQaqqHuDSWx+UnrUUwwGrgsnReFWO3XS62M01QyL1oBFSrtoVZAVAhht
         zstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3Cr4pfPW/YIMfrMO6Kop+sRalHz9diw410o8LHQ/e4=;
        b=QGrSI8vhPLvfNKxQElL0SkN5Z6M3BHlrZCiCBBd+EThFvBqaBsZKfJDb+2dQ5bDg1s
         GsIr+DfCI2ZZ97JSPAJmZwhyHMrl9xZ/EB2+q1T1EvJrVdztsbisnNqvT0rK5xWKs50w
         w3JnzYXrzXTbZJwpV2nXdg8R+iopErM929ycVeE5q2i6brs3SBfwUJSY/V5Dz+VcuDlH
         Uib9LyUSt8W3F1eCkpCxi+dSDbxzwRGCJ8LTMgisTQFRZcc3nbZRprybd8Vv89ydg9rC
         CEiz4Lk7VZ/luxUtA0Cn1w6bTlVyMYx3FF/cNs9o1S4mTxwg+ijPztqxxe5nonONhiH4
         2rpw==
X-Gm-Message-State: AOAM531q2oaDdJBsTUvdsR15rg2TS+8Dbq8ifGHsZFRfeolsrv6QFtZT
        ZARZy1VzJuv072W3MibcUS+1iMRL64Ra6PF9bxs=
X-Google-Smtp-Source: ABdhPJwj7n8XKdePeQxHzI7WTX70roxjqjWF2x4UouMgk2LTW19UlThhC6SmyW2s2o29f7MbMfFsg/haBYQCPy+b+Rg=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr1166532otn.162.1597260212865;
 Wed, 12 Aug 2020 12:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com> <20200812191525.1120850-2-dburgener@linux.microsoft.com>
In-Reply-To: <20200812191525.1120850-2-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 12 Aug 2020 15:21:58 -0400
Message-ID: <CAEjxPJ61+Dusa-i_uggdGDQ-3iGb7+JDJkbsC48DpKpx_gEJSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] selinux: Create function for selinuxfs directory cleanup
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:15 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Separating the cleanup from the creation will simplify two things in
> future patches in this series.  First, the creation can be made generic,
> to create directories not tied to the selinux_fs_info structure.  Second,
> we will ultimately want to reorder creation and deletion so that the
> deletions aren't performed until the new directory structures have already
> been moved into place.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 41 ++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 131816878e50..fc914facb48f 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -355,6 +355,9 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
>  static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>                         unsigned long *ino);
>
> +/* declaration for sel_remove_old_policy_nodes */
> +static void sel_remove_entries(struct dentry *de);
> +
>  static ssize_t sel_read_mls(struct file *filp, char __user *buf,
>                                 size_t count, loff_t *ppos)
>  {
> @@ -509,11 +512,35 @@ static const struct file_operations sel_policy_ops = {
>         .llseek         = generic_file_llseek,
>  };
>
> +static void sel_remove_old_policy_nodes(struct selinux_fs_info *fsi)
> +{
> +       u32 i;
> +
> +       /* bool_dir cleanup */
> +       for (i = 0; i < fsi->bool_num; i++)
> +               kfree(fsi->bool_pending_names[i]);
> +       kfree(fsi->bool_pending_names);
> +       kfree(fsi->bool_pending_values);
> +       fsi->bool_num = 0;
> +       fsi->bool_pending_names = NULL;
> +       fsi->bool_pending_values = NULL;
> +
> +       sel_remove_entries(fsi->bool_dir);
> +
> +       /* class_dir cleanup */
> +       sel_remove_entries(fsi->class_dir);
> +
> +       /* policycap_dir cleanup */
> +       sel_remove_entries(fsi->policycap_dir);

This one shouldn't have its entries removed anymore.
