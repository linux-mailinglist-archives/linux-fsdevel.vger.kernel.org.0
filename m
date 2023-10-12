Return-Path: <linux-fsdevel+bounces-159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F087C67A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89A2282A12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34731D523;
	Thu, 12 Oct 2023 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wl+Ozvuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqpZ1G7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73361611F;
	Thu, 12 Oct 2023 08:39:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF690;
	Thu, 12 Oct 2023 01:38:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BBC91F74C;
	Thu, 12 Oct 2023 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697099938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8c6j9VDLhFYc5XmunB4hBYMK+2M9al9NYLUoZ11ZYVE=;
	b=Wl+Ozvuj8Nk9C7oDWauDDMtBBusebE03rVPeCwDvmJYrHMkxfXOBPt0zc63Nr50YITICVE
	Xc/wXLDUGEX9TYzBQy6WMirJ6fYNPooqR4EDMFOvfpLJGYmQ2WaSHcsYxFRTMTlI5jJtoT
	vpz+tCQoL9srkPNQBkiIETjg2bz2zgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697099938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8c6j9VDLhFYc5XmunB4hBYMK+2M9al9NYLUoZ11ZYVE=;
	b=OqpZ1G7FQHL2iZ2KYqxZhwCiDkq/qYL7Juof0mRlQdToTCF/UL3aew1AKtlnygFIL9OYWc
	8WHEHcon6A+TfqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BB79139F9;
	Thu, 12 Oct 2023 08:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sckdHqKwJ2XPUgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 08:38:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8078A06B0; Thu, 12 Oct 2023 10:38:57 +0200 (CEST)
Date: Thu, 12 Oct 2023 10:38:57 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: enforce the mapping_map_writable() check
 after call_mmap()
Message-ID: <20231012083857.ty66retpyhxkaem3@quack3>
References: <cover.1696709413.git.lstoakes@gmail.com>
 <d2748bc4077b53c60bcb06fccaf976cb2afee345.1696709413.git.lstoakes@gmail.com>
 <20231011094627.3xohlpe4gm2idszm@quack3>
 <512d8089-759c-47b7-864d-f4a38a9eacf3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512d8089-759c-47b7-864d-f4a38a9eacf3@lucifer.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 19:14:10, Lorenzo Stoakes wrote:
> On Wed, Oct 11, 2023 at 11:46:27AM +0200, Jan Kara wrote:
> > On Sat 07-10-23 21:51:01, Lorenzo Stoakes wrote:
> > > In order for an F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> > > clear VM_MAYWRITE in seal_check_write() we must be able to invoke either
> > > the shmem_mmap() or hugetlbfs_file_mmap() f_ops->mmap() handler to do so.
> > >
> > > We would otherwise fail the mapping_map_writable() check before we had
> > > the opportunity to clear VM_MAYWRITE.
> > >
> > > However, the existing logic in mmap_region() performs this check BEFORE
> > > calling call_mmap() (which invokes file->f_ops->mmap()). We must enforce
> > > this check AFTER the function call.
> > >
> > > In order to avoid any risk of breaking call_mmap() handlers which assume
> > > this will have been done first, we continue to mark the file writable
> > > first, simply deferring enforcement of it failing until afterwards.
> > >
> > > This enables mmap(..., PROT_READ, MAP_SHARED, fd, 0) mappings for memfd's
> > > sealed via F_SEAL_WRITE to succeed, whereas previously they were not
> > > permitted.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
> > ...
> >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 6f6856b3267a..9fbee92aaaee 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2767,17 +2767,25 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	vma->vm_pgoff = pgoff;
> > >
> > >  	if (file) {
> > > -		if (is_shared_maywrite(vm_flags)) {
> > > -			error = mapping_map_writable(file->f_mapping);
> > > -			if (error)
> > > -				goto free_vma;
> > > -		}
> > > +		int writable_error = 0;
> > > +
> > > +		if (vma_is_shared_maywrite(vma))
> > > +			writable_error = mapping_map_writable(file->f_mapping);
> > >
> > >  		vma->vm_file = get_file(file);
> > >  		error = call_mmap(file, vma);
> > >  		if (error)
> > >  			goto unmap_and_free_vma;
> > >
> > > +		/*
> > > +		 * call_mmap() may have changed VMA flags, so retry this check
> > > +		 * if it failed before.
> > > +		 */
> > > +		if (writable_error && vma_is_shared_maywrite(vma)) {
> > > +			error = writable_error;
> > > +			goto close_and_free_vma;
> > > +		}
> >
> > Hum, this doesn't quite give me a peace of mind ;). One bug I can see is
> > that if call_mmap() drops the VM_MAYWRITE flag, we seem to forget to drop
> > i_mmap_writeable counter here?
> 
> This wouldn't be applicable in the F_SEAL_WRITE case, as the
> i_mmap_writable counter would already have been decremented, and thus an
> error would arise causing no further decrement, and everything would work
> fine.
> 
> It'd be very odd for something to be writable here but the driver to make
> it not writable. But we do need to account for this.

Yeah, it may be odd but this is indeed what i915 driver appears to be
doing in i915_gem_object_mmap():

        if (i915_gem_object_is_readonly(obj)) {
                if (vma->vm_flags & VM_WRITE) {
                        i915_gem_object_put(obj);
                        return -EINVAL;
                }
                vm_flags_clear(vma, VM_MAYWRITE);
        }

> > I've checked why your v2 version broke i915 and I think the reason maybe
> > has nothing to do with i915. Just in case call_mmap() failed, it ended up
> > jumping to unmap_and_free_vma which calls mapping_unmap_writable() but we
> > didn't call mapping_map_writable() yet so the counter became imbalanced.
> 
> yeah that must be the cause, I thought perhaps somehow
> __remove_shared_vm_struct() got invoked by i915_gem_mmap() but I didn't
> trace it through to see if it was possible.
> 
> Looking at it again, i don't think that is possible, as we hold a mmap/vma
> write lock, and the only operations that can cause
> __remove_shared_vm_struct() to run are things that would not be able to do
> so with this lock held.
> 
> > So I'd be for returning to v2 version, just fix up the error handling
> > paths...
> 
> So in conclusion, I agree, this is the better approach. Will respin in v4.

Thanks!
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

