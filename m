Return-Path: <linux-fsdevel+bounces-41046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D848A2A4E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC5161BBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04988226521;
	Thu,  6 Feb 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su2sY/QD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B19376;
	Thu,  6 Feb 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835068; cv=none; b=l6jmn2vyWGDgDPkKts55Q4tE531SX4022TUnW4RlFSdj867sTrw9sA4irlgPlLMSZvk60N2TvM6o+PtdI+dhZSBgz1g724GaCpbFU5LHjdZkdRxH3VdkVulb/+QE2PVpTO+Ml1dKzUX2OBJLRhrjH60c3YupICOss0hfEZYbSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835068; c=relaxed/simple;
	bh=Z9knfeqQnDaRB2achqfYxquvB3Tq9ppmemZe6j00bSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecWVn8zNAmSR06mWroKUIFVmOvZnGaxlNN3dIqfPmmW8uyoe3D/CKV/Lr2laQgTYO9o5JJyuLk3w2kd/edsbKjHNRfUqID3LAVtX39isoo6pq4+0ooKQioowIBEADKgxDeOLDHq74Kri+sLtXUXCTZavShQlcQOgMvMWHU+dwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su2sY/QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CDEC4CEDD;
	Thu,  6 Feb 2025 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835067;
	bh=Z9knfeqQnDaRB2achqfYxquvB3Tq9ppmemZe6j00bSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=su2sY/QDvpDyc573oBkarOc3gnTTm8RRFz4YgSnkqIikdc9Kj2vdeqOzdWHaVL3GA
	 dy2+kINT9Di/+SojWJNzWbICMy5g7CeHDbuAvGRHLEyYGrGXTuz4zzcJ5LULHMYd6I
	 60bCjXveIVHorK1MUg76otw2MSxvG3UulYAXDx4xcamT95Ay2/CxISedmjVIbHGObz
	 xeqE7fO//uKVgCSj/5z5RwBU8Ia39njTtx8RSrgvu2ZPYQZHL9Mzo9hRZBn5wKeV/A
	 eCPmDHVLV6oTnFedBe8yZdiTwaHhmbiSUsjR90vmbHA6eCNmbJ3vPPIw0P+lNwPOGm
	 KEUUdbfi3MysA==
Date: Thu, 6 Feb 2025 10:44:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	tytso@mit.edu, kees@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to
 inode_set_cached_link()
Message-ID: <20250206-sojabohnen-geometrie-bb7aceedd1bc@brauner>
References: <20250205162819.380864-1-mjguzik@gmail.com>
 <20250205172946.GD21791@frogsfrogsfrogs>
 <CAGudoHENg_G7KaJT15bE0wVOT_yXw0yiPPqTf40zm9YzuaUPkw@mail.gmail.com>
 <vci2ejpu7eirvku6eg5ajrbsdlpztu2wgvm2n75lkiaenuxw7p@7ag5gflkjhus>
 <CAGudoHGjrS30FZAM=Qwqi1vxpdkPQyXGsW7-xONeSE9aw8H3gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGjrS30FZAM=Qwqi1vxpdkPQyXGsW7-xONeSE9aw8H3gg@mail.gmail.com>

On Wed, Feb 05, 2025 at 08:05:20PM +0100, Mateusz Guzik wrote:
> On Wed, Feb 5, 2025 at 7:10 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 05-02-25 18:33:23, Mateusz Guzik wrote:
> > > If the ext4 folk do the right fix, I will be delighted to have this
> > > patch dropped. :)
> >
> > Yeah, let me cook up proper ext4 fix for this (currently under testing).
> >
> 
> I see it got posted and tested:
> https://lore.kernel.org/linux-hardening/67a3b38f.050a0220.19061f.05ea.GAE@google.com/T/#mb782935cc6926dd5642984189d922135f023ec43
> 
> So I consider my patch self-NAKed.

Dropped.

