Return-Path: <linux-fsdevel+bounces-39572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5600A15B2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 04:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396867A42BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CD136352;
	Sat, 18 Jan 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hAWTnleM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPUAbDiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CD130A54;
	Sat, 18 Jan 2025 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737169674; cv=none; b=QcVcGGYXjOvbgNg/BaMKBXAaobFhW1fpdOEgo17GZe90twsvxlOxZwPPkLwg7YdYDqQut7bgfk9oDvPnPLYbLCYPp4rnXGPRB132Jq55+WgRU4U+ffhzhouHoNxG/WwuYIg/ytQeu/NTJoAsE8BjF0Y33dOq0igZUpy6E3CiLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737169674; c=relaxed/simple;
	bh=N2IN0osMYSuywd8aiZmnJW5TElQXfTyU1CcZJV9fR/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+RKDLOMXuIi/eZAilUQ/kY7Ir1UQCfOl/MM9rqfwn1lqvH8KWSTE9fGrV8ZlUcJwJDZYxfMQAkCk346Ilav54trCXsHqMgZHbRtXVlsgCSa9PWMmel++7SrHAos/t6SURVVoMsIdHgFdx3zfm26wfbeHzursR7IzyQZzQPY3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hAWTnleM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iPUAbDiz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B09E11402AA;
	Fri, 17 Jan 2025 22:07:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 22:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737169671; x=1737256071; bh=ZW5l5kQBlD
	INYguCg3RsWbk6hBJPemS+oyodVSSlN0Q=; b=hAWTnleMcjjKox/sYjF+mSsDpz
	xwhMNKmx30XzeUZt0OrVFl47GIX+5aEHdzh4jD8saeqcRdWW2ouCLwz2ucZk8yfd
	5yMZgOY55hoFzpplcmXB5mwPkssQ3pBXoroVbx9jE1lZgQyB9nXPF+fGXxszo2qd
	f52xsUS2Nr5ajOBJHWxbPTf+7Yxw97AjcFpHYCkhiAS1XV4AJHyvJiaQ3lMzBCtY
	PWPFnck8F6jpPcjEnxmsztMfLav+UaVcclWRJzgFH1MtrpaAdSp385diLXzTaruv
	/A1G/AhqXX6dluhvXJB2ypDtkGAdgVo1ZnH8jrSPMEfgyhC+ldqk7e+S46jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737169671; x=1737256071; bh=ZW5l5kQBlDINYguCg3RsWbk6hBJPemS+oyo
	dVSSlN0Q=; b=iPUAbDizpNvDXqoTqCDtwvIl9GNfPwVW0uyIB+GkeJi/sqmA/oj
	DGfdajyNag92WDLb2S/wYbiD8ZpJPw7qdj5lBzwfBe13eHrIhZa1kxd/k2t3W+va
	nz+TP5o/GkRF7XEPO+5X9H/IEXCbxyQ7XFSK44iR9UZGOs+CzLAvSPJ0+34PAqs5
	iSAP65ek8H9Ohyd34BgahqetMlpDIe1TwYtAvfSjv1lLgKZ1RxHEBcRW778xReoZ
	kAPwiPSmUwN9uRqPAJTFskmcSVOtrvUeIlREXVUTcZ9Upf+/dWaqeEVPfwvNX1ip
	tMlyH2kaVxr9wuiMERDOIdIxj4H7DvFLpmg==
X-ME-Sender: <xms:BhuLZytFyThH_F9yEp7Ci_wOd72DbeOi_EnRzrO0FRD9ibPiuToPSQ>
    <xme:BhuLZ3cxcVdMDVCbfaDrAcZQl9Z_oBbnW4k9QQGwU49Qmi5EVtNNTUnrWN86quK2M
    t2mx6fHdkr5x210Wg>
X-ME-Received: <xmr:BhuLZ9xRt7Catm2_P6KvJaLjvz8m1E630LdKw4gkadf3qxgZpWwuFZ8UB6FF17V0Y_CXVLsHzESwyZQ-2bQFf_t467Q71wdQxD8YvuEEkfzdGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epvdefkeetuddufeeigedtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopehthi
    htshhosehmihhtrdgvughupdhrtghpthhtoheplhhsfhdqphgtsehlihhsthhsrdhlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BhuLZ9PuTHXI0o2Io8PNqfnnzwLoAPjtt1KkYdxHpTkourIsUplq_A>
    <xmx:BhuLZy8GG3E4xFK65v_lOUFDnlwpyXmdmxU5uBE47rzjabwzVE3UDw>
    <xmx:BhuLZ1V4SmZzLj3DYc6uvpiQESNNN0eTA6rFUA139KHlBBZ8ef1d5w>
    <xmx:BhuLZ7cry4w7PN9ynlqRVtbOac6KNetHm4x9wMVpCSlkbHyKbUKcHA>
    <xmx:BxuLZ5mXhFVjrxTEiw_F7p7eUl-92sYQOQb5PnPEwyuXZBrAkYSBJj-a>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 22:07:50 -0500 (EST)
