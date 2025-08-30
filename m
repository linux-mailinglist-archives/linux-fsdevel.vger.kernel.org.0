Return-Path: <linux-fsdevel+bounces-59704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D265B3C8C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 09:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D74A5E0749
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98422D793;
	Sat, 30 Aug 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pukcia20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C472AD0D
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539210; cv=none; b=otBuShrC2owVBoaf2gFNkfeBs2TtakrirUEZt9tID81ukzh3KXW+PMWLpJGRUO5e83ioxU9XwwuysARwcRRckwijr9hiBMDMvkpiLNgpgKfimLD7LyHAs53rJGg7oQ8HsI0Q1pYmkJNBB1yQTklIz2rBOwXvzHVfazYD90/mVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539210; c=relaxed/simple;
	bh=3U7GJod3gN5lvU3DYFAv476WbJ+0ToZ4n7V6YGuu5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK8yYoojHwIH8V14A8tlqUYg8zhB1N4OvZALhk9AGZrAQ2rbkc6ZwiNwuzMTOSUHDpen1MKbMbyncMCxY1SWzAOW8NcdszADnJGkksbIQr1m5YiTvIZgJSDlAOsUDvUU/rpILI79AzFV2qsTbOioxdnacP1p7n+tAIo0bLmti38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pukcia20; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMBTSQa13YM7NT7eUiYiyY2jXA+gM+JYSlasvo/LYvs=; b=pukcia20oN4z0vw9ymio/s3Sfq
	L4xHKbv/poRzIw7UDiKAlCsFrM3miFlADkvlChDoH4NuGc8NaQ6d97h6d6ZEHENN1lVRIXZIcRmow
	J6qPpivNRrQOwVkUXiLZadD6xNcIFTX/KpECXxwupP/WP7Eodv6QTF60oFK3HBr6FSErjsq7qWJZv
	t67emleOzfx5nphjwx41+ZfxsEaYzivm2MnqS54K6u6v18DWGb3ohfK6fbcTEPNZvJe8eqVCAFT3H
	tmkHEMoOnhgUIJb2jk/gI2kDurl7jUZTzjsYf4xB/3amugLI2CNf0flkaNQrZuJfk32/9Ml514c7q
	lpTzSCBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usG5V-00000006GsH-0G6T;
	Sat, 30 Aug 2025 07:33:25 +0000
Date: Sat, 30 Aug 2025 08:33:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Siddhesh Poyarekar <siddhesh@gotplt.org>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC] does # really need to be escaped in devnames?
Message-ID: <20250830073325.GF39973@ZenIV>
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
 <20250829163717.GD39973@ZenIV>
 <20250830043624.GE39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830043624.GE39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

	On one hand, we have commit ed5fce76b5ea "vfs: escape hash as
well" which added # to the escape set for devname in /prov/*/mount*;
on another there's nfs_show_devname() doing
                seq_escape(m, devname, " \t\n\\");
and similar for btrfs.  And then there is afs_show_devname() that outright
includes # in that thing on regular basis:
	char pref = '%';
	...
        switch (volume->type) {
	case AFSVL_RWVOL:
		break;
	case AFSVL_ROVOL:
		pref = '#';
		if (volume->type_force)
			suf = ".readonly";
		break;
	case AFSVL_BACKVOL:
		pref = '#';
		suf = ".backup";
		break;
	}

	seq_printf(m, "%c%s:%s%s", pref, cell->name, volume->name, suf);

For NFS and btrfs ones I might be convinced to add # to escape set; for
AFS, though, I strongly suspect that userland would be very unhappy,
and that's userland predating whatever code that "aims to parse fstab as
well as /proc/mounts with the same logic" ed5fce76b5ea is refering to.

So...  Siddhesh, could you clarify the claim about breaking getmntent(3)?
Does it or does it not happen on every system that has readonly AFS
volumes mounted?

