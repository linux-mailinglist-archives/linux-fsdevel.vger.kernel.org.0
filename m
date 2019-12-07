Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1543B115DAA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLGRBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 12:01:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bhWCxXMSfUj2ikhu1QBLL9cZAf8fThN+0iWJPHVoqOw=; b=PA58yHXUCtzHkqiNs9B4pQP2x
        8ddAlPAqnaekr1PY0g9cvLgDNOxFAaxQdNGu1VQRplfg1H68qCvcr7f+9qCgTdJwHxpHD7b4gUlGK
        htWr+EJBIzgC4xmZ/d5sRLQmKIHjVt4ZHrxF9KbKfnNPGPuxG8AKz0KEFHtZkSAikaGuTdc2x+lRZ
        yb+9oIdHEMD+VhptLFmCxpRqKfGe0vJhKz2U+7ORYt1XGef86GT24fyx2Z7mOofe8imRELf4+Gg0F
        hXbQCsmzdjYCeV2WXdUPuvzccADJEuQDanIv54+2RmHUtcQaaAnwXbbq8hD9EH5+UMXNKxqCcEwLW
        te5w8PZ5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iddSd-0001L7-MK; Sat, 07 Dec 2019 17:01:39 +0000
Date:   Sat, 7 Dec 2019 09:01:39 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Davide Libenzi <davidel@xmailserver.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: eventfd: fix obsolete comment
Message-ID: <20191207170139.GA32169@bombadil.infradead.org>
References: <1575704733-11573-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575704733-11573-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 07, 2019 at 03:45:33PM +0800, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> since commit 36a7411724b1 ("eventfd_ctx_fdget(): use fdget() instead of
> fget()"), this comment become outdated and looks confusing. Fix it with
> the correct function name.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/eventfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 8aa0ea8c55e8..0b8466b12932 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(eventfd_fget);
>   * Returns a pointer to the internal eventfd context, otherwise the error
>   * pointers returned by the following functions:
>   *
> - * eventfd_fget
> + * fdget

But this is wrong.  The error pointer is returned from eventfd_ctx_fileget(),
not from fdget.

Looking at the three callers of eventfd_ctx_fileget(), I think it would
make sense to do this:

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 997cb5d0a657..c35b614e3770 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -126,11 +126,6 @@ int vfio_virqfd_enable(void *opaque,
 	INIT_WORK(&virqfd->inject, virqfd_inject);
 
 	irqfd = fdget(fd);
-	if (!irqfd.file) {
-		ret = -EBADF;
-		goto err_fd;
-	}
-
 	ctx = eventfd_ctx_fileget(irqfd.file);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..d389ffd1dc07 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -349,17 +349,13 @@ EXPORT_SYMBOL_GPL(eventfd_fget);
  * eventfd_ctx_fdget - Acquires a reference to the internal eventfd context.
  * @fd: [in] Eventfd file descriptor.
  *
- * Returns a pointer to the internal eventfd context, otherwise the error
- * pointers returned by the following functions:
- *
- * eventfd_fget
+ * Returns a pointer to the internal eventfd context, or an error pointer;
+ * see eventfd_ctx_fileget().
  */
 struct eventfd_ctx *eventfd_ctx_fdget(int fd)
 {
 	struct eventfd_ctx *ctx;
 	struct fd f = fdget(fd);
-	if (!f.file)
-		return ERR_PTR(-EBADF);
 	ctx = eventfd_ctx_fileget(f.file);
 	fdput(f);
 	return ctx;
@@ -368,17 +364,18 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fdget);
 
 /**
  * eventfd_ctx_fileget - Acquires a reference to the internal eventfd context.
- * @file: [in] Eventfd file pointer.
- *
- * Returns a pointer to the internal eventfd context, otherwise the error
- * pointer:
+ * @file: Eventfd file pointer.
  *
- * -EINVAL   : The @fd file descriptor is not an eventfd file.
+ * Return: A pointer to the internal eventfd context, or an error pointer:
+ * * -EBADF  - The @file is NULL.
+ * * -EINVAL - The @file is not an eventfd file.
  */
 struct eventfd_ctx *eventfd_ctx_fileget(struct file *file)
 {
 	struct eventfd_ctx *ctx;
 
+	if (!file)
+		return ERR_PTR(-EBADF);
 	if (file->f_op != &eventfd_fops)
 		return ERR_PTR(-EINVAL);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 01f3f8b665e9..74b45bc439d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4676,11 +4676,6 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	INIT_WORK(&event->remove, memcg_event_remove);
 
 	efile = fdget(efd);
-	if (!efile.file) {
-		ret = -EBADF;
-		goto out_kfree;
-	}
-
 	event->eventfd = eventfd_ctx_fileget(efile.file);
 	if (IS_ERR(event->eventfd)) {
 		ret = PTR_ERR(event->eventfd);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 67b6fc153e9c..814b99c33d44 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -306,11 +306,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	seqcount_init(&irqfd->irq_entry_sc);
 
 	f = fdget(args->fd);
-	if (!f.file) {
-		ret = -EBADF;
-		goto out;
-	}
-
 	eventfd = eventfd_ctx_fileget(f.file);
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);

(not even compile tested)
