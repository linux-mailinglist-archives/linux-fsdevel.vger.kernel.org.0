Return-Path: <linux-fsdevel+bounces-11094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C47850EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9427281B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6AEDDB1;
	Mon, 12 Feb 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhZhaW75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A13EACD;
	Mon, 12 Feb 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725692; cv=none; b=ZUqPZMoHMEd0cZlWl17Oer+L074aNEzCYzvP/rlF9pzz0bDf3MYVoS/NK0ReWGI7dHTtNMW1brgKPOqEeLkj8ZSkHUrXGrYdJOcqcfiHv4vGlozhqnFKXwNlIyBNvQnect0MSQnywHknLJUsR1+PJS2FNWY8GVnqZ/995oQMw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725692; c=relaxed/simple;
	bh=EHz/qRbi+kNGEpQkrHEQzQ1VvbYH6TC+Z6WDIoz/vP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx49/+diRy9DXKGf2OO771txTIK4KXA49Ip6QJId2XWcdiHRBjMkCtVcRo2MleqfcUJX+eml5LReaLTwdcCInL1C34Z8oQoDooWf58z847sqh8N25hgAeBy90jf/b8QttIJ2YEnCeNYagbciDYqWZRWhkXbueJ65w/3q+Eu0V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhZhaW75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38230C433F1;
	Mon, 12 Feb 2024 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707725691;
	bh=EHz/qRbi+kNGEpQkrHEQzQ1VvbYH6TC+Z6WDIoz/vP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhZhaW75hjXPHGaIlZsFHN2as4l+vImi8kozi5BFP8kU2mA7IOtxZjB6ABEhcu8tk
	 WBGtM3CfpDOtYsWzOlLcUu7JxwRJ0R35lfjUI12+zCmnuIiR2Ea5g9vGQRzfEUrM7q
	 L+ESS3sjrhlTG9dd8GJYIgQkXnOY0z76lFwBGpnZDv9b6TElIWjgO5u1rJ8In0qeKY
	 Nj3aGZw/8lhW8JKsvIdXB/OWBGx8ft7hmXZ3mHNcz5VsqOajoV85WFkQX7saWkxgGM
	 8z8SvbFOTw3FVwY56fA8lpiRhWf52c/mpRzX392m9uNRFKMqBdEXTw3LezCT7J6nLf
	 jHBT1slZhMBhA==
Date: Mon, 12 Feb 2024 10:14:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <ZcnTZiyHRf4Dj3P2@kernel.org>
References: <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver>
 <Zbi5bZWI3JkktAMh@kernel.org>
 <20240130172831.hv5z7a7bhh4enoye@revolver>
 <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
 <Zb9mgL8XHBZpEVe7@kernel.org>
 <CA+EESO7RNn0aQhLxY+NDddNNNT6586qX08=rphU1-XmyoP5mZQ@mail.gmail.com>
 <ZcOhW8NR9XWhVnKS@kernel.org>
 <CA+EESO6V9HiPtFpG7-cjvadj_BcKzGvi4GSdJBXD_zTM+EQu5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO6V9HiPtFpG7-cjvadj_BcKzGvi4GSdJBXD_zTM+EQu5A@mail.gmail.com>

On Wed, Feb 07, 2024 at 12:24:52PM -0800, Lokesh Gidra wrote:
> On Wed, Feb 7, 2024 at 7:27 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > > The write-lock is not a requirement here for correctness and I don't see
> > > > why we would need userfaultfd_remove_prep().
> > > >
> > > > As I've said earlier, having a write-lock here will let CRIU to run
> > > > background copy in parallel with processing of uffd events, but I don't
> > > > feel strongly about doing it.
> > > >
> > > Got it. Anyways, such a change needn't be part of this patch, so I'm
> > > going to keep it unchanged.
> >
> > You mean with a read lock?
> 
> No, I think write lock is good as it enables parallel background copy.
> Also because it brings consistency in blocking userfaultfd operations.
> 
> I meant encapsulating remove operations within
> userfaultfd_remove_prep() and userfaultfd_remove_complete(). I
> couldn't figure out any need for that.

I don't think there is a need for that. With fork/mremap prep is required
to ensure there's uffd context for new vmas.
 
-- 
Sincerely yours,
Mike.

