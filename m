Return-Path: <linux-fsdevel+bounces-64380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD320BE3F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA4535071B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970A341640;
	Thu, 16 Oct 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGINMgux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00F32D445
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625580; cv=none; b=rc9Cw4dksvwmOK/6CsTmrCZPZrwIiDH+hqYddZkCp0wQ9UiBVnRgOWulMkkFnCdlOyabjwydmoBfZz1gTSOl2tbahUha030Li+neU+C49OU51EVqaGO2eaPUEtAmrQB6Le2wITVCq54hYzTiOyrANWrDI7fA81ax9mHtwuvWE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625580; c=relaxed/simple;
	bh=oAFOf0C7FHbG2dP8F5Uk3uZewMXJkblvCyuuZPnvJXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/Ji5gCxMlhxMewWXUNL9hLy4HYdx392N2nZwaAyKismuxYveNPVgmg46doDgNTqLWFMCVYoFiLJS8FIRItKMmq8o8NetQKd7JEZVW4nMxF/IoJgS/AuDVsfvZy/uYFwWyMB31ZSTVhS+NuaAGZoPtPWq/4GodJ5SsWemxriOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGINMgux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760625577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtluYhVLkbO8u0oWJsyCOzeQxxX6dgreB/25XigeFbM=;
	b=UGINMguxRIiXGPQXJ8lpWBh5VJxqo3vGgf2wLUNq5YYRMEQ6nz+A/0iAPbTFWXZFgcW2Jn
	eJmC8jYbCVkGey8rbxLdxk2+cX6Ib0+BkJfm9P+QoAlIWYoQk3vnFETY6zU+TvXDNyq45P
	iEbHG15CO5nSfNALkn9jcpE9EFlXjlU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-9yqTBa1CMNqlrK7OTbKgWA-1; Thu, 16 Oct 2025 10:39:36 -0400
X-MC-Unique: 9yqTBa1CMNqlrK7OTbKgWA-1
X-Mimecast-MFC-AGG-ID: 9yqTBa1CMNqlrK7OTbKgWA_1760625575
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28c58e009d1so16367045ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 07:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625574; x=1761230374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtluYhVLkbO8u0oWJsyCOzeQxxX6dgreB/25XigeFbM=;
        b=HGprspp6RPCPuxJ2gzfdW6m/bMOf8bfZxHV93foo6/kQFrtTQ69xVDCVg/+E1iRMmw
         ZEllym7dCcyOEQVxqiHorYwaEq94OIX9+Cox+OMSc8ZfsSoqix12oYmRnDv8BW/9zQA9
         izkbuBkndqiSjtos/cgEXgaPRckOR5lJ2eiavSln4iF1RU6UQkvhZ8ZVkmrSB17Lzi6V
         Mzrtmy79xMWQJ+wlkBSiDzVr+tV86E4VmQz/SuKAWer1Ml/CsqrVfELd9V5D9U3K0dCR
         WAxgAq75pKGiczNQJxhEk8QANebT2LEC3Stmt0ReyM2D80x6BpxHGsO1dXndyINtxn3d
         L1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUzqm3c6K0TVwOrQ1JFJkExr5U44BTqVVfHOyME1kfn13LK6Cvvoa6QXn3z84/Tu4kcEGjOaH01xlli27Aq@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4A9H99mUf48uowMx3IhbgiTfnYs4CJz+4Au5JngvG4HZ4Agw
	S3GMw9F1Q32HdmpJEq+69NKP/HkXpp0sJJMml5Pd/l4Wm9YN5c1expV491NYvFyo06S10InzxjS
	TnNwSrVeaMFnlFdV8w7mX8lcp2Gl+TZsjQT6S43oHbwzf8mbep7drV8ykFeXcOJCQLXiQXh4Wdl
	GjZw==
X-Gm-Gg: ASbGncuHMH6QIpT3/hn5DE8Ak2gxqGdBXBj6XAuWbmCs0OEYK04q7wJdx4rDmewW4LA
	0JPBtEkPWcwfY2jHksIOIfRomrxfd4nYoy4JM5K3LPFV/dTopiiFMmVLk5DpUMnNX0AWxCLojjY
	Cvl+SmdfWmC/sMMK+30KpiFW9EFcl8GaOenKQYrV5fNvipb4f9ngP7n7cajrSdeyN6nDUoQrL4z
	qMEyFdcnSsED+7g53nUjeWvSLH1NtjgTg3ZLm6IzmFwbdmBMIvXmquubnhAqrijLI4UXuXc9xDT
	MB96DCxcaUAIQx9/7A8hyWNK+QGk+3eGhCjKaMqAjsC13LH+QI4fLf0/03fzdndfxmYONQ==
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr2113225ad.30.1760625574002;
        Thu, 16 Oct 2025 07:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoR3sOX166Tcf7MLH16gWKdUAYv0AI7cWSg6pn0j1tfmbyKX2QRAiCoA7ig0qK9oVKh4us1Q==
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr2112865ad.30.1760625573497;
        Thu, 16 Oct 2025 07:39:33 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7cec6sm32751745ad.55.2025.10.16.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:39:32 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:39:28 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <aPEDoAXCqGxwPM5D@zeus>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
 <2025101544-stopper-rifling-00e0@gregkh>
 <aPDGxz04OQgzRQqL@zeus>
 <2025101610-detention-dangle-cef6@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101610-detention-dangle-cef6@gregkh>

On Thu, Oct 16, 2025 at 01:24:12PM +0200, Greg KH wrote:
> On Thu, Oct 16, 2025 at 07:19:51PM +0900, Ryosuke Yasuoka wrote:
> > On Wed, Oct 15, 2025 at 07:40:12AM +0200, Greg KH wrote:
> > > On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> > > > Hi all,
> > > > 
> > > > This patch series add support for the llseek file operation to misc
> > > > devices written in Rust.
> > > 
> > > Cool, but what miscdevice driver needs llseek support?  Do you have a
> > > real user for this that we can see as well?
> > 
> > Currently no. Because lseek is one of fundamental functions for device
> > driver, I think it's valuable to add support. I believe we'll have real
> > users based on read, write, and this lseek support.
> 
> Char devices that use lseek are "odd", don't you agree?  There are no
> such current users under drivers/misc/ and only a rare few under
> drivers/char/ (the huge user of that is mem.c but we aren't going to be
> reimplementing that in rust any time soon...)
> 
> So without a real user of this api, I suggest we hold-off on adding it.
> Let's not add it until someone comes up with a very valid reason for it.

Thank you for your review and clear explanation.

I understand your point. It makes sense not to add this without real
user. I'll hold off on this and will revisit it if a concrete use case
emerges.

Best regards,
Ryosuke

> thanks,
> 
> greg k-h
> 


