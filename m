Return-Path: <linux-fsdevel+bounces-77250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLqQIdK9kWlKlwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 13:36:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D467C13EA84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 13:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69470300AC36
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFF2DE70D;
	Sun, 15 Feb 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="TJJMOChJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F51227E83;
	Sun, 15 Feb 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771158986; cv=none; b=dppTS1pOZMtFhwauu6++WgrYFrZ2ywuy99mpasrbF+5nUB6tWkjb4g+631WBowPtHkJ6/HkpyT8KyS2DImnB0tCC3SXl2P0A8xuPvZOdBPHeJ+0jRXJf34n9CxFA+/CLowdYYpUThLRS1/aim6yOnOx/Ife2r59mi1XBennH2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771158986; c=relaxed/simple;
	bh=8LDkYks1X9Y77i3jA5I2+ZBP83sIk4ga7yhDx6sOK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwE61wKT9V0bN4M0HMadgNyHoIlmY1uZM4vQzKZ69k0Oe67mZE7KTxkF4EwJ1IrZR5WWEJxJR/7QCzQQnP1UhUQ4C3Sv/zZfuPbGmoPXjz4Pms5EDMwXgKvFZF8oKezudWAGaLVA1ig2udbG9AI4c1ZmsH28ea3BqUEPcec+Eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=TJJMOChJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3D47514C2D6;
	Sun, 15 Feb 2026 13:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771158981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x52V94sUrb9KjxsFrGIkU/fw7O4bJiNXv94/Wc68kCY=;
	b=TJJMOChJ+ONZnU6GAcatdgKYYfAFlMFge2M4XrI6NWds6sIFisnfFMM7n/DjesOUD/VW06
	6MEwPLzZXfaZtG/WyJdNLgmBZpY0cGise7QiSfy6uL8jB41VxbWXTrgErI6IQMDIL96Hb/
	SPsqVb0MAW7EpHj8WORpnu5D2QqlJGXOoRMeU6R7vTimnTaR5rZ5I3XDzLRwXRouskzn2q
	+s2ht8GzJBerhPcxrNAwtUza87/12Wsg7nvXJy4ITanysMciTsSWVT7zYb74kO0Xi47VvY
	vZ/6GyVg2nX0hkx5or9UUOjts4d4JvdIAkD3dkORefHnaLsPhoWuPi1RyAcrfA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 30af9ace;
	Sun, 15 Feb 2026 12:36:17 +0000 (UTC)
Date: Sun, 15 Feb 2026 21:36:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Message-ID: <aZG9skZzT_LaHB6O@codewreck.org>
References: <cover.1769013622.git.repk@triplefau.lt>
 <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
 <2050624.usQuhbGJ8B@weasel>
 <aY5JWgyHq5P17_jx@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY5JWgyHq5P17_jx@pilgrim>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77250-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D467C13EA84
X-Rspamd-Action: no action

Still haven't taken time to review, just replying since I'm looking at
9p mails tonight... (The IO accounting part was sent to Linus earlier,
still intending to review and test soonish but feel free to send a v3
with Christian comments for now)

Remi Pommarel wrote on Thu, Feb 12, 2026 at 10:42:50PM +0100:
> > > +	if (S_ISLNK(rreq->inode->i_mode)) {
> > > +		err = p9_client_readlink(fid, &target);
> > 
> > Treadlink request requires 9p2000.L. So this would break with legacy protocol
> > versions 9p2000 and 9p2000.u I guess:
> > 
> > https://wiki.qemu.org/Documentation/9p#9p_Protocol
> 
> I'm having trouble seeing how v9fs_issue_read() could be called for
> S_ISLNK inodes under 9p2000 or 9p2000.u.
> 
> As I understand it, v9fs_issue_read() is only invoked through the page
> cache operations via the inode’s a_ops. This seems to me that only
> regular files and (now that I added a page_get_link() in
> v9fs_symlink_inode_operations_dotl) symlinks using 9p2000.L can call
> v9fs_issue_read(). But not symlinks using 9p2000 or 9p2000.u as I
> haven't modified v9fs_symlink_inode_operations. But I may have missed
> something here ?

I think that's correct, but since it's not obvious perhaps a comment
just above the p9_client_readlink() call might be useful?

Also nitpick: please add brackets to the else as well because the if
part had some (checkpatch doesn't complain either way, but I don't like
  if (foo) {
    ...
  } else
    bar
formatting)



> > > diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> > > index a82a71be309b..e1b762f3e081 100644
> > > --- a/fs/9p/vfs_inode.c
> > > +++ b/fs/9p/vfs_inode.c
> > > @@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
> > >  			goto error;
> > >  		}
> > > 
> > > -		if (v9fs_proto_dotl(v9ses))
> > > +		if (v9fs_proto_dotl(v9ses)) {
> > >  			inode->i_op = &v9fs_symlink_inode_operations_dotl;
> > > -		else
> > > +			inode_nohighmem(inode);
> > 
> > What is that for?
> 
> According to filesystems/porting.rst and commit 21fc61c73c39 ("don't put
> symlink bodies in pagecache into highmem") all symlinks that need to use
> page_follow_link_light() (which is now more or less page_get_link())
> should not add highmem pages in pagecache or deadlocks could happen. The
> inode_nohighmem() prevents that.
> 
> Also from __page_get_link()
>   BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
> 
> A BUG_ON() is supposed to punish us if inode_nohighmem() is not used
> here.
> 
> Of course this does not have any effect on 64bits platforms.

That's how it should be but it marks memory as GFP_USER, I'm curious if
it really has no other effect... Anyway, from what I've read I think it
is likely to go away (highmem on 32bit platforms) soon enough, so this
probably won't matter in the long run.
(if we really care we could flag this only for S_ISLNK(mode), but I
don't think it's worth the check)


-- 
Dominique Martinet | Asmadeus

