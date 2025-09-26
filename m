Return-Path: <linux-fsdevel+bounces-62912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC3BA4FAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7629A1C25406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22A283142;
	Fri, 26 Sep 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8q28ATJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9F27FB10
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915392; cv=none; b=Ls1GQaCzUqw4zOwRO2spZ+ILvTYsISDzctlvFl/j7vCCOhXUpIIPzuFmNESHgIzj+ogvPnjausGUZf5g9KONa7O6/mR1TbrC4tHLyUYXm/kDMG3OdMRxyLW1I1JN/mVf0TeS+/Hq+ySSDs/4v1OYhGySUGABC+zmzd0Gs6LIvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915392; c=relaxed/simple;
	bh=mSQKwT+RgGBH3fgRBwHxAMNFrCKxSsVizA+2Gjhn/pY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGs8ZKnkZf/VAnHcy6e/fHJDn5PneXYvpDoiuZ1SgA/FRfL/vjYTKLb4/Zuz3cwcULx/az+8reAmEaS8UTzLsU8x5dSNbk2vIB5InF06TzFuv/6mnP/a/lVW1k+mPbf0Y4ewQMJ0EgzI9o9o4EIqfcNUllZVerXFoAcPbZF20io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8q28ATJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b595so2356085a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758915389; x=1759520189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob/iOTJHVtIxulD10+qfYKaLq05XmILMIQZZtCe3LNU=;
        b=j8q28ATJXP6njsfMncRoTLIPRIZOM6TE6yvS0FWfgG9oEGpEjpU5QpwTkfS2MhxmOT
         1WnZ3dk97n6mJLnqIYRvGKm1tUWygYHs95kuxhokBn9aO9RA1XUNY7DN17Q5T1gbSffp
         P8WsrJuo9tYImTPRk5pu5Fp/kL5Rz2UKC420dK3FSmNh+Xr7sdZzm5kam8Oi0gzgwoX6
         36VJZSVNuL0mnfDe6/FOqXW7SbQ2YLXEL7NNTot3y7a4uykb9cHCv9EH2EzWB3jZ17Uz
         ry7y+KqDaMrsA3AHIPC0dEf4lqAwkkAR4r5FfFfvF1ng9ggW9GDE4eP7vjtSrwB8SDYw
         aCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758915389; x=1759520189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob/iOTJHVtIxulD10+qfYKaLq05XmILMIQZZtCe3LNU=;
        b=cd/NlhkeM0Lq8PM/rRnkxNkVwJIRFXMDdCfh57MSgCS7Euo563bTlWItz+38VAji/w
         u87mysJckDZi0SrGxvX7P7f/o1pCMuDD1bI44bwuqLAgoaA7nXCqdBXjZjKAslm5AxIu
         yCJSSxMszqSE9qE3LogDinvx4Kg+Tkmj2NPFB5qWIM17lNywsy8M5Cfgsj6oBE6hUHWs
         hH9vpBwPCqU/Jgm6ScHYla7QPEL8K10xzN5IdyxtaMa0sNR9WEVhhupPS6HhUt1GboUx
         FQZTorES8upZk5YjKkzePdotn51pUKm/+1xRw1RDM2TPs2Vs0bXOHpB8GamG6lPRG9m2
         /biw==
X-Forwarded-Encrypted: i=1; AJvYcCUVkuYtxLgHMEPKL4bN/f8TXDkonm1sNT9YGSmvDOm9X26Fhg6PYWJEdY/h/ye9uWKrY5ecKXybhnBnUU6L@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAnJMhA9SoOv7ww1feh8/1g34kpsFqIqcq09dV9wiX59SjBua
	nxQei0HLYxF+mbpBRCLAclw5lSsCX1Ar2WNQ2yzKQ6e88IWZVZeFG9+X6ZEXK7vuWLZC+CxMBM2
	cMBt9WA==
