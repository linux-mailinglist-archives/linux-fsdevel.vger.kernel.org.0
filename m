Return-Path: <linux-fsdevel+bounces-25023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9F947CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105E31F23726
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807813BAE4;
	Mon,  5 Aug 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDmbCmd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D10537FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868901; cv=none; b=guBrRvBN/W6TNSFYY6qa5RaJ9KJ6bSYBv1G8K/QdCGPMPmUHpSlCfYwKKFJpc+Qx0vC0ge1FPobvO1VoUr4Bo12dDh/kqRta+XJ/X0xGdnaNP3F9R4yJhbYxdFJBemokr8PdD3vcItVOAR627vhvaQ3AIDYmr10RiXMuN9HVtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868901; c=relaxed/simple;
	bh=ecjp0Hf0iQhOloLg+5THly2RViSs1xyysVIbS5xlfqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHi7ydkfb0I5gb2i/vfsawVaEmdqukEI7VSXCVo3FlPiCDqVB1U6oSX+T0DzRjwyecpjggnA04XMILHn22l8iiOYc2VooGECFYdLy5CrFYNowuzRbXkxNFcm/ZaftfcReTBuYZoT6znXHA/FcA96xtnf/5mmNh+DzmT/bcagM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDmbCmd9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722868899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=is1WM++VT4Ceny6+rACPKsaEum5ihnLIwJEdmx2bnoE=;
	b=SDmbCmd9R1UyCm/Qs91hs4DV/jBMC7231b5IBYF0xuOODnEX8m0Km4bzXXC7NM6Yw99qoY
	VAWr9q20BNWGxdk9NoH3s0/VUII98sw9t+tRQzBHwdErSsRpw7A2gJx4D9ZT7xFBMIt8Sh
	8HwKYBbwKnHbkUIA3dTI0+oW1Zt5vfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-X2rFjSkxPTKj5DMHy6S9zQ-1; Mon, 05 Aug 2024 10:41:38 -0400
X-MC-Unique: X2rFjSkxPTKj5DMHy6S9zQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36871eb0a8eso5508549f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 07:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868897; x=1723473697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is1WM++VT4Ceny6+rACPKsaEum5ihnLIwJEdmx2bnoE=;
        b=WJkrlMkMjkc+ZWmuQpxGxuWgDSX2uMskLiSaPjcStfZcjRZ01IiczfNcjcMBF/yFM7
         zetctpJxT8Yper8ZCY6UNw+w+HVC+kxl4l/l1OgpkKnF59v4y/9a7iluBkno+x3lFCaK
         DywGf90yXTD4px/wx8i21CInyraIhULtAi6RsjI9frRCdeI1eltw+GeZTo4KGlSdtUUJ
         ClkMzlSoeEPjW8peSizclGB3ItKMVhe7fp2q/YdVN+/Lkevk9anEJoOKPBx+AqLcNdbn
         OTRyP8YXl5dCj5VIfGlRzPgx8KeQn1h8XPs3rtDnh6WsxHpny4JgXQSPdPJ7otIq5xbc
         HMHA==
X-Forwarded-Encrypted: i=1; AJvYcCWt6PgSm7c3t/N6cCvHoRh27bK5TCerCDmqDZy9TKoeRuVQSEObc81Degd7hH3kU0EPQzW0zVtrvB/v1cGnHsDw70O9meeguEB5e7bEgg==
X-Gm-Message-State: AOJu0Yxz588G938yEb+JLTzskY0DqqDaA9TZKnWWnzI/BLJoyZwttKLL
	QuhiGyGj63NDulJ6MFLFK3AM5cSN2mwaS1vnfXSimi93o/ArBsThjf5nkZvXrqyC0jOnrzYlN7I
	qwRmBbnn+sPxsOfw0Eg+PXfs2jHdgD/U4MG8Zwumt4bJs3O6kjcwiGGb3GY3RCd9BcjXclKxXuV
	xEPXOe+V8jrJSmUZPes9THt8l8gSVDCvl1ZwhN+A==
X-Received: by 2002:a05:6000:dd0:b0:368:3079:427f with SMTP id ffacd0b85a97d-36bbc12c503mr6358685f8f.30.1722868896958;
        Mon, 05 Aug 2024 07:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGORe404OR8+lZHyt0xrqRf0852CVHZ5agUPquA97aY6bZLBMVWP/j7MHMW1GPe6Vlxbu6hfVrrT5hYjROrP3g=
X-Received: by 2002:a05:6000:dd0:b0:368:3079:427f with SMTP id
 ffacd0b85a97d-36bbc12c503mr6358656f8f.30.1722868896526; Mon, 05 Aug 2024
 07:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805093245.889357-1-jgowans@amazon.com> <20240805143223.GA1110778@mit.edu>
In-Reply-To: <20240805143223.GA1110778@mit.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 Aug 2024 16:41:25 +0200
Message-ID: <CABgObfYhg6uoR7cQN4wf3bNLZbHfXv6fr35aKsKbqMvuv20Xrg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Gowans <jgowans@amazon.com>, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Steve Sistare <steven.sistare@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org, 
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:35=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Aug 05, 2024 at 11:32:35AM +0200, James Gowans wrote:
> > Guestmemfs implements preservation acrosss kexec by carving out a
> > large contiguous block of host system RAM early in boot which is
> > then used as the data for the guestmemfs files.
>
> Also, the VMM update process is not a common case thing, so we don't
> need to optimize for performance.  If we need to temporarily use
> swap/zswap to allocate memory at VMM update time, and if the pages
> aren't contiguous when they are copied out before doing the VMM
> update

I'm not sure I understand, where would this temporary allocation happen?

> that might be very well worth the vast of of memory needed to
> pay for reserving memory on the host for the VMM update that only
> might happen once every few days/weeks/months (depending on whether
> you are doing update just for high severity security fixes, or for
> random VMM updates).
>
> Even if you are updating the VMM every few days, it still doesn't seem
> that permanently reserving contiguous memory on the host can be
> justified from a TCO perspective.

As far as I understand, this is intended for use in systems that do
not do anything except hosting VMs, where anyway you'd devote 90%+ of
host memory to hugetlbfs gigapages.

Paolo


