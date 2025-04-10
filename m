Return-Path: <linux-fsdevel+bounces-46207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B874A8456E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA027A898C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522928C5AB;
	Thu, 10 Apr 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDd0cqKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F602857C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293199; cv=none; b=mJvw5P+gARdPDP8O4p1sD7lFnFtu6b5tOodN2IoJ36FzalqeeMrEITAs/RbBvcumkn16PASDkPFcAZvv8mAhbaTMT28hQy5f7TkQOadx1b7cP2gQlKgOXXMFJw0VhEqaehEBUCOrgUmZwTzkoW52SzlOze4/IkM3zpFRkJ2+Lio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293199; c=relaxed/simple;
	bh=6EzNCLAlf1iloxVtrXjGElQcW7269jazRrghVzl9gM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EsQEXUBhQR/AOFm9681j12kHWKAoV8y/2+FZqLb48PH6WcaBs0e15wayWRuR+5TmoT9EWTjEn0pT35+EOoQWjm2+R6hMKhACyH2zt7bpUuGQucaHkATGRidNF/rRUfJ+tb4jpsX33X85N0pP+txkWxLHTFcwYUvqb088VA7TtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDd0cqKH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso908962a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744293196; x=1744897996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4wxcHUnCCezh6nWr6RFH2iv1Y8IeCzojzwMbdNb4Do=;
        b=HDd0cqKHGtPrIPrD3zaBYMCfjaq0/jDRlkSiDB73JzjB0UBHODNk9a3ToIcIcWqe7W
         fv0+pYJUjE9TAiXXhDVSySGegZUoKXhfjljrlVuSruuOJc0pq6kffB7El9RfXwtMDP7J
         gf2MRN5X1xzPMUmrWBNH7tiTsdhbj7wIHRtFnLu9CInE5QZnyAh4z8INRoxpeG+tkMjV
         QsrMN45AKpwqQazIHPuCshcCx4XBDQ/mmxOdtRRas9iE38FKpeRMGEXel6aFCd/91cMh
         UU6Yz70trLPM9SMB/Tnr5+AyDoxot2o9cxPh9zdjUXBd5lyBi8XTScMlfCH24mC8ZLiu
         Kv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293196; x=1744897996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4wxcHUnCCezh6nWr6RFH2iv1Y8IeCzojzwMbdNb4Do=;
        b=lMSa+b0/+M/DLlhHHY4K7FLEuW6xjg51qrXg6mxd9nCpy7E6RWEts1S0WV2PbGXMem
         pQsZgFVdiSkItr/R/MTYzKPU/whGMPIQv475Mbov4Und78XmbOBBoMMLm1ZKqc+/2HcL
         fPgJtPuPCXSzVVvp2COEJexv7Q8mN5HzpySLgvdlRsMgrujzn3j770g4FXFpgsNxDg5L
         ZF/AS2iAZqXJ1yWyXfMXZ5Dx/cAQHzrEL7Ml2bYBo8z3DyZDxrFE3JE1PGp8KzELUEuT
         93ZtcvB3Y2ti1fUIEeMt1sJG/2I2liciNN7BzoZUF+0kLiRumYtY5llVDmZHK7Uc8O/g
         VplA==
X-Forwarded-Encrypted: i=1; AJvYcCVNkHDS6gkCM93gf/ZIwg8E4fGxZ6wNsP5MKVZkt4qj2yAHZ/jr843YBGCFBV9J3PehRZPr4a5Jwn4Gr4Hg@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFNhhrXREWGDw58PO/7q9nEXNnQRCrEu8YwE+wCwoO5SAljFu
	zKLa5tUd+9r+5OPvnPi7Mh5X1aEpJYO7ux8Imoe/ElfP4UWNK6CCXKXS1BkGS1By138/VQRKtQy
	EA8DKttg1PqVd5QF5AWuO+A==
X-Google-Smtp-Source: AGHT+IGEOFVmeMKiNYyGdVgVnjUwRuQMOBh3p67Kck++ZyIayxkYnmKh+TTYDv35m8GZuGIZaSBy6hjI9GDfCfcztg==
X-Received: from pjbtb11.prod.google.com ([2002:a17:90b:53cb:b0:301:1ea9:63b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d2ce:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-3072ba1f6e0mr4252531a91.31.1744293196650;
 Thu, 10 Apr 2025 06:53:16 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:53:15 -0700
In-Reply-To: <Z_eEfjrkspAt4ACP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408112402.181574-1-shivankg@amd.com> <20250408112402.181574-6-shivankg@amd.com>
 <Z_eEfjrkspAt4ACP@infradead.org>
Message-ID: <diqz4iyw5dis.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH RFC v7 5/8] KVM: guest_memfd: Make guest mem use guest mem
 inodes instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: Christoph Hellwig <hch@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Apr 08, 2025 at 11:23:59AM +0000, Shivank Garg wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>> 
>> Using guest mem inodes allows us to store metadata for the backing
>> memory on the inode. Metadata will be added in a later patch to support
>> HugeTLB pages.
>> 
>> Metadata about backing memory should not be stored on the file, since
>> the file represents a guest_memfd's binding with a struct kvm, and
>> metadata about backing memory is not unique to a specific binding and
>> struct kvm.
>> 
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  include/uapi/linux/magic.h |   1 +
>>  virt/kvm/guest_memfd.c     | 133 +++++++++++++++++++++++++++++++------
>>  2 files changed, 113 insertions(+), 21 deletions(-)
>> 
>> <snip>
>>  
>> +static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>> +						      loff_t size, u64 flags)
>> +{
>> +	const struct qstr qname = QSTR_INIT(name, strlen(name));
>> +	struct inode *inode;
>> +	int err;
>> +
>> +	inode = alloc_anon_inode(kvm_gmem_mnt->mnt_sb);
>> +	if (IS_ERR(inode))
>> +		return inode;
>> +
>> +	err = security_inode_init_security_anon(inode, &qname, NULL);
>> +	if (err) {
>> +		iput(inode);
>> +		return ERR_PTR(err);
>> +	}
>
> So why do other alloc_anon_inode callers not need
> security_inode_init_security_anon?

Thanks for this tip!

When I did this refactoring, I was just refactoring
anon_inode_create_getfile(), to set up the guest_memfd inode and file in
separate stages, and anon_inode_create_getfile() was already using
security_inode_init_security_anon().

In the next revision I can remove this call.

Is it too late to remove the call to security_inode_init_security_anon()
though? IIUC it is used by LSMs, which means security modules may
already be assuming this call?

