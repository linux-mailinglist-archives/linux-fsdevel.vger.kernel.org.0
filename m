Return-Path: <linux-fsdevel+bounces-25748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3F94FB9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C491F228CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D31BC40;
	Tue, 13 Aug 2024 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wntuwfQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62451B27D;
	Tue, 13 Aug 2024 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514818; cv=none; b=Jdo73GzOrte/xkK8pi7DJjiPC1BEm9VmajPKkemDkCAIPAujWrlz2ca+UHWC748jm8PK8haPaePx4UMsIIY1SRbQkggihTbvrpNT17RT7jO7zVjBTokqwcpf4DJH15ZHY68rg2Jvnm8VIis8PpUlFFMD59bABiiiRVfJWAWVwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514818; c=relaxed/simple;
	bh=corVORvV5k/DGCqcVkY6rnEC5BkIcEdPfj2clKEZgII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQmIG0HX8ye8DdnAabRDYWhNrEo61Q3kgqkUpAD9EHkof4ADCBGpfsWXS1Ex5Phyl48L/nFeL670lZqTXc41XeFkjvOw+vWM/264el27ynKbqyqsTlBinAs3hd5PIJl60oHhymswuPJX5dZigcxNbdJFfJnYB1I14Aysk/LRjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wntuwfQe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=txsNHBxQvWtLf0VpxS59PXDVocFGq080wGelPeQfVz0=; b=wntuwfQeuuOoqMv0Qf7ZjfFRmV
	4Tv3wJQChMzeZxtJ71bIS3Arst0jMGCeUUtlXzMyGENsDQcDPugimaIxQnJ63v/xMX9Bx2SKl6kPt
	pR+0jg4lKgPTJHwnny3VqQO3xgJnaRtJA9s5OsFEpQIPh4hPAmgkizyWkXpQmWJNxIyWCJNJu1mhU
	B+7salhZ2nOxTpcj6TCO/ulx2mPxb4Kcui5i4gO+YM+v9TjErXQXp5cs2C285mjS+kLIf9i1JbTgO
	iR6s+EXWk7M5/jbqJA/absXhsT6/zNhIMf52lNYceshXf7ls5qlLbFZ+UYvqUG/Iliq1CMudxdYWh
	iJ7vlvSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdgvz-00000001GNS-3BM1;
	Tue, 13 Aug 2024 02:06:51 +0000
Date: Tue, 13 Aug 2024 03:06:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>, viro@kernel.org,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	kvm@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
Message-ID: <20240813020651.GJ13701@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org>
 <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner>
 <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
 <20240810032952.GB13701@ZenIV>
 <CAEf4Bzb=yJKSByBktNXQDd8rqWPNCU9EWziqQhFBnCVuTGKCdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb=yJKSByBktNXQDd8rqWPNCU9EWziqQhFBnCVuTGKCdg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 12, 2024 at 01:05:19PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 9, 2024 at 8:29???PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Aug 08, 2024 at 09:51:34AM -0700, Alexei Starovoitov wrote:
> >
> > > The bpf changes look ok and Andrii's approach is easier to grasp.
> > > It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> > > so it goes through bpf CI and our other testing.
> > >
> > > bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> > > and fderr, so pretty much independent from other patches.
> >
> > Representation change and switch to accessors do matter, though.
> > OTOH, I can put just those into never-rebased branch (basically,
> > "introduce fd_file(), convert all accessors to it" +
> > "struct fd representation change" + possibly "add struct fd constructors,
> > get rid of __to_fd()", for completeness sake), so you could pull it.
> > Otherwise you'll get textual conflicts on all those f.file vs. fd_file(f)...
> 
> Yep, makes sense. Let's do that, we can merge that branch into
> bpf-next/master and I will follow up with my changes on top of that.
> 
> Let's just drop the do_one_ldimm64() extraction, and keep fdput(f)
> logic, plus add fd_file() accessor changes. I'll then add a switch to
> CLASS(fd) after a bit more BPF-specific clean ups. This code is pretty
> sensitive, so I'd rather have all the non-trivial refactoring done
> separately. Thanks!

Done (#stable-struct_fd); BTW, which tree do you want "convert __bpf_prog_get()
to CLASS(fd)" to go through?

