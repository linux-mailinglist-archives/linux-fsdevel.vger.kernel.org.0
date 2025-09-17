Return-Path: <linux-fsdevel+bounces-62013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C058B81C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1434480E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163E2C1583;
	Wed, 17 Sep 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wFEBCd+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457D258ECA;
	Wed, 17 Sep 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140957; cv=none; b=A5BeQxbRMajtIzMaTeWFk9K/akkRl5EXj7BR+jvV1ec1UOY1QpJ075iWiyTNRj2cM435mdDNisXVNvOO/8ttZI44P8gy0J6PuiJ7CxOAQzLyD9tN7nb7xVmiVG9kUgTmVWkYmmwajZfwKiB3buu/njE9oiRtmTfW43gXVdyW+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140957; c=relaxed/simple;
	bh=Wwm75Y+VjbsmOrjDmc9L1GO1Rf1S/aoh9sefJX7djiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DShuLc2jRvws1PD2a4pUAzCuytNdiyyCz6+brBer2KEXX5flHL5S3xZ0hYuehXUsdPdCLq71wZehNoOsVKzZ8hGIoo44Od4PEaBRTN1GE/8IgDz0jO2mv7w9MMQhuXLGJ+icL+UQpoHg3XEvm9iVpX+qhhCED5+dhJnTyxMovjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wFEBCd+F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=w1fulQ0gQjzyFPF7toelr6M7l0Oc8OAf+GJq3MYg+zc=; b=wFEBCd+FzEQc7BlKjb+v53jCY6
	JCiORP3QCMwGeNazAdH3o3scAQiI4/Z/E0SYboN2gfHysz+J44RBzGMy+qDQpmvcV8Ht+HL/bq3Rj
	R+D+36kVQPIjBho1YiVAg5qleJ6TyNmitB62iEOnQwU9WoLAnunQdSYXpVfvfFC8q9pAUFEOd0R6a
	+F/VSP16v1Tavpahim8UWx++scDN+ntaVdlBywL6U9lWWKY4g4vdj8gGGDSHe80YPcebaM/RFUTzi
	IIkw/O8wQr8ki3yF8y93qUfRAHW/nrRLfSN1CTRYoxiDvjwqP1GZzCcIW9CDoJ9G3itL2R/1htLop
	RN8WvW5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyymA-00000007q9U-0IXT;
	Wed, 17 Sep 2025 20:29:14 +0000
Date: Wed, 17 Sep 2025 21:29:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917202914.GZ39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV>
 <CAKPOu+_WNgA=8jUa5BiB0_3c+4EoKJdoh9S-tCEuz=3o0WpsiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_WNgA=8jUa5BiB0_3c+4EoKJdoh9S-tCEuz=3o0WpsiA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:19:27PM +0200, Max Kellermann wrote:
> On Wed, Sep 17, 2025 at 10:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Looks rather dangerous - what do you do on fs shutdown?
> 
> Sorry, I'm new to this, I don't know how fs shutdown works - stupid
> question: is my code any more dangerous than what's already happening
> with ceph_queue_inode_work()?

umount /wherever/the/fuck/it/is/mounted

calls umount(2), which removes the mount from the tree, then calls
deactivate_super(), dropping the active reference to superblock.
If it hadn't been mounted elsewhere, that's the last reference and
we this:
		shrinker_free(s->s_shrink);
		fs->kill_sb(s);

		kill_super_notify(s);

		/*
		 * Since list_lru_destroy() may sleep, we cannot call it from
		 * put_super(), where we hold the sb_lock. Therefore we destroy
		 * the lru lists right now.
		 */
		list_lru_destroy(&s->s_dentry_lru);
		list_lru_destroy(&s->s_inode_lru);

		put_filesystem(fs);
		put_super(s);
At some point ->kill_sb() will call generic_shutdown_super() (in case of ceph
that's done via kill_anon_super()), where we get to evict_inodes().  Any
busy inode at that point is a bad problem...

