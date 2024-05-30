Return-Path: <linux-fsdevel+bounces-20537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D768D4F83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28641F24C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BC2032D;
	Thu, 30 May 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJR9OygE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A224DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084756; cv=none; b=sV4QM59Lup9h3hXOUExzSfGJSswjh/aRZC3zwXBSLCP9ce16coVMqrNsRi+5U5RwKTB/O5fWmeWJbMdQyIQQ8/uDtEkZWb+KbkuQKG7xKY3/8rOt0moQ7r15z7wdWaWvep4SiUcHZ6/ALOqsbJ3nDrfYbLwZDLwt7Fxq0wmp5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084756; c=relaxed/simple;
	bh=8oe5ZGKRmc0w4puK0OahLsaaIFzP7EEs/9vQk4KLAUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIF76uslrp7YCJgBAAfK2Ci3fcSf0Ruo448mdtsF+npuxl7cwYOdrjsKSESsIF4X+IB7+t8KcEXDLHP7nJaniXdoxkYkp/o2zKsEn0uIfkKaOaS4jVuIYomEdCcs1Cl1SXF+q5yCBnnhnCfoeoeniAUSHSTxH35qWq5kJo71MzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJR9OygE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717084753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDf89+8SqxfDlWuRy59Dw7AYureYlAUuVk3fKH1rxSE=;
	b=eJR9OygE/TjZ9hBQaxNfHrCXI4M53n8TMGukMkW6rGbqJmxiXB4YP+yHokM/ZzzOnjBE2q
	QvHFzWg8p/+C0p1uO3cZxyBysiStiCpi5AY5XPZ8NYc+pCAvg/E9HixrfOJUX1eAhj6s70
	9ZPXrxw597j6yAGiPEJ5pDdp7JeT5ag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-XkBagONkNfGhLO6Snpq0tQ-1; Thu, 30 May 2024 11:59:10 -0400
X-MC-Unique: XkBagONkNfGhLO6Snpq0tQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EA7D185A780;
	Thu, 30 May 2024 15:59:09 +0000 (UTC)
