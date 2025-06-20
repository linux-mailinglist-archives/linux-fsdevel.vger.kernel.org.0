Return-Path: <linux-fsdevel+bounces-52314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F5AE1A61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7FF17DC44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A128A71B;
	Fri, 20 Jun 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eqS1biAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448317E;
	Fri, 20 Jun 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420835; cv=none; b=f4g9O76dl8qNInHPK/8hbXr8BDo4ERoUQAo9PPqzO4cjoHz+muN36CFGB3o1aRvQXa8R/6BM9isXymffbct7VljCxlAWjeLZEQerljib8zFRA8pOylvIIE513bgF5z/99ltoBUPxgP4YmFeaEtlQTRYm80yKAJl8OuwG+H4mePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420835; c=relaxed/simple;
	bh=tptUqBswmrrA83eEPdA+o1+EZ6nxsbeRtan2snqTm10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MTBQOI3nGepMgg7apfKjYopEt1TwRGn3xiRx/r0bwXeTr/G+bJ3mU0pPXBLO7Evn8gm/kJ4rvU1y31YWuSewLIMvnPCk1JVuk8S7KV4WBE2Z6fOrNHVBVcaRmY09TFlOYGkPgiPVHIM2re2Myav38CKgSi3VKWUaAyndoOmQj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eqS1biAM; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750420834; x=1781956834;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=w/25pdsb7c2UBnYp18+Oc232d/2gPhKJ+C4vXgNX6LQ=;
  b=eqS1biAM/PY6VTrj0XDrvAx117GPWEHbKk2uOQiSD23NcT62sJlYI4Kd
   3DbkAKYdicbtvjMbnC4GRyZe5gb9jKZhMgpsS2TmjZUnvf6+PAmHGqFsz
   kTkiCP9w2vXH78/0oDvIH9hPfxzXVSALdy3SAb4h3IkbubtCEQexaIKAA
   +Wo1HmIPNBSDQuxivxRdkMdj4+4XniyHDDKGTO12AJWDW9KozlHEqX4bw
   +5NdE9A/HlXdMdG0fuEDXGs8evHO6Qc3i1Xids8+/5aZPvXAWmgLc+Dsf
   fsmq7JewrUpj/VAyHpEZtAUQFDImxuCOe99G8mtXvU3f7A3/ZzRPkO/6T
   A==;
X-IronPort-AV: E=Sophos;i="6.16,251,1744070400"; 
   d="scan'208";a="837455426"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 12:00:29 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:56193]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.147:2525] with esmtp (Farcaster)
 id f39858af-1d74-433e-8bd7-937764bedc3b; Fri, 20 Jun 2025 12:00:27 +0000 (UTC)
X-Farcaster-Flow-ID: f39858af-1d74-433e-8bd7-937764bedc3b
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 20 Jun 2025 12:00:27 +0000
Received: from [10.95.102.166] (10.95.102.166) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 20 Jun 2025 12:00:25 +0000
Message-ID: <2097f155-c459-40e1-93e8-3d501ae66b42@amazon.com>
Date: Fri, 20 Jun 2025 13:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
To: Peter Xu <peterx@redhat.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <jannh@google.com>,
	<ryan.roberts@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com> <aEiwHjl4tsUt98sh@x1.local>
 <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com> <aEl9CNGLY0Sil7nq@x1.local>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <aEl9CNGLY0Sil7nq@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D015EUB002.ant.amazon.com (10.252.51.123) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)