Date: Fri, 17 Jan 2025 20:07:48 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <oidb2ijfx64r4lgpf3ei7teexpa54ngnef3cmq5bsxsgxmtros@7pn2y34ud4l7>
References: <20250116124949.GA2446417@mit.edu>
 <Z4l3rb11fJqNravu@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4l3rb11fJqNravu@dread.disaster.area>

Hi Dave,

On Fri, Jan 17, 2025 at 08:18:37AM +1100, Dave Chinner wrote:
> On Thu, Jan 16, 2025 at 07:49:49AM -0500, Theodore Ts'o wrote:
> > Historically, we have avoided adding tracepoints to the VFS because of
> > concerns that tracepoints would be considered a userspace-level
> > interface, and would therefore potentially constrain our ability to
> > improve an interface which has been extremely performance critical.
> 
> Yes, the lack of tracepoints in the VFS is a fairly significant
> issue when it comes to runtime debugging of production systems...
> 
> > I'd like to discuss whether in 2025, it's time to reconsider our
> > reticence in adding tracepoints in the VFS layer.  First, while there
> > has been a single incident of a tracepoint being used by programs that
> > were distributed far and wide (powertop) such that we had to revert a
> > change to a tracepoint that broke it --- that was ***14** years ago,
> > in 2011.
> 
> Yes, that was a big mistake in multiple ways. Firstly, the app using
> a tracepoint in this way. The second mistake was the response that
> "tracepoints should be stable API" based on the abuse of a single
> tracepoint.
> 
> We had extensive tracepoint coverage in subsystems *before* this
> happened. In XFS, we had already converted hundreds of existing
> debug-build-only tracing calls to use tracepoints based on the
> understanding that tracepoints were *not* considered stable user
> interfaces.
> 
> The fact that existing subsystem tracepoints already exposed the
> internal implementation of objects like struct inode, struct file,
> superblocks, etc simply wasn't considered when tracepoints were
> declared "stable".
> 
> The fact is that it is simply not possible to maintain any sort of
> useful introspection with the tracepoint infrastructure without
> exposing internal implementation details that can change from kernel
> to kernel.
> 
> > Across multiple other subsystems, many of
> > which have added an extensive number of tracepoints, there has been
> > only a single problem in over a decade, so I'd like to suggest that
> > this concern may have not have been as serious as we had first
> > thought.
> 
> Yes, these subsystems still operate under the "tracepoints are not
> stable" understanding.  The reality is that userspace has *never*
> been able to rely on tracepoints being stable across multiple kernel
> releases, regardless of what anyone else (including Linus) says is
> the policy.

As a (relatively) long time bpftrace developer, I've always been
fairly consistent with users new to linux tracing that tracepoints
are _not_ guaranteed to be stable and they exist on the stability
spectrum somewhere between kprobes/fentry and uapi.

IIRC from the cases I've seen where tracepoints shift, users just adjust
their scripts. I don't remember having seen anyone both think that it's
the kernel's fault and then go complain on list.

I'm happy to adjust any of bpftrace's public facing docs to make that
reality more clear if it'll help.

> 
> > I'd like to propose that we experiment with adding tracepoints in
> > early 2025, so that at the end of the year the year-end 2025 LTS
> > kernels will have tracepoints that we are confident will be fit for
> > purpose for BPF users.
> 
> Why does BPF even need tracepoints? BPF code should be using kprobes
> to hook into the running kernel to monitor it, yes?

In addition to the points Andrii makes below, tracepoints also have a
nice documenting property. They tend to get added to "places of
interest". They're a great starting point for non kernel developers to
dig into kernel internals. Often times tracepoint naming (as well as the
exported fields) provide helpful hints.

At least for me, if I'm mucking around new places (mostly net/) I'll
tend to go look at the tracepoints to find the interesting codepaths.

[..]

Thanks,
Daniel

