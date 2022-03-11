Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CDA4D6B21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 00:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiCKXgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 18:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCKXga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:36:30 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B8FECB06
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 15:35:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so8722201pgg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13t7T+1H2gbtDRvuwDVr1bm3a+2J2xIzpet95fdBuh4=;
        b=RIgXQdVfVb6lODawzvdTxr4kAtwLPsRjREsyVUC9K9FXvakpJNymy17e6FkbZx5Gvv
         LeDcUKOKw2VoVa83HdzrEPE+n4lq8xuCULunoupKYxugg5JDuOq5trFf3fm42gMytdUt
         ERkjzkjwpAU0zoJJj8eO/F2dpsyBXR6QjMjtDGcOsDfDr2CJipG41gyKlmh4HlNGNwWJ
         vwkcU6O57nxaJWLRTl+0Hya9nMI7GHfWxpWRkjw+wUNIj2S8tgExKh9huQ4lWfIYS5K0
         A8C1eX/+5cBiho3K4ItispCSGtWUy9zYfhJ3aJCa4TY2pJ8nVxCb77Wvrz7OmBeIoOjA
         1QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13t7T+1H2gbtDRvuwDVr1bm3a+2J2xIzpet95fdBuh4=;
        b=tevIy6++DZQ4xhnLjbvE6E2ew2uWhJq3gf+dCiKsMpmUtPKciZ6LlAX47TMBOJYziv
         VlQSZA5kM58Y/sjdfGVraHsyvWcgZ3V6kXB9IICCG/AjTpN4tZwPjBRCHgPwI29QP5Z2
         +5hDZByT42/8zDa/qdlA62ppKWQQ/wpaL/nCgV5lZwIPEBobrpQKfu90z+ULtywpkIPl
         6Pa0HM0fX7NDVPYZfwDFeRO8JmCOG0dJ/IFvfESxmF6gjygNQyYZKSw81xB24X0Z+s6p
         pWiyvWHBfH52QXYqMOvrnGgY7BtOm1ywUANP8W/ja3rW7OlBShKsItqunqPydoZN6mfY
         Wo0w==
X-Gm-Message-State: AOAM5332F7AyjKP7RMsMOPB74/b5Rzj9VELFOGR2+MIxBjxcnQemQbPt
        mPJoeHz81zQFE5z71rvEiZcHY5yMWUKfwjEWcFiM/g==
X-Google-Smtp-Source: ABdhPJy2YDPTfdvIBlgNDhr+xnU7i87kZGa7MwrAaA3nvXLDFGkcmuMWf5/eMsJKEsCu2BWW9StjfFYHKRuRIZXl8BI=
X-Received: by 2002:a62:1481:0:b0:4f6:38c0:ed08 with SMTP id
 123-20020a621481000000b004f638c0ed08mr12796868pfu.86.1647041724808; Fri, 11
 Mar 2022 15:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com> <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Mar 2022 15:35:13 -0800
