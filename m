Return-Path: <linux-fsdevel+bounces-52258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC61AE0E46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA691889BF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D52246790;
	Thu, 19 Jun 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hDutRdyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AE30E82B;
	Thu, 19 Jun 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362829; cv=none; b=ZtcFAJExA9BaGvc2n7L2AByTuK9+ljj10azkqx/THaHblgKEoKPxraOLatxoi6d6nsDjbrDlUeR1MQdnLpDMZswWIOCrJpE7m8lRD4EtPlpgHyL2DeCVe4PNOh8h9kDTBV4nazx5sSRcBpHNr3+r3TFF041J73giYjHCkTZwJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362829; c=relaxed/simple;
	bh=cCeZBTro06Qu9RBc1x6/2a8x3OIoPNh2IfACs6YARSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYZhh8SjNnQUT2QBeAwgWdtwd/v5NC6nHJbkWnlINQqU5d/it0LVFsL7pXfXJ6n9pIly+p+gqZLyAUvDW7ESaQnmssJR7/ftDFpIav4W0ze1npMO2Le5txH1VDBPTOQPGAdTG5eET46J5z+EzLsuGTSY8JWcBlArmiz7sPnSPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hDutRdyj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VwN5PhX0kYXO6J7NGMH16kNv/FTW/SmqfCBwvRcPD9g=; b=hDutRdyjxqT4M6UiaCIeRr4AjW
	41KcsdZjZA2SelDGWoGgguc/fMJn4Ap2PafVGtT7UrKiJHZB88bdMmdo7c59h0mLD7K13RlevHSi3
	7LN8RbxbImn153EC2u53QP81UfqzmaXmKVyWgt/LiT/p9WimJ76lD+o7hZej4+nf9/0wdlaDyw+H3
	Tgc3Oum89TP/NviR7gsnIQ2ofbhSxvfNI1+MCQJ9aXIDRBGl5Ra3CS7GqmjmWroBYiWWT3KxIGrfC
	ZrnqEXpKbyAhXg7NJBEM453nn0s60QMEzkxfWBtTDVBjwAr1Av1YVvEf2Avc06RzbDw/9w6CMUQ0R
	nSfwnMag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSLKR-00000007XVB-1PjJ;
	Thu, 19 Jun 2025 19:53:43 +0000
Date: Thu, 19 Jun 2025 20:53:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Message-ID: <20250619195343.GU1880847@ZenIV>
References: <20250614062051.GC1880847@ZenIV>
 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
 <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
 <20250617220122.GM1880847@ZenIV>
 <cd929637ed2826f25d15bad39a884fac3fd30d0c.camel@ibm.com>
 <20250617221502.GN1880847@ZenIV>
 <0c2591751d796547c45ade7dc11d49018ef5aaa6.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2591751d796547c45ade7dc11d49018ef5aaa6.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 19, 2025 at 06:04:37PM +0000, Viacheslav Dubeyko wrote:

> > I can send a pull request to you now just as easily as I could send it to Linus
> > a month and a half down the road... ;-)  Up to you, guys.
> 
> So, if we don't have any other opinion, then let's send the patch set through
> your tree.

merged into #for-next, will go to Linus at the next window...

