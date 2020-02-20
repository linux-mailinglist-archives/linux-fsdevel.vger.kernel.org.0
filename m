Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8140E1669E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 22:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBTVf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 16:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgBTVf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582234527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2EGDSMUcVYyMIaWsWkgoEGQPIxS78ZmR7hXQG4Kq71Y=;
        b=BF5qPBi0pgH7MJJ/+Ld4QwjGv2dBEg3uxv03akYokIaig3eLVcCu300msvaKtXwuFrhRgf
        C6/h6h4Siy1Oe9+ks50gY4P120DU2/HK9rtfEU6K7VOvJw5Pz9rftc3SZHO3UIOKSUbMDE
        ehuk6os5ytP+gaKAwAu3BUprFRbUQpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-uv_izzr0MCWEgLgn0au4Zw-1; Thu, 20 Feb 2020 16:35:23 -0500
X-MC-Unique: uv_izzr0MCWEgLgn0au4Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA5D107ACC5;
        Thu, 20 Feb 2020 21:35:22 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 445C85C114;
        Thu, 20 Feb 2020 21:35:18 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
        <20200218214841.10076-3-vgoyal@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 20 Feb 2020 16:35:17 -0500
In-Reply-To: <20200218214841.10076-3-vgoyal@redhat.com> (Vivek Goyal's message
        of "Tue, 18 Feb 2020 16:48:35 -0500")
Message-ID: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> Currently pmem_clear_poison() expects offset and len to be sector aligned.
> Atleast that seems to be the assumption with which code has been written.
> It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> and pmem_make_request() which will only passe sector aligned offset and len.
>
> Soon we want use this function from dax_zero_page_range() code path which
> can try to zero arbitrary range of memory with-in a page. So update this
> function to assume that offset and length can be arbitrary and do the
> necessary alignments as needed.

What caller will try to zero a range that is smaller than a sector?

> nvdimm_clear_poison() seems to assume offset and len to be aligned to
> clear_err_unit boundary. But this is currently internal detail and is
> not exported for others to use. So for now, continue to align offset and
> length to SECTOR_SIZE boundary. Improving it further and to align it
> to clear_err_unit boundary is a TODO item for future.

When there is a poisoned range of persistent memory, it is recorded by
the badblocks infrastructure, which currently operates on sectors.  So,
no matter what the error unit is for the hardware, we currently can't
record/report to userspace anything smaller than a sector, and so that
is what we expect when clearing errors.

Continuing on for completeness, we will currently not map a page with
badblocks into a process' address space.  So, let's say you have 256
bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
you access a valid mmap()d address in the same page as the poisoned
memory, you will get a segfault.

Userspace can fix up the error by calling write(2) and friends to
provide new data, or by punching a hole and writing new data to the hole
(which may result in getting a new block, or reallocating the old block
and zeroing it, which will clear the error).

More comments below...

> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 075b11682192..e72959203253 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -74,14 +74,28 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
>  	sector_t sector;
>  	long cleared;
>  	blk_status_t rc = BLK_STS_OK;
> +	phys_addr_t start_aligned, end_aligned;
> +	unsigned int len_aligned;
>  
> -	sector = (offset - pmem->data_offset) / 512;
> +	/*
> +	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> +	 * expects memory offset and length to meet certain alignment
> +	 * restrction (clear_err_unit). Currently nvdimm does not export
                                                  ^^^^^^^^^^^^^^^^^^^^^^
> +	 * required alignment. So align offset and length to sector boundary

What is "nvdimm" in that sentence?  Because the nvdimm most certainly
does export the required alignment.  Perhaps you meant libnvdimm?

> +	 * before passing it to nvdimm_clear_poison().
> +	 */
> +	start_aligned = ALIGN(offset, SECTOR_SIZE);
> +	end_aligned = ALIGN_DOWN((offset + len), SECTOR_SIZE) - 1;
> +	len_aligned = end_aligned - start_aligned + 1;
> +
> +	sector = (start_aligned - pmem->data_offset) / 512;
>  
> -	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
> -	if (cleared < len)
> +	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + start_aligned,
> +				      len_aligned);
> +	if (cleared < len_aligned)
>  		rc = BLK_STS_IOERR;
>  	if (cleared > 0 && cleared / 512) {
> -		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
> +		hwpoison_clear(pmem, pmem->phys_addr + start_aligned, cleared);
>  		cleared /= 512;
>  		dev_dbg(dev, "%#llx clear %ld sector%s\n",
>  				(unsigned long long) sector, cleared,

We could potentially support clearing less than a sector, but I'd have
to understand the use cases better before offerring implementation
suggestions.

-Jeff