Message-ID: <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 27, 2022 at 4:08 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> To easily track filesystem from a pmem device, we introduce a holder for
> dax_device structure, and also its operation.  This holder is used to
> remember who is using this dax_device:
>  - When it is the backend of a filesystem, the holder will be the
>    instance of this filesystem.
>  - When this pmem device is one of the targets in a mapped device, the
>    holder will be this mapped device.  In this case, the mapped device
>    has its own dax_device and it will follow the first rule.  So that we
>    can finally track to the filesystem we needed.
>
> The holder and holder_ops will be set when filesystem is being mounted,
> or an target device is being activated.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h | 32 ++++++++++++++++
>  2 files changed, 121 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e3029389d809..da5798e19d57 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -21,6 +21,9 @@
>   * @cdev: optional character interface for "device dax"
>   * @private: dax driver private data
>   * @flags: state and boolean properties
> + * @ops: operations for dax_device
> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
> + * @holder_ops: operations for the inner holder
>   */
>  struct dax_device {
>         struct inode inode;
> @@ -28,6 +31,8 @@ struct dax_device {
>         void *private;
>         unsigned long flags;
>         const struct dax_operations *ops;
> +       void *holder_data;
> +       const struct dax_holder_operations *holder_ops;
>  };
>
>  static dev_t dax_devt;
> @@ -193,6 +198,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_page_range);
>
> +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
> +                             u64 len, int mf_flags)
> +{
> +       int rc, id;
> +
> +       id = dax_read_lock();
> +       if (!dax_alive(dax_dev)) {
> +               rc = -ENXIO;
> +               goto out;
> +       }
> +
> +       if (!dax_dev->holder_ops) {
> +               rc = -EOPNOTSUPP;

I think it is ok to return success (0) for this case. All the caller
of dax_holder_notify_failure() wants to know is if the notification
was successfully delivered to the holder. If there is no holder
present then there is nothing to report. This is minor enough for me
to fix up locally if nothing else needs to be changed.

> +               goto out;
> +       }
> +
> +       rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> +out:
> +       dax_read_unlock(id);
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> @@ -268,6 +296,10 @@ void kill_dax(struct dax_device *dax_dev)
>
>         clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>         synchronize_srcu(&dax_srcu);
> +
> +       /* clear holder data */
> +       dax_dev->holder_ops = NULL;
> +       dax_dev->holder_data = NULL;

Isn't this another failure scenario? If kill_dax() is called while a
holder is still holding the dax_device that seems to be another
->notify_failure scenario to tell the holder that the device is going
away and the holder has not released the device yet.

>  }
>  EXPORT_SYMBOL_GPL(kill_dax);
>
> @@ -409,6 +441,63 @@ void put_dax(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(put_dax);
>
> +/**
> + * dax_holder() - obtain the holder of a dax device
> + * @dax_dev: a dax_device instance
> +
> + * Return: the holder's data which represents the holder if registered,
> + * otherwize NULL.
> + */
> +void *dax_holder(struct dax_device *dax_dev)
> +{
> +       if (!dax_alive(dax_dev))
> +               return NULL;

It's safe for the holder to assume that it can de-reference
->holder_data freely in its notify_handler callback because
dax_holder_notify_failure() arranges for the callback to run in
dax_read_lock() context.

This is another minor detail that I can fixup locally.

> +
> +       return dax_dev->holder_data;
> +}
> +EXPORT_SYMBOL_GPL(dax_holder);
> +
> +/**
> + * dax_register_holder() - register a holder to a dax device
> + * @dax_dev: a dax_device instance
> + * @holder: a pointer to a holder's data which represents the holder
> + * @ops: operations of this holder
> +
> + * Return: negative errno if an error occurs, otherwise 0.
> + */
> +int dax_register_holder(struct dax_device *dax_dev, void *holder,
> +               const struct dax_holder_operations *ops)
> +{
> +       if (!dax_alive(dax_dev))
> +               return -ENXIO;
> +
> +       if (cmpxchg(&dax_dev->holder_data, NULL, holder))
> +               return -EBUSY;
> +
> +       dax_dev->holder_ops = ops;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dax_register_holder);
> +
> +/**
> + * dax_unregister_holder() - unregister the holder for a dax device
> + * @dax_dev: a dax_device instance
> + * @holder: the holder to be unregistered
> + *
> + * Return: negative errno if an error occurs, otherwise 0.
> + */
> +int dax_unregister_holder(struct dax_device *dax_dev, void *holder)
> +{
> +       if (!dax_alive(dax_dev))
> +               return -ENXIO;
> +
> +       if (cmpxchg(&dax_dev->holder_data, holder, NULL) != holder)
> +               return -EBUSY;
> +       dax_dev->holder_ops = NULL;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dax_unregister_holder);
> +
>  /**
>   * inode_dax: convert a public inode into its dax_dev
>   * @inode: An inode with i_cdev pointing to a dax_dev
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9fc5f99a0ae2..262d7bad131a 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -32,8 +32,24 @@ struct dax_operations {
>         int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  };
>
> +struct dax_holder_operations {
> +       /*
> +        * notify_failure - notify memory failure into inner holder device
> +        * @dax_dev: the dax device which contains the holder
> +        * @offset: offset on this dax device where memory failure occurs
> +        * @len: length of this memory failure event

Forgive me if this has been discussed before, but since dax_operations
are in terms of pgoff and nr pages and memory_failure() is in terms of
pfns what was the rationale for making the function signature byte
based?

I want to get this series merged into linux-next shortly after
v5.18-rc1. Then we can start working on incremental fixups rather
resending the full series with these long reply cycles.