X-Google-Smtp-Source: AGHT+IFDksLZfiXKr/BILK4eWMYTpySqi06A6DOxX2zeNKzHO6pmJyAGRZ48y/vvPgWC6WRjoIw3qUZ+1+0=
X-Received: from pjbaz14.prod.google.com ([2002:a17:90b:28e:b0:32d:e264:a78e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1808:b0:32b:d8bf:c785
 with SMTP id 98e67ed59e1d1-3342a2c3979mr8949944a91.20.1758915388771; Fri, 26
 Sep 2025 12:36:28 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:36:27 -0700
In-Reply-To: <aNVQJqYLX17v-fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
Message-ID: <aNbrO7A7fSjb4W84@google.com>
Subject: Re: [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce NUMA mempolicy
 using shared policy
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
> > @@ -26,6 +28,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
> >  	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
> >  }
> >  
> > +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> > +						   pgoff_t index);
> > +
> >  /**
> >   * folio_file_pfn - like folio_file_page, but return a pfn.
> >   * @folio: The folio which contains this index.
> > @@ -112,7 +117,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
> >  {
> >  	/* TODO: Support huge pages. */
> > -	return filemap_grab_folio(inode->i_mapping, index);
> > +	struct mempolicy *policy;
> > +	struct folio *folio;
> > +
> > +	/*
> > +	 * Fast-path: See if folio is already present in mapping to avoid
> > +	 * policy_lookup.
> > +	 */
> > +	folio = __filemap_get_folio(inode->i_mapping, index,
> > +				    FGP_LOCK | FGP_ACCESSED, 0);
> > +	if (!IS_ERR(folio))
> > +		return folio;
> > +
> > +	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
> > +	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> > +					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> > +					 mapping_gfp_mask(inode->i_mapping), policy);
> > +	mpol_cond_put(policy);
> > +
> > +	return folio;
> >  }
> >  
> >  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> > @@ -372,8 +395,45 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_NUMA
> > +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> > +{
> > +	struct inode *inode = file_inode(vma->vm_file);
> > +
> > +	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
> > +}
> > +
> > +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > +					     unsigned long addr, pgoff_t *pgoff)
> > +{
> > +	struct inode *inode = file_inode(vma->vm_file);
> > +
> > +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > +	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
> > +}
> > +
> > +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> > +						   pgoff_t index)
> 
> I keep reading this is "page offset policy", as opposed to "policy given a page
> offset".  Another oddity that is confusing is that this helper explicitly does
> get_task_policy(current), while kvm_gmem_get_policy() lets the caller do that.
> The end result is the same, but I think it would be helpful for gmem to be
> internally consistent.
> 
> If we have kvm_gmem_get_policy() use this helper, then we can kill two birds with
> one stone:
> 
> static struct mempolicy *__kvm_gmem_get_policy(struct gmem_inode *gi,
> 					       pgoff_t index)
> {
> 	struct mempolicy *mpol;
> 
> 	mpol = mpol_shared_policy_lookup(&gi->policy, index);
> 	return mpol ? mpol : get_task_policy(current);
> }
> 
> static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> 					     unsigned long addr, pgoff_t *pgoff)
> {
> 	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> 
> 	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);

Argh!!!!!  This breaks the selftest because do_get_mempolicy() very specifically
falls back to the default_policy, NOT to the current task's policy.  That is
*exactly* the type of subtle detail that needs to be commented, because there's
no way some random KVM developer is going to know that returning NULL here is
important with respect to get_mempolicy() ABI.

On a happier note, I'm very glad you wrote a testcase :-)

I've got this as fixup-to-the-fixup:

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e796cc552a96..61130a52553f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -114,8 +114,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
        return r;
 }
 
-static struct mempolicy *__kvm_gmem_get_policy(struct gmem_inode *gi,
-                                              pgoff_t index)
+static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
+                                                  pgoff_t index)
 {
 #ifdef CONFIG_NUMA
        struct mempolicy *mpol;
@@ -151,7 +151,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
        if (!IS_ERR(folio))
                return folio;
 
-       policy = __kvm_gmem_get_policy(GMEM_I(inode), index);
+       policy = kvm_gmem_get_folio_policy(GMEM_I(inode), index);
        folio = __filemap_get_folio_mpol(inode->i_mapping, index,
                                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
                                         mapping_gfp_mask(inode->i_mapping), policy);
@@ -431,9 +431,18 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
 static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
                                              unsigned long addr, pgoff_t *pgoff)
 {
+       struct inode *inode = file_inode(vma->vm_file);
+
         *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
 
-        return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
+       /*
+        * Note!  Directly return whatever the lookup returns, do NOT return
+        * the current task's policy as is done when looking up the policy for
+        * a specific folio.  Kernel ABI for get_mempolicy() is to return
+        * MPOL_DEFAULT when there is no defined policy, not whatever the
+        * default policy resolves to.
+        */
+        return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
 }
 #endif /* CONFIG_NUMA */
 


