Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAF49E4DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiA0Omq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 09:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242565AbiA0Omm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643294562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnP/kp//OPcdbcqLzEb2s142Kys19/Yw+EAQfbwSGZc=;
        b=Iw93TtBfxvCQJ5+9DLRVFAAxtnQtv7uNi44ojhrX3LGC37Z3anux7uIqfXQo86ZzVHZEjH
        15iSic90sLFrKMAm/zwNbGLmNZVK7Q7hv7jH5BwsEMYLdtYmBidgz6qBh3RSRw/YuSeqCs
        jStKu3Bl4DYrFIWzKlqaQNLep5ao6P4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-361F9fXzPaaw00oCnSVz_w-1; Thu, 27 Jan 2022 09:42:41 -0500
X-MC-Unique: 361F9fXzPaaw00oCnSVz_w-1
Received: by mail-il1-f198.google.com with SMTP id l10-20020a056e020dca00b002badca9390eso437697ilj.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 06:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnP/kp//OPcdbcqLzEb2s142Kys19/Yw+EAQfbwSGZc=;
        b=ZZuzIgF5olWA6Nupfum/yGNCmsTW7y02QSXnLmcjYiGTRMCGWaU+0i5H3znvFpGYUc
         +AvZgMY2HkIQWFZTM9weARUEl5J0xsI1CLyIsfOCOVkftCiJK3HSQpli3g0UnBSB7/R0
         PkThaqJ2Oz3P/ZPjcbtTS3iL/V8HW4AlNK2BJq8hke79uKIfse/MnSk6oqrRxCn2JfTW
         e1ZWabGDdL2aYKQfbDPIdXMDpBOzbtz/3/2gBTISFco1NnFMYFokgs5fTM0Shea1VcpG
         9rPk9l9GXd05EYvLNsuOYNXFXz5UIhQUOtIi+2KqSVUkgAblr0Kok+fv6xYqMjuIfqHQ
         Jgkw==
X-Gm-Message-State: AOAM530BhyyJ/X2+CvLH9sHTdFRPKW6tERodZaZGfOn08Dq4K/UqFIyh
        ck8ZJwIZIIRU38iuLtWLHMx5ksosj7PgkW5wgKSEH3A8yeFqoDWtZbqPIHX3siIJYF26ZXz2tmT
        JMtbas0vSWwo/VKGIUc7Jf96Ixj9Bq1VwHEi/OUq89g==
X-Received: by 2002:a02:a385:: with SMTP id y5mr1820289jak.307.1643294560185;
        Thu, 27 Jan 2022 06:42:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwncapORF0ZQk5VpSVVWpknXLZo52GxbMt0pWrFwOR5bY4UtTCKnZl9EzarxJ9thg7GRFvmn7bhtRgw7eXFVCQ=
X-Received: by 2002:a02:a385:: with SMTP id y5mr1820277jak.307.1643294559934;
 Thu, 27 Jan 2022 06:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20210721113057.993344-1-rbergant@redhat.com> <2117192.1629980953@warthog.procyon.org.uk>
In-Reply-To: <2117192.1629980953@warthog.procyon.org.uk>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Thu, 27 Jan 2022 15:42:29 +0100
Message-ID: <CACWnjLwb13i=g0+CWt5JV3ho4qtRF2egV7BZkoYCB=Bj7O2j=Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David,

  i came up with the following approach, i drop the sloppy booleans
from cifs/nfs and leave it at fs_context level

