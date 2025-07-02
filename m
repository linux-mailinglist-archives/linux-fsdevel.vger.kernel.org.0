Return-Path: <linux-fsdevel+bounces-53735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B4AF641B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AF91C459D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161D23B628;
	Wed,  2 Jul 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkVTD0eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659F2BE630;
	Wed,  2 Jul 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492210; cv=none; b=KH5ZVWHAS6zGERHgFXDu5CE5664Cj/kzMv/PCtL6CpRJ+s88B4n2mx/7amA/WsoHvvqGi+rylQsOGw+4Uy7m/gc+FkNndCl9hAfubg4diEkONrbrLUfEPk8QKUNJmsAQ6fpuT6PMCWABWli0ioshghNDHfWIE+CHfmcsRdo6e1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492210; c=relaxed/simple;
	bh=E4uzS6CMms6elvBobIW++yNP0Xp03xJB9bt4GThSsFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAHCa8aak61oH3rcDncIieTgsu10HQ4pOnfPH6RMZaS/lX2qfkL5veR3wGJEg0/yA2ihodzx7N+4MPZGBcJaA8V3hCpQRRnLM3wagc+niNlp7xC7+QRrrWTtb5LZYpsvCM26GEUD3s5HrB/aGcSLpXxC0quQMWZ66uxLmTtufcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkVTD0eZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5903bceffso101385371cf.3;
        Wed, 02 Jul 2025 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751492208; x=1752097008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plb9BF29bvzrheIEVugeqNq8ipYFwItYmCmavrVWnAg=;
        b=IkVTD0eZuZcDiQsVmHmSG4n7pmmRI2ti3LFCERnOaQC91akmdMGytwRHplpoAi9p7y
         d5zdTbh3cxUgzB620fCVV9NUV9jT9+05GZv5FfPxfC0wACOJetLQe7KYsP2rW46OiDh3
         +9M7pNvqji+77ZX9z1iOBKYrpvkAUiEqmAjvLn/ILAL9+R8fjPAzq3PU9JRtU+AZKg3V
         Rb6Njw38eTkzAlU6abLcXX7Y2la6WZEFdK0cz02hjtUsNqZTkmINqcBmu8Xt4GVMX5HP
         o56JTcUAaupjUrDui3Wo8YbM0K3X6piHbx4On62QUnY6Uy3Njone7t0q3DgKMSKccFCm
         IKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751492208; x=1752097008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Plb9BF29bvzrheIEVugeqNq8ipYFwItYmCmavrVWnAg=;
        b=UnZ1PFwijjZnvkBURqURD10zl9yogYTa9aaqvqNpKNBoeKXU7inkORYHGB7p8TxTRW
         UpCa3A3EMbK40v7bLnj1Jhgav9VWYkRw/WuUdC5NrnA/sMAPssKzzywJUNFSEevrWWta
         9czVzc5wHBUDETjj7wY6NAwCLcIgeO4Hexd8pDYVCFU2CrCNWFAdmdIMYBtZsRX3LaLJ
         W0MjgkL7xJk+Ns0X2iRhKXMS1Mut7DNLj7uJztreQyWwlFcn24z45UuG/bPMyo9emnjz
         xvUHQvrtW+X4UgY5uno5Mj7hKiWEnqMD2hsHg61xhfONrYKZ0EAIeng5dMWqUuai9TgH
         mX0g==
X-Forwarded-Encrypted: i=1; AJvYcCU5TlEv6dwxEBOzqHEHEAH99D0ggK0GB8sljrAyrSRyQhLRs8VfG+zwZN7mj0ls1R2QcUIVjdLX8F0nFv79DA==@vger.kernel.org, AJvYcCV9tjw/tAbLCjbXXxeLCxCx1Uzn0Z9Dtw/g7pgPkMKvR9htWxOnWO9E53YQdpjEmDFR0gDAdRBhkzQvGg==@vger.kernel.org, AJvYcCWrVehvHI2IyTGKON3ih2AB2YOh5GK2sngjcj69Rmd/oKY9mEOHpcW5T9rAlV/iFNsO0B6NUPQ8RSYl@vger.kernel.org, AJvYcCX3VOD3aSnf39+witNdj5R50pUtmkwL+iaXuWG0HMCS8Hpvgk0jt7pZpG+VY8WKdAqFhIDmu1Bf9Zuy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53Kks8iKz7KLvsxApHjffCVr6rtQ+bmWkjPMkZ+WvF1sdXDHn
	2/t58OY4StQJFjHyR9Lba7lGqduvRH7pE/MbsZAA/ShScXSwp2J9A740tP//ENN9Nj0IQLXAVQL
	b4JHfoPMptp0djpvTuI/VkzLCEL0hLAy4+FWG