Received: from fedora (unknown [10.22.9.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 664B0492BC6;
	Thu, 30 May 2024 15:59:08 +0000 (UTC)
Date: Thu, 30 May 2024 11:59:06 -0400
From: Audra Mitchell <audra@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, raquini@redhat.com
Subject: Re: [PATCH 1/2] Fix userfaultfd_api to return EINVAL as expected
Message-ID: <ZliiSkTsxjVQGu1n@fedora>
References: <20240507195510.283744-1-audra@redhat.com>
 <939a16f2-7b66-45a6-a043-4821bd3c71dc@redhat.com>
 <Zjt3Apr8ILFA4oK_@fedora>
 <ZjuIEH8TW2tWcqXQ@x1n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjuIEH8TW2tWcqXQ@x1n>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, May 08, 2024 at 10:11:28AM -0400, Peter Xu wrote:
> On Wed, May 08, 2024 at 08:58:42AM -0400, Audra Mitchell wrote:
> > On Wed, May 08, 2024 at 09:39:10AM +0200, David Hildenbrand wrote:
> > > On 07.05.24 21:55, Audra Mitchell wrote:
> > > > Currently if we request a feature that is not set in the Kernel
> > > > config we fail silently and return the available features. However, the
> > > > documentation indicates we should return an EINVAL.
> > > 
> > > I assume you are referencing
> > > 
> > > "EINVAL The API version requested in the api field is not supported by this
> > > kernel, or  the  features  field passed to the kernel includes feature bits
> > > that are not supported by the current kernel version."
> > > 
> > > and
> > > 
> > > "To  enable  userfaultfd features the application should set a bit
> > > corresponding to each feature it wants to enable in the features field. If
> > > the kernel supports all the requested features it will enable them.
> > > Otherwise it will zero out the returned uffdio_api structure and return
> > > EINVAL.
> > > "
> > > 
> > > in which case I agree.
> > 
> > Yep! I'm referencing the man page.
> > 
> > > 
> > > > 
> > > > We need to fix this issue since we can end up with a Kernel warning
> > > > should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> > > > a kernel with the config not set with this feature.
> > > 
> > > Can you mention which exact one? Is it a WARN* or a pr_warn() ?
> > 
> > Here is the kernel warning I get:
> > 
> > [  200.803094] unrecognized swap entry 0x7c00000000000001
> > [  200.808270] ------------[ cut here ]------------
> > [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
> > [  200.820738] Modules linked in: qrtr bridge stp llc rfkill sunrpc amd_atl intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm ipmi_ssif acpi_ipmi i2c_piix4 ipmi_si wmi_bmof dcdbas dell_smbios dell_wmi_descriptor ptdma ipmi_devintf rapl ipmi_msghandler acpi_power_meter pcspkr k10temp xfs libcrc32c sd_mod t10_pi mgag200 sg drm_kms_helper crct10dif_pclmul i2c_algo_bit ahci crc32_pclmul drm_shmem_helper libahci crc32c_intel drm i40e libata ghash_clmulni_intel tg3 ccp megaraid_sas sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod fuse
> > [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
> > [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
> > [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> > [  200.889595] Code: 83 fa 02 0f 86 44 01 00 00 83 f9 17 0f 84 e1 00 00 00 83 f9 1f 0f 84 d0 00 00 00 48 89 c6 48 c7 c7 00 e4 dd bb e8 73 a2 de ff <0f> 0b e9 44 fd ff ff 45 0f b6 44 24 20 41 f6 c0 f4 75 27 4c 89 ee
> > [  200.908348] RSP: 0018:ffffa18d2e6c37c8 EFLAGS: 00010246
> > [  200.913584] RAX: 000000000000002a RBX: 00007f26d3600000 RCX: 0000000000000000
> > [  200.920730] RDX: 0000000000000000 RSI: ffff93503f9a0bc0 RDI: ffff93503f9a0bc0
> > [  200.927867] RBP: 00007f26d35cc000 R08: 0000000000000000 R09: ffffa18d2e6c3688
> > [  200.935009] R10: ffffa18d2e6c3680 R11: ffffffffbc9de448 R12: ffffa18d2e6c39e8
> > [  200.942149] R13: ffff92d1ebc15b50 R14: ffff93114e0cde60 R15: ffffa18d2e6c3928
> > [  200.949291] FS:  0000000000000000(0000) GS:ffff93503f980000(0000) knlGS:0000000000000000
> > [  200.957384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  200.963140] CR2: 00007f26b1600658 CR3: 00000040905ba000 CR4: 0000000000350ef0
> > [  200.970283] Call Trace:
> > [  200.972745]  <TASK>
> > [  200.974862]  ? __warn+0x7f/0x130
> > [  200.978108]  ? zap_pte_range+0x43d/0x660
> > [  200.982044]  ? report_bug+0x18a/0x1a0
> > [  200.985720]  ? handle_bug+0x3c/0x70
> > [  200.989219]  ? exc_invalid_op+0x14/0x70
> > [  200.993068]  ? asm_exc_invalid_op+0x16/0x20
> > [  200.997265]  ? zap_pte_range+0x43d/0x660
> > [  201.001199]  ? zap_pte_range+0x43d/0x660
> > [  201.005134]  zap_pmd_range.isra.0+0xf9/0x230
> > [  201.009416]  unmap_page_range+0x2d4/0x4a0
> > [  201.013436]  unmap_vmas+0xa8/0x180
> > [  201.016854]  exit_mmap+0xea/0x3b0
> > [  201.020191]  __mmput+0x43/0x120
> > [  201.023342]  exit_mm+0xb1/0x110
> > [  201.026496]  do_exit+0x270/0x4f0
> > [  201.029739]  do_group_exit+0x2c/0x80
> > [  201.033326]  get_signal+0x886/0x8b0
> > [  201.036828]  ? srso_return_thunk+0x5/0x5f
> > [  201.040848]  arch_do_signal_or_restart+0x25/0x100
> > [  201.045563]  ? srso_return_thunk+0x5/0x5f
> > [  201.049583]  ? vma_set_page_prot+0x5e/0xc0
> > [  201.053692]  ? srso_return_thunk+0x5/0x5f
> > [  201.057713]  ? syscall_exit_work+0xff/0x130
> > [  201.061908]  syscall_exit_to_user_mode+0x1b3/0x200
> > [  201.066712]  do_syscall_64+0x87/0x160
> > [  201.070387]  ? srso_return_thunk+0x5/0x5f
> > [  201.074405]  ? do_mmap+0x416/0x5f0
> > [  201.077821]  ? srso_return_thunk+0x5/0x5f
> > [  201.081840]  ? rseq_get_rseq_cs+0x1d/0x240
> > [  201.085950]  ? srso_return_thunk+0x5/0x5f
> > [  201.089970]  ? rseq_ip_fixup+0x6d/0x1d0
> > [  201.093823]  ? vm_mmap_pgoff+0x117/0x1a0
> > [  201.097755]  ? srso_return_thunk+0x5/0x5f
> > [  201.101776]  ? srso_return_thunk+0x5/0x5f
> > [  201.105795]  ? syscall_exit_to_user_mode+0x78/0x200
> > [  201.110685]  ? srso_return_thunk+0x5/0x5f
> > [  201.114706]  ? do_syscall_64+0x87/0x160
> > [  201.118557]  ? srso_return_thunk+0x5/0x5f
> > [  201.122575]  ? __count_memcg_events+0x49/0xb0
> > [  201.126944]  ? srso_return_thunk+0x5/0x5f
> > [  201.130967]  ? srso_return_thunk+0x5/0x5f
> > [  201.134986]  ? syscall_exit_work+0xff/0x130
> > [  201.139184]  ? srso_return_thunk+0x5/0x5f
> > [  201.143205]  ? syscall_exit_to_user_mode+0x78/0x200
> > [  201.148093]  ? srso_return_thunk+0x5/0x5f
> > [  201.152114]  ? do_syscall_64+0x87/0x160
> > [  201.155960]  ? srso_return_thunk+0x5/0x5f
> > [  201.159984]  ? sched_clock_cpu+0xb/0x190
> > [  201.163916]  ? srso_return_thunk+0x5/0x5f
> > [  201.167939]  ? irqtime_account_irq+0x40/0xc0
> > [  201.172220]  ? srso_return_thunk+0x5/0x5f
> > [  201.176243]  ? srso_return_thunk+0x5/0x5f
> > [  201.180263]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  201.185326] RIP: 0033:0x7f26dfd0735b
> > [  201.188939] Code: Unable to access opcode bytes at 0x7f26dfd07331.
> > [  201.195128] RSP: 002b:00007fffce176868 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
> > [  201.202700] RAX: fffffffffffffffc RBX: 00007f26dfe60000 RCX: 00007f26dfd0735b
> > [  201.209841] RDX: 0000000000000003 RSI: 0000000001000000 RDI: 00007f26af401000
> > [  201.216983] RBP: 00007f26b0400640 R08: 00000000ffffffff R09: 0000000000000000
> > [  201.224127] R10: ffffffffffffffc0 R11: 0000000000000206 R12: 0000000000000000
> > [  201.231267] R13: 000000000040d320 R14: 0000000000000000 R15: 0000000000000000
> > [  201.238413]  </TASK>
> > [  201.240610] ---[ end trace 0000000000000000 ]---
> > [  201.245250] unrecognized swap entry 0x7c00000000000001
> > 
> > 
> > 
> > > 
> > > Likely we want "Fixes:" here.
> > 
> > This could be seen as a continuation of the problem 
> > 2ff559f31a5d Revert "userfaultfd: don't fail on unrecognized features" 
> > was trying to solve. However, this patch only checks to make sure we didnt 
> > ask for a feature outside the possible range of features. We are still missing
> > a check to confirm the requested features are also configured on. So I guess 
> > the "Fixes" tag would be for this patch?
> > 914eedcb9ba0 userfaultfd: don't fail on unrecognized features
> 
> Even though 914eedcb9ba0 was problematic but it might be innocent in this
> regard, as we miss such check even before that commit.
> 
> Perhaps the right Fixes should be when there will be flags that will
> only be supported conditionally, which should be the wp support.  In that
> case, it could be:
> 
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> 
> But it's still complicated though even if we want to backport, as this
> specific check for userfault was added later... in:
> 
> 00b151f21f39 ("mm/userfaultfd: fail uffd-wp registration if not supported")
> 
> In summary: I think we can stick with Fixes on e06f1e1dd499, but we don't
> copy stable.  The major reason we don't copy stable here is not only about
> complexity of such backport, but also that there can be apps trying to pass
> in unsupported bits (even if the kernel didn't support it) but keep using
> MISSING mode only, then we shouldn't fail them easily after a stable
> upgrade.  Just smells dangerous to backport.
> 
> When at it and repost, would you mind consolidate the two feature list
> check together?  We had the previous check here:
> 
> 	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
> 		goto err_out;
> 
> If with this patch IIUC this previous check can be removed (still need to
> check UFFD_API).
> 
> Thanks,
> 
> > 
> > Happy to get your input here!
> > 
> > Thanks in advance!
> > 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > > > ---
> > > >   fs/userfaultfd.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 60dcfafdc11a..17210558de79 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -2073,6 +2073,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
> > > >   	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> > > >   	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> > > >   #endif
> > > > +
> > > > +	ret = -EINVAL;
> > > > +	if (features & ~uffdio_api.features)
> > > > +		goto err_out;
> > > > +
> > > >   	uffdio_api.ioctls = UFFD_API_IOCTLS;
> > > >   	ret = -EFAULT;
> > > >   	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
> > > 
> > > CCing Peter.
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David / dhildenb
> > > 
> > 
> 
> -- 
> Peter Xu

I didn't forget about this, but I did find another test case that is going to
break with this change. Some other things landed on my plate/schedule so I'll
be returning to this in a week or two. I'll make sure I take your feedback
when I submit v2. Thanks again!

> 


