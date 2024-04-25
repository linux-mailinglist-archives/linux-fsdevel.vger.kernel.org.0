Return-Path: <linux-fsdevel+bounces-17792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECF8B23A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FF01F23B90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD214A09B;
	Thu, 25 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkxol9Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A62149E09
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054360; cv=none; b=JW38iqhu10xnq9nTukGuP2QU1Y+lLgdtw5jYodwfarLosbEqmdcBHsVcoIvO1sQCbaRCo+tEJ6CttwCs7xVKlKCil6nwy2lKbsSIzhymkW+lURzkt0h06U7bJJ/AZfvf5Ka3jEzl8EGvy1P8/+Y0o3ijitnhn6W4TaW9wqz0ETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054360; c=relaxed/simple;
	bh=OXlcNY8pu8S/MyjEy2GLENjCN5qdRSRqTym8qU2je0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqQ1y1DyT74UJmCkSMoZ7qzJLdoSnWVwF/AF9agjjvX+ksvAD8VPJ2MS6iRz/tDGg8gZV0iTYSEx1muWaCWIB7Bwaun1l+SJSPmtNc64dwVJ20JiVmk21HLNSXaDsclSVlStKyukwLRUef2WOMS6zJOoDe+1fR53uOkkLJfGm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qkxol9Yc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso15255911fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 07:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714054356; x=1714659156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgj3m/Cw0cxG7wHpYlRihQfjnwxhhxsXHcabhCA3Erw=;
        b=qkxol9YcHy4N7TFJyEYLH7LFZlNrVSlQMe/1FAbMvE53CxVwyFKPhnJgjgr4SSRS62
         ond/Iujmcy9zTgDJuDTZpPbK1wI6b0sTqyenMmvo+5VQ4nwOrLJUjv7myToPU52MULoN
         d+Z4X6AS/W0n9EgbNifYU/HmsVElp/3mEdUdwHw6Qg4db0dEkr20kwe6LcO2VmUNy0MD
         na+5YVJJChBvnTU7TQ7Hb0+aJtctizCnR0WoDgKG1cy7sG+Hu7u49n7rGCEhxtXqSZ8s
         /+67fViRi42PttiDXYYEjgHFJwu4hNeTEkjtw82VzqxD2Pp6ZjFE0A5cVeQ7+OsBKMZP
         xpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054356; x=1714659156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgj3m/Cw0cxG7wHpYlRihQfjnwxhhxsXHcabhCA3Erw=;
        b=rrLjBtrEUErpqtkX/OR+n8i68a63UwHgbjCSf6GYTrDWaZoDVGTgmBYtXAQ174sKSL
         EK+MF1OKbMGnAj8mUC+iarOgkxAIMOIBIg240JamKze4OPMfFCsyi6AM9yFwADnczYJ2
         +sq+toJMRC8otubCR3cG/N6gZzLC6vGMSL2/GQo2MljqRnzZ5qoI0OzhjVm0x2FOeN+f
         O2z1oZpSlH7dj6LaXTd1KxtN8Spy+lDDaIQuahXkKwGxWdgGKH8CyYYiOsBD+QBbVGln
         4eDcYrlnBA7gjcXpwXkh243DrWOpdxblgCatIUHdOZXMFDMJIX1Lpx4T1I/Pu9PqRGPo
         P+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOVQGSQ/Z6z7dhk8WCJpV1afnYLKMoZopTnJlVaVTy0aUh5NmpZQS47kp6cJJcSY78GjKQnfodlKVXtU3woy7e4Zjgv/89OSGWgnPe1Q==
X-Gm-Message-State: AOJu0YyYGkOVJUUutH1Rnq32AWQoMIu3rnKeqJJGkLwdjpD8+BG7kXYl
	lZKXHBwOl9T3X442zujyepuILkU/YiCePXg3NCBNFeZa2r6k06uT1+xvvwFc4ak=
X-Google-Smtp-Source: AGHT+IG4h73e/VD0OiMdGC2ljHdBFoL8+iSdydmC9vOMTBe1nYjTZzgcSwjFqh+dbSJpqsAZN+aRMQ==
X-Received: by 2002:a2e:818a:0:b0:2de:4b8d:ee31 with SMTP id e10-20020a2e818a000000b002de4b8dee31mr3860645ljg.37.1714054356205;
        Thu, 25 Apr 2024 07:12:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b0041aa8ad46d6sm10244618wmb.16.2024.04.25.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:12:35 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:12:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Benjamin Copeland <ben.copeland@linaro.org>
Subject: Re: [PATCH v13 25/35] KVM: selftests: Convert lib's mem regions to
 KVM_SET_USER_MEMORY_REGION2
Message-ID: <69ae0694-8ca3-402c-b864-99b500b24f5d@moroto.mountain>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-26-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-26-seanjc@google.com>

On Fri, Oct 27, 2023 at 11:22:07AM -0700, Sean Christopherson wrote:
> Use KVM_SET_USER_MEMORY_REGION2 throughout KVM's selftests library so that
> support for guest private memory can be added without needing an entirely
> separate set of helpers.
> 
> Note, this obviously makes selftests backwards-incompatible with older KVM
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> versions from this point forward.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is there a way we could disable the tests on older kernels instead of
making them fail?  Check uname or something?  There is probably a
standard way to do this...  It's these tests which fail.

 kvm_aarch32_id_regs
 kvm_access_tracking_perf_test
 kvm_arch_timer
 kvm_debug-exceptions
 kvm_demand_paging_test
 kvm_dirty_log_perf_test
 kvm_dirty_log_test
 kvm_guest_print_test
 kvm_hypercalls
 kvm_kvm_page_table_test
 kvm_memslot_modification_stress_test
 kvm_memslot_perf_test
 kvm_page_fault_test
 kvm_psci_test
 kvm_rseq_test
 kvm_smccc_filter
 kvm_steal_time
 kvm_vgic_init
 kvm_vgic_irq
 kvm_vpmu_counter_access

regards,
dan carpenter


