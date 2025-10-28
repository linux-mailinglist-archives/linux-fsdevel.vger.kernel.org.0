Return-Path: <linux-fsdevel+bounces-65960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1FC17127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 22:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22AA4566C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 21:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE212E427F;
	Tue, 28 Oct 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r93s37by"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D022D876F
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687305; cv=none; b=Z0WxE7MU7dcswdnv8w8vzyvbXkVWqpaRQ5/KV9hTsAJ87QViqp3dbbreT58L9AzF3hkAOkNIzk6D4L2mdiy6ehJaLy/acug7WKTmnsGzQLUC4yovjBS1tPWsMoVvGeYhfrSK/cchFfXbFJ1xoucOfKR02nRpO7gciNuiozL4+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687305; c=relaxed/simple;
	bh=R2i31H9vGUKt8c9pEDO8kNOSs2JZfSsFlvxECOPAMbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sckM5ifqvx63i4SDkreATFspzsB/XPYi8BYHomVM3fF2YxmPh1qWuia2fRJmOD6VxzVUkhGhDqujtzwnfBzGEW5KziFCVMrM7rpwOVcUT3Yf4G70O6OrkJr3khXQMtVNHWWPGJk2Iug0v8BtaSBw+E/b4utwJdostnjELoJ/EDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r93s37by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA1C116D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687305;
	bh=R2i31H9vGUKt8c9pEDO8kNOSs2JZfSsFlvxECOPAMbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r93s37byBu5Kqu2QNWAApFRsKMEiKn+rnGBu28Yh213bmXlXtpGYHy6Md1GZVj5bM
	 s5vnSo0yrYRMDPmHpEUorqNbrzfUbLmxqipY4eXZSatd2x/wYVLZWkfxLbVUyrJnqB
	 qzzqP0cqOIMCM1+yieYa4Jpw8ExK8yVQ10CoTtDy/YpQpSoWeYoXUNtfhEmCx16Hlx
	 hAutjjpMeCNc9SkrGfI4cOnOn4oU/nFvmIHsnMpTitKiMXtsQmuipZbmLKSEJQNkuU
	 lggI9QCrsvI59YWcEgE4fHKT+JxK/C1s0+GH6Knmt4VFXcIEFUXIvCxgclL3uQke9v
	 P+fvzMKknG1XA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592ff1d80feso5238957e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 14:35:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR5kBNyMCNSiw9tLG5ReGKoAoL13lhQ2lA8LkQTKTpdeK2/z5RItAF5VIpl3FdNb2dM2gtxjDV5sFhT4Rz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Xx2F/LJw/EcaJe1Cfoc8iEQIyFp1zEa/aoBU0cnjsFMuLwZZ
	f+lHrUnQU5e9eRyxCHm4JOC5IbDahLmvRoKRUd+wFT6DBDNbUOaMxMc6nFIL2NBZzxmGnwyxmLg
	nlrszJrhg+hHvr2ZgOz6u5johLziMMOE=
X-Google-Smtp-Source: AGHT+IEUgTLUAIKN7pUG+BuUf5d2rQVkYmo1LrGvDv+SiZ+/7mc0PZPnIKuDcBIJFaSVmyoUk9OgmOBn+4n7FgjOtLw=
X-Received: by 2002:a05:6512:3b0c:b0:592:fce6:9054 with SMTP id
 2adb3069b0e04-594128c4f37mr242551e87.52.1761687303564; Tue, 28 Oct 2025
 14:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk> <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV> <20251028210805.GP2441659@ZenIV>
In-Reply-To: <20251028210805.GP2441659@ZenIV>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 28 Oct 2025 22:34:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
X-Gm-Features: AWmQ_bkR_zy3h447gWqfy_yWS54Z8UsgWDqAQbawTspKnXeI6tlX292HDo0fyss
Message-ID: <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
Subject: Re: [PATCH v2 22/50] convert efivarfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 22:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Oct 28, 2025 at 05:45:40PM +0000, Al Viro wrote:
>
> > FWIW, having a special path for "we are in foofs_fill_super(), fuck
> > the locking - nobody's going to access it anyway" is not a great
> > idea, simply because the helpers tend to get reused on codepaths
> > where we can't cut corners that way.
>
>         BTW, looking through efivarfs codebase now... *both* callers
> of efivarfs_create_dentry() end up doing dcache lookups, with variously
> convoluted call chains.  Look: efivarfs_check_missing() has an explicit
> try_lookup_noperm() before the call of efivarfs_create_dentry().
> efivarfs_callback() doesn't, but it's called via
>         efivar_init(efivarfs_callback, sb, true)
> and with the last argument being true efivar_init() will precede the call
> of the callback with efivarfs_variable_is_present().  Guess what does that
> thing (never used anywhere else) do?  Right, the call of try_lookup_noperm().
>
> Why do we bother with that?  What's wrong with having efivarfs_create_dentry()
> returning -EEXIST in case of dentry already being there and turning the
> chunk in efivar_init() into
>                         err = func(variable_name, vendor_guid,
>                                    variable_name_size, data);
>                         if (err == -EEXIST) {
>                                 if (duplicate_check)
>                                         dup_variable_bug(variable_name,
>                                                          &vendor_guid,
>                                                          variable_name_size);
>                                 else
>                                         err = 0;
>                         }
>                         if (err)
>                                 status = EFI_NOT_FOUND;
> Note that both possible callbacks become almost identical and I wouldn't
> be surprised if that "almost" is actually "completely"...  <checks> yep.
>

I'll let James respond to the specifics of your suggestion, but I'll
just note that this code has a rather convoluted history, as we used
to have two separate pseudo-filesystem drivers, up until a few years
ago: the sysfs based 'efivars' and this efivarfs driver. Given that
modifications in one needed to be visible in the other, they shared a
linked list that shadowed the state of the underlying variable store.
'efivars' was removed years ago, but it was only recently that James
replaced the linked list in this driver with the dentry cache as the
shadow mechanism.

Relying on the -EEXIST return value to detect duplicates, and
combining the two callbacks seem like neat optimizations to me, so

Acked-by: Ard Biesheuvel <ardb@kernel.org>

but I have to confess I am slightly out of my depth when it comes to VFS stuff.