On 11/06/2025 13:56, Peter Xu wrote:
> On Wed, Jun 11, 2025 at 01:09:32PM +0100, Nikita Kalyazin wrote:
>>
>>
>> On 10/06/2025 23:22, Peter Xu wrote:
>>> On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
>>>> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
>>>> non-huge pages by calling vm_ops->fault().  A new VMF flag,
>>>> FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
>>>> handle_userfault().
>>>
>>> It's not clear yet on why this is needed to be generalized out of the blue.
>>>
>>> Some mentioning of guest_memfd use case might help for other reviewers, or
>>> some mention of the need to introduce userfaultfd support in kernel
>>> modules.
>>
>> Hi Peter,
>>
>> Sounds fair, thank you.
>>
>>>>
>>>> Suggested-by: James Houghton <jthoughton@google.com>
>>>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>>>> ---
>>>>    include/linux/mm_types.h |  4 ++++
>>>>    mm/hugetlb.c             |  2 +-
>>>>    mm/shmem.c               |  9 ++++++---
>>>>    mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
>>>>    4 files changed, 38 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>> index 0234f14f2aa6..2f26ee9742bf 100644
>>>> --- a/include/linux/mm_types.h
>>>> +++ b/include/linux/mm_types.h
>>>> @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
>>>>     * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>>>>     *                        We should only access orig_pte if this flag set.
>>>>     * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
>>>> + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
>>>> + *                                 minor handler as it is being called by the
>>>> + *                                 userfaultfd code itself.
>>>
>>> We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
>>> as it's not easy to follow when without userfault minor context.  It might
>>> be better to use generic terms like NO_USERFAULT.
>>
>> Yes, I agree, can name it more generically.
>>
>>> Said that, I wonder if we'll need to add a vm_ops anyway in the latter
>>> patch, whether we can also avoid reusing fault() but instead resolve the
>>> page faults using the vm_ops hook too.  That might be helpful because then
>>> we can avoid this new FAULT_FLAG_* that is totally not useful to
>>> non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
>>> struct below just to suite the current fault() interfacing.
>>
>> I'm not sure I fully understand that.  Calling fault() op helps us reuse the
>> FS specifics when resolving the fault.  I get that the new op can imply the
>> userfault flag so the flag doesn't need to be exposed to mm, but doing so
>> will bring duplication of the logic within FSes between this new op and the
>> fault(), unless we attempt to factor common parts out.  For example, for
>> shmem_get_folio_gfp(), we would still need to find a way to suppress the
>> call to handle_userfault() when shmem_get_folio_gfp() is called from the new
>> op.  Is that what you're proposing?
> 
> Yes it is what I was proposing.  shmem_get_folio_gfp() always has that
> handling when vmf==NULL, then vma==NULL and userfault will be skipped.
> 
> So what I was thinking is one vm_ops.userfaultfd_request(req), where req
> can be:
> 
>    (1) UFFD_REQ_GET_SUPPORTED: this should, for existing RAM-FSes return
>        both MISSING/WP/MINOR.  Here WP should mean sync-wp tracking, async
>        was so far by default almost supported everywhere except
>        VM_DROPPABLE. For guest-memfd in the future, we can return MINOR only
>        as of now (even if I think it shouldn't be hard to support the rest
>        two..).
> 
>    (2) UFFD_REQ_FAULT_RESOLVE: this should play the fault() role but well
>        defined to suite userfault's need on fault resolutions.  It likely
>        doesn't need vmf as the parameter, but likely (when anon isn't taking
>        into account, after all anon have vm_ops==NULL..) the inode and
>        offsets, perhaps some flag would be needed to identify MISSING or
>        MINOR faults, for example.
> 
> Maybe some more.
> 
> I was even thinking whether we could merge hugetlb into the picture too on
> generalize its fault resolutions.  Hugetlb was always special, maye this is
> a chance too to make it generalized, but it doesn't need to happen in one
> shot even if it could work.  We could start with shmem.
> 
> So this does sound like slightly involved, and I'm not yet 100% sure this
> will work, but likely.  If you want, I can take a stab at this this week or
> next just to see whether it'll work in general.  I also don't expect this
> to depend on guest-memfd at all - it can be alone a refactoring making
> userfault module-ready.

Thanks for explaining that.  I played a bit with it myself and it 
appears to be working for the MISSING mode for both shmem and 
guest_memfd.  Attaching my sketch below.  Please let me know if this is 
how you see it.

I found that arguments and return values are significantly different 
between the two request types, which may be a bit confusing, although we 
do not expect many callers of those.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8483e09aeb2c..eb30b23b24d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -603,6 +603,16 @@ struct vm_fault {
  					 */
  };

+#ifdef CONFIG_USERFAULTFD
+/*
+ * Used by userfaultfd_request().
+ */
+enum uffd_req {
+	UFFD_REQ_GET_SUPPORTED, /* query supported userfaulfd modes */
+	UFFD_REQ_FAULT_RESOLVE, /* request fault resolution */
+};
+#endif
+
  /*
   * These are the virtual MM functions - opening of an area, closing and
   * unmapping it (needed to keep files on disk up-to-date etc), pointer
@@ -680,6 +690,22 @@ struct vm_operations_struct {
  	 */
  	struct page *(*find_special_page)(struct vm_area_struct *vma,
  					  unsigned long addr);
+
+#ifdef CONFIG_USERFAULTFD
+	/*
+	 * Called by the userfaultfd code to query supported modes or request
+	 * fault resolution.
+	 * If called with req UFFD_REQ_GET_SUPPORTED, it returns a bitmask
+	 * of modes as in struct uffdio_register.  No other arguments are
+	 * used.
+	 * If called with req UFFD_REQ_FAULT_RESOLVE, it resolves the fault
+	 * using the mode specified in the mode argument. The inode, pgoff and
+	 * foliop arguments must be set accordingly.
+	 */
+	int (*userfaultfd_request)(enum uffd_req req, int mode,
+				   struct inode *inode, pgoff_t pgoff,
+				   struct folio **foliop);
+#endif
  };

  #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d144..1cabb925da0e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -222,7 +222,11 @@ static inline bool vma_can_userfault(struct 
