Return-Path: <linux-fsdevel+bounces-44793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADDBA6CBE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 19:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BE1886EA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78598234977;
	Sat, 22 Mar 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uHZBgJ6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADC23498F;
	Sat, 22 Mar 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669412; cv=none; b=myNriMCUGbIDIxiBs4w6Xxz/847azm9NkncuITwt7AfBrYgPcqhXCXCqu5oG+6oeOQPd2zEbiFiTh1aUtwfGK+kihyJWk/h2z6FDmMvD29cxLTm69wCU6uZ2grKSRrMbS4gfaJFnoGHYbacX6qKayV4+C7QqiWhn5CSwSn5P8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669412; c=relaxed/simple;
	bh=QvKF7JS+DTfpNCKESGov63tEpoLKn+Vq2LbUOl3fD30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifoRAHeDKMN/gXy5Z7EQaqSM8AlH8d7QjPDzYcc/qe1urUJiCyRIEzs8RlsxBQRI44vuc0IbzLZ55jppLBUKvk82gg/kBB72TmCl7ku7TIqrfKyZO40zL7uhoDxQrlSn/yYVgUc9wz2t/pXHRy8XxkN+799hxEHfRb5xStD9CLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uHZBgJ6g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=evrD2WzzdcfxRSNM86L9mGBkJPWGxOadsbgzB06kx4g=; b=uHZBgJ6gQktbtDyiVwgnJh34ak
	tc/iPGmhmaAsm1pkN0p2oWeSUXoudOw0H83eENhUMP2lZQ211V04PQySXOKS7BvMMujN5GW7AR3rg
	UBcET1vSQInsfH03x/m0GQBd/bG/JFo6IbGduNgDon3e4D5oVwI5qzKXh02yMMdAviBSDeczLKroJ
	pfjfbuwcsPL8bV6UrDUOl49Tx87g3+ejCxFf/YLB6qYRPeq5vakgw/cppZyXvMtyokIpH3khS89k+
	1O9QoMfi3CwJ/IvPDaAjiKzAtQLNpWzCAPdHg9ZaKADHTALiHy0ujeBOTXm/kEQ53DNeRiGNtcnn/
	HTpNH4hA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tw3v5-0000000EGEA-26gQ;
	Sat, 22 Mar 2025 18:50:07 +0000
Date: Sat, 22 Mar 2025 18:50:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250322185007.GI2023217@ZenIV>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
 <20250322155538.GA16736@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322155538.GA16736@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Mar 22, 2025 at 04:55:39PM +0100, Oleg Nesterov wrote:

> No, check_unsafe_execve() is called with cred_guard_mutex held,
> see prepare_bprm_creds()

Point...

> > 3) A calls exec_binprm(), fails (bad binary)
> > 4) A clears ->in_exec
> 
> So (2) can only happen after A fails and drops cred_guard_mutex.
> 
> And this means that we just need to ensure that ->in_exec is cleared
> before this mutex is dropped, no? Something like below?

Probably should work, but I wonder if it would be cleaner to have
->in_exec replaced with pointer to task_struct responsible.  Not
"somebody with that fs_struct for ->fs is trying to do execve(),
has verified that nothing outside of their threads is using this
and had been holding ->signal->cred_guard_mutex ever since then",
but "this is the thread that..."

