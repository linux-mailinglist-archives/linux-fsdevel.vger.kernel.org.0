Return-Path: <linux-fsdevel+bounces-78887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB3GOYF0pWnfBgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 12:29:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AB1D77E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 12:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9737301BA82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836036308D;
	Mon,  2 Mar 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WPkbthSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6E331220
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450942; cv=none; b=sN6NwVagxnpJG9iyAnrwyUz6T6lgDZIngKN3kjs1+FU5+LnJfwnryOzm+MJifOSoz4eNDdi2l+3AK63NKt6neSaBdYiBNe1Wax/J1ODoPdrcT4tg84qwmptgHlwtLEF0vkyANcjxW11qzLpFtt4sMUuQxFHo2VBzRuktcW8mbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450942; c=relaxed/simple;
	bh=K5ULHdjkJWFTrPH0dXx05JrTB8YMHL8lkvPnUG9C6K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9Y3R/Zt6FVCyItWB+kPyOl7J1gc3QvFOeB2JJH2+eJvsTvunsVRIAn+Nsm7idE7flgex1xiBHmFknHp7dpiS1suChjeenEq3ZSOZMyvtZcQhdoEhmAd0SYjGEzVZRlxjK2oeBESv68tDyQRf3F0YJYXSA+1w67BYfbk3ZnrX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WPkbthSN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836d541968so4116385e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 03:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772450939; x=1773055739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aYNafgGLMp2zV21P8+oK10uFDyPLpaq2eVinuia9OY=;
        b=WPkbthSNzjYrkGU2OaP3MGRaE9A5AuVqltBR4seCVfRAZXAhlC2TmDaxdGFWEk7/FL
         +Ozwiv1gLw5N71yFaR9/B/GpXOPMZk3ECkeWegS0Ge9zjts8Brb4zpbLMhBLOJP+E20V
         Hs4PcY2KtdCjAuGG7dKrzJGniGx+rzz35WjCQUkni89jmc2Q20+6Dl8WLZrwiBm5rPCp
         SfYa99XbWEjSffA4H7rVRo5lYkAAXl6e/v1BIDONDbAJHKl8/1Py2xtyICM4Er+bgT17
         rbpFg9Wp+FpJ0JgiVdfqJX/KzMX6DXLZHg37CTAI3ZkB/Qa7KYzAu+5JhO3A5r53N0MK
         z4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450939; x=1773055739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aYNafgGLMp2zV21P8+oK10uFDyPLpaq2eVinuia9OY=;
        b=Jh0er5wwhJL/pKVAcpK1uWupzzRQ2RDC90e8moJNo83h1Xz178MPxpDSqcQsF8a+mU
         gyyQ0xDlURQxc0OFyAaIjS/PLzFHOhY6lS+EmldFIkDq5TWdkEYRP0BKcz9T8SyhwbCl
         bTp2bV6HpM2tyCbYTlRHU4b+gcwkIvoPzztTlSqnrw2lxz+vAJLlU/7JsHNe4SOikiel
         10NtkNdZDas7SNFF9KZXIWTSUiX1v6RoUWQFhZtbMfC8OJyYqyIPmM/QVr9053EMbHE8
         WIENQqx35QY/vV4s5PX3yT3zSO0+GxFm9aBUUOblV2qKcNXixJPNsAT9gLz+O4tlvvvz
         Ascg==
X-Forwarded-Encrypted: i=1; AJvYcCXhoI+mHtsDg0L7A25VoSlY5z3j0cYoe8YpSpnsUwypNXtPkqrsbJ3slbPB4o8MWy4mtLnp711asH3BNmib@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2lKOKPPV+/FyRcSYcnRA8qcd2hUavwKjogW2VoCWbM1I7C/c
	nBmS8MK0/b1FlgnlSl9ceCK7v++GsIfDP5jZbuCsWzk0qN62cWrtWGSRZfpLxtgTav8=
