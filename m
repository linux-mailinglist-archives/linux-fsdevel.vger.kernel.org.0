Return-Path: <linux-fsdevel+bounces-21304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C19901965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508F61C20E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E425227;
	Mon, 10 Jun 2024 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FhtChlaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95E380
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717987486; cv=none; b=WYUK6Y2NAKo9ZdjmiArVLzA8nzgVYm5L5isJHfoo/b8uI8fcS77fJIpo/e4v1QxjCscM6zpfWn87TVZqzMsc98uQTdLfQj94+0hbauDhX3rWcNxSqJ36CBzme9WpkiD64AAi7xC+FoU5s8yi5rIzeAbkzfkEQXKCjm/kdUVSlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717987486; c=relaxed/simple;
	bh=4zKa1YXYhMIIrdPz5TroUzbXtE8LAGVLkXTyI/QV9xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVLTwlwqbdI+GHsbjvQXKBViKF3qkU5iNbE1o1s0ad05VG7lCBOSF66mnYBrtfcayhEaR7//3b/12D+DkiFSOj7Gj2neWCR8tViDbcE000LB6A/M3VOgDxW2nsPxf0LFdONpBzp5i2EfRjGhEO7VMzRVDAWHCGv/xAoAl5hcsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FhtChlaT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NnahmfVvmfIdd6h5c4SLKZq/yChaFKl1BGROqQ776UY=; b=FhtChlaTNy/6bDJZQ3/r+inUzi
	H3Miv8cq7tU5zhQSKB8TZqVDYbGlORJv2praibS+RN9QfJqjyEkk+K+Yk7DWhwT9y3oCd7b191CrJ
	pvD1Pj+I5dxzOZSjWl/w/ISYlzuBPVvIpFXvXQgpV8C640tnKnbsUdhB00CSMIV341gEP32jnASxY
	7DrzecsRCgFzzj0yRpG4tg7WfY0LVCq90G7lyZQyda8zg65z4qCGA9rsKbqAjowEry9/5RPTy6Wdw
	p31yo89rA7Wg/OBiFyzuj2/H2Rr+wNr+MjdsNO/hZjfcR7ywhZfiNFuJgbKyFr4d2C/1b9rfP59aM
	aJHKP+Jw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sGV1R-006DiH-1b;
	Mon, 10 Jun 2024 02:44:37 +0000
Date: Mon, 10 Jun 2024 03:44:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] potential UAF in kvm_spapr_tce_attach_iommu_group() (was Re:
 [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...))
Message-ID: <20240610024437.GA1464458@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
 <20240607210814.GC1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607210814.GC1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 10:08:14PM +0100, Al Viro wrote:

> Hell knows - it feels like mixing __cleanup-based stuff with anything
> explicit leads to massive headache.  And I *really* hate to have
> e.g. inode_unlock() hidden in __cleanup in a random subset of places.
> Unlike dropping file references (if we do that a bit later, nothing
> would really care), the loss of explicit control over the places where
> inode lock is dropped is asking for serious trouble.
> 
> Any suggestions?  Linus, what's your opinion on the use of CLASS...
> stuff?

While looking through the converted fdget() users, some interesting
stuff got caught.  Example:

kvm_device_fops.unlocked_ioctl() is equal to kvm_device_ioctl() and it
gets called (by ioctl(2)) without any locks.

kvm_device_ioctl() calls kvm_device_ioctl_attr(), passing it dev->ops->set_attr.

kvm_device_ioctl_attr() calls the callback passed to it, still without any
locks.

->set_attr() can be kvm_vfio_set_attr(), which calls kvm_vfio_set_file(), which
calls kvm_vfio_file_set_spapr_tce(), which takes dev->private.lock and
calls kvm_spapr_tce_attach_iommu_group().  No kvm->lock held.


Now, in kvm_spapr_tce_attach_iommu_group() we have (in mainline)
        f = fdget(tablefd);
        if (!f.file)
                return -EBADF;

        rcu_read_lock();
        list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
                if (stt == f.file->private_data) {
                        found = true;
                        break;
                }
        }
        rcu_read_unlock();

        fdput(f);

        if (!found)
                return -EINVAL;

	....
        list_add_rcu(&stit->next, &stt->iommu_tables);

What happens if another thread closes the damn descriptor just as we'd
done fdput()?  This:
static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
{
        struct kvmppc_spapr_tce_table *stt = filp->private_data;
        struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
        struct kvm *kvm = stt->kvm;

        mutex_lock(&kvm->lock);
        list_del_rcu(&stt->list);
        mutex_unlock(&kvm->lock);

        list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
                WARN_ON(!kref_read(&stit->kref));
                while (1) {
                        if (kref_put(&stit->kref, kvm_spapr_tce_liobn_put))
                                break;
                }
        }

        account_locked_vm(kvm->mm,
                kvmppc_stt_pages(kvmppc_tce_pages(stt->size)), false);

        kvm_put_kvm(stt->kvm);

        call_rcu(&stt->rcu, release_spapr_tce_table);

        return 0;
}

Leaving aside the question of sanity of that while (!kfref_put()) loop,
that function will *NOT* block on kvm->lock (the only lock being held
by the caller of kvm_spapr_tce_attach_iommu_group() is struct kvm_vfio::lock,
not struct kvm::lock) and it will arrange for RCU-delayed call of
release_spapr_tce_table(), which will kfree stt.

Recall that in kvm_spapr_tce_attach_iommu_group() we are not holding
rcu_read_lock() between fdput() and list_add_rcu() (we couldn't - not
with the blocking allocations we have there), so call_rcu() might as
well have been a direct call.

What's there to protect stt from being freed right after fdput()?

Unless I'm misreading that code (entirely possible), this fdput() shouldn't
be done until we are done with stt.

