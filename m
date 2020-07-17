Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51272244AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGQTzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgGQTzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:55:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BCC0619D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:55:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so12265656wrs.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RP63dmrV9ylHK1uaqhkLWSiaaQyqrPTqTpp/H10baw0=;
        b=V+O4k6TiO5x+8eMiNuGZJMf8IUTS5kTuIRsCZrs71JIMn0F3w+ETCHbm/DEnOG2wLJ
         9ML02aq2k3sHf8+lyrIAOW2OYQv3J0xJd8+mNSG15TigEg2U9LsP/VMaMAxUGkIlUgiY
         3gUGEfU7gKAn61P9UcVGtiI9XRYIwNmV10PcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RP63dmrV9ylHK1uaqhkLWSiaaQyqrPTqTpp/H10baw0=;
        b=D0qIoGdxuzsjJ4nPbz5rhdToSj9cHaM5zNCHs6HoeN+iL0Em2s170RBpEaikt7mok5
         8Ot3HbCrrD7zo7jjWnkp9zGIJOoUY0DEOKQlsIVvGPu4wRQL2iEMLP7offWHmdEh7p+n
         L+Y2fLTB5S9qm8wV5s9lsRf3Az1XbRxUekXnkiON9b5uq1Ef/AXVyhD8uk4TvadbDFUq
         TGE3/oxb9CQ2FVTNGNOZzgO7OkjWM5lv6HX2EB0jlPFzIy8bySs8CzrPmUJcxk+ELzns
         7mcDxjV1hP78KtblJz2h2sOAjo+U0oGam6U0F9gvYHBaa3t1c/XSKfLG0c4m37fZiFd7
         iurg==
X-Gm-Message-State: AOAM532PXqeb2GpQLHk6UHc/e1yLyFyz8qZ8Lk/d68Aktn/IKF8n6AsK
        elr79ZLjKhuVRb3natdfieEOIQ==
X-Google-Smtp-Source: ABdhPJwO+yiH78inCvfQvjAPF0UIPio09P7R1UJpZjiFt7YsJ8rwM0EOYKbjylj7cxR4jFf4izT1vw==
X-Received: by 2002:adf:d08a:: with SMTP id y10mr5339425wrh.361.1595015746833;
        Fri, 17 Jul 2020 12:55:46 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c3sm3544953wrx.5.2020.07.17.12.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:55:45 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
