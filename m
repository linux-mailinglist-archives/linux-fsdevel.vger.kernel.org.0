Return-Path: <linux-fsdevel+bounces-40535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1452A2497A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D4316641B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF11BD9C8;
	Sat,  1 Feb 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqAU7OYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C111E884
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738418362; cv=none; b=m9VDLvpHEpQeZ9d84T7pibp1rN7uRn+CnUnar8cfc3WcArlxU7tD+cuybn2wabqtACicDCSb7ESB0w63yWfNcyyg/Q4Lv63t/IZysPDRMFKSISPS9Ojz5kFr1c3PgWKnWUy8wRaNsRNK7XUk0ySBVh12wtMCH8XxgOPdyVPsg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738418362; c=relaxed/simple;
	bh=pR8WH26X/q6U0n9NkepNBT2vkGEmvYiSI+DcipTEhck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVMW0gL4lnwW9Dayt5Pcajub9esFi19Cg23QDt1qibXcNowf6XeTq6iv4FZFGVX8sgSU8uRXWzq6Shv/u83/LhpL4jRbKR9HEZgbLlQKnAsYbzm+S3yMJl3pvQadPPhMNataxSStJM6/ZBHnek+wbhD5RPo1beAbhg+gssYIUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqAU7OYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmAZARzJ9C1n/FGsYnWAiWXYV8MPOjHykZI8ROUvWqs=;
	b=PqAU7OYm5RIQngJ5Wcy6xLzM5+RH0V0+jdLBkmmXDfQXlu0SR9sqt3lULWaKnP1SmfyT5G
	hrs//0hRxshDuWdZDy69Hcw3KgrPrtt8sT1OHET4KRb/peA8eicEXPVPxHwwZNX7lIBFc6
	i+3smFOP6pVezDXWb+QlnFpGRTYQvIA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-q5qkpBJUOmKvEAxyqu4jZw-1; Sat, 01 Feb 2025 08:59:17 -0500
X-MC-Unique: q5qkpBJUOmKvEAxyqu4jZw-1
X-Mimecast-MFC-AGG-ID: q5qkpBJUOmKvEAxyqu4jZw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21650d4612eso140435ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2025 05:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738418356; x=1739023156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmAZARzJ9C1n/FGsYnWAiWXYV8MPOjHykZI8ROUvWqs=;
        b=ucU8BFnm4Yaj5HNFciOabpHqrLFtVbn3QTBHi1VPmbcoHvY8yN225shDhEDlXIZoyL
         C6DW2E16BHITvsiC6qtUpJ9lVoOYEAwaVt5em6ALvaoOoOjU/0AQkzNq+Obc6R4YQ1W/
         O58EOI2KiNYnMTPCkHd3nW1lp2Q61DVIap2Yu1OjFV+FK4AhgP/X/tFmdP9UUuUDp2rb
         ABq8qVAAHfkzxZ6M62aMKiTBwkibJNb9dUKm8rYSK03u0RP8TwvvbcizSEtP1BeAfmqm
         WAVzHiOzEApEZgO2bbl3QmuREtroQ42NU/J793XhOctk7O0fAoRFIPHSEMo4K/M75GW0
         uFJg==
X-Forwarded-Encrypted: i=1; AJvYcCXh7xo67FMybR11HzZHAxlN0TiENhC/elUxRgmK9EQ+NUC6RwZa9hiC9ny7mbE9051tjZaZE8cfXTfO0+cv@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvTikds3n0cYEiHgzm2bU8qnfpaiVQsD11djOnDpbHL9Cz9Gq
	0KRcyeuCiZEpCESOg2QOTJUswwDZNaLLQDky8f0eFu1Wj5i1WY/PrO1XCk3jgiMyoHxJtwDjjcv
	Lgs3H4Ile4twv0DCivVAVbUG7M/kXKt9MioOrzrCKyfrRS8VL5rTSjHslHCluEME=
X-Gm-Gg: ASbGncv6uRASWwbR6q+j6bPXDiDGA2yFKTP9s6lBIBtJU7xlGMXJDAtJ6NmsfX8HtvL
	WM9yzbNHvoCo1qvzLst35XiQzZqsA2Q0BUJzHMTbfWQ5HzHE1M8+dsb1uxXBHinZ1Q3ssoGaP8r
	+vTbz7UBcAww6GMO5dRcdyCxL1A3B5dCUBt78aQNTphvLd81AEWjWVTambAxqDMbtKODVrNcWEQ
	dEVFv2GmK55Ii0cxOW0N7NZpIBEsVcYoTmcqM9hAbNl4f17P5WxKDpBuE00zYPf/hxdoA9hkkcV
	tIMhZUDDXEYqP/pCes+esrQ8mdYJ9zLQPHgvclvRxQLPOw==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1ed7a5fafdemr26217615637.13.1738418356655;
        Sat, 01 Feb 2025 05:59:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa6kINL9tUbJBGdL5T5/HJd95XDU5gIp4rlzFG1OgLBs29JAPIoJiyApA80q1AgHnhAi66WA==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1ed7a5fafdemr26217568637.13.1738418356291;
        Sat, 01 Feb 2025 05:59:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba322sm5054412b3a.110.2025.02.01.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:59:15 -0800 (PST)