X-Gm-Gg: ASbGncuTyvjHpIR8zztsg7m0G8cbW/1M+814vLvr00U4DYHjIxdwI/QRqDuetw1xG9X
	P1CWpsJhs4ol1vOgfi9/2Cpps6tLWFYkMQcYlooiiVv+G2k7YDA+1Qhgna747iagcI+4hWadYAr
	n3dLwaSDuTXcxOCaomfQOV/CS+1+ql5XrFvLk7Ak7HbGWiM+qBXuK0YKgYYFz3hDAd/zo9wQ==
X-Google-Smtp-Source: AGHT+IGoQva0z93Hsr6cBS/xQ/Id5Yqj3FdAJiwkeHWw3E4i6JnSDSeEzC3aoZIo+aKKEQD7P9uX+qd4H+iuIJAjkfw=
X-Received: by 2002:ac8:5794:0:b0:4a6:b603:c37e with SMTP id
 d75a77b69052e-4a987bd7e34mr16338791cf.2.1751492207835; Wed, 02 Jul 2025
 14:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org> <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org> <aEkHarE9_LlxFTAi@casper.infradead.org>
 <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org> <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
 <aFuWhnjsKqo6ftit@infradead.org> <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
 <20250701054101.GE10035@frogsfrogsfrogs>
In-Reply-To: <20250701054101.GE10035@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 14:36:37 -0700
X-Gm-Features: Ac12FXzkj0LAvJbdt1VVEKID79S4TlNmpTpl9CLd_GKa4oYm2ZgQZsYKKutZU60
Message-ID: <CAJnrk1bRL47BawgTCjLdrsuK=hpd+zkRwA+ZgLDUN7GzzJzNxw@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Jun 25, 2025 at 09:44:31AM -0700, Joanne Koong wrote:
> > On Tue, Jun 24, 2025 at 11:26=E2=80=AFPM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 10:26:01PM -0700, Joanne Koong wrote:
> > > > > The question is whether this is acceptable for all the filesystem
> > > > > which implement ->launder_folio today.  Because we could just mov=
e the
> > > > > folio_test_dirty() to after the folio_lock() and remove all the t=
esting
> > > > > of folio dirtiness from individual filesystems.
> > > >
> > > > Or could the filesystems that implement ->launder_folio (from what =
I
> > > > see, there's only 4: fuse, nfs, btrfs, and orangefs) just move that
> > > > logic into their .release_folio implementation? I don't see why not=
.
> > > > In folio_unmap_invalidate(), we call:
> > >
> > > Without even looking into the details from the iomap POV that basical=
ly
> > > doesn't matter.  You'd still need the write back a single locked foli=
o
> > > interface, which adds API surface, and because it only writes a singl=
e
> > > folio at a time is rather inefficient.  Not a deal breaker because
> > > the current version look ok, but it would still be preferable to not
> > > have an extra magic interface for it.
> > >
> >
> > Yes but as I understand it, the focus right now is on getting rid of
> > ->launder_folio as an API. The iomap pov imo is a separate issue with
> > determining whether fuse in particular needs to write back the dirty
> > page before releasing or should just fail.
>
> This might not help for Joanne's case, but so far the lack of a
> launder_folio in my fuse+iomap prototype hasn't hindered it at all.
> From what I can tell it's ok to bounce EBUSY back to dio callers...
>
> > btrfs uses ->launder_folio() to free some previously allocated
> > reservation (added in commit 872617a "btrfs: implement launder_folio
> > for clearing dirty page reserve") so at the very least, that logic
> > would need to be moved to .release_folio() (if that suffices? Adding
> > the btrfs group to cc). It's still vague to me whether
> > fuse/nfs/orangefs need to write back the dirty page, but it seems fine
>
> ...but only because a retry will initiate another writeback so
> eventually we can make some forward progress.  But it helps a lot that
> fuse+iomap is handing the entire IO stack over to iomap.
>
> > to me not to - as I understand it, the worst that can happen (and
> > please correct me if I'm wrong here, Matthew) from just failing it
> > with -EBUSY is that the folio lingers longer in the page cache until
> > it eventually gets written back and cleared out, and that only happens
> > if the file is mapped and written to in that window between
> > filemap_write_and_wait_range() and unmap_mapping_folio(). afaics, if
> > fuse/nfs/orangefs do need to write back the dirty folio instead of
> > failing w/ -EBUSY, they could just do that logic in .release_folio.
>
> What do you do in ->release_folio if writeback fails?  Redirty it and
> return false?

Yeah, I was thinking we just redirty it and return false. I don't
think that leads to any deviation from existing behavior (eg in
folio_unmap_invalidate(), a failed writeback will return -EBUSY
regardless of whether the writeback attempt happens from
->launder_folio() or ->release_folio()).
>
> --D

