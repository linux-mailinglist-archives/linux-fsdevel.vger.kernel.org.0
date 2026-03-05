Return-Path: <linux-fsdevel+bounces-79498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDPoLNKbqWn7AwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:05:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D4221424D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A95C730635D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1B3BA242;
	Thu,  5 Mar 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osfIcpMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C073B95EC;
	Thu,  5 Mar 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722929; cv=none; b=k7vFAK30Jcp0Ylm06cvX+R98vUn84m/3YNOyzRAPw0iKpENgAfF7priT5JdDxNK1XNvjrgX0oXJkK6OIGyv2dunWluBJST5VDQ/wRFokGz0V4cZ1m+oEAgc9gsav2A6C/DfHILrq5fzSf8ZaZtADo3US0gC7gjxhUc0/7SawpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722929; c=relaxed/simple;
	bh=wRgZmhQjr00u6xNwov7+QTN0n9PgF8LRxMXoCLehj2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjvdQkarulAjvaMn/8DXfQIJJxtXV5nq7EFPgxZCPTfOn0BfmRSu61IJmOtn9MZdqKiiEcE/LNARBdYjv+wzldQn6q8jBa0tBONH82DAdLD7UT9h03ij9jhGB/rPyCnaS/caHFcyPWB4z6/3rsOOZtTvlH82mPXcfWg9lo+bN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osfIcpMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6767AC2BCAF;
	Thu,  5 Mar 2026 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722929;
	bh=wRgZmhQjr00u6xNwov7+QTN0n9PgF8LRxMXoCLehj2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osfIcpMz9xkEHd1thmcRC7ID5peuXO60NX3dAfXWNx8XuxafCP3huQAqeo0Z50NTL
	 7WHXGEd9l4SBIO3qFyZSZs51cQDgZ/txEREq+UVMtkAIWHPQdU6rlIkMwasA+X4H1R
	 0vgTKrOo0sYCn09iGpla9DwhdJK5l6HmDrrqVHFOs3zTPxZNOSLtG7KttSGuKKL7C5
	 CGHdJwOurKzj6Z9/m8NtjplDD54vC/3JtqBAJaS9/CVLprX6BFPrW616tHCOxrmc4G
	 1fXwqivYf5kdVG+FCyXb3KTvQbaG5LkGZXWNmjd7ibSYSDapxeuO3BMr8v1Fwg+Yeu
	 JQAA3sGPUYrCQ==
Date: Thu, 5 Mar 2026 15:01:55 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/6] tools/testing/vma: add test for vma_flags_test(),
 vma_desc_test()
Message-ID: <f6f396d2-1ba2-426f-b756-d8cc5985cc7c@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
 <376a39eb9e134d2c8ab10e32720dd292970b080a.1772704455.git.ljs@kernel.org>
 <f11ec383-d688-4512-a9ea-700cc2d42f3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11ec383-d688-4512-a9ea-700cc2d42f3a@kernel.org>
X-Rspamd-Queue-Id: 76D4221424D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79498-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lucifer.local:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:52:20PM +0100, David Hildenbrand (Arm) wrote:
> On 3/5/26 11:50, Lorenzo Stoakes (Oracle) wrote:
> > Now we have helpers which test singular VMA flags - vma_flags_test() and
> > vma_desc_test() - add a test to explicitly assert that these behave as
> > expected.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  tools/testing/vma/tests/vma.c | 36 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
> > index f031e6dfb474..1aa94dd7e74a 100644
> > --- a/tools/testing/vma/tests/vma.c
> > +++ b/tools/testing/vma/tests/vma.c
> > @@ -159,6 +159,41 @@ static bool test_vma_flags_word(void)
> >  	return true;
> >  }
> >
> > +/* Ensure that vma_flags_test() and friends works correctly. */
> > +static bool test_vma_flags_test(void)
> > +{
> > +	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> > +					       VMA_EXEC_BIT, 64, 65);
>
> When already using numbers, I was wondering whether you'd want to stick
> to numbers only here.

Numbers are for flags > 64 bits, we currently don't define any, it's to make
sure everything works at higher bitmap sizes, the tests currently set the bitmap
size to 128 bits.

>
> > +	struct vm_area_desc desc;
>
>
> struct vm_area_desc desc = {
> 	.vma_flags = flags,
> };
>
> ?

Ack can do, fix-patch for Andrew below :)

Cheers, Lorenzo

----8<----
From 5cc64e6c1884aaf995ce6398e36d5844c246352d Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Date: Thu, 5 Mar 2026 14:59:58 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 1aa94dd7e74a..f6edd44f4e9e 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -164,9 +164,9 @@ static bool test_vma_flags_test(void)
 {
 	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
 					      VMA_EXEC_BIT, 64, 65);
-	struct vm_area_desc desc;
-
-	desc.vma_flags = flags;
+	struct vm_area_desc desc = {
+		.vma_flags = flags,
+	};

 #define do_test(_flag)					\
 	ASSERT_TRUE(vma_flags_test(&flags, _flag));	\
--
2.53.0

