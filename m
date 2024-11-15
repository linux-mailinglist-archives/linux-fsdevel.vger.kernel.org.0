Return-Path: <linux-fsdevel+bounces-34984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC849CF58F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B9286C22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F901E2304;
	Fri, 15 Nov 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QxGu9sOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2B1714C0;
	Fri, 15 Nov 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701659; cv=none; b=gT8GAsl4IP5ca4oliSSobuife09n6o7rR4Nc6WtDT1Ts6wi1QqP1juUChvk8/pgRuOVMaikpQ9jfkRDQ+8CB9F7JnkOpErH9F+VEmga1KrRIzw414xWMExvdsxdQmBV00icNX5QRbhv6z+uaQKy8nwI76ox8BgF2zRJqvfmIMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701659; c=relaxed/simple;
	bh=mZJ8M9SYhsdIJfeTLGgEYypyiHJEqPM7nuzJIucP1rQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN4h9gTlgvabR1oZkwvoQbqhbM1ZkIBX+zUVJNZcsWxBHPYE39f/DR5MT63AdOq/t++rY01Rp3yEIJgac1LFY9z6pBR8njqYZMK7/GO3ttrKYCMz0ulDDbRPbMZmUJoZOhsMjRJwlgijFxfiu2774eiMQ+DHUoIoFMVzCo7eyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QxGu9sOX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBmldF014249;
	Fri, 15 Nov 2024 20:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1pQWydqckVHECTn8cI0N1o4o
	6AmIUz9H8m9Aj8yXbao=; b=QxGu9sOXsn7OBHFwFvgBCXCIuubF+i5UQAzqNgA7
	KE069feTbuiGXtcKMyw0FiRpQVyDCCEW7Z+dSmeQwySaOHd6nqFhWR7uaEkXbwtg
	s7s+P7SsxhDMGC9CA6dZ0tgWej3vg/WDWJyjkBF6J9Vl/h+vt3JMIoO3W8WY3LBp
	hA26kV9QXMUw+TAx9+NJo/WK7iYQ0JDulyuSakRPXZ8olWrTgmRFf7d1HUEmACTx
	hLQAWAjXUJO0EJOk/4k7k1UUG9VIYdlLgnyyZ57ZyR0MRiSHcODoDVLoT36CPkwa
	oWtkiz2tUWDTaNxYQbe+K5PcODGS8LXCYyDVvkbwilcizA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wwddapu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 20:14:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFKE0gU025430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 20:14:00 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 12:14:00 -0800
Date: Fri, 15 Nov 2024 12:13:59 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: David Hildenbrand <david@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Fuad
 Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>,
        Mike
 Rapoport <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Wilcox
	<willy@infradead.org>,
        James Gowans <jgowans@amazon.com>, <linux-fsdevel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v3 1/2] KVM: guest_memfd: Convert .free_folio() to
 .release_folio()
Message-ID: <20241115121119110-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
 <20241113-guestmem-library-v3-1-71fdee85676b@quicinc.com>
 <c650066d-18c8-4711-ae22-3c6c660c713e@redhat.com>
 <d2147b7c-bb2e-4434-aa10-40cacac43d4f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d2147b7c-bb2e-4434-aa10-40cacac43d4f@redhat.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hUh8BuC6vM8H3tLNDCLcMKmEjCfP2ZGr
X-Proofpoint-ORIG-GUID: hUh8BuC6vM8H3tLNDCLcMKmEjCfP2ZGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=995 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150169

On Fri, Nov 15, 2024 at 11:58:59AM +0100, David Hildenbrand wrote:
> On 15.11.24 11:58, David Hildenbrand wrote:
> > On 13.11.24 23:34, Elliot Berman wrote:
> > > When guest_memfd becomes a library, a callback will need to be made to
> > > the owner (KVM SEV) to transition pages back to hypervisor-owned/shared
> > > state. This is currently being done as part of .free_folio() address
> > > space op, but this callback shouldn't assume that the mapping still
> > > exists. guest_memfd library will need the mapping to still exist to look
> > > up its operations table.
> > 
> > I assume you mean, that the mapping is no longer set for the folio (it
> > sure still exists, because we are getting a callback from it :) )?
> > 
> > Staring at filemap_remove_folio(), this is exactly what happens:
> > 
> > We remember folio->mapping, call __filemap_remove_folio(), and then call
> > filemap_free_folio() where we zap folio->mapping via page_cache_delete().
> > 
> > Maybe it's easier+cleaner to also forward the mapping to the
> > free_folio() callback, just like we do with filemap_free_folio()? Would
> > that help?
> > 
> > CCing Willy if that would be reasonable extension of the free_folio
> > callback.
> > 

I like this approach too. It would avoid the checks we have to do in the
invalidate_folio() callback and is cleaner.

- Elliot

> > > 
> > > .release_folio() and .invalidate_folio() address space ops can serve the
> > > same purpose here. The key difference between release_folio() and
> > > free_folio() is whether the mapping is still valid at time of the
> > > callback. This approach was discussed in the link in the footer, but not
> > > taken because free_folio() was easier to implement.
> > > 
> > > Link: https://lore.kernel.org/kvm/20231016115028.996656-1-michael.roth@amd.com/
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >    virt/kvm/guest_memfd.c | 19 ++++++++++++++++---
> > >    1 file changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index 47a9f68f7b247f4cba0c958b4c7cd9458e7c46b4..13f83ad8a4c26ba82aca4f2684f22044abb4bc19 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -358,22 +358,35 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
> > >    }
> > >    #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > > -static void kvm_gmem_free_folio(struct folio *folio)
> > > +static bool kvm_gmem_release_folio(struct folio *folio, gfp_t gfp)
> > >    {
> > >    	struct page *page = folio_page(folio, 0);
> > >    	kvm_pfn_t pfn = page_to_pfn(page);
> > >    	int order = folio_order(folio);
> > >    	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset,
> > > +				      size_t len)
> > > +{
> > > +	WARN_ON_ONCE(offset != 0);
> > > +	WARN_ON_ONCE(len != folio_size(folio));
> > > +
> > > +	if (offset == 0 && len == folio_size(folio))
> > > +		filemap_release_folio(folio, 0);
> > >    }
> > >    #endif
> > >    static const struct address_space_operations kvm_gmem_aops = {
> > >    	.dirty_folio = noop_dirty_folio,
> > > -	.migrate_folio	= kvm_gmem_migrate_folio,
> > > +	.migrate_folio = kvm_gmem_migrate_folio,
> > >    	.error_remove_folio = kvm_gmem_error_folio,
> > >    #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > > -	.free_folio = kvm_gmem_free_folio,
> > > +	.release_folio = kvm_gmem_release_folio,
> > > +	.invalidate_folio = kvm_gmem_invalidate_folio,
> > >    #endif
> > >    };
> > > 
> > 
> > 
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

