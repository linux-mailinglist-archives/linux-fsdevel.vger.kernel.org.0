Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB16293A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiKOIzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiKOIyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:54:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0B20F72;
        Tue, 15 Nov 2022 00:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XnEj26lKZcJ/I4VuOEUSvvYB44Q9hvJF20imshWtvMA=; b=kNSPfSHEg2HxqQCdQLWh+G4Esm
        2qwuSXBJtSwRoDUdcuxQTX0483lMMKT6LxtmOaL13kbTQeKCgWFaHkVXMoWEAG+YFY3/PpsMkhuxX
        Z5r00F7BzautJ8h5usb/hnqhT12GoyfnpWiIUj4SOf48FL+rxcqTXj4Vpl3ps459ZwROQ0YzQROfh
        BRsffR0Ua0x4d8osnPMu82FUwXiL5TrTHWgFLoP/XZcXgD2NE5SLJTKhbZ1eHrxU1s2vSfiA98TDN
        V1BZls0UhxcVS60l4qcUhohpUpalSC708FlHlLQykqbkt4EAm5yakbMKDi9c739Czg5cKIZOiVNGB
        qQdIutSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouriB-0094M7-LE; Tue, 15 Nov 2022 08:54:31 +0000
Date:   Tue, 15 Nov 2022 00:54:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
Message-ID: <Y3NTx/x2m/kAZyGE@infradead.org>
References: <20221114140747.134928-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114140747.134928-1-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:07:47AM -0500, Jeff Layton wrote:
> +bool vfs_file_has_locks(struct file *filp)
> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	bool ret = false;
> +
> +	ctx = smp_load_acquire(&locks_inode(filp)->i_flctx);
> +	if (!ctx)
> +		return false;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +		if (fl->fl_file == filp) {
> +			ret = true;
> +			goto out;
> +		}
> +	}
> +	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
> +		if (fl->fl_file == filp) {
> +			ret = true;
> +			break;
> +		}
> +	}

Maybe a little helper for the list lookup would be nice here:
static inline bool __vfs_file_has_locks(struct file *file)
{
	struct file_lock *fl;

	list_for_each_entry(fl, &ctx->flc_flock, fl_list)
		if (fl->fl_file == filp)
			return true;
	return false;
}

simplifying the check in the caller to:

	ret = __vfs_file_has_locks(&ctx->flc_posix) ||
	      __vfs_file_has_locks(&ctx->flc_flock);

> +EXPORT_SYMBOL(vfs_file_has_locks);

EXPORT_SYMBOL_GPL for any new network-fsy functionality would be nice.