From:   Scott Branden <scott.branden@broadcom.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
Message-ID: <ad1f7aa8-0b20-b611-d35f-5cdba33e0b7e@broadcom.com>
Date:   Fri, 17 Jul 2020 12:55:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-17 12:04 p.m., Scott Branden wrote:
> Hi Kees,
>
> On 2020-07-17 10:43 a.m., Kees Cook wrote:
>> In preparation for refactoring kernel_read_file*(), remove the redundant
>> "size" argument which is not needed: it can be included in the return
> I don't think the size argument is redundant though.
> The existing kernel_read_file functions always read the whole file.
> Now, what happens if the file is bigger than the buffer.
> How does kernel_read_file know it read the whole file by looking at 
> the return value?
Actually, this change looks ok dealing with the size.  I'll look at the 
rest.
>
>> code, with callers adjusted. (VFS reads already cannot be larger than
>> INT_MAX.)
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   drivers/base/firmware_loader/main.c |  8 ++++----
>>   fs/kernel_read_file.c               | 20 +++++++++-----------
>>   include/linux/kernel_read_file.h    |  8 ++++----
>>   kernel/kexec_file.c                 | 13 ++++++-------
>>   kernel/module.c                     |  7 +++----
>>   security/integrity/digsig.c         |  5 +++--
>>   security/integrity/ima/ima_fs.c     |  5 +++--
>>   7 files changed, 32 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/base/firmware_loader/main.c 
>> b/drivers/base/firmware_loader/main.c
>> index d4a413ea48ce..ea419c7d3d34 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -462,7 +462,7 @@ fw_get_filesystem_firmware(struct device *device, 
>> struct fw_priv *fw_priv,
>>                            size_t in_size,
>>                            const void *in_buffer))
>>   {
>> -    loff_t size;
>> +    size_t size;
>>       int i, len;
>>       int rc = -ENOENT;
>>       char *path;
>> @@ -494,10 +494,9 @@ fw_get_filesystem_firmware(struct device 
>> *device, struct fw_priv *fw_priv,
>>           fw_priv->size = 0;
>>             /* load firmware files from the mount namespace of init */
>> -        rc = kernel_read_file_from_path_initns(path, &buffer,
>> -                               &size, msize,
>> +        rc = kernel_read_file_from_path_initns(path, &buffer, msize,
>>                                  READING_FIRMWARE);
>> -        if (rc) {
>> +        if (rc < 0) {
>>               if (rc != -ENOENT)
>>                   dev_warn(device, "loading %s failed with error %d\n",
>>                        path, rc);
>> @@ -506,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, 
>> struct fw_priv *fw_priv,
>>                        path);
>>               continue;
>>           }
>> +        size = rc;
>>           dev_dbg(device, "Loading firmware from %s\n", path);
>>           if (decompress) {
>>               dev_dbg(device, "f/w decompressing %s\n",
>> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
>> index 54d972d4befc..dc28a8def597 100644
>> --- a/fs/kernel_read_file.c
>> +++ b/fs/kernel_read_file.c
>> @@ -5,7 +5,7 @@
>>   #include <linux/security.h>
>>   #include <linux/vmalloc.h>
>>   -int kernel_read_file(struct file *file, void **buf, loff_t *size,
>> +int kernel_read_file(struct file *file, void **buf,
>>                loff_t max_size, enum kernel_read_file_id id)
>>   {
>>       loff_t i_size, pos;
>> @@ -29,7 +29,7 @@ int kernel_read_file(struct file *file, void **buf, 
>> loff_t *size,
>>           ret = -EINVAL;
>>           goto out;
>>       }
>> -    if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
>> +    if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
> Should this be SSIZE_MAX?
>>           ret = -EFBIG;
>>           goto out;
>>       }
>> @@ -59,8 +59,6 @@ int kernel_read_file(struct file *file, void **buf, 
>> loff_t *size,
>>       }
>>         ret = security_kernel_post_read_file(file, *buf, i_size, id);
>> -    if (!ret)
>> -        *size = pos;
>>     out_free:
>>       if (ret < 0) {
>> @@ -72,11 +70,11 @@ int kernel_read_file(struct file *file, void 
>> **buf, loff_t *size,
>>     out:
>>       allow_write_access(file);
>> -    return ret;
>> +    return ret == 0 ? pos : ret;
>>   }
>>   EXPORT_SYMBOL_GPL(kernel_read_file);
>>   -int kernel_read_file_from_path(const char *path, void **buf, 
>> loff_t *size,
>> +int kernel_read_file_from_path(const char *path, void **buf,
>>                      loff_t max_size, enum kernel_read_file_id id)
>>   {
>>       struct file *file;
>> @@ -89,14 +87,14 @@ int kernel_read_file_from_path(const char *path, 
>> void **buf, loff_t *size,
>>       if (IS_ERR(file))
>>           return PTR_ERR(file);
>>   -    ret = kernel_read_file(file, buf, size, max_size, id);
>> +    ret = kernel_read_file(file, buf, max_size, id);
>>       fput(file);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>>     int kernel_read_file_from_path_initns(const char *path, void **buf,
>> -                      loff_t *size, loff_t max_size,
>> +                      loff_t max_size,
>>                         enum kernel_read_file_id id)
>>   {
>>       struct file *file;
>> @@ -115,13 +113,13 @@ int kernel_read_file_from_path_initns(const 
>> char *path, void **buf,
>>       if (IS_ERR(file))
>>           return PTR_ERR(file);
>>   -    ret = kernel_read_file(file, buf, size, max_size, id);
>> +    ret = kernel_read_file(file, buf, max_size, id);
>>       fput(file);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>>   -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, 
>> loff_t max_size,
>> +int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
>>                    enum kernel_read_file_id id)
>>   {
>>       struct fd f = fdget(fd);
>> @@ -130,7 +128,7 @@ int kernel_read_file_from_fd(int fd, void **buf, 
>> loff_t *size, loff_t max_size,
>>       if (!f.file)
>>           goto out;
>>   -    ret = kernel_read_file(f.file, buf, size, max_size, id);
>> +    ret = kernel_read_file(f.file, buf, max_size, id);
>>   out:
>>       fdput(f);
>>       return ret;
>> diff --git a/include/linux/kernel_read_file.h 
>> b/include/linux/kernel_read_file.h
>> index 78cf3d7dc835..0ca0bdbed1bd 100644
>> --- a/include/linux/kernel_read_file.h
>> +++ b/include/linux/kernel_read_file.h
>> @@ -36,16 +36,16 @@ static inline const char 
>> *kernel_read_file_id_str(enum kernel_read_file_id id)
>>   }
>>     int kernel_read_file(struct file *file,
>> -             void **buf, loff_t *size, loff_t max_size,
>> +             void **buf, loff_t max_size,
>>                enum kernel_read_file_id id);
>>   int kernel_read_file_from_path(const char *path,
>> -                   void **buf, loff_t *size, loff_t max_size,
>> +                   void **buf, loff_t max_size,
>>                      enum kernel_read_file_id id);
>>   int kernel_read_file_from_path_initns(const char *path,
>> -                      void **buf, loff_t *size, loff_t max_size,
>> +                      void **buf, loff_t max_size,
>>                         enum kernel_read_file_id id);
>>   int kernel_read_file_from_fd(int fd,
>> -                 void **buf, loff_t *size, loff_t max_size,
>> +                 void **buf, loff_t max_size,
>>                    enum kernel_read_file_id id);
>>     #endif /* _LINUX_KERNEL_READ_FILE_H */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 1358069ce9e9..a201bbb19158 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -220,13 +220,12 @@ kimage_file_prepare_segments(struct kimage 
>> *image, int kernel_fd, int initrd_fd,
>>   {
>>       int ret;
>>       void *ldata;
>> -    loff_t size;
>>         ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
>> -                       &size, INT_MAX, READING_KEXEC_IMAGE);
>> -    if (ret)
>> +                       INT_MAX, READING_KEXEC_IMAGE);
>> +    if (ret < 0)
>>           return ret;
>> -    image->kernel_buf_len = size;
>> +    image->kernel_buf_len = ret;
>>         /* Call arch image probe handlers */
>>       ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>> @@ -243,11 +242,11 @@ kimage_file_prepare_segments(struct kimage 
>> *image, int kernel_fd, int initrd_fd,
>>       /* It is possible that there no initramfs is being loaded */
>>       if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>>           ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
>> -                           &size, INT_MAX,
>> +                           INT_MAX,
>>                              READING_KEXEC_INITRAMFS);
>> -        if (ret)
>> +        if (ret < 0)
>>               goto out;
>> -        image->initrd_buf_len = size;
>> +        image->initrd_buf_len = ret;
>>       }
>>         if (cmdline_len) {
>> diff --git a/kernel/module.c b/kernel/module.c
>> index e9765803601b..b6fd4f51cc30 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3988,7 +3988,6 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
>>   SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, 
>> int, flags)
>>   {
>>       struct load_info info = { };
>> -    loff_t size;
>>       void *hdr = NULL;
>>       int err;
>>   @@ -4002,12 +4001,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, 
>> const char __user *, uargs, int, flags)
>>                 |MODULE_INIT_IGNORE_VERMAGIC))
>>           return -EINVAL;
>>   -    err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
>> +    err = kernel_read_file_from_fd(fd, &hdr, INT_MAX,
>>                          READING_MODULE);
>> -    if (err)
>> +    if (err < 0)
>>           return err;
>>       info.hdr = hdr;
>> -    info.len = size;
>> +    info.len = err;
>>         return load_module(&info, uargs, flags);
>>   }
>> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
>> index f8869be45d8f..97661ffabc4e 100644
>> --- a/security/integrity/digsig.c
>> +++ b/security/integrity/digsig.c
>> @@ -171,16 +171,17 @@ int __init integrity_add_key(const unsigned int 
>> id, const void *data,
>>   int __init integrity_load_x509(const unsigned int id, const char 
>> *path)
>>   {
>>       void *data = NULL;
>> -    loff_t size;
>> +    size_t size;
>>       int rc;
>>       key_perm_t perm;
>>   -    rc = kernel_read_file_from_path(path, &data, &size, 0,
>> +    rc = kernel_read_file_from_path(path, &data, 0,
>>                       READING_X509_CERTIFICATE);
>>       if (rc < 0) {
>>           pr_err("Unable to open file: %s (%d)", path, rc);
>>           return rc;
>>       }
>> +    size = rc;
>>         perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | 
>> KEY_USR_READ;
>>   diff --git a/security/integrity/ima/ima_fs.c 
>> b/security/integrity/ima/ima_fs.c
>> index e13ffece3726..9ba145d3d6d9 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -275,7 +275,7 @@ static ssize_t ima_read_policy(char *path)
>>   {
>>       void *data = NULL;
>>       char *datap;
>> -    loff_t size;
>> +    size_t size;
>>       int rc, pathlen = strlen(path);
>>         char *p;
>> @@ -284,11 +284,12 @@ static ssize_t ima_read_policy(char *path)
>>       datap = path;
>>       strsep(&datap, "\n");
>>   -    rc = kernel_read_file_from_path(path, &data, &size, 0, 
>> READING_POLICY);
>> +    rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
>>       if (rc < 0) {
>>           pr_err("Unable to open file: %s (%d)", path, rc);
>>           return rc;
>>       }
>> +    size = rc;
>>         datap = data;
>>       while (size > 0 && (p = strsep(&datap, "\n"))) {
>