Date: Sat, 1 Feb 2025 21:59:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Day, Timothy" <timday@amazon.com>, Andreas Dilger <adilger@ddn.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>,
	"neilb@suse.de" <neilb@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
 <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
 <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com>
 <1A60CCB2-5412-4223-849C-F6824F82B1B2@amazon.com>
 <CAOQ4uxjR2fD1gUY6NnJa75+ACm_nANNPajmH5aaVSN7FoD8ukQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjR2fD1gUY6NnJa75+ACm_nANNPajmH5aaVSN7FoD8ukQ@mail.gmail.com>

On Sat, Feb 01, 2025 at 11:55:21AM +0100, Amir Goldstein wrote:
> On Sat, Feb 1, 2025 at 12:01 AM Day, Timothy <timday@amazon.com> wrote:
> >
> > On 1/31/25, 5:11 PM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73il@gmail.com>> wrote:
> > > On Fri, Jan 31, 2025 at 3:35 AM Andreas Dilger via Lsf-pc
> > > <lsf-pc@lists.linux-foundation.org <mailto:lsf-pc@lists.linux-foundation.org>> wrote:
> > > >
> > > >
> > > > As Tim mentioned, it is possible to mount a Lustre client (or two) plus one or
> > > > more MDT/OST on a single ~3GB VM with loopback files in /tmp and run testing.
> > > > There is a simple script we use to format and mount 4 MDTs and 4 OSTs on
> > > > temporary loop files and mount a client from the Lustre build tree.
> > > >
> > > > There haven't been any VFS patches needed for years for Lustre to be run,
> > > > though there are a number patches needed against a copied ext4 tree to
> > > > export some of the functions and add some filesystem features. Until the
> > > > ext4 patches are merged, it would also be possible to run light testing with
> > > > Tim's RAM-based OSD without any loopback devices at all (though with a
> > > > hard limitation on the size of the filesystem).
> > >
> > >
> > > Recommendation: if it is easy to setup loopback lustre server, then the best
> > > practice would be to add lustre fstests support, same as nfs/afs/cifs can be
> > > tested with fstests.
> > >
> > >
> > > Adding fstests support will not guarantee that vfs developers will run fstest
> > > with your filesystem, but if you make is super easy for vfs developers to
> > > test your filesystem with a the de-facto standard for fs testing, then at least
> > > they have an option to verify that their vfs changes are not breaking your
> > > filesystem, which is what upstreaming is supposed to provide.
> >
> > I was hoping to do exactly that. I've been able run to fstests on Lustre
> > (in an adhoc manner), but I wanted to put together a patch series to
> > add proper support. Would fstests accept Lustre support before Lustre
> > gets accepted upstream? Or should it be maintained as a separate
> > branch?
> >
> 
> Up to the maintainer (CC) but in any case, you will need to maintain
> a development branch until the fstests patches are reviewed, so I do
> not see much difference for the process.
> 
> My own vote would be to merge lustre support to fstest *before*
> merging lustre to linux-next tree (to fs-next branch), so that lustre
> could potentially be tested by 3rd party when it hits linux-next.
> 
> IMO, if lustre is on track for upstreaming with all the open questions
> addressed, I see no reason not to merge fstests support earlier.
> 
> I was going to recommend that you consider adding lustre support to
> one or more of the available "fstest runners" to provide a turnkey solution
> for the standalone test setup, but I see that you already contributed to ktest,
> So that's great! and one more reason to merge fstests support sooner.

Thanks Amir, I think fstests has nothing to lose to support one more testing :)

Let's see the patchset (to fstests@) at first. If it's simple enough, likes
4cbc0a0fa8b ("fstests: add GlusterFS support"), then it's easy to be merged.

If it needs to change many common things or generic cases, we'd better
to give it more reviewing and testing, and maybe merge it into a separated
branch at first. Anyway, let's check the patches at first :)

Meanwhile, I'd like to track the patches you send to linux VFS, to think
about when it's time to have the testing part at first, so feel free to CC.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 