vm_area_struct *vma,
  		return false;

  	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+	    (!is_vm_hugetlb_page(vma) &&
+	     !vma->vm_ops->userfaultfd_request &&
+	     !(vma->vm_ops->userfaultfd_request(UFFD_REQ_GET_SUPPORTED, 0,
+						NULL, 0, NULL) &
+	           UFFDIO_REGISTER_MODE_MINOR)))
  		return false;

  	/*
@@ -243,8 +247,11 @@ static inline bool vma_can_userfault(struct 
vm_area_struct *vma,
  #endif

  	/* By default, allow any of anon|shmem|hugetlb */
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	    vma_is_shmem(vma);
+	return vma_is_anonymous(vma) ||
+	    is_vm_hugetlb_page(vma) ||
+	    (vma->vm_ops->userfaultfd_request &&
+	     vma->vm_ops->userfaultfd_request(UFFD_REQ_GET_SUPPORTED, 0, NULL,
+					      0, NULL));
  }

  static inline bool vma_has_uffd_without_event_remap(struct 
vm_area_struct *vma)
diff --git a/mm/shmem.c b/mm/shmem.c
index 1ede0800e846..a5b5c4131dcf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5203,6 +5203,40 @@ static int shmem_error_remove_folio(struct 
address_space *mapping,
  	return 0;
  }

+#ifdef CONFIG_USERFAULTFD
+static int shmem_userfaultfd_request(enum uffd_req req, int mode,
+				     struct inode *inode, pgoff_t pgoff,
+				     struct folio **foliop)
+{
+	int ret;
+
+	switch (req) {
+	case UFFD_REQ_GET_SUPPORTED:
+		ret =
+		    UFFDIO_REGISTER_MODE_MISSING |
+		    UFFDIO_REGISTER_MODE_WP |
+		    UFFDIO_REGISTER_MODE_MINOR;
+		break;
+	case UFFD_REQ_FAULT_RESOLVE:
+		ret = shmem_get_folio(inode, pgoff, 0, foliop, SGP_NOALLOC);
+		if (ret == -ENOENT)
+			ret = -EFAULT;
+		if (ret)
+			break;
+		if (!*foliop) {
+			ret = -EFAULT;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+#endif
+
  static const struct address_space_operations shmem_aops = {
  	.writepage	= shmem_writepage,
  	.dirty_folio	= noop_dirty_folio,
@@ -5306,6 +5340,9 @@ static const struct vm_operations_struct 
shmem_vm_ops = {
  	.set_policy     = shmem_set_policy,
  	.get_policy     = shmem_get_policy,
  #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_request = shmem_userfaultfd_request,
+#endif
  };

  static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5315,6 +5352,9 @@ static const struct vm_operations_struct 
shmem_anon_vm_ops = {
  	.set_policy     = shmem_set_policy,
  	.get_policy     = shmem_get_policy,
  #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_request = shmem_userfaultfd_request,
+#endif
  };

  int shmem_init_fs_context(struct fs_context *fc)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..efc150bf5691 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -392,16 +392,18 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
  	struct page *page;
  	int ret;

-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
-	/* Our caller expects us to return -EFAULT if we failed to find folio */
-	if (ret == -ENOENT)
-		ret = -EFAULT;
+	if (!dst_vma->vm_ops->userfaultfd_request ||
+	    !(dst_vma->vm_ops->userfaultfd_request(UFFD_REQ_GET_SUPPORTED, 0,
+						   NULL, 0, NULL) &
+	      UFFDIO_REGISTER_MODE_MINOR)) {
+		return -EFAULT;
+	}
+
+	ret = dst_vma->vm_ops->userfaultfd_request(UFFD_REQ_FAULT_RESOLVE,
+						   UFFDIO_REGISTER_MODE_MINOR,
+						   inode, pgoff, &folio);
  	if (ret)
  		goto out;
-	if (!folio) {
-		ret = -EFAULT;
-		goto out;
-	}

  	page = folio_file_page(folio, pgoff);
  	if (PageHWPoison(page)) {
@@ -770,10 +772,10 @@ static __always_inline ssize_t mfill_atomic(struct 
userfaultfd_ctx *ctx,
  		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
  					     src_start, len, flags);

-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+	if (!vma_is_anonymous(dst_vma) &&
+            (!dst_vma->vm_ops->userfaultfd_request ||
+	     (!dst_vma->vm_ops->userfaultfd_request(UFFD_REQ_GET_SUPPORTED, 0,
+						    NULL, 0, NULL))))
  		goto out_unlock;

  	while (src_addr < src_start + len) {

> 
> Thanks,
> 
> --
> Peter Xu
> 


