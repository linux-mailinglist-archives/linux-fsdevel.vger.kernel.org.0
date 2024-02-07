Return-Path: <linux-fsdevel+bounces-10624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D5B84CE07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BC287ED3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8657FBD3;
	Wed,  7 Feb 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NU0KCFI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB637FBC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319739; cv=none; b=h797IQ8KWNSsqS2Am1AEvQgB3/0GGYKZoGcFPAvTCxg+JnkgxHAiF4VOfbRp0LNI1oX5sywEUmmFr1ps5apZPQ0SLVRekN8bd4YEbWYfIFpCPZvKF7iOFmmy0cLgKC4ifKPPnUv8hmheH/J/1XgncSMWHQ7zDTP5LS6zno9FxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319739; c=relaxed/simple;
	bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tsd2xGUZi9jfKw/sTtH9GTALlDA8GWPGE9Mkl86lc0j3kxUMHL6r1pYQPtH4dKb2ShOUCAEjsmieG4ONTcF+1ENuCexGin9VjOS894IwicBtKradBQaAJnezRhi2E6/U0e44I8jhlIJ6qlt7OIZcdE0Gplf78hJnIAZ5GYJRRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NU0KCFI2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-218f4589f0cso273390fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707319736; x=1707924536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=NU0KCFI2PcXIesrZqDGaMumM07ZvsINqITiEAwBMhskWR31PwJB4q9nWxtvDCTO8Rh
         IfbIpX2RViygtZEXSpGQCGsTpsDT++li9tKJl1fcXN9y0zRUAUS7k9Vj9IluITTrToXf
         xPIJsabXnGELRFFBalq7+OpPtmVwCRBvcBFnDUeNl1oL0ZgyAT+2IHM3qrrw8yQd1d29
         WoNgWFmGjcu4PtpA3hm6bd6GDiVniNDgAiSjev6BW9nIsWDZFtgeSvTTPfYIfoa4Sbxq
         0UlYxzNH7P8IyUa/gcZr3zalpmpaeVxPmxRrNG8d2DEjrIJKcndJUQSHxUSM1ckT3kjU
         0zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319736; x=1707924536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=dbrtQfL8ce+cSeKKwIgXzmAr58Xjo2GtEgpUSOY+CGXdxQFHYzwlzctXm7dzZRvWQb
         bH/O4plr7EpbUTyMV0/PpHxG4zELdeVgtVLRmhfyCjlXPxsCv4JDqVXylhrMQMnPDLNU
         Qjo+3GypOARwvRxirHSECuo4iY0JDAEOved4IFehc9PWvdOO9WS6+yFGKahtqB8Ya+pp
         N4EwzAS1JvmY2TUFASWkmtuC+CWG5sn3nEhBGVmsTAGgmjHMrVzgJAqLt5F9lVO5WInv
         DOnJ8Nt+HBNELj8ALl31VsjCp4i3bn750BTwB0DojTj4DbhDVvH/iZ04IQDocOgoIi5J
         HBIQ==
X-Gm-Message-State: AOJu0YyYiw+4UahAzrZqxplD/OPdlUFhk3ZGsHtDGHqKC68D9cxOchcL
	Rjo8MElZu25gC9oXDw7M9Ll5oQ1vkYCT/0Ry4sX3WHubIoAdewiYywsI8apxHkI=
X-Google-Smtp-Source: AGHT+IHEL7CFznI2Gw3SaxhMoycGQY1ZAMJ2M/MoHIzeasU/nr/2JepWSFEuheW8Ams28t9PtymRRw==
X-Received: by 2002:a05:6870:bac7:b0:219:83cc:287c with SMTP id js7-20020a056870bac700b0021983cc287cmr6065943oab.18.1707319736190;
        Wed, 07 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUY+po1giBXhl03Vf0urto5lU8KkUE0xa/D+uEwt3aAnuuk7whgR0HTCfY+MTVQpslUqqUs/wsMp+t3ROMVbRdiv139tCe2ZBXKAtq4ZceV9PQJGgSNRI8IXanfewIYC0pI3FzZsKmRPGCkekyIVSuYunEdq/NKi0/3z9aOOnSjGhG1HWtDCKx6tkf7sG69wd0voFNXVKcPnx/Nm+iJxlnF6OfGX8tZ9W5Ef2TdHxCT40iWFJmfW6S8uQKXx/coePehrn7fBGc1ApNtwTAo8s/s5HRc5UVF5kRUR22WO8nHBRkrzcJX/Ul/xP8hPJikjNY5otCJsvQrEVBk2ZaVzx3MkqaDTyR4Ul7c2lNd1sQoJE9R4hMA5FyNT4k6cGm9+PELO3Pd2X6HZW5Jm8qV/VAErzvt6LcaoXye2Wua/2AYMT/wp1V94k8M1zgi8oPWuI9edPTgsfIAIs+qSWZnIHymtDR0ZDoa4pbEKoLlGJm39ZpBPkOgypT7AHFEI8rU/GAr/BBLOvIN75lw9qDVd4OTS7E4DjE+P+TXjW/ejHtWFFjkRAxscCfnxXGlxTCjMW8flXh31SrWNWQb7kthgrk5FZ0nc1rQCTq6Q8fWQP0Awd0gAJf2PwiCs47eD05aetIREJ1Gf81uCiJ/HxdH+LBZUmXJT18VOvJdRMBqtyz
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d76c6000000b006e112c93b1esm228799otl.6.2024.02.07.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:28:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjr4-008ccK-Kk;
	Wed, 07 Feb 2024 11:28:54 -0400
Date: Wed, 7 Feb 2024 11:28:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240207152854.GL31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
 <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>

On Wed, Feb 07, 2024 at 02:56:33PM +0000, Gowans, James wrote:
> 2. Tell VFIO to avoid mapping the memory in again after live update
> because it already exists.
> https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d61683eaee02b0
> (the above flag should only be set *after* live update...).

Definately no to that entire idea. It completely breaks how the memory
lifetime model works in iommufd.

iommufd has to re-establish its pins, and has to rebuild all its
mapping data structures. Otherwise it won't work correctly at all.

This is what I was saying in the other thread, you can't just ignore
fully restoring the iommu environment.

The end goal must be to have fully reconstituted iommufd with all its
maps, ioas's, and memory pins back to fully normal operation.

IMHO you need to focus on atomic replace where you go from the frozen
pkernfs environment to a live operating enviornment by hitlessly
replacing the IO page table in the HW. Ie going from an
IOMMU_DOMAIN_PKERFS to an IOMMU_DOMAIN_PAGING owned by iommufd that
describes exactly the same translation.

"adopting" an entire io page table with unknown contents, and still
being able to correctly do map/unmap seems way too hard.

Jason

