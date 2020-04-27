Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422D1BA876
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgD0Pr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728243AbgD0Pr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F743C0610D5;
        Mon, 27 Apr 2020 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZjowQMFVq/DiEGKmN4M6EG6jrl++/CGXkhZMqU7v+5I=; b=if1ci8CHdArR6APCrw93brGcg0
        9KOBzfyde+ZrqRlcmasKadfAUyMH7y3/JGajV7WG8XcL5AdqUS0srh+EUpYjinp3F1rdi64c6Q7qf
        5xH+rR013Ae8wlJ1Vkro++UPuoL1rQfQfc3NlzUu6yp0ahPXwPAFEg8f5NEpUbhvP4CU4kcVt4a1J
        GRtuizDMmQfgy3gIVaBArl8Np8F0cWlFJpte5mzuuhZGnwTwxo1eiLHvSI8UIrYuzsTlk5HQjpmSB
        WQufhdaS0wTGEkVZ3Jqk3rF2M64xBb1qeIvWA+CkxJEu+/ECFUqHOc1SBqQWF3gg9UUTVoylF6wOg
        Cf1WOs9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT5yh-00081i-A2; Mon, 27 Apr 2020 15:47:27 +0000
Date:   Mon, 27 Apr 2020 08:47:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/5] statsfs API: create, add and remove statsfs
 sources and values
Message-ID: <20200427154727.GH29705@bombadil.infradead.org>
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-3-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141816.16703-3-eesposit@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 04:18:13PM +0200, Emanuele Giuseppe Esposito wrote:
> +static struct statsfs_value *find_value(struct statsfs_value_source *src,
> +					struct statsfs_value *val)
> +{
> +	struct statsfs_value *entry;
> +
> +	for (entry = src->values; entry->name; entry++) {
> +		if (entry == val) {
> +			WARN_ON(strcmp(entry->name, val->name) != 0);

Umm.  'entry' and 'val' are pointers.  So if entry is equal to val,
how could entry->name and val->name not be the same thing?

> +/* Called with rwsem held for writing */
> +static struct statsfs_value_source *create_value_source(void *base)
> +{
> +	struct statsfs_value_source *val_src;
> +
> +	val_src = kzalloc(sizeof(struct statsfs_value_source), GFP_KERNEL);
> +	if (!val_src)
> +		return ERR_PTR(-ENOMEM);
> +
> +	val_src->base_addr = base;
> +	val_src->list_element =
> +		(struct list_head)LIST_HEAD_INIT(val_src->list_element);

This is not how LIST_HEAD_INIT is generally used, but see below.

> +int statsfs_source_add_values(struct statsfs_source *source,
> +			      struct statsfs_value *stat, void *ptr)
> +{
> +	struct statsfs_value_source *val_src;
> +	struct statsfs_value_source *entry;
> +
> +	down_write(&source->rwsem);
> +
> +	list_for_each_entry(entry, &source->values_head, list_element) {
> +		if (entry->base_addr == ptr && entry->values == stat) {
> +			up_write(&source->rwsem);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	val_src = create_value_source(ptr);
> +	val_src->values = (struct statsfs_value *)stat;
> +
> +	/* add the val_src to the source list */
> +	list_add(&val_src->list_element, &source->values_head);
> +
> +	up_write(&source->rwsem);

I dislike this use of doubly linked lists.  I would suggest using an
allocating XArray to store your values.  Something like this:

+int statsfs_source_add_values(struct statsfs_source *source,
+			      struct statsfs_value *stat, void *ptr)
+{
+	struct statsfs_value_source *entry, *val_src;
+	unsigned long index;
+	int err = -EEXIST;
+
+	val_src = create_value_source(ptr);
+	val_src->values = stat;
+
+	xa_lock(&source->values);
+	xa_for_each(&source->values, index, entry) {
+		if (entry->base_addr == ptr && entry->values == stat)
+			goto out;
+	}
+
+	err = __xa_alloc(&source->values, &val_src->id, val_src, xa_limit_32b,
+			GFP_KERNEL);
+out:
+	xa_unlock(&source->values);
+	if (err)
+		kfree(val_src);
+	return err;
+}

Using an XArray avoids the occasional latency problems you can see with
rwsems, as well as being more cache-effective than a linked list.