, let me know what you think and ill send as new version :

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 7ec35f3f0a5f..5a8c074df74a 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -866,7 +866,7 @@ static int smb3_fs_context_parse_param(struct
fs_context *fc,
     if (!skip_parsing) {
         opt = fs_parse(fc, smb3_fs_parameters, param, &result);
         if (opt < 0)
-            return ctx->sloppy ? 1 : opt;
+            return fc->sloppy ? 1 : opt;
     }

     switch (opt) {
@@ -1412,7 +1412,7 @@ static int smb3_fs_context_parse_param(struct
fs_context *fc,
         ctx->multiuser = true;
         break;
     case Opt_sloppy:
-        ctx->sloppy = true;
+        fc->sloppy = true;
         break;
     case Opt_nosharesock:
         ctx->nosharesock = true;
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index e54090d9ef36..52a67a96fb67 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -155,7 +155,6 @@ struct smb3_fs_context {
     bool uid_specified;
     bool cruid_specified;
     bool gid_specified;
-    bool sloppy;
     bool got_ip;
     bool got_version;
     bool got_rsize;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..3c1c999fc1fb 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -155,8 +155,14 @@ int vfs_parse_fs_param(struct fs_context *fc,
struct fs_parameter *param)
     if (ret != -ENOPARAM)
         return ret;

-    return invalf(fc, "%s: Unknown parameter '%s'",
-              fc->fs_type->name, param->key);
+    /* We got an invalid parameter, but sloppy may have been specified
+     * later on param string. Let's wait to process whole params to return
+     * EINVAL */
+
+    fc->param_inval = true;
+    errorf(fc, "%s: Unknown parameter '%s'",fc->fs_type->name, param->key);
+
+    return 0;
 }
 EXPORT_SYMBOL(vfs_parse_fs_param);

@@ -227,6 +233,9 @@ int generic_parse_monolithic(struct fs_context
*fc, void *data)
         }
     }

+    if (!fc->sloppy && fc->param_inval)
+        ret = -EINVAL;
+
     return ret;
 }
 EXPORT_SYMBOL(generic_parse_monolithic);
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ea17fa1f31ec..c9ff68e17b68 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -482,7 +482,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,

     opt = fs_parse(fc, nfs_fs_parameters, param, &result);
     if (opt < 0)
-        return ctx->sloppy ? 1 : opt;
+        return fc->sloppy ? 1 : opt;

     if (fc->security)
         ctx->has_sec_mnt_opts = 1;
@@ -837,7 +837,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
          * Special options
          */
     case Opt_sloppy:
-        ctx->sloppy = true;
+        fc->sloppy = true;
         dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
         break;
     }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 12f6acb483bb..9febdc95b4d0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -80,7 +80,6 @@ struct nfs_fs_context {
     bool            internal;
     bool            skip_reconfig_option_check;
     bool            need_mount;
-    bool            sloppy;
     unsigned int        flags;        /* NFS{,4}_MOUNT_* flags */
     unsigned int        rsize, wsize;
     unsigned int        timeo, retrans;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..06a4b72a0f98 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -110,6 +110,8 @@ struct fs_context {
     bool            need_free:1;    /* Need to call ops->free() */
     bool            global:1;    /* Goes into &init_user_ns */
     bool            oldapi:1;    /* Coming from mount(2) */
+    bool                    sloppy:1;       /* If fs support it and
was specified */
+    bool                    param_inval:1;  /* If set, check sloppy value */
 };

 struct fs_context_operations {

On Thu, Aug 26, 2021 at 2:29 PM David Howells <dhowells@redhat.com> wrote:
>
> Roberto Bergantinos Corpas <rbergant@redhat.com> wrote:
>
> > With addition of fs_context support, options string is parsed
> > sequentially, if 'sloppy' option is not leftmost one, we may
> > return ENOPARAM to userland if a non-valid option preceeds sloopy
> > and mount will fail :
> >
> > host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> > mount.nfs: an incorrect mount option was specified
> > host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> > host#
> >
> > This patch correct that behaviour so that sloppy takes precedence
> > if specified anywhere on the string
>
> It's slightly overcorrected, but that probably doesn't matter.
>
> I wonder if we should put a "bool sloppy" in struct fs_context, put the
> handling in vfs_parse_fs_param() (ie. skip the error message).
>
> David
>

