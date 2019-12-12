Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6813C11D79C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfLLUCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 15:02:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730284AbfLLUCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576180920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb8TmGk+a9HjoYdlVzo58zXnc/ROW/PTOkZPr16nz2Q=;
        b=IaavmPRt9zNg8iW4gvdsBXazkxV31bY8w4kWt4F8RAwDzahv/MaMYNybAzUihp+S709/7c
        CjKnS3e3gjvK8D0shsT7V4wS+DuUcR7JLja4AQD7koqgR6S8wG4fhPU0+unFyCs9L/9idh
        vLl8HfASEWU6rZ42Hhuml+T1x+JHR2s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-GvloIGRDNkSGG3P1G2piyQ-1; Thu, 12 Dec 2019 15:01:59 -0500
X-MC-Unique: GvloIGRDNkSGG3P1G2piyQ-1
Received: by mail-qt1-f197.google.com with SMTP id l4so172985qte.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 12:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hb8TmGk+a9HjoYdlVzo58zXnc/ROW/PTOkZPr16nz2Q=;
        b=M0R1PXF/7Qt3NfNA8dvVDQBwaqMm/qToob9dYddPN6peyhBy4qqiubRz10ycV7C0l0
         82KTRDImfbj2wBmdqFi/vk2uBOibC5y38TH7ARUly12vzk2ZqcJE5fDQXaoxtaJeGExI
         KG6jQsbXfbv+tYqFwql8RDxZoskpMwf933iixoyqe8Wu8FMJ9qrul57yuuKuUTUS5uz8
         kTbF++q+AB+I6PyCdoiKBdI2TEkVag6sB8dnfoR5HQJ4jbCrxFM9wIJBAE9SZ12i0D5l
         3V9syVbp4UJTrDXPw0kK5GvboaX/i78XnEW9AmLeVpxvXUYS4zHT2Ai1YQE2X5Vjoh6T
         eDPw==
X-Gm-Message-State: APjAAAUPwe662OcMDWBGopDBES5UjgkDWOSTss8aDiKMq/dqE/EvW776
        LUB/eFpLvZVXO2qMdafE2D/10naF9+EwvEMN+tfPUBRahqkM7WEW/MKwJY9eiXxUgb/2ArXsZGT
        i4LMHMKje6K1pmkogTls0Jrx38Q==
X-Received: by 2002:a37:65c8:: with SMTP id z191mr10018888qkb.176.1576180918814;
        Thu, 12 Dec 2019 12:01:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwAvAkoCbeKTQnT+w3TgLyOTd0Fj7dn/2e/2ltCsdsrrquGwZiDl6tub5yxZG3D4TI1/gPcZg==
X-Received: by 2002:a37:65c8:: with SMTP id z191mr10018819qkb.176.1576180918172;
        Thu, 12 Dec 2019 12:01:58 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id f19sm2075294qkk.69.2019.12.12.12.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:01:57 -0800 (PST)
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191212145042.12694-1-labbott@redhat.com>
 <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
 <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com>
Date:   Thu, 12 Dec 2019 15:01:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 12:56 PM, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 9:47 AM Laura Abbott <labbott@redhat.com> wrote:
>>
>> Good point, I think I missed how that code flow worked for printing
>> out the error. I debated putting in a dummy parse_param but I
>> figured that squashfs wouldn't be the only fs that didn't take
>> arguments (it's in the minority but certainly not the only one).
> 
> I think printing out the error part is actually fine - it would act as
> a warning for invalid parameters like this.
> 
> So I think a dummy parse_param that prints out a warning is likely the
> right thing to do.
> 
> Something like the attached, perhaps? Totally untested.
> 
>                 Linus
> 

That doesn't quite work. We can't just unconditionally return success
because we rely on -ENOPARAM being returned to parse the source option
back in vfs_parse_fs_param. I think ramfs may also be broken for the
same reason right now as well from reading the code. We also rely on the
fallback source parsing for file systems that do have ->parse_param.

We could do all this in squashfs but given other file systems that don't
have args will also hit this we could just make it generic. The following
works for me (under commenting and poor name choices notwithstanding)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..5e45e36d51e7 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -302,6 +302,50 @@ int fs_lookup_param(struct fs_context *fc,
  }
  EXPORT_SYMBOL(fs_lookup_param);
  
+enum {
+        NO_OPT_SOURCE,
+};
+
+static const struct fs_parameter_spec no_opt_fs_param_specs[] = {
+        fsparam_string  ("source",              NO_OPT_SOURCE),
+        {}
+};
+
+const struct fs_parameter_description no_opt_fs_parameters = {
+        .name           = "no_opt_fs",
+        .specs          = no_opt_fs_param_specs,
+};
+
+int fs_no_opt_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+        struct fs_parse_result result;
+        int opt;
+
+        opt = fs_parse(fc, &no_opt_fs_parameters, param, &result);
+        if (opt < 0) {
+                /* Just log an error for backwards compatibility */
+                errorf(fc, "%s: Unknown parameter '%s'",
+                      fc->fs_type->name, param->key);
+                return 0;
+        }
+
+        switch (opt) {
+        case NO_OPT_SOURCE:
+                if (param->type != fs_value_is_string)
+                        return invalf(fc, "%s: Non-string source",
+					fc->fs_type->name);
+                if (fc->source)
+                        return invalf(fc, "%s: Multiple sources specified",
+					fc->fs_type->name);
+                fc->source = param->string;
+                param->string = NULL;
+                break;
+        }
+
+        return 0;
+}
+EXPORT_SYMBOL(fs_no_opt_parse_param);
+
  #ifdef CONFIG_VALIDATE_FS_PARSER
  /**
   * validate_constant_table - Validate a constant table
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 0cc4ceec0562..07a9b38f7bf5 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -18,6 +18,7 @@
  
  #include <linux/fs.h>
  #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
  #include <linux/vfs.h>
  #include <linux/slab.h>
  #include <linux/mutex.h>
@@ -358,6 +359,7 @@ static int squashfs_reconfigure(struct fs_context *fc)
  static const struct fs_context_operations squashfs_context_ops = {
  	.get_tree	= squashfs_get_tree,
  	.reconfigure	= squashfs_reconfigure,
+	.parse_param	= fs_no_opt_parse_param,
  };
  
  static int squashfs_init_fs_context(struct fs_context *fc)
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..f67b2afcc491 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -106,6 +106,8 @@ static inline bool fs_validate_description(const struct fs_parameter_description
  { return true; }
  #endif
  
+extern int fs_no_opt_parse_param(struct fs_context *fc, struct fs_parameter *param);
+
  /*
   * Parameter type, name, index and flags element constructors.  Use as:
   *