X-Gm-Gg: ATEYQzzHxN8rvAPM9ayfi5+3C9JvkMVr8hVcQiY0FQqdgXjQy9hgXJV/Et5Ht6xnfCF
	fVR4fUxGBbziVf/5wyFK2vStBDW/RsnYwpbrqw8lDUVzWyHsakf+xcbW3OheTVi2F6TbwDyXxkR
	C/WYzfUN2LqrbJ58ke3Bn31DlEgYkggdLoM9FzbBf6P+QPJ2/U8UyHnYrp1Fou72Bv4dx8ekGNs
	Nzr/7XVC+/+qdX3xh/29RSZIRHqPZfF9sOQp1Y+WqHbfzQZEgzmXzHh4otiFwuBtpvBnApHkNzd
	Xd3vqyCJ5/otE/THZKIo6Bbb9tCBfkYXGdeV5r0GA45rhDdwKt0OfJwayw9n7t8YkfBoqj73Evv
	s1xchznSbzhXMeQAMlOXjqB4iLrtjDfkGpO75Gro2yujUpnljDAOR6zxZAxj8Y0pfytKCiU+6yR
	NuGt94F8fdrIoWW8VhhvrJhhBN3L2WhzIDI1MzFcPWCFAu+lsPRcEk4vqF8Q==
X-Received: by 2002:a05:600c:1989:b0:46e:43f0:6181 with SMTP id 5b1f17b1804b1-483c9bfbdd5mr117360665e9.7.1772450939437;
        Mon, 02 Mar 2026 03:28:59 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb789efsm210891065e9.2.2026.03.02.03.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:28:59 -0800 (PST)
Message-ID: <5097ff66-b727-4eac-b845-3bd08d1a0ead@suse.com>
Date: Mon, 2 Mar 2026 12:28:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/6] KVM: guest_memfd: Directly allocate folios
 with filemap_alloc_folio()
Content-Language: en-US
To: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com,
 yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com,
 vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com,
 pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com,
 tabba@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
 <20260225-gmem-st-blocks-v2-2-87d7098119a9@google.com>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <20260225-gmem-st-blocks-v2-2-87d7098119a9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-78887-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8B2AB1D77E8
X-Rspamd-Action: no action

On 2/25/26 08:20, Ackerley Tng wrote:
> __filemap_get_folio_mpol() is parametrized by a bunch of GFP flags, which

                                                           FGP?

> adds complexity for the reader. Since guest_memfd doesn't meaningfully use
> any of the other FGP flags, undo that complexity by directly calling
> filemap_alloc_folio().
> 
> Directly calling filemap_alloc_folio() also allows the order of 0 to be
> explicitly specified, which is the only order guest_memfd supports. This is
> easier to understand, and removes the chance of anything else being able to
> unintentionally influence allocated folio size.

Isn't it determined by FGF_GET_ORDER() so when you pass FGP_LOCK | FGP_CREAT
and no order, it's straigtforward the order will be 0?

But if this helps with patch 4, ok.

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  virt/kvm/guest_memfd.c | 51 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2df27b6443115..2488d7b8f2b0d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -107,6 +107,39 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>  }
>  
> +static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
> +{
> +	/* TODO: Support huge pages. */
> +	struct mempolicy *policy;
> +	struct folio *folio;
> +	gfp_t gfp;
> +	int ret;
> +
> +	/*
> +	 * Fast-path: See if folio is already present in mapping to avoid
> +	 * policy_lookup.
> +	 */
> +	folio = filemap_lock_folio(inode->i_mapping, index);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	gfp = mapping_gfp_mask(inode->i_mapping);
> +
> +	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
> +	folio = filemap_alloc_folio(gfp, 0, policy);
> +	mpol_cond_put(policy);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = filemap_add_folio(inode->i_mapping, folio, index, gfp);
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return folio;
> +}
> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -118,23 +151,11 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   */
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
> -	/* TODO: Support huge pages. */
> -	struct mempolicy *policy;
>  	struct folio *folio;
>  
> -	/*
> -	 * Fast-path: See if folio is already present in mapping to avoid
> -	 * policy_lookup.
> -	 */
> -	folio = filemap_lock_folio(inode->i_mapping, index);
> -	if (!IS_ERR(folio))
> -		return folio;
> -
> -	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
> -	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> -					 FGP_LOCK | FGP_CREAT,
> -					 mapping_gfp_mask(inode->i_mapping), policy);
> -	mpol_cond_put(policy);
> +	do {
> +		folio = __kvm_gmem_get_folio(inode, index);
> +	} while (PTR_ERR(folio) == -EEXIST);
>  
>  	/*
>  	 * External interfaces like kvm_gmem_get_pfn() support dealing
> 


