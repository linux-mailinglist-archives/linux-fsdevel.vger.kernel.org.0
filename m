Return-Path: <linux-fsdevel+bounces-52332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9BAE1E07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EB51892F03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19F2A1CA;
	Fri, 20 Jun 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWiujn47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F898F5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431742; cv=none; b=logVQqI0EsKcypWW3ILBTFIh38dD5lv67ZjSh2fe4ieMbFcdK7MB2FG0hKSDb66Qh3lpApqaZxF/MxseOLCD/0+ZpzUYTgo4ODHM0RBeBGba17jvQzkBzXh33sR4/UqE3fK05p+qWAbWB1OSPUkqjDlpa9FGjCxJjwlii02syyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431742; c=relaxed/simple;
	bh=jiojWTp4M2OPLQVLNZwWBCCmtwoAS7sY+ZSYOOvqLoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cI57fcrl5mnmb1Vaw2oEHusWZlFW/oTz9WRJ/Gs2nDzwbZYN17sxz/N8/YvF/SctUmTOZNIVb8drPKX7FlM583sSLHucf2jV3SoxwmUn1UskAsTxcb/r1m8eK2ZHDa8mJILY0rE/2Q8OBk03WUlSwI6ofoaS5eSRjbVeALfgHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWiujn47; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so1847366a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750431740; x=1751036540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIvatz/B0KFp5dEup/nosXT8XyxE4hqnW2qwmbJi7ww=;
        b=gWiujn47JyNXuMGWOAe47RY+MmzvbiGhIo03uHzYO8y/J5LJuXxa75sDADf7XdG5jl
         eP8KVp9VSYu9HylWgHRUpcCYhACu2xmgb2KsgEJR+7zxpmsw+XZxWMGYaWnTc2xEeD02
         bpNo+qLeByUPcX0e4qUV8T8JO58GCbimlhdigfamcdJMrdau0RIjGlrM5p1zRCVf0+HW
         54r9zbaXkqUV4vDWrB7wRcGIBXQYGhmEpvZS9XCPmWPW+EjhfT0lnjgXMDuPeDbcI7MI
         nOQzI/mNrafA15fxbgPCPLRSQ5pwuDyLulca5c6PdX2qkHNcUP7l14796TnrSEcBiOpG
         5P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750431740; x=1751036540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIvatz/B0KFp5dEup/nosXT8XyxE4hqnW2qwmbJi7ww=;
        b=Pd38bUX8bM5ztfl4jqReDVZnrd8Twt8qXJyHWWazeD0Etx8WsBIniEx65dJXbWlNlr
         ciqiAto44XQnNlvxdhjrkY1ZvkBm/O807XZzZweghk3jEkdUxvQcMZwijIX4eKv5iYpY
         nxoc/3ug18002WyP+OPCXjgbhwi9sQMK/pwmDd/jm0seg1bDKHwulisDfAGmW8/3n0NH
         4BZYaN7rNWbkg///uX24uEWFlbH7a33Ve84610YzgpltzCbktP5AgxuToj2tUNJPGqJR
         ZAXibCLJq9Jq0FdE+3neXTpIAaDzQ8s1zqdrB61pced4dbWQqGbah03OSUcUy2YaunKA
         X3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCULsyOdSuU29TRM+rULtm1aj4TcYzoP2V7zn7ugg5Q6S7weVkqkDFi5dWkVvvAfnyWnV8W0e1Zt6HKhDNXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAZZq6GsclEik2j+eSmq9M1dDZxddQ96az/50Q61X/sw8jSF4
	PavWCXHiE2nu3acwqFwl+htJNQQmO4NOdEbHgnf5/JsKNSZv8Ul0YVypiitS1pcgUaNygnv5AZ9
	XCMZA6Q==
X-Google-Smtp-Source: AGHT+IExJJEDLfHbw/cDZIvMSnQtiL3FA6aoOj5uTpsDJb4W7kOrg449hrd2zU8N5OQvcBYHhv4AeU4UpNo=
X-Received: from pjbta6.prod.google.com ([2002:a17:90b:4ec6:b0:312:e5dd:9248])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c09:b0:311:e8cc:4256
 with SMTP id 98e67ed59e1d1-3159d8cf694mr4153837a91.22.1750431739886; Fri, 20
 Jun 2025 08:02:19 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:02:18 -0700
In-Reply-To: <aFQATWEX2h4LaQZb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619073136.506022-2-shivankg@amd.com> <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner> <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner> <aFQATWEX2h4LaQZb@kernel.org>
Message-ID: <aFV3-sYCxyVIkdy6@google.com>
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
From: Sean Christopherson <seanjc@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Shivank Garg <shivankg@amd.com>, 
	david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com, 
	tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 19, 2025, Mike Rapoport wrote:
> On Thu, Jun 19, 2025 at 02:06:17PM +0200, Christian Brauner wrote:
> > On Thu, Jun 19, 2025 at 02:01:22PM +0300, Mike Rapoport wrote:
> > > On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
> > > > On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> > > > > On 6/19/25 09:31, Shivank Garg wrote:
> > > > > > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > > > > > anonymous inodes with proper security context. This replaces the current
> > > > > > pattern of calling alloc_anon_inode() followed by
> > > > > > inode_init_security_anon() for creating security context manually.
> > > > > > 
> > > > > > This change also fixes a security regression in secretmem where the
> > > > > > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > > > > > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > > > > > 
> > > > > > As guest_memfd currently resides in the KVM module, we need to export this
> > > > > 
> > > > > Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> > > > > explicit for KVM?
> > > > 
> > > > Oh? Enlighten me about that, if you have a second, please. 
> > > 
> > > From Documentation/core-api/symbol-namespaces.rst:
> > > 
> > > The macro takes a comma separated list of module names, allowing only those
> > > modules to access this symbol. Simple tail-globs are supported.
> > > 
> > > For example::
> > > 
> > >   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
> > > 
> > > will limit usage of this symbol to modules whoes name matches the given
> > > patterns.
> > 
> > Is that still mostly advisory and can still be easily circumenvented?

Yes and no.  For out-of-tree modules, it's mostly advisory.  Though I can imagine
if someone tries to report a bug because their module is masquerading as e.g. kvm,
then they will be told to go away (in far less polite words :-D).

For in-tree modules, the restriction is much more enforceable.  Renaming a module
to circumvent a restricted export will raise major red flags, and getting "proper"
access to a symbol would require an ack from the relevant maintainers.  E.g. for
many KVM-induced exports, it's not that other module writers are trying to misbehave,
there simply aren't any guardrails to deter them from using a "dangerous" export.
 
The other big benefit I see is documentation, e.g. both for readers/developers to
understand the intent, and for auditing purposes (I would be shocked if there
aren't exports that were KVM-induced, but that are no longer necessary).

And we can utilize the framework to do additional hardening.  E.g. for exports
that exist solely for KVM, I plan on adding wrappers so that the symbols are
exproted if and only if KVM is enabled in the kernel .config[*].  Again, that's
far from perfect, e.g. AFAIK every distro enables KVM, but it should help keep
everyone honest.

[*] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com 

> The commit message says
> 
>    will limit the use of said function to kvm.ko, any other module trying
>    to use this symbol will refure to load (and get modpost build
>    failures).

To Christian's point, the restrictions are trivial to circumvent by out-of-tree
modules.  E.g. to get access to the above, simply name your module kvm-lol.ko or
whatever.

